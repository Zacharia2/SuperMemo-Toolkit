object PlanDlg: TPlanDlg
  Left = 506
  Top = 164
  HelpContext = 24
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Schedule plan'
  ClientHeight = 1070
  ClientWidth = 2458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  GlassFrame.Enabled = True
  PopupMenu = PopupMenu1
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 16
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 5
    Top = 102
    Width = 2448
    Height = 963
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    ColCount = 60
    DefaultColWidth = 96
    DefaultRowHeight = 36
    DrawingStyle = gdsGradient
    FixedColor = 14803425
    FixedCols = 2
    RowCount = 200
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowMoving, goColMoving, goEditing, goTabs, goThumbTracking, goFixedColClick, goFixedRowClick, goFixedHotTrack]
    TabOrder = 1
    StyleElements = [seFont]
    OnDblClick = StringGrid1DblClick
    OnDrawCell = StringGrid1DrawCell
    OnKeyDown = StringGrid1KeyDown
    OnKeyPress = StringGrid1KeyPress
    OnMouseDown = StringGrid1MouseDown
    OnMouseUp = StringGrid1MouseUp
    OnRowMoved = StringGrid1RowMoved
    OnSelectCell = StringGrid1SelectCell
    RowHeights = (
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36
      36)
  end
  object ToolBar1: TToolBar
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 2448
    Height = 87
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 87
    ButtonWidth = 71
    Images = AboutBox.VirtualImageList32
    ShowCaptions = True
    TabOrder = 0
    Wrapable = False
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 590
      Height = 87
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabOrder = 0
      object Label1: TLabel
        Left = 503
        Top = 19
        Width = 33
        Height = 16
        Hint = 'Determine the length of the schedule (in hours)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&hours'
        FocusControl = LenEdit
      end
      object LenEdit: TEdit
        AlignWithMargins = True
        Left = 396
        Top = 15
        Width = 98
        Height = 24
        Hint = 'Determine the length of the schedule (in hours)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 17
        Margins.Bottom = 5
        Alignment = taCenter
        TabOrder = 0
        Text = '16'
        OnChange = LenEditChange
        OnExit = LenEditExit
        OnKeyPress = LenEditKeyPress
      end
      object ComboBox1: TComboBox
        AlignWithMargins = True
        Left = 6
        Top = 15
        Width = 381
        Height = 24
        Hint = 'Select a schedule by its name'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoComplete = False
        Sorted = True
        TabOrder = 1
        OnChange = ComboBox1Change
        OnClick = ComboBox1Click
        OnDropDown = ComboBox1DropDown
        OnKeyPress = ComboBox1KeyPress
      end
    end
    object ToolButton4: TToolButton
      Left = 590
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton4'
      ImageIndex = 5
      ImageName = 'icon_005'
      Style = tbsSeparator
    end
    object MenuBtn: TToolButton
      Left = 602
      Top = 0
      Hint = 'Open schedule manager menu (Shift+F10)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = '&Menu'
      ImageIndex = 47
      ImageName = 'icon_047'
      Style = tbsTextButton
      OnClick = MenuBtnClick
    end
    object SaveBtn: TToolButton
      Left = 673
      Top = 0
      Hint = 'Save the schedule (Ctrl+S)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'Save'
      ImageIndex = 51
      ImageName = 'icon_051'
      Style = tbsTextButton
      OnClick = SaveBtnClick
    end
    object SetTimeBtn: TToolButton
      Left = 744
      Top = 0
      Hint = 
        'Set the current time as the beginning of the currently selected ' +
        'activity (Alt+B)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = '&Begin'
      ImageIndex = 174
      ImageName = 'icon_174'
      Style = tbsTextButton
      OnClick = SetTimeBtnClick
    end
    object ExportBtn: TToolButton
      Left = 815
      Top = 0
      Hint = 'Export schedule to a text file'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'Export'
      ImageIndex = 42
      ImageName = 'icon_042'
      ParentShowHint = False
      ShowHint = True
      Style = tbsTextButton
      OnClick = ExportBtnClick
    end
    object OffendersBtn: TToolButton
      Left = 886
      Top = 0
      Hint = 'Export activities that delay the schedule'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'Delays'
      ImageIndex = 15
      ImageName = 'icon_015'
      Style = tbsTextButton
      OnClick = MIDelaysClick
    end
    object EditBtn: TToolButton
      Left = 957
      Top = 0
      Hint = 
        'Edit the activity (Alt+Enter, Ctrl+E or double-click)(use Enter ' +
        'to edit in-place)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = '&Edit'
      ImageIndex = 43
      ImageName = 'icon_043'
      Style = tbsTextButton
      OnClick = EditBtnClick
    end
    object Totals: TToolButton
      Left = 1028
      Top = 0
      Hint = 
        'Display total time spent on individual activities (in a day, mon' +
        'th or year)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'Stats'
      ImageIndex = 177
      ImageName = 'icon_177'
      Style = tbsTextButton
      OnClick = TotalsClick
    end
    object AdjustBtn: TToolButton
      Left = 1099
      Top = 0
      Hint = 
        'Set the requested activity time lengths to optimally adjusted le' +
        'ngths'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'Adjust'
      ImageIndex = 119
      ImageName = 'icon_119'
      Style = tbsTextButton
      OnClick = AdjustBtnClick
    end
    object SplitBtn: TToolButton
      Left = 1170
      Top = 0
      Hint = 'Split the currently selected activity in two'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = 'S&plit'
      ImageIndex = 21
      ImageName = 'icon_021'
      Style = tbsTextButton
      OnClick = SplitBtnClick
    end
    object ToolButton2: TToolButton
      Left = 1241
      Top = 0
      Hint = 'Fix the starting time of an activity (Ctrl+F)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = '&Fix'
      ImageIndex = 64
      ImageName = 'icon_064'
      Style = tbsTextButton
      OnClick = MIFixStartTimeClick
    end
  end
  object PopupMenu1: TPopupMenu
    Images = AboutBox.VirtualImageList32
    Left = 384
    Top = 88
    object MIOpen: TMenuItem
      Caption = '&Open'
      Hint = 'Load an existing schedule from a file'
      ImageIndex = 2
      ShortCut = 16463
      OnClick = MIOpenClick
    end
    object MINew: TMenuItem
      Caption = '&New'
      Hint = 'Start creating a new schedule'
      ImageIndex = 39
      ShortCut = 16462
      OnClick = MINewClick
    end
    object Save1: TMenuItem
      Caption = 'Save'
      Hint = 'Save changes to the current schedule'
      ShortCut = 16467
      OnClick = SaveBtnClick
    end
    object MISaveAs: TMenuItem
      Caption = 'Save as'
      Hint = 'Save the schedule template for daily execution'
      ImageIndex = 51
      ShortCut = 24659
      OnClick = MISaveAsClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MIEdit: TMenuItem
      Caption = '&Edit'
      Hint = 
        'Edit the activity (Alt+Enter, Ctrl+E or double-click)(use Enter ' +
        'to edit in-place)'
      ImageIndex = 43
      ShortCut = 16453
      OnClick = MIEditClick
    end
    object MIEditParameters: TMenuItem
      Caption = '&Activities'
      Hint = 'Edit parameters of the selected activity'
      ShortCut = 24645
      OnClick = MIEditParametersClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object MIBegin1: TMenuItem
      Caption = '&Begin'
      Hint = 'Begin the selected activity'
      ShortCut = 32834
      OnClick = MIBegin2Click
    end
    object MIInsert: TMenuItem
      Caption = '&Insert'
      Hint = 'Insert a new actrivity in the selected row'
      ShortCut = 45
      OnClick = MIInsertClick
    end
    object MIDelete: TMenuItem
      Caption = '&Delete'
      Hint = 'Delete the currently selected actvity'
      ImageIndex = 16
      ShortCut = 16430
      OnClick = MIDeleteClick
    end
    object MISplit: TMenuItem
      Caption = '&Split'
      Hint = 'Split the selected activity in two'
      ImageIndex = 21
      ShortCut = 16468
      OnClick = MISplitClick
    end
    object MIMerge: TMenuItem
      Caption = '&Merge'
      Hint = 'Merge an activity with the one that follows it'
      OnClick = MIMergeClick
    end
    object MIFixStartTime: TMenuItem
      Caption = '&Fix'
      Hint = 'Set a fixed start time that cannot be changed automatically'
      ImageIndex = 64
      ShortCut = 16454
      OnClick = MIFixStartTimeClick
    end
    object MITerminate: TMenuItem
      Caption = '&Terminate'
      Hint = 'Terminate the schedule at the selected activity'
      ShortCut = 24589
      OnClick = MITerminateClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MIAlarm: TMenuItem
      Caption = '&Alarm'
      Hint = 'Alarm options'
      ImageIndex = 174
      OnClick = MIAlarmClick
      object MIBegin2: TMenuItem
        Caption = 'Begin'
        Hint = 
          'Begin the selected activity (and set the alarm to alert before t' +
          'he activity'#39's end)'
        ImageIndex = 174
        OnClick = MIBegin2Click
      end
      object MIREmind: TMenuItem
        Caption = 'Remind'
        Hint = 
          'Set the alarm to be raised at the end of the currently scheduled' +
          ' activity'
        OnClick = MIREmindClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object MISetAlarm: TMenuItem
        Caption = 'Set alarm'
        Hint = 'Set the alarm to be raised'
        OnClick = MISetAlarmClick
      end
      object MIStopAlarm: TMenuItem
        Caption = 'Stop alarm'
        Hint = 'Stop the alarm timer'
        OnClick = MIStopAlarmClick
      end
      object MIDisableAlarm: TMenuItem
        Caption = 'Disable alarm'
        Hint = 
          'Turn off automatic alarm at Begin and sharing the status of the ' +
          'alarm between collections'
        OnClick = MIDisableAlarmClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object MIChooseMP3: TMenuItem
        Caption = 'Choose music'
        Hint = 'Choose a sound file to play at alarm time'
        ImageIndex = 52
        OnClick = MIChooseMP3Click
      end
    end
    object Tools1: TMenuItem
      Caption = '&Tools'
      Hint = 'Plan management tools'
      ImageIndex = 156
      object MIExport: TMenuItem
        Caption = '&Export'
        Hint = 'Export the schedule in HTML format'
        ImageIndex = 42
        OnClick = MIExportClick
      end
      object otals1: TMenuItem
        Caption = '&Totals'
        Hint = 'Export statistics for a day, month or year'
        ImageIndex = 177
        RadioItem = True
        OnClick = TotalsClick
      end
      object MIDelays: TMenuItem
        Caption = '&Delays'
        Hint = 'List the activities that have contributed to schedule delays'
        ImageIndex = 15
        OnClick = MIDelaysClick
      end
      object MIArchive: TMenuItem
        Caption = 'Archive'
        Hint = 'Archive current schedule'
        ShortCut = 24641
        OnClick = MIArchiveClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MIAdjust: TMenuItem
        Caption = 'Adjust'
        Hint = 'Set all requested activity lengths to optimal value'
        ImageIndex = 84
        OnClick = AdjustBtnClick
      end
      object MIAdjustFromNow: TMenuItem
        Caption = 'Adjust from now'
        Hint = 'Set optimal activity length as of the present moment'
        OnClick = MIAdjustFromNowClick
      end
      object MIAdjustFromSelected: TMenuItem
        Caption = 'Adjust from selected'
        Hint = 'Set optimal activity length as of the selected activity'
        OnClick = MIAdjustFromSelectedClick
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object MIBeginAndShift: TMenuItem
        Caption = 'Begin and Shift'
        Hint = 
          'Set the beginning of the selected row to current time and optimi' +
          'ze fixed time shift'
        ShortCut = 16450
        OnClick = MIBeginAndShiftClick
      end
      object MIReset: TMenuItem
        Caption = '&Reset'
        Hint = 'Reset starting times of all activities'
        ImageIndex = 80
        OnClick = MIResetClick
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object MIImportDiary: TMenuItem
        Caption = '&Import diary'
        Hint = 'Import a folder of schedules into a diary collection'
        OnClick = MIImportDiaryClick
      end
      object MIImportStatistics: TMenuItem
        Caption = 'Import &statistics'
        Hint = 
          'Process a folder of schedules to compute monthly and annual stat' +
          'istics'
        OnClick = MIImportStatisticsClick
      end
      object MIArchiveSchedules: TMenuItem
        Caption = 'Archive schedules'
        Hint = 'Update statistics and archive all schedules'
        OnClick = MIArchiveSchedulesClick
      end
      object MIPasteFromDiary: TMenuItem
        Caption = 'Paste from diary'
        Hint = 
          'Convert HTML diary texts stored in the clipboard to a plan sched' +
          'ule'
        OnClick = MIPasteFromDiaryClick
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object MIProcessSchedules: TMenuItem
        Caption = 'Process schedules'
        Hint = 
          'Import diary, compute statistics and archive schedules from the ' +
          'default Plan folder'
        ShortCut = 119
        OnClick = MIProcessSchedulesClick
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Close1: TMenuItem
      Caption = '&Close'
      Hint = 'Close the daily schedule dialog box'
      ShortCut = 27
      OnClick = Close1Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object MISelectPlan: TMenuItem
      Caption = 'Inv: Select plan'
      Hint = 'Select a new schedule'
      ImageIndex = 33
      Visible = False
      OnClick = MISelectPlanClick
    end
    object InvBlockedShortcuts1: TMenuItem
      Caption = 'Inv: Blocked Shortcuts'
      Visible = False
      object InvNone1: TMenuItem
        Caption = 'Inv: Block Alt+S'
        ShortCut = 32851
        Visible = False
      end
      object Inv1: TMenuItem
        Caption = 'Inv: Block Alt+N'
        ShortCut = 32846
        Visible = False
      end
      object InvBlockF31: TMenuItem
        Caption = 'Inv: Block F3'
        ShortCut = 114
      end
      object InvBlockCtrlD1: TMenuItem
        Caption = 'Inv: Block Ctrl+D'
        ShortCut = 16452
      end
      object BlockCtrlR1: TMenuItem
        Caption = 'Block Ctrl+R'
        ShortCut = 16466
      end
      object Randomize1: TMenuItem
        Caption = 'Randomize'
        ShortCut = 122
      end
    end
    object InvSleepChart1: TMenuItem
      Caption = 'Inv: SleepChart'
      ShortCut = 123
      Visible = False
      OnClick = InvSleepChart1Click
    end
    object InvEdit1: TMenuItem
      Caption = 'Inv: Edit'
      ShortCut = 13
      Visible = False
      OnClick = EnterShortcutClick
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'SuperMemo Schedule|*.txt|Schedule Reports|*.htm'
    Title = 'Save schedule'
    Left = 528
    Top = 104
  end
  object OpenDialog1: TOpenDialog
    Left = 480
    Top = 104
  end
end
