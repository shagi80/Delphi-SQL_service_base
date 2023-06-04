unit DataMod;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, Buttons, StdCtrls, ComCtrls, Mask, DBCtrls,
  CustomizeDlg, Menus, ActnList, Grids, ToolWin, ImportWin, DBGrids, Gauges,
  ImgList, IniFiles, DateUtils, frxClass, frxExportPDF, frxExportXLS,
  frxExportODF, frxDBSet;

const
  ScreenHeight=864;
  ScreenWidth=1536;
  //���������� ���������
  WM_UPDATESEMTERLIST=WM_USER+1;
  WM_UPDATEREPORTLIST=WM_USER+5;
  WM_CLOSECHILD=WM_USER+2;
  WM_CREATECHILD=WM_USER+3;
  WM_ACTIVATECHILD=WM_USER+4;
  //������� ������ ������
  rcsNotVerified=0;
  rcsSpellingErrors=1;
  rcsDataErrors=2;
  rcsAutoVerified=3;
  rcsManualVerified=4;
  rcsAccept=5;
  //��������� �������� �����
  CustomGarantTime=1;  //����������� ���� � �����
  WorkTime=40;   //���� ������� � ����
  //�������������� �������
  rtTypeFault=1;
  rtFaultForPeriod=2;
  rtSNHistory=3;
  rtForPay=4;
  rtAutorWork=5;


type
  //��� ������ ��� ������� ������ � ������
  TErrorRec = record
    errtype : word;
    Field   : widestring;
    ID      : integer;
    code    : string[250];
  end;
  TRecordsError = array of TErrorRec;

  TStringArray = array of string;

  TDMod = class(TDataModule)
    Connection: TADOConnection;
    ImageList: TImageList;
    FieldsTable: TADOTable;
    ModelsTable: TADOQuery;
    frxPDFExport: TfrxPDFExport;
    frxODTExport: TfrxODTExport;
    frxODSExport: TfrxODSExport;
    frxXLSExport: TfrxXLSExport;
    MainTypesTable: TADOTable;
    EmployeeTable: TADOTable;
    SaveDlg: TSaveDialog;
    RegionTable: TADOTable;
    function ConnectToBase(h : THandle):boolean;
    procedure SendMsgToSystem(msg:cardinal;prm:integer);
    function  SenterEditing(senterid:integer):integer;
    function  ReportEditing(senterid: Integer):integer;
    function  NewWimID : integer;
    function  PointToErrorArray(ErArr : TRecordsError; Fld : widestring; ID : integer):integer;
    function  GetWorkType(str:string):integer;
    procedure AddToErrorArray(var ErrorArray:TRecordsError; Fld : widestring; ID : integer; ErrType : word; code : string);
    function  GetWMModelNote(str:string):string;
    function  DecodeWMSN(str:string;const DS : TDataSet = nil):string;
    function  DecodeDRYERSN(str:string;const DS : TDataSet = nil):string;
    function  DecodeDRYERSN1(str:string;const DS : TDataSet = nil):string;
    function  RecordsVerify(var Errors : TRecordsError; DS : TDataSet; prname:string):boolean;
    function  RecordToErrorArray(ErArr : TRecordsError; ID : integer):integer;
    function  GetSubStr(str : string; dv : string; var substr:TStringArray ):boolean;
    function  GetFloatFormat(flt:real; znac,maxlen : integer): string;
    function  GetMainType(sn:string):integer;
    function  SpellingVerify(var Errors : TRecordsError; DS : TDataSet;maintype:integer):boolean;
    function  DataVerify(var Errors : TRecordsError; DS : TDataSet;maintype:integer):boolean;
    function  UpAndTranslate(str:string;oneword:boolean;const translate : boolean=true):string;
    procedure WriteEvent(AutorID,Status,DocID : integer;TableName : string);
    function  GetDRYERModelNote(str:string):string;
    function  DecodeDRYERSN2(str:string;const DS : TDataSet = nil):string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  DMod      : TDMod;
  MyPath    : string;
  //���� ������
  clERROR   : TColor;
  clWARNING : TColor;
  clNOTERROR: TColor;
  SumOnlyAccept : boolean=true;
  WorkTypes : array [1..3] of string = ('�������������','�����������','�� �����������');
  EditorID      : integer = 1;
  EditorStatus  : integer = 1;


implementation

{$R *.dfm}

uses SenterDataWin,ReportDataWin,Clipbrd, GIFUnit;

// ��������� �������� �������� ���� ����� ������������� ������
procedure TDMod.SendMsgToSystem(msg:cardinal;prm:integer);
var
  h,h1:THandle;
  Buffer:PChar;
  ClassName: array[0..255] of Char;

// ����������� ��������� ���������� ������
procedure RegisterWindow(hWnd:THandle);
var
  h:THandle; // ����� ����, ������������� ����������
begin
  // ��������� ������ ����
  GetClassName(hWnd,Buffer,255);
  if (Trim(StrPas(Buffer)))=ClassName then PostMessage(hWnd,msg,prm,0);
  // ����������� ������
  // ��������� ����������� ���������
  h:=GetWindow(hWnd,gw_Child);
  if h<>0 then RegisterWindow(h);
  // ��������� �������� ���� �� ������
  h:=GetWindow(hWnd,gw_hWndNext);
  if h<>0 then RegisterWindow(h);
end;

begin
  GetClassName(application.MainForm.Handle, ClassName, SizeOf(ClassName));
  Application.ProcessMessages;
  // �������� ������ ��� ������ � PChar
  Buffer:=StrAlloc(256);
  // �������� ����� �������� ���� ����������
  h1:=application.MainForm.Handle;
  repeat
    // �������� ����� ����-���������
    h:=GetWindow(h1,GW_OWNER);
    // ���� �� ���� �������� ������, �� ���� ������
    if h<>0 then begin
      h1:=h;
    end;
  until h=0;
  // ������� ������ ������� ����
  h:=GetWindow(h1,GW_HWNDFIRST);
  // ������ ��������
  RegisterWindow(h);
  // �������� ������ ��� ������ � PChar
  StrDispose(Buffer);
