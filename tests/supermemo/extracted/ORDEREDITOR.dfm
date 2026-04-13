object OrderEditor: TOrderEditor
  Left = 484
  Top = 202
  Hint = 'Drag and drop rows to change the component order'
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Component Order Editor'
  ClientHeight = 370
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'System'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 474
    Height = 312
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Color = clWhite
    ColCount = 3
    DefaultColWidth = 50
    DefaultRowHeight = 18
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowMoving, goAlwaysShowEditor]
    ParentShowHint = False
    ScrollBars = ssNone
    ShowHint = True
    TabOrder = 0
    OnRowMoved = StringGrid1RowMoved
    ExplicitHeight = 313
  end
  object Panel1: TPanel
    Left = 0
    Top = 312
    Width = 474
    Height = 58
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 1
    object OK: TBitBtn
      Left = 5
      Top = 4
      Width = 124
      Height = 39
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&OK'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = OKClick
    end
    object Cancel: TBitBtn
      Left = 133
      Top = 4
      Width = 124
      Height = 39
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&Cancel'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
      OnKeyDown = CancelKeyDown
    end
  end
end
