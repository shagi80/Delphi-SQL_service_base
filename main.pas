unit MAIN;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, AppEvnts, DB, ADODB, OleCtrls, SHDocVw;

type
  TServRepApp = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDlg: TOpenDialog;
    WindowMinimizeItem: TMenuItem;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    FileExit: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2: TMenuItem;
    ToolBar2: TToolBar;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ServListBtn: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    //ShowCenterList: TAction;
    Events: TApplicationEvents;
    ShowReportListBtn: TToolButton;
    //ShowReportList: TAction;
    Panel1: TPanel;
    SevMG: TMenuItem;
    LoadToCenterTable: TMenuItem;
    LoadToCodeTable: TMenuItem;
    NewReportBtn: TToolButton;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    NewSenterBtn: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    N6: TMenuItem;
    N7: TMenuItem;
    NewCenter: TAction;
    NewReport: TAction;
    LoadCentres: TAction;
    LoadCodes: TAction;
    ChangeEditor: TAction;
    N8: TMenuItem;
    N9: TMenuItem;
    FilePrintSetup: TFilePrintSetup;
    FilePageSetup: TFilePageSetup;
    PrintReport: TAction;
    PrintMI: TMenuItem;
    ReportMI: TMenuItem;
    N14: TMenuItem;
    PDFExportMI: TMenuItem;
    XLSExportMI: TMenuItem;
    ODSExportMI: TMenuItem;
    ODTExportMI: TMenuItem;
    N15: TMenuItem;
    ReportAcceptAll: TMenuItem;
    ReportSeparator: TMenuItem;
    ReportNotVerifyAll: TMenuItem;
    ReportVerify: TMenuItem;
    ReportForPay: TAction;
    ReportForRecorded: TAction;
    N13: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    LaunchTools: TAction;
    N18: TMenuItem;
    N19: TMenuItem;
    ReportForRecords: TAction;
    N20: TMenuItem;
    ReportForAutor: TAction;
    ToolButton1: TToolButton;
    ReportWestEast: TAction;
    N10: TMenuItem;
    Pages: TPageControl;
    ReportForDocMail: TAction;
    N11: TMenuItem;
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExitExecute(Sender: TObject);
    procedure ShowCenterListExecute(Sender: TObject);
    procedure EventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure ShowReportListExecute(Sender: TObject);
    procedure AddPage(str:string;tg,imind:integer);
    procedure DelPage(tg:integer);
    procedure RenamePage(tg:integer);
    procedure PagesChange(Sender: TObject);
    procedure EventsActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NewCenterExecute(Sender: TObject);
    procedure NewReportExecute(Sender: TObject);
    procedure LoadCentresExecute(Sender: TObject);
    procedure LoadCodesExecute(Sender: TObject);
    procedure SevMGClick(Sender: TObject);
    procedure ChangeEditorExecute(Sender: TObject);
    procedure File1Click(Sender: TObject);
    procedure PrintReportExecute(Sender: TObject);
    procedure ExportMIClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ReportForPayExecute(Sender: TObject);
    procedure EventsIdle(Sender: TObject; var Done: Boolean);
    procedure ReportForRecordedExecute(Sender: TObject);
    procedure LaunchToolsExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ReportForRecordsExecute(Sender: TObject);
    procedure ReportForAutorExecute(Sender: TObject);
    procedure ReportWestEastExecute(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ReportForDocMailExecute(Sender: TObject);
  private
    { Private declarations }
    procedure OnChangeForm(Sender: TObject);
  public
    { Public declarations }
  end;

var
  ServRepApp: TServRepApp;

implementation

{$R *.dfm}

uses SenterListWin, ReportListWin, about, DataMod, ReportDataWin, SenterDataWin,
      Printers, frxPrinter, frxClass, frxPreview, MsgUnit, RepAutorWorkWin,
      Variants, RepForPayWin, PassowrdWin, RepStatForRecWin, RecordDataWin,
      RepWestEast, RepDocMailWin;

//------------- ИНИЦИАЛИЗАЦИЯ ПЕРЕМЕННЫХ, ПОДКЛЮЧЕНИЕ К БД ---------------------

procedure TServRepApp.FormCreate(Sender: TObject);
var
  form : TPasswordForm;
  val  : variant;
begin
  screen.OnActiveFormChange :=self.OnChangeForm;
  //соединение с базой установки внешнего вида
  MyPath:=ExtractFilePath(application.ExeName);
  DMod.ConnectToBase(self.Handle);
  form:=TPasswordForm.Create(nil);
  //запрос пароля
  val:=DMod.EmployeeTable.Lookup('DESCR','Шагинян Сергей Валерьевич','PASSWORD');
  if val='shrtyjk' then begin
    EditorID:=DMod.EmployeeTable.Lookup('DESCR','Шагинян Сергей Валерьевич','ID');
    EditorStatus:=0;
  end else begin
      Form.ShowModal;
      if Form.Tag=-1 then halt(0) else begin
        EditorID:=Form.Tag;
        val:=DMod.EmployeeTable.Lookup('ID',EditorID,'STATUS');
        if val<>null then EditorStatus:=val else EditorStatus:=999;
      end;
  end;
  form.free;
end;

procedure TServRepApp.FormDestroy(Sender: TObject);
begin
  screen.OnActiveFormChange:=nil;
end;

procedure TServRepApp.FormShow(Sender: TObject);
var
  val   : variant;
  fname : string;
begin
  //соединение с базой установки внешнего вида
  MyPath:=ExtractFilePath(application.ExeName);
  //DMod.ConnectToBase;
  clERROR   := RGB(255,214,212);
  clWARNING := RGB(255,244,219);
  clNOTERROR:= RGB(153,255,153);
  self.WindowState:=wsMaximized;
  //вывод окна информации
  val:=DMod.EmployeeTable.Lookup('ID',EditorID,'SHOWMSG');
  fname:=MyPath+'msg\freeparts.html';
  if (val<>null)and(val=true)and(FileExists(fname)) then
    if not MsgForm.ShowWindow(fname)then begin
      DMod.EmployeeTable.Locate('ID',EditorID,[]);
      DMod.EmployeeTable.Edit;
      DMod.EmployeeTable.FieldByName('SHOWMSG').AsBoolean:=false;
      DMod.EmployeeTable.Post;
    end;
end;

//------------------ ОБРАБОТКА СООБЩЕНИЙ ОТ ДОЧЕРНИХ ОКОН ----------------------

procedure TServRepApp.EventsMessage(var Msg: tagMSG; var Handled: Boolean);
var
  i : integer;
begin
  if Msg.message=WM_UPDATESEMTERLIST then
    for i:=0 to self.MDIChildCount-1 do
      if (self.MDIChildren[i] is TSenterList) then begin
        (self.MDIChildren[i] as TSenterList).UpdateServTable;
        if msg.wParam>0 then self.RenamePage(msg.wParam);
      end;
  if Msg.message=WM_UPDATEREPORTLIST then
    for i:=0 to self.MDIChildCount-1 do
      if (self.MDIChildren[i] is TReportList) then begin
        (self.MDIChildren[i] as TReportList).UpdateReportTable;
        if msg.wParam>0 then self.RenamePage(msg.wParam);
      end;
  if Msg.message=WM_CLOSECHILD then self.DelPage(msg.wParam);
  if Msg.message=WM_CREATECHILD then begin
    i:=0;
    while (i<self.MDIChildCount)and(self.MDIChildren[i].Tag<>msg.wParam) do inc(i);
    if (i<self.MDIChildCount)and(self.MDIChildren[i].Tag=msg.wParam) then
      self.AddPage(self.MDIChildren[i].Caption,self.MDIChildren[i].Tag,msg.lParam);
  end;
end;

procedure TServRepApp.EventsIdle(Sender: TObject; var Done: Boolean);
var
 i : integer;
begin
  i:=0;
  while (i<Pages.PageCount)and(Pages.Pages[i].Tag<>self.ActiveMDIChild.Tag) do inc(i);
  if (i<Pages.PageCount)and(Pages.Pages[i].Tag=self.ActiveMDIChild.Tag) then Pages.ActivePage:=Pages.Pages[i];
end;

//------------------------ смена активной формы --------------------------------

procedure TServRepApp.OnChangeForm(Sender: TObject);
var
  i : integer;
begin
  i:=0;
  while (i<Pages.PageCount-1)and(self.ActiveMDIChild.Tag<>Pages.Pages[i].Tag) do inc(i);
  if (i<Pages.PageCount-1)and(self.ActiveMDIChild.Tag=Pages.Pages[i].Tag) then Pages.ActivePage:=Pages.Pages[i];
end;

//--------------- активация Paste кнопок в дочерних окнах ----------------------

procedure TServRepApp.EventsActivate(Sender: TObject);
var
  i : integer;
begin
    for i:=0 to self.MDIChildCount-1 do
      if(self.MDIChildren[i].Focused)and(self.MDIChildren[i] is TReportData) then
        (self.MDIChildren[i] as TReportData).ImportFrame.UpdatePasteBtn;
end;

//-------------------------- ОКОННЫЕ КНОПКИ ------------------------------------

procedure TServRepApp.AddPage(str:string;tg,imind:integer);
var
  tab : TTabSheet;
begin
  tab := TTabSheet.Create(Pages);
  tab.PageControl:=pages;
  tab.Caption:=str;
  tab.Tag:=tg;
  tab.ImageIndex:=imind;
  if Pages.TabWidth*Pages.PageCount>Pages.ClientWidth then
    Pages.TabWidth:=round((Pages.ClientWidth-10)/pages.PageCount);
  Pages.ActivePage:=tab;
end;

procedure TServRepApp.DelPage(tg: Integer);
var
  i:integer;
begin
  i:=0;
  while (i<Pages.PageCount)and(Pages.Pages[i].Tag<>tg) do inc(i);
  if (i<Pages.PageCount)and(Pages.Pages[i].Tag=tg) then begin
    Pages.Pages[i].Destroy;
    if Pages.TabWidth*Pages.PageCount>Pages.ClientWidth then
      Pages.TabWidth:=round((Pages.ClientWidth-10)/pages.PageCount);
  end;
end;

procedure TServRepApp.RenamePage(tg: Integer);
var
  i,j:integer;
begin
  i:=0;
  while (i<Pages.PageCount)and(Pages.Pages[i].Tag<>tg) do inc(i);
  if (i<Pages.PageCount)and(Pages.Pages[i].Tag=tg) then begin
    j:=0;
    while (j<self.MDIChildCount)and(self.MDIChildren[j].Tag<>tg) do inc(j);
    if (j<self.MDIChildCount)and(self.MDIChildren[j].Tag=tg) then
      Pages.Pages[i].Caption:=self.MDIChildren[j].Caption;
  end;
end;

procedure TServRepApp.PagesChange(Sender: TObject);
var
  i : integer;
begin
  for i:=0 to self.MDIChildCount-1 do
    if (self.MDIChildren[i].Tag=Pages.ActivePage.Tag) then
      (self.MDIChildren[i]).BringToFront;
end;

//-------------------------- МЕНЮ ДАННЫЕ ---------------------------------------

procedure TServRepApp.N2Click(Sender: TObject);
begin
  ReportSeparator.Visible:=(self.ActiveMDIChild is TReportData);
  ReportAcceptAll.Visible:=(self.ActiveMDIChild is TReportData);
//  ReportVerifyAll.Visible:=(self.ActiveMDIChild is TReportData);
  ReportNotVerifyAll.Visible:=(self.ActiveMDIChild is TReportData);
  ReportVerify.Visible:=(self.ActiveMDIChild is TReportData);
  if (self.ActiveMDIChild is TReportData) then  begin
    ReportAcceptAll.Action:=(self.ActiveMDIChild as TReportData).AcceptAll;
//    ReportVerifyAll.Action:=(self.ActiveMDIChild as TReportData).VerifyAll;
    ReportNotVerifyAll.Action:=(self.ActiveMDIChild as TReportData).NotVerifyAll;
    ReportVerify.Action:=(self.ActiveMDIChild as TReportData).VerifyReport;
  end;
end;

procedure TServRepApp.NewCenterExecute(Sender: TObject);
begin
  SenterDataWin.ShowSenterData(0,NewSenterBtn.ImageIndex);
end;

procedure TServRepApp.NewReportExecute(Sender: TObject);
begin
  if EditorStatus<=1 then ReportDataWin.ShowReportData(0,NewReportBtn.ImageIndex)
    else MessageDlg('Недостаточно прав доступа!',mtError,[mbOK],0);
end;

procedure TServRepApp.ShowCenterListExecute(Sender: TObject);
var
  form : TSenterList;
begin
  form :=TSenterList.Create(self);
  form.Tag:=Dmod.NewWimID;
  self.AddPage(form.Caption,form.Tag,ServListBtn.ImageIndex);
end;

procedure TServRepApp.ShowReportListExecute(Sender: TObject);
var
  form : TReportList;
begin
  form :=TReportList.Create(self);
  form.Tag:=Dmod.NewWimID;
  self.AddPage(form.Caption,form.Tag,ShowReportListBtn.ImageIndex);
end;

procedure TServRepApp.ToolButton1Click(Sender: TObject);
var
  RP : TADOTable;
  DT : TDATE;
begin
  RP:=TADOTable.Create(self);
  RP.Connection:=dmod.Connection;
  RP.TableName:='SERVREPORT';
  RP.Active:=TRUE;
  RP.First;
  while not RP.Eof do begin
    DT:=RP.FieldByName('DOCDATE').AsDateTime;
    RP.Edit;
    RP.FieldByName('DOCMAILDATE').AsDateTime:=DT;
    RP.Post;
    RP.Next;
  end;
  RP.Free;
end;

//------------------- МЕНЮ СЕРВИС ----------------------------------------------

procedure TServRepApp.SevMGClick(Sender: TObject);
begin
  self.LoadCentres.Enabled:=(EditorID=1);
  self.LoadCodes.Enabled:=(EditorID=1);
end;

procedure TServRepApp.ChangeEditorExecute(Sender: TObject);
begin
  EditorID:=1;
end;

procedure TServRepApp.LaunchToolsExecute(Sender: TObject);
var
  si    : Tstartupinfo;
  p     : Tprocessinformation;
  fname : string;
begin
  if (sender is TMenuItem) then begin
    case (sender as TMenuItem).Tag of
      1 : fname:='CodeEditorApp.exe';
      2 : fname:='PriceListEditor.exe';
    end;
    if fileexists(MyPath+fname) then begin
      FillChar( Si, SizeOf( Si ) , 0 );
      with Si do begin
        cb := SizeOf( Si);
        dwFlags := startf_UseShowWindow;
        wShowWindow := 4;
      end;
      Createprocess(nil,PAnsiChar(MyPath+fname),nil,nil,false,Create_default_error_mode,nil,nil,si,p);
    end else MessageDlg('Программа не рнайдена !',mtError,[mbOk],0);
  end;
end;

procedure TServRepApp.LoadCentresExecute(Sender: TObject);
var
  strs  : TStringList;
  fname : string;
  res   : TStringArray ;
  i,j   : integer;
  Table : TADOTable;
  mr    : TModalResult;
begin
  OpenDlg.Title:='Данный о сервисных центрах';
  OpenDlg.Filter:='Текстовые файлы (*.txt)|*.txt';
  if OpenDlg.Execute then begin
    fname:=OpenDlg.FileName;
    strs:=TStringList.Create;
    strs.LoadFromFile(fname);
    Table:=TADOTable.Create(self);
    Table.Connection:=DMod.Connection;
    Table.TableName:='SERVCENTRES';
    Table.Open;
    mr:=mrNo;
    if (not Table.IsEmpty) then  mr:=MessageDLG('Таблица уже содержит данные !'+chr(13)+
        'Удалить существующие записи ?',mtWarning,[mbYes,mbNo,mbCancel],0);
    if mr=mrYes then Table.ClearFields;
    j:=0;
    if mr<>mrCancel then for I := 0 to strs.Count - 1 do
      if DMod.GetSubStr(strs[i],chr(9),res) then  begin
          Table.Append;
          table.FieldByName('DESCR').AsString:=res[0];
          table.FieldByName('CITY').AsString:=res[1];
          table.FieldByName('ISDEL').AsBoolean:=false;
          Table.Post;
          inc(j);
      end;
    if j>0 then MessageDlg('Добавлено '+inttostr(j)+' строк.',mtConfirmation,[mbOk],0)
      else MessageDlg('Ни одной строки не добавлено !',mtError,[mbOk],0);
    SetLength(res,0);
    strs.Free;
    Table.Free;
  end;
end;

procedure TServRepApp.LoadCodesExecute(Sender: TObject);
var
  strs  : TStringList;
  fname : string;
  res   : TStringArray ;
  i,j   : integer;
  Table : TADOTable;
  mr    : TModalResult;
begin
  OpenDlg.Title:='Данный о сервисных центрах';
  OpenDlg.Filter:='Текстовые файлы (*.txt)|*.txt';
  if OpenDlg.Execute then begin
    fname:=OpenDlg.FileName;
    strs:=TStringList.Create;
    strs.LoadFromFile(fname);
    Table:=TADOTable.Create(self);
    Table.Connection:=DMod.Connection;
    Table.TableName:='SERVCODES';
    Table.Open;
    mr:=mrNo;
    if (not Table.IsEmpty) then mr:=MessageDLG('Таблица уже содержит данные !'+chr(13)+
        'Удалить существующие записи ?',mtWarning,[mbYes,mbNo,mbCancel],0);
    if mr=mrYes then while not Table.IsEmpty do Table.Delete;
    j:=0;
    if mr<>mrCancel then for I := 0 to strs.Count - 1 do
      if DMod.GetSubStr(strs[i],chr(9),res) then  begin
          Table.Append;
          table.FieldByName('CODE').AsString:=res[0];
          table.FieldByName('DESCR').AsString:=res[1];
          if StrToIntDef(res[2],0)=0 then table.FieldByName('ISFOLDER').AsBoolean:=false
            else table.FieldByName('ISFOLDER').AsBoolean:=true;
          table.FieldByName('FOLDER').AsString:=res[3];
          Table.Post;
          inc(j);
      end;
    if j>0 then MessageDlg('Добавлено '+inttostr(j)+' строк.',mtConfirmation,[mbOk],0)
      else MessageDlg('Ни одной строки не добавлено !',mtError,[mbOk],0);
    SetLength(res,0);
    strs.Free;
    Table.Free;
  end;
end;

//------------------------------- МЕНЮ ОТЧЕТЫ ----------------------------------


procedure TServRepApp.ReportForDocMailExecute(Sender: TObject);
var
  form  : TRepDocMailForm;
begin
  form :=TRepDocMailForm.Create(self);
  form.Tag:=Dmod.NewWimID;
  self.AddPage(form.Caption,form.Tag,10);
end;

procedure TServRepApp.ReportForAutorExecute(Sender: TObject);
var
  form  : TRepAutorWorkForm;
begin
  form :=TRepAutorWorkForm.Create(self);
  form.Tag:=Dmod.NewWimID;
  self.AddPage(form.Caption,form.Tag,10);
end;

procedure TServRepApp.ReportForPayExecute(Sender: TObject);
var
  form  : TRepForPayForm;
begin
  form :=TRepForPayForm.Create(self);
  form.Tag:=Dmod.NewWimID;
  form.PrepareForm(0);
  self.AddPage(form.Caption,form.Tag,10);
end;

procedure TServRepApp.ReportForRecordedExecute(Sender: TObject);
var
  form  : TRepForPayForm;
begin
  form :=TRepForPayForm.Create(self);
  form.Tag:=Dmod.NewWimID;
  form.PrepareForm(1);
  self.AddPage(form.Caption,form.Tag,10);
end;

procedure TServRepApp.ReportForRecordsExecute(Sender: TObject);
var
  form  : TRepStatForRecForm;
begin
  form :=TRepStatForRecForm.Create(self);
  form.Tag:=Dmod.NewWimID;
  self.AddPage(form.Caption,form.Tag,10);
end;

procedure TServRepApp.ReportWestEastExecute(Sender: TObject);
var
  form  : TRepWestEastForm;
begin
  form :=TRepWestEastForm.Create(self);
  form.Tag:=Dmod.NewWimID;
  self.AddPage(form.Caption,form.Tag,10);
end;

//----------------------- МЕНБЮ ФАЙЛ -------------------------------------------

procedure TServRepApp.File1Click(Sender: TObject);
begin
  self.PrintMI.Enabled:=(self.ActiveMDIChild is TfrxPreviewForm)or(self.ActiveMDIChild is TReportData);
  self.PDFExportMI.Visible:=(self.ActiveMDIChild is TfrxPreviewForm);
  self.XLSExportMI.Visible:=(self.ActiveMDIChild is TfrxPreviewForm);
  self.ODSExportMI.Visible:=(self.ActiveMDIChild is TfrxPreviewForm);
  self.ODTExportMI.Visible:=(self.ActiveMDIChild is TfrxPreviewForm);
end;

procedure TServRepApp.FileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TServRepApp.PrintReportExecute(Sender: TObject);
begin
  if (self.ActiveMDIChild is TfrxPreviewForm) then (self.ActiveMDIChild as TfrxPreviewForm).Preview.Print;
  if (self.ActiveMDIChild is TReportData) then (self.ActiveMDIChild as TReportData).ReportPrintExecute(self.ActiveMDIChild as TReportData);
end;

procedure TServRepApp.ExportMIClick(Sender: TObject);
begin
    if (self.MDIChildCount>0)and(self.ActiveMDIChild.ClassName='TfrxPreviewForm') then begin
      if (sender as TMenuItem).Name='PDFExportMI' then
        (self.ActiveMDIChild as TfrxPreviewForm).Preview.Export(DMod.frxPDFExport);
      if (sender as TMenuItem).Name='XLSExportMI' then
        (self.ActiveMDIChild as TfrxPreviewForm).Preview.Export(DMod.frxXLSExport);
      if (sender as TMenuItem).Name='ODTExportMI' then
        (self.ActiveMDIChild as TfrxPreviewForm).Preview.Export(DMod.frxODTExport);
      if (sender as TMenuItem).Name='ODSExportMI' then
        (self.ActiveMDIChild as TfrxPreviewForm).Preview.Export(DMod.frxODSExport);
  end;
end;


//---------------------- МЕНЮ ПОМОЩЬ -------------------------------------------

procedure TServRepApp.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;


end.
