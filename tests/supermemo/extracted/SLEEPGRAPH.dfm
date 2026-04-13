object SleepGraph: TSleepGraph
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Sleep propensity'
  ClientHeight = 335
  ClientWidth = 748
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 748
    Height = 305
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Color = clWhite
    ParentColor = False
    OnMouseMove = PaintBox1MouseMove
    OnPaint = PaintBox1Paint
    ExplicitWidth = 732
    ExplicitHeight = 266
  end
  object BottomPaintBox: TPaintBox
    Left = 0
    Top = 305
    Width = 748
    Height = 30
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    Color = clWhite
    ParentColor = False
    OnPaint = BottomPaintBoxPaint
    ExplicitTop = 266
    ExplicitWidth = 732
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    Top = 264
    object Nextpage1: TMenuItem
      Caption = 'Next day'
      ShortCut = 34
      OnClick = Nextpage1Click
    end
    object Previouspage1: TMenuItem
      Caption = 'Previous day'
      ShortCut = 33
      OnClick = Previouspage1Click
    end
    object MIClose: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = MICloseClick
    end
  end
end
