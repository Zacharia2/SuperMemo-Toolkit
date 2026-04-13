object BrowserForm: TBrowserForm
  Left = 0
  Top = 0
  Caption = 'Light Web Browser'
  ClientHeight = 674
  ClientWidth = 1060
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object CleanBtn: TButton
    Left = 32
    Top = 24
    Width = 129
    Height = 25
    Caption = 'TWebBrowser'
    TabOrder = 0
    OnClick = CleanBtnClick
  end
  object Button2: TButton
    Left = 200
    Top = 24
    Width = 145
    Height = 25
    Caption = 'TWeb'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 16
    Top = 72
    Width = 1017
    Height = 594
    Caption = 'Panel1'
    TabOrder = 2
  end
  object EditButton: TButton
    Left = 376
    Top = 24
    Width = 113
    Height = 25
    Caption = 'Edit'
    TabOrder = 3
    OnClick = EditButtonClick
  end
  object RegistryButton: TButton
    Left = 560
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Registry'
    TabOrder = 4
    OnClick = RegistryButtonClick
  end
end
