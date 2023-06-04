unit SenterDataWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, DBCtrls, Mask,
  ComCtrls;

type
  TSenterData = class(TForm)
    CloseBtn: TBitBtn;
    PostBtn: TBitBtn;
    MainQuery: TADOQuery;
    MainDS: TDataSource;
    ContQuery: TADOQuery;
    ContDS: TDataSource;
    OKBtn: TBitBtn;
    Pages: TPageControl;
    MainPage: TTabSheet;
    AddPage1: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    CodeDBED: TDBEdit;
    CityDB: TDBComboBox;
    NameDBED: TDBEdit;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    Label6: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    Label7: TLabel;
    Grid: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label8: TLabel;
    DBMemo3: TDBMemo;
    Label9: TLabel;
    PriceQuery: TADOQuery;
    PriceDS: TDataSource;
    PriceGrid: TDBGrid;
    PriceDBN: TDBNavigator;
    DBCheckBox1: TDBCheckBox;
    EmplCB: TComboBox;
    RegionCB: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    CopyPriceBtn: TSpeedButton;
    CopyPriceCmd: TADOQuery;
    procedure PostBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateCityCB;
    procedure CloseBtnClick(Sender: TObject);
    procedure ResizeGrid;
    procedure ContDSDataChange(Sender: TObject; Field: TField);
    procedure ContQueryBeforePost(DataSet: TDataSet);
    function  PostMainQuery:boolean;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EmplCBKeyPress(Sender: TObject; var Key: Char);
    procedure EmplCBCloseUp(Sender: TObject);
    procedure PriceDBNBeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure PriceGridDblClick(Sender: TObject);
    procedure RegionCBCloseUp(Sender: TObject);
    procedure PriceQueryBeforePost(DataSet: TDataSet);
    procedure CopyPriceBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    ItemID : integer;
    { Public declarations }
  end;

procedure ShowSenterData(ID,img : integer);

implementation

{$R *.dfm}

uses DataMod, PriceEditWin, SelectSenterWin;

procedure ShowSenterData(ID,img : integer);
var
  form :TSenterData;
  pid  : ^integer;
  ind  : integer;
begin
  form:= TSenterData.Create(application);
  form.ItemID:=ID;
  form.Pages.ActivePageIndex:=0;
  with Form do begin
    ResizeGrid;
    MainQuery.SQL.Clear;
    MainQuery.SQL.Add('SELECT * FROM SERVCENTRES WHERE ID='+IntToStr(ID));
    MainQuery.Open;
    ContQuery.SQL.Clear;
    ContQuery.SQL.Add('SELECT * FROM SERVCONTACT WHERE SENTERID='+IntToStr(ID));
    ContQuery.Open;
    PriceQuery.SQL.Clear;
    PriceQuery.SQL.Add('SELECT T1.*, '+
      '(SELECT T2.[DESCR]  FROM [dbo].[MAINTYPES] AS T2 WHERE T2.[ID]=T1.[MAINTYPEID]) AS MAINTYPE, '+
      '(SELECT T3.[DESCR] FROM [dbo].[SERVPRICETYPES] AS T3 WHERE T3.[ID]=T1.[PRICETYPEID]) AS PRICETYPE '+
      'FROM [dbo].[SERVPRICELIST] AS T1 WHERE T1.[SENTERID]='+IntToStr(ID)+
      ' ORDER BY T1.[DESCR], T1.[PRICETYPEID]');
    PriceQuery.Open;
    //заполняем ComboBox выбора ответственного
    EmplCB.Clear;
    ind:=0;
    EmplCB.Items.Add('не задано');
    new(pid);pid^:=0; EmplCB.Items.Objects[0]:=TObject(pid);
    DMOD.EmployeeTable.First;
    while not DMod.EmployeeTable.Eof do begin
      EmplCB.Items.Add(DMod.EmployeeTable.FieldByName('DESCR').AsString);
      new(pid);
      pid^:=DMod.EmployeeTable.FieldByName('ID').AsInteger;
      if pid^=MainQuery.FieldByName('EMPLID').AsInteger then ind:=EmplCB.Items.Count-1;
      EmplCB.Items.Objects[EmplCB.Items.Count-1]:=TObject(pid);
      DMod.EmployeeTable.Next;
    end;
    EmplCB.ItemIndex:=ind;
    //заполняем ComboBox выбора региона
    RegionCB.Clear;
    ind:=0;
    RegionCB.Items.Add('не задано');
    new(pid);pid^:=0; RegionCB.Items.Objects[0]:=TObject(pid);
    DMOD.RegionTable.First;
    while not DMod.RegionTable.Eof do begin
      RegionCB.Items.Add(DMod.RegionTable.FieldByName('DESCR').AsString);
      new(pid);
      pid^:=DMod.RegionTable.FieldByName('ID').AsInteger;
      if pid^=MainQuery.FieldByName('REGIONID').AsInteger then ind:=RegionCB.Items.Count-1;
      RegionCB.Items.Objects[RegionCB.Items.Count-1]:=TObject(pid);
      DMod.RegionTable.Next;
    end;
    RegionCB.ItemIndex:=ind;
    //заголовок формы
    IF ID=0 then begin
      MainQuery.Append;
      Caption:='Новый СЦ';
    end else Caption:=MainQuery.FieldByName('DESCR').AsString;
    //заполняем список городов
    Repaint;
    UpdateCityCB;
  end;
  PostMessage(application.MainForm.Handle,WM_CREATECHILD,form.Tag,img);
