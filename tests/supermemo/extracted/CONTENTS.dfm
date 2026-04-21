object Contents: TContents
  Left = 445
  Top = 170
  HelpContext = 4
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Contents'
  ClientHeight = 1830
  ClientWidth = 3249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -23
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  KeyPreview = True
  PopupMenu = PopupMenu1
  Position = poDefault
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 29
  object BottomBar: TToolBar
    Left = 5
    Top = 1779
    Width = 3239
    Height = 46
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    AutoSize = True
    BorderWidth = 2
    ButtonHeight = 38
    ButtonWidth = 116
    Caption = 'BottomBar'
    Customizable = True
    EdgeInner = esLowered
    Images = AboutBox.VirtualImageList16
    List = True
    ShowCaptions = True
    TabOrder = 0
    Wrapable = False
    AllowTextButtons = True
    object Learn: TToolButton
      Left = 0
      Top = 0
      Hint = 
        'Start repetitions on elements belonging to the selected branch (' +
        'Ctrl+L)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Learn'
      ImageName = 'icon_034'
      Style = tbsTextButton
      OnClick = LearnClick
    end
    object ToolButton5: TToolButton
      Left = 116
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton5'
      ImageIndex = 2
      ImageName = 'icon_002'
      Style = tbsSeparator
    end
    object Add: TToolButton
      Left = 128
      Top = 0
      Hint = 'Add a new child element'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Add'
      ImageIndex = 150
      ImageName = 'icon_150'
      Style = tbsTextButton
      OnClick = MIAddElementClick
    end
    object ToolButton7: TToolButton
      Left = 244
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton7'
      ImageIndex = 3
      ImageName = 'icon_003'
      Style = tbsSeparator
    end
    object Insert: TToolButton
      Left = 256
      Top = 0
      Hint = 'Insert a new element (Ins)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Insert'
      ImageIndex = 184
      ImageName = 'icon_184'
      Style = tbsTextButton
      OnClick = MIInsertElementClick
    end
    object ToolButton11: TToolButton
      Left = 372
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton11'
      ImageIndex = 5
      ImageName = 'icon_005'
      Style = tbsSeparator
    end
    object Accept: TToolButton
      Left = 384
      Top = 0
      Hint = 
        'Accept the currently selected element as your choice (e.g. for a' +
        ' hyperlink, etc.)(Enter)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Accept'
      ImageIndex = 72
      ImageName = 'icon_072'
      Style = tbsTextButton
      OnClick = AcceptClick
    end
    object ToolButton15: TToolButton
      Left = 500
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton15'
      ImageIndex = 7
      ImageName = 'icon_007'
      Style = tbsSeparator
    end
    object View: TToolButton
      Left = 512
      Top = 0
      Hint = 'View the currently selected element in the element window'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&View'
      ImageIndex = 23
      ImageName = 'icon_023'
      Style = tbsTextButton
      OnClick = ViewClick
    end
    object ToolButton13: TToolButton
      Left = 628
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton13'
      ImageIndex = 6
      ImageName = 'icon_006'
      Style = tbsSeparator
    end
    object Delete: TToolButton
      Left = 640
      Top = 0
      Hint = 'Delete the selected branch including all descendants (Del)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Delete'
      ImageIndex = 16
      ImageName = 'icon_016'
      Style = tbsTextButton
      OnClick = DeleteClick
    end
    object ToolButton3: TToolButton
      Left = 756
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton3'
      ImageIndex = 17
      ImageName = 'icon_017'
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 768
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton1'
      ImageIndex = 18
      ImageName = 'icon_018'
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 780
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton4'
      ImageIndex = 19
      ImageName = 'icon_019'
      Style = tbsSeparator
    end
    object TypeCombo: TComboBox
      Left = 792
      Top = 0
      Width = 375
      Height = 37
      Hint = 'Default type of elements added in the contents window'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabOrder = 0
      Text = 'Topics'
      OnChange = TypeComboChange
      Items.Strings = (
        'Topics'
        'Items')
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 3249
    Height = 98
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    BorderWidth = 2
    ButtonHeight = 32
    ButtonWidth = 107
    Caption = 'ToolBar'
    Images = AboutBox.VirtualImageList16
    TabOrder = 1
    Wrapable = False
    object ToolButton2: TToolButton
      Left = 0
      Top = 0
      Hint = 'Open the contents menu (Shift+F10)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ToolButton2'
      DropdownMenu = PopupMenu1
      ImageIndex = 4
      ImageName = 'icon_004'
    end
    object ProcessElementsButtons: TToolButton
      Left = 71
      Top = 0
      Hint = 
        'Open a menu with operations for processing elements belonging to' +
        ' a given branch'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ProcessElementsButtons'
      DropdownMenu = ProcessMenu
      ImageIndex = 47
      ImageName = 'icon_047'
      OnMouseDown = ProcessElementsButtonsMouseDown
    end
    object SplitWithElement: TToolButton
      Left = 142
      Top = 0
      Hint = 
        'Align Contents with the Element and Element data windows for eas' +
        'y contents review'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'SplitWithElement'
      ImageIndex = 53
      ImageName = 'icon_053'
      OnClick = SplitWithElementClick
    end
    object SplitWithContents: TToolButton
      Left = 213
      Top = 0
      Hint = 
        'Open or close an additional Contents window for drag-and-drop op' +
        'erations'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'SplitWithContents'
      ImageIndex = 54
      ImageName = 'icon_054'
      OnClick = SplitWithContentsClick
    end
    object FindButton: TToolButton
      Left = 284
      Top = 0
      Hint = 'Search for a string in a selected branch (Ctrl+F)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'FindButton'
      ImageIndex = 5
      ImageName = 'icon_005'
      OnClick = MISearchBranchClick
    end
    object ViewBtn: TToolButton
      Left = 355
      Top = 0
      Hint = 'View the currently selected element in the element window'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ViewBtn'
      ImageIndex = 23
      ImageName = 'icon_023'
      OnClick = ViewBtnClick
    end
    object ToolButton17: TToolButton
      Left = 426
      Top = 0
      Hint = 'Collapse the current branch (Alt+Ctrl+Enter)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'ToolButton17'
      ImageIndex = 58
      ImageName = 'icon_058'
      OnClick = CollapseClick
    end
    object PostponeBtn: TToolButton
      Left = 497
      Top = 0
      Hint = 'Postpone repetitions in a given branch'
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
    object SaveBtn: TToolButton
      Left = 568
      Top = 0
      Hint = 'Save the contents into a text file (as currently expanded)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'SaveBtn'
      ImageIndex = 51
      ImageName = 'icon_051'
      OnClick = MISaveClick
    end
    object RootBtn: TToolButton
      Left = 639
      Top = 0
      Hint = 'Set the root of the concept group on the selected branch'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'RootBtn'
      ImageIndex = 221
      ImageName = 'icon_221'
      OnClick = RootBtnClick
    end
    object HookButton: TToolButton
      Left = 710
      Top = 0
      Hint = 
        'Set the hook of the concept group on the selected branch (new el' +
        'ements will now be added here)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'HookButton'
      ImageIndex = 194
      ImageName = 'icon_194'
      OnClick = MIMakeHookClick
    end
    object InfoButton: TToolButton
      Left = 781
      Top = 0
      Hint = 'Display information about the currently selected node'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'InfoButton'
      ImageIndex = 31
      ImageName = 'icon_031'
      OnClick = InfoButtonClick
    end
    object Synch: TToolButton
      Left = 852
      Top = 0
      Hint = 
        'Synchronize the element window with the selection in the Content' +
        's window'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      AutoSize = True
      Caption = 'Synch'
      Grouped = True
      ImageIndex = 57
      ImageName = 'icon_057'
      Style = tbsCheck
      OnClick = SynchClick
    end
    object SelectTheElement: TToolButton
      Left = 923
      Top = 0
      Hint = 'Find the element currently displayed in the element window'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'SelectTheElement'
      ImageIndex = 239
      ImageName = 'Search'
      OnClick = SelectTheElementClick
    end
  end
  object PopupMenu1: TPopupMenu
    HelpContext = 28
    Images = AboutBox.VirtualImageList16
    OnPopup = PopupMenu1Popup
    Left = 32
    Top = 88
    object Invisible1: TMenuItem
      Caption = 'Invisible'
      Visible = False
      object Copy1: TMenuItem
        Caption = 'Inv: Copy'
        Hint = 'Copy the selected element to the clipboard'
        ImageIndex = 81
        ImageName = 'icon_081'
        ShortCut = 16429
        Visible = False
        OnClick = MICopyClick
      end
      object InvCountBurden1: TMenuItem
        Caption = 'Inv: Count Burden'
        ShortCut = 24642
        Visible = False
        OnClick = InvCountBurden1Click
      end
      object InvDone1: TMenuItem
        Caption = 'Inv: Done'
        ShortCut = 24589
        Visible = False
        OnClick = InvDone1Click
      end
      object InvElParams1: TMenuItem
        Caption = 'Inv: El Params'
        ShortCut = 24656
        Visible = False
        OnClick = InvElParams1Click
      end
      object Escape: TMenuItem
        Caption = 'Inv: Escape'
        ShortCut = 27
        Visible = False
        OnClick = EscapeClick
      end
      object InvExecuterepetition1: TMenuItem
        Caption = 'Inv: Execute repetition'
        ShortCut = 24658
        Visible = False
        OnClick = InvExecuterepetition1Click
      end
      object Goto1: TMenuItem
        Caption = 'Go to'
        ShortCut = 16455
        OnClick = Goto1Click
      end
      object Linkmember1: TMenuItem
        Caption = 'Link member'
        ShortCut = 24651
        OnClick = Linkmember1Click
      end
      object Paste1: TMenuItem
        Caption = 'Inv: Paste'
        ShortCut = 8237
        Visible = False
        OnClick = MIPasteClick
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
      object RepetitionHistory1: TMenuItem
        Caption = 'Repetition History'
        ShortCut = 24648
        OnClick = RepetitionHistory1Click
      end
      object InvReviewall1: TMenuItem
        Caption = 'Inv: Review all'
        ShortCut = 24652
        Visible = False
        OnClick = InvReviewall1Click
      end
      object ShowAncestors1: TMenuItem
        Caption = 'Show Ancestors'
        ShortCut = 24664
        OnClick = ShowAncestors1Click
      end
      object Webimport1: TMenuItem
        Caption = 'Web import'
        ShortCut = 24641
        OnClick = Webimport1Click
      end
    end
    object New1: TMenuItem
      Caption = '&New'
      ImageIndex = 33
      ImageName = 'icon_033'
      object MIAddItem: TMenuItem
        Caption = '&Item'
        Hint = 'Add a new item as a child of the selected element'
        ImageName = 'icon_034'
        OnClick = MIAddItemClick
      end
      object MIAddTopic: TMenuItem
        Caption = 'Topic'
        Hint = 'Add a new topic as a child of the selected element'
        ImageIndex = 86
        ImageName = 'icon_086'
        OnClick = MIAddTopicClick
      end
      object MIAddElement: TMenuItem
        Caption = 'Add &child'
        Hint = 
          'Add a new topic or item (depending on the type chosen in the too' +
          'lbar)'
        OnClick = MIAddElementClick
      end
      object MIInsertElement: TMenuItem
        Caption = 'Insert &sibling'
        Hint = 'Insert a new element in the selected place'
        ImageIndex = 184
        ImageName = 'icon_184'
        ShortCut = 45
        OnClick = MIInsertElementClick
      end
      object MIDuplicate: TMenuItem
        Caption = 'Duplicate'
        Hint = 'Duplicate the selected element'
        ImageIndex = 148
        ImageName = 'icon_148'
        ShortCut = 32836
        OnClick = MIDuplicateClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MIFolder: TMenuItem
        Caption = '&Folder'
        Hint = 'Create a new folder (i.e. a topic without a template)'
        ImageIndex = 153
        ImageName = 'icon_153'
        OnClick = MIFolderClick
      end
    end
    object MIViewMenu: TMenuItem
      Caption = '&View'
      ImageIndex = 23
      ImageName = 'icon_023'
      object MIViewElement: TMenuItem
        Caption = '&Element'
        Hint = 'View the currently selected element in the element window'
        ImageIndex = 23
        ImageName = 'icon_023'
        ShortCut = 8205
        OnClick = MIViewElementClick
      end
      object MIViewBranch: TMenuItem
        Caption = '&Branch'
        Hint = 'Display all elements of a given branch in the browser'
        ImageIndex = 73
        ImageName = 'icon_073'
        ShortCut = 16416
        OnClick = MIViewBranchClick
      end
      object MIViewDescendants: TMenuItem
        Caption = '&Descendants'
        Hint = 
          'View the selected elements and all their descendants in the brow' +
          'ser'
        OnClick = MIViewDescendantsClick
      end
      object MIBrowseSelection: TMenuItem
        Caption = '&Selection'
        Hint = 'Browse all selected elements (without descendants)'
        OnClick = MIBrowseSelectionClick
      end
      object Children1: TMenuItem
        Caption = '&Children'
        Hint = 'Display all children of a given element in the browser'
        OnClick = Children1Click
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object MIViewAsMap: TMenuItem
        Caption = '&Map'
        Hint = 'View the branch as a map'
        ImageIndex = 209
        ImageName = 'icon_209'
        OnClick = MIViewAsMapClick
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object MIGotoParent: TMenuItem
        Caption = '&Parent'
        Hint = 'Go to the parent of the currently selected element'
        ShortCut = 16422
        OnClick = MIGotoParentClick
      end
      object MIFirstChild: TMenuItem
        Caption = '&First child'
        Hint = 'Go to the first child of the current element (if available)'
        OnClick = MIFirstChildClick
      end
      object MILastChild: TMenuItem
        Caption = '&Last child'
        Hint = 'Go to the last child of the current element (if available)'
        ShortCut = 16424
        OnClick = MILastChildClick
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object MICollapse: TMenuItem
        Caption = '&Collapse'
        Hint = 'Collapse the currently selected branch'
        ImageIndex = 58
        ImageName = 'icon_058'
        ShortCut = 16397
        OnClick = MICollapseClick
      end
    end
    object MIRename: TMenuItem
      Caption = 'Rename'
      Hint = 'Rename the currently selected element title'
      OnClick = MIRenameClick
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object MICopy: TMenuItem
      Caption = 'Copy'
      Hint = 'Copy the selected element to the clipboard (Ctrl+C)'
      ImageIndex = 81
      ImageName = 'icon_081'
      OnClick = MICopyClick
    end
    object MIPaste: TMenuItem
      Caption = 'Paste'
      Hint = 'Paste an element from the clipboard (Ctrl+V)'
      ImageIndex = 139
      ImageName = 'icon_139'
      OnClick = MIPasteClick
    end
    object MIDelete: TMenuItem
      Caption = 'Delete'
      Hint = 'Delete the currently selected element or branch'
      ImageIndex = 16
      ImageName = 'icon_016'
      OnClick = DeleteClick
    end
    object MIMoveElement: TMenuItem
      Caption = '&Move'
      Hint = 'Move the selected element to a new location'
      ShortCut = 24662
      OnClick = MIMoveElementClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object MILearn: TMenuItem
      Caption = '&Learn'
      Hint = 'Make repetitions in the current branch'
      ImageName = 'icon_034'
      ShortCut = 16460
      OnClick = LearnClick
    end
    object MIDismissElement: TMenuItem
      Caption = '&Dismiss'
      Hint = 'Dismiss the currently selected element'
      ImageIndex = 153
      ImageName = 'icon_153'
      ShortCut = 16452
      OnClick = MIDismissElementClick
    end
    object Search1: TMenuItem
      Caption = '&Search'
      ImageIndex = 5
      ImageName = 'icon_005'
      object MIFind: TMenuItem
        Caption = '&Find'
        Hint = 'Find a text among expanded titles in the tree'
        ImageIndex = 106
        ImageName = 'icon_106'
        OnClick = FindClick
      end
      object MIFindNext: TMenuItem
        Caption = 'Find next'
        Hint = 'Find the next expanded title containing a searched text'
        ShortCut = 114
        OnClick = Findnext1Click
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object MISearchBranch: TMenuItem
        Caption = '&Search branch'
        Hint = 'Search for a string in the selected branch'
        ImageIndex = 5
        ImageName = 'icon_005'
        ShortCut = 16454
        OnClick = MISearchBranchClick
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MIConcept: TMenuItem
      Caption = '&Concept'
      Hint = 'Create concept and change its root or hook'
      ImageIndex = 209
      ImageName = 'icon_209'
      object MIConvertToConcept: TMenuItem
        Caption = 'Create'
        Hint = 
          'Create a new concept group with the root in the currently select' +
          'ed branch'
        ShortCut = 16459
        OnClick = MIConvertToConceptClick
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object MIMakeRoot: TMenuItem
        Caption = 'Set root'
        Hint = 
          'Set the selected element as the root of the current concept grou' +
          'p'
        OnClick = MIMakeRootClick
      end
      object MIMakeHook: TMenuItem
        Caption = 'Set hook'
        Hint = 
          'Set the selected element as the append hook of the current conce' +
          'pt group'
        ImageIndex = 194
        ImageName = 'icon_194'
        OnClick = MIMakeHookClick
      end
    end
    object MIExport: TMenuItem
      Caption = '&Export'
      Hint = 'Export elements'
      ImageIndex = 42
      ImageName = 'icon_042'
      object MITransfer: TMenuItem
        Caption = '&Transfer elements'
        Hint = 
          'Replicate a branch by transferring copies of its elements to ano' +
          'ther collection'
        ShortCut = 24660
        OnClick = MITransferClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MIExportDocument1: TMenuItem
        Caption = '&Document'
        Hint = 'Export the branch as a single document'
        OnClick = MIExportDocument1Click
      end
      object QAtextfile1: TMenuItem
        Caption = '&Q&&A text file'
        Hint = 'Export items from the branch as questions and answers'
        OnClick = QAtextfile1Click
      end
      object MIExportXML: TMenuItem
        Caption = '&XML'
        Hint = 'Export all elements in the branch as XML'
        ShortCut = 119
        OnClick = MIExportXMLClick
      end
      object MIExportHTML: TMenuItem
        Caption = '&HTML'
        Hint = 'Export the branch as a set of HTML pages'
        OnClick = MIExportHTMLClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object ExportSourceCode: TMenuItem
        Caption = 'Source code'
        Hint = 'Export the source code of the currently selected branch'
        OnClick = ExportSourceCodeClick
      end
      object MISaveAsSubset: TMenuItem
        Caption = 'Subset'
        Hint = 
          'Save the elements contained in the currently selected branch in ' +
          'a subset file'
        OnClick = MISaveAsSubsetClick
      end
      object MIExportLearning: TMenuItem
        Caption = 'Learning data'
        Hint = 'Export the learning process of the branch into a text file'
        OnClick = MIExportLearningClick
      end
    end
    object N3: TMenuItem
      Caption = '&Tools'
      ImageIndex = 156
      ImageName = 'icon_156'
      object MINameNode: TMenuItem
        Caption = '&Name node'
        Hint = 'Name import node using imported element tiles'
        OnClick = MINameNodeClick
      end
      object MIRegroupInFolders: TMenuItem
        Caption = '&Regroup in folders'
        Hint = 
          'Arrange elements in folders without severing parent-child relati' +
          'onships'
        OnClick = MIRegroupInFoldersClick
      end
      object MIArrangeFolders: TMenuItem
        Caption = '&Arrange in folders'
        Hint = 'Arrange all elements equally in folders'
        OnClick = MIArrangeFoldersClick
      end
      object MIFlatten: TMenuItem
        Caption = 'Flatten'
        Hint = 
          'Convert a branched tree node into a flat linear structure of sib' +
          'lings'
        OnClick = MIFlattenClick
      end
      object RandomTest: TMenuItem
        Caption = 'Random test'
        Hint = 'Run random test on the currently selected node'
        ImageIndex = 41
        ImageName = 'icon_041'
        ShortCut = 122
        OnClick = RandomTestClick
      end
    end
    object MIFont: TMenuItem
      Caption = '&Font'
      Hint = 'Change the font used in the Contents window'
      ImageIndex = 24
      ImageName = 'icon_024'
      OnClick = MIFontClick
    end
    object MICustomize: TMenuItem
      Caption = 'Delete: Customi&ze'
      Hint = 'Customize the Contents window'
      Visible = False
      object MIAutoScroll: TMenuItem
        Caption = '&Auto-scroll'
        Hint = 
          'Make the Contents window scroll when mouse moves out of the edge' +
          's of the tree'
        OnClick = MIAutoScrollClick
      end
      object MISorted: TMenuItem
        Caption = '&Sorted'
        Hint = 'Keep branches always sorted alphabetically'
        OnClick = MISortedClick
      end
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object MIProcessBranch: TMenuItem
      Caption = '&Process branch>'
      Hint = 'Process element in a given branch'
      ImageIndex = 73
      ImageName = 'icon_073'
      OnClick = MIProcessBranchClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object MIClose: TMenuItem
      Caption = 'Close'
      Hint = 'Close the contents window'
      ShortCut = 16499
      OnClick = MICloseClick
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    Left = 448
    Top = 288
  end
  object ScrollTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = ScrollTimerTimer
    Left = 336
    Top = 264
  end
  object ProcessMenu: TPopupMenu
    Images = AboutBox.VirtualImageList16
    Left = 104
    Top = 88
    object Changestatus1: TMenuItem
      Caption = '&Learning'
      Hint = 'Learning options'
      ImageName = 'icon_034'
      object MILearn2: TMenuItem
        Caption = '&Learn'
        Hint = 'Repeat and review outstanding elements'
        ImageName = 'icon_034'
        ShortCut = 16460
        OnClick = MILearn2Click
      end
      object MIForce: TMenuItem
        Caption = '&Review all'
        Hint = 'Execute mid-interval repetitions on all elements'
        ShortCut = 24652
        OnClick = MIForceClick
      end
      object MIReviewTopics: TMenuItem
        Caption = 'Review &topics'
        Hint = 'Review all topics in the subset'
        OnClick = MIReviewTopicsClick
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object MIDilute: TMenuItem
        Caption = 'Dilute'
        Hint = 
          'Delay the repetition of all elements by increasing intervals sli' +
          'ghtly'
        OnClick = MIDiluteClick
      end
      object MIReschedule: TMenuItem
        Caption = '&Spread'
        Hint = 'Reschedule all elements in a given period (subset Mercy)'
        OnClick = MIRescheduleClick
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object MIRemember: TMenuItem
        Caption = '&Remember'
        Hint = 'Introduce all element into the learning process'
        ImageIndex = 112
        ImageName = 'icon_112'
        OnClick = CommitClick
      end
      object MIReset: TMenuItem
        Caption = 'Forget'
        Hint = 'Remove all elements from the learning process'
        OnClick = ResetClick
      end
      object MIDismiss: TMenuItem
        Caption = '&Dismiss'
        Hint = 'Ignore all elements in the learning process'
        ImageIndex = 153
        ImageName = 'icon_153'
        OnClick = DismissClick
      end
      object MIUndismiss: TMenuItem
        Caption = '&Undismiss'
        Hint = 'Return dismissed elements back to the pending queue'
        OnClick = UndismissClick
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object Done1: TMenuItem
        Caption = 'Done'
        Hint = 'Execute "Done" on all elements in the subset'
        OnClick = Done1Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object MIAddToOutstanding: TMenuItem
        Caption = 'Add to outstanding'
        Hint = 
          'Add elements scheduled in the future to the outstanding queue (w' +
          'ithout rescheduling)'
        ImageIndex = 175
        ImageName = 'icon_175'
        OnClick = MIAddToOutstandingClick
      end
      object MIAddAllToOutstanding: TMenuItem
        Caption = 'Add all to outstanding'
        Hint = 'Add all elements to the outstanding queue'
        OnClick = MIAddAllToOutstandingClick
      end
      object MIAddToDrill: TMenuItem
        Caption = 'Add to drill'
        Hint = 'Add all elements to the final drill queue'
        OnClick = MIAddToDrillClick
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object MIResetHistory: TMenuItem
        Caption = 'Reset history'
        Hint = 'Reset repetition history of all elements in the subset'
        OnClick = MIResetHistoryClick
      end
    end
    object MIPostpone: TMenuItem
      Caption = '&Postpone'
      Hint = 'Postpone the repetition of outstanding elements'
      ImageIndex = 95
      ImageName = 'icon_095'
      OnClick = MIPostponeClick
    end
    object Advance1: TMenuItem
      Caption = '&Advance'
      Hint = 'Bring the review of elements closer in time'
      ImageIndex = 115
      ImageName = 'icon_115'
      object MIAdvanceTopics: TMenuItem
        Caption = '&Topics'
        Hint = 'Shorten absolute intervals of topics listed in the browser'
        ImageIndex = 115
        ImageName = 'icon_115'
        OnClick = MIAdvanceTopicsClick
      end
      object MIAdvanceItems: TMenuItem
        Caption = '&Items'
        Hint = 'Shorten relative intervals of items listed in the browser'
        OnClick = MIAdvanceItemsClick
      end
      object MIAdvanceAll: TMenuItem
        Caption = '&All elements'
        Hint = 
          'Shorten intervals of all elements (topics: absolute interval; it' +
          'ems: relative interval)'
        OnClick = MIAdvanceAllClick
      end
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object MIPriority: TMenuItem
      Caption = '&Priority'
      Hint = 'Spread priorities equally withing a range among the elements'
      ImageIndex = 138
      ImageName = 'icon_138'
      object MIIncreasePriority: TMenuItem
        Caption = '&Increase'
        Hint = 'Increase the priority of elements'
        ImageIndex = 200
        ImageName = 'icon_200'
        OnClick = MIIncreasePriorityClick
      end
      object MIDecrease: TMenuItem
        Caption = '&Decrease'
        Hint = 'Decrease the priority of elements'
        ImageIndex = 199
        ImageName = 'icon_199'
        OnClick = MIDecreaseClick
      end
      object MISpreadPriority: TMenuItem
        Caption = '&Spread'
        Hint = 'Spread priorities within a range'
        ImageIndex = 105
        ImageName = 'icon_105'
        OnClick = MISpreadPriorityClick
      end
      object Modify1: TMenuItem
        Caption = '&Adjust'
        Hint = 'Adjust priorities to match a specified priority range'
        OnClick = Modify1Click
      end
    end
    object Forgettingindex1: TMenuItem
      Caption = '&Forgetting index'
      object SetForgettingIndex1: TMenuItem
        Caption = 'Set forgetting index'
        Hint = 'Set the forgetting index for elements '
        OnClick = SetForgettingIndexClick
      end
      object MIDefaultForgettingIndex: TMenuItem
        Caption = 'Default forgetting index'
        Hint = 'Assign default forgetting index to elements'
        OnClick = MIDefaultForgettingIndexClick
      end
    end
    object AFactor1: TMenuItem
      Caption = 'A-Factor'
      object MISetAFactor: TMenuItem
        Caption = 'Set A-Factor'
        Hint = 'Assign a given A-Factor value to topics in the subset'
        OnClick = MISetAFactorClick
      end
      object MIModifyAFactor: TMenuItem
        Caption = 'Modify A-Factor'
        Hint = 'Increase or decrease A-Factors among topics in the subset'
        OnClick = MIModifyAFactorClick
      end
    end
    object Ordinal1: TMenuItem
      Caption = '&Ordinal'
      object MISetOrdinal: TMenuItem
        Caption = 'Set ordinal'
        Hint = 
          'Assign a given ordinal value to elements (e.g. for sorting the p' +
          'ending queue, etc.)'
        OnClick = MISetOrdinalClick
      end
      object MISetDifficultyOrdinal: TMenuItem
        Caption = 'Set difficulty ordinal'
        Hint = 
          'Assign ordinals derived from item difficulty (easier items will ' +
          'get lower ordinals)'
        OnClick = MISetDifficultyOrdinalClick
      end
      object MISpreadOrdinals: TMenuItem
        Caption = 'Spread ordinals'
        Hint = 'Spread ordinals equally withing a range among the elements'
        OnClick = MISpreadOrdinalsClick
      end
      object MIBlendOrdinals: TMenuItem
        Caption = 'Blend ordinals'
        Hint = 
          'Modify the ordinal order by blending with an order from a subset' +
          ' file'
        OnClick = MIBlendOrdinalsClick
      end
      object MISetPositionOrdinal: TMenuItem
        Caption = 'Set position ordinal'
        Hint = 
          'Give elements ordinals equal to the element'#39's number in the coll' +
          'ection'
        OnClick = MISetPositionOrdinalClick
      end
      object Setpendingordinal1: TMenuItem
        Caption = 'Set pending ordinal'
        Hint = 
          'Give elements ordinals equal to the element'#39's position in the pe' +
          'nding queue'
        OnClick = Setpendingordinal1Click
      end
      object MIModifyOrdinal: TMenuItem
        Caption = 'Modify ordinal'
        Hint = 
          'Increase or decrease ordinal numbers that determine element prio' +
          'rity '
        Visible = False
        OnClick = MIModifyOrdinalClick
      end
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object MIExport2: TMenuItem
      Caption = '&Export'
      Hint = 'Export elements'
      ImageIndex = 42
      ImageName = 'icon_042'
      object MIExportDocument: TMenuItem
        Caption = '&Document (HTML)'
        Hint = 'Export all elements into a single text document'
        OnClick = MIExportDocumentClick
      end
      object MIExportQA: TMenuItem
        Caption = '&Q&&A text file'
        Hint = 'Export a text file with questions and answers'
        OnClick = MIExportQAClick
      end
      object MIExportAllTexts: TMenuItem
        Caption = '&All texts'
        Hint = 'Export all texts as a single unformatted text file'
        OnClick = MIExportAllTextsClick
      end
    end
    object MIMove: TMenuItem
      Caption = '&Move'
      object MIMoveToBranch: TMenuItem
        Caption = 'To a &branch'
        Hint = 'Move browser elements to a selected branch'
        OnClick = MIMoveToBranchClick
      end
      object MIMoveToCategory: TMenuItem
        Caption = 'To a &concept'
        Hint = 'Move browser elements to a selected concept'
        OnClick = MIMoveToCategoryClick
      end
    end
    object MITemplate: TMenuItem
      Caption = '&Template'
      Hint = 'Template options'
      ImageIndex = 113
      ImageName = 'icon_113'
      object MIApplyTemplate: TMenuItem
        Caption = '&Apply template'
        Hint = 'Apply template to all selected elements'
        ImageIndex = 166
        ImageName = 'icon_166'
        OnClick = MIApplyTemplateClick
      end
      object MIImposeTemplate: TMenuItem
        Caption = '&Impose template'
        Hint = 'Impose and detach template from all selected elements'
        OnClick = MIImposeTemplateClick
      end
      object MIDetachTemplate: TMenuItem
        Caption = '&Detach template'
        Hint = 'Detach template from all selected elements'
        OnClick = MIDetachTemplateClick
      end
      object MIReplaceTemplate: TMenuItem
        Caption = '&Replace template'
        Hint = 'Replace template in all selected elements'
        OnClick = MIReplaceTemplateClick
      end
      object MIAddTemplate: TMenuItem
        Caption = 'Add template'
        Hint = 'Add the contents of a template to all elements'
        OnClick = MIAddTemplateClick
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object MIInsertPictures: TMenuItem
        Caption = 'Insert picture'
        Hint = 'Insert picture to all processed elements '
        ImageName = 'icon_108'
        OnClick = MIInsertPicturesClick
      end
    end
    object Status1: TMenuItem
      Caption = 'Type'
      Hint = 'Change the type of elements'
      object MIMakeItems: TMenuItem
        Caption = 'Make &items'
        Hint = 'Convert all elements to items'
        OnClick = ItemClick
      end
      object MIMakeTopics: TMenuItem
        Caption = 'Make &topics'
        Hint = 'Convert all elements to topics'
        OnClick = Topic_Click
      end
      object MIMakeConcepts: TMenuItem
        Caption = 'Make &concepts'
        Hint = 'Convert elements into concepts'
        OnClick = MIMakeConceptsClick
      end
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object MISetTitle: TMenuItem
      Caption = 'Set t&itle'
      Hint = 'Give all elements in the set a given title'
      OnClick = MISetTitleClick
    end
    object MISetConceptGroup: TMenuItem
      Caption = 'Set concept group'
      Hint = 'Set all element affiliations to a given concept group'
      OnClick = MISetConceptGroupClick
    end
    object Reference1: TMenuItem
      Caption = 'Reference'
      Hint = 'Modify references in a subset of elements'
      object MISetReference: TMenuItem
        Caption = 'Set &reference'
        Hint = 'Assing the same reference to all elements in a set'
        ImageIndex = 222
        ImageName = 'icon_222'
        OnClick = MISetReferenceClick
      end
      object MIMergeReferences: TMenuItem
        Caption = 'Merge reference'
        Hint = 'Add reference fields to a set of elements'
        OnClick = MIMergeReferencesClick
      end
      object MIDeleteReference: TMenuItem
        Caption = 'Delete reference'
        Hint = 'Delete references in the subset'
        OnClick = MIDeleteReferenceClick
      end
    end
    object N21: TMenuItem
      Caption = '-'
    end
    object MIStatistics: TMenuItem
      Caption = 'Statistics'
      Hint = 'Compute statistics for a selected set of elements'
      ImageIndex = 179
      ImageName = 'icon_179'
      ShortCut = 24642
      OnClick = MIStatisticsClick
    end
  end
end
