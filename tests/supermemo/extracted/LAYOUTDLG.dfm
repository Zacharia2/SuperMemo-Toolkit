object LayoutDlg: TLayoutDlg
  Left = 486
  Top = 134
  BorderStyle = bsDialog
  Caption = 'Layouts'
  ClientHeight = 650
  ClientWidth = 517
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object DefaultLayout: TLabel
    Left = 7
    Top = 551
    Width = 37
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Default:'
  end
  object CurrentLayout: TLabel
    Left = 7
    Top = 585
    Width = 37
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Current:'
  end
  object ListBox1: TListBox
    Left = 7
    Top = 7
    Width = 378
    Height = 522
    Hint = 'Currently defined layouts'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnDblClick = ListBox1DblClick
    OnKeyDown = ListBox1KeyDown
  end
  object Delete: TBitBtn
    Left = 389
    Top = 121
    Width = 122
    Height = 35
    Hint = 'Delete the selected layout'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Delete'
    NumGlyphs = 2
    TabOrder = 4
    OnClick = DeleteClick
  end
  object Apply: TBitBtn
    Left = 389
    Top = 7
    Width = 122
    Height = 35
    Hint = 'Apply the selected layout'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Apply'
    Default = True
    TabOrder = 1
    OnClick = ApplyClick
  end
  object CloseBtn: TBitBtn
    Left = 389
    Top = 159
    Width = 122
    Height = 35
    Hint = 'Close the layout window'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Cancel = True
    Caption = '&Close'
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 5
    OnClick = CloseBtnClick
  end
  object Save: TBitBtn
    Left = 389
    Top = 45
    Width = 122
    Height = 35
    Hint = 'Save the current layout'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Save'
    TabOrder = 2
    OnClick = SaveClick
  end
  object Default: TBitBtn
    Left = 389
    Top = 83
    Width = 122
    Height = 35
    Hint = 'Make the selected layout the default layout'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Default'
    TabOrder = 3
    OnClick = DefaultClick
  end
  object UseEsc: TCheckBox
    Left = 7
    Top = 619
    Width = 476
    Height = 20
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Use Esc to restore default layout'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 6
  end
end
