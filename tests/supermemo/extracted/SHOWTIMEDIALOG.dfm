object ShowTimeDialog: TShowTimeDialog
  Left = 447
  Top = 190
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Display At'
  ClientHeight = 335
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 25
  object Bevel1: TBevel
    Left = 5
    Top = 6
    Width = 332
    Height = 299
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
  end
  object AtEditing: TCheckBox
    Left = 20
    Top = 20
    Width = 300
    Height = 28
    Hint = 
      'Determine if the selected component should be displayed in parti' +
      'cular mode'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'At editing'
    Checked = True
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 0
  end
  object AtDragging: TCheckBox
    Left = 20
    Top = 67
    Width = 300
    Height = 26
    Hint = 
      'Determine if the selected component should be displayed in parti' +
      'cular mode'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'At dragging'
    Checked = True
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 1
  end
  object AtBrowsing: TCheckBox
    Left = 20
    Top = 115
    Width = 300
    Height = 27
    Hint = 
      'Determine if the selected component should be displayed in parti' +
      'cular mode'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'At &browsing'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 2
  end
  object QuestionBox: TCheckBox
    Left = 20
    Top = 162
    Width = 300
    Height = 30
    Hint = 
      'Determine if the selected component should be displayed in parti' +
      'cular mode'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'On &question'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 3
  end
  object AnswerBox: TCheckBox
    Left = 20
    Top = 210
    Width = 300
    Height = 28
    Hint = 
      'Determine if the selected component should be displayed in parti' +
      'cular mode'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'On &answer'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 4
  end
  object PostGradeBox: TCheckBox
    Left = 20
    Top = 258
    Width = 300
    Height = 26
    Hint = 
      'Determine if the selected component should be displayed in parti' +
      'cular mode'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'After &grading'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 5
  end
  object OK: TBitBtn
    Left = 345
    Top = 15
    Width = 155
    Height = 41
    Hint = 'Accept the setting'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&OK'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 6
    OnClick = OKClick
  end
  object Cancel: TBitBtn
    Left = 345
    Top = 120
    Width = 155
    Height = 40
    Hint = 'Cancel changes'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 7
  end
  object Clear: TBitBtn
    Left = 345
    Top = 67
    Width = 155
    Height = 40
    Hint = 'Clear all checkboxes (and make the component invisible)'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&Clear'
    Glyph.Data = {
      2E060000424D2E06000000000000360400002800000015000000150000000100
      080000000000F801000000000000000000000001000000010000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
      A400000000000000000000000000000000000000000000000000000000000000
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
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000707070707F8
      07070707F80707070707070707F80000000007F807F80707070707070707F807
      07F80707F800F8000000F807F80707070707070707070707070707F800F8F800
      0000070707F8070707070707070707070707F800F8070700000007F807070707
      070707070707070707F800F8070707000000F807F80707070707070707070707
      F800F80707070700000007070707070707070707070707F800F8070707070700
      000007F807070707000000000007F800F8070707070707000000F80707070000
      FFFCFCFC00F800F8070707070707070000000707070000FFFCFC00FCF800F800
      00070707070707000000070700FFFFFFFC0000F800F8FFFF0000000007070700
      000007070000FFFFFC00F800F8FFFF00000000000707070000000707070000FF
      FCF800F8FCFF00000000F8F8F8F807000000070707070000F800F8FC00000000
      F8F8F8F807F8000000000707070707F800F8000000F8F8F8F807F8F8F8000000
      000007070707F800F80707F8F8F807F8F8F8F800000000000000070700F800F8
      F8070707F8F8F8F8000000000000070000000707F800F8000000000000000000
      0000000007070700000007F800F8070700000000000000000007070707070700
      0000F800F807070707070707070707070707070707070700000000F807070707
      070707070707070707070707070707000000}
    TabOrder = 8
    OnClick = ClearClick
  end
end
