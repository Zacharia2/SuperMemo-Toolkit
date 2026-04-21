object AddressDlg: TAddressDlg
  Left = 371
  Top = 122
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Company'
  ClientHeight = 690
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -30
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 144
  TextHeight = 32
  object Panel1: TPanel
    Left = 12
    Top = 12
    Width = 747
    Height = 662
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object ResellerLabel: TLabel
      Left = 30
      Top = 26
      Width = 100
      Height = 32
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Support'
      ParentShowHint = False
      ShowHint = True
    end
    object Label2: TLabel
      Left = 30
      Top = 339
      Width = 122
      Height = 32
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Company'
    end
    object Reseller: TMemo
      Left = 30
      Top = 65
      Width = 693
      Height = 237
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Alignment = taCenter
      Lines.Strings = (
        'support: supermemopedia.com'
        'documentation: help.supermemo.org'
        'articles: supermemo.guru')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Company: TMemo
      Left = 30
      Top = 378
      Width = 693
      Height = 248
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Alignment = taCenter
      Lines.Strings = (
        'SuperMemo World, Poland'
        'wiki: supermemopedia.com'
        'help: help.supermemo.org'
        'research: supermemo.guru'
        'shop: super-memo.com'
        'learn: supermemo.com')
      ParentShowHint = False
      ReadOnly = True
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 1
    end
  end
end
