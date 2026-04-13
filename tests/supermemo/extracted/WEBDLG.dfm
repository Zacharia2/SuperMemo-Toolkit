object WebDlg: TWebDlg
  Left = 411
  Top = 225
  HelpContext = 38
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Web articles available'
  ClientHeight = 1032
  ClientWidth = 2019
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  PopupMenu = PopupMenu1
  Position = poDesigned
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 24
  object Panel1: TPanel
    Left = 0
    Top = 528
    Width = 2019
    Height = 504
    Align = alBottom
    TabOrder = 0
    object ConceptGroupLabel: TLabel
      Left = 888
      Top = 36
      Width = 126
      Height = 24
      Hint = 
        'Concept whose hook will be used to import the articles, images, ' +
        'videos, etc.'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Concept &group'
      FocusControl = ConceptEdit
    end
    object MaxPriorityButton: TSpeedButton
      Left = 1070
      Top = 396
      Width = 52
      Height = 53
      OnClick = MaxPriorityButtonClick
    end
    object Label2: TLabel
      Left = 888
      Top = 351
      Width = 143
      Height = 24
      Hint = 'Maximum priority of automatically imported articles (in %)'
      Caption = 'Ma&ximum priority'
      FocusControl = MaxPriorEdit
    end
    object MinPriorityButton: TSpeedButton
      Left = 1070
      Top = 284
      Width = 52
      Height = 52
      OnClick = MinPriorityButtonClick
    end
    object Label1: TLabel
      Left = 888
      Top = 240
      Width = 138
      Height = 24
      Hint = 'Minimum priority of automatically imported articles (in %)'
      Caption = '&Minimum priority'
      FocusControl = MinPriorEdit
    end
    object ImportMode: TRadioGroup
      Left = 18
      Top = 8
      Width = 492
      Height = 460
      Hint = 
        'Web page import mode determines the way in which pages are impor' +
        'ted from Internet Explorer (click individual modes for more info' +
        ')'
      Caption = 'Web page import mode'
      ItemIndex = 0
      Items.Strings = (
        '&Links only'
        'Page of lin&ks (one element)'
        'L&ocal pages (whole web pages)'
        'Local pages with images'
        'Local images only'
        'Page of images'
        'Live pages')
      TabOrder = 0
      OnClick = ImportModeClick
    end
    object Filter: TRadioGroup
      Left = 540
      Top = 8
      Width = 294
      Height = 238
      Hint = 'Show only a selected subset of pages to import'
      Caption = 'Filter'
      ItemIndex = 0
      Items.Strings = (
        'All'
        'Pictures'
        '&Wikipedia'
        '&YouTube')
      TabOrder = 1
      OnClick = FilterClick
    end
    object IELocation: TRadioGroup
      Left = 537
      Top = 252
      Width = 297
      Height = 218
      Hint = 
        'Import into a single node, or to a concept  group or as a child ' +
        'of the current element'
      Caption = 'Location'
      ItemIndex = 0
      Items.Strings = (
        'New &node'
        'Group hook'
        'Chil&d')
      TabOrder = 2
      OnClick = IELocationClick
    end
    object ConceptEdit: TEdit
      Left = 888
      Top = 101
      Width = 794
      Height = 32
      Hint = 
        'Concept whose hook will be used to import the articles, images, ' +
        'videos, etc.'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ReadOnly = True
      TabOrder = 3
      OnClick = ConceptEditClick
      OnEnter = ConceptEditEnter
    end
    object MaxPriorEdit: TEdit
      Left = 888
      Top = 396
      Width = 182
      Height = 32
      Hint = 
        'Maximum priority of automatically imported articles (in %)(add "' +
        'p" to specify position)'
      TabOrder = 5
    end
    object MinPriorEdit: TEdit
      Left = 882
      Top = 284
      Width = 182
      Height = 32
      Hint = 
        'Minimum priority of automatically imported articles (in %)(add "' +
        'p" to specify position)'
      TabOrder = 4
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 2019
    Height = 47
    Align = alTop
    TabOrder = 1
    object TitleLabel: TLabel
      Left = 1
      Top = 1
      Width = 65
      Height = 45
      Align = alLeft
      Caption = '   &Title   '
      FocusControl = TitleEdit
      ExplicitHeight = 24
    end
    object TitleEdit: TEdit
      Left = 66
      Top = 1
      Width = 1952
      Height = 45
      Align = alClient
      TabOrder = 0
      Text = 'Web import'
      ExplicitHeight = 32
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 91
    Width = 2019
    Height = 437
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ActivePage = ArticleListTab
    Align = alClient
    TabOrder = 2
    object ArticleListTab: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Article list'
      object ListBox1: TCheckListBox
        Left = 0
        Top = 0
        Width = 2011
        Height = 398
        Hint = 'List of articles opened in Internet Explorer'
        Align = alClient
        ItemHeight = 26
        TabOrder = 0
        OnClickCheck = ListBox1ClickCheck
        OnDblClick = ListBox1DblClick
        OnKeyDown = ListBox1KeyDown
        OnKeyPress = ListBox1KeyPress
        OnMouseDown = ListBox1MouseDown
        OnMouseMove = ListBox1MouseMove
      end
    end
    object PicturesTab: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Picture parameters'
      ImageIndex = 1
      object MaxPicsLabel: TLabel
        Left = 32
        Top = 111
        Width = 154
        Height = 24
        Hint = 
          'Maximum number of pictures per web page that can be imported to ' +
          'a single element'
        Caption = 'Maximum pictures'
      end
      object MinSizeLabel: TLabel
        Left = 20
        Top = 17
        Width = 136
        Height = 24
        Hint = 'Minimum size of pictures that are not to be ignored (in bytes)'
        Caption = 'Min. picture size'
      end
      object ImageLocation: TRadioGroup
        Left = 587
        Top = 30
        Width = 477
        Height = 296
        Caption = 'Location (page of images)'
        Items.Strings = (
          'Current &element'
          '&Group hook'
          'Chil&d')
        TabOrder = 0
        Visible = False
        OnClick = ImageLocationClick
      end
      object MinSizeEdit: TEdit
        Left = 20
        Top = 57
        Width = 498
        Height = 32
        Hint = 'Minimum size of pictures that are not to be ignored (in bytes)'
        Enabled = False
        TabOrder = 1
      end
      object MaxPicsEdit: TEdit
        Left = 20
        Top = 153
        Width = 498
        Height = 32
        Hint = 
          'Maximum number of pictures per web page that can be imported to ' +
          'a single element'
        Enabled = False
        TabOrder = 2
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 47
    Width = 2019
    Height = 44
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ButtonHeight = 30
    ButtonWidth = 114
    Caption = 'ToolBar1'
    Images = AboutBox.ImageList1
    List = True
    ShowCaptions = True
    AllowTextButtons = True
    TabOrder = 3
    object ImportPages: TToolButton
      Left = 0
      Top = 0
      Hint = 'Import the list of checked articles from Internet Explorer'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Import'
      ImageIndex = 141
      Style = tbsTextButton
      OnClick = ImportPagesClick
    end
    object CheckAll: TToolButton
      Left = 83
      Top = 0
      Hint = 'Check all boxes on the article import list'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Check &all'
      ImageIndex = 110
      Style = tbsTextButton
      OnClick = CheckAllClick
    end
    object SiftBtn: TToolButton
      Left = 191
      Top = 0
      Hint = 
        'Close all articles that are duplicated in the collection or whic' +
        'h are opened in duplicate'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Sift'
      ImageIndex = 182
      Style = tbsTextButton
      OnClick = SiftBtnClick
    end
    object BrowseDuplicates: TToolButton
      Left = 246
      Top = 0
      Hint = 'View article duplicates in SuperMemo browser'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Duplicates'
      ImageIndex = 148
      Style = tbsTextButton
      OnClick = BrowseDuplicatesClick
    end
    object View: TToolButton
      Left = 364
      Top = 0
      Hint = 
        'View the duplicate copy of the article (if any) or the article i' +
        'tself'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'View'
      ImageIndex = 23
      Style = tbsTextButton
      OnClick = ViewClick
    end
    object HelpBtn: TToolButton
      Left = 437
      Top = 0
      Hint = 'Open the help page with the description of import options'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ImageIndex = 68
      OnClick = HelpBtnClick
    end
    object CloseBox: TCheckBox
      Left = 461
      Top = 0
      Width = 236
      Height = 30
      Hint = 
        'Close all instances of Internet Explorer once their links or con' +
        'tent have been imported to SuperMemo'
      Caption = '&Close browser'
      TabOrder = 0
    end
    object CreateConceptBox: TCheckBox
      Left = 697
      Top = 0
      Width = 180
      Height = 30
      Hint = 'Create a concept on the import node'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      Caption = 'Create concept'
      TabOrder = 1
      OnClick = CreateConceptBoxClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 204
    Top = 228
    object MIScan: TMenuItem
      Caption = '&Uncheck duplicates'
      Hint = 'Scan URLs for duplicates and uncheck them'
      OnClick = MIUncheckDuplicates
    end
    object MIUncheckSelected: TMenuItem
      Caption = 'Uncheck selected'
      Hint = 
        'Uncheck articles that include selections (e.g. to import other a' +
        'rticles as links-only)'
      OnClick = MIUncheckSelectedClick
    end
    object MISwap: TMenuItem
      Caption = 'Swap checked'
      Hint = 'Swap checked articles on the list'
      OnClick = MISwapClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Checkall1: TMenuItem
      Caption = 'Check all'
      ShortCut = 16449
      OnClick = Checkall1Click
    end
    object MICheckDuplicates: TMenuItem
      Caption = 'Check duplicates'
      Hint = 
        'Check articles that have already been imported (e.g. in order to' +
        ' close them)'
      OnClick = MICheckDuplicatesClick
    end
    object MICheckSelected: TMenuItem
      Caption = 'Check selected'
      Hint = 
        'Check articles whose text selections are not empty (e.g. to impo' +
        'rt them)'
      OnClick = MICheckSelectedClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MICloseDuplicates: TMenuItem
      Caption = 'Close duplicates'
      Hint = 
        'Scan URLs for duplicates and close browsers with duplicate artic' +
        'les'
      OnClick = MICloseDuplicatesClick
    end
    object MICloseChecked: TMenuItem
      Caption = 'Close checked'
      Hint = 'Close browsers with checked articles'
      OnClick = MICloseCheckedClick
    end
    object MICloseUnselected: TMenuItem
      Caption = 'Close unchecked'
      Hint = 'Close browsers with unchecked articles'
      OnClick = MICloseUnselectedClick
    end
    object MICloseCurrent: TMenuItem
      Caption = 'Close current'
      Hint = 'Close the currently selected article'
      OnClick = MICloseCurrentClick
    end
    object CloseAll1: TMenuItem
      Caption = 'Close all'
      Hint = 'Close all instances of Internet Explorer'
      OnClick = CloseAll1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MIBrowseDuplicates: TMenuItem
      Caption = 'Browse duplicates'
      Hint = 
        'Open a browser with all elements that are duplicates of the page' +
        's on the import list'
      ShortCut = 24642
      OnClick = MIBrowseDuplicatesClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object InvChangeTab1: TMenuItem
      Caption = 'Change Tab'
      ShortCut = 16393
      OnClick = InvChangeTab1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MIClose: TMenuItem
      Caption = '&Close'
      Hint = 'Close the web import dialog'
      ShortCut = 27
      OnClick = MICloseClick
    end
  end
end
