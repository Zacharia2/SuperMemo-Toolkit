object ElementFilter: TElementFilter
  Left = 475
  Top = 189
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Element filter'
  ClientHeight = 712
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object Bevel1: TBevel
    Left = 12
    Top = 12
    Width = 712
    Height = 515
  end
  object Bevel2: TBevel
    Left = 280
    Top = 12
    Width = 444
    Height = 507
  end
  object Label1: TLabel
    Left = 290
    Top = 22
    Width = 63
    Height = 20
    Caption = 'Minimum'
    ParentShowHint = False
    ShowHint = True
  end
  object Label2: TLabel
    Left = 514
    Top = 22
    Width = 67
    Height = 20
    Caption = 'Maximum'
    ParentShowHint = False
    ShowHint = True
  end
  object SaveFilterBtn: TSpeedButton
    Left = 484
    Top = 670
    Width = 35
    Height = 28
    Hint = 'Save the current filter for later use'
    OnClick = SaveFilterBtnClick
  end
  object DeleteFilterBtn: TSpeedButton
    Left = 517
    Top = 670
    Width = 36
    Height = 28
    Hint = 'Delete the current filter'
    OnClick = DeleteFilterBtnClick
  end
  object SetMinLastRep: TSpeedButton
    Left = 462
    Top = 222
    Width = 35
    Height = 28
    Hint = 'Select the date'
    OnClick = SetMinLastRepClick
  end
  object SetMinNextRep: TSpeedButton
    Left = 462
    Top = 265
    Width = 35
    Height = 28
    Hint = 'Select the date'
    OnClick = SetMinNextRepClick
  end
  object SetMaxLastRep: TSpeedButton
    Left = 684
    Top = 222
    Width = 35
    Height = 28
    Hint = 'Select the date'
    OnClick = SetMaxLastRepClick
  end
  object SetMaxNextRep: TSpeedButton
    Left = 684
    Top = 265
    Width = 35
    Height = 28
    Hint = 'Select the date'
    OnClick = SetMaxNextRepClick
  end
  object RepBox: TCheckBox
    Left = 22
    Top = 95
    Width = 247
    Height = 26
    Hint = 'Turn on/off filtering repetitions'
    Caption = '&Repetitions'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = RepBoxClick
  end
  object LapBox: TCheckBox
    Left = 22
    Top = 138
    Width = 247
    Height = 27
    Hint = 'Turn on/off filtering memory lapses'
    Caption = '&Lapses'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = LapBoxClick
  end
  object IntBox: TCheckBox
    Left = 22
    Top = 182
    Width = 247
    Height = 26
    Hint = 'Turn on/off filtering intervals'
    Caption = '&Interval'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = IntBoxClick
  end
  object LastRepBox: TCheckBox
    Left = 22
    Top = 224
    Width = 247
    Height = 27
    Hint = 'Turn on/off filtering last repetition dates'
    Caption = 'La&st repetition'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = LastRepBoxClick
  end
  object NextRepBox: TCheckBox
    Left = 22
    Top = 268
    Width = 247
    Height = 26
    Hint = 'Turn on/off filtering next repetition dates'
    Caption = 'Ne&xt repetition'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = NextRepBoxClick
  end
  object AFBox: TCheckBox
    Left = 22
    Top = 309
    Width = 247
    Height = 26
    Hint = 'Turn on/off filtering A-Factors'
    Caption = '&A-Factor'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = AFBoxClick
  end
  object FIBox: TCheckBox
    Left = 22
    Top = 352
    Width = 247
    Height = 28
    Hint = 'Turn on/off filtering forgetting indices'
    Caption = '&Forgetting Index'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = FIBoxClick
  end
  object RadioGroup1: TRadioGroup
    Left = 9
    Top = 529
    Width = 271
    Height = 134
    Caption = 'Type'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 43
  end
  object RadioGroup2: TRadioGroup
    Left = 290
    Top = 529
    Width = 259
    Height = 134
    Caption = 'Status'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 44
  end
  object RepMinE: TEdit
    Left = 290
    Top = 95
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of repetition number'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
  end
  object RepMaxE: TEdit
    Left = 514
    Top = 95
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of repetition number'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
  end
  object LapMinE: TEdit
    Left = 290
    Top = 138
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of memory lapses'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 18
  end
  object LapMaxE: TEdit
    Left = 514
    Top = 138
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of memory lapses'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
  end
  object IntMinE: TEdit
    Left = 290
    Top = 181
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of intervals'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
  end
  object IntMaxE: TEdit
    Left = 514
    Top = 181
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of intervals'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 21
  end
  object LastRepMinE: TEdit
    Left = 290
    Top = 222
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of the last repetition date'
    Color = clBtnFace
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 22
  end
  object NextRepMinE: TEdit
    Left = 290
    Top = 265
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of the next repetition date'
    Color = clBtnFace
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 24
  end
  object AFMinE: TEdit
    Left = 290
    Top = 307
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of A-Factors'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 26
  end
  object FIMinE: TEdit
    Left = 290
    Top = 348
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of the requested forgetting index'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 28
  end
  object LastRepMaxE: TEdit
    Left = 514
    Top = 222
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of the last repetition date'
    Color = clBtnFace
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 23
  end
  object NextRepMaxE: TEdit
    Left = 514
    Top = 265
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of the next repetition date'
    Color = clBtnFace
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 25
  end
  object AFMaxE: TEdit
    Left = 514
    Top = 307
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of A-Factors'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 27
  end
  object FIMaxE: TEdit
    Left = 514
    Top = 348
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of the requested forgetting index'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 29
  end
  object OrdBox: TCheckBox
    Left = 22
    Top = 397
    Width = 247
    Height = 26
    Hint = 'Turn on/off filtering the ordinals'
    Caption = '&Ordinal number'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = OrdBoxClick
  end
  object OrdMinE: TEdit
    Left = 290
    Top = 391
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of the ordinal number'
    Color = clBtnFace
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 30
  end
  object OrdMaxE: TEdit
    Left = 514
    Top = 391
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of the ordinal number'
    Color = clBtnFace
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 31
  end
  object ItemBox: TCheckBox
    Left = 47
    Top = 562
    Width = 134
    Height = 27
    Hint = 'Filter items'
    Caption = 'It&em'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 36
  end
  object TopicBox: TCheckBox
    Left = 47
    Top = 597
    Width = 134
    Height = 22
    Hint = 'Filter topic elements'
    Caption = '&Topic'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 37
  end
  object MemorizedBox: TCheckBox
    Left = 313
    Top = 564
    Width = 208
    Height = 21
    Hint = 'Add memorized elements to the filtered set'
    Caption = '&Memorized'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 39
  end
  object PendingBox: TCheckBox
    Left = 313
    Top = 594
    Width = 208
    Height = 25
    Hint = 'Add pending elements to the filtered set'
    Caption = 'Pending'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 40
  end
  object DismissedBox: TCheckBox
    Left = 313
    Top = 628
    Width = 208
    Height = 27
    Hint = 'Add dismissed elements to the filtered set'
    Caption = '&Dismissed'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 41
  end
  object OK: TButton
    Left = 577
    Top = 534
    Width = 134
    Height = 54
    Hint = 'Search for elements that meet the filter criteria'
    Caption = 'O&K'
    Default = True
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = OKClick
  end
  object Cancel: TButton
    Left = 577
    Top = 594
    Width = 134
    Height = 53
    Hint = 'Close the dialog and discard the changes'
    Cancel = True
    Caption = 'Cancel'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = CancelClick
  end
  object TaskBox: TCheckBox
    Left = 47
    Top = 628
    Width = 135
    Height = 25
    Hint = 'Filter elements on the tasklist'
    Caption = 'Tas&k'
    TabOrder = 38
  end
  object Help: TBitBtn
    Left = 577
    Top = 653
    Width = 134
    Height = 52
    HelpContext = 25
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 2
  end
  object UFBox: TCheckBox
    Left = 22
    Top = 439
    Width = 247
    Height = 26
    Hint = 'Turn on/off filtering U-Factors'
    Caption = '&U-Factor'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = UFBoxClick
  end
  object PostBox: TCheckBox
    Left = 22
    Top = 482
    Width = 247
    Height = 28
    Hint = 'Turn on/off filtering postpone count'
    Caption = 'Postpones'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnClick = PostBoxClick
  end
  object FilterCombo: TComboBox
    Left = 9
    Top = 670
    Width = 473
    Height = 28
    Hint = 'Selection of available filters'
    Sorted = True
    TabOrder = 42
    Text = 'Last used'
    OnChange = FilterComboChange
  end
  object UFMinE: TEdit
    Left = 290
    Top = 433
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of U-Factors'
    Color = clBtnFace
    TabOrder = 32
  end
  object UFMaxE: TEdit
    Left = 514
    Top = 433
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of U-Factors'
    Color = clBtnFace
    TabOrder = 33
  end
  object PostMinE: TEdit
    Left = 290
    Top = 476
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of the postpone count'
    Color = clBtnFace
    TabOrder = 34
  end
  object PostMaxE: TEdit
    Left = 514
    Top = 476
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range of the postpone count'
    Color = clBtnFace
    TabOrder = 35
  end
  object PriorityBox: TCheckBox
    Left = 22
    Top = 53
    Width = 247
    Height = 26
    Hint = 'Turn on/off filtering by priority'
    Caption = '&Priority'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = PriorityBoxClick
  end
  object PriorityMinE: TEdit
    Left = 290
    Top = 53
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range for priorities'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
  end
  object PriorityMaxE: TEdit
    Left = 514
    Top = 53
    Width = 169
    Height = 28
    Hint = 'Specify the filtering range for priorities'
    Color = clBtnFace
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
  end
end
