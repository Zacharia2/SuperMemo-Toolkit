object Workload: TWorkload
  Left = 549
  Top = 150
  HelpContext = 29
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Workload Calendar'
  ClientHeight = 805
  ClientWidth = 1059
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 0
    Top = 48
    Width = 1059
    Height = 757
    ActivePage = MonthlyTab
    Align = alClient
    HotTrack = True
    TabOrder = 0
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    ExplicitWidth = 1053
    ExplicitHeight = 740
    object DailyTab: TTabSheet
      Caption = '&Daily'
      object StringGrid1: TStringGrid
        Left = 111
        Top = 80
        Width = 505
        Height = 313
        ColCount = 4
        FixedCols = 0
        RowCount = 35
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goTabs, goThumbTracking]
        ScrollBars = ssVertical
        TabOrder = 0
        OnDblClick = StringGrid1DblClick
        OnDrawCell = StringGrid1DrawCell
        OnKeyDown = StringGrid1KeyDown
        OnMouseDown = StringGrid2MouseDown
        OnSelectCell = StringGrid1SelectCell
        ColWidths = (
          38
          78
          53
          15)
      end
    end
    object MonthlyTab: TTabSheet
      Caption = '&Monthly'
      ImageIndex = 1
      object StringGrid2: TStringGrid
        Left = 80
        Top = 32
        Width = 433
        Height = 305
        ColCount = 4
        FixedCols = 0
        RowCount = 35
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goTabs, goThumbTracking]
        ScrollBars = ssVertical
        TabOrder = 0
        OnDblClick = StringGrid2DblClick
        OnDrawCell = StringGrid1DrawCell
        OnKeyDown = StringGrid2KeyDown
        OnMouseDown = StringGrid2MouseDown
        OnSelectCell = StringGrid2SelectCell
        ColWidths = (
          38
          78
          53
          15)
      end
    end
    object GraphTab: TTabSheet
      Caption = '&Graph'
      ImageIndex = 2
    end
  end
  object ToolBar1: TToolBar
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 1049
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 108
    HideClippedButtons = True
    Images = AboutBox.VirtualImageList32
    List = True
    PopupMenu = PopupMenu1
    ShowCaptions = True
    AllowTextButtons = True
    TabOrder = 1
    Wrapable = False
    ExplicitWidth = 1043
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Hint = 'Open local menu'
      DropdownMenu = PopupMenu1
      ImageIndex = 47
      ImageName = 'icon_047'
    end
    object ToolButton9: TToolButton
      Left = 40
      Top = 0
      Width = 8
      Caption = 'ToolButton9'
      ImageIndex = 8
      ImageName = 'icon_008'
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 48
      Top = 0
      Hint = 'Go to the beginning of the schedule'
      ImageIndex = 131
      ImageName = 'icon_131'
      OnClick = HomeClick
    end
    object ToolButton4: TToolButton
      Left = 88
      Top = 0
      Hint = 'Move four panels back'
      ImageIndex = 171
      ImageName = 'icon_171'
      OnClick = Back4Click
    end
    object ToolButton5: TToolButton
      Left = 128
      Top = 0
      Hint = 'Move one panel back'
      ImageIndex = 133
      ImageName = 'icon_133'
      OnClick = BackClick
    end
    object ToolButton6: TToolButton
      Left = 168
      Top = 0
      Hint = 'Move one panel forward'
      ImageIndex = 134
      ImageName = 'icon_134'
      OnClick = AheadClick
    end
    object ToolButton7: TToolButton
      Left = 208
      Top = 0
      Hint = 'Move four panels forward'
      ImageIndex = 172
      ImageName = 'icon_172'
      OnClick = Ahead4Click
    end
    object ToolButton8: TToolButton
      Left = 248
      Top = 0
      Hint = 'Go to the furthest scheduled element'
      ImageIndex = 132
      ImageName = 'icon_132'
      OnClick = End_Click
    end
    object ToolButton10: TToolButton
      Left = 288
      Top = 0
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 8
      ImageName = 'icon_008'
      Style = tbsSeparator
    end
    object ZoomIn: TToolButton
      Left = 296
      Top = 0
      Hint = 'Zoom in the Calendar graph'
      Caption = 'ZoomIn'
      ImageIndex = 225
      ImageName = 'icon_225'
      OnClick = ZoomInClick
    end
    object ZoomOut: TToolButton
      Left = 336
      Top = 0
      Hint = 'Zoom out the Calendar graph'
      Caption = 'ZoomOut'
      ImageIndex = 226
      ImageName = 'icon_226'
      OnClick = ZoomOutClick
    end
    object ToolButton14: TToolButton
      Left = 376
      Top = 0
      Width = 8
      Caption = 'ToolButton14'
      ImageIndex = 15
      ImageName = 'icon_015'
      Style = tbsSeparator
    end
    object SmoothBtn: TToolButton
      Left = 384
      Top = 0
      Hint = 'Smooth up the graph by averaging neighboring entries'
      Caption = 'SmoothBtn'
      ImageIndex = 236
      ImageName = 'icon_236'
      OnClick = SmoothBtnClick
    end
    object ToolButton13: TToolButton
      Left = 424
      Top = 0
      Width = 8
      Caption = 'ToolButton13'
      ImageIndex = 15
      ImageName = 'icon_015'
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 432
      Top = 0
      Hint = 'View the selected entry'
      Caption = 'Browse'
      ImageIndex = 23
      ImageName = 'icon_023'
      Style = tbsTextButton
      OnClick = EyeButtonClick
    end
    object ExportWorkload: TToolButton
      Left = 524
      Top = 0
      Hint = 'Save data in an Excel file'
      Caption = 'Export'
      ImageIndex = 190
      ImageName = 'Export'
      Style = tbsTextButton
      OnClick = MIExportDataClick
    end
    object ToolButton12: TToolButton
      Left = 609
      Top = 0
      Width = 8
      Caption = 'ToolButton12'
      ImageIndex = 8
      ImageName = 'icon_008'
      Style = tbsSeparator
    end
    object TypeCombo: TComboBox
      Left = 617
      Top = 7
      Width = 222
      Height = 24
      Hint = 'Change the type of elements viewed'
      TabOrder = 0
      Text = 'Workload'
      OnChange = TypeComboChange
      Items.Strings = (
        'Workload'
        'Items only'
        'Topics only'
        'Retention'
        'Repetitions'
        'New items')
    end
    object ChangeType: TToolButton
      Left = 839
      Top = 0
      Hint = 'Change to the next display mode'
      Caption = 'Switch'
      ImageIndex = 232
      ImageName = 'Switch'
      Style = tbsTextButton
      OnClick = ChangeTypeClick
    end
    object FormatCombo: TComboBox
      Left = 924
      Top = 7
      Width = 222
      Height = 24
      Hint = 'Change the display format '
      TabOrder = 1
      Text = 'Default'
      OnChange = FormatComboChange
      Items.Strings = (
        'Default'
        'Full'
        'Classic'
        'Weekday'
        'Simple')
    end
    object WorkloadLabel: TLabel
      Left = 1146
      Top = 0
      Width = 17
      Height = 38
      Caption = 'XY'
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 18
    Top = 61
    object MIDaily: TMenuItem
      Caption = '&Daily workload'
      ShortCut = 32836
      OnClick = MIDailyClick
    end
    object MIMonthly: TMenuItem
      Caption = '&Monthly workload'
      Hint = 'Switch to the monthly view'
      ShortCut = 32845
      OnClick = MIMonthlyClick
    end
    object Workloadgraph1: TMenuItem
      Caption = '&Workload graph'
      ShortCut = 32839
      OnClick = Workloadgraph1Click
    end
    object N1: TMenuItem
      Caption = '-'
      Hint = '-'
    end
    object MIGoTo: TMenuItem
      Caption = '&Go to'
      Hint = 'Go to a selected day'
      ShortCut = 16455
      OnClick = MIGoToClick
    end
    object View1: TMenuItem
      Caption = '&Browse'
      Hint = 'Inspect the elements processed/scheduled on a selected date'
      ImageIndex = 1
      ShortCut = 13
      OnClick = EyeButtonClick
    end
    object MISwitchPanels: TMenuItem
      Caption = '&Switch panels'
      Hint = 'Switch between daily and monthly workloads'
      ShortCut = 16393
      OnClick = MISwitchPanelsClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MIExportData: TMenuItem
      Caption = 'Export data'
      Hint = 'Export data (e.g. to Excel)'
      OnClick = MIExportDataClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Close1: TMenuItem
      Caption = '&Close'
      ShortCut = 27
      OnClick = Close1Click
    end
  end
end
