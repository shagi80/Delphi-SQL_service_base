unit PassowrdWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TPasswordForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    UserCB: TComboBox;
    Label2: TLabel;
    PasswordED: TEdit;
    OkBtn: TBitBtn;
    CloseBtn: TBitBtn;
    MsgLB: TLabel;
    Image1: TImage;
    Label3: TLabel;
    Label4: TLabel;
    procedure OkBtnClick(Sender: TObject);
    procedure UserCBChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  PasswordForm: TPasswordForm;    }

implementation

{$R *.dfm}

uses
  DataMod;

procedure TPasswordForm.CloseBtnClick(Sender: TObject);
begin
  self.Tag:=-1;
end;

procedure TPasswordForm.FormShow(Sender: TObject);
var
  pid : ^integer;
begin
  UserCB.Items.Clear;
  UserCB.Sorted:=false;
  DMod.EmployeeTable.First;
  while not DMod.EmployeeTable.Eof do begin
    UserCB.Items.Add(DMod.EmployeeTable.FieldByName('DESCR').AsString);
    new(pid);
    pid^:=DMod.EmployeeTable.FieldByName('ID').AsInteger;
    UserCB.Items.Objects[UserCB.Items.Count-1]:=TObject(pid);
    DMod.EmployeeTable.Next;
  end;
  UserCB.Sorted:=true;
  UserCB.ItemIndex:=0;
  MsgLB.Caption:='';
  PasswordED.Text:='';
  self.Tag:=0;
end;

procedure TPasswordForm.OkBtnClick(Sender: TObject);
var
  val : variant;
  pid : ^integer;
begin
  pid:=pointer(UserCB.Items.Objects[UserCB.ItemIndex]);
  val:=DMod.EmployeeTable.Lookup('ID',pid^,'PASSWORD');
  if(val<>NULL)and(val=PasswordED.Text)then begin
    self.Tag:=pid^;
    self.Close;
  end else begin
    MsgLB.Caption:='Пароль введен неверно!';
  end;
end;

procedure TPasswordForm.UserCBChange(Sender: TObject);
begin
  MsgLB.Caption:='';
  PasswordED.Text:='';
end;

end.
