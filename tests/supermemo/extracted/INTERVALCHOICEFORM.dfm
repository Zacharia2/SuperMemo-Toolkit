object IntervalChoiceForm: TIntervalChoiceForm
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Select Next Review Interval'
  ClientHeight = 760
  ClientWidth = 1350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  KeyPreview = True
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 20
  object lblStats: TLabel
    Left = 60
    Top = 40
    Width = 1230
    Height = 20
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Alignment = taCenter
    AutoSize = False
    Caption = 'Weighted average: 1y 0m 0d | SD Left: 82.5d | SD Right: 82.5d'
  end
  object lblOldInterval: TLabel
    Left = 36
    Top = 300
    Width = 88
    Height = 20
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Old interval'
  end
  object lblOldIntervalValue: TLabel
    Left = 36
    Top = 345
    Width = 59
    Height = 20
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = '5m 29d'
  end
  object lblWeightedAvg: TLabel
    Left = 578
    Top = 300
    Width = 138
    Height = 20
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Alignment = taCenter
    Caption = 'Weighted average'
  end
  object lblWeightedAvgValue: TLabel
    Left = 578
    Top = 345
    Width = 71
    Height = 20
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Alignment = taCenter
    Caption = '1y 0m 0d'
  end
  object lblMaximum: TLabel
    Left = 1251
    Top = 300
    Width = 75
    Height = 20
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Alignment = taRightJustify
    Caption = 'Maximum'
  end
  object lblMaximumValue: TLabel
    Left = 1247
    Top = 345
    Width = 79
    Height = 20
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Alignment = taRightJustify
    Caption = '1y 2m 24d'
  end
  object lblSelected: TLabel
    Left = 25
    Top = 411
    Width = 153
    Height = 20
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Alignment = taCenter
    Caption = 'Selected: 1y 0m 12d'
  end
  object lblHint: TLabel
    Left = 60
    Top = 530
    Width = 1230
    Height = 20
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Click heatmap to select | ← → arrows to adjust | Ctrl+Shift+R ma' +
      'nual interval'
  end
  object pnlHeatmap: TPanel
    Left = 60
    Top = 105
    Width = 1230
    Height = 180
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    BevelOuter = bvLowered
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    StyleElements = [seClient, seBorder]
    object pbHeatmap: TPaintBox
      Left = 1
      Top = 1
      Width = 1228
      Height = 178
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      OnMouseDown = pbHeatmapMouseDown
      OnMouseLeave = pbHeatmapMouseLeave
      OnMouseMove = pbHeatmapMouseMove
      OnPaint = pbHeatmapPaint
      ExplicitLeft = 12
      ExplicitTop = -23
    end
  end
  object pnlLegend: TPanel
    Left = 60
    Top = 580
    Width = 1230
    Height = 150
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    BevelOuter = bvNone
    Color = 15790320
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object pbAlgSM19: TPaintBox
      Left = 148
      Top = 20
      Width = 16
      Height = 52
      OnPaint = AlgorithmMarkerPaint
    end
    object pbAlgSM20: TPaintBox
      Left = 552
      Top = 20
      Width = 16
      Height = 52
      OnPaint = AlgorithmMarkerPaint
    end
    object pbAlgSM2: TPaintBox
      Left = 24
      Top = 102
      Width = 16
      Height = 52
      OnPaint = AlgorithmMarkerPaint
    end
    object pbAlgSM15: TPaintBox
      Left = 428
      Top = 102
      Width = 16
      Height = 52
      OnPaint = AlgorithmMarkerPaint
    end
    object pbAlgFSRS: TPaintBox
      Left = 832
      Top = 102
      Width = 16
      Height = 52
      OnPaint = AlgorithmMarkerPaint
    end
    object btnAlgSM19: TButton
      Left = 174
      Top = 18
      Width = 350
      Height = 62
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SM-19'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = AlgorithmButtonClick
    end
    object btnAlgSM20: TButton
      Left = 578
      Top = 18
      Width = 350
      Height = 62
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SM-20'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = AlgorithmButtonClick
    end
    object btnAlgSM2: TButton
      Left = 50
      Top = 96
      Width = 350
      Height = 62
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SM-2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = AlgorithmButtonClick
    end
    object btnAlgSM15: TButton
      Left = 454
      Top = 96
      Width = 350
      Height = 62
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SM-15'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = AlgorithmButtonClick
    end
    object btnAlgFSRS: TButton
      Left = 858
      Top = 96
      Width = 350
      Height = 62
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'FSRS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = AlgorithmButtonClick
    end
  end
  object btnAccept: TButton
    Left = 135
    Top = 425
    Width = 255
    Height = 67
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Accept (Enter)'
    Default = True
    TabOrder = 2
    OnClick = btnAcceptClick
  end
  object btnAlwaysDefault: TButton
    Left = 410
    Top = 425
    Width = 255
    Height = 67
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Peek'
    TabOrder = 3
    OnClick = btnAlwaysDefaultClick
  end
  object btnAskLess: TButton
    Left = 617
    Top = 425
    Width = 190
    Height = 67
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Ask less often'
    TabOrder = 4
    OnClick = btnAskLessClick
  end
  object btnManual: TButton
    Left = 823
    Top = 425
    Width = 190
    Height = 67
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Manual'
    TabOrder = 5
    OnClick = btnManualClick
  end
  object btnCancel: TButton
    Left = 1029
    Top = 425
    Width = 190
    Height = 67
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Cancel = True
    Caption = 'Cancel (Esc)'
    ModalResult = 2
    TabOrder = 6
  end
  object PopupMenu1: TPopupMenu
    Left = 1122
    Top = 48
    object MILaterToday: TMenuItem
      Caption = 'Later today'
      Hint = 'Move the repetition to later today (as if it never happened)'
      ShortCut = 24650
      OnClick = MILaterTodayClick
    end
    object MIExecuteRepetition: TMenuItem
      Caption = 'Execute repetition'
      Hint = 'Execute repetition and manually set the interval'
      ShortCut = 24658
      OnClick = MIExecuteRepetitionClick
    end
    object MIReschedule: TMenuItem
      Caption = 'Reschedule'
      Hint = 'Skip that repetition and schedule it on another day'
      ShortCut = 16458
      OnClick = MIRescheduleClick
    end
  end
end
