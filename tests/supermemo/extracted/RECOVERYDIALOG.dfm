object RecoveryDialog: TRecoveryDialog
  Left = 538
  Top = 240
  HelpContext = 9
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Repair Options'
  ClientHeight = 596
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -30
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 35
  object Label1: TLabel
    Left = 29
    Top = 477
    Width = 211
    Height = 35
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Last recovery date:'
  end
  object LastRecoveryL: TLabel
    Left = 29
    Top = 525
    Width = 60
    Height = 35
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'None'
  end
  object Bevel1: TBevel
    Left = 12
    Top = 456
    Width = 726
    Height = 122
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
  end
  object VerifyRepHistButton: TCheckBox
    Left = 29
    Top = 302
    Width = 445
    Height = 42
    Hint = 'Verify the history of repetitions'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Verify rep. &history'
    TabOrder = 10
  end
  object RebuildTranslationButton: TCheckBox
    Left = 29
    Top = 255
    Width = 445
    Height = 42
    Hint = 
      'Rebuild the entire translation registry and looks for missing en' +
      'tries'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Verify tra&nslation'
    Enabled = False
    TabOrder = 9
  end
  object RebuildLexiconButton: TCheckBox
    Left = 29
    Top = 210
    Width = 445
    Height = 39
    Hint = 'Build a new lexicon from all texts in the collection'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Rebuild &lexicon'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
  end
  object CheckFilespaceButton: TCheckBox
    Left = 29
    Top = 165
    Width = 445
    Height = 39
    Hint = 'Check the integrity of filespace and its registry references'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Verify &filespace'
    TabOrder = 7
  end
  object VerifyTasklistsButton: TCheckBox
    Left = 29
    Top = 119
    Width = 445
    Height = 39
    Hint = 'Verify all tasklists'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Verify &tasklists'
    TabOrder = 6
  end
  object RecoverRegistriesButton: TCheckBox
    Left = 29
    Top = 72
    Width = 445
    Height = 41
    Hint = 
      'Rebuild registries and compare them with the old registries (lon' +
      'g lasting!)'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Rebuild registries'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = RecoverRegistriesButtonClick
  end
  object BasicRecoveryButton: TCheckBox
    Left = 29
    Top = 27
    Width = 445
    Height = 41
    Hint = 'Recover element parameters and the learning process'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Basic checkup'
    TabOrder = 4
    OnClick = BasicRecoveryButtonClick
  end
  object OKBtn: TBitBtn
    Left = 500
    Top = 17
    Width = 235
    Height = 57
    Hint = 'Start check-up and recovery'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkOK
    Margin = 8
    NumGlyphs = 2
    Spacing = 12
    TabOrder = 0
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 500
    Top = 81
    Width = 235
    Height = 56
    Hint = 'Quit check-up and recovery'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkCancel
    Margin = 8
    NumGlyphs = 2
    Spacing = 12
    TabOrder = 1
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 500
    Top = 200
    Width = 235
    Height = 54
    HelpContext = 9
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkHelp
    Margin = 8
    NumGlyphs = 2
    Spacing = 12
    TabOrder = 3
    IsControl = True
  end
  object CheckAll: TBitBtn
    Left = 500
    Top = 137
    Width = 235
    Height = 57
    Hint = 'Check all recovery options (except building lexicon)'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Detailed'
    Glyph.Data = {
      E2060000424DE206000000000000360400002800000024000000130000000100
      080000000000AC02000000000000000000000001000000010000000000000000
      80000080000000808000800000008000800080800000C0C0C0007060A000B8B0
      D000000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000E0D8E800A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030304
      0403030303030303030303030303030303F8F8FF030303030303030303030303
      0303040202040303030303030303030303030303F80303F8FF03030303030303
      0303030303040202020204030303030303030303030303F803030303F8FF0303
      0303030303030303040202020202020403030303030303030303F80303030303
      03F8FF030303030303030304020202FA02020202040303030303030303F8FF03
      03FF03030303F8FF03030303030303020202FA02FA0202020403030303030303
      03F8FF03F803FF030303F8FF03030303030303FA02FA020202FA020202040303
      0303030303F8FFF8030303FF030303F8FF03030303030304FA0202020202FA02
      020204030303030303F8F80303030303FF030303F8FF0303030304020202FA02
      020202FA0202020403030303F8FF0303F8FF030303FF030303F8FF0303030202
      02FA03FA02020204FA02020204030303F8FF03F803F8FF0303F8FF030303F8FF
      0303FA02FA030303FA02020204FA020202040303F8FFF8030303F8FF0303F8FF
      030303F8FF0303FA0303030303FA02020204FA020202040303F80303030303F8
      FF0303F8FF030303F8FF0303030303030303FA02020204FA0202040303030303
      03030303F8FF0303F8FF0303F8FF030303030303030303FA02020204FA020203
      030303030303030303F8FF0303F8FFF8030303030303030303030303FA020202
      04FA030303030303030303030303F8FF0303F8FF030303030303030303030303
      03FA0202020403030303030303030303030303F8FF0303F8FF03030303030303
      030303030303FA0202040303030303030303030303030303F8FF03F8FF030303
      0303030303030303030303FA0202030303030303030303030303030303F8FFF8
      FF030303030303030303030303030303FA030303030303030303030303030303
      0303F8030303}
    Margin = 8
    NumGlyphs = 2
    Spacing = 12
    TabOrder = 2
    OnClick = CheckAllClick
  end
  object Backup: TCheckBox
    Left = 29
    Top = 347
    Width = 445
    Height = 42
    Hint = 'Create a quick collection backup before repair'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Make a backup'
    TabOrder = 11
  end
  object Garbage: TCheckBox
    Left = 29
    Top = 395
    Width = 445
    Height = 40
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Delete garbage files'
    TabOrder = 12
  end
  object PopupMenu1: TPopupMenu
    Left = 392
    Top = 264
    object MIDetailed: TMenuItem
      Caption = 'Detailed'
      ShortCut = 16449
      OnClick = MIDetailedClick
    end
    object InvDetailed1: TMenuItem
      Caption = 'Inv: Detailed'
      ShortCut = 32833
      Visible = False
      OnClick = InvDetailed1Click
    end
  end
end
