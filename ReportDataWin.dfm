object ReportData: TReportData
  Left = 0
  Top = 0
  Caption = 'ReportData'
  ClientHeight = 476
  ClientWidth = 1118
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPn: TPanel
    Left = 0
    Top = 424
    Width = 1118
    Height = 52
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      1118
      52)
    object OKbtn: TBitBtn
      Left = 1011
      Top = 5
      Width = 84
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = OKbtnClick
      Kind = bkOK
    end
    object StaticText1: TStaticText
      Left = 16
      Top = 5
      Width = 121
      Height = 17
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = ' '#1048#1090#1086#1075#1086#1074#1099#1077' '#1089#1091#1084#1084#1099':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object SumSetLB: TStaticText
      Left = 16
      Top = 21
      Width = 121
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = #1090#1086#1083#1100#1082#1086' '#1087#1088#1080#1085#1103#1090#1099#1077
      Color = clBtnHighlight
      ParentColor = False
      TabOrder = 2
      OnClick = SumSetLBClick
      OnMouseEnter = SumSetLBMouseEnter
      OnMouseLeave = SumSetLBMouseLeave
    end
    object StaticText3: TStaticText
      Left = 151
      Top = 5
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = #1047#1072' '#1076#1077#1090#1072#1083#1080
      TabOrder = 3
    end
    object DSumLB: TStaticText
      Left = 151
      Top = 21
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = 'StaticText1'
      Color = clBtnHighlight
      ParentColor = False
      TabOrder = 4
    end
    object StaticText5: TStaticText
      Left = 230
      Top = 5
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = #1047#1072' '#1074#1099#1077#1079#1076#1099
      TabOrder = 5
    end
    object MSumLB: TStaticText
      Left = 230
      Top = 21
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = 'StaticText1'
      Color = clBtnHighlight
      ParentColor = False
      TabOrder = 6
    end
    object StaticText7: TStaticText
      Left = 309
      Top = 5
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = #1047#1072' '#1088#1077#1084#1086#1085#1090#1099
      TabOrder = 7
    end
    object WSumLB: TStaticText
      Left = 309
      Top = 21
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = 'StaticText1'
      Color = clBtnHighlight
      ParentColor = False
      TabOrder = 8
    end
    object StaticText4: TStaticText
      Left = 388
      Top = 5
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = #1042#1089#1077#1075#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
    end
    object TSumLB: TStaticText
      Left = 388
      Top = 21
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = 'StaticText1'
      Color = clBtnHighlight
      ParentColor = False
      TabOrder = 10
    end
    object StaticText2: TStaticText
      Left = 480
      Top = 5
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = #1044#1077#1090#1072#1083#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
    end
    object PSumLB: TStaticText
      Left = 480
      Top = 21
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = 'StaticText1'
      Color = clBtnHighlight
      ParentColor = False
      TabOrder = 12
    end
    object StaticText6: TStaticText
      Left = 559
      Top = 5
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = #1056#1077#1084#1086#1085#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
    end
    object RowCntLB: TStaticText
      Left = 559
      Top = 21
      Width = 73
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = 'StaticText1'
      Color = clBtnHighlight
      ParentColor = False
      TabOrder = 14
    end
  end
  object MainPn: TPanel
    Left = 0
    Top = 141
    Width = 1118
    Height = 283
    Align = alClient
    Caption = 'MainPn'
    TabOrder = 2
    object RecordsTableTB: TToolBar
      Left = 1
      Top = 1
      Width = 1116
      Height = 29
      Caption = 'RecordsTableTB'
      Images = DMod.ImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object ShowFrameBtn: TToolButton
        Left = 0
        Top = 0
        Hint = #1069#1082#1089#1087#1086#1088#1090' '#1080#1093' EXCEL|'#1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1080#1079' EXCEL '#1095#1077#1088#1077#1079' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
        Caption = 'ShowFrameBtn'
        ImageIndex = 32
        OnClick = ShowFrameBtnClick
      end
      object ToolButton3: TToolButton
        Left = 23
        Top = 0
        Action = LoadFromRRPFile
      end
      object ToolButton2: TToolButton
        Left = 46
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 33
        Style = tbsSeparator
      end
      object DBNav: TDBNavigator
        Left = 54
        Top = 0
        Width = 144
        Height = 22
        DataSource = RecordsDS
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbDelete, nbRefresh]
        Flat = True
        TabOrder = 0
      end
      object ToolButton1: TToolButton
        Left = 198
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 54
        Style = tbsSeparator
      end
      object ShowOnlyFaultsBtn: TToolButton
        Left = 206
        Top = 0
        Hint = #1058#1086#1083#1100#1082#1086' '#1085#1077' '#1087#1088#1085#1103#1090#1099#1077'|'#1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1085#1077' '#1087#1088#1080#1085#1103#1090#1099#1077' '#1079#1072#1087#1080#1089#1080
        Caption = 'ShowOnlyFaultsBtn'
        ImageIndex = 9
        Style = tbsCheck
        OnClick = ShowOnlyFaultsBtnClick
      end
      object ColorBtn: TToolButton
        Left = 229
        Top = 0
        Hint = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1094#1074#1077#1090#1086#1084'|'#1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1089#1090#1072#1090#1091#1089#1086#1074' '#1094#1074#1077#1090#1086#1084
        Caption = 'ColorBtn'
        Down = True
        ImageIndex = 53
        Style = tbsCheck
        OnClick = ColorBtnClick
      end
      object ToolButton4: TToolButton
        Left = 252
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 50
        Style = tbsSeparator
      end
      object PrintBtn: TToolButton
        Left = 260
        Top = 0
        Action = ReportPrint
      end
    end
    object Grid: TDBGrid
      Left = 1
      Top = 30
      Width = 1116
      Height = 252
      Align = alClient
      DataSource = RecordsDS
      DefaultDrawing = False
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = GridDrawColumnCell
      OnDblClick = GridDblClick
    end
  end
  object TopPn: TPanel
    Left = 0
    Top = 0
    Width = 1118
    Height = 141
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 17
      Width = 214
      Height = 19
      Caption = #1054#1090#1095#1077#1090' '#1089#1077#1088#1074#1080#1089#1085#1086#1075#1086' '#1094#1077#1085#1090#1088#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 17
      Top = 67
      Width = 31
      Height = 13
      Caption = #1053#1086#1084#1077#1088
    end
    object Label3: TLabel
      Left = 128
      Top = 67
      Width = 25
      Height = 13
      Caption = #1076#1072#1090#1072
    end
    object Label5: TLabel
      Left = 17
      Top = 99
      Width = 84
      Height = 13
      Caption = #1054#1090#1095#1077#1090#1085#1099#1081' '#1084#1077#1089#1103#1094
    end
    object MonthBtn: TSpeedButton
      Left = 242
      Top = 95
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFF2626263F3F3F4A4A4A6464646B6B6B6B6B6B5757575757576B6B6B6B6B
        6B6464644A4A4A3F3F3FFFFFFFD69E72D3996EB6845E615850918D8AACA8A4AE
        AEAE979797717171787878979797AEAEAEACA7A48F8C8A4D4D4DFFFFFFD7A175
        F8F2EDA4A09C706F6FD3D3CE7E7B784444444646465151515151514646464544
        44807F7EC4C4C4676767FFFFFFD9A47AF9F3EE877B72868686D3D3CEF8F8F847
        4645BDBDBDCECECEC2C2C2ADADAD484747F2ECE9C4C4C4828282FFFFFFDDA87E
        F9F3EFB29F907A7877D3D3CE6073624B4C4C6565659292927979796565654D4D
        4D868584C4C4C4737373FFFFFFDFAA82F9F3EFE6CAB49E9E9E919191E8E8E8DD
        DDDDC1C1C18F8B889A9897DADADADDDDDDC4C4C49191914C4C4CFFFFFFE1AE87
        FAF4F0EACBB2E3C6AE7093738488849E9E9E8986836FA4736FAB737A837B9E9E
        9E8C8A8A9B795E3E3E3EFFFFFFE3B18CFAF6F1EAC9AEFFFFFFEAC9B0FFFFFFE9
        CBB3FFFFFF6FB1738ED2956BAF6FFFFFFFF1E5DBC68655FFFFFFFFFFFFE5B48F
        FAF6F2E9C6AAE9C6ACEAC7ACE9C7ADE9C9AEE9C9B06CB0716AAF6E68AD6DE8CC
        B5F2E7DEC88A59FFFFFFFFFFFFE7B794FBF7F4E9C3A6FFFFFFE8C4A9FFFFFFE9
        C6AAFFFFFFE8C7ACFFFFFFE8C8B0FFFFFFF7F1EBCB8F5FFFFFFFFFFFFFE9BA98
        FBF7F465A4FF64A3FF62A2FF61A1FF5F9FFF5C9DFF5A9AFF5798FF5495FF5294
        FFFBF7F4CE9364FFFFFFFFFFFFEBBD9BFBF7F464A4FF79BDFF75BBFF71B9FF6D
        B8FF68B3FF61B0FF5AABFF54A7FF3B7DFFFBF7F4D1976AFFFFFFFFFFFFECBF9E
        FBF7F465A4FF64A3FF60A0FF5D9EFF5899FF5496FF4D90FF478BFF4284FF3D7F
        FFFBF7F4D49B6FFFFFFFFFFFFFEEC1A1FBF7F4FBF7F4FBF7F4FBF7F4FBF7F4FB
        F7F4FBF7F4FBF7F4FBF7F4FBF7F4FBF7F4FBF7F4D7A074FFFFFFFFFFFFEFC2A3
        EFC1A2EDC09FEBBE9DEBBC9AE9BA96E7B793E6B590E4B28CE2AF88E0AC84DDA9
        80DCA57DDAA37AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = MonthBtnClick
    end
    object Label4: TLabel
      Left = 297
      Top = 42
      Width = 89
      Height = 13
      Caption = #1057#1077#1088#1074#1080#1089#1085#1099#1081' '#1094#1077#1085#1090#1088
    end
    object CenterBtn: TSpeedButton
      Left = 700
      Top = 37
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFC9C7DC100D27595672FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF9996B51C1A321A1641FFFFFFFFFFFFFFFFFFFFFFFF100D27
        00000400000F27253DFFFFFFFFFFFFFFFFFFFFFFFF9390B3000000000000D5D3
        EAFFFFFFFFFFFFFFFFFFFFFFFF5A57730000009997AE07042026233BFFFFFFFF
        FFFFFFFFFF201D3A000000787496FFFFFF7A77992E2B47FFFFFFFFFFFFFFFFFF
        2A27420000009795AB07041F2A2741FFFFFFFFFFFF3A36560000000000003B39
        58000000504D67FFFFFFFFFFFFFFFFFFFFFFFF2A27420000009995C2000000AB
        A7CCC7C5DD000000000000000000000000000000DEDCF3FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF2C29460000009490B9D7D5EA00000000000001000E65627E5350
        6DDDDBF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFABA7CED7D5EA00
        0000000000000000FFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFC7C5DE000000000000000001FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9491B1201D3A39365600000000000000
        0001FFFFFF161330696689FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9A97B4
        00000000000000000000000001000EFFFDFFFFFFFF3633500000006F6C8FFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF1E1C340000007673920000020000005E5B7BFF
        FFFFFFFFFFFFFFFF3F3C5C0000003A37568581A7FFFFFFFFFFFFFFFFFF1B1740
        D2D1E2FFFFFF3F3C5B0000004E4B67FFFFFFFFFFFFFFFFFFFFFFFF201D370000
        00000000FFFDFFFFFFFFFFFFFFFFFFFFFFFFFF7B799A000000000000DDDBF5FF
        FFFFFFFFFFFFFFFFFFFFFF8783A9000000000000484565FFFFFFFFFFFFFFFFFF
        FFFFFF2F2C4C504D68DDDBF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
        FF494566EEECFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = CenterBtnClick
    end
    object Label6: TLabel
      Left = 297
      Top = 67
      Width = 61
      Height = 13
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
    end
    object SenterIsDelImg: TImage
      Left = 400
      Top = 39
      Width = 18
      Height = 18
      Transparent = True
    end
    object Label7: TLabel
      Left = 297
      Top = 19
      Width = 59
      Height = 13
      Caption = #1043#1086#1090#1086#1074#1085#1086#1089#1090#1100
    end
    object PB: TGauge
      Left = 400
      Top = 17
      Width = 323
      Height = 16
      BackColor = clBtnFace
      ForeColor = clNavy
      Progress = 0
    end
    object Label8: TLabel
      Left = 761
      Top = 64
      Width = 75
      Height = 13
      Caption = #1040#1082#1090' '#1074#1099#1087' '#1088#1072#1073#1086#1090
    end
    object Label9: TLabel
      Left = 842
      Top = 63
      Width = 13
      Height = 13
      Caption = #8470
    end
    object Label10: TLabel
      Left = 923
      Top = 63
      Width = 12
      Height = 13
      Caption = #1086#1090
    end
    object InvoiceClearBtn: TSpeedButton
      Left = 1037
      Top = 59
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
        FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
        FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
        FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = InvoiceClearBtnClick
    end
    object Label11: TLabel
      Left = 761
      Top = 19
      Width = 79
      Height = 13
      Caption = #1057#1095#1077#1090' '#1085#1072' '#1086#1087#1083#1072#1090#1091
    end
    object Label12: TLabel
      Left = 842
      Top = 19
      Width = 13
      Height = 13
      Caption = #8470
    end
    object Label13: TLabel
      Left = 923
      Top = 19
      Width = 12
      Height = 13
      Caption = #1086#1090
    end
    object FirstInvoiceClearBtn: TSpeedButton
      Left = 1037
      Top = 15
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
        FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
        FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
        FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = FirstInvoiceClearBtnClick
    end
    object OnlyReadLB: TLabel
      Left = 17
      Top = 37
      Width = 111
      Height = 13
      Caption = '('#1090#1086#1083#1100#1082#1086' '#1087#1088#1086#1089#1084#1086#1090#1088')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object InformationBtn: TSpeedButton
      Left = 729
      Top = 38
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000074120000741200000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF79DAF148CFEF3ECDEE3CCCEE3BCCEE39CCEE37
        CBED36CBED35CBED34CAED31CAED30C9ED36CBED75D9F1FFFFFFFFFFFF5BD4F0
        1BC9F0AFECFA9CE7F89CE7F89CE7F8A1ECFD9FEAFB9CE7F89DE7F89EE8F8ADEB
        F91BC9F044CEEEFFFFFFFFFFFFADE7F52FCDF1D6F5FCFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0F0FA20C9F0ABE7F5FFFFFFFFFFFFFFFFFF
        48CFEE39CFF1FFFFFFFFFFFFFFFFFF000000555555FFFFFFFFFFFFFFFFFF27CB
        F037CAEDFFFFFFFFFFFFFFFFFFFFFFFFA1E4F42ACCF1CEF3FBFFFFFFFFFFFFBE
        BEBEE4E4E4FFFFFFFFFFFFB1ECF921C9F0A5E5F4FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF49CFEE3CD0F2FFFFFFFFFFFF000000000000FFFFFFFFFFFF25CBF03DCC
        EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA1E4F42ACCF1D2F4FCFFFFFF45
        4545000000FFFFFFAFECF925CAF0AAE6F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF48CFEE40D1F2FFFFFF252525000000FFFFFF24CAF046CEEEFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA1E4F329CCF1DCFBFF00
        0000000000B0EFFD2ACBF0AFE8F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF49CFEE44D2F2FFFFFFFFFFFF22CAF04DD0EEFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA1E4F429CBF1E7
        F9FDB0ECF92FCCF0B4E9F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF4ACFEE55D6F334CEF255D2EEFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA0E4F439
        CFF23FD0F1B8EAF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF59D2EE69D6EFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Visible = False
      OnClick = InformationBtnClick
    end
    object Label14: TLabel
      Left = 761
      Top = 108
      Width = 158
      Height = 13
      Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    end
    object DocMailDateClearBtn: TSpeedButton
      Left = 1037
      Top = 104
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
        FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
        FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
        FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = DocMailDateClearBtnClick
    end
    object NumberDBED: TDBEdit
      Left = 60
      Top = 64
      Width = 51
      Height = 21
      DataField = 'NUMBER'
      DataSource = MainDS
      TabOrder = 0
    end
    object DocDatePic: TDateTimePicker
      Left = 168
      Top = 64
      Width = 93
      Height = 21
      Date = 43758.606641435190000000
      Time = 43758.606641435190000000
      TabOrder = 1
      OnCloseUp = DocDatePicCloseUp
      OnKeyPress = DocDatePicKeyPress
    end
    object MonthED: TEdit
      Left = 117
      Top = 96
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'MonthED'
    end
    object CenterDB: TEdit
      Left = 416
      Top = 38
      Width = 153
      Height = 21
      Color = clInactiveBorder
      ReadOnly = True
      TabOrder = 3
      Text = #1085#1077' '#1074#1099#1073#1088#1072#1085
    end
    object CityDB: TEdit
      Left = 573
      Top = 38
      Width = 121
      Height = 21
      Color = clInactiveBorder
      ReadOnly = True
      TabOrder = 4
    end
    object InvoiceDBE: TDBEdit
      Left = 861
      Top = 60
      Width = 56
      Height = 21
      DataField = 'INVOICENUMBER'
      DataSource = MainDS
      TabOrder = 5
    end
    object DBMemo1: TDBMemo
      Left = 400
      Top = 65
      Width = 322
      Height = 50
      DataField = 'NOTE'
      DataSource = MainDS
      TabOrder = 6
    end
    object InvoiceDT: TDBEdit
      Left = 941
      Top = 60
      Width = 90
      Height = 21
      DataField = 'INVOICEDATE'
      DataSource = MainDS
      TabOrder = 7
    end
    object FirstInvoiceDBE: TDBEdit
      Left = 861
      Top = 16
      Width = 56
      Height = 21
      DataField = 'FIRSTINVOICENUMBER'
      DataSource = MainDS
      TabOrder = 8
    end
    object PaidCheck: TDBCheckBox
      Left = 861
      Top = 38
      Width = 312
      Height = 17
      Caption = #1087#1077#1088#1077#1076#1072#1085#1086' '#1074' '#1086#1087#1083#1072#1090#1091
      DataField = 'PAIDCHECK'
      DataSource = MainDS
      TabOrder = 9
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      OnClick = PaidCheckClick
    end
    object RecordedCheck: TDBCheckBox
      Left = 861
      Top = 82
      Width = 124
      Height = 17
      Caption = #1088#1072#1079#1085#1077#1089#1077#1085#1086' '#1074' 1'#1057
      DataField = 'RECORDEDCHECK'
      DataSource = MainDS
      TabOrder = 10
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      OnClick = RecordedCheckClick
    end
    object FirstInvoiceDT: TDBEdit
      Left = 941
      Top = 16
      Width = 90
      Height = 21
      DataField = 'FIRSTINVOICEDATE'
      DataSource = MainDS
      TabOrder = 11
    end
    object DBEdit1: TDBEdit
      Left = 941
      Top = 105
      Width = 90
      Height = 21
      DataField = 'DOCMAILDATE'
      DataSource = MainDS
      TabOrder = 12
    end
  end
  inline ImportFrame: TImportFrame
    Left = 50
    Top = 180
    Width = 585
    Height = 250
    TabOrder = 1
    Visible = False
    ExplicitLeft = 50
    ExplicitTop = 180
    ExplicitWidth = 585
    ExplicitHeight = 250
    inherited Panel1: TPanel
      Width = 585
      Height = 250
      ExplicitWidth = 585
      ExplicitHeight = 250
      inherited Panel2: TPanel
        Width = 577
        Color = clMaroon
        ExplicitWidth = 577
        inherited CloseBtn: TSpeedButton
          Left = 538
          Caption = #1061
          Font.Color = clWhite
          Font.Height = -13
          Font.Style = [fsBold]
          Glyph.Data = {00000000}
          NumGlyphs = 1
          ParentFont = False
          OnClick = ImportFrameCloseBtnClick
          ExplicitLeft = 538
          ExplicitTop = 2
        end
        inherited CaptioLb: TLabel
          Font.Color = clWhite
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitTop = 10
        end
      end
      inherited Panel3: TPanel
        Width = 577
        ExplicitWidth = 577
        inherited ChildToolBar: TToolBar
          Width = 575
          ExplicitWidth = 575
        end
      end
      inherited table: TStringGrid
        Width = 583
        Height = 151
        ExplicitWidth = 583
        ExplicitHeight = 151
      end
      inherited Panel4: TPanel
        Top = 208
        Width = 583
        ExplicitTop = 208
        ExplicitWidth = 583
        inherited OKBtn: TBitBtn
          Left = 413
          OnClick = ImportFrameOKBtnClick
          ExplicitLeft = 413
        end
        inherited BottomCloseBtn: TBitBtn
          Left = 493
          Caption = #1054#1090#1084#1077#1085#1072
          OnClick = ImportFrameCloseBtnClick
          ExplicitLeft = 493
        end
      end
    end
  end
  object MainQuery: TADOQuery
    Connection = DMod.Connection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      ''
      'select * from servreport')
    Left = 200
    Top = 16
  end
  object MainDS: TDataSource
    DataSet = MainQuery
    Left = 232
    Top = 16
  end
  object Records: TADOQuery
    Connection = DMod.Connection
    BeforePost = RecordsBeforePost
    AfterDelete = RecordsAfterDelete
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SERVRECORDS')
    Left = 288
    Top = 144
  end
  object RecordsDS: TDataSource
    DataSet = Records
    Left = 328
    Top = 144
  end
  object ReportAction: TActionList
    Images = DMod.ImageList
    Left = 360
    Top = 144
    object ReportPrint: TAction
      Caption = #1055#1077#1095#1072#1090#1100
      ImageIndex = 14
      OnExecute = ReportPrintExecute
    end
    object AcceptAll: TAction
      Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1074#1089#1077
      Hint = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1074#1089#1077'|'#1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1074#1089#1077' '#1087#1088#1080#1085#1103#1090#1099#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 27
      OnExecute = AcceptAllExecute
    end
    object VerifyAll: TAction
      Caption = #1055#1088#1080#1085#1103#1090#1100' '#1074#1089#1077
      Hint = #1055#1088#1080#1085#1103#1090#1100' '#1074#1089#1077'|'#1055#1088#1080#1085#1103#1090#1100' '#1074#1089#1077' '#1079#1072#1087#1080#1089#1080' '#1073#1077#1079' '#1086#1096#1080#1073#1086#1082
      ImageIndex = 52
      OnExecute = VerifyAllExecute
    end
    object NotVerifyAll: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1091
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1091'|'#1057#1085#1103#1090#1100' '#1086#1090#1084#1077#1090#1082#1091' '#1086' '#1087#1088#1086#1074#1077#1088#1082#1077' '#1076#1083#1103' '#1074#1089#1077#1093' '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 49
      OnExecute = NotVerifyAllExecute
    end
    object VerifyReport: TAction
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
      Hint = #1055#1088#1086#1074#1077#1088#1080#1090#1100'|'#1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1086#1090#1095#1077#1090
      ImageIndex = 13
      OnExecute = VerifyReportExecute
    end
    object LoadFromRRPFile: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      ImageIndex = 7
      OnExecute = LoadFromRRPFileExecute
    end
  end
  object OpenDlg: TOpenDialog
    Filter = #1060#1072#1081#1083#1099' '#1086#1090#1095#1077#1090#1086#1074' RENOVA|*.rrp'
    Title = #1047#1072#1075#1088#1079#1091#1082#1072' '#1080#1079' '#1092#1072#1081#1083#1072
    Left = 400
    Top = 144
  end
end
