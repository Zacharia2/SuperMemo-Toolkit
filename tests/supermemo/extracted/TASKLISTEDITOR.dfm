object TasklistEditor: TTasklistEditor
  Left = 513
  Top = 265
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 646
  ClientWidth = 1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 707
    Height = 91
  end
  object Bevel2: TBevel
    Left = 8
    Top = 105
    Width = 707
    Height = 168
  end
  object DefaultTimeLabel: TLabel
    Left = 30
    Top = 201
    Width = 76
    Height = 16
    Hint = 'Default time needed to execute tasks in the list'
    Alignment = taCenter
    Caption = 'Default Time'
  end
  object DefaultPriorityLabel: TLabel
    Left = 30
    Top = 163
    Width = 86
    Height = 16
    Hint = 'Default priority of tasks in the list'
    Alignment = taCenter
    Caption = 'Default Priority'
  end
  object DefaultValueLabel: TLabel
    Left = 30
    Top = 126
    Width = 80
    Height = 16
    Hint = 'Default value of tasks in the list'
    Alignment = taCenter
    Caption = 'Default Value'
  end
  object LinkCategory: TSpeedButton
    Left = 24
    Top = 22
    Width = 115
    Height = 62
    Hint = 'Select default category for storing tasks in the tasklist'
    Caption = 'Concept'
    Flat = True
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000074120000741200000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF888888838383FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF909090B2
      B2B26E6E6E939393FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF9C9C9DBFC0C06F6F6F8B8B8BFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5897B82E
      7CA81F73A25494B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF70BDE3439FCC2893C945ADDDFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0D0E080CAEC48
      A9D52C9DD24CB7E6B6D4E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF4AA8D24EBEEC36A6D82EA5D93FB8EB4CA9D2FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF61B4D532BAEB2CAFE52A
      A8DC2AAADE2CAFE633BAEB65B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF94C7DF54D0F132BEEF2EB5E533BAE834BAE92EB4E531BDEF52CEF199CA
      E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6EC1E05CD8F640C8F26FD3EF7C
      DFF685E1F689DAF142C8F259D7F66CC0E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF83D0EB75E1F94ED1F692E5FAAAEEFBA3ECFB80E0F943CDF572E1F979CB
      E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8DD1EBA4EDFB49D5F860DDF980
      E3FA7DE2FA5DDCF947D5F7A1ECFB84CEE9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF7BC7E5D4F6FD83EAFC77E8FC8DEBFC8BEBFC75E8FC82EAFCD3F5FD7BC7
      E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7DCECA3E5F8D3F8FE9FF1FDA5
      F2FDA5F2FD9EF1FDD3F8FEA1E3F7BCDFEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF91D0EA99E3F7E3FAFEE0FAFFE0FAFFE2FAFE99E2F797D2EBFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3E3F074CCEC6A
      CEEF6ACFEF75CDECC7E5F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Layout = blGlyphBottom
    OnClick = LinkCategoryClick
  end
  object TimeEdit: TEdit
    Left = 437
    Top = 198
    Width = 138
    Height = 24
    Hint = 'Default time needed to execute tasks in the list'
    TabOrder = 0
    OnExit = TimeEditExit
  end
  object PriorityEdit: TEdit
    Left = 437
    Top = 160
    Width = 138
    Height = 24
    Hint = 'Default priority of tasks in the list'
    ReadOnly = True
    TabOrder = 1
  end
  object ValueEdit: TEdit
    Left = 437
    Top = 123
    Width = 138
    Height = 24
    Hint = 'Default value of tasks in the list'
    TabOrder = 2
    OnExit = ValueEditExit
  end
  object CategoryEdit: TMemo
    Left = 145
    Top = 22
    Width = 560
    Height = 62
    Hint = 'Select default category for storing tasks in the tasklist'
    ReadOnly = True
    TabOrder = 3
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 16
    object MIQuit: TMenuItem
      Caption = 'Quit'
      Hint = 'Quit editing the current category'
      ShortCut = 27
      OnClick = MIQuitClick
    end
  end
end
