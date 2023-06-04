unit MsgUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, Buttons, ExtCtrls;

type
  TMsgForm = class(TForm)
    MainPn: TPanel;
    WB: TWebBrowser;
    Panel1: TPanel;
    HideCB: TCheckBox;
    BitBtn1: TBitBtn;
    function  ShowWindow(fname:string):boolean;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MsgForm: TMsgForm;

implementation

{$R *.dfm}

function TMsgForm.ShowWindow(fname: string) : boolean;
begin
  self.WB.Navigate(fname);
  self.ShowModal;
  WB.Stop;
  result:=not HideCB.Checked;
end;

procedure TMsgForm.BitBtn1Click(Sender: TObject);
begin
  self.Close;
end;

end.