end;

procedure TSenterData.RegionCBCloseUp(Sender: TObject);
var
  pid : ^integer;
begin
  pid:=pointer(RegionCB.Items.Objects[RegionCb.itemIndex]);
  if not MainQuery.Modified then MainQuery.Edit;
  MainQuery.FieldByName('REGIONID').AsInteger:=pid^;
end;

procedure TSenterData.ResizeGrid;
var
  w,i  : integer;
begin
    // настройка таблицы контактов
    w:=round((Grid.ClientWidth-20)/(Grid.Columns.Count));
    for I := 0 to Grid.Columns.Count - 2 do Grid.Columns[i].Width:=w;
    Grid.Columns[Grid.Columns.Count - 1].Width:=Grid.ClientWidth-(Grid.Columns.Count-1)*w-20;
    PriceGrid.Columns[0].Width:=PriceGrid.ClientWidth-PriceGrid.Columns[1].Width-40;
end;

procedure TSenterData.UpdateCityCB;
var
  i     : integer;
  Query : TADOQuery;
begin
  Query:=TADOQuery.Create(self);
  Query.Connection:=DMod.Connection;
  Query.SQL.Add('SELECT CITY FROM SERVCENTRES');
  Query.Active:=true;
  CityDB.Items.Clear;
  while not Query.Eof do begin
    i:=0;
    while(i<CityDB.Items.Count)and(CityDB.Items[i]<>Query.FieldByName('CITY').AsString)do inc(i);
    if(i=CityDB.Items.Count)then CityDB.Items.Add(Query.FieldByName('CITY').AsString);
    Query.Next;
  end;
  Query.Free;
end;

procedure TSenterData.CloseBtnClick(Sender: TObject);
begin
  self.Close;
end;

function TSenterData.PostMainQuery:boolean;
var
  msg:string;
begin
  result:=true;
  msg:='';
  if Length(CityDB.Text)=0 then msg:=chr(13)+'Поле "Uород" не может быть пустым!';
  if Length(NameDBED.Text)=0 then msg:=chr(13)+'Поле "Наименование" не может быть пустым!';
  if MainQuery.FieldByName('EMPLID').AsInteger=0 then msg:=chr(13)+'Должен быть указан ответсвенный!';
  if MainQuery.FieldByName('REGIONID').AsInteger=0 then msg:=chr(13)+'Должен быть указан регион!';
  if Length(msg)>0 then begin
    msg:='Форма не заполнена!'+msg;
    MessageDLG(msg,mtError,[mbOK],0);
    result:=false;
  end else if MainQuery.Modified then begin
    MainQuery.Post;
    if ITEMID=0 then ITEMID:=MainQuery.FieldByName('ID').AsInteger;
    Caption:=MainQuery.FieldByName('DESCR').AsString;
    DMod.SendMsgToSystem(WM_UPDATESEMTERLIST,self.Tag);
  end;
end;

procedure TSenterData.PriceDBNBeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button=nbInsert then begin
    if PriceEditForm.EditPrice(0,MainQuery.FieldByName('ID').AsInteger) then begin
      PriceQuery.Close;
      PriceQuery.Open;
    end;
    Abort;
  end;
end;

procedure TSenterData.PriceGridDblClick(Sender: TObject);
begin
  if PriceEditForm.EditPrice(PriceQuery.FieldByName('ID').AsInteger) then PriceQuery.Refresh;
end;

procedure TSenterData.PriceQueryBeforePost(DataSet: TDataSet);
begin
  if itemID=0 then
    if MessageDlg('Сервисный центр не записан!'+chr(13)+'Записать?',mtWarning,[mbYes,mbNo],0)=mrYes
      then self.PostMainQuery else Abort;
  DataSet.FieldByName('SENTERID').AsInteger:=ITEMID;
end;

procedure TSenterData.PostBtnClick(Sender: TObject);
begin;
  if (self.PostMainQuery)and(ContQuery.Modified) then ContQuery.Post;
end;

