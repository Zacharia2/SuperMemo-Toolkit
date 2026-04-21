object VBrowser: TVBrowser
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Visual Browser'
  ClientHeight = 542
  ClientWidth = 795
  Color = clYellow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  StyleElements = []
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 795
    Height = 542
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
  end
  object Image2: TImage
    Left = 0
    Top = 0
    Width = 795
    Height = 542
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
  end
  object PopupMenu1: TPopupMenu
    Left = 440
    Top = 96
    object MIclose: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = MIcloseClick
    end
  end
end
