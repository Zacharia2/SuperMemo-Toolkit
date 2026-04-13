object TileDlg: TTileDlg
  Left = 0
  Top = 0
  Caption = 'Tile arrangement'
  ClientHeight = 317
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object ComponentsL: TLabel
    Left = 19
    Top = 19
    Width = 100
    Height = 19
    Caption = 'Components: '
  end
  object Label2: TLabel
    Left = 19
    Top = 130
    Width = 44
    Height = 19
    Caption = 'Rows:'
  end
  object Columns: TLabel
    Left = 19
    Top = 229
    Width = 68
    Height = 19
    Caption = 'Columns:'
  end
  object PaintBox1: TPaintBox
    Left = 326
    Top = 9
    Width = 323
    Height = 286
  end
  object SquaresL: TLabel
    Left = 19
    Top = 68
    Width = 81
    Height = 19
    Caption = 'Rectangles:'
  end
  object RowsE: TEdit
    Left = 19
    Top = 166
    Width = 289
    Height = 30
    TabOrder = 0
    OnKeyDown = RowsEKeyDown
    OnKeyPress = RowsEKeyPress
  end
  object ColsE: TEdit
    Left = 19
    Top = 265
    Width = 289
    Height = 30
    TabOrder = 1
    OnKeyDown = ColsEKeyDown
    OnKeyPress = RowsEKeyPress
  end
  object OK: TButton
    Left = 664
    Top = 11
    Width = 122
    Height = 39
    Caption = '&OK'
    TabOrder = 2
    OnClick = OKClick
  end
  object Button2: TButton
    Left = 664
    Top = 56
    Width = 122
    Height = 39
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object PopupMenu1: TPopupMenu
    Left = 544
    Top = 144
    object MIClose: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = MICloseClick
    end
  end
end
