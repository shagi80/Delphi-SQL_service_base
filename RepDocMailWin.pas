unit RepDocMailWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Buttons, Grids, DBGrids, ComCtrls, ExtCtrls,
  DBCtrls;

type
  TRepDocMailForm = class(TForm)
    TopPN: TPanel;
    SetBtn: TSpeedButton;
    CaptionLB: TLabel;
    FilterCaption: TLabel;
    LeftPn: TPanel;
    SB: TScrollBox;
    MainSetPn: TPanel;
    GetDateBtn: TSpeedButton;
    StDateTP: TDateTimePicker;
    EndDateTP: TDateTimePicker;
    TablePN: TPanel;
    BottomPn: TPanel;
    PrepareBtn: TBitBtn;
    PrintBtn: TBitBtn;
    CloseBtn: TBitBtn;
    MainQuery: TADOQuery;
    DS: TDataSource;
    SumQuery: TADOQuery;
    SumDS: TDataSource;
    FilterED: TEdit;
    ClearFindBtn: TSpeedButton;
    SearchBtn: TSpeedButton;
    Label11: TLabel;
    Grid: TDBGrid;
    ResultPn: TPanel;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    DBText9: TDBText;
    Bevel1: TBevel;
    TopResultPn: TPanel;
    ShowResultBtn: TSpeedButton;
    DocMailCB: TCheckBox;
    MonthBtn: TSpeedButton;
    ClearMonthBtn: TSpeedButton;
    RepMonthCB: TCheckBox;
    MonthED: TEdit;
    procedure SetBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject;
      var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CalkSum;
    procedure GetDateBtnClick(Sender: TObject);
    function  GetFilterString : string;
    procedure StDateTPChange(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure ReportGetValue(const VarName: string; var Value: Variant);
    procedure PrepareBtnClick(Sender: TObject);
    procedure ShowResultBtnClick(Sender: TObject);
    procedure TopResultPnMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TopResultPnMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure TopResultPnMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ClearFindBtnClick(Sender: TObject);
    procedure GridCellClick(Column: TColumn);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SearchBtnClick(Sender: TObject);
    procedure MonthBtnClick(Sender: TObject);
    procedure ClearMonthBtnClick(Sender: TObject);
    procedure DocMailCBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Sql            : string;   //для сохранения запросов из компонентов
    SSql           : string;   //для сохранения запроса суммы
    FirstStart     : boolean;  //флаг первого запуска
    ResPnMov       : TPoint;   //для перемещения панели итогов
    ResultPnHeight : integer;  //для перемещения панели итогов
    RepMonth       : TDate;    //для хранения выбранной отчетной даты
  end;


implementation

{$R *.dfm}

uses DataMod, DateUtils, DateWin, PrintMod, MonthWin;

function  TRepDocMailForm.GetFilterString : string;
var
  flt     : string;
begin
  flt:='';
  FilterCaption.Caption:='';
  //отчеты по периоду поступления почты
  if DocMailCB.Checked then begin
    flt:='(REP.[DOCMAILDATE] BETWEEN '+QuotedStr(FormatDateTime('yyyymmdd',StartOfTheDay(StDateTP.Date)))+' AND '+QuotedStr(FormatDateTime('yyyymmdd',EndOfTheDay(EndDateTP.Date)))+')';
    FilterCaption.Caption:='почта, поступившая в период с '+QuotedStr(FormatDateTime('dd mmm yyyy',StDateTP.Date))+' по '+QuotedStr(FormatDateTime('dd mmm yyyy',EndDateTP.Date));
  end;
  //отчеты по отченому периоду
  if (RepMonthCB.Checked)and(self.RepMonth<>0) then begin
    if Length(flt)>0 then flt:=flt+' AND ';
    flt:=flt+'(REP.[REPDATE]='+QuotedStr(FormatDateTime('yyyymmdd',StartOfTheDay(self.RepMonth)))+')';
    if Length(FilterCaption.Caption)>0 then FilterCaption.Caption:=FilterCaption.Caption+', ';
    FilterCaption.Caption:=FilterCaption.Caption+'отчеты за '+MonthED.Text;
  end;
  //отчеты по части названия СЦ
  if Length(FilterCaption.Caption)>0 then FilterCaption.Caption:=FilterCaption.Caption+', ';
  if (Length(FilterED.Text)>0) then begin
    if Length(flt)>0 then flt:=flt+' AND ';
    flt:=flt+'(SNT.[DESCR] LIKE '+QuotedStr('%'+self.FilterED.Text+'%')+')';
    FilterCaption.Caption:=FilterCaption.Caption+'поиск в названии СЦ по строке "'+FilterED.Text+'"';
  end else FilterCaption.Caption:=FilterCaption.Caption+'по всем сервисным центрам';
  result:=flt;
end;

//--------------------- события контролов --------------------------------------

procedure TRepDocMailForm.ClearFindBtnClick(Sender: TObject);
begin
  FilterED.Text:='';
  self.PrepareBtnClick(sender);
  self.StDateTPChange(self);
end;

procedure TRepDocMailForm.ClearMonthBtnClick(Sender: TObject);
begin
  self.RepMonth:=0;
  self.MonthED.Text:='месяц не задан';
  self.StDateTPChange(self);
end;

procedure TRepDocMailForm.CloseBtnClick(Sender: TObject);
begin
  if MainQuery.Modified then MainQuery.Post;
  self.Close;
end;

procedure TRepDocMailForm.DocMailCBClick(Sender: TObject);
begin
  StDateTP.Enabled:=DocMailCB.Checked;
  EndDateTP.Enabled:=DocMailCB.Checked;
  GetDateBtn.Visible:=DocMailCB.Checked;
  MonthED.Enabled:=RepMonthCB.Checked;
  ClearMonthBTN.Visible:=RepMonthCB.Checked;
  MonthBtn.Visible:=RepMonthCB.Checked;
  Grid.Font.Color:=clGray;
  self.GetFilterString;
end;

procedure TRepDocMailForm.GetDateBtnClick(Sender: TObject);
var
  sd,ed : TDate;
begin
  sd:=StDateTP.Date;
  ed:=EndDateTP.Date;
  if DateForm.GetPeriod(sd,ed) then begin
    StDateTP.Date:=sd;
    EndDateTP.Date:=ed;
    Grid.Font.Color:=clGray;
    self.GetFilterString;
  end;
end;

procedure TRepDocMailForm.SearchBtnClick(Sender: TObject);
begin
  if length(FilterED.Text)>0 then self.PrepareBtnClick(sender);
end;

procedure TRepDocMailForm.SetBtnClick(Sender: TObject);
begin
  LeftPn.Visible:=SetBtn.Down;
  self.MainSetPn.Realign;
end;

procedure TRepDocMailForm.StDateTPChange(Sender: TObject);
begin
  Grid.Font.Color:=clGray;
  self.GetFilterString;
end;

procedure TRepDocMailForm.PrepareBtnClick(Sender: TObject);
var
  msql,flt : string;
begin
  flt:=self.GetFilterString;
  if Length(flt)=0 then begin
    ResultPN.Visible:=false;
    MessageDLG('Условия отбора не заданы !', mtError,[mbOk],0);
    Abort;
  end;
  msql:=stringreplace(sql,'/FILTER/',flt,[rfReplaceAll]);
  MainQuery.Close;
  MainQuery.SQL.Clear;
  MainQuery.SQL.Add(msql);
  //showmessage(MainQuery.SQL.Text);
  Grid.Font.Color:=clBlack;
  MainQuery.Open;
  Grid.Enabled:=not(MainQuery.IsEmpty);
  ResultPn.Visible:=not(MainQuery.IsEmpty);
  if (MainQuery.IsEmpty)and(not FirstStart) then MessageDLG('Записи по вашему запросу не найдены !'+chr(13)+
    'Измените условия отбора и повторите запрос.',mtWarning,[mbOK],0);
  if FirstStart then FirstStart:=false;
  if not MainQuery.IsEmpty then begin
      Grid.Font.Color:=clBlack;
      Self.CalkSum;
      if ShowResultBtn.Tag=1 then self.ShowResultBtnClick(ShowResultBtn);
    end;
end;

procedure TRepDocMailForm.PrintBtnClick(Sender: TObject);
var
  PrMod: TPrMod;
begin
  if FileExists(MyPath+'frxDocMail.fr3') then begin
    PrMod:=TPrMod.Create(application);
    PrMod.formcaption:=self.Caption;
    MainQuery.DisableControls;
    with PrMod do begin
      frxData1.DataSet:=self.MainQuery;
      Report.OnGetValue:=self.ReportGetValue;
      Report.LoadFromFile(MyPath+'frxDocMail.fr3');
      Report.PrepareReport(true);
      Report.ShowPreparedReport;
    end;
    MainQuery.EnableControls;
  end;
end;

procedure TRepDocMailForm.ReportGetValue(const VarName: string; var Value: Variant);
begin
  if comparetext(varname,'FILTER')=0 then value:=self.FilterCaption.Caption;
end;

procedure TRepDocMailForm.MonthBtnClick(Sender: TObject);
var
  m,y,d : word;
  str : string;
  dt  : Tdatetime;
begin
  if (self.RepMonth=0) then begin
    m:=0;
    y:=YearOf(now);
  end else begin
    dt:=self.RepMonth;
    DecodeDate(dt,y,m,d);
  end;
  str:=GetMonth(m,y);
  if Length(str)>0 then begin
    self.RepMonth:=EncodeDate(y,m,1);
    MonthED.Text:=str;
    self.StDateTPChange(self);
  end;
end;

//---------------------- события таьлицы ---------------------------------------

procedure TRepDocMailForm.GridCellClick(Column: TColumn);
begin
  if (not MainQuery.IsEmpty)and((Column.FieldName='FIRSTINVOICENUMBER')or(Column.FieldName='FIRSTINVOICEDATE')
    or(Column.FieldName='NOTE'))then Grid.Options:=Grid.Options+[dgEditing] else Grid.Options:=Grid.Options-[dgEditing];
end;

procedure TRepDocMailForm.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (not MainQuery.IsEmpty)and
    (((Column.FieldName='FIRSTINVOICENUMBER')and(Length(MainQuery.FieldByName('FIRSTINVOICENUMBER').AsString)=0))
    or((Column.FieldName='FIRSTINVOICEDATE')and(Length(MainQuery.FieldByName('FIRSTINVOICEDATE').AsString)=0))) then begin
      Grid.Canvas.Brush.Color:=clERROR;
      Grid.Canvas.FillRect(rect);
  end else (sender as TDBGrid).DefaultDrawDataCell(rect,Column.Field,state);
end;

//---------------------- события формы -----------------------------------------

procedure TRepDocMailForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PostMessage(application.MainForm.Handle,WM_CLOSECHILD,self.Tag,0);
  Action:=caFree;
end;

procedure TRepDocMailForm.FormShow(Sender: TObject);
begin
  ResultPnHeight:=ResultPn.Height;
  sql:=MainQuery.SQL.Text;
  ssql:=SumQuery.SQL.Text;
  //настройка органов управления
  self.RepMonth:=0;
  MonthED.Text:='месяц не задан';
  RepMonthCB.Checked:=false;
  MonthED.Enabled:=RepMonthCB.Checked;
  ClearMonthBTN.Visible:=RepMonthCB.Checked;
  MonthBtn.Visible:=RepMonthCB.Checked;
  SetBtn.Down:=true;
  LeftPn.Visible:=SetBtn.Down;
  EndDateTP.Date:=incday(StartOfTheMonth(now),-1);
  StDateTP.Date:=StartOfTheMonth(IncMonth(now,-1));
  SB.VertScrollBar.Position:=0;
  self.MainSetPn.Realign;
  FirstStart:=true;
  self.PrepareBtnClick(self);
end;

//--------------------- перемещение панели итогов ------------------------------

procedure TRepDocMailForm.CalkSum;
var
  sql : string;
begin
  sql:=ssql;
  SumQuery.Close;
  SumQuery.SQL.Clear;
  sql:=stringreplace(sql,'/FILTER/',self.GetFilterString,[rfReplaceAll]);
  SumQuery.SQL.Add(sql);
  SumQuery.Open;
end;

procedure TRepDocMailForm.ShowResultBtnClick(Sender: TObject);
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

procedure TRepDocMailForm.TopResultPnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then begin
    screen.Cursor:=crDrag;
    (sender as TPanel).Tag:=1;
    ResPnMov.X:=x;
    ResPnMov.Y:=y;
  end;
end;

procedure TRepDocMailForm.TopResultPnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (sender as TPanel).Tag=1 then begin
   ResultPn.Left:=ResultPn.Left+x-ResPnMov.X;
   ResultPn.Top:=ResultPn.Top+y-ResPnMov.Y;
  end;
end;

procedure TRepDocMailForm.TopResultPnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  screen.Cursor:=crDefault;
  (sender as TPanel).Tag:=0;
end;


end.
