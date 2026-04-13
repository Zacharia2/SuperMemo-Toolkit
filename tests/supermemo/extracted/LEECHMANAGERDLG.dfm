object LeechManagerDlg: TLeechManagerDlg
  Left = 418
  Top = 177
  ActiveControl = ShowAnswer
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Leech Alert!'
  ClientHeight = 530
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 24
  object Label2: TLabel
    Left = 166
    Top = 152
    Width = 144
    Height = 24
    Hint = 'Set the postponement interval'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Postpone &interval'
    FocusControl = PostponeIntervalEdit
  end
  object ChooseInterval: TSpeedButton
    Left = 254
    Top = 191
    Width = 33
    Height = 29
    Hint = 'Set the postponement interval'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Flat = True
    OnClick = ChooseIntervalClick
  end
  object LapsesPaintBox: TPaintBox
    Left = 12
    Top = 56
    Width = 477
    Height = 39
    Hint = 'Number of times this leech has been forgotten'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    OnPaint = LapsesPaintBoxPaint
  end
  object LapsesLabel: TLabel
    Left = 209
    Top = 61
    Width = 80
    Height = 24
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Alignment = taCenter
    Caption = 'Lapses: 5'
    Transparent = True
  end
  object IntervalPaintBox: TPaintBox
    Left = 12
    Top = 100
    Width = 477
    Height = 39
    Hint = 'Time since the last repetition (in days)'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
  end
  object IntervalLabel: TLabel
    Left = 212
    Top = 108
    Width = 79
    Height = 24
    Hint = 'Time since the last repetition (in days)'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Alignment = taCenter
    Caption = 'Interval: 6'
    Transparent = True
  end
  object EditBtn: TBitBtn
    Left = 12
    Top = 233
    Width = 135
    Height = 39
    Hint = 'Edit the element to make it easier to remember'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Edit'
    TabOrder = 5
    OnClick = EditBtnClick
  end
  object Forget: TBitBtn
    Left = 12
    Top = 277
    Width = 135
    Height = 39
    Hint = 'Move the element to the end of the pending queue'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&Forget'
    TabOrder = 6
    OnClick = ForgetClick
  end
  object Dismiss: TBitBtn
    Left = 12
    Top = 321
    Width = 135
    Height = 38
    Hint = 'Dismiss the element '
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&Dismiss'
    TabOrder = 7
    OnClick = DismissClick
  end
  object Delete: TBitBtn
    Left = 12
    Top = 365
    Width = 135
    Height = 37
    Hint = 'Delete the leech'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Delete'
    TabOrder = 8
    OnClick = DeleteClick
  end
  object Postpone: TBitBtn
    Left = 12
    Top = 166
    Width = 135
    Height = 38
    Hint = 'Reset and reschedule the element to attempt a new memory engram'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&Postpone'
    TabOrder = 3
    OnClick = PostponeClick
  end
  object Reschedule: TBitBtn
    Left = 166
    Top = 321
    Width = 179
    Height = 38
    Hint = 'Reschedule the repetition'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&Reschedule'
    TabOrder = 10
    OnClick = RescheduleClick
  end
  object Continue: TBitBtn
    Left = 12
    Top = 12
    Width = 135
    Height = 39
    Hint = 'Continue without change'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Cancel = True
    Caption = '&Continue'
    TabOrder = 0
    OnClick = ContinueClick
  end
  object ParamsBtn: TBitBtn
    Left = 166
    Top = 277
    Width = 179
    Height = 39
    Hint = 'Edit element parameters'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Parameters'
    TabOrder = 9
    OnClick = ParamsBtnClick
  end
  object ShowAnswer: TBitBtn
    Left = 155
    Top = 12
    Width = 223
    Height = 36
    Hint = 'Show the correct answer'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&Show answer'
    Default = True
    TabOrder = 1
    OnClick = ShowAnswerClick
  end
  object Great: TBitBtn
    Left = 374
    Top = 191
    Width = 104
    Height = 37
    Hint = 'Grade your response'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Great'
    Enabled = False
    TabOrder = 12
    OnClick = GreatClick
  end
  object Good: TBitBtn
    Left = 374
    Top = 235
    Width = 104
    Height = 37
    Hint = 'Grade your response'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Good'
    Enabled = False
    TabOrder = 13
    OnClick = GoodClick
  end
  object Pass: TBitBtn
    Left = 374
    Top = 280
    Width = 104
    Height = 39
    Hint = 'Grade your response'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Pass'
    Enabled = False
    TabOrder = 14
    OnClick = PassClick
  end
  object Fail: TBitBtn
    Left = 374
    Top = 324
    Width = 104
    Height = 39
    Hint = 'Grade your response'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Fail'
    Enabled = False
    TabOrder = 15
    OnClick = FailClick
  end
  object Bad: TBitBtn
    Left = 374
    Top = 368
    Width = 104
    Height = 38
    Hint = 'Grade your response'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Bad'
    Enabled = False
    TabOrder = 16
    OnClick = BadClick
  end
  object PostponeIntervalEdit: TEdit
    Left = 189
    Top = 189
    Width = 67
    Height = 32
    Hint = 'Set the postponement interval'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 4
    Text = '50'
  end
  object HelpBtn: TBitBtn
    Left = 389
    Top = 12
    Width = 100
    Height = 36
    HelpContext = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 2
  end
  object SaveLayout: TBitBtn
    Left = 166
    Top = 365
    Width = 179
    Height = 39
    Hint = 'Save the current layout (incl. Leech Alert)'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Save layout'
    TabOrder = 11
    OnClick = SaveLayoutClick
  end
  object AutoPostponeBox: TCheckBox
    Left = 12
    Top = 420
    Width = 466
    Height = 31
    Hint = 'Always postpone leeches by the selected interval'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Auto-postpone'
    TabOrder = 17
    OnClick = AutoPostponeBoxClick
  end
  object AutoForgetBox: TCheckBox
    Left = 12
    Top = 454
    Width = 466
    Height = 28
    Hint = 'Always put leeches to the end of the pending queue'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Auto-forget'
    TabOrder = 18
    OnClick = AutoForgetBoxClick
  end
  object UseSemiLeechesBox: TCheckBox
    Left = 12
    Top = 488
    Width = 466
    Height = 23
    Hint = 
      'Include items that would become a leech after a single memory la' +
      'pse'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Include semi-leeches'
    Checked = True
    State = cbChecked
    TabOrder = 19
    OnClick = UseSemiLeechesBoxClick
  end
end
