object MyReplaceDlg: TMyReplaceDlg
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu]
  Caption = 'Replacing texts'
  ClientHeight = 368
  ClientWidth = 1089
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  PopupMenu = PopupMenu1
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 144
  DesignSize = (
    1089
    368)
  TextHeight = 21
  object Label1: TLabel
    Left = 24
    Top = 29
    Width = 79
    Height = 21
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Fin&d what:'
    FocusControl = FindEdit
  end
  object Label2: TLabel
    Left = 24
    Top = 194
    Width = 102
    Height = 21
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Re&place with:'
    FocusControl = ReplaceEdit
  end
  object FindEdit: TEdit
    Left = 12
    Top = 80
    Width = 758
    Height = 29
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object ReplaceEdit: TEdit
    Left = 12
    Top = 242
    Width = 758
    Height = 29
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object FindBtn: TBitBtn
    Left = 798
    Top = 29
    Width = 270
    Height = 67
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Anchors = [akTop, akRight]
    Caption = '&Find'
    TabOrder = 2
    OnClick = FindBtnClick
  end
  object ReplaceBtn: TBitBtn
    Left = 798
    Top = 111
    Width = 270
    Height = 68
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Anchors = [akTop, akRight]
    Caption = '&Replace'
    TabOrder = 3
    OnClick = ReplaceBtnClick
  end
  object ReplaceAllBtn: TBitBtn
    Left = 798
    Top = 194
    Width = 270
    Height = 67
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Anchors = [akTop, akRight]
    Caption = 'Replace &all'
    TabOrder = 4
    OnClick = ReplaceAllBtnClick
  end
  object Cancel: TBitBtn
    Left = 798
    Top = 276
    Width = 270
    Height = 68
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Anchors = [akTop, akRight]
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = CancelClick
  end
  object PopupMenu1: TPopupMenu
    Left = 488
    Top = 192
    object MIEscape: TMenuItem
      Caption = '&Escape'
      Hint = 'Close the dialog'
      ShortCut = 27
      OnClick = MIEscapeClick
    end
  end
end
