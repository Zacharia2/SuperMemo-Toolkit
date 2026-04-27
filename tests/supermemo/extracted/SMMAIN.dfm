object SMMain: TSMMain
  Left = 617
  Top = 150
  HelpContext = 6
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  AlphaBlendValue = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'SuperMemo'
  ClientHeight = 2100
  ClientWidth = 3342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -44
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    000000000000000000C0C444440000044044444404400000CC0F0C4444000000
    000000000000000C30F0F0C40000000000000000F70000C00FFF0F0C00000000
    0000000FFF00CC0FFFFFF0F0C000000000000033F00C30F0FFFFFF0F0C000000
    0000033B00000FFF0FFFFFF0F0C00000000033B00000FFFFF0FFFFFF0F000000
    00033B0000000FFFFF0FFFFFF00000000033B000000000FFFFF0FFF000000000
    033B00000000000FFFFF0000000000003FF0000000000000FFF0000000000003
    0F000000055666550000000000000000B0000008886555666600000000000190
    0000008878677656655000000000099000000872D8EEEE655665000000000000
    0000482D2288ED7E6585800000000000000442D222EEDEE22658800000000000
    000DEEDEEEEDEDE22258850000000000000DEDE8EEDEEED22765650000000000
    0004DEE8EDEEEE2D2D265600000000000004DAEEDFEFEE22D227560000000000
    00048AEDF8FEFE2D2827560000000000000DADE7EF8FEFD228E6650000000000
    0004AADEFEF8F8EEAA8865000000000000004A8EEFEF8FEAAAD7600000000000
    00004DEDEE88F88AADA8600000000000000004EE8DEEEEEDDA78000000000000
    0000004DEEDEEEDEA880000000000000000000044EEDDDEE4400000000000000
    0000000004D444DD40000000000000000000000000000000000000000000FFFF
    FC03E409F003FFF1E00FFFE1C00FFFC10007FF820003FF060001FE0E0001FC1F
    0003F83F8007F07FC01FE0F800FFC1E001FF83C001FF078000FF0F00007F9F00
    003FFE00003FFE00001FFE00001FFE00001FFE00001FFE00001FFE00001FFE00
    001FFF00003FFF00003FFF80007FFFC000FFFFE001FFFFF807FFFFFFFFFF}
  Menu = TheMainMenu
  Position = poDesigned
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 144
  TextHeight = 60
  object MainImage: TImage
    Left = 708
    Top = 252
    Width = 158
    Height = 158
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
  end
  object MediaPlayer1: TMediaPlayer
    Left = 206
    Top = 286
    Width = 379
    Height = 45
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    DoubleBuffered = True
    Visible = False
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
  end
  object UserSound: TMediaPlayer
    Left = 213
    Top = 480
    Width = 379
    Height = 45
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    DeviceType = dtWaveAudio
    DoubleBuffered = True
    Visible = False
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
  end
  object FormatBar: TToolBar
    AlignWithMargins = True
    Left = 5
    Top = 66
    Width = 3332
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 387
    Caption = 'Format'
    DoubleBuffered = True
    DragKind = dkDock
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    GradientEndColor = 11982554
    Images = AboutBox.VirtualImageList24
    List = True
    ParentDoubleBuffered = False
    ParentFont = False
    AllowTextButtons = True
    TabOrder = 2
    Wrapable = False
    object ElMenu1: TToolButton
      Left = 0
      Top = 0
      Hint = 
        'Open element menu (Shift+F10) (same as right click over the elem' +
        'ent toolbar)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Background'
      DropdownMenu = ElWind.ElementMenu
      ImageIndex = 4
      ImageName = 'icon_004'
    end
    object CompMenu1: TToolButton
      Left = 40
      Top = 0
      Hint = 
        'Open component menu (Alt+F12)(same as right-click over the compo' +
        'nent)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'CompMenuButton'
      DropdownMenu = ElWind.ComponentMenu
      ImageIndex = 47
      ImageName = 'icon_047'
      OnClick = CompMenu2Click
    end
    object ToolButton30: TToolButton
      Left = 80
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton30'
      ImageIndex = 80
      ImageName = 'icon_080'
      Style = tbsSeparator
    end
    object CopyElementButton: TToolButton
      Left = 92
      Top = 0
      Hint = 'Copy current element to clipboard'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'CopyElementButton'
      ImageIndex = 81
      ImageName = 'icon_081'
      OnClick = CopyElementButtonClick
    end
    object PasteButton: TToolButton
      Left = 132
      Top = 0
      Hint = 
        'Paste element from clipboard and add it to the current concept g' +
        'roup'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'PasteButton'
      ImageIndex = 82
      ImageName = 'icon_082'
      OnClick = PasteButtonClick
    end
    object DeleteButton: TToolButton
      Left = 172
      Top = 0
      Hint = 'Delete the displayed element'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'DeleteButton'
      ImageIndex = 16
      ImageName = 'icon_016'
      OnClick = DeleteButtonClick
    end
    object ToolButton35: TToolButton
      Left = 212
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton35'
      ImageIndex = 85
      ImageName = 'icon_085'
      Style = tbsSeparator
    end
    object BoldButton: TToolButton
      Left = 224
      Top = 0
      Hint = 'Change the bold attribute of the font'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'BoldButton'
      ImageIndex = 11
      ImageName = 'icon_011'
      OnClick = BoldButtonClick
    end
    object ItalicButton: TToolButton
      Left = 264
      Top = 0
      Hint = 'Change the italic attribute of the font'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ItalicButton'
      ImageIndex = 32
      ImageName = 'icon_032'
      OnClick = ItalicButtonClick
    end
    object UnderlineButton: TToolButton
      Left = 304
      Top = 0
      Hint = 'Change the underline attribute of the font'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'UnderlineButton'
      ImageIndex = 62
      ImageName = 'icon_062'
      OnClick = UnderlineButtonClick
    end
    object ToolButton40: TToolButton
      Left = 344
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton40'
      ImageIndex = 27
      ImageName = 'icon_027'
      Style = tbsSeparator
    end
    object FontButton: TToolButton
      Left = 356
      Top = 0
      Hint = 'Set the font of the current component'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'FontButton'
      ImageIndex = 24
      ImageName = 'icon_024'
      OnClick = FontButtonClick
    end
    object FontColorButton: TToolButton
      Left = 396
      Top = 0
      Hint = 'Change the color of the current font'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'FontColorButton'
      ImageIndex = 25
      ImageName = 'icon_025'
      OnClick = FontColorButtonClick
    end
    object ToolButton41: TToolButton
      Left = 436
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton41'
      ImageIndex = 28
      ImageName = 'icon_028'
      Style = tbsSeparator
    end
    object FontUpButton: TToolButton
      Left = 448
      Top = 0
      Hint = 'Increase font size (Ctrl+])'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '27'
      ImageIndex = 27
      ImageName = 'icon_027'
      OnClick = FontUpButtonClick
    end
    object FontDownButton: TToolButton
      Left = 488
      Top = 0
      Hint = 'Decrease font size (Ctrl+[)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'FontDownButton'
      ImageIndex = 26
      ImageName = 'icon_026'
      OnClick = FontDownButtonClick
    end
    object ToolButton42: TToolButton
      Left = 528
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton42'
      ImageIndex = 29
      ImageName = 'icon_029'
      Style = tbsSeparator
    end
    object Subscript: TToolButton
      Left = 540
      Top = 0
      Hint = 'Change selected HTML text to subscript'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Subscript'
      ImageIndex = 92
      ImageName = 'icon_092'
      OnClick = SubscriptClick
    end
    object SuperScript: TToolButton
      Left = 580
      Top = 0
      Hint = 'Change selected HTML text to superscript'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SuperScript'
      ImageIndex = 93
      ImageName = 'icon_093'
      OnClick = SuperScriptClick
    end
    object ToolButton38: TToolButton
      Left = 620
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton38'
      ImageIndex = 86
      ImageName = 'icon_086'
      Style = tbsSeparator
    end
    object AlignLeft: TToolButton
      Left = 632
      Top = 0
      Hint = 'Align texts left'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'AlignLeft'
      ImageIndex = 77
      ImageName = 'icon_077'
      OnClick = AlignLeftClick
    end
    object AlignCenter: TToolButton
      Left = 672
      Top = 0
      Hint = 'Center texts'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'AlignCenter'
      ImageIndex = 78
      ImageName = 'icon_078'
      OnClick = AlignCenterClick
    end
    object AlignRight: TToolButton
      Left = 712
      Top = 0
      Hint = 'Align texts right'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'AlignRight'
      ImageIndex = 76
      ImageName = 'icon_076'
      OnClick = AlignRightClick
    end
    object ToolButton32: TToolButton
      Left = 752
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton32'
      ImageIndex = 82
      ImageName = 'icon_082'
      Style = tbsSeparator
    end
    object Bullets: TToolButton
      Left = 764
      Top = 0
      Hint = 'Add a bullet to the edited text (Ctrl+Shift+L)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Bullets'
      ImageIndex = 79
      ImageName = 'icon_079'
      OnClick = BulletsClick
    end
    object Numbers: TToolButton
      Left = 804
      Top = 0
      Hint = 
        'Convert text to a numbered list in rich text components (HTML or' +
        ' RTF)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Numbers'
      ImageIndex = 1
      ImageName = 'icon_001'
      OnClick = NumbersClick
    end
    object ToolButton36: TToolButton
      Left = 844
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton36'
      ImageIndex = 86
      ImageName = 'icon_086'
      Style = tbsSeparator
    end
    object Outdent: TToolButton
      Left = 856
      Top = 0
      Hint = 'Decrease HTML indent'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Outdent'
      ImageIndex = 91
      ImageName = 'icon_091'
      OnClick = OutdentClick
    end
    object Indent: TToolButton
      Left = 896
      Top = 0
      Hint = 'Increase HTML indent'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Indent'
      ImageIndex = 90
      ImageName = 'icon_090'
      OnClick = IndentClick
    end
    object ToolButton4: TToolButton
      Left = 936
      Top = 0
      Hint = 
        'Change the color of the current component, its background or of ' +
        'the entire element'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton4'
      ImageIndex = 17
      ImageName = 'icon_017'
      OnClick = ColorButtonClick
    end
    object ToolButton31: TToolButton
      Left = 976
      Top = 0
      Width = 11
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton31'
      ImageIndex = 81
      ImageName = 'icon_081'
      Style = tbsSeparator
    end
    object ToolButton6: TToolButton
      Left = 987
      Top = 0
      Hint = 'Align components in dragging and editing modes'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton6'
      ImageIndex = 102
      ImageName = 'icon_102'
      OnClick = AlignmentButton1Click
    end
    object ToolButton45: TToolButton
      Left = 1027
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton45'
      ImageIndex = 72
      ImageName = 'icon_072'
      Style = tbsSeparator
    end
    object SaveDefaultTemplateBtn: TToolButton
      Left = 1039
      Top = 0
      Hint = 
        'Save the looks of the element as the default template in the cur' +
        'rent concept group'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SaveDefaultTemplateBtn'
      ImageIndex = 170
      ImageName = 'icon_170'
      OnClick = SaveTemplateBtnClick
    end
    object TemplatesBtn: TToolButton
      Left = 1079
      Top = 0
      Hint = 'Apply a template selected from the template registry'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'TemplatesBtn'
      ImageIndex = 113
      ImageName = 'icon_113'
      OnClick = LoadTemplateBtnClick
    end
    object ToolButton43: TToolButton
      Left = 1119
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton43'
      ImageIndex = 82
      ImageName = 'icon_082'
      Style = tbsSeparator
    end
    object DisplayModeBtn: TToolButton
      Left = 1131
      Top = 0
      Hint = 'Switch to presentation mode (Esc)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'DisplayModeBtn'
      ImageIndex = 23
      ImageName = 'icon_023'
      OnClick = DisplayButtonClick
    end
    object EditModeBtn: TToolButton
      Left = 1171
      Top = 0
      Hint = 'Switch to editing mode (Ctrl+E)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'EditModeBtn'
      ImageIndex = 97
      ImageName = 'icon_097'
      OnClick = EditButtonClick
    end
    object DragModeBtn: TToolButton
      Left = 1211
      Top = 0
      Hint = 'Switch to dragging mode (Alt+click twice)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'DragModeBtn'
      ImageIndex = 101
      ImageName = 'icon_101'
      OnClick = DraggingButtonClick
    end
    object SwitchModeBtn2: TToolButton
      Left = 1251
      Top = 0
      Hint = 'Switch between display, editing, and size&drag modes'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SwitchModeBtn2'
      ImageIndex = 143
      ImageName = 'icon_143'
      OnClick = SwitchModeBtnClick
    end
  end
  object AlarmBar: TToolBar
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 3332
    Height = 51
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 51
    ButtonWidth = 120
    Caption = 'Alarm'
    DoubleBuffered = True
    DragKind = dkDock
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    GradientEndColor = 11982554
    Images = AboutBox.VirtualImageList24
    List = True
    ParentDoubleBuffered = False
    ParentFont = False
    AllowTextButtons = True
    TabOrder = 3
    Transparent = False
    Wrapable = False
    object AlarmDisplay: TPanel
      Left = 0
      Top = 0
      Width = 176
      Height = 51
      Hint = 'Alarm timer'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      BiDiMode = bdLeftToRight
      BorderStyle = bsSingle
      Caption = '0:00'
      Color = clWindow
      Ctl3D = False
      DoubleBuffered = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      StyleElements = []
      OnClick = AlarmDisplayClick
    end
    object SetAlarmButton: TToolButton
      Left = 176
      Top = 0
      Hint = 'Set the alarm timer'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Start'
      ImageIndex = 174
      ImageName = 'icon_174'
      Style = tbsTextButton
      OnClick = SetAlarmButtonClick
    end
    object StopAlarmBtn: TToolButton
      Left = 288
      Top = 0
      Hint = 'Stop the current alarm and hide the Alarm toolbar'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Stop'
      ImageIndex = 22
      ImageName = 'icon_022'
      Style = tbsTextButton
      OnClick = StopAlarmBtnClick
    end
    object TimerDisplay: TPanel
      Left = 400
      Top = 0
      Width = 176
      Height = 51
      Hint = 'Stopwatch (e.g. for measuring repetition time)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      BiDiMode = bdLeftToRight
      BorderStyle = bsSingle
      Caption = ' 00:00.000'
      Color = clBlack
      Ctl3D = False
      DoubleBuffered = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -26
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      StyleElements = []
    end
    object TimerButton: TToolButton
      Left = 576
      Top = 0
      Hint = 'Start or pause the learning time stopwatch'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Start'
      ImageIndex = 83
      ImageName = 'icon_083'
      Style = tbsTextButton
      OnClick = StartTimerButtonClick
    end
    object ToolButton25: TToolButton
      Left = 688
      Top = 0
      Hint = 'Reset the learning stopwatch'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Reset'
      ImageIndex = 173
      ImageName = 'icon_173'
      Style = tbsTextButton
      OnClick = ResetTimerClick
    end
  end
  object Reading: TToolBar
    AlignWithMargins = True
    Left = 5
    Top = 162
    Width = 3332
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 322
    Caption = 'Read'
    DoubleBuffered = True
    DragKind = dkDock
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    GradientEndColor = 11982554
    Images = AboutBox.VirtualImageList24
    List = True
    ParentDoubleBuffered = False
    ParentFont = False
    AllowTextButtons = True
    TabOrder = 4
    Wrapable = False
    object PasteArticle: TToolButton
      Left = 0
      Top = 0
      Hint = 'Paste an article to SuperMemo (Ctrl+N)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'PasteArticle'
      ImageIndex = 82
      ImageName = 'icon_082'
      OnClick = PasteArticleClick
    end
    object ToolButton39: TToolButton
      Left = 40
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton39'
      ImageIndex = 13
      ImageName = 'icon_013'
      Style = tbsSeparator
    end
    object RememberExtract: TToolButton
      Left = 52
      Top = 0
      Hint = 'Extract a fragment and memorize it'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'RememberExtract'
      ImageIndex = 144
      ImageName = 'icon_144'
      OnClick = RememberExtractClick
    end
    object ScheduleExtract: TToolButton
      Left = 92
      Top = 0
      Hint = 'Extract a fragment and schedule it for repetition on a given day'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ScheduleExtract'
      ImageIndex = 193
      ImageName = 'icon_193'
      OnClick = ScheduleExtractClick
    end
    object ToolButton49: TToolButton
      Left = 132
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton49'
      ImageIndex = 5
      ImageName = 'icon_005'
      Style = tbsSeparator
    end
    object RememberCloze: TToolButton
      Left = 144
      Top = 0
      Hint = 'Create a cloze deletion and memorize it (Alt+Z)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'RememberCloze'
      ImageIndex = 129
      ImageName = 'icon_129'
      OnClick = RememberClozeClick
    end
    object ScheduleCloze: TToolButton
      Left = 184
      Top = 0
      Hint = 
        'Create a cloze deletion and schedule it for repetition on a give' +
        'n day (Alt+Shift+Z)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ScheduleCloze'
      ImageIndex = 192
      ImageName = 'icon_192'
      OnClick = ScheduleClozeClick
    end
    object ToolButton53: TToolButton
      Left = 224
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton53'
      ImageIndex = 8
      ImageName = 'icon_008'
      Style = tbsSeparator
    end
    object TaskExtract: TToolButton
      Left = 236
      Top = 0
      Hint = 'Extract a fragment and place it on the selected tasklist'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'TaskExtract'
      ImageIndex = 151
      ImageName = 'icon_151'
      OnClick = TaskExtractClick
    end
    object ToolButton28: TToolButton
      Left = 276
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton28'
      ImageIndex = 13
      ImageName = 'icon_013'
      Style = tbsSeparator
    end
    object SplitBtn: TToolButton
      Left = 288
      Top = 0
      Hint = 'Split the article into smaller articles'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SplitBtn'
      ImageIndex = 185
      ImageName = 'icon_185'
      OnClick = SplitBtnClick
    end
    object ToolButton10: TToolButton
      Left = 328
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton10'
      ImageIndex = 164
      ImageName = 'icon_164'
      Style = tbsSeparator
    end
    object SendText: TToolButton
      Left = 340
      Top = 0
      Hint = 'Send selected text via e-mail'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SendText'
      ImageIndex = 130
      ImageName = 'icon_130'
      OnClick = SendTextClick
    end
    object SendFAQ: TToolButton
      Left = 380
      Top = 0
      Hint = 'Respond to selected text via FAQ dialog'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SendFAQ'
      ImageIndex = 159
      ImageName = 'icon_159'
      OnClick = SendFAQClick
    end
    object ToolButton29: TToolButton
      Left = 420
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton29'
      ImageIndex = 13
      ImageName = 'icon_013'
      Style = tbsSeparator
    end
    object ApplyHighlighter: TToolButton
      Left = 432
      Top = 0
      Hint = 'Apply highlighter font'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ApplyHighlighter'
      ImageIndex = 160
      ImageName = 'icon_160'
      OnClick = ApplyHighlighterClick
    end
    object ChooseHighlighter: TToolButton
      Left = 472
      Top = 0
      Hint = 'Choose highlighter font style or RTF highlight font'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ChooseHighlighter'
      ImageIndex = 161
      ImageName = 'icon_161'
      OnClick = ChooseHighlighterClick
    end
    object IgnoreText: TToolButton
      Left = 512
      Top = 0
      Hint = 'Ignore the selected text in further reading (Shift+Ctrl+I)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'IgnoreText'
      ImageIndex = 162
      ImageName = 'icon_162'
      OnClick = IgnoreTextClick
    end
    object ToolButton34: TToolButton
      Left = 552
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton34'
      ImageIndex = 1
      ImageName = 'icon_001'
      Style = tbsSeparator
    end
    object DelBeforeCursorBtn: TToolButton
      Left = 564
      Top = 0
      Hint = 'Delete texts before the cursor (e.g. after processing it)(Alt+\)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'DelBeforeCursorBtn'
      ImageIndex = 188
      ImageName = 'icon_188'
      OnClick = DelBeforeCursorBtnClick
    end
    object DelAfterCursorBtn: TToolButton
      Left = 604
      Top = 0
      Hint = 
        'Delete texts after the cursor (e.g. footnotes, adverts, etc.)(Al' +
        't+.)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'DelAfterCursorBtn'
      ImageIndex = 197
      ImageName = 'icon_197'
      OnClick = DelAfterCursorBtnClick
    end
    object SetReadPoint: TToolButton
      Left = 644
      Top = 0
      Hint = 'Set the read-point on the selected text (Ctrl+F7)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SetReadPoint'
      ImageIndex = 165
      ImageName = 'icon_165'
      OnClick = SetReadPointClick
    end
    object ToolButton12: TToolButton
      Left = 684
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton12'
      ImageIndex = 166
      ImageName = 'icon_166'
      Style = tbsSeparator
    end
    object GoToReadPoint: TToolButton
      Left = 696
      Top = 0
      Hint = 'Go to the read-point (Alt+F7)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'GoToReadPoint'
      ImageIndex = 164
      ImageName = 'icon_164'
      OnClick = GoToReadPointClick
    end
    object ClearReadPoint: TToolButton
      Left = 736
      Top = 0
      Hint = 'Delete the read-point (Shift+Ctrl+F7)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ClearReadPoint'
      ImageIndex = 163
      ImageName = 'icon_163'
      OnClick = ClearReadPointClick
    end
    object ToolButton5: TToolButton
      Left = 776
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 164
      ImageName = 'icon_164'
      Style = tbsSeparator
    end
    object WebSearchBtn: TToolButton
      Left = 784
      Top = 0
      Hint = 'Search the web for learning materials (Ctrl+F3)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'WebSearchBtn'
      ImageIndex = 187
      ImageName = 'icon_187'
      OnClick = WebSearchBtnClick
    end
  end
  object Compose: TToolBar
    AlignWithMargins = True
    Left = 5
    Top = 114
    Width = 3332
    Height = 38
    HelpContext = 24
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 40
    Caption = 'Compose'
    DoubleBuffered = True
    DragKind = dkDock
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    GradientEndColor = 11982554
    Images = AboutBox.VirtualImageList24
    List = True
    ParentDoubleBuffered = False
    ParentFont = False
    AllowTextButtons = True
    TabOrder = 5
    Wrapable = False
    object ElMenu2: TToolButton
      Left = 0
      Top = 0
      Hint = 
        'Open element menu (Shift+F10) (same as right click over the elem' +
        'ent toolbar)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DropdownMenu = ElWind.ElementMenu
      ImageIndex = 4
      ImageName = 'icon_004'
    end
    object CompMenu2: TToolButton
      Left = 40
      Top = 0
      Hint = 
        'Open component menu (Alt+F12)(same as right-click over the compo' +
        'nent)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DropdownMenu = ElWind.ComponentMenu
      ImageIndex = 47
      ImageName = 'icon_047'
    end
    object ViewSourceBtn: TToolButton
      Left = 80
      Top = 0
      Hint = 'View element source data without applying the template'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      Grouped = True
      ImageIndex = 80
      ImageName = 'icon_080'
      Style = tbsCheck
      OnClick = ViewSourceBtn1Click
    end
    object ToolButton69: TToolButton
      Left = 120
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton69'
      ImageIndex = 118
      ImageName = 'icon_118'
      Style = tbsSeparator
    end
    object HTMLBtn: TToolButton
      Left = 132
      Top = 0
      Hint = 
        'Create a formatted text component (HTML format interpreted as in' +
        ' Internet Explorer)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ImageIndex = 29
      ImageName = 'icon_029'
      OnClick = HTMButtonClick
    end
    object WebComponentBtn: TToolButton
      Left = 172
      Top = 0
      Hint = 
        'Create a formatted HTML text component compatible with Chrome (W' +
        'ebView)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'WebComponentBtn'
      ImageIndex = 96
      ImageName = 'icon_096'
      OnClick = WebButtonClick
    end
    object TextButton: TToolButton
      Left = 212
      Top = 0
      Hint = 'Create an unformatted text component (as in Notepad)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'TextButton'
      ImageIndex = 6
      ImageName = 'icon_006'
      OnClick = TextButtonClick
    end
    object ToolButton37: TToolButton
      Left = 252
      Top = 0
      Hint = 'Create a text input component (Spell-Pad)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton37'
      ImageIndex = 10
      ImageName = 'icon_010'
      OnClick = SpellButtonClick
    end
    object ToolButton70: TToolButton
      Left = 292
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton70'
      ImageIndex = 118
      ImageName = 'icon_118'
      Style = tbsSeparator
    end
    object ToolButton46: TToolButton
      Left = 304
      Top = 0
      Hint = 'Create an image component'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton46'
      ImageIndex = 30
      ImageName = 'icon_030'
      OnClick = ImageButtonClick
    end
    object ToolButton50: TToolButton
      Left = 344
      Top = 0
      Hint = 'Create a sound component'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton50'
      ImageIndex = 52
      ImageName = 'icon_052'
      OnClick = SoundButtonClick
    end
    object ToolButton51: TToolButton
      Left = 384
      Top = 0
      Hint = 'Create a video component'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton51'
      ImageIndex = 63
      ImageName = 'icon_063'
      OnClick = VideoButtonClick
    end
    object BinaryBtn: TToolButton
      Left = 424
      Top = 0
      Hint = 
        'Import any file that cannot be used with other components (e.g. ' +
        'PDF, DOC, HLP, CHM, etc.)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ImageIndex = 19
      ImageName = 'icon_019'
      OnClick = ProgramButtonClick
    end
    object CreateScript: TToolButton
      Left = 464
      Top = 0
      Hint = 'Create a program script component'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'CreateScript'
      ImageIndex = 45
      ImageName = 'icon_045'
      OnClick = CreateScriptClick
    end
    object ToolButton54: TToolButton
      Left = 504
      Top = 0
      Hint = 'Insert an OLE object (e.g. Excel spreadsheet or Word document)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton54'
      ImageIndex = 40
      ImageName = 'icon_040'
      OnClick = OLEButtonClick
    end
    object ToolButton71: TToolButton
      Left = 544
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton71'
      ImageIndex = 118
      ImageName = 'icon_118'
      Style = tbsSeparator
    end
    object ToolButton56: TToolButton
      Left = 556
      Top = 0
      Hint = 'Create an elliptic shape'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton56'
      ImageIndex = 59
      ImageName = 'icon_059'
      OnClick = EllipseButtonClick
    end
    object ToolButton57: TToolButton
      Left = 596
      Top = 0
      Hint = 'Create a rectangular shape'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton57'
      ImageIndex = 98
      ImageName = 'icon_098'
      OnClick = RectangleButtonClick
    end
    object ToolButton58: TToolButton
      Left = 636
      Top = 0
      Hint = 'Create a rounded rectangular shape'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton58'
      ImageIndex = 99
      ImageName = 'icon_099'
      OnClick = RRectangleButtonClick
    end
    object ToolButton72: TToolButton
      Left = 676
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton72'
      ImageIndex = 118
      ImageName = 'icon_118'
      Style = tbsSeparator
    end
    object PresentationModeBtn: TToolButton
      Left = 688
      Top = 0
      Hint = 'Switch to presentation mode (Esc)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'PresentationModeBtn'
      ImageIndex = 23
      ImageName = 'icon_023'
      OnClick = DisplayButtonClick
    end
    object ToolButton60: TToolButton
      Left = 728
      Top = 0
      Hint = 'Switch to editing mode (Alt+click)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton60'
      ImageIndex = 97
      ImageName = 'icon_097'
      OnClick = EditButtonClick
    end
    object ToolButton61: TToolButton
      Left = 768
      Top = 0
      Hint = 'Switch to dragging mode (Alt+click twice)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton61'
      ImageIndex = 101
      ImageName = 'icon_101'
      OnClick = DraggingButtonClick
    end
    object SwitchModeBtn: TToolButton
      Left = 808
      Top = 0
      Hint = 'Switch between display, editing, and size&drag modes'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SwitchModeBtn'
      ImageIndex = 143
      ImageName = 'icon_143'
      OnClick = SwitchModeBtnClick
    end
    object ToolButton73: TToolButton
      Left = 848
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton73'
      ImageIndex = 118
      ImageName = 'icon_118'
      Style = tbsSeparator
    end
    object NumberButton: TToolButton
      Left = 860
      Top = 0
      Hint = 'Display component number tags'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowAllUp = True
      Caption = 'NumberButton'
      ImageIndex = 9
      ImageName = 'icon_009'
      Style = tbsCheck
      OnClick = NumberButtonClick
    end
    object ToolButton64: TToolButton
      Left = 900
      Top = 0
      Hint = 'Align components in dragging and editing modes'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton64'
      ImageIndex = 102
      ImageName = 'icon_102'
      OnClick = AlignmentButton1Click
    end
    object ToolButton65: TToolButton
      Left = 940
      Top = 0
      Hint = 'Test the repetition cycle (Shift+Alt+L)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton65'
      ImageIndex = 34
      ImageName = 'L-Plate'
      OnClick = TestRepetitionClick
    end
  end
  object PlanAlarm: TMediaPlayer
    Left = 189
    Top = 372
    Width = 379
    Height = 45
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    DoubleBuffered = True
    Visible = False
    ParentDoubleBuffered = False
    TabOrder = 6
    OnNotify = PlanAlarmNotify
  end
  object ToolsBar: TToolBar
    AlignWithMargins = True
    Left = 5
    Top = 210
    Width = 3332
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 40
    Caption = 'ToolsBar'
    DoubleBuffered = True
    DragKind = dkDock
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    GradientEndColor = 11982554
    Images = AboutBox.VirtualImageList24
    List = True
    ParentDoubleBuffered = False
    ParentFont = False
    AllowTextButtons = True
    TabOrder = 7
    Wrapable = False
    object OpenCollectionBtn: TToolButton
      Left = 0
      Top = 0
      Hint = 'Open an existing collection'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Open collection'
      ImageIndex = 2
      ImageName = 'icon_002'
      OnClick = OpenCollectionBtnClick
    end
    object BackupBtn: TToolButton
      Left = 40
      Top = 0
      Hint = 'Create a quick backup'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'BackupBtn'
      ImageIndex = 100
      ImageName = 'icon_100'
      OnClick = BackupBtnClick
    end
    object ToolButton8: TToolButton
      Left = 80
      Top = 0
      Hint = 'Search for texts in the current collection (Ctrl+F)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Texts'
      ImageIndex = 5
      ImageName = 'icon_005'
      OnClick = MIFindElementsClick
    end
    object ToolButton9: TToolButton
      Left = 120
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton9'
      ImageIndex = 3
      ImageName = 'icon_003'
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 132
      Top = 0
      Hint = 'Open layout manager '
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton3'
      ImageIndex = 67
      ImageName = 'icon_067'
      OnClick = MILayoutsClick
    end
    object SaveLayoutBtn: TToolButton
      Left = 172
      Top = 0
      Hint = 'Save the current position of windows for later use'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Save default layout'
      ImageIndex = 65
      ImageName = 'icon_065'
      OnClick = MISaveDefaultLayoutClick
    end
    object RestoreLayoutBtn: TToolButton
      Left = 212
      Top = 0
      Hint = 'Restore the default position of windows saved earlier'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Apply default layout'
      ImageIndex = 66
      ImageName = 'icon_066'
      OnClick = MIApplyDefaultlayoutClick
    end
    object ToolButton14: TToolButton
      Left = 252
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton14'
      ImageIndex = 4
      ImageName = 'icon_004'
      Style = tbsSeparator
    end
    object WorkloadBtn: TToolButton
      Left = 264
      Top = 0
      Hint = 'Inspect the calendar of repetitions'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Workload'
      ImageIndex = 7
      ImageName = 'icon_007'
      OnClick = WorkloadBtnClick
    end
    object OutstandingBtn: TToolButton
      Left = 304
      Top = 0
      Hint = 'Display all elements scheduled for repetition for today'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'OutstandingBtn'
      ImageIndex = 34
      ImageName = 'L-Plate'
      OnClick = MIBrowseOutstandingClick
    end
    object PathListButton: TToolButton
      Left = 344
      Top = 0
      Hint = 
        'Show a window with the list of ancestors of the current element ' +
        '(Ctrl+Shift+X)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'PathListButton'
      ImageIndex = 176
      ImageName = 'icon_176'
      OnClick = PathListButtonClick
    end
    object ToolButton2: TToolButton
      Left = 384
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton1'
      ImageIndex = 177
      ImageName = 'icon_177'
      Style = tbsSeparator
    end
    object ImageRegistryBtn: TToolButton
      Left = 396
      Top = 0
      Hint = 'Review images used in the collection (open the image registry)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ImageRegistryBtn'
      ImageIndex = 30
      ImageName = 'icon_030'
      OnClick = MIImageClick
    end
    object SoundRegistryBtn: TToolButton
      Left = 436
      Top = 0
      Hint = 'Review sounds used in the collection (open the sound registry)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SoundRegistryBtn'
      ImageIndex = 52
      ImageName = 'icon_052'
      OnClick = MISoundClick
    end
    object ToolButton1: TToolButton
      Left = 476
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton1'
      ImageIndex = 53
      ImageName = 'icon_053'
      Style = tbsSeparator
    end
    object TasklistButton: TToolButton
      Left = 488
      Top = 0
      Hint = 'Open a registry with all tasklists'
      HelpContext = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'TasklistButton'
      ImageIndex = 151
      ImageName = 'icon_151'
      OnClick = TasklistButtonClick
    end
    object ToolButton24: TToolButton
      Left = 528
      Top = 0
      Width = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'ToolButton24'
      ImageIndex = 8
      ImageName = 'icon_008'
      Style = tbsSeparator
    end
    object HintsButton: TToolButton
      Left = 540
      Top = 0
      Hint = 
        'Turn on or off program hints (same as a double-click on the stat' +
        'us bar)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'HintsButton'
      ImageIndex = 229
      ImageName = 'icon_229'
      OnClick = MIHintsClick
    end
  end
  object TheMainMenu: TMainMenu
    BiDiMode = bdLeftToRight
    Images = AboutBox.VirtualImageList16
    ParentBiDiMode = False
    Left = 42
    Top = 329
    object MIFile: TMenuItem
      Caption = '&File'
      HelpContext = 30
      Hint = 'File operations on the collection'
      OnClick = MIFileClick
      object MIOpen: TMenuItem
        Caption = '&Open collection'
        Hint = 'Open an existing collection'
        ImageIndex = 2
        ImageName = 'icon_002'
        OnClick = MIOpenClick
      end
      object MIFavorites: TMenuItem
        Caption = '&Favorites'
        Default = True
        Hint = 'Build list of favorite collections for fast opening'
        ImageIndex = 180
        ImageName = 'icon_180'
        ShortCut = 16463
        OnClick = MIFavoritesClick
      end
      object MINew: TMenuItem
        Caption = 'New collection'
        Hint = 
          'Create a new collection to which you can add your own learning m' +
          'aterial'
        ImageIndex = 39
        ImageName = 'icon_039'
        OnClick = MINewClick
      end
      object Break1: TMenuItem
        Caption = '-'
      end
      object MIBackup: TMenuItem
        Caption = '&Backup'
        GroupIndex = 30
        Hint = 
          'Copy the entire collection to a backup folder with the current d' +
          'ate stamping (compare: File : Copy collection)'
        ShortCut = 8315
        OnClick = MIBackupClick
      end
      object MICopy: TMenuItem
        Caption = '&Copy collection'
        GroupIndex = 30
        Hint = 'Copy the entire collection'
        ImageIndex = 181
        ImageName = 'icon_181'
        ShortCut = 24643
        OnClick = MICopyClick
      end
      object MIDelete: TMenuItem
        Caption = '&Delete collection'
        GroupIndex = 30
        Hint = 'Delete the entire collection'
        ImageIndex = 88
        ImageName = 'icon_088'
        OnClick = MIDeleteClick
      end
      object MIRecover: TMenuItem
        Caption = '&Repair collection'
        GroupIndex = 30
        Hint = 'Verify and repair the collection'
        ImageIndex = 0
        ImageName = 'icon_000'
        ShortCut = 16507
        OnClick = MIRecoverClick
      end
      object MIMerge: TMenuItem
        Caption = '&Merge collection'
        GroupIndex = 30
        Hint = 
          'Add the currently opened collection material to another collecti' +
          'on'
        ImageIndex = 183
        ImageName = 'icon_183'
        OnClick = MIMergeClick
      end
      object N39: TMenuItem
        Caption = '-'
        GroupIndex = 30
      end
      object MIImport: TMenuItem
        Caption = '&Import'
        GroupIndex = 30
        Hint = 'Text, translation and audiovisual file import options'
        ImageIndex = 141
        ImageName = 'icon_141'
        object MIFolders: TMenuItem
          Caption = 'Files and folders'
          Hint = 'Import an entire folder of files and folders'
          OnClick = MIFoldersClick
        end
        object N52: TMenuItem
          Caption = '-'
        end
        object MIMCTText: TMenuItem
          Caption = 'Q&&A text'
          Hint = 'Import Q&&A text file or multiple choice text file'
          OnClick = MIMCTTextClick
        end
        object N55: TMenuItem
          Caption = '-'
        end
        object ImportQA_XML: TMenuItem
          Caption = 'XML &Import'
          Hint = 'Import an XML file to create a set of new elements'
          OnClick = ImportQA_XMLClick
        end
        object MIXMLSynchronization: TMenuItem
          Caption = '&XML Synchronize'
          Hint = 
            'Import an XML file to update element texts, pictures, learning p' +
            'rocess, etc.'
          OnClick = MIXMLSynchronizationClick
        end
        object N32: TMenuItem
          Caption = '-'
        end
        object MIImportEPub: TMenuItem
          Caption = 'EPub e-books'
          Hint = 'Import e-book files in EPub format'
          OnClick = MIImportEPubClick
        end
        object N10: TMenuItem
          Caption = '-'
        end
        object MIImportRepHistory: TMenuItem
          Caption = 'Repetition &history'
          Hint = 
            'Import or verify repetition history from a text file created wit' +
            'h Export : Repetition history'
          OnClick = MIImportRepHistoryClick
        end
        object MIImportLearning: TMenuItem
          Caption = '&Learning process'
          Hint = 'Import the learning process parameters from a plain text file'
          OnClick = MIImportLearningClick
        end
        object MIImportText: TMenuItem
          Caption = 'Source code'
          Hint = 'Import text from a file generated with Export : Source code'
          OnClick = MIImportTextClick
        end
        object MITranslationImport: TMenuItem
          Caption = '&Translation'
          Hint = 'Import translation text file into a translation registry'
          OnClick = MITranslationImportClick
        end
      end
      object MIExport: TMenuItem
        Caption = '&Export'
        GroupIndex = 30
        Hint = 'Text and translation file export options'
        ImageIndex = 42
        ImageName = 'icon_042'
        object MIExportDocument: TMenuItem
          Caption = '&Document'
          Hint = 'Export the entire collection as a single HTML document'
          OnClick = MIExportDocumentClick
        end
        object MIExportQA: TMenuItem
          Caption = '&Q&&A text file'
          Hint = 
            'Export the collection in the text form for a subset import to Su' +
            'perMemo'
          OnClick = MIExportQAClick
        end
        object MIExportAsXML: TMenuItem
          Caption = '&XML'
          Hint = 'Export the collection as XML'
          OnClick = MIExportAsXMLClick
        end
        object N53: TMenuItem
          Caption = '-'
        end
        object MIHTMLExport: TMenuItem
          Caption = '&HTML'
          Hint = 'Export the outline of the collection for publishing on the web'
          OnClick = MIHTMLExportClick
        end
        object MIExportLearning: TMenuItem
          Caption = '&Learning process'
          Hint = 'Save the parameters of the learning process in a text file'
          OnClick = MIExportLearningClick
        end
        object MIExportRepHistory: TMenuItem
          Caption = 'Repetition &history'
          Hint = 'Export repetition history (for backup or research)'
          OnClick = MIExportRepHistoryClick
        end
        object MIExportText: TMenuItem
          Caption = 'Source text'
          Hint = 'Export collection source code in the text format'
          OnClick = MIExportTextClick
        end
        object MITransferSubset: TMenuItem
          Caption = 'Transfer subset'
          Hint = 
            'Replicate a set of elements by transferring their copies taken f' +
            'rom a subset to another collection'
          OnClick = MITransferSubsetClick
        end
        object N41: TMenuItem
          Caption = '-'
        end
        object Lexicon1: TMenuItem
          Caption = 'Lex&icon'
          Hint = 'Export lexicon in the order of word-appearance in the collection'
          OnClick = Lexicon1Click
        end
      end
      object Break3: TMenuItem
        Caption = '-'
        GroupIndex = 30
      end
      object MIFileTools: TMenuItem
        Caption = '&Tools'
        GroupIndex = 30
        Hint = 'Copy, move or delete a collection'
        ImageIndex = 156
        ImageName = 'icon_156'
        object MICollectionSize: TMenuItem
          Caption = 'Collection size'
          Hint = 'Check the size of the collection'
          OnClick = MICollectionSizeClick
        end
        object N57: TMenuItem
          Caption = '-'
        end
        object MIViewHTML: TMenuItem
          Caption = 'View as &HTML'
          GroupIndex = 30
          Hint = 'View the collection as HTML'
          OnClick = MIViewHTMLClick
        end
        object MIReport: TMenuItem
          Caption = '&View report'
          GroupIndex = 30
          Hint = 'View report files in your default text editor'
          OnClick = MIReportClick
        end
        object MIViewFAQ: TMenuItem
          Caption = '&View FAQs'
          GroupIndex = 30
          Hint = 'View FAQ file generated with incremental reading'
          OnClick = MIViewFAQClick
        end
        object N34: TMenuItem
          Caption = '-'
          GroupIndex = 30
        end
        object MIReset: TMenuItem
          Caption = 'Reset collection'
          GroupIndex = 30
          Hint = 
            'Return the collection to the state before the beginning of the l' +
            'earning process'
          OnClick = MIResetClick
        end
        object Break8: TMenuItem
          Caption = '-'
          GroupIndex = 30
        end
        object MIMove: TMenuItem
          Caption = 'Move co&llection'
          GroupIndex = 30
          Hint = 'Move collection files to a new location'
          OnClick = MIMoveClick
        end
        object MIRename: TMenuItem
          Caption = '&Rename collection'
          GroupIndex = 30
          Hint = 
            'Change the name of collection files (this operation is very sens' +
            'itive to hardware failures)'
          OnClick = MIRenameClick
        end
        object Break9: TMenuItem
          Caption = '-'
          GroupIndex = 30
        end
        object MIGarbage: TMenuItem
          Caption = '&Garbage'
          GroupIndex = 30
          Hint = 'Delete temporary files, report files and subset files '
          OnClick = MIGarbageClick
        end
      end
      object MIProperties: TMenuItem
        Caption = '&Properties'
        GroupIndex = 30
        Hint = 
          'Display the most important information about the current collect' +
          'ion'
        OnClick = MIPropertiesClick
      end
      object Break2: TMenuItem
        Caption = '-'
        GroupIndex = 30
      end
      object MIInstallation: TMenuItem
        Caption = '&Installation'
        GroupIndex = 30
        HelpContext = 17
        Hint = 'Installation options'
        OnClick = MIInstallationClick
        object MIInputPassword: TMenuItem
          Caption = '&Input password'
          HelpContext = 17
          Hint = 
            'Provide the registration password to complete the registration p' +
            'rocedure'
          ShortCut = 16457
          OnClick = MIInputPasswordClick
        end
        object MIRequestPassword: TMenuItem
          Caption = '&Request password'
          HelpContext = 17
          Hint = 
            'Send an e-mail to SuperMemo World with a request for the registr' +
            'ation password'
          OnClick = MIRequestPasswordClick
        end
        object BreakRegistration1: TMenuItem
          Caption = '-'
        end
        object MIInstallIcons: TMenuItem
          Caption = 'Install &icons'
          Hint = 'Install SuperMemo icons on the desktop and Start menu'
          OnClick = MIInstallIconsClick
        end
        object BreakRegistration2: TMenuItem
          Caption = '-'
        end
        object MIUnregister: TMenuItem
          Caption = '&Lock'
          HelpContext = 17
          Hint = 
            'Lock the currently used collection (e.g. for redistribution on t' +
            'he web)'
          OnClick = MIUnregisterClick
        end
        object MIPublish: TMenuItem
          Caption = '&Publish'
          Hint = 'Reset, clean and unregister a collection for publishing'
          OnClick = MIPublishClick
        end
        object N56: TMenuItem
          Caption = '-'
        end
        object MIOwner: TMenuItem
          Caption = 'Owner'
          Hint = 'Insert the name of the owner of the SuperMemo license'
          OnClick = MIOwnerClick
        end
        object MIAuthor: TMenuItem
          Caption = 'Author'
          Hint = 
            'Insert the name of the author of the collection (e.g. for redist' +
            'ribution)'
          OnClick = MIAuthorClick
        end
      end
      object Break4: TMenuItem
        Caption = '-'
        GroupIndex = 30
        Visible = False
      end
      object MILevel: TMenuItem
        Caption = '&Level'
        GroupIndex = 30
        Hint = 'Determine the level of complexity of SuperMemo'
        OnClick = MILevelClick
        object MIBeginner: TMenuItem
          Caption = '&Beginner'
          Hint = 'Go to the beginner level with only minimum options available'
          OnClick = ActBeginnerExecute
        end
        object MIBasic: TMenuItem
          Caption = 'Ba&sic'
          Hint = 
            'Go to the basic level that provides more options than the beginn' +
            'er level'
          OnClick = ActBasicExecute
        end
        object MIMiddle: TMenuItem
          Caption = '&Middle'
          Hint = 
            'Go to the medium-advanced level that is an introduction to the p' +
            'rofessional level in SuperMemo'
          OnClick = ActMiddleExecute
        end
        object MIProfessional: TMenuItem
          Caption = '&Professional'
          Hint = 
            'Go to the professional level of SuperMemo and make all options a' +
            'vailable'
          OnClick = ActProfessionalExecute
        end
        object LevelBreak: TMenuItem
          Caption = '-'
        end
        object MIWarrior: TMenuItem
          Caption = 'Warrior layout'
          Hint = 'Use the full professional level with an advanced warrior layout'
          OnClick = MIWarriorClick
        end
        object N51: TMenuItem
          Caption = '-'
        end
        object MINextLevel: TMenuItem
          Caption = '&Next level'
          Hint = 'Switch to the next difficulty level'
          ShortCut = 49275
          OnClick = ActNextLevelExecute
        end
        object MIPreviousLevel: TMenuItem
          Caption = 'Previous level'
          Hint = 'Switch to a previous level'
          ShortCut = 57467
          OnClick = ActPrevLevelExecute
        end
        object N50: TMenuItem
          Caption = '-'
        end
        object MIInvisibleWorkload: TMenuItem
          Caption = 'Inv: Workload'
          ShortCut = 16471
          Visible = False
          OnClick = MIInvisibleWorkloadClick
        end
      end
      object N25: TMenuItem
        Caption = '-'
        GroupIndex = 30
      end
      object MIProcessCollection: TMenuItem
        Caption = 'Process collection>'
        GroupIndex = 30
        Hint = 'Execute operations on all elements in the collection'
        OnClick = MIProcessCollectionClick
      end
      object BreakLevel: TMenuItem
        Caption = '-'
        GroupIndex = 30
      end
      object MIExit: TMenuItem
        Caption = 'E&xit'
        GroupIndex = 30
        Hint = 'Exit SuperMemo'
        ShortCut = 32883
        OnClick = MIExitClick
      end
      object BreakExit: TMenuItem
        Caption = '-'
        GroupIndex = 30
        Visible = False
      end
      object MI1: TMenuItem
        Caption = '&1'
        GroupIndex = 30
        Hint = 'Open one of the recently used collections'
        Visible = False
        OnClick = ChooseFromPickList
      end
      object MI2: TMenuItem
        Caption = '&2'
        GroupIndex = 30
        Hint = 'Open one of the recently used collections'
        Visible = False
        OnClick = ChooseFromPickList
      end
      object MI3: TMenuItem
        Caption = '&3'
        GroupIndex = 30
        Hint = 'Open one of the recently used collections'
        Visible = False
        OnClick = ChooseFromPickList
      end
      object MI4: TMenuItem
        Caption = '&4'
        GroupIndex = 30
        Hint = 'Open one of the recently used collections'
        Visible = False
        OnClick = ChooseFromPickList
      end
      object MI5: TMenuItem
        Caption = '&5'
        GroupIndex = 30
        Hint = 'Open one of the recently used collections'
        Visible = False
        OnClick = ChooseFromPickList
      end
      object MI6: TMenuItem
        Caption = '&6'
        GroupIndex = 30
        Hint = 'Open one of the recently used collections'
        Visible = False
        OnClick = ChooseFromPickList
      end
      object MI7: TMenuItem
        Caption = '&7'
        GroupIndex = 30
        Hint = 'Open one of the recently used collections'
        Visible = False
        OnClick = ChooseFromPickList
      end
      object MI8: TMenuItem
        Caption = '&8'
        GroupIndex = 30
        Hint = 'Open one of the recently used collections'
        Visible = False
        OnClick = ChooseFromPickList
      end
      object MI9: TMenuItem
        Caption = '&9'
        GroupIndex = 30
        Hint = 'Open one of the recently used collections'
        Visible = False
        OnClick = ChooseFromPickList
      end
      object MI10: TMenuItem
        Caption = '1&0'
        GroupIndex = 30
        Hint = 'Open one of the recently used collections'
        Visible = False
        OnClick = ChooseFromPickList
      end
      object MI11: TMenuItem
        Caption = '11 (dummy)'
        GroupIndex = 30
        Visible = False
      end
    end
    object MIEdit: TMenuItem
      Caption = '&Edit'
      GroupIndex = 2
      HelpContext = 1
      Hint = 'Edit the collection by adding elements, imports, etc.'
      OnClick = MIEditClick
      object MIAddItem: TMenuItem
        Caption = 'Add a new &item'
        Default = True
        Hint = 'Add a new item using the default item template'
        ImageIndex = 150
        ImageName = 'icon_150'
        ShortCut = 32833
        OnClick = MIAddItemClick
      end
      object MIPasteArticle: TMenuItem
        Caption = 'Add a new &article'
        Hint = 'Paste an article and add it to the current concept group'
        ImageIndex = 82
        ImageName = 'icon_082'
        ShortCut = 16462
        OnClick = MIAddArticleClick
      end
      object MIAddNewTask: TMenuItem
        Caption = 'Add a new task'
        Hint = 'Add a new task to the current tasklist'
        ImageIndex = 151
        ImageName = 'icon_151'
        ShortCut = 32880
        OnClick = ActAddTaskExecute
      end
      object MIAddNote: TMenuItem
        Caption = 'Add a note'
        Hint = 'Add a new empty topic to the current concept group'
        ImageIndex = 140
        ImageName = 'icon_140'
        ShortCut = 32846
        OnClick = MIAddNoteClick
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object MIWebImport: TMenuItem
        Caption = 'Web import'
        Hint = 'Import articles from MS Edge'
        ImageIndex = 247
        ImageName = 'icon_247'
        ShortCut = 8311
        OnClick = MIWebImportClick
      end
      object MIIEImport: TMenuItem
        Caption = 'Internet Explorer'
        Hint = 'Import pages from Internet Explorer'
        ImageIndex = 141
        ImageName = 'icon_141'
        object ImportWebPages: TMenuItem
          Caption = 'Import'
          Hint = 'Import web pages from open instances of Internet Explorer'
          ShortCut = 24641
          OnClick = ImportWebPagesClick
        end
        object MIWikipedia: TMenuItem
          Caption = 'Wikipedia'
          Hint = 'Import articles from Wikipedia'
          ImageIndex = 190
          ImageName = 'Export'
          ShortCut = 24663
          OnClick = MIWikipediaClick
        end
        object MIYouTube: TMenuItem
          Caption = 'YouTube'
          Hint = 'Import YouTube videos for incremental learning'
          ImageIndex = 191
          ImageName = 'icon_191'
          ShortCut = 24665
          OnClick = MIYouTubeClick
        end
        object MIImportPictures: TMenuItem
          Caption = 'Pictures'
          Hint = 'Import pictures opened in pages in Internet Explorer'
          ImageIndex = 195
          ImageName = 'icon_195'
          OnClick = MIImportPicturesClick
        end
      end
      object MIImportMail: TMenuItem
        Caption = 'Mail import'
        Hint = 'Import mail from Windows (Live) Mail or MS Outlook'
        ImageIndex = 198
        ImageName = 'icon_198'
        ShortCut = 8307
        OnClick = MIImportMailClick
      end
      object MIOpenWebLinks: TMenuItem
        Caption = '&Open web links'
        Hint = 
          'Open all web links of the current element in separate browser wi' +
          'ndows'
        OnClick = MIOpenWebLinksClick
      end
      object N36: TMenuItem
        Caption = '-'
      end
      object MIAddComponents: TMenuItem
        Caption = 'Add components'
        Hint = 'Add components to the current element'
        object MIAddImage: TMenuItem
          Caption = '&Image'
          Hint = 'Add a new image component'
          ImageIndex = 30
          ImageName = 'icon_030'
          OnClick = MIAddImageClick
        end
        object MIAddSound: TMenuItem
          Caption = 'Soun&d'
          Hint = 'Add a new sound component'
          ImageIndex = 52
          ImageName = 'icon_052'
          OnClick = MIAddSoundClick
        end
        object MIAddVideoComponent: TMenuItem
          Caption = '&Video'
          Hint = 'Add a new video component'
          ImageIndex = 63
          ImageName = 'icon_063'
          OnClick = MIAddVideoComponentClick
        end
        object MIAddHTML: TMenuItem
          Caption = '&HTML'
          Hint = 'Add a new HTML component'
          ImageIndex = 29
          ImageName = 'icon_029'
          OnClick = MIAddHTMLClick
        end
        object MIAddText: TMenuItem
          Caption = '&Text'
          Hint = 'Create a new text component'
          ImageIndex = 6
          ImageName = 'icon_006'
          OnClick = MIAddTextClick
        end
        object MIAddSpell: TMenuItem
          Caption = '&Spell'
          Hint = 'Add a new spell-pad component'
          ImageIndex = 10
          ImageName = 'icon_010'
          OnClick = MIAddSpellClick
        end
      end
      object MIEditText: TMenuItem
        Caption = '&Registry texts'
        GroupIndex = 1
        Hint = 'Search for texts in the text registry'
        ImageIndex = 43
        ImageName = 'icon_043'
        OnClick = MIEditTextClick
        object Title1: TMenuItem
          Caption = 'Edit &title'
          Hint = 'Edit the title of the current element'
          ShortCut = 32852
          OnClick = Title1Click
        end
        object N11: TMenuItem
          Caption = '-'
        end
        object MIEditFirstQ: TMenuItem
          Caption = 'Edit first &question'
          Hint = 'Edit the first question component'
          OnClick = MIEditFirstQClick
        end
        object MIEditFirstA: TMenuItem
          Caption = 'Edit first &answer'
          Hint = 'Edit the first answer component'
          OnClick = MIEditFirstAClick
        end
        object MIEditTexts: TMenuItem
          Caption = '&Edit all'
          Default = True
          Hint = 'Set all text components in editing mode'
          ImageIndex = 97
          ImageName = 'icon_097'
          OnClick = MIEditTextsClick
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object MIAddPronunciation: TMenuItem
          Caption = 'Add pronunciation'
          Hint = 'Add a new phonetic transcription entry in the phonetic registry'
          OnClick = MIAddPronunciationClick
        end
        object N4: TMenuItem
          Caption = '-'
        end
        object MIApplyFilter: TMenuItem
          Caption = '&Apply filter'
          GroupIndex = 1
          Hint = 
            'Apply a filter file to the entire collection (e.g. to replace a ' +
            'group of strings)'
          OnClick = MIApplyFilterClick
        end
      end
      object N01: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object MICreateConcept: TMenuItem
        Caption = 'Create a concept'
        GroupIndex = 1
        Hint = 
          'Create a new concept (e.g. as a starting point for a new concept' +
          ' group)'
        OnClick = MICreateConceptClick
      end
      object MICreateTasklist: TMenuItem
        Caption = 'Create a tasklist'
        GroupIndex = 1
        Hint = 'Create a new tasklist'
        OnClick = MICreateTasklistClick
      end
      object N19: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object MIDeleteElement: TMenuItem
        Caption = '&Delete element'
        GroupIndex = 1
        Hint = 'Delete the element currently displayed in the element window'
        ImageIndex = 16
        ImageName = 'icon_016'
        ShortCut = 24622
        OnClick = MIDeleteElementClick
      end
      object MIDeleteComponents: TMenuItem
        Caption = 'Delete components'
        GroupIndex = 1
        Hint = 'Delete all components in the current element'
        OnClick = MIDeleteComponentsClick
      end
      object MIMenus: TMenuItem
        Caption = '&Menus'
        GroupIndex = 1
        Hint = 'Access pop-up menus of currently available windows'
        object MIElementMenu: TMenuItem
          Caption = '&Element>'
          Hint = 'Bring up the pop-up menu of the element window'
          ShortCut = 32889
          OnClick = MIElementMenuClick
        end
        object MIComponentMenu: TMenuItem
          Caption = 'C&omponent>'
          Hint = 
            'Bring up the pop-up menu of the current component in the element' +
            ' window'
          ShortCut = 32891
          OnClick = MIComponentMenuClick
        end
        object MIContentsMenu: TMenuItem
          Caption = '&Contents>'
          Hint = 'Bring up the pop-up menu of the Contents window'
          OnClick = MIContentsMenuClick
        end
        object MIBrowserMenu: TMenuItem
          Caption = '&Browser>'
          Hint = 'Bring up the pop-up menu of the current browser'
          OnClick = MIBrowserMenuClick
        end
        object MIRegistryMenu: TMenuItem
          Caption = '&Registry>'
          Hint = 'Bring up the pop-up menu of the current registry'
          OnClick = MIRegistryMenuClick
        end
      end
      object MIAddPage: TMenuItem
        Caption = 'Del: Add to category'
        Enabled = False
        GroupIndex = 1
        Hint = 
          'Add new elements to the current category and place them in the p' +
          'ending queue'
        Visible = False
        OnClick = MIAddPageClick
        object MIAddNewItem: TMenuItem
          Caption = '&Item'
          Enabled = False
          Hint = 'Add a new item to the current category'
          OnClick = MIAddItemClick
        end
        object MIAddHTMLNote: TMenuItem
          Caption = 'HTML note'
          Enabled = False
          Hint = 'Add a new HTML note to the current category'
          OnClick = MIAddHTMLNoteClick
        end
        object MIAddArticle: TMenuItem
          Caption = '&Article'
          Enabled = False
          Hint = 'Add a new article to the current category (via clipboard)'
          ImageIndex = 82
          ImageName = 'icon_082'
          OnClick = MIAddArticleClick
        end
        object MIHTMLFile: TMenuItem
          Caption = '&HTML file'
          Enabled = False
          Hint = 'Import a new HTML file to the current category'
          OnClick = MIHTMLFileClick
        end
        object MIEMailCat: TMenuItem
          Caption = '&E-mail'
          Enabled = False
          Hint = 'Add a new e-mail text to the current category'
          OnClick = MIEMailCatClick
        end
      end
    end
    object MISearch: TMenuItem
      Caption = '&Search'
      GroupIndex = 10
      HelpContext = 34
      Hint = 'Search for texts in the collection or in the registries'
      OnClick = MISearchClick
      object MIFindElements: TMenuItem
        Caption = '&Find elements'
        Default = True
        GroupIndex = 1
        Hint = 'Search for texts in the current collection (Ctrl+F)'
        ImageIndex = 5
        ImageName = 'icon_005'
        ShortCut = 16454
        OnClick = MIFindElementsClick
      end
      object MIFindSubstring: TMenuItem
        Caption = 'Find &texts'
        GroupIndex = 1
        Hint = 'Search for texts in the text registry'
        ShortCut = 16467
        OnClick = MIFindSubstringClick
      end
      object MIFindInText: TMenuItem
        Caption = 'Find in article'
        GroupIndex = 1
        Hint = 'Search for a text in the current article (F3)'
        ImageIndex = 239
        ImageName = 'Search'
        ShortCut = 114
        OnClick = MIFindInTextClick
      end
      object MIFindSelection: TMenuItem
        Caption = 'Find selection'
        GroupIndex = 1
        Hint = 'Find elements containing the currently selected text'
        OnClick = MIFindSelectionClick
      end
      object N23: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object MIFindAndReplace: TMenuItem
        Caption = 'Search and replace'
        GroupIndex = 1
        Hint = 'Globally search for a text and replace it with another'
        ImageIndex = 107
        ImageName = 'icon_107'
        ShortCut = 16466
        OnClick = MIFindAndReplaceClick
      end
      object N6: TMenuItem
        Caption = '-'
        GroupIndex = 1
        Visible = False
      end
      object MIWebSearch: TMenuItem
        Caption = 'Web search'
        GroupIndex = 1
        Hint = 'Search the web for the currently selected text'
        ImageIndex = 187
        ImageName = 'icon_187'
        ShortCut = 16498
        OnClick = MIWebSearchClick
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object MiConceptRegistry: TMenuItem
        Caption = '&Concepts'
        GroupIndex = 1
        Hint = 'Open a registry with all concepts'
        ImageIndex = 209
        ImageName = 'icon_209'
        OnClick = MiConceptRegistryClick
      end
      object MILinkRegistry: TMenuItem
        Caption = '&Links'
        GroupIndex = 1
        Hint = 'Open a registry with all inter-element links'
        ImageIndex = 222
        ImageName = 'icon_222'
        OnClick = MILinkRegistryClick
      end
      object MIText: TMenuItem
        Caption = 'Te&xts'
        GroupIndex = 1
        Hint = 'Review texts in the text registry'
        ImageIndex = 6
        ImageName = 'icon_006'
        OnClick = ActTextRegistryExecute
      end
      object MILexicon: TMenuItem
        Caption = 'Lexicon'
        GroupIndex = 1
        Hint = 'Find a word in lexicon and texts or elements that use it'
        ImageIndex = 36
        ImageName = 'icon_036'
        OnClick = MIFindWordClick
      end
      object MIImage: TMenuItem
        Caption = '&Images'
        GroupIndex = 1
        Hint = 'Review images used in the collection'
        ImageIndex = 30
        ImageName = 'icon_030'
        OnClick = MIImageClick
      end
      object MISound: TMenuItem
        Caption = '&Sounds'
        GroupIndex = 1
        Hint = 'Review sounds used in the collection'
        ImageIndex = 52
        ImageName = 'icon_052'
        OnClick = MISoundClick
      end
      object N37: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object MITemplate: TMenuItem
        Caption = '&Templates'
        GroupIndex = 1
        Hint = 'Open a registry with templates used in the collection'
        ImageIndex = 113
        ImageName = 'icon_113'
        OnClick = MITemplateClick
      end
      object MITasklists: TMenuItem
        Caption = 'Tas&klists'
        GroupIndex = 1
        Hint = 'Open a registry with all tasklists'
        ImageIndex = 151
        ImageName = 'icon_151'
        OnClick = MITasklistsClick
      end
      object MIReference: TMenuItem
        Caption = '&References'
        GroupIndex = 1
        Hint = 'Open the registry of references'
        OnClick = MIReferenceClick
      end
      object MIOtherRegistries: TMenuItem
        Caption = '&Other registries'
        GroupIndex = 1
        Hint = 'Open other registries used in SuperMemo'
        object MIFont: TMenuItem
          Caption = '&Font'
          GroupIndex = 1
          Hint = 'Open a registry with fonts used in the collection'
          ImageIndex = 24
          ImageName = 'icon_024'
          OnClick = MIFontClick
        end
        object N13: TMenuItem
          Caption = '-'
          GroupIndex = 1
        end
        object MITranslation: TMenuItem
          Caption = 'Tra&nslation'
          GroupIndex = 1
          Hint = 'Open a registry with all translation texts'
          OnClick = MITranslationClick
        end
        object MIPronunciation: TMenuItem
          Caption = '&Pronunciation by word'
          GroupIndex = 1
          Hint = 'Open a registry with phonetic transcription'
          OnClick = MIPronunciationClick
        end
        object MIPronunciationBySound: TMenuItem
          Caption = 'Pronunciation by soun&d'
          GroupIndex = 1
          Hint = 
            'Open a registry with phonetic transcription sorted by transcript' +
            'ion'
          OnClick = MIPronunciationBySoundClick
        end
        object MIComment: TMenuItem
          Caption = '&Comment'
          GroupIndex = 1
          Hint = 'Open a registry with comments to individual elements'
          OnClick = MICommentClick
        end
        object N8: TMenuItem
          Caption = '-'
          GroupIndex = 1
        end
        object MIVideo: TMenuItem
          Caption = '&Video'
          GroupIndex = 1
          Hint = 'Open a registry with video tracks used in the collection'
          ImageIndex = 63
          ImageName = 'icon_063'
          OnClick = MIVideoClick
        end
        object MIBinary: TMenuItem
          Caption = '&Binary'
          GroupIndex = 1
          Hint = 
            'Open a registry with binary files used in the collection (DLLs, ' +
            'executables, help files, e-mail, etc.)'
          OnClick = MIBinaryClick
        end
        object MIStyle: TMenuItem
          Caption = '&Style'
          GroupIndex = 1
          Hint = 'Open a registry with stylesheets used by the collection'
          OnClick = MIStyleClick
        end
        object MIScript: TMenuItem
          Caption = 'Sc&ript'
          GroupIndex = 1
          Hint = 'Open a registry with scripts written for the collection'
          OnClick = MIScriptClick
        end
        object MIOLE: TMenuItem
          Caption = '&OLE Object'
          GroupIndex = 1
          Hint = 'Open a registry with all OLE objects used by the collection'
          OnClick = MIOLEClick
        end
      end
      object N33: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object MIGoTo: TMenuItem
        Caption = '&Go to element'
        GroupIndex = 1
        Hint = 'Find an element by its number'
        ImageIndex = 70
        ImageName = 'icon_070'
        ShortCut = 16455
        OnClick = MIGoToClick
      end
    end
    object MILearn: TMenuItem
      Caption = '&Learn'
      GroupIndex = 15
      HelpContext = 36
      Hint = 'Learn and repeat elements of the collections'
      OnClick = MILearnClick
      object MILearnAll: TMenuItem
        Caption = 'Learn'
        Default = True
        Hint = 
          'Go through all learning stages: outstanding material, new materi' +
          'al and final drill'
        ImageName = 'icon_034'
        ShortCut = 16460
        OnClick = MILearnOutstandingClick
      end
      object MIGoNeural: TMenuItem
        Caption = 'Go neural'
        Hint = 'Begin neural review starting with the current element'
        ImageIndex = 213
        ImageName = 'icon_213'
        ShortCut = 16497
        OnClick = MIGoNeuralClick
      end
      object MILearnStages: TMenuItem
        Caption = '&Stages'
        Hint = 'Choose a learning stage to execute'
        object MILearnOutstanding: TMenuItem
          Caption = '1. &Outstanding material'
          Hint = 'Repeat items that are scheduled for today'#39's repetitions'
          ImageName = 'icon_034'
          OnClick = MILearnOutstandingClick
        end
        object MILearnNew: TMenuItem
          Caption = '2. &New material'
          Hint = 'Learn new material (i.e. commit it to your memory)'
          OnClick = MILearnNewClick
        end
        object MILearnDrill: TMenuItem
          Caption = '3. Final &drill'
          Hint = 
            'Go through the final revision of the material repeated recently ' +
            '(final drill stage)'
          OnClick = MILearnDrillClick
        end
      end
      object MISortOptions: TMenuItem
        Caption = 'Sorting'
        Hint = 'Parameters for sorting the sequence of repetitions'
        ImageIndex = 69
        ImageName = 'icon_069'
        OnClick = MISortOptionsClick
        object MIAutoSort: TMenuItem
          Caption = '&Auto-sort repetitions'
          Hint = 
            'Automatically sort repetitions at the beginning of each learning' +
            ' day'
          OnClick = MIAutoSortClick
        end
        object MISortingCriteria: TMenuItem
          Caption = 'Sorting &criteria'
          Hint = 
            'Criteria used in sorting repetitions (priority, randomization, p' +
            'roportion of topics, etc.)'
          OnClick = MISortingCriteriaClick
        end
        object MISortReps: TMenuItem
          Caption = '&Sort now'
          Hint = 
            'Sort repetitions by priority (using a defined degree of randomiz' +
            'ation)'
          ImageIndex = 69
          ImageName = 'icon_069'
          OnClick = MISortRepsClick
        end
      end
      object MIPostponeOptions: TMenuItem
        Caption = '&Postpone'
        Hint = 'Postponing repetitions'
        ImageIndex = 95
        ImageName = 'icon_095'
        OnClick = MIPostponeOptionsClick
        object MIAutoPostpone: TMenuItem
          Caption = '&Auto-postpone'
          Hint = 
            'Automatically postpone repetitions left from previous days at th' +
            'e beginning of a learning day'
          OnClick = MIAutoPostponeClick
        end
        object N18: TMenuItem
          Caption = '-'
        end
        object MIPostponeTopics: TMenuItem
          Caption = '&Topics'
          Hint = 'Postpone all outstanding topics'
          OnClick = MIPostponeTopicsClick
        end
        object MIPostponeItems: TMenuItem
          Caption = '&Items'
          Hint = 'Postpone all outstanding items'
          OnClick = MIPostponeItemsClick
        end
        object MIPostponeAll: TMenuItem
          Caption = 'All &elements'
          Hint = 'Postpone all outstanding repetitions'
          OnClick = MIPostponeAllClick
        end
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Random1: TMenuItem
        Caption = '&Random'
        Hint = 'Random learning options'
        ImageIndex = 41
        ImageName = 'icon_041'
        object MIRandomizeRepetitions: TMenuItem
          Caption = 'Randomi&ze repetitions'
          Hint = 'Randomize the sequence of outstanding items'
          OnClick = MIRandomizeRepetitionsClick
        end
        object MIRandomLearning: TMenuItem
          Caption = 'Ran&dom learning'
          Hint = 
            'Learn new elements by randomly reviewing pending elements in the' +
            ' collection'
          ShortCut = 16506
          OnClick = MIRandomLearningClick
        end
      end
      object Drill2: TMenuItem
        Caption = 'Drill'
        object MIFinalDrill2: TMenuItem
          Caption = 'Final &drill'
          Hint = 
            'Go through the final revision of the material repeated recently ' +
            '(with a keyboard shortcut)'
          ShortCut = 16499
          OnClick = MIFinalDrill2Click
        end
        object MICutDrills: TMenuItem
          Caption = '&Cut drills'
          Hint = 'Eliminate items scheduled for final drill'
          OnClick = MICutDrillsClick
        end
      end
    end
    object MIView: TMenuItem
      Caption = '&View'
      GroupIndex = 20
      HelpContext = 35
      Hint = 'Browse linearly through knowledge elements'
      OnClick = MIViewClick
      object MIBrowseOutstanding: TMenuItem
        Caption = '&Outstanding'
        Default = True
        Hint = 'Browse all outstanding elements'
        ImageName = 'icon_034'
        OnClick = MIBrowseOutstandingClick
      end
      object MILinkList: TMenuItem
        Caption = 'Lin&k list'
        Hint = 
          'Show the list of concepts and elements linked to the current ele' +
          'ment'
        OnClick = MILinkListClick
      end
      object MINeuralQueue: TMenuItem
        Caption = '&Neural queue'
        Hint = 
          'View the current neural queue (or build a queue for the current ' +
          'element)'
        ImageIndex = 213
        ImageName = 'icon_213'
        OnClick = MINeuralQueueClick
      end
      object MIPriorityBrowser: TMenuItem
        Caption = '&Priority queue'
        Hint = 'Open the browser with elements sorted by their priority'
        ImageIndex = 138
        ImageName = 'icon_138'
        OnClick = MIPriorityBrowserClick
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object MIBrowseAll: TMenuItem
        Caption = '&All'
        Hint = 'Browse all elements in the collection'
        OnClick = MIBrowseAllClick
      end
      object MIBrowseMemorized: TMenuItem
        Caption = '&Memorized'
        Hint = 
          'Browse all elements that have been committed to the learning pro' +
          'cess'
        ImageIndex = 112
        ImageName = 'icon_112'
        OnClick = MIBrowseMemorizedClick
      end
      object MIBrowseDismissed: TMenuItem
        Caption = '&Dismissed'
        Hint = 'Browse all elements that have been dismissed'
        OnClick = MIBrowseDismissedClick
      end
      object N38: TMenuItem
        Caption = '-'
      end
      object MIConcepts: TMenuItem
        Caption = '&Concepts'
        Hint = 'View the list of concepts'
        ImageIndex = 209
        ImageName = 'icon_209'
        OnClick = MIConceptsClick
      end
      object MIBrowseTopics: TMenuItem
        Caption = '&Topics'
        Hint = 'Browse all elements that are topics'
        ImageIndex = 103
        ImageName = 'icon_103'
        OnClick = MIBrowseTopicsClick
      end
      object MIBrowseItems: TMenuItem
        Caption = '&Items'
        Hint = 'Browse all elements that are items'
        ImageIndex = 104
        ImageName = 'icon_104'
        OnClick = MIBrowseItemsClick
      end
      object MIAllTasks: TMenuItem
        Caption = 'Tasks'
        Hint = 'Open a browser with all tasks stored in the current collection'
        ImageIndex = 151
        ImageName = 'icon_151'
        OnClick = MIAllTasksClick
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object MILast: TMenuItem
        Caption = '&Last browser'
        Hint = 'View the contents of the last used browser'
        OnClick = MILastClick
      end
      object MIBrowseSearched: TMenuItem
        Caption = '&Search results'
        Hint = 'Browse elements collected in the last text string search'
        ImageIndex = 5
        ImageName = 'icon_005'
        OnClick = MIBrowseSearchedClick
      end
      object MIBrowseSubset: TMenuItem
        Caption = 'S&ubset'
        Hint = 
          'Browse elements stored in a subset file (e.g. with Subset : Save' +
          ' selection in the browser)'
        OnClick = MIBrowseSubsetClick
      end
      object MIBrowseFilter: TMenuItem
        Caption = '&Filter'
        Hint = 'Browse all elements that meet some search criteria'
        ImageIndex = 182
        ImageName = 'icon_182'
        OnClick = MIBrowseFilterClick
      end
      object N40: TMenuItem
        Caption = '-'
      end
      object MIRecentBrowser: TMenuItem
        Caption = '&Recent'
        object MILearned: TMenuItem
          Caption = '&Learned'
          Hint = 'View elements subject to last subset learning'
          OnClick = MILearnedClick
        end
        object MIReview: TMenuItem
          Caption = '&Reviewed'
          Hint = 'View elements subject to the last forced mid-interval review'
          OnClick = MIReviewClick
        end
        object N44: TMenuItem
          Caption = '-'
        end
        object MIElementsToPostpone: TMenuItem
          Caption = 'To postpone'
          Hint = 'View elements that were subject to the last postpone operation'
          OnClick = MIElementsToPostponeClick
        end
        object MIPostponedElements: TMenuItem
          Caption = '&Postponed'
          Hint = 'View elements that have recently been postponed'
          OnClick = MIPostponedElementsClick
        end
        object MIUnpostponed: TMenuItem
          Caption = 'Not postponed'
          Hint = 
            'View the subset of elements that have been skipped in a recent p' +
            'ostpone operation'
          OnClick = MIUnpostponedClick
        end
        object Advanced1: TMenuItem
          Caption = '&Advanced'
          Hint = 'View subset that has recently been advanced'
          OnClick = Advanced1Click
        end
        object N43: TMenuItem
          Caption = '-'
        end
        object MIPreviousBrowser: TMenuItem
          Caption = '&Previous'
          Hint = 'View the last but one browser subset'
          OnClick = MIPreviousBrowserClick
        end
      end
      object MIOtherBrowsers: TMenuItem
        Caption = 'Other'
        object MIBrowseLeeches: TMenuItem
          Caption = '&Leeches'
          Hint = 
            'Browse all elements that cause most problems in the learning pro' +
            'cess'
          ImageIndex = 223
          ImageName = 'icon_223'
          ShortCut = 8306
          OnClick = MIBrowseLeechesClick
        end
        object MISemiLeeches: TMenuItem
          Caption = '&Semi-leeches'
          Hint = 
            'Browse all leeches and all elements that would become leeches if' +
            ' forgotten'
          OnClick = MISemiLeechesClick
        end
        object MIBrowsePending: TMenuItem
          Caption = 'P&ending'
          Hint = 'Browse or edit elements that have not yet been memorized'
          OnClick = MIBrowsePendingClick
        end
        object MIBrowseDrill: TMenuItem
          Caption = '&Drill'
          Hint = 'Browse or edit elements scheduled for final drill'
          OnClick = MIBrowseDrillClick
        end
        object MIBrowseRange: TMenuItem
          Caption = '&Range'
          Hint = 'Browse elements belonging to a selected range'
          OnClick = MIBrowseRangeClick
        end
        object MIHistory: TMenuItem
          Caption = '&History'
          Hint = 'Browse the most recently visited elements'
          ImageIndex = 74
          ImageName = 'icon_074'
          OnClick = MIHistoryClick
        end
        object MIBrowseNode: TMenuItem
          Caption = '&Branch'
          Hint = 
            'Browse all elements of the current contents branch (Ctrl+Shift+E' +
            'nter)'
          ImageIndex = 73
          ImageName = 'icon_073'
          OnClick = MIBrowseNodeClick
        end
      end
    end
    object MITools: TMenuItem
      Caption = 'Tool&kit'
      GroupIndex = 100
      HelpContext = 31
      Hint = 'Various additional tools and options of SuperMemo'
      OnClick = MIToolsClick
      object MICommander: TMenuItem
        Caption = 'Commander'
        Default = True
        Hint = 'Choose a SuperMemo command to execute'
        ImageIndex = 28
        ImageName = 'icon_028'
        ShortCut = 16397
        OnClick = MICommanderClick
      end
      object MIWorkload: TMenuItem
        Caption = '&Calendar'
        GroupIndex = 30
        Hint = 'Inspect the calendar of repetitions'
        ImageIndex = 7
        ImageName = 'icon_007'
        ShortCut = 16471
        OnClick = MIWorkloadClick
      end
      object MISleepChart: TMenuItem
        Caption = '&Sleep Chart'
        GroupIndex = 30
        Hint = 
          'Chart your sleep and repetitions to better understand your memor' +
          'y'
        ImageIndex = 207
        ImageName = 'icon_207'
        ShortCut = 123
        OnClick = MISleepChartClick
      end
      object MIPlan: TMenuItem
        Caption = '&Plan'
        GroupIndex = 30
        Hint = 
          'Daily schedule of activities such as learning, reading, surfing,' +
          ' e-mail, etc.'
        ShortCut = 16464
        OnClick = MIPlanClick
      end
      object MIMercy: TMenuItem
        Caption = '&Mercy'
        GroupIndex = 30
        HelpContext = 3
        Hint = 'Reschedule outstanding repetitions in a selected period of time'
        ShortCut = 41037
        OnClick = MIMercyClick
      end
      object MITasklist: TMenuItem
        Caption = 'Tasklist'
        GroupIndex = 30
        Hint = 'View the current tasklist'
        ImageIndex = 151
        ImageName = 'icon_151'
        ShortCut = 115
        OnClick = MITasklistClick
      end
      object MIStatisticsMenu: TMenuItem
        Caption = '&Statistics'
        GroupIndex = 30
        Hint = 'Statistics of the learning process and the use of SuperMemo'
        ImageIndex = 179
        ImageName = 'icon_179'
        object MIStatistics: TMenuItem
          Caption = 'Statistics'
          Default = True
          Hint = 'Show the window with learning statistics'
          OnClick = MIStatisticsClick
        end
        object MIElementStatistics: TMenuItem
          Caption = '&Element data'
          Hint = 
            'Show the window with the statistics of the currently displayed e' +
            'lement'
          OnClick = MIElementStatisticsClick
        end
        object MIAnalysis: TMenuItem
          Caption = '&Analysis'
          GroupIndex = 30
          Hint = 'Inspect the optimization graphs of the SuperMemo algorithm'
          ImageIndex = 179
          ImageName = 'icon_179'
          ShortCut = 41025
          OnClick = MIAnalysisClick
        end
        object MISimulation: TMenuItem
          Caption = '&Simulation'
          GroupIndex = 30
          Hint = 'Simulate the learning process over 15 years'
          OnClick = MISimulationClick
        end
        object MIGenerateReport: TMenuItem
          Caption = '&Report'
          GroupIndex = 30
          Hint = 
            'Generate a report text file with statistical parameters and othe' +
            'r data'
          OnClick = MIGenerateReportClick
        end
        object MIResetOptimization: TMenuItem
          Caption = 'Reset &data'
          GroupIndex = 30
          Hint = 'Reset or recompute selected parameters of the learning process'
          object MIResetFI: TMenuItem
            Caption = '&Forgetting index record'
            Hint = 
              'Reset the record of measurements of the actual forgetting index ' +
              'at repetitions'
            OnClick = MIResetFIClick
          end
          object MIResetFIPriority: TMenuItem
            Caption = 'Forgetting index vs priority record'
            Hint = 
              'Reset the record of the measured forgetting index for all priori' +
              'ty categories'
            OnClick = MIResetFIPriorityClick
          end
          object MIResetFirstGradeVsAF: TMenuItem
            Caption = 'First grade vs A-Factor record'
            Hint = 
              'Reset the record of the correlation between first grades and A-F' +
              'actors'
            OnClick = MIResetFirstGradeVsAFClick
          end
          object Gradevsforgettingindex1: TMenuItem
            Caption = 'Grade vs forgetting index'
            Hint = 
              'Reset the correlation between the grades and the forgetting inde' +
              'x'
            OnClick = Gradevsforgettingindex1Click
          end
          object MIResetAvgRepetitionTime: TMenuItem
            Caption = '&Average response time'
            Hint = 'Reset the measurements of the average response time'
            OnClick = MIResetAvgRepetitionTimeClick
          end
          object MIResetRepetitionStatistics: TMenuItem
            Caption = 'Repetition statistics'
            Hint = 
              'Recompute repetition counts in Workload to delete data generated' +
              ' by deleted elements'
            OnClick = MIResetRepetitionStatisticsClick
          end
          object MIResetRepetitionhistoryCalendar: TMenuItem
            Caption = 'Repetition history calendar'
            Hint = 
              'Recompute the history of use of element on individual days for b' +
              'rowsing elements day by day (/subsets /history folder)'
            OnClick = MIResetRepetitionhistoryCalendarClick
          end
          object MIResetRepetitionHistory: TMenuItem
            Caption = '&Repetition history'
            Hint = 
              'Delete the history of repetitions without other changes in the l' +
              'earning process'
            OnClick = MIResetRepetitionHistoryClick
          end
          object MIResetMatrices: TMenuItem
            Caption = '&Optimization matrices'
            Hint = 
              'Reset only the optimization matrices, i.e. data about the memory' +
              ' of the particular student'
            OnClick = MIResetMatricesClick
          end
        end
        object N54: TMenuItem
          Caption = '-'
          GroupIndex = 30
        end
      end
      object MIMemoryMenu: TMenuItem
        Caption = 'Memory'
        GroupIndex = 30
        object Graphs4D: TMenuItem
          Caption = '&4D Graphs'
          GroupIndex = 30
          Hint = 'Display memory graphs in 4D'
          ImageIndex = 214
          ImageName = 'icon_214'
          ShortCut = 118
          OnClick = Graphs4DClick
        end
        object MIMemoryStatus: TMenuItem
          Caption = 'Memory status'
          GroupIndex = 30
          Hint = 
            'Show changes to memory status over time (stability and retrievab' +
            'ility)'
          ShortCut = 113
          OnClick = MIMemoryStatusClick
        end
        object MITotalKnowledge: TMenuItem
          Caption = 'Total knowledge'
          GroupIndex = 30
          Hint = 'Compute the progression timeline of total knowledge'
          OnClick = MITotalKnowledgeClick
        end
        object MIExportData: TMenuItem
          Caption = 'Export data'
          GroupIndex = 30
          Hint = 'Export memory data for all items'
          OnClick = MIExportDataClick
        end
        object MIMemoryStability: TMenuItem
          Caption = 'Compute memory stability matrix'
          GroupIndex = 30
          Hint = 
            'Compute the parameters of memory stability function for the indi' +
            'vidual'
          Visible = False
        end
        object MIRecomputeDifficulties: TMenuItem
          Caption = 'Re-compute difficulties'
          GroupIndex = 30
          Hint = 
            'Update item difficulties in element data for more accurate displ' +
            'ay and browsing'
          OnClick = MIRecomputeDifficultiesClick
        end
        object MICollectDifficultyData: TMenuItem
          Caption = 'Collect difficulty data'
          GroupIndex = 30
          Hint = 
            'Collect difficulty, starting stability, and A-Factors for all it' +
            'ems'
          Visible = False
          OnClick = MICollectDifficultyDataClick
        end
        object MISaveRecallMatrix: TMenuItem
          Caption = 'Save recall matrix'
          GroupIndex = 30
          Hint = 'Save parameters of the recall matrix'
          Visible = False
          OnClick = MISaveRecallMatrixClick
        end
      end
      object MINeuralAnalysis: TMenuItem
        Caption = 'Neural analysis'
        GroupIndex = 30
        Hint = 
          'Build a neural queue over the current element and report the pat' +
          'hs used in the spreading of activation'
        OnClick = MINeuralAnalysisClick
      end
      object N22: TMenuItem
        Caption = '-'
        GroupIndex = 30
      end
      object MIRandomize: TMenuItem
        Caption = 'Randomi&ze'
        GroupIndex = 30
        Hint = 'Mix elements randomly'
        OnClick = MIRandomizeClick
        object MIRandomizeDrill: TMenuItem
          Caption = '&Drill'
          Default = True
          Hint = 'Mix randomly the queue of elements scheduled for final drill'
          OnClick = MIRandomizeDrillClick
        end
        object MIRandomizePending: TMenuItem
          Caption = '&Pending'
          Hint = 'Mix randomly the queue of pending elements'
          OnClick = MIRandomizePendingClick
        end
      end
      object MIRandomTests: TMenuItem
        Caption = 'R&andom test'
        GroupIndex = 30
        Hint = 'Collection of random review options on different element subsets'
        OnClick = MIRandomTestsClick
        object MIResumeTest: TMenuItem
          Caption = '&Resume test'
          Hint = 'Resume the previously interrupted random test'
          OnClick = MIResumeTestClick
        end
        object N26: TMenuItem
          Caption = '-'
        end
        object MIRandomAll: TMenuItem
          Caption = '&All'
          GroupIndex = 30
          Hint = 'Start random test on all elements in the current collection'
          ShortCut = 32890
          OnClick = MIRandomAllClick
        end
        object MIRandomPending: TMenuItem
          Caption = '&Pending'
          GroupIndex = 30
          Hint = 
            'Run a random test on all pending elements in the current collect' +
            'ion'
          OnClick = MIRandomPendingClick
        end
        object MIRandomMemorized: TMenuItem
          Caption = '&Memorized'
          GroupIndex = 30
          Hint = 'Run a random test on all memorized elements'
          OnClick = MIRandomMemorizedClick
        end
        object MIRandomDismissed: TMenuItem
          Caption = '&Dismissed'
          GroupIndex = 30
          Hint = 'Run a random test on all dismissed elements'
          OnClick = MIRandomDismissedClick
        end
        object N27: TMenuItem
          Caption = '-'
          GroupIndex = 30
        end
        object MIRandomTopics: TMenuItem
          Caption = '&Topics'
          GroupIndex = 30
          Hint = 'Run a random test on all topics'
          OnClick = MIRandomTopicsClick
        end
        object MIRandomItems: TMenuItem
          Caption = '&Items'
          GroupIndex = 30
          Hint = 'Run a random test on all items'
          OnClick = MIRandomItemsClick
        end
        object N28: TMenuItem
          Caption = '-'
          GroupIndex = 30
        end
        object MIRandomFilter: TMenuItem
          Caption = '&Filter'
          GroupIndex = 30
          Hint = 
            'Run a random test on all elements matching a given element filte' +
            'r'
          OnClick = MIRandomFilterClick
        end
        object MIRandomLeeches: TMenuItem
          Caption = '&Leeches'
          GroupIndex = 30
          Hint = 
            'Run a random test on most difficult items in the current collect' +
            'ion'
          OnClick = MIRandomLeechesClick
        end
        object N30: TMenuItem
          Caption = '-'
          GroupIndex = 30
        end
        object MIRandomSubset: TMenuItem
          Caption = '&Subset'
          GroupIndex = 30
          Hint = 'Run a random test on all elements stored in a subset file'
          OnClick = MIRandomSubsetClick
        end
        object N29: TMenuItem
          Caption = '-'
          GroupIndex = 30
        end
        object MIRandomNode: TMenuItem
          Caption = '&Branch'
          GroupIndex = 30
          Hint = 
            'Run a random test on elements belonging to the currently selecte' +
            'd branch in the contents window'
          OnClick = MIRandomNodeClick
        end
      end
      object MIRandomReview: TMenuItem
        Caption = '&Random review'
        GroupIndex = 30
        Hint = 'Jump to a randomly selected element in the current collection'
        ShortCut = 122
        OnClick = MIRandomReviewClick
      end
      object BreakModifyInSubset: TMenuItem
        Caption = '-'
        GroupIndex = 30
      end
      object MIOptions: TMenuItem
        Caption = '&Options'
        GroupIndex = 30
        HelpContext = 3
        Hint = 
          'Various options related to learning, data access, appending item' +
          's, etc.'
        ImageIndex = 156
        ImageName = 'icon_156'
        OnClick = MIOptionsClick
      end
    end
    object MIWindow: TMenuItem
      Caption = '&Window'
      GroupIndex = 230
      HelpContext = 33
      Hint = 'Change layouts of windows in SuperMemo'
      OnClick = MIWindowClick
      object MIThemes: TMenuItem
        Caption = '&Themes'
        Hint = 'Choose a theme that makes SuperMemo look best for you'
        OnClick = MIThemesClick
      end
      object MILayout: TMenuItem
        Caption = '&Layout'
        GroupIndex = 15
        Hint = 'Work with layouts'
        ImageIndex = 67
        ImageName = 'icon_067'
        object MILayouts: TMenuItem
          Caption = '&Layout Manager'
          Hint = 'Open the layouts manager'
          ImageIndex = 67
          ImageName = 'icon_067'
          OnClick = MILayoutsClick
        end
        object N2: TMenuItem
          Caption = '-'
        end
        object MIDefaultLayout: TMenuItem
          Caption = 'Apply default layout'
          Default = True
          GroupIndex = 15
          Hint = 'Restore the windows layout chosen as the default layout'
          ImageIndex = 66
          ImageName = 'icon_066'
          ShortCut = 16500
          OnClick = MIApplyDefaultlayoutClick
        end
        object MIWarriorLayout: TMenuItem
          Caption = 'Warrior layout'
          GroupIndex = 15
          Hint = 'Use advanced warrior layout with statistics and toolbars'
          ShortCut = 116
          OnClick = MIWarriorLayoutClick
        end
        object MIClassicLayout: TMenuItem
          Caption = '&Classic layout'
          GroupIndex = 15
          Hint = 'Arrange windows in the classic style known from SuperMemo 6'
          ImageIndex = 3
          ImageName = 'icon_003'
          OnClick = ClassicLayout
        end
        object N16: TMenuItem
          Caption = '-'
          GroupIndex = 15
        end
        object MISaveLayout: TMenuItem
          Caption = '&Save custom layout'
          GroupIndex = 15
          Hint = 'Save the current windows layout for future use'
          OnClick = MISaveLayoutClick
        end
        object MISaveDefaultLayout: TMenuItem
          Caption = 'Save as &default'
          GroupIndex = 15
          Hint = 'Save the current position of windows for later use'
          ImageIndex = 65
          ImageName = 'icon_065'
          ShortCut = 24692
          OnClick = MISaveDefaultLayoutClick
        end
        object N17: TMenuItem
          Caption = '-'
          GroupIndex = 15
        end
        object MIBackColor: TMenuItem
          Caption = 'Background color'
          GroupIndex = 15
          Hint = 'Change the color of SuperMemo background'
          OnClick = MIBackColorClick
        end
        object MIBackgroundPicture: TMenuItem
          Caption = 'Background &picture'
          GroupIndex = 15
          Hint = 'Set a SuperMemo background picture '
          OnClick = MIBackgroundPictureClick
        end
        object MIAboutPicture: TMenuItem
          Caption = 'About picture'
          GroupIndex = 15
          Hint = 'Choose a picture for SuperMemo About Box'
          OnClick = MIAboutPictureClick
        end
      end
      object MIDarkMode: TMenuItem
        Caption = 'Dark mode'
        GroupIndex = 15
        Hint = 'Keep SuperMemo in darker colors'
        OnClick = MIDarkModeClick
      end
      object MIHints: TMenuItem
        Caption = 'H&ints'
        GroupIndex = 15
        Hint = 'Turn the hints off or on'
        OnClick = MIHintsClick
      end
      object N7: TMenuItem
        Caption = '-'
        GroupIndex = 15
      end
      object MIOpenContents: TMenuItem
        Caption = 'Contents'
        GroupIndex = 15
        Hint = 'View the current element in the contents window'
        ImageIndex = 73
        ImageName = 'icon_073'
        ShortCut = 32835
        OnClick = MIOpenContentsClick
      end
      object MIStatusBar: TMenuItem
        Caption = '&Status bar'
        GroupIndex = 15
        Hint = 'Turn on and off the status bar at the bottom of the screen'
        OnClick = MIStatusBarClick
      end
      object MIBackground: TMenuItem
        Caption = '&Background'
        GroupIndex = 15
        Hint = 'Hide or show background behind SuperMemo'
        ShortCut = 49273
        OnClick = ActBackgroundExecute
      end
      object MIStatistics1: TMenuItem
        Caption = 'St&atistics'
        GroupIndex = 15
        Hint = 'Show the window with learning statistics'
        ImageIndex = 179
        ImageName = 'icon_179'
        OnClick = MIStatisticsClick
      end
      object MIElementData1: TMenuItem
        Caption = '&Element data'
        GroupIndex = 15
        Hint = 
          'Show the window with the statistics of the currently displayed e' +
          'lement'
        OnClick = MIElementStatisticsClick
      end
      object MIAncestors: TMenuItem
        Caption = '&Ancestors'
        GroupIndex = 15
        Hint = 'Display the list of ancestors'
        ImageIndex = 176
        ImageName = 'icon_176'
        ShortCut = 24664
        OnClick = MIAncestorsClick
      end
      object N15: TMenuItem
        Caption = '-'
        GroupIndex = 15
      end
      object MIHideSuperMemo: TMenuItem
        Caption = 'Hide SuperMemo'
        GroupIndex = 15
        Hint = 'Hide SuperMemo and put it in a system tray'
        ShortCut = 24647
        OnClick = MIHideSuperMemoClick
      end
      object ApplyLayoutBreak1: TMenuItem
        Caption = '-'
        GroupIndex = 15
      end
      object AL1: TMenuItem
        Caption = '&1'
        GroupIndex = 15
        Hint = 'Apply custom layout saved by the user'
        OnClick = ApplyCustomLayout
      end
      object AL2: TMenuItem
        Caption = '&2'
        GroupIndex = 15
        Hint = 'Apply custom layout saved by the user'
        OnClick = ApplyCustomLayout
      end
      object AL3: TMenuItem
        Caption = '&3'
        GroupIndex = 15
        Hint = 'Apply custom layout saved by the user'
        OnClick = ApplyCustomLayout
      end
      object AL4: TMenuItem
        Caption = '&4'
        GroupIndex = 15
        Hint = 'Apply custom layout saved by the user'
        OnClick = ApplyCustomLayout
      end
      object AL5: TMenuItem
        Caption = '&5'
        GroupIndex = 15
        Hint = 'Apply custom layout saved by the user'
        OnClick = ApplyCustomLayout
      end
      object AL6: TMenuItem
        Caption = '&6'
        GroupIndex = 15
        Hint = 'Apply custom layout saved by the user'
        OnClick = ApplyCustomLayout
      end
      object AL7: TMenuItem
        Caption = '&7'
        GroupIndex = 15
        Hint = 'Apply custom layout saved by the user'
        OnClick = ApplyCustomLayout
      end
      object AL8: TMenuItem
        Caption = '&8'
        GroupIndex = 15
        Hint = 'Apply custom layout saved by the user'
        OnClick = ApplyCustomLayout
      end
      object AL9: TMenuItem
        Caption = '&9'
        GroupIndex = 15
        Hint = 'Apply custom layout saved by the user'
        OnClick = ApplyCustomLayout
      end
    end
    object MIHelp: TMenuItem
      Caption = '&Help'
      GroupIndex = 230
      HelpContext = 32
      Hint = 'Get information about SuperMemo'
      OnClick = MIHelpClick
      object MIFrontPage: TMenuItem
        Caption = '&Welcome - ABC'
        Hint = 'Open the help starting with the welcome page'
        OnClick = MIFrontPageClick
      end
      object MIHelpGuide: TMenuItem
        Caption = '&Guide'
        Default = True
        Hint = 'Step by step instructions for using SuperMemo'
        OnClick = MIHelpGuideClick
      end
      object MIHelpContents: TMenuItem
        Caption = '&Contents'
        Hint = 'Open the help starting with the table of contents'
        OnClick = MIHelpContentsClick
      end
      object MIFAQHelp: TMenuItem
        Caption = '&FAQ'
        Hint = 
          'Open the help starting with the page with frequently asked quest' +
          'ions'
        OnClick = MIFAQHelpClick
      end
      object MIHintsAndTips: TMenuItem
        Caption = '&Hints and tips'
        Hint = 'Open the help starting with the useful hints for users'
        OnClick = MIHintsAndTipsClick
      end
      object MIHelpContext: TMenuItem
        Caption = 'Context (press F1)'
        Hint = 'Open help with the page related to the current context'
        OnClick = MIHelpContextClick
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object MIUserSurvey: TMenuItem
        Caption = '&User survey'
        Hint = 'Submit your feedback to help improve SuperMemo'
        OnClick = MIUserSurveyClick
      end
      object MIHelpWeb: TMenuItem
        Caption = '&Web'
        Hint = 'Go for more help to the web'
        object MIInternetHelp: TMenuItem
          Caption = '&On-line help'
          Hint = 
            'Open the most recent version of help directly from SuperMemo Web' +
            'site'
          OnClick = MIInternetHelpClick
        end
        object MIVideos: TMenuItem
          Caption = 'YouTube'
          Hint = 'YouTube videos about SuperMemo'
          OnClick = MIVideosClick
        end
        object N47: TMenuItem
          Caption = '-'
        end
        object MISearchWiki: TMenuItem
          Caption = 'Search Wiki Help'
          Hint = 'Search SuperMemo Help at supermemo.org'
          ShortCut = 8305
          OnClick = MISearchWikiClick
        end
        object MISearchHelp: TMenuItem
          Caption = 'Search HTML Help'
          Hint = 'Search SuperMemo Help at supermemo.com'
          OnClick = MISearchHelpClick
        end
        object MISearchSuperMemopedia: TMenuItem
          Caption = 'Search SuperMemopedia'
          Hint = 'Search SuperMemopedia.com'
          OnClick = MISearchSuperMemopediaClick
        end
        object MIGoogleSearch: TMenuItem
          Caption = '&Search Web'
          Hint = 'Search Google for articles about SuperMemo'
          OnClick = MIGoogleSearchClick
        end
      end
      object MIHelpEMail: TMenuItem
        Caption = 'E-mail '
        object MIEmailSupport: TMenuItem
          Caption = '&Support'
          Hint = 'Send e-mail with questions to SuperMemo technical support'
          OnClick = MIEmailSupportClick
        end
        object MIBugReport: TMenuItem
          Caption = '&Bug report'
          Hint = 'Report a bug in SuperMemo'
          OnClick = MIBugReportClick
        end
        object MIFeedback: TMenuItem
          Caption = 'Inv: &Questionnaire'
          Hint = 'Please help us improve SuperMemo'
          Visible = False
          OnClick = MIFeedbackClick
        end
      end
      object BreakInternetUpdate: TMenuItem
        Caption = '-'
      end
      object MITipOfTheDay: TMenuItem
        Caption = '&Question of the Day'
        Hint = 'Show Question of the Day dialog box'
        OnClick = MITipOfTheDayClick
      end
      object N31: TMenuItem
        Caption = '-'
      end
      object MIAbout: TMenuItem
        Caption = '&About'
        Hint = 'SuperMemo version information'
        OnClick = MIAboutClick
      end
    end
    object MIElementShortcuts: TMenuItem
      Caption = 'ElementShortcuts'
      GroupIndex = 230
      Visible = False
      object Link1: TMenuItem
        Caption = 'Link'
        object Registrymember1: TMenuItem
          Caption = 'Registry member'
          ShortCut = 24651
          OnClick = Registrymember1Click
        end
        object MIRenameMember: TMenuItem
          Caption = 'Rename member'
          ShortCut = 32850
          OnClick = MIRenamememberClick
        end
        object MILinkExternal: TMenuItem
          Caption = 'External file'
          ShortCut = 24651
          OnClick = MILinkExternalClick
        end
        object MIImportFile: TMenuItem
          Caption = 'Import file'
          ShortCut = 16465
          OnClick = MIImportFileClick
        end
        object MIHyperlink: TMenuItem
          Caption = 'Hyperlink'
          ShortCut = 16459
          OnClick = MIHyperlinkClick
        end
      end
      object Component1: TMenuItem
        Caption = 'Component'
        object Deletecurrentcomponent1: TMenuItem
          Caption = 'Delete current component'
          ShortCut = 16430
          OnClick = Deletecurrentcomponent1Click
        end
        object Componentorder1: TMenuItem
          Caption = 'Component order'
          ShortCut = 24655
          OnClick = Componentorder1Click
        end
        object Hyperlink1: TMenuItem
          Caption = 'Hyperlink'
          OnClick = Hyperlink1Click
        end
        object Setreadingpoint1: TMenuItem
          Caption = 'Set read-point'
          ShortCut = 16502
          OnClick = Setreadingpoint1Click
        end
        object Clearreadpoint1: TMenuItem
          Caption = 'Clear read-point'
          ShortCut = 24694
          OnClick = Clearreadpoint1Click
        end
        object Gotoreadpoint1: TMenuItem
          Caption = 'Go to read-point'
          ShortCut = 32886
          OnClick = Gotoreadpoint1Click
        end
        object Viewsource1: TMenuItem
          Caption = 'View source'
          OnClick = Viewsource1Click
        end
        object MISaveLocally: TMenuItem
          Caption = 'Save locally'
          OnClick = MISaveLocallyClick
        end
        object Undo1: TMenuItem
          Caption = 'Undo'
          ShortCut = 32776
          OnClick = Undo1Click
        end
        object Nextcomponent1: TMenuItem
          Caption = 'Next component'
          ShortCut = 9
          OnClick = Nextcomponent1Click
        end
      end
      object Dragging1: TMenuItem
        Caption = 'Dragging'
        object Dragup1: TMenuItem
          Caption = 'Drag up'
          ShortCut = 49190
          OnClick = Dragup1Click
        end
        object Dragdown1: TMenuItem
          Caption = 'Drag down'
          ShortCut = 49192
          OnClick = Dragdown1Click
        end
        object Dragleft1: TMenuItem
          Caption = 'Drag left'
          ShortCut = 49189
          OnClick = Dragleft1Click
        end
        object Dragright1: TMenuItem
          Caption = 'Drag right'
          ShortCut = 49191
          OnClick = Dragright1Click
        end
      end
      object Newelement1: TMenuItem
        Caption = 'Jump'
        object MIShortcutAhead: TMenuItem
          Caption = 'Ahead'
          ShortCut = 32807
          OnClick = MIShortcutAheadClick
        end
        object Back1: TMenuItem
          Caption = 'Back'
          ShortCut = 32805
          OnClick = Back1Click
        end
        object N46: TMenuItem
          Caption = '-'
        end
        object FirstElement1: TMenuItem
          Caption = 'First Element'
          ShortCut = 32804
          OnClick = FirstElement1Click
        end
        object LastElement1: TMenuItem
          Caption = 'Last Element'
          ShortCut = 32803
          OnClick = LastElement1Click
        end
        object Nextelement1: TMenuItem
          Caption = 'Next element'
          ShortCut = 32802
          OnClick = Nextelement1Click
        end
        object Previouselement1: TMenuItem
          Caption = 'Previous element'
          ShortCut = 32801
          OnClick = Previouselement1Click
        end
        object Parentelement1: TMenuItem
          Caption = 'Parent element'
          ShortCut = 16422
          OnClick = Parentelement1Click
        end
      end
      object MIPostpone1: TMenuItem
        Caption = 'Postpone'
        OnClick = MIPostpone1Click
      end
      object MILearnBranch: TMenuItem
        Caption = 'Learn'
        OnClick = MILearnBranchClick
      end
      object Extract1: TMenuItem
        Caption = 'Extract'
        ShortCut = 32856
        OnClick = Extract1Click
      end
      object ScheduleExtract1: TMenuItem
        Caption = 'Schedule Extract'
        ShortCut = 41048
        OnClick = ScheduleExtract1Click
      end
      object Cloze1: TMenuItem
        Caption = 'Cloze'
        ShortCut = 32858
        OnClick = Cloze1Click
      end
      object Reference1: TMenuItem
        Caption = 'Reference'
        ShortCut = 32849
        OnClick = Reference1Click
      end
      object MICapitalize: TMenuItem
        Caption = 'Capitalize'
        OnClick = MICapitalizeClick
      end
      object EMail1: TMenuItem
        Caption = 'EMail'
        ShortCut = 24645
        OnClick = EMail1Click
      end
      object Deletebeforecursor1: TMenuItem
        Caption = 'Delete before cursor'
        ShortCut = 32988
        OnClick = Deletebeforecursor1Click
      end
      object Deleteaftercursor1: TMenuItem
        Caption = 'Delete after cursor'
        ShortCut = 32958
        OnClick = Deleteaftercursor1Click
      end
    end
    object MIGlobalShortcuts: TMenuItem
      Caption = 'GlobalShortcuts'
      GroupIndex = 230
      Visible = False
      object Edit2: TMenuItem
        Caption = 'Edit'
        object MINextComponent: TMenuItem
          Caption = 'Next component'
          ShortCut = 16468
          OnClick = MINextComponentClick
        end
        object MIElementParameters: TMenuItem
          Caption = 'Element parameters'
          ShortCut = 24656
          OnClick = MIElementParametersClick
        end
        object Prioritydialog1: TMenuItem
          Caption = 'Priority dialog'
          ShortCut = 32848
          OnClick = Prioritydialog1Click
        end
        object MIDuplicate: TMenuItem
          Caption = 'Duplicate'
          ShortCut = 32836
          OnClick = MIDuplicateClick
        end
        object Swap1: TMenuItem
          Caption = 'Swap'
          ShortCut = 24659
          OnClick = Swap1Click
        end
        object Transliterateall1: TMenuItem
          Caption = 'Transliterate all'
          ShortCut = 32857
          OnClick = Transliterateall1Click
        end
        object MIEditingMode: TMenuItem
          Caption = 'Editing mode'
          Hint = 'Switch all components to the editing mode'
          ShortCut = 16453
          OnClick = MIEditingModeClick
        end
        object Viewfile1: TMenuItem
          Caption = 'View file'
          ShortCut = 120
          OnClick = Viewfile1Click
        end
        object MIEditFile: TMenuItem
          Caption = 'Edit file'
          ShortCut = 16504
          OnClick = MIEditFileClick
        end
        object Viewsource2: TMenuItem
          Caption = 'View source'
          ShortCut = 24693
          OnClick = Viewsource2Click
        end
        object Switchimagestretch1: TMenuItem
          Caption = 'Switch image stretch'
          ShortCut = 24657
          OnClick = Switchimagestretch1Click
        end
        object FilterRTF1: TMenuItem
          Caption = 'Filter RTF'
          ShortCut = 117
          OnClick = FilterRTF1Click
        end
        object Plaintext1: TMenuItem
          Caption = 'Plain text'
          ShortCut = 24699
          OnClick = Plaintext1Click
        end
        object MIInsertHR: TMenuItem
          Caption = 'Insert HR'
          ShortCut = 41032
          OnClick = MIInsertHRClick
        end
      end
      object Classify1: TMenuItem
        Caption = 'Learning'
        object Memorize1: TMenuItem
          Caption = 'Memorize'
          ShortCut = 16461
          OnClick = Memorize1Click
        end
        object Dismiss1: TMenuItem
          Caption = 'Dismiss'
          ShortCut = 16452
          OnClick = Dismiss1Click
        end
        object Drill1: TMenuItem
          Caption = 'Drill'
          ShortCut = 24644
          OnClick = Drill1Click
        end
        object Jumpinterval1: TMenuItem
          Caption = 'Jump interval'
          ShortCut = 16458
          OnClick = Jumpinterval1Click
        end
        object Shifttolater1: TMenuItem
          Caption = 'Shift to later'
          ShortCut = 24650
          OnClick = Shifttolater1Click
        end
        object Forcerepetition1: TMenuItem
          Caption = 'Force repetition'
          ShortCut = 24658
          OnClick = Forcerepetition1Click
        end
        object Done1: TMenuItem
          Caption = 'Done'
          ShortCut = 24589
          OnClick = Done1Click
        end
        object Repetitionhistory2: TMenuItem
          Caption = 'Repetition history'
          ShortCut = 24648
          OnClick = Repetitionhistory2Click
        end
      end
      object Font1: TMenuItem
        Caption = 'Font'
        object MINewFont: TMenuItem
          Caption = 'Link registry font'
          ShortCut = 24646
          OnClick = MINewFontClick
        end
        object MIBoldFont: TMenuItem
          Caption = 'Bold font'
          ShortCut = 16450
          OnClick = MIBoldFontClick
        end
        object Italicfont1: TMenuItem
          Caption = 'Italic font'
          ShortCut = 16457
          OnClick = Italicfont1Click
        end
        object Underlinefont1: TMenuItem
          Caption = 'Underline font'
          ShortCut = 16469
          OnClick = Underlinefont1Click
        end
        object Increasefontsize1: TMenuItem
          Caption = 'Increase font size'
          ShortCut = 16605
          OnClick = Increasefontsize1Click
        end
        object Decreasefontsize1: TMenuItem
          Caption = 'Decrease font size'
          ShortCut = 16603
          OnClick = Decreasefontsize1Click
        end
      end
      object Template1: TMenuItem
        Caption = 'Template'
        object ElWindApplyTemplate: TMenuItem
          Caption = 'Merge with template'
          ShortCut = 24653
          OnClick = ElWindApplyTemplateClick
        end
        object MISaveDefaultTemplate: TMenuItem
          Caption = 'Save as default template'
          OnClick = MISaveDefaultTemplateClick
        end
        object ImposeTemplate1: TMenuItem
          Caption = 'Impose Template'
          ShortCut = 24689
          OnClick = ImposeTemplate1Click
        end
      end
      object MIEscape: TMenuItem
        Caption = 'Escape'
        ShortCut = 27
        OnClick = MIEscapeClick
      end
      object Repeatautoplay1: TMenuItem
        Caption = 'Repeat autoplay'
        ShortCut = 16505
        OnClick = Repeatautoplay1Click
      end
      object MITestRepetition: TMenuItem
        Caption = 'Test repetition cycle'
        ShortCut = 41036
        OnClick = MITestRepetitionClick
      end
      object Popupmenu1: TMenuItem
        Caption = 'Popup menu'
        ShortCut = 32889
        OnClick = Popupmenu1Click
      end
      object MIShowReference: TMenuItem
        Caption = 'Show reference'
        ShortCut = 24690
      end
      object MIRemoveFormattingGlobal: TMenuItem
        Caption = 'Remove formatting'
        ShortCut = 24625
        OnClick = MIRemoveFormattingGlobalClick
      end
      object N49: TMenuItem
        Caption = '-'
      end
      object Downloadimages1: TMenuItem
        Caption = 'Download images'
        ShortCut = 16503
        OnClick = Downloadimages1Click
      end
      object Spellcheck1: TMenuItem
        Caption = 'Spellcheck'
        ShortCut = 118
        OnClick = Spellcheck1Click
      end
      object MIProcessImageOptions: TMenuItem
        Caption = 'Zooming options'
        ShortCut = 24695
        OnClick = MIProcessImageOptionsClick
      end
      object WebSearch1: TMenuItem
        Caption = 'Web Search'
        ShortCut = 16498
        OnClick = WebSearch1Click
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object MITest: TMenuItem
        Caption = 'Test'
        ShortCut = 119
        OnClick = MITestClick
      end
    end
  end
  object ColorDialog1: TColorDialog
    Left = 1302
    Top = 486
  end
  object OpenDialog1: TOpenDialog
    Options = [ofPathMustExist]
    Left = 984
    Top = 486
  end
  object RepetitionTimer: TTimer
    Enabled = False
    Interval = 250
    OnTimer = RepetitionTimerTimer
    Left = 1146
    Top = 276
  end
  object TimeUpdate: TTimer
    Enabled = False
    OnTimer = TimeUpdateTimer
    Left = 1302
    Top = 276
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    Left = 1164
    Top = 486
  end
  object SaveDialog: TSaveDialog
    Options = [ofEnableSizing]
    Left = 1446
    Top = 492
  end
  object PlanTimer: TTimer
    Enabled = False
    OnTimer = PlanTimerTimer
    Left = 984
    Top = 276
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    Hint = 'SuperMemo learning'
    BalloonHint = 'Click SuperMemo tray icon to reactivate SuperMemo'
    BalloonTitle = 'Alarm sounded in SuperMemo'
    BalloonFlags = bfInfo
    OnClick = TrayIcon1Click
    Left = 44
    Top = 572
  end
  object AlarmFlicker: TTimer
    Enabled = False
    Interval = 300
    OnTimer = AlarmFlickerTimer
    Left = 1440
    Top = 282
  end
end
