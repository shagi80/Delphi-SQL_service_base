object ProgressForm: TProgressForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1087#1088#1086#1094#1077#1089#1089#1072
  ClientHeight = 119
  ClientWidth = 371
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PB: TGauge
    Left = 16
    Top = 40
    Width = 337
    Height = 20
    Progress = 0
  end
  object ProcName: TLabel
    Left = 16
    Top = 18
    Width = 48
    Height = 13
    Caption = 'ProcName'
  end
  object SpeedButton1: TSpeedButton
    Left = 112
    Top = 72
    Width = 129
    Height = 30
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Flat = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00338833333333
      3333391183333398333339111833391183333911118391111833339111181111
      1833333911111111833333339111111833333333311111833333333339111183
      3333333391111183333333391118111833333391118391118333339118333911
      1833333913333391113333333333333919333333333333333333}
    OnClick = SpeedButton1Click
  end
end
