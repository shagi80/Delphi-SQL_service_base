unit RepWestEast;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, Grids, DBGrids, DB, ADODB,
  DBCtrls;

type
  TRepWestEastForm = class(TForm)
    TopPN: TPanel;
    SetBtn: TSpeedButton;
    CaptionLB: TLabel;
    FilterCaption: TLabel;
    TablePN: TPanel;
    BottomPn: TPanel;
    PrepareBtn: TBitBtn;
    PrintBtn: TBitBtn;
    CloseBtn: TBitBtn;
    LeftPn: TPanel;
    SB: TScrollBox;
    MainSetPn: TPanel;
    PeriodLB: TLabel;
    GetDateBtn: TSpeedButton;
    StDateTP: TDateTimePicker;
    EndDateTP: TDateTimePicker;
    OnlyFullVerify: TCheckBox;
    WDS: TDataSource;
    WestQuery: TADOQuery;
    EastQuery: TADOQuery;
    EDS: TDataSource;
    WestPn: TPanel;
    Splitter1: TSplitter;
    EatPn: TPanel;
    Label1: TLabel;
    WestSumPn: TPanel;
    WestGrid: TDBGrid;
    Label2: TLabel;
    DBText1: TDBText;
    Label4: TLabel;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    Label5: TLabel;
    DBText4: TDBText;
    Label6: TLabel;
    DBText5: TDBText;
    EastGrid: TDBGrid;
    Panel1: TPanel;
    Label7: TLabel;
    DBText6: TDBText;
    Label8: TLabel;
    DBText7: TDBText;
    Label9: TLabel;
    DBText8: TDBText;
    Label10: TLabel;
    DBText9: TDBText;
    Label11: TLabel;
    DBText10: TDBText;
    Label12: TLabel;
    ResultPn: TPanel;
    TopResultPn: TPanel;
    ShowResultBtn: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    EastLB: TLabel;
    ResultLB: TLabel;
    WestLB: TLabel;
    Label15: TLabel;
    procedure SetBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject;
      var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure GetDateBtnClick(Sender: TObject);
    function  SetFilterCaption : string;
    procedure StDateTPChange(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure ReportGetValue(const VarName: string; var Value: Variant);
    procedure PrepareBtnClick(Sender: TObject);
    procedure OnlyFullVerifyClick(Sender: TObject);
    procedure SetColumns(var Query : TADOQuery;var Grid : TDBGrid);
    procedure WestPnResize(Sender: TObject);
    procedure ShowResultBtnClick(Sender: TObject);
    procedure TopResultPnMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TopResultPnMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure TopResultPnMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CalckResult;
  private
    { Private declarations }
    WestSQL,EAstSQL : string;
    FirstStart      : boolean;
    ResPnMov        : TPoint;   //для перемещения панели итогов
    ResultPnHeight  : integer;  //для перемещения панели итогов
  public
    { Public declarations }
  end;


implementation

uses DataMod, DateUtils, DateWin, PrintMod;

{$R *.dfm}

function  TRepWestEastForm.SetFilterCaption : string;
begin
  FilterCaption.Caption:='отчетный период с '+QuotedStr(FormatDateTime('dd mmm yyyy',StDateTP.Date))+' по '+QuotedStr(FormatDateTime('dd mmm yyyy',EndDateTP.Date));
  if OnlyFullVerify.Checked then FilterCaption.Caption:=FilterCaption.Caption+', только полностью проверенные отчеты';
end;

procedure TRepWestEastForm.CalckResult;
type
  TCost = record
    parts,mov,work,total : real;
  end;
var
  westcosts, eastcosts : TCost;
begin
  if WestQuery.IsEmpty then begin
    westcosts.parts:=0;
    westcosts.mov:=0;
    westcosts.work:=0;
  end else begin
    westcosts.parts:=WestQuery.FieldByName('TOTPART').AsFloat;
    westcosts.mov:=WestQuery.FieldByName('TOTMOV').AsFloat;
    westcosts.work:=WestQuery.FieldByName('TOTWORK').AsFloat;
  end;
  if EastQuery.IsEmpty then begin
    eastcosts.parts:=0;
    eastcosts.mov:=0;
    eastcosts.work:=0;
  end else begin
    eastcosts.parts:=EastQuery.FieldByName('TOTPART').AsFloat;
    eastcosts.mov:=EastQuery.FieldByName('TOTMOV').AsFloat;
    eastcosts.work:=EastQuery.FieldByName('TOTWORK').AsFloat;
  end;
  westcosts.total:=westcosts.parts*1.05+westcosts.mov+westcosts.work;
  eastcosts.total:=eastcosts.parts*1.05+eastcosts.mov+eastcosts.work;
  WestLB.Caption:=FormatFloat('### ##0.00 руб', westcosts.total);
  EastLB.Caption:=FormatFloat('### ##0.00 руб', eastcosts.total);
  if westcosts.total>eastcosts.total then ResultLB.Caption:='ВОСТОК должен ЗАПАДУ '+
    FormatFloat('### ##0.00 руб',westcosts.total-eastcosts.total);
  if westcosts.total<eastcosts.total then ResultLB.Caption:='ЗАПАД должен ВОСТОКУ '+
    FormatFloat('### ##0.00 руб',eastcosts.total-westcosts.total);
  if westcosts.total=eastcosts.total then ResultLB.Caption:='Затраты отделений равны !';
end;

//--------------------- события контролов --------------------------------------

procedure TRepWestEastForm.CloseBtnClick(Sender: TObject);
begin
  self.Close;
end;

procedure TRepWestEastForm.GetDateBtnClick(Sender: TObject);
var
  sd,ed : TDate;
begin
  sd:=StDateTP.Date;
  ed:=EndDateTP.Date;
  if DateForm.GetPeriod(sd,ed) then begin
    StDateTP.Date:=sd;
    EndDateTP.Date:=ed;
    WestGrid.Font.Color:=clGray;
    EastGrid.Font.Color:=clGray;
    self.SetFilterCaption;
  end;
end;

procedure TRepWestEastForm.OnlyFullVerifyClick(Sender: TObject);
begin
  WestGrid.Font.Color:=clGray;
  EastGrid.Font.Color:=clGray;
  self.SetFilterCaption;
end;

procedure TRepWestEastForm.SetBtnClick(Sender: TObject);
begin
  LeftPn.Visible:=SetBtn.Down;
  self.MainSetPn.Realign;
end;

procedure TRepWestEastForm.StDateTPChange(Sender: TObject);
begin
  WestGrid.Font.Color:=clGray;
  EastGrid.Font.Color:=clGray;
  self.SetFilterCaption;
end;

procedure TRepWestEastForm.PrepareBtnClick(Sender: TObject);
var
  sql,flt : string;
begin
  flt:='REP.[REPDATE] BETWEEN '+QuotedStr(FormatDateTime('yyyymmdd',StDateTP.Date))+' AND '+QuotedStr(FormatDateTime('yyyymmdd',EndDateTP.Date));
  if OnlyFullVerify.Checked then flt:=flt+' AND REP.[VERIFYST]=100';
  //западная таблица
  SQl:=stringreplace(WestSql,'/REPFILTER/',flt,[rfReplaceAll]);
  WestQuery.Close;
  WestQuery.SQL.Clear;
  WestQuery.SQL.Add(Sql);
  WestQuery.Open;
  TDateTimeField(WestQuery.FieldByName('REPDATE')).DisplayFormat:='MMMM YYYY';
  //восточняая таблица
  SQl:=stringreplace(EastSql,'/REPFILTER/',flt,[rfReplaceAll]);
  EastQuery.Close;
  EastQuery.SQL.Clear;
  EastQuery.SQL.Add(Sql);
  EastQuery.Open;
  TDateTimeField(EastQuery.FieldByName('REPDATE')).DisplayFormat:='MMMM YYYY';
  if (WestQuery.IsEmpty)and(EastQuery.IsEmpty)and(not FirstStart) then MessageDLG('Записи по вашему запросу не найдены !'+chr(13)+
    'Измените условия отбора и повторите запрос.',mtWarning,[mbOK],0);
  if FirstStart then  FirstStart:=false;
  //настройка таблиц
  WestGrid.Enabled:=not(WestQuery.IsEmpty);
  EastGrid.Enabled:=not(EastQuery.IsEmpty);
  if not WestQuery.IsEmpty then WestGrid.Font.Color:=clBlack;
  if not EastQuery.IsEmpty then EastGrid.Font.Color:=clBlack;
  if (not WestQuery.IsEmpty)or(not EastQuery.IsEmpty) then begin
    self.CalckResult;
    ResultPn.Visible:=true;
    PrintBtn.Enabled:=true;
  end else begin
    ResultPn.Visible:=false;
    PrintBtn.Enabled:=false;
  end;
end;

procedure TRepWestEastForm.PrintBtnClick(Sender: TObject);
var
  PrMod: TPrMod;
begin
   if FileExists(MyPath+'frxWestEast.fr3') then begin
    PrMod:=TPrMod.Create(application);
    PrMod.formcaption:=self.Caption;
    WestQuery.DisableControls;
    EastQuery.DisableControls;
    WestQuery.First;
    EastQuery.First;
    with PrMod do begin
      frxData1.DataSet:=self.WestQuery;
      frxData2.DataSet:=self.EastQuery;
      Report.OnGetValue:=self.ReportGetValue;
      Report.LoadFromFile(MyPath+'frxWestEast.fr3');
      Report.PrepareReport(true);
      Report.ShowPreparedReport;
    end;
    WestQuery.EnableControls;
    EastQuery.EnableControls;
  end; 
end;

procedure TRepWestEastForm.ReportGetValue(const VarName: string; var Value: Variant);
begin
  if comparetext(varname,'FILTER')=0 then value:=self.FilterCaption.Caption;
  if comparetext(varname,'WESTRES')=0 then value:=self.WestLB.Caption;
  if comparetext(varname,'EASTRES')=0 then value:=self.EastLB.Caption;
  if comparetext(varname,'RESULT')=0 then value:=self.ResultLB.Caption;
end;

//---------------------- события формы -----------------------------------------

procedure TRepWestEastForm.WestPnResize(Sender: TObject);
begin
  WestPn.Height:=round(TablePN.Height*0.45);
end;

procedure TRepWestEastForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PostMessage(application.MainForm.Handle,WM_CLOSECHILD,self.Tag,0);
  Action:=caFree;
end;

procedure TRepWestEastForm.FormShow(Sender: TObject);
begin
  FirstStart:=true;
  westsql:=WestQuery.SQL.Text;
  eastsql:=EastQuery.SQL.Text;
  ResultPnHeight:=ResultPn.Height;
  //настройка органов управления
  SetBtn.Down:=true;
  LeftPn.Visible:=SetBtn.Down;
  EndDateTP.Date:=incday(StartOfTheMonth(now),-1);
  StDateTP.Date:=StartOfTheMonth(IncMonth(now,-1));
  SB.VertScrollBar.Position:=0;
  self.MainSetPn.Realign;
  self.SetFilterCaption;
  self.PrepareBtnClick(self);
  //Установка названий столбцов и ширины стрлбцов
  self.SetColumns(EastQuery,EastGrid);
  self.SetColumns(WestQuery,WestGrid);
end;

procedure TRepWestEastForm.SetColumns(var Query: TADOQuery; var Grid: TDBGrid);
var
  f   : integer;
  fn  : string;
  col : TColumn;
begin
  //Установка названий столбцов и ширины стрлбцов
  for f := 0 to Query.FieldCount - 1 do begin
      fn:=Query.Fields[f].FieldName;
      //службные поля не выводим
      if (fn<>'MODELID')and(fn<>'EDITORID')and(fn<>'REPORTID')and(fn<>'ID')and(fn<>'SHIFTID')and
        (fn<>'MAINDATE')and(fn<>'FACTORYID')and(fn<>'WORKID')and(fn<>'GROUPID')and(fn<>'ERRORS')and
        (fn<>'TOTPART')and(fn<>'TOTMOV')and(fn<>'TOTWORK')and(fn<>'TOTSUM')and(fn<>'RECCNT')and
        (fn<>'ISADDPART')and(fn<>'MAINTYPEID')and(fn<>'STATUS') then begin
        Col:=Grid.Columns.Add;
        Col.FieldName:=fn;
        if DMod.FieldsTable.Lookup('FIELD',fn,'DESCR')<>NULL then begin
          Col.Title.Caption:=DMod.FieldsTable.Lookup('FIELD',fn,'DESCR');
          Col.Width:=DMod.FieldsTable.Lookup('FIELD',fn,'DISPLEN');
        end;
        //эти поля видны но их нет в таблице полей
        if fn='SENTERNAME' then begin
          Col.Title.Caption:='Серв центр';
          Col.Width:=120;
        end;
        if fn='REPDATE' then begin
          Col.Title.Caption:='Отчет период';
          Col.Width:=80;
          //(WestQuery.FieldByName('REPDATE') as TDateTimeField).DisplayFormat:='MMMM YYYY';
        end;
        if fn='NOTE' then begin
          Col.Title.Caption:='Примечание';
          Col.Width:=350;
        end;
      end;
    end;
end;

//--------------------- перемещение панели итогов ------------------------------

procedure TRepWestEastForm.ShowResultBtnClick(Sender: TObject);
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

procedure TRepWestEastForm.TopResultPnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then begin
    screen.Cursor:=crDrag;
    (sender as TPanel).Tag:=1;
    ResPnMov.X:=x;
    ResPnMov.Y:=y;
  end;
end;

procedure TRepWestEastForm.TopResultPnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (sender as TPanel).Tag=1 then begin
   ResultPn.Left:=ResultPn.Left+x-ResPnMov.X;
   ResultPn.Top:=ResultPn.Top+y-ResPnMov.Y;
  end;
end;

procedure TRepWestEastForm.TopResultPnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  screen.Cursor:=crDefault;
  (sender as TPanel).Tag:=0;
end;


end.