procedure TSenterData.OKBtnClick(Sender: TObject);
begin
  if ContQuery.Modified then ContQuery.Post;
  if self.PostMainQuery then self.Close;
end;

procedure TSenterData.ContDSDataChange(Sender: TObject; Field: TField);
begin
  ResizeGrid;
end;

procedure TSenterData.ContQueryBeforePost(DataSet: TDataSet);
begin
  if itemID=0 then
    if MessageDlg('Сервисный центр не записан!'+chr(13)+'Записать?',mtWarning,[mbYes,mbNo],0)=mrYes
      then self.PostMainQuery else Abort;
  DataSet.FieldByName('SENTERID').AsInteger:=ITEMID;
end;

procedure TSenterData.CopyPriceBtnClick(Sender: TObject);
var
  descr,city,info : string;
  id              : integer;
  execute,isdel   : boolean;
begin
  execute:=true;
  if itemID=0 then
    if MessageDlg('Сервисный центр не записан!'+chr(13)+'Записать?',mtWarning,[mbYes,mbNo],0)=mrYes
      then execute:=self.PostMainQuery else execute:=false;
  if (execute)and(not self.PriceQuery.IsEmpty) then
    if MessageDlg('Перед копированием список цен будет очищен.'+chr(13)
      +'Продолжить ?',mtConfirmation,[mbYes,mbNo],0)=mrYes then begin
        CopyPriceCmd.SQL.Clear;
        CopyPriceCmd.SQL.Add('DELETE [dbo].[SERVPRICELIST] WHERE [SENTERID]='+IntToStr(self.ItemID));
        CopyPriceCmd.ExecSQL;
      end else execute:=false;
  if execute then begin
    id:=GetSenterID(0,descr,city,info,isdel);
    if id>0 then begin
      CopyPriceCmd.SQL.Clear;
      CopyPriceCmd.SQL.Add('SELECT [ID] FROM [dbo].[SERVPRICELIST] WHERE [SENTERID]='+IntToStr(ID));
      CopyPriceCmd.Open;
      if not CopyPriceCmd.IsEmpty then begin
        CopyPriceCmd.SQL.Clear;
       // CopyPriceCmd.SQL.Add('DELETE [dbo].[SERVPRICELIST] WHERE [SENTERID]='+IntToStr(self.ItemID));
        CopyPriceCmd.SQL.Add('INSERT INTO [dbo].[SERVPRICELIST] (DESCR,SENTERID,MAINTYPEID,PRICETYPEID,PRICE)'+
          chr(13)+'SELECT T2.[DESCR],'+IntToStr(self.ItemID)+',T2.[MAINTYPEID],T2.[PRICETYPEID],T2.[PRICE]'+
          chr(13)+'FROM [dbo].[SERVPRICELIST] AS T2 WHERE T2.[SENTERID]='+IntToStr(ID));
        PriceQuery.Close;
        CopyPriceCmd.ExecSQL;
        PriceQuery.Open;
      end else MessageDlg('Список цен для СЦ "'+descr+'{'+city+'}'+'" пуст.'+chr(13)
        +'Копирование не возможно !',mtWarning,[mbNo],0)
    end;
  end;
end;

//------------------- события формы --------------------------------------------

procedure TSenterData.FormActivate(Sender: TObject);
begin
  PostMessage(application.MainForm.Handle,WM_ACTIVATECHILD,self.Tag,0);
end;

procedure TSenterData.FormClose(Sender: TObject; var Action: TCloseAction);
var
  msg : string;
begin
  msg:='';
  if MainQuery.Modified then msg:=msg+chr(13)+'- данные о сервисном цетре';
  if ContQuery.Modified then msg:=msg+chr(13)+'- данные о сервисном цетре';
  if Length(msg)>0 then begin
    msg:='Данные не записаны:'+msg+chr(13)+'Все равно закрыть ?';
    if MessageDlg(msg,mtWarning,[mbYes,mbNo],0)=mrNo then Abort;
  end;
  PostMessage(application.MainForm.Handle,WM_CLOSECHILD,self.Tag,0);
  Action:=caFree;
end;

procedure TSenterData.FormCreate(Sender: TObject);
begin
  self.Tag:=DMod.NewWimID;
end;

//--------------- ComboBox выбора ответственного -------------------------------

procedure TSenterData.EmplCBCloseUp(Sender: TObject);
var
  pid : ^integer;
begin
  pid:=pointer(EmplCB.Items.Objects[EmplCb.itemIndex]);
  if not MainQuery.Modified then MainQuery.Edit;
  MainQuery.FieldByName('EMPLID').AsInteger:=pid^;   
end;

procedure TSenterData.EmplCBKeyPress(Sender: TObject; var Key: Char);
begin
  key:=chr(0);
end;

end.

