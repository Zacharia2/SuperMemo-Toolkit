object ChecksDlg: TChecksDlg
  Left = 501
  Top = 420
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Select'
  ClientHeight = 418
  ClientWidth = 1207
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  KeyPreview = True
  PopupMenu = PopupMenu1
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 29
  object MessageLabel: TLabel
    Left = 15
    Top = 18
    Width = 1103
    Height = 27
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = False
    Caption = 'Message'
  end
  object Cancel: TBitBtn
    Left = 1017
    Top = 329
    Width = 180
    Height = 57
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object OK: TBitBtn
    Left = 824
    Top = 329
    Width = 180
    Height = 57
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 0
    OnClick = OKClick
  end
  object CheckListBox1: TCheckListBox
    Left = 15
    Top = 86
    Width = 1162
    Height = 233
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Color = clBtnFace
    ItemHeight = 29
    TabOrder = 2
  end
  object PopupMenu1: TPopupMenu
    Left = 120
    Top = 312
    object MISelectAll: TMenuItem
      Caption = 'Select All'
      ShortCut = 16449
      OnClick = MISelectAllClick
    end
    object InvSelectAll1: TMenuItem
      Caption = 'Inv: Select All'
      ShortCut = 32833
      Visible = False
      OnClick = InvSelectAll1Click
    end
  end
end
