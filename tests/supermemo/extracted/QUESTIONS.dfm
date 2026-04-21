object Questions: TQuestions
  Left = 481
  Top = 168
  ActiveControl = Country
  Caption = 'SuperMemo Questionnaire'
  ClientHeight = 584
  ClientWidth = 841
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 737
    Top = 0
    Width = 104
    Height = 584
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alRight
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 0
    object OK: TBitBtn
      Left = 4
      Top = 6
      Width = 93
      Height = 32
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&Send'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = OKClick
    end
    object Cancel: TBitBtn
      Left = 6
      Top = 110
      Width = 93
      Height = 32
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Cancel = True
      Caption = 'Cancel'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 3
      OnClick = CancelClick
    end
    object Save: TBitBtn
      Left = 6
      Top = 42
      Width = 93
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Save'
      TabOrder = 1
      OnClick = SaveClick
    end
    object CloseBtn: TBitBtn
      Left = 6
      Top = 73
      Width = 93
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Close'
      TabOrder = 2
      OnClick = CloseBtnClick
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 737
    Height = 584
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HorzScrollBar.Visible = False
    VertScrollBar.Position = 1276
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = -1252
      Width = 274
      Height = 16
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Thank you for your time. All fields are optional. '
    end
    object Label7: TLabel
      Left = 8
      Top = -1228
      Width = 206
      Height = 16
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Use Tab to move from field to field.'
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = -1182
      Width = 492
      Height = 188
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'About you'
      TabOrder = 0
      object Label2: TLabel
        Left = 16
        Top = 31
        Width = 61
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '1. Country:'
        FocusControl = Country
      end
      object Label3: TLabel
        Left = 16
        Top = 62
        Width = 81
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '2. Occupation'
      end
      object Label4: TLabel
        Left = 16
        Top = 94
        Width = 254
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '3. Educational background (degree, major)'
      end
      object Label5: TLabel
        Left = 16
        Top = 160
        Width = 38
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '4. Age'
      end
      object Country: TMemo
        Left = 149
        Top = 24
        Width = 336
        Height = 29
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Lines.Strings = (
          '')
        TabOrder = 0
      end
      object Occupation: TMemo
        Left = 180
        Top = 55
        Width = 305
        Height = 29
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 1
      end
      object Education: TMemo
        Left = 16
        Top = 118
        Width = 469
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 2
      end
      object Age: TMemo
        Left = 78
        Top = 151
        Width = 64
        Height = 29
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 3
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = -986
      Width = 664
      Height = 330
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'About your use of SuperMemo'
      TabOrder = 1
      object Label6: TLabel
        Left = 16
        Top = 24
        Width = 264
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '5. How did you first learn about SuperMemo?'
      end
      object Label8: TLabel
        Left = 16
        Top = 109
        Width = 346
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '6. Which versions have you used (before SuperMemo 17)?'
      end
      object Label9: TLabel
        Left = 16
        Top = 187
        Width = 312
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'How long have you been using SuperMemo (years)?'
      end
      object Label10: TLabel
        Left = 16
        Top = 245
        Width = 378
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '8. How much time per day do you spend with SuperMemo (min)?'
      end
      object Label11: TLabel
        Left = 16
        Top = 274
        Width = 265
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '9. How many items do you have memorized?'
      end
      object HowLearn: TMemo
        Left = 16
        Top = 47
        Width = 632
        Height = 55
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 0
      end
      object SM2_7: TCheckBox
        Left = 16
        Top = 133
        Width = 195
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabStop = False
        Caption = 'SuperMemo 1.0-7.5'
        TabOrder = 2
      end
      object SM15: TCheckBox
        Left = 452
        Top = 155
        Width = 196
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'SuperMemo 15-16'
        TabOrder = 3
      end
      object SM8_99: TCheckBox
        Left = 234
        Top = 133
        Width = 196
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabStop = False
        Caption = 'SuperMemo 8/98/99'
        TabOrder = 4
      end
      object SM2004: TCheckBox
        Left = 16
        Top = 156
        Width = 195
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabStop = False
        Caption = 'SuperMemo 2004'
        TabOrder = 1
      end
      object SM2000_2002: TCheckBox
        Left = 452
        Top = 133
        Width = 196
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabStop = False
        Caption = 'SuperMemo 2000-2002'
        TabOrder = 5
      end
      object Use: TMemo
        Left = 16
        Top = 211
        Width = 328
        Height = 29
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 6
      end
      object Time: TMemo
        Left = 422
        Top = 232
        Width = 95
        Height = 29
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 7
      end
      object Memorized: TMemo
        Left = 16
        Top = 293
        Width = 195
        Height = 29
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 8
      end
      object SM2006_2008: TCheckBox
        Left = 234
        Top = 156
        Width = 196
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabStop = False
        Caption = 'SuperMemo 2006-2008'
        TabOrder = 9
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = -646
      Width = 664
      Height = 148
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '10. What is your opinion about the SuperMemo method?'
      TabOrder = 2
      object MethodExcellent: TRadioButton
        Left = 16
        Top = 41
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Excellent help in learning'
        TabOrder = 0
      end
      object MethodUseful: TRadioButton
        Left = 16
        Top = 61
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Useful idea'
        TabOrder = 1
      end
      object MethodNothing: TRadioButton
        Left = 16
        Top = 83
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Nothing special'
        TabOrder = 2
      end
      object MethodArtificial: TRadioButton
        Left = 16
        Top = 103
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Artificial approach to learning'
        TabOrder = 3
      end
      object MethodWaste: TRadioButton
        Left = 16
        Top = 125
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Waste of time'
        TabOrder = 4
      end
      object NoMethodOpinion: TRadioButton
        Left = 16
        Top = 19
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'No opinion'
        Checked = True
        TabOrder = 5
        TabStop = True
      end
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = -492
      Width = 664
      Height = 139
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '11. What is your opinion about SuperMemo software?'
      TabOrder = 3
      object ProgramExcellent: TRadioButton
        Left = 16
        Top = 40
        Width = 390
        Height = 15
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Excellent piece of software'
        TabOrder = 0
      end
      object ProgramReliable: TRadioButton
        Left = 16
        Top = 59
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Reliable product'
        TabOrder = 1
      end
      object ProgramGood: TRadioButton
        Left = 16
        Top = 77
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Good software that is not user friendly'
        TabOrder = 2
      end
      object ProgramPoor: TRadioButton
        Left = 16
        Top = 96
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Poor quality software'
        TabOrder = 3
      end
      object ProgramBag: TRadioButton
        Left = 16
        Top = 116
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Bag of bugs'
        TabOrder = 4
      end
      object NoProgramOpinion: TRadioButton
        Left = 16
        Top = 19
        Width = 390
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'No opinion'
        Checked = True
        TabOrder = 5
        TabStop = True
      end
    end
    object GroupBox5: TGroupBox
      Left = 8
      Top = -351
      Width = 664
      Height = 385
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Likes and dislikes'
      TabOrder = 4
      object Label12: TLabel
        Left = 8
        Top = 24
        Width = 248
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '12. What do you like most in SuperMemo?'
      end
      object Label13: TLabel
        Left = 8
        Top = 196
        Width = 266
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '13. What do you dislike most in SuperMemo?'
      end
      object Like: TMemo
        Left = 8
        Top = 47
        Width = 640
        Height = 133
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 0
      end
      object Dislike: TMemo
        Left = 8
        Top = 218
        Width = 640
        Height = 158
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 1
      end
    end
    object GroupBox6: TGroupBox
      Left = 8
      Top = 37
      Width = 664
      Height = 543
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Scope for improvement'
      TabOrder = 5
      object Label14: TLabel
        Left = 8
        Top = 24
        Width = 400
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '14. What are the most important improvements you would welcome?'
      end
      object Label15: TLabel
        Left = 8
        Top = 234
        Width = 401
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 
          '15. What subjects are insufficiently or unclearly covered in hel' +
          'p (F1)?'
      end
      object Label16: TLabel
        Left = 8
        Top = 414
        Width = 418
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 
          '16. Dou you use incremental reading? How does it affect your lea' +
          'rning?'
      end
      object Improvements: TMemo
        Left = 16
        Top = 48
        Width = 626
        Height = 180
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 0
      end
      object Help: TMemo
        Left = 16
        Top = 258
        Width = 632
        Height = 149
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 1
      end
      object IR: TMemo
        Left = 16
        Top = 434
        Width = 632
        Height = 95
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 2
      end
    end
  end
end
