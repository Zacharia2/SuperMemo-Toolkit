object FAQDlg: TFAQDlg
  Left = 451
  Top = 164
  Caption = 'E-mail Response'
  ClientHeight = 754
  ClientWidth = 946
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 24
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 139
    Height = 24
    Caption = 'Question author:'
  end
  object Label2: TLabel
    Left = 8
    Top = 81
    Width = 127
    Height = 24
    Caption = 'Answer author:'
  end
  object Label3: TLabel
    Left = 8
    Top = 116
    Width = 68
    Height = 24
    Caption = 'Subject:'
  end
  object Label6: TLabel
    Left = 8
    Top = 263
    Width = 81
    Height = 24
    Caption = 'Question:'
  end
  object Label7: TLabel
    Left = 8
    Top = 438
    Width = 69
    Height = 24
    Caption = 'Answer:'
  end
  object Label4: TLabel
    Left = 8
    Top = 46
    Width = 130
    Height = 24
    Caption = 'Author'#39's e-mail:'
  end
  object ChooseFAQFile: TSpeedButton
    Left = 143
    Top = 220
    Width = 27
    Height = 28
    Hint = 'Select the FAQ file (HTML)'
    OnClick = ChooseFAQFileClick
  end
  object Label5: TLabel
    Left = 8
    Top = 150
    Width = 105
    Height = 24
    Caption = 'FAQ Folder:'
  end
  object Label8: TLabel
    Left = 8
    Top = 185
    Width = 90
    Height = 24
    Caption = 'FAQ Files:'
  end
  object ChooseFAQFolder: TSpeedButton
    Left = 143
    Top = 150
    Width = 27
    Height = 29
    OnClick = ChooseFAQFolderClick
  end
  object WYSIWYG: TSpeedButton
    Left = 904
    Top = 253
    Width = 29
    Height = 27
    OnClick = WYSIWYGClick
  end
  object Question: TMemo
    Left = 8
    Top = 288
    Width = 925
    Height = 140
    TabOrder = 1
  end
  object Answer: TMemo
    Left = 8
    Top = 464
    Width = 925
    Height = 280
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object OK: TButton
    Left = 800
    Top = 8
    Width = 133
    Height = 36
    Caption = '&OK'
    Default = True
    TabOrder = 3
    OnClick = OKClick
  end
  object Cancel: TButton
    Left = 800
    Top = 49
    Width = 133
    Height = 36
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = CancelClick
  end
  object NameL: TEdit
    Left = 176
    Top = 8
    Width = 300
    Height = 32
    TabOrder = 5
  end
  object SenderNameL: TEdit
    Left = 176
    Top = 78
    Width = 300
    Height = 32
    TabOrder = 7
    Text = 'User of SuperMemo'
  end
  object SubjectL: TEdit
    Left = 176
    Top = 113
    Width = 757
    Height = 32
    TabOrder = 8
    Text = 'My question'
  end
  object AddrCombo: TComboBox
    Left = 176
    Top = 43
    Width = 300
    Height = 32
    Hint = 'Address to which e-mail will be sent'
    TabOrder = 6
    Text = 'help@supermemo.com'
    Items.Strings = (
      'help@supermemo.com'
      'bug@supermemo.com'
      'beta@supermemo.com')
  end
  object FAQL: TStaticText
    Left = 8
    Top = 220
    Width = 85
    Height = 28
    Caption = 'FAQ File:'
    TabOrder = 0
  end
  object FAQFile: TEdit
    Left = 176
    Top = 218
    Width = 757
    Height = 32
    Hint = 'Path to the FAQ file (HTML)'
    TabOrder = 9
  end
  object HTMLFAQBox: TCheckBox
    Left = 500
    Top = 8
    Width = 141
    Height = 33
    Caption = 'HTML FAQ'
    Checked = True
    State = cbChecked
    TabOrder = 10
    OnClick = HTMLFAQBoxClick
  end
  object WikiFAQBox: TCheckBox
    Left = 500
    Top = 43
    Width = 141
    Height = 33
    Caption = 'Wiki FAQ'
    TabOrder = 11
    OnClick = WikiFAQBoxClick
  end
  object FAQFiles: TComboBox
    Left = 176
    Top = 183
    Width = 757
    Height = 32
    TabOrder = 12
    OnChange = FAQFilesChange
  end
  object FAQFolderE: TEdit
    Left = 176
    Top = 148
    Width = 757
    Height = 32
    TabOrder = 13
    OnChange = FAQFolderEChange
  end
end