end;

function TDMod.ConnectToBase(h : THandle):boolean;
var
  IniFile  : TIniFile;
  str      : string;
begin
  str:= MyPath+'myini.ini';
  if FileExists(str) then begin
    IniFile :=TIniFile.Create(str);
    IniFile.WriteInteger('MAIN','HANDLE',h);
    //���������� � �����
    str := IniFile.ReadString('MAIN','CONSTR','');
    if Length(str)=0 then begin
      MessageDLG('������ ���������� �� ������ !'+chr(13)+'���������� ����� �������.',mtError,[mbOK],0);
      Halt(0);
    end;
    try
      Connection.Close;
      Connection.ConnectionString:=str;
      Connection.Connected:=true;
    except
      IniFile.Free;
      MessageDLG('������ ���������� � �� !'+chr(13)+'���������� ����� �������.',mtError,[mbOK],0);
      Halt(0);
    end;
    IniFile.Free;
  end else begin
    MessageDLG('INI-���� �� ������ !'+chr(13)+'���������� ����� �������.',mtError,[mbOK],0);
    Halt(0);
  end;
  FieldsTable.Active:=true;
  ModelsTable.Active:=true;
  MainTypesTable.Active:=true;
  EmployeeTable.Active:=true;
  RegionTable.Active:=true;
  result:=true;
end;

function TDMod.NewWimID : integer;
var
  i,id : integer;
  find : boolean;
begin
  id:=1;
  if application.MainForm.MDIChildCount>0 then begin
    find:=true;
    while find do begin
      find:=false;
      i:=0;
      repeat
        if(application.MainForm.MDIChildren[i].Tag=id)then find:=true else inc(i);
      until (i=application.MainForm.MDIChildCount)or(find);
      if find then inc(id);
    end;
  end;
  result:=id;
end;

function TDMod.GetSubStr(str: string; dv: string; var substr:TStringArray ):boolean;
var
  ps     : integer;
begin
  SetLength(substr,0);
  if (length(str)>0)and(Length(dv)>0)and(pos(dv,str)>0) then begin
    ps:=pos(dv,str);
    repeat
      SetLength(substr,high(substr)+2);
      if ps>0 then begin
        substr[high(substr)]:=copy(str,1,ps-1);
        delete(str,1,ps+Length(dv)-1);
      end else begin
        substr[high(substr)]:=copy(str,1,MaxInt);
        str:='stop';
      end;
      ps:=pos(dv,str);
    until str='stop';;
    result:=(high(substr)>-1);
  end else result:=false;
end;

function TDMod.GetFloatFormat(flt:real; znac,maxlen : integer): string;
var
  d:double;
  i,k:integer;
begin
  result:='######0.0';
  if flt<>0 then begin
    d:=frac(flt);
    k:=0;
    while trunc(d*10)=0 do begin
      k:=k+1;
      d:=d*10;
    end;
    if (k+znac-1)>maxlen then k:=maxlen-znac-1 else k:=k+znac-1;
    for I := 1 to k do result:=result+'#';
  end;
end;

//----------- �������� ����� �������������� ������ � ���� ������----------------

function TDMod.SenterEditing(senterid: Integer):integer;
var
  i,id  : integer;
begin
    //��������� �� ������ ��� ������� ����, ������������� ��� ID
    i:=0; id:=0;
    if (i<application.MainForm.MDIChildCount) then repeat
      if(application.MainForm.MDIChildren[i] is TSenterData)then id:=(application.MainForm.MDIChildren[i] as TSenterData).ItemID
        else id:=0;
      inc(i);
    until (i=application.MainForm.MDIChildCount)or(id=senterid);
    if (id=senterid) then result:=i-1 else result:=0;
end;

function TDMod.ReportEditing(senterid: Integer):integer;
var
  i,id  : integer;
begin
    //��������� �� ������ ��� ������� ����, ������������� ��� ID
    i:=0; id:=0;
    if (i<application.MainForm.MDIChildCount) then repeat
      if(application.MainForm.MDIChildren[i] is TReportData)then id:=(application.MainForm.MDIChildren[i] as TReportData).ItemID
        else id:=0;
      inc(i);
    until (i=application.MainForm.MDIChildCount)or(id=senterid);
    if (id=senterid) then result:=i-1 else result:=0;
end;

//-------- ������ � �������� ������ ��� �������� ������-------------------------

function TDMod.PointToErrorArray(ErArr : TRecordsError; Fld : widestring; ID : integer):integer;
var
  i : integer;
begin
  if high(ErArr)>-1 then begin
    i:=0;
    while(i<=high(ErArr))and(not((ErArr[i].Field=Fld)and(ErArr[i].ID=ID)))do inc(i);
    if (i>high(ErArr)) then result:=-1 else result:=i;
  end else result:=-1;
end;

function TDMod.RecordToErrorArray(ErArr : TRecordsError; ID : integer):integer;
var
  i : integer;
begin
  if high(ErArr)>-1 then begin
    i:=0;
    while(i<=high(ErArr))and(not(ErArr[i].ID=ID))do inc(i);
    if (i>high(ErArr)) then result:=-1 else result:=i;
  end else result:=-1;
end;

procedure TDMod.AddToErrorArray(var ErrorArray:TRecordsError; Fld : widestring; ID : integer; ErrType : word; code : string);
begin
  SetLength(ErrorArray,high(ErrorArray)+2);
  ErrorArray[high(ErrorArray)].Field:=Fld;
  ErrorArray[high(ErrorArray)].ID:=ID;
  ErrorArray[high(ErrorArray)].errtype:=ErrType;
  ErrorArray[high(ErrorArray)].code:=Code;
end;

