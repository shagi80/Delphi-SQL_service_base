unit SenterListWin;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ComCtrls,
  ToolWin, ExtCtrls, Grids, DBGrids, DB, ADODB, SysUtils, ActnList, Messages, Dialogs;

type
  TSenterList = class(TForm)
    TopPN: TPanel;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    SpeedButton1: TSpeedButton;
    FilterED: TEdit;
    Grid: TDBGrid;
    Label1: TLabel;
    ActionList1: TActionList;
    Edit: TAction;
    New: TAction;
    ToolButton1: TToolButton;
    SLSTDS: TDataSource;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Delete: TAction;
    SLSTTABLE: TADOQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridTitleClick(Column: TColumn);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FilterEDChange(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure EditExecute(Sender: TObject);
    procedure NewExecute(Sender: TObject);
    procedure UpdateServTable;
    procedure SLSTTABLECalcFields(DataSet: TDataSet);
    procedure DeleteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure ExecSQL (const ord : string='');
  private
    { Private declarations }
    orderfield : string;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataMod, SenterDataWin;

procedure TSenterList.UpdateServTable;
begin
  self.ExecSQL();
end;

procedure TSenterList.ExecSQL(const ord: string = '');
var
  id : integer;
begin
  if not SLSTTABLE.IsEmpty then id := SLSTTABLE.FieldByName('ID').AsInteger else id:=0;
  SLSTTABLE.DisableControls;
  SLSTTABLE.Close;
  SLSTTABLE.SQL.Clear;
  SLSTTABLE.SQL.Add('SELECT SENTR.*, EMPL.[DESCR] AS EMPLOYE, REG.[DESCR] AS REGION');
  SLSTTABLE.SQL.Add('FROM SERVCENTRES AS SENTR LEFT JOIN EMPLOYEES AS EMPL ON EMPL.[ID]=SENTR.[EMPLID]');
  SLSTTABLE.SQL.Add('LEFT JOIN SERVREGION AS REG ON REG.[ID]=SENTR.[REGIONID]');
  if Length(ord)>0 then orderfield:=ord;
  SLSTTABLE.SQL.Add('ORDER BY '+orderfield);
  SLSTTABLE.Open;
  SLSTTABLE.EnableControls;
  if id>0 then SLSTTABLE.Locate('ID',id,[]);
end;

procedure TSenterList.GridDblClick(Sender: TObject);
begin
  self.EditExecute(self);
end;

procedure TSenterList.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  bmp : TBitmap;
begin
  if (not SLSTTABLE.IsEmpty)and(Column.FieldName='ISDEL') then begin
    bmp:=TBitmap.Create;
    Grid.Canvas.FillRect(rect);
    if SLSTTABLE.FieldByName('ISDEL').AsBoolean then DMod.ImageList.GetBitmap(26,bmp)
      else DMod.ImageList.GetBitmap(27,bmp);
    Grid.Canvas.Draw(rect.Left+2,rect.Top+1,bmp);
    bmp.Free;
  end else Grid.DefaultDrawDataCell(rect,Column.Field,state);
end;

procedure TSenterList.GridTitleClick(Column: TColumn);
begin
  if SLSTTABLE.FindField(Column.FieldName)<>nil then self.ExecSQL(Column.FieldName);
end;

procedure TSenterList.NewExecute(Sender: TObject);
begin
  SenterDataWin.ShowSenterData(0,self.New.ImageIndex);
end;

procedure TSenterList.SLSTTABLECalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('STATUS').AsString:='не определен';
end;

procedure TSenterList.SpeedButton1Click(Sender: TObject);
begin
  FilterED.Text:='';
  SLSTTABLE.Filtered:=false;
end;

procedure TSenterList.DeleteExecute(Sender: TObject);
var
  i   : integer;
  msg : string;
begin
  if not SLSTTABLE.Eof then begin
    i:=DMod.SenterEditing(SLSTTABLE.FieldByName('ID').AsInteger);
    if i>0  then begin
      MessageDLG('Этот элемент редактируется!'+chr(13)+
      'Закройте окно редактора и повторите попытку!',mtError,[mbOk],0);
      application.MainForm.MDIChildren[i].BringToFront;
    end else begin
      if not SLSTTABLE.FieldByName('ISDEL').AsBoolean then msg:='Пометить на удаление ?' else msg:='Снять пометку на удаление ?';
      if MessageDLG(msg,mtWarning,[mbYes,mbNo],0)=mrYes then begin
        SLSTTABLE.Edit;
        SLSTTABLE.FieldByName('ISDEL').AsBoolean:=not SLSTTABLE.FieldByName('ISDEL').AsBoolean;
        SLSTTABLE.Post;
        DMod.SendMsgToSystem(WM_UPDATESEMTERLIST,self.Tag);
      end;
    end;
  end;
end;

procedure TSenterList.EditExecute(Sender: TObject);
var
  i : integer;
begin
  if not SLSTTABLE.Eof then begin
    i:=DMod.SenterEditing(SLSTTABLE.FieldByName('ID').AsInteger);
    if i>0 then application.MainForm.MDIChildren[i].BringToFront
      else SenterDataWin.ShowSenterData(SLSTTABLE.FieldByName('ID').AsInteger,self.Edit.ImageIndex);
  end;
end;

procedure TSenterList.FilterEDChange(Sender: TObject);
begin
  if (Length(FilterED.Text)>0) then begin
    SLSTTABLE.Filtered:=False;
    SLSTTABLE.Filter:='DESCR LIKE '+QuotedStr('%'+FilterED.Text+'%')+
      'OR CITY LIKE '+QuotedStr('%'+FilterED.Text+'%')+
      'OR NOTE LIKE '+QuotedStr('%'+FilterED.Text+'%')+
      'OR ADDR LIKE '+QuotedStr('%'+FilterED.Text+'%')+
      'OR REGION LIKE '+QuotedStr('%'+FilterED.Text+'%')+
      'OR EMPLOYE LIKE '+QuotedStr('%'+FilterED.Text+'%');
    SLSTTABLE.Filtered:=true;
  end else SLSTTABLE.Filtered:=false;
end;

procedure TSenterList.FormActivate(Sender: TObject);
begin
  PostMessage(application.MainForm.Handle,WM_ACTIVATECHILD,self.Tag,0);
end;

procedure TSenterList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PostMessage(application.MainForm.Handle,WM_CLOSECHILD,self.Tag,0);
  Action := caFree;
end;

procedure TSenterList.FormCreate(Sender: TObject);
begin
  self.ExecSQL('DESCR');
  toppn.ScaleBy(ScreenHeight,screen.Height);
  self.FormResize(sender);
end;

procedure TSenterList.FormResize(Sender: TObject);
var
  w,i : integer;
begin
  Grid.Columns[1].Width:=round(Grid.ClientWidth*0.07);
  Grid.Columns[2].Width:=round(Grid.ClientWidth*0.05);
  Grid.Columns[3].Width:=round(Grid.ClientWidth*0.13);
  Grid.Columns[4].Width:=round(Grid.ClientWidth*0.13);
  Grid.Columns[5].Width:=round(Grid.ClientWidth*0.07);
  Grid.Columns[6].Width:=round(Grid.ClientWidth*0.13);
  w:=0;
  for I := 0 to Grid.Columns.Count- 2 do
      w:=W+Grid.Columns[i].Width+1;
  Grid.Columns[Grid.Columns.Count-1].Width:=Grid.ClientWidth-w-15;
end;

end.
