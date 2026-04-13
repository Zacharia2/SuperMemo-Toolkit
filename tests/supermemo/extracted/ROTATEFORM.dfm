object RotateForm: TRotateForm
  Left = 0
  Top = 0
  HelpContext = 40
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'RotateForm'
  ClientHeight = 1234
  ClientWidth = 2340
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  PopupMenu = PopupMenu1
  WindowState = wsMaximized
  StyleElements = []
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 22
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 2340
    Height = 694
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Microsoft YaHei'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnMouseDown = PaintBox1MouseDown
    OnMouseMove = PaintBox1MouseMove
    OnMouseUp = PaintBox1MouseUp
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 694
    Width = 2340
    Height = 540
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Microsoft YaHei'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object CasesLabel: TLabel
      Left = 1144
      Top = 395
      Width = 45
      Height = 22
      Hint = 
        'Repetition cases displayed and the minimum required for a data p' +
        'oint'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Cases'
    end
    object DifficultyLabel: TLabel
      Left = 1144
      Top = 313
      Width = 69
      Height = 22
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Difficulty'
    end
    object ParamsPaint: TPaintBox
      Left = 1757
      Top = 103
      Width = 564
      Height = 418
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
    end
    object SliceLabel: TLabel
      Left = 1144
      Top = 475
      Width = 35
      Height = 22
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Slice'
    end
    object TrackBar1: TTrackBar
      Left = 0
      Top = 125
      Width = 1655
      Height = 59
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Max = 360
      PageSize = 15
      TabOrder = 0
      ThumbLength = 36
      OnChange = TrackBar1Change
      OnKeyDown = TrackBar1KeyDown
    end
    object TrackBar2: TTrackBar
      Left = 0
      Top = 204
      Width = 1655
      Height = 61
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Max = 360
      PageSize = 15
      TabOrder = 1
      ThumbLength = 36
      OnChange = TrackBar2Change
      OnKeyPress = TrackBar2KeyPress
    end
    object DiffBar: TTrackBar
      Left = 0
      Top = 284
      Width = 1122
      Height = 82
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Max = 20
      Min = 1
      Position = 1
      TabOrder = 2
      ThumbLength = 36
      OnChange = DiffBarChange
    end
    object Smoothing: TButton
      Left = 1598
      Top = 316
      Width = 124
      Height = 34
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Smoothing'
      TabOrder = 3
      OnClick = SmoothingClick
    end
    object CasesBar: TTrackBar
      Left = 0
      Top = 366
      Width = 1122
      Height = 80
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Max = 100
      TabOrder = 4
      ThumbLength = 36
      OnChange = CasesBarChange
    end
    object ComputeBtn: TButton
      Left = 1339
      Top = 316
      Width = 124
      Height = 34
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Compute'
      TabOrder = 5
      OnClick = ComputeBtnClick
    end
    object Reset: TButton
      Left = 1469
      Top = 316
      Width = 123
      Height = 34
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Reset'
      TabOrder = 6
      OnClick = ResetClick
    end
    object ResetCases: TButton
      Left = 1469
      Top = 356
      Width = 123
      Height = 35
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Reset Cases'
      TabOrder = 7
      OnClick = ResetCasesClick
    end
    object Cancel: TButton
      Left = 1339
      Top = 398
      Width = 124
      Height = 35
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Cancel'
      TabOrder = 8
      OnClick = CancelClick
    end
    object ExportBtn: TButton
      Left = 1468
      Top = 398
      Width = 123
      Height = 35
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Export'
      TabOrder = 9
      OnClick = ExportBtnClick
    end
    object Button1: TButton
      Left = 1339
      Top = 356
      Width = 124
      Height = 35
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Subset'
      TabOrder = 10
      OnClick = Button1Click
    end
    object AverageBox: TCheckBox
      Left = 1595
      Top = 403
      Width = 122
      Height = 24
      Hint = 'Sooth up SInc[] matrix by averaging neighboring entries'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Average'
      TabOrder = 11
      OnClick = AverageBoxClick
    end
    object TheGraphs: TTabControl
      Left = 1
      Top = 1
      Width = 2338
      Height = 45
      Hint = 'Types of graphs available for 4D display'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      HotTrack = True
      TabOrder = 12
      TabPosition = tpBottom
      Tabs.Strings = (
        'Matrices'
        'Stabilization'
        'SInc Approx'
        'Recall'
        'Recall Approx'
        'First Interval'
        'PLS Approx'
        'Sleep'
        'Forgetting'
        'RF Matrix')
      TabIndex = 0
      OnChange = TheGraphsChange
    end
    object TheMatrices: TTabControl
      Left = 1
      Top = 46
      Width = 2338
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      HotTrack = True
      TabOrder = 13
      Tabs.Strings = (
        'S90'
        'SIncMin'
        'SIncMax'
        'Gain'
        'Decay'
        'OS'
        'Recall'
        'R90'
        'Metric'
        'Cases'
        'RF'
        'OF'
        'Intervals'
        'RF Cases')
      TabIndex = 0
      Visible = False
      OnChange = TheMatricesChange
    end
    object SliceBar: TTrackBar
      Left = 0
      Top = 446
      Width = 1122
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Max = 21
      Min = 1
      Position = 1
      TabOrder = 14
      ThumbLength = 36
    end
    object HelpBtn: TBitBtn
      Left = 1597
      Top = 355
      Width = 124
      Height = 35
      Hint = 'Open help page that explains 4D graphs'
      HelpContext = 40
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 15
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 1048
    Top = 144
    object MIParameteroptimization: TMenuItem
      Caption = 'Parameter optimization'
      Hint = 'Compute the optimum value of a selected algorithmic parameter'
      ShortCut = 118
      OnClick = MIParameteroptimizationClick
    end
    object Close1: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = Close1Click
    end
  end
end
