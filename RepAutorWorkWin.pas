unit RepAutorWorkWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, Grids, DBGrids, DB, ADODB,
  DBCtrls;

type
  TRepAutorWorkForm = class(TForm)
    TopPN: TPanel;
    SetBtn: TSpeedButton;
    CaptionLB: TLabel;
    FilterCaption: TLabel;
    TablePN: TPanel;
    Grid: TDBGrid;
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
    AutorFilterCB: TCheckBox;
    AutorCB: TComboBox;
    DS: TDataSource;
    ResultPn: TPanel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    CntTxt: TDBText;
    Bevel3: TBevel;
    TopResultPn: TPanel;
    ShowResultBtn: TSpeedButton;
    SumQuery: TADOQuery;
    SumDS: TDataSource;
    Label10: TLabel;
    RecCntTxt: TDBText;
    MainQuery: TADOQuery;
    procedure SetBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject;
      var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CalkSum;
    procedure AutorFilterCBClick(Sender: TObject);
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
    procedure OnlyFullVerifyClick(Sender: TObject);
  private
    { Private declarations }
    Sql            : string;   //��� ���������� �������� �� �����������
    SSql           : string;   //��� ���������� ������� �����
    FirstStart     : boolean;  //���� ������� �������
    ResPnMov       : TPoint;   //��� ����������� ������ ������
    ResultPnHeight : integer;  //��� ����������� ������ ������
  public
    { Public declarations }
  end;


implementation

uses DataMod, DateUtils, DateWin, PrintMod;

{$R *.dfm}

function  TRepAutorWorkForm.GetFilterString : string;
var
  flt     : string;
  pid     : ^integer;
begin
  flt:='';
  //������� �� ������� ������� ��������
  flt:='BETWEEN '+QuotedStr(FormatDateTime('yyyymmdd',StartOfTheDay(StDateTP.Date)))+' AND '+QuotedStr(FormatDateTime('yyyymmdd',EndOfTheDay(EndDateTP.Date))+' 23:59:59');
  FilterCaption.Caption:='������ �������� � ������ � '+QuotedStr(FormatDateTime('dd mmm yyyy',StDateTP.Date))+' �� '+QuotedStr(FormatDateTime('dd mmm yyyy',EndDateTP.Date));
  //������ �� ���������
  if (AutorFilterCB.Checked) then begin
    pid:=pointer(AutorCB.Items.Objects[AutorCB.ItemIndex]);
    flt:=flt+'AND REP.EMPLID='+inttostr(pid^);
    FilterCaption.Caption:=FilterCaption.Caption+', ����� '+AutorCB.Items[AutorCB.ItemIndex];
  end else FilterCaption.Caption:=FilterCaption.Caption+', �� ���� ������� ';
  result:=flt;
end;

//--------------------- ������� ��������� --------------------------------------

procedure TRepAutorWorkForm.CloseBtnClick(Sender: TObject);
begin
  self.Close;
end;

procedure TRepAutorWorkForm.GetDateBtnClick(Sender: TObject);
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

procedure TRepAutorWorkForm.OnlyFullVerifyClick(Sender: TObject);
begin
  Grid.Font.Color:=clGray;
  self.GetFilterString;
end;

procedure TRepAutorWorkForm.SetBtnClick(Sender: TObject);
begin
  LeftPn.Visible:=SetBtn.Down;
  self.MainSetPn.Realign;
end;

procedure TRepAutorWorkForm.StDateTPChange(Sender: TObject);
begin
  Grid.Font.Color:=clGray;
  self.GetFilterString;
end;

procedure TRepAutorWorkForm.AutorFilterCBClick(Sender: TObject);
begin
  AutorCB.Visible:=AutorFilterCB.Checked;
  Grid.Font.Color:=clGray;
  self.GetFilterString;
end;

procedure TRepAutorWorkForm.PrepareBtnClick(Sender: TObject);
var
  msql : string;
begin
  msql:=stringreplace(sql,'/FILTER/',self.GetFilterString,[rfReplaceAll]);
  MainQuery.Close;
  MainQuery.SQL.Clear;
  MainQuery.SQL.Add(msql);
  //showmessage(MainQuery.SQL.Text);
  Grid.Font.Color:=clBlack;
  MainQuery.Open;
  TDateTimeField(MainQuery.FieldByName('REPDATE')).DisplayFormat:='MMMM YYYY';
  Grid.Enabled:=not(MainQuery.IsEmpty);
  ResultPn.Visible:=not(MainQuery.IsEmpty);
  if (MainQuery.IsEmpty)and(not FirstStart) then MessageDLG('������ �� ������ ������� �� ������� !'+chr(13)+
    '�������� ������� ������ � ��������� ������.',mtWarning,[mbOK],0);
  if FirstStart then FirstStart:=false;
  if not MainQuery.IsEmpty then begin
      Grid.Font.Color:=clBlack;
      Self.CalkSum;
      if ShowResultBtn.Tag=1 then self.ShowResultBtnClick(ShowResultBtn);
    end;
end;

procedure TRepAutorWorkForm.PrintBtnClick(Sender: TObject);
var
  PrMod: TPrMod;
begin
  if FileExists(MyPath+'frxAutorWork.fr3') then begin
    PrMod:=TPrMod.Create(application);
    PrMod.formcaption:=self.Caption;
    MainQuery.DisableControls;
    with PrMod do begin
      frxData1.DataSet:=self.MainQuery;
      frxData2.DataSet:=self.SumQuery;
      Report.OnGetValue:=self.ReportGetValue;
      Report.LoadFromFile(MyPath+'frxAutorWork.fr3');
      Report.PrepareReport(true);
      Report.ShowPreparedReport;
    end;
    MainQuery.EnableControls;
  end; 
