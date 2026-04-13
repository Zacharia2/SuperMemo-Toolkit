object ThemeTestDlg: TThemeTestDlg
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  ActiveControl = ThemeBox
  Caption = 'Theme testing'
  ClientHeight = 579
  ClientWidth = 953
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 21
  object Label1: TLabel
    Left = 36
    Top = 12
    Width = 408
    Height = 39
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Choose the style you like:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object OKBtn: TButton
    Left = 614
    Top = 12
    Width = 327
    Height = 122
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object StringGrid1: TStringGrid
    Left = 36
    Top = 126
    Width = 554
    Height = 336
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    DefaultColWidth = 96
    DefaultRowHeight = 36
    RowCount = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object RadioGroup1: TRadioGroup
    Left = 614
    Top = 240
    Width = 327
    Height = 222
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Radio Group'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Items.Strings = (
      'Choice 1'
      'Choice 2'
      'Choice 3')
    ParentFont = False
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 36
    Top = 471
    Width = 905
    Height = 96
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Some text to type ...')
    ParentFont = False
    TabOrder = 3
  end
  object ThemeBox: TComboBox
    Left = 36
    Top = 59
    Width = 554
    Height = 32
    Hint = 'Current theme'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Sorted = True
    TabOrder = 4
    Text = 'Theme'
    OnChange = ThemeBoxChange
    OnKeyPress = ThemeBoxKeyPress
  end
  object CancelBtn: TButton
    Left = 614
    Top = 143
    Width = 327
    Height = 75
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = CancelBtnClick
  end
  object PopupMenu1: TPopupMenu
    Left = 352
    Top = 8
    object MIClose: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = MICloseClick
    end
  end
end
