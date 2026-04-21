object PasswordDlg: TPasswordDlg
  Left = 393
  Top = 217
  ActiveControl = PasswordEdit
  BorderIcons = [biSystemMenu]
  Caption = 'Unlock password'
  ClientHeight = 305
  ClientWidth = 872
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -24
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = [fsBold]
  FormStyle = fsStayOnTop
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 144
  DesignSize = (
    872
    305)
  TextHeight = 29
  object PasswordCommand: TLabel
    AlignWithMargins = True
    Left = 28
    Top = 32
    Width = 597
    Height = 29
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Enter the unlock password:'
  end
  object PasswordEdit: TEdit
    Left = 13
    Top = 99
    Width = 835
    Height = 58
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akRight]
    PasswordChar = '*'
    TabOrder = 0
  end
  object OKBtn: TBitBtn
    Left = 343
    Top = 190
    Width = 226
    Height = 84
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akBottom]
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 1
  end
  object CancelBtn: TBitBtn
    Left = 604
    Top = 190
    Width = 244
    Height = 84
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akBottom]
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 2
    OnClick = CancelBtnClick
  end
end
