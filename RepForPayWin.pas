unit RepForPayWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, StdCtrls, CheckLst, Buttons, ComCtrls, DB, ADODB,
  DBGrids, DBCtrls;

type
  TRepForPayForm = class(TForm)
    LeftPn: TPanel;
    MainQuery: TADOQuery;
    DS: TDataSource;
    TablePN: TPanel;
    DBG: TDBGrid;
    BottomPn: TPanel;
    PrepareBtn: TBitBtn;
    SaveBtn: TBitBtn;
    PrintBtn: TBitBtn;
    CloseBtn: TBitBtn;
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
    TopResultPn: TPanel;
    ShowResultBtn: TSpeedButton;
    TopPN: TPanel;
    SetBtn: TSpeedButton;
    CaptionLB: TLabel;
    CaptionDateLB: TLabel;
    SetSB: TScrollBox;
    MainSetPn: TPanel;
    PeriodLB: TLabel;
    GetDateBtn: TSpeedButton;
    StDateTP: TDateTimePicker;
    EndDateTP: TDateTimePicker;
    CheckedCB: TCheckBox;
    OnlFullVerifyCB: TCheckBox;
    AutorFilterCB: TCheckBox;
    AutorCB: TComboBox;
    MTypePn: TPanel;
    MTypeCheckBtn: TSpeedButton;
    MTypeClearBtn: TSpeedButton;
    MTypeFilterCB: TCheckBox;
    MTypeCB: TCheckListBox;
    CenterPN: TPanel;
    CenterCheckBtn: TSpeedButton;
    CenterClearBtn: TSpeedButton;
    CentresFilterCB: TCheckBox;
    CentresCB: TCheckListBox;
    SumQuery: TADOQuery;
    SumDS: TDataSource;
    SumOnlyCheckCB: TCheckBox;
    Bevel1: TBevel;
    PrintOnlyCheckCB: TCheckBox;
    SaveOnlyCheckCB: TCheckBox;
    Bevel2: TBevel;
    Label1: TLabel;
    CntTxt: TDBText;
    Bevel3: TBevel;
    RegionPN: TPanel;
    RegionSB: TCheckBox;
    RegionCB: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GetDateBtnClick(Sender: TObject);
    procedure DBGDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure MainQueryAfterPost(DataSet: TDataSet);
    procedure PrepareBtnClick(Sender: TObject);
    procedure TopResultPnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TopResultPnMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TopResultPnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShowResultBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure CenterCheckBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure ReportGetValue(const VarName: string; var Value: Variant);
    procedure SetBtnClick(Sender: TObject);
    procedure PrepareForm(rt: Integer);
    procedure DBGMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DBGCellClick(Column: TColumn);
    procedure MTypeCheckBtnClick(Sender: TObject);
    procedure CalkSum;
    procedure FilterChange(Sender: TObject);
    procedure SumOnlyCheckCBClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    RepType        : integer;
    ResPnMov       : TPoint;   //для перемещения панели итогов
    ResultPnHeight : integer;  //для перемещения панели итогов
    fname          : string;   //имя файла выгрузик
    SumSql,MainSql : string;   //для сохранения запросов из компонентов
    REPFilter      : string;   //передача фильтра в процедуру подсчета суммы
    RECFilter      : string;   //передача фильтра в процедуру подсчета суммы
    cansave        : boolean;  //флаг возможности сохранения
    FirstStart     : boolean;  //флаг первого запуска
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataMod, DateWin, DateUtils, PrintMod;

procedure TRepForPayForm.PrepareForm(rt: Integer);
var
  Table : TADOTable;
  str   : string;
  pid   : ^integer;
  i     : integer;