//------------------------ �������� ����� --------------------------------------

function TDMod.GetMainType(sn:string):integer;
var
  str : string;
  val : variant;
begin
  result:=0;
  //��������� ��� ��� ���������� ������
  str:=copy(sn,2,3);
  val:=ModelsTable.Lookup('IDFORSN',str,'MAINTYPE');
  if (Length(sn)=14)and((sn[1]='K')or(sn[1]='N'))and(val<>NULL) then result:=val;
  //��������� ��� ��� ��������
  if result=0 then begin
    str:=copy(sn,2,4);
    val:=ModelsTable.Lookup('IDFORSN',str,'MAINTYPE');
    if (Length(sn)=15)and((sn[1]='K')or(sn[1]='N'))and(val<>NULL) then result:=val;
    //��� ���, � ���� ��� ���������� �� KK
    if result=0 then begin
      str:=copy(sn,1,2);
      val:=ModelsTable.Lookup('IDFORSN',str,'MAINTYPE');
      if (Length(sn)=12)and(val<>NULL) then result:=val;
    end;
    //��� ������� 2020 � � ����� ���� R31550
    if result=0 then begin
      str:=copy(sn,2,6);
      val:=ModelsTable.Lookup('IDFORSN',str,'MAINTYPE');
      if (Length(sn)=17)and(val<>NULL) then result:=val;
    end;
  end;
  //��������� ��� ��� ����
  if result=0 then begin
    str:=copy(sn,1,2);
    val:=ModelsTable.Lookup('IDFORSN',str,'MAINTYPE');
    if (Length(sn)>15)and(val<>NULL) then result:=val;
  end;
end;

function TDMod.GetWorkType(str:string):integer;
begin
    if Length(str)>0 then begin
      if pos('����',AnsiUpperCase(str))>0 then result:=1
        else if ((pos('��',AnsiUpperCase(str))>0)and(pos('������',AnsiUpperCase(str))>0))
          or((pos('����',AnsiUpperCase(str))>0)and(pos('������',AnsiUpperCase(str))>0)) then result:=3
            else if (pos('������',AnsiUpperCase(str))>0)or(pos('������',AnsiUpperCase(str))>0) then result:=2
              else result:=0;
    end else result:=0;
end;

function TDMod.UpAndTranslate(str:string;oneword:boolean;const translate : boolean=true ):string;
var
  i : integer;
begin
  str:=AnsiUpperCase(str);
  i:=1;
  while(i<=Length(str))and((str[i]=chr(32))or(str[i]=chr(160)))do begin
    delete(str,i,1);
    inc(i);
  end;
  i:=Length(str);
  while(i>=1)and((str[i]=chr(32))or(str[i]=chr(160)))do begin
    delete(str,i,1);
    dec(i);
  end;
  if oneword then begin
    str:=StringReplace(str,chr(32), '',[rfReplaceAll, rfIgnoreCase]);
    str:=StringReplace(str,chr(160), '',[rfReplaceAll, rfIgnoreCase]);
    str:=StringReplace(str,'-', '',[rfReplaceAll, rfIgnoreCase]);
  end;
  if translate then begin
    str:=StringReplace(str,'�', 'A',[rfReplaceAll, rfIgnoreCase]);
    str:=StringReplace(str,'�', 'B',[rfReplaceAll, rfIgnoreCase]);
    str:=StringReplace(str,'�', 'C',[rfReplaceAll, rfIgnoreCase]);
    str:=StringReplace(str,'�', 'D',[rfReplaceAll, rfIgnoreCase]);
    str:=StringReplace(str,'�', 'E',[rfReplaceAll, rfIgnoreCase]);
    str:=StringReplace(str,'�', 'K',[rfReplaceAll, rfIgnoreCase]);
    str:=StringReplace(str,'�', 'O',[rfReplaceAll, rfIgnoreCase]);
  end;
  result:=str;
end;

function TDMod.GetWMModelNote(str:string):string;
var
  nm,md : string;
begin
  str:=self.UpAndTranslate(str,false,false);
  result:='';
  if (Pos('REN',str)>0)or(Pos('���',str)>0) then nm:='RENOVA';
  if (Pos('SLAV',str)>0)or(Pos('����',str)>0)or(Pos('��',str)>0) then nm:='������';
  if (Pos('EVGO',str)>0)or(Pos('����',str)>0) then nm:='EVGO';
  if (Pos('30',str)>0) then md:='WS-30';
  if (Pos('35',str)>0) then md:='WS-35';
  if (Pos('40',str)>0) then md:='WS-40';
  if (Pos('50',str)>0) then md:='WS-50';
  if (Pos('60',str)>0) then md:='WS-60';
  if (Pos('65',str)>0) then md:='WS-65';
  if (Pos('70',str)>0) then md:='WS-70';
  if (Pos('80',str)>0) then md:='WS-80';
  if (Pos('85',str)>0) then md:='WS-85';
  if (Length(nm)>0)and(Length(md)>0) then result:=nm+' '+md else begin
    if (Length(nm)>0) then result:=nm;
    if (Length(md)>0) then result:=md;
  end;
end;

function TDMod.GetDRYERModelNote(str:string):string;
var
  nm,md : string;
begin
  str:=self.UpAndTranslate(str,false,false);
  result:='';
  if (Pos('REN',str)>0)or(Pos('���',str)>0) then nm:='RENOVA';
  if (Pos('SLAV',str)>0)or(Pos('����',str)>0) then nm:='������';
  if (Pos('EVGO',str)>0)or(Pos('����',str)>0) then nm:='EVGO';
  if (Pos('DH-500',str)>0) then md:='DH-500V/5';
  if (Pos('DVN31',str)>0) then md:='DVN31-500/5';
  if (Pos('DVN37',str)>0) then md:='DVN37-500/5';
  if (Length(nm)>0)and(Length(md)>0) then result:=nm+' '+md else begin
    if (Length(nm)>0) then result:=nm;
    if (Length(md)>0) then result:=md;
  end;
