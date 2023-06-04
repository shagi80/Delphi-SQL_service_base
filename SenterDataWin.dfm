object SenterData: TSenterData
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SenterData'
  ClientHeight = 478
  ClientWidth = 568
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object CloseBtn: TBitBtn
    Left = 463
    Top = 442
    Width = 80
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = CloseBtnClick
    Kind = bkCancel
  end
  object PostBtn: TBitBtn
    Left = 304
    Top = 442
    Width = 81
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    TabOrder = 1
    OnClick = PostBtnClick
    Kind = bkRetry
  end
  object OKBtn: TBitBtn
    Left = 385
    Top = 442
    Width = 80
    Height = 25
    TabOrder = 2
    OnClick = OKBtnClick
    Kind = bkOK
  end
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 569
    Height = 433
    ActivePage = MainPage
    MultiLine = True
    TabOrder = 3
    object MainPage: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1086#1077
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 36
        Height = 13
        Caption = #1050#1086#1076' 1'#1057
      end
      object Label3: TLabel
        Left = 121
        Top = 16
        Width = 39
        Height = 13
        Caption = #1043#1086#1088#1086#1076':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 280
        Top = 16
        Width = 87
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 282
        Top = 72
        Width = 86
        Height = 13
        Caption = #1040#1076#1088#1077#1089' '#1076#1086#1089#1090#1072#1074#1082#1080':'
      end
      object Label4: TLabel
        Left = 16
        Top = 72
        Width = 107
        Height = 13
        Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089':'
      end
      object Label5: TLabel
        Left = 16
        Top = 163
        Width = 65
        Height = 13
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
      end
      object Label7: TLabel
        Left = 16
        Top = 230
        Width = 51
        Height = 13
        Caption = #1050#1086#1085#1090#1072#1082#1090#1099
      end
      object Label10: TLabel
        Left = 268
        Top = 368
        Width = 91
        Height = 13
        Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' : '
      end
      object Label11: TLabel
        Left = 16
        Top = 368
        Width = 48
        Height = 13
        Caption = #1056#1077#1075#1080#1086#1085'  : '
      end
      object CodeDBED: TDBEdit
        Left = 16
        Top = 35
        Width = 89
        Height = 21
        DataField = 'CODE'
        DataSource = MainDS
        TabOrder = 0
      end
      object CityDB: TDBComboBox
        Left = 121
        Top = 35
        Width = 145
        Height = 21
        DataField = 'CITY'
        DataSource = MainDS
        ItemHeight = 13
        TabOrder = 1
      end
      object NameDBED: TDBEdit
        Left = 282
        Top = 35
        Width = 261
        Height = 21
        DataField = 'DESCR'
        DataSource = MainDS
        TabOrder = 2
      end
      object DBMemo1: TDBMemo
        Left = 16
        Top = 91
        Width = 250
        Height = 54
        DataField = 'ADDR'
        DataSource = MainDS
        TabOrder = 3
      end
      object DBMemo2: TDBMemo
        Left = 282
        Top = 91
        Width = 261
        Height = 54
        DataField = 'POSTADDR'
        DataSource = MainDS
        TabOrder = 4
      end
      object DBEdit1: TDBEdit
        Left = 16
        Top = 182
        Width = 527
        Height = 21
        DataField = 'NOTE'
        DataSource = MainDS
        TabOrder = 5
      end
      object Grid: TDBGrid
        Left = 16
        Top = 249
        Width = 527
        Height = 104
        DataSource = ContDS
        TabOrder = 6
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NAME'
            Title.Caption = #1060#1048#1054
            Width = 109
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FUNCT'
            Title.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
            Width = 72
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TEL'
            Title.Caption = #1058#1077#1083#1077#1092#1086#1085
            Width = 88
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMAIL'
            Title.Caption = #1040#1076#1088#1077#1089' e-mail'
            Width = 86
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SKYPE'
            Title.Caption = 'SKYPE-'#1080#1084#1103
            Width = 100
            Visible = True
          end>
      end
      object DBNavigator1: TDBNavigator
        Left = 363
        Top = 224
        Width = 180
        Height = 25
        DataSource = ContDS
        VisibleButtons = [nbFirst, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
        Flat = True
        TabOrder = 7
      end
      object EmplCB: TComboBox
        Left = 385
        Top = 365
        Width = 158
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 8
        OnCloseUp = EmplCBCloseUp
        OnKeyPress = EmplCBKeyPress
      end
      object RegionCB: TComboBox
        Left = 81
        Top = 365
        Width = 112
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 9
        Text = #1085#1077' '#1079#1072#1076#1072#1085
        OnCloseUp = RegionCBCloseUp
        Items.Strings = (
          #1085#1077' '#1079#1072#1076#1072#1085
          #1079#1072#1087#1072#1076
          #1074#1086#1089#1090#1086#1082)
      end
    end
    object AddPage1: TTabSheet
      Caption = #1059#1089#1083#1086#1074#1080#1103
      ImageIndex = 1
      object Label8: TLabel
        Left = 16
        Top = 16
        Width = 87
        Height = 13
        Caption = #1059#1089#1083#1086#1074#1080#1103' '#1088#1072#1073#1086#1090#1099':'
      end
      object Label9: TLabel
        Left = 16
        Top = 144
        Width = 32
        Height = 13
        Caption = #1062#1077#1085#1099':'
      end
      object CopyPriceBtn: TSpeedButton
        Left = 513
        Top = 138
        Width = 26
        Height = 25
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF84B094257341196B
          3725734184B094FFFFFFFFFFFFDFB493D59D74D19668CE9263CB8E5EC98A5BC7
          8756C384526B7744288C5364BA8D95D2B264BA8D288C5381AE91FFFFFFD7A175
          F8F2EDF7F0EAF6EDE6F4EAE2F3E7DEF1E4DBF0E2D822703E62BA8B60BA87FFFF
          FF60B98767BC8F20703DFFFFFFD9A47AF9F3EEEBD2BEFFFFFFEBD3BFFFFFFFFF
          FFFFFFFFFF317B4C9CD4B6FFFFFFFFFFFFFFFFFF95D2B2196B37FFFFFFDDA87E
          F9F3EFEBD0BAEBD0BBEBD0BBEBD0BBEBD0BBEBD1BD49896090D3B192D6B1FFFF
          FF65BC8C67BC8F20703DFFFFFFDFAA82F9F3EFEACEB7FFFFFFEBD0BBFFFFFFFF
          FFFFFFFFFF9DAF9161AB8195D4B4BAE6D06ABB8F2D8F5781AE91FFFFFFE1AE87
          FAF4F0EACBB2EACCB3EACCB3EACCB3EACCB3EACEB7E8C7ACA2AE8E5F97714F8E
          6649895F7B7F4FFFFFFFFFFFFFE3B18CFAF6F1EAC9AEFFFFFFEAC9B0FFFFFFFF
          FFFFFFFFFFE8C7ACFFFFFFFFFFFFFFFFFFF1E5DBC68655FFFFFFFFFFFFE5B48F
          FAF6F2E9C6AAE9C6ACEAC7ACE9C7ADE9C9AEE9C9B0E8C7ACE9C9B0E8C8B0E8CC
          B5F2E7DEC88A59FFFFFFFFFFFFE7B794FBF7F4E9C3A6FFFFFFE8C4A9FFFFFFFF
          FFFFFFFFFFE8C7ACFFFFFFFFFFFFFFFFFFF7F1EBCB8F5FFFFFFFFFFFFFE9BA98
          FBF7F4E9C3A6E9C3A6E9C3A6E9C3A6E9C3A6E9C3A6E9C3A6E9C3A6E9C3A6E9C3
          A6FBF7F4CE9364FFFFFFFFFFFFEBBD9BFBF7F4FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF7F4D1976AFFFFFFFFFFFFECBF9E
          FBF7F49CD5A598D3A194D09D90CE988BCB9387C98E82C6897EC3847AC18076BE
          7CFBF7F4D49B6FFFFFFFFFFFFFEFC6A8FBF7F4FBF7F4FBF7F4FBF7F4FBF7F4FB
          F7F4FBF7F4FBF7F4FBF7F4FBF7F4FBF7F4FBF7F4D8A378FFFFFFFFFFFFF7E1D2
          F1C8ACEDC09FEBBE9DEBBC9AE9BA96E7B793E6B590E4B28CE2AF88E0AC84DDA9
          80DCA57DE2B696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = CopyPriceBtnClick
      end
      object DBMemo3: TDBMemo
        Left = 16
        Top = 35
        Width = 523
        Height = 89
        DataField = 'CONDITIONS'
        DataSource = MainDS
        TabOrder = 0
      end
      object PriceGrid: TDBGrid
        Left = 16
        Top = 163
        Width = 523
        Height = 207
        DataSource = PriceDS
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = PriceGridDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'DESCR'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1094#1077#1085#1099
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'PRICE'
            Title.Alignment = taCenter
            Title.Caption = #1062#1077#1085#1072
            Width = 91
            Visible = True
          end>
      end
      object PriceDBN: TDBNavigator
        Left = 327
        Top = 138
        Width = 180
        Height = 25
        DataSource = PriceDS
        VisibleButtons = [nbFirst, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
        Flat = True
        TabOrder = 2
        BeforeAction = PriceDBNBeforeAction
      end
      object DBCheckBox1: TDBCheckBox
        Left = 16
        Top = 376
        Width = 205
        Height = 17
        Caption = ' - '#1073#1077#1089#1087#1083#1072#1090#1085#1099#1077' '#1076#1077#1090#1072#1083#1080
        DataField = 'FREEPARTS'
        DataSource = MainDS
        TabOrder = 3
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
    end
  end
  object MainQuery: TADOQuery
    Connection = DMod.Connection
    CursorType = ctStatic
    LockType = ltPessimistic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT * FROM SERVCENTRES AS T1 LEFT JOIN SERVCONTACT AS T2 ON T' +
        '1.ID=T2.SENTERID')
    Top = 440
  end
  object MainDS: TDataSource
    DataSet = MainQuery
    Left = 40
    Top = 440
  end
  object ContQuery: TADOQuery
    Connection = DMod.Connection
    BeforePost = ContQueryBeforePost
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SERVCONTACT')
    Left = 80
    Top = 440
  end
  object ContDS: TDataSource
    DataSet = ContQuery
    OnDataChange = ContDSDataChange
    Left = 112
    Top = 440
  end
  object PriceQuery: TADOQuery
    Connection = DMod.Connection
    BeforePost = PriceQueryBeforePost
    Parameters = <>
    Left = 152
    Top = 440
  end
  object PriceDS: TDataSource
    DataSet = PriceQuery
    Left = 184
    Top = 440
  end
  object CopyPriceCmd: TADOQuery
    Connection = DMod.Connection
    Parameters = <>
    SQL.Strings = (
      'DELETE [dbo].[SERVPRICELIST] WHERE [SENTERID]=/CURRENTID/'
      ''
      
        'INSERT INTO [dbo].[SERVPRICELIST] (DESCR,SENTERID,MAINTYPEID,PRI' +
        'CETYPEID,PRICE)'
      
        '    SELECT T2.[DESCR],/CURRENTID/,T2.[MAINTYPEID],T2.[PRICETYPEI' +
        'D],T2.[PRICE]'
      '    FROM [dbo].[SERVPRICELIST] AS T2'
      '    WHERE T2.[SENTERID]=/COPYID/'
      '')
    Left = 224
    Top = 440
  end
end