begin
  self.RepType:=rt;
  SumSQL:=string(SumQuery.SQL.Text);
  MainSQL:=string(MainQuery.SQL.Text);
  ResultPnHeight:=ResultPn.Height;
  CentresCB.Height:=200;
  SetSB.VertScrollBar.Position:=0;
  //насторойка сценария
  case RepType of
    0 : begin
        CaptionLB.Caption:='Выгрузка информации по СЧЕТАМ';
        AutorFilterCB.Checked:=true;
        CentresFilterCB.Checked:=false;
        OnlFullVerifyCB.Checked:=true;
        CheckedCB.Checked:=true;
        MTypeFilterCB.Checked:=false;
        RegionSB.Checked:=false;
        end;
    1 : begin
        CaptionLB.Caption:='Выгрузка информации по АКТАМ';
        AutorFilterCB.Checked:=true;
        CentresFilterCB.Checked:=false;
        OnlFullVerifyCB.Checked:=true;
        CheckedCB.Checked:=true;
        MTypeFilterCB.Checked:=false;
        RegionSB.Checked:=false;
        end;
  end;
  //настройка панели фильтра
  //даты
  StDateTP.Date:=StartOfTheMonth(now);
  EndDateTP.Date:=now;
  //список авторов
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
  //выбора региона
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
  
  //список типов
  with DMod.MainTypesTable do begin
    First;
    while not Eof do  begin
      MtypeCB.Items.Add(FieldByName('DESCR').AsString);
      MTypeCB.Checked[MTypeCB.Count-1]:=true;
      new(pid);
      pid^:=FieldByName('ID').AsInteger;
      MTypeCB.Items.Objects[MTypeCB.Count-1]:=TObject(pid);
      Next;
    end;
  end;
  //список сервисных центров
  Table:=TADOTable.Create(self);
  Table.Connection:=DMod.Connection;
  Table.TableName:='SERVCENTRES';
  Table.Open;
  with Table do begin
    First;
    while not Eof do begin
      if not FieldByName('ISDEL').AsBoolean then begin
        str:=FieldByName('DESCR').AsString;
        if length(FieldByName('CITY').AsString)>0 then str:=str+' ('+FieldByName('CITY').AsString+')';
        CentresCB.Items.Add(str);
        CentresCB.Checked[CentresCB.Count-1]:=true;
        new(pid);
        pid^:=FieldByName('ID').AsInteger;
        CentresCB.Items.Objects[CentresCB.Count-1]:=TObject(pid);
      end;
      Next;
    end;
  end;
  self.FilterChange(self);
  Table.Free;
  FirstStart:=true;
  self.FormResize(self);
  self.PrepareBtnClick(self);
end;

procedure TRepForPayForm.MainQueryAfterPost(DataSet: TDataSet);
begin
  DMod.SendMsgToSystem(WM_UPDATEREPORTLIST,0);
  DMod.SendMsgToSystem(WM_UPDATESEMTERLIST,0);
  cansave:=true;
end;

//------------------ события панели фильтра ------------------------------------

procedure TRepForPayForm.SetBtnClick(Sender: TObject);
var
  i : integer;
begin
  LeftPn.Visible:=SetBtn.Down;
  for I := 0 to SetSB.ControlCount-1 do
    if (SetSB.Controls[i] is TWinControl) then(SetSB.Controls[i] as TWinControl).Realign;
end;

procedure TRepForPayForm.GetDateBtnClick(Sender: TObject);
var
  sd,ed : TDate;
begin
  sd:=StDateTP.Date;
  ed:=EndDateTP.Date;
  if DateForm.GetPeriod(sd,ed) then begin
    StDateTP.Date:=sd;
    EndDateTP.Date:=ed;
    DBG.Font.Color:=clGray;
    DBG.Repaint;
  end;
end;

procedure TRepForPayForm.FilterChange(Sender: TObject);
begin
  CaptionDateLB.Caption:='по отчетам поступившим за период с '+FormatDateTime('dd.mm.yyyy',StDateTP.date)+' по '+FormatDateTime('dd.mm.yyyy',EndDateTP.date);
  AutorCB.Visible:=AutorFilterCB.Checked;
  CentresCB.Visible:=CentresFilterCB.Checked;
  CenterCheckBtn.Visible:=CentresFilterCB.Checked;
  CenterClearBtn.Visible:=CentresFilterCB.Checked;
  MTypeCB.Visible:=MTypeFilterCB.Checked;
  MTypeCheckBtn.Visible:=MTypeFilterCB.Checked;
  MTypeClearBtn.Visible:=MTypeFilterCB.Checked;
  RegionCB.Visible:=RegionSB.Checked;
  DBG.Font.Color:=clGray;
  DBG.Repaint;
  ResultPn.Enabled:=false;
end;

procedure TRepForPayForm.CenterCheckBtnClick(Sender: TObject);
var
  i : integer;
