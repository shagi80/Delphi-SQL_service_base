object DateForm: TDateForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1087#1077#1088#1080#1086#1076#1072
  ClientHeight = 246
  ClientWidth = 210
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 210
    Height = 201
    Align = alTop
    TabOrder = 0
    object DateGB: TGroupBox
      Left = 4
      Top = 0
      Width = 200
      Height = 186
      Color = clBtnFace
      ParentColor = False
      TabOrder = 0
      object Label4: TLabel
        Left = 40
        Top = 51
        Width = 5
        Height = 13
        Caption = #1089
      end
      object Label5: TLabel
        Left = 40
        Top = 82
        Width = 12
        Height = 13
        Caption = #1087#1086
      end
      object PeriodRB: TRadioButton
        Left = 16
        Top = 20
        Width = 81
        Height = 17
        Caption = #1087#1077#1088#1080#1086#1076
        TabOrder = 0
        OnClick = PeriodRBClick
      end
      object MonthRB: TRadioButton
        Left = 16
        Top = 120
        Width = 89
        Height = 17
        Caption = #1084#1077#1089#1103#1094
        TabOrder = 1
        OnClick = PeriodRBClick
      end
      object YearRB: TRadioButton
        Left = 119
        Top = 120
        Width = 61
        Height = 17
        Caption = #1075#1086#1076
        TabOrder = 2
        OnClick = PeriodRBClick
      end
      object MonthCB: TComboBox
        Left = 16
        Top = 143
        Width = 105
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 3
        Text = #1103#1085#1074#1072#1088#1100
        Items.Strings = (
          #1103#1085#1074#1072#1088#1100
          #1092#1077#1074#1088#1072#1083#1100
          #1084#1072#1088#1090
          #1072#1087#1088#1077#1083#1100
          #1084#1072#1081
          #1080#1102#1085#1100
          #1080#1102#1083#1100
          #1072#1074#1075#1091#1089#1090
          #1089#1077#1085#1090#1103#1073#1088#1100
          #1086#1082#1090#1103#1073#1088#1100
          #1085#1086#1103#1073#1088#1100
          #1076#1077#1082#1072#1073#1088#1100)
      end
      object YearCB: TComboBox
        Left = 120
        Top = 143
        Width = 65
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
      end
      object StartDateTP: TDateTimePicker
        Left = 72
        Top = 47
        Width = 113
        Height = 21
        Date = 43809.786509143520000000
        Time = 43809.786509143520000000
        TabOrder = 5
      end
      object EndDateTP: TDateTimePicker
        Left = 72
        Top = 74
        Width = 113
        Height = 21
        Date = 43809.786509143520000000
        Time = 43809.786509143520000000
        TabOrder = 6
      end
    end
  end
  object OkBtn: TBitBtn
    Left = 15
    Top = 207
    Width = 89
    Height = 25
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object CloseBtn: TBitBtn
    Left = 105
    Top = 207
    Width = 89
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    Kind = bkCancel
  end
end