end;

function TDMod.DecodeWMSN(str:string;const DS : TDataSet = nil):string;
var
  d,m,y     : integer;
  mainDt    : TDate;
  FactID,ShiftID,ModID : integer;
begin
  result:='';
  if Length(str)=14 then begin
    if (str[1]='K')or(str[1]='N') then begin
      //������ ������ � ��� �
      FactID:=0;
      if (str[1]='K') then FactID:=1;
      if (str[1]='N') then FactID:=2;
      if not(ModelsTable.Lookup('IDFORSN',copy(str,2,3),'ID')=Null) then begin
         //2-4 ������� ������ � ������� ����������� ������
         ModID:=ModelsTable.Lookup('IDFORSN',copy(str,2,3),'ID');
         d:=StrToIntDef(copy(str,5,2),-1);
         m:=StrToIntDef(copy(str,7,2),-1);
         y:=StrToIntDef(copy(str,9,2),-1);
         if (d>0)and(m>0)and(y>0)and(IsValidDate(2000+y,m,d)) then begin
           //���� ���������
           mainDt:=EncodeDate(2000+y,m,d);
           if (ord(str[11])>=65)and(ord(str[11])<=70) then begin
              ShiftID:=ord(str[11])-64;
              //����� ���������
              if StrToIntDef(copy(str,12,3),-1)>0 then begin
                //���������� ����� ���������
                if (DS<>nil) then begin
                  DS.FieldByName('MAINDATE').AsDateTime:=mainDT;
                  DS.FieldByName('MODELID').AsInteger:=ModID;
                  if not(self.ModelsTable.Lookup('ID',ModID,'PRODUCTGROUP')=NULL) then
                    DS.FieldByName('GROUPID').AsInteger:=self.ModelsTable.Lookup('ID',ModID,'PRODUCTGROUP');
                    DS.FieldByName('FACTORYID').AsInteger:=FactID;
                    DS.FieldByName('SHIFTID').AsInteger:=ShiftID;
                end;
                if FactID=1 then
                  result:=inttostr(self.ModelsTable.Lookup('ID',ModID,'IDFORCODES'))+
                    FormatDateTime('DDMMYY',MainDt)+inttostr(ShiftID)+
                      copy(str,Length(str)-2,3)
                else
                  result:=inttostr(self.ModelsTable.Lookup('ID',ModID,'IDFORCODESEAST'))+
                    FormatDateTime('DDMMYY',MainDt)+inttostr(ShiftID)+
                      copy(str,Length(str)-2,3);
             end;
           end;
         end;
      end;
    end;
  end;
end;

function TDMod.DecodeDRYERSN1(str:string;const DS : TDataSet = nil):string;
var
  d,m,y     : integer;
  mainDt    : TDate;
  FactID,ShiftID,ModID : integer;
begin
  result:='';
  if Length(str)=12 then begin
    if (str[1]='K') then begin
      //������ ������ �
      FactID:=0;
      if (str[1]='K') then FactID:=1;
      if not(ModelsTable.Lookup('IDFORSN',copy(str,1,2),'ID')=Null) then begin
         //1-2 ������� ������ � ������� ����������� ������
         ModID:=ModelsTable.Lookup('IDFORSN',copy(str,1,2),'ID');
         d:=StrToIntDef(copy(str,3,2),-1);
         m:=StrToIntDef(copy(str,5,2),-1);
         y:=StrToIntDef(copy(str,7,2),-1);
         if (d>0)and(m>0)and(y>0)and(IsValidDate(2000+y,m,d)) then begin
           //���� ���������
           mainDt:=EncodeDate(2000+y,m,d);
           if (ord(str[9])>=65)and(ord(str[9])<=70) then begin
              ShiftID:=ord(str[9])-64;
              //����� ���������
              if StrToIntDef(copy(str,10,3),-1)>0 then begin
                //���������� ����� ���������
                if (DS<>nil) then begin
                  DS.FieldByName('MAINDATE').AsDateTime:=mainDT;
                  DS.FieldByName('MODELID').AsInteger:=ModID;
                  if not(self.ModelsTable.Lookup('ID',ModID,'PRODUCTGROUP')=NULL) then
                    DS.FieldByName('GROUPID').AsInteger:=self.ModelsTable.Lookup('ID',ModID,'PRODUCTGROUP');
                    DS.FieldByName('FACTORYID').AsInteger:=FactID;
                    DS.FieldByName('SHIFTID').AsInteger:=ShiftID;
                end;
                result:=inttostr(self.ModelsTable.Lookup('ID',ModID,'IDFORCODES'))+
                  FormatDateTime('DDMMYY',MainDt)+inttostr(ShiftID)+
                    copy(str,Length(str)-2,3);
             end;
           end;
         end;
      end;
    end;
  end;
end;

function TDMod.DecodeDRYERSN2(str:string;const DS : TDataSet = nil):string;
var
  d,m,y     : integer;
  mainDt    : TDate;
  FactID,ShiftID,ModID : integer;
