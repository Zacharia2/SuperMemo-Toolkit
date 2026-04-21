object ImportTXTDlg: TImportTXTDlg
  Left = 451
  Top = 188
  ActiveControl = QAChoiceGroup
  BorderStyle = bsDialog
  Caption = 'Import Text'
  ClientHeight = 603
  ClientWidth = 910
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 32
  object Bevel1: TBevel
    Left = 13
    Top = 13
    Width = 709
    Height = 179
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
  end
  object QAChoiceGroup: TRadioGroup
    Left = 13
    Top = 204
    Width = 872
    Height = 185
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Question and Answer template'
    ItemIndex = 0
    Items.Strings = (
      'Create default'
      'Choose from template registry'
      'Use the current element as template')
    TabOrder = 0
    OnClick = QAChoiceGroupClick
  end
  object OKBtn: TButton
    Left = 735
    Top = 17
    Width = 158
    Height = 52
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 735
    Top = 80
    Width = 158
    Height = 53
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object MCTChoiceGroup: TRadioGroup
    Left = 11
    Top = 399
    Width = 872
    Height = 185
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Multiple Choice Test template'
    ItemIndex = 0
    Items.Strings = (
      'Create default'
      'Choose from template registry'
      'Use the current element as template')
    TabOrder = 1
    OnClick = MCTChoiceGroupClick
  end
  object ChangeFile: TBitBtn
    Left = 28
    Top = 24
    Width = 661
    Height = 53
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Choose file to import'
    TabOrder = 4
    OnClick = ChangeFileClick
  end
  object Edit1: TEdit
    Left = 28
    Top = 95
    Width = 680
    Height = 40
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 5
    Text = 'c:\import.txt'
  end
  object DecodeUTFBox: TCheckBox
    Left = 28
    Top = 146
    Width = 476
    Height = 29
    Hint = 'Convert UTF-8 encoded characters to Unicode for display in HTML'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Decode UTF-8'
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = DecodeUTFBoxClick
  end
end
