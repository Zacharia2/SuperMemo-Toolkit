object ConceptSelectBox: TConceptSelectBox
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsNone
  Caption = 'ConceptSelectBox'
  ClientHeight = 779
  ClientWidth = 1190
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  KeyPreview = True
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 21
  object PaintBox1: TPaintBox
    Left = 72
    Top = 113
    Width = 554
    Height = 337
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    OnDblClick = PaintBox1DblClick
    OnMouseDown = PaintBox1MouseDown
  end
  object Edit1: TEdit
    Left = 0
    Top = 0
    Width = 1190
    Height = 29
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    BevelKind = bkTile
    BevelWidth = 2
    TabOrder = 0
    OnChange = Edit1Change
    OnKeyDown = Edit1KeyDown
    OnKeyPress = Edit1KeyPress
  end
  object ToolBar1: TToolBar
    AlignWithMargins = True
    Left = 5
    Top = 34
    Width = 55
    Height = 740
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alLeft
    AutoSize = True
    BorderWidth = 2
    ButtonHeight = 41
    ButtonWidth = 45
    Caption = 'ToolBar1'
    Images = AboutBox.VirtualImageList32
    TabOrder = 1
    object ViewBtn: TToolButton
      Left = 0
      Top = 0
      Hint = 'View the root element of the concept'
      Caption = 'ViewBtn'
      ImageIndex = 23
      ImageName = 'icon_023'
      Wrap = True
      OnClick = ViewBtnClick
    end
    object ReviewConceptGroupBtn: TToolButton
      Left = 0
      Top = 41
      Hint = 'Learn the elements in the concept group'
      Caption = 'ReviewConceptGroupBtn'
      ImageIndex = 34
      ImageName = 'L-Plate'
      Wrap = True
      OnClick = ReviewConceptGroupBtnClick
    end
    object TransferBtn: TToolButton
      Left = 0
      Top = 82
      Hint = 'Move current element to the selected concept group'
      Caption = 'TransferBtn'
      ImageIndex = 232
      ImageName = 'Switch'
      Wrap = True
      OnClick = TransferBtnClick
    end
    object LinkConcept: TToolButton
      Left = 0
      Top = 123
      Hint = 'Link current element to the selected concept'
      Caption = 'LinkConcept'
      ImageIndex = 222
      ImageName = 'icon_222'
      Wrap = True
      OnClick = LinkConceptClick
    end
    object AnchorBtn: TToolButton
      Left = 0
      Top = 164
      Hint = 'Set the concept as the default concept in the collection'
      Caption = 'AnchorBtn'
      ImageIndex = 231
      ImageName = 'icon_231'
      Wrap = True
      OnClick = AnchorBtnClick
    end
    object HookBtn: TToolButton
      Left = 0
      Top = 205
      Hint = 'View the last element in the hook of the concept'
      Caption = 'HookBtn'
      ImageIndex = 194
      ImageName = 'icon_194'
      Wrap = True
      OnClick = HookBtnClick
    end
    object CloseBtn: TToolButton
      Left = 0
      Top = 246
      Hint = 'Close the concept selection list (Esc)'
      Caption = 'CloseBtn'
      ImageIndex = 16
      ImageName = 'icon_016'
      OnClick = CloseBtnClick
    end
  end
end
