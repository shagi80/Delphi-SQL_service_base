object ServRepApp: TServRepApp
  Left = 194
  Top = 111
  Caption = 'ServReports'
  ClientHeight = 503
  ClientWidth = 576
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  WindowMenu = Window1
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar2: TToolBar
    Left = 0
    Top = 0
    Width = 576
    Height = 30
    BorderWidth = 1
    Color = clBtnFace
    Images = DMod.ImageList
    Indent = 5
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Wrapable = False
    object ServListBtn: TToolButton
      Left = 5
      Top = 0
      Action = ShowCenterList
    end
    object NewSenterBtn: TToolButton
      Left = 28
      Top = 0
      Action = NewCenter
    end
    object ToolButton13: TToolButton
      Left = 51
      Top = 0
      Width = 8
      Caption = 'ToolButton13'
      ImageIndex = 17
      Style = tbsSeparator
    end
    object ShowReportListBtn: TToolButton
      Left = 59
      Top = 0
      Action = ShowReportList
    end
    object NewReportBtn: TToolButton
      Left = 82
      Top = 0
      Action = NewReport
    end
    object ToolButton14: TToolButton
      Left = 105
      Top = 0
      Width = 8
      Caption = 'ToolButton14'
      ImageIndex = 17
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 113
      Top = 0
      Action = EditCut1
    end
    object ToolButton5: TToolButton
      Left = 136
      Top = 0
      Action = EditCopy1
    end
    object ToolButton6: TToolButton
      Left = 159
      Top = 0
      Action = EditPaste1
    end
    object ToolButton7: TToolButton
      Left = 182
      Top = 0
      Width = 8
      Caption = 'ToolButton7'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton8: TToolButton
      Left = 190
      Top = 0
      Action = WindowCascade1
    end
    object ToolButton10: TToolButton
      Left = 213
      Top = 0
      Action = WindowTileHorizontal1
    end
    object ToolButton11: TToolButton
      Left = 236
      Top = 0
      Action = WindowTileVertical1
    end
    object ToolButton1: TToolButton
      Left = 259
      Top = 0
      Hint = #1056#1072#1073#1086#1090#1072' '#1072#1074#1090#1086#1088#1072'|'#1054#1090#1095#1077#1090' '#1086' '#1088#1072#1073#1086#1090#1077' '#1084#1077#1085#1077#1076#1078#1077#1088#1072' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      Caption = #1056#1072#1073#1086#1090#1072' '#1084#1077#1085#1077#1076#1078#1077#1088#1072
      Enabled = False
      OnClick = ToolButton1Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 457
    Width = 576
    Height = 46
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    object StatusBar: TStatusBar
      Left = 1
      Top = 26
      Width = 574
      Height = 19
      AutoHint = True
      Panels = <>
      SimplePanel = True
    end
    object Pages: TPageControl
      Left = 1
      Top = 1
      Width = 574
      Height = 25
      Align = alBottom
      Images = DMod.ImageList
      Style = tsFlatButtons
      TabOrder = 1
      TabWidth = 100
      OnChange = PagesChange
    end
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 48
    object File1: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      GroupIndex = 1
      Hint = #1050#1086#1084#1072#1085#1076#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103'  '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077#1084
      OnClick = File1Click
      object PrintMI: TMenuItem
        Action = PrintReport
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object PDFExportMI: TMenuItem
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' PDF ...'
        Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' PDF|'#1069#1082#1089#1087#1086#1088#1090' '#1074' PDF ...'
        OnClick = ExportMIClick
      end
      object XLSExportMI: TMenuItem
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' XLS ...'
        Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' XLS|'#1069#1082#1089#1087#1086#1088#1090' '#1074' XLS ...'
        OnClick = ExportMIClick
      end
      object ODSExportMI: TMenuItem
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' ODS ...'
        Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' ODS|'#1069#1082#1089#1087#1086#1088#1090' '#1074' ODS ...'
        OnClick = ExportMIClick
      end
      object ODTExportMI: TMenuItem
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' ODT ...'
        Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' ODT|'#1069#1082#1089#1087#1086#1088#1090' '#1074' ODT ...'
        OnClick = ExportMIClick
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object FileExitItem: TMenuItem
        Action = FileExit
      end
    end
    object N2: TMenuItem
      Caption = '&'#1044#1072#1085#1085#1099#1077
      GroupIndex = 2
      Hint = #1050#1086#1084#1072#1085#1076#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103' '#1076#1072#1085#1085#1099#1084#1080
      OnClick = N2Click
      object N3: TMenuItem
        Action = ShowCenterList
      end
      object N6: TMenuItem
        Action = NewCenter
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object N4: TMenuItem
        Action = ShowReportList
      end
      object N5: TMenuItem
        Action = NewReport
      end
      object ReportSeparator: TMenuItem
        Caption = '-'
      end
      object ReportVerify: TMenuItem
        Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1086#1090#1095#1077#1090
      end
      object ReportAcceptAll: TMenuItem
        Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1074#1089#1077
        Hint = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1074#1089#1077'|'#1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1074#1089#1077' '#1087#1088#1080#1085#1103#1090#1099#1077' '#1079#1072#1087#1080#1089#1080
        ImageIndex = 27
      end
      object ReportNotVerifyAll: TMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1091
        Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1091'|'#1057#1085#1103#1090#1100' '#1086#1090#1084#1077#1090#1082#1091' '#1086' '#1087#1088#1086#1074#1077#1088#1082#1077' '#1076#1083#1103' '#1074#1089#1077#1093' '#1079#1072#1087#1080#1089#1077#1081
        ImageIndex = 49
      end
    end
    object ReportMI: TMenuItem
      Caption = #1054'&'#1090#1095#1077#1090#1099
      GroupIndex = 7
      Hint = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1077#1090#1086#1074
      object N20: TMenuItem
        Action = ReportForRecords
      end
      object N14: TMenuItem
        Tag = 5
        Action = ReportForAutor
      end
      object N10: TMenuItem
        Action = ReportWestEast
      end
      object N11: TMenuItem
        Action = ReportForDocMail
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object N16: TMenuItem
        Action = ReportForPay
      end
      object N17: TMenuItem
        Action = ReportForRecorded
      end
    end
    object SevMG: TMenuItem
      Caption = '&'#1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      GroupIndex = 7
      Hint = #1057#1083#1091#1078#1077#1073#1085#1099#1077' '#1092#1091#1085#1082#1094#1080#1080
      OnClick = SevMGClick
      object N8: TMenuItem
        Action = ChangeEditor
      end
      object N18: TMenuItem
        Tag = 1
        Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1086#1076#1086#1074
        Hint = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1086#1076#1086#1074'|'#1042#1099#1079#1086#1074' '#1088#1077#1076#1072#1082#1090#1086#1088#1072' '#1082#1086#1076#1086#1074' '#1085#1077#1080#1089#1087#1088#1072#1074#1085#1086#1089#1090#1077#1081
        OnClick = LaunchToolsExecute
      end
      object N19: TMenuItem
        Tag = 2
        Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1089#1087#1080#1089#1082#1072' '#1094#1077#1085
        Hint = #1056#1077#1076#1072#1082#1090#1086#1088' '#1089#1087#1080#1089#1082#1072' '#1094#1077#1085'|'#1042#1099#1079#1086#1074' '#1088#1077#1076#1072#1082#1090#1086#1088#1072' '#1089#1087#1080#1089#1082#1072' '#1094#1077#1085
        OnClick = LaunchToolsExecute
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object LoadToCenterTable: TMenuItem
        Action = LoadCentres
      end
      object LoadToCodeTable: TMenuItem
        Action = LoadCodes
      end
    end
    object Window1: TMenuItem
      Caption = '&'#1054#1082#1085#1086
      GroupIndex = 7
      Hint = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1086#1082#1085#1072#1084#1080
      object WindowCascadeItem: TMenuItem
        Action = WindowCascade1
      end
      object WindowTileItem: TMenuItem
        Action = WindowTileHorizontal1
      end
      object WindowTileItem2: TMenuItem
        Action = WindowTileVertical1
      end
      object WindowMinimizeItem: TMenuItem
        Action = WindowMinimizeAll1
      end
      object WindowArrangeItem: TMenuItem
        Action = WindowArrangeAll1
      end
    end
    object Help1: TMenuItem
      Caption = '&'#1055#1086#1084#1086#1097#1100
      GroupIndex = 7
      Hint = #1055#1086#1084#1086#1097#1100
      object HelpAboutItem: TMenuItem
        Action = HelpAbout1
        Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' ...'
      end
    end
  end
  object OpenDlg: TOpenDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt'
    Left = 8
    Top = 48
  end
  object ActionList1: TActionList
    Images = DMod.ImageList
    Left = 72
    Top = 48
    object FileExit: TAction
      Category = 'File'
      Caption = #1042'&'#1099#1093#1086#1076
      Hint = #1042#1099#1093#1086#1076'|'#1047#1072#1082#1088#1099#1090#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077
      OnExecute = FileExitExecute
    end
    object EditCut1: TEditCut
      Category = 'Edit'
      Caption = #1042#1099'&'#1088#1077#1079#1072#1090#1100
      Enabled = False
      Hint = #1042#1099#1088#1077#1079#1072#1090#1100'|'#1042#1099#1088#1077#1079#1072#1090#1100' '#1090#1077#1082#1089#1090' '#1080' '#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&'#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100'|'#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1089#1090' '#1074' '#1073#1091#1092#1077#1088
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&'#1042#1089#1090#1072#1074#1080#1090#1073
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100'|'#1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1077#1082#1089#1090' '#1080#1079' '#1073#1091#1092#1077#1088#1072
      ImageIndex = 2
      ShortCut = 16470
    end
    object WindowCascade1: TWindowCascade
      Category = 'Window'
      Caption = '&'#1050#1072#1089#1082#1072#1076#1086#1084
      Hint = #1050#1072#1089#1082#1072#1076#1086#1084'|'#1056#1072#1089#1087#1086#1083#1086#1078#1080#1090#1100' '#1086#1082#1085#1072' '#1082#1072#1089#1082#1072#1076#1086#1084
      ImageIndex = 17
    end
    object WindowTileHorizontal1: TWindowTileHorizontal
      Category = 'Window'
      Caption = '&'#1043#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086
      Hint = #1043#1086#1088#1080#1079#1086#1085#1090#1087#1083#1100#1085#1086'|'#1056#1072#1089#1087#1086#1083#1086#1078#1080#1090#1100' '#1086#1082#1085#1072' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086
      ImageIndex = 15
    end
    object WindowTileVertical1: TWindowTileVertical
      Category = 'Window'
      Caption = '&'#1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086
      Hint = #1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086'|'#1056#1072#1089#1087#1086#1083#1086#1078#1080#1090#1100' '#1086#1082#1085#1072' '#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086
      ImageIndex = 16
    end
    object WindowMinimizeAll1: TWindowMinimizeAll
      Category = 'Window'
      Caption = '&'#1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      Hint = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077'|'#1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1086#1082#1085#1072
    end
    object WindowArrangeAll1: TWindowArrange
      Category = 'Window'
      Caption = '&'#1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      Hint = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077'|'#1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1086#1082#1085#1072
    end
    object HelpAbout1: TAction
      Category = 'Help'
      Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      Hint = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'|'#1048#1085#1092#1086#1088#1080#1072#1094#1080#1103' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' '#1080' '#1072#1074#1090#1086#1088#1077
      OnExecute = HelpAbout1Execute
    end
    object ShowCenterList: TAction
      Category = 'Data'
      Caption = #1057#1077#1088#1074#1080#1089#1085#1099#1077' '#1094#1077#1085#1090#1088#1099
      Hint = #1057#1077#1088#1074#1080#1089#1085#1099#1077' '#1094#1077#1085#1090#1088#1099'|'#1054#1090#1082#1088#1099#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1089#1077#1088#1074#1080#1089#1085#1099#1093' '#1094#1077#1085#1090#1088#1086#1074
      ImageIndex = 18
      OnExecute = ShowCenterListExecute
    end
    object ShowReportList: TAction
      Category = 'Data'
      Caption = #1054#1090#1095#1077#1090#1099
      Hint = #1054#1090#1095#1077#1090#1099'|'#1054#1090#1082#1088#1099#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1086#1090#1095#1077#1090#1086#1074
      ImageIndex = 25
      OnExecute = ShowReportListExecute
    end
    object NewCenter: TAction
      Category = 'Data'
      Caption = #1053#1086#1074#1099#1081' '#1089#1077#1088#1074#1080#1089
      Hint = #1053#1086#1074#1099#1081' '#1089#1077#1088#1074#1080#1089'|'#1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100' '#1086' '#1085#1086#1074#1086#1084' '#1089#1077#1088#1074#1080#1089#1085#1086#1084' '#1094#1077#1085#1090#1088#1077
      ImageIndex = 22
      OnExecute = NewCenterExecute
    end
    object NewReport: TAction
      Category = 'Data'
      Caption = #1053#1086#1074#1099#1081' '#1086#1090#1095#1077#1090
      Hint = #1053#1086#1074#1099#1081' '#1086#1090#1095#1077#1090'|'#1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1099#1081' '#1086#1090#1095#1077#1090
      ImageIndex = 19
      OnExecute = NewReportExecute
    end
    object LoadCentres: TAction
      Category = 'Tools'
      Caption = #1047#1072#1087#1086#1083#1085#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099' '#1057#1062
      Enabled = False
      Hint = #1047#1072#1087#1086#1083#1085#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099' '#1057#1062'|'#1047#1072#1075#1088#1091#1082#1072' '#1076#1072#1085#1085#1099#1093' '#1074' '#1090#1072#1073#1083#1080#1094#1091' '#1057#1062' '#1080#1079' '#1092#1072#1081#1083#1072
      OnExecute = LoadCentresExecute
    end
    object LoadCodes: TAction
      Category = 'Tools'
      Caption = #1047#1072#1087#1086#1083#1085#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099' '#1082#1086#1076#1086#1074
      Enabled = False
      Hint = 
        #1047#1072#1087#1086#1083#1085#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099' '#1082#1086#1076#1086#1074'|'#1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093' '#1074' '#1090#1072#1073#1083#1080#1094#1091' '#1082#1086#1076#1086#1074' '#1080#1079' '#1092#1072#1081#1083 +
        #1072
      OnExecute = LoadCodesExecute
    end
    object ChangeEditor: TAction
      Category = 'Tools'
      Caption = #1057#1084#1077#1085#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      Hint = #1057#1084#1077#1085#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103'|'#1054#1082#1085#1086' '#1089#1084#1077#1085#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      OnExecute = ChangeEditorExecute
    end
    object FilePrintSetup: TFilePrintSetup
      Category = 'File'
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1080#1085#1090#1077#1088#1072' ...'
      Enabled = False
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1080#1085#1090#1077#1088#1072'|'#1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1080#1085#1090#1077#1088#1072' ...'
    end
    object FilePageSetup: TFilePageSetup
      Category = 'File'
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1090#1088#1072#1085#1080#1094#1099' ...'
      Dialog.MinMarginLeft = 0
      Dialog.MinMarginTop = 0
      Dialog.MinMarginRight = 0
      Dialog.MinMarginBottom = 0
      Dialog.MarginLeft = 2500
      Dialog.MarginTop = 2500
      Dialog.MarginRight = 2500
      Dialog.MarginBottom = 2500
      Dialog.PageWidth = 21000
      Dialog.PageHeight = 29700
      Enabled = False
      Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1090#1088#1072#1085#1080#1094#1099'|'#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1090#1088#1072#1085#1080#1094#1099' ...'
    end
    object PrintReport: TAction
      Category = 'File'
      Caption = #1055#1077#1095#1072#1090#1100' ...'
      Hint = #1055#1077#1095#1072#1090#1100'|'#1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1072' ...'
      ImageIndex = 14
      OnExecute = PrintReportExecute
    end
    object ReportForPay: TAction
      Category = 'Reports'
      Caption = #1042#1099#1075#1088#1079#1082#1072' '#1087#1086' '#1089#1095#1077#1090#1072#1084
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1076#1083#1103' '#1086#1087#1083#1072#1090#1099'|'#1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1077#1090#1072' '#1076#1083#1103' '#1086#1087#1083#1072#1090#1099' '#1057#1062
      ImageIndex = 54
      OnExecute = ReportForPayExecute
    end
    object ReportForRecorded: TAction
      Category = 'Reports'
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1087#1086' '#1072#1082#1090#1072#1084
      Hint = 
        #1042#1099#1075#1088#1091#1079#1082#1072' '#1076#1083#1103' '#1088#1072#1079#1085#1077#1089#1077#1085#1080#1103' '#1079#1072#1090#1088#1072#1090'|'#1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1095#1077#1090#1072' '#1076#1083#1103' '#1087#1077#1088#1077#1085#1086#1089#1072' '#1076 +
        #1072#1085#1085#1099#1093' '#1074' 1'#1057
      OnExecute = ReportForRecordedExecute
    end
    object LaunchTools: TAction
      Category = 'Tools'
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1086#1076#1086#1074
      Hint = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1086#1076#1086#1074'|'#1042#1099#1079#1086#1074' '#1088#1077#1076#1072#1082#1090#1086#1088#1072' '#1082#1086#1076#1086#1074' '#1085#1077#1080#1089#1087#1088#1072#1074#1085#1086#1089#1090#1077#1081
      OnExecute = LaunchToolsExecute
    end
    object ReportForRecords: TAction
      Category = 'Reports'
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086' '#1088#1077#1084#1086#1085#1090#1072#1084
      Hint = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086' '#1088#1077#1084#1086#1085#1090#1072#1084'|'#1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1079#1072#1087#1088#1086#1089' '#1082' '#1090#1072#1073#1083#1080#1094#1077' '#1088#1077#1084#1086#1085#1090#1086#1074
      OnExecute = ReportForRecordsExecute
    end
    object ReportForAutor: TAction
      Category = 'Reports'
      Caption = #1056#1072#1073#1086#1090#1072' '#1084#1077#1085#1077#1076#1078#1077#1088#1072
      Hint = #1056#1072#1073#1086#1090#1072' '#1072#1074#1090#1086#1088#1072'|'#1054#1090#1095#1077#1090' '#1086' '#1088#1072#1073#1086#1090#1077' '#1084#1077#1085#1077#1076#1078#1077#1088#1072' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      OnExecute = ReportForAutorExecute
    end
    object ReportWestEast: TAction
      Category = 'Reports'
      Caption = #1042#1079#1072#1080#1084#1086#1088#1072#1089#1095#1077#1090#1099' '#1086#1090#1076#1077#1083#1077#1085#1080#1081
      Hint = 
        #1042#1079#1072#1080#1084#1086#1088#1072#1089#1095#1077#1090#1099' '#1086#1090#1076#1077#1083#1077#1085#1080#1081'|'#1054#1090#1095#1077#1090' '#1087#1086' '#1074#1079#1072#1080#1084#1085#1099#1084' '#1088#1077#1084#1086#1085#1090#1072#1084' '#1087#1088#1086#1076#1091#1082#1094#1080#1080' '#1079#1072#1087 +
        #1072#1076#1085#1086#1075#1086' '#1080' '#1074#1086#1089#1090#1086#1095#1085#1086#1075#1086' '#1086#1090#1076#1077#1083#1077#1085#1080#1081
      OnExecute = ReportWestEastExecute
    end
    object ReportForDocMail: TAction
      Category = 'Reports'
      Caption = #1055#1088#1080#1085#1103#1090#1072#1103' '#1087#1086#1095#1090#1072
      Hint = #1055#1088#1080#1085#1103#1090#1072#1103' '#1087#1086#1095#1090#1072'|'#1054#1090#1095#1077#1090' '#1087#1086' '#1087#1088#1080#1085#1103#1090#1086#1081' '#1087#1086#1095#1090#1077
      OnExecute = ReportForDocMailExecute
    end
  end
  object Events: TApplicationEvents
    OnActivate = EventsActivate
    OnIdle = EventsIdle
    OnMessage = EventsMessage
    Left = 104
    Top = 48
  end
end
