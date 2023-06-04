unit ReportListWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComCtrls, ToolWin, DBGrids, Buttons, ExtCtrls,
  frxpngimage, dbf, AppEvnts, DB, DBClient,DateUtils, ADODB, ActnList;

type
  TReportList = class(TForm)
    TopPn: TPanel;
    ToolBar1: TToolBar;
    AddBtn: TToolButton;
    DelBtn: TToolButton;
    FilterPn: TPanel;
    FilterED: TEdit;
    ClearFindBtn: TSpeedButton;
    EditBtn: TToolButton;
    RangePN: TPanel;
    Grid: TDBGrid;
    RLSTTABLE: TADOQuery;
    RLSTDS: TDataSource;
    Date2ED: TDateTimePicker;
    Date1ED: TDateTimePicker;
    StaticText3: TStaticText;
    Label1: TLabel;
    Label3: TLabel;
    ActionList1: TActionList;
    Edit: TAction;
    NewReport: TAction;
    Delete: TAction;
    MonthPN: TPanel;
    Label2: TLabel;
    MonthED: TEdit;
    RepDateBTN: TSpeedButton;
    ClearPeriodBtn: TSpeedButton;
    RLSTTABLENUMBER: TWideStringField;
    RLSTTABLEDOCDATE: TDateTimeField;
    RLSTTABLEREPDATE: TDateTimeField;
    RLSTTABLENOTE: TWideStringField;
    RLSTTABLEVERIFYST: TIntegerField;
    RLSTTABLEPAIDCHECK: TBooleanField;
    RLSTTABLERECORDEDCHECK: TBooleanField;
    RLSTTABLESENTERNAME: TWideStringField;
    RLSTTABLETOTSUM: TFloatField;
    RLSTTABLEEMPLNAME: TWideStringField;
    RLSTTABLEID: TAutoIncField;
    BottomPn: TPanel;
    OnlyFaultShowCB: TCheckBox;
    RegionCB: TComboBox;
    Label4: TLabel;
    Image1: TImage;
    RLSTTABLEREGION: TWideStringField;
    SearchBtn: TSpeedButton;
    ToolButton1: TToolButton;
    Update: TAction;
    procedure ClearFindBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridTitleClick(Column: TColumn);
    procedure ExectSQL(const ord:string='');
    procedure Date1EDKeyPress(Sender: TObject; var Key: Char);
    procedure Date2EDCloseUp(Sender: TObject);
    procedure ClearPeriodBtnClick(Sender: TObject);
    procedure RepDateBTNClick(Sender: TObject);
    procedure FilterEDChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure EditExecute(Sender: TObject);
    procedure NewReportExecute(Sender: TObject);
    procedure DeleteExecute(Sender: TObject);
    procedure UpdateReportTable;
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure GridCellClick(Column: TColumn);
    procedure RLSTTABLECalcFields(DataSet: TDataSet);
    procedure OnlyFaultShowCBClick(Sender: TObject);
    procedure RegionCBCloseUp(Sender: TObject);
    procedure SearchBtnClick(Sender: TObject);
    procedure FilterEDKeyPress(Sender: TObject; var Key: Char);
    procedure UpdateExecute(Sender: TObject);
  private
    { Private declarations }
    order : string;
    month : Tdate;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataMod, MonthWin, ReportDataWin;

const
  NotMonth='месяц не задан';

procedure TReportList.UpdateExecute(Sender: TObject);
var
  id:integer;
begin
  with RLSTTABLE do begin
    id:=fieldbyname('ID').AsInteger;
    DisableControls;
    self.ExectSQL();
    Locate('ID',id,[]);
    EnableControls;
  end;
end;

procedure TReportList.UpdateReportTable;
begin
  RLSTTABLE.Refresh;
end;

procedure TReportList.ExectSQL(const ord:string='');
var
  str : string;
  pid : ^integer;
