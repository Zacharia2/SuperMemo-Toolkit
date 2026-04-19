object ElWind: TElWind
  Left = -5000
  Top = 152
  HelpContext = 18
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Element Window'
  ClientHeight = 1421
  ClientWidth = 2941
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -32
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  PopupMenu = ElementMenu
  PopupMode = pmAuto
  Position = poDesigned
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnDragDrop = FormDragDrop
  OnDragOver = FormDragOver
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 39
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 137
    Width = 2941
    Height = 504
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 6
    StyleElements = []
    OnDragDrop = FormDragDrop
    OnDragOver = FormDragOver
    OnMouseMove = FormMouseMove
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 2937
      Height = 386
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Visible = False
      OnDragDrop = FormDragDrop
      OnDragOver = FormDragOver
      OnMouseDown = FormMouseDown
      OnMouseMove = FormMouseMove
      OnMouseUp = FormMouseUp
      OnPaint = PaintBox1Paint
      ExplicitWidth = 3348
    end
    object Shadow: TShape
      Left = 713
      Top = 324
      Width = 61
      Height = 50
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Brush.Color = clBtnShadow
      Pen.Style = psClear
      Pen.Width = 2
      Visible = False
      OnMouseDown = ShadowMouseDown
      OnMouseMove = ShadowMouseMove
    end
    object SpellResult: TMemo
      Left = 419
      Top = 324
      Width = 229
      Height = 38
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Microsoft YaHei'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Visible = False
    end
  end
  object CreditPanel: TPanel
    Left = 0
    Top = 85
    Width = 2941
    Height = 52
    Hint = 
      'Register SuperMemo to obtain the unlock password (in a business ' +
      'day)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ParentCustomHint = False
    Align = alTop
    BiDiMode = bdLeftToRight
    Caption = 'Click here to REGISTER'
    Color = clRed
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -29
    Font.Name = 'Microsoft YaHei'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentBackground = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Visible = False
    StyleElements = []
    OnClick = CreditPanelClick
  end
  object LearnPanel: TPanel
    Left = 104
    Top = 776
    Width = 1498
    Height = 90
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 7
    Visible = False
    OnMouseDown = FormMouseDown
    object LearnBar: TToolBar
      Left = 84
      Top = -4
      Width = 1344
      Height = 53
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alNone
      AutoSize = True
      ButtonHeight = 38
      ButtonWidth = 51
      Caption = 'LearnBar'
      Flat = False
      Images = AboutBox.VirtualImageList32
      List = True
      AllowTextButtons = True
      TabOrder = 0
      TabStop = True
      Transparent = False
      Wrapable = False
      OnMouseDown = FormMouseDown
      object Stop: TToolButton
        Left = 0
        Top = 0
        Hint = 'Stop learning (Esc)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 22
        ImageName = 'icon_022'
        OnClick = StopClick
      end
      object ButtonsSeparator: TToolButton
        Left = 40
        Top = 0
        Width = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ImageIndex = 27
        ImageName = 'icon_027'
        Style = tbsSeparator
      end
      object AddNoteBtn: TToolButton
        Left = 52
        Top = 0
        Hint = 'Add a note (e.g. to type in a text of a new HTML topic)(Alt+N)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'AddNoteBtn'
        ImageIndex = 140
        ImageName = 'icon_140'
        PopupMenu = Imports
        OnClick = AddNoteBtnClick
      end
      object PasteArticleBtn: TToolButton
        Left = 92
        Top = 0
        Hint = 'Paste an article to SuperMemo (Ctrl+N)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 82
        ImageName = 'icon_082'
        PopupMenu = Imports
        OnClick = MIPasteArticleClick
      end
      object ExtractButton: TToolButton
        Left = 132
        Top = 0
        Hint = 'Extract the selected text as a new topic in learning (Alt+X)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'ExtractButton'
        ImageIndex = 144
        ImageName = 'icon_144'
        PopupMenu = Read
        OnClick = ExtractButtonClick
      end
      object ClozeButton: TToolButton
        Left = 172
        Top = 0
        Hint = 
          'Convert the selected keyword into a deletion and produce a new c' +
          'loze item (Alt+Z)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'ClozeButton'
        ImageIndex = 129
        ImageName = 'icon_129'
        PopupMenu = Read
        OnClick = ClozeButtonClick
      end
      object ToolButton7: TToolButton
        Left = 212
        Top = 0
        Width = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'ToolButton7'
        ImageIndex = 0
        ImageName = 'icon_000'
        Style = tbsSeparator
      end
      object PriorityPercent: TLabel
        AlignWithMargins = True
        Left = 224
        Top = 0
        Width = 71
        Height = 51
        Hint = 'Element'#39's priority (expressed as a percentile from the top)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alCustom
        Alignment = taCenter
        Caption = '11%'
        Color = 5329407
        GlowSize = 3
        ParentColor = False
        Transparent = False
        Layout = tlCenter
        StyleElements = []
      end
      object PriorityPosition: TLabel
        Left = 295
        Top = 0
        Width = 98
        Height = 51
        Hint = 'Element'#39's priority (expressed as a position in the queue)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Alignment = taCenter
        Caption = '(1234)'
        Color = 12040191
        GlowSize = 3
        ParentColor = False
        Transparent = False
        Layout = tlCenter
        StyleElements = []
      end
      object PriorityBtn: TToolButton
        Left = 393
        Top = 0
        Hint = 'Change element'#39's priority (Alt+P)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 138
        ImageName = 'icon_138'
        PopupMenu = PriorityMenu
        OnClick = PriorityBtnClick
      end
      object IntervalLabel: TLabel
        AlignWithMargins = True
        Left = 433
        Top = 0
        Width = 56
        Height = 51
        Hint = 'Current interval (i.e. the period between reviews)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Alignment = taCenter
        Caption = '1 day'
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -20
        Font.Name = 'Microsoft YaHei'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        StyleElements = []
      end
      object RepsLabel: TLabel
        AlignWithMargins = True
        Left = 489
        Top = 0
        Width = 89
        Height = 51
        Hint = 
          'Number of repetitions and the number of memory lapses (if non-ze' +
          'ro)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Alignment = taCenter
        Caption = ' (1:0) '
        Color = clAqua
        ParentColor = False
        Transparent = False
        Layout = tlCenter
        StyleElements = []
      end
      object ForceRepetitionBtn: TToolButton
        Left = 578
        Top = 0
        Hint = 
          'Change the interval and the date of the next review by executing' +
          ' a repetition now (Ctrl+Shift+R)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 142
        ImageName = 'icon_142'
        PopupMenu = Schedule
        OnClick = ForceRepetitionBtnClick
      end
      object NextRepLabel: TLabel
        Left = 618
        Top = 0
        Width = 138
        Height = 51
        Hint = 'Date of the next expected review'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alCustom
        Alignment = taCenter
        Caption = 'Apr 05, 2011'
        Color = 14352384
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -20
        Font.Name = 'Microsoft YaHei'
        Font.Style = [fsBold]
        GlowSize = 3
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        StyleElements = []
      end
      object NextRepDate: TToolButton
        Left = 756
        Top = 0
        Hint = 'View the calendar of repetitions (Ctrl+W)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 7
        ImageName = 'icon_007'
        PopupMenu = Schedule
        OnClick = NextRepDateClick
      end
      object RLabel: TLabel
        Left = 796
        Top = 0
        Width = 44
        Height = 51
        Hint = 
          'Retrievability: estimated current chance of recalling the presen' +
          'ted item'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alCustom
        Alignment = taCenter
        Caption = '100%'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Microsoft YaHei'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        StyleElements = []
      end
      object SLabel: TLabel
        Left = 840
        Top = 0
        Width = 40
        Height = 51
        Hint = 
          'Stability: predicted duration of memory as the interval that wil' +
          'l make recall drop to 90%'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alCustom
        Alignment = taCenter
        Caption = '1 day'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Microsoft YaHei'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        StyleElements = []
      end
      object Done: TToolButton
        Left = 880
        Top = 0
        Hint = 
          'Delete processed texts, or all texts, or the entire element (dep' +
          'ending on the context)(Ctrl+Shift+Enter)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'Done'
        ImageIndex = 16
        ImageName = 'icon_016'
        PopupMenu = Del
        OnClick = DoneClick
      end
      object ApplyTemplateBtn: TToolButton
        Left = 920
        Top = 0
        Hint = 'Apply template to change the looks of the element'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'ApplyTemplateBtn'
        ImageIndex = 113
        ImageName = 'icon_113'
        PopupMenu = Templates
        OnClick = MIApplyTemplateClick
      end
      object FontBtn: TToolButton
        Left = 960
        Top = 0
        Hint = 'Choose a font for the selected text or the entire component'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'FontBtn'
        ImageIndex = 24
        ImageName = 'icon_024'
        PopupMenu = Text
        OnClick = FontBtnClick
      end
      object PlainTextBtn: TToolButton
        Left = 1000
        Top = 0
        Hint = 
          'Remove formatting from the selected text or from the entire comp' +
          'onent'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'PlainTextBtn'
        ImageIndex = 149
        ImageName = 'icon_149'
        PopupMenu = Text
        OnClick = PlainTextBtnClick
      end
      object EditBtn: TToolButton
        Left = 1040
        Top = 0
        Hint = 'Switch to edit mode (or to drag-and-size mode)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'EditBtn'
        ImageIndex = 143
        ImageName = 'icon_143'
        PopupMenu = Switch
        OnClick = MISwitchModeClick
      end
      object ToolButton3: TToolButton
        Left = 1080
        Top = 0
        Width = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'ToolButton3'
        ImageIndex = 69
        ImageName = 'icon_069'
        Style = tbsSeparator
      end
      object DuplicateBtn: TToolButton
        Left = 1092
        Top = 0
        Hint = 'Duplicate the current element (Alt+D)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'DuplicateBtn'
        ImageIndex = 148
        ImageName = 'icon_148'
        PopupMenu = Dup
        OnClick = MIDuplicateClick
      end
      object CopyBtn: TToolButton
        Left = 1132
        Top = 0
        Hint = 'Copy the object to the clipboard (Ctrl+C)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'CopyBtn'
        ImageIndex = 81
        ImageName = 'icon_081'
        PopupMenu = CopyMenu
        OnClick = MICopyClick
      end
      object PasteBtn: TToolButton
        Left = 1172
        Top = 0
        Hint = 'Paste content from the clipboard (Ctrl+V)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'PasteBtn'
        ImageIndex = 139
        ImageName = 'icon_139'
        PopupMenu = CopyMenu
        OnClick = MIComponentPasteClick
      end
      object ToolButton6: TToolButton
        Left = 1212
        Top = 0
        Width = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'ToolButton6'
        ImageIndex = 69
        ImageName = 'icon_069'
        Style = tbsSeparator
      end
      object ImportBtn: TToolButton
        Left = 1224
        Top = 0
        Hint = 
          'Import from the web (documents, pictures, Wikipedia articles, Yo' +
          'uTube videos, etc.)(Shift+F8)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'ImportBtn'
        ImageIndex = 141
        ImageName = 'icon_141'
        PopupMenu = Imports
        OnClick = ImportBtnClick
      end
      object EditFileBtn: TToolButton
        Left = 1264
        Top = 0
        Hint = 
          'Edit the file associated with the current component (using the d' +
          'efault editor defined in Windows)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 43
        ImageName = 'icon_043'
        PopupMenu = Files
        OnClick = EditFileBtnClick
      end
      object LearnBarHelp: TToolButton
        Left = 1304
        Top = 0
        Hint = 'Read help file about the learnbar'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ImageIndex = 68
        ImageName = 'icon_068'
        OnClick = LearnBarHelpClick
      end
    end
    object LearnbarTabs: TTabControl
      Left = 0
      Top = 51
      Width = 1498
      Height = 52
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Images = AboutBox.VirtualImageList32
      TabOrder = 1
      TabPosition = tpBottom
      Tabs.Strings = (
        'Learn'
        'Edit'
        'Read'
        'Compose'
        'Tools'
        'Alarm')
      TabIndex = 0
      OnChange = LearnbarTabsChange
      OnGetImageIndex = LearnbarTabsGetImageIndex
    end
  end
  object GradePanel: TPanel
    Left = 954
    Top = 876
    Width = 762
    Height = 110
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    AutoSize = True
    BevelEdges = []
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 1
    Visible = False
    object Great: TBitBtn
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 120
      Height = 100
      Hint = 
        'Excellent response given without hesitation (keyboard shortcut 5' +
        ')'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Great'
      Style = bsNew
      TabOrder = 0
      OnClick = GreatClick
      OnKeyDown = FormKeyDown
    end
    object Good: TBitBtn
      AlignWithMargins = True
      Left = 125
      Top = 5
      Width = 120
      Height = 100
      Hint = 'Correct response (shortcut 4)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Good'
      Style = bsNew
      TabOrder = 1
      OnClick = GoodClick
      OnKeyDown = FormKeyDown
    end
    object Pass: TBitBtn
      AlignWithMargins = True
      Left = 245
      Top = 5
      Width = 120
      Height = 100
      Hint = 
        'Rather correct response recalled with substantial effort (shortc' +
        'ut 3)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Pass'
      Default = True
      Style = bsNew
      TabOrder = 2
      OnClick = PassClick
      OnKeyDown = FormKeyDown
    end
    object Fail: TBitBtn
      AlignWithMargins = True
      Left = 365
      Top = 5
      Width = 120
      Height = 100
      Hint = 'Wrong response with some hazy recall (shortcut 2)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Fail'
      Style = bsNew
      TabOrder = 3
      OnClick = FailClick
      OnKeyDown = FormKeyDown
    end
    object Bad: TBitBtn
      AlignWithMargins = True
      Left = 485
      Top = 5
      Width = 120
      Height = 100
      Hint = 'Little or no recall (shortcut 1)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Bad'
      Style = bsNew
      TabOrder = 4
      OnClick = BadClick
      OnKeyDown = FormKeyDown
    end
    object CancelGrade: TBitBtn
      AlignWithMargins = True
      Left = 610
      Top = 5
      Width = 147
      Height = 100
      Hint = 'Cancel grade (Alt+G)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Cancel'
      Style = bsNew
      TabOrder = 5
      OnClick = CancelLearningClick
      OnKeyDown = FormKeyDown
    end
  end
  object Learn: TBitBtn
    Left = 12
    Top = 876
    Width = 270
    Height = 94
    Hint = 'Start learning'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Learn'
    PopupMenu = ElementMenu
    Style = bsNew
    TabOrder = 2
    Visible = False
    OnClick = LearnClick
    OnKeyDown = FormKeyDown
  end
  object AddNew: TBitBtn
    Left = 422
    Top = 876
    Width = 180
    Height = 90
    Hint = 'Add a new question-answer pair (Alt+A)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Add new'
    Glyph.Data = {
      360C0000424D360C000000000000360000002800000020000000200000000100
      180000000000000C000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000349E6F349E6F349E
      6F349E6F349E6F349E6F349E6F349E6F349E6F349E6F349E6F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000339F6F3CD7A73CD7
      A73CD7A73CD7A73CD7A73CD7A73CD7A73CD7A73CD7A7339E7000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000033A0703CD7A713B9
      8C13B98C13B98C13B98C13B98C13B98C13B98C3CD7A7329F7000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000031A17139D7A60CC7
      8F0CC78F0CC78F0CC78F0CC78F0CC78F0CC78F39D7A632A17100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000030A27234D5A40CC7
      900CC7900CC7900CC7900CC7900CC7900CC79034D6A531A27200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000002FA3732FD5A20CC8
      910CC8910CC8910CC8910CC8910CC8910CC8912FD4A330A37200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000002DA47429D3A10DCA
      920DCA920DCA920DCA920DCA920DCA920DCA9229D3A12EA47300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000002CA67523D29F0DCB
      930DCB930DCB930DCB930DCB930DCB930DCB9323D19F2DA57400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000002BA6761DD09D0DCC
      940DCC940DCC940DCC940DCC940DCC940DCC941DD19C2BA67600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000029A87817D09A0DCD
      960DCD960DCD960DCD960DCD960DCD960DCD9617D09B2AA87700000000000000
      000000000000000000000000000000000000000000000000000028AA7A27AA7A
      28AA7A27AA7928AA7928AA7928AA7928AA7928AA7927AA7927AA7914CE990DCF
      980DCF980DCF980DCF980DCF980DCF980DCF9813CF9928A97929A97929A97828
      A97928A97829A97829A97828A97829A97829A97829A97800000026AC7B1DD4A0
      3EDCB03EDCB03EDCB03EDCB03EDCB03EDCB03EDCB03EDCB03EDCB011CE980DD0
      990DD0990DD0990DD0990DD0990DD0990DD09911CE983EDCB03EDCB03EDCB03E
      DCB03EDCB03EDCB03EDCB03EDCB03EDCB040DDB127AA7900000024AE7C20D7A3
      11C99611C99611C99611C99611C99611C99611C99611C99611C99611C9960DD2
      9B0DD29B0DD29B0DD29B0DD29B0DD29B0DD29B0DD29B11C99611C99611C99611
      C99611C99611C99611C99611C99611C99615D49E26AC7B00000022AF7D25D8A5
      0ED39C0ED39C0ED39C0ED39C0ED39C0ED39C0ED39C0ED39C0ED39C0ED39C0ED3
      9C0ED39C0ED39C0ED39C0ED39C0ED39C0ED39C0ED39C0ED39C0ED39C0ED39C0E
      D39C0ED39C0ED39C0ED39C0ED39C0ED39C19D6A024AD7C00000021B17F28DAA7
      0ED59E0ED59E0ED59E0ED59E0ED59E0ED59E0ED59E0ED59E0ED59E0ED59E0ED5
      9E0ED59E0ED59E0ED59E0ED59E0ED59E0ED59E0ED59E0ED59E0ED59E0ED59E0E
      D59E0ED59E0ED59E0ED59E0ED59E0ED59E1CD8A322AF7D0000001FB2802BDBAA
      0ED6A00ED6A00ED6A00ED6A00ED6A00ED6A00ED6A00ED6A00ED6A00ED6A00ED6
      A00ED6A00ED6A00ED6A00ED6A00ED6A00ED6A00ED6A00ED6A00ED6A00ED6A00E
      D6A00ED6A00ED6A00ED6A00ED6A00ED6A01FD9A620B17F0000001EB4822FDDAB
      10D8A110D8A110D8A110D8A110D8A10FD8A10FD8A10FD8A10FD8A10FD8A10FD8
      A10ED8A10ED8A10ED8A10ED8A10ED8A10ED8A10ED8A10ED8A10ED8A10ED8A10E
      D8A10ED8A10ED8A10ED8A10ED8A10ED8A123DBA820B2800000001BB68334DEAE
      13D9A413D9A413D9A413D9A413D9A413D9A413D9A412D9A412D9A412D9A412D9
      A412D9A411D9A311D9A311D9A311D9A311D9A311D9A310D9A310D9A310D9A310
      D9A310D9A310D9A30FD9A30FD9A30FD9A327DCAA1DB4810000001AB78439DFAF
      16DBA616DBA616DBA616DBA616DBA615DBA615DBA615DBA615DBA614DBA614DB
      A614DBA614DBA614DBA613DBA613DBA613DBA613DBA613DBA613DBA613DBA613
      DBA613DBA613DBA513DBA513DBA512DBA52CDEAC1CB68300000018B885CFF4E8
      90F9D990F9D990F9D990F9D990F9D990F9D990F9D990F9D9F5F9F71FDDA919DC
      A719DCA719DCA719DCA718DCA718DCA718DCA71DDDA9F5F9F790F9D990F9D990
      F9D990F9D990F9D990F9D990F9D990F9D9F5F9F71AB78400000017BA8717BA86
      17BB8717BA8617BA8617BA8718BA8717B98617BA8718BA8617BA862AE0AD1DDD
      A91DDDA91DDDA91DDDA91CDDA91CDDA91CDDA928E0AD18B98619BA8618B98618
      B98618B98618B98618B98618B98619B98519B98519B985000000000000000000
      00000000000000000000000000000000000000000000000016BB8735E2AF22DD
      A921DDA921DDA921DDA921DDA920DDA920DEA933E2AF16BB8700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000014BC883FE4B326DE
      AB26DEAB25DEAB25DEAB25DEAB25DEAB24DEAB3CE3B215BC8800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000013BE8A46E5B52ADE
      AB2ADEAB29DEAB29DEAB29DEAB29DEAB29DEAB45E5B514BE8900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000013BF8B4CE6B72EDE
      AB2EDEAB2EDEAB2DDEAB2DDEAB2DDEAB2DDEAC4BE6B713BF8B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000012C08C50E7B831DE
      AB31DEAB31DEAB31DEAB31DEAB30DEAB30DEAC4FE7B812C08C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000011C28C53E8B935DD
      AB35DDAB34DDAB34DDAB34DEAB34DEAB34DEAB53E8B911C18C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000FC38D54E9BA37DD
      AB37DDAB37DDAB37DDAB37DDAB37DDAB37DDAB54E9BA10C28D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000EC38E79EDC83ADC
      AB3ADCAB39DCAB39DCAB39DCAB39DCAB39DDAB79EDC80FC38E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000EC48FF5F9F790F9
      D990F9D990F9D990F9D990F9D990F9D990F9D9F5F9F70FC48F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000EC48F0EC48F0EC4
      8F0EC48F0EC48F0EC48F0EC48F0EC48F0EC48F0EC48F0EC48F00000000000000
      0000000000000000000000000000000000000000000000000000}
    PopupMenu = ElementMenu
    Style = bsNew
    TabOrder = 3
    Visible = False
    OnClick = AddNewClick
  end
  object CancelShowAnswer: TBitBtn
    Left = 732
    Top = 876
    Width = 123
    Height = 90
    Hint = 'Cancel show answer (Alt+G)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = '  Cancel  '
    Style = bsNew
    TabOrder = 5
    Visible = False
    OnClick = CancelLearningClick
    OnKeyDown = FormKeyDown
  end
  object NavPanel: TPanel
    Left = 0
    Top = 0
    Width = 2941
    Height = 85
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    ParentColor = True
    TabOrder = 4
    object CaptionPanel: TPanel
      Left = 2317
      Top = 4
      Width = 432
      Height = 78
      Hint = 
        'Current collection name, collection folder and version of SuperM' +
        'emo'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      BevelInner = bvLowered
      BevelKind = bkTile
      BevelWidth = 2
      Caption = 'SM20'
      ParentColor = True
      TabOrder = 0
      OnMouseDown = FormMouseDown
      object TestBtn: TButton
        Left = 4
        Top = 4
        Width = 420
        Height = 66
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Caption = 'TEST--------------------------'
        TabOrder = 0
        Visible = False
        OnClick = TestBtnClick
      end
      object ComputePasswordBtn: TButton
        Left = 155
        Top = 7
        Width = 266
        Height = 62
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Password'
        TabOrder = 1
        Visible = False
        StyleElements = []
        OnClick = ComputePasswordBtnClick
      end
    end
    object ConceptEdit: TEdit
      Left = 1948
      Top = 9
      Width = 347
      Height = 47
      Hint = 'Default concept group for adding new elements'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      BevelKind = bkTile
      BevelWidth = 1
      ParentColor = True
      PopupMenu = Concepts
      ReadOnly = True
      TabOrder = 1
      Text = 'Concept'
      OnClick = ConceptEditClick
      Font.Height = -24
    end
    object NavBar: TToolBar
      AlignWithMargins = True
      Left = 9
      Top = 9
      Width = 1926
      Height = 70
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alNone
      AutoSize = True
      ButtonHeight = 70
      ButtonWidth = 340
      HideClippedButtons = True
      Images = AboutBox.VirtualImageList32
      List = True
      PopupMenu = ElementMenu
      ShowCaptions = True
      AllowTextButtons = True
      TabOrder = 2
      TabStop = True
      Transparent = False
      Wrapable = False
      OnMouseDown = FormMouseDown
      OnResize = NavBarResize
      object PickCollection: TToolButton
        Left = 0
        Top = 0
        Hint = 'Pick a collection from the list of favorites'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'PickCollection'
        ImageIndex = 180
        ImageName = 'icon_180'
        OnClick = PickCollectionClick
      end
      object ToolButton1: TToolButton
        Left = 72
        Top = 0
        Width = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'ToolButton1'
        ImageIndex = 335
        Style = tbsSeparator
      end
      object ContentsBtn: TToolButton
        Left = 84
        Top = 0
        Hint = 'View or modify the knowledge tree (Alt+C)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'Contents'
        ImageIndex = 73
        ImageName = 'icon_073'
        Style = tbsTextButton
        OnClick = ContentsClick
      end
      object ToolButton4: TToolButton
        Left = 288
        Top = 0
        Width = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'ToolButton4'
        ImageIndex = 1
        ImageName = 'icon_001'
        Style = tbsSeparator
      end
      object SearchBtn: TToolButton
        Left = 300
        Top = 0
        Hint = 'Search for texts in the current collection (Ctrl+F)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'Search'
        ImageIndex = 5
        ImageName = 'icon_005'
        PopupMenu = Searches
        Style = tbsTextButton
        OnClick = SearchBtnClick
      end
      object ToolButton5: TToolButton
        Left = 476
        Top = 0
        Width = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'ToolButton5'
        ImageIndex = 1
        ImageName = 'icon_001'
        Style = tbsSeparator
      end
      object BackBtn: TToolButton
        Left = 488
        Top = 0
        Hint = 'Go to the previously visited element (Alt+Left)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = '<'
        ImageIndex = 136
        ImageName = 'icon_136'
        OnClick = BackButtonClick
      end
      object ForwardBtn: TToolButton
        Left = 560
        Top = 0
        Hint = 'Backtrack the steps of revisited elements (Alt+Right)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = '>'
        ImageIndex = 137
        ImageName = 'icon_137'
        OnClick = ForwardButtonClick
      end
      object ToolButton11: TToolButton
        Left = 632
        Top = 0
        Width = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'ToolButton11'
        ImageIndex = 3
        ImageName = 'icon_003'
        Style = tbsSeparator
      end
      object HistoryBtn: TToolButton
        Left = 644
        Top = 0
        Hint = 'Show the list of most recently visited elements'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'History'
        ImageIndex = 74
        ImageName = 'icon_074'
        Style = tbsTextButton
        OnClick = HistoryButtonClick
      end
      object ToolButton2: TToolButton
        Left = 822
        Top = 0
        Width = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'ToolButton2'
        ImageIndex = 4
        ImageName = 'icon_004'
        Style = tbsSeparator
      end
      object HomeB: TToolButton
        Left = 834
        Top = 0
        Hint = 'Go to the first element (Alt+Home)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 131
        ImageName = 'icon_131'
        OnClick = NavigationButtonClick
      end
      object PElementB: TToolButton
        Left = 906
        Top = 0
        Hint = 'Go to the previous element (Alt+PgUp)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 133
        ImageName = 'icon_133'
        OnClick = NavigationButtonClick
      end
      object ParentB: TToolButton
        Left = 978
        Top = 0
        Hint = 'Go to the parent (Ctrl+Up)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 135
        ImageName = 'icon_135'
        OnClick = NavigationButtonClick
      end
      object NElementB: TToolButton
        Left = 1050
        Top = 0
        Hint = 'Go to the next element (Alt+PgDn)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 134
        ImageName = 'icon_134'
        OnClick = NavigationButtonClick
      end
      object EndB: TToolButton
        Left = 1122
        Top = 0
        Hint = 'Go to the last element (Alt+End)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        ImageIndex = 132
        ImageName = 'icon_132'
        OnClick = NavigationButtonClick
      end
      object ToolButton16: TToolButton
        Left = 1194
        Top = 0
        Width = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'ToolButton16'
        ImageIndex = 130
        ImageName = 'icon_130'
        Style = tbsSeparator
      end
      object FindBtn: TToolButton
        Left = 1206
        Top = 0
        Hint = 'Search for a text in the current article (F3)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'Find'
        ImageIndex = 239
        ImageName = 'Search'
        PopupMenu = Searches
        OnClick = FindBtnClick
      end
      object ReferenceBtn: TToolButton
        Left = 1278
        Top = 0
        Hint = 
          'Go to the source article on the web or in the collection (Ctrl+S' +
          'hift+W)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = True
        Caption = 'Source'
        ImageIndex = 128
        ImageName = 'icon_128'
        PopupMenu = Hyperlinks
        OnClick = ReferenceBtnClick
      end
      object WebSearchBtn: TToolButton
        Left = 1350
        Top = 0
        Hint = 'Search the web (Ctrl+F3)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'WebSearchBtn'
        ImageIndex = 187
        ImageName = 'icon_187'
        PopupMenu = Tools
        OnClick = WebSearchBtnClick
      end
      object MailBtn: TToolButton
        Left = 1422
        Top = 0
        Hint = 'Send current element via e-mail (Ctrl+Shift+E)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ImageIndex = 130
        ImageName = 'icon_130'
        PopupMenu = Mail
        OnClick = MailBtnClick
      end
      object CommanderBtn: TToolButton
        Left = 1494
        Top = 0
        Hint = 
          'Open SuperMemo Commander for a list of quick mnemonic commands (' +
          'Ctrl+Enter)'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'CommanderBtn'
        ImageIndex = 28
        ImageName = 'icon_028'
        PopupMenu = Tools
        OnClick = CommanderBtnClick
      end
      object DownloadBtn: TToolButton
        Left = 1566
        Top = 0
        Hint = 'Download the original of the page'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'DownloadBtn'
        ImageIndex = 241
        ImageName = 'icon_241'
        OnClick = DownloadBtnClick
      end
      object LayoutsBtn: TToolButton
        Left = 1638
        Top = 0
        Hint = 'Open a dialog with the list of layouts used in SuperMemo'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'LayoutsBtn'
        ImageIndex = 67
        ImageName = 'icon_067'
        PopupMenu = Layouts
        OnClick = LayoutsBtnClick
      end
      object HelpBtn: TToolButton
        Left = 1710
        Top = 0
        Hint = 'Open help files'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'HelpBtn'
        ImageIndex = 68
        ImageName = 'icon_068'
        OnClick = HelpBtnClick
      end
      object LinkConceptBtn: TToolButton
        Left = 1782
        Top = 0
        Hint = 
          'Link the current element with any concept from the concept regis' +
          'try'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'LinkConceptBtn'
        ImageIndex = 212
        ImageName = 'icon_212'
        PopupMenu = Concepts
        OnClick = LinkConceptBtnClick
      end
      object DefaultConceptBtn: TToolButton
        Left = 1854
        Top = 0
        Hint = 'Choose default concept group for adding new elements'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'DefaultConceptBtn'
        ImageIndex = 209
        ImageName = 'icon_209'
        PopupMenu = Concepts
        OnClick = DefaultConceptBtnClick
      end
    end
  end
  object ElementMenu: TPopupMenu
    HelpContext = 7
    Images = AboutBox.VirtualImageList16
    OnPopup = ElementMenuPopup
    Left = 60
    Top = 144
    object MILearningMenu: TMenuItem
      AutoHotkeys = maAutomatic
      AutoLineReduction = maAutomatic
      Caption = '&Learning'
      object MIForceRepetition: TMenuItem
        Caption = '&Execute repetition'
        Hint = 'Execute element'#39's repetition today'
        ImageIndex = 142
        ImageName = 'icon_142'
        ShortCut = 24658
        OnClick = MIForceRepetitionClick
      end
      object MIJumpInterval: TMenuItem
        Caption = '&Reschedule'
        Hint = 'Schedule the next repetition on a given day'
        ShortCut = 16458
        OnClick = MIJumpIntervalClick
      end
      object MILaterToday: TMenuItem
        Caption = 'Later today'
        Hint = 'Schedule the element for review later today'
        ShortCut = 24650
        OnClick = MILaterTodayClick
      end
      object MIDrill: TMenuItem
        Caption = 'Add to drill'
        Hint = 'Add the element to the final drill queue'
        ShortCut = 24644
        OnClick = MIDrillClick
      end
      object MIAddToSubset: TMenuItem
        Caption = '&Add to subset'
        Hint = 'Add the element to a selected subset'
        OnClick = MIAddToSubsetClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object MIRemember: TMenuItem
        Caption = 'Re&member'
        HelpContext = 7
        Hint = 'Memorize the element and introduce it into the learning process'
        ImageIndex = 112
        ImageName = 'icon_112'
        ShortCut = 16461
        OnClick = MIRememberClick
      end
      object MIReset: TMenuItem
        Caption = 'Fo&rget'
        HelpContext = 7
        Hint = 'Remove the currently displayed element from the learning process'
        OnClick = MIForgetClick
      end
      object MIDismiss: TMenuItem
        Caption = '&Dismiss'
        HelpContext = 7
        Hint = 'Ignore the current element in the learning process'
        ShortCut = 16452
        OnClick = MIDismissClick
      end
      object MIDone: TMenuItem
        Caption = 'Done'
        Hint = 'Terminate the life of the element in incremental reading'
        ImageIndex = 16
        ImageName = 'icon_016'
        ShortCut = 24589
        OnClick = DoneClick
      end
      object MIUndoRepetition: TMenuItem
        Caption = 'Undo Repetition'
        Hint = 'Undo the effects of the most recent repetition'
        ImageIndex = 194
        ImageName = 'icon_194'
        OnClick = MIUndoRepetitionClick
      end
      object N48: TMenuItem
        Caption = '-'
      end
      object MILearnBranch: TMenuItem
        Caption = '&Learn branch'
        Hint = 'Make repetitions only in the current branch'
        ImageName = 'icon_034'
        OnClick = MILearnBranchClick
      end
      object MIPostpone: TMenuItem
        Caption = '&Postpone branch'
        Hint = 'Postpone outstanding repetitions in the current branch'
        OnClick = MIPostponeClick
      end
      object MILocateExtracts: TMenuItem
        Caption = 'Locate extracts'
        Hint = 'Find all extracts and clozes generated from the source article'
        OnClick = MILocateExtractsClick
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object Statistics1: TMenuItem
        Caption = 'Statistics'
        object MIShowRepetitionHistory: TMenuItem
          Caption = 'Repetition history'
          Hint = 'Show the history of repetitions for the current element'
          ShortCut = 24648
          OnClick = MIShowRepetitionHistoryClick
        end
        object MIMemoryStatus: TMenuItem
          Caption = 'Memory status'
          Hint = 
            'Show changes to memory variables over time (stability and retrie' +
            'vability)'
          OnClick = MIMemoryStatusClick
        end
        object MIResetRepHist: TMenuItem
          Caption = 'Reset repetition history'
          Hint = 'Delete the history of repetitions'
          OnClick = MIResetRepHistClick
        end
        object MIBestForgettingIndex: TMenuItem
          Caption = 'Best forgetting index'
          Hint = 
            'Display the impact of the forgetting index on repetitions of the' +
            ' present item'
          OnClick = MIBestForgettingIndexClick
        end
        object MIOptimumRepetitionSchedule: TMenuItem
          Caption = 'Export forgetting index data'
          Hint = 'Export the file with forgetting index data'
          OnClick = MIOptimumRepetitionScheduleClick
        end
        object MINextRepetitionSInc: TMenuItem
          Caption = 'Next repetition stability'
          Hint = 'See how stability increases at different intervals'
          OnClick = MINextRepetitionSIncClick
        end
        object MIRepetitionsSimulation: TMenuItem
          Caption = 'Repetition simulation'
          Hint = 'Simulate repetitions for best S or minimum reps in a period'
          Visible = False
          OnClick = MIRepetitionsSimulationClick
        end
        object MIDifficultyAnalysis: TMenuItem
          Caption = 'Difficulty analysis'
          Hint = 
            'Export data used in determining item difficulty in Algorithm SM-' +
            '17'
          OnClick = MIDifficultyAnalysisClick
        end
      end
    end
    object Concept1: TMenuItem
      Caption = '&Concepts'
      ImageIndex = 209
      ImageName = 'icon_209'
      object MICreateConcept: TMenuItem
        Caption = '&Create concept'
        Hint = 'Convert current element into a concept'
        OnClick = MICreateConceptClick
      end
      object MILinkConcept: TMenuItem
        Caption = '&Link concept'
        Hint = 'Attach an existing concept to the current element'
        ImageIndex = 212
        ImageName = 'icon_212'
        OnClick = MILinkConceptClick
      end
      object MIUnlinkConcept: TMenuItem
        Caption = '&Unlink concept'
        Hint = 'Sever a link from the element to a concept'
        OnClick = MIUnlinkConceptClick
      end
      object N82: TMenuItem
        Caption = '-'
      end
      object MICreateLink: TMenuItem
        Caption = 'Create link'
        Hint = 
          'Add current element to links registry to enable linking to other' +
          ' elements'
        OnClick = MICreateLinkClick
      end
      object MILinkElement: TMenuItem
        Caption = 'Link &element'
        Hint = 'Link current element to another element using link registry'
        ImageIndex = 222
        ImageName = 'icon_222'
        OnClick = MILinkElementClick
      end
      object MILinkBranch: TMenuItem
        Caption = 'Link &contents'
        Hint = 
          'Link the element with another element picked from the contents w' +
          'indow'
        OnClick = MILinkBranchClick
      end
      object MIUnlinkElement: TMenuItem
        Caption = 'Unlink element'
        Hint = 'Sever a link from the current element to another element'
        OnClick = MIUnlinkElementClick
      end
      object N83: TMenuItem
        Caption = '-'
      end
      object MIListLinks: TMenuItem
        Caption = 'List links'
        Hint = 'Display all links of the current element in the browser'
        OnClick = MIListLinksClick
      end
      object MIConceptMap: TMenuItem
        Caption = 'Map'
        Hint = 'Display the map associated with the current concept'
        OnClick = MIConceptMapClick
      end
    end
    object Priority1: TMenuItem
      Caption = '&Priority'
      ImageIndex = 138
      ImageName = 'icon_138'
      object MIModifyPriority: TMenuItem
        Caption = '&Modify'
        Hint = 'Set the priority of the element'
        ImageIndex = 138
        ImageName = 'icon_138'
        ShortCut = 32848
        OnClick = MIModifyPriorityClick
      end
      object MIIncreasePriority: TMenuItem
        Caption = 'Increase'
        Hint = 'Increase element priority in the learning process'
        ImageIndex = 200
        ImageName = 'icon_200'
        ShortCut = 24614
        OnClick = MIIncreasePriorityClick
      end
      object MIDecreasePriority: TMenuItem
        Caption = 'Decrease'
        Hint = 'Decrease element priority in the learning process'
        ImageIndex = 199
        ImageName = 'icon_199'
        ShortCut = 24616
        OnClick = MIDecreasePriorityClick
      end
    end
    object MIReferenceMenu: TMenuItem
      Caption = 'Reference'
      Hint = 'Process element references'
      object MILinkReference: TMenuItem
        Caption = 'Link'
        Hint = 'Insert a reference taken from the reference registry'
        ImageIndex = 222
        ImageName = 'icon_222'
        OnClick = MILinkReferenceClick
      end
      object MIEditReference: TMenuItem
        Caption = 'Edit'
        Hint = 'Modify element'#39's references'
        OnClick = MIEditReferenceClick
      end
      object MIAddReference: TMenuItem
        Caption = 'Add'
        Hint = 'Add new reference'
        OnClick = MIAddReferenceClick
      end
      object MIDeleteReference: TMenuItem
        Caption = 'Delete'
        Hint = 'Delete the reference association'
        OnClick = MIDeleteReferenceClick
      end
      object MIDeprecate: TMenuItem
        Caption = 'Deprecate'
        Hint = 
          'Stop new web imports from considering the present reference as a' +
          ' duplicate (i.e. consider it outdated without deleting)'
        OnClick = MIDeprecateClick
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object MICopyReferences: TMenuItem
        Caption = 'Copy'
        Hint = 'Copy reference data to the clipboard'
        OnClick = MICopyReferencesClick
      end
      object MIShowReferences: TMenuItem
        Caption = 'Show'
        Hint = 'Display element'#39's reference data'
        OnClick = MIShowReferencesClick
      end
      object MICitation: TMenuItem
        Caption = 'Citation'
        Hint = 'Process citation reference'
        object MIShowCitation: TMenuItem
          Caption = 'Show'
          Hint = 'Show a formatted citation reference based on current references'
          OnClick = MIShowCitationClick
        end
        object MIInsertCitation: TMenuItem
          Caption = 'Insert'
          Hint = 
            'Insert a formatted citation reference based on the current refer' +
            'ence'
          OnClick = MIInsertCitationClick
        end
      end
    end
    object MIEMailElement: TMenuItem
      Caption = 'E-mail'
      Hint = 'E-mail texts included in the element'
      ImageIndex = 130
      ImageName = 'icon_130'
      OnClick = MIEMailElementClick
      object MISendElement: TMenuItem
        Caption = '&Element'
        Hint = 'Send the element via e-mail'
        ImageIndex = 130
        ImageName = 'icon_130'
        OnClick = MISendElementClick
      end
      object MISendAsAttachment: TMenuItem
        Caption = '&Attachment'
        Hint = 'Send the element as attachments'
        OnClick = MISendAsAttachmentClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object MIMailQA: TMenuItem
        Caption = '&Q&&A'
        Hint = 'E-mail the question and the answer included in the component'
        OnClick = MIMailQAClick
      end
      object MIMailTexts: TMenuItem
        Caption = 'Te&xts'
        Hint = 'Send element texts via e-mail'
        OnClick = MIMailTextsClick
      end
      object MISendHTML: TMenuItem
        Caption = '&HTML'
        Hint = 'Send element as HTML'
        OnClick = MISendHTMLClick
      end
    end
    object N30: TMenuItem
      Caption = '-'
    end
    object MITemplateMenu: TMenuItem
      AutoHotkeys = maAutomatic
      Caption = '&Template'
      HelpContext = 7
      Hint = 
        'Save or load element templates to and from files and/or registri' +
        'es'
      ImageIndex = 113
      ImageName = 'icon_113'
      OnClick = MITemplateMenuClick
      object MISaveAsTemplate: TMenuItem
        Caption = '&Save as template'
        Hint = 'Save current element as a template in the template registry'
        ImageIndex = 169
        ImageName = 'icon_169'
        OnClick = MISaveAsTemplateClick
      end
      object MISaveAsDefault: TMenuItem
        Caption = 'Save as default'
        Hint = 
          'Save the current element as the default template for the current' +
          ' concept group'
        ImageIndex = 170
        ImageName = 'icon_170'
        OnClick = MISaveAsDefaultClick
      end
      object Savewithobjects1: TMenuItem
        Caption = 'Save with objects'
        Hint = 
          'Save template along with objects such as texts, pictures, sounds' +
          ', etc.'
        OnClick = Savewithobjects1Click
      end
      object N28: TMenuItem
        Caption = '-'
      end
      object MIApplyTemplate: TMenuItem
        Caption = '&Apply template'
        Hint = 'Change the look of an element by using a template'
        ImageIndex = 166
        ImageName = 'icon_166'
        ShortCut = 24653
        OnClick = MIApplyTemplateClick
      end
      object MIDetachTemplate: TMenuItem
        Caption = '&Detach template'
        Hint = 
          'Restore the original looks of the element by disconnecting the t' +
          'emplate'
        ImageIndex = 167
        ImageName = 'icon_167'
        OnClick = MIDetachTemplateClick
      end
      object MIImposeTemplate: TMenuItem
        Caption = 'Impose template'
        Hint = 'Permanently set the current look of an element'
        ImageIndex = 168
        ImageName = 'icon_168'
        ShortCut = 24689
        OnClick = MIImposeTemplateClick
      end
      object MIAddTemplate: TMenuItem
        Caption = 'Add template'
        Hint = 'Add new components taken from a selected template'
        OnClick = MIAddTemplateClick
      end
      object N29: TMenuItem
        Caption = '-'
      end
      object MISwapSourceView: TMenuItem
        Caption = 'View source'
        Hint = 'View element'#39's source data (i.e. without the applied template)'
        ShortCut = 24661
        OnClick = MISwapSourceViewClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object MISaveToFile: TMenuItem
        Caption = 'Save to file'
        Hint = 'Save current element as a template file'
        ImageIndex = 51
        ImageName = 'icon_051'
        OnClick = MISaveToFileClick
      end
      object MILoadTemplateFromFile: TMenuItem
        Caption = 'Load from file'
        Hint = 'Apply a template loaded from a template file'
        OnClick = MILoadTemplateFromFileClick
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object Copytemplate1: TMenuItem
        Caption = 'Copy template'
        Hint = 'Copy the look of the current element as a template'
        OnClick = MICopyToClipboardClick
      end
      object MIPasteTemplate1: TMenuItem
        Caption = 'Paste template'
        Hint = 'Paste the look from a template stored in the clipboard'
        OnClick = MIPasteTemplateClick
      end
      object N36: TMenuItem
        Caption = '-'
      end
      object MIFlags: TMenuItem
        Caption = 'Template flags'
        Hint = 'Set template flags that determine how templates are applied'
        OnClick = MIFlagsClick
        object MIDeleteTemplateExtras: TMenuItem
          Caption = 'Delete template extras'
          Hint = 
            'When applying a template, delete all template components that do' +
            ' not match the source'
          OnClick = MIDeleteTemplateExtrasClick
        end
        object MISkipSourceExtras: TMenuItem
          Caption = 'Skip source extras'
          Hint = 
            'When applying a template, delete all source components that do n' +
            'ot match the template'
          OnClick = MISkipSourceExtrasClick
        end
        object MICheckSourceExtras: TMenuItem
          Caption = 'Check source'
          Hint = 
            'Let the source template flags determine the way in which the tem' +
            'plate is applied'
          OnClick = MICheckSourceExtrasClick
        end
        object MICheckTemplateExtras: TMenuItem
          Caption = 'Check template'
          Hint = 
            'Let the template flags determine the way in which the template i' +
            's applied'
          OnClick = MICheckTemplateExtrasClick
        end
      end
    end
    object MICopyTexts: TMenuItem
      Caption = 'Copy'
      Hint = 'Copy texts included in the element to the clipboard'
      ImageIndex = 81
      ImageName = 'icon_081'
      OnClick = MICopyTextsClick
      object MICopyElementSource: TMenuItem
        Caption = '&Element'
        Hint = 'Copy the element to the clipboard'
        OnClick = MICopyElementSourceClick
      end
      object MICopyQA: TMenuItem
        Caption = '&Q&&A '
        Hint = 'Copy question and answer to the clipboard'
        OnClick = MICopyQAClick
      end
      object MICopyText: TMenuItem
        Caption = 'Te&xts'
        Hint = 'Copy texts to the clipboard'
        OnClick = MICopyTextClick
      end
      object MICopyComponent: TMenuItem
        Caption = 'Component'
        Hint = 'Copy the contents of the current component'
        OnClick = MICopyComponentClick
      end
    end
    object MIElementPaste: TMenuItem
      Caption = 'Paste'
      Hint = 'Paste data from the clipboard'
      ImageIndex = 139
      ImageName = 'icon_139'
      ShortCut = 16470
      OnClick = MIElementPasteClick
    end
    object MIEditPopup: TMenuItem
      Caption = '&Edit'
      Hint = 'Edit element menu'
      ImageIndex = 43
      ImageName = 'icon_043'
      object MIEditParamters: TMenuItem
        Caption = 'Element &parameters'
        Hint = 'Edit or view item parameters'
        ShortCut = 24656
        OnClick = MIEditParamtersClick
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object MITitle: TMenuItem
        Caption = '&Title'
        HelpContext = 7
        Hint = 'Name the element'#39's title'
        ShortCut = 32852
        OnClick = MITitleClick
      end
      object MIDuplicate: TMenuItem
        Caption = '&Duplicate'
        HelpContext = 7
        Hint = 'Duplicate the current element'
        ImageIndex = 148
        ImageName = 'icon_148'
        ShortCut = 32836
        OnClick = MIDuplicateClick
      end
      object MIMoveElement: TMenuItem
        Caption = '&Move'
        Hint = 'Move the element to a selected branch in Contents'
        ShortCut = 24662
        OnClick = MIMoveElementClick
      end
      object MITransferElement: TMenuItem
        Caption = 'Transfer'
        Hint = 'Transfer the element to another collection'
        ImageIndex = 232
        ImageName = 'Switch'
        ShortCut = 24660
        OnClick = MITransferElementClick
      end
      object MISwap: TMenuItem
        Caption = '&Swap Q&&A'
        Hint = 
          'Swap the first question text component with the first answer tex' +
          't component'
        ShortCut = 24659
        OnClick = MISwapClick
      end
      object MIDismember: TMenuItem
        Caption = 'Dismember'
        Hint = 'Generate elements from a multi-component element'
        OnClick = MIDismemberClick
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object MICopyToClipboard: TMenuItem
        Caption = '&Copy element'
        Hint = 'Copy the element to the clipboard'
        OnClick = MICopyToClipboardClick
      end
      object MIPasteElement: TMenuItem
        Caption = 'Paste element'
        Hint = 'Create a new element pasted from the clipboard'
        OnClick = MIPasteElementClick
      end
      object MIPasteTemplate: TMenuItem
        Caption = 'Paste template'
        Hint = 
          'Change the look of the element by pasting the template of anothe' +
          'r element'
        OnClick = MIPasteTemplateClick
      end
      object N37: TMenuItem
        Caption = '-'
      end
      object MIBrowseBranch: TMenuItem
        Caption = 'Browse branch'
        Hint = 'Browse all descendants of the currently displayed element'
        ShortCut = 16416
        OnClick = MIBrowseBranchClick
      end
      object N59: TMenuItem
        Caption = '-'
      end
      object MIBackground: TMenuItem
        Caption = '&Background'
        OnClick = MIBackgroundClick
        object MIImportBackground: TMenuItem
          Caption = '&Import file'
          Hint = 'Import a picture to display in the background'
          OnClick = MIImportBackgroundClick
        end
        object MILinkBackground: TMenuItem
          Caption = '&Link from registry'
          Hint = 'Link a registry image to display in the background'
          OnClick = MILinkBackgroundClick
        end
        object MIBckgArrangement: TMenuItem
          Caption = '&Arrangement'
          OnClick = MIBckgArrangementClick
          object MIBckgTopLeft: TMenuItem
            Caption = 'Top-&left'
            Checked = True
            Hint = 'Place the background picture top-left'
            OnClick = MIBckgTopLeftClick
          end
          object MIBckgCenter: TMenuItem
            Caption = '&Center'
            Hint = 'Place the background picture in the center of the element window'
            OnClick = MIBckgCenterClick
          end
          object MIBckgTile: TMenuItem
            Caption = '&Tile'
            Hint = 'Tile the background picture'
            OnClick = MIBckgTileClick
          end
          object MIBckgStretch: TMenuItem
            Caption = '&Stretch'
            Hint = 'Stretch the background image to fit the entire element window'
            OnClick = MIBckgStretchClick
          end
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object MIBckgDelete: TMenuItem
          Caption = '&Delete'
          Hint = 'Delete the background image'
          OnClick = MIBckgDeleteClick
        end
      end
    end
    object MIElColor: TMenuItem
      Caption = 'Color'
      HelpContext = 7
      Hint = 'Change the color of topic or item background'
      ImageIndex = 17
      ImageName = 'icon_017'
      OnClick = MIElColorClick
    end
    object MIScaleable: TMenuItem
      Caption = 'Scaled'
      Hint = 'Make the components resize when the element window resizes'
      OnClick = MIScaleableClick
    end
    object MIAutoPlay: TMenuItem
      Caption = 'A&utoPlay'
      HelpContext = 7
      Hint = 
        'Turn on and off playing the first playable component on activati' +
        'ng the topic window'
      OnClick = MIAutoPlayClick
    end
    object MIElementType: TMenuItem
      Caption = 'Ty&pe'
      Hint = 'Select the type of the current element'
      OnClick = MIElementTypeClick
      object MIItem: TMenuItem
        Caption = '&Item'
        Checked = True
        Hint = 'Set element'#39's type: item (for active review)'
        ImageName = 'icon_034'
        OnClick = MIItemClick
      end
      object MITopic: TMenuItem
        Caption = '&Topic'
        Hint = 'Set element'#39's type: topic (for passive review)'
        ImageIndex = 86
        ImageName = 'icon_086'
        OnClick = MITopicClick
      end
      object MIConcept: TMenuItem
        Caption = '&Concept'
        Hint = 'Set element'#39's type: concept (for holding an idea)'
        ImageIndex = 209
        ImageName = 'icon_209'
        OnClick = MIConceptClick
      end
      object MITask: TMenuItem
        Caption = 'Tas&k'
        Hint = 'Set element'#39's type: task (for holding a job)'
        ImageIndex = 151
        ImageName = 'icon_151'
        OnClick = MITaskClick
      end
    end
    object N10: TMenuItem
      Caption = '-'
      HelpContext = 7
    end
    object MIComponent: TMenuItem
      Caption = 'Components'
      Hint = 'Operations on components'
      object MIMode: TMenuItem
        Caption = 'Mode'
        Hint = 'Change the element mode '
        ImageIndex = 143
        ImageName = 'icon_143'
        OnClick = MIModeClick
        object MIPresentationmode: TMenuItem
          Caption = 'Presentation'
          HelpContext = 7
          Hint = 'Set all components in presentation mode (Alt+click)'
          ImageIndex = 23
          ImageName = 'icon_023'
          ShortCut = 27
          OnClick = MIPresentationmodeClick
        end
        object MIEditingmode: TMenuItem
          Caption = 'Editing'
          HelpContext = 7
          Hint = 'Set all components in editing mode (same as Alt+click)'
          ImageIndex = 97
          ImageName = 'icon_097'
          OnClick = MIEditingmodeClick
        end
        object MIDraggingmode: TMenuItem
          Caption = 'Dragging'
          HelpContext = 7
          Hint = 'Set all components in dragging mode (same as double Alt+click)'
          ImageIndex = 101
          ImageName = 'icon_101'
          OnClick = MIDraggingmodeClick
        end
        object N70: TMenuItem
          Caption = '-'
        end
        object MISwitchComponentMode: TMenuItem
          Caption = 'Switch'
          Hint = 'Switch from presentation to editing or to dragging and resizing'
          ImageIndex = 143
          ImageName = 'icon_143'
          ShortCut = 16453
          OnClick = MISwitchModeClick
        end
      end
      object N42: TMenuItem
        Caption = '-'
      end
      object ComponentOrder1: TMenuItem
        Caption = 'Component &order'
        HelpContext = 7
        Hint = 'Edit the order of components in the knowledge element'
        ShortCut = 24655
        OnClick = ComponentOrder1Click
      end
      object MITileComponents: TMenuItem
        Caption = '&Tile components'
        Hint = 'Tile selected components'
        ImageIndex = 60
        ImageName = 'icon_060'
        ShortCut = 41044
        OnClick = MITileComponentsClick
      end
      object MIFitComponentSize: TMenuItem
        Caption = 'Fit sizes'
        Hint = 
          'Adjust the sizes of components to match the size of the current ' +
          'component'
        OnClick = MIFitComponentSizeClick
      end
      object MIFitAllPictures: TMenuItem
        Caption = 'Fit pictures'
        Hint = 
          'Adjust the size of all image components to match the size of the' +
          ' images'
        OnClick = MIFitAllPicturesClick
      end
      object MICompressImages: TMenuItem
        Caption = 'Compress images'
        Hint = 'Compress all images in the element'
        OnClick = MICompressImagesClick
      end
      object MIAlignment: TMenuItem
        Caption = '&Alignment and size'
        Hint = 
          'Align or size all selected components in editing or dragging mod' +
          'es'
        OnClick = MIAlignmentClick
      end
      object N52: TMenuItem
        Caption = '-'
      end
      object MITestRepetition: TMenuItem
        Caption = 'Test repetition c&ycle'
        Hint = 'Simulate all stages of a repetition'
        ShortCut = 41036
        OnClick = MITestRepetitionClick
      end
      object MIRepleatAutoPlay: TMenuItem
        Caption = 'Repeat Autoplay'
        Hint = 'Call autoplay again on the element'
        ShortCut = 16505
        OnClick = MIRepleatAutoPlayClick
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object Tab1: TMenuItem
        Caption = '&Next component'
        HelpContext = 7
        Hint = 'Select next component (if any)'
        ShortCut = 16468
        OnClick = Tab1Click
      end
      object ShiftTab1: TMenuItem
        Caption = '&Previous component'
        Hint = 'Select previous component (if any)'
        OnClick = ShiftTab1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MITranslate: TMenuItem
        Caption = 'Translate all'
        Hint = 'Translate all text components (if translation is available)'
        ShortCut = 32853
        OnClick = MITranslateClick
      end
      object MITransliterate: TMenuItem
        Caption = 'Transliterate all'
        Hint = 
          'Provide all text components with phonetic transcription (if avai' +
          'lable)'
        ShortCut = 32857
        OnClick = MITransliterateClick
      end
    end
    object MIDeleteComponents: TMenuItem
      Caption = 'Delete components'
      HelpContext = 7
      Hint = 'Delete all components of the element'
      OnClick = MIDeleteComponentsClick
    end
    object MIDeleteElement: TMenuItem
      Caption = 'Delete element'
      HelpContext = 7
      Hint = 'Delete the current element and all its children'
      ImageIndex = 16
      ImageName = 'icon_016'
      ShortCut = 24622
      OnClick = MIDeleteElementClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object MIGoTo: TMenuItem
      Caption = 'Go to'
      Hint = 'Go to another element in the collection'
      object MIGoToElement: TMenuItem
        Caption = 'Element number'
        Hint = 'Go to the element of a given number'
        ImageIndex = 70
        ImageName = 'icon_070'
        ShortCut = 16455
        OnClick = MIGoToElementClick
      end
      object Nexthierarchyelement1: TMenuItem
        Caption = 'Next element'
        Hint = 'Go to the next element in the knowledge tree'
        ImageIndex = 134
        ImageName = 'icon_134'
        ShortCut = 32802
        OnClick = Nexthierarchyelement1Click
      end
      object Previoushierarchyelement1: TMenuItem
        Caption = 'Previous element'
        Hint = 'Go to the previous element in the knowledge tree'
        ImageIndex = 133
        ImageName = 'icon_133'
        ShortCut = 32801
        OnClick = Previoushierarchyelement1Click
      end
      object FirstElement1: TMenuItem
        Caption = 'First element'
        HelpContext = 7
        Hint = 'Go to the master node of the collection'
        ImageIndex = 131
        ImageName = 'icon_131'
        ShortCut = 32804
        OnClick = FirstElement1Click
      end
      object LastElement1: TMenuItem
        Caption = 'Last element'
        HelpContext = 7
        Hint = 'Go to the last element'
        ImageIndex = 132
        ImageName = 'icon_132'
        ShortCut = 32803
        OnClick = LastElement1Click
      end
      object MIParentElement: TMenuItem
        Caption = 'Parent element'
        Hint = 'Go to the parent of the currently displayed element'
        ImageIndex = 135
        ImageName = 'icon_135'
        ShortCut = 16422
        OnClick = MIParentElementClick
      end
      object MINextSibling: TMenuItem
        Caption = 'Next sibling'
        Hint = 'Go to the next sibling of the current element'
        ShortCut = 40994
        OnClick = MINextSiblingClick
      end
      object MIPreviousSibling: TMenuItem
        Caption = 'Previous sibling'
        Hint = 'Go to the previous sibling of the current element'
        ShortCut = 40993
        OnClick = MIPreviousSiblingClick
      end
      object MIFirstChild: TMenuItem
        Caption = 'First child'
        Hint = 'Go to the first child of the current element (if available)'
        OnClick = MIFirstChildClick
      end
      object MILastChild: TMenuItem
        Caption = 'Last child'
        Hint = 'Go to the last child of the current element (if available)'
        ShortCut = 16424
        OnClick = MILastChildClick
      end
      object N45: TMenuItem
        Caption = '-'
      end
      object Back1: TMenuItem
        Caption = 'Back'
        Hint = 'Return to the recently visited element'
        ImageIndex = 136
        ImageName = 'icon_136'
        ShortCut = 32805
        OnClick = BackButtonClick
      end
      object Forward1: TMenuItem
        Caption = 'Forward'
        Hint = 
          'Move forwards on the history list (i.e. list of recently visited' +
          ' elements)'
        ImageIndex = 137
        ImageName = 'icon_137'
        ShortCut = 32807
        OnClick = ForwardButtonClick
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object MIPath: TMenuItem
        Caption = '&Ancestor'
        Hint = 'Open the pathlist to select an ancestor of the current element'
        ImageIndex = 176
        ImageName = 'icon_176'
        ShortCut = 24664
        OnClick = MIPathClick
      end
      object N40: TMenuItem
        Caption = '-'
      end
      object MINextElement: TMenuItem
        Caption = 'Inv: Next'
        HelpContext = 7
        Hint = 'Go to the next element in the knowledge tree'
        ShortCut = 34
        Visible = False
        OnClick = MINextElementClick
      end
      object MIPreviousElement: TMenuItem
        Caption = 'Inv: Previous '
        HelpContext = 7
        Hint = 'Go to the previous element in the knowledge tree'
        ShortCut = 33
        Visible = False
        OnClick = MIPreviousElementClick
      end
    end
    object N38: TMenuItem
      Caption = '-'
      Visible = False
    end
    object InvSelectAll1: TMenuItem
      Caption = 'Inv: Select All'
      ShortCut = 16449
      Visible = False
      OnClick = InvSelectAll1Click
    end
    object InvCancelGrade1: TMenuItem
      Caption = 'Inv: Cancel Grade'
      ShortCut = 32839
      Visible = False
      OnClick = InvCancelgrade1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 32
    Top = 331
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Microsoft YaHei'
    Font.Style = []
    Left = 112
    Top = 331
  end
  object AutoplayTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = AutoplayTimerTimer
    Left = 736
    Top = 312
  end
  object UntranslateTimer: TTimer
    Enabled = False
    Interval = 50
    OnTimer = UntranslateTimerTimer
    Left = 824
    Top = 304
  end
  object ComponentMenu: TPopupMenu
    Alignment = paCenter
    HelpContext = 8
    Images = AboutBox.VirtualImageList16
    OnPopup = ComponentMenuPopup
    Left = 216
    Top = 156
    object MIReading: TMenuItem
      Caption = '&Reading'
      Hint = 'Process text in a reading position'
      ImageIndex = 37
      ImageName = 'icon_037'
      object MIRememberExtract: TMenuItem
        Caption = 'Remember extract'
        Hint = 'Extract the selection and memorize it'
        ImageIndex = 144
        ImageName = 'icon_144'
        ShortCut = 32856
        OnClick = MIRememberExtractClick
      end
      object MIExplainExtract: TMenuItem
        Caption = 'E&xplain extract'
        Hint = 'Extract selection, memorize it, and append AI explanation'
        ShortCut = 41048
        OnClick = MIExplainExtractClick
      end
      object MIScheduleExtract: TMenuItem
        Caption = 'Schedule extract'
        Hint = 
          'Extract selection and schedule it for repetition on a selected d' +
          'ay'
        ImageIndex = 193
        ImageName = 'icon_193'
        OnClick = MIScheduleExtractClick
      end
      object MIQueueExtraction: TMenuItem
        Caption = 'Queue extract'
        Hint = 
          'Extract the selection and put it as a new element in the pending' +
          ' queue'
        OnClick = MIQueueExtractionClick
      end
      object MIExtractTask: TMenuItem
        Caption = 'Task extract'
        Hint = 'Use the selected text to create a new task on the reading list'
        ImageIndex = 151
        ImageName = 'icon_151'
        OnClick = MIExtractTaskClick
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object MIRememberCloze: TMenuItem
        Caption = 'Remember cloze'
        Hint = 'Use the selection to create a cloze deletion and memorize it'
        ImageIndex = 129
        ImageName = 'icon_129'
        ShortCut = 32858
        OnClick = MIRememberClozeClick
      end
      object MIScheduleCloze: TMenuItem
        Caption = 'Schedule cloze'
        Hint = 
          'Create cloze deletion and schedule it for repetition on a given ' +
          'day'
        ImageIndex = 192
        ImageName = 'icon_192'
        OnClick = MIScheduleClozeClick
      end
      object MIQueueCloze: TMenuItem
        Caption = 'Queue cloze'
        Hint = 'Use the selection to create a pending cloze deletion'
        OnClick = MIQueueClozeClick
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object MIAIExplain: TMenuItem
        Caption = 'AI Explain'
        Hint = 'Explain selection with AI'
        OnClick = MIAIExplainClick
      end
      object N50: TMenuItem
        Caption = '-'
      end
      object MIDeletePriorText: TMenuItem
        Caption = 'Delete before cursor'
        Hint = 'Delete texts before the cursor (e.g. after processing it)'
        ImageIndex = 188
        ImageName = 'icon_188'
        ShortCut = 32988
        OnClick = MIDeleteBeforeCursorClick
      end
      object MIDeleteAfterText: TMenuItem
        Caption = 'Delete after cursor'
        Hint = 'Delete texts after the cursor (e.g. footnotes, adverts, etc.)'
        ImageIndex = 197
        ImageName = 'icon_197'
        ShortCut = 32958
        OnClick = MIDeleteAfterTextClick
      end
      object MIDeleteProcessedTexts: TMenuItem
        Caption = 'Delete processed text'
        Hint = 'Delete all texts that have already been extracted or ignored'
        OnClick = MIDeleteProcessedTextsClick
      end
      object Split1: TMenuItem
        Caption = 'Split'
        Hint = 'Automatically split article into portions'
        ImageIndex = 185
        ImageName = 'icon_185'
        object MIInsertHorizontalLine: TMenuItem
          Caption = 'Insert splitline'
          Hint = 'Insert a horizontal line that can be used to split the article'
          ShortCut = 41032
          OnClick = MIInsertHorizontalLineClick
        end
        object MISplitArticle: TMenuItem
          Caption = 'Split article'
          Hint = 'Split the article in portions demarcated by splitmarks'
          ImageIndex = 185
          ImageName = 'icon_185'
          OnClick = MISplitArticleClick
        end
      end
      object MIDecompose: TMenuItem
        Caption = 'Decompose'
        Hint = 'Convert an enumeration into multiple elements'
        OnClick = MIDecomposeClick
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object Readpoints1: TMenuItem
        Caption = 'Read-points'
        Hint = 'Mark and unmark reading points in the text'
        object MISetReadPoint: TMenuItem
          Caption = '&Set read-point'
          Hint = 'Mark the last reading point in a reading list component'
          ImageIndex = 165
          ImageName = 'icon_165'
          ShortCut = 16502
          OnClick = MISetReadPointClick
        end
        object MIGoToReadPoint: TMenuItem
          Caption = '&Go to read-point'
          Hint = 'Go to the point in the text marked as read-point'
          ImageIndex = 164
          ImageName = 'icon_164'
          ShortCut = 32886
          OnClick = MIGoToReadPointClick
        end
        object MIClearReadPoint: TMenuItem
          Caption = '&Clear read-point'
          ImageIndex = 163
          ImageName = 'icon_163'
          ShortCut = 24694
          OnClick = MIClearReadPointClick
        end
      end
      object N51: TMenuItem
        Caption = '-'
      end
      object MIEMail: TMenuItem
        Caption = '&E-mail'
        Hint = 'Reply to the selected text via e-mail'
        ImageIndex = 130
        ImageName = 'icon_130'
        ShortCut = 24645
        OnClick = MIEMailClick
      end
      object MIEMailFAQ: TMenuItem
        Caption = '&E-mail FAQ'
        Hint = 'Respond to the selected fragment via an FAQ dialog'
        ImageIndex = 159
        ImageName = 'icon_159'
        OnClick = MIEMailFAQClick
      end
      object N58: TMenuItem
        Caption = '-'
      end
      object MIHighlight: TMenuItem
        Caption = '&Highlight'
        Hint = 'Highlight the selected text'
        ImageIndex = 160
        ImageName = 'icon_160'
        OnClick = MIHighlightClick
      end
      object MIIgnoreText: TMenuItem
        Caption = '&Ignore'
        Hint = 'Mark text as less important'
        ImageIndex = 162
        ImageName = 'icon_162'
        ShortCut = 24649
        OnClick = MIIgnoreTextClick
      end
    end
    object MITextsMenu: TMenuItem
      Caption = 'Te&xt'
      Hint = 'Options affecting texts, fonts, and the lexicon'
      OnClick = MITextsMenuClick
      object MIStyle: TMenuItem
        Caption = '&Style'
        Hint = 'Change the stylesheet associated with the component'
        object MISaveStyle: TMenuItem
          Caption = '&Save style'
          Hint = 
            'Save the style selected in an HTML component in the Style regist' +
            'ry'
          OnClick = MISaveStyleClick
        end
        object MIPickStyle: TMenuItem
          Caption = '&Apply style'
          Hint = 'Apply a selected style to a selection in text'
          OnClick = MIPickStyleClick
        end
        object MINewStyle: TMenuItem
          Caption = '&New style'
          Hint = 'Create a new stylesheet for the HTML component'
          OnClick = MINewStyleClick
        end
        object Linkstyle1: TMenuItem
          Caption = '&Link style'
          Hint = 'Use a stylesheet stored in the style registry'
          OnClick = MILinkStyleClick
        end
        object MIEditStyle: TMenuItem
          Caption = '&Edit style'
          Hint = 'Edit the stylesheet associated with the component'
          OnClick = MIEditStyleClick
        end
        object MIDefaultStyle: TMenuItem
          Caption = '&Default style'
          Hint = 'Restore the default stylesheet'
          OnClick = MIDefaultStyleClick
        end
        object N02: TMenuItem
          Caption = '-'
        end
        object MIEditStylesheet: TMenuItem
          Caption = 'Edit file'
          Hint = 'Edit stylesheet file in the default text editor'
          OnClick = MIEditStylesheetClick
        end
      end
      object Font1: TMenuItem
        Caption = '&Font'
        ImageIndex = 24
        ImageName = 'icon_024'
        object MINewFont: TMenuItem
          Caption = '&New font'
          HelpContext = 8
          Hint = 
            'Add a new font to the font registry and use it with the selected' +
            ' component'
          OnClick = MINewFontClick
        end
        object MILinkFont: TMenuItem
          Caption = '&Link font'
          HelpContext = 8
          Hint = 'Use a font stored in the font registry'
          ShortCut = 24646
          OnClick = MILinkFontClick
        end
        object MIEditFont: TMenuItem
          Caption = '&Edit font'
          Hint = 'Change the currently used font'
          ImageIndex = 24
          ImageName = 'icon_024'
          OnClick = MIEditFontClick
        end
        object MIDefaultFont: TMenuItem
          Caption = '&Default font'
          Hint = 'Detach the linked font and use the default font'
          OnClick = MIDefaultFontClick
        end
        object MIFontColor: TMenuItem
          Caption = '&Font color'
          Hint = 'Change the font color'
          ImageIndex = 25
          ImageName = 'icon_025'
          OnClick = MIFontColorClick
        end
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object MITextAlignment: TMenuItem
        Caption = '&Alignment'
        Hint = 'Align text left, right or center'
        ImageIndex = 77
        ImageName = 'icon_077'
        OnClick = MITextAlignmentClick
        object MIAlignLeft: TMenuItem
          Caption = '&Left'
          Hint = 'Align text left'
          ImageIndex = 77
          ImageName = 'icon_077'
          OnClick = MIAlignLeftClick
        end
        object MIAlignCenter: TMenuItem
          Caption = '&Center'
          Hint = 'Center all texts'
          ImageIndex = 78
          ImageName = 'icon_078'
          OnClick = MIAlignCenterClick
        end
        object MIAlignRight: TMenuItem
          Caption = '&Right'
          Hint = 'Align text right'
          ImageIndex = 76
          ImageName = 'icon_076'
          OnClick = MIAlignRightClick
        end
        object N14: TMenuItem
          Caption = '-'
        end
        object MIRTL: TMenuItem
          Caption = 'RTL text'
          Hint = 
            'Set the RTL direction of the text flow (e.g. as in Hebrew, Arabi' +
            'c, etc.)'
          OnClick = MIRTLClick
        end
        object MIDefaultRTL: TMenuItem
          Caption = 'RTL alignments'
          Hint = 
            'Use RTL flow for all right-alignment operations (e.g. as for Ara' +
            'bic, Hebrew, etc.)'
          OnClick = MIDefaultRTLClick
        end
      end
      object MITransparent: TMenuItem
        Caption = '&Transparent'
        Checked = True
        Hint = 'Keep the text background transparent'
        OnClick = MITransparentClick
      end
      object MICaseSensitive: TMenuItem
        Caption = 'Case sensitive'
        Hint = 'Differentiate between lower and uppercase in the Spell-Pad'
        OnClick = MICaseSensitiveClick
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object MIFullHTML: TMenuItem
        Caption = 'Full &HTML'
        Checked = True
        Hint = 
          'Full HTML adds outer HTML code for maximum HTML power at the cos' +
          't of collection size (Full HTML texts are also more prone to cau' +
          'sing errors in Internet Explorer)'
        OnClick = MIFullHTMLClick
      end
      object MIReadOnly: TMenuItem
        Caption = 'Read only'
        Hint = 'Do not allow of editing the text'
        OnClick = MIReadOnlyClick
      end
      object N8: TMenuItem
        Caption = '-'
        Hint = '-'
      end
      object MIConvert: TMenuItem
        Caption = 'Convert'
        Hint = 'Convert, filter or process texts'
        object MIFilter: TMenuItem
          Caption = 'Filter'
          Hint = 'Filter HTML or RTF codes for easier reading'
          ShortCut = 117
          OnClick = MIFilterClick
        end
        object MIPlainText: TMenuItem
          Caption = 'Plain text'
          Hint = 'Convert Rich Text to plain text'
          ShortCut = 24699
          OnClick = MIPlainTextClick
        end
        object MIParseHTML: TMenuItem
          Caption = 'Parse HTML'
          Hint = 'Convert HTML tags from the selected text into formatted text'
          ImageIndex = 149
          ImageName = 'icon_149'
          ShortCut = 24625
          OnClick = MIParseHTMLClick
        end
        object MICleanleadHTML: TMenuItem
          Caption = 'Clean lead HTML'
          Hint = 'Remove leading HTML formatting tags'
          OnClick = MICleanleadHTMLClick
        end
        object MIMarkdown: TMenuItem
          Caption = 'Markdown'
          Hint = 'Convert markdown language used by AI bots to HTML'
          OnClick = MIMarkdownClick
        end
        object N61: TMenuItem
          Caption = '-'
        end
        object MIPDF2HTML: TMenuItem
          Caption = 'PDF to HTML'
          Hint = 
            'Convert a PDF file to an HTML file for easier incremental readin' +
            'g'
          OnClick = MIPDF2HTMLClick
        end
        object N60: TMenuItem
          Caption = '-'
        end
        object MIUnitConversion: TMenuItem
          Caption = 'Unit conversion'
          Hint = 'Convert selected text from imperial to metric units'
          OnClick = MIUnitConversionClick
        end
        object N47: TMenuItem
          Caption = '-'
        end
        object MIDecodeUTF8: TMenuItem
          Caption = 'Decode UTF-8'
          Hint = 'Decode the selected text encoded as UTF-8'
          OnClick = MIDecodeUTF8Click
        end
        object MIEncodeUTF8: TMenuItem
          Caption = 'Encode UTF-8'
          Hint = 'Encode the text as UTF-8'
          OnClick = MIEncodeUTF8Click
        end
        object MIDecodeURL: TMenuItem
          Caption = 'Decode URL'
          Hint = 'Convert percent encoding (URL encoding) to Unicode'
          OnClick = MIDecodeURLClick
        end
        object MIUnicode: TMenuItem
          Caption = 'ANSI to Unicode'
          Hint = 
            'Convert an ANSI text to Unicode using a selected code page (acti' +
            've code page by default)'
          OnClick = MIUnicodeClick
        end
      end
      object MICase: TMenuItem
        Caption = '&Case'
        Hint = 'Change the case of the selected text'
        object MICaseLower: TMenuItem
          Caption = 'lowercase'
          Hint = 'Change the case of the selected text'
          ImageIndex = 201
          ImageName = 'icon_201'
          OnClick = MICaseLowerClick
        end
        object MICaseUpper: TMenuItem
          Caption = 'UPPERCASE'
          Hint = 'Change the case of the selected text'
          ImageIndex = 203
          ImageName = 'icon_203'
          OnClick = MICaseUpperClick
        end
        object MICaseCapitalized: TMenuItem
          Caption = 'Sentence case.'
          Hint = 'Change the case of the selected text'
          ImageIndex = 202
          ImageName = 'icon_202'
          OnClick = MICaseCapitalizedClick
        end
      end
      object N46: TMenuItem
        Caption = '-'
      end
      object MISpellCheck: TMenuItem
        Caption = 'Spell-check'
        Hint = 'Spell-check the text'
        OnClick = MISpellCheckClick
      end
    end
    object MIImageMenu: TMenuItem
      Caption = '&Image'
      Hint = 'Image options and properties'
      ImageIndex = 30
      ImageName = 'icon_030'
      OnClick = MIImageMenuClick
      object MIExtractImage: TMenuItem
        Caption = '&Extract'
        Hint = 'Duplicate the element, clone the image, and start trimming'
        ImageIndex = 144
        ImageName = 'icon_144'
        ShortCut = 32856
        OnClick = MIExtractImageClick
      end
      object MIOcclusion: TMenuItem
        Caption = 'Occlusion'
        Hint = 'Generate occlusion tests based on the image'
        OnClick = MIOcclusionClick
      end
      object N54: TMenuItem
        Caption = '-'
      end
      object MIZoom: TMenuItem
        Caption = '&Zoom and trim'
        Hint = 'Zoom, trim or select portions of the image'
        OnClick = MIZoomClick
      end
      object MIUnzoom: TMenuItem
        Caption = '&Unzoom'
        Hint = 'Display the entire image without zooming'
        OnClick = MIUnzoomClick
      end
      object MICrop: TMenuItem
        Caption = '&Crop'
        Hint = 'Cut and save the picture as currently zoomed/trimmed'
        OnClick = MICropClick
      end
      object MIClone: TMenuItem
        Caption = 'C&lone'
        Hint = 
          'Create a new copy of the same image in the registry (e.g. for fu' +
          'rther editing)'
        OnClick = MICloneClick
      end
      object MICompressImage: TMenuItem
        Caption = 'Com&press'
        Hint = 'Compress the picture file (use Scale to compress more)'
        OnClick = MICompressImageClick
      end
      object MIScaleImage: TMenuItem
        Caption = 'Scale'
        Hint = 'Reduce the size of large pictures'
        OnClick = MIScaleImageClick
      end
      object MIZoomOptions: TMenuItem
        Caption = 'Process'
        Hint = 'Choose one of the zooming/scaling options'
        ShortCut = 24695
        OnClick = MIZoomOptionsClick
      end
      object N56: TMenuItem
        Caption = '-'
      end
      object MIImageSize: TMenuItem
        Caption = '&Stretch'
        HelpContext = 8
        Hint = 'Turn on/off stretching images '
        OnClick = MIImageSizeClick
        object MIImageNormal: TMenuItem
          Caption = '&Normal'
          Hint = 'Display picture in its original size'
          ImageIndex = 205
          ImageName = 'icon_205'
          OnClick = MIImageNormalClick
        end
        object MIImageStretch: TMenuItem
          Caption = '&Proportional'
          Hint = 'Stretch the picture proportionally to the maximum size possible'
          ImageIndex = 206
          ImageName = 'icon_206'
          OnClick = MIImageStretchClick
        end
        object MIImageFill: TMenuItem
          Caption = '&Filled'
          Hint = 'Stretch the picture to fill the entire image component area'
          ImageIndex = 204
          ImageName = 'icon_204'
          OnClick = MIImageFillClick
        end
        object N39: TMenuItem
          Caption = '-'
        end
        object MISwitchImageSize: TMenuItem
          Caption = 'Switch'
          Hint = 'Switch the image stretching method'
          ShortCut = 24657
          OnClick = MISwitchImageSizeClick
        end
      end
      object MIFitPictureSize: TMenuItem
        Caption = 'Fit size'
        Hint = 'Change the size of components to match the size of the picture'
        OnClick = MIFitPictureSizeClick
      end
      object MIImageTransparent: TMenuItem
        Caption = '&Transparent'
        Hint = 'Keep image background transparent'
        OnClick = MITransparentClick
      end
      object Use1: TMenuItem
        Caption = '&Use as'
        Hint = 'Use the image in SuperMemo'
        object MIUseAsAboutBox: TMenuItem
          Caption = 'About Box picture'
          Hint = 'Use the image in the About Box picture'
          OnClick = MIUseAsAboutBoxClick
        end
        object MIUseOnDesktop: TMenuItem
          Caption = 'SuperMemo background'
          Hint = 'Use the image as the SuperMemo background'
          OnClick = MIUseOnDesktopClick
        end
        object WindowsDesktop1: TMenuItem
          Caption = 'Windows Desktop'
          OnClick = WindowsDesktop1Click
        end
      end
      object MISendPicture: TMenuItem
        Caption = 'Send'
        Hint = 'Send scaled picture via e-mail'
        ImageIndex = 130
        ImageName = 'icon_130'
        OnClick = MISendPictureClick
      end
      object Convert2: TMenuItem
        Caption = 'Convert'
        object MIConvertToJPG: TMenuItem
          Caption = 'Convert to &JPEG'
          Hint = 'Convert the picture to JPEG format'
          OnClick = MIConvertToJPGClick
        end
        object MIConvertToGIF: TMenuItem
          Caption = 'Convert to &GIF'
          Hint = 'Convert the picture to GIF format'
          OnClick = MIConvertToGIFClick
        end
        object MIConvertToPng: TMenuItem
          Caption = 'Convert to &PNG'
          Hint = 'Convert the picture to PNG format'
          OnClick = MIConvertToPngClick
        end
        object MIConverttoBMP: TMenuItem
          Caption = 'Convert to &BMP'
          Hint = 'Convert the picture to BMP format'
          OnClick = MIConverttoBMPClick
        end
      end
      object N57: TMenuItem
        Caption = '-'
      end
      object MIEditHitArea: TMenuItem
        Caption = '&Edit hit-area'
        HelpContext = 8
        Hint = 'Open Hit-Area Editor'
        OnClick = MIEditHitAreaClick
      end
    end
    object MISoundMenu: TMenuItem
      Caption = '&Sound and video'
      Hint = 'Sound and video options and properties'
      ImageIndex = 52
      ImageName = 'icon_052'
      OnClick = MISoundMenuClick
      object MIPanel: TMenuItem
        Caption = '&Panel'
        object MINoPanel: TMenuItem
          Caption = '&None'
          Hint = 'Do not show the control panel in sound components'
          OnClick = MINoPanelClick
        end
        object MISliderPanel: TMenuItem
          Caption = '&Slider'
          Hint = 'Show panel with a slider'
          OnClick = MISliderPanelClick
        end
        object MIRecorderPanel: TMenuItem
          Caption = '&Recorder'
          Hint = 'Show panel for recording the user (e.g. for pronunciation tests)'
          OnClick = MIRecorderPanelClick
        end
        object MIButtonsPanel: TMenuItem
          Caption = '&Extractor'
          Hint = 
            'Show a player button with extract functions for incremental soun' +
            'd and video processing'
          OnClick = MIButtonsPanelClick
        end
      end
      object MIResetExtract: TMenuItem
        Caption = 'Reset extract'
        Hint = 
          'Reset the starting and ending position of a sound or video extra' +
          'ct'
        OnClick = MIResetExtractClick
      end
      object MIContinuousPlay: TMenuItem
        Caption = 'Continuous'
        Hint = 'Play sound or video continuously'
        OnClick = MIContinuousPlayClick
      end
      object MIFullScreen: TMenuItem
        Caption = 'Full screen'
        Hint = 'Set video to play full screen'
        OnClick = MIFullScreenClick
      end
      object MIFrames: TMenuItem
        Caption = '&Frames'
        HelpContext = 8
        Hint = 
          'Specify the number of frames passed in a single step in slow-mot' +
          'ion video upon clicking Step button'
        Visible = False
        OnClick = MIFramesClick
      end
    end
    object MIScript: TMenuItem
      Caption = '&Script'
      HelpContext = 8
      Hint = 'Edit a script file with an interpreted program script'
      ImageIndex = 45
      ImageName = 'icon_045'
      ShortCut = 120
      OnClick = MIScriptClick
    end
    object MIShapeMenu: TMenuItem
      Caption = 'Shape'
      Hint = 'Shape properties'
      ImageIndex = 99
      ImageName = 'icon_099'
      object Solid2: TMenuItem
        Caption = '&Solid'
        OnClick = Solid2Click
      end
      object Cross1: TMenuItem
        Caption = '&Cross'
        OnClick = Cross1Click
      end
      object Horizontal1: TMenuItem
        Caption = '&Horizontal'
        OnClick = Horizontal1Click
      end
      object Vertical1: TMenuItem
        Caption = '&Vertical'
        OnClick = Vertical1Click
      end
      object Clear1: TMenuItem
        Caption = 'Clea&r'
        OnClick = Clear1Click
      end
    end
    object MICopyCutPaste: TMenuItem
      Caption = 'Copy/Cut/Paste'
      Hint = 'Clipboard operations'
      ImageIndex = 139
      ImageName = 'icon_139'
      OnClick = MICopyCutPasteClick
      object MIUndo: TMenuItem
        Caption = 'Undo'
        Hint = 'Undo the last text editing operation'
        ImageIndex = 194
        ImageName = 'icon_194'
        ShortCut = 16474
        OnClick = MIUndoClick
      end
      object N33: TMenuItem
        Caption = '-'
      end
      object MICut: TMenuItem
        Caption = 'Cut'
        Hint = 'Cut to clipboard'
        ImageIndex = 21
        ImageName = 'icon_021'
        ShortCut = 16472
        OnClick = MICutClick
      end
      object MICopy: TMenuItem
        Caption = 'Copy'
        Hint = 'Copy to clipboard'
        ImageIndex = 81
        ImageName = 'icon_081'
        ShortCut = 16451
        OnClick = MICopyClick
      end
      object MIComponentPaste: TMenuItem
        Caption = 'Paste '
        HelpContext = 8
        Hint = 'Paste data from the clipboard'
        ImageIndex = 139
        ImageName = 'icon_139'
        ShortCut = 16470
        OnClick = MIComponentPasteClick
      end
      object Pasteplain1: TMenuItem
        Caption = 'Paste plain'
        Hint = 'Paste formatted text as plain text (e.g. from an AI chatbot)'
        OnClick = Pasteplain1Click
      end
      object MIPasteHTML: TMenuItem
        Caption = 'Paste HTML'
        Hint = 'Paste HTML source text and format it'
        OnClick = MIPasteHTMLClick
      end
      object MIDeleteContent: TMenuItem
        Caption = 'Delete'
        Hint = 'Delete text or image'
        ImageIndex = 16
        ImageName = 'icon_016'
        ShortCut = 46
        OnClick = MIDeleteContentClick
      end
      object N34: TMenuItem
        Caption = '-'
      end
      object MISelectAll: TMenuItem
        Caption = 'Select all'
        Hint = 'Select the entire text'
        ShortCut = 16449
        OnClick = MISelectAllClick
      end
      object N53: TMenuItem
        Caption = '-'
      end
      object MICopyTranscription: TMenuItem
        Caption = 'Copy transcription'
        Enabled = False
        Hint = 'Copy phonetic transcription of the word to clipboard'
        OnClick = MICopyTranscriptionClick
      end
    end
    object MILinksMenu: TMenuItem
      Caption = 'Lin&ks'
      Hint = 'Links to other elements, components or files'
      ImageIndex = 222
      ImageName = 'icon_222'
      object MILinkMember: TMenuItem
        Caption = '&Registry member'
        HelpContext = 8
        Hint = 'Connect an object from the relevant registry'
        ImageIndex = 222
        ImageName = 'icon_222'
        ShortCut = 24651
        OnClick = MILinkMemberClick
      end
      object MIRenameMember: TMenuItem
        Caption = 'Rename'
        Hint = 'Rename the registry member associated with the component'
        ShortCut = 32850
        OnClick = MIRenameMemberClick
      end
      object MIHyperlink: TMenuItem
        Caption = '&Hyperlink'
        HelpContext = 8
        Hint = 'Specify the component'#39's hyperlink'
        ShortCut = 16459
        OnClick = MIHyperlinkClick
      end
      object MIHyperlinkNumber: TMenuItem
        Caption = 'Hyperlink &number'
        Hint = 'View or input the number of element to link from the component'
        OnClick = MILinkComponentToElementClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MILinkStyle: TMenuItem
        Caption = '&Style'
        Hint = 'Use a stylesheet stored in the style registry'
        OnClick = MILinkStyleClick
      end
      object MIFontLink: TMenuItem
        Caption = '&Font'
        Hint = 'Link a font from the font registry'
        ImageIndex = 24
        ImageName = 'icon_024'
        ShortCut = 24646
        OnClick = MILinkFontClick
      end
      object MIClickPlay: TMenuItem
        Caption = '&Play on click'
        HelpContext = 8
        Hint = 'Determine which component should be played on mouse click'
        OnClick = MIClickPlayClick
      end
      object MILinkExternal: TMenuItem
        Caption = 'External file'
        HelpContext = 8
        Hint = 'Connect an external file with a given component'
        OnClick = MILinkExternalClick
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object MIOpenHyperlinks: TMenuItem
        Caption = 'Open hyperlinks'
        Hint = 'Open all hyperlinks listed in an HTML text'
        OnClick = MIOpenHyperlinksClick
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object MIDeleteLink: TMenuItem
        Caption = '&Delete registry link'
        Hint = 'Delete registry link '
        OnClick = MIDeleteLinkClick
      end
      object MIDeleteHyperlink: TMenuItem
        Caption = 'Delete hyperlink'
        Hint = 'Delete the hyperlink associated with the component'
        OnClick = MIDeleteHyperlinkClick
      end
    end
    object MIDownloadFile: TMenuItem
      Caption = 'Download file'
      Hint = 'Download a file from the Internet'
      OnClick = MIDownloadFileClick
    end
    object MIWebSearch: TMenuItem
      Caption = '&Web search'
      Hint = 'Search the web for the selected text'
      ImageIndex = 187
      ImageName = 'icon_187'
      ShortCut = 16498
      OnClick = MIWebSearchClick
    end
    object MIOpenInNewWindow: TMenuItem
      Caption = 'Open in &new window'
      Hint = 
        'Open a new browser window with the page pointed to by the hyperl' +
        'ink'
      OnClick = MIOpenInNewWindowClick
    end
    object N55: TMenuItem
      Caption = '-'
    end
    object MIAnswer: TMenuItem
      Caption = '&Answer'
      HelpContext = 8
      Hint = 'Make the component invisible at question time'
      ImageIndex = 72
      ImageName = 'icon_072'
      OnClick = MIAnswerClick
    end
    object MITest: TMenuItem
      Caption = '&MCT'
      HelpContext = 8
      Hint = 
        'Determine if the component takes part in multiple choice test ev' +
        'aluation'
      OnClick = MITestClick
      object MITestNone: TMenuItem
        Caption = '&None'
        Checked = True
        Hint = 'Component does not take part in a multiple choice test'
        OnClick = MITestNoneClick
      end
      object MITestWrong: TMenuItem
        Caption = '&Wrong'
        Hint = 'Component makes up a wrong response in a multiple choice test'
        OnClick = MITestWrongClick
      end
      object MITestCorrect: TMenuItem
        Caption = '&Correct'
        Hint = 'Component makes up a correct response in a multiple choice test'
        OnClick = MITestCorrectClick
      end
    end
    object MICompColor: TMenuItem
      Caption = '&Color'
      HelpContext = 8
      Hint = 'Choose the color for a shape component'
      ImageIndex = 17
      ImageName = 'icon_017'
      OnClick = MICompColorClick
    end
    object MIDefaultColor: TMenuItem
      Caption = 'Default color'
      Hint = 'Determine if component color should match the background color'
      OnClick = MIDefaultColorClick
    end
    object MIDisplayAt: TMenuItem
      Caption = 'Display at'
      HelpContext = 8
      Hint = 'Determine when a component should be visible'
      ImageIndex = 23
      ImageName = 'icon_023'
      OnClick = MIDisplayAtClick
    end
    object MIPlayAt: TMenuItem
      Caption = 'Play at'
      Hint = 'Determine when a sound component should be played'
      ImageIndex = 52
      ImageName = 'icon_052'
      OnClick = MIPlayAtClick
    end
    object N32: TMenuItem
      Caption = '-'
    end
    object MIReference: TMenuItem
      Caption = 'Reference'
      Hint = 
        'Mark portions of text as reference items proliferating along ext' +
        'racts'
      ImageIndex = 128
      ImageName = 'icon_128'
      object MISelectReference: TMenuItem
        Caption = 'Select'
        Hint = 'Select an appropriate label from the list of choices'
        ShortCut = 32849
        OnClick = MISelectReferenceClick
      end
      object MITitleRef: TMenuItem
        Caption = 'Title'
        Hint = 'Mark a portion of text with reference labels'
        ShortCut = 32852
        OnClick = MITitleRefClick
      end
      object MIAuthor: TMenuItem
        Caption = 'Author'
        Hint = 'Mark a portion of text with reference labels'
        OnClick = MIAuthorClick
      end
      object MIDateRef: TMenuItem
        Caption = 'Date'
        Hint = 'Mark a portion of text with reference labels'
        OnClick = MIDateRefClick
      end
      object MISource: TMenuItem
        Caption = 'Source'
        Hint = 'Mark a portion of text with the source journal or webpage'
        OnClick = MISourceClick
      end
      object Email1: TMenuItem
        Caption = 'E-mail'
        Hint = 'Mark a portion of text with reference labels'
        OnClick = Email1Click
      end
      object Link1: TMenuItem
        Caption = 'Link'
        Hint = 'Mark a portion of text with reference labels'
        OnClick = Link1Click
      end
      object MIComment: TMenuItem
        Caption = 'Comment'
        Hint = 'Mark a portion of text with reference labels'
        OnClick = MICommentClick
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object MIEditReferences: TMenuItem
        Caption = 'Edit'
        Hint = 'Edit references'
        OnClick = MIEditReferenceClick
      end
      object N62: TMenuItem
        Caption = '-'
      end
      object MIDownload: TMenuItem
        Caption = 'Download'
        Hint = 'Download reference (e.g. for YouTube videos)'
        OnClick = MIDownloadClick
      end
    end
    object MISearchText: TMenuItem
      Caption = 'Find in article'
      Hint = 'Search the component'#39's text'
      ImageIndex = 106
      ImageName = 'icon_106'
      ShortCut = 114
      Visible = False
      OnClick = MISearchTextClick
    end
    object MIHTML: TMenuItem
      Caption = 'Insert HTML &link'
      Hint = 'Insert SuperMemo-specific links to HTML code'
      object MILinkToURL: TMenuItem
        Caption = 'Web address'
        Hint = 'Insert a WWW URL into HTML source text'
        ShortCut = 16459
        OnClick = MILinkToURLClick
      end
      object MIInsertElementLink: TMenuItem
        Caption = '&Element'
        Hint = 'Insert a link to another element into HTML source text'
        OnClick = MIInsertElementLinkClick
      end
      object MILinkToElementNo: TMenuItem
        Caption = 'E&lement number'
        Hint = 'Link to an element with a given number'
        OnClick = MILinkTextToElementNoClick
      end
      object MILinkToTextRegistry: TMenuItem
        Caption = 'Text registry'
        Hint = 'Insert a link to another registry text into HTML source text'
        OnClick = MILinkToTextRegistryClick
      end
      object LinkToHTMLFile: TMenuItem
        Caption = 'HTML file'
        Hint = 'Insert a link to another HTML file into HTML source text'
        OnClick = LinkToHTMLFileClick
      end
      object MILinkImage: TMenuItem
        Caption = 'Registry image'
        Hint = 'Insert an image from image registry'
        OnClick = MILinkImageClick
      end
      object MIInsertRegistryScriptLink: TMenuItem
        Caption = 'Registry script'
        Hint = 'Insert a link to a SuperMemo script'
        OnClick = MIInsertRegistryScriptLinkClick
      end
    end
    object MIDownloadImages: TMenuItem
      Caption = 'Download images'
      Hint = 
        'Download images used in an HTML document and place them in the i' +
        'mage registry'
      ShortCut = 16503
      OnClick = MIDownloadImagesClick
    end
    object MIInsertOLE: TMenuItem
      Caption = 'Insert OLE object'
      Hint = 
        'Open a dialog with the choice of OLE servers and inserts an OLE ' +
        'object'
      OnClick = MIInsertOLEClick
    end
    object MIOLEProperties: TMenuItem
      Caption = 'OLE properties'
      Hint = 'View and edit OLE object properties'
      OnClick = MIOLEPropertiesClick
    end
    object MIButtonText: TMenuItem
      Caption = '&Button text'
      Hint = 'Set text on the script or program button'
      object MIPlayButtonText: TMenuItem
        Caption = '&Play'
        HelpContext = 8
        Hint = 'Determine the text on the Play button'
        OnClick = MIPlayButtonTextClick
      end
      object MIStopButtonText: TMenuItem
        Caption = '&Stop'
        Hint = 'Determine the text on the Stop button'
        OnClick = MIStopButtonTextClick
      end
    end
    object MenuItem4: TMenuItem
      Caption = '-'
      HelpContext = 8
    end
    object MIDeleteComponent: TMenuItem
      Caption = '&Delete component'
      HelpContext = 8
      Hint = 'Delete the selected component'
      ImageIndex = 16
      ImageName = 'icon_016'
      ShortCut = 16430
      OnClick = MIDeleteComponentClick
    end
    object MIEditMenu: TMenuItem
      Caption = '&File'
      Hint = 'Paste, Copy, Edit and Delete options'
      ImageIndex = 51
      ImageName = 'icon_051'
      OnClick = MIEditMenuClick
      object MIViewFile: TMenuItem
        Caption = '&View file'
        Hint = 
          'View the file in the default viewer (e.g. web browser for HTML f' +
          'iles, MS Paint for Images, etc.)'
        ImageIndex = 23
        ImageName = 'icon_023'
        ShortCut = 120
        OnClick = MIViewFileClick
      end
      object MIEditFile: TMenuItem
        Caption = 'Edit file'
        Hint = 
          'Edit the file associated with the component (e.g. use Front Page' +
          ' for HTML files, MS Word for RTF files, etc.)'
        ImageIndex = 43
        ImageName = 'icon_043'
        ShortCut = 16504
        OnClick = MIEditFileClick
      end
      object MIViewInFolder: TMenuItem
        Caption = 'View in folder'
        Hint = 
          'Open the file in its location in the original folder (usu. subfo' +
          'lder of \elements)'
        OnClick = MIViewInFolderClick
      end
      object MIImport: TMenuItem
        Caption = '&Import file'
        HelpContext = 8
        Hint = 'Import a file (double-click in editing mode)'
        ImageIndex = 141
        ImageName = 'icon_141'
        ShortCut = 16465
        OnClick = MIImportClick
      end
      object MISaveFile: TMenuItem
        Caption = '&Save file'
        Hint = 'Save the associated file locally'
        ImageIndex = 51
        ImageName = 'icon_051'
        OnClick = MISaveFileClick
      end
      object MIDeleteFile: TMenuItem
        Caption = 'Delete file'
        Hint = 
          'Delete the first existing file from primary or secondary storage' +
          ' (acts also as edit undo)'
        ImageIndex = 16
        ImageName = 'icon_016'
        OnClick = MIDeleteFileClick
      end
      object MICopyPath: TMenuItem
        Caption = 'Copy path'
        Hint = 'Copy the file path to the clipboard'
        ImageIndex = 81
        ImageName = 'icon_081'
        OnClick = MICopyPathClick
      end
      object N44: TMenuItem
        Caption = '-'
      end
      object MIViewSource: TMenuItem
        Caption = 'View source'
        Hint = 'View or edit the source file in notepad'
        ShortCut = 24693
        OnClick = MIViewSourceClick
      end
      object MIPasteSpecial: TMenuItem
        Caption = 'Paste special'
        Hint = 'Paste special'
        Visible = False
      end
      object N35: TMenuItem
        Caption = '-'
      end
      object MISelectPreviousComponents: TMenuItem
        Caption = 'Select previous component'
        Hint = 'Select the previous component on the component list (if any)'
        OnClick = MISelectPreviousComponentsClick
      end
      object SelectNextComponent1: TMenuItem
        Caption = 'Select next component'
        Hint = 'Select the next component on the component list (if any)'
        ShortCut = 16468
        OnClick = SelectNextComponent1Click
      end
    end
    object MICompMode: TMenuItem
      Caption = '&Mode'
      ImageIndex = 143
      ImageName = 'icon_143'
      OnClick = MICompModeClick
      object MIDisplay: TMenuItem
        Caption = 'Presentation mode'
        Hint = 'Set the component in presentation mode'
        ImageIndex = 23
        ImageName = 'icon_023'
        ShortCut = 27
        OnClick = MIDisplayClick
      end
      object MIEdit: TMenuItem
        Caption = 'Editing mode'
        HelpContext = 8
        Hint = 'Edit the current component (same as Alt+click)'
        ImageIndex = 97
        ImageName = 'icon_097'
        OnClick = MIEditClick
      end
      object MIDrag: TMenuItem
        Caption = 'Dragging mode'
        HelpContext = 8
        Hint = 'Allow dragging the current component (same as double Alt+click)'
        ImageIndex = 101
        ImageName = 'icon_101'
        OnClick = MIDragClick
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object MISendToBack: TMenuItem
        Caption = '&Send to back'
        Hint = 
          'Hide the current component behind others (if any are overlapping' +
          ')'
        OnClick = MISendToBackClick
      end
    end
    object MIBrowserMenu: TMenuItem
      Caption = 'Browser menu'
      Hint = 'Switch from SuperMemo menu to the original web browser menu'
      Visible = False
      OnClick = MIBrowserMenuClick
    end
  end
  object ScriptTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = ScriptTimerTimer
    Left = 896
    Top = 304
  end
  object Searches: TPopupMenu
    Images = AboutBox.ImageList1
    OnPopup = SearchesPopup
    Left = 423
    Top = 158
    object MISearchSubstring: TMenuItem
      Caption = '&Find elements'
      Default = True
      Hint = 'Search for texts in the current collection (Ctrl+F)'
      ImageIndex = 5
      ShortCut = 16454
      OnClick = MISearchSubstringClick
    end
    object MISearchLexicon: TMenuItem
      Caption = 'Find &words'
      Hint = 'Search for a word in the lexicon'
      ImageIndex = 36
      OnClick = MISearchLexiconClick
    end
    object MISearchTextRegistry: TMenuItem
      Caption = 'Find &texts'
      Hint = 'Search for texts in the text registry'
      ShortCut = 16467
      OnClick = MISearchTextRegistryClick
    end
    object MITextRegistry: TMenuItem
      Caption = 'Open text registry'
      Hint = 'Review texts in the text registry'
      ImageIndex = 6
      OnClick = MITextRegistryClick
    end
    object MIFindInText: TMenuItem
      Caption = '&Find in article'
      Hint = 'Search for a text in the current article (F3)'
      ImageIndex = 106
      ShortCut = 114
      OnClick = MISearchTextClick
    end
    object N65: TMenuItem
      Caption = '-'
    end
    object MISearchAndReplace: TMenuItem
      Caption = 'Search and &replace'
      Hint = 
        'Search and replace a given text with another text in the entire ' +
        'collection'
      ImageIndex = 107
      ShortCut = 16466
      OnClick = MISearchAndReplaceClick
    end
    object N64: TMenuItem
      Caption = '-'
    end
    object MIAncestors: TMenuItem
      Caption = 'Ancestors'
      Hint = 'Show the window with ancestors of the element'
      ImageIndex = 176
      ShortCut = 24664
      OnClick = MIPathClick
    end
  end
  object Imports: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 800
    Top = 464
    object MIPasteArticle: TMenuItem
      Caption = 'Paste an article'
      Hint = 'Paste the article stored in the clipboard'
      ImageIndex = 82
      ShortCut = 16462
      OnClick = MIPasteArticleClick
    end
    object MIImportArticle: TMenuItem
      Caption = 'Import articles'
      Hint = 'Import articles from MS Edge'
      ShortCut = 8311
      OnClick = MIImportArticleClick
    end
    object InternetExplorer1: TMenuItem
      Caption = 'Internet Explorer'
      Hint = 'Import from Internet Explorer'
      object Alldocuments1: TMenuItem
        Caption = 'Import articles'
        Hint = 'Import all documents opened in Internet Explorer'
        ImageIndex = 141
        ShortCut = 24641
        OnClick = Alldocuments1Click
      end
      object Wikipediaarticles1: TMenuItem
        Caption = 'Import from Wikipedia'
        Hint = 'Import all Wikipedia articles opened in Internet Explorer'
        ImageIndex = 190
        ShortCut = 24663
        OnClick = Wikipediaarticles1Click
      end
      object YouTubevideos1: TMenuItem
        Caption = 'Import YouTube videos'
        Hint = 'Open all YouTube videos opened in Internet Explorer'
        ImageIndex = 191
        ShortCut = 24665
        OnClick = YouTubevideos1Click
      end
      object MIImportPictures: TMenuItem
        Caption = 'Import pictures'
        Hint = 'Import all pictures opened in Internet Explorer'
        ImageIndex = 195
        OnClick = MIImportPicturesClick
      end
    end
    object Importmail1: TMenuItem
      Caption = 'Import mail'
      Hint = 
        'Import mail from MS Outlook, Windows Mail, Windows Live Mail, et' +
        'c.'
      ImageIndex = 198
      ShortCut = 8307
      OnClick = Importmail1Click
    end
    object MIImportfile2: TMenuItem
      Caption = 'Import file'
      Hint = 'Import a file to the currently selected component'
      ShortCut = 16465
      OnClick = MIImportClick
    end
  end
  object Schedule: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 632
    Top = 456
    object MIOutstanding: TMenuItem
      Caption = 'Outstanding'
      Hint = 'Show the list of elements due for review in the browser'
      ImageIndex = 34
      OnClick = MIOutstandingClick
    end
    object MIWorkload: TMenuItem
      Caption = 'Calendar'
      Hint = 'Open the calendar of repetitions'
      ImageIndex = 7
      ShortCut = 16471
      OnClick = MIWorkloadClick
    end
    object N31: TMenuItem
      Caption = '-'
    end
    object MIExecuteRepetition: TMenuItem
      Caption = 'Execute repetition'
      Default = True
      Hint = 
        'Execute a repetition now and determine the new interval and the ' +
        'date of the next review'
      ImageIndex = 142
      ShortCut = 24658
      OnClick = MIForceRepetitionClick
    end
    object MIReschedule: TMenuItem
      Caption = 'Reschedule repetition'
      Hint = 'Schedule the next repetition on a given day'
      ShortCut = 16458
      OnClick = MIJumpIntervalClick
    end
    object MILaterToday2: TMenuItem
      Caption = 'Move to later today'
      Hint = 'Schedule the element for review later today'
      ShortCut = 24650
      OnClick = MILaterTodayClick
    end
    object N79: TMenuItem
      Caption = '-'
    end
    object MIDismiss2: TMenuItem
      Caption = '&Dismiss'
      Hint = 'Ignore the current element in the learning process'
      ImageIndex = 153
      ShortCut = 16452
      OnClick = MIDismissClick
    end
    object MIRemember2: TMenuItem
      Caption = '&Remember'
      Hint = 'Memorize the element and introduce it into the learning process'
      ImageIndex = 112
      ShortCut = 16461
      OnClick = MIRemember2Click
    end
    object MIForget: TMenuItem
      Caption = 'Forget'
      Hint = 'Remove the currently displayed element from the learning process'
      OnClick = MIForgetClick
    end
    object N73: TMenuItem
      Caption = '-'
    end
    object MIMercy: TMenuItem
      Caption = '&Mercy'
      Hint = 'Redistribute outstanding elements equally in a period of time'
      ShortCut = 41037
      OnClick = MIMercyClick
    end
  end
  object Del: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 360
    Top = 464
    object MIDone2: TMenuItem
      Caption = 'Done!'
      Default = True
      Hint = 
        'Delete the element from the learning process without affecting i' +
        'ts descendants'
      ImageIndex = 16
      ShortCut = 24589
      OnClick = DoneClick
    end
    object Dismiss1: TMenuItem
      Caption = 'Dismiss'
      Hint = 
        'Remove the element from the learning process (and retain it in t' +
        'he collection)'
      ShortCut = 16452
      OnClick = MIDismissClick
    end
    object N80: TMenuItem
      Caption = '-'
    end
    object Deleteselection1: TMenuItem
      Caption = 'Delete selection'
      Visible = False
    end
    object MIDeleteComponent2: TMenuItem
      Caption = 'Delete component'
      Hint = 'Delete the current component'
      ShortCut = 16430
      OnClick = MIDeleteComponentClick
    end
    object MIDeleteComponents2: TMenuItem
      Caption = 'Delete components'
      Hint = 'Delete selected components'
      OnClick = MIDeleteComponentsClick
    end
    object MIDeleteElement2: TMenuItem
      Caption = 'Delete element'
      Hint = 'Delete the current element and all its descendants'
      ShortCut = 24622
      OnClick = MIDeleteElementClick
    end
  end
  object Files: TPopupMenu
    Images = AboutBox.ImageList1
    OnPopup = FilesPopup
    Left = 776
    Top = 408
    object MIViewFile2: TMenuItem
      Caption = 'View file'
      Hint = 
        'View the file in the default viewer (e.g. web browser for HTML f' +
        'iles, MS Paint for Images, etc.)'
      ImageIndex = 23
      ShortCut = 120
      OnClick = MIViewFileClick
    end
    object MIViewSource2: TMenuItem
      Caption = 'View source'
      Hint = 'View or edit the source file (e.g. HTML source in a notepad)'
      ShortCut = 24693
      OnClick = MIViewSourceClick
    end
    object Editfile1: TMenuItem
      Caption = 'Edit file'
      Hint = 
        'Open the file from the current component in the default editor (' +
        'defined in Windows)'
      ImageIndex = 43
      ShortCut = 16504
      OnClick = MIEditFileClick
    end
    object MIImportFile: TMenuItem
      Caption = 'Import file'
      Hint = 'Import a file to the currently selected component'
      ImageIndex = 141
      ShortCut = 16465
      OnClick = MIImportClick
    end
    object MISaveFile2: TMenuItem
      Caption = 'Save file'
      Hint = 'Export the file associated with the component'
      ImageIndex = 51
      OnClick = MISaveFileClick
    end
    object PlayerSeparator: TMenuItem
      Caption = '-'
      Visible = False
    end
    object MIYTPlayerVersion: TMenuItem
      Caption = 'Player version'
      Hint = 
        'Change the version of the YouTube player to play that particular' +
        ' video'
      Visible = False
      OnClick = MIYTPlayerVersionClick
    end
  end
  object Mail: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 912
    Top = 240
    object MISendElement2: TMenuItem
      Caption = 'Send element'
      Default = True
      Hint = 'Send all components of the element via mail'
      ImageIndex = 130
      ShortCut = 24645
      OnClick = MailBtnClick
    end
    object Sendpicture1: TMenuItem
      Caption = 'Send picture'
      Hint = 'Send picture via mail'
      OnClick = MISendPictureClick
    end
    object MIMailTexts2: TMenuItem
      Caption = 'Send texts (unformatted)'
      Hint = 'Send element texts via e-mail'
      OnClick = MIMailTextsClick
    end
    object MISendHTML2: TMenuItem
      Caption = 'Send texts (HTML)'
      Hint = 'Send element as HTML'
      OnClick = MISendHTMLClick
    end
    object MIReplyToSelection: TMenuItem
      Caption = 'Reply to selection'
      Hint = 'Reply to the selected text via e-mail'
      OnClick = MIReplyToSelectionClick
    end
    object MIEMailFAQ2: TMenuItem
      Caption = 'FAQ'
      Hint = 'Respond to the selected fragment via an FAQ dialog'
      ImageIndex = 159
      OnClick = MIEMailFAQClick
    end
  end
  object Text: TPopupMenu
    Images = AboutBox.ImageList1
    OnPopup = TextPopup
    Left = 752
    Top = 464
    object MIParseHTML2: TMenuItem
      Caption = 'Parse HTML'
      Default = True
      Hint = 'Convert HTML tags from the selected text into formatted text'
      ImageIndex = 149
      ShortCut = 24625
      OnClick = MIParseHTMLClick
    end
    object MICleanleadHTML2: TMenuItem
      Caption = 'Clean lead HTML'
      Hint = 'Remove leading HTML formatting tags'
      OnClick = MICleanleadHTMLClick
    end
    object MIPlainText2: TMenuItem
      Caption = 'Convert to plain text'
      Hint = 'Convert HTML or RTF to plain text, or EML to HTML'
      ShortCut = 24699
      OnClick = MIPlainTextClick
    end
    object MIFilterHTML2: TMenuItem
      Caption = 'Filter HTML code'
      Hint = 'Filter HTML or RTF codes for easier reading'
      ImageIndex = 182
      ShortCut = 117
      OnClick = MIFilterClick
    end
    object N78: TMenuItem
      Caption = '-'
    end
    object MIEditStylesheet2: TMenuItem
      Caption = 'Edit stylesheet'
      Hint = 'Edit the stylesheet associated with the current HTML component'
      OnClick = MIEditStylesheetClick
    end
    object N66: TMenuItem
      Caption = '-'
    end
    object MICaseUpper2: TMenuItem
      Caption = 'UPPERCASE'
      Hint = 'Change the case of the selected text to upper'
      ImageIndex = 203
      OnClick = MICaseUpperClick
    end
    object MICaseLower2: TMenuItem
      Caption = 'lowercase'
      Hint = 'Change the case of the selected text to lower'
      ImageIndex = 201
      OnClick = MICaseLowerClick
    end
    object MICaseCapitalized2: TMenuItem
      Caption = 'Sentence case'
      Hint = 'Change the case of the selected text to capitalized'
      ImageIndex = 202
      OnClick = MICaseCapitalizedClick
    end
    object N72: TMenuItem
      Caption = '-'
    end
    object MIUnitConversion2: TMenuItem
      Caption = 'Convert to metric units'
      Hint = 'Convert selected text from imperial to metric units'
      OnClick = MIUnitConversionClick
    end
    object N67: TMenuItem
      Caption = '-'
    end
    object MITranscription: TMenuItem
      Caption = 'Phonetic transcription'
      Hint = 'Replace texts with their phonetic transcription'
      ImageIndex = 48
      ShortCut = 32857
      OnClick = MITransliterateClick
    end
    object MITranslateTexts: TMenuItem
      Caption = 'Translate texts'
      Hint = 'Translate texts when mouse is moved over the component'
      ImageIndex = 121
      ShortCut = 32853
      OnClick = MITranslateClick
    end
  end
  object Dup: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 288
    Top = 456
    object MIDuplicateElement: TMenuItem
      Caption = 'Duplicate element'
      Hint = 'Duplicate the current element (and make it a child)'
      ImageIndex = 148
      ShortCut = 32836
      OnClick = MIDuplicateClick
    end
    object MITransferElement2: TMenuItem
      Caption = 'Transfer element'
      Hint = 'Add a copy of the current element to another collection'
      ShortCut = 24660
      OnClick = MITransferElementClick
    end
    object MIMoveElement2: TMenuItem
      Caption = 'Move element'
      Hint = 'Move the element to a selected branch in Contents'
      ShortCut = 24662
      OnClick = MIMoveElementClick
    end
    object Copyandmove1: TMenuItem
      Caption = 'Copy and move'
      Hint = 
        'Create a duplicate of the element and move it to a selected bran' +
        'ch in Contents'
      Visible = False
    end
    object MISwapQA: TMenuItem
      Caption = 'Swap Q&A'
      Hint = 'Swap the question with the answer'
      ShortCut = 24659
      OnClick = MISwapClick
    end
    object N75: TMenuItem
      Caption = '-'
    end
    object MICopyElementSourceToClipboard: TMenuItem
      Caption = 'Copy element'
      Hint = 'Copy the current element to the clipboard'
      OnClick = MICopyElementSourceClick
    end
    object MIPasteElement2: TMenuItem
      Caption = 'Paste element'
      Hint = 'Create a new element pasted from the clipboard'
      OnClick = MIPasteElementClick
    end
  end
  object Switch: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 688
    Top = 448
    object MISwitchMode2: TMenuItem
      Caption = 'Switch mode'
      Hint = 'Switch from presentation to editing or to drag-and-size mode'
      ImageIndex = 143
      ShortCut = 16453
      OnClick = MISwitchModeClick
    end
    object N76: TMenuItem
      Caption = '-'
    end
    object MIPresentationmode3: TMenuItem
      Caption = 'Presentation'
      Hint = 'Set all components in presentation mode (Alt+click)'
      ImageIndex = 23
      ShortCut = 27
      OnClick = MIPresentationmodeClick
    end
    object MIEditingmode3: TMenuItem
      Caption = 'Editing'
      Hint = 'Set all components in editing mode (Alt+click)'
      ImageIndex = 97
      OnClick = MIEditingmodeClick
    end
    object MIDraggingmode3: TMenuItem
      Caption = 'Dragging'
      Hint = 'Set all components in dragging mode (same as double Alt+click)'
      ImageIndex = 101
      OnClick = MIDraggingmodeClick
    end
    object N77: TMenuItem
      Caption = '-'
    end
    object MITile: TMenuItem
      Caption = 'Tile components'
      Hint = 'Tile edited/dragged components into equal rows and columns'
      ImageIndex = 60
      ShortCut = 41044
      OnClick = MITileComponentsClick
    end
    object MITitle2: TMenuItem
      Caption = 'Title'
      Hint = 'Name the element'#39's title'
      ShortCut = 32852
      OnClick = MITitleClick
    end
    object N74: TMenuItem
      Caption = '-'
    end
    object MIEditReference2: TMenuItem
      Caption = 'Edit reference'
      Hint = 'Modify element'#39's references'
      OnClick = MIEditReferenceClick
    end
    object MISelectReference2: TMenuItem
      Caption = 'Select reference'
      Hint = 'Select an appropriate label from the list of choices'
      ShortCut = 32849
      OnClick = MISelectReferenceClick
    end
  end
  object Tools: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 756
    Top = 240
    object MICommander: TMenuItem
      Caption = 'Commander'
      Default = True
      Hint = 'Choose a SuperMemo command to execute'
      ImageIndex = 28
      ShortCut = 16397
      OnClick = MICommanderClick
    end
    object MIOptions: TMenuItem
      Caption = 'Options'
      Hint = 'Display the dialog with main the options of SuperMemo'
      ImageIndex = 156
      OnClick = MIOptionsClick
    end
    object MIElementMenu: TMenuItem
      Caption = 'Element menu'
      Hint = 'Display the menu of options for the current element'
      ImageIndex = 4
      ShortCut = 32889
      OnClick = MIElementMenuClick
    end
    object MIComponentMenu: TMenuItem
      Caption = 'Component menu'
      Hint = 'Display the menu of options for the current component'
      ImageIndex = 47
      ShortCut = 32891
      OnClick = MIComponentMenuClick
    end
  end
  object Templates: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 856
    Top = 416
    object MIApplyTemplate2: TMenuItem
      Caption = 'Apply template'
      Hint = 'Change the look of an element by using a template'
      ImageIndex = 166
      ShortCut = 24653
      OnClick = MIApplyTemplateClick
    end
    object MISaveTemplate: TMenuItem
      Caption = 'Save template'
      Hint = 'Save current element as a template in the template registry'
      ImageIndex = 169
      OnClick = MISaveAsTemplateClick
    end
    object MISaveTemplateAsDefault: TMenuItem
      Caption = 'Save as default'
      Hint = 
        'Save the current element as the default template for the current' +
        ' category'
      ImageIndex = 170
      OnClick = MISaveAsDefaultClick
    end
    object MIImposeTemplate2: TMenuItem
      Caption = 'Impose template'
      Hint = 'Permanently change the look of the element to that of a template'
      ImageIndex = 168
      ShortCut = 24689
      OnClick = MIImposeTemplateClick
    end
    object MIDetachTemplate2: TMenuItem
      Caption = 'Detach template'
      Hint = 
        'Restore the original looks of the element by disconnecting the t' +
        'emplate'
      ImageIndex = 167
      OnClick = MIDetachTemplateClick
    end
  end
  object Read: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 136
    Top = 456
    object Extract1: TMenuItem
      Caption = 'Extract'
      Hint = 'Extract the selected text as a topic'
      ImageIndex = 144
      ShortCut = 32856
      OnClick = MIRememberExtractClick
    end
    object Cloze1: TMenuItem
      Caption = 'Cloze'
      Hint = 'Create cloze on the basis of the selected keyword'
      ImageIndex = 129
      ShortCut = 32858
      OnClick = MIRememberClozeClick
    end
    object N49: TMenuItem
      Caption = '-'
    end
    object Split2: TMenuItem
      Caption = 'Split'
      Hint = 'Split article'
      ImageIndex = 185
      OnClick = MISplitArticleClick
    end
    object N63: TMenuItem
      Caption = '-'
    end
    object MIHighlight2: TMenuItem
      Caption = 'Highlight'
      Hint = 'Highlight the selected text'
      ImageIndex = 160
      OnClick = MIHighlightClick
    end
    object MIIgnore: TMenuItem
      Caption = 'Ignore'
      Hint = 'Ignore the selected text'
      ImageIndex = 162
      ShortCut = 24649
      OnClick = MIIgnoreTextClick
    end
    object N43: TMenuItem
      Caption = '-'
    end
    object MIDeleteBeforeCursor2: TMenuItem
      Caption = 'Delete before cursor'
      Hint = 'Delete texts before the cursor'
      ImageIndex = 188
      ShortCut = 32988
      OnClick = MIDeleteBeforeCursorClick
    end
    object MIDeleteAfterCursor2: TMenuItem
      Caption = 'Delete after cursor'
      Hint = 'Delete texts after the cursor'
      ImageIndex = 197
      ShortCut = 32958
      OnClick = MIDeleteAfterTextClick
    end
  end
  object Layouts: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 1068
    Top = 264
    object MILayoutManager: TMenuItem
      Caption = 'Layout manager'
      Default = True
      Hint = 'Open the layout manager'
      OnClick = MILayoutManagerClick
    end
    object MIApplydefaultlayout: TMenuItem
      Caption = 'Apply default layout'
      Hint = 'Apply the default layout of windows'
      ImageIndex = 66
      ShortCut = 16500
      OnClick = MIApplydefaultlayoutClick
    end
    object MISaveLayout: TMenuItem
      Caption = 'Save layout'
      Hint = 'Save the current window layout for later use'
      OnClick = MISaveLayoutClick
    end
    object MISaveDefaultLayout: TMenuItem
      Caption = 'Save default layout'
      Hint = 'Save the current layout of windows as your default layout'
      ImageIndex = 65
      ShortCut = 24692
      OnClick = MISaveDefaultLayoutClick
    end
  end
  object CopyMenu: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 328
    Top = 408
    object MICut2: TMenuItem
      Caption = 'Cut'
      Hint = 'Cut to clipboard'
      ImageIndex = 21
      ShortCut = 16472
      OnClick = MICutClick
    end
    object MICopy2: TMenuItem
      Caption = 'Copy'
      Hint = 'Copy the picture, text, element, etc. to the clipboard'
      ImageIndex = 81
      ShortCut = 16451
      OnClick = MICopyClick
    end
    object MIPaste: TMenuItem
      Caption = 'Paste'
      Hint = 'Paste from the clipboard (text, image, etc.)'
      ImageIndex = 139
      ShortCut = 16470
      OnClick = MIComponentPasteClick
    end
    object MIDelete: TMenuItem
      Caption = 'Delete'
      Hint = 'Delete the selected text or the current image'
      ImageIndex = 16
      ShortCut = 46
      OnClick = MIDeleteContentClick
    end
    object N68: TMenuItem
      Caption = '-'
    end
    object MISelectAll2: TMenuItem
      Caption = 'Select all'
      Hint = 'Select all text in the current text component'
      ShortCut = 16449
      OnClick = MISelectAllClick
    end
  end
  object AddComponents: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 184
    Top = 400
    object MIAddHTMLComponent: TMenuItem
      Caption = 'Add HTML text'
      Hint = 'Add a rich text component (HTML format)'
      ImageIndex = 29
      OnClick = MIAddHTMLComponentClick
    end
    object MIAddTextComponent: TMenuItem
      Caption = 'Add plain text'
      Hint = 'Add a plain text component'
      ImageIndex = 6
      OnClick = MIAddTextComponentClick
    end
    object MIAddImage: TMenuItem
      Caption = 'Add image'
      Hint = 'Add an image component for importing images'
      ImageIndex = 30
      OnClick = MIAddImageClick
    end
    object MIAddSound: TMenuItem
      Caption = 'Add sound'
      Hint = 'Add a sound component for playing sounds'
      ImageIndex = 52
      OnClick = MIAddSoundClick
    end
    object MIAddVideo: TMenuItem
      Caption = 'Add video'
      Hint = 
        'Add a video component for playing movies (e.g. in incremental vi' +
        'deo)'
      ImageIndex = 63
      OnClick = MIAddVideoClick
    end
    object N69: TMenuItem
      Caption = '-'
    end
    object MIPresentationMode2: TMenuItem
      Caption = 'Presentation mode'
      Hint = 'Display components in the presentation mode'
      ImageIndex = 23
      ShortCut = 27
      OnClick = MIDisplayClick
    end
    object MIEditingMode2: TMenuItem
      Caption = 'Editing mode'
      Hint = 'Start editing components'
      ImageIndex = 97
      OnClick = MIEditingmodeClick
    end
    object MIDraggingMode2: TMenuItem
      Caption = 'Dragging mode'
      Hint = 'Start dragging or sizing components'
      ImageIndex = 101
      OnClick = MIDraggingmodeClick
    end
    object MISwitchMode: TMenuItem
      Caption = 'Switch mode'
      Hint = 'Switch from presentation to editing to drag-and-size mode'
      ImageIndex = 143
      ShortCut = 16453
      OnClick = MISwitchModeClick
    end
  end
  object AlarmMenu: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 192
    Top = 456
    object MISetAlarm: TMenuItem
      Caption = 'Set alarm'
      Hint = 'Set the alarm to be raised after a selected period of time'
      ImageIndex = 174
      OnClick = MISetAlarmClick
    end
    object Cancelalarm1: TMenuItem
      Caption = 'Cancel alarm'
      Default = True
      Hint = 'Cancel the alarm'
      ImageIndex = 22
      OnClick = Cancelalarm1Click
    end
    object Choosemusic1: TMenuItem
      Caption = 'Choose music'
      Hint = 'Choose alarm music'
      ImageIndex = 52
      OnClick = Choosemusic1Click
    end
  end
  object PriorityMenu: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 504
    Top = 456
    object MISetPriority: TMenuItem
      Caption = 'Priority'
      Hint = 'Set element'#39's priority'
      ImageIndex = 138
      ShortCut = 32848
      OnClick = MIModifyPriorityClick
    end
    object MISetFI: TMenuItem
      Caption = 'Forgetting index'
      Hint = 'Set element'#39's forgetting index'
      OnClick = MISetFIClick
    end
    object MIElementParameters: TMenuItem
      Caption = 'Parameters'
      Default = True
      Hint = 'View or change element parameters'
      ShortCut = 24656
      OnClick = MIEditParamtersClick
    end
  end
  object Concepts: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 1188
    Top = 264
    object MILinkConcept1: TMenuItem
      Caption = '&Link concept'
      Hint = 'Attach an existing concept to the current element'
      ImageIndex = 212
      OnClick = MILinkConceptClick
    end
    object MIListLinks1: TMenuItem
      Caption = 'List links'
      Hint = 'List links associated with the element'
      OnClick = MIListLinksClick
    end
    object Unlinkconcept1: TMenuItem
      Caption = '&Unlink concept'
      OnClick = Unlinkconcept1Click
    end
    object MIUnlinkElement1: TMenuItem
      Caption = 'Unlink element'
      OnClick = MIUnlinkElement1Click
    end
    object N84: TMenuItem
      Caption = '-'
    end
    object MICreateConcept1: TMenuItem
      Caption = 'Create concept'
      Hint = 'Convert the current element into a new concept'
      OnClick = MICreateConceptClick
    end
    object N21: TMenuItem
      Caption = '-'
      ShortCut = 189
    end
    object MIConceptMap1: TMenuItem
      Caption = 'Map'
      Hint = 
        'Display the concept map or the content map for the current eleme' +
        'nt'
      OnClick = MIConceptMapClick
    end
  end
  object ImageList1: TImageList
    Height = 64
    Masked = False
    Width = 64
    Left = 60
    Top = 700
    Bitmap = {
      494C01010A00B801940520002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000008000000060000000010020000000000000C0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000C0C0C002528280022252800282A
      2A00111111000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000381F
      C6003A20C8003D23CB004026CD004127CE004127CE003F25CD003D23CB003A20
      C7003820C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000383D3F00939EA0009DA7A9007F898B0099A4
      A70099A4A700697173001E222200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000371DC1003B21C7004127CF00472D
      D5004A30D8004B31D9004B31D9004B31D9004B31D9004B31D9004B31D9004A30
      D800472DD5004127CF003B21C700371DBE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003F414400B0BBBD00CBD4D500BCC2C400A2AEB000C7D0
      D100C1CACB00AFBABD00A3B0B3004D5455000404040000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000391FC7004329D0004A30D8004B31D9004B31
      D9004B31D9004B31D9004B31D9004B31D9004B31D9004B31D9004B31D9004B31
      D9004B31D9004B31D9004A30D8004228D000391FC70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7E7E00CCD8DA00DDE6E800D0DADB00D2DBDD00D7E1
      E200B9C7C900A1B1B300AAB8BA00ABB9BC002D35360000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003D24CB004930D7004B32DA004B32DA004B32DA004B32
      DA004B32DA004B32DA004B32DA004B32DA004B32DA004B32DA004B32DA004B32
      DA004B32DA004B32DA004B32DA004B32DA004830D7003D23CA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C2D5D500DEEDEE00DDEBEC00D2E0E200CCDADC00D1DE
      E000B9C9CB0096A6A90082939600788B8E003B4F510000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003E27CD004B38DD004C39DD004C39DD004C39DD004C39DD004233
      AE003D3097004635C3004B38DC004C39DD004C39DD004B38DC004635C3003D30
      97004233AF004C39DD004C39DD004C39DD004C39DD004B37DC003E26CC000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008D8D8D00D9E8E900D6E4E600C3D4D600B8C9CC00B9C8
      CA00B4C4C60099A9AB00859698007B8E900065787A0003050500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003D25CC004C3DE0004D3FE1004D3FE1004D3FE1004D3FE1004D3FE1002F2B
      5A00242424002424240024242700272633002726330024242700242424002424
      24002F2B5B004D3FE1004D3FE1004D3FE1004D3FE1004D3FE1004C3DE0003D25
      CB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000073858500D0DFE1009DB2B4005270750053727700889D
      9F00A7B7B9009BABAD0089999C007F919300798C8F0062747500455354003743
      44001217170001010100182325000E1414000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A3EDF004E44E4004E44E4004E44E4004E44E4004E44E4004E44E400463E
      C300282739002424240024242400242424002424240024242400242424002827
      3900473EC3004E44E4004E44E4004E44E4004E44E4004E44E4004E44E4004A3D
      DF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000096AAAB00C4D4D6005A7376000B272C000F2C3100536B
      6E0090A0A2008A999C0089999B008797990083949600849597008A9C9E00879A
      9C00788A8C0047595B003854560049636600131B1B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004332
      D5004F49E7004F49E7004F49E7004F49E7004F49E7004F49E7004F49E7004F49
      E7004C46DB003A3788002C2B490025252A0025252B002C2B49003A3788004C46
      DB004F49E7004F49E7004F49E7004F49E7004F49E7004F49E7004F49E7004F49
      E7004231D4000000000000000000000000000000000000000000000000000000
      00000000000062707000A1B4B600B0C1C300405A5E0009262A000B2A2E005B72
      75009BABAD0092A2A40092A2A4009CADB0009CACAE008F9FA00091A1A3009CAC
      AE008B9B9D00708284005A707200556C6F0053696B0009090900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004D49
      E600504DE900504DE900504DE900504DE900504DE900504DE900504DE900504D
      E900504DE900504DE900504DE900504DE900504DE900504DE900504DE900504D
      E900504DE900504DE900504DE900504DE900504DE900504DE900504DE900504D
      E9004D48E5000000000000000000000000000000000000000000000000000000
      00007B8C8D00A4B8BA00A3B5B700B7C7C9004660630016353A0029474B008A9B
      9D00B0BFC100B0C1C3009BB0B40093ABAE0093AAAC0088989A007D8C8E006779
      7C0042595C003B535600485F62005C7173006177790037464700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005050
      EB005050EB005050EB005050EB005050EB005050EB005050EB004F4FE8004141
      AB004343B1004F50EA005050EB005050EB005050EB005050EB004F50EA004343
      B2004141AB004F4FE8005050EB005050EB005050EB005050EB005050EB005050
      EB005050EB000000000000000000000000000000000000000000000000000000
      0000C4D7D900B9CCCF00BED0D200CCDADD00A5B6B90086989B00B5C4C700A1B0
      B300A7B8BA00859B9E00688084003F5C60004E696D00758A8D00748385004558
      5A0031474A00374E51003E535700576B6E00607375005F7677000C0C0C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000463CDB005053
      EC005053EC005053EC005053EC005053EC005053EC005053EC00353673002424
      2400242424003A3C8A005053EC005053EC005053EC005053EC003A3C8A002424
      240024242400353673005053EC005053EC005053EC005053EC005053EC005053
      EC005053EC00463CDB0000000000000000000000000000000000000000000000
      0000B8CACC009BB5B80094AEB1009DB4B700D1DFE100DBE7E800CBD9DB00A6B6
      B80092A5A7005971740025404400132D31002C484C0069808400748385004659
      5B003A4E5100475B5E004B5E61005466680061727500697D7F002E3A3A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004B48E4005156
      EE005156EE005156EE005156EE005156EE005156EE005156EE00272834002424
      2400242424002C2D4B005156EE005156EE005156EE005156EE002C2D4B002424
      240024242400272834005156EE005156EE005156EE005156EE005156EE005156
      EE005156EE004B48E40000000000000000000000000000000000000000000000
      00005C6C6E00809A9E006C878B005F7B7F009CB0B300D3E1E300C7D6D8009FB0
      B2007084870030484C00112B2F000B232700192F3300566C6F00778688005061
      6300495B5D00556668005A6A6C005D6D6F00647577006C7F8100596C6D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004E51EA005157
      EF005157EF005157EF005157EF005157EF005157EF005157EF002C2D49002424
      24002424240028293A003739790033366B0033366B0036397900282939002424
      2400242424002C2D49005157EF005157EF005157EF005157EF005157EF005157
      EF005157EF004E50E90000000000000000000000000000000000000000000000
      000075898C007A9497005D7679003A5154003B515500CBDADB00BCCACC008F9F
      A2005A6D7000395154002B454900213E43002743470065787B0079888A005A6A
      6C00556567005C6C6E006170720063727400667678006B7D7F006C8183000F0F
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004F55EC005158
      EF005158EF005158EF005158EF005158EF005158EF004950CE002F325A002424
      240024242400292A3E0030325A00333568003335680030325B00292B3F002424
      2400242424002F3159004950CD005158EF005158EF005158EF005158EF005158
      EF005158EF004F55EC0000000000000000000000000000000000000000000000
      000087A1A300637C7F0032464A001A2C2F004F626500B8C6C800B0BFC1008F9E
      A00071838500586D7000607578007D909300A1B1B30098A7A9007D8C8E005C6B
      6E005C6C6E00617072006473750065737500677678006B7B7D006E828400232B
      2B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004F55ED005159
      F0005159F0005159F0005159F0004D54DF003538710024252700313460004146
      A8004D55DF005159F0005159F0005159F0005159F0005159F0005159F0004D55
      E0004146A8003134610024252800343770004D54DF005159F0005159F0005159
      F0005159F0004F55ED0000000000000000000000000000000000000000000000
      000090A7A9005F797C004860630062777900A0AFB100B7C5C700B9C7C900A8B6
      B800A5B4B600B1C0C200B8C6C800B7C6C800AFBEC0009EAEB000859496006372
      740061707200647375006674760066757600667577006B7B7C006E8183003F4C
      4C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004F52EB00525A
      F000525AF000525AF0004B52D2002829370034376E004B52D200525AF000525A
      F000525AF000525AF000525AF000525AF000525AF000525AF000525AF000525A
      F000525AF000525AF0004B52D30034376F00282937004B52D300525AF000525A
      F000525AF0004F52EA0000000000000000000000000000000000000000000000
      0000C0D2D400CEDDDF00C4D3D500C0CFD000C2D0D100C9D8D900CCDADC00C8D6
      D800BECDCF00B9C8CA00BBC9CC00BBCACC00B2C1C300A4B3B50094A3A5007482
      840066757700677577006775770067757700667577006A797B006D7F81005061
      6200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004C4CE600525A
      F100525AF100525AF1004F58E7004950CA00525AF100525AF100525AF100525A
      F100525AF100525AF100525AF100525AF100525AF100525AF100525AF100525A
      F100525AF100525AF100525AF100525AF1004950CB004F58E700525AF100525A
      F100525AF1004B4BE60000000000000000000000000000000000000000000000
      0000C2D1D500D5E4E500D1DFE100CFDDDF00D6E4E600DAE7E900D8E6E700E0EC
      ED00DFEAEB00D1DEE000C4D2D400C0CFD100B7C7C900ACBCBE00A1B0B2008D9C
      9E00768587006F7E80006D7B7D006B797B00697779006A797B006D7F81006477
      7A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF1000000000000000000000000000000000000000000000000000000
      0000ADC8C800D7E6E800D7E5E700D9E7E800DFEDEE00E0EDEE00DEEBED00EAF4
      F400F1F5F500EBF2F300D7E3E500C5D3D500BDCCCE00B4C3C500A9B8BA009EAD
      AF008C9B9D00808F91007A898B00748284006E7D7F006C7B7D006E7F81006F86
      8700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF1000000000000000000000000000000000000000000000000000000
      0000FFFFFF00D4E3E500DBE9EB00DDEAEC00E0EEEF00DFEDEE00E1EEF000EDF5
      F500F2F6F600F2F5F500E3EDEE00C5D4D600BAC9CB00B7C7C900ADBDBF00A4B4
      B5009BABAD008F9FA100839394007C8C8D00758486006F7F81006E8082006F86
      8600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004F55
      EC00525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F1004F54EC000000000000000000000000000000000000000000000000000000
      000000000000CFE0E000DCEAEC00DDEBED00DFEDEF00DFEDEF00E4F0F200F0F5
      F500F3F6F600F3F6F600EDF2F300CBD9DB00B3C3C500B1C0C200AFBFC100A5B5
      B700A1B1B3009AA9AC008D9D9F00829294007B8A8C0074848600708284007086
      8700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100000000000000000000000000000000000000000000000000000000000000
      000000000000CADADA00DAE9EA00DDEBEC00DFEDEF00E0EEEF00E7F2F400F3F6
      F600F4F6F600F4F6F600F2F5F500D7E3E400B8C8CA00ADBDBF00ABBABD00A7B6
      B900A3B3B500A0AFB10095A5A70089999B008191930079898B00738587007389
      8B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004E52EA00525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF1004D50
      E900000000000000000000000000000000000000000000000000000000000000
      000000000000ADC5C500D5E5E700DCEAEC00E0EDEF00E2EFF100EAF5F600F4F7
      F700F5F6F700F5F6F600F3F5F600DEE9EA00C2D1D300B5C5C700AEBEC000A9B8
      BA00A8B7B900A3B3B5009BAAAC008F9EA10088989A007F909200778A8C00768F
      8F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005158EF00525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF1005057EE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CCDCDE00DBEAEB00E0EEEF00E3F0F200EAF5F700F3F8
      F800F6F7F800F5F7F700F2F6F700E0EBED00C8D6D800BCCBCD00B6C6C700AFBE
      C000AEBDC000A9B8BA009FAEB10096A6A8008F9FA100889A9C007F94950055AA
      AA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005158EF00525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF1005058EE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B8CDCD00D9E7E900DFEDEF00E2F0F200E6F3F400EBF6
      F700F1F7F800EFF7F800E9F4F500DCE9EB00CBD9DB00C1CFD100BBCACC00B7C6
      C800B5C4C600B0BFC100A5B5B7009FAFB10097A8AA008EA1A300869A9D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004F54EC00525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF100525BF100525BF1004E52EA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CDDCDE00DDEBED00E1EFF100E2F0F200E3F1
      F200E6F3F400E5F1F300DFEDEE00D7E5E700CCDBDD00C4D3D500BECDCF00BCCB
      CD00B8C8C900B2C2C400A9B9BB00A4B4B6009BADAF0090A4A600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004740DE005159EF00525BF100525B
      F100525BF100525BF100525BF100525BF100525BF100525BF100525BF100525B
      F100525BF100525BF1005058EF00463EDC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CCCCCC00D4E3E600DEECEE00E0EEF000E1EE
      F000E0EEF000DEEBED00D9E7E900D5E3E500CEDDDF00C8D7D900C3D2D400BECD
      CF00B8C8CA00B1C1C300ABBCBD00A4B6B8009BAEAF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000453BDA004D4F
      E800515AF000525BF100525BF100525BF100525BF100525BF100525BF100515A
      F0004C4EE700443AD90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F00CFE0E200D9E8EA00DEEC
      ED00DEEBED00DCEAEB00D8E6E800D4E2E400D0DEE000CBDADC00C6D5D700BECE
      D000B8C8CA00B2C2C400ABBCBE009EAFB2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003F2DD0004234D5004338D8004338D8004234D5003F2DD0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFCFD700CFDF
      E100D7E7E800DAE8EA00D8E6E800D3E2E400CFDEE000CBDADC00C4D4D600BDCD
      CF00B5C5C700ACBEC0009AB6B600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AABBBB00C6D8D800C9D8DA00C6D7D700C3D4D400BDCFCF00B7C8CA00ADC1
      C1007F7F7F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006FA2CD0076ABD8007AB0DF007EB5
      E4007DB5E5007CB5E50080B7E50083BAE70087BBE70087BBE70079B0DC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007EB5E30087BBE7007EB7E50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000994EE000E97EF001098F0001098F0000E97EF000994EE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000008E
      EA000390EC000994EE000E97EF001098F0001098F0000E97EF000994EE000390
      EC00008FEA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000076ACD9007FB8E70085BBE80088BD
      E9008ABEEA008CBFEB008DC0EB008EC1EB008EC1EC0086BCE80082B9E7008BBF
      EA0099C8EF00A9D1F300B5D8F700BBDBF800BCDCF800BCDCF800AFD4F4007CB3
      E200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007FB6E600B8DAF700BDDDF900BADBF8009CC9EF0076ADD8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001299F0001D9F
      F40022A2F50023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60022A2
      F5001D9FF4001198F00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000089E2000490EB001299F0001D9F
      F40022A2F50023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60022A2
      F5001D9FF4001199F0000390EB000088E2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007EB6E50088BDE90090C2EC0094C4ED0095C5EE0096C6
      EE0096C6EE0096C6EE0096C6EE0095C5EE008ABEEA0087BDE90091C3ED009BC9
      EF00A8D0F300B5D8F600BCDCF800BDDDF900BDDDF900BDDDF900BDDDF9008EC0
      EA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000082B8E600BDDDF900BDDDF900BDDDF900BDDDF9009ECAEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000159BF10022A2F50023A3F60023A3
      F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3
      F60023A3F60023A3F60022A2F500139AF1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000290EA00159BF10022A2F50023A3F60023A3
      F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3
      F60023A3F60023A3F60022A2F500139AF100028FEB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007EB8
      E50089BEEA0082BAE70086BCE80095C5EE0097C6EE0099C7EF009AC8EF009BC9
      EF009BC9EF009BC9EF009BC8EF009AC8EF008CBFEA0089BEEA0091C3ED009AC8
      EF00A7D0F300B3D7F600BCDCF800BDDDF900BDDDF900BDDDF900BCDCF80085BB
      E800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000083BAE600BDDDF900BDDDF900BDDDF900BDDDF900BBDBF8007FB7
      E500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001FA1F40023A3F60023A3F60023A3F60023A3
      F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3
      F60023A3F60023A3F60023A3F60023A3F6001EA0F40000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000086DD000894ED001FA1F40023A3F60023A3F60023A3F60023A3
      F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3
      F60023A3F60023A3F60023A3F60023A3F6001FA0F4000793ED00000000000000
      000000000000000000000000000000000000000000000000000075ABD8008DC0
      EB0092C3ED0088BDE9008EC1EB009AC8EF009CC9F0009ECAF0009FCBF000A0CC
      F100A0CCF100A0CCF100A0CBF1009FCBF0009CC9F0008ABEEA0082BAE70088BD
      E90088BDE90088BDE90089BDE90089BEE9008ABEE9008BBFEA008ABEE9007EB6
      E600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084BAE700BDDDF900BDDDF900BDDDF900BDDDF900BDDDF90084B9
      E600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000022A2F50023A3F60023A3F60023A3F60023A3F60023A3
      F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3
      F60023A3F60023A3F60023A3F60023A3F60023A3F60021A2F500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000B95EE0022A2F50023A3F60023A3F60023A3F60023A3F60023A3
      F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3F60023A3
      F60023A3F60023A3F60023A3F60023A3F60023A3F60021A2F5000A94EE000000
      00000000000000000000000000000000000000000000000000007FB8E60093C4
      ED0096C6EE008DC0EB0098C7EE009FCBF000A1CCF100A3CDF100A4CEF200A5CE
      F200A5CFF200A5CFF200A5CEF200A4CEF200A1CCF10088BDE90085BBE8008DC0
      EB0099C8EF00A4CEF200ADD3F400B5D8F600B9DAF800BADBF800BBDBF800ACD3
      F4007CB4E2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008ABDE800BDDDF900BDDDF900BDDDF900BDDDF900BBDCF8007DB6
      E500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000022A6F60023A7F60023A7F60023A7F60023A7F60023A7F60023A7
      F60023A7F60023A7F60023A7F60023A7F60023A7F60023A7F60023A7F60023A7
      F60023A7F60023A7F60023A7F60023A7F60023A7F60023A7F60022A6F6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000895ED0022A6F60023A7F60023A7F60023A7F60023A7F60023A7F60023A7
      F60023A7F60023A7F60023A7F60023A5F30023A5F30023A7F60023A7F60023A7
      F60023A7F60023A7F60023A7F60023A7F60023A7F60023A7F60022A6F6000794
      ED0000000000000000000000000000000000000000000000000080B7E60097C6
      EE009AC8EF0098C7EE00A1CCF100A3CEF200A6CFF200A7D0F300A9D1F300AAD1
      F300AAD2F400AAD2F400AAD1F300A9D1F30094C4ED0089BEEA0091C3ED0099C8
      EF00A4CEF200B0D5F500BADBF800BCDCF900BDDDF900BDDDF900BDDDF900BDDD
      F90094C4EC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000095C5ED00BDDDF900BDDDF900BDDDF900BDDDF900AFD4F4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000022B0F60027B3F80027B3F80027B3F80027B3F80027B3F80027B3F80027B3
      F80027B3F80027B3F80027B3F80027B3F80027B3F80027B3F80027B3F80027B3
      F80027B3F80027B3F80027B3F80027B3F80027B3F80027B3F80027B3F80021AF
      F60000000000000000000000000000000000000000000000000000000000018F
      EB0022B0F60027B3F80027B3F80027B3F80027B3F80027B3F80027B3F80027B3
      F800268EC20024556F0024333B00242424002424240024323A0024556E00268D
      C10027B3F80027B3F80027B3F80027B3F80027B3F80027B3F80027B3F80021AF
      F600018FEB00000000000000000000000000000000000000000080B8E6009BC9
      EF009FCBF000A2CDF100A5CFF200A8D0F300AAD2F400ACD3F400AED4F500AFD4
      F50099C7EE0090C2EB0092C3EC00A2CDF10096C5ED008ABEEA0091C3ED0098C7
      EF00A4CEF200AFD4F500B9DAF800BCDCF800BDDDF900BDDDF900BDDDF900BDDD
      F90097C6ED000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A8D0F200BDDDF900BDDDF900BDDDF900BDDDF9009ECAEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0
      F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0
      F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0
      F9000000000000000000000000000000000000000000000000000000000015A8
      F2002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AB6EC002553
      6600242424002424240024242400242424002424240024242400242424002424
      2400255366002AB6EC002AC0F9002AC0F9002AC0F9002AC0F9002AC0F9002AC0
      F90014A7F200000000000000000000000000000000000000000081B8E6009FCB
      F000A3CDF100A6CFF200AAD1F300ADD3F400AFD5F500B1D6F500B3D7F600B4D7
      F600B4D8F600B4D8F6009FCBF0007FB7E60088BDE90087BCE90084BBE8008BBF
      EA0095C5ED009FCBF000A8D1F300AFD5F500B2D6F500B0D5F500ABD2F3009ECA
      EF007EB7E5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000086BBE800BCDCF800BDDDF900BDDDF900BDDDF900BDDDF9008BBFEA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002AC6
      F9002CC9FA002CC9FA002CC9FA002CC9FA002CC9FA002CC9FA002CC9FA002CC9
      FA002CC6F7002AA8D000298EAF0028819F0028819F00298EAF002AA8D0002CC6
      F6002CC9FA002CC9FA002CC9FA002CC9FA002CC9FA002CC9FA002CC9FA002CC9
      FA0029C5F90000000000000000000000000000000000000000000190EB002AC6
      F9002CC9FA002CC9FA002CC9FA002CC9FA002CC9FA002CC9FA00264D5A002424
      24002424240024303300264F5B00276071002760710026505D00243236002424
      240024242400264D5A002CC9FA002CC9FA002CC9FA002CC9FA002CC9FA002CC9
      FA0029C5F900018FEB000000000000000000000000000000000082B8E600A3CD
      F100A7D0F300ABD2F400AED4F500B1D6F500B4D7F600B6D9F700B8DAF700B9DA
      F800B9DBF800B9DBF800B9DAF700A4CEF1007EB7E60084BBE80083BAE70086BC
      E90087BDE90089BDE9008ABEEA008DC0EA0091C2EB0096C5ED009CC9EF009CC9
      EF0086BCE8000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000077AC
      D900ADD3F400BDDDF900BDDDF900BDDDF900BDDDF900BADBF8007EB6E5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002ED2
      FC002ED2FC002ED2FC002ED2FC002ED2FC002ED2FC002ED2FC002CAACA002761
      7100242D2F00242424002424240024242400242424002424240024242400242D
      2F00276170002CA9CA002ED2FC002ED2FC002ED2FC002ED2FC002ED2FC002ED2
      FC002ED2FC0000000000000000000000000000000000000000000FA5F0002ED2
      FC002ED2FC002ED2FC002ED2FC002ED2FC002ED2FC002ECFF800275C6900297D
      91002CB1D1002ED1FA002ED2FC002ED2FC002ED2FC002ED2FC002ED2FB002DB5
      D8002A83990027606E002ECFF8002ED2FC002ED2FC002ED2FC002ED2FC002ED2
      FC002ED2FC000FA4F0000000000000000000000000000000000081B8E600A6CF
      F200ABD2F400AFD4F500B2D7F600B6D8F700B8DAF700BBDBF800BCDCF800BCDC
      F900BCDDF900BCDDF900BCDCF900BCDCF80091C2EB0081B9E7008FC2EC0093C4
      ED009DCAF000A7D0F300B1D6F500B9DAF800BCDCF800BCDCF900BDDDF900BDDD
      F900B4D7F6007BB2E00000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000075A9D400A2CD
      F100BDDDF900BDDDF900BDDDF900BDDDF900BDDDF900AED4F400699AC0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001DBBF50030D8
      FC0030D7FC0032D5FC0033D2FB0033D3FC002FBFE10027586300242424002424
      2400242424002424240024242400242424002424240024242400242424002424
      24002424240024242400275763002FBFE10033D3FC0033D2FB0032D5FC0030D7
      FC0030D8FC0000000000000000000000000000000000000000001DBBF50030D8
      FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8
      FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8
      FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8FC0030D8
      FC0030D8FC001DBBF5000000000000000000000000000000000083BAE600AAD2
      F300AED4F500B3D7F600B7D9F700BADBF800BCDCF800BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900A9D1F30086BCE90091C3ED0097C6
      EE00A2CDF100ADD3F400B8DAF700BCDDF900BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF90084BAE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000081B7E600A8D0F200BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900BDDDF900AAD1F30073A8D3006E9F
      C8007EB7E50084BAE70088BCE8008CBFEA008EC0EB008DBFE90086BCE8000000
      000000000000000000000000000000000000000000000000000028CEFA0032DB
      FD0037D2FC003DC8FA0041C3F9003796BA00252E300024242400242424002537
      3B00285E68002A7B8A002C8EA0002C97AB002C97AB002C8EA0002A7B8A00285E
      680025373B002424240024242400252D30003796BA0041C3F9003DC8FA0037D2
      FC0032DBFD0027CDFA00000000000000000000000000008EEA0028CDFA0031DD
      FD0031DDFD0031DDFD0031DDFD0031DDFD0031DDFD0031DDFD0031DDFD0031DD
      FD0031DDFD0031DDFD0031DDFD0031DDFD0031DDFD0031DDFD0031DDFD0031DD
      FD0031DDFD0031DDFD0031DDFD0031DDFD0031DDFD0031DDFD0031DDFD0031DD
      FD0031DDFD0027CDFA00008DEA0000000000000000000000000083BAE600ADD4
      F400B2D6F600B7D9F700BBDBF800BCDCF800BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900B3D7F6007FB8E6008DC0EB0093C4
      ED009CCAF000A6CFF200B0D5F500B8DAF700BCDCF800BCDCF800BDDDF900BDDD
      F900B1D6F50079B2DF0000000000000000000000000000000000000000000000
      000000000000000000000000000078AEDC0094C4EC00B7D9F700BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900B9DAF8008FC1EB0086BCE90090C2
      EC009ECAF000A9D1F300B4D7F600BADBF800BCDCF800BDDDF900BCDCF80094C4
      EC000000000000000000000000000000000000000000000000002ED9FC0037D6
      FC0040C6F90048B8F7003E84B0002426270028353D0031778F0031BDD90032DE
      FD0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DF
      FE0032DFFD0031BDD9003177900028363D00242627003E84B00048B8F70040C6
      F90037D6FC002ED9FC00000000000000000000000000008EEA002ED9FC0032DF
      FE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DF
      FE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DF
      FE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DFFE0032DF
      FE0032DFFE002ED9FC00008EE90000000000000000000000000083BAE600B1D6
      F500B6D8F700BADBF800BCDCF900BDDDF900BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900B4D8F6007EB7E6007EB7E60082BA
      E70088BDE9008FC1EB0096C5ED009AC8EF009DCAEF009CC9EF0099C7EE0092C3
      EC0081B9E6000000000000000000000000000000000000000000000000000000
      0000000000007EB6E40095C4EC00B3D7F600BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF90098C7EE0089BDEA0091C3ED009AC8
      EF00A6CFF200B2D7F600BCDCF800BDDDF900BDDDF900BDDDF900BDDDF900ADD3
      F40000000000000000000000000000000000000000000000000033DEFD003CCF
      FB0047BCF70051ABF500374E6E004471A5004DAFF20043C3F90038D6FC0033E0
      FD0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0
      FE0033E0FD0038D6FC0043C3F9004DAFF2004471A600374E6E0051ABF50047BC
      F7003CCFFB0033DDFD00000000000000000000000000008EEA0032DFFD0033E0
      FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0
      FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0
      FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0FE0033E0
      FE0033E0FE0032DFFD00008EEA000000000000000000000000007DB5E400AFD5
      F500B9DAF800BCDCF800BDDDF900BDDDF900BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900ADD3F40080B8E6008ABEEA0091C2
      EC0095C5ED0099C7EE009CC9EF00A0CBF000A3CDF100A7D0F2009FCBF00082B9
      E6000000000000000000000000000000000000000000000000000000000088BD
      E800A4CEF100B9DAF700BDDDF900BDDDF900BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF9009CC9EF008BBFEA0091C3ED0099C8
      EF00A5CFF200B1D6F500BADBF800BCDCF900BDDDF900BDDDF900BDDDF900A4CE
      F10000000000000000000000000000000000000000000000000033DEFD003DCE
      FA0049BAF70054A7F4005D96F2005A9BF30050AEF50044C1F80039D5FC0033E0
      FD0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E0FD0039D5FC0044C1F80050AEF5005A9BF3005D96F20054A7F40049BA
      F7003DCEFA0033DDFD00000000000000000000000000008EE90032E0FD0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0032E0FD0032DB
      F80033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0032DBF80032E0FD0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0032E0FD00008EEA000000000000000000000000000000000088BD
      E800A4CEF100B9DAF700BDDDF900BDDDF900BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF9009CC9EF008BBFEA0091C3ED0099C8
      EF00A5CFF200B1D6F500BBDBF800BCDCF900BDDDF900BDDDF900BDDDF900A4CE
      F1000000000000000000000000000000000000000000000000007DB5E200AFD5
      F500B9DAF800BCDCF800BDDDF900BDDDF900BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900ADD3F40080B8E6008ABEEA0091C2
      EC0095C5ED0099C7EE009CC9EF00A0CBF000A3CDF100A7CFF200A0CBF00081B9
      E70000000000000000000000000000000000000000000000000030DAFC003BD2
      FB0045C0F8004EB0F60054A6F40052A9F5004BB6F60041C7F90037D9FC0033E0
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E0FE0037D9FC0041C7F9004BB6F60052A9F50054A6F4004EB0F60045C0
      F8003BD2FB002FDAFC00000000000000000000000000008EEA002FDBFC0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0031CCE600264448002425
      26002A76820033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE002A76
      8200242526002644480031CCE60033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE002FDBFC00008EE900000000000000000000000000000000000000
      0000000000007EB7E50095C4EC00B3D7F600BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF90098C7EE0089BEEA0091C3ED009AC8
      EF00A6CFF200B2D7F600BCDCF800BDDDF900BDDDF900BDDDF900BDDDF900ADD3
      F40000000000000000000000000000000000000000000000000083BAE600B1D6
      F500B6D8F700BADBF800BCDCF900BDDDF900BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900B4D8F6007EB7E6007EB7E60082BA
      E70088BDE9008FC1EB0096C5ED009AC8EF009DCAEF009CC9EF0099C7EE0092C3
      EC0081B9E700000000000000000000000000000000000000000029D1FA0036DB
      FD003ECDFA0045C1F80048BAF70048BCF70042C5F9003BD2FB0033DFFD0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033DFFD003BD2FB0042C5F90048BCF70048BAF70045C1F8003ECD
      FA0036DBFD0028D0FA00000000000000000000000000008EEA0029D1FA0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE002A758200242424002424
      24002424240030BED60033E1FE0033E1FE0033E1FE0033E1FE0030BED6002424
      240024242400242424002A75820033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0028D0FA00008DEA00000000000000000000000000000000000000
      000000000000000000000000000079B1DF0095C4EC00B7D9F700BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900B9DAF7008FC1EB0086BCE90090C2
      EC009ECAF000A9D1F300B4D7F600BADBF800BCDCF800BDDDF900BCDCF80094C4
      EC0000000000000000000000000000000000000000000000000083BAE600ADD4
      F400B2D6F600B7D9F700BBDBF800BCDCF800BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900B3D7F6007FB8E6008DC0EB0093C4
      ED009CCAF000A6CFF200B0D5F500B8DAF700BCDCF800BCDCF800BDDDF900BDDD
      F900B1D6F50079B1DE00000000000000000000000000000000001FC1F60033E0
      FD0035DCFD003AD4FB003DCFFB003CD0FB0038D7FC0034DEFD0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0034DEFD0038D7FC003CD0FB003DCFFB003AD4FB0035DC
      FD0033E0FD0000000000000000000000000000000000000000001FC1F60033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0028616B00242424002424
      2400242424002EAABF0033E1FE0033E1FE0033E1FE0033E1FE002EAABF002424
      2400242424002424240028616B0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE001EC0F60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000082B9E700A8D0F200BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900BDDDF900AAD1F30075A9D50071A6
      CF007EB7E50084BAE80088BCE8008CC0EA008EC1EB008DBFE90085BBE8000000
      000000000000000000000000000000000000000000000000000083BAE600AAD2
      F300AED4F500B3D7F600B7D9F700BADBF800BCDCF800BDDDF900BDDDF900BDDD
      F900BDDDF900BDDDF900BDDDF900BDDDF900A9D1F30086BCE90091C3ED0097C6
      EE00A2CDF100ADD3F400B8DAF700BCDDF900BDDDF900BDDDF900BDDDF900BDDD
      F900BDDDF90084BAE700000000000000000000000000000000000000000033E1
      FE0033E1FE0033E0FD0033DFFD0033E0FD0030C6DF002D9BAE0032DFFB0033E1
      FE0030C2DA002DA1B40032E0FD0033E1FE0033E1FE0032DCF9002D99AB0031CB
      E40033E1FE0032DAF6002D99AB0031D0EA0033E0FD0033DFFD0033E0FD0033E1
      FE0033E1FE00000000000000000000000000000000000000000011AAF10033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE002C92A300242424002424
      2400242D2E0031D2EC0033E1FE0033E1FE0033E1FE0033E1FE0031D2EC00242D
      2E0024242400242424002C92A30033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0010A9F10000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000075ACD700A3CD
      F100BDDDF900BDDDF900BDDDF900BDDDF900BDDDF900AED4F400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000081B8E600A6CF
      F200ABD2F400AFD4F500B2D7F600B6D8F700B8DAF700BBDBF800BCDCF800BCDC
      F900BCDDF900BCDDF900BCDCF900BCDCF80091C2EB0081B9E7008FC2EC0093C4
      ED009DCAF000A7D0F300B1D6F500B9DAF800BCDCF800BCDCF900BDDDF900BDDD
      F900B4D7F6007AB3E00000000000000000000000000000000000000000002FDC
      FC0033E1FE0033E1FE0033E1FE0033E1FE0028616B0024242400296D78002FAF
      C500253235002424240030BFD60033E1FE0033E1FE002EA7BC0024242400263D
      41002FB6CC00285C6400242424002A78850033E1FE0033E1FE0033E1FE0033E1
      FE002FDAFC0000000000000000000000000000000000000000000292EA002FDC
      FC0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0032DFFC002C8D9D00296A
      75002FB6CD0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE002FB6
      CD00296A75002C8D9D0032DFFC0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE002FDBFC000191EB0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000079AE
      DC00ADD3F400BDDDF900BDDDF900BDDDF900BDDDF900BADBF8007DB5E4000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000082B8E600A3CD
      F100A7D0F300ABD2F400AED4F500B1D6F500B4D7F600B6D9F700B8DAF700B9DA
      F800B9DBF800B9DBF800B9DAF700A4CEF1007EB7E60084BBE80083BAE70086BC
      E90087BDE90089BDE9008ABEEA008DC0EA0091C2EB0096C5ED009CC9EF009CC9
      EF0085BCE8000000000000000000000000000000000000000000000000000000
      000033E1FE0033E1FE0033E1FE0033E1FE002D97A90024242400242424002424
      240024242400253A3E0032DCF90033E1FE0033E1FE0031D3EE00242F30002424
      24002424240024242400242424002EADC20033E1FE0033E1FE0033E1FE0033E1
      FE000000000000000000000000000000000000000000000000000084DC001AB9
      F40033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0019B7F4000085DC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000086BBE800BCDCF800BDDDF900BDDDF900BDDDF900BDDDF9008BBFEA000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000081B8E6009FCB
      F000A3CDF100A6CFF200AAD1F300ADD3F400AFD5F500B1D6F500B3D7F600B4D7
      F600B4D8F600B4D8F6009FCBF0007FB7E60088BDE90087BCE80085BBE8008BBF
      EA0095C5ED009FCBF000A9D1F300AFD5F500B2D6F500B0D5F500ABD2F3009FCB
      F0007EB7E5000000000000000000000000000000000000000000000000000000
      00002DD8FB0033E1FE0033E1FE0033E1FE0032E0FC002A768300242626002424
      2400253B3F0030BBD20033E1FE0033E1FE0033E1FE0033E1FE002EAEC3002534
      360024242400242829002B88970033E1FE0033E1FE0033E1FE0033E1FE002CD5
      FB00000000000000000000000000000000000000000000000000000000000293
      EB002DD7FB0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE002CD6
      FB000291EB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006896BD00A8D0F200BDDDF900BDDDF900BDDDF900BDDDF9009ECAEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007FB8E6009BC9
      EF009FCBF000A2CDF100A5CFF200A8D0F300AAD2F400ACD3F400AED4F500AFD4
      F50099C7EE0090C1EB0092C3EC00A2CDF10096C5ED008ABEEA0091C3ED0098C7
      EF00A4CEF200AFD4F500B9DAF800BCDCF800BDDDF900BDDDF900BDDDF900BDDD
      F90097C6ED000000000000000000000000000000000000000000000000000000
      00000000000031DFFD0033E1FE0033E1FE0033E1FE0033E1FE0031D1EB0030C1
      D90032DEFA0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0032DC
      F80030C0D80032D4EF0033E1FE0033E1FE0033E1FE0033E1FE0031DEFD000000
      0000000000000000000000000000000000000000000000000000000000000078
      C6000CA3EF0031DFFD0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0031DEFD000AA0
      EF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000095C5ED00BDDDF900BDDDF900BDDDF900BDDDF900AFD4F4000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080B7E60097C6
      EE009AC8EF0098C7EE00A1CCF100A3CEF200A6CFF200A7D0F300A9D1F300AAD1
      F300AAD2F400AAD2F400AAD1F300A9D1F30094C4ED0089BEEA0091C3ED0099C8
      EF00A4CEF200B0D5F500BADBF800BCDCF900BDDDF900BDDDF900BDDDF900BDDD
      F90094C4EC000000000000000000000000000000000000000000000000000000
      0000000000000000000032DFFD0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0031DEFD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000088E00011ABF10032DFFD0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0031DEFD000FA7F0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008ABDE800BDDDF900BDDDF900BDDDF900BDDDF900BBDCF8000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007FB8E60093C4
      ED0096C6EE008DC0EB0098C7EE009FCBF000A1CCF100A3CDF100A4CEF200A5CE
      F200A5CFF200A5CFF200A5CEF200A4CEF200A1CCF10088BDE90085BBE8008DC0
      EB0099C8EF00A4CEF200ADD3F400B5D8F600B9DAF800BADBF800BBDBF800ACD3
      F4007EB4E2000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002EDAFC0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE002DD8FB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000088E0000DA5F0002EDAFC0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE002DD8FB000BA2EF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000085BAE700BDDDF900BDDDF900BDDDF900BDDDF900BDDDF9000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000076ADD9008DC0
      EB0092C3ED0088BDE9008EC1EB009AC8EF009CC9F0009ECAF0009FCBF000A0CC
      F100A0CCF100A0CCF100A0CBF1009FCBF0009CC9F0008ABEEA0082BAE70088BD
      E90088BDE90088BDE90089BDE90089BEE9008ABEE9008BBFEA008ABEE9007EB5
      E500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001FC1F60032DFFD0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0031DFFD001DBEF6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000007DCE000494EB001FC1F60032DFFD0033E1FE0033E1
      FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1
      FE0033E1FE0033E1FE0031DFFD001DBEF6000394EB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000082B9E700BDDDF900BDDDF900BDDDF900BDDDF900BBDBF8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007FB8
      E50089BEEA0082BAE70086BCE80095C5EE0097C6EE0099C7EF009AC8EF009BC9
      EF009BC9EF009BC9EF009BC8EF009AC8EF008CBFEA0089BEEA0091C3ED009AC8
      EF00A7D0F300B3D7F600BCDCF800BDDDF900BDDDF900BDDDF900BCDCF80085BB
      E800000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001ABAF5002BD4
      FB0032E0FD0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0032E0
      FD002AD3FA0019B8F40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000008BE6000698EC001ABAF4002BD4
      FB0032E0FD0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0033E1FE0032E0
      FD002AD3FA0019B8F4000597EC00008AE5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000083BAE600BDDDF900BDDDF900BDDDF900BDDDF9009ECAEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007EB6E60088BDE90090C2EC0094C4ED0095C5EE0096C6
      EE0096C6EE0096C6EE0096C6EE0095C5EE008ABEEA0087BDE90091C3ED009BC9
      EF00A8D0F300B5D8F600BCDCF800BDDDF900BDDDF900BDDDF900BDDDF9008EC0
      EA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000597EC000EA6F00014B0F20017B4F30017B4F30014AFF2000EA6F0000496
      EC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000008E
      E9000597EC000EA6F00014B0F20017B4F30017B4F30014B0F2000EA6F0000496
      EC00008DEA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007FB8E600B8DAF700BDDDF900BADBF8009CC9EF0078AEDB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000079AFDC007FB8E70085BBE80088BD
      E9008ABEEA008CBFEB008DC0EB008EC1EB008EC1EC0086BCE80082B9E7008BBF
      EA0099C8EF00A9D1F300B5D8F700BBDBF800BCDCF800BCDCF800AFD4F4007CB4
      E300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007EB7E40087BBE70080B8E50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007AB1DF007DB5E5007CB5
      E4007DB5E5007DB5E50080B7E50083BAE70087BBE70087BBE7007AB2E0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007973510076724D006864450068624500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000591406005914
      0600591406005914060059140600591406005914060059140600591406005914
      0600591406005914060059140600591406005914060059140600591406005914
      0600591406005914060059140600591406005914060059140600591406005914
      0600591406005914060059140600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000349E6F00349E
      6F00349E6F00349E6F00349E6F00349E6F00349E6F00349E6F00349E6F00349E
      6F00349E6F000347340000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007171540078734F0077724F008E895F007C77530067634500686344006B5D
      4300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000059140600A778
      5C00A97B5F00AB7E6200AC816600AF846A00B1876D00B38A7100B58D7500B790
      7900B8937C00BA967F00BB988100BD998400BD9A8400BC988200BB968000B994
      7D00B7917A00B58E7600B38B7300B1886F00AF856B00AD826700AB7F6400AA7C
      6100A87A5E00AA7D620059140600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000339F6F003CD7
      A7003CD7A7003CD7A7003CD7A7003CD7A7003CD7A7003CD7A7003CD7A7003CD7
      A700339E70000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F3F007873
      4D0078734E0087815A00B2AB7900C7C089009F9A6E00817D59006E6A4A006762
      4400656345007F7F3F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000591406009860
      3D007B3C1D007B3C1D007B3C1D007A3C1C007A3B1C007A3B1C007A3B1C007A3B
      1B007A3A1B007A3A1B00793A1B00793A1A00793A1A00793A1B00793A1B007A3A
      1B007A3A1B007A3B1B007A3B1C007A3B1C007A3B1C007B3C1D007B3C1D007B3C
      1D007B3C1D0098603D0059140600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000033A070003CD7
      A70013B98C0013B98C0013B98C0013B98C0013B98C0013B98C0013B98C003CD7
      A700329F70000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000076724D0078734F00817C
      5500AAA37300C6BF8800C6BF8800B3AD7B008A8660008A86600089855F007D79
      56006C6848006864450065624500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000591406009257
      3000722F0C00732F0C00732F0C00732F0C00732F0C00732F0C00732F0C00732F
      0C00732F0C00732F0C00732F0C00732F0C00732F0C00732F0C00732F0C00732F
      0C00732F0C00732F0C00732F0C00732F0C00732F0C00732F0C00732F0C00732F
      0C00722F0C0091552E0059140600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000031A1710039D7
      A6000CC78F000CC78F000CC78F000CC78F000CC78F000CC78F000CC78F0039D7
      A60032A171000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000078714D0077734F007C775200A29C6E00C4BD
      8700C7C08900C6BF8800AFA978009F9A6E008A8660008A8660008A8660008A86
      600089845F007A7653006A664600676244006767440000000000000000000000
      0000000000000000000000000000000000000000000000000000591406009459
      310074310C0074310C0074310C0074310C0074310C0074310C0074310C007431
      0C0074310C0074310C0074310C0074310C0074310C0074310C0074310C007431
      0C0074310C0074310C0074310C0074310C0074310C0074310C0074310C007431
      0C0074310C0092572E0059140600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000030A2720034D5
      A4000CC790000CC790000CC790000CC790000CC790000CC790000CC7900034D6
      A50031A272000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000075754E0077734E00797450009A946800C0BA8400C7C08900C7C0
      8900C5BE8700ABA576009F9A6E009F9A6E008A8660008A8660008A8660008A86
      60008A8660008A86600087835E007772500068634400676344006D5B48000000
      000000000000000000000000000000000000000000000000000059140600965C
      330076330C0076330C0076330C0076330C0076330C0076330C0076330C007633
      0C0076330C0076330C0076330C0076330C0076330C0076330C0076330C007633
      0C0076330C0076330C0076330C0076330C0076330C0076330C0076330C007633
      0C0076330C0094592F0059140600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002FA373002FD5
      A2000CC891000CC891000CC891000CC891000CC891000CC891000CC891002FD4
      A30030A372000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000333333001F1F1F001C1C1C001C1C1C001F1F1F00333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F0077724E0078724F00928C6200BBB58000C7C08900C7C08900C7C08900C3BD
      8600A7A274009F9A6E009F9A6E009F9A6E008A8660008A8660008A8660008A86
      60008A8660008A8660008A8660008A86600085815C00736F4E00686445006764
      45007F7F7F00000000000000000000000000000000000000000059140600985E
      340078350D0078350D0078350D0078350D0078350D0078350D0078350D007835
      0D0078350D0078350D0078350D0078350D0078350D0078350D0078350D007835
      0D0078350D0078350D0078350D0078350D0078350D0078350D0078350D007835
      0D0078350D00965B300059140600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002DA4740029D3
      A1000DCA92000DCA92000DCA92000DCA92000DCA92000DCA92000DCA920029D3
      A1002EA473000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000242424004C4C4C007175
      770092979A00ACB1B700BDC4CA00C7CDD400C7CDD400BDC4CA00ACB1B7009297
      9A00717577004C4C4C0024242400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000079744D007873
      4E008A845C00B5AE7C00C7C08900C7C08900C7C08900C7C08900C1BB8500A59F
      72009F9A6E009F9A6E009D986D0074715600817D5B008A8660008A8660008A86
      60008A8660008A8660008A8660008A8660008A8660008A866000827E5A00706C
      4B00676244006666440000000000000000000000000000000000591406009A61
      35007A370D007A370D007A370D007A370D007A370D007A370D007A370D007A37
      0D007A370D007A370D007A370D007A370D007A370D007A370D007A370D007A37
      0D007A370D007A370D007A370D007A370D007A370D007A370D007A370D007A37
      0D007A370D00985D310059140600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002CA6750023D2
      9F000DCB93000DCB93000DCB93000DCB93000DCB93000DCB93000DCB930023D1
      9F002DA574000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000505055008E919600C6CCD400DDE4EC00E1E8
      F000E1E7EF00D7D1C000CEB88800CAAC6C00C9AA6B00CCB58500D5CFBE00E1E7
      EF00E1E8F000DDE4EC00C6CCD4008E9196005055550000000000000000000000
      000000000000000000000000000000000000000000000000000085815900ADA7
      7600C6BF8800C7C08900C7C08900C7C08900C7C08900BFB88300A29D70009F9A
      6E009F9A6E009F9A6E00858160003333330036353100757254008A8660008A86
      60008A8660008A8660008A8660008A8660008A8660008A8660008A8660008985
      5F007F7B57006D6A4A000000000000000000000000000000000059140600A16B
      40007D3A0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A
      0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A
      0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A0D007D3A
      0D007D3A0D009C63360059140600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002BA676001DD0
      9D000DCC94000DCC94000DCC94000DCC94000DCC94000DCC94000DCC94001DD1
      9C002BA676000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000067676B00B1B7BC00DFE6ED00E4EBF200E4EBF200E4EBF200DEDF
      DC00CFAF6D00CB9E4200C99C4000C79A3E00C6993D00C4973B00C2953900C5A6
      6400DBDDDA00E3EAF200E3EAF200E3EAF200DEE5EC00B0B5BC00676B6E000000
      0000000000000000000000000000000000000000000000000000C3BC8600C7C0
      8900C7C08900C7C08900C7C08900C7C08900BCB58100A19B6F009F9A6E009F9A
      6E009F9A6E009F9A6E0084805F00333333002C2C2C002E2E2D0065634B008A86
      60008A8660008A8660008A8660008A8660008A8660008A8660008A8660008A86
      60008A86600089835E000000000000000000000000000000000059140600A46E
      42007F3C0E007F3C0E007F3C0E007F3C0E007F3C0E007F3C0E007F3C0E007F3C
      0E007F3C0E00A06F4D00FCFDFC00FCFDFC00FCFDFC00FCFDFC00FCFDFC00FCFD
      FC00FCFDFC0087491E007F3C0E007F3C0E007F3C0E007F3C0E007F3C0E007F3C
      0E007F3C0E009F66370059140600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000029A8780017D0
      9A000DCD96000DCD96000DCD96000DCD96000DCD96000DCD96000DCD960017D0
      9B002AA877000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006565
      6500B4B8BE00E4E9F000E6ECF300E6ECF300E6ECF300E6ECF300E1E2DF00CFA9
      5900CDA04400CB9E4200C99C4000C79A3E00C6993D00C4973B00C2953900C093
      3700C19A4B00DEDFDC00E5EBF300E5EBF300E5EBF300E4EBF200E1E8EF00B4B8
      BE0065656D000000000000000000000000000000000000000000C5BE8800C7C0
      8900C7C08900C7C08900C7C08900B8B17F009F9A6E009F9A6E009F9A6E009F9A
      6E009F9A6E009F9A6E0084805F00333333004D4C3E00363531002C2C2C005251
      410087835E008A8660008A8660008A8660008A8660008A8660008A8660008A86
      60008A86600089845E000000000000000000000000000000000059140600A671
      4400823E0E00823E0E00823E0E00823E0E00823E0E00823E0E00823E0E00823E
      0E00823E0E0094735B00FCFDFC00FCFDFC00FCFDFC00FCFDFC00FCFDFC00FCFD
      FC00FCFDFC0082471D00823E0E00823E0E00823E0E00823E0E00823E0E00823E
      0E00823E0E00A1683900591406000000000028AA7A0027AA7A0028AA7A0027AA
      790028AA790028AA790028AA790028AA790028AA790027AA790027AA790014CE
      99000DCF98000DCF98000DCF98000DCF98000DCF98000DCF98000DCF980013CF
      990028A9790029A9790029A9780028A9790028A9780029A9780029A9780028A9
      780029A9780029A9780029A978000000000000000000000000009FA2A700DFE4
      EB00E8EEF400E8EEF400E8EEF400E8EEF400E8EEF400E7EDF400D4B57500CFA2
      4600CDA04400CB9E4200C99C4000BF953D00BE933B00C4973B00C2953900C093
      3700BE913500C6A76600E6ECF300E6ECF300E6ECF300E6ECF300E6ECF300E6EC
      F300DDE2EA00A2A4A90000000000000000000000000000000000C6C08900C7C0
      8900C7C08900C7C08900938E6A006C6952006C6952006C6952006C6952006C69
      52006C6952006C6952005E5B4A0033333300605E4900817D5B00424138002C2C
      2C0042413800817D5B008A8660008A8660008A8660008A8660008A8660008A86
      60008A8660008A8560000000000000000000000000000000000059140600A974
      460084410E0084410E0084410E0084410E0084410E0084410E0084410E008441
      0E0084410E0091715B00FCFDFC00CCCBCA000B0100000B0100000B0100000B01
      00000B0100007C3D0D0084410E0084410E0084410E0084410E0084410E008441
      0E0084410E00A36B3A00591406000000000026AC7B001DD4A0003EDCB0003EDC
      B0003EDCB0003EDCB0003EDCB0003EDCB0003EDCB0003EDCB0003EDCB00011CE
      98000DD099000DD099000DD099000DD099000DD099000DD099000DD0990011CE
      98003EDCB0003EDCB0003EDCB0003EDCB0003EDCB0003EDCB0003EDCB0003EDC
      B0003EDCB00040DDB10027AA79000000000000000000CBD0D400EAEFF500EAEF
      F500EAEFF500EAEFF500EAEFF500EAEFF500EAEFF500E2DDCE00D0A34700CFA2
      4600CDA04400C19740005A4C2F002727260027272600584A2D00B88E3800C093
      3700BE913500BD903400DDD7C800E8EEF400E8EEF400E8EEF400E8EEF400E8EE
      F400E8EDF400E7EDF400C9CED400000000000000000000000000C6C08900C7C0
      8900C7C08900C7C0890039393600333333003333330033333300333333003333
      33003333330033333300333333003333330064624B008A86600087835E005251
      41002C2C2C0036353100757254008A8660008A8660008A8660008A8660008A86
      60008A8660008A8560000000000000000000000000000000000059140600AB77
      480087440F0087440F0087440F0087440F0087440F0087440F0087440F008744
      0F0087440F0093735B00FCFDFC00D2CDCB0087440F0087440F0087440F008744
      0F0087440F0087440F0087440F0087440F0087440F0087440F0087440F008744
      0F0087440F00A56E3B00591406000000000024AE7C0020D7A30011C9960011C9
      960011C9960011C9960011C9960011C9960011C9960011C9960011C9960011C9
      96000DD29B000DD29B000DD29B000DD29B000DD29B000DD29B000DD29B000DD2
      9B0011C9960011C9960011C9960011C9960011C9960011C9960011C9960011C9
      960011C9960015D49E0026AC7B0000000000E2E6EA00ECF1F600ECF1F600ECF1
      F600ECF1F600ECF1F600ECF0F600ECF0F600ECF0F600DDC89B00D0A34700CFA2
      4600CDA0440060513200292929002929290029292900292929005D4E2E00C093
      3700BE913500BD903400D1BC8F00EAEFF500EAEFF500EAEFF500EAEFF500EAEF
      F500EAEFF500E9EFF500E9EFF500E0E4EA000000000000000000C6C08900C7C0
      8900C7C08900C7C08900373735004A493F008783610087836100878361008783
      61008783610087836100878361008884610088845F008A8660008A8660008A86
      600065634B002E2E2D002E2E2D0065634B008A8660008A8660008A8660008A86
      60008A866000949066000000000000000000000000000000000059140600AE7A
      4A0089460F0089460F0089460F0089460F0089460F0089460F0089460F008946
      0F0089460F0096745B00FCFDFC00D2CDCB0089460F0089460F0089460F008946
      0F0089460F0089460F0089460F0089460F0089460F0089460F0089460F008946
      0F0089460F00A8703C00591406000000000022AF7D0025D8A5000ED39C000ED3
      9C000ED39C000ED39C000ED39C000ED39C000ED39C000ED39C000ED39C000ED3
      9C000ED39C000ED39C000ED39C000ED39C000ED39C000ED39C000ED39C000ED3
      9C000ED39C000ED39C000ED39C000ED39C000ED39C000ED39C000ED39C000ED3
      9C000ED39C0019D6A00024AD7C0000000000E4EDF400EEF2F700EEF2F700EEF2
      F700EEF2F700EEF2F700EEF2F700EDF2F700EDF2F700DBBF8300D0A34700CFA2
      4600CA9E43002F2E2C002C2C2C002C2C2C002C2C2C002C2C2C002F2E2C00BE91
      3700BE913500BD903400CBAF7400ECF1F600ECF0F600ECF0F600ECF0F600ECF0
      F600EBF0F600EBF0F600EBF0F600E3EAF3000000000000000000C6C08900C7C0
      8900C7C08900C7C0890037373500514F43009F9A6E009F9A6E009F9A6E009F9A
      6E009F9A6E009F9A6E009F9A6E009F9A6E008A8660008A8660008A8660008A86
      60008A86600075725400363531002C2C2C005351410088845E008A8660008A86
      60009C976C00ABA575000000000000000000000000000000000059140600B07D
      4B008C490F008C490F008C490F008C490F008C490F008C490F008C490F008C49
      0F008C490F0098755B00FCFDFC00D3CDCB008C490F008C490F008C490F008C49
      0F008C490F008C490F008C490F008C490F008C490F008C490F008C490F008C49
      0F008C490F00AA733D00591406000000000021B17F0028DAA7000ED59E000ED5
      9E000ED59E000ED59E000ED59E000ED59E000ED59E000ED59E000ED59E000ED5
      9E000ED59E000ED59E000ED59E000ED59E000ED59E000ED59E000ED59E000ED5
      9E000ED59E000ED59E000ED59E000ED59E000ED59E000ED59E000ED59E000ED5
      9E000ED59E001CD8A30022AF7D0000000000A3C7E700ECF1F600F0F3F800F0F3
      F800F0F3F800F0F3F800EFF3F800EFF3F800EFF3F700DCC08500D0A34700CFA2
      4600CB9F4400454441003E3E3E002E2E2E002E2E2E002E2E2E0033322F00BE92
      3700BE913500BD903400CDB17600EEF2F700EEF2F700EEF2F700EDF2F700EDF2
      F700EDF2F700EDF1F700E9EFF500A3C7E7000000000000000000C6C08900C7C0
      8900C7C08900C7C0890037373500514F43009F9A6E009F9A6E009F9A6E009F9A
      6E009F9A6E009F9A6E009F9A6E009F9A6E008A8660008A8660008A8660008A86
      60008A8660008A866000817D5B00414038002C2C2C0045443A008B876100A29C
      6F00ADA77700ABA575000000000000000000000000000000000059140600B27F
      4B008E4C10008E4C10008E4C10008E4C10008E4C10008E4C10008E4C10008E4C
      10008E4C10009A765B00FCFDFC00D4CECB008E4C10008E4C10008E4C10008E4C
      10008E4C10008E4C10008E4C10008E4C10008E4C10008E4C10008E4C10008E4C
      10008E4C1000AC753D0059140600000000001FB280002BDBAA000ED6A0000ED6
      A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6
      A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6
      A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6A0000ED6
      A0000ED6A0001FD9A60020B17F00000000006294B4009DC3E500EAEFF400F2F5
      F900F1F5F900F1F5F800F1F5F800F1F4F800F1F4F800E2CDA200D0A34700CFA2
      4600D5B06300B7AE9B00979797004C4C4C0031313100313131006B593400C093
      3700BE913500BD903400D6C19600F0F3F800EFF3F800EFF3F800EFF3F700EFF3
      F700EFF3F700E7EDF3009CC3E5006A9CC5000000000000000000C6C08900C7C0
      8900C7C08900C7C0890037373500514F43009F9A6E009F9A6E009F9A6E009F9A
      6E009F9A6E009F9A6E009F9A6E009F9A6E008A8660008A8660008A8660008A86
      60008A8660008A866000807D5A00414037002C2C2C004A483D00A6A17200ADA7
      7700ADA77700ACA676000000000000000000000000000000000059140600B481
      4C00914E10009250120092501200925012009250120092501200925012009250
      1200925012009D785C00FCFDFC00D6CECB009250120092501200925012009250
      1200925012009250120092501200925012009250120092501200925012009250
      1200914E1000AE773E0059140600000000001EB482002FDDAB0010D8A10010D8
      A10010D8A10010D8A10010D8A1000FD8A1000FD8A1000FD8A1000FD8A1000FD8
      A1000FD8A1000ED8A1000ED8A1000ED8A1000ED8A1000ED8A1000ED8A1000ED8
      A1000ED8A1000ED8A1000ED8A1000ED8A1000ED8A1000ED8A1000ED8A1000ED8
      A1000ED8A10023DBA80020B2800000000000000000007EB6E60090BBE100DAE3
      EC00F2F5F800F3F6F900F3F6F900F3F6F900F3F6F900EDE8DB00D0A44800CFA2
      4600DABA7600E3CDA000B9B09C00696762003E3B3400715E3600BE923900C093
      3700BE913500BD903400E8E3D600F1F5F800F1F5F800F1F4F800F1F4F800F0F3
      F700D8E2EB008FBBE1007EB4E400000000000000000000000000C6C08900C7C0
      8900C7C08900C7C0890037373500514F43009F9A6E009F9A6E009F9A6E009F9A
      6E009F9A6E009F9A6E009F9A6E009F9A6E008A8660008A8660008A8660008A86
      60008A86600075725400353531002C2C2C00615F4B00A8A37400ADA77700ADA7
      7700ADA77700ACA676000000000000000000000000000000000059140600BD90
      5F00A0652C00A1683000A1682F00A1682F00A1682F00A1682F00A1682F00A168
      2F00A1682F00AB836900FCFDFC00DBCFCC00A1682F00A1682F00A1682F00A168
      2F00A1682F00A1682F00A1682F00A1682F00A1682F00A1682F00A1682F00A168
      2F00A0662D00B989550059140600000000001BB6830034DEAE0013D9A40013D9
      A40013D9A40013D9A40013D9A40013D9A40013D9A40012D9A40012D9A40012D9
      A40012D9A40012D9A40011D9A30011D9A30011D9A30011D9A30011D9A30011D9
      A30010D9A30010D9A30010D9A30010D9A30010D9A30010D9A3000FD9A3000FD9
      A3000FD9A30027DCAA001DB481000000000000000000486D91007EB6E60081B4
      E100B5CCE000EAEDF000F3F6F900F5F7FA00F5F7FA00F5F7FA00DDC08500CFA2
      4600D0A54E00DDC08500DBBE8100C99E4500C6993D00C4973B00C2953900C093
      3700BE913500D0B47900F3F6F900F3F6F900F3F6F900F2F4F800E8EBEF00B3CB
      E00081B4E1007EB6E6006D91B600000000000000000000000000C6C08900C7C0
      8900C7C08900C7C08900373735004A493F008783610087836100878361008783
      61008783610087836100878361008884610088845F008A8660008A8660008A86
      600065624B002E2E2D002F2F2E007B775A00ADA77700ADA77700ADA77700ADA7
      7700ADA77700ACA676000000000000000000000000000000000059140600C094
      6200A56C3300A66E3600A66E3600A66E3600A66E3600A66E3600A66E3600A66E
      3600A66E3600B0866C00FCFDFC00DDCFCC00A66E3600A66E3600A66E3600A66E
      3600A66E3600A66E3600A66E3600A66E3600A66E3600A66E3600A66E3600A66E
      3600A56C3300BD8F5B0059140600000000001AB7840039DFAF0016DBA60016DB
      A60016DBA60016DBA60016DBA60015DBA60015DBA60015DBA60015DBA60014DB
      A60014DBA60014DBA60014DBA60014DBA60013DBA60013DBA60013DBA60013DB
      A60013DBA60013DBA60013DBA60013DBA60013DBA60013DBA50013DBA50013DB
      A50012DBA5002CDEAC001CB68300000000000000000000000000709DCA007EB5
      E5007EB4E4008BB6DC00C0D1E000E9EBED00F0F2F500F6F8FA00F4F3F000D6B2
      6700CDA04400CB9E4200C99C4000C79A3E00C6993D00C4973B00C2953900C093
      3700C9A45A00F2F1EE00F4F7FA00EFF1F400E7EAED00BFD0E0008BB6DC007EB4
      E4007EB5E50070A5D20000000000000000000000000000000000C6C08900C7C0
      8900C7C08900C7C0890039393600333333003333330033333300333333003333
      33003333330033333300333333003333330064624B008A86600087835E005251
      41002C2C2C003A393400918D6700ADA77700ADA77700ADA77700ADA77700ADA7
      7700ADA77700ACA676000000000000000000000000000000000059140600C296
      6400A9713700AA733A00AA733A00AA733A00AA733A00AA733A00AA733A00AA73
      3A00AA733A00B3886E00FCFDFC00DECFCC00AA743B00AA743B00AA743B00AA74
      3B00AA743B00AA743B00AA733A00AA733A00AA733A00AA733A00AA733A00AA73
      3A00A9713700C0925E00591406000000000018B88500CFF4E80090F9D90090F9
      D90090F9D90090F9D90090F9D90090F9D90090F9D90090F9D900F5F9F7001FDD
      A90019DCA70019DCA70019DCA70019DCA70018DCA70018DCA70018DCA7001DDD
      A900F5F9F70090F9D90090F9D90090F9D90090F9D90090F9D90090F9D90090F9
      D90090F9D900F5F9F7001AB784000000000000000000000000000000000075A8
      D1007FB5E6007FB6E6007CB2E00089B4D900B3CADE00DAE0E600E9EBEC00EBEA
      E600D7BB8100CB9E4300C99C4000C79A3E00C6993D00C4973B00C2953A00CFB3
      7A00E9E8E500E8EAEC00D9DFE500B3C9DD0089B4D9007CB2E0007FB6E6007FB5
      E60075ADD6000000000000000000000000000000000000000000C6C08900C7C0
      8900C7C08900C7C0890099956E00817D6000817D6000817D6000817D6000817D
      6000817D6000817D60006D6B550033333300605E4900817D5B00424138002C2C
      2C004A493D00A19B7000ADA77700ADA77700ADA77700ADA77700ADA77700ADA7
      7700ADA77700ACA676000000000000000000000000000000000059140600C499
      6600AD763C00AE783F00AE783F00AE783F00AE793F00AE793F00AE794000AE79
      4000AE794000B78B7100FCFDFC00E0D0CD00AF794000AF794000AF794000AF79
      4000AE794000AE794000AE794000AE794000AE794000AE793F00AE793F00AE78
      3F00AD773D00C2966100591406000000000017BA870017BA860017BB870017BA
      860017BA860017BA870018BA870017B9860017BA870018BA860017BA86002AE0
      AD001DDDA9001DDDA9001DDDA9001DDDA9001CDDA9001CDDA9001CDDA90028E0
      AD0018B9860019BA860018B9860018B9860018B9860018B9860018B9860018B9
      860019B9850019B9850019B98500000000000000000000000000000000000000
      00006FA1CD007FB5E5007FB6E6007FB6E5007CB2E0007AADD90090B6D800ACC6
      DD00C3D3E100D1D2CC00D4C29B00D3B98200D2B78100D1C09900CFD1CB00C3D3
      E100ACC6DC0090B6D8007AADD9007CB2E0007FB6E5007FB6E6007FB5E50076A7
      D300000000000000000000000000000000000000000000000000C6C08900C7C0
      8900C7C08900C7C08900C7C08900C7C08900C7C08900C7C08900C7C08900C7C0
      8900C7C08900C7C08900A29C7300333333004D4C3E00363531002C2C2C00615E
      4B00AAA47500ADA77700ADA77700ADA77700ADA77700ADA77700ADA77700ADA7
      7700ADA77700ACA676000000000000000000000000000000000059140600C69C
      6800B17C4200B27E4400B27E4500B27E4500B27F4500B37F4600B37F4600B37F
      4700B3804700BB8E7400FCFDFC00E1D0CD00B3804700B3804800B3804700B380
      4700B3804700B3804700B3804700B37F4700B37F4600B37F4600B27F4600B27E
      4500B17D4300C59A660059140600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000016BB870035E2
      AF0022DDA90021DDA90021DDA90021DDA90021DDA90020DDA90020DEA90033E2
      AF0016BB87000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005F8FAF0086BAE70088BAE70089BCE80089BCE80089BBE60086B7
      E10084B3DD0082B1D90081AFD70081AFD60081AFD60081AFD70082B1D90084B3
      DD0086B7E10089BBE60089BCE80089BCE80088BAE70086BAE7006F8FBF000000
      0000000000000000000000000000000000000000000000000000C6C08900C7C0
      8900C7C08900C7C08900C7C08900C7C08900C7C08900C7C08900C7C08900C7C0
      8900C7C08900C7C08900A29C7300333333002C2C2C002F2F2E007B775A00ADA7
      7700ADA77700ADA77700ADA77700ADA77700ADA77700ADA77700ADA77700ADA7
      7700ADA77700ACA676000000000000000000000000000000000059140600C89F
      6B00B5824900B6844B00B6844B00B7854C00B7854D00B7864D00B7864E00B886
      4E00B8874F00BF947800FCFDFC00E3D3CD00B8874F00B8875000B8874F00B887
      4F00B8874F00B8874F00B8874F00B8864E00B7864E00B7864D00B7854D00B785
      4C00B6834A00C99F6B0059140600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000014BC88003FE4
      B30026DEAB0026DEAB0025DEAB0025DEAB0025DEAB0025DEAB0024DEAB003CE3
      B20015BC88000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008BB7DB0098C5EB009AC5EB009AC5EB009AC5
      EB009AC5EB009AC5EB009AC5EB009AC5EB009AC5EB009AC5EB009AC5EB009AC5
      EB009AC5EB009AC5EB009AC5EB0098C5EB008DBAE20000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C08900C7C0
      8900C7C08900C7C08900C7C08900C7C08900C7C08900C7C08900C7C08900C7C0
      8900C7C08900C7C08900A49F75003333330039393400918C6600ADA77700ADA7
      7700ADA77700ADA77700ADA77700ADA77700ADA77700ADA77700ADA77700ADA7
      7700ADA77700ACA676000000000000000000000000000000000059140600CBA3
      6F00BA895100BB8B5300BB8B5300BB8C5400BC8C5500BC8D5600BC8D5700BD8E
      5700BD8E5700A7693B007C20020089361300BD8F5800BD8F5900BD8F5800BD8F
      5800BD8E5800BD8E5800BD8E5700BC8E5700BC8D5700BC8D5600BC8C5500BB8C
      5400BA8A5200CCA4720059140600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000013BE8A0046E5
      B5002ADEAB002ADEAB0029DEAB0029DEAB0029DEAB0029DEAB0029DEAB0045E5
      B50014BE89000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000093B2D100A9CDEE00ABCF
      EE00ABCEED00ACCFEE00ACCFEE00ACCFEE00ACCFEE00ACCFEE00ACCFEE00ABCE
      ED00ABCFEE00A9CDEE0093B7D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C7C08800C6BF
      8800C7C08900C7C08900C7C08900C7C08900C7C08900C7C08900C7C08900C7C0
      8900C7C08900C7C08900C4BD87008B876600A19B7000ADA77700ADA77700ADA7
      7700ADA77700ADA77700ADA77700ADA77700ADA77700ADA77700ADA77700ADA7
      7700ADA77700AFA878000000000000000000000000000000000059140600CEA7
      7400BF905900BF925B00C0925C00C0935D00C0935E00C1945F00C1945F00C195
      6000C1956000C2956100C2966100C2966100C2966100C2966100C2966100C296
      6100C2966100C2956100C1956000C1956000C1945F00C1945F00C0945E00C093
      5D00BF915B00CFAA790059140600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000013BF8B004CE6
      B7002EDEAB002EDEAB002EDEAB002DDEAB002DDEAB002DDEAB002DDEAC004BE6
      B70013BF8B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000778899008FA6BE009EBAD300A0BBD000A0BBD0009EBAD3008FABBE007788
      AA00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C4BD
      8900C7C08800C6BF8800C7C08900C7C08900C7C08900C7C08900C7C08900C7C0
      8900C7C08900C7C08900C7C08900C7C08900ADA77700ADA77700ADA77700ADA7
      7700ADA77700ADA77700ADA77700ADA77700ADA77700ADA77700ACA67700AEA9
      7700B0A97C00000000000000000000000000000000000000000059140600D1AB
      7900C3986200C4996400C4996500C59A6600C59A6700C59B6700C59B6800C69C
      6800C69C6900C69C6900C69C6900C69C6A00C69C6A00C69D6A00C69C6A00C69C
      6A00C69C6900C69C6900C69C6900C69C6800C59B6800C59B6700C59A6700C59A
      6600C4986400D3B0800059140600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012C08C0050E7
      B80031DEAB0031DEAB0031DEAB0031DEAB0031DEAB0030DEAB0030DEAC004FE7
      B80012C08C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C8C08900C6C08800C7C08900C7C08900C7C08900C7C08900C7C0
      8900C7C08900C7C08900C7C08900C7C08900ADA77700ADA77700ADA77700ADA7
      7700ADA77700ADA77700ADA77700ADA77700ADA77700AEA97700AFAB79000000
      000000000000000000000000000000000000000000000000000059140600D3AF
      7E00C79D6A00C79E6A00C89E6B00C89F6C00C89F6C00C89F6D00C8A06D00C8A0
      6D00C8A06D00C8A06D00C8A06D00C8A06D00C8A06D00C9A06D00C9A06E00C9A0
      6E00C9A06E00C9A06E00C9A06E00C9A06D00C8A06D00C8A06D00C89F6D00C89F
      6C00C79E6B00D6B4860059140600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000011C28C0053E8
      B90035DDAB0035DDAB0034DDAB0034DDAB0034DEAB0034DEAB0034DEAB0053E8
      B90011C18C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00C6C08800C6BF8900C7C08900C7C08900C7C0
      8900C7C08900C7C08900C7C08900C7C08900ADA77700ADA77700ADA77700ADA7
      7700ADA77700ADA77700ADA77700AEA87600AFA97800FFFF0000000000000000
      000000000000000000000000000000000000000000000000000059140600D6B4
      8600CCA67600CDA77600CDA77800CEA87900CEA97A00CEA97A00CEAA7B00CFAA
      7C00CFAA7C00CFAB7D00CFAB7D00CFAB7E00CFAB7E00CFAB7E00CFAB7D00CFAB
      7D00CFAB7D00CFAA7C00CFAA7C00CEAA7B00CEA97B00CEA97A00CEA87900CDA8
      7800CDA67600DABB900059140600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000FC38D0054E9
      BA0037DDAB0037DDAB0037DDAB0037DDAB0037DDAB0037DDAB0037DDAB0054E9
      BA0010C28D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D4D47F00C6BF8900C6C08900C7C0
      8900C7C08900C7C08900C7C08900C7C08900ADA77700ADA77700ADA77700ADA7
      7700ADA77700ACA77600B0A97700AAAA7F000000000000000000000000000000
      000000000000000000000000000000000000000000000000000059140600DEC3
      9C00E2CAA800E4CEAE00E7D2B500E9D7BD00EBDBC300EDDECA00EFE2CF00F1E5
      D400F2E8D900F3EADD00F5ECE000F5EEE300F6EFE500F6EFE400F5EDE100F4EB
      DE00F3E9DB00F1E6D700F0E3D200EEE0CC00ECDDC700EAD9C000E8D5B900E5D0
      B200E3CBAA00E3CCAC0059140600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000EC38E0079ED
      C8003ADCAB003ADCAB0039DCAB0039DCAB0039DCAB0039DCAB0039DDAB0079ED
      C8000FC38E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBF8F00C6BE
      8700C6BE8800C7C08900C7C08900C7C08900ADA77700ADA77700ADA77700ADA7
      7600AEA87700B4A5780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000591406005914
      0600591406005914060059140600591406005914060059140600591406005914
      0600591406005914060059140600591406005914060059140600591406005914
      0600591406005914060059140600591406005914060059140600591406005914
      0600591406005914060059140600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000EC48F00F5F9
      F70090F9D90090F9D90090F9D90090F9D90090F9D90090F9D90090F9D900F5F9
      F7000FC48F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C7BF8700C5BF8700C5BF8800C7C08900ADA77700ABA57600ADA77600AFA7
      7700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000EC48F000EC4
      8F000EC48F000EC48F000EC48F000EC48F000EC48F000EC48F000EC48F000EC4
      8F000EC48F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C5BB8600C2BB8600ACA67500A9A57600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000600000000100010000000000000600000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFF07FFFF0000000000000000FFE007FFFE01FFFF0000000000000000
      FF0000FFFC007FFF0000000000000000FE00007FFC007FFF0000000000000000
      FC00003FFC007FFF0000000000000000F800001FFC003FFF0000000000000000
      F000000FFC0000FF0000000000000000F000000FFC00007F0000000000000000
      E0000007F800003F0000000000000000E0000007F000003F0000000000000000
      E0000007F000001F0000000000000000C0000003F000001F0000000000000000
      C0000003F000001F0000000000000000C0000003F000000F0000000000000000
      C0000003F000000F0000000000000000C0000003F000000F0000000000000000
      C0000003F000000F0000000000000000C0000003F000000F0000000000000000
      E0000007F000000F0000000000000000E0000007F000000F0000000000000000
      E0000007F800000F0000000000000000F000000FF800000F0000000000000000
      F000000FF800000F0000000000000000F800001FFC00000F0000000000000000
      FC00003FFC00001F0000000000000000FE00007FFE00003F0000000000000000
      FF0000FFFE00003F0000000000000000FFC003FFFF0000FF0000000000000000
      FFF81FFFFFC001FF0000000000000000FFFFFFFFFFF007FF0000000000000000
      FFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF001FFFFC7FFFFFF81FFFFFE007FFFF00000FFFF81FFF
      FFC003FFFF0000FFFC00000FFFF81FFFFF0000FFFE00007FE000000FFFF80FFF
      FE00007FF800003FC000000FFFF80FFFFC00003FF800001FC0000007FFF80FFF
      F800001FF000000FC0000007FFF81FFFF000000FE0000007C0000007FFF81FFF
      F000000FE0000007C0000007FFF01FFFE0000007C0000003C0000007FFE01FFF
      E0000007C0000003C0000003FFC01FFFC0000007C0000003C0000003FF80001F
      C000000380000001C0000003FE00000FC000000380000001C0000007F800000F
      C000000380000001C000000FE000000FC000000380000001E000000FC000000F
      C000000380000001F800000FC0000007C000000380000001FE00000FC0000003
      C0000007C0000003FF80001FC0000003E0000007C0000003FFC03FFFC0000003
      E0000007C0000003FFE01FFFC0000007F000000FC0000003FFF01FFFC0000007
      F000000FE0000007FFF01FFFC0000007F800001FE000000FFFF81FFFC0000007
      FC00003FF000001FFFF81FFFC0000007FE00007FF800003FFFF81FFFC000000F
      FF0000FFFC00007FFFF81FFFE000000FFFC003FFFF0000FFFFF81FFFFC00000F
      FFF00FFFFFE007FFFFF81FFFFF00000FFFFFFFFFFFFFFFFFFFFC7FFFFFFF801F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3FFF
      C0000001FFC003FFFFFFFFFFFFF00FFFC0000001FFC007FFFFFFFFFFFFC003FF
      C0000001FFC007FFFFFFFFFFFF8001FFC0000001FFC007FFFFFFFFFFFE00007F
      C0000001FFC007FFFFFFFFFFF800001FC0000001FFC007FFFFF81FFFE0000007
      C0000001FFC007FFFF8001FFC0000003C0000001FFC007FFFE00007FC0000003
      C0000001FFC007FFF800001FC0000003C0000001FFC007FFE0000007C0000003
      C000000100000001C0000003C0000003C00000010000000180000001C0000003
      C00000010000000100000000C0000003C00000010000000100000000C0000003
      C00000010000000100000000C0000003C00000010000000100000000C0000003
      C00000010000000180000001C0000003C00000010000000180000001C0000003
      C000000100000001C0000003C0000003C000000100000001E0000007C0000003
      C000000100000001F000000FC0000003C0000001FFC007FFF800001FC0000003
      C0000001FFC007FFFE00007FC0000003C0000001FFC007FFFF8001FFC0000003
      C0000001FFC007FFFFF00FFFE0000007C0000001FFC007FFFFFFFFFFF800001F
      C0000001FFC007FFFFFFFFFFFC00003FC0000001FFC007FFFFFFFFFFFF0000FF
      C0000001FFC007FFFFFFFFFFFFC003FFC0000001FFC007FFFFFFFFFFFFF00FFF
      FFFFFFFFFFC007FFFFFFFFFFFFFC3FFF00000000000000000000000000000000
      000000000000}
  end
  object Hyperlinks: TPopupMenu
    Images = AboutBox.ImageList1
    Left = 1152
    Top = 216
    object Openhyperlink1: TMenuItem
      Caption = 'Open hyperlink'
      Hint = 
        'Open the current version of the original article in the web brow' +
        'ser'
      ImageIndex = 128
      OnClick = Openhyperlink1Click
    end
    object Openparsed1: TMenuItem
      Caption = 'Open parsed'
      Hint = 
        'Open the original article using Zander Parser (e.g. to strip adv' +
        'ertising)'
      OnClick = Openparsed1Click
    end
    object N41: TMenuItem
      Caption = '-'
    end
    object Gotoroot1: TMenuItem
      Caption = 'Go to origin'
      Hint = 
        'Go to the element that is the origin of the current element in i' +
        'ncremental reading (parent or root article)'
      ImageIndex = 12
      OnClick = Gotoroot1Click
    end
    object Changeroot1: TMenuItem
      Caption = 'Change origin'
      Hint = 
        'Mark a selected element as the origin of the current element (e.' +
        'g. to be used with "List sources" in the browser)'
      OnClick = Changeroot1Click
    end
    object Resetroot1: TMenuItem
      Caption = 'Reset origin'
      Hint = 
        'Reset the origin element of the current element (it will become ' +
        'inaccessible)'
      OnClick = Resetroot1Click
    end
  end
end
