object ChangeCompSize: TChangeCompSize
  Left = 380
  Top = 271
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Change component size'
  ClientHeight = 276
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -14
  Font.Name = 'Microsoft YaHei'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 115
  TextHeight = 16
  object Bevel1: TBevel
    Left = 10
    Top = 10
    Width = 271
    Height = 255
    Shape = bsFrame
    IsControl = True
  end
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 117
    Height = 16
    Caption = 'Component type:'
  end
  object Label2: TLabel
    Left = 24
    Top = 96
    Width = 10
    Height = 16
    Hint = 'New value of the X coordinate'
    Caption = 'X'
  end
  object Label3: TLabel
    Left = 24
    Top = 139
    Width = 11
    Height = 16
    Hint = 'New value of the Y coordinate (counted from top)'
    Caption = 'Y'
  end
  object Label4: TLabel
    Left = 24
    Top = 181
    Width = 40
    Height = 16
    Hint = 'New width'
    Caption = 'Width'
  end
  object Label5: TLabel
    Left = 24
    Top = 224
    Width = 46
    Height = 16
    Hint = 'New height'
    Caption = 'Height'
  end
  object OKBtn: TBitBtn
    Left = 289
    Top = 10
    Width = 104
    Height = 33
    Hint = 'Start changing'
    TabOrder = 0
    OnClick = OKBtnClick
    Kind = bkOK
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 289
    Top = 49
    Width = 104
    Height = 33
    TabOrder = 1
    Kind = bkCancel
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object ComboBox1: TComboBox
    Left = 24
    Top = 52
    Width = 241
    Height = 24
    Hint = 'Type of the component to change size'
    ItemHeight = 16
    TabOrder = 2
    Text = 'Text'
    Items.Strings = (
      'Text'
      'HTML'
      'RTF'
      'Spell'
      'Sound'
      'Image'
      'Video'
      'OLE'
      'Script'
      'Program')
  end
  object XEdit: TEdit
    Left = 96
    Top = 92
    Width = 169
    Height = 24
    Hint = 'New value of the X coordinate'
    TabOrder = 3
    Text = 'No change'
  end
  object YEdit: TEdit
    Left = 96
    Top = 135
    Width = 169
    Height = 24
    Hint = 'New value of the Y coordinate (counted from top)'
    TabOrder = 4
    Text = 'No change'
  end
  object WEdit: TEdit
    Left = 96
    Top = 177
    Width = 169
    Height = 24
    Hint = 'New width'
    TabOrder = 5
    Text = 'No change'
  end
  object HEdit: TEdit
    Left = 96
    Top = 220
    Width = 169
    Height = 24
    Hint = 'New height'
    TabOrder = 6
    Text = 'No change'
  end
end
