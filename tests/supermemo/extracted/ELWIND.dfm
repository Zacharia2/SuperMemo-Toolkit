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
    Width = 320
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
    Width = 222
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
    Width = 164
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
      494C01010A001800040040004000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000000010000C000000001002000000000000000
      0300000000000000000000000000000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000004D00B30A1E00
      87112B008E124900A40EFF00FF02000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000100001E11000000040000620D6A00D50C4D00
      990A000000000000000000000000000000000000000000000000000000000000
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
      0000AA00AA03431CA62E3822A35B3123A1822E2399AD2D259BC630259EE12E23
      9CEB2F249CED2F239CE731239BD22C2298BE30249CAA292395823824A3563920
      9F28800080020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005500
      AA03293D56502838579E343F5ED22E3556EB606B84D5595D81E44C4E7AE34C54
      7EDE455275C92F4562912636495000101F310000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000331FA3322C23
      9D8A2D2599D130269EFD3629ADFF382CB3FF382FB1FF3831B2FF3733B3FF3833
      B3FF3834B3FF3732B2FF3731B1FF3730B0FF372DB0FF362CB0FF3427A9FF3022
      9EFA2E1F99D1301F9B85361B9D2F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000A1D2C342041
      45C938535CFF92A4B3FFA8BCC7FF8B9DA7FFD5E6EBFFC9DADEFF849AA5FFB0C3
      CEFFB1C3D1FF6C8699FF5F7688FF4E6777FF2C4152C315042B3C000000000000
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
      00000000000000000000000000000000000033249F553124A1BD2F259DFF342E
      AEFF3832B4FF3B37BBFF3E3CC1FF3F3EC4FF403FC5FF4140C5FF4040C6FF4040
      C6FF3F40C5FF3F3FC4FF3F3EC3FF3E3CC1FF3E3CC1FF3D3ABFFE3B37BBFF3933
      B6FF372FB4FF342AADFF2E2299FE2E1E98BE331B965500000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001E234633475171EC95A8
      B7FFA2B3C0FFE0EDF2FFCDDEE5FFC0D0D8FFD5E4EBFFD5E4EBFFB9CAD3FFC2D2
      DBFFCFDFE7FEACBECBFE9FB2C2FFABBFD2FF697F98FF54647EFF262B439F0000
      140D000000000000000000000000000000000000000000000000000000000000
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
      00000000000000000000341EA43B30229DBE3428A7FF392FB3FF3D39BCFF4140
      C6FE4343CBFF4342CCFF4142C9FF4142C9FF4242C9FF4342C8FF4343C9FF4242
      C8FF4142C8FF4141C7FF4140C7FF4140C7FF403FC6FF403FC5FF403EC5FF403F
      C6FF403DC6FF3F3BC2FF3B34B9FF362DB0FF3424A4FF301E99C12E1B96380000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002B395524416271E9ADC1CFFFD6E3
      EDFEC7D5DFFFDDE9EFFFCFDFE6FFC6D4DCFFDAE7EDFFD7E5EBFFB7C8D2FFC2D1
      DAFFCADAE3FEB9CBD5FEA1B4C1FFB8CAD7FF95A8BCFF889FB7FF607B93FF1D2B
      42C033004D0A0000000000000000000000000000000000000000000000000000
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
      00001C1C8E0933249F8D30259EFF3731B2FF3D3BBFFF4242C9FE4345CCFF4345
      CCFF4446CCFF4546CDFF4446CDFF4547CDFF4547CDFF4547CEFF4547CEFF4547
      CEFF4446CCFF4446CCFF4346CCFF4245CAFF4344CAFF4343CAFF4243C9FF4142
      C8FF4040C6FF403FC5FF3F3EC5FF3F3DC4FE3B36B9FF352BABFF2E209AFD301F
      998A660099050000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000324D60AC86A0B2FFCBDAE3FFDBE6
      ECFFCEDCE3FEE2EFF4FFD8E6ECFFCCDAE0FEE1EEF2FFE0EFF3FFB8C7D0FEC5D3
      DCFED4E4ECFFB8CAD4FFB1C1CCFFBFD0DCFF9AAFC0FF7E94A9FF768EA8FF4258
      6FFF192031BA6600990500000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000002F1A
      87312E229ACD372AAEFF3C39BAFF4344CAFF4445CCFF4445CCFF4548CEFF4649
      D1FF474AD1FF474AD1FF474AD2FF474AD1FF474BD2FF474BD2FF474AD2FF474A
      D2FF474AD2FF4649D1FF4649D0FF4649CFFF4548CFFF4447CEFF4446CDFF4445
      CCFF4244CBFF4143C9FF4140C8FF403FC6FF413FC7FF403DC4FF3A32B6FF3325
      A7FF321B96C030108F2000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001C1C5E1B5C7485F3CAD8E4FFC7D5DFFFDCE6
      ECFFB5C5CFFFDAE6EBFEC0CFD7FE9EAEBAFFC9D7DFFEC3D3DBFE92A4B0FFA8B9
      C4FEBECCD5FF98ACBAFF9EB0BDFFC2D2DDFF95A9BBFF7E94A9FF788FA7FF5066
      7FFF192C3BFF15171F7B00000000000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000003A24A54F3122
      9EF13931B3FF4140C6FF4548CEFF4448CCFF454ACFFF464BD1FF474CD3FF484D
      D5FF484FD5FF494FD6FF494FD6FF494FD6FF494FD6FF494FD6FE494FD6FF494E
      D6FF494ED6FF484ED6FF484ED5FF484CD4FF474CD3FF464BD2FF464AD1FF4649
      D0FF4548CEFF4446CDFF4345CCFF4344CAFF4242C9FF4141C7FF4240C9FF3C39
      BEFF352AADFF2A1E94E829178938000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000F373F45849BA4FFE0EAF1FFB4C4CFFEC1D0
      DAFFA0B3C1FFA4B6C5FFABBECBFFB4C6D1FFB5C7D2FFAEC0CBFFB1C3CEFEAFC0
      CCFF9CAFBEFF98ACBCFF90A6B7FF99AEBEFF869CAFFF788EA3FE6F869CFF5269
      7FFF1E3542FF172631FA3712492A000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000002F249C623325A2FE3C34
      B9FF4446CCFF4548CFFF464AD0FF474CD3FF484ED5FF494FD7FF4A50D8FF4A51
      D9FF4B52DAFF4B53DBFF4B52DAFF4B52DBFF4C53DBFF4B53DBFF4B52DBFF4B51
      DBFF4B51DBFF4B51DAFF4B51D9FF4A50D9FF494FD8FF494ED6FF484DD5FF484C
      D4FF474BD3FF474AD2FF4549D0FF4547CFFF4546CDFF4444CCFF4242CAFF4241
      CAFF433EC9FF382FB2FF2C2095F0311A8F440000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000A34384E8FA6ABFFE6F0F7FFAEBFCCFFC3D2
      DCFFD5E2E9FFD3E0E8FFDAE7EDFFDCE9EFFFDDEAEFFFDCE9EEFFD6E4EAFFCEDE
      E5FFC6D6DFFFBDCED9FEBBCCD8FFAEC0CEFFA5B9C8FF889EB0FF6E859CFF5268
      7CFF162C38FF19343EFF12292B9A000000000000000000000000000000000000
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
      0000000000000000000000000000000000003421A05E3426A9FF3A37B7FF4548
      CFFE474AD1FF484DD5FF4950D6FF4A51D8FF4A52DAFF4B53DBFF4C55DCFF4C56
      DDFF4D56DEFF4D56E0FF4E56DFFF4E56DFFF4E57DFFF4E57DFFF4E55DFFF4E56
      DEFF4D55DEFF4D55DEFF4D55DDFF4D54DCFF4C52DBFF4B51DAFF4B51D9FF4A50
      D7FF494ED6FF484DD4FF484DD4FF484BD3FF474AD2FF4649D0FF4548D0FF4446
      CEFF4342CBFF413FC8FF3831B6FF2E1F9BF8371A993C00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000C363A42748A94FFE0EAF1FFCDDBE3FFDBE6
      ECFFDEEAEFFFDFEBF0FFDDEAEEFFDAE7ECFFD6E3EAFFD5E2E8FED0DFE6FFC4D4
      DDFFBECED8FFB9CAD4FFB5C6D2FFB3C4D0FFAFC0CEFF899EB0FF7D93A9FF364B
      5CFF0F2332FF1C3243FF0E2B25BC000000000000000000000000000000000000
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
      00000000000000000000000000002E2096383226A3F93D34BAFF4649D0FF484B
      D1FF4A4FD6FF4B51DAFF4B54DBFF4D55DDFF4D56DEFF4E57E0FF515CEBFF4F5B
      E4FF4E5AE2FF4F5AE3FF5059E3FF505AE4FF505AE3FF4F5AE3FF5059E3FF5059
      E3FF5059E2FF5058E2FF4F58E1FF4F57E0FF4E56DFFF4D55DDFF4C54DDFF4C53
      DBFF4A52DAFF4A52DBFF4B51DBFF494FD7FF494ED6FF494DD5FF484BD4FF4649
      D2FF4646CFFF4443CDFF4441CEFF3A32B9FF2C209BE9331A991E000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004E558724556A7DF7D3E0E6FFD7E5EAFFDBE8
      EDFFDDEAEFFEDEEAEFFFDBE8EDFFD8E6EBFFD3E1E7FFCFDEE4FFC6D6DFFFB9CA
      D4FFB4C6D1FFAFC1CCFFA9BBC8FFA9BBC8FF9FB2C1FF7B92A5FF778DA1FF1F34
      44FF132838FF172F3EFF1E2D42CEFF00FF030000000000000000000000000000
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
      000000000000000000002D0F961130249EE03A33B5FF474AD2FF494ED3FF4B50
      D7FF4C54DAFF4E56DDFF4E58DEFF4F59E1FF4F5CE3FF505EE5FE4450B5FE5465
      E7FF5262EEFF505EE5FF525EE6FF525EE7FF515EE6FF515EE6FF515DE6FF515D
      E6FF515DE5FF515CE5FF515BE3FF505BE3FF505AE2FF4F59E1FF4E59E1FF4D57
      DEFF4E5AE7FF4E5ADDFE4851CBFF4D57DEFF4C53DBFF4B51D9FF4A4ED8FF494C
      D6FF484BD4FF4648D1FF4544CEFF4542CEFF3A2FB8FF2B1E93C9660099050000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009955EE0F4B637DECBBCAD3FFDCE9EEFFDDE9
      EEFFDAE8EDFED9E8EEFFD6E4EBFFCFDEE5FFD1E2E9FFDCEDF4FFCBDDE7FEAEC1
      CDFFABBECAFFACBECAFFABBCC9FFAABBC9FF8CA1B1FF778DA0FF8095A9FF2439
      49FF122839FF22384AFF33435CFE333A5BD02339518A1D2C4A34000000000000
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
      0000000000000000000032229FA4382DB6FF4648CFFF4A4ED6FF4B51D8FF4D54
      DDFF4F58DFFF4F5AE2FF505BE3FF515DE5FF515FE7FF5868F7FF2C3458FE2A30
      48FF5362DAFF586AFDFF5361EDFF5361EAFF5361EAFF5361E9FF5361E9FF5360
      E9FF525FE8FF525FE8FF525EE6FF525DE6FF515DE5FF4F5CE4FF4F5CE5FF5462
      F5FF4F5BD3FF242839FE3A418DFF525EF0FF4E56DEFF4D54DDFF4C52DCFF4B4F
      DAFF4A4FD9FF484CD6FF4748D2FF4645D0FF4740D0FE372AB2FF2D1994830000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000036465D423E596CFBB0BECAFFDDEAF0FFDBE8
      EDFFDEEBF0FFDDE8EEFFDBE9EFFED0E1EAFFAFBEC6FF6F7B82FE95A1A8FEB3C6
      D2FEA3B6C3FFB0C2CDFFB1C2CEFF9CAFBDFF8096A7FF7C91A3FF869BACFF7489
      9BFF5E7285FF6C8093FE7A90A3FE778FA2FF5F7C92FF3E596BFF355362B82637
      623C000000000000000000000000000000000000000000000000000000000000
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
      00000000000034219D4E3327A4FF4341C6FF4C52DAFF4B52D9FF4E56DEFF4F59
      E1FF515BE3FF515EE5FF515FE6FF5361E8FF5364EAFF5769F7FF5363CCFF1B1E
      11FE24292DFE414E95FF586CEAFF5A70FEFE5569F5FE5366EEFF5364ECFF5463
      EBFF5362EAFF5361E9FF5361E9FF5261EAFE5366F1FE576AFAFE5667EBFF404C
      99FF222625FF23272AFE5460E3FF505CE8FF4F59E3FF4F57E1FF4E55E0FF4D54
      DDFF4D53DCFF4B51DAFF494DD6FF4749D1FF4747D3FF423EC9FF2F21A4FB2F18
      A02B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000E004712373D607036435FE462768CFFCAD6DFFFDAE7EBFFDDEB
      EFFFD3DDE3FF526470FE758691FFADBDC7FF3E5361FF152A37FF0D1E25FF8C9A
      A3FEA7BBCAFFADBFCBFFB9C9D4FF96ABB9FF859CABFF879CACFF879CABFF8A9E
      AEFF899EAFFF899DAEFF879CAEFF889DAFFF899EB2FF889DB0FF768EA3FF4F67
      83FF395366A2091A231D0D343B270F4444441726442200000000000000000000
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
      0000663399053222A0D53C35BAFF4E53DDFF4C52D9FF4E56DEFF505AE2FF515C
      E5FF535EE7FF5460E9FF5462E9FF5563EBFF5666EEFF5567EFFF6075FFFF4553
      94FE1C2111FF1F241AFE29303DFF404D8BFF5162CEFF596DEFFE5C6FFBFF5B6F
      FFFF5A6CFEFF5A6CFDFF5A6BF8FF5768EAFE4F5EC7FE3D498AFE2A3144FF1E23
      16FF1C2015FF4E5BB9FE5765F9FF515DE7FF525CE6FF515AE5FF5058E3FF4F57
      E1FF4E56DFFF4D54DDFF4C50DBFF4A4DD7FF4748D3FF4747D5FF3B33C1FF2D1D
      9EAE000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000030365F4B385463DE5E6F86FF77859CFFAFBDCAFECDD9E1FFD8E5E9FEE8F4
      F8FFA0ACB3FF27424EFF334E5BFF3A5261FF405868FF273E4AFF051A22FF4754
      5AFFAFC1CEFEA7BAC6FEBECED8FFA7BAC6FF8299A8FF8EA2B2FF93A6B5FF9AAC
      BAFFA2B4C1FFA9BAC7FFACBCC9FFA7B8C5FF9DAEBEFF8FA2B3FF8EA1B5FF869A
      AFFF597A8DFF385C66F03D6272F5496F83FF44677AF52F515FC211333A4B0000
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
      00003621A2633829AEFF484CD2FF4D55DDFF4E56DEFF505AE2FF525DE5FF535F
      E7FF5461EAFF5563ECFF5565EDFF5766EEFF5768F0FF576AF1FF576DF4FF6076
      FEFE404D83FF1E2419FF222922FF20261EFF23292AFF2D354AFF37446CFF3E4C
      85FF3E4B87FF3C4984FF344065FF2B3346FF222827FF1F261EFE20261BFF1F25
      20FF4653A0FF5C6FFFFF5361EBFF5361EAFF535FE9FF535DE8FF525CE6FF505A
      E4FF5058E3FF4F56E1FF4D53DEFF4C50DBFF494CD7FF474AD5FF413FCAFF3322
      A5FF401BA8380000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002A34
      6331414F69F899ABB9FFC1CED8FFCAD9DFFECCD9E0FECCD8DFFFD3E0E5FEE7F3
      F7FFA3AEB4FF2C4654FF435A6AFF3C5463FF38505EFF1E333DFF081B23FF434C
      51FFB3C3CFFEA4B6C4FEB7C8D3FFB9CAD4FFAEC1CBFFBACAD4FFC4D4DCFFCBDA
      E1FFCEDBE2FFCAD8E0FFC7D5DDFFC4D3DCFFBECED7FFAFC1CCFF9CAFBDFF92A6
      B6FF7E95A7FF5E778EFF5A708BFF637895FF6C849EFF6A85A0FF426075FF1A37
      4191000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000008000
      FF0431249DD74139C0FF5056E0FF4E56DEFF505AE2FF525DE6FF535FE8FF5462
      EAFF5664ECFF5765EEFF5767EFFF5768F0FF586AF2FF586BF3FF576DF3FF576E
      F6FE6178FEFE4C5DA7FF252D32FF1E251CFF262E2EFF252D2BFF212823FF2026
      1DFF21271CFF20281DFF212923FF242C29FF242D2AFF1E231AFF2C3447FF5365
      C6FF5D73FEFE5568F1FE5564EFFF5563EDFF5561ECFF5460EAFF535EE9FF525C
      E7FF525BE6FF5059E4FF4F56E1FF4D53DEFF4B4FDBFF494BD7FF4949D7FF3B32
      BBFF2D1A98A40000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000400080043552
      64C9A1AFBCFFD4DDE7FEC4D2DAFEC7D4DBFFCAD7DEFECDDAE0FFD0DEE3FEE1ED
      F2FFC2C9CFFF2F4651FF3E5565FF3A505FFF314754FF192D36FF04161DFF646E
      74FFB2C4D1FEA6B8C5FFB7C9D3FFBECFD8FFCCDBE3FFD0DEE5FFD2E0E6FFD2E0
      E6FFCFDDE4FFCDDBE2FFCAD9E1FFC8D7DEFFC5D4DCFFC1D0D8FFBACAD4FFA8BA
      C6FF9AACBCFF8599ACFF6E8198FF5D728BFF60778FFF6A819AFF7189A4FF4D6B
      7FFF1E3941980000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000000000351E
      A0433227A3FF4A4CD2FF5056DFFF525AE2FF535DE6FF5460E9FF5563EAFF5665
      EDFF5867EFFF5868F1FF5869F2FF596BF3FF596CF3FF596DF4FF596FF5FF596F
      F5FF586FF7FF6079FFFF5C74E3FF3C4A78FF252D2EFF1F261CFF202721FF232A
      26FF242B28FF222A25FF20261DFF1F251CFF283038FF44528DFF5E73F6FF5C72
      FFFF5769F2FF5769F2FF5767F1FF5766F0FF5664EEFF5563EDFF5561EBFF545F
      EAFF535DE8FF525CE6FF5059E3FF4F56E1FF4D52DEFF4B4FDAFF4A4BD7FF4441
      CCFF2F1F9FF53512A71D00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002B235241727F
      92FFDCE7EDFFCCDAE0FFCDDAE0FFD1DEE3FFD4E0E5FFD2DFE4FFD1DEE2FFD7E4
      E9FFE9F1F4FF53636BFF2D4453FF334956FF2A3F4AFF162931FF091A1FFF939D
      A4FFAABFCCFFA7B9C6FFB8CAD3FFC0D0DAFFCDDCE3FFD2E0E6FFD1DFE5FFD1E0
      E6FFD5E4E9FFD4E3E9FFCCDBE2FECAD8E0FFC6D5DDFFC3D3DBFFC2D1D9FFBCCC
      D5FFA6BAC6FF98AEBBFF94A9B7FF869BACFF6F8698FF627A8FFF687E96FF768C
      A6FF526B82FF2237489400000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000000000291F
      939A3B36B8FF5157E1FF5057E0FF535CE5FF5460E8FF5562EBFF5665EDFF5767
      EFFF5968F0FF5A6AF2FF596CF3FF5A6CF5FF5A6EF5FF5A6FF6FF5970F5FF5A70
      F7FF5A71F8FF5971F8FF5C76FFFF637FFFFF5D74E2FF4C5DA6FF3C4979FF323E
      59FF323C57FF35405EFF414E84FF4F60B1FE5F76EDFF627BFFFF596FF9FF586D
      F5FF596BF4FF586AF3FF5768F2FF5767F2FF5666F0FF5665EEFF5663EDFF5561
      ECFF545FEAFF535DE9FF515AE6FF5058E3FF4F55E1FF4D52DDFF4A4CD8FF4B4C
      DAFF3D2EBCFF2E18956A00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002031497EA9B1
      C1FFDFEAEFFFD4E1E5FFD8E3E8FFDCE7EBFEDBE7EBFED9E6EAFFD6E3E8FFD7E3
      E8FFF0FBFFFFA0A9ADFF1D323EFF2E4450FF223641FF0C2028FF2C393DFFB8C5
      CDFE9BB0BEFFA8BBC7FFB8CAD4FEC0D0D9FFCCDBE2FFD1E0E7FFDEE9EFFFDEEA
      EFFED5E1E6FFD2DFE5FFE1ECF2FFD1E0E7FFC3D4DBFFC2D2DBFFC0D0D9FFBFCF
      D7FEBDCDD5FFB1C2CDFFA3B6C3FF9CB0BEFF98ACBBFF8A9FB0FF758A9FFF6B81
      98FF798DA7FF425E6DFF13303A4F000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000008000AA062F20
      99DA4544C9FF525AE5FF515AE3FF545FE8FF5563EAFF5765EDFF5767EFFF5869
      F1FF596BF2FF5A6CF4FF5A6DF4FF5A6EF5FF5A70F7FF5B70F7FF5B70F7FF5A71
      F7FF5A72F8FF5A72F8FF5A73F8FF5A73F8FF5C75FFFF617AFFFF637DFFFF617B
      FFFF6179FFFF627AFFFF637BFFFF6078FFFF5A72FDFF5A70F7FF5A70F7FF5A6F
      F6FF596DF5FF586DF4FF586AF3FF5869F2FF5768F1FF5667F0FF5665EFFF5663
      EEFF5462EDFF535FEAFE535DE9FF525AE6FF5057E4FF4E54DFFF4C4FDBFF4D50
      DEFF423BC6FF2E1C92BE00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000039425B87BEC5
      CEFFE7F1F3FEDDE8EBFEDEE9EDFFE6F0F3FEEEF7F9FFE7F1F4FEDCE9ECFFD9E7
      EAFFDFEBF0FFE0E9ECFE3E4E57FF1F3842FF1E323AFF011218FF727C80FEB8CB
      D5FE97AAB8FFACBDC9FEB8C9D2FFBECED8FFD0E0E5FFD4E2E8FFA9BAC3FF7188
      96FF5C7384FF536B7CFF768A95FFCDD7DDFFCFDEE6FFBACBD4FEBDCDD6FFB9CA
      D3FEB6C8D0FEB9CAD3FFB7C9D4FFADC1CCFEA3B7C3FF9FB4C2FFA7B9C6FF768C
      9EFF73899FFF768DA7FF2B4759E8000C0C150000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000331C9F2D3327
      A4FD4D50D8FF5259E4FF535CE6FF5560E9FF5764ECFF5867EFFF5969F1FF596B
      F2FF5A6CF4FF5A6DF5FF5A6EF6FF5B6FF6FF5A70F7FF5A71F8FF5B71F7FF5B72
      F8FF5B73F8FF5B73F9FF5B74F9FF5B74FAFF5B75FAFF5B74F9FF5B74FAFF5B74
      FBFF5B73FAFF5B73FAFF5B73F9FF5B73F9FF5B72F8FF5B71F8FF5B70F7FF5A70
      F7FF596EF6FF596CF4FF586AF4FF586AF4FF5869F3FF5868F2FF5866F1FF5765
      F0FF5663EFFF5562EDFF555FEBFF545DE8FF525AE6FF4F56E2FF4D51DEFF4D50
      DEFF4946D2FF2D1E9AF1360DAE13000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003B436482B1BB
      C6FFECF6F9FFE1EBEFFFE8F1F4FFCFDCE0FFBBC8CFFED5DFE3FFF0F8FBFFEBF6
      F9FFD9E6EBFFF0FBFEFE98A0A5FF0C1F27FF152931FF1A272BFFB9C5CBFEA2B7
      C2FF9CAFBCFFAEC0CCFFB4C6D0FFC4D4DDFFB5C6D0FF718A99FF506E7EFF4C68
      79FF496274FF425B6CFF2F4B5AFF3B4F5BFFBEC9CEFEC5D6DFFEB4C5CFFFA9BC
      C7FFACC0CAFF9BAFBAFF93A9B6FF9CB1BEFFAABDC9FFACBFCBFFA6B9C6FF738A
      9CFF697F95FF8196AFFF5A758EFF1B323C840000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000033209C5F382D
      B0FF4F56DEFF525AE3FF545FE7FF5662EBFF5765EEFF5868F0FF596AF1FF5A6C
      F3FF5A6DF5FF5B6EF5FF5B6FF6FF5A70F7FF5A71F7FF5A72F8FF5A73F8FF5A73
      F7FF5A73F8FF5B74F9FF5B74F9FF5C75FAFF5C76FAFF5D75FAFF5C74FAFF5C74
      FAFF5C74FAFF5C74FAFF5C73F9FF5C72F8FF5B72F8FF5B71F7FF5B70F7FF5A70
      F6FF596EF5FF586DF4FF576BF3FF576BF3FF586AF3FF5869F3FF5868F2FF5767
      F1FF5765F0FF5663EEFF5561ECFF535EEAFF525BE7FF5058E4FF4F54E0FF4C51
      DCFE4D4EDCFF3327A7FF30189B40000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002D3663558691
      A3FFEFF7F9FFEAF3F7FFC8D2DAFF557183FF4D687BFF4F6778FF6D808BFFB5BE
      C4FFF0F9FBFFE4F1F5FEEDF6F7FF4B5458FF00070AFE7A8083FECADAE2FF94A8
      B5FFA0B3C0FFABBEC9FFB7C8D1FFA4B6C2FF5D7588FF5A7285FF586F80FF4961
      71FF3A5161FF344B5AFF314655FF182F3EFF515E66FFD9E4EBFFADBFCBFF99AD
      BBFF576F80FF3C5869FF476477FF547084FF728A9CFF899FAFFF8398A9FF6A82
      95FF697F92FF71879CFF8095ADFF304758EC2211330F00000000000000000000
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
      000000000000000000000000000000000000000000000000000035229F953E35
      BBFF525BE4FF525CE4FF5560E8FF5763EDFF5866EFFF5968F0FF5A6BF2FF5B6C
      F4FF5A6EF5FF5B70F6FF5A70F7FF5A71F7FF5971F7FF5972FAFF5A74FFFF5A76
      FFFF5974FCFF5972F8FF5A74F9FF5B75FAFF5C75FAFF5D75FAFF5D75FAFF5C75
      FAFF5C75FAFF5C74FAFF5C73F9FF5C72F9FF5B72F8FF5A72F8FF5970F6FF586F
      F6FF596FFBFF5A70FDFF596EFAFF576BF3FF586AF2FF586AF3FF5869F3FF5768
      F3FF5866F1FF5765F0FF5562EEFF5560EBFF525CE8FF515AE6FF5056E2FF4D53
      DEFF5054E3FF3A31B8FF2B159A77000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000043367913525E
      75EDDCE5E8FFF4FCFDFE99AAB5FF547182FF5E7889FF516A7CFF365162FF243E
      4CFF808E95FEEEF8FAFEE8F4F8FEDAE2E5FFB1B6B8FEE8EEF2FEB8C9D2FE94A8
      B5FEA2B5C2FFABBEC9FFAABCC7FF5D7787FF51697BFF4D6476FF425A6AFF364E
      5EFF2B4251FF243C4AFF1F3541FF19303BFF12242DFFB8BFC4FEC1D2DCFF7188
      96FF375262FF546D7DFF5E7789FF627B8DFF688193FF698294FF6D8597FF7087
      99FF6E8498FF677E92FF90A3B9FF556F82FF1A2C406300000000000000000000
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
      00000000000000000000000000000000000000000000000000002E1F9ABB453D
      C4FF545EE7FF545DE6FF5561EAFF5764EDFF5867EFFF5969F0FF5A6CF2FF5B6D
      F4FF5A6FF5FF5B70F6FF5A71F7FF5870F6FE5B78FFFF5A75F3FF5168D1FF4E65
      C9FF556FE4FF5D7AFFFF5A74FCFF5A74F8FF5B74FAFF5C75FAFE5C75FAFF5C75
      FAFF5C75FAFF5C74FAFF5B73F9FF5B72F8FF5A73F7FF5971F5FF5973FDFF5C76
      FBFE5168D2FF4D61C0FF5167D4FF5A73F9FF5870FCFF556BF2FF586BF4FF586A
      F3FF5869F3FF5767F1FF5663EEFF5561ECFF545EEAFF525BE7FF5159E4FF4E54
      E0FF5157E6FF403AC3FF271A95A9000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002246
      5A8E9DAFBAFFF3FBFDFE7A91A1FF5D778AFF566F81FF4B6476FE405A6AFF354E
      5DFF19313EFF99A2A8FFEBF6FAFFE6F1F6FEEFFAFEFEE5F0F3FEC2D1D8FF99AC
      B8FFA4B6C2FEB2C4CEFF738897FF435B6CFF465C6CFF3D5464FF38505FFF2E45
      55FF253C4AFF1E3541FF182D39FF152A34FF041922FF8E999FFFD1E0E9FF6B81
      90FF4B6474FF698090FF6D8594FF6F8697FF71899AFF73899BFF73899AFF7188
      9AFF708799FF677E92FF8298ACFF7A91A5FF223C4DCD55005503000000000000
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
      000000000000000000000000000000000000000000006600CC0531219AD74945
      CCFF555EEAFF555EE8FF5662EBFF5764EEFF5867EFFF596AF1FF5A6CF2FF5A6D
      F4FF5A6FF6FF5A71F6FF5970F7FF5E77FFFF495CADFF29323FFF222928FF2228
      26FF242C2FFF3A497BFF5B75EFFF5A74FBFF5A74F9FF5B75FAFF5C74FAFF5C74
      FAFF5C75FAFF5B74F9FF5B73F9FF5A72F7FF5971F5FF5A73FCFF566DDCFF323C
      5BFF222925FF212723FE232928FF303955FF5164CDFF5A71FFFF576AF3FF586A
      F4FF5969F4FF5868F2FF5765F0FF5662EDFF545FEBFF535DE9FF515AE6FF5056
      E2FF5258E8FF4440C9FF291B92C3000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000221A
      551E6F7894F0BFD1D9FF597587FF526C7EFF435D6EFF3A5465FF334C5BFF2942
      4FFF1E3944FF31424AFFD2DCE0FFE0EDF1FEE1EDF0FEE2EDF1FEC7D5DCFFA5B6
      C1FFA9BBC6FFA1B4BFFF445C6CFF405968FF3A5262FF364E5DFF344B5BFF2A42
      51FF1F3644FF182F3BFF142A35FF122630FF00151DFE8B949AFED4E3EBFF7C92
      9FFF617787FF758A99FF768C9CFF778E9EFF778E9EFF778E9EFF778D9EFF758C
      9DFF73899CFF6E8598FF73899DFF91A6BAFF3A5566FE232D4133000000000000
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
      0000000000000000000000000000000000000000000030209F102E2195EC4C4E
      D1FF5660EBFF5660EAFF5763ECFF5866EEFF5868EFFF5969F0FF596CF2FF5A6D
      F3FF596FF4FF596FF4FF5D78FFFF495BA9FF1B2015FF222B24FF252F2EFF262F
      2EFF242D2AFF1C2212FF354161FF5D7AFAFF5974F9FF5B75F8FF5B74F9FF5C75
      F9FF5B75F9FF5B75F9FF5B74F8FF5A72F6FF5973F8FF5A73EDFF2A3343FF1F25
      19FF262E2DFF262E2EFF262E2DFF21271EFF212624FF4F63C7FF596EFBFF576A
      F3FF5869F2FF5868F2FF5866EFFF5764EEFF5561ECFF545EEAFF535BE7FF5158
      E4FF5358E7FF4744CBFF2E1E97DC5539C6090000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      FF0A7C7DA3E499AFB8FF3D5769FF3E5768FF395162FF2F4756FF273F4DFF1F37
      43FF1D343FFF0F212BFF9DA6ABFFE2F0F5FFE1ECF1FFDBE6EBFFBFCDD4FEACBC
      C5FFB0C1CBFF8196A2FF344D5CFF3D5564FF38505FFF344B5BFF2F4656FF263E
      4CFF1A313EFF142B37FF132935FF0A212CFF0F1B21FEB8C1C5FFCDDDE5FF8CA0
      ACFF6E8493FF7A909FFF7C92A2FF7D94A3FF7D93A3FF7C92A2FF7A90A1FF788F
      9FFF768D9FFF738A9CFF6C8497FF91A7BAFF5A7088FF2432477A000000000000
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
      000000000000000000000000000000000000000000004623B916312298EF4F52
      D6FF5661ECFF5761EBFF5764EDFF5866EFFF5868F0FF596AF0FF596CF2FF5A6D
      F3FF596FF3FF5970F8FF5A73ECFF273038FF232B25FF252E2FFF252E2FFF252E
      2FFF252E2EFF262F2DFF212721FF536BD3FF5A76FFFF5A73F8FF5A73F8FF5B73
      F8FF5A74F8FF5A74F8FF5A74F7FF5973F9FF5C77FFFF4F62C0FE1E231AFF272F
      2FFF262E2FFF262E2FFF252D2FFF262F2FFF20271AFF2F3853FF5C72FAFF566A
      F3FF5869F3FF5868F2FF5866F0FF5765EFFF5661EDFF545FEBFF545CE8FF5259
      E6FF5459E9FF4948D1FF2B1D97E730109F100000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003D57
      6E4F879FADFF899CACFF385163FF344D5EFF314958FF263E4DFF203844FF1A31
      3CFF182D38FF0B1D26FF88969EFFD4E3E9FFCDD9DFFFC6D3DAFFBFCCD3FFB0BF
      C8FFB5C6CFFF768B97FF314A5AFF39505FFF344B5BFF304857FF2B4353FF233A
      49FF192F3CFF142B37FF112835FF000B15FF687175FED2E0E7FFC8D7DFFF92A6
      B1FF758B9AFF7F94A4FF8096A6FF8197A7FF8298A6FF8096A6FF7E94A5FF7B92
      A2FF7A91A2FF768DA0FF6E8699FF8AA1B4FF738AA2FF24394DB6000000000000
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
      00000000000000000000000000000000000000000000491BBF1C32239BF35152
      D9FF5862EEFF5863EDFF5866EEFF5968F0FF5969F1FF5A6AF1FF5A6CF2FF5A6D
      F3FF596FF3FF5B72FDFF546BD1FF222927FF252E2EFF252E2FFF252E2EFF252E
      2FFF252F2FFF262E2DFF242C2DFF546BC9FF5972E8FF5D78FAFF5B77FEFF5873
      F5FE5A74F6FF5972F5FF5D77FEFE5D76F2FF566DE5FF5165BEFF242C2AFF252E
      2EFF252E2EFF252E2EFF262E2FFF252E2EFF242D2AFF262F32FF5A6FE4FF566B
      F5FF576AF1FF5769F1FF5867F0FF5764EFFF5662EDFF5560ECFF555DE9FF535B
      E7FF555AE9FF4B4BD5FF2B1F97EA2B2B9C120000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004F6E
      7B95A9BECAFF7E93A3FF395264FF2F4857FF2A424FFF213845FF1B323EFF172D
      37FF122933FF13242DFF9CABB4FEC2D2DAFFC1CFD6FFBDCAD2FFCAD6DCFFBFCD
      D4FFBACAD2FF81949EFF273E4BFF354C5AFF304958FF2D4656FF294151FF2239
      48FF1A313EFF0D232FFF00121CFF586267FFC4D3DAFFC4D4DBFFC6D5DCFF92A7
      B1FF798F9EFF8499A8FF859BAAFF869CABFF869CAAFF849BA9FF8298A8FF7F96
      A6FF7D95A5FF7B91A3FF738A9DFF8096AAFF899EB1FF333E59DF600060080000
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
      000000000000000000000000000000000000000000004C26C61B32239AF25253
      DAFF5862EFFF5863EEFF5866EFFF5968F0FF5969F1FF5A6BF2FF5A6BF2FF5A6D
      F3FF596EF3FF5970F8FF5A73E6FF252D31FE242C2AFF252E2FFF252E2EFF252E
      2EFF252F2EFF262F2EFF272E2FFF2A3139FF272D30FF2F394DFF5268C8FF5B78
      FBFF5A73F6FF5D77FCFF4F64C1FF2A313DFF252C30FF272F33FF252E2EFF252E
      2EFF252E2EFF252F2EFF252E2FFF252E2FFF242B28FF28313BFF5A70EBFF566C
      F4FF5769F1FF5869F1FF5867F1FF5765F0FF5763EEFF5660ECFF555EEAFF545B
      E8FF555BE9FF4B4CD6FF2C1F98E92D1EA5110000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF00FF01607C
      8AC8BFCFD8FF8599A7FF334C5DFF2D4656FF243C4AFF1D3541FF17303AFF0C25
      2FFF01151FFF627179FFB2C4CEFEC6D4DBFFCAD8DEFFBCC9D0FFCCDADEFFCFDC
      E1FFBBCBD2FFAABBC4FF465965FF1E3543FF233D4DFF223C4CFF1C3544FF1027
      36FF10232EFF313F47FF7D8A90FEC3D3DAFFC7D5DCFFC4D3DAFFC2D3DAFF8DA2
      ADFF7F94A2FF899EACFF8AA0AEFF8BA0AFFF8AA0AEFF889FADFF859CABFF839A
      A9FF8198A8FF7E95A6FF788FA2FF788FA3FF92A5B8FF3E4B64F8391C63240000
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
      000000000000000000000000000000000000000000003628AE13302498EE5355
      D9FF5965F1FF5864EEFF5966F0FF5A68F1FF596AF1FF5A6BF2FF596CF2FF5A6D
      F3FF596FF3FF586EF2FF5F7AFFFF3C4B81FE1F261DFF252E2EFF252E2EFF262E
      2EFF262E2FFF252E2DFF232A23FF1F2419FF1E2519FF151900FF3A4979FE6381
      FFFF5A75F8FF617DFFFF3C4B80FF161900FF1F2619FF1F261AFF212922FF252D
      2BFF262E2FFF262E2FFF262E2FFF252E2FFF20261EFF384476FE5C71FFFF5569
      EFFF576AF2FF5769F2FF5868F1FF5766F0FF5662EEFF5660EDFF555EEAFF545B
      E8FF565BE9FF4B4BD4FF301D97E34E27C40D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BF40FF046186
      8AD4C2D2D9FFABBDC7FF425B69FF1D3745FF152F3AFF0D2732FF071F28FE2335
      3BFF7B898FFEBBCBD4FECAD7DDFEDDE8ECFFD0DCE1FEC1CED4FFCBD7DDFFDBE5
      E9FED2DFE3FFB7C8D0FEAEBEC7FF768992FF5A6D79FF4F6471FF576872FF6A79
      83FF92A0A7FEB6C6CDFFC7D8DEFFCFDCE1FFCDDBE0FFC4D3D9FFBFCFD6FF8A9F
      ABFF899EABFF8FA4B1FF8EA4B1FF8EA4B2FF8EA4B1FF8CA2B1FF89A0AEFF879D
      ACFF849BABFF8197A8FF7D94A6FF798FA2FF92A4B9FF475A70FF20304C400000
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
      000000000000000000000000000000000000000000004020AF10302198EC5254
      D6FF5A67F2FF5965EFFF5A66F0FF5A68F1FF596AF2FF5A6CF2FF5A6CF3FF596D
      F2FF586DF3FF5C73FFFF5870EBFF3A4775FE212821FF252E2FFF262E2EFF2128
      22FF1E241CFF252D2FFF333E54FF415181FF485892FE4E62AFFF5C76E5FE5F7A
      FBFE5D77FAFF5D77FBFF5D75E8FE4D5FB3FF475795FF3F4E7FFF333E57FF262C
      2EFF1E241BFF222922FF272F2FFF262E2EFF212722FF435195FE5C70FDFF566B
      F5FF5668EFFF5769F1FF5868F1FF5866F0FF5763EFFF5661EDFF555EEBFF545C
      E8FF575CECFF4845CCFF2A188EC8FF00FF010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CC66FF055980
      82D5C2D2D8FFCCDBE2FEA3B6BFFF768993FF5D6C75FE617078FF89969DFFAFBE
      C5FFCBDAE0FFDEE8EBFFEEF6F8FEE3EEF1FFCFDBE0FEC7D3D8FFCDD9DEFEE1EB
      EEFEE9F2F5FFE1EBEEFFCEDADFFEC4D1D8FFBDCCD3FFB8C6CFFFBBCBD2FEC5D4
      DBFFC7D6DCFFD0DDE1FFDCE7EBFFD5E1E6FFCCDADFFFC2D1D7FFC0D0D7FF8EA3
      AFFF8CA2AEFE92A7B4FF93A7B4FF93A8B5FF92A7B5FF90A6B4FF8DA3B1FF8AA0
      AFFF889EADFF849BABFF8198AAFF7A91A4FF94A6BBFF506679FF2E3653590000
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
      00000000000000000000000000000000000000000000AA55FF0331219DD24E4E
      D0FF5B69F3FF5966F0FF5A67F1FF5A69F2FF5A6BF2FF5A6CF2FF596CF2FF596D
      F6FE5C75FDFF4454A2FF242B34FF20261EFF272F30FF212720FF20261DFF333F
      54FF4D5FA7FE5E75E2FF657FFFFF6782FFFF6781FFFF6780FFFF627AFFFF6078
      FCFF6078FCFF6077FBFF6078FFFF647DFFFF657DFFFF657DFFFF637CFFFF5D72
      DEFF4A5CA3FF313B4FFF20251BFF242B24FF272E2FFF212724FF2F3758FF5164
      D4FF596FFDFF5669EFFF5867F1FF5867F0FF5764EFFF5662EDFF565EEAFF545B
      E8FF575EEDFF443FC7FF27158FB2000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005278
      7CC0AFBFC7FFE8F2F6FFCBD9DFFEC3D3DAFFCCDBE1FFD3E2E7FFDAE8EDFFE0EA
      EEFFF0F7F8FFF1F9FAFFEAF3F5FFDFE9EDFFD0DCE1FFCFDBDFFFCEDADFFEDFE9
      EDFFEAF3F5FEEEF6F8FEF4FBFDFFEFF7F8FFE6EFF1FFE2EAEDFFE2EBEEFFE7F0
      F3FFE7F1F3FFE2ECEFFFD8E4E8FED1DEE3FFC8D7DCFFC1D1D7FFC5D5DBFFA1B5
      BEFF889FABFF96ABB7FF97ACB8FF97ACB9FF96ACB8FF93AAB6FF91A7B5FF8EA4
      B3FF8BA1B0FF889FAEFF849CACFF7E96A8FF94A7BBFF5B7084FF333C64730000
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
      00000000000000000000000000000000000000000000000000002E1E9BB04A45
      C8FF5D6AF5FF5A66F1FF5A68F2FF5A69F3FF5A6AF3FF5A6BF3FF5A6DF6FF5C70
      EFFF343E68FF1F2319FF252C29FF232A26FF1F241DFF34415AFF556CC0FF6783
      FFFF6480FEFE607AFFFF5F78FDFF6079FCFF6279FDFF627AFDFF6279FDFF6278
      FDFF6178FCFF6178FDFF6177FCFF6077FBFF5F76FBFF5E75FAFF5C73FAFF5D75
      FFFF627CFFFF627CFEFF4F61B2FF2C3543FF1D2319FF262D2CFF21261DFF2327
      2AFF4958B5FF5C71FEFF5766EFFF5866EFFF5764EEFF5662EEFF555EEBFF545B
      E8FF575EEDFF3E36BDFF26158E87000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005E7B
      839E95AAB4FFDDE7ECFFF4FBFDFEEEF7F9FFEEF6F8FFF1F8FAFFF3FBFDFFF4FB
      FDFFF1F8FAFFEFF6F9FFE6EFF2FFDAE4E8FFDAE5E9FEDAE4E9FED7E1E6FED9E3
      E7FFE4EDF0FEEFF6F9FEF1F8FBFFF2F9FBFFF2F9FCFFF2F9FBFFEFF6F9FFEAF3
      F6FFE4EFF1FFDEE9ECFFD3DFE4FEC9D6DCFEC6D4DAFFC4D2D8FFC2D2D8FFC0D0
      D7FF95AAB6FF95AAB5FF9BAFBCFF9AAFBCFF99AEBBFF97ADB9FF95AAB7FF91A7
      B5FF8EA4B3FF8BA1B1FF869EAEFF8098AAFF94A7BAFF61778BFF2443567A0000
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
      0000000000000000000000000000000000000000000000000000371F9C83463B
      BEFF5E6AF3FF5A66F2FF5B69F3FF5B69F4FF5B6BF3FF5A6CF5FF6074FCFE3842
      6DFE1D2217FF283033FF20261DFE2B3441FF5265B8FF6681FFFF627BFFFF5F76
      FDFF6077FCFF6179FCFF6279FDFF6379FDFF6379FDFF6379FDFF6379FDFF6278
      FDFF6378FDFF6378FCFF6277FCFF6277FCFF6076FBFF6075FBFF5F74FAFF5E73
      F9FF5D73F8FF5B71F9FF6177FFFF6176F4FF44528EFF222722FF222823FF252B
      2AFF202420FF4C5CB9FF5A6BFBFF5765EEFF5763EEFF5661EEFF565EEBFF555B
      E9FF575BEAFF382CAEFF2E179A58000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B74
      7E658FA3ACFFCAD3DCFFE5EDF1FFF1F9FBFFF2FAFBFEF2FAFCFFF1F9FBFFF2FA
      FCFFEEF6F8FFE7EFF2FFDEE9ECFFE0E9EDFFE1EBEEFEE1EAEEFEDFE9EDFFDEE8
      ECFFDBE7EAFFE0EAEDFFE8F1F4FFECF4F7FFEDF4F7FFEBF3F5FFE9F1F4FFE4EE
      F0FFDBE6EAFFD4DFE3FFCCDADFFFC9D7DCFFC7D6DBFFC4D3D8FFC0D1D6FFC1D1
      D7FFBCCDD3FF9AB0BAFF9CB1BCFF9FB4BFFF9DB2BEFF9BB0BDFF97ACBAFF95AA
      B7FF91A7B5FF8DA3B3FF88A0B0FF8299ABFF96A9BAFF637A8CFF2141507D0000
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
      0000000000000000000000000000000000000000000000000000371FA24A3B2F
      AEFF5B67EDFF5B66F3FF5B69F3FF5C6AF4FF5C6CF4FF5D6FFCFF5769DDFF2328
      28FF272F2FFF1D231BFF374367FF657DF2FF637DFFFF5E76FDFF6077FCFF6178
      FCFF6278FCFF6279FDFF6278FDFF6379FDFF6379FDFF6379FDFF6379FEFF6478
      FDFF6378FDFF6378FDFF6277FCFF6277FCFF6176FBFF6176FCFF5F74FBFF5F74
      FAFF5E73F9FF5D72F8FF5B6FF7FF5B6FFAFF647BFFFF576ACDFF293140FF2024
      1EFE262B28FF272C38FF5766E5FF5766F2FF5763EEFF5761EEFF565EEBFF565D
      ECFF5353DFFF31219BF93316A023000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000395D
      593F81939CFFD3DBE4FFD0DBE1FEDCE6EBFEE3EDF0FEE7F0F2FFE9F2F5FFE6EF
      F2FFE2ECEFFFE2EBEFFFE4EDF1FFE5EEF1FFE4EEF1FEE4EEF1FEE3EDF0FFE2EC
      EFFEE1EBEEFEDEE9ECFFDCE7EBFEDCE8EBFFDCE7EAFFDBE5E9FFD8E3E7FFD5E1
      E5FFD4E0E3FFD2DFE3FFD0DCE1FFCDDADFFFC9D7DDFFC6D5DAFFC2D2D7FFBFCF
      D5FFC0D0D6FFBACCD2FFA1B6C1FEA2B6C1FFA1B5C1FF9EB3BFFF9AAFBCFF97AD
      BAFF94A9B7FF90A6B5FF8BA2B2FF869DAEFF97AABCFF63788CFF2C44597B0000
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
      00000000000000000000000000000000000000000000000000003D24AA153123
      9FF0565CE0FF5E69F6FF5B68F3FF5C6BF5FF5C6CF4FF5D6EFAFF5D6FE7FF272E
      35FF1D2111FF3F4C7BFF667DFFFF6076FFFF5F75FBFF6176FCFF6276FCFF6277
      FDFF6378FDFF6378FDFF6378FDFF6379FDFF6478FDFF6478FDFF6479FDFF6578
      FDFF6377FDFF6377FDFF6376FDFF6376FCFF6275FCFF6175FCFF6074FBFF6073
      FAFF5F72FAFF5E72F9FF5E70F7FF5D6FF7FF5C6DF6FF6073FFFF6075EBFF3239
      52FF1C1F0DFF20231EFE5461D5FF5967F5FF5862EEFF5860EDFF575DEBFF595F
      EFFF4E47D2FF321C97D840008004000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004D64
      69387C8B96FFD0D8E1FFD5E0E5FFD9E4E8FFDAE4E9FFDDE7EBFFE0EAEDFEE3EC
      EFFFE5EEF1FFE6EFF3FFE7F0F3FFE7F0F3FFE7F0F3FFE6EFF2FEE5EEF1FEE5EF
      F1FFE4EEF0FFE3ECEFFEE1EBEEFFE0EBEEFFDFEAEDFFDEE8ECFFDCE7EAFFD9E5
      E7FFD7E3E6FFD4E1E4FFD2DFE2FFCFDCE0FFCBDADEFFC9D7DCFFC4D3D9FFC0D0
      D6FEBCCCD4FEBECED5FEBACBD2FFA6BAC4FFA5B9C3FFA1B6C2FF9DB2BFFF9AAF
      BCFF97ACBAFE93A8B7FE8FA5B5FF899FB0FF99ABBDFF637A8AFF354E64690000
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
      0000000000000000000000000000000000000000000000000000000000002C1C
      98BE4A4BCCFF616DF9FF5B67F3FF5C6AF5FF5C6CF5FF5C6CF6FF6174FCFF5869
      D3FF5061B9FF667DFFFF5F74FEFF5F75FAFF6176FCFF6276FCFF6277FCFF6377
      FDFF6378FDFF6478FDFF6478FEFF6478FEFF6478FDFF6478FEFF6478FEFF6478
      FDFF6477FDFF6477FDFF6376FCFF6376FDFF6275FDFF6275FCFF6174FBFF6173
      FAFF6072FAFF5F71F9FF5E70F8FF5E6FF8FF5D6DF7FF5C6CF6FF5D71FEFF6173
      F3FF434D8CFF4C58ADFE5C6AF5FF5865EFFF5862EFFF5860EDFF565CEAFF5A5F
      EEFF4439C2FF2F1C999300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006A4F
      8D1D717B8BF5CCD7DEFFD8E3E8FFDDE7EBFFE0E9EDFFE2EBEFFFE5EEF1FFE7F0
      F2FFE8F0F3FFE9F1F4FFE9F2F5FFEAF2F5FFE9F2F4FFE9F1F4FFE8F1F3FFE8F1
      F3FFE6F0F2FFE6EFF2FFE5EEF1FFE3EDF0FFE2EDF0FFE1EBEEFFDFE9ECFFDDE8
      EBFFDAE6E9FFD8E4E7FFD4E1E5FFD1DFE3FFCEDBE0FFCBD9DDFFC6D5DBFFC3D2
      D8FFBFCFD6FEBCCDD4FEC0D0D6FFB5C6CFFFA6BAC4FFA4B8C4FFA0B5C1FF9CB1
      BEFF99AEBCFF96ABB9FF91A7B7FF8CA1B2FF9AADBEFF5C7282FF2C44524B0000
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
      000000000000000000000000000000000000000000000000000000000000331F
      9F6A3F36B6FF636DF2FF5B65F3FF5D69F4FF5E6CF5FF5E6DF6FE5E6EF7FF6273
      FFFF6377FFFF6072FBFF6174FAFF6275FBFE6275FCFF6376FCFF6377FDFF6377
      FDFF6477FDFF6477FEFF6477FDFF6578FDFF6478FDFF6578FDFF6578FEFF6477
      FDFF6477FDFF6476FDFF6476FDFF6376FDFF6374FCFF6274FCFF6273FBFF6273
      FBFF6071FAFF6071FAFF5F6FF9FF5E6FF8FF5E6CF7FF5E6CF6FF5C6BF5FF5B6A
      F7FF6270FFFF5E6BFDFF5964EFFF5963EFFF5961EEFF575FEDFF575BEBFF5658
      E3FF3729ACFF371FA14100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008020
      9F08697686E1C4CFD9FFD9E3E8FEDCE5EAFFE1EBEEFFE4EEF1FEE6F0F2FFE8F1
      F4FFE9F2F4FFEAF3F6FFEBF3F6FFEBF4F6FEEBF3F5FFEBF3F6FFEBF3F6FFEBF3
      F5FFE9F2F4FFE8F1F3FFE8F1F4FFE7F0F3FFE5EFF1FFE3EDF0FFE1ECEEFFE0EA
      EDFFDDE8EBFFDBE6EAFED7E4E7FFD4E1E5FFD1DEE2FFCEDBDFFFC9D7DDFFC6D5
      DAFFC2D2D8FEC1D0D6FFBFCED5FFBDCDD5FFACBEC8FFA6BAC5FFA4B7C3FFA0B3
      C1FF9CB1BEFE98ADBBFF94A9B8FF91A5B6FF9AADBDFF536276FE3A3A65350000
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
      000000000000000000000000000000000000000000000000000000000000451D
      B11A32239FF55A5FE0FF5E6BF7FF5D68F4FF5E6BF6FF5F6DF7FF5F6FF8FF6070
      F9FF6071FAFF6173FBFF6174FBFF6274FCFF6375FCFF6376FCFF6377FDFF6477
      FDFF6477FDFF6477FEFF6477FDFF6578FDFF6578FDFF6577FDFF6577FEFF6577
      FDFF6476FDFF6576FEFF6475FDFF6475FDFF6374FCFF6373FCFF6272FBFF6272
      FBFF6171FBFF6070FAFF606EF9FF5F6EF9FF5E6CF7FF5E6CF7FF5D6AF6FF5C69
      F4FF5B66F3FF5A65F1FF5A64F0FF5A63F0FF5860EEFF575EEBFF5C60EFFF4A46
      CBFF2E1999D82B2BAA0600000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005A707BBAB5C3CDFFDCE6EBFEDCE6EBFEE2ECEFFEE6EFF1FFE8F1F3FFEAF2
      F5FFEAF3F6FFEBF3F6FFECF4F7FFECF5F8FFEDF5F7FFEDF5F7FFEDF5F7FFEDF4
      F6FFEBF3F6FFEBF3F5FFEAF3F5FFE9F2F5FFE8F1F4FFE6F0F2FFE4EEF0FFE2EC
      EEFFDFEAEDFFDDE8EBFFDAE5E9FFD7E3E7FFD3E0E4FFD0DDE2FFCBD9DFFFC9D6
      DDFFC5D3DAFFC3D1D8FFC0D0D7FFC0D0D7FFB6C7CFFFA8BBC6FFA6B9C5FFA3B6
      C3FF9EB2C0FE9AAFBDFF96ABBAFF96AABAFF93A6B7FF49566DEC7030AF100000
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
      0000301E9BAA4C42C7FF636FF8FF5C66F3FF5E6BF6FF5F6DF7FF606FF9FF6070
      F9FF6171FAFF6272FBFF6273FCFF6274FCFF6375FDFF6375FDFF6376FDFF6477
      FDFF6477FEFF6577FDFF6577FDFF6577FDFF6577FEFF6577FEFF6577FEFF6576
      FEFF6476FDFF6575FEFE6475FEFF6474FDFF6374FDFF6373FCFF6272FCFF6271
      FCFF6170FBFF616FFAFF606EF9FF606DF9FF5F6CF8FF5E6BF7FF5D69F6FF5D68
      F5FF5B66F3FF5A64F2FF5B62F1FF5961F0FF585FEDFF565BEBFF5B5EEAFF3A2F
      B3FF301A9F7F0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004E6A736F9BAEB7FFE3EAF0FFDDE7EBFFE2ECF0FFE7F0F3FFE8F2F5FFEAF3
      F6FFEBF4F6FFEDF5F7FFEDF5F8FFEEF6F8FFEDF6F8FFEEF6F8FFEDF5F7FFEDF5
      F7FFEDF5F7FFECF4F6FFECF5F7FFEBF3F6FFE9F2F4FFE8F1F3FFE6EFF2FFE4EE
      F0FFE1ECEFFFDFEAEDFFDBE7EAFFD8E5E8FFD6E2E6FFD3E0E4FFCFDCE2FFCCDA
      DFFFC7D6DCFFC5D4DAFFC3D3D8FFC1D0D7FFBDCDD5FFADBFC9FFA8BBC7FFA5B8
      C5FFA1B4C2FF9DB1BFFF97ABBBFF9CB0C1FF879BACFF414E63C7FF00FF010000
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
      00003724A8383626A8FF5B62E6FF5E69F7FF5E69F5FF606CF8FF606EF9FF616F
      FAFF6171FBFF6271FCFF6273FCFF6273FDFF6274FDFF6375FDFF6375FDFF6476
      FDFF6476FDFF6476FDFF6476FEFF6476FDFF6576FEFF6476FDFF6576FEFF6575
      FDFF6476FDFF6475FDFF6474FDFF6474FDFF6373FDFF6372FDFF6371FCFF6271
      FBFF6270FBFF606FFAFF606DF9FF5F6CF8FF5F6BF8FF5E6AF7FF5D69F5FF5D67
      F4FF5B65F3FF5A63F2FF5A61F0FF5960EFFF585CECFF5A60F0FF504CD2FF2D1C
      96F4401BA41C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004C677C25728A93FBDDE7ECFFDFE9EDFFE3EDF0FFE8F1F3FFE9F3F5FFEBF4
      F6FFECF4F7FFEEF6F8FFEEF6F8FFEFF6F9FFEFF7F9FFEFF7F9FFEFF6F8FFEFF7
      F8FFEEF5F8FFEDF5F8FFEDF6F7FFECF4F6FFEBF3F5FFEAF2F4FFE8F0F4FFE5EF
      F1FFE3EDF0FFE0EBEEFFDEE9ECFFDBE7EAFFD8E4E8FFD5E2E6FFD1DEE3FFCEDB
      E0FFCAD8DDFFC7D6DBFFC5D3DAFFC2D1D8FFC0CFD6FFB1C2CCFFAABCC7FFA7BA
      C6FFA4B6C3FF9FB2C0FF99ADBCFFA1B4C4FF708495FF3C4C6189000000000000
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
      0000000000002A1E9CB54743C5FF6671FBFF5C67F5FF606CF7FF616EF8FF616F
      F9FF6170FAFF6271FBFF6271FCFF6272FCFF6272FDFF6374FDFF6474FDFF6475
      FDFF6475FDFF6475FEFF6476FEFF6575FEFF6575FDFF6575FDFF6575FEFF6575
      FEFF6575FDFF6574FEFF6473FEFF6474FDFF6472FDFF6471FCFF6371FCFF6370
      FCFF626FFBFF616EFAFF606CF9FF606BF8FF5F6AF7FF5E68F7FF5C67F5FF5C65
      F4FF5B64F3FF5A62F1FF5960EFFF585EEDFF595BEBFF5E61ECFF4031B8FF2F19
      998E000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000001587B7EC7C3D0D6FFE7EFF4FFE4EDF0FFE8F1F4FFEAF3F5FFECF4
      F6FFEDF5F7FFEFF6F9FFEFF7F9FFEFF7F9FFF0F7F9FFF0F7F9FFEFF7F9FFEFF7
      F9FFEFF7F9FFEFF7F8FFEEF6F8FFEDF5F7FFECF4F6FFEBF3F6FFE8F2F4FFE7EF
      F2FFE4EEF0FFE2EBEFFFDFEAEDFFDDE8EBFFD9E5E9FFD6E3E6FFD3E0E4FFD0DD
      E2FFCCDADFFFC9D7DCFFC6D5DBFFC3D2D8FFC2D0D8FFB3C4CEFFABBDC8FFA9BB
      C6FFA5B7C4FFA1B3C1FFA0B1C0FF9CAEBEFF546B7AFE41506433000000000000
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
      0000000000003829AD323225A1FD5A5FDEFF606DFBFF5E69F6FF5F6CF8FF606E
      F9FF616EFAFF6270FBFF6171FBFF6371FCFF6372FDFF6373FDFF6373FDFF6474
      FDFF6474FDFF6475FEFF6474FEFF6574FEFF6574FDFF6574FEFF6574FEFF6474
      FDFF6574FDFF6573FDFF6473FDFF6472FDFF6471FDFF6371FCFF6370FBFF626F
      FBFF626DFAFF616DFAFF606BF9FF5F6AF8FF5E68F7FF5E67F6FF5C65F4FF5B64
      F3FF5B63F2FF5A61F0FF585DEEFF575BEBFF5F61F0FF4C48CAFF2D1B99EA4321
      A617000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000516F755E90A3AAFFE9F0F5FFE4EDF0FFE9F1F4FFEAF3F6FFECF5
      F7FFEEF5F8FFF0F6F9FFF0F7F9FFF0F8F9FFF1F7F9FFF1F7FAFFF0F8F9FFF0F7
      FAFFF0F7F9FFEFF7F8FEEFF7F9FFEEF7F9FFEDF5F7FFECF4F6FFEAF3F5FFE8F1
      F3FFE6EEF1FFE4ECEFFFE1EBEEFFDEE9ECFFDBE6EAFFD8E4E8FFD5E1E6FFD2DE
      E3FFCCDBE0FFCAD8DDFFC8D6DCFFC3D2D9FEC2D1D9FFB4C5CEFFACBEC9FFAABC
      C7FFA5B7C4FFA2B4C2FFAABAC9FF8799A9FF445D68CD80008002000000000000
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
      000000000000000000003222A38E4336BDFF646CF0FF5E67F7FF5E68F6FF606B
      F8FF606DFAFF626EFBFF626FFBFF6370FCFF6271FCFF6372FDFF6372FCFF6373
      FDFF6473FDFF6474FDFF6473FEFF6473FEFF6473FDFF6473FDFF6573FDFF6573
      FDFF6472FDFF6472FDFF6472FDFF6471FCFF6370FCFF6370FCFF636FFBFF626E
      FAFF616DFAFF606BF9FF606AF9FF5F69F7FF5E67F6FF5E66F5FF5C64F3FF5B62
      F3FF5A61F1FF595FEFFF575AEBFF5B5EEFFF5C57DFFF3828AEFF321EA2650000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000809FBF08627B80DDC6D0D7FFEBF5F8FEE8F0F3FFEAF3F5FFECF5
      F7FFEDF6F8FFEFF7FAFFF0F7F9FFF1F8FAFEF1F8F9FFF1F8F9FFF1F8FAFFF1F8
      FAFFF1F8F9FFF0F7F9FFF0F7F9FFEFF7F9FFEFF6F8FFEDF4F6FFEBF3F6FFE9F2
      F4FFE7F0F2FFE4EEF1FFE2ECEFFFE0EBEDFFDCE7EBFFDAE5E9FFD6E3E7FFD3DF
      E5FFCEDCE1FFCCD9DEFFC8D6DCFFC5D3DAFFC2D1D9FFB4C4CEFFADBECAFFAABB
      C7FFA5B6C4FFA3B5C3FFAAB7C9FE67798AFF3E58656200000000000000000000
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
      00000000000000000000402BBF0C311FA6D94A45C4FF6872F9FF5A64F5FF5E68
      F6FF606BF9FF616DFAFF616EFBFF626FFCFF626FFCFF6371FDFF6271FCFF6371
      FDFF6372FDFF6372FDFF6372FDFF6472FDFF6472FDFF6472FDFF6472FDFF6472
      FDFF6471FDFF6471FDFF6470FDFF6370FCFF636FFCFF626EFBFF626DFBFF626D
      FAFF616BFAFF606AF9FF5F69F8FF5F68F7FF5D66F6FF5D65F5FF5B62F3FF5B61
      F1FF5960F0FF585DEDFF595BECFF6165EFFF4134BCFF2E1C9CB0000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005B747A5C8398A1FFE8F0F4FFE9F2F6FFEAF3F5FFEDF5
      F7FFEEF6F8FFF0F7FAFFF0F8FAFFF1F8FBFFF1F8FAFFF2F9FAFEF2F8FAFFF1F9
      FAFFF1F8FAFFF1F8FAFFF1F8FAFFF1F8F9FFEFF6F9FFEEF5F7FFECF5F6FFEAF3
      F5FFE8F1F4FFE6EFF2FFE4EEF0FFE1EBEEFFDDE8ECFFDBE6EAFFD7E3E7FED4E0
      E5FFCFDCE1FFCCD9DFFEC8D7DDFFC6D4DBFFC3D1D9FFB2C4CDFFADBFCAFFAABC
      C7FFA5B7C3FFADBFCCFF8E9EB1FF4F5971D5552B800600000000000000000000
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
      00000000000000000000000000003223AA333024A6FA5957D5FF6871FCFE5A60
      F4FF5E68F7FF606BF8FF606CF9FF626EFAFF626EFBFF626FFCFF616FFCFF6370
      FCFF626FFCFF6370FCFF6370FDFF6371FDFF6371FCFF6470FDFF6470FDFF6470
      FDFF6470FCFF6370FCFF646FFCFF626EFCFF626DFCFF626DFBFF616CF9FF616B
      F9FF6069F9FF5F68F8FF5E67F7FF5D66F6FF5D64F4FF5C63F3FF5A61F1FF595F
      F0FF595DEEFF585AEDFF6668F3FF4B43C7FF2D1CA1E23D18AA15000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000557979B8ACBEC2FFF3FAFEFFE9F1F4FFECF4
      F7FFEDF5F8FFEFF6F9FEF0F7F9FFF1F8FAFFF2F8FAFFF2F8FBFFF2F8FAFEF2F9
      FBFFF2F8FAFEF1F8FAFFF1F8F9FEF1F7F9FFF0F7F9FFEFF6F8FFEDF4F7FFEBF3
      F5FFE8F1F4FFE7F0F2FFE4EEF0FFE2EBEFFFDFE9ECFFDCE7EBFFD8E4E7FFD4E1
      E5FFD0DDE2FFCDDAE0FECAD8DEFFC7D5DCFFC2D0D8FFB1C2CBFFAFBFCAFFABBC
      C8FFADBECAFFA9B9C7FF5D7382FF455B6E430000000000000000000000000000
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
      0000000000000000000000000000000000003127A4623627B0FF5D60D7FF6A72
      FCFE5861F4FF5E67F7FF5F6AF9FF606CFAFF616CFAFF616DFAFF616EFBFF626E
      FCFF616EFBFF616EFCFF626FFCFF626FFCFF626FFCFF636FFCFF636FFCFF636E
      FCFF636EFCFF636EFCFF626DFBFF626DFBFF616CFBFF616BFAFF606AF9FF6069
      F9FF5F68F8FF5E66F7FF5D66F6FF5D64F5FF5B63F4FF5A61F2FF595FF0FF575B
      EEFF5658EDFF666CF7FF534DD0FF321E9FF43119A23400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000052737B1F677D86EDC8D4D9FFF5FDFFFFEAF2
      F6FFEDF4F7FEEFF6F9FFF0F7FAFFF1F8FAFFF3F8FBFFF2F8FBFFF2F9FBFEF3F9
      FBFEF2F8FAFFF3F9FAFFF2F8FBFFF2F8FAFEF0F8F9FFEFF6F8FFEEF5F8FFECF4
      F6FFE9F2F5FEE8F0F3FFE5EEF1FFE2ECEFFEDFEAEDFFDDE8EBFFD9E4E8FFD5E1
      E5FFD1DEE2FFCEDBE0FFCAD8DEFFCAD7DDFFBCCBD4FEB1C2CCFFAFC0CAFFADBD
      C9FFB6C5D3FF7B8B9AFF495C6B99000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000003425AC753626ACFF6363
      D8FF747EFDFF5C61F3FF5B62F5FF5F69F8FF606AF9FF606BFAFF606CFAFF616D
      FAFF616DFBFF626DFBFF626DFBFF626DFBFF626DFBFF626EFBFE636EFCFF626D
      FBFF626DFBFF626CFBFF616CFAFF616CFAFF606BFAFF606AF9FF5F69F8FF5F68
      F8FF5D66F6FF5D65F5FF5D63F4FF5C62F3FF5A61F1FF595EF0FF5356EDFF5658
      EEFF6C72F7FF5554D2FF3420A9FF3B1FAE520000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005D7A81476C8D91FFD2DCDFFFF9FE
      FFFFEBF3F6FFEEF5F7FFEFF7F9FFF1F8FAFFF2F9FBFFF2F9FBFEF3F8FBFFF3F9
      FBFFF2F9FBFEF3F9FBFFF3F9FBFFF2F8FAFEF2F8FAFFF0F7F9FFEEF6F8FFECF4
      F7FEEAF3F5FEE8F1F4FEE6EFF2FFE3EDF0FFE0EAEDFFDDE8EBFFD9E4E8FFD6E2
      E6FED1DEE3FFCDDAE0FFCCD9DFFFC6D4DBFFB6C6D0FFB4C3CEFFAEBEC9FFB9C7
      D4FF8E9DAEFF526674DE40556A0C000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000003521A6733424
      AAFF5D60D5FF7A86FCFE636BF8FF585FF4FF5C65F7FF606AF9FF5F69F9FF606B
      F9FF606BFAFF616BFAFF616BFAFE616BFBFF616CFBFF616CFBFF616CFBFF616C
      FBFF616BFAFF616BFAFF606AFAFF606AF9FF5F69F9FF5E68F8FF5E67F6FF5D67
      F7FF5C65F5FF5C64F4FF5B61F3FF5A60F2FF5659EFFF5356EDFF6066F2FF737E
      F5FF5251CBFF311EA1F8341DA558000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000537A7D62718991FFCED7
      DCFFF8FDFFFFEDF5F8FFEEF6F8FEF0F7FAFFF1F8FBFFF2F9FBFEF2F8FBFEF3F8
      FBFFF3F9FBFEF3F8FBFEF3F9FBFFF3F9FBFFF2F8FAFFF1F8FAFEEFF6F8FFEDF5
      F7FFEBF3F6FFE9F1F5FFE6EFF2FFE3EDF0FFE1EBEEFFDEE8ECFFDAE5E9FFD7E3
      E6FED1DEE3FFCDDBE0FFCBD8DFFFBBCBD3FFB7C7D0FFB4C4CEFFB9C8D4FE8F9F
      ABFF556D75EB4A60703000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000003523
      AF603122A9F7534DCBFF7D88F5FF7781FDFF5F66F5FF5960F6FF5B64F7FF5F68
      F8FF6069F9FF606AF9FF606AF9FF606AFAFF5F6AF9FF5F6AFAFF606AFAFF606A
      F9FF6069F9FF6069F9FF5F69F8FF5E68F8FE5C67F7FF5C66F7FF5C66F6FF5C65
      F5FF5B63F4FF5960F2FF5459F0FF5558EFFF5F62EFFF777FF9FF757CEFFF4A41
      C5FF2F1EA4E33D20A63F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000537A80626488
      8FFFBCC8CEFFF9FCFFFFF2F8FCFFEFF6F9FFEFF6F9FFF1F7FAFFF2F8FAFFF3F8
      FBFFF3F8FAFFF3F8FBFFF3F9FBFFF2F8FBFFF2F8FBFFF0F7FAFFF0F6F8FFEEF5
      F7FFEBF3F5FFEAF2F4FFE7F1F3FFE5EEF1FFE2EBEFFFDEE9EDFFD9E5E8FFD5E1
      E6FFD1DEE3FFCCDADFFFC1CFD7FEBAC9D2FFBBCBD4FFBCCBD4FF8D9CACFF586F
      79ED406C67340000000000000000000000000000000000000000000000000000
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
      00003C2AB037321DA6D64138B8FF7076E4FF8593FEFF7581FCFF656FF6FE5B64
      F5FF585FF7FF5A63F7FF5D66F8FF5F67F8FF5E68F8FF5E69F8FF5F68F8FF5F68
      F8FF5E68F8FF5E67F8FF5E67F7FE5D67F7FF5C66F6FF5B64F5FF5A63F4FF575E
      F3FF555BF2FF595FF1FF636BF2FF7783F9FF808DF7FF6367D7FF392EB7FF2F1B
      A1BC3E23B01D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005A7C
      8652617985EDA0B3B9FFEAF1F3FFF9FEFEFEEFF6F9FFEFF6F9FFF1F8FAFFF2F8
      FAFFF2F8FAFEF2F8FBFFF2F9FBFFF2F8FBFFF1F8FAFFF1F7FAFFEFF6F8FFEEF5
      F7FFEBF3F6FEEAF2F4FFE7F0F3FFE5EEF1FFE1EBEEFFDDE8ECFFD9E5E8FFD5E1
      E6FFCEDBE1FFC5D3D9FEBFCDD6FFC5D4DDFFB6C5CFFF8395A0FF5B7180DE5862
      7134000000000000000000000000000000000000000000000000000000000000
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
      0000000000004422AA0F3020A88F3323A8FD504EC8FF7781E9FF8695FEFF808E
      FEFF707DF8FF646EF6FF5D66F7FF5962F6FF5861F5FF5860F6FF5960F6FF5960
      F6FF585FF6FF5860F5FF575FF4FF565EF4FF575DF3FF585FF3FF5B62F2FF636C
      F3FF737CF6FF808DFDFF828FFAFF6B71E0FF493EC2FF301FA6F33423AE75FF00
      FF01000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005A758325567D82BD7F96A1FFC0CCD0FFF3F6F9FFFCFFFFFFF2F9FBFFF0F7
      F9FFF1F7FAFFF1F8FAFFF1F8FAFFF1F8FBFFF1F7FAFFEFF6F9FFEEF5F8FFECF4
      F7FFEAF3F5FFE7F1F4FFE6EFF1FFE3EDF0FFE0EAEEFFDDE7EBFFD8E3E8FFD1DD
      E3FFC8D6DCFFCAD9DFFFC3D2DAFFA1B1BBFF728A98FF5C7487B6476670190000
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
      00000000000000000000000000003720A8382C1C9EBF3327A8FF4C4AC5FF6C73
      DFFF8290F4FF899AFEFF8595FFFF7E8DFCFF7684F9FF707BF8FF6D78F6FF6C76
      F6FF6A75F6FF6A75F6FF6C77F5FE6F7CF5FF7481F9FF7B88FBFF8290FDFF8390
      FBFF7985EEFF6266D6FF453FBDFF2E1E9EF6301AA79A4522B325000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF01667A8E75637A88EB869FA7FFC2CDD3FFEAF0F3FEF9FE
      FEFEF7FEFFFFF3F9FDFFF1F7FBFFF0F7FAFFEFF6F9FFEFF6F8FFEEF5F8FFECF4
      F6FFE9F1F4FFE8F0F3FFE5EEF1FFE2ECF0FFDFE8EDFEDBE6EBFFD7E3E9FFD5E1
      E7FEC9D5DDFFA7B7C0FF80959EFF656F81E863718E6A00000000000000000000
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
      00000000000000000000000000000000000000000000361FB6422C1FA5AC3024
      A5F24239BAFF5551CEFF6970DDFF7984EAFF828DF2FF8893F7FF8B98FCFF8C9A
      FDFF8C9AFEFF8C99FDFF8996FCFF838FF6FF7A86F1FF7078E4FF6265D7FF4E48
      C6FF3B30B3FF2F1FA4DE2F1EA7883C22AE260000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000556A8A185B8086835E848BE7819BA1FFAABA
      C1FFD0D9DCFFEAEFF2FFF9FCFFFFFDFFFFFFFBFFFFFFF9FEFFFFF5FBFEFFF2F9
      FDFFF1F8FBFFF0F6FAFFECF5F9FFEBF4F8FFE7EFF4FFDCE6EBFFC3D1D7FFA3B2
      BCFF7D949EFF5B767EEC547A7A82645990170000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000003820
      AF203622AC682F1EA6AC301FA0E13527A5FC3C32B0FF453EBBFF4D49C5FF514D
      C8FF514EC7FF4F4BC2FF4A46BFFF413AB6FF3B2FA8FF35259EF12D1E9BCE2D1D
      9F94361FAD4B4D33E60A00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005168741665808762677D
      88B96A7C89F47C949BFF99AFB4FFB0C1C6FFC2CFD4FFCDD8DCFFD2DCE0FFD1DC
      E0FFCDD8DDFFCAD5DAFFBECCD2FFAFBEC6FF9EB0B8FF869AA2FF697986FE626E
      81C55D74826E667A851900000000000000000000000000000000000000000000
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
      000000000000000000008033CC0A411EB82B3824B14E331FA574271FA57C281E
      A481261E9D7F231B967C301FA7742E1FA9533C1EAA3C602BCA18000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007373A51F5D808C52577E818452787BB2598383D25D8484E75C7E80EB5E80
      80ED5D8281E95C8080E85E8084DA567E7BBA587A7B9958727A6B5D74852C0000
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
      000000000000000000000000000000000000FF80FF0250708010406666144674
      7416478071125080701060609F08000000000000000000000000000000000000
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
      000000000000604ACA185864CD3D5167CE2F0000000100000000000000000000
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
      0000000000000000000000000000000000000000000000000000FF00FF020000
      0000FF00FF01FF00FF01FF00FF02FF00FF02FF00FF0200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004363C279446DCAEB4F76CFFF4C72C8FE4866C7D04B5DC463000000000000
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
      000000000000000000000000000000000000000000000000000000000000515E
      C9134B61CA3A4D66CC50475DBE763F5DBC814460B9924662BFAE3F62BABD3E64
      B9C03D63B9C64065BCC74363BBCF4363BACF4460BBCF4461BCCF425FBDD34363
      BCCF4464B9D14462B9D1445FBAD3465FBAD24761BAD34761B8CE4461B3C6455E
      B0BC4A5DB89F475BB56B5B49BF1C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003A62
      BD8C5986DCFF90B9EAFF99C3EDFF85B0E8FF6792DFFF4E73D0FF4A65C49C0000
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
      00000000000000000000000000005050CC233E5FC75B3D62C79A3F64C1C6446B
      C1EB4F73CBFF567DD5FF5D84DAFF668DE1FF6994E4FF6B97E4FF709CE5FF729F
      E7FF71A0E5FF72A1E5FF74A3E6FF75A3E6FF74A5E5FF74A3E5FF72A1E5FF73A1
      E5FF75A3E6FF76A3E6FF74A3E5FF75A4E6FF75A6E6FF76A6E7FF75A5E6FF72A0
      E1FF6E95DFFF6283D4FF4E66BEEF4855B9780000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004961C22A3F6F
      C2FDA6CBF2FFC3E9FFFFB9DFFFFFB5DEFEFF9FCCFAFF739FE1FF507BD5FF4B62
      BF88000000000000000000000000000000000000000000000000000000000000
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
      0000BF00FF045555F4183A6FF135266EEC432B6CF147346CEF4E336DEE4B2F6F
      ED473F6AEB41556CF42D5547E312000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      FF014B5DCB2C4A5EC86F3F5ABCBD4766C0F85782D6FF6997E3FF73A2E6FF7BAB
      E8FF80AFE9FF82B2EBFF86B6EEFF8AB9EFFF8CBBF0FF8BBAF0FF8ABAEFFF89B9
      EFFF89B8EFFF89B7EEFF87B7EDFF88B7EEFF88B7EEFF89B7EEFF88B8EEFF89B8
      EEFF88B7EEFF88B7EEFF88B8EEFF88B7EDFF87B7EDFF88B7EDFF88B6EDFF88B6
      EDFF8AB9EFFF8BB9EFFF80ADE9FF577ACFFF4054B18000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003B63C1746792
      DEFFBFE1FEFFB3D8FCFFB5D9FBFEB6DBFCFFB3DAFBFF94C3F4FF6792DBFF4D6E
      C6FF545FC2430000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000991AFF0A692D
      F0114739F1125A2DE111B31AFF0A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006600FF052C77F23A247CEC77227D
      ECAF2481EED32681ECEF2581EBFF2585F3FF277EF5FF287FF7FF2780F5FF2582
      F4FF277FF2FF287BEBFB2978EAEA2A7AEEC8317DF29D3079F25F3B62F2270000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006050
      CF104A6ACD67446BC8AA4165BFB84264C0A53F6ABE89386BBB7C425EC09A4465
      C1CF4C6CC7FC6084DEFF719FE5FF81B2EAFF8BBBF0FF8DBDF2FF8AB9EFFF87B6
      EEFF84B4ECFF85B4EBFF84B4EBFF85B3ECFF85B4ECFF85B4EBFF85B4EBFF85B3
      ECFF85B3EBFF85B3EBFF84B3EAFF85B3EAFF85B3EBFF85B3EAFF85B3EAFF85B3
      EAFF84B2EAFF84B2EAFF84B2EAFF84B2EAFF84B2EAFF84B2E9FF84B2E9FF84B2
      E9FF84B1E9FF84B1E9FF8BB9F0FF83B3ECFF486FC0F94242B51F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003C64C29683A9
      E8FFC3E4FFFFB4D9FBFFB4D9FBFFB3D9FBFFB9DDFDFFAAD1F8FF85B2F0FF5984
      D3FF4762BAC98000800200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003D5BF32A3270F2602C72F08B2275EAB22577EAC72974EBE12A75
      EAEB2B73E9ED2B73E8EC2B76EBE02677ECCB276FE8B52974ED8A3569F366355A
      EF30000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003565EF302D79F3832380EFDA2386F4FF258AFDFF2689
      FAFF2688F4FF268AF0FF258CECFF2691ECFF2694ECFF2796EBFF2797EAFF2794
      EBFF278FEAFF278AECFF2688EFFF2686F4FF2785FAFF2783FAFF257CEDFA2B7A
      EDC23271EF714058E72000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005068C8534D6C
      CAE15883D9FF6496DFFF6898DFFF6291DAFF5F8EDBFF6091DCFF6794E0FF75A3
      E6FF82B1ECFF89BAF0FF8ABCF0FF86B7EEFF85B5ECFF85B5ECFF85B5ECFF86B5
      ECFF86B6ECFF86B6ECFF87B6ECFF87B6ECFF86B6ECFF87B7EDFF87B6ECFF87B6
      ECFF87B6ECFF86B6ECFF86B5EBFF86B5EBFF86B5EBFF86B5EBFF85B4EBFF85B4
      EAFF84B4EAFF84B4EAFF85B3EAFF85B3EAFF84B3EAFF85B3EAFF85B3EAFF85B3
      EAFF85B3EAFF85B3EAFF83B2EAFF8CBCF0FF6287D5FF404EAE5F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003B66C2B18AAF
      E8FFC1E4FFFFB4D9FCFFB4DAFCFFB4DAFBFFB5DBFBFFB8DDFCFF98C5F6FF729D
      DEFF4A69C5FF4354BC3D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000336CF42D2A75
      EE852477ECCD2279ECFB237FF8FF2582FAFF2685F9FF2788F6FF2787F2FF2887
      EFFF2A8BEFFF2989EFFF2788F1FF2886F5FF2980F6FF2980FAFF257FFCFF2577
      ECFE2673EFC92B6EF0763E5DF021000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002C79F9522682F4BE2482EEFE278AFDFF2688F5FF258DEDFF2699EBFF27A4
      ECFF27AAECFF27B0EBFF26B4ECFF26B5ECFF26B3ECFF26B3EBFF26B3EAFF26B4
      EAFF27B4EBFF27B2EBFF27B0EBFF27ABEBFF26A2EAFF2795EAFF2887EDFF2883
      F6FF2882FDFF287BF0F12A7BF0973D67ED2A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004C65CA5B4E74D3FF6E9A
      E4FF87B8EEFF8BBBF0FF89BBF0FF89BAF0FF8ABAF0FF8ABAF0FF8BBCF1FF8ABA
      F0FF87B6EEFF86B4ECFF85B5ECFF86B6EDFF86B6EDFF86B7EDFF85B7EDFF87B7
      EDFF87B7EDFF88B8EDFF88B8EDFF88B8EDFE88B8EDFF89B9EDFF89B8EEFF89B8
      EDFF88B7EDFF88B8EDFF88B7EDFF88B7ECFF87B7ECFE87B7ECFF87B5ECFF86B6
      ECFF86B5ECFF86B5EBFF86B5EBFF86B5EBFF85B5EBFF86B5EBFF86B5EBFF85B4
      EAFF85B4EBFF85B3EAFF85B3EBFF8CBCF1FF698EDBFF4B58B87D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003865BFBA8FB6
      EBFFBFE4FFFFB6DBFCFFB5DAFCFFB4DBFCFFB5DBFCFFB9DEFDFFA7CFF7FF85B4
      EDFF5880D6FF495FBD8C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002A70F149277CF0B7257DEBFE2585
      FBFF2683F3FF268AECFF2794EBFF279EE9FE28A8EBFF28AAEBFF28AAEBFF28AB
      EAFF29AEEAFF29ADEBFF29ADEBFF28ABEBFF28A7EBFF28A0EAFE2797EAFF278B
      ECFF2783F6FF2682FCFF237AEDF62777EFAA3C61EC3700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002B75ED482681
      F3C7278AFCFF258AF9FF258AEDFF2699EAFF27A7EAFE27B2EAFF27B5E9FF27B2
      EAFF27B0E9FF27AFE9FF27AFEAFF27B0EAFF27B0EBFF27B0EBFF27B0EAFF27AF
      E9FF27AFE9FF27AFEAFF27AFEAFF28B1EAFF27B3EAFF27B6EBFF28B2EAFF28A5
      EAFF2790E9FF2781EFFF2687FCFF2780F0F83077F3904949E715000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005D6AD3294A6DCEF672A3E6FF8DC0
      F2FF85B6EDFF85B5ECFF84B5ECFF84B5ECFF83B5ECFF84B5ECFF84B5ECFF85B6
      ECFF85B6ECFF86B6EDFF86B7ECFF86B7EDFF86B8ECFF86B8EDFF85B7ECFF85B7
      EDFF85B7EDFF87B9EDFF89B9EEFF89BAEEFF89B9EDFF89B9EDFF89B9EDFF89B8
      EDFF88B8EDFF88B8EDFF88B8EDFF89B8EDFF89B9EDFF89B9EDFF8AB8EDFF8AB8
      EDFF8CBAEEFF8DBAEEFE8DBAEEFF8DBAEEFF8BBBEFFF8CBAEFFF8BBAEFFF8BBA
      EEFF8BBAEEFF8ABAEEFF8BBAEEFF8FBDF1FF6281D3FF515ABC5B000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AA55FF03426BC5D09AC2
      EFFFBDE2FFFFB6DBFCFFB5DBFCFFB5DAFCFFB4DAFBFEB5DBFCFFAFD6F9FF89BB
      F0FF678FDBFF455CB4C300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003468EA31277BF0B52485F5FF2784F8FF2783ECFF2795
      EBFF28A8EBFF29B1EBFF27B2EBFF27B0EAFF28AFEAFF28AEEAFE28ADEAFF28AD
      EAFF28ADEBFF28ADEBFF28AEEAFF28AFEBFF27B2EAFF27B4EAFF28B5EBFF28B4
      EBFF29ABECFF2899EBFF2788EEFF2684FAFF257BF0FE2B75F39B4E4EE21A0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005544DD0F2B7CF29A248BF8FF278A
      FAFF268BECFF27A4EBFF27B2EBFF27B4EAFF27B1EAFF27AEEAFF27AFEAFF27AF
      E9FF27B0EAFF27B0EAFF27B1EBFF27B1EAFF28B1EBFF28B2EBFF27B2EBFF27B2
      EBFF28B1EBFF28B1EAFF28B1EAFF28B1EAFF28B1EBFF28B0EAFF27B0EAFF28B4
      EAFF28B7EBFF29ADEBFF2896EBFF2784EEFF2887FEFF287BF0E43171EE580000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004865C6B86590E2FF8FC0F1FF87B8
      EEFF87B7EDFF87B7EDFF87B7EDFF87B8EDFF87B7EDFF87B7EDFF86B7ECFF86B7
      ECFF83B6ECFF83B5EDFF85B7ECFF87B8EEFF88BAEEFF8BBCEFFF8EBEF0FF91C0
      F1FF93C2F2FF95C3F2FF96C4F3FF96C4F2FF95C2F2FF94C1F2FF94C1F1FE91BF
      F1FF91C0F0FF90BFF0FF8FBDEFFF8EBDEFFF8DBCEFFF8DBCEFFF8DBBEEFF8BBA
      EEFF7BAEE7FE77AAE5FF75A7E4FF74A7E3FF75A6E3FF75A7E3FF75A6E3FF74A6
      E3FF74A5E2FF74A6E2FF78A6E3FF709CDDFF4F6CC9F7534BC322000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008866FF0F446EC5EBA4CC
      F1FFBDE1FFFFB6DBFCFFB5DAFCFEB5DBFCFEB4DBFCFFB4DAFCFFB7DCFBFF8EBE
      F1FF6F99E0FF4B60BDE56A2BBF0C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BF0080042B77F1812682F1F82788FBFF2787ECFF289BEBFF28AEEDFF27B4
      ECFF28B0EBFF28AEEBFF27AEEAFF28AFEBFF28AFEBFF28B0EBFF28B0EBFF28B0
      EAFF28AFEBFF29AFEBFF29AFEBFF28AFEBFF28AFEBFF28AFEBFF28AFEBFF27B0
      EBFF28B2EAFF28B6EBFF29B4EBFF28A1EBFF2785EDFF2682FDFF2779F0E73172
      EF5E000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003366EA3C2483F5D62590FFFF2587EDFF279F
      EBFF27B4ECFF27B5EBFF27AFEAFF27AFEAFF27B1EAFF28B1EAFF28B1EAFF28B1
      EAFF28B1EAFF28B1EAFF28B3EBFF28B3EBFF28B3ECFF28B3ECFF28B4EBFF28B4
      EBFF29B3EAFF29B3EAFF28B2EBFF28B3EBFF28B1EAFF28B1EAFF29B1EAFF29B0
      EBFF28AFEAFF28B1EAFF29B7EAFF29AFEBFF2693EAFF2684F4FF2685F9FF277B
      ED9C6D24DB070000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004F5CCF3A4B70CDFF87B6EBFF8DBCF1FF89B8
      EEFF8AB9EEFF8ABAEFFF8ABAEEFF8ABAEEFF88B9EEFF86B7EDFF83B7ECFF86B8
      EDFF89BBEEFE91C0F1FF96C4F2FF9BC6F4FF9BC8F4FF9EC9F5FF9DCAF5FF9DC9
      F5FF9CC9F5FF9CC9F4FF9DC8F5FF9CC8F5FF9CC8F4FF9BC8F4FF9CC8F4FE9AC7
      F4FF98C5F3FF98C4F2FF96C2F1FF94C2F1FF94C1F1FF93C1F0FF92BFF0FF90BE
      EFFF6A9EDFFF6298DCFF6197DBFE6297DBFF6599DCFF6398DBFF6195DAFF5F93
      D9FF5D8FD6FF598BD3FF5785CEFF5380CBFF4C6EC4FE475FBEC1525FC13E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000465DCB2C4B78CAFBB8DA
      F9FFB9DFFEFFB7DCFDFFB6DBFCFFB6DBFCFFB5DAFCFFB4DAFBFFB9DEFDFF96C2
      F1FF6F9DE3FF4D62BDF16040CA18000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003360
      E32D2780EFC4278BFFFF2786F0FF289BECFF27B1EDFF28B4EBFF28B0EBFF28AF
      ECFF27B0ECFF28B0ECFF28B0ECFF29B1ECFF29B1ECFF28B2ECFF28B2ECFF28B2
      EBFF29B1ECFF29B1ECFF28B1ECFF29B2EBFF29B1ECFF29B0ECFE28B0ECFF28B1
      EBFF28B1EBFF28B0EBFF28B2ECFF29B8ECFF29B5EEFF289BECFF2783F3FF2782
      FBFF2D78ECA36A40D50C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002B71EC5F2385F5FA238BFBFF248FECFF26AEECFF27B6
      ECFF27B1EAFF27B1EBFF27B1EBFF28B1EBFF28B3EBFF28B3EBFF28B3EBFF28B4
      EAFF28B4EBFF28B4ECFF27B5ECFF28B5ECFF28B5EDFF28B5ECFF28B5EDFF29B5
      ECFF29B5ECFF29B5EBFF29B4ECFF29B4ECFF29B3ECFF29B3ECFF29B2EBFF29B2
      EBFF28B1EBFF155C7BFF000000FF28B5EBFF28BCECFF28A8EBFF2787ECFF2888
      FEFF277CF1C22C59DE1700000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003A61C6996795E4FF98C7F5FF8AB9EFFF8BBA
      EFFF8CBBF0FF8CBCF0FF89BAEFFE88B9EFFF8ABBEFFE91BFF1FE99C6F4FF9FCA
      F6FEA2CCF7FFA4CEF7FFA2CCF6FFA1CCF6FFA1CCF6FFA1CCF6FFA0CBF6FFA0CC
      F5FF9FCBF6FF9FCBF6FF9FCBF6FF9FCAF6FF9FCAF6FF9FCAF6FF9FCAF5FF9EC9
      F5FF9CC8F4FF9BC7F4FF99C6F3FE99C5F3FF99C5F3FF98C4F2FE97C3F2FF97C4
      F2FF98C4F3FF94C1F2FF95C2F2FF95C1F2FF95C2F2FF95C2F2FF93C1F2FF92BF
      F1FF90BEF0FF8EBCF0FF8FBDF0FF8DBCEFFF85B6EAFF6E9ADFFF4D6CC7FB5662
      CB44000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002E5EC2645E91DBFFC6E5
      FDFFB7DCFDFFB6DCFDFFB6DBFCFFB6DBFCFFB5DAFCFFB5DAFCFFB8DDFDFF9BC6
      F2FF6FA1E5FF5269BFF4775ED51E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000346CE7492482
      F3EF2788FCFF288DECFF28ACEDFF27B5EDFF27B0ECFF28B0ECFF27B2ECFF28B2
      ECFF28B1EDFF28B2EDFF29B3EDFF29B2EEFF29B3ECFF28B3ECFF28B4EDFF29B4
      EDFF28B4EDFF28B4EDFF29B3EDFF29B4EDFF28B4EDFF28B4EDFF28B3ECFF28B4
      EDFF29B2ECFF28B2ECFF28B4EDFF28B4EDFF27B4EDFF28BAEEFF2AAEEEFF288C
      EDFF2786FFFF287CF2C84359E917000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002273F068238CFAFF2487F2FF2799ECFF27B6ECFF27B4ECFF27B1
      EBFF28B2ECFF27B2EBFF27B3EBFF28B4ECFF28B5EBFF28B5ECFF28B6ECFF28B6
      ECFF28B7ECFF28B6EDFF28B7EDFF28B8EDFF28B7EDFF29B7EDFF28B7EDFF29B7
      EDFF29B7ECFF2AB6EDFF29B5EDFF29B6ECFF28B6ECFF29B6ECFF29B6ECFE29B5
      ECFF29B3ECFF1B769BFF155D7BFF28B3EBFF28B3EBFF28BAEBFF28B5EBFF288D
      EAFF2788FBFF267BF0D64059DF28000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000926DFF073D63C5DC82B1EBFF96C5F4FF8CBCF0FF8CBC
      F0FF8BBCEFFF8DBDF0FF90BFF1FE9AC7F4FFA2CCF6FFA5CFF8FFA7CFF8FEA6CF
      F9FFA5CFF8FFA5D0F8FFA5CFF7FFA5D0F8FFA6D0F8FFA6CFF8FFA4CFF7FFA5CF
      F8FFA4CEF8FFA4CFF8FEA4CFF7FFA3CEF7FFA4CEF8FFA3CEF7FFA2CDF7FFA1CC
      F7FFA1CBF6FF9FCBF6FF9ECAF5FF9EC9F4FF9DC8F4FF9CC7F4FF9BC6F4FF9AC5
      F3FF99C5F3FF98C4F2FF96C2F1FE95C2F1FE94C1F1FF93C0F1FF92C0F1FF91C0
      F0FF91BFF0FF90BEF0FF90BDEFFF8FBDEFFF91BFF1FF98C9F5FE729DE0FF4858
      B3DD8033B30A0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003262C3B783B0E9FFC6E8
      FFFFB6DCFDFFB6DCFCFFB6DBFCFFB6DBFCFFB5DAFBFEB4DAFCFFB7DCFCFF9CC7
      F3FF6FA0E3FF5466C0FD6E51CB2C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000346BEC4F2484F4FA2784
      F4FF289BECFF29B8EEFF27B4EDFF27B1ECFE28B1EDFF28B2EDFF28B4EDFF28B4
      EDFF28B4EEFF28B4EEFF28B5EEFF28B5EFFF29B6EEFF29B6EEFF29B6EEFF28B6
      EEFF29B7EEFF28B7EEFF29B6EEFF29B7EEFF29B7EEFF28B7EEFF29B6EFFF29B6
      EEFF29B5EEFF29B5EFFF29B6EEFF29B7EFFF28B7EEFF28B6EEFF28B8EFFF29BA
      EFFF2795EEFF2486FDFF2880F4D24964E41C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002475ED642288FCFF2585F2FF27A2ECFF27B8EDFF28B2ECFF27B4ECFF28B3
      ECFF28B4EDFF28B5EDFF28B6EDFF28B6EDFF28B7EDFF28B7EEFF29B8EDFF29B8
      EDFF28B9EDFF29B9EEFF28BAEEFF28BAEEFF29BAEFFF29BAEEFF29B9EEFF29B9
      EFFF29B9EEFF29B9EEFF29B8EEFF29B8EEFF29B8EEFF29B8EEFF29B8EEFF29B8
      EEFF29B6EDFF29B5EDFF29B5EDFF28B6ECFF28B6ECFF29B5ECFF28B8ECFF28BB
      ECFF2894EBFF2887F9FF297EF0E74060EC280000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005368D5314970CAFE92BFEFFF93C2F3FF8DBDF1FF8FBF
      F1FF95C3F3FF9FCAF6FFA6CFF8FEA7D0F8FEA5CFF8FEA7D0F8FFA8D1F9FFA9D1
      F9FFA8D2F9FFA9D2FAFFA9D2F9FFA9D2F9FEA9D2F9FFAAD3FAFFA8D1F9FFA8D2
      F9FFA8D2F9FFA8D2F9FFA7D2F9FFA7D1F9FFA8D1F9FEA7D0F8FFA6CFF9FFA5CF
      F8FFA4CEF7FFA3CEF7FFA2CDF7FFA1CCF6FFA1CAF6FF9FCAF5FF9EC9F4FF9DC8
      F4FE9BC7F4FF9AC6F4FF99C5F3FF98C4F2FF97C3F3FF96C2F2FF95C2F2FF94C2
      F1FF93C0F2FF92BFF1FF92BFF0FF91BEF0FF8FBDEFFF8EBDEFFE90BFF1FF5676
      C7FF4F56B7470000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005369DA224575CBF7AFD2F4FFBDE2
      FFFFB7DCFDFFB7DBFDFFB6DBFCFFB6DBFCFFB5DAFCFFB4DAFCFFB7DDFDFF9CC7
      F3FF6F9EE3FF5567C0F87257D026000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002E71EA3D2685F6F72786F5FF29A3
      EEFF28BBEFFF28B4EFFF27B4EEFF27B5EEFF27B5EEFF28B5EEFF28B6EEFF28B6
      EFFF28B7EFFF28B7EFFF28B8EFFF28B9F0FF29B8EFFF29B9EFFF29B9EFFF29B8
      EFFF28B9EFFF28B9EFFF29B9F0FF29B9EFFF28BAEFFF28B9EFFF28B9EFFF29B9
      EFFF28B8EFFF28B8F0FF28B9EFFF28BAF0FF28B9EFFF29B9EFFF27B9F0FF27B9
      EFFF29C0F2FF2A9CEEFF2686FDFF2480F2D23155F31500000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002B75
      F148228BF9FF2487F3FF27A2EDFF28B8EDFF27B3EDFF28B4EDFF27B6EDFF28B6
      EDFF28B7EEFF28B8EEFF28B8EEFF28B9EEFF28BAEEFF28BAEFFF29BBEFFF29BB
      EEFF28BBEFFF28BBEFFF28BDF0FF28BDF0FF28BCF0FF28BCF0FF28BCF0FF28BD
      F0FF28BCEFFF29BBEFFF28BAEFFF29BAEFFF29B9EFFF29B9EFFF28BAEEFF28BA
      EFFF29B9EEFF29B9EEFF29B8EEFF29B8EEFF29B8EDFF29B7EDFF28B7ECFF28B8
      ECFF28BDEDFF2895EAFF2787FAFF287DF1D74059F21400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000425EC4645F89D9FF9ECAF6FF93C0F2FF97C3F4FFA0CB
      F6FFA3CDF7FFA5CFF9FFA6D0F8FFA7D1F9FFA9D2F9FFAAD3F9FFABD4FAFFACD4
      FAFFABD5FBFFACD5FBFFACD5FBFFADD5FBFFACD5FAFFACD5FBFFACD4FAFFACD4
      FBFFABD4FAFFAAD4FAFFAAD4FAFFAAD3FAFFAAD3FAFFAAD3FAFFA8D2F9FFA7D2
      F9FFA7D1F9FFA6D0F8FFA5CFF7FFA4CEF8FFA3CDF7FFA2CCF7FFA0CCF6FF9FCA
      F5FF9EC9F5FF9CC8F4FF9AC7F4FF99C6F3FF98C4F4FF98C4F2FE96C4F3FE96C3
      F3FF96C2F3FF95C2F2FF94C1F1FF92C0F1FF91BEF0FF8FBDF0FF98C7F6FF6691
      D7FF4A5BBF870000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003C67C190709BE2FFC4E6FDFFB8DD
      FDFFB7DDFDFFB7DCFCFFB7DCFCFFB6DCFCFFB5DBFCFFB5DAFCFFB8DDFEFF99C4
      F2FF6F9EE3FF5767BEED8C40CC14000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003060E3252484F5EC2789F8FF28A4EFFF29BF
      F0FF28B6F0FF29B6F0FF28B7F0FF28B8EFFF28B8F0FF28B8F0FF28B9F0FF28BA
      F0FF28BAF0FF28BAF1FF28BBF1FF28BBF1FF29BBF0FF29BCF0FF29BCF1FF29BC
      F0FF29BCF1FF28BCF1FF29BCF1FF29BBF1FF28BCF1FF28BCF1FF28BCF1FF28BD
      F1FF29BCF1FF28BCF1FF28BCF1FF29BDF2FF29BCF1FF29BCF1FF28BDF1FF27BD
      F1FF27BDF2FF29C5F3FF299CEEFF2586FEFF267EEFC59249FF07000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000376EEA251F88
      F5EE2389F7FF27A6EEFF28BBEFFF28B4EEFF28B7EFFF28B8EFFF28B8EFFF28B9
      EFFF28BAEFFF28BAF0FF28BBEFFF29BCF0FF28BCEFFF28BDF0FF29BDF0FF29BE
      F1FF28BEF1FF28BFF1FF28C0F2FF28C0F2FF28C0F2FF28C0F2FF28C1F2FF28C1
      F2FF28BFF2FF29BEF1FF29BEF1FF29BDF1FF29BDF0FF29BCF0FF29BDF0FF28BD
      F1FF29BCF0FF29BCF0FF29BBF0FF29BBEFFF29BAEFFF29BAEEFF28B9EDFF28B9
      EDFF27B9EDFF28BFEEFF2890ECFF288AFFFF2B7AEABA00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003E60C387719DE6FFA2CEF9FF9AC6F5FFA3CDF7FFA5CF
      F8FFA6D0F8FFA8D1F9FFA9D2F9FFAAD3FAFFABD4FAFFADD5FBFFAED6FBFFAFD7
      FCFFAFD6FCFFAFD6FCFFAED6FCFFAED6FCFFAFD7FBFFAFD7FBFFAED6FBFFAED6
      FBFFADD6FBFFADD6FCFFADD6FBFFADD5FBFFACD5FBFFACD5FBFFABD4FAFFAAD4
      FAFFA9D3FAFFA8D2F9FFA8D1F9FFA7D1F8FFA5CFF8FFA4CEF8FFA3CDF7FFA2CC
      F7FFA0CBF5FF9EC9F5FF9CC8F5FF9AC7F4FF9AC6F4FF99C5F4FF98C5F3FE98C4
      F3FF97C4F3FF96C3F3FF94C2F2FF93C1F2FE92C0F1FF91BEF1FF9BCAF7FF6B98
      DCFF455FBC8C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004266C5234172C7F6ACCEF2FFC0E4FEFEB7DC
      FDFEB7DCFDFFB6DCFCFFB6DBFCFFB6DBFCFFB5DAFCFEB4DAFCFFB8DDFDFF94C1
      F1FF6C9AE2FF5367BFE2CC4DE60A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009900FF052280F0C8268BFFFF28A1EFFF28C2F2FF28BA
      F1FF27BAF1FF28BAF1FF28BBF2FF28BBF2FF28BBF1FF28BCF1FF28BDF2FF28BD
      F3FF27BEF2FF28BEF3FF28BEF3FF28BFF3FF28BFF2FF28BFF3FF28BFF2FF28BE
      F2FF28BEF2FF29BEF2FF28BFF3FF28BFF3FF28BFF3FF28BFF3FF28C0F3FF28C0
      F3FF28C0F3FF28C0F3FF28C0F3FF28C0F2FF28BFF2FF28BFF2FF27C1F3FF27C1
      F3FF27C1F3FF27C1F3FF29C8F4FF2997EEFF258CFFFF2578EF9D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00FF012380EFC4248A
      FFFF279BEEFF28BEF0FF27B7EFFF28B8EFFF28BAF0FF27BAF0FF28BBF0FF27BC
      F0FF27BDF1FF27BEF1FF28BEF1FF28BEF2FF28BFF1FF29C0F1FF28C1F3FF28C2
      F3FF28C3F4FF28C3F4FF28C3F5FF27C3F6FF27C4F7FF28C4F8FF27C3F8FF27C3
      F7FF28C2F6FF28C2F4FF28C2F4FF28C2F3FF29C1F2FF28C1F2FF29C0F1FF29BF
      F2FF29BFF2FF29BEF0FF29BEF0FF29BEF1FF29BDF0FF29BDEFFF29BCEFFF29BC
      EFFF28BCEFFF28BDEFFF29BBF0FF288AECFF278FFEFF2975E976000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003A63C6AF7DA9EBFFA5D0F9FFA0CBF6FFA4CFF8FFA7D1
      FAFFA9D3FAFFACD4FAFFABD4FAFFADD6FBFFAED6FBFFAFD6FCFFB0D8FCFFB0D8
      FCFFB0D8FCFFB0D9FDFFB1D9FCFFB1D9FDFFB1D9FCFFB1D9FDFFB0D8FCFFB0D9
      FCFFAFD8FCFFAFD8FDFFAFD8FCFFAFD8FCFFAFD7FCFFAED7FCFFAED6FCFFADD5
      FBFFACD5FBFFABD4FBFFAAD3FAFFA9D3F9FFA7D1F9FFA5CFF9FFA4CEF8FFA3CD
      F7FFA1CCF6FFA2CDF7FFA2CCF7FFA1CBF7FFA0CAF6FF9FCAF6FF9DC9F5FF9CC8
      F5FF9AC7F5FF99C6F5FF9AC6F5FF99C5F4FF98C5F4FF9AC7F5FF9DCAF5FF5F80
      CBFF4A56B93E0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003564C7BB7EABE7FFC7E9FFFFB6DCFDFFB7DC
      FDFFB6DCFCFFB6DCFDFFB6DBFDFFB6DBFDFFB5DBFCFFB4DAFCFFB8DDFCFF8CBA
      EEFF6A98E1FF526AC3D3FF00FF02000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000297CED82258EFFFF2795EEFF29C3F3FF27BEF3FF28BE
      F3FF28BDF3FF28BDF3FF28BFF3FF28BFF3FF28C0F3FF28C0F4FF28C1F4FF28C2
      F5FF28C2F4FF27C2F5FF28C2F5FF28C3F5FF29C3F6FF29C3F6FF29C3F5FF28C3
      F5FF28C2F4FF28C2F5FF28C3F5FF28C4F6FF28C3F6FF28C3F6FF28C4F6FF28C5
      F6FF28C4F6FF28C4F5FF28C4F4FF27C3F5FF28C2F4FF28C3F4FF27C4F5FF27C5
      F5FF27C5F5FF27C5F5FF27C6F5FF2AC9F6FF2690F1FF2588FFFF2D73EE5B0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003075EE6B248DFFFF258E
      EEFF29C0F1FF29BAF1FF28BAF1FF28BBF1FF28BCF1FF28BDF1FF28BEF2FF28BF
      F2FF28BFF2FF28C1F3FF28C1F3FF27C2F3FF28C3F3FF28C4F4FF28C5F5FF27C6
      F8FF27CEFFFF28D8FFFF29DAFFFF2BD7FFFF2BD5FDFF2DD2F9FF2CD1F8FF2BD6
      FEFF2AD8FFFF2BDAFFFF28D6FFFF27CCFFFF28C5F8FF28C6F6FF29C4F5FF29C3
      F3FF29C3F3FF29C2F3FF29C1F2FF2AC1F2FF2AC0F2FF29C0F1FF29C0F1FF29C0
      F1FF29C0F0FF29BFF0FF29C2F1FF29B4F0FF268AF2FF2683F4F83366F2280000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00FF013A66C2CA88B5EFFFA8D2FBFFA4CEF8FFA7D0F9FFAAD3
      FAFFACD4FBFFADD6FBFFAED6FBFFAFD7FCFFB0D7FCFFB1D8FCFFB2D9FDFFB2D9
      FDFFB2D9FCFFB2D9FDFFB3DAFDFFB3DAFDFFB3DAFDFFB3DAFDFFB2D9FDFFB2DA
      FDFFB1D9FDFFB2D9FDFFB2DAFDFFB1D9FDFFB1D9FDFFB1D9FCFFB0D8FCFFAFD7
      FCFFAED6FBFFAED6FBFFADD5FAFFACD4FAFFAAD3FAFFA8D2F9FFA6D0F9FFA5CF
      F8FFA2CDF7FE93C2F1FF90BFEFFF8DBDEEFF8BBBEEFF8ABAEDFF88B9ECFF87B8
      EBFE84B5EBFF82B4EBFF83B3E9FF81B1E8FE7DAEE6FF80B0E7FF6E99E0FF5164
      BDBC000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003866C97F5788DDFFBEDFFAFEBADFFEFFB6DBFCFFB6DC
      FDFFB6DBFDFFB6DBFCFFB6DBFDFFB6DBFDFFB5DBFCFFB6DBFCFFB1D7FAFF81B2
      EBFF6A97E1FF4E69C1C400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003D6DF32A2486F5F9268AF3FF28BFF4FF27C4F5FF28C3F5FF28C2
      F5FF28C1F5FF28C1F5FF28C2F5FF28C3F5FF28C6F6FF27C6F6FF28C6F6FF28C6
      F6FF28C6F6FF27C6F7FF27C7F7FF27C6F7FF28C6F9FF28C6FAFF28CAFEFF27CA
      FFFF28CCFEFF28CBFEFE28CCFFFF28CAFCFF27C8F9FF28C7F8FF28C7F8FF28C7
      F7FF28C8F7FF27C8F7FF27C8F6FF28C8F6FF27C6F4FF27C7F5FF27C7F6FF27C8
      F6FF27C9F6FF27C9F7FF27C8F7FF27CDF7FF29BEF6FF2685F7FF237EF0EB3D61
      F315000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A60EA182284F4ED2487F8FF29B7
      F3FF28C4F3FF28BEF3FF28BEF2FF28BEF2FF28BFF2FF28BFF2FF27C1F3FF28C1
      F3FF28C2F3FF28C3F4FF28C4F4FF28C5F5FF28C6F6FF27CAFBFF28DAFFFF2DD8
      FEFF2EB9D3FF2D8F9BFF2B737BFF2A5458FF274E50FF274B4CFF274949FF274F
      51FF285658FF2B767DFF2D98A6FF2EC1DAFF2BD8FFFF26D7FFFF27C9FAFF28C7
      F5FF28C6F5FF29C5F4FF28C4F3FF29C4F3FF2AC3F2FF2AC3F2FF29C3F2FF29C3
      F2FF29C3F1FF2AC2F2FF29C0F2FF2AC7F2FF29A6EFFF288BFFFF2677EDBA0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005555E309406AC6DF90BDEEFFA9D3FBFFA5CFF8FFA9D2FAFFACD4
      FBFFADD5FBFFAFD7FCFFAFD8FCFFB1D9FCFFB2D9FDFFB2D9FDFFB3DAFCFFB3DA
      FDFFB4DAFDFFB4DBFDFFB4DBFDFFB4DBFDFFB4DBFDFEB4DBFEFFB4DBFDFFB4DB
      FEFFB3DBFDFFB3DAFDFFB3DBFEFFB3DAFEFFB3DAFDFFB2D9FDFFB1D9FDFFB0D9
      FDFFAFD8FCFFAFD7FCFFAED6FCFFADD6FBFFACD5FBFFABD4FAFFA7D1F9FFABD5
      FBFF8BBCEEFF5D98DAFF5F98DBFF5E97DAFF6098D9FF5F97D9FF5D95D8FF5D95
      D7FF6097D9FF5F96D8FF5F95D9FF5D93D8FF598DD3FF5587CFFF537CCFFF4E6D
      C9DA5365C5530000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003D65CA604679CDFFA5CBF1FFBEE2FEFEB5DAFDFFB5DBFCFFB5DB
      FCFFB5DBFCFFB5DBFDFFB5DBFCFFB5DBFCFFB4DAFCFFB8DDFEFFA4CDF6FF7CB0
      EAFF6995DFFF4D61BABF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002880F2AC268BFFFF27B0F3FF28CCF7FF28C6F6FF29C6F7FF29C6
      F7FF28C5F7FF28C5F7FF29C5F6FF28C6F7FF28C9F8FF28CAF8FF28CAF9FF27C9
      F8FF27C8F9FF27CDFFFF27D7FFFF2ADEFFFF2CD8FFFF2DD2FAFF2CC9EAFF2BC7
      E6FF2BC8E5FE2BC8E5FF2BC7E7FF2BD5FAFF2ADBFFFF29DFFEFE27D8FFFF27CF
      FFFF27CCFAFF27CCF9FF27CBF8FF27CCF8FF28CAF7FF27CAF7FF27CBF7FF28CB
      F8FF28CCF8FF28CBF8FF27CBF8FF27CAF8FF29D3F9FF28A4F2FF2688FFFF277A
      EC95000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000277CF088228CFFFF269EF2FF2ACD
      F6FF28C2F4FF28C3F4FF28C2F3FF28C2F4FF28C3F4FF28C3F4FF28C4F4FF28C5
      F4FF28C6F5FF28C7F6FF28C7F6FF27C8F9FF29DBFFFF2ED3F3FF2D92A0FF294E
      4EFF252723FF231E1AFF22201CFF222421FF212622FF212623FF212623FF2124
      21FF212320FF211E1BFF221D19FF252B26FF2A5557FF2E9DADFF2BD8FAFF28D8
      FFFF27C9F8FF28C9F6FF28C8F5FF29C7F5FF2AC6F4FF2AC7F5FF2AC7F4FF2AC7
      F4FF2AC6F4FF2AC6F4FF2AC5F4FF2AC3F3FF2CC9F4FF2793F0FF2887FDFF326C
      ED47000000000000000000000000000000000000000000000000000000000000
      000000000000496DED0E416CC6E797C1EFFFA9D3FCFFA7D0F9FFABD3FAFFAED6
      FBFFAFD7FBFFB1D7FCFFB1D9FDFFB3DAFDFFB3DAFDFFB3DBFDFFB4DBFDFFB5DB
      FDFFB5DCFDFFB6DCFEFFB5DCFEFFB5DCFDFFB6DCFEFFB5DCFEFFB5DCFDFFB5DC
      FEFFB5DCFEFFB5DBFDFFB5DBFEFFB4DBFEFFB4DBFEFFB4DBFEFFB3DBFEFFB2D9
      FDFFB1D9FCFFB1D8FCFFB0D8FCFFAFD7FBFFAED5FCFFADD5FBFFAAD3FAFFA8D2
      FAFFA8D2F9FFA5CFF7FFA2CDF6FFA0CCF5FFA0CCF6FFA0CCF5FFA1CCF6FFA0CB
      F5FFA0CAF7FF9FCAF6FF9DC9F5FF9CC8F4FF9BC6F4FF98C4F2FF92C0EFFF7BA9
      E6FF4F74CAFC5A65CA3000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000406DCA604276CFFF99C1EDFFC0E4FFFFB4D9FCFFB5DAFCFFB4DAFCFFB5DB
      FCFFB5DBFDFFB5DBFDFFB5DBFDFFB5DBFCFFB3D9FBFFB8DDFDFF96C2F1FF7CAF
      EAFF6992DFFF5560C0C100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003A6EF32C2482F5FC2695F4FF29D0F9FF29C8F8FF29C8F8FF29C9F8FF28CA
      F9FF27C9F8FF28C9F8FF28C9F8FF28CAF8FF27CBF9FF28CBFAFF26CCFCFF26D7
      FFFF2ADFFFFF2CCAEBFF2DA6BBFF2D828CFF2A5B60FF274C4DFF253633FF2333
      2FFF233430FF23332FFF24322EFF264949FF28575AFF2B7981FF2AA1B3FF2CCA
      E7FF2AE0FFFF26DBFFFF26D0FCFF28CFFAFF27CDF9FF27CDF8FF27CDF8FF27CD
      F9FF28CCF8FF28CDF9FF28CDF9FF28CDF8FF27CBF8FF29CAF7FF288AF2FF277B
      F3FB3960EC280000000000000000000000000000000000000000000000000000
      00000000000000000000000000004747E3122180F0EC2388F8FF29C1F5FF29C8
      F6FF28C7F6FF28C7F5FF28C6F5FF28C6F5FF27C6F6FF28C7F7FF27C8F6FF28C9
      F7FF28CAF7FF28C8F7FF25CFFEFF2BE1FFFF2FA3B1FF283E3CFF201A16FF2123
      20FF222D2BFF232E2DFF222E2CFF222F2DFF232E2DFF232E2DFF232E2CFF232E
      2CFF222E2DFF222E2CFF222E2DFF222C29FF20201EFF221B17FF284948FF2EAB
      BCFF2BE0FFFF26D1FEFF29CBF7FF29CBF7FF2ACAF6FF2ACAF6FF29CAF5FF29CA
      F6FF2AC9F5FF2AC8F6FF29C8F5FF29C7F5FF2BCEF6FF29B4F2FF2787FCFF267B
      ECBE000000000000000000000000000000000000000000000000000000000000
      0000000000005050DF10426FC7EA9EC6F2FFABD6FDFFA9D3FAFFADD4FBFFAFD7
      FCFFB1D8FCFFB2D9FDFFB3DAFDFFB4DBFDFFB4DBFDFFB4DBFDFFB5DCFEFFB6DC
      FEFFB6DDFEFFB7DDFEFFB6DDFEFFB6DDFEFFB6DDFEFFB7DDFEFFB6DDFEFFB6DD
      FEFFB6DDFEFFB6DDFEFFB5DDFEFFB6DCFEFFB5DCFDFFB4DBFEFFB4DBFEFFB4DA
      FDFFB3DAFDFFB2D9FDFFB1D8FCFFB0D7FCFFAFD7FCFFAED6FCFFACD4FAFFABD4
      FAFFAAD3F9FFA9D2F9FFA7D1F9FFA5CFF8FFA3CEF8FFA1CCF7FFA0CBF7FF9ECA
      F6FF9FCAF6FF9DC9F5FF9CC8F4FF9BC6F4FF98C4F3FF96C3F2FF96C2F3FF9ECD
      F8FF75A0E7FF475EB8B8FF00FF01000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004972
      D082487AD0FF97C1EDFFBEE4FFFFB3D9FCFFB4DAFCFFB4DBFDFFB4DBFCFFB4DB
      FCFFB5DBFDFFB6DCFDFFB5DCFDFFB5DBFDFFB4DAFCFFB4DBFCFF88B7EDFF7EAF
      EAFF6C96E0FF6369C8CF000000004060BF085164CD294169C23F466BC53E436A
      C4413E70C5424172CA434474C7444172CA434B76CC414772C8414D6DD1385A73
      E61F8055D5060000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002C80F09E258BFFFF28BBF6FF2AD1FAFF29CBF9FF28CBF9FF29CCFAFF28CC
      FAFF28CCFAFF29CBF9FF28CCFAFF29CCFAFF27CDFCFF27DAFFFF2BDFFFFF2FB2
      C5FF2B6B71FF263533FF231D19FF211C17FF21221EFF212622FF222A28FF212B
      29FF222B29FF222B29FF222B28FF222622FF21221EFF211B17FF211C18FF2531
      2DFF285F64FF2BAAB9FF2DE1FFFF28DFFFFF27D0FCFF27D0FAFF27CFFAFF27D0
      FAFF28CFFAFF28CFFAFF28CEF9FF28CEF9FF28CBF8FF29D3F9FF2BAEF2FF2886
      FFFF2978EF9D0000000000000000000000000000000000000000000000000000
      00000000000000000000000000002871EE662389FFFF26A1F3FF2AD2F8FF29C9
      F8FF28CAF7FF28CAF7FF28CAF7FF28CAF7FF28CBF7FF28CBF8FF27CDF8FF28CE
      F8FF27CCF9FF26D6FFFF2DD7F4FF2C6A6FFF231A16FF222522FF232F2DFF222E
      2CFF232F2DFF222A28FF21201DFF201B18FF201F1DFF21201DFF22211EFF201D
      1AFF201E1BFF212422FF222C2AFF222E2CFF222E2CFF222F2DFF212320FF241D
      18FF2C6D72FF2ED7F4FE28D8FFFF29CEF9FF29CDF8FF2ACDF7FF2ACDF7FF2ACD
      F7FF2BCCF7FF2BCCF7FF2ACBF7FF2ACBF7FF2ACAF7FF2BD0F7FF288EF1FF2681
      F4FF3468EF310000000000000000000000000000000000000000000000000000
      0000000000004B5AE111426EC7EBA4CAF4FFAED7FCFFABD4FAFFAED6FBFFB0D8
      FCFFB2D9FCFFB4DAFDFFB4DBFDFFB5DBFEFFB5DCFDFFB5DCFEFFB7DCFEFFB7DD
      FEFFB7DEFEFFB7DEFEFFB7DDFEFFB7DDFEFFB6DEFEFFB7DEFEFFB7DEFDFFB7DD
      FEFFB7DDFEFFB7DDFEFFB7DDFEFFB7DDFEFFB6DCFEFFB5DBFEFFB5DBFEFFB4DB
      FDFFB3DAFEFFB2DAFDFFB1D9FCFFB1D8FDFFB0D8FCFFAFD7FCFFAED5FBFFADD5
      FBFFABD4FBFFAAD2FAFFA9D1F9FFA7D0F8FFA5CFF8FFA3CEF7FFA2CDF7FFA1CC
      F6FFA0CBF6FF9FCAF6FF9DC8F5FF9BC7F4FF99C5F3FF97C4F3FF96C2F2FF98C5
      F4FE8FBCF1FF4E6BBDF45D51C516000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004E6ABF243C6BC9B25283
      D9FFA1C7F0FFBDE3FFFFB1D8FCFFB3D9FCFFB4DAFCFFB4DBFDFFB4DAFCFFB4DB
      FCFFB6DBFCFFB5DCFDFFB6DBFDFFB5DBFCFFB5DBFCFEAED7F9FE7FB0EAFF7EAF
      EAFF648FD7FF4F72C5E6436FC4B44874C9DB4776C7F8497ACAFF4778C9FF497A
      CBFF4A7CCEFF497CCEFF497BCBFF487BCBFF4578CBFF4579CCFF4478CAFF4377
      C9F4406BC6D73364C2A4416BC24F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005555
      F315277CF2F12796F7FF29D3FAFF29CDFBFF29CDFBFF29CDFAFF29CDFAFF28CE
      FBFF28CEFBFF28CEFAFF27CEFAFF26D2FFFF2BE2FFFF2DB2C3FF285758FF2320
      1CFF201C19FF222927FF232E2CFF222E2CFF222E2BFF222D2CFF232E2BFF222D
      2CFF232E2CFF222E2CFF222E2CFF222D2CFF222D2BFF222D2BFF222D2CFF212B
      28FF201E19FF221C18FF295050FF2EAEBCFF2CE5FFFF26DAFFFF28D1FBFF28D2
      FBFF28D1FBFF28D1FBFF27D0FAFF27CFFAFF28CEF9FF28CDF9FF2BD1F9FF288F
      F3FF267AEFF42758EB1A00000000000000000000000000000000000000000000
      00000000000000000000000000002180F0C6228CFEFF2AC3F7FF29D1F9FF29CC
      F9FF29CDF9FF29CDF9FF29CDF9FF28CDF9FF29CFF9FF29CFF9FF28D0FAFF28CF
      FAFF27DBFFFF2FD1E9FF294746FF211815FF222E2BFF232F2DFF222F2BFF2121
      1FFF231C1AFF273633FF296164FF2C848EFF2C9CAEFF2CA7B9FF2FAABBFF2C90
      9DFF2D787EFF2B5150FF252A27FF221A18FF222724FF232F2EFF222E2DFF222D
      2CFF211A16FF284848FF2ECFE8FF28DAFFFF29D0FAFF2AD0FAFF2BD0F9FF2ACF
      F9FF2BD0F8FF2AD0F9FF2AD0F9FF2ACFF9FF2BCEF8FF2CD7F9FF2BAFF3FF2885
      FFFF2D74EF930000000000000000000000000000000000000000000000000000
      0000000000003C5AD2113E70C5EBA5CAF3FFAED7FBFFABD5FAFFAED6FBFFB0D8
      FCFFB2D9FDFFB4DBFDFFB4DBFDFFB5DCFDFFB6DCFDFEB6DDFEFFB7DDFEFFB8DD
      FEFFB8DFFEFFB8DEFEFFB8DEFEFFB8DEFEFFB9DFFEFFB9DFFEFFB8DEFEFFB8DE
      FEFFB7DEFEFFB8DDFEFFB8DEFEFFB7DDFEFFB7DDFEFFB7DCFEFFB6DCFDFEB5DC
      FDFFB4DBFDFFB3DAFDFFB2D9FDFFB2D9FCFFB0D8FCFFAFD7FCFFAFD6FBFFAED6
      FBFFADD5FBFFABD4FAFFAAD2FAFFA9D2F9FFA7D0F8FFA6D0F8FFA4CFF7FFA3CD
      F7FFA0CCF6FF9FCAF5FF9DC9F5FF9CC7F4FF99C6F3FF98C5F3FF97C3F2FF97C4
      F3FF98C6F3FF5778C5FF4851B739000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004C6FCB6C4171C8EF689AE0FFAED4
      F5FFBAE0FEFFB1D7FBFFB2D8FBFFB3D9FCFFB4DAFCFFB5DAFDFFB5DAFCFFB5DB
      FDFFB5DBFDFFB5DCFCFFB5DBFCFFB4DAFCFFB8DEFDFFA2CEF5FF75A7E6FF79A9
      E6FF5481CEFF5786D3FF70A3E9FF7EADEBFF8BBAEDFF90BCEDFF94C0EDFF99C3
      EEFF9DC6F0FF9CC5EFFF9BC3EEFF99C3EEFF9BC4EDFF9BC4EDFF9EC7EFFFA0C8
      F0FF95C0EEFF7EABE7FF5483D0FF3E67BFA46363D51200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002E78
      F2642684FFFF2BB4F6FF2AD5FCFF29CEFBFF29CEFBFF2ACEFBFF28CFFBFF28D0
      FBFF29D1FBFF28CFFCFF27DCFFFF2ED4F0FF2A6F74FF231E1BFF21201DFF222E
      2BFF222E2CFF222D2BFF222D2BFF222E2BFF222E2CFF222F2CFF222E2CFF222F
      2CFF222F2DFF222F2CFF222E2CFF222D2BFF222E2BFF222D2BFF212D2BFF212D
      2BFF222D2BFF222D2BFF21211EFF231C19FF2A6366FF2ED0E6FF29E2FFFF27D1
      FCFF28D2FBFF28D2FBFF28D1FBFF28D0FBFF28CFFAFF29CEFAFF2BD6FAFF2AAD
      F4FF2883FFFF2973EC6A00000000000000000000000000000000000000000000
      000000000000000000003665EB261F85F3FB2598F7FF2CD7F9FF29CFFAFF2ACF
      FAFF2ACFFAFF2AD0FAFF29D0FAFF29D1FAFF29D2FBFF2AD2FBFF29D2FBFF27DA
      FFFF30D4EAFF284140FF211C19FF232F2DFF222F2DFF21201FFF23221EFF2B5B
      5AFF30A2ADFF31D3ECFF2DE8FFFF2BEAFFFF2CE4FFFF2BE2FFFF2BE4FFFF2CE6
      FFFF2DE8FFFF30E2FFFF30C7DBFF2E8C93FF284041FF211A17FF222825FF222F
      2DFF22312EFF211E1AFF273F40FF2FD1E9FF29DAFFFF2AD3FCFF2BD3FBFF2BD3
      FBFF2BD3FAFF2BD2F9FF2BD3FBFF2BD3FAFF2BD2FAFF2BD3F9FF2ECBF7FF298B
      F9FF2A7DEEDD5555FF0600000000000000000000000000000000000000000000
      000000000000495BDB0E3E6FC6E6A2CAF1FFB1D9FDFFADD5FAFFB0D7FBFFB1D9
      FCFFB3DAFDFFB5DBFDFFB4DBFDFFB6DCFDFFB7DCFEFFB7DDFEFFB7DDFEFFB8DE
      FEFFB9DEFEFFB9DEFEFFB9DEFEFFB8DEFEFEB9DFFEFFB9DFFEFFB8DFFEFFB8DF
      FEFFB8DDFEFFB8DEFEFFB9DFFEFFB9DEFEFFB7DDFEFFB8DDFEFFB7DDFEFFB5DC
      FDFFB4DBFDFFB4DAFEFFB4DAFDFFB2D9FDFEB1D9FCFFB0D8FCFFB0D7FBFFAED6
      FBFFADD5FBFFACD4FAFFABD3FAFFAAD3F9FFA8D1F9FEA8D0F8FFA5CFF8FFA4CE
      F7FFA1CDF7FF9FCBF5FF9EC9F5FF9CC8F5FF9BC6F3FE99C5F3FF99C4F3FF98C5
      F3FF97C4F2FF5779C8FF4955BA3F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005F73D7334374CEB24C81D8FF85B2E9FFB8DFFCFEB4DB
      FDFFB0D7FBFFB2D8FBFFB3D8FCFFB4DAFCFFB4DAFCFFB4DBFCFFB5DBFCFFB5DB
      FCFFB5DBFDFFB5DBFCFFB5DBFCFFB4DAFCFFBADFFDFF8DBCEEFF75A8E6FF6698
      DBFF5888D2FF8ABAEFFF92C1F3FF95C3F4FF98C4F5FF9BC7F6FEA1CCF7FFA5CF
      F9FFA8D0FAFEAAD3FAFFA9D2FBFEABD4FBFFAFD7FCFFB2D8FDFFB5DBFEFFB7DD
      FFFFBCE2FFFFC2E7FEFEB8DCF7FF6E9CE0FF3F64BFBAAA55FF03000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000287D
      EFBB2791FFFF2CCFFAFF2BD1FBFF2BCFFBFF2ACEFBFF2ACEFBFF29D1FBFF29D2
      FBFF28CFFCFF2AE0FFFF33BED2FF293D3CFF201915FF222D2AFF222E2CFF222D
      2BFF222D2BFF232F2CFF222A28FF222320FF221D1AFF221C17FF221F1AFF231F
      19FF231E1AFF231E1AFF221D1AFF231C19FF201B17FF21211DFF212723FF222C
      2AFF222D2BFF222D2AFF222D2BFF222D2BFF211B18FF26312FFF2FB0BFFF2BE5
      FFFF28D0FCFF29D1FBFF29D1FBFF29D0FBFF28CFFAFF29CFFAFF29D0FAFF2CCB
      F8FF298AFCFF2776EEB700000000000000000000000000000000000000000000
      000000000000000000002C7BF45D2288FFFF29ADF6FF2EDBFCFF2AD2FBFF2AD2
      FCFF2AD3FBFF2AD3FBFF2AD3FBFF2AD3FCFF2AD4FCFF29D4FBFF28D4FDFF30DF
      FAFF2C5051FF211C18FF22302FFF222928FF221A17FF2B5456FF30B8C5FF2EEA
      FFFF29E8FFFF29DBFFFF29D9FFFF29DAFEFF2AD9FEFF2AD9FEFF2AD9FDFF2AD9
      FDFF2AD8FDFF29D8FFFF29DEFFFF2BE9FFFF31DDF7FF2F929BFF263131FF211C
      19FF222E2DFF222E2EFF211B19FF2A575AFF2FE2FDFF28D6FEFF2BD6FCFF2BD6
      FCFF2BD5FBFF2BD5FBFF2BD6FCFF2BD5FCFF2BD3FAFF2BD3FBFF30DBFBFF2C9C
      F4FF2A80F2FE2F6DEF3100000000000000000000000000000000000000000000
      000000000000AA55FF033F6EC6D59DC6F1FFB5DDFFFFAFD7FBFFB1D8FCFFB3DA
      FCFFB4DBFDFFB5DBFDFFB6DCFDFFB7DCFEFFB7DDFDFFB8DEFEFFB8DFFEFFB9DF
      FEFFB9DFFEFFB9DFFEFFBADFFEFFB9DFFEFFBAE0FEFFBADFFEFFB9DFFEFFB9DF
      FEFFB8DEFEFFB8DFFEFFBADFFEFFB9DFFEFFB9DEFEFFB8DEFEFFB7DDFEFFB7DD
      FEFFB5DCFEFFB5DBFEFFB4DBFDFFB3DAFEFFB2DAFDFFB2D9FDFFB0D8FCFFAFD7
      FBFFADD6FBFFACD5FBFFABD4FAFFAAD3F9FFA9D2F9FFA7D1F9FFA6CFF8FFA4CE
      F7FFA1CDF7FFA0CCF6FF9EC9F5FF9CC8F4FF9BC6F4FF9AC6F3FF98C3F3FF99C6
      F5FF8AB9ECFF4F6BBCFB6753C825000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8002506ECE435279D0A44B73CCFB5F90DEFFA1CAF1FFB8E0FEFEADD6FBFFAFD6
      FAFFB0D8FBFFB1D8FBFFB3D9FCFFB3DAFCFFB4DAFCFFB5DBFCFFB5DBFCFFB5DB
      FCFFB5DBFCFFB5DBFCFFB4DAFCFFB6DBFDFFB1D8F9FF78ACE7FF78AAE7FF5A8C
      D5FF79ACE7FF89BAEEFF8EBCF0FF92C0F1FF98C4F3FF9CC8F4FFA0CBF5FFA4CE
      F7FFA6D0F8FFA9D2F9FFA8D0F9FFAAD2F9FFACD4FAFFAFD7FBFFB1D8FBFFB2D9
      FBFFB2D9FBFFB1D8FBFEB9E1FFFFB8DCF7FF517FCEFF3F64C045000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000515EF213237E
      F2EC29A2FBFF2EDAFCFF2BCFFCFF2BCFFCFF2CCDFBFF2BCCFBFF2ACFFBFF2ACE
      FBFF2AE0FFFF31B6C7FF252A27FF22221FFF232F2DFF222D2BFF222E2CFF232C
      28FF201E1BFF201C19FF25322FFF295355FF2B787FFF2B848FFF2FA4B3FF2FAE
      BDFF31ACBDFF32AEBEFF30ADBDFF2E8F9EFF2C7D85FF295A5EFF28403FFF2325
      22FF1F1A17FF212523FF232E2BFF232D2BFF222F2DFF212421FF231E1DFF31A1
      AFFF2BE3FFFF28CFFCFF29D1FBFF29D0FBFF29D0FBFF29D0FAFF29CEFAFF2BD9
      FBFF2B99F6FF2775ECEF4747E312000000000000000000000000000000000000
      000000000000000000002987F59D238CFFFF2DC0F8FF2ED9FDFF2BD4FDFF2BD4
      FCFF2BD5FCFF2BD5FCFF2BD6FCFF2AD5FCFF2AD6FCFF2AD5FDFF2CE4FFFF2E86
      8FFF211713FF23312FFF202321FF232524FF31959DFF31EBFFFF2BE7FFFF2ADA
      FFFF2ADAFEFF2BDAFEFF2BDBFEFF2BDBFEFF2BDAFEFF2BDAFEFF2BDAFEFF2BDA
      FDFF2BD9FDFF2BD9FEFF2BD9FDFF2BD8FDFF29D9FFFF2CEAFFFF33D3E6FF2D5E
      61FF201915FF212B2AFF22302EFF221916FF2F97A6FF2CE3FFFF2BD7FDFF2CD8
      FCFF2CD6FCFF2BD7FCFF2CD8FDFF2CD7FCFF2CD6FBFF2CD5FBFF30DEFCFF2FB3
      F6FF2E87FFFF2E76EC6A00000000000000000000000000000000000000000000
      00000000000000000000376BC0C191BAEDFFBAE2FFFFAFD8FCFFB1D9FCFFB3DA
      FCFFB4DBFDFFB5DCFEFFB6DCFEFFB7DDFEFFB7DEFEFFB8DEFEFFB9DFFEFFB9DF
      FEFFB9DFFEFFBAE0FEFFBADFFEFFBAE0FEFFBAE0FEFFBAE0FEFFB9DFFEFFB9DF
      FEFFB9DFFEFFB9DFFFFFBADFFFFFB9DFFEFFB9DFFEFFB8DFFEFFB8DEFEFFB7DD
      FEFFB6DCFEFFB5DCFEFFB4DCFDFFB4DBFEFFB3DAFEFFB2DAFDFFB0D8FCFFAFD7
      FCFFAED6FBFFACD5FBFFABD4FAFFAAD3FAFFA9D2FAFFA7D1F9FFA6CFF8FFA4CE
      F7FFA1CDF7FF9FCCF6FF9EC9F5FF9CC8F4FF9AC7F4FF99C6F3FF97C2F3FF9DCB
      F7FF76A3EBFF4B62B9B700000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004B5AC3224B74D4774D7B
      D2D04F7CD3FF4D7FD7FF76A4E0FFAFD7F9FFB3DBFEFFACD5FAFFAED6FAFFAFD7
      FAFFB0D7FBFFB1D8FBFFB3D9FCFFB4DAFCFFB4DAFCFFB4DAFCFFB5DBFCFFB5DB
      FCFFB5DBFCFFB5DBFCFFB4DAFCFFBADFFEFF9BC7F3FF72A8E6FF6FA0E1FF6697
      DBFE86B8EEFF88B8EEFF90BFF0FF95C2F1FF99C6F3FF9DC9F5FEA2CCF6FFA6CF
      F7FFA8D1F8FFABD3F9FFABD2F9FFADD4FAFFAFD6FAFFB1D8FBFFB2D8FCFFB3D9
      FBFFB3DAFCFFB3DAFCFEB3DAFBFEC1E5FEFE71A2E2FF3C66C17F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002878EF402581
      FBFF2CB4F8FF2DD9FDFF2ACEFBFF2BCCFAFF2CCAFAFF2DC9FAFF2BC9F9FF2CD7
      FFFF36BBD0FF272A27FF212421FF232E2CFF232E2CFF222B29FF211A18FF252B
      29FF296468FF2EA2B0FF2ECEE5FF2CE4FFFF2BE9FFFF29E9FFFF28E5FFFF28E4
      FFFF28E2FFFF29E3FFFF29E3FFFF2AE6FFFF2CE9FFFF2DE6FFFF32D9F6FF32B9
      D0FF2F8088FF28403FFF221B19FF232523FF232E2DFF222D2CFF222825FF231E
      1BFF2FA6B6FF2AE2FFFF29D0FCFF2AD1FBFF29CFFBFF29CEFAFF29CDF9FF2BD9
      FBFF2BAEF6FF2879F7FF3667F239000000000000000000000000000000000000
      000000000000FF00FF012486F4C92292FEFF2CD0FBFF2CD7FEFF2CD7FDFF2CD7
      FDFF2BD7FDFF2CD7FCFF2BD7FCFF2AD7FDFF2AD8FEFF2AD8FFFF30D8F8FF283B
      3AFF212825FF21211EFF283130FF33BECAFF2DEDFFFF2BDBFFFF2BDAFEFF2BDB
      FEFF2BDBFEFF2BDBFEFF2BDCFFFF2BDBFEFF2CDBFEFF2CDBFFFF2BDBFEFF2BDA
      FEFF2BDAFEFF2BDAFEFF2AD9FEFF2BD9FDFF2BD8FDFF2AD6FDFF2ADDFFFF31E9
      FFFF2E838AFF221916FF222B29FF211F1CFF2C6066FF31E6FFFF2AD8FEFF2BDA
      FDFF2BD9FCFF2CD9FDFF2BD9FDFF2CD9FDFF2CD8FCFF2CD8FCFF2DDBFDFF2DC6
      F8FF288CFFFF297DF09B00000000000000000000000000000000000000000000
      000000000000000000003669C3A581AAE8FFC0E5FFFFADD7FBFFB2DAFCFFB4DA
      FDFFB5DBFDFFB7DCFEFFB7DDFEFFB8DEFEFFB8DEFEFFB8DEFEFFB8DFFEFFB9DF
      FEFFB9E0FEFFB9E0FEFFBADFFEFFBADFFEFFBBDFFEFFBAE0FEFFB9E0FEFFB9DF
      FEFFBADFFEFFBADFFEFFBAE0FEFFB9DFFEFFB9DFFFFFB9DEFEFFB7DEFEFFB6DE
      FEFFB6DDFEFFB6DDFEFFB5DCFEFFB4DBFEFFB3DBFDFFB2DAFDFFB1D8FCFFAFD7
      FBFFAED6FBFFB3DAFEFFB4DCFEFFB1DAFDFFB0D8FDFFAFD7FCFFACD6FBFFAAD4
      FAFFA8D2FAFFA6D0F9FFA3CEF8FFA2CDF7FFA0CBF7FFA0CCF8FF9ECDF7FF84B3
      EFFF5474CDEF5157C52C00000000000000000000000000000000000000000000
      0000000000000000000000000000594EC8174E74D0934B79CFF55286DDFF5185
      D6FF5989D4FF86B2E8FFB1DAFCFFAAD3FAFFABD4FAFFAED5FBFFAFD6FBFFB0D8
      FBFFB0D7FAFFB1D8FBFFB2D9FCFFB3DAFBFFB3DAFBFFB4DAFCFFB4DAFCFFB4DA
      FCFFB4DBFCFFB4DAFCFFB4DAFCFFB9DEFDFF8ABAEDFE74A9E7FF669ADEFF72A4
      E3FE8ABCEFFF8EBDF0FF92C1F1FF97C4F3FF9CC7F4FFA0CBF6FFA4CEF7FFA7D0
      F7FFA9D2F9FFABD4F9FFADD4FAFFAFD6FAFFB0D7FBFEB2D8FCFFB3D9FCFFB4DA
      FCFFB4DBFCFFB4DCFCFFB5DCFCFFC2E6FFFF7AABE8FF2C62B685000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002B80F36C288A
      FFFF2DC1FAFF2DD2FCFF2CC8FAFF2EC4F8FF2FC1F7FF30C0F6FF2DC8FDFF36CB
      EBFF2A3A3AFF232220FF232F2DFF232F2DFF201F1CFF232624FF2C777EFF31CB
      E0FF2FEBFFFF2DE8FFFF28DDFFFF29D9FFFF29DAFEFF2AD9FDFF29DAFEFF29DA
      FDFF29D9FEFF29D9FDFF29D8FEFF2AD8FDFF29D9FEFF29D9FEFF29DAFFFF29E0
      FFFF2FE9FFFF32DDF9FF30A0ACFF283E3EFF211A16FF222B29FF232F2DFF2226
      24FF252422FF32BDD3FF2AD9FFFF2BCDFBFF2BCCFBFF2ACDF9FF29CDF9FF2BD4
      FAFF2DC0F8FF2884FFFF2D74F067000000000000000000000000000000000000
      000000000000764EFF0D2484F5E9269AFBFF30DBFDFF2CD6FEFF2DD8FEFF2DD8
      FDFF2CD8FDFF2CD8FDFF2BD9FDFF2BD9FDFF2BD9FEFF2BDAFEFF30DEFAFF2A51
      52FF200F0BFF294241FF34CFDEFF2DECFFFF2CD9FFFF2CDBFEFF2CDCFEFF2CDC
      FEFF2CDCFEFF2CDCFEFF2CDCFEFF2CDCFEFF2CDCFEFF2CDCFEFF2BDBFEFF2CDB
      FEFF2CDBFEFF2CDBFEFF2BDBFEFF2BDAFEFF2BD9FEFF2BD9FDFF2BD8FDFF29D9
      FFFF2FECFFFF32939BFF221C18FF22120EFF318B95FF2FE7FFFF2CDAFEFF2CDB
      FDFF2CDBFDFF2DDAFDFF2CDBFEFF2CDAFEFF2DDAFDFF2CD9FDFF2DDAFDFF30D5
      FAFF2992FDFF267CF1C200000000000000000000000000000000000000000000
      000000000000000000003E6FCC736695E0FFC2E4FDFFAFD8FCFFB2DAFCFFB4DB
      FDFFB6DDFEFFB7DDFEFFB7DEFEFFB8DFFEFFB9DFFEFFB8DFFEFFB8DFFEFFB9DF
      FEFFB9E0FEFFBAE0FEFFBAE0FEFFBAE0FEFFBAE0FEFFBAE0FFFFB9E0FFFFBAE0
      FFFFBAE0FEFFBAE0FEFFBAE0FFFFBADFFEFFB9DFFEFFB9DFFEFFB8DEFEFFB7DE
      FEFFB7DEFEFFB6DDFEFFB5DCFEFFB4DCFDFFB4DBFEFFB3DAFDFFB1D9FCFFAFD7
      FCFFB2D9FCFF97C5EFFF85B8EAFF84B7E9FF83B5E8FF82B4E8FF82B5E8FF80B2
      E6FF7EB0E6FF7DAFE6FF79AAE2FF78A9E1FF7AAAE2FF7AA9E0FF6693D7FF5072
      C9D54F61C13A0000000000000000000000000000000000000000000000000000
      00000000000000000000516ED12C4C76D1E05285DEFF5789D4FF6596D9FF75A6
      E4FF94C2F3FFA8D3FBFFA6D0F8FFA9D3F9FFACD5FAFFADD6FBFFAFD6FBFFB0D8
      FBFFB1D7FBFFB1D8FBFFB2D8FCFFB3D9FCFFB4DAFCFFB4DAFCFFB4DAFCFFB4DA
      FCFFB4DAFDFFB4DBFCFFB4DAFCFFB6DCFCFF83B5EBFF76AAE7FF659ADEFF75A8
      E5FE8CBCF0FF8FBEF0FF94C2F1FF98C5F3FF9DC9F5FFA2CCF6FFA5CFF7FFA9D2
      F8FFAAD3F9FFADD5FAFFADD6FAFFAFD7FBFFB1D8FCFEB3D9FCFFB4DAFCFFB5DB
      FCFFB5DCFCFFB6DDFDFFB7DDFDFFC2E7FEFE73A5E6FF3565BC81000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002B83F28E2892
      FFFF2BCCFAFF2DCCFBFF2EC4F9FF32BCF7FF37B0F4FF36AEF3FF35CEFFFF2D65
      6BFF211A15FF232F2DFF222B29FF221B17FF295659FF30C1D2FF2DECFFFF29E0
      FFFF28D9FFFF29DBFEFF29DCFEFF29DBFEFF2ADBFEFF2ADAFEFF2ADBFEFF2ADA
      FEFF2ADBFEFF2ADAFDFF2ADAFDFF2ADAFDFF2ADAFEFF2AD9FDFF2ADAFEFF2AD9
      FDFF2AD6FDFF29D6FFFF2AE5FFFF30D9F3FF2F767EFF241D1AFF212523FF232F
      2EFF211E1CFF284447FF32D1F6FF2CC7FCFF2EC5F8FF2CC7F9FF2BCBF9FF2BD0
      FAFF2FCBF9FF298AFFFF2D74F2A0000000000000000000000000000000000000
      0000000000004E71F8242281F3F829A4F9FF30E2FFFF2DD8FDFF2DD9FEFF2DD9
      FEFF2DD9FDFF2DD9FDFF2BD9FDFF2BD9FEFF2CDAFDFF2CD9FEFF2BDEFFFF2FCD
      E5FF2F9DAAFF34D7F0FF2CE8FFFF2CDBFFFF2DDCFEFF2DDCFEFF2DDCFEFF2DDC
      FEFF2DDCFEFF2CDCFEFF2CDDFEFF2DDCFEFF2CDCFEFF2CDCFFFF2CDCFEFF2CDC
      FEFF2CDCFEFF2CDBFEFF2BDBFEFF2CDBFEFF2CDBFEFF2BDAFEFF2CD9FDFF2BD9
      FDFF2AD9FEFF2EE5FEFE34B7C9FF31ACBCFF2FDEFEFF2AD9FEFF2DDBFDFF2CDB
      FEFF2DDBFEFF2DDBFEFF2DDBFEFF2DDBFEFF2DDAFEFF2DD9FEFF2ED8FDFF31DB
      FCFF2997FAFF2C7CF2E0AA1CFF09000000000000000000000000000000000000
      00000000000000000000466ED62C427BCEFEB3D4F5FFBBE1FFFFB5DCFDFFB6DC
      FDFFB8DEFDFFB9DEFEFFB8DFFEFFB9DFFEFFB9DFFEFFB9DFFEFFB9DFFEFFB9E0
      FEFFBAE0FEFFBAE0FEFFBAE1FEFFBAE0FEFFBAE0FEFFBAE0FEFFBAE1FEFFBAE0
      FEFFBAE0FEFFB9DFFEFFBAE0FEFFBADFFEFFB9E0FFFFB9DFFEFFB8DEFEFEB8DE
      FEFFB7DEFEFFB7DEFEFFB7DDFEFFB5DCFEFFB5DCFDFFB3DBFDFFB1D9FDFFB2D9
      FDFFA8D2F7FF6AA2DFFF659EDEFF649DDEFF649CDDFF639BDCFF649BDCFF6299
      DAFF6199DBFF6197D9FF5F95D7FF5E93D6FF5C90D5FF5082CDFF466DCBFF4C61
      C17C000000000000000000000000000000000000000000000000000000000000
      0000000000009249DB075171C9D16191E1FF83B3E8FF91C1F1FF97C5F5FE95C3
      F4FF9EC9F5FFA9D2F9FFAAD3F9FFACD4F9FFADD5FAFFAED6FBFFAFD6FBFFB0D7
      FBFFB0D8FBFFB1D8FBFFB2DAFCFFB3DAFCFFB3DAFCFFB4DAFCFFB4DBFCFFB5DB
      FCFFB4DBFCFFB5DBFCFFB4DAFCFFB5DBFBFF85B6ECFF7AAEE9FF669BDEFF73A7
      E4FE8DBDF0FE8FBEF0FF93C2F2FF98C5F4FF9DC9F5FFA1CBF6FFA5CFF8FFA9D2
      F9FFABD3F9FFADD5FAFFAFD7FBFFB0D7FBFFB1D9FCFFB3DAFCFFB4DBFDFFB5DB
      FCFFB6DDFDFFB7DDFDFFB9E0FEFFC6E9FEFF6397DEFF4269C355000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002985F2B62A99
      FFFF2DD2FCFF2EC6FAFF31BCF7FF36B2F4FF3BA8F2FF3DADFCFF389EC5FF2422
      1CFF242D2BFF222927FF221E18FF308592FF32E5FFFF2BE2FFFF29D9FFFF2ADB
      FEFF29DBFEFF2ADBFEFF2ADBFEFF2ADCFEFF2ADCFEFF2ADCFEFF2BDCFEFF2ADB
      FEFF2ADBFDFF2ADBFEFF2ADBFEFF2ADBFEFF2BDAFEFF2ADAFDFF2ADAFDFF2BDA
      FEFF2AD8FDFF2AD7FDFF2AD4FDFF29D6FFFF31E5FFFF35A5B7FF252D2BFF2020
      1EFF24302FFF211815FF30879EFF34C8FFFF33B7F5FF31BDF6FF2DC4F7FF2BCB
      F9FF30D1F9FF2B92FFFF2878F0BF000000000000000000000000000000000000
      0000000000003F69F23D2682FBFF2AAEF7FF30E4FFFF2FD9FDFF2DDAFEFF2DDA
      FEFF2EDAFDFF2DDAFDFF2CDAFEFF2CDAFEFF2DDAFEFF2CDAFEFF2BDAFEFF2BE0
      FFFF30E9FFFF2FDFFFFF2EDCFFFF2EDCFFFF2EDDFEFF2EDDFEFF2DDDFFFF2EDD
      FEFF2DDDFEFF2EDCFEFF2DDDFEFF2DDDFEFF2DDDFEFF2DDDFEFF2DDDFEFF2CDD
      FEFF2DDCFEFF2DDCFEFF2CDDFFFF2CDCFEFF2DDCFEFF2CDBFEFF2DDBFEFF2CDB
      FEFF2CDBFEFF2CD9FEFF2EE5FFFF2EE8FFFF2BDBFFFF2CDBFEFF2CDCFFFF2DDC
      FEFF2DDCFEFF2DDCFEFF2DDBFEFF2DDBFEFF2EDBFEFF2ED9FDFF2FD8FDFF31DF
      FDFF2B9BFAFF297BF3ED5A3CFF11000000000000000000000000000000000000
      00000000000000000000000000002F6BC4B778A4E6FFCCECFFFFB6DEFEFFB7DD
      FDFFB8DEFEFFB9DFFEFFB9DFFEFFB9DFFEFFB9DFFEFFB9E0FEFFB9E0FEFFB9E0
      FEFFBAE0FEFFBAE1FEFFBAE0FEFFBAE0FEFEBAE0FEFFBAE1FFFFBAE0FEFFBAE1
      FFFFBAE0FEFFB9DFFEFFBAE0FEFFBAE0FEFFB9E0FFFFB9DFFEFFB9DFFEFFB8DE
      FEFFB7DEFEFFB7DDFEFFB7DDFEFFB6DCFEFFB4DCFEFFB3DBFEFFB1D9FDFFB0D8
      FCFFB0D8FCFFB4DBFDFFB1D9FCFFAFD7FBFFAFD7FBFFAED6FBFFAED5FBFFACD4
      FBFFA9D2FAFFA7D1F9FFA5CEF8FFA4CEF8FFA0CBF7FF9AC8F6FF7EA5E4FF4F6D
      C7FC4965C63F0000000000000000000000000000000000000000000000000000
      000000000000566ECF4A5680D7FF8DBCEEFF99C8F6FE93C0F2FE93C0F2FF9AC5
      F3FFA6D0F7FFA9D2F8FFAAD3F9FFACD4F9FFADD5FAFFAED6FBFFAED7FAFFB0D7
      FBFFB0D7FBFFB1D8FBFFB2D9FCFFB3DAFCFFB4DAFCFFB4DAFCFFB4DBFCFFB4DB
      FCFFB4DBFCFFB4DBFCFFB3D9FCFFB7DDFCFE88B8EDFF7BAFE9FF6FA3E2FF689A
      DDFE90BFF1FE95C4F3FF9CC9F5FFA1CCF7FFA3CEF8FFA7D1F9FFADD5FBFFB0D7
      FCFFB0D7FBFFB2D9FCFFB4DBFDFEB6DCFEFFB7DEFFFFBAE0FFFFBBE0FFFFBCE1
      FFFFBFE3FFFFC5E7FFFFD0F0FFFF92BEEDFF3F73CAD95070CF10000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002383F7C229A3
      FFFF2DD4FCFF30BFF7FF37B1F4FF3BA7F2FF41A1F0FF48AFFFFF335D7AFF211C
      11FF232925FF23211CFF3794AAFF34D8FFFF2ACDFDFF29D6FDFF29DBFEFF2ADB
      FEFF2ADBFEFF2ADBFEFF2ADBFEFF2ADBFEFF2BDCFEFF2BDCFEFF2BDCFEFF2BDC
      FEFF2BDBFEFF2ADBFEFF2BDCFEFF2BDCFEFF2BDBFEFF2BDBFEFF2BDBFEFF2BDA
      FEFF2BD9FEFF2BD9FDFF2AD6FCFF2AD2FBFF2ACCFBFF30D1FFFF3AB3DAFF2738
      3CFF201E1AFF1F1C15FF2E5369FE46B3FEFE39A7F1FF35B1F3FF30BBF5FF2DC4
      F8FF30D4FAFF2A99FDFF2B79F4CB000000000000000000000000000000000000
      0000000000003B71F23D2484FBFF2CB3F8FF31E5FEFF2FDAFEFF2EDAFEFF2EDB
      FEFF2EDAFEFF2EDBFEFF2CDBFEFF2DDBFEFF2DDBFEFF2DDBFFFF2DDBFEFF2DDB
      FEFF2DDCFEFF2EDDFFFF2EDDFFFF2EDEFFFF2EDDFFFF2EDDFEFF2EDCFEFF2EDD
      FEFF2EDDFEFF2EDDFEFF2DDEFEFF2EDEFFFF2DDEFEFF2DDDFEFF2DDDFFFF2DDD
      FEFF2DDDFEFF2EDDFEFF2DDDFEFF2DDDFEFF2DDCFEFF2DDDFEFF2EDCFEFF2DDC
      FDFF2EDBFEFF2DDBFEFF2DDCFEFF2CDCFEFF2CDCFEFF2DDDFEFF2DDDFEFF2DDD
      FEFF2DDCFEFF2EDCFEFF2DDCFEFF2EDCFEFF2EDBFEFF2EDBFEFF2ED9FEFF30E0
      FDFF2AA0F9FF287DF3F04949FF15000000000000000000000000000000000000
      00000000000000000000000000004771D02B3D70C9FA9ABAE9FFD4F2FFFFBDE4
      FFFFBAE0FDFFBAE0FEFFB9DFFEFFBADFFEFFB8DEFEFFB9DFFEFFB9E0FEFFB9E0
      FEFFBAE1FEFFBAE1FFFFBAE0FEFFBAE0FFFFBAE0FFFFBAE0FEFFBAE0FFFFBAE0
      FEFFBAE0FFFFB9E0FFFFB9E0FEFFBAE0FEFFB9DFFFFFB9DFFFFFB8DFFEFFB8DE
      FEFFB7DEFEFFB7DDFEFFB6DDFEFFB6DCFEFFB5DCFEFFB4DBFEFFB2D9FCFFB0D8
      FCFFAFD7FCFFACD5FBFFACD4FBFFABD3FAFFAAD3FAFFA9D2F9FFA7D1F9FFA6CF
      F8FFA5CFF8FFA3CDF8FFA1CBF7FFA0CAF6FF9DC9F5FF9CC8F5FFA6D3FAFF77A2
      E2FF3F63C0B90000FF0100000000000000000000000000000000000000000000
      0000000000004E6AC9806A99E7FF9BC8F6FF93C0F1FE96C2F2FF97C4F2FFA0CA
      F5FFA4CEF7FFA6CFF8FFA9D2F8FFAAD3F9FFACD5FAFFAED6FBFFAED6FAFFAFD7
      FBFFB0D7FBFFB1D8FBFFB2D9FBFFB3D9FCFFB3DAFCFFB4DAFCFFB4DBFCFFB4DA
      FDFFB4DBFCFFB4DBFCFFB2DAFCFFB2D9FBFF81B2EAFE7EB0EAFF6D9FE1FF5487
      D2FF6498DDFF6EA1E1FF71A4E4FF7CACE8FF87B8ECFF8DBDEFFF95C3F0FF9AC6
      F1FF9DC9F2FFA2CCF4FFA5CEF5FFA7CFF4FFA6CFF5FFA6CEF3FFA7CFF5FFA6CE
      F4FFA5CDF3FF99C1EDFF78A6E3FF4C83DAFE5078D15900000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002787F7C62BA8
      FFFF2FD2FCFF31B9F6FF39AAF3FF3EA3F1FF429FF0FF46A5FBFF4082B2FF2423
      1BFF242421FF3B88A8FF3CC8FFFF32BBF7FF2CCAFAFF29D6FDFF29DAFEFF2ADB
      FEFF2ADBFEFF2ADCFEFF2ADCFEFF2BDCFEFF2BDCFEFF2CDCFEFF2BDCFEFF2BDC
      FEFF2BDCFEFF2BDCFEFF2BDDFEFF2BDDFEFF2CDCFEFF2BDCFEFF2CDBFDFF2CDB
      FEFF2BDAFEFF2BD9FDFF2AD6FDFF2AD3FBFF2CCBFAFF31B9F5FF37BBFFFF3DAF
      E3FF2B4149FF222220FF3B7CAAFF45A6FCFF3CA1F0FF39A9F1FF33B5F3FF2EC1
      F7FF31D5FBFF2B9DFBFF2D7BF4D6CC00FF050000000000000000000000000000
      0000000000002F72F7412384FDFF2EB5F8FF33E6FEFF30DAFEFF2EDBFEFF2EDB
      FEFF2EDBFEFF2EDBFEFF2DDCFEFF2DDCFEFF2EDCFEFF2EDCFEFF2DDCFEFF2DDC
      FEFF2EDDFEFF2FDDFFFF2FDEFEFF2EDDFEFF2EDDFEFF2FDDFEFF2EDDFEFF2FDD
      FEFF2EDDFEFF2EDDFEFF2EDEFFFF2FDEFEFF2EDEFEFF2EDEFEFF2DDDFFFF2EDD
      FEFF2EDDFEFF2EDDFEFF2DDDFFFF2DDDFEFF2EDEFEFF2EDDFFFF2EDCFEFF2DDD
      FEFF2EDCFEFF2EDCFEFF2EDDFEFF2DDDFEFF2DDDFEFF2DDDFEFF2DDDFEFF2DDE
      FEFF2EDDFEFF2EDDFEFF2EDDFEFF2EDCFEFF2EDCFEFF2EDCFDFF2ED9FEFF32E2
      FDFF2BA1F7FF2B80F4F04E64FF17000000000000000000000000000000000000
      000000000000000000000000000000000000406EC75F4172CEFF87B1E8FFC7E5
      F9FFD2F2FFFFCDEFFFFFC7ECFFFFC0E7FFFFB9E0FFFFB7DFFEFFB9E0FEFFBAE0
      FEFFBAE1FEFFBAE0FEFFBAE1FEFFBAE0FEFFBAE0FFFFBAE0FFFFBAE0FFFFBAE0
      FEFFBAE0FFFFB9E0FEFFB9E0FEFFBAE0FEFFB9DFFFFFB9DFFFFFB7DFFFFFB7DE
      FEFFB8DEFEFFB7DEFEFFB6DDFEFFB5DCFDFFB5DCFEFFB4DBFDFFB2D9FCFFB1D8
      FCFFAFD7FCFFAED6FBFFADD5FBFFACD4FAFFABD3FAFFAAD3F9FFA8D1F9FFA7D0
      F9FFA6D0F8FFA5CEF7FFA2CCF7FFA1CBF7FF9FCAF5FF9DC8F5FF9FCCF8FF94C0
      EEFF476EC0ED2D3CB41100000000000000000000000000000000000000000000
      0000000000004C68C6AB79A8ECFF9DCAF7FF94C1F2FF95C2F2FF9AC6F3FFA1CB
      F6FFA3CDF7FFA5CFF7FFA8D1F8FFA9D3F9FFABD4FAFFADD6FAFFAED6FAFFAFD7
      FBFFAFD7FBFFB0D7FBFFB2D8FBFFB3D9FCFFB3DAFCFFB3DAFCFFB4DAFCFFB4DA
      FCFFB3DAFCFFB3DAFCFFB2D9FCFFAED6F9FF81B2EAFE6FA3E2FF6196DBFE6A9E
      E1FF588DD8FF4F86D4FF4E86D6FF4A84D5FF4481D4FF4482D3FF4484D5FF4685
      D6FF4585D7FF4686D7FF4786D8FF4786D7FF4686D9FF4585D9FF4785D8FF4684
      D6FF4282D7FF4181D5FF4480D3FF5289D8FF4A7AD3E3416DCC81AA00AA030000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002587F3C62AA7
      FFFF2ED0FCFF32B7F6FF3CA8F2FF41A1F0FF459BEFFF4698EEFF4CA5F8FF4B95
      D0FF4798D6FF46ADFEFF3EA4F2FF39AFF3FF2EC5F8FF2AD4FDFF2AD9FEFF2ADB
      FEFF2BDBFEFF2BDBFEFF2BDCFEFF2BDCFEFF2BDCFEFF2CDDFEFF2CDDFEFF2CDD
      FEFF2CDEFEFF2CDDFEFF2CDDFEFF2BDDFEFF2CDDFEFF2CDDFEFF2CDBFEFF2CDB
      FEFF2CDBFEFF2CD9FDFF2BD8FDFF2BD4FCFF2EC7F9FF35B5F4FF3BA8EFFF40A7
      F6FF49A4EFFF4899E1FF47A0F5FF4399EEFF409CEFFF3EA1F0FF36AEF2FF31BE
      F7FF31D6FAFF2B9BFCFF2C7DF4DABF20DF080000000000000000000000000000
      0000000000002B70F3422285FFFF30B6FAFF33E6FFFF30DBFEFF2FDCFEFF2FDC
      FEFF2FDCFEFF2FDCFEFF2EDCFEFF2EDCFEFF2EDCFEFF2FDCFEFF2EDCFEFF2EDD
      FEFF2EDDFEFF2FDDFFFF2FDDFEFF2FDDFEFF30DDFEFF30DDFEFF30DEFEFF30DE
      FEFF2FDEFFFF2EDEFEFF2EDEFFFF2FDEFEFF2FDEFEFF2FDEFEFF2EDEFEFF2EDE
      FFFF2EDEFEFF2EDDFEFF2DDEFEFF2EDDFEFF2EDDFEFF2EDDFEFF2EDDFEFF2EDD
      FEFF2EDCFEFF2FDCFEFF2EDDFEFF2FDDFEFF2FDEFFFF2FDDFFFF2EDEFEFF2FDE
      FEFF2EDDFEFF2EDDFEFF2EDEFEFF2FDDFEFF2FDDFEFF2FDCFEFF2FDAFEFF32E2
      FEFF2C9FF8FF277CF4EF3D49FF15000000000000000000000000000000000000
      000000000000000000000000000000000000000000003D63CE433267CDBE517E
      D0FF7DA4E8FF9ABCF0FFADD1F4FFC0E1F8FFCCEAFDFFD1F0FFFFC5EAFFFFBCE2
      FFFFBBE1FEFFBCE1FEFFBBE1FEFFBCE1FEFFBBE0FEFFBAE0FFFFB9E0FEFFB9E0
      FEFFB9E0FEFFBAE0FEFFBAE0FEFFBAE0FFFFB9E0FEFFB8DFFFFFB8DFFFFFB8DF
      FEFFB7DEFEFFB7DDFEFFB6DDFEFFB6DCFDFFB5DCFEFFB4DBFDFFB3DAFCFFB2D9
      FCFFB0D8FCFFAFD7FCFFAED6FBFFADD5FBFFACD4FBFFABD3FAFFA9D2F9FFA8D1
      F9FFA6D0F9FFA5CEF8FFA3CCF7FFA1CBF6FF9FCAF5FF9DC9F5FF9DC9F6FF97C2
      EFFF4C74C2EF4359C81700000000000000000000000000000000000000000000
      000000000000486FC9BD81B1EEFF9FCBF7FF93C2F2FF95C2F2FF99C5F3FFA0CA
      F5FFA2CDF6FFA4CFF7FFA7D0F8FFA9D2F9FFAAD3FAFFACD4FAFFADD5FBFFAED7
      FBFFAED6FBFFAFD7FBFFB0D8FBFFB1D8FCFFB3D9FCFFB3DAFCFFB3DAFCFFB3DA
      FCFFB3DAFBFFB3DAFCFFB2D9FBFFA8D2F7FF7CAFE9FF6699DDFF6FA4E3FF77AC
      E8FF72A8E5FF7DAFE8FF87B9EDFF8ABAEEFF8BBBEDFF8FBFEFFF97C5F1FF9AC7
      F2FF9BC7F0FF9CC8F1FF9DCAF1FF9FCBF3FFA1CCF4FFA4CEF5FFA6CFF3FFA8D0
      F4FFA8D0F4FFAAD1F5FFADD3F4FFAED2F4FF9FC6F0FF578BDEFF386BC2960000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002587F5C32AA5
      FFFF2FD1FCFF33B8F7FF3CA9F3FF41A1F0FF459CF0FF469AEFFF489BEFFF4AA0
      F8FF47A1F8FF449EF0FF41A4F1FF3AAEF2FF2EC6F8FF2BD5FDFF2ADBFEFF2BDC
      FEFF2BDCFEFF2CDCFEFF2BDCFEFF2BDDFEFF2DDDFEFF2CDDFEFF2DDDFEFF2CDD
      FEFF2DDEFEFF2CDDFEFF2DDEFFFF2CDDFEFF2CDEFEFF2DDDFEFF2DDDFEFF2DDB
      FEFF2DDCFEFF2CDBFEFF2CD8FEFF2CD5FDFF2EC8F9FF35B6F3FF3DA8F0FF419F
      EDFF459CF2FF469CF4FF4499EFFF439CEFFF409EF0FF3DA3F1FF36AFF3FF31BF
      F7FF32D6FAFF2B98FEFF2D7CF7D3FF00FF040000000000000000000000000000
      0000000000003671F23D2286FDFF2FB2FAFF35E6FFFF31DBFEFF30DDFEFF30DC
      FEFF30DCFEFF2FDCFEFF2FDDFEFF2FDDFEFF2FDEFEFF2FDDFEFF2FDDFEFF2FDD
      FEFF30DEFEFF30DEFEFF2FDEFEFF2FDDFFFF2FDEFFFF2FDEFFFF30DEFFFF30DE
      FEFF30DEFEFF2FDEFFFF2FDEFFFF2FDFFEFF30DFFEFF2FDEFEFF2EDEFEFF2EDE
      FEFF2FDEFEFF2FDEFEFF2EDEFEFF2EDDFEFF2EDDFFFF2DE1FFFF2EE7FFFF2EE4
      FFFF2DDEFFFF2FDDFEFF2FDEFEFF2FDEFEFF30DEFEFF30DEFEFF30DEFEFF2FDE
      FEFF2FDEFEFF2FDEFEFF2FDEFEFF30DEFEFF30DDFEFF30DCFDFF31DCFEFF34DF
      FDFF2B99F9FF297DF4EC4B3CFF11000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004463
      D5313361CA6E3869CBA73C6FC7D34A78C9F85E92DDFF84B4EDFFB1D5F4FFCCEC
      FDFECAEDFFFFBCE3FFFFBBE2FEFFBCE1FEFFBBE1FEFFBAE0FEFFB9E0FEFFBAE0
      FEFFB9E0FEFFBAE0FEFFBAE0FEFFBAE0FEFFB9DFFFFFB9DFFEFFB9DFFEFFB8DE
      FEFFB7DEFEFFB7DEFEFFB6DDFEFFB6DCFEFFB5DCFEFFB4DBFDFFB3DAFDFFB2D8
      FCFFB0D7FCFFAFD7FBFFAED6FBFFADD5FBFFADD4FBFFACD4FAFFAAD3FAFFA9D1
      FAFFA7D0F9FFA5CFF9FFA3CDF7FFA1CCF6FF9FCAF6FE9DC9F5FF9ECAF7FF93C1
      EFFF4C73C2EC5555CC0F00000000000000000000000000000000000000000000
      0000CC66FF054C76CDD386B6EFFF9ECAF7FF93C1F3FF95C3F3FF9AC6F4FFA0CB
      F6FFA2CDF7FFA4CEF7FFA7D0F8FFA9D2F9FFAAD3F9FFABD4FAFFACD5FBFFAED6
      FBFFADD6FAFFAFD7FBFFAFD7FBFFB1D8FCFFB1D9FBFFB2D9FCFFB2D9FCFFB2DA
      FCFFB2D9FBFFB1D9FBFFB3DAFCFF9FCBF4FF72A6E4FF669ADEFF75A9E7FF73A8
      E5FF80B4EBFF98C6F4FF9CC9F6FFA0CCF7FFA6D1F9FFACD5FBFFB1D9FCFFB5DC
      FDFFB7DEFEFFB9DFFFFFB8E0FEFFB9E0FFFFBAE1FFFFBBE1FEFFBBE2FFFFBCE3
      FFFFBDE2FFFFBDE3FFFFBDE2FFFFBCE2FFFFCBEFFFFFA9CBF0FF427BCCFF436D
      CE2A000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002386F6BC2BA3
      FFFF30D4FCFE33BDF8FF3AAEF3FF3FA5F1FF43A0F0FF449DEFFF459DEFFF459C
      F0FF43A0EFFF42A2F1FF3DA9F1FF37B3F3FF2FC7F8FF2CD5FCFF2BDAFEFF2BDB
      FEFF2BDBFEFF2CDCFEFF2CDDFEFF2CDDFEFF2DDDFEFF2DDDFEFF2EDDFFFF2EDE
      FEFF2DDDFEFF2DDDFEFF2DDEFEFF2DDEFEFF2DDEFEFF2DDDFEFF2DDDFEFF2DDC
      FEFF2DDCFEFF2DDBFEFF2DD9FDFF2DD6FDFF2ECBFAFF32BDF5FF3AACF1FF3FA1
      EFFF439CEEFF449AEEFF439CEFFF41A0F0FF3DA5F1FF38ACF2FF32B8F4FF30C5
      F9FF34D6FAFF2B94FFFF2876F4C1000000000000000000000000000000000000
      000000000000496DF8231F85F6F82CADFBFF38E6FEFF33DCFEFF31DDFEFF31DC
      FEFF31DCFEFF30DCFEFF30DCFEFF30DCFEFF2FDDFEFF30DDFEFF2FDDFEFF30DD
      FEFF30DDFEFF30DDFEFF2EE1FFFF33EEFFFF34DEFBFF32E0FCFF31EEFFFF2DE2
      FFFF2FDDFEFF30DEFEFF30DFFFFF30DFFEFF2FDEFFFF30DEFEFF30DEFEFF2FDE
      FEFF30DEFEFF30DDFEFF2EDCFEFF2DDEFEFE30EDFFFF33D6EEFF33BBD0FF36C5
      D9FF35E9FFFF2DE5FFFF2FDCFEFF30DDFEFF30DEFEFF30DEFEFF30DEFEFF30DD
      FEFF30DEFFFF30DDFEFF30DEFEFF31DEFEFF31DEFEFF32DEFEFF32DEFEFF34DA
      FCFF2A94FAFF2D81F5E29933FF0A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF80FF025F66DB233C6DD159336CCFA04075CDEA6697
      DEFFA4C8EFFFD5F0FEFFCBEEFFFFBCE2FEFFBAE0FFFFBAE0FEFFB9E0FEFFBADF
      FEFFBAE0FFFFBBE0FEFFBAE0FEFFBADFFEFFBADFFFFFB9DFFEFFB9DFFFFFB8DE
      FEFFB7DDFDFFB7DCFEFFB6DCFEFFB6DCFEFFB5DCFDFFB4DAFDFFB2D9FDFFB2D7
      FCFFB0D7FCFFAFD6FBFFAED5FBFFACD4FAFFACD3FAFFABD3FAFFAAD1F9FFA8D0
      F9FFA7CFF8FFA5CEF8FFA2CCF7FFA1CBF6FF9FC9F5FF9DC6F5FFA8D3FCFF82AD
      EAFF4562BFB6FF00FF0100000000000000000000000000000000000000000000
      00006060DF104973C9E88EBBEFFF9BC7F6FF93C2F2FF96C3F2FF9CC8F4FFA0CA
      F5FFA1CCF7FFA3CEF7FFA6D0F7FFA8D1F8FFA9D2F9FFAAD3FAFFABD5FAFFACD5
      FAFFADD5F9FFAED6FAFFAFD7FBFFB0D7FBFFB0D8FBFFB1D9FCFFB1D8FBFFB1D8
      FBFFAFD7FBFFAED6FBFFB3DAFCFF97C4F1FF6DA2E2FF699DDEFF75A9E6FF72A6
      E5FE8DBDEFFF99C6F3FF99C7F4FF9ECAF6FFA0CCF6FFA6D0F8FFAAD4F9FFADD6
      FAFFAED8FBFFB0D9FCFFB2DAFCFFB3DBFCFFB4DCFCFFB5DDFDFFB6DDFDFFB7DE
      FDFFB7DEFDFFB8DFFDFFB9DEFDFFB9DEFEFFB8DFFEFFC4E7FEFF6399DFFF396A
      C467000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002B88F6AB2A9F
      FFFF31D6FCFF32C5FBFF37B5F6FF3CACF3FF3FA5F2FF42A2F1FF43A2F1FF43A1
      F1FF40A6F2FF3EAAF3FF39B0F3FF35B9F5FF2ECCFAFF2CD7FDFF2CDAFEFF2CDC
      FEFF2CDCFEFF2CDDFEFF2DDDFEFF2DDDFEFF2EDEFEFF2EDEFEFF2EDEFEFF2FDE
      FEFF2EDEFEFF2EDEFEFF2EDEFEFF2EDEFEFF2EDEFEFF2EDEFEFF2EDEFEFF2EDD
      FEFF2EDCFEFF2DDCFEFF2DDAFEFF2DD7FDFF2ED0FBFF30C4F8FF37B4F5FF3BA9
      F1FF40A3F1FF42A0F0FF40A2F2FF3FA6F2FF3AADF4FF36B4F5FF30BFF7FF2FCC
      FAFF34D3FAFF2B8FFFFF2E74F3AD000000000000000000000000000000000000
      0000000000005540EA0C2186F6E62AA4FDFF3AE5FEFF34DCFEFE33DEFEFF32DD
      FEFF32DDFEFF31DDFEFF31DCFEFF31DDFEFF31DDFEFF31DDFEFF31DEFEFF30DD
      FEFF30DDFEFF30E6FFFF36DBEFFF327378FF2B484AFF2A4A4BFF31767BFF37D9
      EDFF2FE8FFFF30DDFEFF31DFFFFF31DEFEFF31DFFFFF31DFFFFF31DFFEFF30DF
      FEFF30DEFEFF30DEFEFF2EDFFFFF33E7FDFF328489FF283231FF242725FF2628
      23FF2E5050FF37C9D8FF2FE8FFFF2FDDFEFF30DEFEFF31DEFEFF30DFFEFF31DE
      FEFF31DEFEFF31DEFEFF31DEFEFF33DEFEFF33DEFEFF33DFFEFF34E1FEFF36D6
      FBFF2992FFFF2981F6C700000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005180E8163E6E
      CF6F3B72CBE0639AE2FFAFD2F2FFD1F0FEFEBEE4FFFFB9E0FEFFB9E0FEFFBAE0
      FEFFBAE0FEFFBBE0FFFFBAE0FFFFBADFFFFFBADFFEFFB9DFFEFFB9DFFEFFB8DE
      FEFFB7DDFEFFB7DDFDFFB6DCFEFFB5DBFEFFB4DAFEFFB3DAFDFFB4DAFDFFB2D9
      FDFFAFD6FCFFADD5FBFFADD4FBFFACD3FBFFAAD2FBFFA9D1FAFFA8D1FAFFA7D0
      FAFFA6CFF9FFA4CDF8FFA2CCF7FFA2CDF8FFA6D0F9FFA9D5FAFF93C0F0FF5473
      C7FF465CBD3A0000000000000000000000000000000000000000000000000000
      00005876E21A4A76C8F293BEEFFF99C5F5FF94C1F2FE96C4F3FF9CC8F5FF9FCA
      F6FFA0CCF6FFA3CEF7FFA5D0F8FFA8D1F8FFA8D2F9FFAAD3FAFFABD4F9FFACD5
      FAFFACD5FAFFADD6FAFFAED7FAFFAFD7FBFFB0D8FBFFB1D8FBFFB0D8FBFFB0D8
      FBFFAED7FAFFADD6FAFFB3DAFBFF88B9EDFF6FA3E3FF689BDEFF74A9E6FE73A7
      E5FE92C2F1FE98C5F3FF9BC8F4FF9FCCF6FFA2CEF7FFA7D1F8FFABD5F9FFADD6
      FAFFAFD8FBFFB1DAFCFFB2DBFCFFB4DCFDFFB4DDFDFFB5DEFDFFB7DEFDFFB7DE
      FDFFB8DEFDFEB8DFFDFFB9DEFDFFBADEFDFFB8DEFDFFC3E8FFFF6FA6E5FF366B
      C085000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003084F68B279A
      FFFF31D4FBFF30D1FCFF33C2F9FF36B9F6FF38B2F5FF3AAEF3FF3BADF4FF3CAD
      F3FF3AB0F3FF38B3F5FF35B9F5FF31C3F8FF2CD1FCFF2CDAFDFF2DDCFEFF2DDD
      FEFF2EDDFEFF2EDDFEFF2DDEFEFF2EDEFEFF2FDEFEFF2FDEFEFF2FDFFEFF30DF
      FEFF2FDFFEFF2FDEFEFF30DFFEFF2FDEFEFF2FDFFEFF30DEFEFF30DEFEFF2FDE
      FEFF2FDDFEFF2FDDFEFF2EDCFEFF2DDAFEFF2DD4FCFF2ECDFAFF33C2F8FF36B8
      F5FF38B3F4FF39AFF3FF39B0F3FF37B3F4FF34B8F6FF32BEF7FF2FC6F9FF2FD4
      FCFF35CBF9FF2A8AFFFF2C76F584000000000000000000000000000000000000
      000000000000000000002589F7C3279EFFFF3DE1FDFF38DFFEFE35DFFEFF34DE
      FEFF33DDFEFF33DEFEFF31DDFEFF31DDFEFF31DEFEFF32DEFFFF31DDFEFF31DD
      FEFF2FE0FFFF35E1F3FF2B4C4BFF211715FF232926FF222826FF201814FF2B47
      47FF35DDEDFF2DE3FFFF31DFFFFF31DFFEFF33E0FEFF32DFFEFF32DFFEFF32DF
      FEFF31DFFEFF31DDFFFF32EEFFFF31868DFF1F120EFF222A28FF232E2CFF232E
      2BFF201C19FF293736FF36D7E8FF2DE2FFFF31DEFEFF31DDFEFF31DEFEFF31DE
      FEFF31DEFFFF32DEFEFF33DEFEFF34DFFEFF35DEFEFF35DEFEFF37E5FEFF37CA
      F8FF268EFFFF2680F2A000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006677DD0F2E6ECD7B3A74CEF183ADE8FFD1ECFAFFCCEFFFFFB8DFFEFFBAE0
      FEFFBAE1FEFFBAE0FEFFBAE0FEFFBAE0FEFFBADFFEFFBADFFFFFB8DFFEFFB8DE
      FEFFB7DDFEFFB7DDFEFFB6DBFCFFB5DAFCFFC4E6FEFFD0EFFFFFD5F3FFFFD0EE
      FFFFCFECFFFFCFECFFFFCBECFFFFC8EAFFFFCCECFFFFCAEAFFFFCAEAFEFFC4E6
      FEFFBDE0FDFFB7DCFBFFB2D9FAFFA8D2F6FF95C1F1FF77A5E8FF4F75CCF74D62
      C260000000000000000000000000000000000000000000000000000000000000
      00005C6BD6324F7DCBFE93C1F1FF97C4F4FF94C2F3FF96C4F3FE9AC7F4FF9DC9
      F5FF9FCCF7FFA2CDF7FFA4CFF7FFA6D0F8FFA7D1F8FFA9D2F9FFA9D3F9FFABD4
      FAFFABD4F9FFADD5FAFFADD6FAFFAFD7FBFFAFD7FBFEB0D8FBFFB0D8FAFFB0D8
      FAFFAFD7FAFFB2DAFBFFA5D0F6FF74AAE7FF71A4E4FF6598DCFF76AAE7FF75A9
      E6FF94C2F2FF98C5F3FF9CCAF5FFA1CDF7FFA4D0F8FFA8D2F9FFABD5FAFFAED7
      FBFFB0D8FBFFB2DAFDFFB3DBFCFFB5DCFDFFB6DDFDFFB7DEFDFFB7DEFDFFB8DE
      FDFFB9DFFDFFB9DFFDFFBADFFDFEBADFFDFFB9DFFDFEC5E8FFFF70A4E3FF3564
      BE82000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003386F5692692
      FFFF31C8FAFF32DCFDFF31CAFBFF32C4F9FF34BFF8FF35BAF6FF36B9F6FF36B9
      F6FF35BBF7FF34BFF8FF30C5FAFF2FCDFBFF2CD6FDFF2DDBFEFF2DDDFEFF2DDE
      FEFF2EDEFEFF2EDEFEFF2EDFFEFF2EDFFFFF2FDFFFFF2FDFFEFF2FDFFEFF30DF
      FEFF30DFFEFF30DFFEFF30DFFEFF30DFFEFF30DFFEFF30DFFEFF30DEFEFF30DE
      FEFF30DEFEFF2FDDFEFF2FDDFEFF2EDBFEFF2ED7FDFF2FD3FCFF30CDFBFF31C5
      FAFF33C2F8FF33BEF7FF33BEF7FF33C0F8FF32C3F9FF30C7FAFF2FCEFBFF31DD
      FDFF34BDF7FF2882FFFF3170F75D000000000000000000000000000000000000
      00000000000000000000288CF68E2498FFFF3DD3FBFF3BE4FFFF37DFFEFF36DF
      FEFF34DEFEFF34DEFEFF33DEFEFF32DEFEFF32DEFEFF33DEFEFF32DEFEFF32DE
      FFFF32EFFFFF338F97FF211714FF243231FF23302EFF23302EFF233331FF2219
      16FF317E86FF32F0FFFF32DFFFFF32DFFFFF33DFFEFF33E0FEFF32DFFEFF33DF
      FEFF33DFFEFF32E3FFFF35D5EAFF272F2DFF232B28FF222F2EFF232F2EFF232F
      2EFF23312FFF211715FF31848CFF32EEFFFF31DEFEFF32DFFEFF33DFFEFF33DF
      FEFF33DEFEFF33DEFEFF34DFFEFF35E0FEFF35DFFEFF35DEFEFF3CE9FEFF34B7
      F6FF2586FFFF2979F06900000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005176DA293571CEC25B91E0FFC3E0F4FFD0F2FFFFB9E0
      FEFFBADFFEFFBAE0FEFFBAE0FEFFBAE0FEFFBAE0FEFFB9DFFEFFB9DEFEFFB7DE
      FEFFB7DDFEFEB6DDFDFFB5DAFCFFB2D8FBFFCBEDFFFFCDE9F8FF88AFE2FF739E
      DFFF6D97D5FF6C96D4FF6E97D5FF6D96D6FF6C96D5FF6B95D3FF6E98D5FF6D98
      D5FF6994D5FF6591D4FF628AD1FF567AC7F74971C6D54D6BC8916464D32E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000516BD2395180CFFF95C3F1FF96C3F3FF94C1F3FF96C3F2FF99C6F4FF9CC9
      F5FF9FCBF6FFA1CDF7FFA4CEF7FFA5D0F8FFA6D1F8FFA8D2F8FFA9D3F9FFAAD4
      F9FFAAD4F9FFABD4F9FFADD5FAFFAED7FAFFAFD6FBFEB0D7FBFFAFD7FAFFAFD7
      FAFFAFD7FAFFB5DCFBFF83B5EBFF71A7E6FF73A7E6FF6194D9FF73A7E5FE73A8
      E5FE94C2F1FF99C6F3FF9DCAF5FFA2CDF7FFA5D0F8FEA8D3F9FFACD5FAFFAED7
      FBFFB0D9FCFFB2DBFCFFB4DCFDFFB6DDFDFFB6DEFEFFB7DFFEFFB8DEFDFFB9DF
      FDFFB9DFFDFFBAE0FDFFBAE0FDFFBAE0FDFFBBE0FEFFC4E7FEFF6999DEFF4168
      C362000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003280F138238A
      FBFF31B6FAFF35E3FEFF2FD0FCFF30CCFBFF30C9FAFF31C5F9FF31C4F9FF31C3
      F9FF2FC7FAFF2FCAFBFF2CD2FEFF2CDFFFFF2BE2FFFF2CDCFEFF2CDEFEFF2CDE
      FEFF2EDEFEFF2EDDFEFF2DDFFFFF2DE5FFFF2EE0FFFF30DEFEFF30E0FEFF30DF
      FEFF30DFFEFF30DFFEFF30E0FEFF30E0FEFF30E0FFFF2FE4FFFF2EE0FFFF2FDD
      FEFF30DEFEFF30DEFFFF2FDDFEFF2EDCFEFF2EDAFFFF2DDBFFFF2CD5FFFF2DD1
      FCFF2FCDFBFF30CAFAFF31C7FAFF30C9FAFF30CBFBFF2FCEFCFF30D2FCFF35E1
      FDFE2EAEF7FF297DFDFF435EF639000000000000000000000000000000000000
      000000000000000000002C84F2512190FFFF36BDFBFF3FEAFFFF36DEFEFF36DF
      FEFF37DFFEFF36DFFEFF33DEFEFF33DFFDFF32DEFEFF32DEFEFF33DFFEFF32DD
      FFFF36EBFFFF305859FF212220FF22302FFF232F2EFF242F2EFF222F2EFF2126
      24FF2D5052FF35E9FFFF31E0FFFF32DFFEFF34E0FEFF34DFFEFF33E0FFFF33DE
      FFFF33DEFEFF33EAFFFF35B0BEFF221C18FF23302EFF23302EFF232F2EFF222F
      2EFF232F2DFF212321FF2E5657FF34E9FFFF31DDFFFF32DEFEFF32DEFEFF32DE
      FEFF34DFFEFF34DFFEFF34DFFEFF35DFFEFF35DFFEFF36DEFEFF3CEAFDFF2FA5
      F8FF297FF8FF3C5DE83700000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009966CC05336DCD9A4985DDFFB6D6F1FFD3F3
      FFFFB9DFFEFFB7DEFEFFB9E0FEFFB9DFFEFFB9E0FEFFB9DFFEFFB8DFFEFFB8DE
      FEFFB7DDFEFEB6DCFDFFB1D8FCFFAED6FCFFBEE0F9FF618DD2FF3660C5CF385D
      C765244DB63F2850B7402D51B63F2B4EB8412454B3402756B4412B5AB441315B
      B743355CBC482F57BD463E56C13E6962DA22AA55FF0300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004B6DCD3D5582D2FF97C4F2FF96C3F4FF93C2F2FF95C3F3FF98C6F4FF9AC8
      F4FF9DCAF5FF9FCCF6FFA2CDF6FEA4CFF7FFA5D0F8FFA6D1F9FFA7D2F9FFA9D3
      F9FFAAD4F9FFABD4FAFFACD6FAFFADD5FBFFAED6FAFFAFD7FBFFAFD7FAFFAFD7
      FAFFB6DEFCFF91C1EFFF6FA4E5FF74A7E6FF75A8E7FF6498DCFF689DDEFF75A9
      E7FE91C1F1FF9AC8F4FF9DCAF6FFA2CDF7FFA6D1F9FFA9D4FAFFACD6FBFFAED8
      FBFFB1D9FCFFB3DBFDFFB3DCFDFEB5DDFDFFB6DEFEFFB7DFFDFFB8DFFDFFB9DF
      FEFFB9E0FDFFB9E0FEFEB8DFFDFFB8E0FEFFC2E7FFFFBADDF8FF4C7ECAFD4B70
      C729000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004E62EB0D2388
      F6E72BA4FDFF38E3FDFF2FD5FDFF30D2FDFF2FD0FCFF30CEFBFF30CDFBFF30CE
      FBFF2ED0FDFF2DD5FEFF33E1FFFF35B9CCFF33CADEFF2EE9FFFF2CDDFEFF2DDF
      FEFF2EDDFEFF2EE4FFFF35E5FFFF35C8DCFF34E0FBFF30E3FFFF31E0FEFF31E1
      FEFF31E0FEFF32E0FEFF31DFFEFF30E0FFFF34E7FFFF39D2E6FF36DFF7FF31E4
      FFFF30DEFFFF30DFFEFF30DFFEFF2EE0FFFF32E6FFFF34D1E8FF31E1FFFF2DDA
      FFFF2FD4FEFF2FD2FCFF30D1FCFF30D2FDFF30D2FDFF2FD5FEFF31D7FEFF37DF
      FDFF299CFCFF2B7AF5E87733EE0F000000000000000000000000000000000000
      000000000000000000003D61FF151E87F9F12CA6FEFF44E9FDFF38DFFEFF38E0
      FEFF39DFFEFF38E0FEFF35E0FEFF35DFFEFF34DFFEFF34DFFEFF34DFFEFF33DE
      FFFF37EAFFFF2C5456FF212321FF232F2EFF23302EFF232F2EFF222F2EFF2126
      24FF2C5052FF37E9FFFF32E0FFFF33E0FEFF35E0FEFF35E0FEFF35E0FEFF34E0
      FEFF34DFFEFF34EAFFFF36B0BFFF231C19FF23302EFF23302EFF232F2EFF222F
      2EFF222F2DFF21221EFF2D5B5EFF33EBFFFF32DEFFFF33DEFEFF33DFFEFF34DF
      FEFF35DFFEFF35DFFEFF36DFFEFF36E0FEFF37E0FFFF37E1FEFF3CDFFCFF2994
      FCFF2B7CF3E16633E60A00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003970CF86467FD7FFB8D7
      F3FFD2F2FFFFB7DDFEFFB8DFFEFFB9E0FEFFB9E0FEFFB9DFFEFFB8DEFEFEB8DE
      FEFFB7DDFEFFB5DCFEFFB2D8FCFFB6DDFFFF87B2E4FF3C67C0EB6060CA180000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004565C63F5584D3FF98C5F2FF95C3F3FF93C2F2FF95C3F3FF97C5F3FF99C7
      F4FE9DC9F5FF9ECBF6FFA1CDF6FFA3CEF7FFA3CFF8FFA5D0F8FFA6D1F8FFA8D3
      F9FFA9D3F9FFAAD3F9FFABD5FAFFACD5FAFFADD6FBFEAED6FAFEB0D7FBFEB8DF
      FDFF96C4F1FF6DA3E5FF73A6E7FF72A6E5FF73A6E5FE6CA0E1FF5F93D9FF6399
      DDFF84B6EAFF97C5F1FEA0CCF6FFA7D2F8FFABD6FAFFB0DAFCFFB6DEFDFEB9E0
      FDFFBCE2FEFFBEE3FEFEBDE3FFFFBFE4FEFFC2E5FFFFC3E6FFFFC3E6FEFEC4E7
      FFFFC6E9FFFFC6E9FEFEC6E8FFFFC8E9FFFFCEEFFDFE7DAEEBFF376CC4AD0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002788
      F6AC269BFFFF3BD7FCFF32DDFFFF31D6FEFF31D4FDFF31D3FDFF2FD3FDFF2ED3
      FDFF2DD7FEFF33E4FEFF34787AFF241B16FF272A26FF36BFCCFF2EEAFFFF2EDE
      FEFF2DE2FFFF37E1F2FF2F5857FF24231FFF305857FF39E1F4FF30E2FFFF32E1
      FEFF32E1FEFF32E1FFFF31E0FEFF37EAFFFF35848AFF252522FF2D4546FF36D7
      EAFF30E5FFFF31E0FEFF2FE0FFFF36ECFFFF327779FF252724FF316568FF36DE
      F7FF2FDAFFFF30D8FFFF30D7FEFF30D8FDFF31D8FEFF32DAFEFF35DFFEFF39D7
      FBFF2690FFFF2B7DF3AE00000000000000000000000000000000000000000000
      00000000000000000000000000002089F5B52199FFFF44D8FCFF3FE5FFFF3DE1
      FEFF3BE1FEFF3AE0FEFF37E0FEFE36E0FEFF35E0FEFF35DFFEFF34DEFEFF34DE
      FEFF36EFFFFF358E97FF211713FF243230FF232F2EFF232F2EFF233230FF2119
      15FF318086FE36F0FFFF34E0FFFF35E0FEFF36E1FEFF37E0FFFF36E0FEFF36E0
      FEFF35E0FEFF33E3FFFF3AD8ECFF2A3230FF212725FF232F2EFF232E2DFF222E
      2DFF23302EFF201511FF33909BFE34EEFFFF33DEFEFF34DFFEFF35E0FEFF36DF
      FEFF37DFFEFF37DFFFFF36DFFEFF37DFFFFF38E0FFFF3CE7FFFF3AC5FAFF268C
      FFFF2F78F5930000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003C6FD0834F84
      E0FFC9E2F6FFCDEFFFFFB6DDFEFFB8DEFDFEB9DFFEFFB9DFFEFFB8DEFEFFB7DE
      FEFFB6DDFEFFB5DBFDFFB0D8FCFFB7DEFFFF75A4E5FF3E67C2B9000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000486CCB405085D3FF95C3F2FF94C1F2FF93C1F2FF95C3F3FF98C5F3FF9AC7
      F4FF9BC9F5FF9DCAF6FF9FCBF6FFA1CDF7FFA2CEF7FFA4CFF8FFA6D1F8FFA8D2
      F8FFA8D2F8FFA9D3F9FFABD4F9FFABD5FAFFACD5FAFEAED6FBFEADD5F9FF88B8
      EBFF6CA1E4FF72A4E6FF72A4E6FF71A4E5FF71A3E5FE6C9FE1FF5F93DAFF6298
      DDFF5C93D9FF5D96DBFF609BE0FF619CE0FF619CE1FF639FE2FF65A2E3FF68A4
      E4FF6BA6E5FF6FA9E6FF6FAAE8FF72ACE8FF72ACE8FF74ADE9FF74ACE9FF76AD
      E9FF77AEE9FF79AEE9FF79ACE8FF78ABE6FF6A9CE3FF4777D2D6555EC61B0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002B82
      F75A2392FFFF37BDFAFF39E8FFFF33DAFEFF33D9FEFF32D8FEFF30D8FEFF30D9
      FEFF2DDFFFFF37D2E9FF272A26FF242D2AFF21211EFF2C4F50FF35F1FFFF2DE0
      FFFF34F8FFFF34848AFE211511FF26302EFF231916FF37B0BDFF34ECFFFF34E1
      FEFF34E1FEFF34E1FEFF32E5FFFF3BD7EDFF282D2AFF232A28FF211716FF316F
      72FF36F7FFFF30E0FFFF33F4FFFF38A9B6FF221713FF252E2CFF231410FF37B1
      BFFF32E8FFFF32DCFFFF32DCFEFF32DCFEFF34DCFEFF35DDFEFF3AEAFEFF34BA
      F7FF2485FFFF2F74F45C00000000000000000000000000000000000000000000
      00000000000000000000000000002982F15E1F91FFFF39B7F9FF48EEFEFF3FE2
      FEFF3EE2FEFF3DE2FEFF3AE1FEFF38E1FEFF37E0FEFF37E0FEFF36E0FFFF35DF
      FFFF34E3FFFF3EE1F1FF2D4A48FF201714FF212725FF212725FF1F1715FF2A46
      46FF3ADDEDFF33E4FFFF36E1FFFF37E1FEFF38E1FEFF38E1FFFF38E1FFFF38E0
      FEFF37E0FEFF36E0FEFF37EEFFFF379DA5FF201714FF212322FF222B2AFF2128
      26FF1F1512FF2C4E50FF39E1F3FF34E1FFFF36DFFFFF36E0FFFF37E0FEFF38E0
      FEFF38E0FEFF39E0FFFF38E0FEFF39E0FFFF3AE0FEFF43EBFEFF31A4F9FF2782
      FDFF3764F1380000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003368
      CCB06596E1FFDBF3FCFFC0E5FFFFB6DCFEFFB8DFFEFFB8DFFEFFB8DEFEFFB7DE
      FEFFB6DCFEFFB5DBFDFFB1D9FCFFB5DEFEFF78A7E8FF3D69C3B3000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004868CB405285D4FF95C3F2FF93C1F2FF93C1F1FF95C2F2FF97C4F4FF99C6
      F5FF9BC7F5FF9CC9F5FF9DCAF5FF9ECBF6FF9ECBF6FFA1CDF7FFA4CFF7FFA6D0
      F8FFA7D1F8FFA8D2F8FFAAD3F9FFAAD4F9FFABD5F9FFAED7FBFFA6D1F7FF6FA7
      E4FF689DE2FF70A3E6FF72A4E5FF71A3E5FF70A3E5FF6498DDFE689DDFFE78AC
      E8FF7EB2EBFF8FBFF1FF92C3F3FF8FC0F1FF8EC0F1FF8ABDF0FF84B9EDFF7EB4
      EAFF76AEE9FF6FA9E7FF6BA7E7FF69A5E6FF68A5E4FF68A4E5FF66A3E4FF65A2
      E4FF66A1E3FF66A1E3FF66A1E1FF629CDEFF4C8AE2FF4A78D586000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003C69
      F011228AF8EB2B9EFDFF3FE4FDFF36DCFEFF34DAFEFF34DAFEFF32DAFEFF31DA
      FEFF30DFFFFF39D9F0FF273634FF232A28FF23302EFF21201DFF34939DFF39F7
      FFFF37BCC9FF262826FF232C2AFF23302DFF22211FFF36B9CAFF37EBFFFF36E1
      FEFF35E2FEFF36E1FEFF34E3FFFF3BDDF3FF283937FF232927FF232E2BFF2424
      21FF3BB2C0FF38F7FFFF3DD6E5FF2B3B39FF222724FF24302EFF231D1AFF36B4
      C4FF32E9FFFF34DFFEFF35DDFEFF36DDFEFF36DDFEFF36DFFEFF42E7FDFF2C97
      FBFF2979F3E74455EE0F00000000000000000000000000000000000000000000
      00000000000000000000000000003377EE0F218FF8EE299AFCFF4AE4FCFF42E5
      FFFF3FE2FEFF3EE2FEFF3DE2FEFF3DE1FEFF3AE1FEFF3AE0FEFF39E0FEFF38E0
      FEFF37DFFEFF39E9FFFF3ED9EAFF336D71FF2A4A4AFF294C4CFF30777AFF3BDC
      EFFF36E8FFFF37DFFEFF39E1FFFF3AE2FEFF3BE1FFFF3AE2FFFF3AE1FEFF3AE1
      FEFF39E0FEFF39E0FEFF37DFFEFF39EFFFFF39A5ADFF2D4746FF26302DFF283C
      3AFF31787BFF3CE1F4FF37E6FFFF38DEFEFF38DFFEFF38DFFEFF39DFFEFF38DF
      FEFF39DFFEFF39DFFFFF3AE0FFFF3CE0FFFF40E7FFFF42D7FCFF2790FFFF2881
      F3C5000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005973
      CC143369CBE598B6EAFFDBF8FFFFB4DCFDFFB6DDFEFFB7DEFEFFB7DDFEFFB6DC
      FEFFB5DBFEFFB4DBFDFFB3D9FDFFB4DCFFFF8BB5ECFF436AC2D2FF00FF010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A67D23E5282D5FF94C2F2FF92BFF2FF92C0F1FF93C1F2FF96C3F4FF98C5
      F3FF99C6F4FF9AC7F5FF9CC8F5FF9DCAF5FF9DCAF5FF9FCBF6FFA0CBF6FFA1CD
      F6FFA3CEF7FFA5D0F8FFA7D1F8FFA9D3F9FFAAD4F9FFAAD4F9FFAED7FAFFAFD8
      FBFF90C0EFFF6FA4E4FF6A9FE2FF6FA3E4FF70A3E5FF6296DBFF6FA4E3FF75AA
      E6FE8BBCEFFF99C6F4FF9CC9F5FFA1CDF7FFA6D2F9FFABD6FBFFB0DAFCFFB5DC
      FDFEBADFFDFFBBE0FDFFBDE2FDFFBEE3FDFFBEE3FDFFBFE4FEFFBFE4FEFFBFE4
      FEFFC0E5FDFFC0E5FEFFC3E7FEFFC7EBFEFF9FC7F0FF426CC4EA5050BF100000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000298EF98A2392FFFF3AC7FAFF3DE6FFFF36DCFEFF36DCFEFF34DDFEFF34DD
      FEFF34DEFFFF38F0FFFF327D82FF201715FF23302FFF222D2BFF242523FF2E4F
      4FFF262F2DFF232926FF23302FFF20211EFF294A4CFF3EE9FBFF37E2FFFF38E1
      FEFF37E2FEFF38E2FEFF37E2FFFF3BF3FFFF327D83FF201814FF24312FFF222A
      28FF272E2DFF305C5DFF28393AFF232624FF243230FF212421FF294141FF3CE4
      F8FF34E1FFFF36E0FEFF38DFFEFF39DFFEFF39DFFEFF3EEAFFFF3EC5F9FF2589
      FFFF2C78F48C0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000258DF68F2096FFFF3BBCF8FF4DF0
      FFFF42E2FEFF41E3FEFE41E3FEFF40E2FEFF3DE1FEFF3CE1FEFF3CE2FEFF3BE1
      FEFF3BE1FEFF3BE0FFFF3AE4FFFF3FF1FFFF3FE3FCFF3FE4FDFF3DF1FFFF39E5
      FFFF3AE0FEFF3BE1FEFF3DE3FEFF3DE2FEFF3DE2FEFF3DE2FFFF3DE2FEFF3DE2
      FEFF3CE2FEFF3CE1FEFF3AE0FEFE39E0FFFF3AEDFFFF3FE7FFFF3ED5E8FF3EDD
      F4FF3CF0FFFF39E4FFFF3ADFFEFF3AE0FEFF3BE0FEFF3BE0FEFF3BE1FEFF3AE0
      FEFF3BE0FEFF3CE0FFFF3DE1FEFF3DE0FEFF48EFFEFF34ACF9FF268BFFFF307B
      F24F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000406ACB544D7CD5FFCDE8F9FFC3E9FEFFB3DBFEFFB7DDFEFFB7DDFEFFB6DC
      FEFFB4DBFDFEB3DAFDFFB3D9FDFFB1D9FEFFA1CAF5FF4D7ACBFC4869CD2E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005264D6385180D1FF93C1F2FF92BFF1FF91BFF1FF93C1F2FF95C2F3FF96C4
      F3FF98C5F3FF99C6F3FF9AC7F4FF9BC8F5FF9CC9F5FF9ECAF6FF9ECBF5FFA0CC
      F6FFA1CCF6FFA2CDF6FFA3CFF7FFA6D1F8FFA8D2F9FFA9D3FAFFAAD3F9FFABD4
      FAFFB1DAFBFFA7D2F7FF7EAFE8FF649BE0FE6DA0E3FE6195DAFF70A5E4FE77AB
      E7FE92C1F1FF98C5F3FF9CC9F5FFA0CDF6FFA3CFF7FFA6D1F9FFA9D4FAFFABD5
      FBFFADD7FBFFAFD8FCFFB2DAFCFFB3DBFDFFB3DCFDFFB4DDFDFFB5DDFDFFB6DD
      FDFFB5DDFDFFB5DDFDFEB4DDFCFFB4DDFDFFC8E9FFFF628BD1FF375EC0410000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003E74F7212188FAF72EA0FCFF49EBFEFF39DFFFFF39DEFEFF38DEFEFF38DF
      FEFF38DFFEFF37E4FFFF41E2F0FF2C4544FF1F1C19FF24312EFF222F2CFF2025
      23FF222C2AFF23312FFF222522FF23201FFF3CC0CCFF3CEEFFFF39E1FEFF3AE1
      FEFF39E2FEFF39E1FEFF3AE3FEFF39E7FFFF40E0EEFF2B3B3AFF20211EFF2533
      30FF232D2BFF212321FF222A27FF233230FF232B29FF211916FF3AAEB7FF3BF0
      FFFF3AE1FFFF3AE1FFFF3BE1FEFF3DE2FEFF3EE3FEFF47E8FEFF2E96F9FF2480
      F7F63366F0230000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003575F418228DF8EF2697FCFF52E3
      FCFF48E7FEFF45E4FEFF43E3FFFF43E3FEFF41E3FFFF41E3FEFF40E3FFFF40E3
      FEFF40E3FEFF3FE3FFFF3EE2FEFF3EE2FFFF3CE3FFFF3CE3FFFF3EE2FFFF3EE2
      FEFF3FE3FEFF40E3FEFF41E4FEFF41E3FEFE41E4FFFF41E3FEFF41E3FEFF40E3
      FEFF40E2FEFF3FE2FEFF3DE2FEFF3DE2FEFF3DE1FEFF3CE2FFFF3CE4FFFF3CE2
      FFFF3BE0FEFF3CE1FEFF3DE1FFFF3DE1FEFF3EE1FEFF3EE1FEFF3EE2FEFF3EE1
      FEFF3FE1FEFF40E1FEFF3FE1FEFF43EAFEFF43D4FAFF2692FFFF2980F4BF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002A60C8B88FB5EBFFE1FBFFFFB7DEFEFFB7DDFEFFB7DDFEFFB7DC
      FEFFB4DBFDFEB3DAFDFFB2D9FCFFAFD7FCFFAED8FDFF6497DEFF3961C0860000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006761D52A4E7DC9F993C1F1FF93C0F2FF90BEF0FF92BFF1FF93C1F2FF95C3
      F2FE97C5F3FF99C6F4FF99C7F4FF9BC8F5FF9CC8F5FF9ECAF6FF9FCBF5FFA0CC
      F6FFA0CCF6FFA1CCF6FFA2CEF7FFA3CFF7FFA6D1F8FFA8D2F8FFA8D2F8FFA9D3
      F9FFA6D2F8FFA9D4F9FFAED8FAFF8ABBECFF649BDEFF5B92D8FF6DA3E3FF80B2
      EAFF98C6F2FF98C6F3FE9DCAF5FFA2CEF7FFA5D0F8FFA8D2F9FFAAD5FAFFACD6
      FBFFADD7FBFFB0D8FCFFB0D9FCFEB2DAFCFFB3DCFCFFB5DDFDFFB5DDFDFFB5DD
      FDFFB6DDFDFFB6DDFDFEB5DDFCFFB4DDFDFFC3E8FFFF6E9CE0FF4365CA6A0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002788F8892191FFFF40C0F9FF44ECFEFF3BE0FEFF3BE0FEFF3CE0
      FEFF3BE1FEFF3BE1FFFF3CEBFFFF43D9E7FF2F5453FF1F1A16FF1E1F1DFF2024
      22FF202321FF1E1916FF252B28FF3EB2BAFF40F5FFFF3CE2FEFF3DE2FEFF3DE2
      FEFF3CE2FEFF3CE2FEFF3CE3FEFF3CE2FEFF3CEFFFFF43CCD6FF2A3B39FF2019
      15FF212623FF222B29FF212624FF1F1A18FF22201EFF3B9DA2FF40F5FFFF3CE2
      FEFF3DE3FEFF3DE3FEFF3FE3FEFF3FE3FEFF49F0FFFF3AB9F8FF2588FFFF2880
      F28E000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002887F4731F96FFFF39AE
      FAFF53F2FEFF47E5FEFF47E4FEFF46E4FEFF44E5FFFF44E4FEFF44E5FFFF44E4
      FEFF43E4FEFF44E4FEFF42E4FEFF43E4FFFF42E4FEFF41E4FEFF41E4FEFF42E4
      FEFF44E5FEFF44E4FEFF44E5FEFF44E5FEFF45E5FEFF45E4FEFF44E5FEFF43E4
      FEFF43E4FEFF42E4FEFF41E3FEFF41E3FEFF41E2FEFF41E2FEFF40E2FEFF40E2
      FEFF40E2FEFF40E2FEFF41E2FEFF41E1FEFF41E2FEFF41E3FEFF41E2FEFF41E2
      FEFF43E2FEFF43E2FDFF42E5FEFF4BEBFDFF2E9EF9FF2986FBFD366CF5340000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003F62D0415080D4FFD5EEFCFFC1E5FFFFB5DCFEFFB7DDFEFFB7DC
      FEFFB5DBFDFFB4DAFDFFB2D9FCFFB0D7FCFEB1D9FFFF87B5EAFF3967BEDE664D
      CC0A000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005266D6194979C8F092BFF1FF94C0F2FF90BEF1FF91BEF1FF93C1F1FF95C3
      F2FF97C3F3FF98C5F3FF99C7F4FF9AC7F5FF9BC8F5FF9CCAF5FF9ECAF5FF9FCB
      F6FF9FCBF6FFA0CCF6FFA1CDF7FFA2CEF7FFA5D0F8FEA6D1F8FFA7D1F8FFA8D2
      F8FFA7D2F8FFA7D2F8FFA6D1F8FFAED8FBFF96C3EFFF5990D6FF6AA0E2FF82B4
      EBFE99C6F3FF99C6F3FF9FCAF6FFA3CEF7FFA5D1F8FFA8D3F9FFAAD5FAFFADD6
      FAFFAED8FBFFAFD9FCFFB1D9FBFEB3DAFCFFB3DCFCFFB5DDFDFFB5DCFDFFB6DD
      FDFFB6DEFDFEB6DDFDFEB5DCFDFFB5DDFDFFC2E6FFFF709EE2FF4169CA790000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004E62FF0D268AFAE02696FFFF49DEFCFF45E8FFFF41E2FEFF40E2
      FFFF3FE2FFFF40E2FEFF3EE0FEFF3DE9FFFF43ECFFFF3BA3AAFF326567FF2D55
      54FF2D5555FF368086FF44D3E2FF42F3FFFF3FE3FFFF40E3FEFF40E3FEFF40E3
      FEFF3FE3FEFF40E2FEFF40E3FEFF3FE3FEFF3EE1FEFF3FEEFFFF45DEEDFF3987
      8AFF2D4B4BFF2A3C3CFF2F4C4CFF357172FF42C6D0FF43F4FFFF3DE2FFFF3EE2
      FEFF40E3FFFF41E2FEFF42E2FEFF47EAFFFF4CDCFBFF268FFEFF2B7DF8E45547
      F112000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00FF02268EFBC82293
      FFFF4BCFFBFE53F1FFFF49E5FEFF4AE6FFFF48E6FFFF47E6FFFF48E5FEFF47E6
      FFFF46E5FFFF47E5FEFF47E5FEFF47E5FEFF47E5FEFF48E5FEFF45E5FEFF46E5
      FEFF48E6FEFF48E6FEFF4AE6FEFF4AE6FFFF49E6FEFF49E6FEFF48E5FEFF48E5
      FEFF46E5FEFF46E4FEFF45E4FEFF44E4FEFF44E3FEFF44E3FFFF44E4FFFF44E3
      FEFF44E3FFFF45E3FEFF45E3FEFF45E3FEFF45E3FEFF45E4FEFF45E3FEFF44E3
      FFFF46E4FEFF46E3FEFF50F2FEFF3BB6F9FF288FFFFF327AF48E000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF02336BC7D5A6C8F3FFCFF0FFFFB3DAFDFFB6DCFEFFB5DB
      FEFFB4DCFDFFB3DAFDFFB2D9FCFFAFD7FCFFAED6FCFF9FCAF3FF4E79CEFF465F
      BD3E000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000495BDB0E4973C8E690BBF1FF95C2F3FF8FBDF1FF91BEF1FF93C0F1FF94C1
      F1FF95C2F3FF96C4F3FF98C6F4FF9AC7F4FF9BC7F5FF9CC9F5FF9CC9F5FF9ECA
      F6FF9ECAF6FFA0CCF6FFA1CDF7FFA2CEF7FFA3CFF7FFA5CFF7FFA5D0F8FEA6D1
      F7FFA7D1F8FFA7D2F8FFA7D1F7FFA5D0F7FFAED9FBFF77A9E1FF5C93DBFE7DAF
      EAFE98C6F4FF99C7F4FFA1CCF7FFA4CFF8FFA6D1F9FFA8D3F9FEABD5FAFFADD7
      FBFFAFD8FBFFB0D8FCFFB1D9FCFEB3DAFCFFB4DCFCFEB5DDFDFFB5DCFDFFB6DD
      FDFFB5DDFDFFB5DEFDFFB5DDFDFFB4DDFEFFC2E7FEFF6796DEFF4069CB6B0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002D81F549218FFFFF2DA2FCFF52EDFDFF46E6FEFF46E4
      FEFF43E4FEFF43E4FEFF41E3FEFF41E2FEFF40E4FFFF44F3FFFF47F2FFFF48ED
      FFFF46EFFFFF46F4FFFF41EBFFFF43E4FFFF44E5FFFF44E5FEFF44E4FEFF44E4
      FEFF44E4FEFF44E4FEFF44E5FEFF44E4FEFF44E4FEFF43E3FEFF41E8FFFF47F7
      FFFF46E9FFFF46DCF2FF49EAFFFF48F6FFFF43EDFFFF43E3FFFF42E3FEFF42E4
      FEFF43E4FEFF44E4FEFF46E6FEFE51ECFDFE2F9DF9FF2689FFFF326EF6510000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003480F92C238F
      FDF82797FFFF59E7FCFF50ECFEFF4DE7FEFF4BE7FFFF4BE7FFFF4BE6FFFF4AE7
      FFFF49E6FFFF49E7FEFF4AE7FEFF4AE7FEFF4BE7FEFF4CE7FEFF4AE7FEFF4AE6
      FEFF4CE7FEFF4CE7FEFF4DE8FFFF4DE7FFFF4EE7FFFF4DE8FEFF4BE6FFFF4BE5
      FFFF4AE6FFFF4AE6FEFF49E6FEFF48E6FEFF48E5FEFF48E5FEFF48E5FEFF48E5
      FEFF48E5FEFF47E5FEFE49E5FEFF49E5FFFF48E4FEFF48E5FEFF47E4FEFF48E4
      FEFF47E4FEFF50F0FFFF49CCFAFF248FFFFF2B84F7D2664DFF0A000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000316BCA8173A1E8FFD7F4FFFFB3DBFDFFB5DCFEFFB5DB
      FDFFB4DBFEFFB3DAFDFFB1D9FCFFAFD7FCFFADD5FCFFAAD4FAFF5A8BDAFF4962
      C26D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00FF02446AC5CD8AB8F1FF97C4F5FF8FBDF1FF90BDF1FF92BFF1FF93C0
      F2FF95C2F2FF96C3F3FF96C4F3FF99C5F3FF9AC7F4FF9CC8F5FF9CC9F5FF9DC9
      F5FF9ECAF6FF9FCBF6FF9FCCF6FFA1CDF6FFA2CDF7FFA3CEF7FFA4CFF8FFA5D0
      F8FFA7D1F8FFA7D1F8FFA7D1F7FFA6D0F8FFA8D4F9FF97C4EFFF578FD7FE72A6
      E4FF9AC8F4FF9CC9F5FFA1CDF7FFA5D0F8FFA7D2F9FFA9D3F9FEACD6FAFFAED7
      FBFFAFD8FCFFB0DAFBFFB1DAFCFFB4DBFCFFB4DDFDFFB5DDFDFFB5DDFDFFB6DD
      FDFFB6DEFDFFB6DEFDFFB5DDFDFFB8E1FFFFB7DDF9FF527BCFFF506ACF300000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002686F7851F96FFFF40B2F9FF57F1FEFF4AE6
      FFFF47E5FEFF48E5FEFF48E4FEFF47E4FEFF45E5FEFF45E4FEFF44E4FFFF44E5
      FFFF44E4FFFF45E5FEFF45E5FEFF47E5FFFF47E5FFFF47E5FEFF49E6FEFF49E5
      FEFF49E6FEFF48E5FEFF47E5FDFF48E5FEFF48E6FEFF48E6FEFF47E5FEFF47E4
      FEFF46E5FFFF45E8FFFF46E6FFFF47E5FFFF48E4FEFF48E4FEFF46E4FEFF46E4
      FEFF48E4FEFF47E5FEFF52F2FEFF3BB1FAFF248DFFFF2E7EF490000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002C85
      F7621F98FFFF35A8FCFF61F0FDFF54EDFEFF50E7FFFF4FE8FFFF4DE7FEFF4DE7
      FFFF4EE8FFFF4EE7FFFF4DE7FFFF4DE7FEFF4EE7FEFF4EE7FEFF4EE7FEFF4EE7
      FEFF4EE8FEFF4EE8FEFF50E8FFFF50E8FFFF51E8FFFF50E8FEFF4FE8FEFF4EE7
      FEFF4EE7FEFF4DE7FEFF4DE7FEFF4CE6FEFF4BE6FEFF4BE5FEFF4BE6FEFF4BE5
      FEFF49E5FFFF49E4FEFF4CE5FEFF4BE5FEFF4AE5FFFF49E4FFFF48E4FEFF48E3
      FEFF50F2FEFF4ED8FBFF2A92FDFF278CFAF93472EF3100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004169D2335082D5FDCFEDFDFFBDE1FEFFB2D9FDFFB5DB
      FDFFB3D9FDFFB2D8FDFFB0D7FCFFAFD6FCFFABD3FBFFADD7FCFF6292DFFF4264
      C17B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003D66C0A77BACEDFF9AC5F6FF8FBDF1FF91BEF1FF92BFF1FF93C0
      F2FF94C2F2FF96C2F2FF96C4F2FF97C5F3FF98C5F3FF9AC7F4FF9CC8F4FF9DC8
      F5FF9DC9F5FF9DC9F5FF9ECBF6FF9FCBF6FFA1CCF7FFA2CDF7FFA3CEF7FFA4CF
      F7FFA5CFF7FFA6D0F7FFA6D0F7FFA5CFF7FFA3CEF7FEABD5F9FE7DADE6FF5E93
      DAFF84B5EBFFA0CCF6FFA8D4F9FFB0DAFBFFB3DCFDFFB5DDFDFFB3DCFCFFB3DB
      FCFFB3DCFDFFB3DCFDFFB3DCFDFFB5DDFEFFB5DEFEFFB6DEFEFFB6DFFEFFB6DF
      FEFFB7E0FEFFB7E1FEFFBAE4FFFFC9EEFFFF7FB2F1FF4367CAC2000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000288DF7A52193FFFF41BDFAFF5AF3
      FEFF4CE7FFFF4CE5FEFF4CE7FEFF4CE6FEFF49E6FEFF4AE6FEFF4AE6FEFF49E6
      FEFF4AE6FEFF4AE6FDFF49E6FFFF4AE6FFFF4BE7FEFF4BE7FEFF4DE7FEFF4DE7
      FEFF4DE7FEFF4CE7FEFF4CE7FEFF4CE7FEFF4BE7FEFF4BE7FEFF4CE7FEFF4BE6
      FEFF4BE6FEFF4BE7FEFF4CE6FEFF4CE6FEFF4CE6FEFF4BE6FEFF4BE5FEFF4BE4
      FEFF4BE6FEFF55F2FEFF42BFFAFF228CFFFF2D80F8B9FF00FF02000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002D90FB882098FFFF37ACFCFF63F1FDFF57EEFEFF52E8FEFF51E8FFFF51E8
      FEFF51E9FFFF51E9FFFF50E9FFFF50E9FEFF52E9FEFF51E9FEFF51E9FEFF51E8
      FEFF51E9FEFF51E9FEFF53EAFFFF53EAFEFF53EAFEFF52E9FEFF52E9FEFF52E9
      FEFF52E8FEFF51E8FEFF50E8FEFF50E8FEFF4EE7FEFF4EE6FEFF4EE7FEFF4DE6
      FEFF4DE6FEFF4CE6FEFF4EE6FEFF4EE6FEFF4DE6FEFF4CE6FEFF4AE5FEFF53F1
      FFFF51DCFBFE2693FBFF2691FFFF2E7AEF5E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005555E3094273CEE3BEDEF8FFCAECFFFFB0D7FCFFB4DA
      FDFFB2D9FDFFB1D8FDFFAED6FCFFADD5FBFFAAD3FAFFAED8FCFF6795E1FF4564
      C282000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003F5EBD51608DDCFF9BC6F6FF8FBCF1FF90BEF1FF91BFF1FF93C0
      F1FF94C0F2FF95C2F2FF95C3F2FF96C3F2FE97C5F3FF99C6F4FF9BC6F4FF9CC8
      F5FF9CC8F5FF9CC9F4FF9ECAF6FF9FCAF6FFA0CCF6FFA1CDF6FFA3CEF7FFA3CE
      F7FFA4CEF7FFA5CFF8FFA6D0F7FFA5CFF7FFA2CDF7FFABD6FAFF7BACE4FF568B
      D5FF538CD7FF5991D9FF609ADFFF6DA5E4FF78AEE6FF84B7EBFF91C2F0FF9BC9
      F2FFA0CCF3FFA6D0F6FFABD4F8FFB0D7F9FFB3DAFAFEB6DDFBFFB9DFFBFFBADF
      FBFFBAE0FBFFB8DDFAFFB2D7F5FF7AA8E4FF4074D1D7536BD52B000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CC00CC052C8AF9B52194FFFF42B8
      FAFF5EF1FEFF53EBFEFF4EE6FEFF4EE7FEFF4EE7FEFF4FE7FEFF4EE8FEFF4EE7
      FEFF4FE8FEFF4FE8FEFF4FE7FEFF4FE8FEFF51E8FEFF51E8FEFF51E8FEFF51E8
      FEFF51E8FEFF51E8FEFF50E9FEFF50E8FEFF50E8FEFF51E9FEFF51E8FEFF51E8
      FEFF51E8FEFF52E8FEFF50E7FEFF4FE7FEFF51E8FEFF50E7FEFF4FE6FEFF4FE7
      FEFE5BF5FEFF45C1FBFF258CFFFF267EF6C74455EE0F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002988F6901D98FFFF36A6FCFF62EBFCFF5CF5FEFF53E9FEFF54EA
      FEFF54E9FFFF54E9FFFF54EAFEFF53EAFEFF54EAFEFF54EAFEFF53EAFEFF53EA
      FEFF54E9FEFF54E9FEFF56EAFFFF56EAFFFF55EAFEFF55EAFEFF55EAFEFF55E9
      FEFF54E9FEFF53E8FEFF53E9FFFF53E8FEFF52E8FEFF52E8FEFF50E8FEFF50E7
      FEFF4FE6FEFF4FE6FEFF4EE6FFFF4EE5FFFF4EE6FEFF4EE8FEFF5BF5FEFF50D1
      FAFF2994FDFF258FFFFF307CF36B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003464CABF9AC1F0FFD8F5FFFFB1D8FCFFB1D8
      FCFFB1D8FDFFB0D7FCFFADD5FBFFACD3FBFFA9D1FAFFACD6FBFF6492DCFF3F5F
      BE7E000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008040FF044169C1CC81AFEEFF9DC8F7FF91BDF1FF91BDF0FF91BE
      F0FF92BFF1FF93C0F1FF95C2F1FF96C3F2FF97C4F3FF98C5F3FF99C6F3FF9AC7
      F4FF9BC7F4FF9CC8F4FF9DC9F5FF9ECAF5FF9FCBF5FFA0CCF6FFA1CDF6FFA3CD
      F7FFA3CEF6FFA4CFF7FFA5CFF7FFA5CFF7FFA8D2F9FF99C4EFFF558BD4FE6CA0
      E2FF77ACE7FF82B3EAFF84B6ECFF7BB0E8FF6FA7E5FF67A1E2FF65A0E1FF629D
      E0FF5E9ADFFF5C98DEFF619ADEFF6098DDFF5E98DEFF5C96DEFF5C96DDFF5B94
      DCFF578FDAFF548AD6FE477FD2FF4778D6F47676DE2700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007139FF09278CF9B21F94
      FFFF39AFFBFF60EEFCFF57F0FFFF52E8FEFF53EAFFFF53E9FEFF52E9FEFF52E9
      FEFF53E9FEFF54E9FEFF53E9FEFF53EAFEFF55E9FEFF54E9FEFF55EAFEFF55E9
      FEFF55EAFEFF55EAFEFF55E9FEFF54EAFEFF54EAFEFF54EAFEFF54EAFEFF55EA
      FEFF56EBFEFF56EAFEFF54E9FEFF53E9FEFF54E9FEFF53E8FEFF56EFFEFF5DEF
      FDFF3EB4FBFF228EFFFF2A80F8C14B4BE1110000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002B90FD831E94FFFF279DFFFF58DDFCFF63F8FEFF57ED
      FEFF57EAFFFF57EBFFFF58EBFEFF58EBFEFF57EBFEFF57EBFEFF57EBFEFF56EB
      FEFF58EBFEFF58EBFEFF59ECFFFF58ECFEFF58EBFEFF58EBFEFF58EBFEFF57EB
      FEFF57EBFFFF56EAFEFF57EAFEFF56E9FEFF55EAFEFF55E9FEFF54E9FEFF53E8
      FEFF52E7FEFF52E7FEFF51E7FEFF51E6FEFF55EEFEFF5DEFFEFF43B9F9FF218F
      FFFF258DFBFC2D7EF46100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003362CA9A88B1ECFFE1FAFFFFB5DBFDFFB0D7
      FCFFB0D7FCFFAFD6FCFFACD4FBFFABD3FAFFA8D0FAFFA9D2F9FF5C89D6FF4762
      BF68000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004864CD2E4971CBEB7CAFEFFF95C2F3FF98C4F4FF99C6
      F4FF97C4F4FF9AC7F5FF9AC8F6FF95C2F2FF95C2F2FF97C4F3FF98C5F3FF9AC6
      F3FF9AC6F3FF9BC7F4FF9CC8F5FF9DC9F5FF9FCAF5FF9FCBF5FFA1CCF6FFA2CD
      F6FFA3CDF7FFA4CFF6FFA5CEF7FFA4CEF7FFACD5FAFF699AD9FF5E94DCFF7AAF
      EAFF8CBDEFFFA6D0F8FEA8D2F9FFADD6FAFFB1DAFDFFB3DBFDFFB5DCFCFFB5DC
      FCFFB4DCFCFFB2DAFAFFB0D8FAFFAFD7F9FFACD6F9FFA8D2F7FFA4CFF6FFA2CD
      F4FFA1CBF3FFA3CCF3FEA1CBF3FF5F93DFFF476EC86F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF00FF01248A
      F8942195FFFF31A2FFFF5CDBFBFF65F7FEFF59EFFEFF56EBFEFF56EAFEFF57EA
      FEFF59EBFEFF59ECFEFF57EBFEFE58EBFEFF58EBFEFF59EBFEFF5AEBFEFF59EB
      FEFF59EBFEFF59EBFEFF59EBFEFF59EBFEFF59ECFEFF59EBFEFF59ECFEFF5AEC
      FEFF5AEBFEFF5AEBFEFF59EBFEFF58EAFEFE59EDFDFF62F6FEFF59E1FBFF34A4
      FDFF238DFFFF2E86F7A86633E60A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002A83F7612390FDF72397FFFF4BC3FBFF68F3
      FDFF62F6FEFF5AEDFEFF5BEDFEFF5BEDFEFF5BECFEFF5BECFEFF5AECFEFF5AEC
      FEFF5BECFEFF5BECFEFF5BEDFEFF5BEDFFFF5CEDFFFF5CECFEFF5BECFEFF5AEC
      FEFF5AECFEFF5AEBFEFF59EAFEFF59EBFEFF58EAFEFF57EAFEFF56EAFEFF55E9
      FEFF55E9FEFF55E8FEFF57ECFEFF61F6FEFF59E2FBFF33A4F9FF2290FFFF268B
      F9E6347AF0450000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003061C576719EE4FFDEF7FFFFB5DBFDFFB0D6
      FCFFAFD7FCFFADD5FCFFABD3FAFFA9D1FAFFAAD2FBFF9EC7F1FF4E75C8FF5260
      C438000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004653C628416ECAB74E7CCCFC6592E3FF719D
      E9FF6E99E8FF6F99E5FF81AEE6FF9BC7F4FF9CC8F6FF96C2F3FF96C3F2FF98C4
      F2FF99C5F2FF99C5F3FF9BC6F4FF9CC7F4FF9EC8F5FF9ECAF5FFA1CBF5FFA1CC
      F6FFA2CDF6FFA3CDF6FFA4CEF6FFA7D0F8FF9EC8F0FF588CD5FF6FA4E3FF7BAE
      E9FE9CC8F4FFA3CDF6FFA3CEF7FFA6D0F8FFA7D1F9FFA9D3FAFFABD5FAFFADD6
      FBFFAFD8FBFFB2D9FCFFB3DBFDFFB6DCFDFFB7DDFEFFB9DFFEFFB8DFFEFFBAE1
      FFFFBBE2FFFFBAE1FFFFC9EEFFFF87B2E9FF3B64C5A800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000368AFF64238DFCF52296FFFF42B6FBFF5FE7FCFF67F7FEFF5DF0FFFF5AEC
      FEFF5CECFDFF5DECFEFF5BECFEFF5BECFEFF5CECFEFF5DECFDFE5DECFEFF5DEC
      FEFF5DECFEFF5DECFEFF5DEDFEFF5DECFEFF5DEDFEFF5CEDFEFF5DEDFEFF5DED
      FEFF5DECFEFF5CEDFEFF5FEFFEFF67F6FEFF64EDFDFF45BDFCFF2694FFFF2385
      FCF83083FB750000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F78FA35298EFDD11C99FFFF31A5
      FFFF55D3FBFF6AF4FDFF66F7FEFF5EF0FEFF5DEEFEFF5EEEFEFF5CEDFEFF5DED
      FEFF5EEEFEFF5EEDFEFF5EEEFEFF5EEEFFFF5FEEFFFF5FEDFFFF5DEDFEFF5DEC
      FEFF5DEDFEFF5DECFEFF5CECFEFF5CECFFFF5BECFEFF5AEBFEFF59EBFEFF58EB
      FFFF5AEEFEFF62F5FEFF62EEFDFE45BFFBFF2497FFFF2492FFFF2784F9B53060
      E720000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000345EC2546591DAFFDDF5FFFFB7DDFDFFAFD6
      FBFEAFD6FCFFACD4FBFFA9D1F9FEA6CFF8FFAFD7FDFF83B1E8FF4469C5D86D49
      DB07000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000475FD02B4565CF603D5F
      C67E3E63C37C4365C29F456AC3EA5C8DDAFF80B1EBFF98C6F2FFA0CCF7FF9AC7
      F5FF97C3F2FF97C3F2FF99C5F3FF9AC6F3FF9CC7F5FE9DC8F4FF9FCAF5FF9FCB
      F5FFA1CCF5FFA2CCF6FFA4CEF7FFA8D2F9FF90BCEAFF568CD6FF71A6E4FF8AB8
      ECFFA4CDF6FFA3CCF6FFA4CFF7FFA6D0F8FFA7D1F8FFA9D3F9FEABD4FAFFADD7
      FBFFAFD8FCFFB1D9FCFFB3DAFCFFB4DBFDFFB4DBFDFFB5DCFDFFB5DDFDFFB5DC
      FDFFB6DDFDFFB5DCFDFFC2E8FFFF8AB3E8FF3D62C4B700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003E71F42D298EF9B31E91FFFF289BFFFF4CBBFAFF62E5FDFF69F8
      FFFF66F6FDFF61F1FEFF5EEDFEFF5EEDFEFF60EDFEFF60EDFEFF60EDFEFF60ED
      FEFF60EDFEFF60EDFEFF5FEDFEFF5EEDFEFF60EEFEFF60EDFEFF5EEDFEFF60F0
      FEFF67F6FDFF6BF9FDFF62E6FCFF4BBFFCFF2F9CFFFF208EFFFF2D86FABD3370
      F532000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D33FF0A2B8CF9832090
      FCF62098FFFF37A7FEFF56D0FCFF6DF3FDFF6CFBFEFF66F7FEFF61F1FEFF60EF
      FEFF5FEEFEFF60EEFEFF62EFFEFF61EFFFFF5FEEFEFF5FEEFEFF61EEFEFF61EE
      FFFF61EEFEFF60EEFEFE5FEEFEFF5EEEFEFF5DEEFEFF5EF1FFFF63F6FEFF67F6
      FEFF60E6FCFF4BC3FAFF2F9FFFFF2094FFFF278EF9E22E7AF564000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002F56C4415986D6FFD6EDFDFFBDE1FDFFABD4
      FBFFAED4FBFFABD3FBFFA7CFF9FFA4CEF9FFA8D0F8FF608ADCFF4D68C97B0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006464D3174265C674436BC7D55584D6FF76A5E6FF8FBB
      EEFF9FCAF5FFA4CDF8FFA0CAF6FF9CC7F5FF9AC6F5FF9AC5F4FF9BC6F4FF9CC7
      F5FF9EC8F5FF9FCAF5FFA1CBF5FFA5CEF7FF8EBBEBFF598ED7FF71A7E4FF94C1
      F0FFA2CCF6FFA2CDF7FFA5CFF7FFA7D0F8FFA8D1F8FFAAD3F9FFACD5FAFFAED6
      FBFFAFD7FBFFB1D9FDFFB2DAFCFEB4DBFDFFB5DCFDFFB6DCFDFFB6DCFDFFB6DD
      FDFFB6DDFDFFB5DDFDFFC4E9FFFF7AA4E3FF3961C39800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002F84FC57298EFBD61F93FFFF2499FFFF3AAE
      FDFF54D0FBFE66E9FCFF6CF3FDFE6FF8FEFE6DF8FEFF6AF6FEFF67F4FEFF66F3
      FEFF65F4FEFF65F4FEFF66F5FEFF67F6FDFF6BF8FEFE6EF8FEFF6BF2FDFF64E6
      FCFF56D1FCFF3EB3FFFF2799FFFF1F8BFFFF2484FBD02F81FA61000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003577
      F32B2B8EFDA7238DFCFB1D97FFFF2DA3FFFF44BDFDFF5BDBFCFE6BEFFCFF71F7
      FDFF6EF9FEFE6AF7FEFF69F7FFFF68F6FFFF63F3FFFF63F2FFFF66F2FEFF66F4
      FEFF67F5FEFF68F6FEFE6AF8FFFF6CF8FEFF6CF3FDFF65E5FCFE52CCFBFF3AAD
      FCFF259AFFFF1D90FFFF2389F9DF2F86FB723947E31200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004E5ED32E517BCDFED5EBFBFFC9E9FFFFAAD3
      FBFFACD3FBFFA9D1FAFFA3CCF9FFADD5FCFE7AA6E5FF4665C1E37755DD0F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF40FF044768D153426BC6BD4770
      C5F9598CDAFF6EA3E7FF81B1EDFF90BEF0FF9AC7F3FFA3CDF5FFA4CEF6FFA5CF
      F8FFA6D0F9FFA6D0F8FEA6D1F9FFA6D1F9FEA0CCF5FF5F93D8FF6DA3E2FE98C3
      F1FEA1CCF6FFA3CDF7FFA6CFF7FFA8D1F9FFA9D2F9FFAAD3F9FFACD5FAFFAFD7
      FBFFAFD8FBFFB1D9FCFFB3DAFDFFB4DBFDFFB5DCFDFFB6DCFDFFB6DCFDFFB6DD
      FDFFB6DDFDFEB7DFFEFEC1E5FCFF5F8BDAFF3E5EC45F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000DF083285F95C268DFBC11D8C
      F9FB1D96FFFF289CFFFF38A5FFFF4BB6FBFF51C3FBFF59D2FCFF61D6FBFF64DA
      FBFF60DBFBFF5DD9FCFF5DD6FBFF57D0FBFF4EC1FCFF43B5FEFF35A3FFFF2A97
      FFFF228EFFFF1F84FAF82684F9B3297AF84B8000800200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000396CF42D298CFB8E218DFAE11B93FFFF1F9AFFFF2DA3FFFF3DAE
      FEFF48BAFCFF51C6FCFF59D5FDFF5EDBFCFF61E2FDFF63E5FDFF65E5FDFF60E0
      FDFF5BD7FCFF57D2FCFF4FC5FAFF45B8FCFF37A8FFFF2A9DFFFF2093FFFF208B
      FCFF268AF9C82879F5674937ED0E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005B5BDB0E4772CAEDCBE0FAFFDFF9FFFFB5DB
      FCFEA5D0FBFFA6D0FBFFACD6FCFF85B1E8FF4770CDFF5168D142000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000535A
      D6253C67C9593665C0923C6AC5C24771C6E95380D2FF5F90DDFF6A99E4FF74A1
      E7FF7EACEBFF87B4ECFF8EBCECFF91BEECFF97C4EFFF6C98D9FF6090DAFF9CC8
      F3FFB4DBFCFFB1D9FCFFADD6FBFFADD5FCFFACD5FBFEADD6FBFFACD6FBFFAFD7
      FCFFB0D7FCFFB2D9FCFFB3DAFCFFB4DBFDFFB4DCFCFFB6DDFDFFB6DEFCFFB6DE
      FDFFBCE3FFFFCBEFFEFE8DB8F0FF406ACCDA4E4ED80D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002F77
      F92B2C8AFD742889F9B72087F9E41E85FBFF1D8CFFFF1F90FFFF2192FFFF2394
      FFFF2496FFFF2495FFFF2293FFFF2091FFFF1E8CFFFF2085FBFA2384FADA2783
      FAA52D7BFA66326AF82400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000624EFF0D3086F9502F8AFD99258EFDD1208D
      FBF42093FFFF1E99FFFF209BFFFF219CFFFF259DFFFF259EFFFF279EFFFF269D
      FFFF2299FFFF2196FFFF1E94FFFF1F8DFAFD238DFBE5278EFCB62987F97B3078
      F535000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000416ECBA27CA7EEFFD2EBF8FFD5F3
      FEFEBCDFFCFEABD3F7FF79A6E6FF496CC9F54864CE5900000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006355C6124665CF3A4567D05C3B68CA7D3967
      C686456DCAA9466EC9C0496EC6D54A70C6DF4970C7EA5076CBEB5276CDFB5D89
      D9FF77A8E7FF8AB9F0FF9AC8F6FFA4CEF5FFAED6F9FFB3D9FBFFBCE1FDFFBEE3
      FEFFBEE3FFFFBFE4FEFEBFE4FEFEC0E5FEFEC4E8FFFFC6E9FFFFC4E9FEFEC4E9
      FFFFBDDFFBFF82AEECFF4570CEE44468D0310000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005555EA0C4478FF313C87FF513B85FB75318BF888338C
      F895358DFA9B348DFA932F82F9833081F86F377CF8464E76FF279224DB070000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000556F
      FF1E3683F7423089FA6A2D90FB833393FC95318CFAA02A8BF9A3318EF7A5318F
      F8962B8DF9823086F8743186FF4E357DFF2B5555FF0C00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000647ADE173D6FD1C35581DDFF7298
      E6FF6E9AE3FF557ED2FF4264CFC14E67CE340000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF40FF049966FF0A4060CF105A5AE1116066DF284261
      CD42335EC06D3864C5963E6FC5BC4A75C7DC4E7CC9EB5583CEF76892DCFF6E9B
      E1FF7BA7ECFF84AFF0FF84B1EFFF87B3F0FF8DB6F0FF8EB5F0FF87B0EDFF749E
      E5FF547DD2F93E67CCAE3E58B91D000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000FF00FF02546FE14C4462
      D77F3C60D16A465FD73300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007139E3091E3CD211475CD524395DCE3F3A61
      D24F3967CC743264C97F3462C5803863C5843162C6823162C6822E60C7803E65
      D85B4A5ED7260000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000025645D292564497B22583C8029563D7D2754
      3D7D2954407C29543F7D2B563B7D27583E7C255A3F7D2758437D255A3F7D275A
      427C275C3D7D275A3D7D28573F7E2B57417E2855437E2853437E255A3B7D275E
      497D344E6D310000000000000000000000000000000000000000000000000000
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
      00000000FF016E635148656044886A5D51876763523E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001A051A310B04
      0746130008430C000442100000410C0000410F0004420F0404420F0004420F04
      0843130808440F0408430F0008430F0404430C0404420B040443100000410C04
      04420F0408440B0408440F0408430B0004430F0408430B040443100404410F04
      044213040B43130008430C040041080000410C000041080000410C0000410C00
      04410F0404420C0000410C0004400C0000410C0000410C0004420C0404410C00
      0041100404410F000442100000410C0004410F0404420C040442100000410C00
      04410F0408441304084313040844100408403300660500000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000663305275D4DD3377466FF317769FF327365FF3273
      64FF337164FF337265FF327365FF327366FF337467FF337467FF327566FF3275
      66FF327464FF327465FF337365FF337466FF347367FF347368FF337468FF3C69
      6BFF36505BE217462E0B00000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000007866
      5455725C46CD7A694CFF978966FF877557FF79634DFF755947B16959432E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000190613522B0B13FD2E11
      15FF2E0F13FF2D0F12FF2B0E11FF2B1012FF2B0F11FF2A1011FF2C0E12FF2C10
      12FF290E12FF2A0F13FF280F13FF281013FF281010FF281010FF2A0E12FF2B0F
      11FF291112FF291113FF281011FF271010FF280E10FF280F10FF2B1012FF2C11
      13FF2B1013FF2B1013FF2A1211FF2A1212FF290F11FF290F10FF290F12FF2A10
      11FF291012FF2A1112FF2A0F12FF2A1011FF280F11FF290F12FF2A1012FF2B10
      12FF2C1113FF2C1013FF2B0F12FF2C1013FF2D1113FF2D1114FF2C0E12FF2D0E
      12FF2B0F12FF2C0F13FF2B0F13FF2D1014FF280C1A8100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000044330F285447E924AE83FF10DC9AFF11D292FF12D1
      92FF13CF91FF13CF91FF11D092FF11D192FF13D093FF13D092FF13D092FF13D0
      92FF14CF92FF15CF92FF12D090FF12D191FF12D191FF14D291FF12DD9CFF2A95
      7EFF384B4EEA2D3C2D1100000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000070625539706545BA796A
      4BFF93845EFFB9AE7FFFC8C08EFF91855BFF897757FF866E52FF756247F76E5C
      459061583E1D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000015020E9046211FFF9767
      45FF8F6042FF8E6041FF8D5D42FF8D5F43FF8F6044FF8F6044FF8D5F43FF8D60
      42FF8D6044FF8D6045FF8D6044FF8D6144FF8E6045FF8D6045FF8D6145FF8D61
      45FF8D6145FF8F6146FF8D6044FF8D6145FF8E6145FF8E6145FF8E6145FF8F62
      46FF8F6245FF8F6246FF8E6145FF8F6145FF8D6145FF8E6144FF8E6144FF8E61
      44FF8E6145FF8E6145FF8E6043FF8E6043FF8D6044FF8E6044FF8D6043FF8D5F
      43FF8D5F43FF8E5F43FF8E5E42FF8E5E41FF8E5F43FF8E5F42FF8D5E40FF8E5E
      3FFF8C5D3EFF8B5C3EFF946442FF4D2722FF270712C400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001C472B12285440E820B485FF14DA95FF13C484FF13C5
      85FF13C585FF12C485FF13C585FF13C585FF13C585FF13C485FF14C485FF14C3
      85FF14C385FF14C385FF13C383FF13C384FF13C484FF14C384FF14DF9AFF2A9A
      7CFF324A50E62040401000000000000000000000000000000000000000000000
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
      00000000000000000000000000007A525C1977654898746246FE91815CFFB5AA
      7BFFC8BE8AFFC2B886FFBDB482FF948A5AFF918657FF938859FE8F7F57FF856F
      51FF745E47EF755C49855544440F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001800128B4C2821FFAC79
      4BFEA37047FEA57248FEA57349FFA57449FFA6734AFFA6744AFFA57449FFA574
      49FFA6754BFFA6754BFFA6754CFFA6754BFFA7764CFFA7764CFFA7764CFFA776
      4CFFA7764CFFA8764CFFA8764CFFA8764CFFA8774DFFA8774DFFA8774EFFA877
      4EFFA8764DFFA7764CFFA7764DFFA7764CFFA7764CFFA7754CFFA7754BFFA676
      4BFFA7754BFFA6744AFFA5744AFFA57449FFA5744AFFA5744AFFA6744AFFA674
      4AFFA5744AFFA57349FFA57247FFA47247FFA47248FFA47248FFA37247FFA372
      46FFA47145FFA26F44FFAD794AFF542E22FF250710C300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000F4B2D1128543FE922B485FF17D694FF15BC7EFF15BD
      7FFF15BE7FFF14BE80FF15BE80FF15BD7FFF14BD80FF14BD7FFF15BD80FF15BD
      80FF15BC7FFF15BC7FFF15BE7FFF15BD7FFF14BE7FFF14BD7FFF15DF9BFF2C99
      7EFF304B4FE61040301000000000000000000000000000000000000000000000
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
      000000000000000000007A664D64726246E7867551FFAA9B71FFC9BF8CFFC6BD
      8AFFBEB482FFC1B685FFBBB27FFF928958FF918755FF928856FF948B58FF9489
      59FF897754FF7F6A4DFF6D5F42DB705D475D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000B8649261EFFA774
      47FF956237FF7B491AFF7F4E1DFF7F4D1CFF7E4D1DFF7E4D1DFF7F4E1CFF7F4E
      1DFF804E1DFF804E1DFF7F4D1DFF7F4E1DFF7F4E1DFF7F4E1CFF804F1EFF804F
      1DFF7F4F1EFF804F1DFF804F1DFF7F4E1DFF804F1EFF814F1EFF814F1EFF814F
      1FFF804F1EFF7F4F1EFF814F1DFF804F1DFF7F4E1DFF7F4E1DFF7F4E1DFF7F4E
      1DFF7F4E1CFF7F4E1CFF7F4E1CFF7F4E1CFF804E1CFF7F4E1DFF7F4E1DFF7F4E
      1DFF7F4E1CFF7E4D1CFF7F4D1CFF7F4D1CFF7F4D1DFF7F4D1CFF7F4D1CFF7E4C
      1CFF784818FF936236FFA97648FF4D2B1EFF230710C400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001E4B3C11295344E724B586FF16D894FF14BE7EFF15BF
      80FF15C081FF15C080FF16C081FF16C182FF15C081FF15C081FF15C082FF16C0
      82FF16C081FF16BF82FF16C182FF16C181FF14C181FF15C080FF19E19CFF2A9D
      7EFF2D4B4BE61E3C2D1100000000000000000000000000000000000000000000
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
      00007C694F4478604AC4806C4DFF9D8F65FFC3B786FFCBC28EFEC1B684FFC0B5
      84FFC3B987FFB7AF7CFFAAA36DFF948C59FE928956FF938956FF928957FF9289
      57FF948B59FF918657FF897853FF7D664CFF725E44C46E604048000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000B8748261DFFA774
      47FF905E30FF6F3E0AFF75430DFF75430DFF74420DFF75430DFF75430DFF7443
      0DFF75440DFF75440DFF74430DFF75430EFF75440DFF75430DFF74430DFF7543
      0DFF75430DFF74430DFF75440DFF75430EFF74430EFF74430EFF75440EFF7544
      0DFF75440EFF75440EFF75440DFF75440DFF74440DFF74430DFF75430DFF7443
      0DFF75440DFF75440DFF75440DFF75440DFF75430EFF75430EFF75430DFF7443
      0CFF74430DFF74430DFF75430DFF75430DFF75430DFF74430DFF73420CFF7342
      0DFF6C3C07FF8E5D2FFFA97648FF4D2A1EFF210710C300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000205040102A5446E624B688FF17D895FF15BE7FFF16C0
      80FF16C082FF16C081FF16C182FF16C283FF16C182FF16C182FF16C283FF16C1
      82FF16C182FF17C082FF16C282FF16C182FF15C281FF16C181FF19E19DFF2A9E
      7FFF2D4B4AE62030201000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000785A62227464
      49A0776746FF93825FFFBBB07FFFCCC38EFFC5BB88FFC1B785FFC0B784FFC4BA
      88FFB5AD7AFFA5A06BFFACA56FFF958E59FF928A56FF938A56FE928957FE9288
      57FF928857FF928A57FF958D5AFF8E8257FF857252FF786449FF735E44A8714D
      4D2B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000017000F8849271CFFA975
      46FF956133FF75430DFF7B4710FF7B4710FF7A4610FF7A4711FF7B4710FF7A47
      10FF7B4810FF7B4811FF7B4810FF7B4811FF7C4810FF7C4810FF7B4811FF7C48
      11FF7B4811FF7B4811FF7B4810FF7B4810FF7B4811FF7B4812FF7C4811FF7B48
      11FF7B4811FF7B4811FF7B4910FF7A4811FF7B4810FF7A4811FF7A4810FF7B48
      10FF7B4810FF7B4810FF7B4810FF7B4811FF7A4810FF7B4810FF7A4811FF7B47
      10FF7B4711FF7B4711FF7A4710FF7A4711FF7A4710FF7A4711FF7A4710FF7A47
      10FF71400CFF905E30FFA97648FF4C2A1FFF230712C300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001C5555122A5246E827B688FF19D795FF16C080FF16C2
      82FF17C182FF17C282FF17C283FF16C283FF17C283FF17C283FF17C384FF17C2
      83FF17C283FF17C183FF17C282FF17C282FF16C282FF16C181FF19E19CFF2C9F
      80FF2E494BE71E2D1E1100000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000006D49490E78644A80745E46EF8E7B
      57FFB3A77AFFCBC38FFEC7BE8AFFC2B785FFC2B885FFC2B885FFC5BB88FFB5AD
      7AFFA7A16BFFABA56FFFAEA771FF958E59FF938B56FF938B58FF938A58FF938A
      57FF928957FF918857FF918856FF938B58FF938A58FF8B7E54FF826D4DFF755A
      45F6705E418D6851461600000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000016000F8949271CFFAA76
      47FF956132FF75430DFF7B4710FF7B4710FF7B4710FF7B4710FF7A4710FF7B47
      10FF7C4810FF7C4910FF7B4810FF7C4810FF7C4810FF7C4810FF7C4810FF7C49
      10FF7C4911FF7C4810FF7B4810FF7B4810FF7B4811FF7B4810FF7B4810FF7C49
      10FF7C4910FF7B4810FF7B4910FF7B4810FF7B4810FF7B4910FF7B4810FF7B48
      10FF7C4910FF7B4810FF7B4810FF7B4810FF7B4810FF7B4810FF7C4810FF7B48
      10FF7B4810FF7B4810FF7B4810FF7B4810FF7B4710FF7B4710FF7A4710FF7A47
      0FFF72410BFF905E30FFA97648FF4D2B1EFF210710C300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001C5547122A5344E928B689FF1AD997FF16C182FF17C3
      83FF18C384FF17C283FF17C383FF17C383FF18C484FF17C384FF18C485FF18C3
      84FF18C384FF18C383FF17C383FF17C282FF17C383FF17C281FF1BE29DFF2CA0
      80FF2D4B4BE62030201000000000000000000000000000000000000000000000
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
      000000000000000000000000000075724555736342DA877253FFA99C70FFCAC1
      8CFFCBC28EFFC3B987FFC2B887FFC3B986FFC2B986FFC6BB89FFB6AE7AFEA6A1
      6CFFABA56FFFABA56FFFAEA770FF968F59FF938C57FF948B58FF948B58FF938B
      57FF928957FF918856FF918855FF918856FF908755FF918956FF908656FF8576
      4EFF7C6749FF715B44E7706042708040BF040000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000017000F884A261DFFA975
      47FF966232FF77440DFF7C4710FF7C4810FF7C4810FF7C4910FF7C4910FF7C49
      10FF7C4910FF7D4910FF7C4910FF7C4810FF7C4910FF7D4910FF7C4910FF7C49
      10FF7C4910FF7C4910FF7C490FFF7C4910FF7C4910FF7C4910FF7C4910FF7C49
      10FF7C4A10FF7C4910FF7C4910FF7C4910FF7C4910FF7C4910FF7C490FFF7C49
      10FF7C4910FF7C4910FF7C4910FF7C4910FF7C4910FF7C4910FF7C4910FF7C49
      10FF7B4810FF7C4810FF7B4810FF7C4910FF7C4810FF7C480FFF7B4710FF7A47
      10FF73420BFF915F30FFA87548FF4E2B1EFF23070EC200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001B5136132A5244E82AB689FF1CDA99FF18C282FF18C3
      83FF19C484FF19C384FF19C485FF19C485FF19C485FF19C585FF18C485FF19C4
      85FF19C484FF18C484FF18C484FF18C484FF17C484FF18C282FF1EE49FFF2FA1
      82FF2F4B4DE60F2D1E1100000000000000000000000000000000000000000000
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
      00000000000076624E34716043B47C6B48FF9E8E65FFC5BA89FFCEC590FFC4BA
      89FFC3B987FFC3B987FFC2B986FFC2B987FFC6BC8AFFB8AF7CFFA8A26CFFACA5
      6FFFABA56EFFABA46EFFADA670FF97905BFF948D58FF958D59FF938C58FF938B
      58FF938A57FF928A57FF918956FF918856FF918756FF908755FF908656FF9289
      57FF8B8052FF83704EFF7C6647FF765A43CB7057424900000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000015000F8849261EFFA976
      48FF966232FF77440DFF7C4810FF7D480FFF7C4810FF7C4910FF7C4910FF7C49
      10FF7D4910FF7D4910FF7C4910FF7C4910FF7C4910FF7C4910FF7C4910FF7C49
      10FF7C490FFF7C4910FF7C490FFF7D490FFF7D4910FF7D4A10FF7C4910FF7D49
      10FF7D490FFF7D4A0FFF7C4910FF7D4A0FFF7C490FFF7C4910FF7C4910FF7C49
      10FF7C490FFF7C490FFF7D4910FF7C4910FF7C4910FF7C4910FF7C4910FF7C49
      10FF7C4910FF7C4910FF7C4810FF7C4810FF7C480FFF7B480FFF7B470FFF7B48
      10FF73420BFF916031FFA97547FF4D2B1EFF23090EC200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001C4739122B5244E92AB68AFF1DDB99FF18C283FF1AC3
      84FF1AC484FF1AC485FF1AC586FF1AC586FF1AC586FF1AC585FF1AC586FF1AC5
      85FF1AC585FF1AC585FF19C484FF19C585FF18C485FF19C383FF20E4A0FF2FA2
      82FF2E4C4BE52030201000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000007B5E
      4C1B73644492726140FA91825BFFBBB181FFD0C793FFC8BE8BFFC3BA88FFC4BA
      88FFC3BA87FFC3BA87FFC2B986FFC6BC8AFFB8B07DFFA7A26CFFABA56FFFABA5
      6FFFAAA46EFFAAA36DFFADA66FFF97915BFF958D58FF958E59FF948C58FF948B
      58FF938A58FF928A57FF918956FF918856FF908755FF8F8755FF8F8554FF8E85
      54FF8E8554FF8F8655FF887A52FF816D4BFF776244FF715C3FAB6B59472B0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000018000F8849261DFFAA77
      48FF986432FF78450DFF7D4A10FF7D4A10FF7D4A10FF7D4A10FF7D4A10FF7E49
      10FF7E4B0FFF7E4A10FF7D4A10FF7D4A10FF7D4A10FF7D4A0FFF7D4A0FFF7D4A
      10FF7D4A0FFF7D4910FF7D4A0FFF7D4A10FF7D4A0FFF7D4A10FF7E4A0FFF7E4A
      10FF7E4B10FF7E4B10FF7D4A0FFF7D4A0FFF7D4A0FFF7D4A10FF7C4B10FF7D4A
      10FF7D4A0FFF7D4A0FFF7D4910FF7D4A10FF7D4A10FF7D4A10FF7D4910FF7D49
      10FF7D4A0FFF7D490FFF7D4910FF7C4910FF7D4910FF7C4910FF7C4910FF7B49
      10FF73430AFF926131FFA97747FF4E2B1DFF210710C400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000284343132C5047E92CB58BFF1DDC9AFF19C382FF1AC5
      84FF1AC685FF1BC586FF1BC686FF1BC686FF1BC686FF1BC687FF1BC586FF1BC6
      86FF1BC586FF1BC585FF1AC585FF1BC585FF19C585FF1AC383FF1FE5A0FF2FA4
      84FF2F4F4BE61E3C1E1100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000313149154D436A35394F48474D54636449575D8146595486425A5488425E
      5387485D5D86485B5F834E5266733C4555513B3B514546396C2827004E0D0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006A55400C74644280745F
      40EC8C7C56FFB2A779FFCDC591FFCCC38FFFC4BB88FFC5BB89FFC4BB88FFC4BA
      88FFC3B987FFC3BA87FFC6BD89FFB9B27EFFA8A36DFFACA66FFFABA56FFFABA5
      6EFFA9A36CFFA9A36CFFADA66EFF97925CFF96905AFF968F5AFF958D59FF948C
      58FF938B57FF928A57FF928A57FF918956FF908855FF908755FF8F8654FF8E85
      54FF8D8353FF8C8353FF8D8353FF8C8153FF85764EFF806B4AFF745E43F7745A
      44885E4336130000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000017000F884A271DFFAA79
      48FF986432FF78450DFF7D4A10FF7E4A10FF7D4A0FFF7E4A0FFF7D4A0FFF7E4A
      0FFF7E4A0FFF7E4B10FF7D4A10FF7D4B10FF7D4A0FFF7D4B0FFF7D4B0FFF7D4B
      0FFF7D4A0FFF7D4B0FFF7D4B0FFF7D4B0FFF7D4A0FFF7D4B0FFF7E4B0FFF7D4B
      10FF7E4B10FF7E4B10FF7D4A0FFF7D4B0FFF7D4B0FFF7D4B0FFF7C4A0FFF7D4B
      10FF7D4A0FFF7D4B0FFF7D4A0FFF7D4B0FFF7E4A10FF7E4B10FF7D4A0FFF7D4A
      0FFF7D4A0FFF7D4A0FFF7C490FFF7D4A10FF7D4910FF7D4910FF7C490FFF7C49
      10FF73420AFF936131FFAA7848FF4D2B1DFF1F070EC300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001E4B4B112B5247E92DB68CFF1FDD9CFF1AC483FF1BC5
      86FF1CC686FF1BC686FF1DC687FF1CC787FF1CC788FF1CC788FF1CC787FF1CC7
      87FF1BC687FF1CC686FF1BC686FF1CC687FF1AC787FF1BC584FF20E4A1FF2FA5
      85FF2E524AE41133220F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000660524245023324A52605263649B6173
      72C76D7B7BEC7F8A8EFF939DA0FFA0A9ADFFADB5B8FFB3BCBEFFB6BEC0FFB5BE
      BFFFB1BCBFFFB2BBBFFFA9B3B7FF9EAAAFFF949DA3FF828B90F86B787CE25A68
      6DBC435859862C3A474B230C5116000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000796454526F6441D783724DFFA99B
      73FFCCC491FFCFC792FFC6BD8AFFC5BD8AFFC5BC89FFC5BC89FFC4BB88FFC3BB
      87FFC3BA87FFC6BD8AFFBAB27EFEA8A36EFFABA670FFABA66FFFABA56EFFAAA4
      6DFFA9A36CFFA8A36BFFABA56EFF97925DFF96905AFF968F5AFF958D59FF948C
      58FF928B57FF928A57FF928A56FF918A56FF908854FF908755FF8F8654FF8E85
      54FF8D8452FF8C8453FF8B8152FF8A8052FF8C8352FF8A7E51FF85734EFF816A
      4BFF755B41DF7558426000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000017000D874B281DFFAD7B
      48FF986633FF78460CFF7E4A10FF7E4A10FF7E4B0FFF7F4B0FFF7E4B0FFF7F4B
      0FFF7F4A10FF7F4B0FFF7F4B0FFF7E4B0FFF7E4B0FFF7E4B0FFF7E4B0FFF7E4B
      0FFF7E4B0FFF7E4B0FFF7D4B0FFF7D4B0FFF7E4C10FF7E4C10FF7E4C0FFF7E4C
      0FFF7E4B0FFF7E4C10FF7E4C0FFF7E4C10FF7E4C0FFF7E4B10FF7E4B0FFF7E4B
      0FFF7D4A0FFF7D4A0FFF7D4A0FFF7E4B0FFF7E4B0FFF7E4B10FF7E4B0FFF7E4B
      10FF7D4A0FFF7E4A0FFF7D4A0FFF7E4A10FF7D4A10FF7E4A10FF7D490FFF7C49
      10FF74430BFF936131FFAC7A49FF4D2C1EFF1F0710C300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001B434313285343E92FB88DFF20DE9DFF1BC585FF1DC6
      87FF1DC788FF1DC787FF1DC788FF1DC787FF1DC788FF1DC888FF1DC888FF1DC7
      88FF1DC888FF1DC687FF1CC687FF1CC787FF1BC788FF1CC585FF20E5A1FF2DA5
      83FF2E534CE42244220F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002400490739475548535D66996E767DD9899197F7A8B3B5FFC6CED1FFD7DC
      E0FFDDDFE4FFE3E5E9FFE7E9F1FFECF1FBFFEDF1FEFEEBEEFAFEEDEEFBFFEDEE
      FAFFECEEF9FFEFF2FEFFEFF2FEFFECEDF5FFE7E8EDFFE8EAEEFFDCE0E4FFD1D7
      DAFFBCC4C9FF97A0A7FF747C85EB58666DA83E465A5B432C6F17000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007A6657327C6248B77E6A4CFF9E9166FFC5BC8BFFD2CA
      96FFC8C08CFFC7BE8BFFC6BE8BFFC5BD8AFFC6BD89FFC5BC89FFC4BC88FFC4BB
      87FFC7BE8AFFB9B27EFFAAA46FFFACA670FFABA66FFFABA56EFFAAA46EFFAAA4
      6DFFAAA56DFFB5AF74FFB9B375FEA09B63FF97915BFF97905BFF958E59FF948D
      58FF938C58FF938B57FF928A56FF918956FF908855FF8F8755FF8F8754FF8E86
      53FF8D8553FF8D8453FF8C8251FF8B8151FF8A7F50FF8A7F50FF8B7F50FF887B
      4FFF85714DFF80664AFF765C46C16E5041330000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000015000D874A281DFFAE7B
      4AFF996734FF78460DFF7E4A10FF7E4B10FF7F4B0FFF7F4B0FFF7F4B0FFF7F4B
      0FFF7F4B0FFF7F4C0FFF7E4C0FFF7E4C0FFF7F4C0FFF7E4B0FFF7E4C0FFF7E4B
      0FFF7E4B0EFF7E4B0FFF7E4A0FFF7E4B0FFF7F4C0FFF7E4C0FFF7E4C0FFF7E4C
      0FFF7E4C0FFF7E4C0FFF7E4C0FFF7E4C0FFF7E4C0FFF7E4B0FFF7E4B0FFF7E4B
      0FFF7E4B0FFF7D4A0FFF7E4B0FFF7E4B0FFF7E4C0FFF7E4B0FFF7E4B0FFF7E4B
      0FFF7E4A0FFF7E4B0FFF7D4A0FFF7E4A0FFF7E4A0FFF7E4A10FF7D4A10FF7C4A
      10FF74430AFF946231FFAC7A49FF4E2D1EFF1F0710C300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001C473912285444E92FB98FFF22DF9EFF1CC586FF1EC7
      88FF1FC889FF1EC889FF1EC889FF1EC888FF1EC989FF1EC989FF1EC989FF1EC8
      89FF1EC888FF1EC888FF1DC788FF1EC888FF1DC889FF1DC686FF21E5A1FF2EA4
      82FF2E544AE42244220F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000022225E1E4359
      6581697878D897A3A6FFC8CED3FFDEE3E7FFE8EAEFFFE9E9EFFFE3E3EAFFDFDF
      E5FFE0E3ECFFE4EAF7FFDDDBE0FECCBCACFFBDA379FFB39156FFAE8742FEAF88
      41FFB28D4DFEBD9F74FFCABAA7FEDCD8DBFEE6EAF7FEE1E5EEFFDDDEE3FFE1E2
      E7FFE7E7EDFFEAEAF1FFE4E7ECFFD1D6DBFFA2ABB3FF727E88EA475E619B3034
      453B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000074694B44786847F796835FFFBFB384FFD4CB95FECBC38FFEC7BE
      8BFFC8BF8CFFC8BF8CFFC6BE8BFFC6BD8AFFC5BD8AFFC5BD89FFC4BB88FFC8BF
      8BFFBAB27EFFA9A46EFFACA770FFACA670FFABA56FFFAAA56EFFAAA46DFFA9A3
      6CFFB6AF74FF7A764FFF494831FF928E5BFFA6A064FF96905AFF958E59FF948E
      59FF948C58FF938C57FF918A57FF918956FF908856FF908855FF8E8754FF8E86
      54FF8D8553FF8D8452FF8B8252FF8B8151FF8A8050FF897E4FFF887D4EFF887D
      4FFF897D4FFF84754DFF856D4FFF7D6349F7745D4C4D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000015000D874A291EFFAF7D
      4BFE9B6835FF79470DFF804D0FFF804D0FFF804C0FFF804C0FFF804D0FFF7F4C
      0EFF7F4C0FFF804C0FFF7F4C0FFF7F4C0FFF7F4C0FFF804D0FFF7F4C0FFF7F4C
      0FFF7E4C0EFF7E4C0FFF7F4D0EFF814E0EFF804E0FFF814E0FFF804E0EFF804E
      0FFF804E0EFF804E0EFF804E0EFF804E0EFF804D0EFF804D0EFF804E0EFF804D
      0FFF7F4C0EFF7F4C0EFF7E4B0FFF7E4C0FFF7F4D0FFF7F4C10FF7E4C0FFF7E4C
      0FFF7E4B0FFF7F4B10FF7E4B0FFF7E4C0FFF7E4B0FFF7E4B0FFF7E4B0FFF7E4A
      0FFF75450AFF936230FFAD7A49FF4E2D1FFF250712C300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000285E51132D5449E831B790FF25E1A2FF1DC787FF1FC9
      8AFF20CA8AFF20C98AFF20C98AFF20C98AFF1FC98BFF20C98AFF1FC98AFF1FC9
      8AFF20C98AFF1FC889FF1FC889FF1FC888FF1EC888FF1DC686FF24E6A4FF31A4
      83FF2E524DE41144220F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000039345831535D6D9A7C8691EEB5BF
      C4FFE0E4E9FFEBECF2FFE6E6EDFFE0E1E7FFDFDFE4FEDFE0E4FFDFE1E4FFE7ED
      F7FEDDD6D1FFBE9D70FFA8791EFFA16C00FFA57200FFAC7900FFAE7B00FFAD7C
      00FFAB7800FFA67100FF9F6B00FEA47416FFB89460FFD7CDC6FFE6EBF7FFDFE0
      E5FEDDDEE2FFDDDEE3FFDDDEE4FFE2E3E9FFE9EAF0FFE3E5EBFFC5CDD1FF8791
      96FF53646DBB2739474800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808000026D6440CB9F9267FFD5CC9AFFD0C793FFC8BF8CFFC8BF8CFFC7BF
      8CFFC8BF8CFFC7BF8BFFC6BE8AFFC6BE8AFFC5BD89FFC5BD88FFC8C08CFFBBB5
      7FFFA9A56EFFABA770FEACA770FFABA66FFFAAA56EFEA9A46DFFAAA46CFFAAA4
      6CFFAEA96FFF2C2D23FF1D1D1BFF292920FF7B774CFFA8A165FF979059FF938D
      57FF948D58FF938C57FF928B57FF918A56FF918955FF908855FF8F8754FF8E86
      54FF8D8552FF8C8452FF8C8252FF8B8151FF8A8050FF8A7F50FF897E4EFF887C
      4EFF877B4EFF877B4EFF86794EFF8B7451FF796148CD80008002000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000B8749291EFFB17E
      4DFE9C6935FF7A470DFF804D10FF804D10FF804C0FFF804D0FFF804D0EFF804D
      0EFF7F4D0FFF804C0FFF7F4C0FFF7F4C0FFF804D0FFF804D0EFF7F4C0EFF7F4C
      0FFF7E4C0FFF7E4B0FFF7A4910FF6A3904FF663603FF663603FF643604FF6436
      04FF653704FF663604FF653505FF643505FF643604FF653604FF653605FF6536
      05FF673704FF75440DFF7E4C10FF7E4C10FF7F4D0FFF7F4C0FFF7F4C0FFF7F4C
      0FFF7F4C0FFF7F4C0FFF7F4C0FFF7F4C0FFF7E4C0FFF7E4C0FFF7E4B0FFF7E4B
      0FFF76440AFF956331FFAD7B4AFF4F2D1FFF230910C300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001B5151132B5347EA32B690FF27E0A3FF1FC889FF20CA
      8BFF21CA8CFF22CA8BFF22CA8BFF21CA8BFF21CA8BFF21CA8BFF21CA8CFF21CA
      8BFF21C98BFF21CA8AFF20C98AFF20C98AFF1FC989FF1FC786FF26E7A5FF32A5
      84FF2E534CE42244330F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000202646284860639F7E8D92FBC9CFD6FFEAECF1FFECEB
      F2FFE2E3E9FFE0E1E7FFE0E1E7FFE1E1E6FFE1E1E6FFE3E5EBFFE9ECF7FFC3AB
      8BFEA4710FFFA26E00FFB18100FFBC8B0BFFC29117FFC5931CFFC5931EFFC593
      1EFFC4921CFFC39017FFBD8C0DFFB28200FFA27000FEA06C05FFBD9F76FEE5E5
      EBFEE2E5ECFFDFDEE3FFDFDFE4FFDEDFE5FEDFDFE5FFDFDFE6FFE8E7EEFFEDED
      F3FFD5DADFFF929FA3FF53656CB5242843390000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007A665219726B42F2C4BB8BFFD2C995FFCAC08DFFC9C08DFFC8C08CFFC8C0
      8CFFC8BF8CFFC7BF8CFFC6BE8AFFC6BE8AFFC5BD89FFC9C08DFFBCB681FFA7A5
      6DFFABA770FFABA770FFABA66FFFABA66FFFA9A46EFFA9A46DFFA9A46BFFAAA4
      6CFFAAA56DFF303127FF2B2B24FF262520FF21211DFF5A5639FF9D975DFF9A94
      5BFF928C57FF938C57FF928B57FF928A56FF918956FF908955FF8F8754FF8E87
      53FF8D8553FF8C8352FF8C8252FF8B8251FF8A8050FF8A8050FF897E4FFF877C
      4EFF867B4DFF867A4CFF867A4DFF88774FFF796445E5623B270D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000F000B8749281EFFB480
      4FFF9D6B36FF7A490DFF804D10FF814E10FF804E0FFF804E0FFF804D0FFF814D
      0FFF814D0FFF814D0FFF804D0FFF814E0EFF814E0FFF814E0FFF804D0FFF804D
      0FFF7F4C0EFF7F4B0EFF683D13FF806A60FE88776DFF86756AFF87786DFF8676
      6CFF86756CFE86766DFE85746BFF84746CFF88776DFF87766DFF89776DFF8B7A
      70FF88746AFE613D25FF77450DFF804E0FFF804E0FFF804D0FFF804C0FFF804D
      0FFF804D0FFF804C0FFF7F4C0FFF7F4C0FFF7F4C0FFF7F4C0FFF7E4C0FFF7F4C
      0FFF75450AFF976533FFAF7D4CFF502E1FFF220711C100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000334D4D142D5649E932B68FFF27E1A2FF20C889FF21CA
      8BFF22CB8CFF22CB8CFF22CB8CFF22CA8CFF22CC8DFF21CB8DFF22CA8CFF22CB
      8CFF23CA8BFF22CA8BFF21CB8CFF22CA8CFF21CA8BFF20C98AFF24E8A5FF32A4
      83FF2E534DE42040401000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001A004D0A4749608579858CF4C9D1D6FFEBECF2FFE9E9EFFFE1E2E9FFE2E3
      E9FFE4E4E9FFE4E4E9FFE4E4E8FFE5E5E8FFE7E8EDFFE9E9F0FFBB965DFFA26B
      00FFB38200FFC08F12FFC89720FFCB9A25FFC89826FFC89725FFC79625FFC796
      24FFC69623FFC69623FFC79622FFC89620FFC19014FFB48400FF9F6A00FFAE82
      3DFFE4E0E2FFE5E8F0FFE0E0E4FFE1E0E5FEE1E1E7FFE1E1E6FFDFE0E5FFDEDF
      E5FFE5E6ECFFEEEEF4FFDADEE3FF868F97FF454D649B43215917000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000886D6D2F776D47FBC4BA87FFCFC593FFCAC08EFFC9C08DFFC9C08DFFC9C0
      8CFFC8BF8CFFC7BF8BFFC6BE8AFFC6BE8AFFCAC28EFFBDB781FFAAA66EFFADA8
      71FFACA770FFABA76FFFABA66FFFABA66EFFAAA46DFFAAA56DFFA9A46BFFABA5
      6CFFABA56CFF313226FF2C2B23FF454331FE23231EFF1F201DFF3D3D2BFF908B
      56FFA0985EFF918B56FF938C57FF928B56FF928A56FF918955FF8F8854FF8F87
      53FF8E8553FF8D8452FF8D8252FF8B8251FF8A8050FF8A7F50FF887E4FFF887D
      4EFF877B4DFF867A4DFF867A4CFF88784FFF786343E66644330F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000F000A8549281DFFB581
      50FF9F6B38FF7A490DFF814D10FF814E0FFF804E0FFF814E0FFF814E0FFF814E
      0EFF814D0FFF814E0FFF814E0FFF814E0FFF814E0FFF814E0FFF804E0EFF804D
      0EFF7F4D0EFF7D4809FF613E1CFFEDEFF3FEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF9F8F8AFF5F2E00FF824F0EFF804D0FFF814D0FFF814D0FFF804D
      0FFF804D0FFF804D0FFF804D0FFF804D0FFF804D0FFF7F4C0FFF7F4C0FFF7F4C
      0FFF76450AFF976633FFB07E4CFF502E20FF220911C100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003B4E620D2B5649E931B78EFF28E1A3FF22C98AFF23CB
      8CFF23CB8DFF23CB8DFF24CB8EFF24CB8DFF23CC8DFF23CB8DFF23CC8DFF23CB
      8DFF24CA8CFF24CB8CFF23CB8CFF23CB8CFF22CB8CFF21C98AFF26E9A5FF32A5
      83FF2F554DE21C1C390900000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003041
      4E3B5E6C75D2B4BAC1FFEBEDF2FFEBEAF0FFE2E2E8FFE3E3E9FFE4E5EAFFE5E6
      EBFFE6E6EAFFE6E6EBFFE7E6EAFFE8E9EDFEEEEEF6FEB79252FFA67100FFBB8B
      04FFC7951DFFCB9928FFC99826FFC89825FFC89826FFC89826FFC79826FFC798
      25FFC69725FFC69725FFC59523FFC59422FFC79522FFC7941CFFBD8C0AFFA570
      00FFAC7E34FFE6E5E9FEE5E7EDFFE2E2E6FFE2E3E7FFE2E3E8FFE1E1E7FFE1E1
      E7FFE0E1E7FFDFE0E7FFE5E5EBFFEFF0F5FFBDC5CCFF5F6A7AE22F4255510000
      0000000000000000000000000000000000000000000000000000000000000000
      0000876D6831776D45FDC3BA87FFCFC693FFCAC18EFFC9C18DFFC9C08DFFC9C0
      8DFFC8C08CFFC8BF8BFFC6BE8BFFCAC28EFFBEB781FFABA770FFADA971FFADA8
      71FFACA76FFFABA66FFFABA66EFFABA56DFFAAA46DFEA9A46CFFA9A46CFFAAA4
      6CFFAAA56DFF303227FF24241EFFA29D68FF79754DFF272720FF1F221DFF2D2D
      23FF79744AFFA29B5FFF948D57FF928C56FF928A56FF918955FF908854FF8F87
      54FF8E8553FF8D8453FF8C8352FF8C8251FF8A8050FF897F4FFF887F4FFF887D
      4FFF877B4DFF867A4DFF867A4CFF87784EFF786343E56644330F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000130008844C2A1EFFB784
      52FFA06C39FF7B490DFF824E10FF824F10FF824E0FFF834E0FFF824E0FFF814F
      0FFF824F0FFF824F0FFF824F0FFF824F0FFF824E0EFF824E0EFF814E0FFF814E
      0FFF814D0EFF7B4908FF5B3B1AFFE5E3E7FFFEFEFEFEFBF9FBFEFAF8FAFFFBF8
      FAFFF9F7F9FFF9F7F9FFF9F7F9FFF9F7F9FFF7F6F8FFF8F6F8FEF8F7F8FFF9F7
      FAFFFFFFFFFFA79891FF5E2E00FF824F0FFF814E0FFF814E0FFF814E0FFF814E
      0FFF814E0FFF814D0FFF804D0EFF804D0FFF814D0FFF804D0FFF7F4D0FFF7F4D
      0FFF77460BFF976633FFB27F4EFF4F2F21FF250A12C300000000000000000000
      0000000000000F3C1E111A401A1400360D131A4D261400401A140D4026140D40
      2614244931150D431B131A4D26141A4026140D431B1300430D130D4026140D43
      1B1318553115004700122F53472B325751EF2FB68EFF24E1A1FF21CA8BFF23CB
      8DFF24CB8DFF24CB8EFF24CC8EFF25CC8EFF25CC8DFF24CC8DFF24CC8DFF24CB
      8DFF24CB8DFF24CA8CFF23CB8CFF23CB8CFF22CA8CFF21C98AFF28E8A4FF32A5
      83FF355654E61E4B352200470E120C3D31151A4026141A402614244931150D40
      26140D4D33140D4033140D4026140D431B131A4033141A402614184931150D40
      2614184931151849241520202008000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004B4D6470828A
      93FCDBE1E5FFEDEFF3FFE2E3E9FFE4E4EAFFE5E5EBFFE6E7EBFFE7E8ECFFE8E8
      ECFFE9E9EDFFEAE9EDFFE8E8EBFEF1F4FFFFC6A66EFFA87200FFBB8A04FFCC99
      20FFCC9B27FFCA9A27FFC99927FFC99927FFCA9827FFCD9B27FFD09D26FFCF9C
      26FFCA9827FFC79726FFC59625FFC59624FFC59422FFC69422FFC99620FFC291
      11FFA57200FFB79254FFEDF0FBFEE4E5E9FFE4E4E9FFE4E4E9FFE3E3E9FFE3E3
      E8FFE3E3E9FFE2E3E9FFE1E1E8FFE0E1E7FFEDEDF3FFDADFE4FF7C8B92FF444E
      5B8A000080020000000000000000000000000000000000000000000000000000
      00008C735F33796B44FEC4BB89FFD0C794FFCBC28FFFCBC18FFFCAC18FFFCAC1
      8EFFC9C08DFFC8C08DFFCBC38FFFBDB681FFACA76FFFAEA971FFAEA870FFADA8
      6FFFACA66FFEACA66FFFABA56DFFABA56DFFAAA46DFFA9A46CFEA9A46BFFAAA5
      6CFFAAA56DFF313327FF252520FF979361FFB3AD6EFE8E8958FF333327FF1F20
      1DFF23241FFF5D593BFF9D975CFF979159FF908955FF918A55FF908854FF8F87
      54FF8E8553FF8D8452FF8C8352FF8C8352FF8A8050FF8A7F4FFF897F4FFF887E
      4FFF867C4DFF857A4DFF857A4DFF87764FFF75613EE760501010000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000A854D2A1FFFB986
      54FFA06E3AFF7B4A0DFF834F10FF834F0FFF824F0FFF834E0FFF824F0FFF824F
      0FFF824F0FFF824F0FFF824F0EFF824F0FFF824F0EFF824F0EFF814E0FFF814F
      0FFF814E0EFF7B4908FF5A3A1AFFE6E4E6FEFEFEFEFEFAF8FAFFFAF8FAFFFBFA
      FCFFFEFCFFFFFDFCFFFFFEFDFFFFFEFDFFFFFDFCFFFFFDFBFFFFFDFCFFFFFEFD
      FFFFFFFFFFFFA89892FE5E2D00FF83510FFF814F0FFF814F0FFF814F0FFF824F
      0FFF814E0EFF814E0FFF814E0FFF804D0FFF804D0FFF804D0FFF804D0FFF804E
      0FFF78470BFF986734FFB2814FFF4F3021FF230D12C400000000000000005539
      710932615198315744EB355043EB355344E9335344EA325644EA335044E93351
      44EA335146EA335345EA325247EA325449EA33534AEA325447EA315349E93054
      47E9335749EA315845EA36564CED39524FFE2CB78AFF24E09FFF23CB8DFF24CC
      8EFF25CC8EFF25CC8EFF26CD8FFF25CC8EFF25CC8EFF25CC8EFF25CD8EFF25CC
      8EFF25CC8EFF25CC8DFF24CC8DFF24CC8DFF23CB8DFF22CA8BFF27E7A3FF30A1
      7FFF365857FD365752EA32564CE932574DEB35564EE934584EEA35594DEA3558
      4CE935564FE935564EE934584EEA35594DEA36594FE936594EE934584EEA3456
      4BEB36544CEA38524BEB396060DE35605D520000000000000000000000000000
      00000000000000000000000000000000000000005503465E6B96A5B0B7FFEAEC
      F3FFE7E7EEFFE1E2E9FFE4E5EBFFE6E6ECFFE8E8EDFFE8E9EDFFE9EAEDFFEAEB
      EEFFEBEBEFFFECEBEEFFF0F3FBFEDBCBBAFFAA7300FFBD8C03FFCB981DFFCE9C
      28FFCC9C28FFCC9C28FFC99A28FFD7A42AFFD8AA2DFFC09A2CFFB18E27FFB892
      27FFCA9E2AFFDAA829FFCE9C28FFC69626FFC69625FFC69623FFC79622FFCA97
      20FFC08F09FFA16900FFCBB49BFEEEF3FEFEE6E6EAFFE6E7EBFFE5E6EBFFE5E5
      EAFEE5E5EBFFE5E5EAFFE4E4EAFFE3E3E9FFDFE0E7FFE5E5EDFEEBEDF4FFA8B3
      B6FF54616ABA1B0D431300000000000000000000000000000000000000000000
      000087736433796C44FEC4BB89FFD0C795FFCCC290FFCBC28FFFCAC28FFFCAC2
      8EFFC9C18EFFD0C793FFC3BC85FFB1AC72FFB2AE74FFB2AD73FFB1AC72FFB0AC
      71FFB0AB71FFB0AA71FFAFAA70FFAFAA6FFFAFA970FFAFA96EFFADA86DFFAEA9
      6EFFAFAA70FF323428FF262720FF999462FFA29D64FFA8A267FFA29D65FF4D4B
      34FF1E201DFF20211EFF403F2CFF8F8A55FF9D965DFF908955FF908955FF9087
      54FF8E8654FF8D8553FF8D8452FF8C8351FF8A8150FF898050FF897F4FFF887E
      4EFF867C4DFF857B4DFF867A4DFF86764FFF75603CE860501010000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000C854E2B21FFB986
      54FFA16D39FF7C4B0CFF835010FF84500FFF83500EFF83500FFF82500FFF8350
      0FFF83500FFF84500EFF83500EFF83500EFF83500EFF83500FFF824F0EFF8250
      0EFF814F0EFF7D4A08FF5B3D19FFE5E4E7FFFEFDFEFEF8F7F9FFF9F8F9FFF3F1
      F2FEE2E1E2FFE3E1E3FFE2DFE0FFE1DFDFFFE2DFE0FEE2DEDFFFE3E0E1FFE3E1
      E2FFE4E4E4FF896E62FF6D3903FF82500FFF82500FFF824F0FFF824F0FFF824F
      0FFF824E0EFF824F0EFF824E0EFF814E0FFF814E0FFF814E0FFF804D0EFF804E
      0FFF78480AFF9B6A35FFB4834FFF4F3020FF240A13C500000000000000002C46
      423A365E50FF329A7AFF2AB187FF2BAB82FF2CAA82FF2BAB82FF2AAA81FF2BA9
      82FF29AB83FF29AC83FF29AB81FF29AB82FF29AB84FF29AC84FF29AD84FF29AE
      83FF28AF82FF29AF83FF29AE83FF27AB7FFF24CB8EFF25D093FF24CC8FFF25CC
      8EFF25CC8EFF25CD8EFF26CD8FFF26CD8FFF26CD8FFF26CD8FFF26CD8FFF26CD
      8FFF26CC8FFF26CC8EFF25CC8DFF25CC8EFF24CB8DFF24CB8DFF25D999FF25C4
      8EFF29AB80FF2BAE85FF2AAD85FF2BAD85FF2AAF85FF29AF85FF2AAE85FF2BAD
      85FF2BAE85FF2AAF85FF29AF85FF29AF85FF2AAE85FF2BAD84FF2BAD84FF2BAD
      85FF2BAB86FF2EAD8CFF3E7F73FF43595FBE0000000000000000000000000000
      000000000000000000000000000024125B0E555E6CB5BAC2C9FFF0F0F6FFE1E2
      E9FFE3E4E9FFE4E6EBFFE7E8ECFFE9E9EDFFEAEAEEFFEBEBEFFFEBECEFFFECEE
      F0FFEEEDEFFFEFEEF2FFF2F2FAFFB88C39FEB78200FFCD9A1CFFD09E28FFD09E
      29FFD09F2AFFCE9E2AFFE1AD2DFFA88828FF484121FF25251CFF1E1E1BFF2221
      1AFF302D1DFF645321FFC49B29FFDCA72AFFC89825FFC99924FFC89822FFC998
      22FFCB971DFFB68300FFA67518FFEAE6EAFFEBEDF3FFE9E9ECFFE9E9EDFFE8E9
      EDFFE8E8EDFFE7E7ECFFE6E6EBFFE5E5EAFFE3E3E9FFE2E2E8FFE2E2E9FFF0F0
      F6FFC4CDD3FF5D667AD1483B6927000000000000000000000000000000000000
      00008E6C6234786C45FEC3BB89FFD2C996FFCDC491FFCDC491FFCBC390FFCAC2
      8FFFD0C994FFBBB583FFA39E6BFFA6A26EFFA6A16CFFA5A16BFFA6A16CFFA6A1
      6CFFA49F6AFFA39E69FFA19C67FFA19C67FFA29D68FFA29D67FFA29E67FFA49E
      67FF9F9C67FF313328FF2A2922FF9C9664FFA7A168FF9E9862FFA39D64FFAEA8
      6AFF6B6845FF242520FF1E201FFF2C2D24FF787449FFA0985EFF928A56FF9188
      54FF908854FF8F8753FF8E8553FF8D8452FF8C8251FF8A814FFF887F4FFF887E
      4EFF877D4DFF867B4DFF867B4CFF86784EFF72603EEA55471C12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000C854D2B21FFBA87
      55FFA16F3AFF7C4C0CFF845010FF84500FFF84500EFF83500FFF83500FFF8350
      0EFF83510FFF84500FFF83500EFF83500EFF83500EFF83500EFF82500EFF8250
      0EFF824F0EFF7D4A08FF593C19FFE5E4E7FEFEFCFFFFF7F7F9FFFEFEFEFFB0A6
      9FFF482C0EFE60411DFF64431BFF65431AFF65421BFE65431AFF65431CFF6544
      1DFF63401AFF6A3D0CFF81500FFF814F0EFF82500FFF82500FFF824F0FFF824F
      0FFF814F0EFF824F0EFF814F0FFF824E0FFF814E0FFF814E0FFF804E0EFF804E
      0FFF78480AFF9B6B36FFB58450FF503021FF220A13C500000000000000002044
      3C4033574AFF2BC790FF1FEAA1FF1AD993FF1AD993FF1AD993FF1AD993FF19DA
      93FF19D893FF19D993FF1BD893FF1AD993FF19D992FF1AD992FF1BD893FF1BD8
      92FF1AD893FF1BD894FF1CD893FF1DD893FF22CF90FF25CB8FFF26CD8FFF26CD
      8FFF27CD8FFF27CD90FF27CE90FF28CE90FF28CE90FF28CE90FF28CE90FF28CE
      8FFF28CE90FF28CD90FF26CD8FFF26CD8FFF25CD8FFF25CD8EFF25CF93FF22D4
      94FF1DD994FF1CDA94FF1BD994FF1BD994FF1CD995FF1BD994FF1AD893FF1AD8
      94FF1BD894FF1BD894FF1AD893FF1AD993FF1AD993FF1ADA94FF1AD994FF1AD9
      95FF1BD995FF20EAA2FF339070FF3F5659BD0000000000000000000000000000
      000000000000000000004D1A990A596576C2C2CBCEFFF1F1F7FFE0E1E7FFE2E4
      E9FFE5E6EBFFE7E8ECFFE8EAEDFFEAEBEEFFECECF0FFEDEDF1FEEEEEF1FFEFEF
      F2FFF0F0F2FFF6F9FDFFE1CEBBFFA97500FFC7950DFFD4A12AFFD2A029FFD2A3
      2DFFD2A12DFFE4B22FFF8C7426FF11151AFF14171AFF20201CFF20211EFF2120
      1DFF1D1E1BFF0F131AFF22221AFFB28E28FFDCA829FFCA9925FFCA9924FFC999
      23FFCD9A23FFC3920FFFA16C00FFCDB493FFF4F8FFFFECEBEEFFECECF0FFEBEB
      EFFFEBEBEFFFEAEAEEFFE8E8EDFFE7E7ECFFE5E6EBFFE5E5EAFFE3E3E9FFE1E1
      E8FFEDECF5FECED5DAFF5E6D7AE53E3264290000000000000000000000000000
      00008E716734786E45FEC3BC8AFFD2CA96FFCDC492FFCDC491FFCCC491FFD4CC
      96FFAFAB7FFF2B2D22FF2F3026FF2F2E26FF2F2F26FF2F3026FF2F2F26FF2F2F
      26FF2E2E26FF2E2E26FF2F2E26FF2E2E25FF2E2E25FF2E2E25FF2F2F26FF2F30
      25FF2E2D23FF2D2E25FF282821FFA29D68FFA7A168FFA09A63FF9F9962FF9F9A
      62FFB0A96BFF888354FF303026FF1E211FFF22241FFF5C593AFF9C955BFF968E
      57FF908753FF8F8753FF8E8552FF8D8452FF8C8251FF8A814FFF887F4FFF887E
      4EFF877C4DFF857C4DFF857A4CFF83744BFF745F3DEA55470E12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000F000B874E2C21FFBC8A
      57FFA4723CFF7F4D0DFF85520FFF85520FFF84510FFF84510FFF85510EFF8451
      0EFF84510FFF85520FFF84510FFF84510FFF84510EFF84510FFF83500EFF8351
      0EFF82500EFF7D4B08FF5C3C1AFFE4E4E7FFFEFDFFFFF8F6F9FFFFFFFFFFA89E
      96FF562900FF824F0AFF804E0BFF814F0BFF804E0BFF7F4E0BFF7F4D0AFF804D
      0AFF7F4D0AFF82510EFF83510FFF83510EFF83510EFF83500FFF84510EFF8250
      0EFF83500EFF83500EFF834F0EFF824F0EFF824F0EFF82500FFF82500FFF824F
      0FFF7A490AFF9C6B35FFB7854FFF503221FF230914C400000000000000002840
      3840365149FF34C495FF2CE2A1FF1FC788FF21C98AFF21C98BFF21C88AFF21C9
      8AFF20C88AFF20C88AFF20C98BFF20C98BFF21C98BFF21CA8BFF21CA8CFF22CA
      8CFF21CA8CFF21CA8CFF23CA8CFF24CB8CFF25CC8EFF26CC8FFF26CE8FFF27CE
      8FFF28CE90FF28CE90FF28CE90FF28CE90FF29CE91FF29CE90FF29CF90FF29CE
      90FF29CE8FFF29CE90FF28CE90FF28CE8FFF26CD8FFF26CD8FFF24CD8FFF23CD
      8FFF23CC8EFF23CC8EFF21CC8DFF21CC8DFF21CB8DFF21CB8DFF20CA8CFF20CA
      8CFF20CA8CFF20CA8CFF20CA8CFF20CA8CFF20CA8CFF1FC98BFF20CA8AFF1FC9
      8BFF21C98CFF2BE1A0FF379171FF345F52BA0000000000000000000000000000
      00000000000000000000565C74ABC2C9D1FFF0F0F6FFE1E2E9FFE2E4E9FFE5E6
      EBFFE7E8EDFFE9EAEEFFEBEBEFFFECECF0FFEEEEF1FFEFEFF2FFF1F1F2FFF2F2
      F3FFF3F3F4FFFAFDFEFEC7A462FFB68000FFD4A024FFD7A42EFFD6A630FFD6A6
      32FFE6B232FFA58A2CFF0E121AFF1E201EFF23231EFF23221EFF22221FFF2322
      1EFF23231FFF24241EFF16191BFF1F1F1BFFBD9829FFD6A229FFCB9B25FFCB9B
      24FFCC9B23FFCB981CFFB17C00FFB88D3EFFF4F6FCFFEEEEF2FFEFEEF1FFEDEE
      F0FFEEEEF1FFEDEDF0FFEBEBEFFFE9EAEEFFE7E8ECFFE5E6EBFFE4E4EAFFE3E3
      EAFFE1E1E8FFEDECF2FFD0D9DFFF626A81D92317461600000000000000000000
      00008C6E69337B7048FDC6BD8CFFD2CA97FFCEC593FFCDC592FFCDC592FFDAD2
      9CFF9D9974FF1F221DFF2D2E26FF2E2C25FF2C2C25FF2C2C25FF2D2C25FF2C2C
      25FF2C2C25FF2C2B25FF2B2B24FF2B2B23FF2C2C24FF2B2C24FF2B2B23FF2A2B
      23FF2E2E25FF2D2C23FF6A6848FFB5B074FFA39E67FFA29C65FFA29B64FFA19A
      63FF9D9761FFA9A367FF9F9962FF474731FE1F201EFF20221FFF42402DFF948C
      56FF9B9359FF8E8653FF8E8552FF8C8452FF8B8351FF8B8150FF89804FFF887F
      4EFF877E4DFF857C4CFF837949FF8F7F55FF74603BE95A5A1E11000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000D874E2B21FFBD8C
      59FFA6733DFF7F4D0EFF855210FF85520FFF84510FFF85520FFF85520EFF8551
      0EFF84520FFF85520EFF84520EFF84520EFF84520EFF84510EFF83510EFF8351
      0EFF83500EFF7E4B08FF5B3C19FFE4E4E6FFFEFDFFFFF8F7F9FFFFFFFFFFABA1
      9AFF5A2F02FF88550EFF845310FF845310FF845310FF845310FF84520FFF8452
      0FFF84510EFF83510EFF84510EFF84510EFF84520EFF84510FFF84510FFF8451
      0EFF83510EFF83500EFF83510EFF82500EFF83500EFF83500FFF82500FFF8250
      0FFF7A4A0AFF9D6C36FFB88650FF503321FF200A13C50000000000000000243D
      353F355048FF37C597FF2FE4A4FF22C688FF24C98CFF24C98CFF24C98CFF24C9
      8CFF24C98CFF24C98CFF25CA8CFF25CA8DFF25CA8DFF25CA8DFF25CA8DFF25CB
      8EFF25CA8DFF25CB8DFF26CB8EFF27CC8DFF28CD90FF28CD90FF29CE90FF29CE
      90FF29CE91FF2ACE91FF29CF91FF2ACF91FF2ACF92FF2ACF91FF2BCF91FF2BCF
      91FF2ACF91FF2ACF91FF2ACF91FF2ACF91FF28CE91FF28CE90FF26CE90FF26CD
      8FFF27CC8FFF27CC8FFF25CC8FFF25CC8FFF25CC8FFF24CC8EFF23CB8EFF23CB
      8EFF24CB8EFF24CB8EFF23CC8EFF24CC8EFF24CC8EFF23CB8DFF23CB8CFF22CA
      8BFF24CA8CFF30E6A5FF369273FF345F4EBA0000000000000000000000000000
      00000000000046536D8AAEBBBFFFF4F3FBFFE2E3EAFFE4E5EBFFE5E6EBFFE7E7
      ECFFE9EAEFFFEBECEFFFECEDF1FFEEEEF2FFF0F0F3FFF1F2F5FFF3F3F4FFF4F4
      F6FFF6F7FAFFF4F2F5FFB88722FFC79205FFDAA72DFFD9A831FFD9AA34FFDBAA
      35FFE1B434FF3B371EFF16191CFF23231EFF23221FFF23231FFF232220FF2323
      1FFF232320FF23231FFF23231EFF10141CFF49421EFFDDAD2CFFCD9B27FFCC9B
      26FFCC9B23FFCF9D23FFBE8B03FFAD7B0EFFE9E3E1FFF3F5FAFEF0F0F4FEF0F0
      F3FEF0F0F3FFEEEFF2FFEDEDF1FFEBECF0FFE9EAEEFFE8E9EDFFE6E7ECFFE5E5
      EBFFE3E4EAFFE1E1E8FFEFEFF6FFCBD3D9FF576378C72B008006000000000000
      00008A7566327B7048FEC7BE8DFFD3CA97FFCFC693FFCEC593FFCEC593FFD9D1
      9BFFA09D78FF1C1D1AFF464537FFBEB98EFFB3B083FFADAB7EFFB2AD7FFFB1AD
      7FFFB2AE7FFFB1AD7EFFAFAA7CFFADAA7BFFAFAC7DFFAEAB7CFFAEAA7AFFACA9
      79FFACA875FFB3AE78FFBEB77AFFAAA46CFFA49F67FFA39D66FFA29C65FFA19B
      64FF9F9962FF9D9761FFA39D64FFACA568FF625F3FFF21221FFF20221EFF3130
      25FF7E784AFF9F965CFF8E8553FF8D8552FF8B8351FF8B8250FF89804FFF8980
      4EFF867D4CFF817747FFA19563FFA79869FF705E36E963550E12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000A864F2D21FFC18F
      5CFFA6753EFF814F0EFF865310FF86530FFF85520FFF86520FFF86530FFF8653
      0FFF86530FFF86530FFF86530FFF86520FFF85530FFF85530FFF85520EFF8452
      0EFF85520EFF804D09FF5E401AFFE5E4E7FEFFFDFFFFF9F8F9FEFFFFFFFFABA1
      9BFF5B3002FF87550FFF855410FF855410FF855410FF855410FF85540FFF8553
      0FFF85530EFF85520EFF85520EFF85530FFF85530FFF85530FFF85520EFF8452
      0FFF84510FFF84510EFF85520FFF84510FFF83510EFF83510FFF84510EFF8452
      0FFF7C4D0BFF9E6E37FFBC8A55FF513322FF260916C500000000000000002844
      3C4033554CFF3AC69BFF30E5A6FF23C789FF25CC8EFF26CB8DFF26CB8DFF26CB
      8EFF26CB8EFF26CB8FFF27CB8FFF27CB8EFF28CC8FFF28CC8FFF28CC8FFF27CC
      90FF27CD8FFF28CD8FFF28CD90FF29CD90FF2ACE91FF2ACE91FF2ACE91FF2ACE
      91FF2BCF91FF2BCF91FF2BD092FF2CD092FF2CD093FF2CD092FF2CD093FF2CD0
      93FF2CD092FF2CCF92FF2BD092FF2BCF92FF2BCF92FF2ACF91FF29CF92FF29CF
      92FF29CE91FF29CE91FF29CE91FF29CE91FF28CD90FF27CD91FF27CD90FF27CC
      90FF27CD91FF27CD91FF27CD90FF26CD90FF26CE90FF25CD90FF24CC8EFF23CB
      8DFF26CA8EFF35EBADFF369776FF365E54BC0000000000000000000000000000
      000040476944949EABFFF0F1F6FFE2E3EBFFE4E5ECFFE6E7EDFFE7E8EEFFE9EA
      EFFFEBECF1FFEDEEF2FFEEEFF2FFF0F0F3FFF1F2F4FFF3F3F6FFF5F5F6FFF6F6
      F7FFFAFBFEFFEDE5DFFEB58109FFD29E14FFDCAA33FFDCAB37FFDCAC38FFE9B6
      3BFFB59531FF181A1AFF23241EFF23231FFF22221FFF232320FF232420FF2323
      20FF232320FF23231FFF23231FFF22231EFF171A1CFFB6902AFFD7A429FFCD9C
      27FFCD9C25FFCF9D26FFC5910EFFAB7700FFDED1BDFEF9FCFFFFF3F3F5FFF2F3
      F5FFF2F2F4FEF0F0F3FFEEEEF2FFEDEEF1FFEBECF0FFEAEAEFFFE8E9EDFFE7E8
      ECFFE5E5EBFFE3E3EAFFE1E2E9FFEFEFF6FFB8BECCFF4F536C97000000000000
      000084715D347C6F48FEC7BE8EFFD2CA98FFCFC694FFCFC693FFCEC693FFD9D2
      9CFFA29E79FF1C1D1AFF4F4D3CFFDDD4A0FFC6C088FFBBB57BFEBDB77EFFBEB8
      7FFFBFB981FFBFB980FFBFB87FFFBFB87FFFC0B981FFC1BB82FFC2BC83FFC2BC
      83FFBEB87FFFB9B27AFFADA870FFA6A069FFA69F68FFA59F68FFA49D66FFA39C
      65FFA19A64FFA09A63FF9F9962FF9F9861FFAFA769FF817C50FF2C2C23FF2122
      20FF262620FF625F3EFF9C955BFF938B56FF8C8451FF8D8351FF8B8250FF8980
      4EFE847B49FE9F9562FFB4A874FFA49568FF76643FE963551C12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000885502E22FFC292
      5EFFA87740FF824F0EFF875410FF875310FF86530FFF86530FFF86540FFF8754
      0FFF86540FFF87540FFF86530FFF87530FFF86530FFF86530FFF86530EFF8553
      0EFF85520EFF814E08FF603F19FFE5E5E7FEFFFEFFFFF9F9FAFEFFFFFFFFACA2
      9CFF5C3102FF88550FFF865410FF865510FF865410FF865410FF85540FFF8654
      0FFF86540EFF86530EFF86530FFF86530FFF86530FFF86540FFF85520FFF8553
      0EFF86520EFF85530EFF85520FFF85520FFF84520FFF84520FFF84520FFF8452
      0FFF7D4D0CFF9F6F39FFBE8C56FF533422FF260A13C500000000000000002445
      413F32564CFF3CC89DFF33E7A9FF25C88CFF28CC8FFF28CC8FFF29CD8FFF28CD
      90FF29CD90FF29CD91FF2ACD91FF2ACD91FF2ACD91FF2ACE91FF2ACE91FF2ACE
      91FF2ACE91FF2BCE92FF2BCE91FF2BCE92FF2BCF92FF2CCF92FF2CD093FF2CD0
      93FF2DD093FF2DD092FF2ED193FF2DD193FF2ED194FF2DD094FF2DD195FF2ED1
      95FF2ED094FF2ED093FF2DD193FF2DD193FF2DD094FF2CD093FF2BD093FF2CCF
      93FF2CCF93FF2BCF92FF2BCF93FF2BCF93FF2ACF92FF2ACF92FF29CE92FF29CF
      92FF2ACE92FF29CF93FF2ACF92FF29CE92FF28CF92FF28CE91FF27CE90FF26CC
      8EFF28CC90FF37ECAEFF379776FF366251BC0000000000000000000000002020
      4008687B84D0E0E5EEFFE5E5EDFFE3E5ECFFE6E7EDFFE8E9EFFFE9EAEFFFEAEC
      F0FFEEEEF2FFEFF0F3FFF0F1F4FFF2F2F6FFF3F4F6FFF5F5F7FFF7F6F8FFF8F7
      F9FFFEFFFFFFE5D7C1FFB47D00FFD8A41EFFDEAD36FFDFAF3BFFE0B13CFFF3C1
      40FF8E772DFF15171AFF24241FFF23231FFF232320FF232320FF232320FF2323
      20FF232321FF232320FF232320FF24241FFF10141AFF846F27FFE1AD2BFFCE9E
      27FFCE9D26FFCF9E27FFC99514FFAB7500FFDBCBB4FEFBFFFFFFF5F5F8FFF5F5
      F7FFF4F4F6FFF3F2F5FFF0F0F4FFEFF0F3FFEDEEF2FFECECF1FFEAEAF0FFE9EA
      EFFFE7E7EDFFE4E5EBFFE3E3EAFFE1E2EAFEEEEFF8FF94A0A8FF4152624E0000
      0000847158347B7046FFC7BE8EFFD3CB99FFCFC794FFCFC694FFCEC693FFDAD2
      9CFFA29E7AFF1C1E1BFF4E4C3BFFD5CE9BFFBCB680FFB2AC74FFB3AD76FFB3AD
      75FFB1AB74FFB1AB73FFB0AA71FFAEA970FFADA86FFFADA86FFFACA66EFFABA6
      6DFFAAA46BFFA9A26BFFA7A16AFFA7A26AFFA6A069FFA59F68FFA59D67FFA49D
      66FFA29B65FFA19B64FFA19A63FF9F9962FF9D9760FFABA467FF99935DFF403F
      2CFF20211DFF21221FFF44432FFF918954FF978E57FF8D8451FF89814EFF867D
      4CFFA19763FFAEA470FFAEA26FFFA59568FF796541E9694B1E11000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000017000B88512F24FFC493
      5FFFAA7841FF82500EFF885511FF895510FF87540FFF87540FFF87540FFF8855
      0FFF88550FFF885510FF88550FFF885510FF87550FFF88550FFF87540FFF8754
      0FFF86540FFF824F09FF614019FFE4E4E6FFFEFEFEFEF9F8F9FEFFFFFFFFADA2
      9BFF5F3101FF89560FFF875510FF87550FFF88550FFF88550FFF87540FFF8754
      0FFF87540EFF87540FFF87540FFF875410FF87550FFF87540FFF87540FFF8754
      0FFF86530FFF87530FFF86540FFF86530FFF86530FFF85530FFF85530FFF8553
      0FFF7D4D0CFFA2723CFFBF8E58FF543523FF240A14C400000000000000002643
      433D32544BFF42C9A0FF39E8ACFF28C88CFF2ACD91FF2ACD91FF2ACE92FF2BCE
      92FF2BCE92FF2CCE91FF2BCE92FF2CCE92FF2CCE92FF2CCE92FF2CCE92FF2CCE
      92FF2DCF92FF2DCF93FF2DCF92FF2DCF93FF2DD094FF2DD094FF2ED093FF2ECF
      94FF2ED094FF2ED094FF2FD194FF2FD194FF2FD195FF2FD194FF2FD295FF2FD1
      95FF30D095FF2FD195FF2FD194FF2FD194FF2ED094FF2ED094FF2ED093FF2ED0
      94FF2ED094FF2DCF93FF2DCF93FF2DCF94FF2DCE94FF2CCE93FF2CCF93FF2BCF
      94FF2BCF93FF2BCF94FF2BCF93FF2BD093FF2BCF93FF2BCF93FF29CF92FF29CD
      90FF29CD91FF3AECB0FF3A9879FF326250BB0000000000000000000000002147
      5D659DACBCFFF3F2FAFFE0E2EAFFE6E7EDFFE7E9EEFFE9EAEFFFEAECF1FEECED
      F2FEF0F1F4FFF2F3F5FFF3F3F6FEF5F5F7FFF6F5F8FFF7F6F9FFF8F8F9FFF9F8
      F9FFFFFFFFFFE5D7BCFEB78100FFDBA722FFE1B039FFE4B33EFFE7B744FFFAC8
      49FF947D32FE0A0D10FE191913FF23231DFF242421FF242420FF232320FF2323
      20FF242321FF232420FF232320FF23231FFF0E141BFF776625FFE5B22BFFD09F
      28FFCF9E26FFD19E27FFCC9916FFAB7500FFDBCAB5FEFDFFFFFFF7F7F9FFF6F6
      F8FFF5F5F7FFF4F4F6FFF2F2F5FFF0F1F4FFEFEFF3FFEDEEF2FFECEDF1FFEBEC
      F0FEE8E9EEFFE7E7ECFFE4E5ECFFE2E4EBFEEFF0F6FFD0D5DEFF525A75AC0000
      000089715E36796F44FFC6BE8DFFD4CB9AFFCFC895FFCFC693FFCFC793FFDAD1
      9CFFA4A07BFF1D1D1BFF4F4D3DFFD7D09CFFBEB781FFB5AE76FFB7B078FFB6AF
      78FFB4AE77FFB3AD76FFB3AC74FFB2AC73FFB0AA72FFB0AA72FFAFA870FFADA7
      70FFABA56EFFAAA46CFFA9A36BFFA8A26BFFA7A069FFA69F69FFA59F68FFA59E
      67FFA39C66FFA29B64FFA29A63FFA09963FF9F9861FF9D965FFFA59D63FFA9A1
      65FF5F5B3DFF21211EFF20211FFF313125FF827C4CFF968E56FF8A824FFFA49A
      66FFAEA46FFFAA9E6BFFADA26EFFA49466FF7D6343E7694B1E11000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000016000D89512F24FFC695
      62FFAC7A42FF83510FFF895611FF895610FF88550FFF885510FF88550FFF8955
      0FFF89560FFF89550FFF895510FF895510FF88550FFF88550FFF88550FFF8855
      0FFF88540FFF835009FF624019FEE5E4E6FFFFFFFFFFFAF8F9FFFFFFFFFFAEA3
      9CFF603301FF8A570FFF885510FF885610FF88550FFF88550FFF88550FFF8755
      0FFF88550FFF88550FFF88550FFF88550FFF87550FFF88550FFF88540FFF8754
      0FFF87540FFF87540FFF87540FFF87540FFF87540FFF87540FFF86530FFF8654
      10FF7E4E0CFFA4743DFFC1905AFF543623FF230A12C300000000000000002640
      403C33534BFF44C9A3FF3CE9AEFF2ACA8DFF2CCE93FF2CCF93FF2DD094FF2CD0
      93FF2DCF93FF2DCF93FF2ECF94FF2ED093FF2ED094FF2ED094FF2ED094FF2FD0
      94FF2ED094FF2FD094FF2FD094FF2FD094FF2FD195FF2FD195FF30D195FF30D1
      95FF30D195FF30D195FF30D296FF30D295FF31D296FF31D296FF31D296FF32D2
      96FF31D296FF32D296FF31D296FF31D296FF31D196FF31D195FF30D295FF30D1
      95FF30D195FF30D196FF2FD095FF2ED094FF2FD095FF2ED095FF2ED095FF2ED0
      95FF2ED195FF2ED195FF2ED095FF2ED195FF2DD195FF2DD195FF2BD093FF2BCE
      92FF2CCF93FF3CEDB2FF39977AFF326250BB0000000000000000000000003C5C
      7A5E697CA8FFD5D7E4FFEEEFF2FEE5E6EDFFE7E9EEFFEAEBF0FFECEEF2FFEEF0
      F3FEF2F2F6FFF4F4F7FFF5F5F8FFF7F6F9FFF7F7F9FEF9F9FBFFF9F9FAFFFAFA
      FBFFFEFFFFFFEADECAFEB88200FFDBA820FFE4B43DFFE7B743FFECBE4DFFFBCC
      53FFB79539FE363A3EFE4F4F4EFF20201CFF1D1D19FF262623FF232421FF2324
      21FF242421FF242421FF232320FF24241FFF0F141BFF857126FFE3B02BFFD1A0
      28FFD1A027FFD1A027FFCC9914FFAA7400FFDBCBB8FEFDFFFFFFF8F9FAFFF8F8
      F9FFF6F6F8FFF5F5F7FEF4F4F6FFF2F2F5FFF0F0F4FEEFF0F4FFEEEEF2FFEDED
      F1FEE9EAEFFEE8E9EEFFE4E6ECFFEAEBF0FEE9E9F0FF7C87A6FF4B5A74960000
      000089715A36797044FFC6BE8DFFD4CB99FFD0C795FFD0C794FFCFC794FFDAD2
      9DFFA5A07BFF1C1E1BFF4F4E3EFFD8D19DFFBFB782FFB6AF77FFB8B17AFFB7B0
      79FFB5AF78FFB4AE77FFB3AD76FFB3AC75FFB2AB74FFB1AB72FFB0A972FFAFA8
      71FFACA66EFFABA56DFFA9A46CFFA8A36BFFA7A16AFFA7A069FFA59F68FFA59E
      67FFA39D66FFA39B65FFA29B64FFA19A63FFA09961FF9F9860FF9E9660FF9F97
      60FFAEA669FF7E794EFF353529FF252622FF272620FF867E4FFFAEA46BFFACA3
      6CFFA99D6BFEA99E6BFFACA06DFFA39465FF7D6241E8694B1E11000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000015000B86523025FFCA98
      66FFAF7D44FF855310FF8A5711FF8B5711FF8A5710FF8A5611FF8A560FFF8957
      10FF8A5710FF8B5710FF8A5710FF8A5610FF8A5610FF8A560FFF895610FF8956
      10FF8A5610FF86520AFF634019FFE6E5E7FFFFFFFFFFFAF8FAFFFFFFFFFFACA1
      9BFF623501FF8D5911FF8A5710FF8A5710FF895711FF895610FF895610FF8957
      10FF8A560FFF8A560FFF89560FFF8A570FFF895610FF895710FF895610FF8956
      10FF88550FFF89550FFF89550FFF88550FFF88550FFF88550FFF885510FF8855
      10FF81510CFFA87740FFC5935EFF563624FF230A14C400000000000000002143
      363D345248FF48CBA8FF40EBB2FF2CCB8FFF2ED095FF2FD095FF2FD095FF2FD1
      95FF2FD195FF30D196FF30D196FF30D196FF30D195FF30D195FF31D295FF31D1
      96FF31D195FF30D296FF31D195FF31D195FF32D295FF32D296FF32D296FF32D2
      96FF32D296FF33D296FF33D397FF33D397FF32D396FF33D297FF33D397FF33D3
      97FF33D397FF33D297FF32D396FF33D296FF33D297FF33D297FF32D297FF32D2
      96FF32D197FF32D197FF32D297FF31D296FF31D296FF31D197FF31D197FF31D2
      97FF31D296FF31D197FF30D297FF30D297FF30D196FF30D197FF2FD195FF2ED0
      94FF2ED094FF40EEB4FF3C997CFF386450BC0000000000000000000000009F60
      DF084F62A0DB6879B5FFC7CADBFEF3F3F5FFE6E7EEFFE8E9EFFFEFF0F4FFF2F3
      F5FFF2F3F6FFF5F5F8FFF7F7F9FFF8F8FAFFF9F9FAFFFAF9FBFFFAFAFBFFFBFB
      FCFFFEFEFFFFF3EBE7FFBB870DFFD9A419FFE6B63EFFEABC48FFF1C65AFFF5CA
      56FFE3D19AFFF4FAFDFFFFFFFFFFC4C4C5FE30302EFF1E1F1BFF232422FF2424
      22FF242422FF242421FF232320FF23231FFF15181AFFB3932AFFDDA92AFFD3A2
      28FFD2A228FFD3A226FFC8940AFFAB7803FFE5DAD0FEFDFEFFFFFAF9FBFFF9F9
      FAFFF8F8F9FFF7F7F8FEF5F5F7FEF4F4F6FEF1F2F4FEF0EFF3FFEEEEF2FFEDEE
      F2FFEBEBF0FFE6E7EDFEEBECEFFFE6E6EBFF8187B4FF506097FE5C72882F0000
      0000897260387A7048FFC7BF90FFD5CC9BFFD0C795FFCFC794FFCFC795FFDBD3
      9EFFA49F7AFF1C1D1AFF4F4E3DFFD8D19EFFBFB883FFB9B179FFBAB27CFFB9B2
      7BFFB7B17AFFB6B079FFB4AE77FFB4AE76FFB3AD75FFB2AC74FFB0AA73FFB0AA
      72FFAEA870FFADA76FFFAAA56DFFA9A36CFFA8A26BFFA7A16AFFA69F69FFA69F
      68FFA59E67FFA49D66FFA39B64FFA29B64FFA19A62FFA09861FFA09861FF9D95
      5FFFA39D63FFB3AD6CFF515038FF272722FF1A1A19FF857D53FFB5AB71FFA99E
      69FFA89D69FFA89C68FFAB9E6BFFA29163FF7B6244EA63551C12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000015000C85533026FFCC9B
      69FFB07E46FF855411FF8B5812FF8B5812FF8B5711FF8B5810FF8A5810FF8A57
      10FF8B5810FF8B5811FF8B5710FF8A5710FF8B5710FF8B570FFF8A5710FF8957
      11FF8A5811FF86530BFF644019FFE7E5E7FFFFFFFFFFFAF9FAFFFFFFFFFFADA2
      9BFF633502FF8D5A11FF8A5711FF8A5710FF8A5810FF8A5710FF8A5710FF8A57
      0FFF8A5710FF8A5710FF8A5710FF8B5710FF8A5710FF8A5810FF8A5710FF8A57
      10FF89560FFF895610FF89560FFF89550FFF89560FFF89560FFF885510FF8956
      10FF83510DFFA97841FFC7965FFF573825FF230A14C40000000000000000213F
      363D345248FF4BCCAAFF42ECB4FF2ECD91FF30D296FF31D296FF31D297FF31D2
      97FF32D297FF32D297FF32D298FF32D397FF32D397FF33D297FF32D397FF32D3
      97FF33D297FF33D397FF33D396FF33D396FF33D397FF34D397FF34D497FF34D3
      97FF34D297FF34D397FF35D398FF34D498FF35D497FF34D397FF34D498FF35D4
      98FF36D398FF36D398FF34D498FF34D398FF35D399FF34D399FF34D398FF34D3
      98FF34D298FF34D298FF34D399FF34D399FF33D398FF33D398FF33D398FF33D3
      99FF33D298FF33D399FF32D399FF32D399FF32D398FF32D298FF31D297FF30D1
      95FF30D196FF43EEB6FF3D987DFF396550BD0000000000000000000000000000
      000057639E675F79BBFF596BACFFADB0CCFFF3F5F5FFEAECF0FFE8E8EFFFEFF0
      F4FEF5F5F8FEF7F7F9FFF8F9FBFFF9F9FBFFF9F9FBFEFBFAFCFFFBFBFCFFFCFB
      FCFFFDFDFEFEFCFAFCFEC49632FFD09A07FFE5B53BFFEDBF4DFFF4CA5BFFF6D4
      7AFFFEFEFEFFFFFFFFFFFEFFFFFFFFFFFFFFAAABACFF141510FF242522FF2424
      22FF252522FF252521FF24241FFF16191DFF3E3A1DFFDFB22EFFD4A329FFD4A3
      27FFD4A228FFD4A326FFC18E01FFB0811AFFF3F0F1FEFBFCFFFFFAFAFBFEFAFA
      FBFFF9F9FAFFF8F8FAFFF6F6F8FEF4F5F7FEF3F3F6FFF1F2F5FFEFEFF3FFEBEC
      F0FFE5E7EDFFF1F1F1FED6D6E1FE6F78AAFF5C70B4FF55649AB5000000000000
      0000866F58377A7047FFC7C090FFD5CD9AFFD0C795FFCFC795FFCFC794FFDCD3
      9DFFA49F7BFF1C1D1AFF504E3DFFD8D19DFFBEB783FFB9B27AFFBAB47CFFB9B3
      7CFFB7B17AFFB6B079FFB5AF78FFB4AE77FFB3AD76FFB2AC75FFB1AB73FFB0AA
      72FFAEA871FFADA770FFABA56DFFAAA46CFFA8A26BFFA7A26AFFA7A069FFA69F
      68FFA59E67FFA49D66FFA39C65FFA29B64FFA19963FF9F9862FF9E9760FFACA4
      67FF958E5BFF3C3C2AFF22221EFF1F1E1CFF524F37FFAFA46CFFA99F69FEA79C
      67FFA69B66FFA59A66FFA99C68FEA08F62FF796244E955550E12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000B88523325FFCFA0
      6AFFB08047FF865511FF8D5A13FF8D5913FF8D5911FF8D5A11FF8C5A12FF8D59
      12FF8D5A12FF8E5A11FF8D5912FF8D5A12FF8D5911FF8C5911FF8C5911FF8C59
      10FF8D5A11FF88540BFF654219FFE7E5E7FFFFFFFFFFFBFAFBFEFFFFFFFFACA2
      99FF633602FF8E5B13FF8B5810FF8B5810FF8B5910FF8C5910FF8B5810FF8B58
      11FF8B5910FF8C5910FF8C5910FF8C5911FF8C5911FF8C5911FF8C5911FF8C59
      11FF8B5810FF8C5811FF8B5811FF8B5811FF8B5710FF8B5710FF8B5811FF8B58
      11FF84530DFFAA7840FFCA9962FF553825FF1F0712C40000000000000000263F
      3B3D325449FF50CCADFF45EEB6FF2FCE92FF34D397FF33D397FF33D298FF33D3
      98FF34D298FF34D398FF35D398FF35D498FF34D498FF34D499FF35D499FF35D4
      99FF34D499FF35D498FF35D397FF35D398FF35D498FF35D498FF36D499FF36D4
      99FF36D498FF36D499FF36D499FF36D499FF36D498FF36D498FF37D499FF37D4
      99FF37D499FF37D499FF36D499FF37D499FF36D499FF36D499FF36D599FF36D4
      99FF36D399FF36D39AFF36D49AFF36D49AFF35D49AFF35D49AFF35D49AFF35D4
      9AFF35D49AFF35D49BFF35D49AFF35D49AFF34D499FF34D399FF33D398FF32D2
      97FF32D297FF43EFB5FF3D9D7DFF376254BD0000000000000000000000000000
      000055398E09536A9FD8728ECEFF5367AEFF8588B7FFE7E8EEFFF0F0F2FEE5E6
      EDFEECECF2FFF3F4F7FFFAFAFCFFFCFCFDFFFBFBFCFEFBFBFDFFFCFBFDFFFCFC
      FDFFFDFCFDFFFEFEFEFED3B174FFC28900FFE0AF2AFFEFC34FFFF3CA5AFFF8E0
      A0FFFDFFFFFFFCFDFEFEFDFEFEFFFFFFFFFFDADADCFF1F201DFF23241FFF2526
      22FF262621FF272721FF20231CFF131619FFAA8C29FFE2AF2BFFD4A329FFD5A3
      28FFD6A429FFD2A01CFFB68000FFC19957FFFFFFFFFFFBFBFDFFFBFBFCFFFBFA
      FCFFF9F9FAFEF9F9FAFEF7F7F9FEF6F6F8FEF2F2F5FFECECF1FEE4E5EBFFE3E5
      EBFFF1F2F2FFB9BAD2FF5F6DACFF6782C2FF5B73B0F947598E2B000000000000
      0000826F5837776F46FFC7C090FFD6CD9AFFD0C896FFD0C896FFCFC795FFDAD2
      9DFFA6A17CFF1E1F1CFF504F3DFFD7D19DFFC0B884FFBAB37CFFBBB47EFFBBB4
      7DFFB9B27CFFB7B17AFFB6AF78FFB5AE77FFB3AD76FFB3AC75FFB1AB73FFB0AA
      72FFAEA971FFADA770FFACA66FFFABA56DFFA9A36BFFA7A16AFFA7A069FFA79F
      68FFA59E67FFA49D66FFA39C65FFA39B64FFA19962FFA19A62FFAEA66AFF7A76
      4DFF292A23FF212320FF21211DFF6C6845FFB4AA6EFFA89E68FFA49A65FFA399
      64FFA29762FFA19562FFA59965FF9E8D62FF7B6842EA55550012000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000011000B88533327FFD0A2
      6DFFB18149FF83530EFF8B5711FF8B5710FF8A5710FF8A5710FF8B5810FF8B58
      10FF8C5910FF8C5910FF8B580FFF8B5810FF8B570FFF8B580FFF8A580FFF8A57
      0FFF8B5810FF86530AFF654319FFE7E5E7FFFEFEFEFEFBFAFBFEFFFFFFFFADA2
      99FF633603FF8C5911FF89570FFF89570EFF89570FFF8A580FFF89570EFF8A57
      0FFF89570FFF8A570EFF8A580FFF8A580FFF8A570FFF8A570FFF8A570FFF8957
      0FFF89560EFF89560EFF89570FFF89560FFF88560FFF89560EFF89560FFF8856
      0FFF81520CFFAB7940FFCB9A64FF543825FF1E090EC300000000000000002542
      3E3E325449FF53CCB0FF49EEB9FF31CF93FF36D499FF35D499FF35D49AFF36D4
      99FF36D499FF36D499FF37D59AFF37D59AFF36D49AFF36D499FF37D59AFF37D4
      9AFF37D59AFF37D59AFF37D499FF37D599FF37D599FF37D499FF38D59AFF38D5
      9AFF37D59AFF37D599FF38D59AFF38D59AFF38D69AFF38D59AFF38D59BFF38D5
      9AFF38D59BFF38D59AFF39D59BFF38D59AFF38D59BFF37D59AFF38D59BFF38D5
      9BFF38D59BFF38D49BFF38D59BFF38D59BFF38D59BFF38D59CFF37D59CFF37D5
      9CFF37D59CFF37D59CFF37D59BFF37D59CFF36D59BFF36D59AFF36D59AFF35D3
      99FF35D49AFF45EFB7FF3D9D7EFF376254BD0000000000000000000000000000
      0000000000004B58964B667EBDFF7C9CD5FF5973B8FF636CAAFFC7C7DAFEF7F6
      F6FEE8E9EFFFE6E7EEFFEBECF1FFF4F4F7FEFBFBFCFEFCFDFEFFFDFCFDFEFCFC
      FDFFFDFCFDFFFFFFFFFFEDE1D5FEB98104FED9A511FFECBE47FFF3CA5CFFF7D7
      7DFFFCFCF8FFFDFEFEFEFDFFFFFFFFFFFFFF9B9DA8FF141612FF262722FF2627
      22FF232521FF161A1FFF171A1AFF957B26FFEBB72DFFD6A429FFD5A429FFD5A4
      28FFD7A528FFC9970AFFA97200FFDECBB5FFFEFEFEFEFBFBFDFEFCFBFDFEFBFB
      FCFFF9F9FAFEF6F6F8FEF0F0F3FEEAEAEFFEE5E5ECFEE3E4EAFFEEEEF0FEE3E4
      E9FF8F91BBFF5565A9FF7B9CD2FF6F8CC9FF44588F8B00000000000000000000
      000084715A36776F45FFC8C18FFFD5CD9AFFD1C895FFD0C895FFD0C795FFDAD2
      9DFFA7A27DFF1E1F1CFF4F4E3DFFD7D09CFFBFB984FFBAB37DFFBCB57EFFBBB4
      7DFFB9B37CFFB8B27AFFB6B079FFB4AE77FFB3AD76FFB2AC75FFB0AB73FFAFAA
      73FFAEA871FFADA770FFACA56FFFAAA46DFFA8A26AFFA7A169FFA7A169FFA69F
      68FFA59E67FFA59D66FFA39C65FFA19A63FFA79F66FFACA468FF5D5B3CFF2123
      1FFF202120FF2F2E25FF8B8658FFB6AE71FFA59C65FFA29963FFA29862FFA197
      61FFA09561FFA09460FFA29663FF9D8C5FFF7B6742E95A5A0011000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000987593628FFD6A7
      73FFB88950FF90601DFF986621FF996620FF986520FF986620FF996620FF9966
      20FF996720FF996720FF99671FFF996620FF996620FF99661FFF98661FFF9765
      1FFF97651EFF936017FF69451BFFE6E5E7FFFFFFFFFFFCFBFCFFFFFFFFFFAEA2
      9AFF673907FF9B6820FF97661FFF98671FFF97661FFF97661FFF97651EFF9765
      1EFF97651DFF98651EFF97641DFF98651DFF97651EFF97651FFF96641EFF9664
      1DFF97641EFF97641EFF96641EFF96631EFF96641DFF96641DFF96641EFF9563
      1EFF8C5C17FFAE7E45FFCC9B64FF573825FF1E0B0FC10000000000000000284C
      4040335549FF51CCAFFF4BEFBAFF34D297FF37D59AFF38D59BFF38D59AFF38D5
      9BFF38D59AFF38D69BFF38D69BFF39D69CFF38D69BFF38D69BFF39D69CFF39D6
      9CFF39D69CFF39D69CFF38D69BFF39D59BFF39D69AFF39D59BFF3AD69AFF39D6
      9BFF39D69AFF39D59AFF3AD69BFF3AD69BFF3AD69BFF39D69BFF3AD69BFF3AD6
      9BFF3AD69CFF3AD69CFF3AD69CFF3AD69BFF3AD69CFF3AD69CFF3AD69CFF3AD6
      9CFF3AD69CFF3AD59CFF3AD69DFF3AD69DFF3AD69EFF3AD69EFF3AD69DFF3AD6
      9DFF3AD69DFF39D69DFF39D79DFF39D69DFF38D69DFF38D69CFF39D69CFF38D6
      9BFF38D79DFF4CF1BEFF3E9E7FFF386358BC0000000000000000000000000000
      00000000000000000000525FA3B2809AD1FF81A5D6FF6D8FC8FF5563AAFF9595
      C1FFE8E8EDFFF3F3F4FFE7E8EEFEE6E7EEFEEBEBF0FFF0F1F5FFF6F6F9FEFBFB
      FDFFFDFCFEFFFDFDFEFFFFFFFFFFC7A35FFFC58C00FFE7B62FFFF0C353FFF5CA
      59FFF7DA88FFFAF4DBFFFAF6EDFFF6E6B9FF776B33FF1A1D16FF171A1CFF171B
      1DFF27291DFF5B5021FFBC972AFFE9B62EFFD8A82BFFD8A82BFFD6A528FFD7A6
      27FFD3A11BFFB88300FFB88F3CFEFBFAFDFEFBFCFDFEF8F8FAFEF3F3F6FFEDEE
      F2FFE9E9EEFEE7E6EDFEE4E4EAFEE3E3EAFEEDECEDFFF0EFF0FFB6B4D0FF686F
      ADFF637BB9FF84A8D7FF84A2D5FF50649FD8462E740B00000000000000000000
      0000846D5E36776E46FFC7C08FFFD6CE9BFFD1C895FFD1C895FFD0C895FFDCD3
      9DFFA5A07AFF1C1E1BFF504E3EFFE4DDA6FFCEC78FFFC8C187FFC9C287FFC8C1
      87FFC7C085FFC6BF84FFC3BC81FFC1BB7FFFC0BA7EFFBFB97DFFBEB97DFFBDB7
      7CFFBCB67AFFBBB579FFB1AC71FFA8A26BFFA7A16AFFA7A069FFA5A068FFA59F
      68FFA69E67FFA59E67FFA29C64FFAFA76BFF9D9661FF444230FF20211DFF2021
      1DFF44422FFFA39C65FFB2A96EFFA29A64FFA29863FFA19762FF9F9560FF9F94
      60FF9E935FFF9E925FFFA09461FF9B8B5EFF7B6640EA55470E12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000015000886593629FFD8AB
      78FFBE8F56FF9E6D2BFFA6732FFFA6732FFFA6732FFFA6742FFFA7742FFFA774
      2FFFA7742FFFA6742FFFA6742EFFA6742FFFA6742FFFA6742EFFA5732DFFA572
      2CFFA5722AFF9F6B23FF6A461BFFE8E5E7FFFFFFFFFFFCFBFCFFFFFFFFFFADA1
      99FF6B3E0BFFAD792EFFA8752FFFA7752EFFA6742DFFA6742CFFA5732CFFA572
      2CFFA4722BFFA4722CFFA5712BFFA5712BFFA4722CFFA4722CFFA5722CFFA572
      2CFFA5722DFFA5722DFFA4722CFFA4712CFFA4712BFFA3712BFFA3712BFFA371
      2BFF9A6924FFB38349FFCF9C68FF593927FF200B0EC20000000000000000254A
      3A3E33554AFF53CCB0FF4DF1BCFF36D298FF3AD69CFF39D69BFF3AD69CFF3AD6
      9CFF3AD69CFF3AD79CFF3AD79DFF3AD79DFF3AD79DFF3AD79DFF3BD79DFF3BD7
      9DFF3BD69DFF3AD79DFF3AD79DFF3BD79CFF3BD69CFF3BD69CFF3BD79CFF3BD7
      9BFF3BD69BFF3BD69CFF3BD79CFF3BD79CFF3BD69CFF3BD69CFF3CD79CFF3BD7
      9DFF3CD79DFF3CD79DFF3CD69DFF3CD69CFF3CD79DFF3CD79DFF3CD79DFF3CD7
      9DFF3CD79DFF3CD79EFF3DD79FFF3CD79FFF3CD79FFF3DD79FFF3CD79FFF3CD7
      9FFF3BD89EFF3CD79EFF3CD89FFF3BD89EFF3BD79FFF3BD79EFF3BD79EFF3AD6
      9DFF3CD89FFF50F1BEFF3E9D7FFF386455BC0000000000000000000000000000
      000000000000000000005252AD1F5B6FACF08BA9D8FF7EA3D5FE83A6D6FF5E77
      B9FF646DACFFB4B5D1FFF2F2F3FEF2F2F3FEE7E7EDFEE6E6EDFFE6E6ECFEEBEC
      F0FFF3F3F5FEF9F8F9FFFDFDFEFFF0EAE6FFBB8511FFD49F09FFECBD44FFF2C7
      59FFF4CB5EFFF5CE65FFF1CC69FFEFC450FFF7CC45FFCCAC3BFFB39633FFB495
      31FFD0A932FFEDBC32FFE9B330FFDBA92EFFDAAB2EFFDBAA2CFFD9A82AFFD7A6
      22FFC39104FFAC7705FFE5D9CDFFF7F9FDFFEEEEF0FFEAEAEDFFE6E6ECFFE5E5
      EBFFE4E4EBFEE4E4EBFFEDEDEFFFF0EFF0FEC5C4D9FE767AB1FE5B6CB0FF789A
      CEFF82A8D6FF91B1DCFF647AB0FC465390370000000000000000000000000000
      000082735B35776E45FFC8C090FFD5CE9BFFD1C895FFD0C895FFD0C895FFDCD4
      9EFFA39E79FF20211DFF3B3B31FF8B886AFF868261FF82805CFF807E5BFF817E
      5BFF807D5AFF7F7D5AFF7E7C58FF7E7B57FF7E7B58FF7D7A57FF7D7A56FF7C79
      55FF7B7953FF797650FF95905FFFB0AA70FFA6A069FFA69F69FFA5A068FFA59F
      67FFA59E67FFA69E67FFB4AD6FFF837F52FF2E2D24FF22231FFF21211EFF625F
      40FFB2AA6DFFABA36AFFA19964FFA29964FFA19762FFA09661FF9E9460FF9D93
      5FFF9D925EFF9C915DFF9F9360FF9A8A5DFF7C6640EA55470E12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001300068659382BFFDCB0
      7DFFC0935AFF9C6C2AFFA4722EFFA4722EFFA4732EFFA4732DFFA5732EFFA573
      2EFFA5722EFFA5732EFFA4732DFFA4722DFFA4712BFFA3722BFFA3712BFFA371
      2AFFA27028FF9A6820FF6A451CFFE8E5E8FFFFFFFFFFFCFAFCFEFFFFFFFFABA0
      98FF6A3D0BFFA9762CFFA4732CFFA4732CFFA3712AFFA4722AFFA3712AFFA371
      2AFFA27129FFA2702AFFA2712AFFA3702AFFA2712BFFA2712BFFA3722BFFA472
      2CFFA3712BFFA3712BFFA2712AFFA2712BFFA2702AFFA2702BFFA2702BFFA271
      2BFF986923FFB5864DFFD6A671FF5A3D2BFF210A14C40000000000000000254A
      353E355749FF55CDB2FF4DF2BEFF38D49AFF3CD79CFF3BD79CFF3BD79DFF3CD7
      9DFF3CD69DFF3CD79DFF3CD79DFF3DD89DFF3CD89EFF3DD79EFF3DD79EFF3DD8
      9EFF3CD79DFF3DD79EFF3CD79DFF3CD79CFF3CD79CFF3CD79CFF3CD79CFF3CD6
      9CFF3CD79CFF3CD69CFF3DD79DFF3DD89DFF3CD79CFF3CD79CFF3CD79DFF3DD7
      9DFF3DD79CFF3DD79CFF3CD79DFF3DD69DFF3DD79DFF3DD79EFF3ED79EFF3ED7
      9EFF3ED79FFF3FD79FFE3FD89FFF3ED89FFF3ED79FFF3ED7A0FF3ED8A0FF3DD8
      A0FF3DD9A0FF3ED8A0FF3DD8A0FF3DD9A0FF3DD8A0FF3DD8A0FF3DD89FFF3CD7
      9FFF3DD8A1FF50F1BDFF429E7FFF3A6756BD0000000000000000000000000000
      00000000000000000000000000003A509D537588BBFF99B6DEFF7CA4D4FF8AB2
      DBFF7DA0D1FF5C71B3FE7379B3FFBDBDD7FFF0EFF1FFF3F2F2FFE7E7EDFEE5E5
      ECFFE7E7EDFFE9E8EEFFEDECF1FFF7FBFFFFDFC9A8FFB87D00FFD7A411FFEEBE
      43FFF2C655FFF1C656FFF1C858FFF1C756FFEFC24EFFF4C54BFFF3C345FFF1BF
      40FFE8B73BFFE2B239FFE0B138FFDEAF35FFDEAD2FFFDFAE30FFDAA924FFC795
      06FFAB7400FFD1B693FEF3F7FEFEE7E8EDFFE5E5EBFEE5E5EAFEE4E4EAFEE7E7
      EBFEF2F2F1FFEDEDEFFFBDBDD4FF7B7FB4FF606FB1FF7493C9FF8AB0D9FE80A4
      D1FF9AB5DEFF859ACBFF4A599B78000000000000000000000000000000000000
      000084715E36797048FFC8C190FFD5CD9AFFD1C895FFD0C895FFD0C895FFDCD3
      9DFFA29D79FF1C1D1AFF272825FF1A1B1BFF1C1C1DFF1C1C1CFF1A1B1CFF1B1B
      1CFF1B1B1CFF1A1C1CFF1B1C1DFF1C1C1CFF1C1D1DFF1C1D1DFF1A1B1BFF1A1A
      1AFF1A1A1AFF1E1F1CFF2B2A21FFA59F69FFA9A26AFFA6A068FFA69F68FFA49D
      66FFABA46AFFB0A96DFF636142FF232420FF232420FF2C2B22FF837E53FFB5AE
      70FFA59D66FFA29A64FFA19963FFA09762FFA09662FF9F9561FF9D945FFF9D92
      5EFF9B915DFF9B8F5DFE9D905EFF99885CFF7C6441E963471C12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001100068659392CFFDEB4
      82FFC3955EFF9E6E2CFFA57431FFA67431FFA67430FFA57430FFA67430FFA675
      30FFA67530FFA67530FFA6742FFFA6742FFFA5742EFFA4732EFFA5732DFFA473
      2DFFA4722BFF9B6A22FF6B451CFEE8E5E7FFFFFFFFFFFCFAFBFFFFFFFFFFACA0
      99FF6B3E0DFFAA772DFFA6752EFFA6752EFFA5732CFFA5732CFFA5732DFFA473
      2DFFA4732CFFA4722CFFA4732DFFA4732DFFA4722EFFA4732EFFA5742FFFA574
      2FFFA5732FFFA5732EFFA4732DFFA4732DFFA4722DFFA4722DFFA3722DFFA472
      2EFF9A6A26FFB8894FFFD9A974FF5B3E2DFF210A14C300000000000000002647
      363D355749FF56D0B4FF50F1C0FF38D499FF3BD79CFF3BD79CFF3CD79DFF3CD7
      9CFF3CD79CFF3CD79CFF3CD89DFF3CD89DFF3CD89DFF3DD89DFF3DD99EFF3DD8
      9EFF3DD89DFF3DD89DFF3DD79DFF3CD79CFF3DD79DFF3DD79DFF3DD79DFF3ED7
      9DFF3DD79DFF3ED79DFF3ED89EFF3ED89EFF3ED89EFF3DD89DFF3ED89EFF3ED8
      9EFF3FD79DFF3FD89DFF3ED89EFF3ED79DFF3ED79EFF3ED79FFF3ED79FFF3ED7
      9EFF3FD79FFF3FD79FFF3FD9A0FF3FD9A0FF3FD8A1FF3FD9A1FF3FD9A1FF3ED9
      A0FF3FD9A0FF3FD9A0FF3ED8A0FF3ED9A0FF3ED9A0FF3ED8A0FF3DD89FFF3DD8
      9FFF3ED7A0FF51F1BDFF429C80FF386454BC0000000000000000000000000000
      00000000000000000000000000000000000051539E848CA0CCFF9DBDE2FF7AA2
      D2FF8BAFD9FF91B8E0FF7A99CEFF5B6EB1FF727BB3FEB2B4D1FFE5E5EBFEF5F5
      F5FEEEEEF1FFE8E8EDFFE8E7ECFEEAE9EEFEF7FBFFFFD7BC96FFBC8000FFD19C
      03FFE6B532FFF1C34CFFF1C656FFEFC552FFEDC24CFFEBC04AFFEABE48FFE8BC
      45FFE6B940FFE5B73EFFE3B53BFFE2B43AFFE3B233FFD8A822FFC29000FFAE76
      00FFCDAF82FFF2F4FFFFE7E7EDFEE5E6EBFFE7E8EBFFEFEFF0FEF2F2F2FFDEDE
      E7FEADADCCFF747CB2FF6073B3FF7899CCFF8EB5DDFE8DB1DAFF7EA2D0FF9CBB
      DFFF9AB1D9FF4D5C99A300000000000000000000000000000000000000000000
      0000876F60357A7049FFC9C290FFD6CD9AFFD2C996FFD1C896FFD0C895FFD3CB
      97FFCBC697FF63624DFF515141FF525141FF545342FF545342FF535140FF5251
      40FF535241FF535241FF53513FFF53513FFF535340FF545340FF53523FFF5453
      40FF504F3BFF2D2E26FF282720FF999463FFAAA46CFFA69F68FFA49D67FFB3AB
      6FFFA09A64FF444330FF21221EFF22231FFF3F3D2DFF9C9663FFB3AC6FFFA29B
      65FFA29B64FFA29A64FFA09863FFA09762FF9E9561FF9E9460FF9D935FFF9B91
      5EFF9B905CFF9A8E5CFF9C8F5DFF98875AFF7D6441E8694B1E11000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000F0006875A3A2DFFE2B8
      86FFC79A63FFA17231FFA87735FFA87735FFA87733FFA87734FFA87734FFA877
      34FFA77732FFA87733FFA77632FFA77733FFA77631FFA77631FFA67631FFA676
      31FEA77630FF9F6D26FF6B471DFFE7E5E7FFFEFEFEFEFBFAFAFFFFFFFFFFACA1
      99FF6D400DFFAA782EFFA67631FFA77631FFA87731FFA77630FFA77530FFA676
      30FFA6762FFFA67530FFA77630FFA77631FFA77631FFA77632FFA77631FFA776
      31FFA77631FFA77632FFA77631FFA77531FFA67530FFA67530FFA5732FFFA574
      2FFF9C6C28FFBD8D55FFDCAD78FF5A3E2CFF210710C400000000000000001C49
      3D3F315D4DFF5DD5B9FF5CF9CEFF41E0AAFF46E5AFFF45E6AEFF46E4AFFF45E5
      AFFF46E6B1FF47E6B0FF46E5AFFF45E5B0FF45E6B1FF46E6B0FF46E6B0FF47E5
      B0FF47E5B1FF47E4B0FF44E1ACFF43DFAAFF40DBA4FF3ED8A0FF3FD89EFF3FD8
      9EFF3ED89EFF3FD89EFF3FD89EFF3FD99FFF3FD89FFF3FD89EFF3FD89FFF40D8
      9FFF40D89EFF40D79EFF3FD79EFF3FD79EFF3ED79EFF3ED69EFF42DAA5FE44DF
      AAFF47E3B0FF48E2B0FF49E4B1FF49E4B1FF49E4B2FF49E4B2FF48E4B0FF49E3
      B0FF49E3B0FF48E3AFFE47E2AEFF47E2AFFF49E3AFFF49E2AFFF48E2AFFF49E2
      B0FF4BE2B1FF5BF4C8FF439E82FF3B6558B90000000000000000000000000000
      00000000000000000000000000000000000000000000445EA09EA5B8DEFFACC7
      E7FE7CA5D4FF8BAFD9FF91B6DDFF95BCE1FF82A4D2FE657CB9FE6873B0FF9193
      C1FFC7C7DCFFE9E9EDFFF5F4F2FFF3F2F1FFEDECEFFFEFF4FFFFD9C3A4FFB881
      11FFC28900FFD9A612FFE7B835FFECC048FFEFC34EFFEFC450FFEEC34FFFEDC2
      4DFFEABF47FFE8BC43FFE3B536FFDAAA23FFCC9A07FFB78200FFAB770BFED3BC
      9FFEF5F9FFFFEEF0F3FFF4F4F2FFF1F1F1FEE1E1E8FFB9BAD3FF868BBCFE6774
      B2FF6A80BCFF83A5D3FF95BADFFF92B5DCFF8BAED6FE80A6D2FFA3C1E4FFAEC3
      E0FF49689DC12020800800000000000000000000000000000000000000000000
      0000877360357B7049FEC8C090FFD6CE9BFFD1C996FFD1C996FFD0C896FFD0C7
      95FFD3CB99FFDDD6A1FFD8D29DFED7D29DFFD7D19CFFD6D19CFFD6CF9AFFD5CF
      99FFD4CF99FFD4CF99FFD4CD97FFD4CD97FED3CD96FED3CD96FFD4CE94FFD7D0
      96FFCCC892FF323329FF26261FFF9C9666FFA8A26AFEA59F67FFB4AD71FF837F
      54FF2D2E24FF212320FF23231EFF5F5C3FFFAFA86DFFADA56BFFA29B65FFA49C
      65FFA29A64FFA19964FFA09762FFA09661FF9E9460FF9E935FFF9D925EFF9C90
      5DFF9B8F5CFF9A8D5BFF9B8E5CFF97865AFF7B6743E963472B12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000F0006875A3A2FFFE4BB
      8BFFC99C66FFA37433FFA97937FFA97937FFA97936FFA97936FFAA7937FFAA79
      36FFA97936FFAA7935FFA97935FFA97935FFA97834FFA87833FFA87833FFA877
      33FFA97833FFA17029FF6C471EFFE7E6E7FEFEFEFEFEFBFAFAFEFFFFFFFFAEA2
      99FF70420EFFAC7930FFA77732FFA87833FFA87833FFA97833FFA87733FFA878
      33FFA77832FFA87732FFA87833FFA87833FFA87834FFA87834FFA87833FFA878
      33FFA97934FFA97834FFA87734FFA87834FFA87733FFA87733FFA77531FFA776
      32FF9F6F2CFFBF9058FFDEB07CFF5A3F2DFF1D0710C400000000000000001B4B
      4341326252FF65C7B3FF77F0DEFF6FEED4FF6DF0D3FF6CF0D2FF6EF0D3FF6CF1
      D3FF6DF1D3FF6CF1D3FF6BF0D1FF6AF0D2FF6CF1D4FF6CF1D4FF6CF0D3FF6CF0
      D2FF6CF0D2FF6BEFD0FF69EECDFF67EFCAFF5BEDC0FF45DDA9FF3ED79EFF40D8
      A0FF40D99FFF40D9A0FF41D9A0FF41D9A0FF40D89FFF40D99FFF41D9A0FF41D9
      A0FF41D89FFF41D89FFF41D89FFF41D89FFF3FD79FFF40D69EFF5FEFC4FF69EF
      CBFF6EEDCFFF6FEFD2FF71F0D3FF71F0D3FF70F1D4FF71F1D3FE70EFD2FF70EF
      D1FF71F0D3FF71F0D3FE70F0D3FF70F1D3FF72F1D6FF71F1D6FF72F1D4FF72F1
      D4FF75F2D5FF79F2D8FF469780FF3A6855BC0000000000000000000000000000
      00000000000000000000000000000000000000000000000080024F62A4B7B2C5
      E1FFBED6EDFF82ABD8FF89AFD9FF8FB2DBFE94B8DEFE9AC1E3FF90B3DCFF7590
      C8FF6376B5FF6B77B2FF888DBCFFAEB0CFFFCECEDEFEE6E5EBFFFBFFFFFFF7ED
      E3FED5AB61FFC48B04FFC48B00FFCB9700FFD4A30CFFD9A91AFFDAAA1DFFDAA9
      1CFFD7A614FFD19E06FFC68F00FFBF8800FFC0880BFED3AB61FEF2E8DDFEF8FB
      FEFEDCDCE8FFC3C4D8FEA2A3C6FF7C83B5FF6874B0FF6579B7FF7A99CCFF93B7
      DEFF99BFE3FF94B7DDFF90B2D9FF8EB0DAFF81A7D4FFB2CCE8FFBCD1E7FF4C62
      9AC90F1E78110000000000000000000000000000000000000000000000000000
      0000876F5B357B714AFFC9C190FFD6CD9BFFD1C996FFD1C996FFD0C896FED1C9
      96FFD0C896FFCFC795FFCFC895FFCFC895FFCDC694FFCDC693FFCCC592FFCCC5
      91FFCBC591FFCBC491FFCAC390FFCAC38FFFC9C28EFFC9C18EFFC8C18CFFCBC3
      8DFFC2BD8BFF32352AFF26261FFF9A9465FFB1AA6EFFAEA86DFF616041FF2425
      20FF222420FF282922FF7F7B53FFB7B073FFA69F67FFA39C65FFA39C65FFA39B
      65FFA19963FFA09862FFA09661FF9F9561FF9E935FFF9D925EFF9B915DFF9B90
      5CFF998E5CFF998C5AFF998C5BFF96855AFF7B6744E760502010000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013000989593B30FFE7BF
      90FFCB9F67FFA67636FFAC7C3AFFAC7C39FFAB7B39FFAB7C39FFAB7C39FFAC7C
      39FFAC7C39FFAB7C39FFAB7C39FFAB7C38FFAC7B38FFAC7B37FFAB7B38FFAB7A
      37FFAB7B37FEA4732DFF714B20FFE8E5E7FFFFFFFFFFFBFBFBFEFFFFFFFFAFA2
      9AFF734510FFAC7A33FFA97935FFAA7935FFA97A36FFAA7A35FFAA7A35FFAA7A
      36FFA97934FFAA7934FFAA7A35FFA97A35FFAA7936FFAA7A36FFAA7936FFAA7A
      35FFAA7A37FFAB7A37FFAA7A36FFAA7A36FFAA7A36FFAA7936FFA97835FFA979
      35FFA1722EFFBF9059FFE0B27FFF5C4130FF1E070EC300000000000000003553
      5F2B376A5BF63C7E69FF3A7A65FF3A7B64FF397F68FF397F68FF388069FF3980
      69FF3B7E66FF3A7F65FF397F68FF3B8067FF3A8067FF3A8168FF3A8269FF3982
      68FF377E67FF387D66FF3A7F67FF346A55FE4EC2A0FE4BE8B4FF3DD49AFF40D7
      9EFF3FD89EFF40D89FFF41D89FFF41D89FFF40D99FFF40D89FFF41D89FFF41D8
      9FFF40D79EFF3FD79DFF41D79EFF40D69EFF3FD59CFF41D79FFF61FACDFF4AA3
      8AFE3F7262FF41826CFF3C806BFF3E816AFF3C856CFF3C856CFF3D836DFF3E83
      6CFF3D856EFF3E846DFF3D856DFF3F866FFF3E8771FF3F8670FF3E846DFF3F84
      6DFF41856EFF43856FFF398D6FFF387A5B970000000000000000000000000000
      00000000000000000000000000000000000000000000000000002449A40E3D5F
      9CC3ADBDDCFFD5E7F7FF93B9E0FF85AED8FF92B5DCFF94B6DDFF97B9DEFF9EC2
      E4FFA0C4E6FF91B2DCFF7A97CAFF6A80BBFF6878B4FF6F79B2FF7D83B6FF979D
      CBFFB1B7DEFFADA2AEFFAA8B68FEAF8735FEBC8710FEBE8908FFBE8705FEBE87
      05FFBB860BFFB58620FFB18B4CFFA58979FFA29AADFF9EA6D2FF8D96C6FE767F
      B2FF6B79B4FF6C80B8FF738BC2FF85A4D2FE97B9DFFF9FC4E5FF9BBFE1FF96B7
      DCFF94B6DCFF93B5DCFF8AAFD9FF8BB2DAFFC6DDF1FFBECDE4FF4A6398C70028
      6B13000000000000000000000000000000000000000000000000000000000000
      0000846D52387D7249FFC9C190FFD5CD9BFFD1C996FFD1C896FFD1C996FFD1C9
      96FFD0C996FFD1C996FFD0C896FFD0C896FFCFC894FFCFC794FFCDC793FFCDC6
      93FFCCC693FFCDC591FFCDC591FFCCC490FFCBC48FFFCBC48FFFCAC38DFFCDC5
      8FFFC4BF8CFF33352BFF25251FFFA6A26EFFA19C68FF41402FFF21221EFF2122
      1EFF3C3B2CFF9B9664FFB3AD70FFA29B65FFA49C65FFA29A64FFA29964FFA199
      63FF9F9762FF9F9761FF9F9560FF9E9460FF9D925FFF9C925EFF9C905DFF9B8F
      5DFF998D5BFF988C5AFF998C5BFF96855AFF7C6544E85A4B1E11000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000140009895A3B30FFE9C2
      94FFCDA26BFFA87938FFAE7E3DFFAE7E3CFFAD7E3CFFAD7E3CFFAD7E3CFFAE7E
      3CFFAE7F3CFFAE7E3CFFAD7D3CFFAD7E3BFFAD7D3BFFAE7D3BFFAD7D3AFFAD7D
      3AFFAE7D39FFA67530FF734E22FFE8E5E7FFFFFFFFFFFCFBFBFFFFFFFFFFB0A3
      9AFF744712FFAE7D35FFAB7B37FFAB7C38FFAB7C38FFAB7C38FFAC7D38FFAC7C
      39FFAC7B37FFAC7C38FFAC7C38FFAC7C38FFAC7C39FFAB7C39FFAC7C38FFAB7C
      38FFAD7C3AFFAD7C39FFAC7C39FFAC7B39FFAC7C39FFAC7C39FFAC7A38FFAB7B
      38FFA37431FFC1925CFFE3B482FF5D4232FF1F070EC400000000000000000000
      00003764642E2A6B5D7932625A7A30645B7B30665C7A32665C7A2E64597B2E61
      597B305F5D7B305F5B7B32645B7B32645B7B3262627A3064617B306A5D7B2E68
      5B7B29665D7B29645D7B3064587F2D5A4BF151BEA2FF4EECB8FF3ED49AFF42D8
      9FFF41D89FFF41D89FFF42D99FFF42D8A0FF42D9A0FF42D9A0FF43D9A0FF42D9
      A0FF42D89FFF41D79FFF43D79FFF43D89FFF41D69EFF43D7A0FE63F9CFFE4C9D
      89FE37605AEF306258802E6761792E66607A34665F7B32665F7B336561793264
      607A3266627A3266607A3269647A3269667A35686478356765793469667A3567
      637C3866667A3168627D337A656D2D7869110000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001717
      8B0B47539EA59BADD3FFE7F3FCFFB5CFEBFE8DB2DBFE8FB4DCFE97B9DFFF97B9
      DEFF98B9DFFE9BBCE1FFA1C3E4FFA4C7E6FFA2C3E5FF98B8DEFF8BA9D4FF7C98
      C9FF7289C1FF6F87C6FF7184CCFE7481C5FE737DB1FE767CAAFF747AA9FE7579
      A6FE7478AEFE727EBBFE7385CAFE768ACAFE788FC8FF7C95C6FF87A5D0FF96B5
      DBFFA0C2E4FFA4C8E8FFA2C6E6FF9EC0E3FF99BBDFFF98B9DEFF97B9DEFF97B9
      DDFF8EB2DBFF89AFD9FFA4C4E4FEDBEBF8FFADBEDDFF4B5A9DBC0F0F78110000
      0000000000000000000000000000000000000000000000000000000000000000
      0000847252387D7349FFCAC292FFD6CD9BFFD1C997FFD2C996FFD2C997FFD1C9
      96FFD1C997FFD1C896FFD0C896FFD0C896FFD0C895FFCFC894FFCEC793FFCEC7
      93FFCDC693FFCDC692FFCDC591FFCCC591FFCCC590FFCBC48FFFCAC38EFFCDC5
      8FFFC3BF8CFF32352BFF2C2C24FF6F6E4DFF302F25FF242520FF20201DFF5957
      3DFFB0AA70FFAEA86EFFA19B65FFA39C65FFA29A64FFA19964FFA19863FFA098
      62FF9F9661FF9E9561FF9D9460FF9D935FFF9C925EFF9B915EFF9B8F5CFF9A8E
      5BFF988C5BFF978B5AFF978A5BFF958359FF7C6443E75A3C0F11000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000016000B895C3E34FFECC5
      97FFD1A671FFAB7D3DFFB18141FFB08140FFB0803FFFB0803FFFB0803FFFB080
      3EFFB0813FFFB1813FFFB0813FFFB0813EFFB0813FFFB0803FFFB0803EFFAF80
      3EFFB0803EFFA77733FF744D21FFE8E4E7FFFFFFFFFFFBF9F9FFFFFFFFFFADA1
      98FF734714FFB3813AFFAE7F3BFFAE7F3CFFAF803DFFAF803DFFAF7F3CFFAF80
      3DFFAF7F3CFFAF7F3CFFAE7E3CFFAF7E3BFFAE7F3CFFAE7E3CFFAF7E3BFFAF7E
      3CFFAF7F3CFFAF7F3CFFAF7E3CFFAF7E3DFEAF7E3CFFAE7E3CFFAE7D3CFFAE7E
      3CFFA67735FFC69661FFE8BA88FF604334FF20030EC200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002C5A44E656C3A6FF53F0BDFF3FD69CFF44D9
      A0FF43D99FFF43D9A0FF44D9A0FF44D9A1FF44DAA1FF44D9A1FF44DAA1FF45D9
      A0FF45D9A0FF44D9A0FF45D9A0FF44D8A0FF43D89FFF45D9A1FF66FAD1FF509F
      8DFF355B57DD0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000031519A8D8094C5FFE3ECF7FFD9E9F7FEA0C1E3FE8BB2DCFF93B7
      DEFF9BBBE0FF9CBDE0FF9DBEE1FF9EBDE1FF9EBEE1FFA0BFE2FFA4C3E4FFA8C7
      E7FFABCBE9FFACCDEAFFAACBE9FFA9C9E8FFABCCEBFFA9CAECFFA6C8EAFFA6C8
      EAFFA9CBEBFFABCCEAFEABCCE8FFAECFEBFFACCDEAFFA9CAE8FFA4C5E5FFA1C1
      E2FF9FBEE0FF9DBDE0FF9CBDE0FF9CBCE0FF9ABADFFF99B9DEFF93B7DDFF8BB2
      DBFF98BCDFFFCDE1F3FFDEECF7FF8C9FC8FF40589A975500D506000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008675523B81774CFFCBC394FFD5CE9CFFD2C997FFD2C997FFD2C997FFD2C9
      97FFD1C896FFD1C996FFD1C996FFD1C896FFD0C895FFD0C895FFCFC794FFCFC7
      94FFCEC693FFCDC692FFCDC692FFCDC592FFCDC592FFCDC591FFCCC490FFCEC7
      91FFC5C08EFF32342AFF2B2B24FF272722FF252520FF282821FF7A764FFFB5AF
      72FFA8A169FFA39C66FFA39C65FFA29B65FFA19963FFA09863FF9F9862FF9F96
      62FF9E9560FF9D9460FF9C935FFF9C925FFF9C905EFF9B905DFF9A8F5CFF998E
      5CFF978C5BFF978A5AFF978959FF958458FF7D6A43E863472B12000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000014000B8A5D3E35FFEDC8
      9BFFD4A976FFAE7F40FFB48444FFB38444FEB28242FFB28342FFB38342FFB283
      42FFB38342FFB38342FFB38242FFB28341FFB38341FFB38241FFB28241FFB182
      40FFB38341FFAB7A36FF764F23FFE9E5E7FFFFFFFFFFFBF9F9FFFFFFFFFFAEA1
      98FF764A16FFB6843EFFB0813DFFB1813EFFB18340FFB28240FFB18240FFB182
      40FFB1823FFFB1813FFFB0813FFFB0813FFFB1803FFFB1813FFFB1813FFFB180
      3FFFB1813FFFB1813FFFB1813FFFB1803FFFB1803FFFB0803FFFB0803FFFB180
      3FFFA97938FFC89A65FFEABC8CFF604334FF1E030FC100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001E5A4B112F5D49E857C3A7FF54F0BEFF41D69DFF45D9
      A1FE44D9A0FF44DAA0FF45D9A1FF46DAA1FF46DAA2FF46DAA2FF46DBA2FF46DA
      A1FF46D9A1FF46DAA1FF46D9A1FF45D9A1FF45D8A0FF47D9A1FF69FBD2FF509F
      8DFF365C57DD2E2E460B00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000037439C586071AFEAC3D1EAFFF0F7FEFFCADDF2FFA0C1
      E3FF93B6DFFF94B7DFFF9BBDE1FF9FBFE1FFA0BFE2FFA1BFE2FFA1C0E2FFA2C0
      E2FFA3C0E3FFA2C0E3FFA3C2E3FFA3C1E3FFA3C1E4FFA4C2E3FFA4C2E3FFA4C2
      E3FFA4C3E4FFA4C2E3FFA3C2E3FFA2C1E2FFA2C1E2FFA1C1E2FFA0C0E1FE9FBF
      E1FF9EBEE1FF9EBEE0FF9DBDE1FF9CBCE0FF94B7DEFF90B4DCFF9DBEE1FFC1D8
      EEFFE8F4FCFFC3D3E8FF6175A8F4424792650000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008271543D82794FFFCDC696FFD6CE9CFFD2C997FFD2C997FFD2CA97FFD2C9
      97FFD1C997FFD1CA96FFD1C996FFD1C996FFD0C896FFD0C896FFD0C793FFCFC7
      93FFCFC693FFCEC693FFCEC692FFCEC592FFCEC692FFCDC591FFCCC490FFCFC7
      91FFC5C08EFF2F3229FF2C2E26FF20211EFF363529FF969161FFB3AD71FFA29C
      66FFA39C66FFA39B65FFA29A64FFA19963FFA09862FFA09762FF9E9661FF9E95
      61FF9D9460FF9C935EFF9C925EFF9B915DFF9A905DFF998E5CFF998E5BFF988D
      5AFF978B5AFF968959FF968759FF938156FF7E6746E870404010000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000150008885F4137FFEECC
      A1FFD7AE7AFFB18345FFB68748FFB68748FFB68747FFB58647FFB58646FFB586
      46FFB58646FFB68646FFB58645FFB58646FFB58645FFB58645FFB48645FFB485
      44FFB58645FFAF7F3AFF785326FFE7E4E6FFFEFDFEFEFAF7F9FEFFFFFFFFB2A4
      99FF7E501AFFB88742FFB38442FFB38542FFB38542FFB48543FFB48543FFB485
      44FFB38443FFB38443FFB38441FFB38341FFB38342FFB38442FFB38442FFB483
      42FFB48443FFB38343FFB38442FFB38443FFB48443FFB38443FFB38242FFB383
      43FFAC7C3BFFCB9E6AFFEBBF8FFF604332FF1E030DC100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001C5555122F5B4AE859C5ABFF59F0BFFF42D69CFF46D9
      A1FF46DAA1FF46DAA2FF47DBA2FF47DBA2FF47DAA2FF47DBA3FF48DBA3FF47DB
      A3FF48DAA3FF48DAA2FF48DAA2FF48DAA2FF46D9A0FF47D9A1FF67FDD2FF529D
      8DFF385A54E13B3B4E0D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000028289F20455EA4A0869CC5FFDAE8F5FFF3FC
      FFFFD4E5F4FFB1CDEAFF9DC1E4FF97BCE1FF9ABDE2FF9FC0E3FFA1C1E3FFA3C1
      E3FFA3C2E3FFA3C2E3FFA4C2E3FFA4C3E4FFA4C3E4FFA4C3E4FFA4C3E3FFA4C3
      E3FFA4C3E3FFA3C3E3FFA4C3E3FFA4C3E4FFA3C3E3FFA2C2E3FFA3C2E3FFA2C1
      E2FF9EBFE2FF9ABDE0FF92B8DEFF95BADFFFA7C6E5FFC8DCF0FFEAF5FCFFDCE8
      F3FF91A4CEFF4E5CA1C42D3E882D000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000079665928746D4AFFC4BC8DFFE1DCA7FFD2CA98FFD2C998FFD2C998FFD2C9
      98FFD2CB98FFD2C997FFD1C997FFD2C997FFD1C996FFD1C896FFD0C895FFD0C8
      95FFCFC794FFCFC794FFCEC793FFCEC692FFCEC692FFCDC591FFCCC590FFCEC5
      90FFD0CA96FF3F3F31FF181916FF54543EFFABA66DFFB0A96EFFA29A65FFA39B
      65FFA29964FFA19863FFA09862FFA09762FF9E9661FF9E9561FF9D9560FF9D94
      5FFF9C925FFF9C925EFF9B915DFF9A905DFF9A8E5CFF998D5BFF988C5AFF988B
      5AFF978B59FF968959FF958759FF957E57FF82674AD96D246D07000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000130008875F4139FFF0CF
      A5FFDAB17FFFB38548FFB98A4BFFB8894BFFB8894BFFB7894AFFB78849FFB789
      49FFB88949FFB88949FFB78849FFB88948FFB78848FFB78848FFB78848FFB688
      47FFB88948FFB1823EFF7B5428FFEAE6E8FFFEFEFEFEFCFAFCFEFFFFFFFFB6A8
      9CFF82531CFFBB8A45FFB58745FFB68845FFB68746FFB68746FFB68747FFB788
      46FFB68746FFB68746FFB58645FFB58645FFB58646FFB58645FFB68645FFB686
      45FFB68746FFB68646FFB68646FFB68646FFB68646FFB58546FFB58545FFB585
      45FFAE7E3EFFCEA16EFFECC193FF5F4434FF1B030BC000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002B635512305B4CE95BC5ACFF5BF0C0FF44D69DFF47DA
      A2FF48DBA3FF48DBA2FF48DBA3FF49DBA3FF48DBA3FF48DCA3FF49DCA4FF49DB
      A3FF49DBA3FF49DBA3FF49DAA4FF49DAA3FF47D9A2FF48DAA2FF6AFDD4FF539D
      8DFF365853E03B274E0D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000026409A445468A8C597A9
      D0FFDBE8F8FFF3FAFFFFE5F0FAFFCBDEF1FFB4CEEAFFA3C3E5FF9CBEE2FF99BC
      E2FF9CBEE2FF9FC0E3FFA1C1E4FFA2C2E4FFA4C3E5FFA5C4E4FFA4C3E4FEA4C3
      E4FFA4C4E4FFA4C4E4FFA4C3E4FFA3C3E4FFA0C1E3FF9DBFE2FF98BDE1FF99BC
      E1FF9CC0E2FFA7C7E5FFBBD4EBFFD9E7F5FFF2F9FFFFE3EEF8FF9CB1D5FF5E68
      A8E53A469F6DFF00FF0200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000001716642AD918557FFC0B788FFDCD5A3FED8D19FFFD2C997FFD3CA
      98FFD3CA98FFD3CA98FFD2C997FFD2C997FFD1C996FFD1C996FFD1C895FFD0C8
      95FFCFC795FFCFC794FFCFC693FFCFC693FFCEC692FFCEC692FFCDC591FFCCC4
      90FFD4CC97FFB9B487FF9D9870FFB8B27BFFA9A26AFFA39D66FEA29B65FFA19A
      64FFA09863FF9F9762FF9F9661FF9E9660FF9E9460FF9D945FFF9C935FFF9C92
      5EFF9B925EFF9A915DFF9A905CFF998F5CFF998D5BFF988C5AFF978B59FF968A
      59FF968A59FF948457FF937E56FF957A54FF8265497400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000140006895E4239FFF4D5
      AEFFDDB685FFB6894CFFBC8E50FFBC8D4FFFBB8D4EFFBB8C4EFFBA8C4DFFBA8C
      4DFFBB8C4DFFBA8C4DFFBA8C4DFFBB8C4DFFBA8B4CFFBA8B4CFFBA8C4CFFBA8B
      4BFFBB8D4CFFB48443FF794F26FFEAE5E7FFFFFFFFFFFFFFFFFFFFFFFFFFAF9C
      90FF86551EFFC0914EFFB88A49FFB98A49FFB98B4BFFBA8B4BFFB98B4BFFB98B
      4AFFB98B49FFB98A4AFFB88949FFB88949FFB88949FFB88949FFB9894AFFB989
      4AFFB98949FFB88949FFB8884AFFB9884AFFB8894AFFB8884AFFB88949FFB888
      49FFB28242FFD1A371FFEFC596FF604636FF1D0109BF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002B636312305F4CE85EC5ADFF5CF2C2FF45D79EFF48DB
      A3FF49DBA3FF49DBA3FF4ADCA4FF4BDCA4FF4ADCA5FF4ADCA4FF4BDCA4FF4ADC
      A4FF4ADCA4FF4ADBA4FF4ADBA4FF4ADBA4FF49D9A2FF49D9A2FF6BFDD4FF519C
      8BFF355953DC5D2E740B00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002B3F
      9C4D556DAABF889EC8FFC9D7EEFFEBF4FCFFF7FCFFFFE8F3FBFFD5E6F4FFC5DB
      F0FFB5D1EBFFABCAE8FFA4C6E6FF9FC4E5FF9FC3E5FF9DC2E4FF9DC1E4FF9DC1
      E4FF9DC3E4FF9DC2E4FF9FC3E4FFA1C5E5FFA6C7E7FFADCCE9FFB9D3ECFFCADE
      F0FFDDEAF6FFEEF7FEFFF2FCFDFFD4E1F0FFA0AFD6FF6776B2E238549A7C4D33
      A614000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000624E3B0D6F6B408C757042FAA19266FFCBC396FFDFD8A5FFD5CD
      9BFFD3CA99FFD3CB99FFD2CA98FFD2CA97FFD2C996FFD1C996FFD1C895FFD0C8
      95FFD0C795FFD0C794FFCFC793FFCFC793FFCFC793FFCFC693FFCDC591FFCDC5
      90FFCBC38FFFD1C993FFD8D097FFA8A16CFFA09963FFA39A65FFA19963FFA098
      62FFA09762FF9F9661FF9E9561FF9E9560FF9D9360FF9C925FFF9B925EFF9B91
      5EFF9B915DFF9A905DFF998E5CFF998D5CFF988B5BFF978B5AFF978C5AFF9589
      5AFF907C57FF927855FF837049E97D6946660000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000130006895D4239FFF6D8
      B3FFDFB989FFB98C4FFFBE9154FFBE9053FFBE8F51FFBD8F51FFBD8F50FFBD8F
      50FFBD8F50FFBD8F50FFBD8F50FFBD8F51FFBD8F4FFFBD8E4FFFBC8F4FFFBC8E
      4FFFBC8E4FFFC19251FE95682FFF845E3BFF886449FE876448FE85634BFF7D52
      2AFFB18343FFBE904FFFBB8D4EFFBB8D4EFFBC8E4FFFBC8E4FFFBC8E4EFFBD8E
      4EFFBC8D4DFFBB8D4DFFBB8D4DFFBB8D4DFFBB8D4DFFBA8C4DFFBB8C4DFFBB8C
      4DFFBB8C4DFFBB8C4DFFBB8C4DFFBB8B4DFFBB8B4DFFBA8B4DFFBA8B4DFFBB8C
      4DFFB58546FFD3A775FFF0C799FF5F4536FF1B0307C000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001E695A112F5F4CE860C6ADFF5FF2C4FF46D89FFF4ADC
      A4FF4ADCA4FF4BDDA5FF4BDDA5FF4CDDA5FF4CDDA6FF4BDDA6FF4CDDA5FF4CDD
      A5FF4BDCA5FF4BDCA5FF4CDCA4FF4CDBA4FF4ADAA3FF4ADAA2FF6EFDD4FF519D
      8BFF335B51DD462E5D0B00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000030409B404C5DA3A76B7CB4EF93A9D1FFC5D6EDFFE4EEF8FFF2F8
      FEFFF5FBFFFFF0F8FDFEE9F2FBFFE2EDF8FFDDE9F7FFD6E5F4FFD4E3F3FFD3E3
      F3FFD4E3F3FFD6E5F4FFDBEAF6FFE2EEF8FFE8F3FBFFF0F8FEFFF3F9FEFFECF5
      FCFFDBE8F5FFB7C6E2FF7C8CBDFF5964A5C135409A604010AF10000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006F6A3F357E6B47BC87764CFFABA174FFD3CC
      9BFFDDD7A4FFD4CC9AFFD3CA98FFD3CB98FFD2CA97FFD2C997FFD1C896FFD1C8
      96FFD0C895FFD0C795FFD0C794FFD0C793FFD0C793FFD0C693FFCEC592FFCDC6
      91FFCCC490FFCBC38FFFCDC691FFA7A16BFFA09862FFA29A64FFA09862FF9F97
      61FF9E9661FF9E9560FF9D9460FF9C935FFF9B925EFF9B925EFF9B915DFF9A90
      5CFF998F5CFF998F5CFF988D5BFF988B5BFF988B5BFF97895BFF938459FF9680
      57FF887050F5896B50866F4E3717000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000130006895D4239FFF6D9
      B5FFE1BC8CFFBB8E52FFC19458FFC19457FFC19357FFC09356FFC09254FFBF92
      54FFC09254FFBF9254FFBF9253FFBF9254FFBF9254FFBF9153FFBF9153FFBF91
      52FFBE9052FFBF9152FFC29454FFAB7C3CFFA37334FFA27334FFA37436FFB98A
      49FFC19353FFBD8E50FFBE9051FFBE9152FFBF9153FFBF9153FFBF9152FFBF90
      52FFBF9052FFBE9052FFBE9052FFBE9052FFBE8F52FFBE8F51FFBE8F51FFBE8F
      51FFBD8F51FFBE8F51FFBE8E51FFBD8E51FFBD8E51FFBD8E51FFBE8E51FFBE8F
      52FFB88A4BFFD6AC7BFFF5CEA3FF5F4537FF1D030BC100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002B635512315F4CE865C8B4FF62F4C7FF47D89FFF4CDC
      A5FF4CDDA5FF4CDDA5FF4CDDA6FF4DDDA6FF4DDEA6FF4DDDA6FF4DDDA6FF4DDD
      A6FF4DDDA6FF4CDDA5FF4DDCA5FF4DDCA5FF4BDBA4FF4CDBA3FF6EFED5FF519F
      8CFF335953E02B2B550C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000311D9D1A204595594365A59C637DB1D07990
      BAF89FB2D6FFBACCE6FFCAD9EEFFDCE9F7FFE4EFF9FFECF5FCFFF0F9FFFFF1FA
      FFFFF0F9FFFFEBF4FBFFE2EDF7FFD9E5F4FFC6D6EBFFB6C5E3FF9AAAD1FF7A8D
      B9F26275AACA4853A1873C38A237000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007A744A5A786C45D68E81
      57FFB8AD7FFFDBD4A3FFDBD4A0FFD2CA98FFD2CA97FFD2C997FFD1C896FFD1C8
      96FFD1C895FFD0C895FFD1C894FFD1C894FFD0C794FFD0C794FFCFC693FFCEC6
      92FFCDC590FFCCC490FFCEC691FFA69E6AFE9E9661FFA19963FF9F9762FF9F96
      61FF9D9560FF9C945FFF9C935EFF9B925EFF9B915EFF9A915DFF9A8F5DFF998E
      5CFF998D5CFF988D5BFF978C5BFF978C5BFF93855BFF96815BFF8C7753FF8374
      48A9796D492A0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000130004895D433BFFF7DB
      B8FFE2BE90FFBD9055FFC4975BFFC3965AFFC3955AFFC3965AFFC29558FFC295
      57FFC29558FFC29558FFC29457FFC29557FFC29558FFC29558FFC19457FFC294
      56FFC19457FFC19456FFC29557FFC7995BFFC7995BFFC7995AFFC59759FFC294
      55FFC09254FFC19354FFC19355FFC19456FFC29456FFC19457FFC19356FFC194
      56FFC29356FFC29356FFC19355FFC19255FFC19256FFC19256FFC19256FFC192
      55FFC09255FFC09154FFC09155FFC09155FFC09155FFC09155FFC09155FFC192
      55FFBA8D4FFFD9AF7FFFF6D1A8FF5F4639FF1D0309C100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002D694B1132614DE968CAB5FF63F4C8FF48D99FFF4DDD
      A6FF4DDDA6FF4EDDA6FF4EDDA7FF4EDEA7FF4EDEA7FF4FDEA7FF4EDEA7FF4EDE
      A7FF4EDDA6FF4EDDA6FF4EDDA6FF4EDCA6FF4DDBA4FF4DDBA4FF71FED7FF519F
      8DFF345953E02B2B550C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000AA032033
      99283E52A757465DA0835465A7A95B73AABE657BAED47083B3E9788BBBEA7A8A
      B8EB7688B8EA6F80B3E6667BADD15A73A5BC4F65A79F41549D7A3E489F4A2C2C
      A71D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000745D460B786E
      48797A6B43EF968B5CFFBFB888FFDCD7A3FED8D09EFFD2C997FFD1C996FFD1C9
      96FFD1C896FFD1C896FFD1C895FFD1C895FFD1C795FFD0C795FFCFC793FFCFC7
      93FFCDC591FFCCC490FFCEC692FFA59E6AFF9E9660FFA09862FF9F9661FF9E95
      60FF9D935FFF9C935EFF9B925EFF9A915EFF9A915DFF9A905CFF988E5CFF988D
      5BFF988C5BFF988D5BFF95885AFF968459FF927D55FF8B6E51C2816348430000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000150006885E443EFFFAE1
      C1FFE5C295FFBF9259FFC5995EFFC5985DFFC6985DFFC5985DFFC4985CFFC598
      5DFFC4985CFFC5985CFFC5995CFFC5985DFFC5985CFFC5985CFFC5985BFFC598
      5BFFC5985CFFC5985CFFC5985CFFC6995DFFC6995EFFC6995DFFC5995BFFC598
      5BFFC4975BFFC5975AFFC4975BFFC5975BFFC5975BFFC5985BFFC4985BFFC496
      5BFFC4965AFFC4965AFFC4965AFFC4965AFFC4965AFFC3965AFFC4965AFFC396
      5AFFC39559FFC39559FFC39559FFC39559FFC39459FFC39558FFC29458FFC494
      59FFBE9054FFDCB587FFF7D5ACFF61483BFF1E0309C100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001E5A3C1131624DE768C7B6FF65F3C9FF49D99FFF4FDE
      A6FF4FDEA6FF4FDDA7FF4FDEA8FF4FDFA8FF4FDFA7FF4FDEA8FF50DEA7FF4FDE
      A7FF4FDDA7FF4FDDA7FF4EDDA6FF4EDCA6FF4DDBA5FF4EDCA5FF76FFDAFF549D
      8CFF335950E02B2B550C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF020000880F000080100000
      87110000801027009D0DFF00FF01000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000070685020716F3C9C7C6E48FFA3976DFFCBC393FFDED7A4FFD4CC9AFFD1C8
      97FFD1C997FFD2C997FFD2C996FFD2C996FFD1C895FFD1C894FFD0C794FFD0C7
      94FFCDC592FFCDC491FFD0C793FFA59E69FF9D9460FFA09662FF9E9560FF9D94
      60FF9C925EFF9B915EFF9B915DFF9A915DFF998F5CFF988E5CFF978D5BFF988D
      5CFF978C5BFF95845AFF96805AFF887551E480734B6600000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000130004885E4540FFFBE3
      C6FFE6C49AFFC1955CFFC79C62FFC89B62FFC79A61FFC79B61FFC79B61FFC79B
      60FFC79B60FFC79B60FFC79B61FFC79B61FFC79B60FFC79B60FFC79B5FFFC79B
      5FFFC89B5FFFC89B60FFC89C60FFC99C61FFC99D62FFC89D63FFC89C61FFC89C
      5FFFC79B5FFFC89B5FFFC79B60FFC79B60FFC89B5FFEC79A60FFC79B5FFFC79A
      5FFFC7995FFFC6995EFFC7995EFFC6995EFFC6985EFFC6985EFFC6995DFFC699
      5EFFC6985DFFC6985DFFC6985DFFC6985DFFC5975DFFC5975DFFC5975DFFC698
      5EFFC29358FFDEB88BFFF8D9B1FF62493CFF1D0107C100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001E5A3C1131614BE86AC8B6FF67F4CAFF4AD99FFF50DE
      A7FF50DEA7FF50DEA7FF50DFA9FF50DFA9FF50DFA8FF51DFA8FF50DFA7FF51DE
      A7FF51DEA8FF51DDA8FF50DDA7FF50DDA7FF4EDBA6FF4FDCA5FF78FEDBFE559D
      8CFF335B52DE402B550C00000000000000000000000000000000000000000000
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
      000000000000000000008670523B7E6C47BA887A4EFFACA174FFD2CA9AFFDCD5
      A2FED2CA98FFD2C997FFD2C997FFD2C997FFD1C996FFD1C895FFD0C895FFD0C8
      95FFCEC693FFCDC591FFD0C793FFA49D69FF9D9560FF9E9661FF9D9360FF9C93
      5FFF9B915EFF9A915EFF9A905DFF99905CFF988E5CFF998E5CFF978C5CFF9586
      5BFF97815AFF8C7150F9876F508C805959140000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000130002885D443EFFFCE7
      CBFFE8C89FFFC3975EFFCA9E65FFCB9E65FFCA9E66FFCB9F66FFCA9E65FFCB9E
      65FFCA9E65FFCA9F65FFCB9F65FFCA9F65FFCA9F65FFCA9F65FFCA9E65FFCA9F
      65FFCA9E64FFCA9F65FFCB9F65FFCBA065FFCBA066FFCBA066FFCB9F64FFCA9F
      65FFCA9F64FFCA9E64FFCA9F64FFCA9E64FFCB9E65FFCA9E64FECA9E64FFCA9E
      64FFCA9D63FFCA9D63FFCA9D62FFC99D63FFC99D63FFC99C63FFC99C62FFC99C
      62FFC99C62FFC99B62FFC89B62FFC89C61FFC89B61FFC89A61FFC99C63FFC99D
      64FFC4975BFFE0BB90FFFCDDB9FF634A3FFF1D0107C000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000396355122F604AE869C8B4FF6CF7CEFF4CDBA1FF50DE
      A8FF51DEA8FF51DFA8FF51DFA9FF52DEA9FF52DFA9FF52E0AAFF52E0A9FF52DF
      A8FF51DFA8FF51DEA8FF51DEA8FF51DEA8FF4FDDA6FF50DDA7FF76FFDDFF559E
      8DFF345850E137245B0E00000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000007C764761767544DD928358FFB6AB
      7FFFD8D3A1FFDBD5A1FFD2CA98FFD2C997FFD1C997FFD1C997FED1C896FFD0C8
      95FFCFC793FFCDC692FFD0C894FFA79F6BFF9D9560FF9F9661FF9D935FFF9C93
      5FFF9A915DFF99915DFF998F5CFF9A8F5CFF9A8F5EFF988A5DFF96805BFF8F77
      55FF85734FB17A604A3000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000130004895C433FFFFCE7
      CEFFE8CAA3FFC69A62FFCDA169FFCDA169FFCDA26AFECDA26AFFCDA16AFFCDA1
      69FFCCA269FFCCA269FFCDA269FFCEA36AFFCDA169FFCDA269FFCDA169FFCDA2
      69FECDA26AFFCDA36AFFCEA369FFCEA36AFFCEA36AFFCEA36AFFCEA269FFCDA2
      69FFCDA268FFCDA268FFCDA269FFCDA26AFFCDA269FFCDA169FFCDA168FFCDA1
      68FFCDA168FFCDA067FFCCA067FFCCA067FFCCA067FFCCA068FFCCA067FFCCA0
      67FFCC9F66FFCB9F66FFCB9F65FFCB9F66FFCB9E66FFCB9E66FFCCA068FFCDA1
      69FFC69A5FFFE4C096FFFDE1BEFF624B40FF1B0005C000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000396355122F604CE96ACAB5FF6EF8D0FF4DDCA2FF51DF
      A8FF52DFA9FF52DFA9FF52E0AAFF52E0AAFF53E0AAFF53E0AAFF54E0AAFF53DF
      AAFF53DFA9FF52DEA8FF52DFA9FF52DEA8FF50DEA7FF52DEA7FF79FFDDFF559E
      8DFF345850E03B27620D00000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000007060301083744A80806B
      47F096895DFFBFB689FFDCD6A3FFD8D19FFFD1C997FFD1CA97FFD1C997FFD0C9
      96FFCFC795FFCEC693FFD1C895FFA69F6BFF9D9460FF9E9660FF9B935FFF9B92
      5EFF9A915EFF99905DFF99905EFF998D5EFF98865DFF947C57FF896F4FC4896B
      4E45000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000170006885F4542FFFCE9
      D1FFE8CCA4FFC2965EFFCB9F66FFCBA066FFCBA067FFCB9F66FFCA9F66FFCBA0
      66FFCBA066FFCBA066FFCBA066FFCBA166FFCCA166FFCBA066FFCB9F66FFCAA0
      66FFCBA166FFCBA066FFCCA267FFCCA267FFCCA269FFCCA268FFCBA267FFCBA1
      67FFCBA066FFCBA065FFCCA167FFCCA066FFCBA065FFCB9F65FFCBA066FFCBA0
      66FFCBA065FFCB9F65FFCA9F65FFCA9F66FFCA9F66FFCA9F66FFCA9E65FFCB9E
      65FFCB9F65FFCB9F64FFC99B61FFC89B62FFC99C63FFC99D63FFCA9D64FFCB9E
      66FFC4975FFFE4C69FFFFFEACDFF654D45FF1D0105BF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001C5555122A5F4DE96CCAB7FF71F7D0FF4DDAA1FF53DE
      A8FF53DFA8FF54E0A8FF54E0AAFF54E0AAFF54E1AAFF54E0AAFF55E0AAFF54E0
      AAFF54DFA9FF53DFA9FF53DFA9FF53DEA8FF51DDA7FF53DEA8FF7CFFDFFF579D
      8DFF365951E04E3B760D00000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000007C64
      4D21786B479D7D6D48FFA09167FFC8C094FFDDD7A4FFD4CD9BFFD1C997FFD1C9
      97FFD0C895FFCEC794FFD1C995FFA69F6BFF9B935FFF9C9460FF9A915EFF9A8F
      5DFF9B905EFF9A905FFF96865EFF98815BFF897451EA846D4E6C0000FF010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000015000486614644FFFFED
      D6FFFCE7CDFFF1DABEFFF3DDC1FFF4DDC0FFF3DCC1FFF3DCC0FFF3DDC0FFF3DD
      C0FFF3DDC1FFF4DDC0FFF3DDC0FFF3DEC0FFF4DFC2FFF3DFC1FFF3DEC2FFF3DE
      C1FFF3DEC1FFF3DEC1FFF4DFC3FFF4DFC1FFF4DFC4FFF4DFC4FFF2DEC2FFF2DE
      C1FFF3DEC1FFF3DEC0FFF3DEC1FFF3DEC0FFF3DFC1FFF3DEC0FFF4DEC1FFF4DE
      C1FFF3DEC2FFF3DEC1FFF3DFC2FFF3DEC1FFF3DDC1FFF3DDC0FFF3DDBFFFF3DD
      BFFFF4DEC2FFF4DEC1FFF3DCBEFFF3DCBEFFF3DDBEFFF3DCBDFFF3DCBFFFF4DD
      BFFFF2DBBDFFFBE3C9FFFFF0D7FF654E48FF190004BF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001C6347122C614DE96DCAB8FF71F7D0FF4EDBA2FF54DE
      A8FF54E0A9FF54E0A9FF55E0ABFF55E0ABFF55E1ABFF55E1ABFE55E1ABFF55E0
      ABFF55E0AAFF54E1AAFF54DFA9FF54DFA9FF52DEA7FF54DEA8FF7EFFE0FF589D
      8FFF355952DF55406A0C00000000000000000000000000000000000000000000
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
      0000000000007C6C4642826A4AC289764FFFAB9E72FFD2CB9BFEDCD6A3FFD2CA
      99FFD0C896FFCFC795FFD1CA97FFA69E6BFF9A915EFF9B935FFF9A905EFF9A91
      5FFF998B5FFF9A875CFF8C7653FF896F4F9E7B614F1D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000160207895B4140FFE3D9
      C6FFE4D5C4FFE4D5C6FFE3D4C6FFE3D4C6FFE3D5C7FFE3D5C6FFE2D5C5FFE2D5
      C5FFE4D6C8FFE4D6C8FFE4D6C8FFE3D6C7FFE4D7C9FFE3D6C8FFE3D6C9FFE3D6
      C8FFE3D6C8FFE3D5C7FFE4D6C8FFE4D6C8FFE4D7C9FFE3D6C8FFE2D5C7FFE3D6
      C7FFE3D7C8FFE3D6C8FFE2D4C5FFE0D3C5FFE3D4C6FFE2D4C5FFE2D4C5FFE1D4
      C4FFE2D6C6FFE3D5C5FFE2D3C4FFE2D3C4FFE2D4C5FFE2D3C5FFE3D5C5FFE3D5
      C5FFE3D5C6FFE3D4C5FFE4D4C5FFE3D3C3FFE3D3C3FFE3D3C2FFE4D3C2FFE3D3
      C1FFE3D4C3FFE2D0BFFFE5D8C5FF5B413FFF1C0103C200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000285E43132D644CE96ACBB6FF6DF7CDFF4BDA9FFF51DE
      A5FF52DFA6FF52DFA7FF52E0A8FF52E0A8FF52E1A9FF51E1A8FF52E1A8FF52E1
      A9FF52E0A8FF52DFA7FF51DEA5FF50DFA5FF4FDDA3FF52DDA5FF7EFFE2FF569D
      8FFF2E5A50DF4040800C00000000000000000000000000000000000000000000
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
      000000000000000000000000000086764A5D806E49DC91815AFFB7AC7EFFD8D2
      A1FFD8D29FFFCFC796FFD2CB99FFA49D6AFF978F5AFF9A925EFF998E5FFF9887
      5DFF96815BFF867750B87773483C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000024091A783C181EFF4329
      25FF3D2622FF3D2721FF3D2622FF3E2722FF3C2722FF3C2621FF3E2822FF3F29
      23FF402B24FF402C24FF402B25FF402B24FF3F2B24FF402B24FF402D25FF402D
      24FF402C25FF402D24FF412E25FF402D25FF422E26FF422E25FF402D24FF402D
      25FF3E2B24FF3F2B23FF412D25FF412D25FF3F2C25FF3F2C25FF402D24FF402C
      24FF3F2B24FF3F2B23FF3F2B23FF3F2C24FF412D25FF412C26FF402C26FF402B
      25FF402B24FF402C24FF402B23FF402A22FF3F2924FF3F2923FF402921FF3F28
      21FF3E2722FF3C2520FF3E2422FF3B151DFF2A0D14A300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000266659142E654EEA6BCAB6FF76FBDAFE58E5B2FF5EE8
      B7FF5EE8B8FF5EE9B8FF5FEABAFF5FEAB9FF5EEABAFF5EEABAFF60E9B9FF60EA
      B9FF60E9B9FF60E8B8FE5EE8B8FF5EE8B8FF5EE6B6FF60E7B8FF83FFE9FF569F
      90FF305B50DF40406A0C00000000000000000000000000000000000000000000
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
      00000000000000000000000000000000000080606010846E568B7D6946F6988A
      60FFC4BB8DFFDAD5A3FED7D09FFFA39C6AFF978E5CFF96885CFF968259FF8E72
      53DF8B6F555A0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003300330F27091A6E1F04
      0C7D1B0608791B0608791B040B791B040D791906087B1B06087A1D060A7A1F08
      0D7A1B08067A1D08087B1B08087B1D080A7A1B080A7B1D0A0A7A1D0A0D7A1D0A
      0A7A1B0A0A7B1B0A087A1D0A0A7A1F080D7A210A0F7B210C0F7B210A0D7A2108
      0A7A1B08087B1D0A087B1F0A0A7C210C0A7B1B0A0C7C1B080C7B1D080A7C1D08
      087B1B080A7C1D080C7B1F0A0C7B1F0A0A7B210A0C7B210A0D7A1D080A7B1D08
      0A7B1D080A7B1F080C7B1B060A7B1E080B791E0808791D08087A1908067A1708
      087A1906067B1906067B1400027E2309167540154A1800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003B6C6C1A2F6B56F26FC4B1FF91FAEEFF8AFBE7FF8BFB
      E8FF8AFBE8FF89FAE8FF89FAE7FF89FAE8FF8AFAE8FF89FAE8FF89FAE8FF8AFA
      E8FF8AF9E6FF8AF8E6FF89FAE8FF8AFAE9FF8AFAE8FF89FAE7FF8BF9EAFF5A9E
      91FF2F624FE7495B490E00000000000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000007C705729796F
      3FA583714BFFA89971FFCDC799FFA09669FF94815AFF877750F583764E7D8050
      6010000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000001C553909387162D6478C79FF478B76FF468A74FF4589
      73FF468A75FF468975FF448977FF448977FF448A75FF448975FF438A76FF4489
      75FF428772FF428772FF418D75FF428C75FF428C75FF438A74FF458972FF4381
      71FF36705FC38040800400000000000000000000000000000000000000000000
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
      0000876E5548816848CB89764EFF897652FF86794FA7857A4B2C000000000000
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
      000000000000000000000000000047637124356864732C635D792D6053782A5F
      527925614F7B2662527A2D6255782C6154792C60547A2C5F517B266150792860
      4F7A2363487C2361497B25614F7B235F4C7C2763527C2763507C2765507C2E6A
      5874356A60180000000000000000000000000000000000000000000000000000
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
      000000000000AA55FF037E6E4C437A6A50300000000000000000000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000000010000C00000000100010000000000001800000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      00000000000000000000000000000000FFFFFFFFC1FFFFFFFFFFFC0FFFFFFFFF
      00000000000000000000000000000000FFFFFFF00007FFFFFFFFE000FFFFFFFF
      00000000000000000000000000000000FFFFFFC00001FFFFFFFFC0003FFFFFFF
      00000000000000000000000000000000FFFFFF0000007FFFFFFF80000FFFFFFF
      00000000000000000000000000000000FFFFFC0000001FFFFFFF000007FFFFFF
      00000000000000000000000000000000FFFFF000000007FFFFFF000003FFFFFF
      00000000000000000000000000000000FFFFE000000003FFFFFE000003FFFFFF
      00000000000000000000000000000000FFFFC000000001FFFFFE000001FFFFFF
      00000000000000000000000000000000FFFF8000000000FFFFFE000001FFFFFF
      00000000000000000000000000000000FFFF00000000007FFFFE000001FFFFFF
      00000000000000000000000000000000FFFE00000000003FFFFE000000FFFFFF
      00000000000000000000000000000000FFFC00000000001FFFFE0000003FFFFF
      00000000000000000000000000000000FFFC00000000001FFFFE0000000FFFFF
      00000000000000000000000000000000FFF800000000000FFFF8000000007FFF
      00000000000000000000000000000000FFF000000000000FFFF0000000001FFF
      00000000000000000000000000000000FFF0000000000007FFE0000000000FFF
      00000000000000000000000000000000FFE0000000000007FFC00000000007FF
      00000000000000000000000000000000FFE0000000000003FFC00000000003FF
      00000000000000000000000000000000FFE0000000000003FFC00000000001FF
      00000000000000000000000000000000FFC0000000000003FFC00000000000FF
      00000000000000000000000000000000FFC0000000000001FFC00000000000FF
      00000000000000000000000000000000FFC0000000000001FFC000000000007F
      00000000000000000000000000000000FFC0000000000001FFC000000000007F
      00000000000000000000000000000000FFC0000000000001FFE000000000003F
      00000000000000000000000000000000FF80000000000001FFE000000000003F
      00000000000000000000000000000000FF80000000000000FFE000000000003F
      00000000000000000000000000000000FF80000000000000FFE000000000003F
      00000000000000000000000000000000FF80000000000000FFE000000000001F
      00000000000000000000000000000000FF80000000000000FFC000000000001F
      00000000000000000000000000000000FF80000000000000FFC000000000001F
      00000000000000000000000000000000FF80000000000000FFC000000000001F
      00000000000000000000000000000000FF80000000000001FFE000000000001F
      00000000000000000000000000000000FFC0000000000001FFE000000000001F
      00000000000000000000000000000000FFC0000000000001FFE000000000001F
      00000000000000000000000000000000FFC0000000000001FFE000000000001F
      00000000000000000000000000000000FFC0000000000001FFE000000000001F
      00000000000000000000000000000000FFE0000000000003FFE000000000001F
      00000000000000000000000000000000FFE0000000000003FFE000000000001F
      00000000000000000000000000000000FFE0000000000003FFF000000000001F
      00000000000000000000000000000000FFF0000000000007FFF000000000001F
      00000000000000000000000000000000FFF0000000000007FFF000000000003F
      00000000000000000000000000000000FFF800000000000FFFF000000000003F
      00000000000000000000000000000000FFF800000000000FFFF800000000003F
      00000000000000000000000000000000FFFC00000000001FFFF800000000007F
      00000000000000000000000000000000FFFC00000000003FFFFC00000000007F
      00000000000000000000000000000000FFFE00000000003FFFFE0000000000FF
      00000000000000000000000000000000FFFF00000000007FFFFE0000000001FF
      00000000000000000000000000000000FFFF8000000000FFFFFF0000000001FF
      00000000000000000000000000000000FFFFC000000001FFFFFF8000000003FF
      00000000000000000000000000000000FFFFE000000003FFFFFFC000000007FF
      00000000000000000000000000000000FFFFF000000007FFFFFFE00000000FFF
      00000000000000000000000000000000FFFFF80000000FFFFFFFF00000001FFF
      00000000000000000000000000000000FFFFFE0000003FFFFFFFF80000007FFF
      00000000000000000000000000000000FFFFFF800000FFFFFFFFFE000000FFFF
      00000000000000000000000000000000FFFFFFE00003FFFFFFFFFF800003FFFF
      00000000000000000000000000000000FFFFFFFC003FFFFFFFFFFFF0001FFFFF
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF01FFFFFF
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFD07FFFFFFFFFF03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE0000001FFFFFFFFE01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFE00000000FFFFFFFFC00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF001FFFFFF
      FFFFE0000000007FFFFFFFC007FFFFFFFFFFFFFFC1FFFFFFFFFFFF00001FFFFF
      FFE000000000003FFFFFFFC003FFFFFFFFFFFFF8000FFFFFFFFFFC000003FFFF
      FFC000000000003FFFFFFFC003FFFFFFFFFFFFC00001FFFFFFFFF0000000FFFF
      FF8000000000003FFFFFFFC003FFFFFFFFFFFF0000007FFFFFFFC00000003FFF
      FF0000000000003FFFFFFF8003FFFFFFFFFFFC0000001FFFFFFF000000001FFF
      FF0000000000003FFFFFFF8001FFFFFFFFFFF00000000FFFFFFE0000000007FF
      FE0000000000001FFFFFFF8001FFFFFFFFFFE000000003FFFFFC0000000003FF
      FE0000000000000FFFFFFF8001FFFFFFFFFFC000000001FFFFF80000000001FF
      FC00000000000007FFFFFF8001FFFFFFFFFF8000000000FFFFF00000000000FF
      FC00000000000007FFFFFF0001FFFFFFFFFF00000000007FFFE000000000007F
      FC00000000000007FFFFFF0001FFFFFFFFFE00000000003FFFC000000000007F
      FC00000000000007FFFFFE0001FFFFFFFFFC00000000003FFF8000000000003F
      FC00000000000007FFFFFE0001FFFFFFFFFC00000000001FFF8000000000001F
      F80000000000000FFFFFFC0003FFFFFFFFF800000000000FFF0000000000001F
      F800000000000007FFFFF80003FFFFFFFFF800000000000FFF0000000000000F
      F800000000000003FFFFF00003FFFFFFFFF0000000000007FE0000000000000F
      F800000000000001FFFFE000020007FFFFF0000000000007FE00000000000007
      F800000000000001FFFF8000000001FFFFE0000000000003FE00000000000007
      F800000000000001FFFF00000000007FFFE0000000000003FC00000000000003
      F800000000000001FFFC00000000003FFFE0000000000003FC00000000000003
      F800000000000001FFE000000000003FFFC0000000000001FC00000000000003
      FC00000000000003FF8000000000003FFFC0000000000001F800000000000003
      FC00000000000003FE0000000000003FFFC0000000000001F800000000000003
      FC00000000000007FC0000000000003FFFC0000000000001F800000000000001
      FC0000000000000FF80000000000003FFFC0000000000001F800000000000001
      FE00000000000007F80000000000003FFFC0000000000001F800000000000001
      FE00000000000003F80000000000007FFFC0000000000000F800000000000001
      FF00000000000003F80000000000001FFFC0000000000000F800000000000001
      FF80000000000003F80000000000001FFFC0000000000000F800000000000001
      FFE0000000000003F00000000000000FFFC0000000000001F800000000000001
      FFFC000000000003F00000000000000FFFC0000000000001F800000000000003
      FFFFC00000000007F00000000000000FFFC0000000000001FC00000000000003
      FFFFF0000000000FF00000000000000FFFC0000000000001FC00000000000003
      FFFFFC000000001FF00000000000000FFFC0000000000001FC00000000000003
      FFFFFE000000007FF00000000000000FFFC0000000000001FC00000000000003
      FFFFFF80001FFFFFF00000000000001FFFE0000000000003FE00000000000007
      FFFFFFC0003FFFFFF00000000000001FFFE0000000000003FE00000000000007
      FFFFFFE0003FFFFFF00000000000003FFFE0000000000003FE0000000000000F
      FFFFFFE0001FFFFFF00000000000001FFFF0000000000007FF0000000000000F
      FFFFFFF0001FFFFFF00000000000001FFFF0000000000007FF0000000000001F
      FFFFFFF8001FFFFFF00000000000001FFFF800000000000FFF8000000000001F
      FFFFFFF8000FFFFFF00000000000001FFFF800000000000FFF8000000000003F
      FFFFFFF8000FFFFFF00000000000001FFFFC00000000001FFFC000000000003F
      FFFFFFFC000FFFFFF00000000000001FFFFE00000000003FFFE000000000007F
      FFFFFFFC000FFFFFF80000000000003FFFFF00000000003FFFF00000000000FF
      FFFFFFFC000FFFFFF80000000000003FFFFF00000000007FFFF80000000001FF
      FFFFFFFE000FFFFFF80000000000007FFFFF8000000000FFFFFC0000000003FF
      FFFFFFFE000FFFFFFC0000000000007FFFFFC000000001FFFFFE0000000007FF
      FFFFFFFE000FFFFFFE0000000000007FFFFFF000000007FFFFFF000000000FFF
      FFFFFFFE000FFFFFFF8000000000007FFFFFF80000000FFFFFFF800000003FFF
      FFFFFFFE001FFFFFFFFC00000000007FFFFFFE0000003FFFFFFFE00000007FFF
      FFFFFFFE001FFFFFFFFF00000000007FFFFFFF0000007FFFFFFFF8000001FFFF
      FFFFFFFE003FFFFFFFFFE0000000007FFFFFFFE00003FFFFFFFFFE00000FFFFF
      FFFFFFFF007FFFFFFFFFFE00000000FFFFFFFFFC001FFFFFFFFFFFE0007FFFFF
      FFFFFFFF00FFFFFFFFFFFFFC000001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF83FFFFFFFFFFFFFFFE0007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE000007FFFF
      FFFFFFFFFFFFFFFFFFFFFFF07FFFFFFFFFC00000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFFE01FFFFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFF8007FFFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFE0001FFFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFC0000FFFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFF000003FFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFC000000FFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFF00000003FFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFE00000000FFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFF8000000007FFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFE0000000001FFFFF800000000000000000000000000000
      FFFFFFF0001FFFFFFF800000000007FFFF800000000000000000000000000000
      FFFFFE000001FFFFFF000000000003FFFF800000000000000000000000000000
      FFFFF00000003FFFFC000000000000FFFF800000000000000000000000000000
      FFFFC00000000FFFF80000000000007FFF800000000000000000000000000000
      FFFF0000000003FFF00000000000003FFF800000000000000000000000000000
      FFFC0000000000FFF00000000000003FFF800000000000000000000000000000
      FFF000000000003FF00000000000003FFF800000000000000000000000000000
      FFE000000000001FF00000000000003FFF800000000000000000000000000000
      FFC0000000000007F00000000000003FFF800000000000000000000000000000
      FF00000000000003F00000000000003FFF800000000000000000000000000000
      FE00000000000001F00000000000003FFF800000000000000000000000000000
      FC00000000000000F00000000000003FFF800000000000000000000000000000
      FC00000000000000700000000000003FFF800000000000000000000000000000
      F800000000000000300000000000003FFF800000000000000000000000000000
      F000000000000000300000000000003FFF800000000000000000000000000000
      E000000000000000100000000000003FFF800000000000000000000000000000
      E000000000000000100000000000003FFF800000000000000000000000000000
      E000000000000000100000000000003FFF800000000000000000000000000000
      E000000000000000100000000000003FFF800000000000000000000000000000
      F000000000000000300000000000003FFF800000000000000000000000000000
      F000000000000000300000000000003FFF800000000000000000000000000000
      F800000000000000700000000000003FFF800000000000000000000000000000
      FC00000000000000700000000000003FFF800000000000000000000000000000
      FC00000000000000F00000000000003FFF800000000000000000000000000000
      FE00000000000001F00000000000003FFF800000000000000000000000000000
      FF00000000000003F00000000000003FFF800000000000000000000000000000
      FF80000000000003F00000000000003FFF800000000000000000000000000000
      FF80000000000007F00000000000003FFF800000000000000000000000000000
      FFC000000000000FF00000000000003FFF800000000000000000000000000000
      FFE000000000001FF00000000000003FFF800000000000000000000000000000
      FFF800000000003FF00000000000003FFF800000000000000000000000000000
      FFFC0000000000FFF00000000000003FFF800000000000000000000000000000
      FFFE0000000001FFF00000000000003FFF800000000000000000000000000000
      FFFF8000000003FFF00000000000007FFF800000000000000000000000000000
      FFFFE00000000FFFF8000000000000FFFF800000000000000000000000000000
      FFFFF80000003FFFFE000000000001FFFF800000000000000000000000000000
      FFFFFE000001FFFFFF800000000007FFFF800000000000000000000000000000
      FFFFFFC0000FFFFFFFC0000000001FFFFF800000000000000000000000000000
      FFFFFFFF01FFFFFFFFF0000000007FFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFC00000000FFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFF00000003FFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFF8000000FFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFE000001FFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFF800007FFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFE0001FFFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFF0007FFFFFFFF800000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFFC00FFFFFFFFFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFFFFFFFFFFFFFFF03FFFFFFFFFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFFFFFFFFFFFFFFF8FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
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
