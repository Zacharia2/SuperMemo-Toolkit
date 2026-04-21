object MercyOptions: TMercyOptions
  Left = 395
  Top = 169
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Repetition sorting parameters'
  ClientHeight = 526
  ClientWidth = 749
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -20
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 25
  object Bevel1: TBevel
    Left = 14
    Top = 14
    Width = 595
    Height = 337
    Shape = bsFrame
    IsControl = True
  end
  object Label1: TLabel
    Left = 31
    Top = 43
    Width = 59
    Height = 25
    Hint = 
      'Item importance as indicated by ordinals and the forgetting inde' +
      'x'
    Caption = '&Priority'
  end
  object Label2: TLabel
    Left = 31
    Top = 106
    Width = 80
    Height = 25
    Hint = 'Degree of delay in taking the next repetition to come'
    Caption = '&Lateness'
  end
  object Label3: TLabel
    Left = 31
    Top = 169
    Width = 95
    Height = 25
    Hint = 'The amount of work put into successfully repeating a given item'
    Caption = 'In&vestment'
  end
  object Label4: TLabel
    Left = 31
    Top = 232
    Width = 80
    Height = 25
    Hint = 
      'The easiness criterion makes it easy to quickly discharge repeti' +
      'tions of easier items'
    Caption = '&Easiness'
  end
  object Label5: TLabel
    Left = 31
    Top = 294
    Width = 76
    Height = 25
    Hint = 'The recency of the material introduced to the collection'
    Caption = '&Recency'
  end
  object ImportanceP: TLabel
    Left = 557
    Top = 48
    Width = 40
    Height = 25
    Hint = 
      'Percent weight a given criterion will be assigned when sorting r' +
      'escheduled items'
    Caption = '20%'
  end
  object LatenessP: TLabel
    Left = 557
    Top = 109
    Width = 40
    Height = 25
    Hint = 
      'Percent weight a given criterion will be assigned when sorting r' +
      'escheduled items'
    Caption = '20%'
  end
  object InvestmentP: TLabel
    Left = 557
    Top = 171
    Width = 40
    Height = 25
    Hint = 
      'Percent weight a given criterion will be assigned when sorting r' +
      'escheduled items'
    Caption = '20%'
  end
  object EasinessP: TLabel
    Left = 557
    Top = 232
    Width = 40
    Height = 25
    Hint = 
      'Percent weight a given criterion will be assigned when sorting r' +
      'escheduled items'
    Caption = '20%'
  end
  object RecencyP: TLabel
    Left = 557
    Top = 294
    Width = 40
    Height = 25
    Hint = 
      'Percent weight a given criterion will be assigned when sorting r' +
      'escheduled items'
    Caption = '20%'
  end
  object OKBtn: TBitBtn
    Left = 619
    Top = 14
    Width = 123
    Height = 41
    Hint = 'Accept the specified Mercy sorting criteria'
    Caption = '&OK'
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 0
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 619
    Top = 63
    Width = 123
    Height = 42
    Hint = 'Return to the previously set criteria'
    Caption = '&Cancel'
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 1
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 619
    Top = 165
    Width = 123
    Height = 44
    Kind = bkHelp
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 2
    Visible = False
    IsControl = True
  end
  object Default: TBitBtn
    Left = 619
    Top = 113
    Width = 124
    Height = 42
    Hint = 'Set default setting of Mercy criteria'
    Caption = '&Default'
    Glyph.Data = {
      BE060000424DBE06000000000000360400002800000024000000120000000100
      0800000000008802000000000000000000000001000000010000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
      0404040404040303030303030303030303FFF8F8F8F8F8F803FF030303030302
      0403030402020202020204040303030303F8F8FF03F8030303030303F8F8FF03
      030303020204040202020202020202020403030303F8FFF8F80303FFFFFFFFFF
      0303F8FF030303020202020202FAFAFAFAFA02020204030303F8FF030303FFF8
      F8F8F8F8FF0303F8FF03030202020202FA0303030303FA020202040303F8FF03
      03FFF80303030303F8FF0303F8FF03020202020203030303030303FA02020403
      03F8FF0303F803030303030303F8FF03F8FF03020202020202030303030303FA
      0404040303F8FFFFFFFFF8FF0303030303F8F8F8F80303FAFAFAFAFAFAFA0303
      030303030303030303F8F8F8F8F8F8F803030303030303030303030303030303
      030303030303030303030303030303030303030303030303FFFFFFFFFFFF0303
      030303030303030303030404040404040303FFFFFFFF030303030303F8F8F8F8
      F8F803FA040404030303030303FA02020202020403F8F8F8F8FF0303030303F8
      FF03030303F803FA02020403030303030303FA020202020403F8FF03F8FF0303
      03030303F803030303F80303FA0202040303030303040402020202040303F803
      03F8FFFFFFFFFFF8F803030303F80303FA020202040404040402020202020204
      0303F8FF0303F8F8F8F8F8030303FFFF03F8030303FA02020202020202020202
      FAFA0204030303F8FFFF030303030303FFFFF8F8FFF803030303FAFA02020202
      0202FAFA0303FA0303030303F8F8FFFFFFFFFFFFF8F80303F803030303030303
      FAFAFAFAFAFA030303030303030303030303F8F8F8F8F8F80303030303030303
      0303030303030303030303030303030303030303030303030303030303030303
      0303}
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 3
    OnClick = DefaultClick
  end
  object Importance: TTrackBar
    Left = 164
    Top = 42
    Width = 393
    Height = 38
    Hint = 'Set the priority of the corresponding criterion [0..10]'
    Position = 5
    TabOrder = 4
    OnChange = ImportanceChange
  end
  object Lateness: TTrackBar
    Left = 164
    Top = 104
    Width = 393
    Height = 39
    Hint = 'Set the priority of the corresponding criterion [0..10]'
    Position = 5
    TabOrder = 5
    OnChange = ImportanceChange
  end
  object Investment: TTrackBar
    Left = 164
    Top = 165
    Width = 393
    Height = 39
    Hint = 'Set the priority of the corresponding criterion [0..10]'
    Min = 1
    Position = 5
    TabOrder = 6
    OnChange = ImportanceChange
  end
  object Easiness: TTrackBar
    Left = 164
    Top = 227
    Width = 393
    Height = 39
    Hint = 'Set the priority of the corresponding criterion [0..10]'
    Position = 5
    TabOrder = 7
    OnChange = ImportanceChange
  end
  object Recency: TTrackBar
    Left = 164
    Top = 288
    Width = 393
    Height = 40
    Hint = 'Set the priority of the corresponding criterion [0..10]'
    Position = 5
    TabOrder = 8
    OnChange = ImportanceChange
  end
  object ModeCheckBox: TRadioGroup
    Left = 15
    Top = 363
    Width = 595
    Height = 155
    Hint = 'Determine how to sort repetitions'
    Caption = 'Sorting options'
    ItemIndex = 0
    Items.Strings = (
      'Use sorting criteria specified above'
      'Reverse sorting order'
      'Retain current repetition sequence'
      'Randomize')
    TabOrder = 9
  end
end
