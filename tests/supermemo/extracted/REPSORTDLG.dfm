object RepSortDlg: TRepSortDlg
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu]
  Caption = 'Repetition sorting criteria'
  ClientHeight = 942
  ClientWidth = 896
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 22
  object PaintBox1: TPaintBox
    Left = 0
    Top = 480
    Width = 896
    Height = 434
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object YLabel: TLabel
    Left = 33
    Top = 764
    Width = 10
    Height = 22
    Caption = 'Y'
    Transparent = True
  end
  object XLabel: TLabel
    Left = 51
    Top = 764
    Width = 10
    Height = 22
    Caption = 'X'
    Transparent = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 896
    Height = 480
    Align = alTop
    TabOrder = 1
    DesignSize = (
      896
      480)
    object Bevel1: TBevel
      Left = 18
      Top = 206
      Width = 851
      Height = 253
      Shape = bsFrame
      Style = bsRaised
    end
    object Bevel2: TBevel
      Left = 18
      Top = 87
      Width = 851
      Height = 111
      Shape = bsFrame
      Style = bsRaised
    end
    object Label4: TLabel
      Left = 44
      Top = 98
      Width = 156
      Height = 22
      Hint = 'Proportion of topics in the sequence of learned elements'
      Caption = 'Proportion of topics'
    end
    object Label3: TLabel
      Left = 44
      Top = 216
      Width = 125
      Height = 22
      Hint = 
        'Choosing between highly prioritized vs. highly randomized sequen' +
        'ce of learning'
      Caption = 'Prioritized items'
    end
    object ItemRandomizationL: TLabel
      Left = 693
      Top = 216
      Width = 144
      Height = 22
      Hint = 
        'Choosing between highly prioritized vs. highly randomized sequen' +
        'ce of learning'
      Anchors = [akTop, akRight]
      Caption = 'Randomized items'
    end
    object Label5: TLabel
      Left = 39
      Top = 330
      Width = 129
      Height = 22
      Hint = 
        'Choosing between highly prioritized vs. highly randomized sequen' +
        'ce of learning'
      Caption = 'Prioritized topics'
    end
    object TopicRandomizationL: TLabel
      Left = 687
      Top = 330
      Width = 148
      Height = 22
      Hint = 
        'Choosing between highly prioritized vs. highly randomized sequen' +
        'ce of learning'
      Anchors = [akTop, akRight]
      Caption = 'Randomized topics'
    end
    object TopicsBar: TTrackBar
      Left = 33
      Top = 141
      Width = 812
      Height = 57
      Hint = 'Proportion of topics in the sequence of learned elements'
      Max = 100
      PageSize = 10
      TabOrder = 0
      ThumbLength = 45
    end
    object SortNow: TBitBtn
      Left = 254
      Top = 15
      Width = 234
      Height = 54
      Caption = '&Sort Now'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      ModalResult = 4
      NumGlyphs = 2
      TabOrder = 1
      OnClick = SortNowClick
    end
    object OK: TBitBtn
      Left = 494
      Top = 15
      Width = 184
      Height = 54
      Caption = '&OK'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 2
      OnClick = OKClick
    end
    object Cancel: TBitBtn
      Left = 684
      Top = 15
      Width = 185
      Height = 54
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 3
    end
    object ItemRandomizationBar: TTrackBar
      Left = 33
      Top = 257
      Width = 812
      Height = 64
      Hint = 
        'Choosing between highly prioritized vs. highly randomized sequen' +
        'ce of learning'
      Max = 100
      PageSize = 10
      Position = 1
      TabOrder = 4
      ThumbLength = 45
      OnChange = ItemRandomizationBarChange
    end
    object TopicRandomizationBar: TTrackBar
      Left = 33
      Top = 374
      Width = 812
      Height = 64
      Hint = 
        'Choosing between highly prioritized vs. highly randomized sequen' +
        'ce of learning'
      Max = 100
      PageSize = 10
      Position = 1
      TabOrder = 5
      ThumbLength = 45
      OnChange = ItemRandomizationBarChange
    end
  end
  object TabSet1: TTabControl
    Left = 0
    Top = 914
    Width = 896
    Height = 28
    Align = alBottom
    TabOrder = 0
    Tabs.Strings = (
      'Sorting criteria'
      'Current item sorting'
      'Current topic sorting')
    TabIndex = 0
    OnChange = TabSet1Change
  end
end
