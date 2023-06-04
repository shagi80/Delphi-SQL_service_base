unit ReportDataWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, Buttons, StdCtrls, ComCtrls, Mask, DBCtrls,
  ActnList, ImportWin, Gauges, Grids, DBGrids, ToolWin, DateUtils,
  DataMod, CustomizeDlg, Menus, dbf;

type
  TReportData = class(TForm)
    TopPn: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    NumberDBED: TDBEdit;
    Label3: TLabel;
    DocDatePic: TDateTimePicker;
    Label5: TLabel;
    MonthED: TEdit;
    MonthBtn: TSpeedButton;
    Label4: TLabel;
    CenterBtn: TSpeedButton;
    Label6: TLabel;
    MainQuery: TADOQuery;
    MainDS: TDataSource;
    SenterIsDelImg: TImage;
    CenterDB: TEdit;
    CityDB: TEdit;
    ImportFrame: TImportFrame;
    MainPn: TPanel;
    RecordsTableTB: TToolBar;
    ShowFrameBtn: TToolButton;
    ToolButton2: TToolButton;
    DBNav: TDBNavigator;
    Grid: TDBGrid;
    Label7: TLabel;
    PB: TGauge;
    Records: TADOQuery;
    RecordsDS: TDataSource;
    ColorBtn: TToolButton;
    ToolButton1: TToolButton;
    BottomPn: TPanel;
    OKbtn: TBitBtn;
    StaticText1: TStaticText;
    SumSetLB: TStaticText;
    StaticText3: TStaticText;
    DSumLB: TStaticText;
    StaticText5: TStaticText;
    MSumLB: TStaticText;
    StaticText7: TStaticText;
    WSumLB: TStaticText;
    StaticText4: TStaticText;
    TSumLB: TStaticText;
    ToolButton4: TToolButton;
    StaticText2: TStaticText;
    PSumLB: TStaticText;
    InvoiceDBE: TDBEdit;
    Label8: TLabel;
    ShowOnlyFaultsBtn: TToolButton;
    PrintBtn: TToolButton;
    StaticText6: TStaticText;
    RowCntLB: TStaticText;
    ReportAction: TActionList;
    ReportPrint: TAction;
    AcceptAll: TAction;
    VerifyAll: TAction;
    NotVerifyAll: TAction;
    VerifyReport: TAction;
    DBMemo1: TDBMemo;
    Label9: TLabel;
    Label10: TLabel;
    InvoiceDT: TDBEdit;
    InvoiceClearBtn: TSpeedButton;
    Label11: TLabel;
    FirstInvoiceDBE: TDBEdit;
    PaidCheck: TDBCheckBox;
    RecordedCheck: TDBCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    FirstInvoiceDT: TDBEdit;
    FirstInvoiceClearBtn: TSpeedButton;
    OnlyReadLB: TLabel;
    InformationBtn: TSpeedButton;
    Label14: TLabel;
    DBEdit1: TDBEdit;
    DocMailDateClearBtn: TSpeedButton;
    LoadFromRRPFile: TAction;
    ToolButton3: TToolButton;
    OpenDlg: TOpenDialog;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DocDatePicKeyPress(Sender: TObject; var Key: Char);
    procedure DocDatePicCloseUp(Sender: TObject);
    procedure MonthBtnClick(Sender: TObject);
    function  PostMainQuery:boolean;
    procedure CenterBtnClick(Sender: TObject);
    procedure ImportFrameCloseBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ShowFrameBtnClick(Sender: TObject);
    procedure OKbtnClick(Sender: TObject);
    procedure HideFrame;
    procedure ImportFrameOKBtnClick(Sender: TObject);
    procedure ExeckRecordsSQL(const onlyfaults : boolean=false);
    procedure ImportFormText(mode:integer);
    procedure RecordsBeforePost(DataSet: TDataSet);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridDblClick(Sender: TObject);
    procedure VerifyRecords;
    procedure ColorBtnClick(Sender: TObject);
    procedure SetReportStatus;
    procedure SumSetLBMouseLeave(Sender: TObject);
    procedure SumSetLBMouseEnter(Sender: TObject);
    procedure SumSetLBClick(Sender: TObject);
    procedure ChangeStatus(stat : word);
    procedure RecordsAfterDelete(DataSet: TDataSet);
    procedure ShowOnlyFaultsBtnClick(Sender: TObject);
    procedure ReportPrintExecute(Sender: TObject);
    procedure AcceptAllExecute(Sender: TObject);
    procedure VerifyAllExecute(Sender: TObject);
    procedure NotVerifyAllExecute(Sender: TObject);
    procedure VerifyReportExecute(Sender: TObject);
    procedure InvoiceClearBtnClick(Sender: TObject);
    procedure FirstInvoiceClearBtnClick(Sender: TObject);
    procedure PaidCheckClick(Sender: TObject);
    procedure RecordedCheckClick(Sender: TObject);
    procedure InformationBtnClick(Sender: TObject);
    procedure DocMailDateClearBtnClick(Sender: TObject);
    procedure loadFromFile(fname: string);
    procedure LoadFromRRPFileExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ItemID    : integer;
    Errors    : TRecordsError;
    SumAccept : boolean;
    SenterInfo: string;
  end;