begin
  result:='';
  if Length(str)=17 then begin
    if (str[1]='K')or(str[1]='N') then begin
      //������ ������ � ��� �
      FactID:=0;
      if (str[1]='K') then FactID:=1;
      if (str[1]='N') then FactID:=2;
      if not(ModelsTable.Lookup('IDFORSN',copy(str,2,6),'ID')=Null) then begin
         //2-5 ������� ������ � ������� ����������� ������
         ModID:=ModelsTable.Lookup('IDFORSN',copy(str,2,6),'ID');
         d:=StrToIntDef(copy(str,8,2),-1);
         m:=StrToIntDef(copy(str,10,2),-1);
         y:=StrToIntDef(copy(str,12,2),-1);
         if (d>0)and(m>0)and(y>0)and(IsValidDate(2000+y,m,d)) then begin
           //���� ���������
           mainDt:=EncodeDate(2000+y,m,d);
           if (ord(str[14])>=65)and(ord(str[14])<=70) then begin
              ShiftID:=ord(str[14])-64;
              //����� ���������
              if StrToIntDef(copy(str,15,3),-1)>0 then begin
                //���������� ����� ���������
                if (DS<>nil) then begin
                  DS.FieldByName('MAINDATE').AsDateTime:=mainDT;
                  DS.FieldByName('MODELID').AsInteger:=ModID;
                  if not(self.ModelsTable.Lookup('ID',ModID,'PRODUCTGROUP')=NULL) then
                    DS.FieldByName('GROUPID').AsInteger:=self.ModelsTable.Lookup('ID',ModID,'PRODUCTGROUP');
                    DS.FieldByName('FACTORYID').AsInteger:=FactID;
                    DS.FieldByName('SHIFTID').AsInteger:=ShiftID;
                end;
                result:=inttostr(self.ModelsTable.Lookup('ID',ModID,'IDFORCODES'))+
                  FormatDateTime('DDMMYY',MainDt)+inttostr(ShiftID)+
                    copy(str,Length(str)-2,3);
             end;
           end;
         end;
      end;
    end;
  end;
end;

function TDMod.DecodeDRYERSN(str:string;const DS : TDataSet = nil):string;
var
  d,m,y     : integer;
  mainDt    : TDate;
  FactID,ShiftID,ModID : integer;
begin
  result:='';
  if Length(str)=15 then begin
    if (str[1]='K')or(str[1]='N') then begin
      //������ ������ � ��� �
      FactID:=0;
      if (str[1]='K') then FactID:=1;
      if (str[1]='N') then FactID:=2;
      if not(ModelsTable.Lookup('IDFORSN',copy(str,2,4),'ID')=Null) then begin
         //2-5 ������� ������ � ������� ����������� ������
         ModID:=ModelsTable.Lookup('IDFORSN',copy(str,2,4),'ID');
         d:=StrToIntDef(copy(str,6,2),-1);
         m:=StrToIntDef(copy(str,8,2),-1);
         y:=StrToIntDef(copy(str,10,2),-1);
         if (d>0)and(m>0)and(y>0)and(IsValidDate(2000+y,m,d)) then begin
           //���� ���������
           mainDt:=EncodeDate(2000+y,m,d);
           if (ord(str[12])>=65)and(ord(str[12])<=70) then begin
              ShiftID:=ord(str[12])-64;
              //����� ���������
              if StrToIntDef(copy(str,13,3),-1)>0 then begin
                //���������� ����� ���������
                if (DS<>nil) then begin
                  DS.FieldByName('MAINDATE').AsDateTime:=mainDT;
                  DS.FieldByName('MODELID').AsInteger:=ModID;
                  if not(self.ModelsTable.Lookup('ID',ModID,'PRODUCTGROUP')=NULL) then
                    DS.FieldByName('GROUPID').AsInteger:=self.ModelsTable.Lookup('ID',ModID,'PRODUCTGROUP');
                    DS.FieldByName('FACTORYID').AsInteger:=FactID;
                    DS.FieldByName('SHIFTID').AsInteger:=ShiftID;
                end;
                result:=inttostr(self.ModelsTable.Lookup('ID',ModID,'IDFORCODES'))+
                  FormatDateTime('DDMMYY',MainDt)+inttostr(ShiftID)+
                    copy(str,Length(str)-2,3);
             end;
           end;
         end;
      end;
    end;
  end;
end;


//------------------ �������� ����� ������ -------------------------------------

function  TDMod.SpellingVerify(var Errors : TRecordsError; DS : TDataSet;maintype:integer):boolean;
var
  isaddpart, ErrorRec : boolean;
  i,ID   : integer;
  Query  : TADOQuery;