begin
  if length(ord)>0 then order:=ord ;
  str:='SELECT T1.*, T2.DESCR AS SENTERNAME, T3.DESCR AS EMPLNAME, REG.DESCR AS REGION';
  str:=str+' FROM SERVREPORT AS T1';
  str:=str+' LEFT JOIN SERVCENTRES AS T2 ON T2.ID=T1.SENTERID';
  str:=str+' LEFT JOIN EMPLOYEES AS T3 ON T3.[ID]=T1.[EMPLID]';
  str:=str+' LEFT JOIN SERVREGION AS REG ON REG.[ID]=T2.[REGIONID]';
  //отбор по дате документа
  str:=str+' WHERE (T1.DOCDATE BETWEEN '+QuotedStr(FormatDateTime('yyyymmdd',Date1ed.Date))+
    ' AND '+QuotedStr(FormatDateTime('yyyymmdd',IncDay(Date2ed.Date,1)))+')';
  //отрбор по отчетному периоду
  if (MonthED.Text<>NotMonth) then begin
    str:=str+' AND (T1.REPDATE = '+
    QuotedStr(FormatDateTime('yyyymmdd',month))+')';
  end;
  //только не проверенные
  if OnlyFaultShowCB.Checked then str:=str+' AND (T1.VERIFYST < 100)';
  //по региону
  pid:=pointer(RegionCB.Items.Objects[RegionCb.itemIndex]);
  if pid^>0 then str:=str+' AND (REG.ID='+IntToStr(pid^)+')';
  //сортировка
  str:=str+' ORDER BY '+QuotedStr(order);
  RLSTTABLE.SQL.Clear;
  RLSTTABLE.SQL.Add(str);
  RLSTTABLE.Open;
end;

procedure TReportList.DeleteExecute(Sender: TObject);
var
  i : integer;
  query : TADOQuery;
begin
  if not(EditorStatus<=1) then MessageDlg('Недостаточно прав доступа!',mtError,[mbOK],0)
  else if (not RLSTTABLE.IsEmpty) then begin
    i:=DMod.ReportEditing(RLSTTABLE.FieldByName('ID').AsInteger);
    if i>0  then begin
      MessageDLG('Этот элемент редактируется!'+chr(13)+
      'Закройте окно редактора и повторите попытку!',mtError,[mbOk],0);
      application.MainForm.MDIChildren[i].BringToFront;
    end else
      if MessageDLG('Будет удален отчет и вся связанные с этим'+
      ' отчетом записи о ремонтах!'+chr(13)+
      'Удалить ?',mtWarning,[mbYes,mbNo],0)=mrYes then begin
        i:=RLSTTABLE.FieldByName('ID').AsInteger;
        Query:=TADOQuery.Create(self);
        Query.Connection:=DMod.Connection;
        Query.SQL.Add('SELECT * FROM SERVRECORDS WHERE REPORTID='+INTTOSTR(I));
        Query.Open;
        While not Query.IsEmpty do Query.Delete;
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('SELECT * FROM SERVREPORT WHERE ID='+INTTOSTR(I));
        Query.Open;
        Query.Delete;
        Query.Free;
        DMod.SendMsgToSystem(WM_UPDATEREPORTLIST,self.Tag);
      end;
  end;
end;

procedure TReportList.EditExecute(Sender: TObject);
var
  i : integer;
begin
  if not RLSTTABLE.Eof then begin
    i:=DMod.ReportEditing(RLSTTABLE.FieldByName('ID').AsInteger);
    if i>0 then application.MainForm.MDIChildren[i].BringToFront
      else ReportDataWin.ShowReportData(RLSTTABLE.FieldByName('ID').AsInteger,self.Edit.ImageIndex);
  end;
end;

procedure TReportList.NewReportExecute(Sender: TObject);
begin
  ReportDataWin.ShowReportData(0,self.NewReport.ImageIndex);
end;