procedure ShowReportData(ID,img : integer);

implementation

{$R *.dfm}

uses MonthWin,SelectSenterWin,ImportStateWin, RecordDataWin, GIFUnit, PrintMod;

const
  NotMonth='месяц не задан';

//подготовка формы
procedure ShowReportData(ID,img : integer);
var
  form  : TReportData;
  query : TADOQuery;
begin
  form:= TReportData.Create(application);
  application.ProcessMessages;
  form.Tag:=Dmod.NewWimID;
  form.ItemID:=ID;
  with Form do begin
    MainQuery.SQL.Clear;
    MainQuery.SQL.Add('SELECT * FROM SERVREPORT WHERE ID='+IntToStr(ID));
    MainQuery.Open;
    if ID=0 then begin
      MainQuery.Append;
      //инициализация некоторых элементов закголовка
      DocDatePic.Date:=now;
      MonthED.Text:=NotMonth;
      InformationBtn.Visible:=false;
      Caption:='Новый отчет '+IntToStr(tag);
      DMod.ImageList.GetBitmap(27,SenterIsDelImg.Picture.Bitmap);
    end else begin
      MonthED.Text:=FormatDateTime('mmmm yyyy',MainQuery.FieldByName('REPDATE').AsDateTime);
      DocDatePic.Date:=MainQuery.FieldByName('DOCDATE').AsDateTime;
      Caption:='Отчет №'+MainQuery.FieldByName('NUMBER').AsString+' от '+FormatDateTime('dd.mm.yy',DocDatePic.Date);
      //данные об СЦ
      query:=tadoquery.Create(form);
      query.Connection:=dmod.Connection;
      query.SQL.Add('SELECT DESCR,CITY,ISDEL,CONDITIONS FROM SERVCENTRES WHERE ID='+QuotedStr(MainQuery.FieldByName('SENTERID').AsString));
      Query.Active:=true;
      InformationBtn.Visible:=(length(Query.FieldByName('CONDITIONS').AsString)>0);
      if InformationBtn.Visible then SenterInfo:=Query.FieldByName('CONDITIONS').AsString;
      CenterDB.Text:=Query.FieldByName('DESCR').AsString;
      CityDB.Text:=Query.FieldByName('CITY').AsString;
      if query.FieldByName('ISDEL').AsBoolean then DMod.ImageList.GetBitmap(26,SenterIsDelImg.Picture.Bitmap)
        else DMod.ImageList.GetBitmap(27,SenterIsDelImg.Picture.Bitmap);
      query.Free;
    end;
    //выключаем контролы если пользователь не редактор
    toppn.Enabled:=(EditorStatus<=1);
    RecordsTableTB.Visible:=(EditorStatus<=1);
    OnlyReadLB.Visible:=not(EditorStatus<=1);
    ImportFrame.PrepareFrame;
    ExeckRecordsSQL;
    SumAccept:=SumOnlyAccept;
    SetReportStatus;
  end;
  PostMessage(application.MainForm.Handle,WM_CREATECHILD,form.Tag,img);
end;
//сообщение родителю о создании окна
procedure TReportData.FormActivate(Sender: TObject);
begin
  ImportFrame.UpdatePasteBtn;
end;
//проверка записи заголовка и закрытие окна, сообщение родителю
procedure TReportData.FormClose(Sender: TObject; var Action: TCloseAction);
var
  cl : boolean;
begin
  cl:=false;
  if EditorStatus<=1 then begin
    if  Records.Modified then Records.Post;
    if (self.ItemID=0)and(Records.IsEmpty) then begin
      case MessageDlg('Записать новый пустой отчет ?',mtWarning,[mbYes,mbNo,mbCancel],0) of
        mrYes : cl:=self.PostMainQuery;
        mrNo  : cl:=true;
        mrCancel : cl:=false;
      end;
    end else cl:=self.PostMainQuery;
  end else cl:=true;
  if cl then begin
    PostMessage(application.MainForm.Handle,WM_CLOSECHILD,self.Tag,0);
    Action:=caFree;
  end else Action:=caNone;
end;
//изменение размер фрейма импорта
procedure TReportData.FormResize(Sender: TObject);
begin
  ImportFrame.Width:=round(self.ClientWidth*0.95);
  ImportFrame.Height:=round(self.ClientHeight*0.95);
  ImportFrame.Left:=round((self.ClientWidth-ImportFrame.Width)/2);
  ImportFrame.Top:=round((self.ClientHeight-ImportFrame.Height)/2*0.9);
end;

procedure TReportData.OKbtnClick(Sender: TObject);
begin
  self.Close;
end;

//---------------------- РАБОТА С ТАБЛИЦЕЙ -------------------------------------

procedure TReportData.ExeckRecordsSQL(const onlyfaults : boolean=false);
var
  f     : integer;
  fn    : string;
  col   : TColumn;