begin
  isaddpart:=DS.FieldByName('ISADDPART').AsBoolean;
  ID:=DS.FieldByName('ID').AsInteger;
  DS.FieldByName('WORKID').AsInteger:=0;
  //���� ��� ��������������� ������ ����������� ������ �������� ����� � ���� � ������
  if not isaddpart then begin
    //��� �������
    i:=DMod.GetWorkType(DS.FieldByName('WORKTYPE').AsString);
    if i>0 then begin
      DS.FieldByName('WORKTYPE').AsString:=WorkTypes[i];
      DS.FieldByName('WORKID').AsInteger:=i;
    end else AddToErrorArray(Errors,'WORKTYPE',ID,rcsSpellingErrors, '��� ������� �� ���������');
    //���� �������
    if (DS.FieldByName('WORKPRICE').AsInteger<=0) then
      AddToErrorArray(Errors,'WORKPRICE',ID,rcsSpellingErrors, '������������ ��������� �������');
    //���� ������ �������
    if (DS.FieldByName('STARTDATE').IsNULL) then
      AddToErrorArray(Errors,'STARTDATE',ID,rcsSpellingErrors, '���� ������ ������� �� �������');
    //���� ��������� �������
    if (DS.FieldByName('ENDDATE').IsNULL) then
      AddToErrorArray(Errors,'ENDDATE',ID,rcsSpellingErrors, '���� ��������� ������� �� �������');
    //�������� ��������
    if Length(DS.FieldByName('PROBLEMNOTE').AsString)=0 then
      AddToErrorArray(Errors,'PROBLEMNOTE',ID,rcsSpellingErrors, '�� ������ ���������� ������');
  end;
  //�������� ��������� ��������� ������
  //����������� ������ ��� ����� 1 � 2 - �������� � �������
  ErrorRec:=false;
  case maintype of
    1 : errorrec:=(Length(DecodeWMSN(DS.FieldByName('SN').AsString,DS))=0);
    2 : begin
        errorrec:=(Length(DecodeDRYERSN(DS.FieldByName('SN').AsString,DS))=0);
        if errorrec then errorrec:=(Length(DecodeDRYERSN1(DS.FieldByName('SN').AsString,DS))=0);
        if errorrec then errorrec:=(Length(DecodeDRYERSN2(DS.FieldByName('SN').AsString,DS))=0);
        end;
  end;
  if errorrec then AddToErrorArray(Errors,'SN',ID,rcsSpellingErrors, '������ � �������� ������');
  //���������� � ������
  if (Length(DS.FieldByName('PARTS').AsString)=0)and((isaddpart)or(DS.FieldByName('PARTQTY').AsInteger>0)or
        (DS.FieldByName('PARTCOST').AsFloat>0)) then
          AddToErrorArray(Errors,'PARTS',ID,rcsSpellingErrors, '������ �� �������');
  if (DS.FieldByName('PARTQTY').AsInteger<=0)and((isaddpart)or(DS.FieldByName('PARTCOST').AsInteger>0)or
        (Length(DS.FieldByName('PARTS').AsString)>0)) then
          AddToErrorArray(Errors,'PARTQTY',ID,rcsSpellingErrors, '������������ ���������� �������');
  //����� ��������� ������ ���� ������ ����� ������ ��������� �����
  //"���������� ������" ��� ����� ���������� ������
  ID:=DS.FieldByName('REPORTID').AsInteger;
  Query:=TADOQuery.Create(self);
  Query.Connection:=self.Connection;
  Query.SQL.Add('SELECT T2.FREEPARTS FROM SERVREPORT AS T1');
  Query.SQL.Add('INNER JOIN SERVCENTRES AS T2 ON T2.ID=T1.SENTERID');
  Query.SQL.Add('WHERE T1.ID='+IntToStr(ID));
  Query.Open;
  if not Query.FieldByName('FREEPARTS').AsBoolean then
    if (DS.FieldByName('PARTCOST').AsInteger<=0)and((isaddpart)or(DS.FieldByName('PARTQTY').AsInteger>0)or
          (Length(DS.FieldByName('PARTS').AsString)>0)) then
            AddToErrorArray(Errors,'PARTCOST',ID,rcsSpellingErrors, '������������ ���� ������');
  Query.Free;
  result:=(high(Errors)<0);
end;

function TDMod.DataVerify(var Errors : TRecordsError; DS : TDataSet;maintype:integer):boolean;
var
  str     : string;
  Query   : TADOQuery;
  val     : variant;
  id,ptid : integer;