begin
  for I := 0 to CentresCB.Items.Count - 1 do
    CentresCB.Checked[i]:=((sender as TSpeedButton).Name='CenterCheckBtn');
  DBG.Font.Color:=clGray;
  DBG.Repaint;
end;

procedure TRepForPayForm.MTypeCheckBtnClick(Sender: TObject);
var
  i : integer;
begin
  for I := 0 to MTypeCB.Items.Count - 1 do
    MTypeCB.Checked[i]:=((sender as TSpeedButton).Name='MTypeCheckBtn');
  DBG.Font.Color:=clGray;
  DBG.Repaint;
end;

//------------------------ основные кнопки формы -------------------------------

procedure TRepForPayForm.PrepareBtnClick(Sender: TObject);
var
  filter, str : string;
  pid    : ^integer;
  i      : integer;
  sql    : string;
begin
  sql:=MainSql;
  //меняем поля в запросе в зависимости от типа оплата/учет
  case RepType of
    0   :STR:=' REP.[PAIDCHECK] AS FCHECK, REP.[FIRSTINVOICENUMBER] AS INVOICENUMBER, REP.[FIRSTINVOICEDATE] AS INVOICEDATE';
    1   :STR:=' REP.[RECORDEDCHECK] AS FCHECK, REP.[INVOICENUMBER], REP.[INVOICEDATE]';
  end;
  sql:=stringreplace(sql,'/INVOICE/',STR,[rfReplaceAll]);
  //------------------ ФИЛЬТР ПО ЗАПИСЯМ (ПО ТИПУ ПРОДУКЦИИ) -------------------
  filter:='';
  if MTypeFilterCB.Checked then begin
    STR:='';
    for i := 0 to self.MTypeCB.Items.Count-1 do
      if MTypeCB.Checked[i] then begin
        pid:=pointer(MTypeCB.Items.Objects[i]);
        STR:=STR+'(REC.[MAINTYPEID]='+inttostr(pid^)+') OR ';
      end;
    delete(STR,Length(STR)-4,4);
    if Length(STR)>0 then filter:=' AND ('+STR+'))';
  end;
  RECFilter:=filter;
  sql:=stringreplace(sql,'/RECFILTER/',RECFilter,[rfReplaceAll]);
  //------------------ ФИЛЬТР ПО ОТЧЕТАМ  --------------------------------------
  //диапазон дат
  filter:=chr(13)+'(REP.[DOCDATE] BETWEEN ';
  filter:=filter+QuotedStr(FormatDateTime('yyyymmdd',StartOfTheDay(StDateTP.date)))+' AND ';
  filter:=filter+QuotedStr(FormatDateTime('yyyymmdd',EndOfTheday(EndDateTP.date)))+')';
  //только принятые на 100% отчеты
  if OnlFullVerifyCB.Checked then filter:=filter+' AND (REP.[VERIFYST]=100)';
  //только не выгружавшиеся ранее
  if CheckedCB.Checked then case RepType of
      0 : filter:=filter+' AND (REP.[PAIDCHECK]=0)';
      1 : filter:=filter+' AND (REP.[RECORDEDCHECK]=0)';
    end;
  //отбор по автору
  if AutorFilterCB.Checked then begin
    pid:=pointer(AutorCB.Items.Objects[AutorCB.ItemIndex]);
    filter:=filter+' AND (REP.[EMPLID]='+IntToStr(pid^)+')';
  end;
  //отбор по региону
  if RegionSB.Checked then begin
    pid:=pointer(RegionCB.Items.Objects[RegionCB.ItemIndex]);
    filter:=filter+' AND (SNT.[REGIONID]='+IntToStr(pid^)+')';
  end;
  //отбор по сервисному центру
  if CentresFilterCB.Checked then begin
    STR:='';
    for i := 0 to self.CentresCB.Items.Count-1 do
      if CentresCB.Checked[i] then begin
        pid:=pointer(CentresCB.Items.Objects[i]);
        STR:=STR+'(SNT.[ID]='+inttostr(pid^)+') OR ';
      end;
    delete(STR,Length(STR)-4,4);
    if Length(STR)>0 then filter:=filter+' AND ('+STR+'))';
  end;
  //формируем запрос
  REPFilter:=filter;
  sql:=stringreplace(sql,'/REPFILTER/',REPFilter,[rfReplaceAll]);
  MainQuery.Close;
  MainQuery.SQL.Clear;
  MainQuery.SQL.Add(sql);
  DBG.Font.Color:=clBlack;
  MainQuery.Open;
  MainQuery.Filter:='TOTALSUM>0';
  MainQuery.Filtered:=true;
  cansave:=true;
  SaveBtn.Enabled:=not(MainQuery.IsEmpty);
  DBG.Enabled:=not(MainQuery.IsEmpty);
  PrintBtn.Enabled:=not(MainQuery.IsEmpty);
  if (MainQuery.IsEmpty)and(not FirstStart) then MessageDLG('Записи по вашему запросу не найдены !'+chr(13)+
    'Измените условия отбора и повторите запрос.',mtWarning,[mbOK],0);
  if FirstStart then FirstStart:=false;
  if not MainQuery.IsEmpty then begin
      self.CalkSum;
      ResultPn.Visible:=true;
      ResultPn.Enabled:=true;
      if ShowResultBtn.Tag=1 then self.ShowResultBtnClick(ShowResultBtn);
    end;