//----------------------- события запроса -------------------------------------

procedure TReportList.RLSTTABLECalcFields(DataSet: TDataSet);
var
  Query : TADOQuery;
begin
  Query:=TADOQuery.Create(self);
  Query.Connection:=DMod.Connection;
  Query.SQL.Add('SELECT SUM(T1.WORKPRICE) AS TOTWORK, SUM(T1.MOVPRICE) AS TOTMOV, SUM(T1.PARTCOST) AS TOTPART'+
    ' FROM SERVRECORDS AS T1 WHERE (T1.[REPORTID]='+IntToStr(DataSet.FieldByName('ID').AsInteger)+')');
  Query.Open;
  DataSet.FieldByName('TOTSUM').AsFloat:=Query.FieldByName('TOTPART').AsFloat+
    Query.FieldByName('TOTMOV').AsFloat+Query.FieldByName('TOTWORK').AsFloat;
  Query.Free;
end;

//------------------------- события формы --------------------------------------

procedure TReportList.FormActivate(Sender: TObject);
begin
  self.FormResize(self);
end;

procedure TReportList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PostMessage(application.MainForm.Handle,WM_CLOSECHILD,self.Tag,0);
  Action:=caFree;
end;

procedure TReportList.FormCreate(Sender: TObject);
var
  pid : ^integer;
begin
  if ScreenHeight<screen.Height then begin
    TopPn.ScaleBy(ScreenHeight,screen.Height);
    BottomPn.ScaleBy(ScreenHeight,screen.Height);
  end else begin
    TopPn.ScaleBy(screen.Height,ScreenHeight);
    BottomPn.ScaleBy(screen.Height,ScreenHeight);
  end;
  Date2ED.Date:=now;
  Date1ED.Date:=incday(Date2ED.Date,-30);
  MonthED.Text:=NotMonth;
  self.FormResize(self);
  OnlyFaultShowCB.Checked:=false;
  SearchBtn.Enabled:=false;
  //заполняем ComboBox выбора региона
  RegionCB.Clear;
  RegionCB.Items.Add('не задан');
  new(pid); pid^:=0; RegionCB.Items.Objects[0]:=TObject(pid);
  DMOD.RegionTable.First;
  while not DMod.RegionTable.Eof do begin
      RegionCB.Items.Add(DMod.RegionTable.FieldByName('DESCR').AsString);
      new(pid);
      pid^:=DMod.RegionTable.FieldByName('ID').AsInteger;
      RegionCB.Items.Objects[RegionCB.Items.Count-1]:=TObject(pid);
      DMod.RegionTable.Next;
  end;
  RegionCB.ItemIndex:=0;
  SELF.ExectSQL('DOCDATE');
end;

procedure TReportList.FormResize(Sender: TObject);
var
  w,i  : integer;
begin
  Grid.Columns[0].Width:=round(Grid.ClientWidth*0.1);
  Grid.Columns[1].Width:=round(Grid.ClientWidth*0.05);
  Grid.Columns[2].Width:=round(Grid.ClientWidth*0.05);
  Grid.Columns[3].Width:=round(Grid.ClientWidth*0.07);
  Grid.Columns[4].Width:=round(Grid.ClientWidth*0.15);
  Grid.Columns[5].Width:=round(Grid.ClientWidth*0.07);
  Grid.Columns[6].Width:=round(Grid.ClientWidth*0.07);
  Grid.Columns[9].Width:=round(Grid.ClientWidth*0.13);
  w:=0;
  for I := 0 to Grid.Columns.Count- 2 do
      w:=W+Grid.Columns[i].Width+1;
  Grid.Columns[Grid.Columns.Count-1].Width:=Grid.ClientWidth-w-15;
end;

//------------------------- настройки фильтра ----------------------------------

procedure TReportList.Date1EDKeyPress(Sender: TObject; var Key: Char);
begin
  key:=chr(0);
end;

