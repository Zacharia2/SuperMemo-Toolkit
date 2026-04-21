object ImgScaler: TImgScaler
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Image Scaling'
  ClientHeight = 413
  ClientWidth = 824
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 144
  TextHeight = 21
  object CompressorImage: TImage
    Left = 551
    Top = 368
    Width = 37
    Height = 37
    Proportional = True
    Visible = False
  end
  object Scale: TLabel
    Left = 624
    Top = 18
    Width = 39
    Height = 21
    Caption = '&Scale'
    FocusControl = ScaleBar
  end
  object Size: TLabel
    Left = 624
    Top = 116
    Width = 30
    Height = 21
    Caption = 'Size'
  end
  object ScaledImage: TImage
    Left = 588
    Top = 368
    Width = 38
    Height = 37
  end
  object Quality: TLabel
    Left = 624
    Top = 66
    Width = 52
    Height = 21
    Caption = 'Quality'
  end
  object Label1: TLabel
    Left = 624
    Top = 167
    Width = 28
    Height = 21
    Caption = '&Left'
    FocusControl = LeftBar
  end
  object Label2: TLabel
    Left = 624
    Top = 213
    Width = 39
    Height = 21
    Caption = '&Right'
    FocusControl = RightBar
  end
  object Label3: TLabel
    Left = 624
    Top = 264
    Width = 28
    Height = 21
    Caption = '&Top'
    FocusControl = TopBar
  end
  object Label4: TLabel
    Left = 624
    Top = 312
    Width = 54
    Height = 21
    Caption = '&Bottom'
    FocusControl = BottomBar
  end
  object ScaleBar: TTrackBar
    Left = 18
    Top = 18
    Width = 575
    Height = 24
    LineSize = 3
    Max = 100
    Min = 3
    PageSize = 7
    Frequency = 5
    Position = 90
    TabOrder = 0
    ThumbLength = 30
    OnChange = ScaleBarChange
  end
  object QualityBar: TTrackBar
    Left = 18
    Top = 66
    Width = 575
    Height = 24
    Max = 100
    Min = 5
    Frequency = 5
    Position = 80
    TabOrder = 1
    ThumbLength = 30
    OnChange = ScaleBarChange
  end
  object SizeBar: TTrackBar
    Left = 18
    Top = 116
    Width = 575
    Height = 24
    Enabled = False
    Max = 100
    Position = 100
    TabOrder = 2
    ThumbLength = 30
  end
  object Original: TButton
    Left = 192
    Top = 377
    Width = 158
    Height = 28
    Caption = 'Original'
    TabOrder = 8
    OnClick = OriginalClick
  end
  object OK: TBitBtn
    Left = 27
    Top = 377
    Width = 149
    Height = 28
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 7
    OnClick = OKClick
  end
  object Cancel: TBitBtn
    Left = 368
    Top = 377
    Width = 156
    Height = 28
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 9
  end
  object LeftBar: TTrackBar
    Left = 18
    Top = 167
    Width = 575
    Height = 21
    Max = 100
    TabOrder = 3
    ThumbLength = 30
    OnChange = ScaleBarChange
  end
  object RightBar: TTrackBar
    Left = 18
    Top = 213
    Width = 575
    Height = 24
    Max = 100
    Min = 5
    Position = 100
    TabOrder = 4
    ThumbLength = 30
    OnChange = ScaleBarChange
  end
  object TopBar: TTrackBar
    Left = 18
    Top = 264
    Width = 575
    Height = 21
    Max = 100
    Position = 100
    TabOrder = 5
    ThumbLength = 30
    OnChange = ScaleBarChange
  end
  object BottomBar: TTrackBar
    Left = 18
    Top = 312
    Width = 575
    Height = 23
    Max = 100
    Min = 5
    Position = 100
    TabOrder = 6
    ThumbLength = 30
    OnChange = ScaleBarChange
  end
end
