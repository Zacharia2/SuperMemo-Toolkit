object TargetDlg: TTargetDlg
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Choose'
  ClientHeight = 606
  ClientWidth = 1458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 29
  object Splitter1: TSplitter
    Left = 210
    Top = 0
    Width = 11
    Height = 534
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Color = clBtnShadow
    MinSize = 45
    ParentColor = False
  end
  object Splitter2: TSplitter
    Left = 887
    Top = 0
    Width = 10
    Height = 534
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Color = clBtnShadow
    MinSize = 45
    ParentColor = False
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 210
    Height = 534
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alLeft
    ItemHeight = 29
    TabOrder = 0
    OnClick = ListBox1Click
    OnDblClick = ListBox1DblClick
  end
  object ListBox2: TListBox
    Left = 221
    Top = 0
    Width = 666
    Height = 534
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabStop = False
    Align = alLeft
    ItemHeight = 29
    TabOrder = 1
    OnClick = ListBox2Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 534
    Width = 1458
    Height = 72
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    TabOrder = 2
    object OK: TBitBtn
      Left = 14
      Top = 12
      Width = 207
      Height = 51
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = OKClick
    end
    object Cancel: TBitBtn
      Left = 665
      Top = 12
      Width = 207
      Height = 51
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 3
    end
    object Add: TBitBtn
      Left = 230
      Top = 12
      Width = 207
      Height = 51
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Add'
      TabOrder = 1
      OnClick = ChooseAnotherClick
    end
    object DelBtn: TBitBtn
      Left = 449
      Top = 12
      Width = 207
      Height = 51
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Delete'
      TabOrder = 2
      OnClick = DeleteTargetClick
    end
    object SearchEdit: TEdit
      Left = 881
      Top = 9
      Width = 541
      Height = 37
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic]
      ParentFont = False
      TabOrder = 4
      Text = 'Ctrl+S for Search'
      StyleElements = [seClient, seBorder]
      OnEnter = SearchEditEnter
      OnKeyPress = SearchEditKeyPress
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 680
    Top = 200
    object MISearch: TMenuItem
      Caption = 'Search'
      ShortCut = 16467
      OnClick = MISearchClick
    end
    object Close1: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = Close1Click
    end
    object InvSearchO1: TMenuItem
      Caption = 'Inv: Search O'
      ShortCut = 16463
      Visible = False
      OnClick = InvSearchO1Click
    end
  end
end
