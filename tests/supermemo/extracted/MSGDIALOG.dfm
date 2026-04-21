object MsgDialog: TMsgDialog
  Left = 381
  Top = 210
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Message'
  ClientHeight = 407
  ClientWidth = 1469
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  KeyPreview = True
  StyleElements = []
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 28
  object MsgLabel: TLabel
    Left = 30
    Top = 30
    Width = 1409
    Height = 185
    Alignment = taCenter
    AutoSize = False
    Caption = 'Message'
    ShowAccelChar = False
    Layout = tlCenter
    StyleElements = [seBorder]
    OnMouseDown = MsgLabelMouseDown
  end
  object ToolBar1: TToolBar
    AlignWithMargins = True
    Left = 5
    Top = 328
    Width = 1459
    Height = 74
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ParentCustomHint = False
    Align = alBottom
    AutoSize = True
    ButtonHeight = 70
    ButtonWidth = 139
    DoubleBuffered = False
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    Images = AboutBox.VirtualImageList64
    List = True
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = False
    TabOrder = 0
    Transparent = False
    Wrapable = False
    object Ok: TToolButton
      AlignWithMargins = True
      Left = 0
      Top = 0
      Hint = 'Close this message'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  &OK  '
      ImageIndex = 72
      ImageName = 'icon_072'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = OkClick
    end
    object Yes: TToolButton
      AlignWithMargins = True
      Left = 126
      Top = 0
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  &Yes  '
      ImageIndex = 72
      ImageName = 'icon_072'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = YesClick
    end
    object No: TToolButton
      AlignWithMargins = True
      Left = 252
      Top = 0
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  &No  '
      ImageIndex = 22
      ImageName = 'icon_022'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = NoClick
    end
    object All: TToolButton
      AlignWithMargins = True
      Left = 378
      Top = 0
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  &All  '
      ImageIndex = 122
      ImageName = 'icon_122'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = AllClick
    end
    object Copy: TToolButton
      AlignWithMargins = True
      Left = 500
      Top = 0
      Hint = 'Copy this message to the clipboard'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  Co&py  '
      ImageIndex = 81
      ImageName = 'icon_081'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = CopyClick
    end
    object Search: TToolButton
      AlignWithMargins = True
      Left = 645
      Top = 0
      Hint = 'Search for solutions with Google'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  &Search  '
      ImageIndex = 106
      ImageName = 'icon_106'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = SearchClick
    end
    object Help: TToolButton
      AlignWithMargins = True
      Left = 802
      Top = 0
      Hint = 'See help for more information'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  &Help  '
      ImageIndex = 68
      ImageName = 'icon_068'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = HelpClick
    end
    object Info: TToolButton
      AlignWithMargins = True
      Left = 942
      Top = 0
      Cursor = crHandPoint
      Hint = 'Look for more information at SuperMemo Website'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  &Info  '
      ImageIndex = 31
      ImageName = 'icon_031'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = InfoClick
    end
    object Report: TToolButton
      AlignWithMargins = True
      Left = 1075
      Top = 0
      Hint = 'Report this bug to SuperMemo World'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  &Report  '
      ImageIndex = 130
      ImageName = 'icon_130'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = ReportClick
    end
    object EMailBtn: TToolButton
      AlignWithMargins = True
      Left = 1233
      Top = 0
      Hint = 'E-mail this message (to anyone)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  &E-Mail  '
      ImageIndex = 130
      ImageName = 'icon_130'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = EMailBtnClick
    end
    object Cancel: TToolButton
      AlignWithMargins = True
      Left = 1388
      Top = 0
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ParentCustomHint = False
      AutoSize = True
      Caption = '  &Cancel  '
      ImageIndex = 16
      ImageName = 'icon_016'
      ParentShowHint = False
      ShowHint = False
      Style = tbsTextButton
      Visible = False
      OnClick = CancelClick
    end
  end
end
