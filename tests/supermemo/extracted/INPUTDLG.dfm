object InputDlg: TInputDlg
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Input text'
  ClientHeight = 390
  ClientWidth = 1135
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 21
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 61
    Height = 21
    Margins.Left = 12
    Margins.Top = 12
    Margins.Right = 12
    Margins.Bottom = 12
    Alignment = taCenter
    Caption = 'Request'
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 22
    Top = 38
    Width = 1103
    Height = 304
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 0
    OnKeyDown = Memo1KeyDown
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 320
    Width = 1135
    Height = 70
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    AutoSize = True
    ButtonHeight = 70
    ButtonWidth = 144
    Images = AboutBox.VirtualImageList24
    List = True
    ParentShowHint = False
    ShowCaptions = True
    AllowTextButtons = True
    ShowHint = True
    TabOrder = 1
    object OK: TToolButton
      Left = 0
      Top = 0
      Hint = 'Accept (Alt+Enter)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = ' &OK   '
      ImageIndex = 72
      ImageName = 'icon_072'
      Style = tbsTextButton
      OnClick = OKClick
    end
    object Cancel: TToolButton
      Left = 121
      Top = 0
      Hint = 'Cancel changes (Esc)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = True
      Caption = ' &Cancel   '
      ImageIndex = 16
      ImageName = 'icon_016'
      Style = tbsTextButton
      OnClick = CancelClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 368
    Top = 56
    object SelectAll1: TMenuItem
      Caption = 'Select All'
      ShortCut = 16449
      OnClick = SelectAll1Click
    end
  end
end
