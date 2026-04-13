object Options: TOptions
  Left = 475
  Top = 184
  HelpContext = 3
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 923
  ClientWidth = 1547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -29
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 33
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1547
    Height = 923
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = LearningTab
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object LearningTab: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&Learning'
      object Bevel6: TBevel
        Left = 24
        Top = 21
        Width = 1472
        Height = 180
        Hint = 
          'Proportion of items that will be forgotten during repetitions (i' +
          'n percent)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Label3: TLabel
        Left = 74
        Top = 33
        Width = 267
        Height = 33
        Hint = 
          'Proportion of items that will be forgotten during repetitions (i' +
          'n percent)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Forgetting index (default)'
      end
      object FILabel: TLabel
        Left = 1298
        Top = 93
        Width = 56
        Height = 33
        Hint = 
          'Proportion of items that will be forgotten during repetitions (i' +
          'n percent)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '10 %'
      end
      object Bevel5: TBevel
        Left = 24
        Top = 219
        Width = 839
        Height = 224
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Bevel4: TBevel
        Left = 881
        Top = 219
        Width = 615
        Height = 224
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object MidnightClockLabel: TLabel
        Left = 918
        Top = 240
        Width = 209
        Height = 33
        Hint = 
          'Number of hours past midnight after which new repetition day beg' +
          'ins'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Midnight clock shift:'
      end
      object Label2: TLabel
        Left = 923
        Top = 393
        Width = 13
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taCenter
        Caption = '0'
      end
      object Label4: TLabel
        Left = 1040
        Top = 398
        Width = 13
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taCenter
        Caption = '4'
      end
      object Label7: TLabel
        Left = 1157
        Top = 398
        Width = 13
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taCenter
        Caption = '8'
      end
      object Label18: TLabel
        Left = 1275
        Top = 398
        Width = 26
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taCenter
        Caption = '12'
      end
      object Label19: TLabel
        Left = 1395
        Top = 398
        Width = 26
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taCenter
        Caption = '16'
      end
      object GroupBox3: TGroupBox
        Left = 24
        Top = 480
        Width = 1472
        Height = 297
        Hint = 
          'Alert on interval discrepancies large enough (in percent) for in' +
          'tervals long enough (in days)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Algorithm Arena Alerts'
        TabOrder = 4
        object Label20: TLabel
          Left = 72
          Top = 137
          Width = 146
          Height = 33
          Hint = 
            'Suppress alerts for intervals shorter than this minimum (to avoi' +
            'd noise on short intervals)'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Interval [days]'
        end
        object Label6: TLabel
          Left = 72
          Top = 57
          Width = 152
          Height = 33
          Hint = 
            'Alert when the recommended interval differs from other algorithm' +
            's by more than this percentage'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Difference [%]'
        end
        object Label1: TLabel
          Left = 72
          Top = 216
          Width = 68
          Height = 33
          Hint = 
            'Alert when the new interval is more than this many times longer ' +
            'than the previous interval'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Factor'
        end
        object IntervalLengthEdit: TEdit
          Left = 504
          Top = 131
          Width = 354
          Height = 41
          Hint = 
            'Suppress alerts for intervals shorter than this minimum (to avoi' +
            'd noise on short intervals)'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Alignment = taCenter
          TabOrder = 0
          Text = '14'
        end
        object IntervalDifferenceEdit: TEdit
          Left = 504
          Top = 51
          Width = 354
          Height = 41
          Hint = 
            'Alert when the recommended interval differs from other algorithm' +
            's by more than this percentage'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Alignment = taCenter
          TabOrder = 1
          Text = '40%'
        end
        object FactorLevelEdit: TEdit
          Left = 504
          Top = 210
          Width = 354
          Height = 41
          Hint = 
            'Alert when the new interval is more than this many times longer ' +
            'than the previous interval'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Alignment = taCenter
          TabOrder = 2
          Text = '2.5'
        end
        object StrictBtn: TBitBtn
          Left = 1007
          Top = 36
          Width = 301
          Height = 70
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Strict check'
          TabOrder = 3
          OnClick = StrictBtnClick
        end
        object LaxBtn: TBitBtn
          Left = 1007
          Top = 116
          Width = 301
          Height = 70
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Relaxed check'
          TabOrder = 4
          OnClick = LaxBtnClick
        end
        object DefaultCheckBtn: TBitBtn
          Left = 1007
          Top = 195
          Width = 301
          Height = 70
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Default check'
          TabOrder = 5
          OnClick = DefaultCheckBtnClick
        end
      end
      object FI: TTrackBar
        Left = 74
        Top = 93
        Width = 1188
        Height = 87
        Hint = 
          'Proportion of items that will be forgotten during repetitions (i' +
          'n percent)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Max = 20
        Min = 3
        PageSize = 4
        Position = 10
        TabOrder = 0
        ThumbLength = 45
        OnChange = FIChange
      end
      object RandomizeDrillBtn: TCheckBox
        Left = 101
        Top = 267
        Width = 765
        Height = 50
        Hint = 
          'Always randomly mix the final drill queue when moving from repet' +
          'itions to the final drill'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Always randomize final drill'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 1
      end
      object MidnightShiftBar: TTrackBar
        Left = 902
        Top = 290
        Width = 547
        Height = 90
        Hint = 
          'Number of hours past midnight after which new repetition day beg' +
          'ins'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Max = 16
        PageSize = 3
        TabOrder = 2
        ThumbLength = 45
        OnChange = MidnightShiftBarChange
      end
      object SkipDrillBtn: TCheckBox
        Left = 101
        Top = 353
        Width = 754
        Height = 51
        Hint = 'Do not add items to the final drill queue'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Skip final drill'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
    end
    object DataAccessTab: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'A&ccess'
      ImageIndex = 1
      object Label8: TLabel
        Left = 33
        Top = 33
        Width = 200
        Height = 33
        Hint = 
          'Select path at which multimedia objects of the collection are lo' +
          'cated (...\ELEMENTS)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Seco&ndary storage'
        FocusControl = SecondaryStorageEdit
      end
      object SecondaryStorageBtn: TSpeedButton
        Left = 1376
        Top = 104
        Width = 63
        Height = 60
        Hint = 
          'Select path at which multimedia objects of the collection are lo' +
          'cated (...\ELEMENTS)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00303333333333
          333337F3333333333333303333333333333337F33FFFFF3FF3FF303300000300
          300337FF77777F77377330000BBB0333333337777F337F33333330330BB00333
          333337F373F773333333303330033333333337F3377333333333303333333333
          333337F33FFFFF3FF3FF303300000300300337FF77777F77377330000BBB0333
          333337777F337F33333330330BB00333333337F373F773333333303330033333
          333337F3377333333333303333333333333337FFFF3FF3FFF333000003003000
          333377777F77377733330BBB0333333333337F337F33333333330BB003333333
          333373F773333333333330033333333333333773333333333333}
        NumGlyphs = 2
        OnClick = SecondaryStorageBtnClick
      end
      object Label16: TLabel
        Left = 38
        Top = 630
        Width = 105
        Height = 33
        Hint = 'Password that is used to protect access to the collection'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Password'
        FocusControl = PasswordEdit
      end
      object Label12: TLabel
        Left = 38
        Top = 527
        Width = 164
        Height = 33
        Hint = 'Default element in the collection'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Default element'
        FocusControl = DefaultElement
      end
      object SelectDefaultElement: TSpeedButton
        Left = 1376
        Top = 516
        Width = 63
        Height = 57
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        OnClick = SelectDefaultElementClick
      end
      object SecondaryStorageEdit: TEdit
        Left = 33
        Top = 107
        Width = 1341
        Height = 41
        Hint = 
          'Select path at which multimedia objects of the collection are lo' +
          'cated (...\ELEMENTS)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 0
      end
      object GroupBox2: TGroupBox
        Left = 38
        Top = 183
        Width = 1401
        Height = 299
        Hint = 'The degree of access to advanced options of the program'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Access level'
        TabOrder = 1
        object BeginnerBtn: TRadioButton
          Left = 38
          Top = 54
          Width = 604
          Height = 53
          Hint = 
            'SuperMemo provides only most important functions for the absolut' +
            'e beginner'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Beginner'
          TabOrder = 0
          OnClick = SetLevelClick
          OnKeyUp = BeginnerBtnKeyUp
        end
        object BasicBtn: TRadioButton
          Left = 38
          Top = 111
          Width = 604
          Height = 51
          Hint = 
            'SuperMemo provides all non-authoring functions for majority of u' +
            'sers'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '&Basic'
          TabOrder = 1
          OnClick = SetLevelClick
          OnKeyUp = BeginnerBtnKeyUp
        end
        object ProfessionalBtn: TRadioButton
          Left = 38
          Top = 219
          Width = 604
          Height = 53
          Hint = 'SuperMemo provides all its functions'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Professional'
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = SetLevelClick
          OnKeyUp = BeginnerBtnKeyUp
        end
        object MiddleBtn: TRadioButton
          Left = 38
          Top = 170
          Width = 604
          Height = 49
          Hint = 'SuperMemo provides options on middle-advanced level'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Middle'
          TabOrder = 3
          OnClick = SetLevelClick
        end
      end
      object PasswordEdit: TEdit
        Left = 369
        Top = 621
        Width = 377
        Height = 41
        Hint = 'Password that is used to protect access to the collection'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        MaxLength = 10
        PasswordChar = '*'
        TabOrder = 2
        OnChange = PasswordEditChange
      end
      object CompileLexiconBox: TCheckBox
        Left = 38
        Top = 699
        Width = 733
        Height = 53
        Hint = 
          'Uncheck this box to speed up SuperMemo by not compiling the lexi' +
          'con on editing texts'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Compile lexicon on-the-fly'
        TabOrder = 3
      end
      object DefaultElement: TEdit
        Left = 369
        Top = 516
        Width = 995
        Height = 41
        Hint = 'Default element in the collection'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        MaxLength = 10
        ReadOnly = True
        TabOrder = 4
      end
    end
    object LanguageTab: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Lan&guage'
      ImageIndex = 2
      object Bevel3: TBevel
        Left = 21
        Top = 443
        Width = 1464
        Height = 147
        Hint = 
          'Language used by the interface of SuperMemo in the hidden state ' +
          '(Ctrl+Alt+F12)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
      end
      object Bevel1: TBevel
        Left = 21
        Top = 170
        Width = 1490
        Height = 255
        Hint = 
          'Translation language for the collection, font and translation mo' +
          'de'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ParentShowHint = False
        ShowHint = True
      end
      object Bevel7: TBevel
        Left = 21
        Top = 609
        Width = 1464
        Height = 147
        Hint = 
          'Phonetic transcription used in the lexicon registry in Search : ' +
          'Find word (right panel) '
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
      end
      object Label14: TLabel
        Left = 65
        Top = 657
        Width = 228
        Height = 33
        Hint = 
          'Phonetic transcription used in the lexicon registry in Search : ' +
          'Find word (right panel) '
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Phonetic transcription'
        FocusControl = PhoneticCombo
      end
      object Label13: TLabel
        Left = 65
        Top = 494
        Width = 234
        Height = 33
        Hint = 
          'Language used by the interface of SuperMemo in the hidden state ' +
          '(Ctrl+Alt+F12)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Local&ization language:'
        FocusControl = LocalizationCombo
      end
      object Label11: TLabel
        Left = 65
        Top = 290
        Width = 163
        Height = 33
        Hint = 'Font used for collection translation (with Shift-Click)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Translation font'
      end
      object Label10: TLabel
        Left = 65
        Top = 200
        Width = 216
        Height = 33
        Hint = 'Language used for collection translation (with Shift-Click)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Collection &translation'
        FocusControl = TranslationCombo
      end
      object Bevel2: TBevel
        Left = 21
        Top = 21
        Width = 1464
        Height = 126
        Hint = 'Language used by the program'#39's authoring shell'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
      end
      object Label9: TLabel
        Left = 65
        Top = 65
        Width = 92
        Height = 33
        Hint = 'Language used by SuperMemo interface'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Program'
        Enabled = False
      end
      object PhoneticCombo: TComboBox
        Left = 503
        Top = 650
        Width = 724
        Height = 41
        Hint = 
          'Phonetic transcription used in the lexicon, on middle button cli' +
          'ck, etc.'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Sorted = True
        TabOrder = 8
        Text = 'None'
      end
      object ChoosePhoneticFont: TButton
        Left = 1265
        Top = 650
        Width = 196
        Height = 66
        Hint = 
          'Phonetic transcription used in the lexicon, on middle button cli' +
          'ck, etc.'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Font'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnClick = ChoosePhoneticFontClick
      end
      object LocalizationCombo: TComboBox
        Left = 503
        Top = 489
        Width = 532
        Height = 41
        Hint = 
          'Language used by the interface of SuperMemo in the hidden state ' +
          '(Ctrl+Alt+F12)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Sorted = True
        TabOrder = 6
        Text = 'None'
        OnClick = LocalizationComboClick
        Items.Strings = (
          '')
      end
      object Localization: TButton
        Left = 1062
        Top = 489
        Width = 404
        Height = 63
        Hint = 
          'Language used by the interface of SuperMemo in the hidden state ' +
          '(Ctrl+Alt+F12)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Locali&zation table'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = LocalizationClick
      end
      object TranslateSoundsBox: TCheckBox
        Left = 74
        Top = 366
        Width = 1125
        Height = 42
        Hint = 'Determine if sounds should be translated on mouse move'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Translate &sounds on mouse move'
        TabOrder = 5
      end
      object TranslationCombo: TComboBox
        Left = 503
        Top = 191
        Width = 724
        Height = 41
        Hint = 
          'Language used for collection translation (with Shift-Click, mous' +
          'e move, etc.)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Sorted = True
        TabOrder = 1
        Text = 'None'
        Items.Strings = (
          'English'
          'French'
          'German'
          'None'
          'Polish'
          'Spanish')
      end
      object TransFontName: TEdit
        Left = 503
        Top = 284
        Width = 724
        Height = 41
        Hint = 
          'Font used for collection translation (with Shift-Click, mouse mo' +
          've, etc.)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 3
        Text = 'Default'
      end
      object DeleteTranslation: TButton
        Left = 1265
        Top = 191
        Width = 196
        Height = 66
        Hint = 'Delete currently selected translation files'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Delete'
        TabOrder = 2
        OnClick = DeleteTranslationClick
      end
      object ChooseTransFont: TButton
        Left = 1265
        Top = 284
        Width = 196
        Height = 64
        Hint = 
          'Font used for collection translation (with Shift-Click, mouse mo' +
          've, etc.)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Font'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = ChooseTransFontClick
      end
      object ProgramLanguage: TEdit
        Left = 261
        Top = 54
        Width = 1205
        Height = 41
        Hint = 'Language used by the program'#39's authoring shell'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        Text = 'English'
      end
    end
    object SuperMemoTab: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&SuperMemo'
      ImageIndex = 3
      object Bevel8: TBevel
        Left = 21
        Top = 24
        Width = 1464
        Height = 98
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Label17: TLabel
        Left = 38
        Top = 276
        Width = 278
        Height = 33
        Hint = 'Set the default background image displayed in the element window'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Default &background image'
        FocusControl = BackgroundEdit
      end
      object Label15: TLabel
        Left = 53
        Top = 59
        Width = 262
        Height = 33
        Hint = 
          'Determine the maximum number of children that can be added to a ' +
          'single hierarchy node'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'C&hildren limit per branch:'
      end
      object ChildrenLimitLabel: TLabel
        Left = 645
        Top = 59
        Width = 13
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '0'
      end
      object GroupBox1: TGroupBox
        Left = 503
        Top = 462
        Width = 982
        Height = 296
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Custom sounds'
        TabOrder = 5
        object successlabel: TLabel
          Left = 26
          Top = 101
          Width = 90
          Height = 33
          Hint = 'Sound registry name of the sound produced for good grade scores'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Success'
        end
        object failurelabel: TLabel
          Left = 26
          Top = 191
          Width = 71
          Height = 33
          Hint = 'Sound registry name of the sound produced for bad grade scores'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Failure'
        end
        object PlaySuccess: TSpeedButton
          Left = 882
          Top = 93
          Width = 62
          Height = 54
          Hint = 'Play success-grade sound'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Glyph.Data = {
            6E020000424D6E0200000000000076000000280000002A000000150000000100
            040000000000F801000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888888888888888888888888880000008888888888888888888888888888
            8888888888888800000088888888888888888888888888888888888888888800
            0000888888888888888888888888888888888888888888000000888888F88888
            888888888888888F88888888888888000000888887AFF8888888888888888807
            FF888888888888000000888887AAAFF8888888888888880777FF888888888800
            0000888887AAAAAFF8888888888888077777FF88888888000000888887AAAAAA
            AFF8888888888807777777FF888888000000888887AAAAAAAAAFF88888888807
            77777777FF8888000000888887AAAAAAAAA77F88888888077777777700F88800
            0000888887AAAAAAA77888888888880777777700888888000000888887AAAAA7
            788888888888880777770088888888000000888887AAA7788888888888888807
            77008888888888000000888887A7788888888888888888070088888888888800
            0000888887788888888888888888880088888888888888000000888888888888
            8888888888888888888888888888880000008888888888888888888888888888
            8888888888888800000088888888888888888888888888888888888888888800
            0000888888888888888888888888888888888888888888000000888888888888
            888888888888888888888888888888000000}
          NumGlyphs = 2
          OnClick = PlaySuccessClick
        end
        object PlayFailure: TSpeedButton
          Left = 882
          Top = 183
          Width = 62
          Height = 57
          Hint = 'Play fail-grade sound'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Glyph.Data = {
            6E020000424D6E0200000000000076000000280000002A000000150000000100
            040000000000F801000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888888888888888888888888880000008888888888888888888888888888
            8888888888888800000088888888888888888888888888888888888888888800
            0000888888888888888888888888888888888888888888000000888888F88888
            888888888888888F88888888888888000000888887AFF8888888888888888807
            FF888888888888000000888887AAAFF8888888888888880777FF888888888800
            0000888887AAAAAFF8888888888888077777FF88888888000000888887AAAAAA
            AFF8888888888807777777FF888888000000888887AAAAAAAAAFF88888888807
            77777777FF8888000000888887AAAAAAAAA77F88888888077777777700F88800
            0000888887AAAAAAA77888888888880777777700888888000000888887AAAAA7
            788888888888880777770088888888000000888887AAA7788888888888888807
            77008888888888000000888887A7788888888888888888070088888888888800
            0000888887788888888888888888880088888888888888000000888888888888
            8888888888888888888888888888880000008888888888888888888888888888
            8888888888888800000088888888888888888888888888888888888888888800
            0000888888888888888888888888888888888888888888000000888888888888
            888888888888888888888888888888000000}
          NumGlyphs = 2
          OnClick = PlayFailureClick
        end
        object SuccessSoundEdit: TEdit
          Left = 230
          Top = 93
          Width = 646
          Height = 41
          Hint = 'Sound registry name of the sound produced for good grade scores'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Enabled = False
          TabOrder = 0
        end
        object FailureSoundEdit: TEdit
          Left = 230
          Top = 183
          Width = 646
          Height = 41
          Hint = 'Sound registry name of the sound produced for bad grade scores'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Enabled = False
          TabOrder = 1
        end
      end
      object SoundModeGroup: TRadioGroup
        Left = 53
        Top = 462
        Width = 418
        Height = 296
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Sound Feedback'
        TabOrder = 4
      end
      object BackgroundEdit: TEdit
        Left = 53
        Top = 345
        Width = 1432
        Height = 41
        Hint = 
          'Set the default background image displayed in the element window' +
          ' (valid image registry name)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 0
      end
      object ChildrenLimit: TTrackBar
        Left = 740
        Top = 44
        Width = 726
        Height = 69
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        LineSize = 10
        Max = 500
        Min = 5
        PageSize = 25
        Frequency = 20
        Position = 150
        TabOrder = 1
        ThumbLength = 45
        OnChange = ChildrenLimitChange
      end
      object RemoveFormattingBox: TCheckBox
        Left = 33
        Top = 134
        Width = 699
        Height = 52
        Hint = 
          'Save disk space by removing formatting from texts used in format' +
          'less components'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Remove hidden formatting'
        TabOrder = 2
        OnClick = RemoveFormattingBoxClick
      end
      object StatusBordersBox: TCheckBox
        Left = 33
        Top = 198
        Width = 699
        Height = 53
        Hint = 
          'Use component borders to mark plain text HTML (yellow), inner HT' +
          'ML (gray), zoomed pictures (red), etc.'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Component status borders'
        TabOrder = 3
        OnClick = StatusBordersBoxClick
      end
      object smNoneButton: TRadioButton
        Left = 72
        Top = 533
        Width = 254
        Height = 49
        Hint = 'No sound feedback during learning'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'None'
        Checked = True
        TabOrder = 6
        TabStop = True
        OnClick = smNoneButtonClick
      end
      object smDefaultButton: TRadioButton
        Left = 72
        Top = 594
        Width = 254
        Height = 48
        Hint = 
          'Use default Windows sounds during learning (Default Sound and Cr' +
          'itical Stop)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Default'
        TabOrder = 7
        OnClick = smNoneButtonClick
      end
      object smCustomButton: TRadioButton
        Left = 72
        Top = 666
        Width = 254
        Height = 47
        Hint = 'Use custom sounds from sound registry for learning feedback'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Custom'
        TabOrder = 8
        OnClick = smNoneButtonClick
      end
      object GradeIconsBox: TCheckBox
        Left = 936
        Top = 134
        Width = 536
        Height = 52
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Grade icons'
        Checked = True
        State = cbChecked
        TabOrder = 9
        OnClick = GradeIconsBoxClick
      end
    end
    object MouseTab: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&Mouse'
      ImageIndex = 5
      object Translation: TGroupBox
        Left = 20
        Top = 390
        Width = 711
        Height = 294
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Translation'
        TabOrder = 0
        object TranslationOnMouseMove: TCheckBox
          Left = 54
          Top = 54
          Width = 608
          Height = 50
          Hint = 'Translate texts when the mouse moves over '
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'On mouse move'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = TranslationOnMouseMoveClick
        end
        object TranslationOnMiddleClick: TCheckBox
          Left = 54
          Top = 126
          Width = 608
          Height = 53
          Hint = 
            'Translate texts upon a click with the middle mouse button (or wh' +
            'eel)'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'On middle button click'
          TabOrder = 1
          OnClick = TranslationOnMiddleClickClick
        end
        object TCheckBox
          Left = 54
          Top = 200
          Width = 608
          Height = 52
          Hint = 'Show text translation in a dialog box with Ctrl+click'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'On Ctrl+click'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 2
        end
      end
      object PhoneticTranscription: TGroupBox
        Left = 786
        Top = 390
        Width = 699
        Height = 294
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Phonetic transcription'
        TabOrder = 1
        object TranscriptionOnMouseMove: TCheckBox
          Left = 38
          Top = 54
          Width = 619
          Height = 50
          Hint = 
            'Replace texts with their transcription when the mouse moves over' +
            ' '
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'On mouse move'
          TabOrder = 0
          OnClick = TranscriptionOnMouseMoveClick
        end
        object TranscriptionOnMiddleClick: TCheckBox
          Left = 38
          Top = 126
          Width = 619
          Height = 53
          Hint = 
            'Replace texts with transcription upon a click with the middle mo' +
            'use button (or wheel)'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'On middle button click'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = TranscriptionOnMiddleClickClick
        end
        object CheckBox6: TCheckBox
          Left = 38
          Top = 200
          Width = 619
          Height = 52
          Hint = 'Show phonetic transcriptions with Ctrl+click'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'On Ctrl+click'
          Enabled = False
          TabOrder = 2
        end
      end
      object DragComponents: TGroupBox
        Left = 786
        Top = 53
        Width = 699
        Height = 321
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Drag components'
        TabOrder = 2
        object CheckBox1: TCheckBox
          Left = 38
          Top = 191
          Width = 619
          Height = 52
          Hint = 'Drag components to the ClipBox when Shift is pressed'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'On Ctrl+Shift+drag'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 0
        end
        object CheckBox7: TCheckBox
          Left = 38
          Top = 107
          Width = 619
          Height = 55
          Hint = 
            'Set components in dragging mode with a double click with Alt is ' +
            'pressed'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'On Alt+dblclick '
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 1
        end
      end
      object EditTexts: TGroupBox
        Left = 20
        Top = 53
        Width = 715
        Height = 321
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Edit components'
        TabOrder = 3
        object EditTextsOnAltClick: TCheckBox
          Left = 54
          Top = 74
          Width = 612
          Height = 52
          Hint = 'Set texts in editing mode upon Alt+click'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Edit on Alt+click'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 0
        end
        object EditTextsOnClick: TCheckBox
          Left = 54
          Top = 153
          Width = 612
          Height = 53
          Hint = 'Edit texts on mouse click'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Edit on click'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object CheckBox3: TCheckBox
          Left = 54
          Top = 236
          Width = 609
          Height = 39
          Hint = 'View images, HTML, etc. in the default viewer'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Preview on Ctrl+click'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 2
        end
      end
    end
    object Leeches: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Leeches'
      ImageIndex = 5
      object LeechChoices: TRadioGroup
        Left = 54
        Top = 54
        Width = 828
        Height = 428
        Hint = 'Determine how leeches should be processed'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Leech management'
        Items.Strings = (
          'None'
          'Wizard'
          'Auto-forget'
          'Auto-postpone')
        TabOrder = 0
        OnClick = LeechChoicesClick
      end
      object UseSemiLeechesBox: TCheckBox
        Left = 54
        Top = 552
        Width = 828
        Height = 48
        Hint = 'Include potential leeches in leech processing'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Include semi-leeches'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = UseSemiLeechesBoxClick
      end
    end
    object Fonts: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Fonts'
      ImageIndex = 6
      object Bevel9: TBevel
        Left = 6
        Top = 47
        Width = 1506
        Height = 699
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
      end
      object InterfaceSample: TLabel
        Left = 479
        Top = 201
        Width = 221
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Interface font sample'
      end
      object ContentsSample: TLabel
        Left = 479
        Top = 536
        Width = 224
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Contents font sample'
      end
      object QuestionSample: TLabel
        Left = 479
        Top = 312
        Width = 224
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Question font sample'
      end
      object HighlightSample: TLabel
        Left = 479
        Top = 648
        Width = 221
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Highlight font sample'
      end
      object AnswerSample: TLabel
        Left = 479
        Top = 425
        Width = 208
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Answer font sample'
      end
      object InterfaceFontButton: TBitBtn
        Left = 47
        Top = 189
        Width = 360
        Height = 60
        Hint = 
          'The interface font used throughout SuperMemo (buttons, dialogs, ' +
          'etc.)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Interface &font'
        Glyph.Data = {
          72010000424D7201000000000000760000002800000015000000150000000100
          040000000000FC00000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777770007777777777777777777770007777777777777777777770007744
          7777777777777777700077447777777777777777700077447777777778187777
          7000774447777777771777777000774477777777771787777000774477777777
          7711177770007744447755777717877770007777777778577717787770007777
          7777775778111177700077777777775777777777700077777777755577777777
          7000777777777757777777777000777777777758777777777000777777777775
          5777777770007777777777777777777770007777777777777777777770007777
          77777777777777777000777777777777777777777000}
        TabOrder = 0
        OnClick = InterfaceFontButtonClick
      end
      object QuestionFontButton: TBitBtn
        Left = 47
        Top = 300
        Width = 360
        Height = 60
        Hint = 'Default question font used in question text components'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Question font'
        Glyph.Data = {
          2E060000424D2E06000000000000360400002800000015000000150000000100
          080000000000F801000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
          A400000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
          0707070707070707070707070707070000000707070707070707070707070707
          0707070707070700000007070707070707070707070707070707070707070700
          0000070704040707070707070707070707070707070707000000070704040707
          07070707070707070707070707070700000007070404070707070707070707F8
          01F8070707070700000007070404040707070707070707070107070707070700
          000007070404070707070707070707070107F807070707000000070704040707
          0707070707070707010101070707070000000707040404040707050507070707
          0107F807070707000000070707070707070707F805070707010707F807070700
          000007070707070707070707050707F801010101070707000000070707070707
          0707070705070707070707070707070000000707070707070707070505050707
          0707070707070700000007070707070707070707050707070707070707070700
          00000707070707070707070705F8070707070707070707000000070707070707
          0707070707050507070707070707070000000707070707070707070707070707
          0707070707070700000007070707070707070707070707070707070707070700
          0000070707070707070707070707070707070707070707000000070707070707
          070707070707070707070707070707000000}
        TabOrder = 1
        OnClick = QuestionFontButtonClick
      end
      object ContentsFontButton: TBitBtn
        Left = 47
        Top = 524
        Width = 360
        Height = 60
        Hint = 'The font used to display element titles in the contents window'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Contents font'
        Glyph.Data = {
          2E060000424D2E06000000000000360400002800000015000000150000000100
          080000000000F801000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
          A400000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
          0707070707070707070707070707070000000707070707070707070707070707
          0707070707070700000007070707070707070707070707070707070707070700
          0000070704040707070707070707070707070707070707000000070704040707
          07070707070707070707070707070700000007070404070707070707070707F8
          01F8070707070700000007070404040707070707070707070107070707070700
          000007070404070707070707070707070107F807070707000000070704040707
          0707070707070707010101070707070000000707040404040707050507070707
          0107F807070707000000070707070707070707F805070707010707F807070700
          000007070707070707070707050707F801010101070707000000070707070707
          0707070705070707070707070707070000000707070707070707070505050707
          0707070707070700000007070707070707070707050707070707070707070700
          00000707070707070707070705F8070707070707070707000000070707070707
          0707070707050507070707070707070000000707070707070707070707070707
          0707070707070700000007070707070707070707070707070707070707070700
          0000070707070707070707070707070707070707070707000000070707070707
          070707070707070707070707070707000000}
        TabOrder = 2
        OnClick = ContentsFontButtonClick
      end
      object HighlightFontButton: TBitBtn
        Left = 47
        Top = 636
        Width = 360
        Height = 60
        Hint = 
          'Font used to highlight RTF texts (use stylesheets to highlight H' +
          'TML texts)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Highlight font'
        Glyph.Data = {
          2E060000424D2E06000000000000360400002800000015000000150000000100
          080000000000F801000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
          A400000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
          0707070707070707070707070707070000000707070707070707070707070707
          0707070707070700000007070707070707070707070707070707070707070700
          0000070704040707070707070707070707070707070707000000070704040707
          07070707070707070707070707070700000007070404070707070707070707F8
          01F8070707070700000007070404040707070707070707070107070707070700
          000007070404070707070707070707070107F807070707000000070704040707
          0707070707070707010101070707070000000707040404040707050507070707
          0107F807070707000000070707070707070707F805070707010707F807070700
          000007070707070707070707050707F801010101070707000000070707070707
          0707070705070707070707070707070000000707070707070707070505050707
          0707070707070700000007070707070707070707050707070707070707070700
          00000707070707070707070705F8070707070707070707000000070707070707
          0707070707050507070707070707070000000707070707070707070707070707
          0707070707070700000007070707070707070707070707070707070707070700
          0000070707070707070707070707070707070707070707000000070707070707
          070707070707070707070707070707000000}
        TabOrder = 3
        OnClick = HighlightFontButtonClick
      end
      object AnswerFontButton: TBitBtn
        Left = 47
        Top = 413
        Width = 360
        Height = 60
        Hint = 'Default font used in answer text components'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Answer font'
        Glyph.Data = {
          2E060000424D2E06000000000000360400002800000015000000150000000100
          080000000000F801000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
          A400000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
          0707070707070707070707070707070000000707070707070707070707070707
          0707070707070700000007070707070707070707070707070707070707070700
          0000070704040707070707070707070707070707070707000000070704040707
          07070707070707070707070707070700000007070404070707070707070707F8
          01F8070707070700000007070404040707070707070707070107070707070700
          000007070404070707070707070707070107F807070707000000070704040707
          0707070707070707010101070707070000000707040404040707050507070707
          0107F807070707000000070707070707070707F805070707010707F807070700
          000007070707070707070707050707F801010101070707000000070707070707
          0707070705070707070707070707070000000707070707070707070505050707
          0707070707070700000007070707070707070707050707070707070707070700
          00000707070707070707070705F8070707070707070707000000070707070707
          0707070707050507070707070707070000000707070707070707070707070707
          0707070707070700000007070707070707070707070707070707070707070700
          0000070707070707070707070707070707070707070707000000070707070707
          070707070707070707070707070707000000}
        TabOrder = 4
        OnClick = AnswerFontButtonClick
      end
      object DefaultFontInHTML: TCheckBox
        Left = 479
        Top = 80
        Width = 927
        Height = 61
        Hint = 
          'Use question and answer fonts in HTML (this will increase the si' +
          'ze of texts and the size of the collection)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Use question and answer fonts in HTML'
        TabOrder = 5
        OnClick = DefaultFontInHTMLClick
      end
      object StylesheetBtn: TButton
        Left = 47
        Top = 81
        Width = 360
        Height = 60
        Hint = 'Edit the default HTML stylesheet'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Stylesheet'
        TabOrder = 6
        OnClick = StylesheetBtnClick
      end
    end
    object TabSheet1: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'E-mail'
      ImageIndex = 7
      object MailOptions: TRadioGroup
        Left = 47
        Top = 36
        Width = 970
        Height = 314
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Default mail protocol'
        ItemIndex = 0
        Items.Strings = (
          'Default mail client'
          'Secure SMTP (with formatting and attachments)'
          'Simple MAPI (with attachments)')
        TabOrder = 0
      end
      object GroupBox4: TGroupBox
        Left = 47
        Top = 404
        Width = 1393
        Height = 373
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'SMTP data'
        TabOrder = 1
        object Label5: TLabel
          Left = 48
          Top = 62
          Width = 109
          Height = 33
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Username'
        end
        object Label21: TLabel
          Left = 48
          Top = 137
          Width = 105
          Height = 33
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Password'
        end
        object Label22: TLabel
          Left = 48
          Top = 288
          Width = 44
          Height = 33
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Port'
        end
        object Label23: TLabel
          Left = 48
          Top = 212
          Width = 119
          Height = 33
          Hint = 'Address of the SMTP host server (e.g. smtp.gmail.com)'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'SMTP host'
        end
        object MailUsernameEdit: TEdit
          Left = 432
          Top = 48
          Width = 842
          Height = 41
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabOrder = 0
        end
        object MailPasswordEdit: TEdit
          Left = 432
          Top = 126
          Width = 842
          Height = 41
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          PasswordChar = '*'
          TabOrder = 1
        end
        object MailPortEdit: TEdit
          Left = 432
          Top = 285
          Width = 842
          Height = 41
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabOrder = 2
          Text = '587'
        end
        object SMTPHostEdit: TEdit
          Left = 432
          Top = 206
          Width = 842
          Height = 41
          Hint = 'Address of the SMTP host server (e.g. smtp.gmail.com)'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabOrder = 3
        end
      end
    end
  end
  object OKBtn: TBitBtn
    Left = 797
    Top = 840
    Width = 226
    Height = 69
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&OK'
    Default = True
    Glyph.Data = {
      BE060000424DBE06000000000000360400002800000024000000120000000100
      0800000000008802000000000000000000000001000000010000000000000000
      80000080000000808000800000008000800080800000C0C0C000B14E5A00D9A8
      AE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECD5D800A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
      0303030303030303030303030303030303030303030303030303030303030303
      03030303030303030303030303030303030303030303FF030303030303030303
      03030303030303040403030303030303030303030303030303F8F8FF03030303
      03030303030303030303040202040303030303030303030303030303F80303F8
      FF030303030303030303030303040202020204030303030303030303030303F8
      03030303F8FF0303030303030303030304020202020202040303030303030303
      0303F8030303030303F8FF030303030303030304020202FA0202020204030303
      0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
      040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
      03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
      FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
      0303030303030303030303FA0202020403030303030303030303030303F8FF03
      03F8FF03030303030303030303030303FA020202040303030303030303030303
      0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
      03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
      030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
      0202040303030303030303030303030303F8FF03F8FF03030303030303030303
      03030303FA0202030303030303030303030303030303F8FFF803030303030303
      030303030303030303FA0303030303030303030303030303030303F803030303
      0303030303030303030303030303030303030303030303030303030303030303
      0303}
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 1
    OnClick = OKBtnClick
  end
  object CancelBtn: TBitBtn
    Left = 1035
    Top = 839
    Width = 230
    Height = 69
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkCancel
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 2
  end
  object Help: TBitBtn
    Left = 1272
    Top = 839
    Width = 230
    Height = 69
    HelpContext = 3
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkHelp
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 3
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Microsoft YaHei'
    Font.Style = []
    Left = 597
    Top = 13
  end
end