end;

procedure TRepForPayForm.CalkSum;
var
  sql, filter : string;
begin
  SumQuery.Close;
  SumQuery.SQL.Clear;
  if SumOnlyCheckCB.Checked then case RepType of
    0 : filter:=' AND (REP.[PAIDCHECK]=1) AND '+REPFilter+RECFilter;
    1 : filter:=' AND (REP.[RECORDEDCHECK]=1) AND '+REPFilter+RECFilter;
  end else filter:=' AND '+REPFilter+RECFilter;
  sql:=stringreplace(SumSQL,'/FILTER/',filter,[rfReplaceAll]);
  //SHOWMESSAGE(SQL);
  SumQuery.SQL.Add(sql);
  SumQuery.Open;
end;

procedure TRepForPayForm.SaveBtnClick(Sender: TObject);
var
  strs : TStringList;
  str  : string;
begin
  if not cansave then
    if MessageDlg('Некоторые строки не заполнены !'+chr(13)+
    'Все равно выгрузить ?',mtWarning,[mbYes,mbNo],0)=mrNo then Abort;
  if MainQuery.Modified then MainQuery.Post;
  DMod.SaveDlg.Title:='Выгрузка данных для 1С';
  DMod.SaveDlg.DefaultExt:='*.txt';
  DMod.SaveDlg.Filter:='Текстовый документ|*.txt';
  if ((length(fname)=0)and(DMod.SaveDlg.Execute))or(Length(fname)>0) then begin
    fname:=DMod.SaveDlg.FileName;
    strs:=TStringList.Create;
    MainQuery.First;
    while not MainQuery.Eof do begin
      if (not SaveOnlyCheckCB.Checked)or((SaveOnlyCheckCB.Checked)
      and(MainQuery.FieldByName('FCHECK').AsBoolean)) then begin
        str:=MainQuery.FieldByName('CODE').AsString;
        while(Length(str)>0)and(str[Length(str)]=' ')do delete(str,Length(str),1);
        if Length(str)>0 then begin
          str:='"'+MainQuery.FieldByName('CODE').AsString+'",';
          str:=str+'"'+MainQuery.FieldByName('DESCR').AsString+' ('+MainQuery.FieldByName('CITY').AsString+')",';
          str:=str+'"'+MainQuery.FieldByName('PARTSUM').AsString+'",';
          str:=str+'"'+MainQuery.FieldByName('MOVSUM').AsString+'",';
          str:=str+'"'+MainQuery.FieldByName('WORKPRICE').AsString+'",';
          str:=str+'"'+MainQuery.FieldByName('INVOICENUMBER').AsString+'",';
          str:=str+'"'+MainQuery.FieldByName('INVOICEDATE').AsString+'",';
          str:=str+'"За '+MainQuery.FieldByName('REPDATE').AsString+'. '+MainQuery.FieldByName('NOTE').AsString+'"';
          strs.Add(str);
        end else begin
          MessageDLG('Ошибка в коде по 1С для "'+MainQuery.FieldByName('DESCR').AsString+'"!'+chr(13)+
            'Строка не выгружена. Отметка о выгрузке снята !',mtError,[mbOk],0);
          if not MainQuery.Modified then  MainQuery.Edit;
          MainQuery.FieldByName('FCHECK').AsBoolean:=false;
          MainQuery.Post;
          MainQuery.Refresh;
        end;
      end;
      MainQuery.Next;
    end;
    strs.SaveToFile(fname);
    strs.Free;
  end;