procedure TReportList.Date2EDCloseUp(Sender: TObject);
begin
  inherited;
  if Comparedate(Date1ED.Date,Date2ED.Date)<=0 then self.ExectSQL()
    else begin
      MessageDLG('Диапазон дат задан неврено!',mtError,[mbOk],0);
      if (sender as TControl).Name='Date1ED' then Date1ED.Date:=Date2ED.Date;
      if (sender as TControl).Name='Date2ED' then Date2ED.Date:=Date1ED.Date;
    end;
end;

procedure TReportList.ClearPeriodBtnClick(Sender: TObject);
begin
  MonthED.Text:=NotMonth;
  self.ExectSQL();
end;

procedure TReportList.RegionCBCloseUp(Sender: TObject);
begin
  SELF.ExectSQL('DOCDATE');
end;

procedure TReportList.RepDateBTNClick(Sender: TObject);
var
  m,y,d : word;
  str : string;
begin
  if (MonthED.Text=NotMonth) then begin
    m:=0;
    y:=YearOf(now);
  end else begin
    DecodeDate(month,y,m,d);
  end;
  str:=GetMonth(m,y);
  if Length(str)>0 then begin
    month:=EncodeDate(y,m,1);
    MonthED.Text:=str;
    self.ExectSQL();
  end;
end;

procedure TReportList.ClearFindBtnClick(Sender: TObject);
begin
  FilterED.Text:='';
end;

procedure TReportList.SearchBtnClick(Sender: TObject);
begin
  if (Length(FilterED.Text)>0) then begin
    RLSTTABLE.Filtered:=False;
    RLSTTABLE.Filter:='SENTERNAME LIKE '+QuotedStr('%'+FilterED.Text+'%')+
      'OR NOTE LIKE '+QuotedStr('%'+FilterED.Text+'%')+
      'OR REGION LIKE '+QuotedStr('%'+FilterED.Text+'%')+
      'OR EMPLNAME LIKE '+QuotedStr('%'+FilterED.Text+'%');
    RLSTTABLE.Filtered:=true;
  end else RLSTTABLE.Filtered:=false;
end;

procedure TReportList.FilterEDChange(Sender: TObject);
begin
  SearchBtn.Enabled:=(Length(FilterED.Text)>0);
  if Length(FilterED.Text)=0 then RLSTTABLE.Filtered:=False;
end;

procedure TReportList.FilterEDKeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13)and(Length(FilterED.Text)>0) then begin
    self.SearchBtnClick(self);
    key:=#0;
  end;
end;

procedure TReportList.OnlyFaultShowCBClick(Sender: TObject);
begin
 SELF.ExectSQL('DOCDATE');
end;

//------------------------- события табличной части ---------------------------

procedure TReportList.GridTitleClick(Column: TColumn);
begin
  self.ExectSQL(column.FieldName);
end;

procedure TReportList.GridCellClick(Column: TColumn);
begin
  if (not RLSTTABLE.IsEmpty)and((Column.FieldName='PAIDCHECK')or(Column.FieldName='RECORDEDCHECK')) then begin
    if not RLSTTABLE.Modified then RLSTTABLE.Edit;
    if Column.FieldName='PAIDCHECK' then RLSTTABLE.FieldByName('PAIDCHECK').AsBoolean:=not RLSTTABLE.FieldByName('PAIDCHECK').AsBoolean;
    if Column.FieldName='RECORDEDCHECK' then RLSTTABLE.FieldByName('RECORDEDCHECK').AsBoolean:=not RLSTTABLE.FieldByName('RECORDEDCHECK').AsBoolean;
    RLSTTABLE.Post;
    DMod.SendMsgToSystem(WM_UPDATEREPORTLIST,self.Tag);
  end;
end;

procedure TReportList.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  proc : integer;
  rct  : Trect;
  str  : string;
  bmp  : TBitMap;
