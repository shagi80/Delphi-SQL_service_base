program Mdiapp;

uses
  Forms,
  main in 'main.pas' {ServRepApp},
  SenterListWin in 'SenterListWin.pas' {SenterList},
  about in 'about.pas' {AboutBox},
  DataMod in 'DataMod.pas' {DMod: TDataModule},
  SenterDataWin in 'SenterDataWin.pas' {SenterData},
  ReportListWin in 'ReportListWin.pas' {ReportList},
  MonthWin in 'MonthWin.pas' {MonthDLG},
  ReportDataWin in 'ReportDataWin.pas' {ReportData},
  SelectSenterWin in 'SelectSenterWin.pas' {SelectSenter},
  ImportWin in 'ImportWin.pas' {ImportFrame: TFrame},
  ImportStateWin in 'ImportStateWin.pas' {ImportState},
  RecordDataWin in 'RecordDataWin.pas' {RecordData},
  GIFUnit in 'GIFUnit.pas' {ProgressForm},
  MsgUnit in 'MsgUnit.pas' {MsgForm},
  DateWin in 'DateWin.pas' {DateForm},
  RepForPayWin in 'RepForPayWin.pas' {RepForPayForm},
  PassowrdWin in 'PassowrdWin.pas' {PasswordForm},
  RepStatForRecWin in 'RepStatForRecWin.pas' {RepStatForRecForm},
  PriceEditWin in 'PriceEditWin.pas' {PriceEditForm},
  PrintMod in 'PrintMod.pas' {PrMod: TDataModule},
  RepAutorWorkWin in 'RepAutorWorkWin.pas' {RepAutorWorkForm},
  RepWestEast in 'RepWestEast.pas' {RepWestEastForm},
  RepDocMailWin in 'RepDocMailWin.pas' {RepDocMailForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SerReports';
  Application.CreateForm(TDMod, DMod);
  Application.CreateForm(TServRepApp, ServRepApp);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TMsgForm, MsgForm);
  Application.CreateForm(TDateForm, DateForm);
  Application.CreateForm(TPriceEditForm, PriceEditForm);
  Application.Run;
end.
