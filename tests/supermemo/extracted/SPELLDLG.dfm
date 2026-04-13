object SpellDlg: TSpellDlg
  Left = 342
  Top = 130
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Spelling'
  ClientHeight = 464
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  FormStyle = fsStayOnTop
  PixelsPerInch = 144
  TextHeight = 24
  object Label1: TLabel
    Left = 11
    Top = 11
    Width = 139
    Height = 24
    Caption = 'Not in dictionary:'
  end
  object Label2: TLabel
    Left = 11
    Top = 78
    Width = 113
    Height = 24
    Caption = 'Replace with:'
  end
  object Label3: TLabel
    Left = 11
    Top = 156
    Width = 109
    Height = 24
    Caption = 'Suggestions:'
  end
  object ErrorEdit: TEdit
    Left = 11
    Top = 39
    Width = 420
    Height = 32
    TabOrder = 0
  end
  object lbSuggestions: TListBox
    Left = 11
    Top = 186
    Width = 576
    Height = 254
    ItemHeight = 30
    TabOrder = 1
    OnClick = lbSuggestionsClick
  end
  object ReplaceEdit: TEdit
    Left = 11
    Top = 108
    Width = 420
    Height = 32
    TabOrder = 2
  end
  object Ignore: TBitBtn
    Left = 468
    Top = 11
    Width = 119
    Height = 39
    Kind = bkIgnore
    NumGlyphs = 2
    TabOrder = 3
    OnClick = IgnoreClick
  end
  object Change: TBitBtn
    Left = 468
    Top = 59
    Width = 119
    Height = 40
    Caption = '&Change'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 4
    OnClick = ChangeClick
  end
  object Cancel: TBitBtn
    Left = 468
    Top = 108
    Width = 119
    Height = 39
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 5
  end
end
