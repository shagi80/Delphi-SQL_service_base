unit ImportStateWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TImportState = class(TForm)
    RG: TRadioGroup;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetImportState: integer;

implementation

{$R *.dfm}

function GetImportState:integer;
var
  form : TImportState;
begin
  form:= TImportState.Create(application);
  if form.ShowModal=mrOK then result:=form.RG.ItemIndex
    else result:=-1;
  form.Free;
end;

end.
