unit RecordDataWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Mask, DB, ADODB, Buttons, Menus, DateUtils;

type
  TRecordData = class(TForm)
    MainPn: TPanel;
    WorkTypeDBC: TDBComboBox;
    Query: TADOQuery;
    DS: TDataSource;
    DBEdit1: TDBEdit;
    DBMemo1: TDBMemo;
    DBEdit2: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    ModelNoteDBC: TDBComboBox;
    StaticText1: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    DBEdit4: TDBEdit;
    DBEdit9: TDBEdit;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    WORKTYPEIM: TImage;
    CLIENTIM: TImage;
    CLIENTADDRIM: TImage;
    CLIENTTELIM: TImage;
    MODELNOTEIM: TImage;
    SNIM: TImage;
    DETAILIM: TImage;
    PRICEIM: TImage;
    PROBLEMNOTEIM: TImage;
    WORKNOTEIM: TImage;
    WORKCODEIM: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    PostBtn: TBitBtn;
    CloseBtn: TBitBtn;
    Label12: TLabel;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    StaticText10: TStaticText;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DATEIM: TImage;
    Label13: TLabel;
    Label14: TLabel;
    HistoryED: TEdit;
    HISTORYIM: TImage;
    DBMemo4: TDBMemo;
    StatusPN: TPanel;
    StatusBtn: TSpeedButton;
    StatusLB: TLabel;
    LockImg: TImage;
    ShowHistoryBtn: TSpeedButton;
    JoinBtn: TSpeedButton;
    WorkCodeED: TDBEdit;
    SelCodeBtn: TSpeedButton;
    WorkCodeLB: TListBox;
    WorkCodeTxt: TEdit;
    SetMainTypeBtn: TSpeedButton;
    DBEdit3: TDBEdit;
    MTLB: TListBox;
    DBEdit6: TDBEdit;
    Label15: TLabel;
    function  Verify:boolean;
    procedure SetStatus;
    procedure StatusBtnClick(Sender: TObject);
    procedure PostBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure QueryAfterEdit(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  ChangeManualStatus(text:string):TModalResult;
    procedure ShowHistoryBtnClick(Sender: TObject);
    procedure JoinBtnClick(Sender: TObject);
    procedure ModelNoteDBCDropDown(Sender: TObject);
    procedure WorkCodeEDChange(Sender: TObject);
    procedure SelCodeBtnClick(Sender: TObject);
    procedure WorkCodeLBClick(Sender: TObject);
    procedure WorkCodeLBMouseLeave(Sender: TObject);
    procedure SetMainTypeBtnClick(Sender: TObject);
    procedure MTLBExit(Sender: TObject);
    procedure MTLBClick(Sender: TObject);
  private
    { Private declarations }
    CanModifyManualStatus : boolean;
  public
    { Public declarations }
  end;


procedure EditRecord(id:integer;const ReadOnly:boolean=false);

implementation

{$R *.dfm}

uses DataMod, PrintMod;

var
  Errors  : TRecordsError; //массив с описанием ошибок в данных

//Основная процедура подготовки окна
procedure EditRecord(id:integer;const ReadOnly:boolean=false);
var
  i   : integer;
  form: TRecordData;
  hnt : string;
begin
  form:=TRecordData.Create(application);
  with form do begin
    StatusPn.Visible:=not(ReadOnly);
    PostBtn.Visible:=not(ReadOnly);
    MainPn.Enabled:=not(ReadOnly);
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT *  FROM SERVRECORDS WHERE ID='+inttostr(id));
    Query.Open;
    HistoryED.Text:='';
    ShowHistoryBtn.Enabled:=false;
    hnt:=Query.FieldByName('ERRORS').AsString;
    i:=Query.FieldByName('STATUS').AsInteger;
    LockImg.Visible:=((Length(hnt)>0)and(i>=rcsManualVerified));
    LockImg.ShowHint:=LockImg.Visible;
    LockImg.Hint:=hnt;
    JoinBtn.Enabled:=(i<rcsManualVerified);
    JoinBtn.Down:=Query.FieldByName('ISADDPART').AsBoolean;
    //если статус установлен в ручную не проверяем запись
    if i<rcsManualVerified then form.Verify else form.SetStatus;
    //заполнение списка типов ремонта
    WorkTypeDBC.Items.Clear;
    for I := 1 to high(WorkTypes) do WorkTypeDBC.Items.Add(WorkTypes[i]);
    CanModifyManualStatus:=false;
    WorkCodeEDChange(form);
    ShowModal;
  end;
  form.free
end;

//если статус меньше чем "подтвержден в ручную" или "принят" реузльтат mrCancel
//если статус "подтвержден в ручную" или "принят" и провека/измненеие разрешены тогда mrYes
//если статус "подтвержден в ручную" или "принят" и провека/измненеие НЕ разрешены тогда mrNo
function TRecordData.ChangeManualStatus(text:string):TModalResult;
var
  st  : integer;
  msg : string;
begin
  msg:='';
  st:=Query.FieldByName('STATUS').AsInteger;
  if st=rcsManualVerified then msg:='Данные приняты в ручную.';
  if st=rcsAccept then msg:='Данные подтверждены.';
  if length(msg)>0 then begin
    msg:=msg+chr(13)+text;
    result:=MessageDlg(msg,mtConfirmation,[mbYes,mbNo],0);
  end else result:=mrCancel;
end;

//Проверка записи
procedure TRecordData.PostBtnClick(Sender: TObject);
begin
  case self.ChangeManualStatus('Все равно проверить ?') of
    mrCancel : self.Verify;
    mrYes :  begin
          CanModifyManualStatus:=true;
          if not Query.Modified then Query.Edit;
          Query.FieldByName('STATUS').AsInteger:=rcsNotVerified;
          Query.Post;
          CanModifyManualStatus:=false;
          self.Verify;
        end;
  end;
end;

//Исли статус "проверено в ручную" или "подтверждено" выводится запрос на разрешение изменений
procedure TRecordData.QueryAfterEdit(DataSet: TDataSet);
var
  mr   : TModalResult;
begin
  if CanModifyManualStatus then mr:=mrCancel else mr:=self.ChangeManualStatus('Все равно изменить ?');
  case mr of
    mrYes : begin
        //if not Query.Modified then Query.Edit;
        DataSet.FieldByName('STATUS').AsInteger:=rcsNotVerified;
        self.SetStatus;
        end;
    mrNo : begin
        query.Cancel;
        Abort;
        end;
  end;
end;

procedure TRecordData.CloseBtnClick(Sender: TObject);
begin
  self.Close;
end;

//Запись перед закрытием
procedure TRecordData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Query.Modified then Query.Post;
end;

//присоединение к предыдущему
procedure TRecordData.JoinBtnClick(Sender: TObject);
var
  Prev : TADOQuery;
begin
  if JoinBtn.Down then begin
    if MessageDLG('Привязка к предыдущей записи как дополнительная деталь.'+chr(13)+
      'Значения некоторых полей будет скопированно.'+chr(13)+'Вы уверены?',mtWarning,[mbYes,mbNo],0)=mrNo then begin
      JoinBtn.Down:=false;
      Abort;
    end;
    Prev:=TADOQuery.Create(self);
    Prev.Connection:=DMod.Connection;
    Prev.SQL.Add('SELECT * FROM SERVRECORDS WHERE REPORTID='+IntToStr(Query.FieldByName('REPORTID').AsInteger));
    Prev.Open;
    Prev.Locate('ID',Query.FieldByName('ID').AsInteger,[]);
    Prev.Prior;
    if not Query.Modified then Query.Edit;
    Query.FieldByName('WORKTYPE').AsString:='';
    Query.FieldByName('CLIENT').AsString:='';
    Query.FieldByName('CLIENTADDR').AsString:='';
    Query.FieldByName('CLIENTTEL').AsString:='';
    Query.FieldByName('SN').AsString:=Prev.FieldByName('SN').AsString;
    Query.FieldByName('MAINTYPEID').AsInteger:=Prev.FieldByName('MAINTYPEID').AsInteger;
    if not(Prev.FieldByName('BUYDATE').IsNull) then
      Query.FieldByName('BUYDATE').AsDateTime:=Prev.FieldByName('BUYDATE').AsDateTime
      else Query.FieldByName('BUYDATE').AsVariant:=NULL;
    Query.FieldByName('STARTDATE').AsDateTime:=Prev.FieldByName('STARTDATE').AsDateTime;
    Query.FieldByName('ENDDATE').AsDateTime:=Prev.FieldByName('ENDDATE').AsDateTime;
    Query.FieldByName('WORKPRICE').AsInteger:=0;
    Query.FieldByName('MOVPRICE').AsInteger:=0;
    if Length(Query.FieldByName('WORKCODE').AsString)=0 then
      Query.FieldByName('WORKCODE').AsString:=Prev.FieldByName('WORKCODE').AsString;
    if Length(Query.FieldByName('PROBLEMNOTE').AsString)=0 then
      Query.FieldByName('PROBLEMNOTE').AsString:=Prev.FieldByName('PROBLEMNOTE').AsString;
    Query.FieldByName('ISADDPART').AsBoolean:=true;
    Query.Post;
    Prev.Free;
    self.Verify;
  end else begin
    if MessageDLG('Отсоединение от предыдущей записи.'+chr(13)+
      'Серийный номер будет очищен.'+chr(13)+'Вы уверены?',mtWarning,[mbYes,mbNo],0)=mrNo then begin
      JoinBtn.Down:=true;
      Abort;
    end;
    if not Query.Modified then Query.Edit;
    Query.FieldByName('ISADDPART').AsBoolean:=FALSE;
    Query.FieldByName('SN').AsString:='';
    Query.Post;
    self.Verify;
  end;
end;

procedure TRecordData.ModelNoteDBCDropDown(Sender: TObject);
var
  Table : TADOQuery;
  mt    : integer;
begin
  ModelNoteDBC.Items.Clear;
  mt:=DMod.GetMainType(Query.FieldByName('SN').AsString);
  if mt>0 then begin
    Table:=TADOQuery.Create(self);
    Table.Connection:=DMod.Connection;
    Table.SQL.Add('SELECT * FROM PRODUCTIONMODELS WHERE MAINTYPE='+IntToStr(mt));
    Table.Open;
    while not Table.Eof do begin
      ModelNoteDBC.Items.Add(Table.FieldByName('DESCR').AsString);
      Table.Next;
    end;
    Table.Free;
  end;
end;

//проверка записи
function TRecordData.Verify:boolean;
var
  i      : integer;
  fld,im : string;
  img    : TImage;
begin
  HistoryED.Text:='единичный ремонт';
  ShowHistoryBtn.Enabled:=false;
  //проверка
  DMod.RecordsVerify(Errors,Query,'');
  //если есть ошибки первогу уровня рисунки статуса пустые
  //если проверка первого уровня пройдена рисунки в Оk
  for I := 0 to self.ComponentCount-1 do
    if (self.Components[i] is TImage)and(self.Components[i].Name<>'LockImg') then begin
      img:=(self.Components[i] as TImage);
      Img.Picture:=nil;
      case Query.FieldByName('STATUS').AsInteger of
        rcsSpellingErrors : DMod.ImageList.GetBitmap(49,img.Picture.Bitmap);
        rcsDataErrors,rcsAutoVerified : DMod.ImageList.GetBitmap(51,img.Picture.Bitmap);
      end;
      img.ShowHint:=false;
      img.Hint:='';
    end;
  //рисунки статуса ошибочных полей в соответствующее состояние
  for I := 0 to high(Errors) do begin
    fld:=Errors[i].Field;
    if (fld='PARTS')or(fld='PARTQTY')or(fld='PARTDOC') then im:='DETAILIM'
      else if (fld='PARTCOST')or(fld='MOVPRICE')or(fld='WORKPRICE') then im:='PRICEIM'
        else if (fld='BUYDATE')or(fld='STARTDATE')or(fld='ENDDATE') then im:='DATEIM'
          else im:=fld+'IM';
    if self.FindComponent(im)<>nil then begin
      img:=(self.FindComponent(im) as TImage);
      Img.Picture:=nil;
      case Errors[i].errtype of
        rcsNotVerified    : DMod.ImageList.GetBitmap(49,img.Picture.Bitmap);
        rcsSpellingErrors : DMod.ImageList.GetBitmap(26,img.Picture.Bitmap);
        rcsDataErrors     : DMod.ImageList.GetBitmap(50,img.Picture.Bitmap);
      end;
      //в подсказку тип ошибки
      if Length(img.Hint)>0 then img.Hint:=img.Hint+chr(13);
      img.Hint:=img.Hint+Errors[i].code;
      img.ShowHint:=true;
    end;
    if fld='HISTORY' then begin
      HistoryED.Text:='многократный ремонт';
      ShowHistoryBtn.Enabled:=true;
    end;
  end;
  self.SetStatus;
  result:=(high(Errors)<0);
end;

//установка параметров панели статуса
procedure  TRecordData.SetStatus;
var
  i   : integer;
  bmp : TbitMap;
  hnt : string;
begin
  bmp:=TBitMap.Create;
  i:=Query.FieldByName('STATUS').AsInteger;
  hnt:=Query.FieldByName('ERRORS').AsString;
  LockImg.Visible:=((Length(hnt)>0)and(i>=rcsManualVerified));
  LockImg.ShowHint:=LockImg.Visible;
  LockImg.Hint:=hnt;
  JoinBtn.Enabled:=(i<rcsManualVerified);
  if Query.FieldByName('MAINTYPEID').AsInteger=0 then begin
      DMod.ImageList.GetBitmap(21,bmp);
      SetMainTypeBtn.Hint:='Задать тип продукции в ручную';
      SNIM.Stretch:=true;
    end else begin
      DMod.ImageList.GetBitmap(5,bmp);
      SetMainTypeBtn.Hint:='Сбросить тип продукции и перепроверить';
      SNIM.Stretch:=false;
    end;
  SetMainTypeBtn.Glyph:=bmp;
  bmp.Assign(nil);
  case i of
    rcsNotVerified : begin
        StatusPN.Color:=clError;
        StatusLB.Caption:='Запись не проверена !';
        StatusBtn.Visible:=false;
      end;
    rcsSpellingErrors : begin
        StatusPN.Color:=clError;
        StatusLB.Caption:='Ошибка записи значений !';
        StatusBtn.Visible:=false;
      end;
    rcsDataErrors                    : begin
        StatusPN.Color:=clWarning;
        StatusLB.Caption:='Данные нужнаются в дополинтельной проверке !';
        StatusBtn.Visible:=true;
        StatusBtn.Hint:='Изменить статус на "Принятов в ручную"';
        DMod.ImageList.GetBitmap(51,bmp);
        StatusBtn.Glyph:=bmp;
        StatusBtn.Caption:='принять';
      end;
    rcsAutoVerified, rcsManualVerified : begin
        StatusPN.Color:=clNOTERROR;
        StatusLB.Caption:='Данные нужнаются в подтверждении !';
        StatusBtn.Visible:=true;
        StatusBtn.Hint:='Изменить статус на "Подтверждено"';
        DMod.ImageList.GetBitmap(27,bmp);
        StatusBtn.Glyph:=bmp;
        StatusBtn.Caption:='подтвердить';
      end;
    rcsAccept : begin
        StatusPN.Color:=clWhite;
        StatusLB.Caption:='Данные подтверждены !';
        StatusBtn.Visible:=true;
        StatusBtn.Hint:='Изменить статус на "Не проверено"';
        DMod.ImageList.GetBitmap(49,bmp);
        StatusBtn.Glyph:=bmp;
        StatusBtn.Caption:='сбросить';
      end;
  end;
  bmp.Free;
  if Query.FieldByName('ISADDPART').AsBoolean then Caption:='Деталь от предыдушего ремонта' else begin
    Caption:='Тип продукции не определен';
    i:=Query.FieldByName('MAINTYPEID').AsInteger;
    if (I>0)and(DMod.MainTypesTable.Lookup('ID',i,'DESCR')<>NULL) then
      Caption:=DMod.MainTypesTable.Lookup('ID',i,'DESCR');
  end;
end;

procedure TRecordData.ShowHistoryBtnClick(Sender: TObject);
var
  strs : TStringList;
begin
  self.Hide;
  Strs:=TStringList.Create;
  Strs.Add(Query.FieldByName('FACTORYID').AsString+'='+Query.FieldByName('SN').AsString);
  PrintSNHistoryReport(strs);
  strs.Free;
  self.Close;
end;

//Кнопка на панели статуса
procedure TRecordData.StatusBtnClick(Sender: TObject);
var
  st : integer;
begin
    st:=Query.FieldByName('STATUS').AsInteger;
    CanModifyManualStatus:=(st>=rcsManualVerified);
    if not Query.Modified then Query.Edit;
    CanModifyManualStatus:=false;
    case st of
      //если ошибки в данных кнопка включена - ошибки можно принятть в ручную
      rcsDataErrors : begin
                      Query.FieldByName('STATUS').AsInteger:=rcsManualVerified;
                      self.SetStatus;
                      end;
      //если ошибок нет или они приняты в ручную запись можно подтвердить
      rcsAutoVerified,rcsManualVerified : begin
                                          Query.FieldByName('STATUS').AsInteger:=rcsAccept;
                                          //записываем дату подтверждения
                                          if Query.FieldByName('ACCEPTDATE').IsNull then
                                            Query.FieldByName('ACCEPTDATE').AsDateTime:=now;
                                          self.SetStatus;
                                          end;
      //если запись подтверждеа можно вренуть ее в состояние "не проверено"
      //если фатальная ошибка сбрасываем тип
      rcsSpellingErrors,rcsAccept : begin
                  Query.FieldByName('STATUS').AsInteger:=rcsNotVerified;
                  Query.FieldByName('MAINTYPEID').AsInteger:=0;
                  if (MonthOf(now)=MonthOf(Query.FieldByName('ACCEPTDATE').AsDateTime))and
                    (YearOf(now)=YearOf(Query.FieldByName('ACCEPTDATE').AsDateTime))then
                       Query.FieldByName('ACCEPTDATE').AsVariant:=NULL;
                  self.Verify;
                  end;
    end;
    if Query.Modified then Query.Post;
end;

//---------------- списко выбора кодов неисправности----------------------------

procedure TRecordData.WorkCodeEDChange(Sender: TObject);
var
  Table : TADOQuery;
  mt    : integer;
begin
  Table:=TADOQuery.Create(self);
  Table.Connection:=DMod.Connection;
  mt:=Query.FieldByName('MAINTYPEID').AsInteger;
  Table.SQL.Add('SELECT DESCR FROM SERVCODES WHERE CODE='+QuotedStr(workcodeed.Text)+
    ' AND (MAINTYPE='+IntToStr(mt)+' OR MAINTYPE=0)');
  Table.Open;
  if Table.Eof then WorkCodeTxt.Text:='' else WorkCodeTxt.Text:=Table.FieldByName('DESCR').AsString;
  Table.Free;
end;

procedure TRecordData.WorkCodeLBClick(Sender: TObject);
var
  pid : ^integer;
  Table : TADOQuery;
begin
  WorkCodeLB.Visible:=false;
  SelCodeBtn.Down:=false;
  pid:=pointer(WorkCodeLB.Items.Objects[WorkCodeLB.ItemIndex]);
  if pid<>nil then begin
    Table:=TADOQuery.Create(self);
    Table.Connection:=DMod.Connection;
    Table.SQL.Add('SELECT CODE FROM SERVCODES WHERE ID='+IntToStr(pid^));
    Table.Open;
    if not Query.Modified then Query.Edit;
    Query.FieldByName('WORKCODE').AsString:=Table.FieldByName('CODE').AsString;
    Table.Free;
  end;
end;

procedure TRecordData.WorkCodeLBMouseLeave(Sender: TObject);
begin
  WorkCodeLB.Visible:=false;
  SelCodeBtn.Down:=false;
end;

procedure TRecordData.SelCodeBtnClick(Sender: TObject);
var
  Table : TADOQuery;
  mt    : integer;
  pid : ^integer;
begin
  if  SelCodeBtn.Down then begin
    //заполнение списка кодов
    WorkCodeLB.Items.Clear;
    WorkCodeLB.Sorted:=FALSE;
    mt:=Query.FieldByName('MAINTYPEID').AsInteger;
    if mt>0 then begin
      Table:=TADOQuery.Create(self);
      Table.Connection:=DMod.Connection;
      Table.SQL.Add('SELECT * FROM SERVCODES WHERE ISFOLDER=0 AND (MAINTYPE='+IntToStr(mt)
        +' OR MAINTYPE=0)');
      Table.Open;
      if not Table.IsEmpty then begin
        WorkCodeLB.Items.Clear;
        while not Table.EOF do begin
          WorkCodeLB.Items.Add(Table.FieldByName('CODE').AsString+'  '+Table.FieldByName('DESCR').AsString);
          new(pid);
          pid^:=Table.FieldByName('ID').AsInteger;
          WorkCodeLB.Items.Objects[WorkCodeLB.Count-1]:=TObject(pid);
          Table.Next;
        end;
      end;
      Table.Free;
    end;
    if WorkCodeLB.Count>0 then begin
      WorkCodeLB.Visible:=true;
      WorkCodeLB.Height:=MainPn.ClientHeight-SelCodeBtn.Top-SelCodeBtn.Height-5;;
    end else begin
      MessageDLG('Таблица кодов неисправностей пуста !',mtError,[mbOk],0);
      SelCodeBtn.Down:=false;
    end;
    WorkCodeLB.Sorted:=TRUE;
    self.ActiveControl:=WorkCodeLB;
  end else WorkCodeLB.Visible:=false;
end;

//----------------------- список выбора типа продукции -------------------------

procedure TRecordData.SetMainTypeBtnClick(Sender: TObject);
var
  pid : ^integer;
begin
  if Query.FieldByName('MAINTYPEID').AsInteger>0 then begin
    if not Query.Modified then Query.Edit;
    Query.FieldByName('MAINTYPEID').AsInteger:=0;
    SetMainTypeBtn.Down:=false;
    self.Verify;
  end else if SetMainTypeBtn.Down then begin
    //заполнение списка кодов
    MTLB.Items.Clear;
    MTLB.Sorted:=FALSE;
    Dmod.MainTypesTable.First;
    if not Dmod.MainTypesTable.IsEmpty then
      while not Dmod.MainTypesTable.EOF do begin
        MTLB.Items.Add(Dmod.MainTypesTable.FieldByName('DESCR').AsString);
        new(pid);
        pid^:=Dmod.MainTypesTable.FieldByName('ID').AsInteger;
        MTLB.Items.Objects[MTLB.Count-1]:=TObject(pid);
        Dmod.MainTypesTable.Next;
        end;
    if MTLB.Count>0 then begin
      MTLB.Visible:=true;
      MTLB.Height:=MainPn.ClientHeight-SetMainTypeBtn.Top-SetMainTypeBtn.Height-5;;
    end else begin
      MessageDLG('Таблица типов пуста !',mtError,[mbOk],0);
      SetMainTypeBtn.Down:=false;
    end;
    MTLB.Sorted:=TRUE;
    self.ActiveControl:=MTLB;
  end else MTLB.Visible:=false;
end;

procedure TRecordData.MTLBClick(Sender: TObject);
var
  pid : ^integer;
  val : variant;
begin
  MTLB.Visible:=false;
  SetMainTypeBtn.Down:=false;
  pid:=pointer(MTLB.Items.Objects[MTLB.ItemIndex]);
  if pid<>nil then begin
    val:=DMod.MainTypesTable.Lookup('ID',pid^,'ID');
    if val<>null then begin
      if not Query.Modified then Query.Edit;
      Query.FieldByName('MAINTYPEID').AsInteger:=VAL;
      self.Verify;
    end;
  end;
end;

procedure TRecordData.MTLBExit(Sender: TObject);
begin
  MTLB.Visible:=false;
  SetMainTypeBtn.Down:=false;
end;

end.
