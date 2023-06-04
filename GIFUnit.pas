unit GIFUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Gauges, StdCtrls, Buttons;

type
  TProgressForm = class(TForm)
    PB: TGauge;
    ProcName: TLabel;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    StopProcess:boolean;
  end;


implementation

{$R *.dfm}

procedure TProgressForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  self.StopProcess:=true;
  action:=caNone;
end;

procedure TProgressForm.FormCreate(Sender: TObject);
begin
  self.StopProcess:=false;
end;

procedure TProgressForm.SpeedButton1Click(Sender: TObject);
begin
  self.Close;
end;

end.