begin
  with DS do begin
    id:=FieldByName('WORKID').AsInteger;
    //���� ������ ���������� ������ ���� ������ ���� �������
    //������, ��� ����� � �������
    if (id=2)or(id=3) then begin
      if(FieldByName('BUYDATE').IsNull) then
        DMod.AddToErrorArray(Errors,'BUYDATE',FieldByName('ID').AsInteger,
          rcsDataErrors, '��� ����������� � ��������������� ������� ������ ���� ������� ���� �������');
      if (length(FieldByName('CLIENT').AsString)=0) then
        DMod.AddToErrorArray(Errors,'CLIENT',FieldByName('ID').AsInteger,
          rcsDataErrors, '��� ����������� ������� ������ ���� ������� ������� �������');
      if (length(FieldByName('CLIENTADDR').AsString)=0) then
        DMod.AddToErrorArray(Errors,'CLIENTADDR',FieldByName('ID').AsInteger,
          rcsDataErrors, '��� ����������� ������ ����� ���� ������ ����� �������');
      if (length(FieldByName('CLIENTTEL').AsString)=0) then
        DMod.AddToErrorArray(Errors,'CLIENTTEL',FieldByName('ID').AsInteger,
          rcsDataErrors, '��� ����������� ������� ����� ���� ������ ������� �������');
    end;
    //���� ������ ������������� ���� ������� ���� �� ������
    if (id=1)and(not(FieldByName('BUYDATE').IsNull)) then
      DMod.AddToErrorArray(Errors,'BUYDATE',FieldByName('ID').AsInteger,
        rcsDataErrors, '��� �������������� ������� ���� ������� �� �����������');
    //��� ���� ������ ���� ������� ���� ������������
    if not FieldByName('MAINDATE').IsNull then begin
      if (not FieldByName('BUYDATE').IsNull)and
      (not(FieldByName('BUYDATE').AsDateTime>FieldByName('MAINDATE').AsDateTime)) then
        DMod.AddToErrorArray(Errors,'BUYDATE',FieldByName('ID').AsInteger,
          rcsDataErrors, '������� ������� ������, ��� �����������  - ��� �� ��������');
      if not(FieldByName('STARTDATE').AsDateTime>FieldByName('MAINDATE').AsDateTime) then
        DMod.AddToErrorArray(Errors,'STARTDATE',FieldByName('ID').AsInteger,
          rcsDataErrors, '������ ����� ������ ������������ �������  - ��� �� ��������');
      if not(FieldByName('ENDDATE').AsDateTime>FieldByName('MAINDATE').AsDateTime) then
        DMod.AddToErrorArray(Errors,'ENDDATE',FieldByName('ID').AsInteger,
          rcsDataErrors, '������ ������� ������ ������������ �������  - ��� �� ��������');
    end;
    //���� ������ � ��������� ������� ������ ���� ������� ���� �������
    //�������� ������������ �����
    if not FieldByName('BUYDATE').IsNull then begin
      if not(FieldByName('STARTDATE').AsDateTime>FieldByName('BUYDATE').AsDateTime) then
        DMod.AddToErrorArray(Errors,'STARTDATE',FieldByName('ID').AsInteger,
          rcsDataErrors, '������ ����� ������ ������� �������  - ��� �� ��������');
      if not(FieldByName('ENDDATE').AsDateTime>FieldByName('BUYDATE').AsDateTime) then
        DMod.AddToErrorArray(Errors,'ENDDATE',FieldByName('ID').AsInteger,
          rcsDataErrors, '������ ������� ������ ������� �������  - ��� �� ��������');
      val:=self.MainTypesTable.Lookup('ID',maintype,'GARANTTIME');
      if val=null then val:=CustomGarantTime;
      if YearsBetween(FieldByName('BUYDATE').AsDateTime,FieldByName('STARTDATE').AsDateTime)>=val then
        DMod.AddToErrorArray(Errors,'STARTDATE',FieldByName('ID').AsInteger,
          rcsDataErrors, '����������� ���� �����');
    end;
    //���� ��������� ������� ������ ���� ������� ���� ������
    if not(FieldByName('ENDDATE').AsDateTime>=FieldByName('STARTDATE').AsDateTime) then
      DMod.AddToErrorArray(Errors,'ENDDATE',FieldByName('ID').AsInteger,
        rcsDataErrors, '������ ������� ������ ��� �����  - ��� �� ��������');
    //�������� ����� �������
    if DaysBetween(FieldByName('STARTDATE').AsDateTime,FieldByName('ENDDATE').AsDateTime)>WorkTime then
      DMod.AddToErrorArray(Errors,'ENDDATE',FieldByName('ID').AsInteger,
        rcsDataErrors, '���� ������� ��������');
    Query:=TADOQuery.Create(self);
    Query.Connection:=self.Connection;
    //�������� ������ ����� ��������� ������ ���� ������ � �������� ������ ����������
    // ��. ������ ��� ����� 1 � 2 - ��������, �������
    Query.SQL.Add('SELECT DESCR FROM PRODUCTIONMODELS WHERE MAINTYPE='+INTTOSTR(maintype)+
      ' AND ID='+INTTOSTR(FieldByName('MODELID').AsInteger));
    Query.Open;
    if not Query.IsEmpty then begin
      if (Length(FieldByName('MODELNOTE').AsString)=0)then
          FieldByName('MODELNOTE').AsString:=Query.FieldByName('DESCR').AsString
      else begin
        case maintype of
          1 : str:=self.GetWMModelNote(FieldByName('MODELNOTE').AsString);
          2 : str:=self.GetDRYERModelNote(FieldByName('MODELNOTE').AsString);
        end;
        //if length(str)>0 then FieldByName('MODELNOTE').AsString:=str;
        if FieldByName('MODELNOTE').AsString<>Query.FieldByName('DESCR').AsString then
              DMod.AddToErrorArray(Errors,'MODELNOTE',FieldByName('ID').AsInteger,rcsDataErrors, '������ �� ��������� � �������� �������');
      end;
    end;
    //����� � ������� (���� ��� �� �������������� ������)
    if not FieldByName('ISADDPART').AsBoolean then begin
      str:= FieldByName('SN').AsString;
      //id:= FieldByName('REPORTID').AsInteger;
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('SELECT ID FROM SERVRECORDS WHERE SN='+QuotedStr(str)+' AND STATUS=5');
      Query.Open;
      if not Query.IsEmpty then
        AddToErrorArray(Errors,'HISTORY',FieldByName('ID').AsInteger,
          rcsDataErrors, '���� ����� ����������� � ���� ��� ������ �������');
    end;
    //����� ��������� � ������������
    //����� ������������ ���� ������ ����  ������ ������ � ������� ���������� �����
    //���� ������ ������� ������
    val:=null;
    if ((not(DMod.MainTypesTable.Lookup('ID',maintype,'SEARCHDATE')=null))AND
        (not(FieldByName('MAINDATE').AsVariant)=null)and
        (FieldByName('MAINDATE').AsDateTime>DMod.MainTypesTable.Lookup('ID',maintype,'SEARCHDATE')))OR
        (DMod.MainTypesTable.Lookup('ID',maintype,'SEARCHDATE')=null)
        then val:=DMod.MainTypesTable.Lookup('ID',maintype,'PRODUCTIONCODETABLE');
    if (not(val=null))then begin
      str:='';
      //��� �������� � ������� �������� ����������� � ��� EAN-13
      //��� ��������� ����� - ����� ������ �� ������
      case maintype of
            1 : str:=self.DecodeWMSN(FieldByName('SN').AsString);
            2 : begin
                str:=self.DecodeDRYERSN(FieldByName('SN').AsString);
                if Length(str)=0 then str:=self.DecodeDRYERSN1(FieldByName('SN').AsString);
                end
            else str:=FieldByName('SN').AsString;
      end;
      if length(str)>0 then begin
        Query.Close;
        Query.SQL.Clear;
        case FieldByName('FACTORYID').AsInteger of
          1 : Query.SQL.Add('SELECT ID FROM '+VAL+' WHERE CODE='+QuotedStr(str)+' AND (SHOPSID=2 OR SHOPSID=3)');
          2 : Query.SQL.Add('SELECT ID FROM '+VAL+' WHERE CODE='+QuotedStr(str)+' AND SHOPSID=4');
        end;
        try
          Query.Open;
          if Query.IsEmpty then AddToErrorArray(Errors,'SN',FieldByName('ID').AsInteger,
            rcsDataErrors, '�������� ����� �� ������ � ������������');
        except
          AddToErrorArray(Errors,'SN',FieldByName('ID').AsInteger,
            rcsDataErrors, '������ ����������� � ������� �����');
        end;
      end else AddToErrorArray(Errors,'SN',FieldByName('ID').AsInteger,
          rcsDataErrors, '������ ��������� SN ������� 2');
    end;
    //��� ������������� ����������� ���� ��� ��������� ������, � ��� ��� ������ - ���� ������
    //������������ � �������� ���� ������������ ��� ���� �������
    ptid:=0;
    if (not(FieldByName('ISADDPART').AsBoolean))
    or((FieldByName('ISADDPART').AsBoolean)and(Length(DS.FieldByName('WORKCODE').AsString)>0)) then begin
      FieldByName('WORKCODE').AsString:=self.UpAndTranslate(DS.FieldByName('WORKCODE').AsString,true);
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('SELECT * FROM SERVCODES WHERE (MAINTYPE='+IntToStr(maintype)+' OR MAINTYPE=0)');
      Query.Open;
      if Query.Lookup('CODE',DS.FieldByName('WORKCODE').AsString,'ID')=NULL then
        AddToErrorArray(Errors,'WORKCODE',ID,rcsDataErrors, '������������ ��� �������')
      else
        if Query.Lookup('CODE',DS.FieldByName('WORKCODE').AsString,'PRICETYPEID')<>NULL
          then PTID:=Query.Lookup('CODE',DS.FieldByName('WORKCODE').AsString,'PRICETYPEID');
    end;
    //����� ��� ���� ������� ����� �������� ����� ��� ����� �� � �������� ������������
    if ptid>0 then begin
      //������ ID ��
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('SELECT SENTERID FROM SERVREPORT WHERE ID='+FieldByName('REPORTID').AsString);
      Query.Open;
      id:=Query.FieldByName('SENTERID').AsInteger;
      //�������� ���� �� ������� ��� �� ����, �� � ���� �������
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('SELECT PRICE FROM SERVPRICELIST WHERE (SENTERID='+INTTOSTR(ID)+') AND '+
        '(MAINTYPEID='+IntToStr(maintype)+') AND (PRICETYPEID='+IntToStr(ptid)+')');
      Query.Open;
      if not Query.IsEmpty then
        if Query.FieldByName('PRICE').AsFloat<>FieldByName('WORKPRICE').AsFloat then
          AddToErrorArray(Errors,'WORKPRICE',ID,rcsDataErrors,'��� ����� ������� ���� ������ ���� '
            +Query.FieldByName('PRICE').AsString+' ���');
    end;
    Query.Free;
    //���������� � ��������� �� ������
    if (Length(FieldByName('PARTS').AsString)>0)and(Length(FieldByName('PARTDOC').AsString)=0) then
          AddToErrorArray(Errors,'PARTDOC',ID,rcsDataErrors, '�� ������� ����� ���������');
  end;
  result:=(high(errors)<0);
