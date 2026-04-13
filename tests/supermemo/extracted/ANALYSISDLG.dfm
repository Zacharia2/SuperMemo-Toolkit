object AnalysisDlg: TAnalysisDlg
  Left = 405
  Top = 192
  HelpContext = 5
  Margins.Left = 8
  Margins.Top = 8
  Margins.Right = 8
  Margins.Bottom = 8
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Analysis'
  ClientHeight = 990
  ClientWidth = 1674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'System'
  Font.Style = []
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 20
  object Notebook: TPageControl
    Left = 0
    Top = 0
    Width = 1674
    Height = 894
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ActivePage = TabFC17
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = NotebookChange
    object TabUse: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Use'
      object UsePaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 735
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        OnMouseDown = UsePaintBoxMouseDown
        OnMouseMove = UsePaintBoxMouseMove
        OnMouseUp = UsePaintBoxMouseUp
        OnPaint = UsePaintBoxPaint
        ExplicitWidth = 1650
        ExplicitHeight = 750
      end
      object CatSet: TTabControl
        Left = 0
        Top = 735
        Width = 1666
        Height = 60
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Tabs.Strings = (
          'Work done'
          'Outstanding'
          'Burden'
          'Element count'
          'Memorized'
          'Newly memorized'
          'Efficiency'
          'Overload'
          'Priority protection')
        TabIndex = 0
        OnChange = CatSetClick
      end
      object UseSet: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = UseSetClick
      end
    end
    object TabFC17: TTabSheet
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Caption = '&Forgetting'
      object Curve17PaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 735
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alClient
        OnMouseMove = Curve17PaintBoxMouseMove
        OnPaint = Curve17PaintBoxPaint
        ExplicitWidth = 1662
        ExplicitHeight = 732
      end
      object StabTab: TTabControl
        Left = 0
        Top = 735
        Width = 1666
        Height = 60
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alBottom
        TabOrder = 0
        Tabs.Strings = (
          'Stability: new'
          '2 days'
          '3 days'
          '9 days'
          '26'
          '58'
          '109'
          '184'
          '287'
          '421'
          '592'
          '804'
          '1059'
          '4 y.'
          '5 y.'
          '6 y.'
          '7 y.'
          '8 y.'
          '10 y.'
          '12 y.'
          '14y+')
        TabIndex = 0
        OnChange = StabTabChange
      end
      object DiffTab: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alBottom
        TabOrder = 1
        Tabs.Strings = (
          'Difficulty=0'
          '0.05'
          '0.11'
          '0.16'
          '0.21'
          '0.26'
          '0.32'
          '0.37'
          '0.42'
          '0.47'
          '0.53'
          '0.58'
          '0.63'
          '0.68'
          '0.74'
          '0.79'
          '0.84'
          '0.89'
          '0.95'
          'Hardest')
        TabIndex = 0
        OnChange = DiffTabChange
      end
    end
    object TabFC15: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Forgetting (UF)'
      object CurvePaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 675
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        OnPaint = CurvePaintBoxPaint
        ExplicitWidth = 1662
        ExplicitHeight = 672
      end
      object RepTabSet: TTabControl
        Left = 0
        Top = 735
        Width = 1666
        Height = 60
        Hint = 
          'Switch between forgetting curves for different repetition catego' +
          'ries, A-Factors or lapses'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ParentCustomHint = False
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Tabs.Strings = (
          'Repetition: 1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10'
          '11'
          '12'
          '13'
          '14'
          '15'
          '16'
          '17'
          '18'
          '19'
          '20'
          'All Reps')
        TabIndex = 0
        OnChange = RepTabSetChange
      end
      object LapsesTabSet: TTabControl
        Left = 0
        Top = 675
        Width = 1666
        Height = 60
        Hint = 
          'Switch between forgetting curves for different repetition catego' +
          'ries, A-Factors or lapses'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ParentCustomHint = False
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Tabs.Strings = (
          'Lapses: 0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10'
          'All Lapses')
        TabIndex = 0
        OnChange = LapsesTabSetChange
      end
      object AFTabSet: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Hint = 
          'Switch between forgetting curves for different repetition catego' +
          'ries, A-Factors or lapses'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ParentCustomHint = False
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Tabs.Strings = (
          'A-Factor: 1.2'
          '1.5'
          '1.8'
          '2.1'
          '2.4'
          '2.7'
          '3.0'
          '3.3'
          '3.6'
          '3.9'
          '4.2'
          '4.5'
          '4.8'
          '5.1'
          '5.4'
          '5.7'
          '6.0'
          '6.3'
          '6.6'
          '6.9'
          'All AFs')
        TabIndex = 0
        Visible = False
        OnChange = AFTabSetChange
      end
    end
    object TabFCPL: TTabSheet
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Caption = 'Forgetting (PLS)'
      object ForgettingPLSBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 735
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alClient
        OnPaint = ForgettingPLSBoxPaint
        ExplicitWidth = 1662
        ExplicitHeight = 732
      end
      object LapsTab: TTabControl
        Left = 0
        Top = 735
        Width = 1666
        Height = 60
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alBottom
        TabOrder = 0
        Tabs.Strings = (
          'Laps=1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10'
          '11'
          '12'
          '13'
          '14'
          '15'
          '16'
          '17'
          '18'
          '19'
          '20')
        TabIndex = 0
        OnChange = LapsTabChange
      end
      object RTab: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alBottom
        TabOrder = 1
        Tabs.Strings = (
          'R=0.00'
          '0.23'
          '0.37'
          '0.46'
          '0.54'
          '0.60'
          '0.65'
          '0.69'
          '0.73'
          '0.77'
          '0.80'
          '0.83'
          '0.86'
          '0.88'
          '0.90'
          '0.93'
          '0.95'
          '0.96'
          '0.98'
          '1.00')
        TabIndex = 0
        OnChange = RTabChange
      end
    end
    object TabStabilization: TTabSheet
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Caption = 'Stabiliz.'
      object StabilizationPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 735
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alClient
        OnPaint = StabilizationPaintBoxPaint
        ExplicitWidth = 1662
        ExplicitHeight = 732
      end
      object SStabTab: TTabControl
        Left = 0
        Top = 735
        Width = 1666
        Height = 60
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alBottom
        TabOrder = 0
        Tabs.Strings = (
          '2 days'
          '3 days'
          '9 days'
          '26'
          '58'
          '109'
          '184'
          '287'
          '421'
          '592'
          '804'
          '1059'
          '4 y.'
          '5 y.'
          '6 y.'
          '7 y.'
          '8 y.'
          '10 y.'
          '12 y.'
          '14y+')
        TabIndex = 0
        OnChange = SDiffTabChange
      end
      object SDiffTab: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alBottom
        TabOrder = 1
        Tabs.Strings = (
          'Difficulty=0'
          '0.05'
          '0.11'
          '0.16'
          '0.21'
          '0.26'
          '0.32'
          '0.37'
          '0.42'
          '0.47'
          '0.53'
          '0.58'
          '0.63'
          '0.68'
          '0.74'
          '0.79'
          '0.84'
          '0.89'
          '0.95'
          'Hardest')
        TabIndex = 0
        OnChange = SDiffTabChange
      end
    end
    object TabGraphs: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Graphs'
      object GraphPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 795
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        OnPaint = GraphPaintBoxPaint
        ExplicitWidth = 1650
        ExplicitHeight = 825
      end
      object GraphTabset: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Tabs.Strings = (
          'Forgetting Index vs. Priority'
          'First Interval'
          'D-Factor vs. A-Factor'
          'First Grade vs. A-Factor'
          'Grade vs. Forgetting Index')
        TabIndex = 0
        OnChange = GraphTabsetClick
      end
    end
    object TabDistr: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Distributions'
      object DistrPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 795
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        OnPaint = DistrPaintBoxPaint
        ExplicitWidth = 1662
        ExplicitHeight = 792
      end
      object DistrTabs: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        HotTrack = True
        MultiLine = True
        RaggedRight = True
        Style = tsButtons
        TabOrder = 0
        Tabs.Strings = (
          'Intervals'
          'A-Factors'
          'Difficulties'
          'Repetitions'
          'Lapses')
        TabIndex = 0
        OnChange = DistrTabsChange
      end
    end
    object Tab3DCurves: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '3-D &Curves'
      object Curve3DPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 795
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        OnPaint = Curve3DPaintBoxPaint
        ExplicitWidth = 1650
        ExplicitHeight = 825
      end
      object AF3DTabSet: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Tabs.Strings = (
          'A-Factor: 1.2'
          '1.5'
          '1.8'
          '2.1'
          '2.4'
          '2.7'
          '3.0'
          '3.3'
          '3.6'
          '3.9'
          '4.2'
          '4.5'
          '4.8'
          '5.1'
          '5.4'
          '5.7'
          '6.0'
          '6.3'
          '6.6'
          '6.9')
        TabIndex = 0
        OnChange = AF3DTabSetChange
      end
    end
    object Tab3DGraphs: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&3-D Graphs'
      object PaintBox3D: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 795
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        OnPaint = PaintBox3DPaint
        ExplicitWidth = 1650
        ExplicitHeight = 825
      end
      object ThreeDTabSet: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Tabs.Strings = (
          'R-Factor Matrix'
          'O-Factor Matrix'
          'Cases')
        TabIndex = 0
        OnChange = ThreeDTabSetClick
      end
    end
    object TabSincDecay: TTabSheet
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Caption = '&S. decay'
      object SIncDecayPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 795
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alClient
        OnPaint = SIncDecayPaintBoxPaint
        ExplicitWidth = 1662
        ExplicitHeight = 792
      end
      object SIncDecayTabs: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alBottom
        TabOrder = 0
        Tabs.Strings = (
          'Difficulty=0'
          '0.05'
          '0.11'
          '0.16'
          '0.21'
          '0.26'
          '0.32'
          '0.37'
          '0.42'
          '0.47'
          '0.53'
          '0.58'
          '0.63'
          '0.68'
          '0.74'
          '0.79'
          '0.84'
          '0.89'
          '0.95'
          'Hardest')
        TabIndex = 0
        OnChange = SIncDecayTabsChange
      end
    end
    object TabOFDecay: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&OF decay'
      object OFDecayPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 795
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        OnPaint = OFDecayPaintBoxPaint
        ExplicitWidth = 1650
        ExplicitHeight = 825
      end
      object OFDecayTabs: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Tabs.Strings = (
          '1.2'
          '1.5'
          '1.8'
          '2.1'
          '2.4'
          '2.7'
          '3.0'
          '3.3'
          '3.6'
          '3.9'
          '4.2'
          '4.5'
          '4.8'
          '5.1'
          '5.4'
          '5.7'
          '6.0'
          '6.3'
          '6.6'
          '6.9')
        TabIndex = 0
        OnChange = OFDecayTabsClick
      end
    end
    object TabMatrices: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Matrices'
      object RecallPaint: TPaintBox
        Left = 948
        Top = 360
        Width = 374
        Height = 242
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        OnDblClick = RecallPaintDblClick
        OnMouseDown = RecallPaintMouseDown
        OnPaint = MatrixPaint
      end
      object MatrixTabs: TTabControl
        Left = 0
        Top = 795
        Width = 1666
        Height = 60
        Hint = 'Matrix data describing the status of memory and the algorithm'
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alBottom
        TabOrder = 0
        Tabs.Strings = (
          'Recall'
          'Metric'
          'Cases'
          'R90'
          'SInc'
          'Intervals'
          'R-Factors'
          'O-Factors'
          'RF cases')
        TabIndex = 0
        OnChange = MatrixTabSetClick
      end
    end
    object TabMetrics: TTabSheet
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Caption = '&Metrics'
      object MetricPaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 1666
        Height = 855
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alClient
        OnPaint = MetricPaintBoxPaint
        ExplicitWidth = 1650
        ExplicitHeight = 1260
      end
    end
  end
  object Bottom: TPanel
    Left = 0
    Top = 894
    Width = 1674
    Height = 96
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    TabOrder = 1
    object ViewMode: TSpeedButton
      Left = 1230
      Top = 17
      Width = 47
      Height = 39
      Hint = 'Switch display mode: all, topics, or items'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002A2A2A00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0073737300C4C5C700DADCDD00E2E4E400E0E1
        E100CFD1D1009193930038383800FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00B1B3B500D5D8D800F1F0F300CDC0ED00AD9EDC00E2DB
        F300F7F5F900F1F2F200D5D8D80093939600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00BABDBF00D8DADB00F9F9F900C0B0E0006039B800382672007762
        B200D0C8E100FEFEFE00FAFBFB00C4C6C7004C4C4C00FF00FF00FF00FF00FF00
        FF00AAACAC00CDCFD000F6F7F700FEFEFE008877B10044278600151416007765
        9D0071638A00F4F4F400BEC0C10081818100FF00FF00FF00FF00FF00FF003F3F
        3F00CED0D100A6A8A900C8C8C800F4F4F400A598BB0047259200341F75003925
        650058545D008182820084848700FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF004C4C4C00B0B2B400B7B9BA008D8F8F00757676003B373F00201D26003433
        37007376760072727200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF003F3F3F0081848400A8AAAC009DA0A000959799007D81
        8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = ViewModeClick
    end
    object XYLabel: TLabel
      Left = 1283
      Top = 17
      Width = 22
      Height = 20
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'XY'
    end
    object OK: TBitBtn
      Left = 456
      Top = 9
      Width = 224
      Height = 72
      Hint = 'Close Analysis (Esc)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Cancel = True
      Caption = 'Close'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 0
      OnClick = OKClick
    end
    object HelpBtn: TBitBtn
      Left = 681
      Top = 9
      Width = 224
      Height = 72
      HelpContext = 5
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Kind = bkHelp
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 1
    end
    object Rotate: TBitBtn
      Left = 231
      Top = 9
      Width = 224
      Height = 72
      Hint = 'Rotate 3-D graphs'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Rotate'
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = RotateClick
    end
    object Smooth: TBitBtn
      Left = 9
      Top = 9
      Width = 224
      Height = 72
      Hint = 
        'Smooth by averaging across Z-values (i.e. repetition number by d' +
        'efault)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Smooth'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000098640A9F6A0A9F6A0A9F6A0A9F6A0A9F6B0CA26F13A4
        741CA87A27AB8134AF8840B3904FB8985EBDA16FBCA171946208D0A533D08612
        D08612D08612D08612D08612D08612D08612D08612D08612D08612D08612D086
        12D08612D086129F690AEAD7A3FDFAF5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD086129F6A0A7BB5EC0B77DC
        78B4EBEDF0F1F8F8F8DDDDDDF7F7F7DCDCDCF7FAFB7BB5EC0B77DC78B4EBF8F8
        F8FFFFFFD086129F6A0A0C78DCBEDBF60875DBF9FDFEBED8E2BFBFBFDDDDDDA4
        BEC7F6FCFE0C78DCBEDBF60875DBFEFEFEFFFFFFD086129F6A0A7CB6EC0C78DC
        78B4EB2EC0F52EC0F599D2E7AAE3F799D2E72EC0F57CB6EC0C78DC78B4EB2EC0
        F5FFFFFFD086129F6A0AEBDAAAFDFAF6FFFFFFB5C0C42EC0F52EC0F5F6FCFF2E
        C0F52EC0F5E2E2E2FDFDFDB7E1F154CCF72EC0F5FDFAF6D5BE95DDBE6CDDA753
        FFFFFFE1E1E1FDFEFE7BB5EC0B77DC78B4EBFDFDFDDFDFDFF9F9F9DDDEDEC2EC
        FB7BB5EC0B77DC78B4EBDEC070DDA754FFFFFFB7B7B7FEFEFE0C78DCBEDBF608
        75DBFEFEFEBFBFBFDEDEDEBFBFBFFDFDFD0C78DCBEDBF60875DBE0C477DDA955
        FFFFFFE1E1E1FEFEFE7CB6EC0C78DC78B4EBFDFDFDE0E0E0FAFAFADEDEDEFCFC
        FC7CB6EC0C78DC78B4EBE4CB88DDA956FFFFFFC0C0C0E4E4E4E8E8E8FEFEFEE8
        E8E8E4E4E4CDCDCDDFDFDFCCCCCCE1E1E1FFFFFFFDFAF6DECCABE7D297DFAB5B
        FFFFFFFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFBFBFBFBFBFAFAFAFAFA
        FAFFFFFFDBA24AB9934EEBD8A7EED4ACE6BE80E6C084E4B876DFAD5FDEA959DE
        A959DDA756DDA756DDA754DDA652DDA551DDA450E7C38BBC9754ECDDB2FAF2E6
        F8EEDCF5E8CFF3E2C3F1DEBAF1DCB5F1DCB5F1DCB5F0DBB4F0DBB4F0DAB4F0DA
        B2EFDAB2EFDAB1BD9A59EEE0BAECDEB3EBD9AAE8D49DE6CE90E3C986E2C77FE2
        C77FE2C67EE2C67EE1C67DE1C67DE0C57CE0C57BE0C47BE0C578}
      TabOrder = 4
      OnClick = SmoothClick
    end
    object ViewCombo: TComboBox
      Left = 990
      Top = 17
      Width = 234
      Height = 28
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabOrder = 3
      Text = 'All elements'
      OnChange = ViewComboChange
      Items.Strings = (
        'All elements'
        'Items only'
        'Topics only')
    end
  end
  object PopupMenu1: TPopupMenu
    Images = AboutBox.VirtualImageList32
    Left = 640
    Top = 156
    object MINext: TMenuItem
      Caption = '&Next'
      Hint = 'Next tab'
      ShortCut = 16393
      OnClick = MINextClick
    end
    object MIPrevious: TMenuItem
      Caption = '&Previous'
      Hint = 'Previous tab'
      ShortCut = 24585
      OnClick = MIPreviousClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object MINextSecondary: TMenuItem
      Caption = 'Next secondary'
      Hint = 'Next tab in the secondary row'
      ShortCut = 9
      OnClick = MINextSecondaryClick
    end
    object MIPreviousSecondary: TMenuItem
      Caption = 'Previous secondary'
      Hint = 'Previous tab in the secondary row'
      ShortCut = 8201
      OnClick = MIPreviousSecondaryClick
    end
    object N2: TMenuItem
      Caption = '-'
      Hint = '-'
    end
    object Cutoffleft1: TMenuItem
      Caption = 'Cut off left'
      ShortCut = 16423
      OnClick = Cutoffleft1Click
    end
    object Cutoffright1: TMenuItem
      Caption = 'Cut off right'
      ShortCut = 16421
      OnClick = Cutoffright1Click
    end
    object Cutofftop1: TMenuItem
      Caption = 'Cut off top'
      ShortCut = 16424
      OnClick = Cutofftop1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MIExport: TMenuItem
      Caption = 'Export'
      Hint = 'Export the displayed statistic'
      OnClick = MIExportClick
    end
    object Import1: TMenuItem
      Caption = 'Import'
      OnClick = Import1Click
    end
    object MISimulate: TMenuItem
      Caption = 'Simulate'
      Enabled = False
      Hint = 
        'Simulate the stochastic choice of the first interval for flat cu' +
        'rves'
      OnClick = MISimulateClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MIClose: TMenuItem
      Caption = '&Close'
      Hint = 'Close the analysis window'
      ShortCut = 27
      OnClick = MICloseClick
    end
    object N3: TMenuItem
      Caption = '-'
      Visible = False
    end
    object InvDistributions1: TMenuItem
      Caption = 'Inv: Distributions'
      ShortCut = 32836
      Visible = False
      OnClick = InvDistributions1Click
    end
    object Inv3DCurves1: TMenuItem
      Caption = 'Inv: 3D Curves'
      ShortCut = 32835
      Visible = False
      OnClick = Inv3DCurves1Click
    end
    object Invapproximations1: TMenuItem
      Caption = 'Inv: approximations'
      ShortCut = 32833
      Visible = False
      OnClick = Invapproximations1Click
    end
    object InvUse1: TMenuItem
      Caption = 'Inv: Use '
      ShortCut = 32853
      Visible = False
      OnClick = InvUse1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 776
    Top = 168
  end
end
