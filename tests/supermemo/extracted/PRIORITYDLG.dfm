object PriorityDlg: TPriorityDlg
  Left = 0
  Top = 0
  ActiveControl = PercentEdit
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Element Priority'
  ClientHeight = 399
  ClientWidth = 1021
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  SnapBuffer = 100
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 21
  object Label1: TLabel
    Left = 11
    Top = 18
    Width = 134
    Height = 21
    Hint = 'Position in the priority queue'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Position [1..Total]'
    FocusControl = PositionEdit
  end
  object Label2: TLabel
    Left = 11
    Top = 62
    Width = 138
    Height = 21
    Hint = 'Priority (0% highest, 100% lowest)'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Pe&rcent [0..100%]'
    FocusControl = PercentEdit
  end
  object Before: TLabel
    Left = 43
    Top = 266
    Width = 962
    Height = 35
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    AutoSize = False
    Caption = 'Before'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    ParentFont = False
  end
  object After: TLabel
    Left = 43
    Top = 353
    Width = 962
    Height = 35
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    AutoSize = False
    Caption = 'After'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 493
    Top = 18
    Width = 120
    Height = 21
    Hint = 
      'Requested forgetting index (i.e. acceptable level of forgetting ' +
      'in %)'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Forgetting index'
    FocusControl = FI
  end
  object Label6: TLabel
    Left = 493
    Top = 59
    Width = 64
    Height = 21
    Hint = 
      'A-Factor (i.e. determinant of the speed in which intervals incre' +
      'ase)'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&A-Factor'
    FocusControl = AF
  end
  object Label7: TLabel
    Left = 493
    Top = 103
    Width = 53
    Height = 21
    Hint = 
      'Ordinal number used in sorting collections (e.g. for use by othe' +
      'rs)'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Ordinal'
    FocusControl = Ordinal
  end
  object GoAfter: TSpeedButton
    Left = 13
    Top = 353
    Width = 26
    Height = 25
    Hint = 'Go to the preceding element'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    OnClick = GoAfterClick
  end
  object GoBefore: TSpeedButton
    Left = 13
    Top = 266
    Width = 26
    Height = 24
    Hint = 'Go to the succeeding element'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    OnClick = GoBeforeClick
  end
  object Label3: TLabel
    Left = 11
    Top = 103
    Width = 149
    Height = 21
    Hint = 'Interval remaining to the next repetition'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Interval (remaining)'
    FocusControl = IntervalEdit
  end
  object IntervalBtn: TSpeedButton
    Left = 437
    Top = 99
    Width = 25
    Height = 28
    Hint = 'Choose the new interval'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    OnClick = IntervalBtnClick
  end
  object GoThis: TSpeedButton
    Left = 13
    Top = 306
    Width = 26
    Height = 26
    Hint = 'Go to the succeeding element'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    OnClick = GoThisClick
  end
  object This: TLabel
    Left = 43
    Top = 306
    Width = 962
    Height = 35
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    AutoSize = False
    Caption = 'This'
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    StyleElements = [seBorder]
  end
  object PaintBox1: TPaintBox
    Left = 9
    Top = 144
    Width = 998
    Height = 61
    OnPaint = PaintBox1Paint
  end
  object OK: TBitBtn
    Left = 864
    Top = 6
    Width = 147
    Height = 41
    HelpContext = 37
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 7
    OnClick = OKClick
  end
  object Cancel: TBitBtn
    Left = 864
    Top = 95
    Width = 147
    Height = 41
    HelpContext = 37
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 8
  end
  object TrackBar1: TTrackBar
    Left = 12
    Top = 210
    Width = 999
    Height = 52
    Hint = 'Priority (0% highest, 100% lowest)'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Max = 100
    PageSize = 10
    TabOrder = 3
    ThumbLength = 22
    TickMarks = tmTopLeft
    OnChange = TrackBar1Change
  end
  object PositionEdit: TEdit
    Left = 234
    Top = 14
    Width = 177
    Height = 29
    Hint = 'Position in the priority queue'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 0
    Text = '1'
    StyleElements = [seFont, seBorder]
    OnChange = PositionEditChange
  end
  object PercentEdit: TEdit
    Left = 234
    Top = 57
    Width = 177
    Height = 29
    Hint = 'Priority (0% highest, 100% lowest)'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 1
    StyleElements = [seFont, seBorder]
    OnChange = PercentEditChange
  end
  object FI: TEdit
    Left = 680
    Top = 14
    Width = 168
    Height = 29
    Hint = 
      'Requested forgetting index (i.e. acceptable level of forgetting ' +
      'in %)'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 4
  end
  object AF: TEdit
    Left = 680
    Top = 56
    Width = 168
    Height = 29
    Hint = 
      'A-Factor (i.e. determinant of the speed in which intervals incre' +
      'ase)'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 5
  end
  object Ordinal: TEdit
    Left = 680
    Top = 99
    Width = 168
    Height = 29
    Hint = 
      'Ordinal number used in sorting collections (e.g. for use by othe' +
      'rs)'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 6
  end
  object IntervalEdit: TEdit
    Left = 234
    Top = 99
    Width = 177
    Height = 29
    Hint = 'Interval remaining to the next repetition'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 2
    Text = '1'
  end
  object PositUpDown: TUpDown
    Left = 411
    Top = 14
    Width = 25
    Height = 29
    Hint = 'Increment or decrement the position in the priority queue'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Associate = PositionEdit
    Min = 1
    Max = 1000000000
    Position = 1
    TabOrder = 9
    Thousands = False
    OnMouseDown = PositUpDownMouseDown
  end
  object BitBtn1: TBitBtn
    Left = 864
    Top = 50
    Width = 147
    Height = 41
    HelpContext = 37
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 10
  end
  object IntervalUpDown: TUpDown
    Left = 411
    Top = 99
    Width = 25
    Height = 29
    Hint = 'Increment or decrement the interval'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Associate = IntervalEdit
    Min = 1
    Max = 3333
    Position = 1
    TabOrder = 11
    Thousands = False
  end
  object PopupMenu1: TPopupMenu
    Left = 640
    Top = 96
    object MIIncrease: TMenuItem
      Caption = 'Increase priority'
      ShortCut = 32805
      OnClick = MIIncreaseClick
    end
    object MIDecrease: TMenuItem
      Caption = 'Decrease priority'
      ShortCut = 32807
      OnClick = MIDecreaseClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InvPercent1: TMenuItem
      Caption = 'Inv: Percent'
      ShortCut = 32850
      Visible = False
      OnClick = InvPercent1Click
    end
    object InvPosition1: TMenuItem
      Caption = 'Inv: Position'
      ShortCut = 32848
      Visible = False
      OnClick = InvPosition1Click
    end
    object InvInterval1: TMenuItem
      Caption = 'Inv: Interval'
      ShortCut = 32841
      Visible = False
      OnClick = InvInterval1Click
    end
  end
end
