object PrMod: TPrMod
  OldCreateOrder = False
  Height = 117
  Width = 208
  object Query1: TADOQuery
    Connection = DMod.Connection
    Parameters = <>
    Left = 8
    Top = 8
  end
  object Query2: TADOQuery
    Connection = DMod.Connection
    Parameters = <>
    Left = 8
    Top = 48
  end
  object DS1: TDataSource
    DataSet = Query1
    Left = 48
    Top = 8
  end
  object DS2: TDataSource
    DataSet = Query2
    Left = 48
    Top = 48
  end
  object frxData2: TfrxDBDataset
    UserName = 'frxData2'
    CloseDataSource = False
    DataSource = DS2
    BCDToCurrency = False
    Left = 88
    Top = 48
  end
  object frxData1: TfrxDBDataset
    UserName = 'frxData1'
    CloseDataSource = False
    DataSource = DS1
    BCDToCurrency = False
    Left = 88
    Top = 8
  end
  object Report: TfrxReport
    Version = '4.15'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.MDIChild = True
    PreviewOptions.Modal = False
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43826.431082314800000000
    ReportOptions.LastChange = 44109.788907106480000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    OnPreview = ReportPreview
    OnClosePreview = ReportClosePreview
    Left = 128
    Top = 8
    Datasets = <
      item
        DataSet = frxData1
        DataSetName = 'frxData1'
      end
      item
        DataSet = frxData2
        DataSetName = 'frxData2'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 420.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 8
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 143.622140000000000000
        Top = 18.897650000000000000
        Width = 1511.812000000000000000
        object Memo3: TfrxMemoView
          Left = 162.519790000000000000
          Top = 30.236240000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxData2
          DataSetName = 'frxData2'
          Memo.UTF8 = (
            '[FILTER]')
        end
        object Memo38: TfrxMemoView
          Align = baWidth
          Width = 1511.812000000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#160#1056#1106#1056#8216#1056#1115#1056#1118#1056#1106' '#1056#1114#1056#8226#1056#1116#1056#8226#1056#8221#1056#8211#1056#8226#1056#160#1056#1106)
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Top = 30.236240000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1032#1057#1027#1056#187#1056#1109#1056#1030#1056#1105#1057#1039' '#1056#1109#1057#8218#1056#177#1056#1109#1057#1026#1056#176' :')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 162.519790000000000000
          Top = 60.472480000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxData2
          DataSetName = 'frxData2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxData2."CNT"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Top = 60.472480000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109' '#1056#1109#1057#8218#1057#8225#1056#181#1057#8218#1056#1109#1056#1030' :')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 162.519790000000000000
          Top = 79.370130000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxData2
          DataSetName = 'frxData2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxData2."RECCNT"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Top = 79.370130000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109' '#1057#1026#1056#181#1056#1112#1056#1109#1056#1029#1057#8218#1056#1109#1056#1030' :')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 408.189240000000000000
          Top = 60.472480000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxData2
          DataSetName = 'frxData2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxData2."WORKSUM"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 287.244280000000000000
          Top = 60.472480000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8212#1056#176' '#1057#1026#1056#181#1056#1112#1056#1109#1056#1029#1057#8218#1057#8249' :')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 408.189240000000000000
          Top = 79.370130000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxData2
          DataSetName = 'frxData2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxData2."PARTSUM"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 287.244280000000000000
          Top = 79.370130000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8212#1056#176' '#1056#1169#1056#181#1057#8218#1056#176#1056#187#1056#1105' :')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 408.189240000000000000
          Top = 98.267780000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxData2
          DataSetName = 'frxData2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxData2."MOVSUM"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 287.244280000000000000
          Top = 98.267780000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8212#1056#176' '#1056#1030#1057#8249#1056#181#1056#183#1056#1169' :')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 351.496290000000000000
          Top = 117.165430000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxData2
          DataSetName = 'frxData2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxData2."TOTALSUM"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 287.244280000000000000
          Top = 117.165430000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109' :')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 487.559370000000000000
          Top = 60.472480000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            #1057#1026#1057#1107#1056#177)
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 487.559370000000000000
          Top = 79.370130000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            #1057#1026#1057#1107#1056#177)
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 487.559370000000000000
          Top = 98.267780000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            #1057#1026#1057#1107#1056#177)
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 487.559370000000000000
          Top = 117.165430000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1057#1026#1057#1107#1056#177)
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 18.897650000000000000
        Top = 275.905690000000000000
        Width = 1511.812000000000000000
        DataSet = frxData1
        DataSetName = 'frxData1'
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
        object Memo5: TfrxMemoView
          Left = 570.709030000000000000
          Width = 49.133850940000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'BUYDATE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          DisplayFormat.FormatStr = 'dd.mm.yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxData1."BUYDATE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 287.244280000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'CLIENTADDR'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."CLIENTADDR"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 162.519790000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'WORKTYPE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."WORKTYPE"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 215.433210000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'CLIENT'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."CLIENT"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 408.189240000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'MODELNOTE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."MODELNOTE"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 948.662030000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'PROBLEMNOTE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."PROBLEMNOTE"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 718.110700000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'PARTS'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."PARTS"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 1077.166050000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'WORKNOTE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."WORKNOTE"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 351.496290000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'CLIENTTEL'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."CLIENTTEL"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 487.559370000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'SN'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."SN"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 619.842920000000000000
          Width = 49.133850940000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'STARTDATE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          DisplayFormat.FormatStr = 'dd.mm.yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxData1."STARTDATE"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 668.976810000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'ENDDATE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          DisplayFormat.FormatStr = 'dd.mm.yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxData1."ENDDATE"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 812.598950000000000000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'PARTQTY'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxData1."PARTQTY"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 835.276130000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'PARTCOST'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxData1."PARTCOST"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 873.071430000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'MOVPRICE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxData1."MOVPRICE"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 910.866730000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'WORKPRICE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxData1."WORKPRICE"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 1209.449600000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'WORKCODE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxData1."WORKCODE"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 102.047310000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'REPDATE'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."REPDATE"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'SENTERNAME'
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."SENTERNAME"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 1235.906310000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."NOTE"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 1375.748920000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxData1."ERRORS"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 64.252010000000000000
        Top = 355.275820000000000000
        Width = 1511.812000000000000000
        object Memo1: TfrxMemoView
          Left = 1436.221400000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          ShowHint = False
          HAlign = haRight
          Memo.UTF8 = (
            '[Page#]')
        end
      end
      object Header2: TfrxHeader
        Height = 30.236240000000000000
        Top = 222.992270000000000000
        Width = 1511.812000000000000000
        object Memo52: TfrxMemoView
          Left = 570.709030000000000000
          Width = 49.133850940000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          DisplayFormat.FormatStr = 'mm.dd.yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8221#1056#176#1057#8218#1056#176' '#1056#1111#1056#1109#1056#1108#1057#1107#1056#1111#1056#1108#1056#1105)
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 287.244280000000000000
          Width = 64.252010000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1106#1056#1169#1057#1026#1056#181#1057#1027' '#1056#1108#1056#187#1056#1105#1056#181#1056#1029#1057#8218#1056#176)
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 162.519790000000000000
          Width = 52.913420000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1056#1105#1056#1169' '#1057#1026#1056#181#1056#1112#1056#1109#1056#1029#1057#8218#1056#176)
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 215.433210000000000000
          Width = 71.811070000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1113#1056#187#1056#1105#1056#181#1056#1029#1057#8218)
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 408.189240000000000000
          Width = 79.370130000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1114#1056#1109#1056#1169#1056#181#1056#187#1057#1034)
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Left = 948.662030000000000000
          Width = 128.504020000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8221#1056#181#1057#8222#1057#8222#1056#181#1056#1108#1057#8218)
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Left = 718.110700000000000000
          Width = 94.488250000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8221#1056#181#1057#8218#1056#176#1056#187#1056#1105)
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 1077.166050000000000000
          Width = 132.283550000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#160#1056#176#1056#177#1056#1109#1057#8218#1057#8249)
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 351.496290000000000000
          Width = 56.692950000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1118#1056#181#1056#187#1056#181#1057#8222#1056#1109#1056#1029' '#1056#1108#1056#187#1056#1105#1056#181#1056#1029#1057#8218#1056#176)
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 487.559370000000000000
          Width = 83.149660000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1056#181#1057#1026#1056#1105#1056#8470#1056#1029#1057#8249#1056#8470' '#1056#1029#1056#1109#1056#1112#1056#181#1057#1026)
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 619.842920000000000000
          Width = 49.133850940000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          DisplayFormat.FormatStr = 'mm.dd.yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8221#1056#176#1057#8218#1056#176' '#1056#1111#1057#1026#1056#1105#1056#181#1056#1112#1056#176)
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 668.976810000000000000
          Width = 49.133890000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          DisplayFormat.FormatStr = 'mm.dd.yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1115#1056#1108#1056#1109#1056#1029'-'#1056#1029#1056#1105#1056#181' '#1057#1026#1056#181#1056#1112#1056#1109#1056#1029#1057#8218#1056#176)
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 812.598950000000000000
          Width = 22.677180000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1113#1056#1109#1056#187' '#1056#1169#1056#181#1057#8218)
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 835.276130000000000000
          Width = 37.795300000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8212#1056#176' '#1056#1169#1056#181#1057#8218#1056#176#1056#187)
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 873.071430000000000000
          Width = 37.795300000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8212#1056#176' '#1056#1030#1057#8249#1056#181#1056#183#1056#1169)
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 910.866730000000000000
          Width = 37.795300000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8212#1056#176' '#1057#1026#1056#181#1056#1112'-'#1057#8218)
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 1209.449600000000000000
          Width = 26.456710000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1113#1056#1109#1056#1169)
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Width = 102.047310000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1056#181#1057#1026#1056#1030#1056#1105#1057#1027#1056#1029#1057#8249#1056#8470
            #1057#8224#1056#181#1056#1029#1057#8218#1057#1026)
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 102.047310000000000000
          Width = 60.472480000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1115#1057#8218#1057#8225#1056#181#1057#8218#1056#1029#1057#8249#1056#8470' '#1056#1111#1056#181#1057#1026#1056#1105#1056#1109#1056#1169)
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 1235.906310000000000000
          Width = 139.842610000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1119#1057#1026#1056#1105#1056#1112#1056#181#1057#8225#1056#176#1056#1029#1056#1105#1056#181)
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 1375.748920000000000000
          Width = 136.063080000000000000
          Height = 30.236220470000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxData1
          DataSetName = 'frxData1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1115#1057#8364#1056#1105#1056#177#1056#1108#1056#1105)
          ParentFont = False
        end
      end
    end
  end
end
