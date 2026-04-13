object GetIntervalDlg: TGetIntervalDlg
  Left = 506
  Top = 262
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Interval'
  ClientHeight = 810
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -23
  Font.Name = 'MS Reference Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 28
  object Bevel1: TBevel
    Left = 17
    Top = 17
    Width = 801
    Height = 777
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
  end
  object Label1: TLabel
    Left = 48
    Top = 35
    Width = 92
    Height = 28
    Hint = 'Interval in days (from now till the selected date)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = '&Interval'
    FocusControl = IntervalEdit
  end
  object Label2: TLabel
    Left = 48
    Top = 179
    Width = 55
    Height = 28
    Hint = 'Selected date (determined by the length of the interval)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = '&Date'
  end
  object IntervalEdit: TEdit
    Left = 48
    Top = 98
    Width = 278
    Height = 36
    Hint = 'Interval in days (from now till the selected date)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 0
    OnKeyPress = IntervalEditKeyPress
  end
  object OK: TBitBtn
    Left = 600
    Top = 42
    Width = 194
    Height = 68
    Hint = 'Accept the currently selected interval'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = '&OK'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 2
    OnClick = OKClick
  end
  object CancelBtn: TBitBtn
    Left = 599
    Top = 119
    Width = 195
    Height = 67
    Hint = 'Cancel the selection'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = '&Cancel'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object DateEdit: TEdit
    Left = 48
    Top = 242
    Width = 434
    Height = 36
    Hint = 'Selected date (determined by the length of the interval)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 1
    OnKeyPress = DateEditKeyPress
  end
  object Panel1: TPanel
    Left = 48
    Top = 312
    Width = 746
    Height = 470
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 4
    object Calendar: TMonthCalendar
      Left = 2
      Top = 2
      Width = 499
      Height = 391
      Hint = 'Selected date (determined by the length of the interval)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Date = 36315.000000000000000000
      FirstDayOfWeek = dowMonday
      TabOrder = 0
      OnClick = CalendarClick
    end
  end
end
