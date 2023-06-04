object SenterList: TSenterList
  Left = 197
  Top = 117
  Caption = #1057#1087#1080#1089#1086#1082' '#1089#1077#1088#1074#1080#1089#1085#1099#1093' '#1094#1077#1085#1090#1088#1086#1074
  ClientHeight = 424
  ClientWidth = 713
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object TopPN: TPanel
    Left = 0
    Top = 0
    Width = 713
    Height = 33
    Align = alTop
    Constraints.MaxHeight = 33
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      AlignWithMargins = True
      Left = 686
      Top = 4
      Width = 23
      Height = 22
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1090#1088#1086#1082#1091' '#1087#1086#1080#1089#1082#1072
      Margins.Bottom = 6
      Align = alRight
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
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
      ExplicitLeft = 680
    end
    object Label1: TLabel
      Left = 519
      Top = 1
      Width = 37
      Height = 31
      Align = alRight
      Caption = #1055#1086#1080#1089#1082': '
      Layout = tlCenter
      ExplicitHeight = 13
    end
    object ToolBar1: TToolBar
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 157
      Height = 25
      Align = alLeft
      Caption = 'ToolBar1'
      TabOrder = 0
      object ToolBar2: TToolBar
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 150
        Height = 22
        Caption = 'ToolBar2'
        Images = DMod.ImageList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = New
        end
        object ToolButton3: TToolButton
          Left = 23
          Top = 0
          Action = Delete
        end
        object ToolButton2: TToolButton
          Left = 46
          Top = 0
          Action = Edit
        end
      end
    end
    object FilterED: TEdit
      AlignWithMargins = True
      Left = 559
      Top = 4
      Width = 121
      Height = 22
      Margins.Bottom = 6
      Align = alRight
      TabOrder = 1
      OnChange = FilterEDChange
      ExplicitHeight = 21
    end
  end
  object Grid: TDBGrid
    Left = 0
    Top = 33
    Width = 713
    Height = 391
    Align = alClient
    DataSource = SLSTDS
    DefaultDrawing = False
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = GridDrawColumnCell
    OnDblClick = GridDblClick
    OnTitleClick = GridTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ISDEL'
        Width = 20
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODE'
        Title.Caption = #1050#1086#1076' 1'#1057
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCR'
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CITY'
        Title.Caption = #1043#1086#1088#1086#1076
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REGION'
        Title.Caption = #1056#1077#1075#1080#1086#1085
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPLOYE'
        Title.Caption = #1052#1077#1085#1077#1076#1078#1077#1088
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOTE'
        Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        Width = 250
        Visible = True
      end>
  end
  object ActionList1: TActionList
    Images = DMod.ImageList
    Left = 128
    Top = 120
    object Edit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 24
      OnExecute = EditExecute
    end
    object New: TAction
      Caption = #1053#1086#1074#1099#1081
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1079#1072#1087#1080#1089#1100' '#1086' '#1057#1062
      ImageIndex = 22
      OnExecute = NewExecute
    end
    object Delete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100' '#1086#1073' '#1057#1062
      ImageIndex = 23
      OnExecute = DeleteExecute
    end
  end
  object SLSTDS: TDataSource
    DataSet = SLSTTABLE
    Left = 88
    Top = 120
  end
  object SLSTTABLE: TADOQuery
    Connection = DMod.Connection
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SERVCENTRES')
    Left = 56
    Top = 120
  end
end
