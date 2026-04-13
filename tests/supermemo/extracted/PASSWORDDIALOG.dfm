object PasswordDialog: TPasswordDialog
  Left = 260
  Top = 184
  ActiveControl = Edit
  BorderStyle = bsDialog
  Caption = 'Enter password'
  ClientHeight = 132
  ClientWidth = 273
  ParentFont = True
  PixelsPerInch = 96
  Position = poScreenCenter
  TextHeight = 13
  object OKButton: TButton
    Left = 109
    Top = 98
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 1
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 190
    Top = 98
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 81
    Caption = 'Password'
    TabOrder = 0
    object Edit: TEdit
      Left = 16
      Top = 18
      Width = 225
      Height = 20
      PasswordChar = '*'
      TabOrder = 0
      OnChange = EditChange
    end
    object AddButton: TButton
      Left = 16
      Top = 46
      Width = 65
      Height = 25
      Caption = '&Add'
      Enabled = False
      TabOrder = 1
      OnClick = AddButtonClick
    end
    object RemoveButton: TButton
      Left = 88
      Top = 46
      Width = 65
      Height = 25
      Caption = '&Remove'
      Enabled = False
      TabOrder = 2
      OnClick = RemoveButtonClick
    end
    object RemoveAllButton: TButton
      Left = 160
      Top = 46
      Width = 81
      Height = 25
      Caption = 'Re&move all'
      TabOrder = 3
      OnClick = RemoveAllButtonClick
    end
  end
end