begin
    Records.SQL.Clear;
    Records.SQL.Add('SELECT * FROM SERVRECORDS WHERE (REPORTID='+IntToStr(ItemID)+')');
    if onlyfaults then Records.SQL.Add('AND (STATUS<3)');
    Records.Open;
    //Установка названий столбцов и ширины стрлбцов
    Grid.Columns.Clear;
    for f := 0 to Records.FieldCount - 1 do begin
      fn:=Records.Fields[f].FieldName;
      //службные поля не выводим
      if (fn<>'MODELID')and(fn<>'EDITORID')and(fn<>'REPORTID')and(fn<>'ID')and(fn<>'SHIFTID')and
        (fn<>'MAINDATE')and(fn<>'FACTORYID')and(fn<>'WORKID')and(fn<>'GROUPID')and(fn<>'ERRORS')and
        (fn<>'ISADDPART')and(fn<>'MAINTYPEID') then begin
        Col:=Grid.Columns.Add;
        Col.FieldName:=fn;
        if DMod.FieldsTable.Lookup('FIELD',fn,'DESCR')<>NULL then begin
          Col.Title.Caption:=DMod.FieldsTable.Lookup('FIELD',fn,'DESCR');
          Col.Width:=DMod.FieldsTable.Lookup('FIELD',fn,'DISPLEN');
        end;
        //эти поля видны но их нет в таблице полей
        if fn='STATUS' then begin
          Col.Title.Caption:='';
          Col.Width:=20;
        end;
        if fn='NOTE' then begin
          Col.Title.Caption:='Примечание';
          Col.Width:=350;
        end;
      end;
    end;
end;

procedure TReportData.RecordsAfterDelete(DataSet: TDataSet);
begin
  self.SetReportStatus;
end;

procedure TReportData.RecordsBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('REPORTID').AsVariant=NULL then DataSet.FieldByName('REPORTID').AsInteger:=ItemID;
  if DataSet.FieldByName('STATUS').AsVariant=NULL then DataSet.FieldByName('STATUS').AsInteger:=rcsNotVerified;
end;

procedure TReportData.VerifyAllExecute(Sender: TObject);
begin
  self.ChangeStatus(rcsManualVerified);
end;

procedure TReportData.VerifyRecords;
var
  id : integer;
begin
  if not Records.IsEmpty then begin
    if Records.Modified then Records.Post;
    id:=Records.FieldByName('ID').AsInteger;
    Records.DisableControls;
    DMOD.RecordsVerify(Errors,Records,'Провека отчета. '+self.Caption);
    Records.Locate('ID',ID,[]);
    Records.EnableControls;
  end;
end;

procedure TReportData.VerifyReportExecute(Sender: TObject);
begin
  self.VerifyRecords;
end;

procedure TReportData.ColorBtnClick(Sender: TObject);
begin
  Grid.Repaint;
end;

procedure TReportData.GridDblClick(Sender: TObject);
var
  ReadOnly : boolean;
begin
  //ReadOnly:=((EditorStatus>1)or((Records.FieldByName('STATUS').AsInteger=5)and(EditorStatus<>0)));
  ReadOnly:=(EditorStatus>1);
  if not Records.IsEmpty then EditRecord(Records.FieldByName('ID').AsInteger,ReadOnly);
  Records.Refresh;
  self.SetReportStatus;
end;

procedure TReportData.SetReportStatus;
var
  st    : integer;
  Query : TADOQuery;
