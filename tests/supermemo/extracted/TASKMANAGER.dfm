object TaskManager: TTaskManager
  Left = 454
  Top = 218
  HelpContext = 23
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  ActiveControl = StringGrid1
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Tasklist'
  ClientHeight = 1163
  ClientWidth = 1756
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 16
  object StringGrid1: TStringGrid
    Left = 0
    Top = 87
    Width = 1756
    Height = 1076
    Align = alClient
    DefaultColWidth = 96
    DefaultRowHeight = 36
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing, goTabs, goThumbTracking]
    TabOrder = 0
    OnColumnMoved = StringGrid1ColumnMoved
    OnDblClick = StringGrid1DblClick
    OnKeyDown = StringGrid1KeyDown
    OnSelectCell = StringGrid1SelectCell
    RowHeights = (
      36
      36
      36
      36
      36)
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1756
    Height = 87
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 87
    ButtonWidth = 75
    Caption = 'ToolBar1'
    Images = AboutBox.VirtualImageList32
    ShowCaptions = True
    TabOrder = 1
    Wrapable = False
    object MenuBtn: TToolButton
      Left = 0
      Top = 0
      Hint = 'Open tasklist manager menu'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Menu'
      DropdownMenu = PopupMenu1
      ImageIndex = 47
      ImageName = 'icon_047'
    end
    object TaskCombo: TComboBox
      Left = 75
      Top = 0
      Width = 300
      Height = 24
      Hint = 'Select tasklist for editing or inspection'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      TabOrder = 0
      Text = 'sm9'
      OnChange = TaskComboChange
      OnClick = TaskComboClick
      OnDropDown = TaskComboDropDown
      OnExit = TaskComboExit
      OnKeyPress = TaskComboKeyPress
      Items.Strings = (
        'sm9'
        'web'
        'tasks'
        'books'
        'buy'
        'sm8')
    end
    object ToolButton3: TToolButton
      Left = 375
      Top = 0
      Hint = 'Make current tasklist the default tasklist'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Set'
      ImageIndex = 231
      ImageName = 'icon_231'
      OnClick = SetDefaultClick
    end
    object ViewBtn: TToolButton
      Left = 450
      Top = 0
      Hint = 'View the element associated with the tasklist (Ctrl+Enter)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&View'
      ImageIndex = 23
      ImageName = 'icon_023'
      OnClick = ViewBtnClick
    end
    object GoToButton: TToolButton
      Left = 525
      Top = 0
      Hint = 'Go to the selected task (Ctrl+Shift+Enter)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Go to'
      ImageIndex = 70
      ImageName = 'icon_070'
      OnClick = GoToButtonClick
    end
    object AddButton: TToolButton
      Left = 600
      Top = 0
      Hint = 'Add a new task to the current tasklist'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Add task'
      ImageIndex = 8
      ImageName = 'icon_008'
      OnClick = AddButtonClick
    end
    object Delete: TToolButton
      Left = 675
      Top = 0
      Hint = 'Delete the currently selected task'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Delete task'
      ImageIndex = 16
      ImageName = 'icon_016'
      OnClick = DeleteClick
    end
    object Find: TToolButton
      Left = 750
      Top = 0
      Hint = 'Find a task containing a given substring (Ctrl+F)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Find'
      ImageIndex = 239
      ImageName = 'Search'
      OnClick = FindClick
    end
    object SortButton: TToolButton
      Left = 825
      Top = 0
      Hint = 'Sort the tasklist for priority (Ctrl+S)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Sort'
      ImageIndex = 69
      ImageName = 'icon_069'
      OnClick = SortButtonClick
    end
    object ExportButton: TToolButton
      Left = 900
      Top = 0
      Hint = 'Export the current tasklist as a text file'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Export'
      ImageIndex = 42
      ImageName = 'icon_042'
      OnClick = ExportButtonClick
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 672
    Top = 360
  end
  object OpenDialog1: TOpenDialog
    Left = 540
    Top = 348
  end
  object PopupMenu1: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 108
    Top = 312
    object MIView: TMenuItem
      Caption = '&View'
      Hint = 'View the task element in the element window'
      ImageIndex = 23
      ShortCut = 16397
      OnClick = MIViewClick
    end
    object MIGoTo: TMenuItem
      Caption = '&Go to'
      Hint = 
        'Close the tasklist manager and display the current task in the e' +
        'lement window'
      ImageIndex = 70
      ShortCut = 24589
      OnClick = MIGoToClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MIDismiss: TMenuItem
      Caption = '&Dismiss task'
      Hint = 'Remove the task from the list and store it in the task archive'
      ShortCut = 16452
      OnClick = MIDismissClick
    end
    object MIMemorizedTask: TMenuItem
      Caption = '&Memorize task'
      Hint = 'Introduce the task into the learning process'
      ShortCut = 16461
      OnClick = MIMemorizedTaskClick
    end
    object MIEditParameters: TMenuItem
      Caption = '&Edit parameters'
      Hint = 'Edit the parameters of the selected task (also: Ctrl+E)'
      ShortCut = 24656
      OnClick = MIEditParametersClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object MIAddTask: TMenuItem
      Caption = '&Add task'
      Hint = 'Add a new task'
      ImageIndex = 8
      ShortCut = 32880
      OnClick = MIAddTaskClick
    end
    object MITransferTask: TMenuItem
      Caption = '&Transfer task'
      Hint = 'Transfer task to another tasklist'
      ImageIndex = 232
      ShortCut = 16468
      OnClick = MITransferTaskClick
    end
    object MISort: TMenuItem
      Caption = '&Sort'
      Hint = 'Sort the tasklist for priority'
      ImageIndex = 69
      ShortCut = 16467
      OnClick = MISortClick
    end
    object MIFind: TMenuItem
      Caption = '&Find task'
      Hint = 'Find a task containing a given substring'
      ImageIndex = 106
      ShortCut = 16454
      OnClick = MIFindClick
    end
    object MIFindNext: TMenuItem
      Caption = '&Find next'
      Hint = 'Search again for the last searched string'
      ShortCut = 114
      OnClick = MIFindNextClick
    end
    object Findall1: TMenuItem
      Caption = 'Find all'
      Hint = 'Find all tasks with a given text in the description'
      ImageIndex = 5
      ShortCut = 24646
      OnClick = Findall1Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object MISelectTasklist: TMenuItem
      Caption = '&Set as default'
      Hint = 'Set the current tasklist to be the default tasklist'
      ImageIndex = 231
      OnClick = SetDefaultClick
    end
    object MIGotoMenu: TMenuItem
      Caption = '&Jump'
      object MIRandomJump: TMenuItem
        Caption = '&Random jump'
        Hint = 'Jump to review a random taks in the list'
        ImageIndex = 41
        ShortCut = 122
        OnClick = MIRandomJumpClick
      end
      object MIRandomPreferred: TMenuItem
        Caption = 'Random preferred'
        Hint = 'Jump to a random task with preference for high priority tasks'
        ShortCut = 8314
        OnClick = MIRandomPreferredClick
      end
      object MISelectedRow: TMenuItem
        Caption = 'Selected &row'
        Hint = 'Go to a selected row in the tasklist manager'
        ShortCut = 16455
        OnClick = MISelectedRowClick
      end
    end
    object Tools1: TMenuItem
      Caption = '&Tools'
      object MIOpenInBrowser: TMenuItem
        Caption = '&Open in browser'
        Hint = 'Open all associated tasks in a task browser'
        ShortCut = 24642
        OnClick = MIOpenInBrowserClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MIExportAsHTML: TMenuItem
        Caption = 'Export as HTML'
        Hint = 'Export tasklist in HTML'
        ImageIndex = 42
        OnClick = MIExportAsHTMLClick
      end
      object MIExportAsText: TMenuItem
        Caption = 'Export as text'
        Hint = 'Export tasklist as a text file (importable to other tasklists)'
        OnClick = MIExportAsTextClick
      end
      object MIImportText: TMenuItem
        Caption = 'Import text'
        Hint = 'Import tasklist exported as text'
        OnClick = MIImportTextClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object MITransferTasklist: TMenuItem
        Caption = 'Transfer tasklist'
        Hint = 'Transfer the entire tasklist to another tasklist'
        OnClick = MITransferTasklistClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object MIVerify: TMenuItem
        Caption = 'Verify tasklist'
        Hint = 'Verify the integrity of the tasklist'
        ShortCut = 119
        OnClick = MIVerifyClick
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MIClose: TMenuItem
      Caption = 'Close'
      Hint = 'Close tasklist manager'
      ImageIndex = 72
      ShortCut = 27
      OnClick = MICloseClick
    end
    object N7: TMenuItem
      Caption = '-'
      Visible = False
    end
    object InvEditparamters1: TMenuItem
      Caption = 'Inv: Edit paramters'
      ShortCut = 16453
      Visible = False
      OnClick = InvEditparamters1Click
    end
    object InvTransferTaskOption: TMenuItem
      Caption = 'Inv: Transfer task with Ctrl+Shift+T'
      ShortCut = 24660
      Visible = False
      OnClick = MITransferTaskClick
    end
    object InvAnalysis1: TMenuItem
      Caption = 'Inv: Analysis'
      ShortCut = 41025
      Visible = False
      OnClick = InvAnalysis1Click
    end
  end
end
