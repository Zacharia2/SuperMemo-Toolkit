object CommanderDlg: TCommanderDlg
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'SuperMemo Commander'
  ClientHeight = 800
  ClientWidth = 1139
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -23
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 28
  object Label1: TLabel
    Left = 26
    Top = 17
    Width = 102
    Height = 28
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = '&Command'
    FocusControl = CommandLine
  end
  object Label2: TLabel
    Left = 453
    Top = 17
    Width = 139
    Height = 28
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'C&ustom name'
    FocusControl = OCommandLine
  end
  object HintArea: TLabel
    AlignWithMargins = True
    Left = 26
    Top = 618
    Width = 1091
    Height = 151
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Alignment = taCenter
    AutoSize = False
    Color = clWindow
    ParentColor = False
    Transparent = True
    WordWrap = True
  end
  object CommandLine: TEdit
    Left = 26
    Top = 62
    Width = 405
    Height = 36
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 0
    OnChange = CommandLineChange
  end
  object OCommandLine: TEdit
    Left = 453
    Top = 62
    Width = 407
    Height = 36
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 1
    OnChange = OCommandLineChange
  end
  object CommandBox: TListBox
    Left = 26
    Top = 107
    Width = 405
    Height = 501
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ItemHeight = 28
    Sorted = True
    TabOrder = 2
    OnClick = CommandBoxClick
  end
  object OCommandBox: TListBox
    Left = 453
    Top = 107
    Width = 407
    Height = 501
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ItemHeight = 28
    Sorted = True
    TabOrder = 3
    OnClick = OCommandBoxClick
  end
  object OK: TButton
    Left = 869
    Top = 60
    Width = 260
    Height = 55
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = OKClick
  end
  object Cancel: TButton
    Left = 867
    Top = 128
    Width = 260
    Height = 55
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = MICloseClick
  end
  object Rename: TButton
    Left = 867
    Top = 197
    Width = 260
    Height = 55
    Hint = 'Rename the command'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = '&Rename'
    TabOrder = 6
    OnClick = RenameClick
  end
  object Button1: TButton
    Left = 870
    Top = 266
    Width = 260
    Height = 55
    Hint = 'Restore the default command set'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Default'
    TabOrder = 7
    OnClick = Button1Click
  end
  object PopupMenu1: TPopupMenu
    Left = 616
    Top = 272
    object Execute1: TMenuItem
      Caption = 'Execute'
      ShortCut = 13
      OnClick = Execute1Click
    end
    object MIClose: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = MICloseClick
    end
    object Up1: TMenuItem
      Caption = 'Inv: Up'
      ShortCut = 38
      Visible = False
      OnClick = Up1Click
    end
    object Down1: TMenuItem
      Caption = 'Inv: Down'
      ShortCut = 40
      Visible = False
      OnClick = Down1Click
    end
    object InvRight1: TMenuItem
      Caption = 'Inv: Right'
      ShortCut = 39
      Visible = False
      OnClick = InvRight1Click
    end
    object InvLeft1: TMenuItem
      Caption = 'Inv: Left'
      ShortCut = 37
      Visible = False
      OnClick = InvLeft1Click
    end
    object InvTab1: TMenuItem
      Caption = 'Inv: Tab'
      ShortCut = 9
      Visible = False
      OnClick = InvTab1Click
    end
  end
end