begin
  Query:=TADOQuery.Create(self);
  Query.Connection:=dmod.Connection;
  //считаем количество ремонтов
  Query.SQL.Add('DECLARE @CNT MONEY');
  Query.SQL.Add('SELECT @CNT=COUNT(T1.STATUS) FROM SERVRECORDS AS T1 WHERE T1.[REPORTID]='+IntToStr(itemID)+' AND ISADDPART=0');
  Query.SQL.Add('SELECT COUNT(T1.STATUS) AS ACCEPTCNT, @CNT AS TOTCNT FROM SERVRECORDS AS T1 WHERE T1.[STATUS]='+IntToStr(rcsAccept)+
    ' AND T1.[REPORTID]='+IntToStr(itemID)+' AND ISADDPART=0');
  Query.Open;
  if SumAccept then RowCntLB.Caption:=Query.FieldByName('ACCEPTCNT').AsString
    else RowCntLB.Caption:=Query.FieldByName('TOTCNT').AsString;
  Query.Close;
  //расчет статуса (также как и количество ремонтов но учитываем и дополенительные детали)
  Query.SQL.Clear;
  Query.SQL.Add('DECLARE @CNT MONEY');
  Query.SQL.Add('SELECT @CNT=COUNT(T1.STATUS) FROM SERVRECORDS AS T1 WHERE T1.[REPORTID]='+IntToStr(itemID));
  Query.SQL.Add('SELECT COUNT(T1.STATUS) AS ACCEPTCNT, @CNT AS TOTCNT FROM SERVRECORDS AS T1 WHERE T1.[STATUS]='+IntToStr(rcsAccept)+
    ' AND T1.[REPORTID]='+IntToStr(itemID));
  Query.Open;
  st:=Query.FieldByName('TOTCNT').AsInteger;
  if st>0 then st:=round(Query.FieldByName('ACCEPTCNT').AsInteger/st*100);
  //расчет сумм
  Query.SQL.Clear;
  Query.SQL.Add('SELECT SUM(T1.WORKPRICE) AS TOTWORK, SUM(T1.MOVPRICE) AS TOTMOV, SUM(T1.PARTCOST) AS TOTPART,'+
    ' SUM(T1.PARTQTY) AS PARTSQTY FROM SERVRECORDS AS T1 WHERE (T1.[REPORTID]='+IntToStr(itemID)+')');
  if SumAccept then Query.SQL.Add('AND (T1.[STATUS]='+IntToStr(rcsAccept)+')');
  Query.Open;
  if not MainQuery.Modified then MainQuery.Edit;
  MainQuery.FieldByName('VERIFYST').AsInteger:=st;
  PB.Progress:=st;
  DSumLB.Caption:=FormatFloat('####0.0##',Query.FieldByName('TOTPART').AsFloat);
  MSumLB.Caption:=FormatFloat('####0.0##',Query.FieldByName('TOTMOV').AsFloat);
  WSumLB.Caption:=FormatFloat('####0.0##',Query.FieldByName('TOTWORK').AsFloat);
  TSumLB.Caption:=FormatFloat('####0.0##',Query.FieldByName('TOTPART').AsFloat+
    Query.FieldByName('TOTMOV').AsFloat+Query.FieldByName('TOTWORK').AsFloat);
  PSumLB.Caption:=FormatFloat('####0',Query.FieldByName('PARTSQTY').AsFloat);
  Query.Free;
end;

procedure TReportData.ChangeStatus(stat: Word);
var
  id,st :integer;
  PForm : TProgressForm;
begin
  // Показ формы прогресса выполнения
  PForm:=TProgressForm.Create(application.MainForm);
  if (Records.RecordCount>10) then begin
    PForm.PB.Progress:=0;
    PForm.PB.MaxValue:=Records.RecordCount;
    PForm.ProcName.Caption:='Подтверждение записей. '+self.Caption;
    PForm.Show;
    application.ProcessMessages;
  end;
  //
  id:=Records.FieldByName('ID').AsInteger;
  records.DisableControls;
  with Records do begin
    first;
    while not EoF do begin
      st:=FieldByName('STATUS').AsInteger;
      if not Modified then Edit;
      case Stat of
        rcsAccept : if st>=rcsAutoVerified then begin
                      FieldByName('STATUS').AsInteger:=rcsAccept;
                      //записываем дату подтверждения
                      if FieldByName('ACCEPTDATE').IsNull then FieldByName('ACCEPTDATE').AsDateTime:=now;
                    end;
        rcsManualVerified : if st=rcsDataErrors then FieldByName('STATUS').AsInteger:=rcsManualVerified;
        rcsNotVerified : FieldByName('STATUS').AsInteger:=rcsNotVerified;
      end;
      Post;
      if PForm.Showing then begin
        PForm.PB.Progress:=PForm.PB.Progress+1;
        application.ProcessMessages;
        if (PForm.StopProcess) then Break;
      end;
      next;
    end;
  end;
  PForm.Free;
  Records.EnableControls;
  Records.Locate('ID',id,[]);
  self.SetReportStatus;
end;

procedure TReportData.AcceptAllExecute(Sender: TObject);
begin
  self.ChangeStatus(rcsAccept);
end;

procedure TReportData.NotVerifyAllExecute(Sender: TObject);
begin
  self.ChangeStatus(rcsNotVerified);
end;

procedure TReportData.ShowOnlyFaultsBtnClick(Sender: TObject);
begin
  self.ExeckRecordsSQL(ShowOnlyFaultsBtn.Down);
end;

procedure TReportData.ReportPrintExecute(Sender: TObject);
begin
  PrintReport(self.ItemID,ShowOnlyFaultsBtn.Down);
end;

procedure TReportData.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  str : string;
  rct : Trect;
  BMP : TBitmap;
  i   : integer;
