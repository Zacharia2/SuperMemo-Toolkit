object AlignDlg: TAlignDlg
  Left = 393
  Top = 168
  BorderStyle = bsDialog
  Caption = 'Alignment and Size'
  ClientHeight = 496
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 24
  object Label1: TLabel
    Left = 13
    Top = 13
    Width = 85
    Height = 24
    Caption = 'Alignment'
  end
  object Label2: TLabel
    Left = 13
    Top = 276
    Width = 36
    Height = 24
    Caption = 'Size'
  end
  object GroupBox1: TGroupBox
    Left = 13
    Top = 46
    Width = 333
    Height = 224
    Caption = 'Horizontal'
    TabOrder = 0
    object HNoChange: TRadioButton
      Left = 13
      Top = 30
      Width = 307
      Height = 28
      Caption = 'No change'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object LeftSides: TRadioButton
      Left = 13
      Top = 60
      Width = 307
      Height = 27
      Caption = 'Left sides'
      TabOrder = 1
    end
    object HCenters: TRadioButton
      Left = 13
      Top = 88
      Width = 307
      Height = 29
      Caption = 'Centers'
      TabOrder = 2
    end
    object RightSides: TRadioButton
      Left = 13
      Top = 120
      Width = 307
      Height = 28
      Caption = 'Right sides'
      TabOrder = 3
    end
    object HSpace: TRadioButton
      Left = 13
      Top = 148
      Width = 307
      Height = 27
      Caption = 'Space equally'
      TabOrder = 4
    end
    object HCenter: TRadioButton
      Left = 13
      Top = 178
      Width = 307
      Height = 27
      Caption = 'Center in window'
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 357
    Top = 46
    Width = 343
    Height = 224
    Caption = 'Vertical'
    TabOrder = 1
    object VNoChange: TRadioButton
      Left = 13
      Top = 30
      Width = 319
      Height = 28
      Caption = 'No change'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object Tops: TRadioButton
      Left = 13
      Top = 60
      Width = 319
      Height = 27
      Caption = 'Tops'
      TabOrder = 1
    end
    object VCenters: TRadioButton
      Left = 13
      Top = 88
      Width = 319
      Height = 29
      Caption = 'Centers'
      TabOrder = 2
    end
    object Bottoms: TRadioButton
      Left = 13
      Top = 120
      Width = 319
      Height = 28
      Caption = 'Bottoms'
      TabOrder = 3
    end
    object VSpace: TRadioButton
      Left = 13
      Top = 148
      Width = 319
      Height = 27
      Caption = 'Space equally'
      TabOrder = 4
    end
    object VCenter: TRadioButton
      Left = 13
      Top = 178
      Width = 319
      Height = 27
      Caption = 'Center in window'
      TabOrder = 5
    end
  end
  object OK: TBitBtn
    Left = 393
    Top = 450
    Width = 147
    Height = 44
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = OKClick
  end
  object BitBtn2: TBitBtn
    Left = 551
    Top = 450
    Width = 149
    Height = 44
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object GroupBox3: TGroupBox
    Left = 13
    Top = 309
    Width = 333
    Height = 134
    Caption = 'Width'
    TabOrder = 4
    object HShrink: TRadioButton
      Left = 13
      Top = 60
      Width = 307
      Height = 27
      Caption = 'Shrink to the smallest'
      TabOrder = 0
    end
    object HGrow: TRadioButton
      Left = 13
      Top = 88
      Width = 307
      Height = 29
      Caption = 'Grow to the largest'
      TabOrder = 1
    end
    object RadioButton3: TRadioButton
      Left = 13
      Top = 30
      Width = 307
      Height = 28
      Caption = 'No change'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
  end
  object GroupBox4: TGroupBox
    Left = 357
    Top = 309
    Width = 343
    Height = 134
    Caption = 'Height'
    TabOrder = 5
    object VShrink: TRadioButton
      Left = 13
      Top = 60
      Width = 307
      Height = 27
      Caption = 'Shrink to the smallest'
      TabOrder = 0
    end
    object VGrow: TRadioButton
      Left = 13
      Top = 88
      Width = 307
      Height = 29
      Caption = 'Grow to the largest'
      TabOrder = 1
    end
    object RadioButton6: TRadioButton
      Left = 13
      Top = 30
      Width = 307
      Height = 28
      Caption = 'No change'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
  end
end