begin
 if (not RLSTTABLE.IsEmpty)and((Column.FieldName='VERIFYST')or
    (Column.FieldName='PAIDCHECK')or
    (Column.FieldName='RECORDEDCHECK')) then begin
    rct:=rect;
    if (Column.FieldName='VERIFYST') then begin
      proc:=RLSTTABLE.FieldByName('VERIFYST').AsInteger;
      if proc=100 then begin
        grid.Canvas.Brush.Style:=bsSolid;
        grid.Canvas.Brush.Color:=clWhite;
        grid.Canvas.FillRect(rect);
        grid.Canvas.Font.Color:=clGreen;
        str:='принят';
        DrawText(grid.Canvas.Handle,pchar(str),Length(str),rct,DT_LEFT or DT_VCENTER or DT_SINGLELINE);
      end;
      if proc=0 then begin
        grid.Canvas.Brush.Style:=bsSolid;
        grid.Canvas.Brush.Color:=clWhite;
        grid.Canvas.FillRect(rect);
        grid.Canvas.Font.Color:=clRed;
        grid.Canvas.Font.Style:=[fsBold];
        str:=inttostr(proc)+'%';
        DrawText(grid.Canvas.Handle,pchar(str),Length(str),rct,DT_CENTER or DT_VCENTER or DT_SINGLELINE);
      end;
      if (proc>0)and(proc<100) then begin
        inc(rct.Top); dec(rct.Bottom);
        grid.Canvas.Brush.Style:=bsSolid;
        grid.Canvas.Brush.Color:=clWhite;
        grid.Canvas.FillRect(rect);
        grid.Canvas.Brush.Color:=clSkyBlue;
        rct.Right:=rct.Left+round((rect.Right-rect.Left)*proc/100);
        grid.Canvas.FillRect(rct);
        rct:=rect;
        grid.Canvas.Brush.Style:=bsClear;
        grid.Canvas.Font.Color:=clBlack;
        str:=inttostr(proc)+'%';
        DrawText(grid.Canvas.Handle,pchar(str),Length(str),rct,DT_CENTER or DT_VCENTER or DT_SINGLELINE);
      end;
    end;
    if Column.FieldName='PAIDCHECK' then begin
      grid.Canvas.Brush.Color:=clWhite;
      grid.Canvas.FillRect(rect);
      bmp:=TBitMap.Create;
      if RLSTTABLE.FieldByName('PAIDCHECK').AsBoolean then DMod.ImageList.GetBitmap(57,bmp)
        else DMod.ImageList.GetBitmap(58,bmp);
      proc:=trunc((rct.Bottom-rct.Top-bmp.Height)/2);
      grid.Canvas.Draw(rct.Left+2,rct.Top+proc,bmp);
      bmp.free;
    end;
    if Column.FieldName='RECORDEDCHECK' then begin
      grid.Canvas.Brush.Color:=clWhite;
      grid.Canvas.FillRect(rect);
      bmp:=TBitMap.Create;
      if RLSTTABLE.FieldByName('RECORDEDCHECK').AsBoolean then DMod.ImageList.GetBitmap(57,bmp)
        else DMod.ImageList.GetBitmap(58,bmp);
      proc:=trunc((rct.Bottom-rct.Top-bmp.Height)/2);
      grid.Canvas.Draw(rct.Left+2,rct.Top+proc,bmp);
      bmp.free;
    end;
  end else Grid.DefaultDrawDataCell(rect,Column.Field,state);
end;

procedure TReportList.GridMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  gpnt : TGridCoord;
begin
  gpnt:=grid.MouseCoord(x,y);
  if (not RLSTTABLE.IsEmpty)and(gpnt.X>0)and((Grid.Columns[gpnt.X-1].FieldName='PAIDCHECK')or(Grid.Columns[gpnt.X-1].FieldName='RECORDEDCHECK')) then grid.Cursor:=crHandPoint
    else grid.Cursor:=crDefault;
end;


end.