end;

function TDMod.RecordsVerify(var Errors : TRecordsError; DS : TDataSet; prname:string):boolean;
var
  PForm      : TProgressForm;
  maintype,i : integer;
  str        : string;
begin
  if not DS.IsEmpty then begin
    // ����� ����� ��������� ����������
    PForm:=TProgressForm.Create(application.MainForm);
    if (Length(prname)>0)and(DS.RecordCount>5) then begin
      PForm.PB.Progress:=0;
      PForm.PB.MaxValue:=DS.RecordCount;
      PForm.ProcName.Caption:=prname;
      PForm.Show;
      application.ProcessMessages;
    end;
    //��������
    DS.First;
    while (not DS.Eof) do begin
      if (DS.FieldByName('STATUS').AsInteger<rcsManualVerified) then begin
        SetLength(Errors,0);
        if not DS.Modified then DS.Edit;
        //�������� ������ � ��������� ����
        DS.FieldByName('STATUS').AsInteger:=rcsNotVerified;
        DS.FieldByName('ERRORS').AsString:='';
        DS.FieldByName('MAINDATE').AsVariant:=NULL;
        DS.FieldByName('WORKID').AsInteger:=0;
        DS.FieldByName('MODELID').AsInteger:=0;
        DS.FieldByName('GROUPID').AsInteger:=0;
        DS.FieldByName('FACTORYID').AsInteger:=0;
        DS.FieldByName('SHIFTID').AsInteger:=0;
        //���������� ��� ��������� ���� �� ��� �� ���������
        maintype:=DS.FieldByName('MAINTYPEID').AsInteger;
        if maintype=0 then begin
          DS.FieldByName('SN').AsString:=self.UpAndTranslate(DS.FieldByName('SN').AsString,true);
          maintype:=self.GetMainType(DS.FieldByName('SN').AsString);
          //���������� ��� ���������
          DS.FieldByName('MAINTYPEID').AsInteger:=maintype;
        end;
        if maintype>0 then begin
          //�������� ������� ������
          if not self.SpellingVerify(Errors,DS,maintype) then DS.FieldByName('STATUS').AsInteger:=rcsSpellingErrors
            //�������� ������� ������
            else if not DataVerify(Errors,DS,maintype) then DS.FieldByName('STATUS').AsInteger:=rcsDataErrors
              //���������
              else DS.FieldByName('STATUS').AsInteger:=rcsAutoVerified;
        end else AddToErrorArray(Errors,'SN',DS.FieldByName('ID').AsInteger,rcsNotVerified, '��� ��������� �� ���������');
        //�������������� ���� "������"
        if high(Errors)>=0 then begin
          str:=DS.FieldByName('ERRORS').AsString;
          for I := 0 to high(Errors) do begin
              if Length(str)>0 then str:=str+chr(13);
              str:=str+Errors[i].code;
            end;
          if not DS.Modified then DS.Edit;          
          DS.FieldByName('ERRORS').AsString:=str;
        end;
        if DS.Modified then DS.Post;
      end;
      if PForm.Showing then begin
        PForm.PB.Progress:=PForm.PB.Progress+1;
        application.ProcessMessages;
        if (PForm.StopProcess) then Break;
      end;
      DS.Next;
    end;
    PForm.Free;
  end;
  Result:=(high(Errors)>=0);
end;

//-------------------------������ � ��������------------------------------------

procedure TDMod.WriteEvent(AutorID,Status,DocID : integer;TableName : string);
var
  Query : TADOQuery;
  //SID   : integer;
begin
  Query:=TADOQuery.Create(self);
  Query.Connection:=self.Connection;
  Query.SQL.Add('SELECT @@SPID AS SPID');
  Query.Open;
  ShowMessage(Query.FieldByName('SPID').AsString);
  Query.Free;
end;

end.