begin
  i:=Records.FieldByName('STATUS').AsInteger;
  if not(gdSelected in State) then begin
    if (i<rcsAccept)and(ColorBtn.Down)then begin
      case i of
        rcsNotVerified    : grid.Canvas.Brush.Color:=clERROR;
        rcsSpellingErrors : grid.Canvas.Brush.Color:=clERROR;
        rcsDataErrors     : grid.Canvas.Brush.Color:=clWarning;
        rcsAutoVerified, rcsManualVerified : grid.Canvas.Brush.Color:=clNOTERROR;
      end;
      grid.Canvas.FillRect(rect);
      str:=Records.FieldByName(Column.FieldName).AsString;
      rct:=Rect;
      inc(rct.Left,2);
      DrawText(grid.Canvas.Handle,pchar(str),Length(str),rct,DT_LEFT or DT_VCENTER or DT_SINGLELINE);
    end;
  end else Grid.DefaultDrawDataCell(rect,Column.Field,state);
  if (not Records.IsEmpty)and(Column.FieldName='STATUS') then  begin
    grid.Canvas.Brush.Color:=clWhite;
    grid.Canvas.FillRect(rect);
    rct:=Rect;
    bmp:=TBitmap.Create;
    case Records.FieldByName('STATUS').AsInteger of
      rcsNotVerified    : DMod.ImageList.GetBitmap(49,bmp);
      rcsSpellingErrors : DMod.ImageList.GetBitmap(26,bmp);
      rcsDataErrors     : DMod.ImageList.GetBitmap(50,bmp);
      rcsAutoVerified   : DMod.ImageList.GetBitmap(51,bmp);
      rcsManualVerified : DMod.ImageList.GetBitmap(52,bmp);
      rcsAccept         : DMod.ImageList.GetBitmap(27,bmp);
    end;
    Grid.Canvas.Draw(rct.Left+2,rct.Top+1,bmp);
    bmp.Free;
  end;
  if (Column.FieldName<>'STATUS')and((i=rcsAccept)or(not ColorBtn.Down)) then Grid.DefaultDrawDataCell(rect,Column.Field,state);
end;


//--------------------- ЗАГОЛОВОК ОТЧЕТА ---------------------------------------
//подбор отчетного месяца
procedure TReportData.MonthBtnClick(Sender: TObject);
var
  m,y,d : word;
  str : string;
  dt  : Tdatetime;
begin
  if (MonthED.Text=NotMonth) then begin
    m:=0;
    y:=YearOf(now);
  end else begin
    dt:= MainQuery.FieldByName('REPDATE').AsDateTime;
    DecodeDate(dt,y,m,d);
  end;
  str:=GetMonth(m,y);
  if Length(str)>0 then begin
    if not MainQuery.Modified then MainQuery.Edit;
    MainQuery.FieldByName('REPDATE').AsDateTime:=EncodeDate(y,m,1);
    MonthED.Text:=str;
  end;
end;
//установка даты в заголовке
procedure TReportData.DocDatePicCloseUp(Sender: TObject);
begin
  if not MainQuery.Modified then MainQuery.Edit;
  MainQuery.FieldByName('DOCDATE').AsDateTime:=DocDatePic.Date;
end;
//запрет редактировани даты в ручную
procedure TReportData.DocDatePicKeyPress(Sender: TObject; var Key: Char);
begin
  key:=chr(0);
end;
//подбор сервисного центра
procedure TReportData.CenterBtnClick(Sender: TObject);
var
  id    : integer;
  d,c,i : string ;
  isdel : boolean;
begin
  ID:=GetSenterID(MainQuery.FieldByName('SENTERID').AsInteger,d,c,i,isdel);
  if ID>0 then begin
    if MainQuery.Modified=false then MainQuery.Edit;
    MainQuery.FieldByName('SENTERID').AsInteger:=id;
    CenterDB.Text:=d;
    CityDB.Text:=c;
    InformationBtn.Visible:=(length(i)>0);
    if InformationBtn.Visible then SenterInfo:=i; 
    if isdel then DMod.ImageList.GetBitmap(26,SenterIsDelImg.Picture.Bitmap)
      else DMod.ImageList.GetBitmap(27,SenterIsDelImg.Picture.Bitmap);
    SenterIsDelImg.Repaint;
  end;
end;

procedure TReportData.PaidCheckClick(Sender: TObject);
begin
  FirstInvoiceClearBTN.Enabled:=not TDBCheckBox(sender).Checked;
  FirstInvoiceDBE.Enabled:=not TDBCheckBox(sender).Checked;
  FirstInvoiceDT.Enabled:=not TDBCheckBox(sender).Checked;
end;

procedure TReportData.RecordedCheckClick(Sender: TObject);
begin
  InvoiceClearBTN.Enabled:=not TDBCheckBox(sender).Checked;
  InvoiceDBE.Enabled:=not TDBCheckBox(sender).Checked;
  InvoiceDT.Enabled:=not TDBCheckBox(sender).Checked;
end;
//проверка заголовка и запись отчета
function TReportData.PostMainQuery:boolean;
var
  msg       : string;
