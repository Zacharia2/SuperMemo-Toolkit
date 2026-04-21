object StatBar: TStatBar
  Left = 378
  Top = 229
  Align = alBottom
  AutoSize = True
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 30
  ClientWidth = 878
  Color = clBtnFace
  TransparentColorValue = clRed
  DragKind = dkDock
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = False
  StyleElements = []
  OnCreate = FormCreate
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object StatusPanel: TPanel
    Left = 0
    Top = 0
    Width = 878
    Height = 30
    Hint = 'Status bar'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    AutoSize = True
    BorderStyle = bsSingle
    DockSite = True
    DragKind = dkDock
    Locked = True
    TabOrder = 0
    object OutstandingBar: TPaintBox
      Left = 340
      Top = 1
      Width = 200
      Height = 24
      Hint = 
        'Proportion of outstanding items and items scheduled for final dr' +
        'ill among all items scheduled for today'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      OnPaint = OutstandingBarPaint
    end
    object MemorizedLabel: TPanel
      Left = 1
      Top = 1
      Width = 150
      Height = 24
      Hint = 'Number of memorized items and topics in the collection'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 0
      StyleElements = []
    end
    object OutstandingLabel: TPanel
      Left = 151
      Top = 1
      Width = 189
      Height = 24
      Hint = 
        'Outstanding items, topics and final drill items (if any) within ' +
        'the total outstanding at the beginning of the day'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 1
      StyleElements = []
    end
    object Hinter: TPanel
      Left = 540
      Top = 1
      Width = 189
      Height = 24
      Hint = 'Hint area for menus, statistics, parameters, buttons, etc.'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taLeftJustify
      AutoSize = True
      BevelInner = bvLowered
      BevelOuter = bvLowered
      BorderStyle = bsSingle
      Color = clYellow
      Ctl3D = True
      UseDockManager = False
      Locked = True
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 2
      OnDblClick = HinterDblClick
    end
  end
end
