object MemForm: TMemForm
  Left = 0
  Top = 0
  Caption = 'Memory status timeline'
  ClientHeight = 584
  ClientWidth = 962
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PaintBox1: TPaintBox
    Left = 0
    Top = 22
    Width = 962
    Height = 562
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    OnPaint = PaintBox1Paint
    ExplicitTop = 17
    ExplicitHeight = 567
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 962
    Height = 22
    AutoSize = True
    Caption = 'ToolBar1'
    Images = AboutBox.ImageList1
    TabOrder = 0
    Visible = False
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = 'ToolButton1'
      ImageIndex = 0
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 0
      Caption = 'ToolButton2'
      ImageIndex = 1
    end
    object ToolButton3: TToolButton
      Left = 46
      Top = 0
      Caption = 'ToolButton3'
      ImageIndex = 2
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 1056
    Top = 168
    object Close1: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = Close1Click
    end
  end
end
