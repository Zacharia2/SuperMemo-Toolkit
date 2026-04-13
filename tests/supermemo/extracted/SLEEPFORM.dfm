object SleepForm: TSleepForm
  Left = 546
  Top = 136
  HelpContext = 39
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Sleep and learning timeline'
  ClientHeight = 915
  ClientWidth = 1254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  Menu = MainMenu1
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnMouseWheel = FormMouseWheel
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 24
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1254
    Height = 915
    ActivePage = CircadianTab
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object SleepTab: TTabSheet
      Caption = 'Timeline'
      object PaintBox1: TPaintBox
        Left = 0
        Top = 49
        Width = 1227
        Height = 827
        Cursor = crCross
        Align = alClient
        OnMouseDown = PaintBox1MouseDown
        OnMouseMove = PaintBox1MouseMove
        OnPaint = PaintBox1Paint
        ExplicitTop = 44
        ExplicitWidth = 1223
        ExplicitHeight = 829
      end
      object ToolBar1: TToolBar
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 1236
        Height = 39
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ButtonHeight = 39
        ButtonWidth = 39
        Caption = 'ToolBar1'
        Images = AboutBox.VirtualImageList32
        List = True
        TabOrder = 0
        object ConsolidateBlocksBtn: TToolButton
          Left = 0
          Top = 0
          Hint = 'Consolidate sleep blocks'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'ConsolidateBlocksBtn'
          ImageIndex = 118
          ImageName = 'icon_118'
          OnClick = ConsolidateBlocksBtnClick
        end
        object Approximations: TToolButton
          Left = 39
          Top = 0
          Hint = 'Re-compute circadian approximations on current sleep data'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Approximations'
          ImageIndex = 127
          ImageName = 'icon_127'
          OnClick = ApproximationsClick
        end
        object EMailButton: TToolButton
          Left = 78
          Top = 0
          Hint = 'Mail file to SuperMemo R&D for research purposes'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'EMailButton'
          ImageIndex = 130
          ImageName = 'icon_130'
          OnClick = EMailButtonClick
        end
        object GoToBtn: TToolButton
          Left = 117
          Top = 0
          Hint = 'Go to a given day in the log'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'GoToBtn'
          ImageIndex = 7
          ImageName = 'icon_007'
          OnClick = GoToBtnClick
        end
        object InfoButton: TToolButton
          Left = 156
          Top = 0
          Hint = 'Show time block data'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'InfoButton'
          ImageIndex = 31
          ImageName = 'icon_031'
          OnClick = InfoButtonClick
        end
        object TraceButton: TToolButton
          Left = 195
          Top = 0
          Hint = 'Trace mouse with block selections'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'TraceButton'
          ImageIndex = 121
          ImageName = 'icon_121'
          OnClick = TraceButtonClick
        end
        object SaveDataBtn: TToolButton
          Left = 234
          Top = 0
          Hint = 'Save the current timeline file'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'SaveDataBtn'
          ImageIndex = 51
          ImageName = 'icon_051'
          OnClick = SaveDataBtnClick
        end
        object OpenDataBtn: TToolButton
          Left = 273
          Top = 0
          Hint = 'Open a new timeline file'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'OpenDataBtn'
          ImageIndex = 2
          ImageName = 'icon_002'
          OnClick = OpenDataBtnClick
        end
        object ComboBox1: TComboBox
          Left = 312
          Top = 0
          Width = 291
          Height = 32
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'None'
          Visible = False
          OnChange = ComboBox1Change
          Items.Strings = (
            'None'
            'Circadian'
            'Homeostatic'
            'Sleepiness'
            'All')
        end
      end
      object ScrollBar1: TScrollBar
        Left = 1227
        Top = 49
        Width = 19
        Height = 827
        Align = alRight
        Kind = sbVertical
        PageSize = 0
        TabOrder = 1
        OnChange = ScrollBar1Change
      end
    end
    object CircadianTab: TTabSheet
      Caption = 'Circadian'
      ImageIndex = 4
      object CircadianPaintBox: TPaintBox
        Left = 0
        Top = 44
        Width = 1246
        Height = 832
        Align = alClient
        Color = clWhite
        ParentColor = False
        OnPaint = CircadianPaintBoxPaint
        ExplicitWidth = 1233
        ExplicitHeight = 829
      end
      object ToolBar3: TToolBar
        Left = 0
        Top = 0
        Width = 1246
        Height = 44
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ButtonHeight = 38
        ButtonWidth = 98
        Caption = 'ToolBar3'
        Images = AboutBox.VirtualImageList32
        List = True
        AllowTextButtons = True
        TabOrder = 0
        object PhaseShiftBtn: TToolButton
          Left = 0
          Top = 0
          Hint = 'Switch between absolute and relative hours'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'PhaseShiftBtn'
          ImageIndex = 119
          ImageName = 'icon_119'
          Style = tbsCheck
          OnClick = PhaseShiftBtnClick
        end
        object Consolidate1: TToolButton
          Left = 40
          Top = 0
          Hint = 'Consolidate sleep blocks for circadian graph display'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Consolidate1'
          ImageIndex = 118
          ImageName = 'icon_118'
          Style = tbsCheck
          OnClick = ConsolidateClick
        end
        object SleepDataBtn: TToolButton
          Left = 80
          Top = 0
          Hint = 'Change between sleep data and repetition data'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'SleepDataBtn'
          Down = True
          ImageIndex = 207
          ImageName = 'icon_207'
          Style = tbsCheck
          OnClick = SleepDataBtnClick
        end
        object FromBtn: TToolButton
          Left = 120
          Top = 0
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AutoSize = True
          Caption = 'From: '
          Enabled = False
          Style = tbsTextButton
          OnClick = FromBtnClick
        end
        object ToolButton3: TToolButton
          Left = 186
          Top = 0
          Hint = 'Pick a starting day for data display'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'ToolButton3'
          ImageIndex = 125
          ImageName = 'icon_125'
          OnClick = ToolButton3Click
        end
        object ToBtn: TToolButton
          Left = 226
          Top = 0
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AutoSize = True
          Caption = 'To: '
          Enabled = False
          Style = tbsTextButton
        end
        object ToolButton4: TToolButton
          Left = 270
          Top = 0
          Hint = 'Pick an ending day for data display'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'ToolButton4'
          ImageIndex = 126
          ImageName = 'icon_126'
          OnClick = ToolButton4Click
        end
        object BlockNoLabel: TLabel
          AlignWithMargins = True
          Left = 310
          Top = 0
          Width = 128
          Height = 38
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alRight
          Alignment = taCenter
          Caption = 'Blocks found: 0'
          Layout = tlCenter
        end
      end
    end
    object PhaseShiftTab: TTabSheet
      Caption = 'Phase shift'
      ImageIndex = 1
      object PhaseShiftPaintBox: TPaintBox
        Left = 0
        Top = 44
        Width = 1246
        Height = 832
        Align = alClient
        OnPaint = PhaseShiftPaintBoxPaint
        ExplicitWidth = 1233
        ExplicitHeight = 829
      end
      object ToolBar2: TToolBar
        Left = 0
        Top = 0
        Width = 1246
        Height = 44
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ButtonHeight = 33
        ButtonWidth = 35
        Caption = 'ToolBar2'
        Images = AboutBox.ImageList1
        TabOrder = 0
        object Consolidate2: TToolButton
          Left = 0
          Top = 0
          Hint = 'Consolidate interrupted blocks'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Consolidate2'
          ImageIndex = 118
          OnClick = ConsolidateClick
        end
        object ClearStartButton: TToolButton
          Left = 35
          Top = 0
          Hint = 'Show only waking times'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'ClearStartButton'
          ImageIndex = 116
          OnClick = ClearStartButtonClick
        end
        object ClearFinishButton: TToolButton
          Left = 70
          Top = 0
          Hint = 'Show only retirement times'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'ClearFinishButton'
          ImageIndex = 117
          OnClick = ClearFinishButtonClick
        end
        object RelativeButton: TToolButton
          Left = 105
          Top = 0
          Hint = 
            'Switch between hours and relative hours (i.e. hours counted from' +
            ' arising)'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'RelativeButton'
          ImageIndex = 119
          OnClick = RelativeButtonClick
        end
      end
    end
    object AlertnessH: TTabSheet
      Hint = 'Changes in mental performance with waking time'
      Caption = 'Alertness (H)'
      ImageIndex = 4
      object AlertnessPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1246
        Height = 845
        Align = alClient
        OnClick = AlertnessPaintBoxClick
        ExplicitWidth = 1233
        ExplicitHeight = 837
      end
      object ToolBar4: TToolBar
        Left = 0
        Top = 845
        Width = 1246
        Height = 31
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        AutoSize = True
        ButtonHeight = 31
        ButtonWidth = 35
        Caption = 'ToolBar4'
        Color = clBtnFace
        Images = AboutBox.ImageList1
        ParentColor = False
        TabOrder = 0
        object AlertnessExcel: TToolButton
          Left = 0
          Top = 0
          Hint = 'Save data with homeostatic decline in alertness in an Excel file'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AutoSize = True
          ImageIndex = 51
          Visible = False
          OnClick = AlertnessExcelClick
        end
        object MinLengthE: TEdit
          Left = 23
          Top = 0
          Width = 91
          Height = 31
          Hint = 'Minimum length of sleep blocks to consider (in hours)'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Microsoft YaHei'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '0.2'
          OnKeyDown = MinLengthEKeyDown
        end
        object HalflifeEdit: TEdit
          Left = 114
          Top = 0
          Width = 140
          Height = 31
          Hint = 'Homeostatic alertness halflife (in hours)'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Microsoft YaHei'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = '5'
          OnKeyDown = HalflifeEditKeyDown
        end
        object RepCasesAlert: TLabel
          Left = 254
          Top = 0
          Width = 173
          Height = 24
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = '   Repetition cases:   '
          Visible = False
        end
        object FormulaAlert: TLabel
          Left = 427
          Top = 0
          Width = 105
          Height = 24
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = '   Formula:   '
        end
      end
    end
    object AlertnessC: TTabSheet
      Hint = 'Changes in mental performance with circadian time'
      Caption = 'Alertness (C)'
      ImageIndex = 5
      object PerformancePaintBox: TPaintBox
        Left = 0
        Top = 33
        Width = 1246
        Height = 843
        Align = alClient
        ExplicitWidth = 1233
        ExplicitHeight = 840
      end
      object ApproxToolbar: TToolBar
        Left = 0
        Top = 0
        Width = 1246
        Height = 33
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ButtonHeight = 33
        ButtonWidth = 129
        Caption = 'ApproxToolbar'
        Images = AboutBox.ImageList1
        List = True
        ShowCaptions = True
        AllowTextButtons = True
        TabOrder = 0
        object HomeoButton: TToolButton
          Left = 0
          Top = 0
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AllowAllUp = True
          AutoSize = True
          Caption = 'Homeostatic'
          Style = tbsTextButton
          OnClick = HomeoButtonClick
        end
        object CButton: TToolButton
          Left = 115
          Top = 0
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AllowAllUp = True
          AutoSize = True
          Caption = 'Circadian'
          Style = tbsTextButton
          OnClick = CButtonClick
        end
        object SButton: TToolButton
          Left = 205
          Top = 0
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AllowAllUp = True
          AutoSize = True
          Caption = 'Alertness'
          Style = tbsTextButton
          OnClick = SButtonClick
        end
        object SDButton: TToolButton
          Left = 294
          Top = 0
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AllowAllUp = True
          AutoSize = True
          Caption = 'Wake'
          Style = tbsTextButton
          OnClick = SDButtonClick
        end
        object ModelButton: TToolButton
          Left = 353
          Top = 0
          Hint = 
            'Switch between the actual waking time and the optimum waking tim' +
            'e (derived from the sleep model)'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AutoSize = True
          Caption = 'Model'
          Style = tbsTextButton
          OnClick = ModelButtonClick
        end
        object UseRButton: TToolButton
          Left = 417
          Top = 0
          Hint = 
            'Use retrievability instead of 1-success, 0-fail scores (R is der' +
            'ived from DSR model or from grades)'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AutoSize = True
          Caption = 'Use R'
          Style = tbsTextButton
          OnClick = UseRButtonClick
        end
        object PerformanceExcel: TToolButton
          Left = 479
          Top = 0
          Hint = 'Save data with circadian changes in alertness in an Excel file'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AllowAllUp = True
          AutoSize = True
          Caption = 'Excel'
          Style = tbsTextButton
          OnClick = PerformanceExcelClick
        end
        object RepCases: TLabel
          Left = 538
          Top = 0
          Width = 173
          Height = 24
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          Alignment = taCenter
          Caption = '   Repetition cases:   '
          Layout = tlCenter
        end
      end
      object approximation: TButton
        Left = 975
        Top = 78
        Width = 237
        Height = 30
        Caption = 'approximation'
        TabOrder = 1
        Visible = False
        OnClick = approximationClick
      end
    end
    object NapLength: TTabSheet
      Caption = 'Napping'
      ImageIndex = 8
      object NapPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1246
        Height = 876
        Align = alClient
        OnPaint = NapPaintBoxPaint
        ExplicitWidth = 1233
        ExplicitHeight = 873
      end
    end
    object REMTab: TTabSheet
      Caption = 'REM'
      ImageIndex = 6
      object REMPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1246
        Height = 876
        Align = alClient
        ExplicitWidth = 1233
        ExplicitHeight = 873
      end
    end
    object BlockDistribution: TTabSheet
      Caption = 'Distribution'
      ImageIndex = 3
      object DistributionPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1246
        Height = 876
        Align = alClient
        OnPaint = DistributionPaintBoxPaint
        ExplicitWidth = 1233
        ExplicitHeight = 873
      end
      object LogScale: TCheckBox
        Left = 332
        Top = 14
        Width = 244
        Height = 30
        Hint = 'Switch between linear and log scales'
        Caption = 'Log scale'
        TabOrder = 0
        OnClick = LogScaleClick
      end
    end
    object PeriodogramTab: TTabSheet
      Caption = 'Periodogram'
      ImageIndex = 7
      object PeriodogramPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1246
        Height = 876
        Align = alClient
        OnMouseMove = PeriodogramPaintBoxMouseMove
        OnPaint = PeriodogramPaintBoxPaint
        ExplicitWidth = 1233
        ExplicitHeight = 873
      end
      object XYLabel: TLabel
        Left = 830
        Top = 21
        Width = 72
        Height = 24
        Caption = 'XYLabel'
        Transparent = False
        StyleElements = []
      end
    end
    object LearningVsSleep: TTabSheet
      Caption = 'Learning'
      ImageIndex = 9
      object LearningPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1246
        Height = 876
        Align = alClient
        OnMouseDown = LearningPaintBoxMouseDown
        OnPaint = LearningPaintBoxPaint
        ExplicitWidth = 1233
        ExplicitHeight = 873
      end
    end
    object MemoryTab: TTabSheet
      Caption = 'Consolidation'
      ImageIndex = 10
      object MemoryPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1246
        Height = 876
        Align = alClient
        ExplicitWidth = 1233
        ExplicitHeight = 873
      end
    end
  end
  object Approximate: TButton
    Left = 530
    Top = 107
    Width = 246
    Height = 30
    Caption = 'Approximate'
    TabOrder = 1
    Visible = False
    OnClick = ApproximateClick
  end
  object Button3: TButton
    Left = 704
    Top = 107
    Width = 91
    Height = 30
    Caption = 'Overlap'
    TabOrder = 2
    Visible = False
  end
  object Button4: TButton
    Left = 815
    Top = 107
    Width = 255
    Height = 30
    Caption = 'Paint Retention'
    TabOrder = 3
    Visible = False
    OnClick = Button4Click
  end
  object SaveDialog1: TSaveDialog
    Filter = 'SleepChart File|*.tim'
    Left = 160
    Top = 136
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 128
    object File1: TMenuItem
      Caption = '&File'
      object MINew: TMenuItem
        Caption = 'New'
        Hint = 'Create new sleep data file'
        OnClick = MINewClick
      end
      object MIOpenSleepChart: TMenuItem
        Caption = 'Open'
        Hint = 'Open a sleep data file'
        ShortCut = 16463
        OnClick = MIOpenSleepChartClick
      end
      object Save1: TMenuItem
        Caption = 'Save'
        Hint = 'Save the currently opened data file'
        ShortCut = 16467
        OnClick = Save1Click
      end
      object SaveAs1: TMenuItem
        Caption = 'Save As'
        Hint = 'Save the current sleep data file under a new name'
        OnClick = SaveAs1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object I1: TMenuItem
        Caption = 'Import'
        object MIImportSleepChartFile: TMenuItem
          Caption = 'SleepChart file'
          Hint = 'Import data from another SleepChart file'
          OnClick = MIImportSleepChartFileClick
        end
        object N13: TMenuItem
          Caption = '-'
        end
        object MIImportfromExcel: TMenuItem
          Caption = 'Excel file'
          Hint = 
            'Import data from comma-separated Excel file (format: millennium ' +
            'day, sleep start hour, sleep end hour)'
          OnClick = MIImportfromExcelClick
        end
        object N10: TMenuItem
          Caption = '-'
        end
        object MINewDefaultFile: TMenuItem
          Caption = 'New default'
          Hint = 
            'Set a new SleepChart file as a defult file for the current colle' +
            'ction'
          OnClick = MINewDefaultFileClick
        end
        object Makedefault1: TMenuItem
          Caption = 'Make default'
          Hint = 
            'Set the currently opened SleepChart file as the default file for' +
            ' the current collection'
          OnClick = Makedefault1Click
        end
        object N11: TMenuItem
          Caption = '-'
        end
        object MIImportReplacementSleepChartFile: TMenuItem
          Caption = 'Replace'
          Hint = 
            'Import a SleepChart file as the new main default sleep record in' +
            ' SuperMemo'
          OnClick = MIImportReplacementSleepChartFileClick
        end
        object N12: TMenuItem
          Caption = '-'
          Hint = '-'
        end
        object MISuperimpose: TMenuItem
          Caption = 'Superimpose'
          Enabled = False
          Hint = 'Superimpose a new SleepChart file onto the current file'
          OnClick = MISuperimposeClick
        end
      end
      object Export1: TMenuItem
        Caption = 'Export'
        object MIExportToExcel: TMenuItem
          Caption = 'To Excel'
          Hint = 'Export the SleepChart file in the CSV format'
          OnClick = MIExportToExcelClick
        end
        object N9: TMenuItem
          Caption = '-'
        end
        object MIExportSleepLengthData: TMenuItem
          Caption = 'Sleep length data'
          Hint = 'Export total sleep length data'
          OnClick = MIExportSleepLengthDataClick
        end
        object MIPeriodogram: TMenuItem
          Caption = 'Periodogram data'
          Hint = 'Export data for Fourier analysis of sleep spectra'
          OnClick = MIPeriodogramClick
        end
        object MIExport_rPRC: TMenuItem
          Caption = 'Recursive PRC'
          Hint = 'Export the recursive PRC data'
          OnClick = MIExport_rPRCClick
        end
      end
      object ools1: TMenuItem
        Caption = 'Verify'
        object MIRepetitionHistory: TMenuItem
          Caption = 'Repetition History'
          Hint = 'Test repetition history for discrepancies with Timeline data'
          OnClick = MIRepetitionHistoryClick
        end
        object MITestForOverlaps: TMenuItem
          Caption = 'Block Overlaps'
          Hint = 
            'Verify data by checking if repetition blocks do not overlap with' +
            ' sleep blocks'
          OnClick = MITestForOverlapsClick
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
    end
    object N3: TMenuItem
      Caption = '&Edit'
      object MIGoToDay: TMenuItem
        Caption = 'Go to day'
        Hint = 'Go to a selected day in the sleep log'
        ShortCut = 16455
        OnClick = MIGoToDayClick
      end
      object MISetFirstSleepDay: TMenuItem
        Caption = 'Set first day'
        Hint = 'Set the first day in the sleep log'
        OnClick = MISetFirstSleepDayClick
      end
    end
    object Options1: TMenuItem
      Caption = '&Options'
      object Age1: TMenuItem
        Caption = 'Age'
        Hint = 
          'Choose the age category of the sleeper to adjust some sleep para' +
          'meters'
        OnClick = Age1Click
        object MIBaby: TMenuItem
          Caption = 'Baby'
          Hint = 'Age 0-12 months'
          OnClick = MIBabyClick
        end
        object MIChild: TMenuItem
          Caption = 'Child'
          Hint = 'Age 1-8 years old'
          OnClick = MIChildClick
        end
        object MIAdult: TMenuItem
          Caption = 'Adult'
          Hint = 'Adolescent or adult'
          OnClick = MIAdultClick
        end
      end
      object Display1: TMenuItem
        Caption = 'Statistic'
        Hint = 'Choose which statistic should be displayed alongside the log'
        OnClick = Display1Click
        object MILearningTime: TMenuItem
          Caption = 'Learning time'
          Checked = True
          Hint = 
            'Display the total learning time in the data column (on the right' +
            ')'
          OnClick = MILearningTimeClick
        end
        object MISleepTime: TMenuItem
          Caption = 'Sleep time'
          Hint = 
            'Display total sleep time in the 24h period (starting with subjec' +
            'tive night start)'
          OnClick = MISleepTimeClick
        end
        object MINightSleep: TMenuItem
          Caption = 'Night sleep'
          Hint = 'Display total subjective nighttime sleep'
          OnClick = MINightSleepClick
        end
        object MINapTime: TMenuItem
          Caption = 'Nap time'
          Hint = 'Display only napping time'
          OnClick = MINapTimeClick
        end
        object MIPhaseShift: TMenuItem
          Caption = 'Phase shift'
          Hint = 
            'Display the estimated phase shift as well as the trailing phase ' +
            'shift average'
          OnClick = MIPhaseShiftClick
        end
        object MIREMCoefficient: TMenuItem
          Caption = 'REM Coefficient'
          Hint = 'Estimate the REM richness from the sleep phase'
          OnClick = MIREMCoefficientClick
        end
        object N7: TMenuItem
          Caption = '-'
        end
        object MIViewNext: TMenuItem
          Caption = 'View next'
          Hint = 'View the next statistic'
          ShortCut = 16423
          OnClick = MIViewNextClick
        end
        object ViewPrevious1: TMenuItem
          Caption = 'View previous'
          Hint = 'View a previous statistic'
          ShortCut = 16421
          OnClick = ViewPrevious1Click
        end
      end
      object Consolidation1: TMenuItem
        Caption = 'Consolidation'
        Hint = 
          'Choose the way the correlation between recall and consolidation ' +
          'is displayed'
        OnClick = Consolidation1Click
        object MIRecallvsConsolidation: TMenuItem
          Caption = 'Recall vs. Consolidation'
          Hint = 'Display recall on the horizontal axis'
          OnClick = MIRecallvsConsolidationClick
        end
        object MIConsolidationvsRecall: TMenuItem
          Caption = 'Consolidation vs. Recall'
          Hint = 'Display consolidation on the horizontal axis'
          OnClick = MIConsolidationvsRecallClick
        end
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object SleepChartHelp1: TMenuItem
        Caption = 'SleepChart &Help'
        ShortCut = 112
        OnClick = SleepChartHelp1Click
      end
      object SleepChartGuru1: TMenuItem
        Caption = 'SleepChart &Guru'
        OnClick = SleepChartGuru1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Time block file|*.tim|Sleep data|*.csv'
    Left = 96
    Top = 80
  end
  object AddingTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = AddingTimerTimer
    Left = 168
    Top = 80
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 88
    Top = 136
    object MIDenseView: TMenuItem
      Caption = 'Dense view'
      Hint = 'Display a dense log to visualize long-term trends'
      OnClick = MIDenseViewClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object MIDeleteBlock: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = MIDeleteBlockClick
    end
    object MINext: TMenuItem
      Caption = 'Next'
      ShortCut = 9
      OnClick = MINextClick
    end
    object MIPrevious: TMenuItem
      Caption = 'Previous'
      ShortCut = 8201
      OnClick = MIPreviousClick
    end
    object Goto1: TMenuItem
      Caption = 'Go to'
      ShortCut = 16455
      OnClick = Goto1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MIForcedAwakening: TMenuItem
      Caption = 'Forced awakening'
      Hint = 'Mark sleep block as interrupted (e.g. with an alarm clock)'
      ShortCut = 16449
      OnClick = MIForcedAwakeningClick
    end
    object MIDelayedRetirement: TMenuItem
      Caption = 'Delayed retirement'
      Hint = 'Mark sleep block as delayed despite substantial sleepiness'
      ShortCut = 16452
      OnClick = MIDelayedRetirementClick
    end
    object N6: TMenuItem
      Caption = '-'
      ShortCut = 189
    end
    object MISleepPropensity: TMenuItem
      Caption = 'Sleep propensity'
      Hint = 
        'Show sleep propensity projected using a two-component sleep mode' +
        'l'
      ShortCut = 16464
      OnClick = MISleepPropensityClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Close1: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = Close1Click
    end
  end
end
