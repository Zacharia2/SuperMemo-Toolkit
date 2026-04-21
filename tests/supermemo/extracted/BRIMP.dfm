object BrImp: TBrImp
  Left = 0
  Top = 0
  HelpContext = 38
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  HorzScrollBar.Tracking = True
  VertScrollBar.Tracking = True
  BorderIcons = [biSystemMenu, biMaximize, biHelp]
  Caption = 'Web Import'
  ClientHeight = 1415
  ClientWidth = 2774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  PopupMenu = PopUpMenu
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnHelp = FormHelp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 21
  object SideSplitter: TSplitter
    Left = 1719
    Top = 250
    Width = 5
    Height = 1165
    Align = alRight
    ExplicitLeft = 2317
    ExplicitTop = 230
    ExplicitHeight = 1185
  end
  object GridSplitter: TSplitter
    Left = 1714
    Top = 250
    Width = 5
    Height = 1165
    Align = alRight
    ExplicitLeft = 1762
    ExplicitTop = 230
    ExplicitHeight = 1185
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 2774
    Height = 90
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 45
    ButtonWidth = 71
    Caption = 'ToolBar'
    Images = AboutBox.VirtualImageList32
    TabOrder = 0
    object SetLinksBtn: TToolButton
      Left = 0
      Top = 0
      Hint = 'Set the import mode to Link in selected tabs'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'SetLinksBtn'
      ImageIndex = 246
      ImageName = 'icon_246'
      OnClick = SetLinksBtnClick
    end
    object SetSelModeBtn: TToolButton
      Left = 71
      Top = 0
      Hint = 'Set the import mode to Text Selection in checked tabs'
      AutoSize = True
      Caption = 'SetSelModeBtn'
      ImageIndex = 217
      ImageName = 'icon_217'
      OnClick = SetSelModeBtnClick
    end
    object SetTextMode: TToolButton
      Left = 142
      Top = 0
      Hint = 'Set the import mode to Text in selected tabs'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'SetTextMode'
      ImageIndex = 6
      ImageName = 'icon_006'
      OnClick = SetTextModeClick
    end
    object SetHTMBtn: TToolButton
      Left = 213
      Top = 0
      Hint = 'Set the import mode to HTML in selected tabs'
      AutoSize = True
      Caption = 'SetHTMBtn'
      ImageIndex = 149
      ImageName = 'icon_149'
      OnClick = SetHTMBtnClick
    end
    object ParseBtn: TToolButton
      Left = 284
      Top = 0
      Hint = 'Set the import mode to Parsed HTML in selected tabs'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ParseBtn'
      ImageIndex = 218
      ImageName = 'icon_218'
      OnClick = ParseClick
    end
    object ScreenShotBtn: TToolButton
      Left = 355
      Top = 0
      Hint = 
        'Set the import mode to Screen to import screenshots of selected ' +
        'tabs'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ScreenShotBtn'
      ImageIndex = 30
      ImageName = 'icon_030'
      OnClick = ScreenShotBtnClick
    end
    object ToolButton5: TToolButton
      Left = 426
      Top = 0
      Width = 10
      Caption = 'ToolButton5'
      ImageIndex = 31
      ImageName = 'icon_031'
      Style = tbsSeparator
    end
    object IgnoreAllBtn: TToolButton
      Left = 436
      Top = 0
      Hint = 'Mark all selected import tabs as "ignore" '
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'IgnoreAllBtn'
      ImageIndex = 22
      ImageName = 'icon_022'
      OnClick = IgnoreAllBtnClick
    end
    object KeepBrowsersBtn: TToolButton
      Left = 507
      Top = 0
      Hint = 'Mark all selected import tabs as "keep"'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'KeepBrowsersBtn'
      ImageIndex = 84
      ImageName = 'icon_084'
      OnClick = KeepBrowsersBtnClick
    end
    object CloseAllBtn: TToolButton
      Left = 578
      Top = 0
      Hint = 'Set all selected import tabs to "to be closed"'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'CloseAllBtn'
      ImageIndex = 16
      ImageName = 'icon_016'
      OnClick = CloseAllBtnClick
    end
    object ToolButton1: TToolButton
      Left = 649
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton1'
      ImageIndex = 183
      ImageName = 'icon_183'
      Style = tbsSeparator
    end
    object FilterDuplicatesBtn: TToolButton
      Left = 661
      Top = 0
      Hint = 
        'Remove from the list all tabs that are duplicates of articles in' +
        ' the collection (or import duplicates)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'FilterDuplicatesBtn'
      ImageIndex = 182
      ImageName = 'icon_182'
      OnClick = FilterDuplicatesBtnClick
    end
    object BrowseDuplicatesBtn: TToolButton
      Left = 732
      Top = 0
      Hint = 
        'Browse elements that are duplicates of documents on the import l' +
        'ist'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'BrowseDuplicatesBtn'
      ImageIndex = 186
      ImageName = 'icon_186'
      OnClick = BrowseDuplicatesBtnClick
    end
    object ToolButton3: TToolButton
      Left = 803
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton3'
      ImageIndex = 183
      ImageName = 'icon_183'
      Style = tbsSeparator
    end
    object GenerateTitleBtn: TToolButton
      Left = 815
      Top = 0
      Hint = 
        'Generate the title of the node from the titles of documents to b' +
        'e imported'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'GenerateTitleBtn'
      ImageIndex = 36
      ImageName = 'icon_036'
      OnClick = GenerateTitleBtnClick
    end
    object SourcesPanel: TPanel
      Left = 886
      Top = 0
      Width = 195
      Height = 90
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '   Sources:'
      TabOrder = 0
      DoubleBuffered = True
    end
    object WikiBtn: TToolButton
      Left = 1081
      Top = 0
      Hint = 'Check for import all tabs that contain Wikipedia articles'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'WikiBtn'
      ImageIndex = 258
      ImageName = 'Wikipedia'
      OnClick = WikiBtnClick
    end
    object YouTubeBtn: TToolButton
      Left = 1152
      Top = 0
      Hint = 'Check for import all tabs that display YouTube videos'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'YouTubeBtn'
      ImageIndex = 191
      ImageName = 'icon_191'
      OnClick = YouTubeBtnClick
    end
    object ImgBtn: TToolButton
      Left = 1223
      Top = 0
      Hint = 'Check for import all tabs that contain pictures'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ImgBtn'
      ImageIndex = 195
      ImageName = 'icon_195'
      OnClick = ImgBtnClick
    end
    object PDFBtn: TToolButton
      Left = 1294
      Top = 0
      Hint = 'Check for import all tabs that contain PDF documents'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'PDFBtn'
      ImageIndex = 19
      ImageName = 'icon_019'
      OnClick = PDFBtnClick
    end
    object SMButton: TToolButton
      Left = 1365
      Top = 0
      Hint = 
        'Check for import all SuperMemo wiki documents (Help, SuperMemope' +
        'dia, Guru, etc.)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'SMButton'
      ImageIndex = 215
      ImageName = 'icon_215'
      OnClick = SMButtonClick
    end
  end
  object HeaderPanel: TPanel
    Left = 0
    Top = 90
    Width = 2774
    Height = 160
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      2774
      160)
    object Label3: TLabel
      Left = 30
      Top = 40
      Width = 33
      Height = 21
      Hint = 'Title of the new import node in SuperMemo'
      Caption = '&Title'
      FocusControl = TitleEdit
    end
    object ConceptGroupLabel: TLabel
      Left = 30
      Top = 100
      Width = 107
      Height = 21
      Hint = 
        'Concept whose hook will be used to import the articles, images, ' +
        'videos, etc.'
      Caption = 'Concept &group'
      FocusControl = ConceptEdit
    end
    object TitleEdit: TEdit
      Left = 294
      Top = 36
      Width = 1900
      Height = 29
      Hint = 'Title of the new import node in SuperMemo'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'Web import'
    end
    object ConceptEdit: TEdit
      Left = 294
      Top = 96
      Width = 756
      Height = 29
      Hint = 
        'Concept whose hook will be used to import the articles, images, ' +
        'videos, etc.'
      ReadOnly = True
      TabOrder = 1
      OnClick = ConceptEditClick
      OnEnter = ConceptEditEnter
    end
  end
  object RightPanel: TPanel
    Left = 2324
    Top = 250
    Width = 450
    Height = 1165
    Align = alRight
    BevelOuter = bvNone
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 2
    object ImportBtn: TBitBtn
      AlignWithMargins = True
      Left = 13
      Top = 13
      Width = 424
      Height = 80
      Hint = 'Import selected browser tabs to SuperMemo'
      Align = alTop
      Caption = '&Import'
      Enabled = False
      TabOrder = 0
      OnClick = ImportBtnClick
    end
    object HelpBtn: TButton
      AlignWithMargins = True
      Left = 13
      Top = 99
      Width = 424
      Height = 60
      Hint = 'Open the help page that describes the web import dialog box'
      Align = alTop
      Caption = '&Help'
      TabOrder = 1
      OnClick = HelpBtnClick
    end
    object ImportLocation: TRadioGroup
      AlignWithMargins = True
      Left = 13
      Top = 165
      Width = 424
      Height = 200
      Hint = 
        'Import into a single node, or to a concept group, or as a child ' +
        'of the current element'
      Align = alTop
      Caption = 'Location'
      ItemIndex = 0
      Items.Strings = (
        'New &node'
        'Group hook'
        'Chil&d')
      TabOrder = 2
      OnClick = ImportLocationClick
    end
    object PriorityGroup: TGroupBox
      AlignWithMargins = True
      Left = 13
      Top = 371
      Width = 424
      Height = 300
      Hint = 'Determine the priority of imported elements'
      Align = alTop
      Caption = 'Priority'
      TabOrder = 3
      object Label1: TLabel
        Left = 20
        Top = 45
        Width = 124
        Height = 21
        Hint = 
          'Minimum priority of automatically imported articles (in %)(add "' +
          'p" to specify position)'
        Caption = '&Minimum priority'
        FocusControl = MinPriorEdit
      end
      object Label2: TLabel
        Left = 20
        Top = 160
        Width = 128
        Height = 21
        Hint = 
          'Maximum priority of automatically imported articles (in %)(add "' +
          'p" to specify position)'
        Caption = 'Ma&ximum priority'
        FocusControl = MaxPriorEdit
      end
      object MinPriorEdit: TEdit
        Left = 20
        Top = 85
        Width = 200
        Height = 29
        Hint = 
          'Minimum priority of automatically imported articles (in %)(add "' +
          'p" to specify position)'
        TabOrder = 0
      end
      object MaxPriorEdit: TEdit
        Left = 20
        Top = 200
        Width = 200
        Height = 29
        Hint = 
          'Maximum priority of automatically imported articles (in %)(add "' +
          'p" to specify position)'
        TabOrder = 1
      end
    end
    object CreateConceptBox: TCheckBox
      AlignWithMargins = True
      Left = 13
      Top = 677
      Width = 424
      Height = 45
      Hint = 'Convert the import node to a new concept'
      Align = alTop
      Caption = 'Create concept'
      TabOrder = 4
      OnClick = CreateConceptBoxClick
    end
    object RememberSettingsBox: TCheckBox
      AlignWithMargins = True
      Left = 13
      Top = 728
      Width = 424
      Height = 45
      Hint = 'Reuse settings such as priorities in future imports'
      Align = alTop
      Caption = 'Remember settings'
      TabOrder = 5
    end
    object ImageLocation: TRadioGroup
      Left = 15
      Top = 800
      Width = 420
      Height = 250
      Hint = 
        'Import into a single node, or to a concept  group or as a child ' +
        'of the current element'
      Caption = 'Location (page of images)'
      Items.Strings = (
        'Current &element'
        '&Group hook'
        'Chil&d')
      TabOrder = 6
      Visible = False
    end
    object AutoPlayBtn: TButton
      Left = 24
      Top = 1068
      Width = 397
      Height = 49
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Auto-Play (YouTube)'
      TabOrder = 7
      OnClick = AutoPlayBtnClick
    end
  end
  object TheMemo: TMemo
    Left = 1724
    Top = 250
    Width = 600
    Height = 1165
    Hint = 'Text preview for documents that make text preview accessible'
    Align = alRight
    Lines.Strings = (
      'Text preview')
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 250
    Width = 1714
    Height = 1165
    Hint = 
      'List of documents recognized as importable from supported web br' +
      'owsers'
    Align = alClient
    Color = clWhite
    DefaultColWidth = 500
    DefaultRowHeight = 36
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 4
    OnDrawCell = StringGrid1DrawCell
    OnKeyDown = StringGrid1KeyDown
    OnMouseDown = StringGrid1MouseDown
    OnMouseWheelDown = StringGrid1MouseWheelDown
    OnMouseWheelUp = StringGrid1MouseWheelUp
  end
  object CollectBtn: TBitBtn
    Left = 1200
    Top = 140
    Width = 300
    Height = 75
    Caption = 'Collect'
    TabOrder = 5
    Visible = False
    OnClick = CollectBtnClick
  end
  object PopUpMenu: TPopupMenu
    Images = AboutBox.VirtualImageList16
    Left = 156
    Top = 528
    object MIText: TMenuItem
      Caption = 'Text'
      Hint = 'Turn on the plain text import mode for the tab'
      ImageIndex = 6
      ImageName = 'icon_006'
      ShortCut = 16468
      OnClick = MITextClick
    end
    object Link1: TMenuItem
      Caption = 'Link'
      Hint = 'Turn on the link import mode for the tab'
      ImageIndex = 246
      ImageName = 'icon_246'
      ShortCut = 16460
      OnClick = Link1Click
    end
    object HTML1: TMenuItem
      Caption = 'HTML'
      Hint = 'Turn on the full HTML import mode for the tab'
      ImageIndex = 149
      ImageName = 'icon_149'
      ShortCut = 16456
      OnClick = HTML1Click
    end
    object Parse1: TMenuItem
      Caption = 'Parse'
      Hint = 
        'Turn on the parsed import mode for the tab (text filtered by Zan' +
        'der Parser)'
      ImageIndex = 218
      ImageName = 'icon_218'
      ShortCut = 16464
      OnClick = Parse1Click
    end
    object Images1: TMenuItem
      Caption = 'Images'
      Hint = 'Attempt to import the document as image'
      ImageIndex = 195
      ImageName = 'icon_195'
      OnClick = Images1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Ignore1: TMenuItem
      Caption = 'Ignore'
      Hint = 'Do not import the tab to SuperMemo'
      ImageIndex = 22
      ImageName = 'icon_022'
      OnClick = Ignore1Click
    end
    object MIKeep: TMenuItem
      Caption = 'Keep'
      Hint = 'Do not close the browser with the selected document'
      ImageIndex = 78
      ImageName = 'icon_078'
      OnClick = MIKeepClick
    end
    object MICloseBrowser: TMenuItem
      Caption = 'Close'
      Hint = 
        'Close the browser with the selected document at the end of impor' +
        'ts'
      ImageIndex = 16
      ImageName = 'icon_016'
      ShortCut = 32835
      OnClick = MICloseBrowserClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object MIView: TMenuItem
      Caption = '&View'
      Hint = 
        'View the tab in the browser (double click) or view the element w' +
        'ith a copy of the content (Ctrl+double click)'
      OnClick = MIViewClick
    end
    object MIViewInBrowser: TMenuItem
      Caption = '&View in the browser'
      Hint = 'View the current tab in the web browser (same as double click)'
      ImageIndex = 23
      ImageName = 'icon_023'
      OnClick = MIViewInBrowserClick
    end
    object ViewinSuperMemo1: TMenuItem
      Caption = '&View in SuperMemo'
      Hint = 
        'View the selected tab of the duplicate element in SuperMemo (sam' +
        'e as Ctrl+double-click)'
      OnClick = ViewinSuperMemo1Click
    end
    object MISelectall: TMenuItem
      Caption = 'Select all'
      Hint = 'Select all tabs for import'
      ShortCut = 16449
      OnClick = MISelectallClick
    end
    object MIDelete: TMenuItem
      Caption = 'Delete'
      Hint = 'Delete the row and close the tab'
      ShortCut = 46
      OnClick = MIDeleteClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Filterduplicates1: TMenuItem
      Caption = 'Filter duplicates'
      Hint = 
        'Close and remove tabs with duplicate elements or tabs with dupli' +
        'cate URLs'
      ImageIndex = 182
      ImageName = 'icon_182'
      ShortCut = 16454
      OnClick = Filterduplicates1Click
    end
    object MIUnselectDuplicates: TMenuItem
      Caption = 'Unselect duplicates'
      Hint = 
        'Uncheck all tabs that are duplicates of articles in the collecti' +
        'on'
      OnClick = MIUnselectDuplicatesClick
    end
    object MIBrowseDuplicates: TMenuItem
      Caption = 'Browse duplicates'
      Hint = 
        'Browse elements that are duplicates of documents on the import l' +
        'ist'
      ImageIndex = 186
      ImageName = 'icon_186'
      ShortCut = 24642
      OnClick = MIBrowseDuplicatesClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Import1: TMenuItem
      Caption = 'Import'
      object MIPageOfImages: TMenuItem
        Caption = 'Page of images'
        Hint = 'Import images from selected tabs to the current element'
        ImageIndex = 195
        ImageName = 'icon_195'
        OnClick = MIPageOfImagesClick
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Exist1: TMenuItem
      Caption = 'Exit'
      ShortCut = 27
      OnClick = Exist1Click
    end
    object N5: TMenuItem
      Caption = '-'
      Visible = False
    end
    object InvHome1: TMenuItem
      Caption = 'Inv: Home'
      ShortCut = 36
      Visible = False
      OnClick = InvHome1Click
    end
    object InvEnd1: TMenuItem
      Caption = 'Inv: End'
      ShortCut = 35
      Visible = False
      OnClick = InvEnd1Click
    end
    object InvSelectAll1: TMenuItem
      Caption = 'Inv: Select All'
      ShortCut = 32833
      Visible = False
      OnClick = InvSelectAll1Click
    end
  end
end
