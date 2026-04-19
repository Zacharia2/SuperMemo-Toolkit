object RegistryForm: TRegistryForm
  Left = 378
  Top = 275
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  ClientHeight = 920
  ClientWidth = 3844
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -23
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  KeyPreview = True
  PopupMenu = PopupMenu1
  Position = poDefault
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnMouseWheel = FormMouseWheel
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 29
  object Splitter1: TSplitter
    Left = 353
    Top = 165
    Width = 9
    Height = 504
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alNone
    Color = clBtnShadow
    MinSize = 3
    ParentColor = False
  end
  object RightPanel: TPanel
    Left = 371
    Top = 188
    Width = 722
    Height = 504
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    OnClick = RightPanelClick
    object Splitter2: TSplitter
      Left = 38
      Top = 303
      Width = 600
      Height = 11
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alNone
      Color = clBtnShadow
      MinSize = 3
      ParentColor = False
    end
    object UserListBox: TCheckListBox
      Left = 14
      Top = 360
      Width = 660
      Height = 95
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ItemHeight = 29
      TabOrder = 0
      OnDblClick = UserListBoxDblClick
      OnKeyDown = UserListBoxKeyDown
      OnKeyUp = UserListBoxKeyUp
      OnMouseUp = UserListBoxMouseUp
    end
  end
  object ButtonPanel: TPanel
    Left = 0
    Top = 836
    Width = 3844
    Height = 84
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    ExplicitTop = 1598
    object Insert: TButton
      Left = 795
      Top = 1
      Width = 159
      Height = 57
      Hint = 'Create a new component linked to the currently selected member'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Insert'
      TabOrder = 2
      TabStop = False
      OnClick = InsertClick
    end
    object Accept: TButton
      Left = 1113
      Top = 1
      Width = 159
      Height = 57
      Hint = 'Link the selected registry member with the requesting source'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Accept'
      TabOrder = 5
      TabStop = False
      OnClick = AcceptClick
    end
    object Rename: TButton
      Left = 636
      Top = 1
      Width = 159
      Height = 57
      Hint = 'Rename the currently selected registry member (Alt+R)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Rename'
      TabOrder = 3
      TabStop = False
      OnClick = RenameClick
    end
    object List: TButton
      Left = 159
      Top = 1
      Width = 159
      Height = 57
      Hint = 
        'Show the list of elements that use the currently selected regist' +
        'ry member'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&List'
      Default = True
      TabOrder = 0
      TabStop = False
      OnClick = ListClick
    end
    object Browse: TButton
      Left = 0
      Top = 1
      Width = 159
      Height = 57
      Hint = 
        'Browse elements that use the selected registry members (or the h' +
        'ighlighted member if none selected)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Browse'
      TabOrder = 1
      TabStop = False
      OnClick = BrowseClick
    end
    object Add: TButton
      Left = 954
      Top = 1
      Width = 159
      Height = 57
      Hint = 'Add a new registry member'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Add'
      TabOrder = 4
      OnClick = AddClick
    end
    object Go: TButton
      Left = 318
      Top = 1
      Width = 159
      Height = 57
      Hint = 
        'Go to the first element or member using the currently selected r' +
        'egistry member'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Go to'
      TabOrder = 6
      OnClick = GoClick
    end
    object Button1: TButton
      Left = 477
      Top = 1
      Width = 159
      Height = 57
      Hint = 'Execute neural review over the selected registry member'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Neural'
      TabOrder = 7
      OnClick = Button1Click
    end
  end
  object PathPanel: TPanel
    Left = 0
    Top = 791
    Width = 3844
    Height = 45
    Hint = 
      'Number of elements using the selected registry member and the pa' +
      'th to the registry object associated with the member (if any)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 1553
    object PathLabel: TPanel
      Left = 571
      Top = 1
      Width = 3272
      Height = 43
      Hint = 'Path to the object associated with the registry in the filespace'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      ParentBackground = False
      TabOrder = 0
    end
    object SlotLabel: TPanel
      Left = 421
      Top = 1
      Width = 150
      Height = 43
      Hint = 'Filespace slot used by the member (if any)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      BevelOuter = bvLowered
      Caption = '0'
      TabOrder = 1
    end
    object PositLabel: TPanel
      Left = 271
      Top = 1
      Width = 150
      Height = 43
      Hint = 'Member'#39's physical position in the registry'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      BevelOuter = bvLowered
      Caption = '0'
      TabOrder = 2
    end
    object UserLabel: TPanel
      Left = 121
      Top = 1
      Width = 150
      Height = 43
      Hint = 'Number of users of the member (enumerated with List)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      BevelOuter = bvLowered
      Caption = '0'
      TabOrder = 3
    end
    object IndexLabel: TPanel
      Left = 1
      Top = 1
      Width = 120
      Height = 43
      Hint = 'Member'#39's current index (i.e. position in sorted registry)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      BevelOuter = bvLowered
      Caption = '0'
      TabOrder = 4
    end
  end
  object ComboPanel: TPanel
    Left = 0
    Top = 112
    Width = 3844
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 3
    DesignSize = (
      3844
      38)
    object ComboBox1: TComboBox
      Left = 576
      Top = 0
      Width = 746
      Height = 37
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoComplete = False
      Anchors = []
      DropDownCount = 21
      TabOrder = 0
      TextHint = '[type the name of a registry member]'
      OnChange = ComboBox1Change
      OnKeyDown = ComboBox1KeyDown
    end
  end
  object MemberPanel: TPanel
    Left = 44
    Top = 210
    Width = 278
    Height = 459
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 4
    object MemberListBox: TCheckListBox
      Left = 57
      Top = 66
      Width = 108
      Height = 302
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ItemHeight = 24
      Style = lbOwnerDrawVariable
      StyleElements = [seClient, seBorder]
      TabOrder = 1
      OnClickCheck = MemberListBoxClickCheck
      OnDblClick = MemberListBoxDblClick
      OnDrawItem = MemberListBoxDrawItem
      OnKeyPress = MemberListBoxKeyPress
      OnKeyUp = MemberListBoxKeyUp
      OnMouseDown = MemberListBoxMouseDown
      OnMouseMove = MemberListBoxMouseMove
      OnMouseUp = MemberListBoxMouseUp
    end
    object ScrollPanel: TPanel
      Left = 204
      Top = 24
      Width = 48
      Height = 383
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabOrder = 0
      OnResize = ScrollPanelResize
      object ScrollBar1: TScrollBar
        Left = 15
        Top = 42
        Width = 20
        Height = 284
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Kind = sbVertical
        PageSize = 0
        TabOrder = 0
        TabStop = False
        OnScroll = ScrollBar1Scroll
      end
    end
  end
  object ToolBar: TToolBar
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 3834
    Height = 102
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    BorderWidth = 0
    ButtonHeight = 38
    ButtonWidth = 108
    Caption = 'ToolBar'
    HideClippedButtons = True
    Images = AboutBox.VirtualImageList32
    List = True
    AllowTextButtons = True
    TabOrder = 5
    StyleElements = []
    Wrapable = False
    object MenuBtn: TToolButton
      Left = 0
      Top = 0
      Hint = 'Open registry menu (Shift+F10)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'MenuBtn'
      ImageIndex = 4
      ImageName = 'icon_004'
      OnClick = PopUpButtonClick
    end
    object ListButton: TToolButton
      Left = 72
      Top = 0
      Hint = 
        'Show the list of elements that use the currently selected regist' +
        'ry member'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'ListButton'
      ImageIndex = 79
      ImageName = 'icon_079'
      OnClick = ListClick
    end
    object GoToBtn: TToolButton
      Left = 144
      Top = 0
      Hint = 
        'Go to the currently selected element on the element list (or fir' +
        'st element if none selected)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'GoToBtn'
      ImageIndex = 70
      ImageName = 'icon_070'
      OnClick = UserListBoxDblClick
    end
    object ViewButton: TToolButton
      Left = 216
      Top = 0
      Hint = 
        'View the currently selected element using the selected registry ' +
        'member (or first element on the list if none selected)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'ViewButton'
      ImageIndex = 23
      ImageName = 'icon_023'
      OnClick = ViewButtonClick
    end
    object GoNeuralBtn: TToolButton
      Left = 288
      Top = 0
      Hint = 'Execute neural review over the selected registry member'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'GoNeuralBtn'
      ImageIndex = 213
      ImageName = 'icon_213'
      OnClick = GoNeuralBtnClick
    end
    object FindButton: TToolButton
      Left = 360
      Top = 0
      Hint = 'Find substrings among registry members (Ctrl+S)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'FindButton'
      ImageIndex = 5
      ImageName = 'icon_005'
      OnClick = MIFindAllClick
    end
    object ReplaceButton: TToolButton
      Left = 432
      Top = 0
      Hint = 'Find and replace text in registry items (Ctrl+R)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'ReplaceButton'
      ImageIndex = 107
      ImageName = 'icon_107'
      OnClick = MIReplaceClick
    end
    object SuperSet: TToolButton
      Left = 504
      Top = 0
      Hint = 'View the superset of the current registry subset'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'SuperSet'
      ImageIndex = 133
      ImageName = 'icon_133'
      OnClick = SuperSetClick
    end
    object SubSet: TToolButton
      Left = 576
      Top = 0
      Hint = 'View the subsequent subset in registry subset hierarchy'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'SubSet'
      ImageIndex = 134
      ImageName = 'icon_134'
      OnClick = SubSetClick
    end
    object CheckBtn: TToolButton
      Left = 648
      Top = 0
      Hint = 'Create a new registry subset from the selected members'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'CheckBtn'
      ImageIndex = 110
      ImageName = 'icon_110'
      OnClick = CheckBtnClick
    end
    object UnCheckBtn: TToolButton
      Left = 720
      Top = 0
      Hint = 'Create a new registry subset from the unselected members'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'UnCheckBtn'
      ImageIndex = 109
      ImageName = 'icon_109'
      OnClick = UnCheckBtnClick
    end
    object RandomButton: TToolButton
      Left = 792
      Top = 0
      Hint = 'Switch to a randomly selected item in the registry (F11)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'RandomButton'
      ImageIndex = 41
      ImageName = 'icon_041'
      OnClick = RandomButtonClick
    end
    object FontButton: TToolButton
      Left = 864
      Top = 0
      Hint = 'Change font in the font registry'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'FontButton'
      ImageIndex = 24
      ImageName = 'icon_024'
      OnClick = FontButtonClick
    end
    object EditButton: TToolButton
      Left = 936
      Top = 0
      Hint = 
        'Edit texts associated with the registry member (e.g. stylesheets' +
        ', HTML, etc.)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'EditButton'
      ImageIndex = 43
      ImageName = 'icon_043'
      OnClick = EditButtonClick
    end
    object SwitchRegistry: TToolButton
      Left = 1008
      Top = 0
      Hint = 
        'Switch to the complementary registry (twin, reference, lexicon, ' +
        'etc.)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'SwitchRegistry'
      ImageIndex = 57
      ImageName = 'icon_057'
      OnClick = SwitchRegistryClick
    end
    object BrowseBtn: TToolButton
      Left = 1080
      Top = 0
      Hint = 'Browse all elements using the currently selected registry subset'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'BrowseBtn'
      ImageIndex = 186
      ImageName = 'icon_186'
      OnClick = BrowseBtnClick
    end
    object ImportBtn: TToolButton
      Left = 1152
      Top = 0
      Hint = 'Import files to registry (e.g. bitmaps, wave files, etc.)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'ImportBtn'
      ImageIndex = 141
      ImageName = 'icon_141'
      OnClick = MIImportFileClick
    end
    object ModeBtn: TToolButton
      Left = 1224
      Top = 0
      Hint = 'Stretch or unstretch images'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'ModeBtn'
      ImageIndex = 143
      ImageName = 'icon_143'
      OnClick = ModeButtonClick
    end
    object SaveBtn: TToolButton
      Left = 1296
      Top = 0
      Hint = 'Save the object file'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'SaveBtn'
      ImageIndex = 51
      ImageName = 'icon_051'
      OnClick = ExportButtonClick
    end
    object MediaPlayer1: TMediaPlayer
      Left = 1368
      Top = 0
      Width = -2
      Height = 90
      Hint = 'Play, pause, rewind, record or save the current sound'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Enabled = False
      VisibleButtons = [btPlay, btPause, btPrev]
      DoubleBuffered = True
      Display = RightPanel
      Visible = False
      ParentDoubleBuffered = False
      TabOrder = 0
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 1154
    Top = 336
  end
  object PopupMenu1: TPopupMenu
    Images = AboutBox.ImageList1
    OnPopup = PopupMenu1Popup
    Left = 1418
    Top = 378
    object MIGoNeural: TMenuItem
      Caption = '&Go neural'
      Hint = 'Begin a neural review of a concept or associated members'
      ImageIndex = 213
      ShortCut = 32846
      OnClick = MIGoNeuralClick
    end
    object MIViewMenu: TMenuItem
      Caption = '&View'
      Hint = 'Options for viewing elements and lists of elements '
      ImageIndex = 23
      object MIListUsers: TMenuItem
        Caption = '&List elements'
        Hint = 'List all elements using the current member'
        OnClick = ListClick
      end
      object MIView: TMenuItem
        Caption = '&View element'
        Hint = 'View the selected element in the element window'
        OnClick = ViewButtonClick
      end
      object MIGoTo: TMenuItem
        Caption = '&Go to element'
        Hint = 
          'Go to the the selected element (or the first element on the list' +
          ')'
        ImageIndex = 70
        OnClick = UserListBoxDblClick
      end
      object MIConceptMap: TMenuItem
        Caption = '&Map'
        Hint = 
          'View the concept or contents map associated with the concept or ' +
          'link'
        Visible = False
      end
      object MIViewReference: TMenuItem
        Caption = '&Reference'
        Hint = 'View the reference associated with the image'
        OnClick = MIViewReferenceClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object MIBrowseCurrent: TMenuItem
        Caption = '&Browse current'
        Hint = 
          'Open a browser with all elements that use the highlighted member' +
          ' of the registry'
        ShortCut = 16450
        OnClick = MIBrowseCurrentClick
      end
      object MIBrowseSelected: TMenuItem
        Caption = 'Browse &selected'
        Hint = 
          'Open a browser with all elements that use any of the selected me' +
          'mbers of the registry'
        ShortCut = 24642
        OnClick = MIBrowseSelectedClick
      end
      object MIBrowseAll: TMenuItem
        Caption = 'Browse &all'
        Hint = 
          'Open a browser with all elements that use any of the members of ' +
          'the entire registry'
        ImageIndex = 186
        OnClick = MIBrowseAllClick
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object MIRandomPick: TMenuItem
        Caption = '&Random pick'
        Hint = 'Choose a new randomly selected item '
        ImageIndex = 41
        ShortCut = 122
        OnClick = RandomButtonClick
      end
      object MISelectPosition: TMenuItem
        Caption = 'Go to position'
        Hint = 'Select a registry member by physical position in the registry'
        ShortCut = 16455
        OnClick = MISelectPositionClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object MIShowPath: TMenuItem
        Caption = 'Path'
        Hint = 'Path to the member'#39's object file(s)'
        OnClick = MIShowPathClick
      end
      object MIPlay: TMenuItem
        Caption = 'Play'
        Enabled = False
        Hint = 'Play the player'
        ShortCut = 16505
        OnClick = MIPlayClick
      end
      object MIUTF8codes: TMenuItem
        Caption = 'Encoding'
        Hint = 'Display UTF-8 codes of the registry member name'
        OnClick = MIUTF8codesClick
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object MIClear: TMenuItem
        Caption = '&Clear'
        Hint = 'Clear the combo box or exit if cleared'
        ShortCut = 27
        OnClick = ClearClick
      end
    end
    object MIEditMenu: TMenuItem
      Caption = '&Edit'
      Hint = 'Editing options'
      ImageIndex = 43
      OnClick = MIEditMenuClick
      object MIPaste: TMenuItem
        Caption = '&Paste'
        Hint = 'Paste object into the registry'
        ImageIndex = 139
        OnClick = MIPasteClick
      end
      object MIPasteOver: TMenuItem
        Caption = '&Paste over'
        Hint = 'Replace the object by pasting in a new version'
        OnClick = MIPasteOverClick
      end
      object MIOverwrite: TMenuItem
        Caption = '&Overwrite file'
        Hint = 'Overwrite the current object file with a new file'
        OnClick = MIOverwriteClick
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object MIEditText: TMenuItem
        Caption = '&Edit text'
        Hint = 'Edit the name of the registry member'
        OnClick = MIEditTextClick
      end
      object MIEditTranslation: TMenuItem
        Caption = 'Edit &translation'
        Hint = 'Edit the translation field (if translation registry exists)'
        OnClick = MIEditTranslationClick
      end
      object MICopyPath: TMenuItem
        Caption = '&Copy path'
        Hint = 
          'Copy the path to the registry member object file to the clipboar' +
          'd'
        OnClick = MICopyPathClick
      end
    end
    object MISearch: TMenuItem
      Caption = '&Search'
      Hint = 
        'Options for search registry for substrings (and replacing string' +
        's)'
      ImageIndex = 5
      object MIFindAll: TMenuItem
        Caption = '&Find texts'
        Hint = 'Find registry members containing a given substring'
        ImageIndex = 5
        ShortCut = 16467
        OnClick = MIFindAllClick
      end
      object MIFindFirst: TMenuItem
        Caption = 'Find first'
        Hint = 
          'Find the first substring occurrence after the currently selected' +
          ' registry member'
        ShortCut = 16454
        OnClick = MIFindFirstClick
      end
      object MIFindNext: TMenuItem
        Caption = 'Find &next'
        Hint = 'Repeat last search'
        ShortCut = 114
        OnClick = MIFindNextClick
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object MIReplace: TMenuItem
        Caption = 'Search and &replace'
        Hint = 'Find text and replace it with another'
        ImageIndex = 107
        ShortCut = 16466
        OnClick = MIReplaceClick
      end
      object MIApplyFilter: TMenuItem
        Caption = '&Apply filter'
        Hint = 'Replace texts in the registry by using a filter file (FLT)'
        ImageIndex = 182
        OnClick = MIApplyFilterClick
      end
    end
    object MIRename: TMenuItem
      Caption = '&Rename'
      Hint = 'Rename the currently selected member'
      ShortCut = 32850
      OnClick = RenameClick
    end
    object MIDeleteMember: TMenuItem
      Caption = '&Delete'
      Hint = 'Delete the currently selected registry member'
      ImageIndex = 16
      OnClick = DeleteClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object MITools: TMenuItem
      Caption = '&Tools'
      Hint = 'Advanced registry tools'
      ImageIndex = 156
      object MIImportFile: TMenuItem
        Caption = '&Import files'
        Hint = 'Import files to registry (e.g. bitmaps, AVI files, etc.)'
        ImageIndex = 141
        OnClick = MIImportFileClick
      end
      object MIImportText: TMenuItem
        Caption = 'Import text'
        Hint = 
          'Import a previously exported text file (e.g. after spellchecking' +
          ')'
        OnClick = MIImportTextClick
      end
      object MIExportFile: TMenuItem
        Caption = 'Export file'
        Hint = 'Export the file associated with the selected member'
        ImageIndex = 51
        OnClick = ExportButtonClick
      end
      object MIExportText: TMenuItem
        Caption = 'Export as text'
        Hint = 'Export registry members into a text file '
        OnClick = MIExportTextClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MISort: TMenuItem
        Caption = 'Sort by frequency'
        Hint = 
          'Sort the registry by member use frequency (most often used membe' +
          'rs first)'
        OnClick = MISortClick
      end
      object MISortSize: TMenuItem
        Caption = 'Sort by size'
        Hint = 'Sort the registry by file size'
        OnClick = MISortSizeClick
      end
      object MISortPriority: TMenuItem
        Caption = 'Sort by priority'
        Hint = 
          'Sort the registry by member priority (members with highest ordin' +
          'al average first)'
        OnClick = MISortPriorityClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object MIExternalize: TMenuItem
        Caption = 'Externalize files'
        Hint = 
          'Export all registry files to secondary storage (i.e. secondary \' +
          'ELEMENTS\ folder)'
        OnClick = MIExternalizeClick
      end
      object MIInternalize: TMenuItem
        Caption = 'Internalize files'
        Hint = 
          'Integrate all external files into the filespace (i.e. primary \E' +
          'LEMENTS\ folder)'
        OnClick = MIInternalizeClick
      end
      object MIRecover: TMenuItem
        Caption = 'Repair'
        Hint = 
          'Reindex registry or recover linked registries (e.g. transcriptio' +
          'n registry)'
        ImageIndex = 0
        OnClick = MIRecoverClick
      end
      object MINormalizeURLs: TMenuItem
        Caption = 'Normalize URLs'
        Enabled = False
        Hint = 
          'Convert all URLs to a normalized form for reliable detection of ' +
          'duplicates'
        Visible = False
        OnClick = MINormalizeURLsClick
      end
      object MIDeleteUnused: TMenuItem
        Caption = 'Delete unused'
        Hint = 'Delete registry members that are not registered in use'
        OnClick = MIDeleteUnusedClick
      end
      object MIComputeSize: TMenuItem
        Caption = 'Size statistics'
        Hint = 
          'Compute the size of texts, files, linked files, HTML objects, et' +
          'c.'
        OnClick = MIComputeSizeClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object MIAddPredefined: TMenuItem
        Caption = 'Add predefined templates'
        Hint = 'Add the set of predefined templates to the template registry'
        OnClick = MIAddPredefinedClick
      end
      object MIAddPrefefinedStyles: TMenuItem
        Caption = 'Add predefined styles'
        Hint = 'Add all styles from the default stylesheets'
        OnClick = MIAddPrefefinedStylesClick
      end
      object MIGenerateCollection: TMenuItem
        Caption = 'Generate elements'
        Hint = 'Insert all registry members into newly created elements'
        OnClick = MIGenerateCollectionClick
      end
      object MIGenerateImageReferences: TMenuItem
        Caption = 'Generate references'
        Hint = 'Generate references from member names that carry reference data'
        OnClick = MIGenerateImageReferencesClick
      end
      object MIDeleteAllMembers: TMenuItem
        Caption = 'Delete all members'
        Enabled = False
        Hint = 'Delete all members from the registry'
        Visible = False
        OnClick = MIDeleteAllMembersClick
      end
    end
    object Selection1: TMenuItem
      Caption = 'Selection'
      Hint = 'Set selection by checking or unchecking member boxes'
      object MISelectAllMembers: TMenuItem
        Caption = '&Select all'
        Hint = 'Check all members as selected'
        OnClick = MISelectAllMembersClick
      end
      object MIUnslectAll: TMenuItem
        Caption = '&Unselect all'
        Hint = 'Uncheck all members as unselected'
        OnClick = MIUnslectAllClick
      end
      object MISwapSelection: TMenuItem
        Caption = 'S&wap selection'
        Hint = 'Swap the registry subset selection'
        OnClick = MISwapSelectionClick
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object MISelectIndexRange: TMenuItem
        Caption = 'Select index range'
        Hint = 'Select member by their index range'
        OnClick = MISelectIndexRangeClick
      end
      object MISelectPositionRange: TMenuItem
        Caption = 'Select position range'
        Hint = 'Select members in a range of registry positions'
        OnClick = MISelectPositionRangeClick
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object MISelectedSubset: TMenuItem
        Caption = '&Extract to subset'
        Hint = 'Display selected registry members in a separate subset'
        ImageIndex = 110
        ShortCut = 24589
        OnClick = MISelectedSubsetClick
      end
    end
    object Subset1: TMenuItem
      Caption = 'Subset'
      object MIPreviousSubset: TMenuItem
        Caption = 'Previous subset'
        Enabled = False
        Hint = 'Open the superset of the current registry subset'
        ShortCut = 32805
        OnClick = SuperSetClick
      end
      object MINextSubset: TMenuItem
        Caption = 'Next subset'
        Hint = 'Move to the next registry subset in the subset hierarchy'
        ShortCut = 32807
        OnClick = SubSetClick
      end
      object MIDeleteSubset: TMenuItem
        Caption = 'Delete subset'
        Hint = 'Delete the currently selected registry subset'
        OnClick = MIDeleteSubsetClick
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object MIMatchToSubset: TMenuItem
        Caption = '&Match to subset'
        Hint = 'Find registry members whose users belong to an element subset'
        OnClick = MIMatchToSubsetClick
      end
      object Selectformat1: TMenuItem
        Caption = 'Select format'
        object MISelectHTML: TMenuItem
          Caption = 'HTML'
          Hint = 'Select subset of texts in HTML format'
          OnClick = MISelectHTMLClick
        end
        object MISelectTXT: TMenuItem
          Caption = 'Text (plain)'
          Hint = 'Select subset of texts in plain text format'
          OnClick = MISelectTXTClick
        end
        object MISelectEML: TMenuItem
          Caption = 'EML'
          Hint = 'Select all EML mail into a registry subset'
          OnClick = MISelectEMLClick
        end
        object MISelectRTF: TMenuItem
          Caption = 'RTF'
          Hint = 'Select subset of texts in RTF format'
          OnClick = MISelectRTFClick
        end
        object N8: TMenuItem
          Caption = '-'
        end
        object MISelectBMP: TMenuItem
          Caption = 'BMP'
          Hint = 'Select subset of images in BMP format'
          OnClick = MISelectBMPClick
        end
        object MISelectJPG: TMenuItem
          Caption = 'JPEG'
          Hint = 'Select subset of images in JPEG format'
          OnClick = MISelectJPGClick
        end
        object MISelectGIF: TMenuItem
          Caption = 'GIF'
          Hint = 'Select subset of images in GIF format'
          OnClick = MISelectGIFClick
        end
        object PNG1: TMenuItem
          Caption = 'PNG'
          Hint = 'Select subset of images in PNG format'
          OnClick = PNG1Click
        end
      end
      object MISelectBySizeRange: TMenuItem
        Caption = 'Size range'
        Hint = 'Select elements in a range of sizes'
        OnClick = MISelectBySizeRangeClick
      end
      object MISelectUntranslated: TMenuItem
        Caption = 'Select untranslated'
        Enabled = False
        Hint = 'Select all text entries that have not been translated'
        OnClick = MISelectUntranslatedClick
      end
    end
    object MIUseStatistics: TMenuItem
      Caption = 'Use statistics'
      Hint = 'Generate a file with the number of users of individual members'
      OnClick = MIUseStatisticsClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object MIClose: TMenuItem
      Caption = '&Close'
      Hint = 'Close the registry window'
      ShortCut = 16499
      OnClick = MICloseClick
    end
    object N1: TMenuItem
      Caption = '-'
      Visible = False
    end
    object InvAdd1: TMenuItem
      Caption = 'Inv: Add'
      ShortCut = 32833
      Visible = False
      OnClick = AddClick
    end
    object InvAdd2: TMenuItem
      Caption = 'Inv: Add'
      ShortCut = 16449
      Visible = False
      OnClick = AddClick
    end
    object InvBrowse1: TMenuItem
      Caption = 'Inv: Browse'
      ShortCut = 32834
      Visible = False
      OnClick = MIBrowseCurrentClick
    end
    object InvPopup1: TMenuItem
      Caption = 'Inv: Popup'
      ShortCut = 32889
      Visible = False
      OnClick = InvPopup1Click
    end
    object InvEdit1: TMenuItem
      Caption = 'Inv: Rename/Edit'
      ShortCut = 16453
      Visible = False
      OnClick = InvEdit1Click
    end
    object InvGoneural1: TMenuItem
      Caption = 'Inv: Go neural'
      ShortCut = 16497
      Visible = False
      OnClick = MIGoNeuralClick
    end
  end
end
