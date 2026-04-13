object FileBrowser: TFileBrowser
  Left = 449
  Top = 135
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  ActiveControl = FileBox
  BorderIcons = [biSystemMenu, biMaximize]
  BorderWidth = 4
  Caption = 'Open'
  ClientHeight = 1013
  ClientWidth = 1788
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -23
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMenu = BrowserMenu
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 31
  object Splitter1: TSplitter
    Left = 540
    Top = 105
    Width = 9
    Height = 620
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Color = clBtnFace
    MinSize = 45
    ParentColor = False
    OnMoved = Splitter1Moved
  end
  object Splitter2: TSplitter
    Left = 1257
    Top = 105
    Width = 9
    Height = 620
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alRight
    Color = clBtnFace
    MinSize = 45
    ParentColor = False
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 1788
    Height = 105
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    OnResize = TopPanelResize
    object Label1: TLabel
      Left = 24
      Top = 30
      Width = 58
      Height = 31
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Drive:'
      FocusControl = DriveBox
      Transparent = True
    end
    object SearchLabel: TLabel
      Left = 900
      Top = 30
      Width = 73
      Height = 31
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Search:'
      FocusControl = SearchEdit
      Transparent = True
    end
    object Label3: TLabel
      Left = 0
      Top = 0
      Width = 64
      Height = 31
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Fo&lder'
      FocusControl = DirBox
      Transparent = True
      Visible = False
    end
    object FileLabel: TLabel
      Left = 375
      Top = 30
      Width = 35
      Height = 31
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&File'
      FocusControl = FileBox
      Transparent = True
      Visible = False
    end
    object FindBtn: TSpeedButton
      Left = 1740
      Top = 24
      Width = 42
      Height = 48
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      OnClick = FindBtnClick
    end
    object DriveBox: TDriveComboBox
      Left = 105
      Top = 24
      Width = 750
      Height = 37
      Hint = 'Change drive'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Color = clWhite
      DirList = DirBox
      TabOrder = 0
      OnChange = DriveBoxChange
      OnEnter = DriveBoxEnter
      OnExit = DriveBoxExit
    end
    object SearchEdit: TEdit
      Left = 975
      Top = 24
      Width = 750
      Height = 39
      Hint = 'Search for files'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabOrder = 1
      OnKeyDown = SearchEditKeyDown
    end
  end
  object DirBox: TDirectoryListBox
    Left = 0
    Top = 105
    Width = 540
    Height = 620
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alLeft
    Color = clWhite
    FileList = FileBox
    ItemHeight = 31
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnChange = DirBoxChange
    OnEnter = DirBoxEnter
    OnExit = DirBoxExit
    OnKeyDown = DirBoxKeyDown
  end
  object FileBox: TFileListBox
    Left = 549
    Top = 105
    Width = 708
    Height = 620
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Color = clWhite
    FileEdit = FileNameEdit
    FileType = [ftReadOnly, ftArchive, ftNormal]
    ItemHeight = 31
    MultiSelect = True
    ParentShowHint = False
    ShowGlyphs = True
    ShowHint = False
    TabOrder = 2
    OnChange = FileBoxChange
    OnClick = FileBoxClick
    OnDblClick = OKClick
    OnEnter = FileBoxEnter
    OnExit = FileBoxExit
    OnKeyDown = FileBoxKeyDown
    OnKeyPress = FileBoxKeyPress
    OnMouseDown = FileBoxMouseDown
    OnMouseUp = FileBoxMouseUp
  end
  object ScrollBox1: TScrollBox
    Left = 1266
    Top = 105
    Width = 522
    Height = 620
    Hint = 'Preview window'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alRight
    BorderStyle = bsNone
    Color = clWhite
    ParentColor = False
    TabOrder = 6
    object Image1: TImage
      Left = 14
      Top = 315
      Width = 228
      Height = 119
      Hint = 'Preview window'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Visible = False
    end
    object MediaPanel: TPanel
      Left = 39
      Top = 675
      Width = 357
      Height = 134
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      BevelOuter = bvLowered
      TabOrder = 0
      Visible = False
      object PlayBtn: TSpeedButton
        Left = 122
        Top = 62
        Width = 57
        Height = 57
        Hint = 'Click here to play sound'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          33333333333F3333333333333303333333333333338FF3333333333333003333
          333333333388FF3333333333330003333333333333888FF33333333333000033
          3333333333888833333333333300033333333333338883333333333333003333
          3333333333883333333333333303333333333333338333333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        Visible = False
        OnClick = PlayBtnClick
        OnMouseDown = PlayBtnMouseDown
        OnMouseUp = PlayBtnMouseUp
      end
      object StopBtn: TSpeedButton
        Left = 177
        Top = 62
        Width = 57
        Height = 57
        Hint = 'Click here to stop sound'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          333333333333333333333333333333333333333333FFFFF33333333330000033
          33333333388888F3333333333000003333333333388888F33333333330000033
          33333333388888F3333333333000003333333333388888F33333333330000033
          3333333338888833333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        Visible = False
        OnClick = StopBtnClick
        OnMouseDown = StopBtnMouseDown
        OnMouseUp = StopBtnMouseUp
      end
      object ProgressBar: TProgressBar
        Left = 20
        Top = 20
        Width = 304
        Height = 34
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 0
      end
    end
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 725
    Width = 1788
    Height = 180
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 5
    object FileNameLabel: TLabel
      Left = 24
      Top = 36
      Width = 103
      Height = 31
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'File &name:'
      FocusControl = FileNameEdit
      Transparent = True
    end
    object FileTypeLabel: TLabel
      Left = 24
      Top = 102
      Width = 117
      Height = 31
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'File of &type:'
      FocusControl = FilterBox
      Transparent = True
    end
    object FileNameEdit: TEdit
      Left = 135
      Top = 30
      Width = 1095
      Height = 39
      Hint = 'Enter file name and press Enter'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Color = clWhite
      TabOrder = 0
      Text = '*.*'
      OnEnter = FileNameEditEnter
      OnExit = FileNameEditExit
      OnKeyPress = FileNameEditKeyPress
    end
    object FilterBox: TFilterComboBox
      Left = 135
      Top = 96
      Width = 1095
      Height = 39
      Hint = 'File type filter'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Color = clWhite
      TabOrder = 1
    end
    object OK: TButton
      Left = 1260
      Top = 30
      Width = 240
      Height = 83
      Hint = 'Accept operation'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Open'
      Default = True
      ModalResult = 1
      TabOrder = 2
      OnClick = OKClick
      OnMouseDown = OKMouseDown
      OnMouseUp = OKMouseUp
    end
    object Cancel: TButton
      Left = 1530
      Top = 30
      Width = 240
      Height = 83
      Hint = 'Cancel operation'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 3
      OnClick = CancelClick
      OnMouseDown = CancelMouseDown
      OnMouseUp = CancelMouseUp
    end
  end
  object StatusBar: TPanel
    Left = 0
    Top = 905
    Width = 1788
    Height = 54
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object OptionPanel: TPanel
    Left = 0
    Top = 959
    Width = 1788
    Height = 54
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 4
    Visible = False
    object MediaPlayer1: TMediaPlayer
      Left = 1650
      Top = 6
      Width = 85
      Height = 42
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      VisibleButtons = [btPlay, btPause, btStop]
      DoubleBuffered = True
      Display = ScrollBox1
      Visible = False
      ParentDoubleBuffered = False
      TabOrder = 0
      TabStop = False
    end
  end
  object MediaTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = MediaTimerTimer
    Left = 536
    Top = 376
  end
  object BrowserMenu: TPopupMenu
    AutoPopup = False
    OnPopup = BrowserMenuPopup
    Left = 592
    Top = 376
    object MIPreview: TMenuItem
      Caption = '&Preview'
      Hint = 'Preview the file in the preview window'
      ShortCut = 116
      OnClick = MIPreviewClick
    end
    object MIView: TMenuItem
      Caption = '&View'
      Hint = 'View the selected file'
      ShortCut = 114
      OnClick = MIViewClick
    end
    object Edit1: TMenuItem
      Caption = '&Edit...'
      Hint = 'Edit current file with the associated program'
      ShortCut = 120
      OnClick = Edit1Click
    end
    object MIDelete: TMenuItem
      Caption = 'Delete'
      Hint = 'Delete the selected file or files'
      OnClick = MIDeleteClick
    end
    object MIRename: TMenuItem
      Caption = '&Rename'
      Hint = 'Rename the selected file'
      ShortCut = 32850
      OnClick = MIRenameClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MIPasteFilename: TMenuItem
      Caption = 'Paste'
      Hint = 'Paste the text or the filename if the file is in the clipboard'
      ShortCut = 16470
      OnClick = MIPasteFilenameClick
    end
    object N1: TMenuItem
      Caption = '-'
      Visible = False
    end
    object InvRename: TMenuItem
      Caption = 'Inv: Rename'
      ShortCut = 117
      Visible = False
      OnClick = MIRenameClick
    end
    object InvPaste1: TMenuItem
      Caption = 'Inv: Paste'
      ShortCut = 8237
      Visible = False
    end
  end
end