end;

procedure TRepForPayForm.CloseBtnClick(Sender: TObject);
begin
  self.Close;
end;

procedure TRepForPayForm.PrintBtnClick(Sender: TObject);
var
  PrMod: TPrMod;
begin
  if FileExists(MyPath+'frxForPay.fr3') then begin
    PrMod:=TPrMod.Create(application);
    PrMod.formcaption:=self.Caption;
    MainQuery.DisableControls;
    //если установлена галка "печатать только отмеченные"
    if PrintOnlyCheckCB.Checked then begin
      MainQuery.Filter:='FCHECK = 1';
      MainQuery.Filtered:=true;
    end;
    with PrMod do begin
      frxData1.DataSet:=self.MainQuery;
      Report.OnGetValue:=self.ReportGetValue;
      Report.LoadFromFile(MyPath+'frxForPay.fr3');
      Report.PrepareReport(true);
      Report.ShowPreparedReport;
    end;
    if MainQuery.Filtered then MainQuery.Filtered:=false;
    MainQuery.EnableControls;
  end;
end;

procedure TRepForPayForm.ReportGetValue(const VarName: string; var Value: Variant);
var
  repfilter,str : string;
  i : integer;
begin
  if comparetext(varname,'CAPTION')=0 then begin
    case RepType of
      0 : value:='Выгрузка информации для оплаты';
      1 : value:='Выгрузка информации для учета затрат';
    end;
    value:=AnsiUpperCase(value);
  end;
  if comparetext(varname,'FILTER')=0 then begin
    //формирование заголовка с данными о фильтре
    repfilter:='';
    if CheckedCB.Checked then repfilter:=repfilter+'не выгружавшиеся ранее';
    if OnlFullVerifyCB.Checked then repfilter:=repfilter+', только принятые на 100% отчеты';
    if AutorFilterCB.Checked then repfilter:=repfilter+', по автору "'+AutorCB.Text+'"';
    if MTypeFilterCB.Checked then begin
      STR:='';
      for i := 0 to self.MTypeCB.Items.Count-1 do if MTypeCB.Checked[i] then STR:=STR+', '+MTypeCB.Items[i];
      delete(str,1,2);
      if Length(STR)>0 then repfilter:=repfilter+chr(13)+'по типам: '+str;
    end;
    if CentresFilterCB.Checked then begin
      STR:='';
      for i := 0 to self.CentresCB.Items.Count-1 do if CentresCB.Checked[i] then STR:=STR+', '+CentresCB.Items[i];
      delete(str,1,2);
      if Length(STR)>0 then repfilter:=repfilter+chr(13)+'по списку сервисных центров: '+str;
    end;
    value:=repfilter;
  end;
  if comparetext(varname,'PERIOD')=0 then value:='по отчетам поступившим за период с '+FormatDateTime('dd.mm.yyyy',StDateTP.date)+
    ' по '+FormatDateTime('dd.mm.yyyy',EndDateTP.date)+' ('+SumQuery.FieldByName('CNT').AsString+' отчета )';
  if comparetext(varname,'DOCNAME')=0 then
    case RepType of
      0 : value:='Счет';
      1 : value:='Акт';
    end;
  if comparetext(varname,'FCHECK')=0 then
    if MainQuery.FieldByName('FCHECK').AsBoolean then value:='>' else value:='';
end;

//--------------------- перемещение панели итогов ------------------------------

procedure TRepForPayForm.ShowResultBtnClick(Sender: TObject);
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

procedure TRepForPayForm.SumOnlyCheckCBClick(Sender: TObject);
begin
  self.CalkSum;
end;

procedure TRepForPayForm.TopResultPnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then begin
    screen.Cursor:=crDrag;
    (sender as TPanel).Tag:=1;
    ResPnMov.X:=x;
    ResPnMov.Y:=y;
  end;
end;

procedure TRepForPayForm.TopResultPnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (sender as TPanel).Tag=1 then begin
   ResultPn.Left:=ResultPn.Left+x-ResPnMov.X;
   ResultPn.Top:=ResultPn.Top+y-ResPnMov.Y;
  end;
end;

