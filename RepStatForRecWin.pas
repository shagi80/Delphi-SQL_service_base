unit RepStatForRecWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, CheckLst, DB, ADODB, Grids,
  DBGrids, DBCtrls, frxClass, frxExportPDF, frxExportXLS,
  frxExportODF, frxDBSet;

type
  TRepStatForRecForm = class(TForm)
    TopPn: TPanel;
    CaptionLB: TLabel;
    DS: TDataSource;
    MainPn: TPanel;
    SB: TScrollBox;
    FilterPn: TPanel;
    BottomBevel: TBevel;
    Panel3: TPanel;
    Label1: TLabel;
    GetDateBtn: TSpeedButton;
    DateCB: TComboBox;
    StDateTP: TDateTimePicker;
    EndDateTP: TDateTimePicker;
    Panel4: TPanel;
    WorkTypeCheck: TCheckBox;
    WorkTypeCB: TComboBox;
    ModelPn: TPanel;
    ModelCheck: TCheckBox;
    ModelCB: TCheckListBox;
    ClientPn: TPanel;
    ClientDataCheck: TCheckBox;
    ClientDataPn: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ClearClientBtn: TSpeedButton;
    ClientAddrBtn: TSpeedButton;
    ClientTelBtn: TSpeedButton;
    ClientEd: TEdit;
    AddrEd: TEdit;
    TelEd: TEdit;
    MiainTypePn: TPanel;
    MainTypeCheck: TCheckBox;
    MainTypeCB: TCheckListBox;
    Panel5: TPanel;
    ClearSNEDBTN: TSpeedButton;
    SNCheck: TCheckBox;
    SNEd: TEdit;
    Panel6: TPanel;
    CostCheck: TCheckBox;
    CostDataPn: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    PartCostMin: TEdit;
    PartCostMax: TEdit;
    MovCostMin: TEdit;
    MovCostMax: TEdit;
    WorkCostMin: TEdit;
    WorkCostMax: TEdit;
    WorkForClientPn: TPanel;
    WorkForClientCheck: TCheckBox;
    WorkForClientED: TEdit;
    SenterPN: TPanel;
    SenterCheck: TCheckBox;
    SenterCB: TCheckListBox;
    Panel8: TPanel;
    ClearWorkTimeBtn: TSpeedButton;
    WorkTimeCheck: TCheckBox;
    WorkTimeED: TEdit;
    WorkTimeCB: TComboBox;
    Panel9: TPanel;
    ClearPartBtn: TSpeedButton;
    PartCheck: TCheckBox;
    PartED: TEdit;
    Panel10: TPanel;
    ClearProblemNoteBtn: TSpeedButton;
    ProblemNoteCheck: TCheckBox;
    ProblemNoteED: TEdit;
    Panel11: TPanel;
    ClearWorkNoteBtn: TSpeedButton;
    WorkNoteCheck: TCheckBox;
    WorkNoteED: TEdit;
    Panel12: TPanel;
    WorkCodeCheck: TCheckBox;
    WorkCodeCB: TCheckListBox;
    SetBtn: TSpeedButton;
    Panel1: TPanel;
    Grid: TDBGrid;
    BottomPn: TPanel;
    PrepareBtn: TBitBtn;
    MyQuery: TADOQuery;
    CloseBtn: TBitBtn;
    ResultPn: TPanel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    DBText5: TDBText;
    Bevel3: TBevel;
    TopResultPn: TPanel;
    ShowResultBtn: TSpeedButton;
    SumQuery: TADOQuery;
    SumDS: TDataSource;
    PrintBtn: TBitBtn;
    RegionPN: TPanel;
    RegionSB: TCheckBox;
    RegionCB: TComboBox;
    FactoryPn: TPanel;
    FactoryCheck: TCheckBox;
    FactoryCB: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClearClientBtnClick(Sender: TObject);
    procedure UpdateFilter(Sender: TObject);
    function  UpdateModelCB(mt : integer): integer;
    function  UpdateSenterCB: integer;
    function  UpdateCodeCB(mt : integer): integer;
    procedure FormShow(Sender: TObject);
    function  GetRecordFilterString : string;
    function  GetReportFilterString : string;
    function  GetCenterFilterString : string;
    procedure ChangeFilter(Sender: TObject);
    procedure PrepareBtnClick(Sender: TObject);
    procedure GetDateBtnClick(Sender: TObject);
    procedure SetBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure ShowResultBtnClick(Sender: TObject);
    procedure TopResultPnMouseDown(Sender: TObject;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TopResultPnMouseMove(Sender: TObject;
              Shift: TShiftState; X, Y: Integer);
    procedure TopResultPnMouseUp(Sender: TObject;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CalkSum;
    procedure PrintBtnClick(Sender: TObject);
    procedure ReportGetValue(const VarName: string; var Value: Variant);
    function  GetReportFilterCaption : string;
    function  GetRecordFilterCaption : string;
   // function  GetCenterFilterCaption : string;
    procedure GridDblClick(Sender: TObject);
    procedure RegionCBChange(Sender: TObject);
    procedure RegionSBClick(Sender: TObject);
  private
    { Private declarations }
    ResPnMov       : TPoint;   //��� ����������� ������ ������
    ResultPnHeight : integer;  //��� ����������� ������ ������
    SumSql         : string;   //��� ���������� �������� �� �����������
    FirstStart     : boolean;  //���� ������� �������
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataMod, DateWin, DateUtils, PrintMod, RecordDataWin;

function  TRepStatForRecForm.GetCenterFilterString : string;
var
  pid     : ^integer;
begin
  //����� �� �������
  if RegionSB.Checked then begin
    pid:=pointer(RegionCB.Items.Objects[RegionCB.ItemIndex]);
    result:='(REGIONID='+IntToStr(pid^)+')';
  end else result:='';
end;

function  TRepStatForRecForm.GetReportFilterString : string;
var
  flt,str : string;
  i       : integer;
  pid     : ^integer;
begin
  flt:='';
  //�� ����, ���� ���� ���������� � ������ (�������� ������ ��� ���� ������)
  if DateCB.ItemIndex<2 then begin
    case DateCB.ItemIndex of
      0 : str:='REPDATE';
      1 : str:='DOCDATE';
    end;
    flt:='('+str+' BETWEEN '+QuotedStr(FormatDateTime('yyyymmdd',StartOfTheDay(StDateTP.Date)))+
      ' AND '+QuotedStr(FormatDateTime('yyyymmdd',EndOfTheDay(EndDateTP.Date)))+')';
  end;
  //�� ��������� �������
  str:='';
  if (SenterCheck.Checked) then begin
    str:='';
    for i := 0 to SenterCB.Items.Count-1 do
      if SenterCB.Checked[i] then begin
        pid:=pointer(SenterCB.Items.Objects[i]);
        if length(str)=0 then str:='(SENTERID='+inttostr(pid^)+')' else str:=str+' OR (SENTERID='+inttostr(pid^)+')';
      end;
    if length(str)>0 then
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND ('+str+')';
  end;
  result:=flt;
end;

function  TRepStatForRecForm.GetRecordFilterString : string;
var
  flt,str : string;
  i       : integer;
  pid     : ^integer;
  pstr    : ^string;
begin
  flt:='';
  //�� ����, ���� ���� ���������� � ������ (���� ������������, ���� �������, ���� ������ �������)
  if DateCB.ItemIndex>1 then begin
    case DateCB.ItemIndex of
      2 : str:='MAINDATE';
      3 : str:='BUYDATE';
      4 : str:='STARTDATE';
      5 : str:='ACCEPTDATE';
    end;
    flt:='('+str+' BETWEEN '+QuotedStr(FormatDateTime('yyyymmdd',StartOfTheDay(StDateTP.Date)))
      +' AND '+QuotedStr(FormatDateTime('yyyymmdd',EndOfTheDay(EndDateTP.Date)))+')';
  end;
  //�������
  if FactoryCheck.Checked then begin
    case FactoryCB.ItemIndex of
      1 : str:='(FACTORYID=1)';
      2 : str:='(FACTORYID=2)';
      else str:='';
    end;
    if length(str)>0 then
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
  end;
  //��� �������
  if WorkTypeCheck.Checked then begin
    str:='(WORKTYPE='+QuotedStr(WorkTypeCB.Text)+')';
    if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
  end;
  //���� ������
  if (WorkForClientCheck.Checked)and(WorkTypeCB.Visible)
    and(WorkTypeCB.ItemIndex=1)and(StrToIntDef(WorkForClientED.Text,0)>0 )then begin
      str:='((STARTDATE-BUYDATE)<='+inttostr(strtointdef(WorkForClientEd.Text,0))+')';
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
  end;
  //�� ������ �������
  if (ClientDataCheck.Checked)and(WorkTypeCB.Visible)and(WorkTypeCB.ItemIndex=1) then begin
    if Length(ClientED.Text)>0 then begin
      str:='(CLIENT LIKE '+QuotedStr('%'+ClientED.Text+'%')+')';
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
    end;
    if Length(AddrED.Text)>0 then begin
      str:='(CLIENTADDR LIKE '+QuotedStr('%'+AddrED.Text+'%')+')';
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
    end;
    if Length(TelED.Text)>0 then begin
      str:='(CLIENTTEL LIKE '+QuotedStr('%'+TelED.Text+'%')+')';
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
    end;
  end;
  //�� ���� ���������
  str:='';
  if (MainTypeCheck.Checked) then begin
    str:='';
    for i := 0 to MainTypeCB.Items.Count-1 do
      if MainTypeCB.Checked[i] then begin
        pid:=pointer(MainTypeCB.Items.Objects[i]);
        if length(str)=0 then str:='(MAINTYPEID='+inttostr(pid^)+')' else str:=str+' OR (MAINTYPEID='+inttostr(pid^)+')';
      end;
    if length(str)>0 then
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND ('+str+')';
  end;
  //�� ������
  str:='';
  if (ModelCB.Visible)and(ModelCheck.Checked)and(ModelCheck.Enabled) then begin
    str:='';
    for i := 0 to ModelCB.Items.Count-1 do
      if ModelCB.Checked[i] then begin
        pid:=pointer(ModelCB.Items.Objects[i]);
        if length(str)=0 then str:='(MODELID='+inttostr(pid^)+')' else str:=str+' OR (MODELID='+inttostr(pid^)+')';
      end;
    if length(str)>0 then
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND ('+str+')';
  end;
  //�� ��������� ������
  if (SNCheck.Checked)and(Length(SNED.Text)>0) then begin
    str:='(SN LIKE '+QuotedStr('%'+SNED.Text+'%')+')';
    if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
  end;
  //�� ����� �������
  if (WorkTimeCheck.Checked)and(StrToIntDef(WorkTimeED.Text,0)>0) then begin
    str:='((ENDDATE-STARTDATE)'+WorkTimeCB.Text+inttostr(strtointdef(WorkTimeED.Text,0))+')';
    if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
  end;
  //�� ���������
  if (CostCheck.Checked)then begin
    if(strtointdef(PartCostMin.Text,0)>0) then begin
      str:='(PARTCOST>'+ inttostr(strtointdef(PartCostMin.Text,0))+')';
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
    end;
    if(strtointdef(PartCostMax.Text,0)>0) then begin
      str:='(PARTCOST<='+inttostr(strtoint(PartCostMax.Text))+')';
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
    end;
    if (strtointdef(MovCostMin.Text,0)>0) then begin
      str:='(MOVPRICE>'+ inttostr(strtointdef(MovCostMin.Text,0))+')';
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
    end;
    if (strtointdef(MovCostMax.Text,0)>0) then begin
      str:='(MOVPRICE<='+inttostr(strtoint(MovCostMax.Text))+')';
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
    end;
    if(strtointdef(WorkCostMin.Text,0)>0) then begin
      str:='(WORKPRICE>'+ inttostr(strtointdef(WorkCostMin.Text,0))+')';
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
    end;
    if(strtointdef(WorkCostMax.Text,0)>0) then begin
      str:='(WORKPRICE<='+inttostr(strtoint(WorkCostMax.Text))+')';
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
    end;
  end;
  //�� �������� ������
  if (PartCheck.Checked)and(Length(PartED.Text)>0) then begin
    str:='(PARTS LIKE '+QuotedStr('%'+PartED.Text+'%')+')';
    if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
  end;
  //�� �������� ��������
  if (ProblemNoteCheck.Checked)and(Length(ProblemNoteED.Text)>0) then begin
    str:='(PROBLEMNOTE LIKE '+QuotedStr('%'+ProblemNoteED.Text+'%')+')';
    if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
  end;
  //�� �������� �����
  if (WorkNoteCheck.Checked)and(Length(WorkNoteED.Text)>0) then begin
    str:='(WORKNOTE LIKE '+QuotedStr('%'+WorkNoteED.Text+'%')+')';
    if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND '+str;
  end;
  //�� ���� �������������
  str:='';
  if (WorkCodeCB.Visible)and(WorkCodeCheck.Checked)and(WorkCodeCheck.Enabled) then begin
    str:='';
    for i := 0 to WorkCodeCB.Items.Count-1 do
      if WorkCodeCB.Checked[i] then begin
        pstr:=pointer(WorkCodeCB.Items.Objects[i]);
        if length(str)=0 then str:='(WORKCODE='+QuotedStr(pstr^)+')' else str:=str+' OR (WORKCODE='+QuotedStr(pstr^)+')';
      end;
    if length(str)>0 then
      if length(flt)=0 then flt:=str else flt:=flt+chr(13)+' AND ('+str+')';
  end;
  result:=flt;
end;

procedure TRepStatForRecForm.UpdateFilter(Sender: TObject);
var
  i,j : integer;
  pid : ^integer;
begin
  FactoryCB.Visible:=FactoryCheck.Checked;
  RegionCB.Visible:=RegionSB.Checked;
  SenterCB.Visible:=SenterCheck.Checked;
  WorkTypeCB.Visible:=(WorkTypeCheck.Checked);
  WorkForClientCheck.Enabled:=(WorkTypeCB.Visible)and(WorkTypeCB.ItemIndex=1);
  WorkForClientEd.Visible:=(WorkForClientCheck.Checked)and(WorkTypeCB.Visible)and(WorkTypeCB.ItemIndex=1);
  ClientDataCheck.Enabled:=(WorkTypeCB.Visible)and(WorkTypeCB.ItemIndex=1);
  ClientDataPn.Visible:=(ClientDataCheck.Checked)and(WorkTypeCB.Visible)and(WorkTypeCB.ItemIndex=1);
  MainTypeCB.Visible:=(MainTypeCheck.Checked);
  //������� ���-�� ��������� �����
  j:=0;
  pid:=nil;
  for i := 0 to MainTypeCB.Items.Count-1 do
    if MainTypeCB.Checked[i] then begin
      inc(j);
      pid:=pointer(MainTypeCB.Items.Objects[i]);
    end;
  i:=0;
  //���� ��� ���� ��������� ������ ������� � ������� ��-�� �������
  if (j=1)and(pid<>nil) then i:=self.UpdateModelCB(pid^);
  ModelCheck.Enabled:=(i>0)and(j=1)and(MainTypeCheck.Checked);
  ModelCB.Visible:=(ModelCheck.Checked)and(i>0)and(j=1)and(ModelCheck.Enabled);
  //���� ��� ���� ��������� ������ ����� � ������� ��-�� �������
  if (j=1)and(pid<>nil) then i:=self.UpdateCodeCB(pid^) else i:=self.UpdateCodeCB(0);
  WorkCodeCheck.Enabled:=(i>0);
  WorkCodeCB.Visible:=(WorkCodeCheck.Checked)and(i>0);
  SNED.Visible:=SNCheck.Checked;
  ClearSNEDBtn.Visible:=SNCheck.Checked;
  WorkTimeED.Visible:=WorkTimeCheck.Checked;
  WorkTimeCB.Visible:=WorkTimeCheck.Checked;
  ClearWorkTimeBtn.Visible:=WorkTimeCheck.Checked;
  CostDataPn.Visible:=CostCheck.Checked;
  PartED.Visible:=PartCheck.Checked;
  ClearPartBtn.Visible:=PartCheck.Checked;
  ProblemNoteED.Visible:=ProblemNoteCheck.Checked;
  ClearProblemNoteBtn.Visible:=ProblemNoteCheck.Checked;
  WorkNoteED.Visible:=WorkNoteCheck.Checked;
  ClearWorkNoteBtn.Visible:=WorkNoteCheck.Checked;
  SB.VertScrollBar.Range:=BottomBevel.Top+BottomBevel.Height;
  self.ChangeFilter(self);
end;

procedure TRepStatForRecForm.CalkSum;
var
  sql, filter, recflt, repflt,sntflt : string;
begin
  recflt:=self.GetRecordFilterString;
  repflt:=self.GetReportFilterString;
  sntflt:=self.GetCenterFilterString;
  filter:='';
  if Length(recflt)>0 then filter:=' AND '+recflt;
  if (Length(repflt)>0)or(Length(sntflt)>0) then begin
    filter:=filter+(' AND [REPORTID] IN (SELECT ID FROM [SERVREPORT] WHERE '+repflt);
    if Length(sntflt)=0 then filter:=filter+')' else begin
      if Length(repflt)>0 then filter:=filter+'AND ';
      filter:=filter+'[SENTERID] IN (SELECT ID FROM [SERVCENTRES] WHERE '+SNTFLT+'))';
    end;
  end;
  SumQuery.Close;
  SumQuery.SQL.Clear;
  sql:=stringreplace(SumSQL,'/FILTER/',filter,[rfReplaceAll]);
  //SHOWMESSAGE(SQL);
  SumQuery.SQL.Add(sql);
  SumQuery.Open;
end;

function  TRepStatForRecForm.GetReportFilterCaption : string;
var
  flt,str : string;
  i       : integer;
begin
  flt:='';
  //�� ����, ���� ���� ���������� � ������ (�������� ������ ��� ���� ������)
  if DateCB.ItemIndex<2 then begin
    case DateCB.ItemIndex of
      0 : str:='�������� ������';
      1 : str:='���� ������';
    end;
    flt:=str+' � '+QuotedStr(FormatDateTime('dd mmm yyyy',StDateTP.Date))+' �� '+QuotedStr(FormatDateTime('dd mmm yyyy',EndDateTP.Date));
  end;
  //�� �������
  if RegionSB.Checked then
    if length(flt)=0 then flt:='������ �� - '+RegionCB.Text else flt:=flt+', ������ �� - '+RegionCB.Text;
  //�� ��������� �������
  str:='';
  if (SenterCheck.Checked) then begin
    str:='';
    for i := 0 to SenterCB.Items.Count-1 do
      if SenterCB.Checked[i] then
        if length(str)=0 then str:='��������� ������: '+SenterCB.Items[i] else str:=str+', '+SenterCB.Items[i];
    if length(str)>0 then
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  result:=flt;
end;

function  TRepStatForRecForm.GetRecordFilterCaption : string;
var
  flt,str : string;
  i       : integer;
  pid     : ^integer;
  pstr    : ^string;
begin
  flt:='';
  //�� ����, ���� ���� ���������� � ������ (���� ������������, ���� �������, ���� ������ �������)
  if DateCB.ItemIndex>1 then begin
    case DateCB.ItemIndex of
      2 : str:='���� ������������';
      3 : str:='���� �������';
      4 : str:='���� ������ �������';
    end;
    flt:=str+' � '+QuotedStr(FormatDateTime('dd mmm yyyy',StDateTP.Date))+' �� '+QuotedStr(FormatDateTime('dd mmm yyyy',EndDateTP.Date));
  end;
  //��� �������
  if WorkTypeCheck.Checked then begin
    str:='��� ������� '+QuotedStr(WorkTypeCB.Text);
    if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  //���� ������
  if (WorkForClientCheck.Checked)and(WorkTypeCB.Visible)
    and(WorkTypeCB.ItemIndex=1)and(StrToIntDef(WorkForClientED.Text,0)>0 )then begin
      str:='���� ������ �� ������� '+WorkForClientEd.Text+' ����';
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  //�� ������ �������
  if (ClientDataCheck.Checked)and(WorkTypeCB.Visible)and(WorkTypeCB.ItemIndex=1) then begin
    if Length(ClientED.Text)>0 then begin
      str:='�� ����� ������� '+QuotedStr('%'+ClientED.Text+'%');
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
    end;
    if Length(AddrED.Text)>0 then begin
      str:='�� ������ ������� '+QuotedStr('%'+AddrED.Text+'%');
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
    end;
    if Length(TelED.Text)>0 then begin
      str:='�� �������� ������� '+QuotedStr('%'+TelED.Text+'%');
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
    end;
  end;
  //�� ���� ���������
  str:='';
  if (MainTypeCheck.Checked) then begin
    str:='';
    for i := 0 to MainTypeCB.Items.Count-1 do
      if MainTypeCB.Checked[i] then
        if length(str)=0 then str:='�� ���� �������� '+QuotedStr(MainTypeCB.Items[i])
          else str:=str+', '+QuotedStr(MainTypeCB.Items[i]);
    if length(str)>0 then
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  //�� ������
  str:='';
  if (ModelCB.Visible)and(ModelCheck.Checked)and(ModelCheck.Enabled) then begin
    str:='';
    for i := 0 to ModelCB.Items.Count-1 do
      if ModelCB.Checked[i] then begin
        pid:=pointer(ModelCB.Items.Objects[i]);
        if length(str)=0 then str:='�� ������ '+QuotedStr(ModelCB.Items[i]) else str:=str+', '+QuotedStr(ModelCB.Items[i]);
      end;
    if length(str)>0 then
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  //�� ��������� ������
  if (SNCheck.Checked)and(Length(SNED.Text)>0) then begin
    str:='�� ��������� ������ '+QuotedStr('%'+SNED.Text+'%');
    if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  //�� ����� �������
  if (WorkTimeCheck.Checked)and(StrToIntDef(WorkTimeED.Text,0)>0) then begin
    str:='�� ����� ������� '+WorkTimeCB.Text+WorkTimeED.Text+'���� ';
    if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  //�� ���������
  if (CostCheck.Checked)then begin
    if(strtointdef(PartCostMin.Text,0)>0) then begin
      str:='���� ������>'+PartCostMin.Text;
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
    end;
    if(strtointdef(PartCostMax.Text,0)>0) then begin
      str:='���� ������<='+PartCostMax.Text;
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
    end;
    if (strtointdef(MovCostMin.Text,0)>0) then begin
      str:='�� �����>'+MovCostMin.Text;
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
    end;
    if (strtointdef(MovCostMax.Text,0)>0) then begin
      str:='�� �����<='+MovCostMax.Text;
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
    end;
    if(strtointdef(WorkCostMin.Text,0)>0) then begin
      str:='�� ������>'+WorkCostMin.Text;
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
    end;
    if(strtointdef(WorkCostMax.Text,0)>0) then begin
      str:='�� ������<='+WorkCostMax.Text;
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
    end;
  end;
  //�� �������� ������
  if (PartCheck.Checked)and(Length(PartED.Text)>0) then begin
    str:='�� �������� ������ '+QuotedStr('%'+PartED.Text+'%');
    if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  //�� �������� ��������
  if (ProblemNoteCheck.Checked)and(Length(ProblemNoteED.Text)>0) then begin
    str:='(�� �������� �������� '+QuotedStr('%'+ProblemNoteED.Text+'%');
    if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  //�� �������� �����
  if (WorkNoteCheck.Checked)and(Length(WorkNoteED.Text)>0) then begin
    str:='�� �������� ����� '+QuotedStr('%'+WorkNoteED.Text+'%');
    if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  //�� ���� �������������
  str:='';
  if (WorkCodeCB.Visible)and(WorkCodeCheck.Checked)and(WorkCodeCheck.Enabled) then begin
    str:='';
    for i := 0 to WorkCodeCB.Items.Count-1 do
      if WorkCodeCB.Checked[i] then begin
        pstr:=pointer(WorkCodeCB.Items.Objects[i]);
        if length(str)=0 then str:='�� ���� ������������� '+QuotedStr(pstr^) else str:=str+', '+QuotedStr(pstr^);
      end;
    if length(str)>0 then
      if length(flt)=0 then flt:=str else flt:=flt+', '+str;
  end;
  result:=flt;
end;

//-------------------������� ��������� ----------------------------------------

procedure TRepStatForRecForm.GridDblClick(Sender: TObject);
begin
  if Grid.Enabled then EditRecord(MyQuery.FieldByName('ID').AsInteger,true);
end;

procedure TRepStatForRecForm.GetDateBtnClick(Sender: TObject);
var
  sd,ed : TDate;
begin
  sd:=StDateTP.Date;
  ed:=EndDateTP.Date;
  if DateForm.GetPeriod(sd,ed) then begin
    StDateTP.Date:=sd;
    EndDateTP.Date:=ed;
    self.ChangeFilter(self);
  end;
end;

procedure TRepStatForRecForm.ChangeFilter(Sender: TObject);
begin
  Grid.Font.Color:=clGray;
  Grid.Repaint;
  ResultPn.Enabled:=false;
  PrintBtn.Enabled:=false;
end;

procedure TRepStatForRecForm.ClearClientBtnClick(Sender: TObject);
begin
  if TSpeedButton(sender).Name='ClearClientBtn' then ClientED.Text:='';
  if TSpeedButton(sender).Name='ClearAddrBtn' then AddrED.Text:='';
  if TSpeedButton(sender).Name='ClearTelBtn' then TelED.Text:='';
  if TSpeedButton(sender).Name='ClearSNEDBTN' then SNED.Text:='';
  if TSpeedButton(sender).Name='ClearWorkTimeBtn' then WorkTimeED.Text:='';
  if TSpeedButton(sender).Name='ClearPartBtn' then PartED.Text:='';
  if TSpeedButton(sender).Name='ClearProblemNoteBtn' then ProblemNoteED.Text:='';
  if TSpeedButton(sender).Name='ClearWorkNoteBtn' then WorkNoteED.Text:='';
  self.ChangeFilter(self);
end;

procedure TRepStatForRecForm.CloseBtnClick(Sender: TObject);
begin
  self.Close;
end;

procedure TRepStatForRecForm.PrepareBtnClick(Sender: TObject);
var
  recflt,repflt,sntflt : string;
begin
  //
  recflt:=self.GetRecordFilterString;
  repflt:=self.GetReportFilterString;
  sntflt:=self.GetCenterFilterString;
  MyQuery.Close;
  MyQuery.SQL.Clear;
  MyQuery.SQL.Add('SELECT * FROM [SERVRECORDS] WHERE ([STATUS]=5)');
  if Length(recflt)>0 then MyQuery.SQL.Add(' AND '+recflt);
  if (Length(repflt)>0)or(Length(sntflt)>0) then begin
    MyQuery.SQL.Add(' AND [REPORTID] IN (SELECT ID FROM [SERVREPORT] WHERE '+repflt);
    if Length(sntflt)=0 then MyQuery.SQL.Add(')') else begin
      if length(repflt)>0 then MyQuery.SQL.Add('AND');
      MyQuery.SQL.Add('[SENTERID] IN (SELECT ID FROM [SERVCENTRES] WHERE '+SNTFLT+'))');
    end;
  end;
  //showmessage(MyQuery.SQL.Text);
  Grid.Font.Color:=clBlack;
  MyQuery.Open;
  Grid.Enabled:=not(MyQuery.IsEmpty);
  ResultPn.Visible:=not(MyQuery.IsEmpty);
  ResultPn.Enabled:=not(MyQuery.IsEmpty);
  if (MyQuery.IsEmpty)and(not FirstStart) then MessageDLG('������ �� ������ ������� �� ������� !'+chr(13)+
    '�������� ������� ������ � ��������� ������.',mtWarning,[mbOK],0);
  if FirstStart then FirstStart:=false;
  if not MyQuery.IsEmpty then begin
      self.CalkSum;
      PrintBtn.Enabled:=true;
      if ShowResultBtn.Tag=1 then self.ShowResultBtnClick(ShowResultBtn);
    end;
end;

procedure TRepStatForRecForm.PrintBtnClick(Sender: TObject);
var
  PrMod: TPrMod;
begin
  if FileExists(MyPath+'frxRecStatReport.fr3') then begin
    PrMod:=TPrMod.Create(application);
    PrMod.formcaption:=self.Caption;
    MyQuery.DisableControls;
    with PrMod do begin
      frxData1.DataSet:=self.MyQuery;
      frxData2.DataSet:=self.SumQuery;
      Report.OnGetValue:=self.ReportGetValue;
      Report.LoadFromFile(MyPath+'frxRecStatReport.fr3');
      Report.PrepareReport(true);
      Report.ShowPreparedReport;
    end;
    MyQuery.EnableControls;
  end;
end;

procedure TRepStatForRecForm.RegionCBChange(Sender: TObject);
begin
  if self.UpdateSenterCB=0 then begin
    SenterCheck.Checked:=false;
    SenterCheck.Enabled:=false;
    SenterCB.Visible:=false;
  end else SenterCheck.Enabled:=true;
  self.ChangeFilter(sender);
end;

procedure TRepStatForRecForm.RegionSBClick(Sender: TObject);
begin
  self.UpdateFilter(sender);
  self.RegionCBChange(sender);
end;

procedure TRepStatForRecForm.ReportGetValue(const VarName: string; var Value: Variant);
var
  str : string;
begin
  if comparetext(varname,'FILTER')=0 then begin
    //������������ ��������� � ������� � ������
    value:='';
    str:=self.GetReportFilterCaption;
    if length(str)>0 then value:='������ �� ��������:'+chr(13)+str+chr(13);
    str:=self.GetRecordFilterCaption;
    if length(str)>0 then value:=value+'������ �� ��������:'+chr(13)+str+chr(13);
  end;
end;

procedure TRepStatForRecForm.SetBtnClick(Sender: TObject);
begin
  MainPN.Visible:=SetBtn.Down;
end;

//-------------------- ���������� ������� --------------------------------------

function  TRepStatForRecForm.UpdateModelCB(mt : integer):integer;
var
  i : integer;
  pid : ^integer;
begin
  Dmod.ModelsTable.First;
  ModelCB.Clear;
  i:=0;
  while not Dmod.ModelsTable.Eof do begin
    if (Dmod.ModelsTable.FieldByName('MAINTYPE').AsInteger=mt)and
      (length(Dmod.ModelsTable.FieldByName('DESCR').AsString)>0)then begin
        ModelCB.Items.Add(Dmod.ModelsTable.FieldByName('DESCR').AsString);
        new(pid);
        pid^:=Dmod.ModelsTable.FieldByName('ID').AsInteger;
        ModelCB.Items.Objects[ModelCB.Items.Count-1]:=TObject(pid);
        inc(i);
      end;
    Dmod.ModelsTable.Next;
  end;
  result:=i;
end;

function  TRepStatForRecForm.UpdateSenterCB:integer;
var
  i : integer;
  pid : ^integer;
  Query : TADOQuery;
begin
  Query:=TADOQuery.Create(self);
  Query.Connection:=Dmod.Connection;
  Query.SQL.Add('SELECT * FROM SERVCENTRES');
  if RegionSB.Checked then begin
    pid:=pointer(RegionCB.Items.Objects[RegionCB.ItemIndex]);
    Query.SQL.Add('WHERE REGIONID='+inttostr(pid^));
  end;
  Query.Open;
  SenterCB.Clear;
  i:=0;
  while not Query.Eof do begin
    SenterCB.Items.Add(Query.FieldByName('DESCR').AsString);
    new(pid);
    pid^:=Query.FieldByName('ID').AsInteger;
    SenterCB.Items.Objects[SenterCB.Items.Count-1]:=TObject(pid);
    inc(i);
    Query.Next;
  end;
  Query.Free;
  result:=i;
end;

function  TRepStatForRecForm.UpdateCodeCB(mt : integer):integer;
var
  i : integer;
  pid : ^string;
  Query : TADOQuery;
begin
  Query:=TADOQuery.Create(self);
  Query.Connection:=Dmod.Connection;
  if mt>0 then Query.SQL.Add('SELECT * FROM SERVCODES WHERE ((MAINTYPE='+INTTOSTR(MT)+')OR(MAINTYPE=0))AND(ISFOLDER=0)')
    else Query.SQL.Add('SELECT * FROM SERVCODES WHERE (MAINTYPE=0) AND(ISFOLDER=0)');
  Query.Open;
  WorkCodeCB.Clear;
  i:=0;
  while not Query.Eof do begin
    WorkCodeCB.Items.Add(Query.FieldByName('CODE').AsString+' '+Query.FieldByName('DESCR').AsString);
    new(pid);
    pid^:=Query.FieldByName('CODE').AsString;
    WorkCodeCB.Items.Objects[WorkCodeCB.Items.Count-1]:=TObject(pid);
    inc(i);
    Query.Next;
  end;
  Query.Free;
  result:=i;
end;

//---------------------- ������� ����� -----------------------------------------

procedure TRepStatForRecForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PostMessage(application.MainForm.Handle,WM_CLOSECHILD,self.Tag,0);
  Action:=caFree;
end;

procedure TRepStatForRecForm.FormShow(Sender: TObject);
var
  pid : ^integer;
  f  : integer;
  fn : string;
  Col: TColumn;
begin
  SumSQL:=string(SumQuery.SQL.Text);
  //���������������� ��������� (��� ������ �������)
  RegionCB.Top:=round((RegionPN.Height-RegionCB.Height)/2)-3;
  WorkTypeCB.Top:=round((Panel4.Height-WorkTypeCB.Height)/2)-3;
  WorkForClientED.Top:=round((WorkForClientPn.Height-WorkForClientED.Height)/2)-3;
  SNEd.Top:=round((Panel5.Height-SNed.Height)/2)-3;
  ClearSNEDBTN.Top:=SNEd.Top;
  WorkTimeCB.Top:=round((Panel8.Height-WorkTimeCB.Height)/2)-3;
  WorkTimeED.Top:=WorkTimeCB.Top;
  ClearWorkTimeBtn.Top:=WorkTimeCB.Top;
  PartED.Top:=round((Panel9.Height-PartEd.Height)/2)-3;
  ClearPartBtn.Top:=PartED.Top;
  ProblemNoteED.Top:=round((Panel10.Height-ProblemNoteEd.Height)/2)-3;
  ClearProblemNoteBtn.Top:=ProblemNoteED.Top;
  WorkNoteED.Top:=round((Panel11.Height-WorkNoteEd.Height)/2)-3;
  ClearWorkNoteBtn.Top:=WorkNoteED.Top;
  //��������� ComboBox ������ �������
  RegionCB.Clear;
  RegionCB.Sorted:=false;
  DMOD.RegionTable.First;
  while not DMod.RegionTable.Eof do begin
    RegionCB.Items.Add(DMod.RegionTable.FieldByName('DESCR').AsString);
    new(pid);
    pid^:=DMod.RegionTable.FieldByName('ID').AsInteger;
    RegionCB.Items.Objects[RegionCB.Items.Count-1]:=TObject(pid);
    DMod.RegionTable.Next;
  end;
  RegionCB.Sorted:=true;
  if RegionCB.Items.Count>0 then RegionCB.ItemIndex:=0;
  //��������� ������ �����
  Dmod.MainTypesTable.First;
  ModelCB.Clear;
  while not Dmod.MainTypesTable.Eof do begin
    MainTypeCB.Items.Add(Dmod.MainTypesTable.FieldByName('DESCR').AsString);
    new(pid);
    pid^:=Dmod.MainTypesTable.FieldByName('ID').AsInteger;
    MainTypeCB.Items.Objects[MainTypeCB.Items.Count-1]:=TObject(pid);
    MainTypeCB.Checked[MainTypeCB.Items.Count-1]:=true;
    Dmod.MainTypesTable.Next;
  end;
  SetBtn.Down:=true;
  EndDateTP.Date:=incday(StartOfTheMonth(now),-1);
  StDateTP.Date:=StartOfTheMonth(IncMonth(now,-1));
  self.UpdateFilter(self);
  self.UpdateSenterCB;
  SB.VertScrollBar.Position:=0;
  FilterPn.Top:=0;
  FirstStart:=true;
  self.PrepareBtnClick(self);
  //��������� �������� �������� � ������ ��������
  for f := 0 to MYQuery.FieldCount - 1 do begin
    fn:=MyQuery.Fields[f].FieldName;
    //�������� ���� �� �������
    if (fn<>'MODELID')and(fn<>'EDITORID')and(fn<>'REPORTID')and(fn<>'ID')and(fn<>'SHIFTID')and
      (fn<>'MAINDATE')and(fn<>'FACTORYID')and(fn<>'WORKID')and(fn<>'GROUPID')and(fn<>'ERRORS')and
      (fn<>'ISADDPART')and(fn<>'MAINTYPEID')and(fn<>'STATUS')and(fn<>'ACCEPTDATE') then begin
        Col:=Grid.Columns.Add;
        Col.FieldName:=fn;
        if DMod.FieldsTable.Lookup('FIELD',fn,'DESCR')<>NULL then begin
          Col.Title.Caption:=DMod.FieldsTable.Lookup('FIELD',fn,'DESCR');
          Col.Width:=DMod.FieldsTable.Lookup('FIELD',fn,'DISPLEN');
        end;
        //��� ���� ����� �� �� ��� � ������� �����
       { if fn='STATUS' then begin
          Col.Title.Caption:='';
          Col.Width:=20;
        end;  }
       if fn='NOTE' then begin
          Col.Title.Caption:='����������';
          Col.Width:=350;
        end;
    end;
  end;
  ResultPnHeight:=ResultPn.Height;
  self.GetRecordFilterString;
end;

//--------------------- ����������� ������ ������ ------------------------------

procedure TRepStatForRecForm.ShowResultBtnClick(Sender: TObject);
var
  bmp : TBitMap;
begin
  bmp:=TBitMap.Create;
  if ShowResultBtn.Tag=0 then begin
    Dmod.ImageList.GetBitmap(55,bmp);
    ShowResultBtn.Glyph:=bmp;
    ShowResultBtn.Tag:=1;
    ResultPn.Height:=(TopResultPn.Height+2);
    ResultPn.Top:=ResultPn.Top+ResultPnHeight-(TopResultPn.Height+2);
  end else begin
    Dmod.ImageList.GetBitmap(56,bmp);
    ShowResultBtn.Glyph:=bmp;
    ShowResultBtn.Tag:=0;
    ResultPn.Height:=ResultPnHeight;
    ResultPn.Top:=ResultPn.Top-ResultPnHeight+(TopResultPn.Height+2);
  end;
  bmp.Free;
end;

procedure TRepStatForRecForm.TopResultPnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then begin
    screen.Cursor:=crDrag;
    (sender as TPanel).Tag:=1;
    ResPnMov.X:=x;
    ResPnMov.Y:=y;
  end;
end;

procedure TRepStatForRecForm.TopResultPnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (sender as TPanel).Tag=1 then begin
   ResultPn.Left:=ResultPn.Left+x-ResPnMov.X;
   ResultPn.Top:=ResultPn.Top+y-ResPnMov.Y;
  end;
end;

procedure TRepStatForRecForm.TopResultPnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  screen.Cursor:=crDefault;
  (sender as TPanel).Tag:=0;
end;

end.
