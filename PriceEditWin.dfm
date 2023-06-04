object PriceEditForm: TPriceEditForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1094#1077#1085#1099
  ClientHeight = 202
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 380
    Height = 161
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 73
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    end
    object Label2: TLabel
      Left = 24
      Top = 60
      Width = 76
      Height = 13
      Caption = #1058#1080#1087' '#1087#1088#1086#1076#1091#1082#1094#1080#1080
    end
    object Label3: TLabel
      Left = 24
      Top = 88
      Width = 47
      Height = 13
      Caption = #1058#1080#1087' '#1094#1077#1085#1099
    end
    object Label4: TLabel
      Left = 24
      Top = 113
      Width = 26
      Height = 13
      Caption = #1062#1077#1085#1072
    end
    object Label5: TLabel
      Left = 223
      Top = 113
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Caption = #1088#1091#1073
    end
    object DBEdit1: TDBEdit
      Left = 120
      Top = 21
      Width = 233
      Height = 21
      DataField = 'DESCR'
      DataSource = DS
      TabOrder = 0
    end
    object MainTypeCB: TDBLookupComboBox
      Left = 120
      Top = 56
      Width = 233
      Height = 21
      DataField = 'MAINTYPEID'
      DataSource = DS
      KeyField = 'ID'
      ListField = 'DESCR'
      ListSource = MTDS
      TabOrder = 1
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 120
      Top = 83
      Width = 121
      Height = 21
      DataField = 'PRICETYPEID'
      DataSource = DS
      KeyField = 'ID'
      ListField = 'DESCR'
      ListSource = PDS
      TabOrder = 2
    end
    object DBEdit2: TDBEdit
      Left = 120
      Top = 110
      Width = 89
      Height = 21
      DataField = 'PRICE'
      DataSource = DS
      TabOrder = 3
    end
  end
  object PostBtn: TBitBtn
    Left = 107
    Top = 167
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = PostBtnClick
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
  object CancelBtn: TBitBtn
    Left = 188
    Top = 167
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
    OnClick = CancelBtnClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object MTDS: TDataSource
    DataSet = DMod.MainTypesTable
    Left = 256
    Top = 80
  end
  object Query: TADOQuery
    Connection = DMod.Connection
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 288
    Top = 80
  end
  object DS: TDataSource
    DataSet = Query
    Left = 320
    Top = 80
  end
  object PriceQuery: TADOQuery
    Connection = DMod.Connection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM [DBO].[SERVPRICETYPES]')
    Left = 256
    Top = 112
  end
  object PDS: TDataSource
    DataSet = PriceQuery
    Left = 288
    Top = 112
  end
end