begin
  result:=true;
  msg:='';
  //записываем дату по умолчанию (если не задана)
  if MainQuery.FieldByName('DOCDATE').AsVariant=null then MainQuery.FieldByName('DOCDATE').AsDateTime:=DocDatePic.Date;
  //Проверка заголовка
  if Length(NumberDBED.Text)=0 then msg:=msg+chr(13)+'- номер отчета не задан';
  if MainQuery.FieldByName('REPDATE').AsVariant=null then msg:=msg+chr(13)+'- отчетный месяц не задан';
  if MainQuery.FieldByName('SENTERID').AsVariant=null then msg:=msg+chr(13)+'- сервисный центр не выбран';
  if (MainQuery.FieldByName('FIRSTINVOICEDATE').IsNull) and (Length(MainQuery.FieldByName('FIRSTINVOICENUMBER').AsString)>0) then
     msg:=msg+chr(13)+'- не указана дата счета';
  if (Length(MainQuery.FieldByName('FIRSTINVOICENUMBER').AsString)=0) and (not MainQuery.FieldByName('FIRSTINVOICEDATE').IsNull) then
     msg:=msg+chr(13)+'- не указан номер счета';
  if (MainQuery.FieldByName('INVOICEDATE').IsNull) and (Length(MainQuery.FieldByName('INVOICENUMBER').AsString)>0) then
     msg:=msg+chr(13)+'- не указана дата акта вып работ';
  if (Length(MainQuery.FieldByName('INVOICENUMBER').AsString)=0) and (not MainQuery.FieldByName('INVOICEDATE').IsNull) then
     msg:=msg+chr(13)+'- не указан номер акта вып работ';
  if Length(msg)>0 then begin
    msg:='Ошибки заполнения заголовка:'+msg;
    MessageDLG(msg,mtError,[mbOK],0);
  end;
  if Length(msg)=0 then  begin
    if MainQuery.FieldByName('EMPLID').AsInteger=0 then begin
      if not MainQuery.Modified then MainQuery.Edit;
      MainQuery.FieldByName('EMPLID').AsInteger:=EditorID;
    end;
    if MainQuery.Modified then MainQuery.Post;
    if ITEMID=0 then ITEMID:=MainQuery.FieldByName('ID').AsInteger;
    Caption:='Отчет №'+MainQuery.FieldByName('NUMBER').AsString+' от '+FormatDateTime('dd.mm.yy',DocDatePic.Date);
    DMod.SendMsgToSystem(WM_UPDATEREPORTLIST,self.Tag);
  end else result:=false;
end;

procedure TReportData.InformationBtnClick(Sender: TObject);
begin
  MessageDlg(SenterInfo,mtInformation,[mbOk],0);
end;

procedure TReportData.InvoiceClearBtnClick(Sender: TObject);
begin
  MainQuery.FieldByName('INVOICEDATE').AsVariant:=NULL;
  MainQuery.FieldByName('INVOICENUMBER').AsVariant:=NULL;
end;

procedure TReportData.FirstInvoiceClearBtnClick(Sender: TObject);
begin
  MainQuery.FieldByName('FIRSTINVOICEDATE').AsVariant:=NULL;
  MainQuery.FieldByName('FIRSTINVOICENUMBER').AsVariant:=NULL;
end;

procedure TReportData.DocMailDateClearBtnClick(Sender: TObject);
begin
  MainQuery.FieldByName('DOCMAILDATE').AsVariant:=NULL;
end;

//--------------------- РАБОТА С ФРЭЙМОМ ИМПОРТА -------------------------------

procedure TReportData.ShowFrameBtnClick(Sender: TObject);
var
  import : boolean;
begin
  If ItemID=0 then begin
    if MessageDLG('Новый отчет сначала должен быть записан !'+chr(13)+
    'Записать заголовок отчета ?',mtError,[mbYES,mbNO],0)=mrYes then import:=self.PostMainQuery else import:=false;
  end else Import:=true;
  if import then begin
    ImportFrame.Visible:=true;
    ImportFrame.CaptioLb.Caption:='Импорт данных в отчет №'+MainQuery.FieldByName('NUMBER').AsString+' от '+FormatDateTime('dd.mm.yy',DocDatePic.Date);
    self.FormResize(self);
    toppn.Enabled:=false;
    bottompn.Enabled:=false;
    MainPn.Enabled:=false;
  end;
end;

procedure TReportData.SumSetLBClick(Sender: TObject);
begin
  if SumAccept then (sender as TStaticText).Caption:='все записи';
  if not SumAccept then (sender as TStaticText).Caption:='только принятые';
  SumAccept:=not SumAccept;
  self.SetReportStatus;
end;

procedure TReportData.SumSetLBMouseEnter(Sender: TObject);
begin
  (sender as TStaticText).Font.Color:=clNavy;
end;

procedure TReportData.SumSetLBMouseLeave(Sender: TObject);
begin
  (sender as TStaticText).Font.Color:=clBlack;
end;

procedure TReportData.ImportFormText(mode:integer);
var
  c,r  : integer;
  pind : ^integer;
  fn   : string;
begin
  Records.DisableControls;
  if (mode=0)and(not Records.IsEmpty) then with Records do begin
    Open;
    while not IsEmpty do Delete;
  end;
  for r := 1 to ImportFrame.table.RowCount-1 do begin
    Records.Append;
    Records.FieldByName('REPORTID').AsInteger:=ItemID;
    Records.FieldByName('STATUS').AsInteger:=rcsNotVerified;
    Records.FieldByName('MAINTYPEID').AsInteger:=0;
    for c := 1 to ImportFrame.table.ColCount-1 do begin
      pind:=pointer(ImportFrame.table.Objects[c,0]);
      if (pind<>nil)and(DMod.FieldsTable.Lookup('ID',pind^,'FIELD')<>NULL) then begin
        fn:=DMod.FieldsTable.Lookup('ID',pind^,'FIELD');
        if Records.FindField(fn)<>nil then Records.FieldByName(fn).AsString:=ImportFrame.table.Cells[c,r];
      end;
    end;
    Records.Post;
  end;
  if not Records.Eof then Records.First;
  Records.EnableControls;
