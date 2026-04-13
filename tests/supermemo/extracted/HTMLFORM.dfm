object HTMLForm: THTMLForm
  Left = 431
  Top = 194
  Caption = 'HTML Export'
  ClientHeight = 572
  ClientWidth = 880
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 24
  object Label1: TLabel
    Left = 20
    Top = 10
    Width = 35
    Height = 24
    Caption = '&Title'
    FocusControl = TheTitleEdit
  end
  object Label10: TLabel
    Left = 280
    Top = 418
    Width = 124
    Height = 24
    Caption = 'URL download'
  end
  object Label11: TLabel
    Left = 280
    Top = 498
    Width = 71
    Height = 24
    Caption = 'URL info'
  end
  object Label9: TLabel
    Left = 650
    Top = 408
    Width = 43
    Height = 24
    Caption = 'Price'
  end
  object FindTemplate: TSpeedButton
    Left = 826
    Top = 106
    Width = 29
    Height = 30
    Hint = 
      'Choose a template file (any HTML file with tags such as #pages#,' +
      ' #element#, etc.)'
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C000000000000000000000000000000000000000000001F7C1F7C
      1F7C1F7C1F7C0000000000420042004200420042004200420042004200001F7C
      1F7C1F7C1F7C0000E07F00000042004200420042004200420042004200420000
      1F7C1F7C1F7C0000FF7FE07F0000004200420042004200420042004200420042
      00001F7C1F7C0000E07FFF7FE07F000000420042004200420042004200420042
      004200001F7C0000FF7FE07FFF7FE07F00000000000000000000000000000000
      0000000000000000E07FFF7FE07FFF7FE07FFF7FE07FFF7FE07F00001F7C1F7C
      1F7C1F7C1F7C0000FF7FE07FFF7FE07FFF7FE07FFF7FE07FFF7F00001F7C1F7C
      1F7C1F7C1F7C0000E07FFF7FE07F00000000000000000000000000001F7C1F7C
      1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
      000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C0000
      1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    OnClick = FindTemplateClick
  end
  object OK: TBitBtn
    Left = 740
    Top = 10
    Width = 124
    Height = 38
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 0
    OnClick = OKClick
  end
  object Cancel: TBitBtn
    Left = 740
    Top = 50
    Width = 124
    Height = 38
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
    OnClick = CancelClick
  end
  object TheTitleEdit: TEdit
    Left = 20
    Top = 40
    Width = 651
    Height = 32
    Hint = 'Title displayed at the top of individual HTML pages'
    TabOrder = 2
    Text = 'SuperMemo collection'
  end
  object AuthorDataGroup: TGroupBox
    Left = 20
    Top = 150
    Width = 841
    Height = 251
    Caption = 'Author Data'
    TabOrder = 3
    object Label2: TLabel
      Left = 20
      Top = 30
      Width = 48
      Height = 24
      Caption = 'name'
    end
    object Label3: TLabel
      Left = 20
      Top = 86
      Width = 51
      Height = 24
      Caption = 'e-mail'
    end
    object Label4: TLabel
      Left = 20
      Top = 143
      Width = 64
      Height = 24
      Caption = 'website'
    end
    object Label5: TLabel
      Left = 20
      Top = 198
      Width = 67
      Height = 24
      Caption = 'address'
    end
    object AuthorEdit: TEdit
      Left = 140
      Top = 30
      Width = 681
      Height = 32
      Hint = 'Collection author'#39's data'
      TabOrder = 0
    end
    object EMailEdit: TEdit
      Left = 140
      Top = 86
      Width = 681
      Height = 32
      Hint = 'Collection author'#39's data'
      TabOrder = 1
    end
    object WebsiteEdit: TEdit
      Left = 140
      Top = 143
      Width = 681
      Height = 32
      Hint = 'Collection author'#39's data'
      TabOrder = 2
    end
    object AddressEdit: TEdit
      Left = 140
      Top = 198
      Width = 681
      Height = 32
      Hint = 'Collection author'#39's data'
      TabOrder = 3
    end
  end
  object StatusRadioGroup: TRadioGroup
    Left = 20
    Top = 418
    Width = 231
    Height = 141
    Hint = 'Commercial status of the collection'
    Caption = 'Status'
    ItemIndex = 0
    Items.Strings = (
      'Free'
      'Shareware'
      'Commercial')
    TabOrder = 4
  end
  object DownloadURLEdit: TEdit
    Left = 280
    Top = 453
    Width = 581
    Height = 32
    Hint = 'Web address from which the collection can be downloaded'
    TabOrder = 5
  end
  object InfoURLEdit: TEdit
    Left = 280
    Top = 528
    Width = 581
    Height = 32
    Hint = 'Web address with more information about the collection'
    TabOrder = 6
  end
  object PriceEdit: TEdit
    Left = 760
    Top = 408
    Width = 101
    Height = 32
    Hint = 'Price of the collection as determined by the author'
    TabOrder = 7
    OnChange = PriceEditClick
    OnClick = PriceEditClick
    OnEnter = PriceEditClick
  end
  object UseTemplateBox: TCheckBox
    Left = 20
    Top = 80
    Width = 471
    Height = 21
    Hint = 'Decide if an HTML template should be used'
    Caption = 'Use Template'
    TabOrder = 8
  end
  object TemplateFileEdit: TEdit
    Left = 20
    Top = 106
    Width = 801
    Height = 32
    Hint = 'Template file that will be used if Use Template is checked'
    TabOrder = 9
  end
end
