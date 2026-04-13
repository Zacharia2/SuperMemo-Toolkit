object SimDlg: TSimDlg
  Left = 323
  Top = 144
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Simulation of the learning process'
  ClientHeight = 605
  ClientWidth = 860
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 8
    Top = 347
    Width = 845
    Height = 218
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    OnPaint = PaintBox1Paint
  end
  object Bevel2: TBevel
    Left = 8
    Top = 156
    Width = 549
    Height = 158
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
  end
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 845
    Height = 141
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
  end
  object Label1: TLabel
    Left = 18
    Top = 18
    Width = 601
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 
      'This dialog simulates the learning process over the next 15 year' +
      's given the following input parameters:'
  end
  object Label3: TLabel
    Left = 383
    Top = 78
    Width = 98
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taRightJustify
    Caption = 'Forgetting index:'
  end
  object FILabel: TLabel
    Left = 486
    Top = 78
    Width = 26
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '10%'
  end
  object Label5: TLabel
    Left = 588
    Top = 47
    Width = 167
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taRightJustify
    Caption = 'Planned repetitions per day:'
  end
  object Label2: TLabel
    Left = 18
    Top = 165
    Width = 29
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Date'
  end
  object DateLabel: TLabel
    Left = 330
    Top = 165
    Width = 12
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '---'
  end
  object Label13: TLabel
    Left = 18
    Top = 238
    Width = 119
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Avg repetitions/day:'
  end
  object AvgRepetitions: TLabel
    Left = 330
    Top = 238
    Width = 12
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '---'
  end
  object Label15: TLabel
    Left = 18
    Top = 263
    Width = 116
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Avg new items/day:'
  end
  object AvgNewRepetitions: TLabel
    Left = 330
    Top = 263
    Width = 12
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '---'
  end
  object Label17: TLabel
    Left = 18
    Top = 286
    Width = 82
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Avg time/day:'
  end
  object AvgTime: TLabel
    Left = 330
    Top = 286
    Width = 12
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '---'
  end
  object Label19: TLabel
    Left = 577
    Top = 188
    Width = 63
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Chart type:'
  end
  object Label20: TLabel
    Left = 26
    Top = 573
    Width = 85
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Memory used:'
  end
  object Memory: TLabel
    Left = 174
    Top = 573
    Width = 4
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '-'
  end
  object Label14: TLabel
    Left = 18
    Top = 188
    Width = 25
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Day'
  end
  object DayLabel: TLabel
    Left = 330
    Top = 188
    Width = 12
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '---'
  end
  object HundredPercent: TLabel
    Left = 8
    Top = 322
    Width = 33
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '100%'
  end
  object LastDate: TLabel
    Left = 785
    Top = 322
    Width = 58
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taRightJustify
    Caption = 'Last date:'
  end
  object ChartType: TLabel
    Left = 577
    Top = 214
    Width = 181
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'New items memorized per day'
  end
  object Label6: TLabel
    Left = 18
    Top = 214
    Width = 70
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Memorized:'
  end
  object MemorizedItems: TLabel
    Left = 330
    Top = 214
    Width = 12
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '---'
  end
  object FIBar: TTrackBar
    Left = 530
    Top = 71
    Width = 313
    Height = 43
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Max = 90
    Min = 3
    Position = 10
    TabOrder = 0
    TickMarks = tmTopLeft
    OnChange = FIBarChange
  end
  object RepsPerDayEdit: TEdit
    Left = 765
    Top = 44
    Width = 70
    Height = 24
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 1
    Text = '200'
  end
  object GroupBox1: TGroupBox
    Left = 18
    Top = 44
    Width = 296
    Height = 96
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Strategy'
    TabOrder = 2
    object OnlyRepeat: TRadioButton
      Left = 10
      Top = 27
      Width = 284
      Height = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Repeat memorized only'
      TabOrder = 0
      OnClick = OnlyRepeatClick
    end
    object LearnNew: TRadioButton
      Left = 10
      Top = 57
      Width = 284
      Height = 18
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Learn new items'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = LearnNewClick
    end
  end
  object Start: TButton
    Left = 506
    Top = 570
    Width = 82
    Height = 28
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Start'
    TabOrder = 3
    OnClick = StartClick
  end
  object Stop: TButton
    Left = 593
    Top = 570
    Width = 82
    Height = 28
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'St&op'
    TabOrder = 4
    OnClick = StopClick
  end
  object Close: TButton
    Left = 767
    Top = 570
    Width = 82
    Height = 28
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Cancel = True
    Caption = '&Close'
    ModalResult = 2
    TabOrder = 5
  end
  object Resume: TButton
    Left = 680
    Top = 570
    Width = 82
    Height = 28
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Resume'
    TabOrder = 6
    OnClick = ResumeClick
  end
  object OriginalFI: TCheckBox
    Left = 352
    Top = 114
    Width = 483
    Height = 20
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Use the actual forgetting index'
    TabOrder = 7
  end
  object UpdateTimer: TTimer
    Enabled = False
    OnTimer = UpdateTimerTimer
    Left = 736
    Top = 360
  end
end