end;

procedure TReportData.HideFrame;
begin
  ImportFrame.TableModified:=false;
  self.ImportFrame.Visible:=false;
  toppn.Enabled:=true;
  bottompn.Enabled:=true;
  MainPn.Enabled:=true;
end;

procedure TReportData.ImportFrameCloseBtnClick(Sender: TObject);
var
  mr    : TModalResult;
  impst : integer;
begin
  if ImportFrame.TableModified then begin
    mr:=MessageDlg('Перенести данные в отчет ?',mtWarning,[mbYes,mbNo,mbCancel],0);
    case mr of
      mrYes    : if ImportFrame.VerifyImportFormat then begin
                    impst:=GetImportState;
                    if impst<0 then Abort else begin
                      self.ImportFormText(impst);
                      self.HideFrame;
                      self.VerifyRecords;
                      self.SetReportStatus;
                    end;
                  end else Abort;
      mrCancel : Abort;
    end;
  end;
  self.HideFrame;
end;

procedure TReportData.ImportFrameOKBtnClick(Sender: TObject);
var
  impst : integer;
begin
  if ImportFrame.VerifyImportFormat then begin
    if Records.IsEmpty then impst:=0 else impst:=GetImportState;
    if impst<0 then Abort;
    self.ImportFormText(impst);
    Records.Refresh;
    self.HideFrame;
    self.VerifyRecords;
    self.SetReportStatus;
  end;
end;

//------------------------ Загрзука из файла RRP -------------------------------

procedure TReportData.loadFromFile(fname: string);
var
  id,mt        : integer;
  str,sn,model : string;
  ReportDBF    : TDBF;
  sdt,edt,bdt  : TDateTime;
