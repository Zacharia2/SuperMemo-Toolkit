object XMLExportDialog: TXMLExportDialog
  Left = 503
  Top = 315
  Width = 738
  Height = 523
  Caption = 'XML Export'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 133
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 120
    Width = 149
    Height = 16
    Caption = 'Name of the file to export:'
  end
  object Label2: TLabel
    Left = 8
    Top = 192
    Width = 29
    Height = 16
    Caption = 'Filter'
  end
  object BitBtn1: TBitBtn
    Left = 640
    Top = 8
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 640
    Top = 40
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 448
    Width = 617
    Height = 17
    Caption = 'Include learning data'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 256
    Width = 625
    Height = 177
    Caption = 'XSL Stylesheet'
    ItemIndex = 0
    Items.Strings = (
      'No stylesheet'
      'Universal (supermemo.com)'
      'SuperMemo default'
      'Collection default'
      'Select file')
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 8
    Top = 152
    Width = 545
    Height = 24
    TabOrder = 4
    Text = 'c:\supermemo.xml'
  end
  object Button1: TButton
    Left = 552
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 5
  end
  object none: TEdit
    Left = 8
    Top = 216
    Width = 545
    Height = 24
    TabOrder = 6
    Text = 'none'
  end
  object Button2: TButton
    Left = 552
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 7
  end
  object RadioGroup2: TRadioGroup
    Left = 8
    Top = 16
    Width = 617
    Height = 97
    Caption = 'Export to:'
    Items.Strings = (
      'Another collection (SuperMemo for Windows)'
      'XML file')
    TabOrder = 8
  end
end
