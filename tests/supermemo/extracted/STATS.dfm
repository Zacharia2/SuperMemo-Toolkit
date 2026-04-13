object Stats: TStats
  Left = -5000
  Top = 159
  HelpContext = 19
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Statistics'
  ClientHeight = 899
  ClientWidth = 519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    7777777077777777077777777700000000000077000000077000000077700008
    88888800FFFFFFF00FFFFFFF0770008888888880FFFFFFFF0FFFFFFFF0700888
    8888888800000000000000000070088888888888888888888888888880700000
    000000000000000000000000007008880FFFFF8FFFFF8FFFFF8FFFFFF0700888
    0FFFFF8FFFFF8FFFFF8FFFFFF070000008888888888888888888888880700888
    0FFFFF8FFFFF8FFFFF8FFFFFF07008880FFFFF8FFFFF8FFFFF8FFFFFF0700000
    088888888888888888888888807008880FFFFF8FFFFF8FFFFF8FFFFFF0700888
    0FFFFF8FFFFF8FFFFF8FFFFFF070000008888888888888888888888880700888
    0FFFFF8FFFFF8FFFFF8FFFFFF07008880FFFFF8FFFFF8FFFFF8FFFFFF0700000
    088888888888888888888888807008880FFFFF8FFFFF8FFFFF8FFFFFF0700888
    0FFFFF8FFFFF8FFFFF8FFFFFF070000000000000000000000000000000700888
    0888880888880888880888888070088808888808888808888808888880000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0100803E0000001C0000001800000010000
    0001000000010000000100000001000000010000000100000001000000010000
    0001000000010000000100000001000000010000000100000001000000010000
    000100000001000000010000000300000003FFFFFFFFFFFFFFFFFFFFFFFF}
  KeyPreview = True
  PopupMenu = PopupMenu1
  Position = poDesigned
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 144
  TextHeight = 20
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 53
    Width = 513
    Height = 843
    Align = alClient
    ColCount = 2
    DefaultColWidth = 1000
    DefaultRowHeight = 26
    DrawingStyle = gdsGradient
    RowCount = 15
    FixedRows = 0
    GradientEndColor = 16777192
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowMoving, goEditing, goAlwaysShowEditor, goThumbTracking]
    ParentColor = True
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnKeyDown = StringGrid1KeyDown
    OnMouseDown = StringGrid1MouseDown
    OnMouseMove = StringGrid1MouseMove
    OnRowMoved = StringGrid1RowMoved
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 519
    Height = 50
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 50
    ButtonWidth = 42
    Caption = 'ToolBar1'
    GradientEndColor = 11982554
    Images = AboutBox.VirtualImageList32
    TabOrder = 1
    object ToolButton4: TToolButton
      Left = 0
      Top = 0
      Hint = 'Open local menu'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton4'
      DropdownMenu = PopupMenu1
      ImageIndex = 47
      ImageName = 'icon_047'
    end
    object ToolButton7: TToolButton
      Left = 42
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton7'
      ImageIndex = 1
      ImageName = 'icon_001'
      Style = tbsSeparator
    end
    object WorkloadBtn: TToolButton
      Left = 54
      Top = 0
      Hint = 'Inspect the calendar of repetitions'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ImageIndex = 7
      ImageName = 'icon_007'
      OnClick = WorkloadBtnClick
    end
    object AnalysisBtn: TToolButton
      Left = 96
      Top = 0
      Hint = 'Open the Analysis window'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ImageIndex = 179
      ImageName = 'icon_179'
      OnClick = AnalysisBtnClick
    end
    object Graphs4DBtn: TToolButton
      Left = 138
      Top = 0
      Hint = 'Open memory graphs window'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Graphs4DBtn'
      ImageIndex = 214
      ImageName = 'icon_214'
      OnClick = Graphs4DBtnClick
    end
    object ToolButton6: TToolButton
      Left = 180
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton6'
      ImageIndex = 0
      ImageName = 'icon_000'
      Style = tbsSeparator
    end
    object WarriorLayoutBtn: TToolButton
      Left = 192
      Top = 0
      Hint = 'Apply warrior layout'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ImageIndex = 3
      ImageName = 'icon_003'
      OnClick = WarriorLayoutBtnClick
    end
    object ToolButton8: TToolButton
      Left = 234
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton8'
      ImageIndex = 69
      ImageName = 'icon_069'
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 246
      Top = 0
      Hint = 
        'Open a help page with information about the Statistics window (F' +
        '1)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton5'
      ImageIndex = 68
      ImageName = 'icon_068'
      OnClick = ToolButton5Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 88
    Top = 256
    object MICalendar: TMenuItem
      Caption = 'Workload Calendar'
      Hint = 'Inspect the calendar of repetitions'
      ShortCut = 16471
      OnClick = MICalendarClick
    end
    object MIReport: TMenuItem
      Caption = '&Report'
      Hint = 'Export report file'
      OnClick = MIReportClick
    end
    object MIRestoreLayout: TMenuItem
      Caption = 'Restore layout'
      Hint = 'Restore the default layout'
      ShortCut = 16500
      OnClick = MIRestoreLayoutClick
    end
    object MIElementWindow: TMenuItem
      Caption = 'Element window'
      Hint = 'Return to the element window'
      ShortCut = 27
      OnClick = MIElementWindowClick
    end
  end
end
