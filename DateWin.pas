unit DateWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TDateForm = class(TForm)
    Panel1: TPanel;
    DateGB: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    PeriodRB: TRadioButton;
    MonthRB: TRadioButton;
    YearRB: TRadioButton;
    MonthCB: TComboBox;
    YearCB: TComboBox;
    StartDateTP: TDateTimePicker;
    EndDateTP: TDateTimePicker;
    OkBtn: TBitBtn;
    CloseBtn: TBitBtn;
    procedure PeriodRBClick(Sender: TObject);
    function  GetPeriod (var stdate,enddate : TDate):boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DateForm: TDateForm;

implementation

{$R *.dfm}

uses DateUtils;

function  TDateForm.GetPeriod (var stdate,enddate : TDate):boolean;
var
 i : integer;
begin
  PeriodRB.Checked:=true;
  StartDateTP.Date:=stdate;
  EndDateTP.Date:=enddate;
  YearCB.Items.Clear;
  i:=2016;
  while (i<=YearOf(now)) do begin
    YearCB.Items.Add(inttostr(i));
    inc(i);
  end;
  YearCB.ItemIndex:=0;
  if self.ShowModal=mrOK then begin
    if PeriodRB.Checked then begin
      stdate:=StartDateTP.Date;
      enddate:=EndDateTP.Date;
    end;
    if YearRB.Checked then begin
      stdate:=EncodeDate(StrToInt(YearCB.Text),01,01);
      enddate:=EncodeDate(StrToInt(YearCB.Text),12,31);
    end;
    if MonthRB.Checked then begin
      enddate:=EndOfTheMonth(EncodeDate(StrToInt(YearCB.Text),MonthCB.ItemIndex+1,01));
      stdate:=StartOfTheMonth(EncodeDate(StrToInt(YearCB.Text),MonthCB.ItemIndex+1,01));
    end;
    result:=true;
  end else result:=false;
end;


procedure TDateForm.PeriodRBClick(Sender: TObject);
begin
  if PeriodRB.Checked then begin
    MonthRB.Checked:=false;
    YearRB.Checked:=false;
  end;
  if YearRB.Checked then begin
    MonthRB.Checked:=false;
    PeriodRB.Checked:=false;
  end;
  if MonthRB.Checked then begin
    PeriodRB.Checked:=false;
    YearRB.Checked:=false;
  end;
  MonthCB.Enabled:=(MonthRB.Checked);
  YearCB.Enabled:=((YearRB.Checked)or(MonthRB.Checked));
  StartDateTP.Enabled:=(PeriodRB.Checked);
  EndDateTP.Enabled:=(PeriodRB.Checked);
end;



end.