begin
  ReportDBF:=TDBF.Create(self);
  ReportDBF.TableName:=fname;
  ReportDBF.Active:=true;
  while not ReportDBF.Eof do begin
    id:=ReportDBF.FieldByName('ID').AsInteger;
    //stat:=ReportDBF.FieldByName('STATUS').AsInteger;
    if id>0 then begin
      Records.Append;
      Records.FieldByName('REPORTID').AsInteger:=ItemID;
      Records.FieldByName('STATUS').AsInteger:=rcsNotVerified;
      Records.FieldByName('WORKTYPE').AsString:=ReportDBF.FieldByName('WORKTYPE').AsString;
      Records.FieldByName('CLIENT').AsString:=ReportDBF.FieldByName('CLIENT').AsString;
      Records.FieldByName('CLIENTTEL').AsString:=ReportDBF.FieldByName('CLIENTTEL').AsString;
      Records.FieldByName('CLIENTADDR').AsString:=ReportDBF.FieldByName('CLIENTADDR').AsString;
      model:=ReportDBF.FieldByName('MODELNOTE').AsString;
      Records.FieldByName('MODELNOTE').AsString:=model;
      sn:=ReportDBF.FieldByName('SN').AsString;
      Records.FieldByName('SN').AsString:=sn;
      bdt:=0;
      if (ReportDBF.FieldByName('BUYDATE').AsVariant=NULL)or(ReportDBF.FieldByName('WORKID').AsInteger=1)
        then Records.FieldByName('BUYDATE').AsVariant:=NULL else begin
          bdt:=ReportDBF.FieldByName('BUYDATE').AsDateTime;
          Records.FieldByName('BUYDATE').AsString:=FormatDateTime('dd.mm.yyyy',bdt);
        end;
      sdt:=0;
      if ReportDBF.FieldByName('STARTDATE').AsVariant=NULL then Records.FieldByName('STARTDATE').AsVariant:=NULL else begin
        sdt:=ReportDBF.FieldByName('STARTDATE').AsDateTime;
        Records.FieldByName('STARTDATE').AsString:=FormatDateTime('dd.mm.yyyy',sdt);
      end;
      edt:=0;
      if ReportDBF.FieldByName('ENDDATE').AsVariant=NULL then Records.FieldByName('ENDDATE').AsVariant:=NULL else begin
        edt:=ReportDBF.FieldByName('ENDDATE').AsDateTime;
        Records.FieldByName('ENDDATE').AsString:=FormatDateTime('dd.mm.yyyy',edt);
      end;
      Records.FieldByName('PARTS').AsString:=ReportDBF.FieldByName('PARTS').AsString;
      Records.FieldByName('PARTCOST').AsFloat:=ReportDBF.FieldByName('PARTCOST').AsFloat;
      Records.FieldByName('PARTQTY').AsFloat:=ReportDBF.FieldByName('PARTQTY').AsFloat;
      Records.FieldByName('PARTDOC').AsString:=ReportDBF.FieldByName('PARTDOC').AsString;
      Records.FieldByName('MOVPRICE').AsFloat:=ReportDBF.FieldByName('MOVPRICE').AsFloat;
      Records.FieldByName('WORKPRICE').AsFloat:=ReportDBF.FieldByName('WORKPRICE').AsFloat;
      str:=ReportDBF.FieldByName('PROBLEMNOT').AsString;
      if length(str)=0 then str:=ReportDBF.FieldByName('ADDPROBNOT').AsString
        else str:=str+'. '+ReportDBF.FieldByName('ADDPROBNOT').AsString;
      Records.FieldByName('PROBLEMNOTE').AsString:=str;
      Records.FieldByName('WORKNOTE').AsString:=ReportDBF.FieldByName('WORKNOTE').AsString;
      Records.FieldByName('WORKCODE').AsString:=ReportDBF.FieldByName('WORKCODE').AsString;
      Records.FieldByName('WORKID').AsInteger:=ReportDBF.FieldByName('WORKID').AsInteger;
      Records.FieldByName('FACTORYID').AsInteger:=ReportDBF.FieldByName('FACTORYID').AsInteger;
      Records.FieldByName('MODELID').AsInteger:=ReportDBF.FieldByName('MODELID').AsInteger;
      Records.FieldByName('GROUPID').AsInteger:=ReportDBF.FieldByName('GROUPID').AsInteger;
      if ReportDBF.FieldByName('MAINDATE').AsVariant=NULL then Records.FieldByName('MAINDATE').AsVariant:=NULL else
        Records.FieldByName('MAINDATE').AsString:=FormatDateTime('dd.mm.yyyy',ReportDBF.FieldByName('MAINDATE').AsDateTime);
      Records.FieldByName('SHIFTID').AsInteger:=ReportDBF.FieldByName('SHIFTID').AsInteger;
      mt:=ReportDBF.FieldByName('MAINTYPEID').AsInteger;
      Records.FieldByName('MAINTYPEID').AsInteger:=mt;
      Records.FieldByName('NOTE').AsString:=ReportDBF.FieldByName('NOTE').AsString;
      Records.FieldByName('ISADDPART').AsBoolean:=false;
      Records.Post;
      //дополнительные детали
      ReportDBF.Filter:='PARENT='+IntTOStr(id);
      ReportDBF.Filtered:=true;
      while not ReportDBF.Eof do begin
        Records.Append;
        Records.FieldByName('MODELNOTE').AsString:=model;
        Records.FieldByName('SN').AsString:=sn;
        Records.FieldByName('PARTS').AsString:=ReportDBF.FieldByName('PARTS').AsString;
        Records.FieldByName('PARTCOST').AsFloat:=ReportDBF.FieldByName('PARTCOST').AsFloat;
        Records.FieldByName('PARTQTY').AsFloat:=ReportDBF.FieldByName('PARTQTY').AsFloat;
        Records.FieldByName('PARTDOC').AsString:=ReportDBF.FieldByName('PARTDOC').AsString;
        Records.FieldByName('MAINTYPEID').AsInteger:=mt;
        Records.FieldByName('ISADDPART').AsBoolean:=true;
        if bdt>0 then Records.FieldByName('BUYDATE').AsString:=FormatDateTime('dd.mm.yyyy',bdt);
        if sdt>0 then Records.FieldByName('STARTDATE').AsString:=FormatDateTime('dd.mm.yyyy',sdt);
        if edt>0 then Records.FieldByName('ENDDATE').AsString:=FormatDateTime('dd.mm.yyyy',edt);
        Records.Post;
        ReportDBF.Next;
      end;
      ReportDBF.Filter:='';
      ReportDBF.Filtered:=false;
    end;
    if id>0 then ReportDBF.Locate('ID',id,[]);
    ReportDBF.Next;
  end;
end;

procedure TReportData.LoadFromRRPFileExecute(Sender: TObject);
var
  load : boolean;
begin
  load:=false;
  // отчет толжен быть записан
  If ItemID=0 then begin
    if MessageDLG('Новый отчет сначала должен быть записан !'+chr(13)+
    'Записать заголовок отчета ?',mtError,[mbYES,mbNO],0)=mrYes then load:=self.PostMainQuery else load:=false;
  end else load:=true;
  //отчет должен быть очищен
  if (load)and(not Records.IsEmpty) then begin
    if MessageDLg('Перед загрузкой имеющиеся данные будут удалены!'+
      chr(13)+'Продолжить ?',mtWarning,[mbOk,mbCancel],0)=mrOk then begin
        Records.Open;
        while not Records.IsEmpty do Records.Delete;
    end else load:=false;
  end;
  //загрзука из файла
  if (load)and(OpenDlg.Execute) then begin
    self.loadFromFile(OpenDlg.FileName);
    self.VerifyRecords;
    self.SetReportStatus;
  end;
end;

end.
