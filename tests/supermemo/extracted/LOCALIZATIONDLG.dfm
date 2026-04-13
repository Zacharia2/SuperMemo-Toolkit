object LocalizationDlg: TLocalizationDlg
  Left = 420
  Top = 147
  Caption = 'Localization table'
  ClientHeight = 376
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 343
    Width = 499
    Height = 33
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 0
    object FontButton: TSpeedButton
      Left = 6
      Top = 3
      Width = 26
      Height = 26
      Hint = 'Font used by translated interface buttons'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Glyph.Data = {
        2E060000424D2E06000000000000360400002800000015000000150000000100
        080000000000F801000000000000000000000001000000010000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
        A400000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
        0707070707070707070707070707070000000707070707070707070707070707
        0707070707070700000007070707070707070707070707070707070707070700
        0000070704040707070707070707070707070707070707000000070704040707
        07070707070707070707070707070700000007070404070707070707070707F8
        01F8070707070700000007070404040707070707070707070107070707070700
        000007070404070707070707070707070107F807070707000000070704040707
        0707070707070707010101070707070000000707040404040707050507070707
        0107F807070707000000070707070707070707F805070707010707F807070700
        000007070707070707070707050707F801010101070707000000070707070707
        0707070705070707070707070707070000000707070707070707070505050707
        0707070707070700000007070707070707070707050707070707070707070700
        00000707070707070707070705F8070707070707070707000000070707070707
        0707070707050507070707070707070000000707070707070707070707070707
        0707070707070700000007070707070707070707070707070707070707070700
        0000070707070707070707070707070707070707070707000000070707070707
        070707070707070707070707070707000000}
      OnClick = FontButtonClick
    end
    object FontName: TLabel
      Left = 40
      Top = 9
      Width = 49
      Height = 16
      Hint = 'Font used by translated interface buttons'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'System'
    end
    object Cancel: TBitBtn
      Left = 422
      Top = 3
      Width = 72
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&Cancel'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
      OnClick = CancelClick
    end
    object OK: TBitBtn
      Left = 358
      Top = 3
      Width = 64
      Height = 27
      Hint = 
        'Save the translation table and update the current SuperMemo inte' +
        'rface'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&OK'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = OKClick
    end
    object Import: TButton
      Left = 230
      Top = 3
      Width = 64
      Height = 27
      Hint = 'Import translation table from a file'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&Import'
      TabOrder = 2
      OnClick = ImportClick
    end
    object Export: TButton
      Left = 166
      Top = 3
      Width = 64
      Height = 27
      Hint = 'Export translation table to a file'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&Export'
      TabOrder = 3
      OnClick = ExportClick
    end
    object Delete: TButton
      Left = 294
      Top = 3
      Width = 64
      Height = 27
      Hint = 'Delete the current translation table'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Cancel = True
      Caption = '&Delete'
      ModalResult = 3
      TabOrder = 4
      OnClick = DeleteClick
    end
  end
  object StringGrid1: TStringGrid
    Left = 13
    Top = 32
    Width = 167
    Height = 218
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ColCount = 1
    FixedCols = 0
    ScrollBars = ssVertical
    TabOrder = 1
    OnSelectCell = StringGrid1SelectCell
    OnTopLeftChanged = StringGrid1TopLeftChanged
  end
  object StringGrid2: TStringGrid
    Left = 192
    Top = 32
    Width = 174
    Height = 218
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ColCount = 1
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ScrollBars = ssVertical
    TabOrder = 2
    OnSelectCell = StringGrid2SelectCell
    OnTopLeftChanged = StringGrid2TopLeftChanged
  end
  object OpenDialog1: TOpenDialog
    Left = 40
    Top = 390
  end
  object SaveDialog1: TSaveDialog
    Left = 8
    Top = 390
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Microsoft YaHei'
    Font.Style = []
    Left = 72
    Top = 392
  end
end
