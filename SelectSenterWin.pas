unit SelectSenterWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, Buttons, StdCtrls, ExtCtrls;

type
  TSelectSenter = class(TForm)
    Grid: TDBGrid;
    MainTable: TADOQuery;
    DS: TDataSource;
    TopPn: TPanel;
    Label1: TLabel;
    FilterED: TEdit;
    SpeedButton1: TSpeedButton;
    Panel2: TPanel;
    HideDelCB: TCheckBox;
    procedure GridDblClick(Sender: TObject);
    procedure GridTitleClick(Column: TColumn);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FilterEDChange(Sender: TObject);
    procedure ExecSQL(const ord:string='');
    procedure HideDelCBClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetSenterID(id:integer; var descr,city,info : string;var IsDel :boolean):integer ;

implementation

{$R *.dfm}

uses DataMod;

var
  newID   : integer;
  des,cit : string;
  inf     : string;
  order   : string;
  del     : boolean;

function GetSenterID(id:integer;var descr,city,info : string;var IsDel :boolean):integer;
var
  form: TSelectSenter;
begin
  form:= TSelectSenter.Create(application);
  form.MainTable.Active:=true;
  form.ExecSQL('DESCR');
  form.FormResize(form);
  if ID>0 then form.MainTable.Locate('ID',ID,[]);
  newID:=0;
  form.ShowModal;
  if newID>0 then begin
    descr:=des;
    city:=cit;
    info:=inf;
    IsDel:=del;
    result:=newID;
  end;
  form.Free;
end;

procedure TSelectSenter.ExecSQL(const ord:string='');
var
  str : string;
begin
  str:='SELECT ID,DESCR,CITY,ISDEL,CONDITIONS FROM SERVCENTRES';
  if HideDelCB.Checked then str:=str+' WHERE ISDEL=0';
  if Length(ord)>0 then order:=ord;
  str:=str+' ORDER BY '+QuotedStr(order);
  MainTable.Active:=false;
  MainTable.SQL.Clear;
  MainTable.SQL.Add(str);
  MainTable.Active:=true;
end;

procedure TSelectSenter.FilterEDChange(Sender: TObject);
begin
  if (Length(FilterED.Text)>0) then begin
    MainTable.Filtered:=False;
    MainTable.Filter:='DESCR LIKE '+QuotedStr('%'+FilterED.Text+'%')+
      'OR CITY LIKE '+QuotedStr('%'+FilterED.Text+'%');
    MainTable.Filtered:=true;
  end else MainTable.Filtered:=false;
end;

procedure TSelectSenter.FormCreate(Sender: TObject);
begin
  if ScreenHeight<screen.Height then TopPn.ScaleBy(ScreenHeight,screen.Height)else TopPn.ScaleBy(screen.Height,ScreenHeight);
end;

procedure TSelectSenter.FormResize(Sender: TObject);
var
  w : integer;
begin
  w:=round((Grid.ClientWidth-20)/2);
  Grid.Columns[0].Width:=w;
  Grid.Columns[1].Width:=w;
end;

procedure TSelectSenter.GridDblClick(Sender: TObject);
begin
  newID:=MainTable.FieldByName('ID').AsInteger;
  des:=MainTable.FieldByName('DESCR').AsString;
  cit:=MainTable.FieldByName('CITY').AsString;
  inf:=MainTable.FieldByName('CONDITIONS').AsString;
  del:=MainTable.FieldByName('ISDEL').AsBoolean;
  self.Close;
end;

procedure TSelectSenter.GridTitleClick(Column: TColumn);
begin
  self.ExecSQL(column.FieldName);
end;

procedure TSelectSenter.HideDelCBClick(Sender: TObject);
begin
  self.ExecSQL();
end;

procedure TSelectSenter.SpeedButton1Click(Sender: TObject);
begin
  FilterED.Text:='';
  MainTable.Filtered:=false;
end;

end.
