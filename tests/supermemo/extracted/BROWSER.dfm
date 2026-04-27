object Browser: TBrowser
  Left = 468
  Top = 191
  HelpContext = 2
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Browser'
  ClientHeight = 1745
  ClientWidth = 3306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  KeyPreview = True
  PopupMenu = PopupMenu1
  Position = poDefault
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 32
  object ThumbCanvas: TImage
    Left = 666
    Top = 756
    Width = 158
    Height = 158
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Visible = False
    OnDblClick = ThumbCanvasDblClick
    OnMouseDown = ThumbCanvasMouseDown
  end
  object StringGrid1: TStringGrid
    Left = 51
    Top = 282
    Width = 650
    Height = 386
    HelpContext = 2
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Color = clBtnFace
    ColCount = 2
    DefaultColWidth = 96
    DefaultRowHeight = 36
    DrawingStyle = gdsGradient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goDrawFocusSelected, goColSizing, goColMoving, goTabs]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Visible = False
    StyleElements = [seFont, seClient]
    OnColumnMoved = StringGrid1ColumnMoved
    OnDblClick = StringGrid1DblClick
    OnDrawCell = StringGrid1DrawCell
    OnKeyDown = StringGrid1KeyDown
    OnMouseDown = StringGrid1MouseDown
    OnMouseMove = StringGrid1MouseMove
    OnMouseUp = StringGrid1MouseUp
    OnSelectCell = StringGrid1SelectCell
    RowHeights = (
      36
      35
      36
      36
      36)
  end
  object Speedbar: TToolBar
    Left = 0
    Top = 0
    Width = 3306
    Height = 90
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 45
    ButtonWidth = 107
    Images = AboutBox.VirtualImageList24
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Wrapable = False
    object MenuButton: TToolButton
      Left = 0
      Top = 0
      Hint = 'Open browser context menu (Shift+F10)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'MenuButton'
      ImageIndex = 4
      ImageName = 'icon_004'
      OnClick = MenuButtonClick
    end
    object ProcessElementsButton: TToolButton
      Left = 71
      Top = 0
      Hint = 
        'Open a menu with operations for processing all elements in the b' +
        'rowser'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ProcessElementsButton'
      DropdownMenu = Contents.ProcessMenu
      ImageIndex = 47
      ImageName = 'icon_047'
      OnMouseDown = ProcessElementsButtonMouseDown
    end
    object StandardSize: TToolButton
      Left = 142
      Top = 0
      Hint = 
        'Align the browser with the Element and Element data windows for ' +
        'easy browsing'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'StandardSize'
      ImageIndex = 53
      ImageName = 'icon_053'
      OnClick = StandardSizeClick
    end
    object ReviewButton: TToolButton
      Left = 213
      Top = 0
      Hint = 
        'Review all the material in the browser in the presently displaye' +
        'd sequence (Ctrl+Shift+L)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      ImageIndex = 34
      ImageName = 'L-Plate'
      OnClick = ReviewButtonClick
    end
    object ReviewTopics: TToolButton
      Left = 284
      Top = 0
      Hint = 'Review all topics in the browser'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      ImageIndex = 86
      ImageName = 'icon_086'
      OnClick = ReviewTopicsClick
    end
    object AddToOutstanding: TToolButton
      Left = 355
      Top = 0
      Hint = 'Add browsed elements to the outstanding queue'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'AddToOutstanding'
      ImageIndex = 175
      ImageName = 'icon_175'
      OnClick = AddToOutstandingClick
    end
    object GoNeuralBtn: TToolButton
      Left = 426
      Top = 0
      Hint = 
        'Begin neural review using the contents of the browser as the sta' +
        'rting point'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      ImageIndex = 213
      ImageName = 'icon_213'
      OnClick = MIGoNeuralClick
    end
    object ChildSelected: TToolButton
      Left = 497
      Top = 0
      Hint = 'Open a new browser with only selected elements'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ChildSelected'
      ImageIndex = 110
      ImageName = 'icon_110'
      OnClick = ChildSelectedClick
    end
    object ChildUnselected: TToolButton
      Left = 568
      Top = 0
      Hint = 'Open a new browser with only unselected elements '
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ChildUnselected'
      ImageIndex = 109
      ImageName = 'icon_109'
      OnClick = ChildUnselectedClick
    end
    object MemorizedButton: TToolButton
      Left = 639
      Top = 0
      Hint = 'Leave only memorized elements in the browser'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      ImageIndex = 112
      ImageName = 'icon_112'
      OnClick = MemorizedClick
    end
    object ToolButton1: TToolButton
      Left = 710
      Top = 0
      Hint = 'Leave only items in the browser'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      ImageIndex = 104
      ImageName = 'icon_104'
      OnClick = MIChildItemClick
    end
    object TopicsBtn: TToolButton
      Left = 781
      Top = 0
      Hint = 'Leave only topics in the browser'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'TopicsBtn'
      ImageIndex = 103
      ImageName = 'icon_103'
      OnClick = MIChildTopicClick
    end
    object Sources: TToolButton
      Left = 852
      Top = 0
      Hint = 'List sources of the elements in the browser'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'Sources'
      ImageIndex = 12
      ImageName = 'icon_012'
      OnClick = SourcesClick
    end
    object SortBtn: TToolButton
      Left = 923
      Top = 0
      Hint = 'Sort the browser by the order of the knowledge tree'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'SortBtn'
      ImageIndex = 69
      ImageName = 'icon_069'
      OnClick = SortBtnClick
    end
    object SpreadPriorityBtn: TToolButton
      Left = 994
      Top = 0
      Hint = 
        'Spread the priority of elements in the browser in a selected ran' +
        'ge in proportion to current priority'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      ImageIndex = 105
      ImageName = 'icon_105'
      OnClick = SpreadPriorityBtnClick
    end
    object AdvanceTopicsBtn: TToolButton
      Left = 1065
      Top = 0
      Hint = 'Advance topic review'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'AdvanceTopicsBtn'
      ImageIndex = 115
      ImageName = 'icon_115'
      OnClick = AdvanceTopicsBtnClick
    end
    object AdvanceItemsBtn: TToolButton
      Left = 1136
      Top = 0
      Hint = 'Shorten item intervals'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'AdvanceItemsBtn'
      ImageIndex = 114
      ImageName = 'icon_114'
      OnClick = AdvanceItemsBtnClick
    end
    object PostponeBtn: TToolButton
      Left = 1207
      Top = 0
      Hint = 'Delay repetitions'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'PostponeBtn'
      ImageIndex = 95
      ImageName = 'icon_095'
      OnClick = PostponeBtnClick
    end
    object InsertPicture: TToolButton
      Left = 1278
      Top = 0
      Hint = 'Add a picture to all elements in the browser'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'InsertPicture'
      ImageIndex = 108
      ImageName = 'InsertPicture'
      OnClick = InsertPictureClick
    end
    object ToolButton8: TToolButton
      Left = 1349
      Top = 0
      Hint = 'Show browser elements as thumbs (i.e. small pictures)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ToolButton8'
      ImageIndex = 124
      ImageName = 'icon_124'
      OnClick = ToolButton8Click
    end
    object ApplyTemplateBtn: TToolButton
      Left = 1420
      Top = 0
      Hint = 'Apply a template to all elements in the browser'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ApplyTemplateBtn'
      ImageIndex = 113
      ImageName = 'icon_113'
      OnClick = ApplyTemplateBtnClick
    end
    object RandomBtn: TToolButton
      Left = 1491
      Top = 0
      Hint = 'Randomize the content of the browser (Ctrl+Shift+F11)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = '`'
      ImageIndex = 41
      ImageName = 'icon_041'
      OnClick = MIRandomizeClick
    end
    object SaveRepsButton: TToolButton
      Left = 1562
      Top = 0
      Hint = 'Schedule repetition of elements listed in the browser for today'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      ImageIndex = 94
      ImageName = 'icon_094'
      OnClick = MISaveRepetitionsClick
    end
    object FindBtn: TToolButton
      Left = 1633
      Top = 0
      Hint = 'Find text in element titles in the browser (Alt+F and F3)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'FindBtn'
      ImageIndex = 5
      ImageName = 'icon_005'
      OnClick = FindButtonClick
    end
    object GoToBtn: TToolButton
      Left = 1704
      Top = 0
      Hint = 'Go to the currently selected element (Enter or double-click)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'GoToBtn'
      ImageIndex = 23
      ImageName = 'icon_023'
      OnClick = GoToButtonClick
    end
    object SaveSubsetButton: TToolButton
      Left = 1775
      Top = 0
      Hint = 'Save the browser in a subset file'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'SaveSubsetButton'
      ImageIndex = 51
      ImageName = 'icon_051'
      OnClick = SaveSubsetButtonClick
    end
    object Synch: TToolButton
      Left = 1846
      Top = 0
      Hint = 
        'Synchronize the element displayed in the element window with the' +
        ' current selection in the browser'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'Synch'
      ImageIndex = 57
      ImageName = 'icon_057'
      OnClick = SynchClick
    end
    object GoToElWindElement: TToolButton
      Left = 1917
      Top = 0
      Hint = 'Find the element currently displayed in the element window'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'GoToElWindElement'
      ImageIndex = 239
      ImageName = 'Search'
      OnClick = GoToElWindElementClick
    end
  end
  object ScrollBar1: TScrollBar
    Left = 3269
    Top = 90
    Width = 37
    Height = 1655
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alRight
    Kind = sbVertical
    PageSize = 0
    TabOrder = 2
    Visible = False
    OnKeyUp = ScrollBar1KeyUp
    OnMouseLeave = ScrollBar1MouseLeave
    OnScroll = ScrollBar1Scroll
  end
  object PopupMenu1: TPopupMenu
    HelpContext = 14
    Images = AboutBox.VirtualImageList16
    Left = 68
    Top = 516
    object Invisible1: TMenuItem
      Caption = 'Invisible'
      Visible = False
      object InvApplytemplate1: TMenuItem
        Caption = 'Apply template'
        ShortCut = 24653
        Visible = False
        OnClick = InvApplytemplate1Click
      end
      object InvClose: TMenuItem
        Caption = 'Inv: Close'
        ShortCut = 16499
        Visible = False
        OnClick = InvCloseClick
      end
      object InvCommander1: TMenuItem
        Caption = 'Inv: Commander'
        ShortCut = 16397
        Visible = False
        OnClick = InvCommander1Click
      end
      object InvCountBurden1: TMenuItem
        Caption = 'Inv: Count Burden'
        ShortCut = 24642
        Visible = False
        OnClick = InvCountBurden1Click
      end
      object InvDismiss1: TMenuItem
        Caption = 'Inv: Dismiss'
        ShortCut = 16452
        Visible = False
        OnClick = InvDismiss1Click
      end
      object InvDone1: TMenuItem
        Caption = 'Inv: Done'
        ShortCut = 24589
        Visible = False
        OnClick = InvDone1Click
      end
      object InvElParam1: TMenuItem
        Caption = 'Inv: El Param'
        ShortCut = 24656
        Visible = False
        OnClick = InvElParam1Click
      end
      object InvExecuterepetition1: TMenuItem
        Caption = 'Inv: Execute repetition'
        ShortCut = 24658
        Visible = False
        OnClick = InvExecuterepetition1Click
      end
      object InvGoto1: TMenuItem
        Caption = 'Inv: Go to'
        ShortCut = 16455
        Visible = False
        OnClick = InvGoto1Click
      end
      object InvImpose1: TMenuItem
        Caption = 'Inv: Impose'
        ShortCut = 24689
        Visible = False
        OnClick = InvImpose1Click
      end
      object Linkmember1: TMenuItem
        Caption = 'Link member'
        ShortCut = 24651
        OnClick = Linkmember1Click
      end
      object Memorize1: TMenuItem
        Caption = 'Memorize'
        ShortCut = 16461
        OnClick = Memorize1Click
      end
      object Nextcomponent1: TMenuItem
        Caption = 'Next component'
        ShortCut = 16468
        OnClick = Nextcomponent1Click
      end
      object InvPlan1: TMenuItem
        Caption = 'Inv: Plan'
        ShortCut = 16464
        Visible = False
        OnClick = InvPlan1Click
      end
      object InvPostpone1: TMenuItem
        Caption = 'Inv: Postpone'
        Visible = False
        OnClick = InvPostpone1Click
      end
      object InvPriority1: TMenuItem
        Caption = 'Inv: Priority'
        ShortCut = 32848
        Visible = False
        OnClick = InvPriority1Click
      end
      object InvRepetitionhistory1: TMenuItem
        Caption = 'Inv: Repetition history'
        ShortCut = 24648
        Visible = False
        OnClick = InvRepetitionhistory1Click
      end
      object InvReviewall1: TMenuItem
        Caption = 'Inv: Review all'
        ShortCut = 24652
        Visible = False
        OnClick = InvReviewall1Click
      end
      object InvShift1: TMenuItem
        Caption = 'Inv: Shift'
        ShortCut = 24650
        Visible = False
        OnClick = InvShift1Click
      end
      object InvShowAncestors1: TMenuItem
        Caption = 'Inv: Show Ancestors'
        ShortCut = 24664
        OnClick = InvShowAncestors1Click
      end
      object SleepChart1: TMenuItem
        Caption = 'SleepChart'
        ShortCut = 123
        OnClick = SleepChart1Click
      end
      object InvTasklist1: TMenuItem
        Caption = 'Inv: Tasklist'
        ShortCut = 115
        Visible = False
        OnClick = InvTasklist1Click
      end
      object InvTitle1: TMenuItem
        Caption = 'Inv: Title'
        ShortCut = 32852
        Visible = False
        OnClick = InvTitle1Click
      end
      object InvTransfer1: TMenuItem
        Caption = 'Inv: Transfer'
        ShortCut = 24660
        Visible = False
        OnClick = InvTransfer1Click
      end
    end
    object MILearn: TMenuItem
      Caption = '&Learn'
      ImageName = 'icon_034'
      ShortCut = 16460
      OnClick = MILearnClick
    end
    object MIGoNeural: TMenuItem
      Caption = 'Go neural'
      Hint = 
        'Begin neural review using the contents of the browser as the sta' +
        'rting point'
      ImageIndex = 213
      ImageName = 'icon_213'
      ShortCut = 16497
      OnClick = MIGoNeuralClick
    end
    object MIGoTo: TMenuItem
      Caption = '&View'
      Hint = 
        'Display the selected element in the element window (double-click' +
        ')'
      ImageIndex = 23
      ImageName = 'icon_023'
      ShortCut = 13
      OnClick = GoToButtonClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MIChild: TMenuItem
      Caption = '&Child'
      Hint = 'Open a child browser with a subset of elements'
      ImageIndex = 186
      ImageName = 'icon_186'
      object MIChildPriority: TMenuItem
        Caption = '&Priority'
        Hint = 
          'Open a child browser with elements whose priority surpasses a se' +
          'lected value'
        ImageIndex = 138
        ImageName = 'icon_138'
        OnClick = MIChildPriorityClick
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object MISelected: TMenuItem
        Caption = '&Selected'
        Hint = 'Open a child browser with all selected elements'
        ImageIndex = 110
        ImageName = 'icon_110'
        OnClick = MISelectedClick
      end
      object MIUnselected: TMenuItem
        Caption = 'Unselected'
        Hint = 'Open a child browser with all elements that are not selected'
        ImageIndex = 109
        ImageName = 'icon_109'
        OnClick = MIUnselectedClick
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object MIChildSources: TMenuItem
        Caption = '&Sources'
        Hint = 
          'Open a browser with sources of all extracts and clozes in the pr' +
          'esent browser'
        ImageIndex = 12
        ImageName = 'icon_012'
        OnClick = MIChildSourcesClick
      end
      object MIChildArticles: TMenuItem
        Caption = '&Articles'
        Hint = 
          'Open a child browser with top-level topics and tasks (i.e. non-e' +
          'xtract articles)'
        OnClick = MIChildArticlesClick
      end
      object MIExtracts: TMenuItem
        Caption = '&Extracts'
        Hint = 
          'Open a child browser that includes only article extracts (as opp' +
          'osed to top-level articles)'
        ImageIndex = 144
        ImageName = 'icon_144'
        OnClick = MIExtractsClick
      end
      object MIChildDescendants: TMenuItem
        Caption = '&Descendants'
        Hint = 
          'Create a new browser with children and descendants of the elemen' +
          'ts currently held in the browser'
        OnClick = MIChildDescendantsClick
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object MIOutstanding: TMenuItem
        Caption = '&Outstanding'
        Hint = 'Open a child browser that includes only the outstanding elements'
        OnClick = MIOutstandingClick
      end
      object MIMemorized: TMenuItem
        Caption = '&Memorized'
        Hint = 'Open a child browser with elements that have been memorized'
        ImageIndex = 112
        ImageName = 'icon_112'
        OnClick = MemorizedClick
      end
      object MIPending: TMenuItem
        Caption = 'Pending'
        Hint = 'Open a child browser with all pending elements'
        OnClick = MIPendingClick
      end
      object MIDismissed: TMenuItem
        Caption = 'Dismissed'
        Hint = 'Open a child browser with all dismissed elements'
        OnClick = MIDismissedClick
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object MIChildItem: TMenuItem
        Caption = '&Items'
        Hint = 
          'Open a child browser with all topics included in the current bro' +
          'wser'
        ImageName = 'icon_034'
        OnClick = MIChildItemClick
      end
      object MIChildTopic: TMenuItem
        Caption = '&Topics'
        Hint = 
          'Open a child browser with all topics included in the current bro' +
          'wser'
        ImageIndex = 86
        ImageName = 'icon_086'
        OnClick = MIChildTopicClick
      end
      object MIChildTask: TMenuItem
        Caption = 'Tas&ks'
        Hint = 'Open a child browser with tasks only'
        ImageIndex = 151
        ImageName = 'icon_151'
        OnClick = MIChildTaskClick
      end
      object MIChildTasksAndTopics: TMenuItem
        Caption = 'Tasks/Topics'
        Hint = 'Open a child browser with tasks and topics only'
        OnClick = MIChildTasksAndTopicsClick
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object MIChildFilter: TMenuItem
        Caption = '&Filter'
        Hint = 
          'Open a child browser with elements that meet selected filter cri' +
          'teria'
        ImageIndex = 182
        ImageName = 'icon_182'
        OnClick = MIChildFilterClick
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object MIChildBranch: TMenuItem
        Caption = '&Branch'
        Hint = 
          'Open a child browser with only elements belonging to a given bra' +
          'nch in the contents window'
        ImageIndex = 73
        ImageName = 'icon_073'
        OnClick = MIChildBranchClick
      end
    end
    object Select1: TMenuItem
      Caption = 'Select'
      object MISelectElement: TMenuItem
        Caption = 'Select element'
        Hint = 'Mark the current element as selected (+ in the leftmost column)'
        ShortCut = 45
        OnClick = MISelectElementClick
      end
      object MISelectAll: TMenuItem
        Caption = 'Select all elements'
        Hint = 'Select all elements in the browser'
        OnClick = MISelectAllClick
      end
      object MIClearSelection: TMenuItem
        Caption = 'Clear selection'
        Hint = 'Remove selection markers from all elements'
        OnClick = MIClearSelectionClick
      end
      object MIInvertSelection: TMenuItem
        Caption = 'Invert selection'
        Hint = 
          'Invert the selection (i.e. unselect selected and select unselect' +
          'ed)'
        OnClick = MIInvertSelectionClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object MISelectBrowserRange: TMenuItem
        Caption = 'Browser range'
        Hint = 'Select a range of rows in the browser'
        OnClick = MISelectBrowserRangeClick
      end
      object MISelectElementRange: TMenuItem
        Caption = 'Element range'
        Hint = 'Select a range of elements in the browser'
        OnClick = MISelectElementRangeClick
      end
      object MIUnselectBrowserRange: TMenuItem
        Caption = 'Unselect browser range'
        Hint = 'Remove selection from a range of rows in the browser'
        OnClick = MIUnselectBrowserRangeClick
      end
      object MIUnselectElementRange: TMenuItem
        Caption = 'Unselect element range'
        Hint = 'Remove selection from a range of elements in the browser'
        OnClick = MIUnselectElementRangeClick
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object MIUnselectSubtract: TMenuItem
        Caption = 'Unselect-Subtract'
        Hint = 'Unselect all elements that belong to a given subset file'
        OnClick = MIUnselectSubtractClick
      end
      object MIUnselectIntersect: TMenuItem
        Caption = 'Unselect-Intersect'
        Hint = 'Unselect all elements that cannot be found in a subset file'
        OnClick = MIUnselectIntersectClick
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object MISaveSelection: TMenuItem
        Caption = '&Save selection'
        Hint = 'Save all marked elements into a subset file'
        OnClick = MISaveSelectionClick
      end
    end
    object MISubset: TMenuItem
      Caption = '&Subset'
      object MISaveAll: TMenuItem
        Caption = 'Save all'
        Hint = 'Save all browsed elements in a subset file'
        OnClick = MISaveAllClick
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object MIAddSubset: TMenuItem
        Caption = '&Add subset file'
        Hint = 'Create a new browser with the sum of subset elements'
        OnClick = MIAddSubsetClick
      end
      object MISubtractSubset: TMenuItem
        Caption = 'Sub&tract subset file'
        Hint = 'Create a new browser with the difference of subset elements'
        OnClick = MISubtractSubsetClick
      end
      object MIIntersectSubset: TMenuItem
        Caption = '&Intersect subset file'
        Hint = 'Create a new browser with the intersection of subset elements'
        OnClick = MIIntersectSubsetClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MIIntersperseSubset: TMenuItem
        Caption = 'Intersperse subset'
        Hint = 'Mix two subsets randomly using a selected frequency ratio'
        OnClick = MIIntersperseSubsetClick
      end
      object N9: TMenuItem
        Caption = '-'
        Hint = '-'
      end
      object MIDelete: TMenuItem
        Caption = '&Delete'
        Hint = 'Delete a selected subset file'
        OnClick = MIDeleteClick
      end
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object Search1: TMenuItem
      Caption = 'Search'
      ImageIndex = 5
      ImageName = 'icon_005'
      object MISearchBrowser: TMenuItem
        Caption = '&Search browser'
        Hint = 'Search for texts in elements included in the browser'
        ImageIndex = 5
        ImageName = 'icon_005'
        ShortCut = 16454
        OnClick = MISearchBrowserClick
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object Find1: TMenuItem
        Caption = '&Find title'
        Hint = 
          'Find a text among titles displayed in the browser (starting with' +
          ' the current row)'
        ShortCut = 32838
        OnClick = FindButtonClick
      end
      object Findnext1: TMenuItem
        Caption = 'Find &next '
        Hint = 'Find the same string again (in browsed element titles)'
        ShortCut = 114
        OnClick = Findnext1Click
      end
      object MIFindAll: TMenuItem
        Caption = 'Find all titles'
        Hint = 'Find all titles including a given substring'
        OnClick = MIFindAllClick
      end
      object MIFindCurrent: TMenuItem
        Caption = 'Find current'
        Hint = 'Find the element currently displayed in the element window'
        OnClick = GoToElWindElementClick
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object MISearchAndReplace: TMenuItem
        Caption = 'Search and &replace'
        Hint = 'Search and replace texts in the browser'
        ImageIndex = 107
        ImageName = 'icon_107'
        ShortCut = 16466
        OnClick = MISearchAndReplaceClick
      end
    end
    object MISort: TMenuItem
      Caption = 'S&ort'
      Hint = 'Sort the browser'
      ImageIndex = 69
      ImageName = 'icon_069'
      object MISortForReview: TMenuItem
        Caption = 'For &Review'
        Hint = 
          'Sort elements using repetition sorting criteria (proportion of t' +
          'opics, randomization, etc.)'
        ShortCut = 16467
        OnClick = MISortForReviewClick
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object MISortByInterval: TMenuItem
        Caption = 'By interval'
        Hint = 'Sort the browser by current intervals'
        OnClick = MISortByIntervalClick
      end
      object MISortByStability: TMenuItem
        Caption = 'By stability'
        Hint = 'Sort the browser by memory stability (S)'
        OnClick = MISortByStabilityClick
      end
      object MISortByRetrievability: TMenuItem
        Caption = 'By retrievability'
        Hint = 'Sort browser elements by probability of recall (R)'
        OnClick = MISortByRetrievabilityClick
      end
      object MISortByDifficulty: TMenuItem
        Caption = 'By difficulty'
        Hint = 'Sort the browser by element difficulty'
        OnClick = MISortByDifficultyClick
      end
      object MISortByFirstRepetition: TMenuItem
        Caption = 'By first rep. date'
        Hint = 'Sort the browser by the date of the first repetition'
        OnClick = MISortByFirstRepetitionClick
      end
      object MIByLastRep: TMenuItem
        Caption = 'By last rep. date'
        Hint = 'Sort the browser by the date of the last repetition'
        OnClick = MIByLastRepClick
      end
      object MIByNextRep: TMenuItem
        Caption = 'By next rep. date'
        Hint = 'Sort the browser by the date of the next repetition'
        OnClick = MIByNextRepClick
      end
      object MIByForgetting: TMenuItem
        Caption = 'By memory lapses'
        Hint = 'Sort the browser by the number of memory lapses'
        OnClick = MIByForgettingClick
      end
      object MISortByPostpone: TMenuItem
        Caption = 'By postpone count'
        Hint = 'Sort the browser by the postpone count'
        OnClick = MISortByPostponeClick
      end
      object MISortByPriority: TMenuItem
        Caption = 'By priority'
        Hint = 'Sort the browser by element priority'
        ImageIndex = 138
        ImageName = 'icon_138'
        OnClick = MISortByPriorityClick
      end
      object MIByRepetitions: TMenuItem
        Caption = 'By repetition count'
        Hint = 'Sort the browser by the number of repetitions'
        OnClick = MIByRepetitionsClick
      end
      object Bytextsize1: TMenuItem
        Caption = 'By text &size'
        Hint = 'Sort the browser by the size of texts included in elements'
        OnClick = Bytextsize1Click
      end
      object Byfilesize1: TMenuItem
        Caption = 'By picture size'
        Hint = 'Sort the browser by the size of pictures included in elements'
        OnClick = Byfilesize1Click
      end
      object MISortByTree: TMenuItem
        Caption = 'By tree'
        Hint = 'Sort elements by their position in the contents window'
        ImageIndex = 69
        ImageName = 'icon_069'
        OnClick = MISortByTreeClick
      end
      object Other1: TMenuItem
        Caption = '&Other'
        object MIByTitle: TMenuItem
          Caption = 'By &title'
          Hint = 'Sort the browser by the title of elements'
          OnClick = MIByTitleClick
        end
        object MISortByType: TMenuItem
          Caption = 'By type'
          Hint = 'Sort the browser by element type'
          OnClick = MISortByTypeClick
        end
        object MISortByAFactor: TMenuItem
          Caption = 'By A-Factor'
          Hint = 'Sort the browser by A-Factors'
          OnClick = MISortByAFactorClick
        end
        object MIByElementNo: TMenuItem
          Caption = 'By element number'
          Hint = 'Sort the browser by the element number'
          OnClick = MIByElementNoClick
        end
        object MISortByFI: TMenuItem
          Caption = 'By forgetting index'
          Hint = 'Sort the browser by forgetting index'
          OnClick = MISortByFIClick
        end
        object MIByOrdinal: TMenuItem
          Caption = 'By ordinal number'
          Hint = 'Sort the browser by the ordinal number'
          OnClick = MIByOrdinalClick
        end
        object MISortByUFactor: TMenuItem
          Caption = 'By U-Factor'
          Hint = 'Sort the browser by U-Factors'
          OnClick = MISortByUFactorClick
        end
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object MIRandomize: TMenuItem
        Caption = 'Randomize'
        Hint = 'Randomize the sequence of elements in the browser'
        ShortCut = 24698
        OnClick = MIRandomizeClick
      end
    end
    object Export1: TMenuItem
      Caption = '&Export'
      Hint = 'Export from the browser'
      ImageIndex = 42
      ImageName = 'icon_042'
      object MITransfer: TMenuItem
        Caption = '&Transfer elements'
        Hint = 
          'Replicate the contents of the browser by transferring copies of ' +
          'elements to another collection '
        OnClick = MITransferClick
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object MIExportDocument: TMenuItem
        Caption = '&Document'
        Hint = 
          'Export the browser as a single HTML document (with or without th' +
          'e contents file)'
        OnClick = MIExportDocumentClick
      end
      object MIExportQAText: TMenuItem
        Caption = '&Q&&A text file'
        Hint = 'Export questions and answers from the browser into a Q&A file'
        OnClick = MIExportQATextClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object MIExportasXML: TMenuItem
        Caption = '&XML'
        Hint = 
          'Export the subset as questions and answers in XML format for imp' +
          'ort on other platforms'
        OnClick = MIExportasXMLClick
      end
      object MIExportAsText: TMenuItem
        Caption = '&Source text'
        Hint = 'Export browsed elements as text'
        OnClick = MIExportAsTextClick
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object MITextSubset: TMenuItem
        Caption = 'Text subset'
        Hint = 'Open the text registry subset corresponding with browser texts'
        OnClick = MITextSubsetClick
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object MIExportRepetitionHistoryCSV: TMenuItem
        Caption = 'Repetition history (CSV)'
        Hint = 'Export subset'#39's history of repetitions into a CSV file'
        OnClick = MIExportRepetitionHistoryCSVClick
      end
      object MIExportRepetitionHistoryText: TMenuItem
        Caption = 'Repetition history (Text)'
        Hint = 
          'Export subset'#39's history of repetitions into a SuperMemo-importab' +
          'le file'
        OnClick = MIExportRepetitionHistoryTextClick
      end
      object RepetitionhistoryAI1: TMenuItem
        Caption = 'Repetition history (AI)'
        Hint = 'Anonymized repetition history set with normalized grade output'
        OnClick = RepetitionhistoryAI1Click
      end
    end
    object Random1: TMenuItem
      Caption = '&Random'
      ImageIndex = 41
      ImageName = 'icon_041'
      object Randomchange1: TMenuItem
        Caption = '&Random review'
        Hint = 
          'Jump to a randomly selected element for a quick review of the br' +
          'owser'#39's contents'
        ShortCut = 122
        OnClick = RandomButtonClick
      end
      object MIRandomTest: TMenuItem
        Caption = 'Random test'
        Hint = 'Start random test on the elements of the browser'
        ShortCut = 16506
        OnClick = MIRandomTestClick
      end
      object MIRandomizeBrowser: TMenuItem
        Caption = 'Randomize browser'
        Hint = 'Randomize the sequence of elements in the browser'
        ShortCut = 24698
        OnClick = MIRandomizeClick
      end
    end
    object MITools: TMenuItem
      Caption = '&Tools'
      Hint = 'Various operations on the browser'
      ImageIndex = 156
      ImageName = 'icon_156'
      object MISavePending: TMenuItem
        Caption = 'Save &pending'
        Hint = 'Save pending browser in the pending queue (e.g. after sorting)'
        OnClick = MISavePendingClick
      end
      object MISavePriority: TMenuItem
        Caption = 'Save priority'
        Hint = 'Save the browser at the top of the priority queue'
        OnClick = MISavePriorityClick
      end
      object Savedrill1: TMenuItem
        Caption = 'Save &drill'
        Hint = 'Save the browser in the final drill queue'
        OnClick = Savedrill1Click
      end
      object MISaveRepetitions: TMenuItem
        Caption = 'Save &repetitions'
        Hint = 'Schedule repetition of elements listed in the browser for today'
        OnClick = MISaveRepetitionsClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object MISwapQA: TMenuItem
        Caption = 'Swap Q&&A'
        Hint = 'Swap questions with answers in the browser'
        OnClick = MISwapQAClick
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object MITotalKnowledge: TMenuItem
        Caption = 'Total knowledge'
        Hint = 'Compute the estimate of changes in subset knowledge over time'
        OnClick = MITotalKnowledgeClick
      end
      object MIMemoryModel: TMenuItem
        Caption = 'Memory model'
        Hint = 'Compute memory model parameters for the browser subset'
        ShortCut = 119
        OnClick = MIMemoryModelClick
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object MIRepetitionsGraph: TMenuItem
        Caption = 'Repetitions &graph'
        Hint = 
          'Plot the graph of repetition intervals using repetition history ' +
          'of elements in the browser'
        OnClick = MIRepetitionsGraphClick
      end
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MIProcessBrowser: TMenuItem
      Caption = '&Process browser>'
      Hint = 'Process elements in the selected branch'
      ImageIndex = 186
      ImageName = 'icon_186'
      OnClick = MIProcessBrowserClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object MIClose: TMenuItem
      Caption = 'Close'
      Hint = 'Close the browser'
      ShortCut = 27
      OnClick = MICloseClick
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 304
    Top = 516
  end
  object OpenDialog1: TOpenDialog
    Left = 188
    Top = 520
  end
end
