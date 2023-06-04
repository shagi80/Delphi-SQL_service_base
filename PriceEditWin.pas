unit PriceEditWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBCtrls, StdCtrls, Mask, ExtCtrls, ADODB, Buttons, Grids, DBGrids;

type
  TPriceEditForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    MainTypeCB: TDBLookupComboBox;
    MTDS: TDataSource;
    Query: TADOQuery;
    DS: TDataSource;
    Label3: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    PriceQuery: TADOQuery;
    PDS: TDataSource;
    PostBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label5: TLabel;
    function  EditPrice(id : integer;const senterid : integer=0): boolean;
    procedure PostBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PriceEditForm: TPriceEditForm;

implementation

{$R *.dfm}

uses DataMod;

function  TPriceEditForm.EditPrice(id : integer;const senterid : integer=0): boolean;
begin
  PriceQuery.Close;
  PriceQuery.Open;
  Query.Close;
  Query.SQL.Clear;
  if id=0 then begin
    Query.SQL.Add('SELECT T1.*  FROM  [DBO].[SERVPRICELIST] AS T1');
    self.Caption:='Добавление цены';
  end  else begin
    Query.SQL.Add('SELECT T1.*  FROM  [DBO].[SERVPRICELIST] AS T1 WHERE T1.[ID]='+IntToStr(id));
    self.Caption:='Изменение цены';
  end;
  Query.Open;
  if id=0 then begin
    Query.Append;
    Query.FieldByName('SENTERID').AsInteger:=SenterID;
  end;
  result:=self.ShowModal=mrOk;
end;

procedure TPriceEditForm.CancelBtnClick(Sender: TObject);
begin
  Query.Cancel;
end;

procedure TPriceEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Query.Close;
  PriceQuery.Close;
end;

procedure TPriceEditForm.PostBtnClick(Sender: TObject);
var
  msg: string;
begin
  msg:='';
  if Query.FieldByName('DESCR').IsNull then msg:='Наименование не заполнено!';
  if Query.FieldByName('PRICE').AsInteger=0 then msg:='Цена не указана!';
  if Query.FieldByName('MAINTYPEID').IsNull then msg:='Тип прдукции не выбран!';
  if Query.FieldByName('PRICETYPEID').IsNull then msg:='Тип цены не выбран!';
  if length(msg)=0 then begin
    if Query.Modified then Query.Post;
  end else MessageDLG(msg,mtError,[mbOk],0);
end;

end.
