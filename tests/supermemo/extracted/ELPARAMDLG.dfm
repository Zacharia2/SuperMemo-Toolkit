object ElParamDlg: TElParamDlg
  Left = 549
  Top = 178
  HelpContext = 16
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  ActiveControl = TitleEdit
  BorderStyle = bsDialog
  Caption = 'Element parameters'
  ClientHeight = 1120
  ClientWidth = 968
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -23
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 26
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 968
    Height = 1070
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = ElementTab
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 1030
    object ElementTab: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Element'
      object Bevel1: TBevel
        Left = 6
        Top = 20
        Width = 944
        Height = 939
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
        IsControl = True
      end
      object Title: TLabel
        Left = 26
        Top = 62
        Width = 41
        Height = 26
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Title'
        FocusControl = TitleEdit
        OnClick = TitleClick
      end
      object Label1: TLabel
        Left = 26
        Top = 120
        Width = 73
        Height = 26
        Hint = 'Current interval'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Interval'
        FocusControl = IntervalEdit
      end
      object Label2: TLabel
        Left = 26
        Top = 183
        Width = 146
        Height = 26
        Hint = 'Date of the next repetition'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Next repetition'
      end
      object Label3: TLabel
        Left = 26
        Top = 431
        Width = 89
        Height = 26
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&A-Factor'
        FocusControl = AFactor
      end
      object Label4: TLabel
        Left = 26
        Top = 369
        Width = 160
        Height = 26
        Hint = 
          'Acceptable probability of forgetting the element during repetiti' +
          'ons'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Forgetting index'
        FocusControl = FI
      end
      object Label5: TLabel
        Left = 26
        Top = 306
        Width = 72
        Height = 26
        Hint = 
          'Ordinal number that is low for important items and high for less' +
          ' important items'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Ordinal'
        FocusControl = Ordinal
      end
      object Label6: TLabel
        Left = 26
        Top = 497
        Width = 63
        Height = 26
        Hint = 'Concept group to which the element should be moved'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Group'
        FocusControl = TargetConceptCombo
      end
      object Label7: TLabel
        Left = 26
        Top = 621
        Width = 103
        Height = 26
        Hint = 'Comment associated with the element'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Co&mment:'
        FocusControl = Comment
      end
      object Label8: TLabel
        Left = 26
        Top = 558
        Width = 90
        Height = 26
        Hint = 'Template to be applied'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Template'
        FocusControl = TemplateCombo
      end
      object IntervalBtn: TSpeedButton
        Left = 618
        Top = 113
        Width = 35
        Height = 31
        Hint = 'Change the inter-repetition interval'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        OnClick = IntervalBtnClick
      end
      object ChooseDate: TSpeedButton
        Left = 618
        Top = 176
        Width = 35
        Height = 33
        Hint = 'Change the date of the next repetition'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        OnClick = IntervalBtnClick
      end
      object Label13: TLabel
        Left = 26
        Top = 246
        Width = 71
        Height = 26
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Priority'
        FocusControl = PriorityEdit
      end
      object IntervalEdit: TEdit
        Left = 305
        Top = 114
        Width = 312
        Height = 34
        Hint = 'Current interval'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
        Text = '1'
        OnEnter = IntervalEditEnter
        OnKeyPress = ParamsKeyPress
      end
      object NextRepetition: TEdit
        Left = 305
        Top = 177
        Width = 312
        Height = 34
        Hint = 'Date of the next repetition'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
        Text = '01.01.2000'
        OnKeyPress = ParamsKeyPress
      end
      object AFactor: TEdit
        Left = 305
        Top = 426
        Width = 355
        Height = 34
        Hint = 'Element'#39's A-Factor (see: supermemo.guru for definitions)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 6
        Text = '3.0'
        OnKeyPress = ParamsKeyPress
      end
      object FI: TEdit
        Left = 305
        Top = 363
        Width = 355
        Height = 34
        Hint = 
          'Acceptable probability of forgetting the element during repetiti' +
          'ons'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 5
        Text = '10'
        OnKeyPress = ParamsKeyPress
      end
      object Ordinal: TEdit
        Left = 305
        Top = 300
        Width = 355
        Height = 34
        Hint = 
          'Ordinal number that is low for important items and high for less' +
          ' important items'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 4
        Text = '100'
        OnKeyPress = ParamsKeyPress
      end
      object TargetConceptCombo: TComboBox
        Left = 215
        Top = 483
        Width = 709
        Height = 34
        Hint = 'Concept group to which the element belongs or should be moved'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Sorted = True
        TabOrder = 7
        Text = 'No change'
        OnChange = TargetConceptComboChange
        OnClick = TargetConceptComboClick
        OnDropDown = TargetConceptComboDropDown
        OnEnter = TargetConceptComboEnter
        OnKeyDown = TargetConceptComboKeyDown
        OnKeyPress = TargetConceptComboKeyPress
      end
      object Comment: TMemo
        Left = 26
        Top = 677
        Width = 898
        Height = 258
        Hint = 'Comment associated with the element (Ctrl+Enter for new line)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ScrollBars = ssVertical
        TabOrder = 9
        OnKeyDown = DescriptionKeyDown
        OnKeyPress = ParamsKeyPress
      end
      object ETypeGroup: TRadioGroup
        Left = 683
        Top = 156
        Width = 241
        Height = 315
        Hint = 
          'Choose an element type (e.g. items for review, topics for readin' +
          'g, concepts for neural review, etc.)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Element type'
        Items.Strings = (
          'Item'
          'Topic'
          'Concept'
          'Task')
        TabOrder = 10
        OnClick = ETypeGroupClick
      end
      object TitleEdit: TEdit
        Left = 104
        Top = 51
        Width = 820
        Height = 34
        Hint = 'Element'#39's title'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 0
        OnKeyPress = TitleEditKeyPress
      end
      object TemplateCombo: TComboBox
        Left = 215
        Top = 554
        Width = 709
        Height = 34
        Hint = 
          'Template that is currently applied or should be applied to the e' +
          'lement'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Sorted = True
        TabOrder = 8
        Text = 'None'
        OnChange = TemplateComboChange
        OnEnter = TemplateComboEnter
        OnKeyDown = TemplateComboKeyDown
        OnKeyPress = TemplateComboKeyPress
      end
      object PriorityEdit: TEdit
        Left = 305
        Top = 240
        Width = 355
        Height = 34
        Hint = 'Element'#39's priority'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 3
        Text = '2.5'
        OnKeyPress = ParamsKeyPress
      end
    end
    object TaskTab: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Task'
      ImageIndex = 1
      object Bevel3: TBevel
        Left = 0
        Top = 15
        Width = 951
        Height = 944
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
        IsControl = True
      end
      object DescriptionLabel: TLabel
        Left = 26
        Top = 101
        Width = 115
        Height = 26
        Hint = 'Task description'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Description'
        FocusControl = Description
      end
      object Label9: TLabel
        Left = 47
        Top = 707
        Width = 106
        Height = 26
        Hint = 'The date on which this task was introduced in the collection'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Introduced'
        FocusControl = Introduced
      end
      object Label10: TLabel
        Left = 47
        Top = 612
        Width = 85
        Height = 26
        Hint = 'Task priority equal Value/Time'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Val/Time'
        FocusControl = TaskPriority
      end
      object ValueLabel: TLabel
        Left = 47
        Top = 474
        Width = 55
        Height = 26
        Hint = 'Value of the task'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Value'
        FocusControl = Value
      end
      object TimeLabel: TLabel
        Left = 47
        Top = 543
        Width = 49
        Height = 26
        Hint = 'Time needed to execute the task (or other related cost)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Time'
        FocusControl = Time
      end
      object Tasklist: TLabel
        Left = 26
        Top = 26
        Width = 74
        Height = 26
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Ta&sklist'
        FocusControl = TaskCombo
      end
      object Label11: TLabel
        Left = 542
        Top = 612
        Width = 43
        Height = 26
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Max'
      end
      object Label12: TLabel
        Left = 542
        Top = 474
        Width = 40
        Height = 26
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Pos'
      end
      object Description: TMemo
        Left = 26
        Top = 144
        Width = 900
        Height = 320
        Hint = 'Task description (Ctrl+Enter for new line)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 0
        OnKeyDown = DescriptionKeyDown
        OnKeyPress = ParamsKeyPress
      end
      object RadioGroup1: TRadioGroup
        Left = 495
        Top = 684
        Width = 431
        Height = 264
        Hint = 
          'Function describing the changes of value before and after the de' +
          'adline'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Deadline &function'
        ItemIndex = 0
        Items.Strings = (
          'None'
          'Standard'
          'Post-Date'
          'Decline'
          'Post-Decline')
        TabOrder = 5
        OnClick = RadioGroup1Click
      end
      object Value: TEdit
        Left = 222
        Top = 474
        Width = 246
        Height = 34
        Hint = 'Value of the task'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 1
        Text = '10'
        OnKeyPress = ParamsKeyPress
      end
      object Time: TEdit
        Left = 222
        Top = 539
        Width = 704
        Height = 34
        Hint = 'Time needed to execute the task (or other related cost)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 2
        Text = '1'
        OnKeyPress = ParamsKeyPress
      end
      object TaskPriority: TEdit
        Left = 222
        Top = 605
        Width = 246
        Height = 34
        Hint = 'Task priority equal Value/Time'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ReadOnly = True
        TabOrder = 3
        Text = '10'
        OnKeyPress = ParamsKeyPress
      end
      object Introduced: TEdit
        Left = 222
        Top = 702
        Width = 261
        Height = 34
        Hint = 'The date on which this task was introduced in the collection'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 7
        OnKeyPress = ParamsKeyPress
      end
      object DeadlineEdit: TEdit
        Left = 222
        Top = 774
        Width = 261
        Height = 34
        Hint = 'Task deadline'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ReadOnly = True
        TabOrder = 4
        OnKeyPress = ParamsKeyPress
      end
      object Halftime: TEdit
        Left = 222
        Top = 848
        Width = 261
        Height = 34
        Hint = 
          'Deadline half-time (i.e. time at which value reaches 50% of dead' +
          'line maximum)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ReadOnly = True
        TabOrder = 6
        OnKeyPress = ParamsKeyPress
      end
      object TaskCombo: TComboBox
        Left = 186
        Top = 26
        Width = 740
        Height = 34
        Hint = 'Tasklist to which the task belongs'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 8
        Text = 'Tasks'
        OnChange = TaskComboChange
        OnClick = TaskComboClick
        OnDropDown = TaskComboDropDown
        OnEnter = TaskComboEnter
        OnKeyPress = TaskComboKeyPress
      end
      object DeadlineBtn: TButton
        Left = 36
        Top = 774
        Width = 176
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'D&eadline'
        TabOrder = 9
        OnClick = DeadlineBtnClick
      end
      object HalfTimeBtn: TButton
        Left = 36
        Top = 848
        Width = 176
        Height = 43
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Half-time'
        TabOrder = 10
        OnClick = HalfTimeBtnClick
      end
      object MaxPriority: TEdit
        Left = 626
        Top = 605
        Width = 300
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 11
      end
      object Position: TEdit
        Left = 626
        Top = 474
        Width = 300
        Height = 34
        Hint = 'Position of the task on the tasklist'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 12
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 1070
    Width = 968
    Height = 50
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    ButtonHeight = 40
    ButtonWidth = 100
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 1
    Wrapable = False
    ExplicitTop = 1030
    object HistoryButton: TToolButton
      Left = 0
      Top = 0
      Hint = 'View the history of repetitions for this element'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&History'
      ImageIndex = 3
      Style = tbsTextButton
      OnClick = HistoryClick
    end
    object FutureButton: TToolButton
      Left = 93
      Top = 0
      Hint = 'Expected future repetitions'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Future'
      ImageIndex = 4
      Style = tbsTextButton
      Visible = False
    end
    object Difficulty: TToolButton
      Left = 186
      Top = 0
      Hint = 'Display estimation fo element'#39's difficulty'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Difficulty'
      ImageIndex = 3
      Style = tbsTextButton
      OnClick = DifficultyClick
    end
    object ToolButton1: TToolButton
      Left = 279
      Top = 0
      Hint = 'Accept changes to element parameters'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'OK'
      ImageIndex = 0
      Style = tbsTextButton
      OnClick = OKBtnClick
    end
    object CancelBtn: TToolButton
      Left = 372
      Top = 0
      Hint = 'Close the dialog and discard the changes'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Cancel'
      ImageIndex = 1
      Style = tbsTextButton
      OnClick = CancelClick
    end
    object HelpButton: TToolButton
      Left = 465
      Top = 0
      Hint = 'Get help on element parameters dialog'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Help'
      ImageIndex = 2
      Style = tbsTextButton
      OnClick = HelpButtonClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 952
    Top = 104
    object Close1: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = CancelClick
    end
  end
end
