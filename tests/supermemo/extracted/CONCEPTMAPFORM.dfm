object ConceptMapForm: TConceptMapForm
  Left = 0
  Top = 0
  Caption = 'Concept map'
  ClientHeight = 753
  ClientWidth = 1275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TheMap: TImage
    Left = 0
    Top = 22
    Width = 1275
    Height = 731
    Align = alClient
    OnMouseDown = TheMapMouseDown
    ExplicitLeft = 32
    ExplicitTop = 248
    ExplicitWidth = 1201
    ExplicitHeight = 473
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1275
    Height = 22
    AutoSize = True
    Caption = 'ToolBar1'
    Images = AboutBox.ImageList1
    TabOrder = 0
    object ViewBtn: TToolButton
      Left = 0
      Top = 0
      Hint = 'View the center element of the map'
      Caption = 'ViewBtn'
      ImageIndex = 23
      OnClick = ViewBtnClick
    end
    object ToolButton1: TToolButton
      Left = 23
      Top = 0
      Caption = 'ToolButton1'
      ImageIndex = 209
      Visible = False
    end
    object CaptionsBtn: TToolButton
      Left = 46
      Top = 0
      Hint = 'Display concept map captions'
      AllowAllUp = True
      Caption = 'CaptionsBtn'
      Grouped = True
      ImageIndex = 6
      Style = tbsCheck
      Visible = False
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 928
    Top = 368
    object Close1: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = Close1Click
    end
  end
end