procedure TRepForPayForm.TopResultPnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  screen.Cursor:=crDefault;
  (sender as TPanel).Tag:=0;
end;

//--------------------- события формы ------------------------------------------

procedure TRepForPayForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PostMessage(application.MainForm.Handle,WM_CLOSECHILD,self.Tag,0);
  Action:=caFree;
end;

procedure TRepForPayForm.FormResize(Sender: TObject);
var
  i,w : integer;
begin
  w:=0;
  for I := 0 to DBG.Columns.Count-2 do w:=w+DBG.Columns[i].Width;
  if (DBG.ClientWidth-w-40)>0 then DBG.Columns[DBG.Columns.Count-1].Width:=DBG.ClientWidth-w-40;
end;

//------------------------------ события таблицы -------------------------------

procedure TRepForPayForm.DBGDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  bmp  : TBitMap;
  proc : integer;
  rct  : TRect;
begin
  //столбец отметки об оплате
  if not(DBG.Enabled) then abort;
  if (Column.FieldName='FCHECK')then begin
    rct:=rect;
    DBG.Canvas.Brush.Color:=clWhite;
    DBG.Canvas.FillRect(rect);
    bmp:=TBitMap.Create;
    if MainQuery.FieldByName('FCHECK').AsBoolean then DMod.ImageList.GetBitmap(57,bmp)
      else DMod.ImageList.GetBitmap(58,bmp);
    proc:=trunc((rct.Bottom-rct.Top-bmp.Height)/2);
    DBG.Canvas.Draw(rct.Left+2,rct.Top+proc,bmp);
    bmp.free;
  end else begin
    //если строка не отмечена выводим все серым
    //если отмечена выделяем пустые ячейки если они есть
    //if MainQuery.FieldByName('FCHECK').AsBoolean=false then begin
      if (not MainQuery.IsEmpty)and(((Column.FieldName='CODE')and(Length(MainQuery.FieldByName('CODE').AsString)=0))
        or((Column.FieldName='INVOICENUMBER')and(Length(MainQuery.FieldByName('INVOICENUMBER').AsString)=0))
        or((Column.FieldName='INVOICEDATE')and(Length(MainQuery.FieldByName('INVOICEDATE').AsString)=0))) then begin
          DBG.Canvas.Brush.Color:=clERROR;
          DBG.Canvas.FillRect(rect);
          cansave:=false;
      end else (sender as TDBGrid).DefaultDrawDataCell(rect,Column.Field,state);
    {end else  begin
      rct:=rect;
      DBG.Canvas.Brush.Color:=clWhite;
      DBG.Canvas.FillRect(rect);
      DBG.Canvas.Font.Color:=clGray;
      inc(rct.Left,2);
      inc(rct.Top,2);
      str:=MainQuery.FieldByName(Column.FieldName).AsString;
      DrawText(DBG.Canvas.Handle,pchar(str),Length(str),rct,0);
    end; }
  end;
end;

procedure TRepForPayForm.DBGMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  gpnt : TGridCoord;
begin
  gpnt:=DBG.MouseCoord(x,y);
  if (not MainQuery.IsEmpty)and(gpnt.X>0)and(DBG.Columns[gpnt.X-1].FieldName='FCHECK') then DBG.Cursor:=crHandPoint
    else DBG.Cursor:=crDefault;
end;

procedure TRepForPayForm.DBGCellClick(Column: TColumn);
begin
  if (not MainQuery.IsEmpty)and(MainQuery.FieldByName('FCHECK').AsBoolean=false)and((Column.FieldName='CODE')or(Column.FieldName='INVOICENUMBER')
    or(Column.FieldName='INVOICEDATE')) then DBG.Options:=DBG.Options+[dgEditing] else DBG.Options:=DBG.Options-[dgEditing];
  if (not MainQuery.IsEmpty)and(Column.FieldName='FCHECK') then begin
    if not MainQuery.Modified then MainQuery.Edit;
    if Column.FieldName='FCHECK' then MainQuery.FieldByName('FCHECK').AsBoolean:=not MainQuery.FieldByName('FCHECK').AsBoolean;
    MainQuery.Post;
    if SumOnlyCheckCB.Checked then self.CalkSum;
    DMod.SendMsgToSystem(WM_UPDATEREPORTLIST,self.Tag);
  end;
end;

end.