end;

procedure TRepAutorWorkForm.ReportGetValue(const VarName: string; var Value: Variant);
begin
  if comparetext(varname,'FILTER')=0 then value:=self.FilterCaption.Caption;
end;

//---------------------- ������� ����� -----------------------------------------

procedure TRepAutorWorkForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PostMessage(application.MainForm.Handle,WM_CLOSECHILD,self.Tag,0);
  Action:=caFree;
end;

procedure TRepAutorWorkForm.FormShow(Sender: TObject);
var
  pid : ^integer;
  i   : integer;
  f   : integer;
  fn  : string;
  col : TColumn;
begin
  self.DoubleBuffered:=true;
  ResultPnHeight:=ResultPn.Height;
  sql:=MainQuery.SQL.Text;
  ssql:=SumQuery.SQL.Text;
  //������ �������
  DMod.EmployeeTable.First;
  while not DMod.EmployeeTable.Eof do begin
    AutorCB.Items.Add(DMod.EmployeeTable.FieldByName('DESCR').AsString);
    new(pid);
    pid^:=DMod.EmployeeTable.FieldByName('ID').AsInteger;
    if pid^=EditorID then AutorCB.ItemIndex:=AutorCB.Items.Count-1;
    AutorCB.Items.Objects[AutorCB.Items.Count-1]:=TObject(pid);
    DMod.EmployeeTable.Next;
  end;
  AutorCB.Sorted:=true;
  if AutorCB.Items.Count>0 then begin
    i:=0;
    pid:=pointer(AutorCB.Items.Objects[0]);
    while(i<AutorCB.Items.Count)and(pid^<>EditorID)do begin
      inc(i);
      if(i<AutorCB.Items.Count)then pid:=pointer(AutorCB.Items.Objects[i]);
    end;
    if(i<AutorCB.Items.Count)and(pid^=EditorID)then AutorCB.ItemIndex:=i else AutorCB.ItemIndex:=0;
  end;
  AutorCB.Visible:=AutorFilterCB.Checked;
  //��������� ������� ����������
  SetBtn.Down:=true;
  LeftPn.Visible:=SetBtn.Down;
  EndDateTP.Date:=incday(StartOfTheMonth(now),-1);
  StDateTP.Date:=StartOfTheMonth(IncMonth(now,-1));
  SB.VertScrollBar.Position:=0;
  self.MainSetPn.Realign;
  self.GetFilterString;
  FirstStart:=true;
  self.PrepareBtnClick(self);
  //��������� �������� �������� � ������ ��������
  for f := 0 to MainQuery.FieldCount - 1 do begin
      fn:=MainQuery.Fields[f].FieldName;
      //�������� ���� �� �������
      if (fn<>'MODELID')and(fn<>'EDITORID')and(fn<>'REPORTID')and(fn<>'ID')and(fn<>'SHIFTID')and
        (fn<>'MAINDATE')and(fn<>'FACTORYID')and(fn<>'WORKID')and(fn<>'GROUPID')and(fn<>'ACCEPTDATE')and
      //  (fn<>'TOTPART')and(fn<>'TOTMOV')and(fn<>'TOTWORK')and(fn<>'TOTSUM')and(fn<>'RECCNT')and
        (fn<>'ISADDPART')and(fn<>'MAINTYPEID')and(fn<>'STATUS')and(fn<>'ERRORS') then begin
        Col:=Grid.Columns.Add;
        Col.FieldName:=fn;
        if DMod.FieldsTable.Lookup('FIELD',fn,'DESCR')<>NULL then begin
          Col.Title.Caption:=DMod.FieldsTable.Lookup('FIELD',fn,'DESCR');
          Col.Width:=DMod.FieldsTable.Lookup('FIELD',fn,'DISPLEN');
        end;
        //��� ���� ����� �� �� ��� � ������� �����
        if fn='SENTERNAME' then begin
          Col.Title.Caption:='���� �����';
          Col.Width:=120;
        end;
        if fn='REPDATE' then begin
          Col.Title.Caption:='����� ������';
          Col.Width:=80;
          //(WestQuery.FieldByName('REPDATE') as TDateTimeField).DisplayFormat:='MMMM YYYY';
        end;
        if fn='NOTE' then begin
          Col.Title.Caption:='����������';
          Col.Width:=350;
        end;
      end;
    end;
end;


//--------------------- ����������� ������ ������ ------------------------------

procedure TRepAutorWorkForm.CalkSum;
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

procedure TRepAutorWorkForm.ShowResultBtnClick(Sender: TObject);
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

procedure TRepAutorWorkForm.TopResultPnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then begin
    screen.Cursor:=crDrag;
    (sender as TPanel).Tag:=1;
    ResPnMov.X:=x;
    ResPnMov.Y:=y;
  end;
end;

procedure TRepAutorWorkForm.TopResultPnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (sender as TPanel).Tag=1 then begin
   ResultPn.Left:=ResultPn.Left+x-ResPnMov.X;
   ResultPn.Top:=ResultPn.Top+y-ResPnMov.Y;
  end;
end;

procedure TRepAutorWorkForm.TopResultPnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  screen.Cursor:=crDefault;
  (sender as TPanel).Tag:=0;
end;


end.
