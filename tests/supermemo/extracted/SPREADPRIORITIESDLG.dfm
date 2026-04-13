object SpreadPrioritiesDlg: TSpreadPrioritiesDlg
  Left = 0
  Top = 0
  ActiveControl = MinPositEdit
  BorderIcons = [biSystemMenu]
  Caption = 'Modify Priorities'
  ClientHeight = 585
  ClientWidth = 717
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object Bevel4: TBevel
    Left = 18
    Top = 393
    Width = 689
    Height = 184
  end
  object Label1: TLabel
    Left = 46
    Top = 458
    Width = 58
    Height = 18
    Caption = '&Minimum'
    FocusControl = MinPercentEdit
  end
  object Label2: TLabel
    Left = 46
    Top = 531
    Width = 64
    Height = 18
    Caption = 'Ma&ximum'
    FocusControl = MaxPercentEdit
  end
  object ChangeLabel: TLabel
    Left = 36
    Top = 218
    Width = 81
    Height = 18
    Hint = 
      'Priority of elements will be multiplied by this Change factor (e' +
      '.g. Change=50% for Priority=2% will result in Priority=1%)'
    Caption = '&Change (%)'
    FocusControl = ChangeEdit
  end
  object Label3: TLabel
    Left = 265
    Top = 403
    Width = 49
    Height = 18
    Caption = 'Pe&rcent'
    FocusControl = MinPercentEdit
  end
  object Label4: TLabel
    Left = 519
    Top = 403
    Width = 48
    Height = 18
    Caption = '&Position'
    FocusControl = MinPositEdit
  end
  object Bevel1: TBevel
    Left = 455
    Top = 393
    Width = 11
    Height = 184
  end
  object Bevel2: TBevel
    Left = 18
    Top = 503
    Width = 689
    Height = 9
  end
  object Bevel3: TBevel
    Left = 18
    Top = 430
    Width = 689
    Height = 10
  end
  object MinLabel: TLabel
    Left = 36
    Top = 255
    Width = 22
    Height = 18
    Caption = 'Min'
  end
  object MaxLabel: TLabel
    Left = 641
    Top = 255
    Width = 28
    Height = 18
    Caption = 'Max'
  end
  object StepLabel: TLabel
    Left = 528
    Top = 193
    Width = 29
    Height = 18
    Hint = 
      'Step shows you how many other elements (priority positions) fit ' +
      'in-between a given priority spread'
    Caption = '&Step'
  end
  object RadioGroup1: TRadioGroup
    Left = 36
    Top = 18
    Width = 467
    Height = 175
    Hint = 
      'How should priorities be modified: increased, decreased or sprea' +
      'd from minimum to maximum priority'
    Caption = 'Modify subset priorities'
    Items.Strings = (
      '&Increase'
      '&Decrease'
      '&Spread')
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object ChangeBar: TTrackBar
    Left = 18
    Top = 291
    Width = 689
    Height = 52
    TabOrder = 1
    TickMarks = tmTopLeft
    OnChange = ChangeBarChange
  end
  object OK: TBitBtn
    Left = 528
    Top = 18
    Width = 165
    Height = 42
    Caption = '&OK'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = OKClick
  end
  object BitBtn2: TBitBtn
    Left = 528
    Top = 119
    Width = 165
    Height = 42
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object ChangeEdit: TEdit
    Left = 265
    Top = 216
    Width = 238
    Height = 26
    Hint = 
      'Priority of elements will be multiplied by this Change factor (e' +
      '.g. Change=50% for Priority=2% will result in Priority=1%)'
    TabOrder = 4
    Text = '100%'
    OnChange = ChangeEditChange
  end
  object MinPercentEdit: TEdit
    Left = 246
    Top = 448
    Width = 166
    Height = 26
    Hint = 'Priority minimum in %'
    TabOrder = 5
    Text = '1'
    OnChange = MinPercentEditChange
  end
  object MaxPercentEdit: TEdit
    Left = 246
    Top = 521
    Width = 166
    Height = 26
    Hint = 'Priority maximum in %'
    TabOrder = 6
    Text = '50'
    OnChange = MaxPercentEditChange
  end
  object MinPositEdit: TEdit
    Left = 519
    Top = 448
    Width = 166
    Height = 26
    Hint = 'Minimum position in the priority spread'
    TabOrder = 7
    OnChange = MinPositEditChange
  end
  object MaxPositEdit: TEdit
    Left = 519
    Top = 521
    Width = 166
    Height = 26
    Hint = 'Maximum position in the priority spread'
    TabOrder = 8
    OnChange = MaxPositEditChange
  end
  object Limits: TCheckBox
    Left = 18
    Top = 349
    Width = 675
    Height = 26
    Hint = 
      'Limit changes to fall in between priority minimum and priority m' +
      'aximum'
    Caption = 'Limit changes'
    Checked = True
    State = cbChecked
    TabOrder = 9
    OnClick = LimitsClick
  end
  object Adjust: TCheckBox
    Left = 368
    Top = 351
    Width = 675
    Height = 26
    Hint = 
      'When spreading priorities within a range, adjust them in proport' +
      'ion to the present value'
    Caption = 'Adjust in proportion'
    TabOrder = 10
  end
  object StepEdit: TEdit
    Left = 528
    Top = 218
    Width = 162
    Height = 26
    Hint = 
      'The increment between successive priority positions (e.g. Step=1' +
      ' implies consecutive sequence)'
    TabOrder = 11
    OnChange = StepEditChange
  end
  object BitBtn1: TBitBtn
    Left = 528
    Top = 68
    Width = 165
    Height = 42
    HelpContext = 37
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 12
  end
end
