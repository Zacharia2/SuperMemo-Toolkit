object RepHistoryForm: TRepHistoryForm
  Left = 367
  Top = 258
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu]
  Caption = 'Repetition History'
  ClientHeight = 1305
  ClientWidth = 2192
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 20
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 2192
    Height = 1305
    Align = alClient
    ColCount = 10
    DefaultColWidth = 96
    DefaultRowHeight = 36
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goThumbTracking]
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    ColWidths = (
      96
      95
      96
      96
      96
      96
      96
      96
      96
      96)
  end
  object PopupMenu1: TPopupMenu
    Left = 384
    Top = 112
    object MIEditHistory: TMenuItem
      Caption = '&Edit'
      Hint = 
        'Edit repetition history (this may affect the algorithm and sleep' +
        ' optimization)'
      ShortCut = 16453
      OnClick = MIEditHistoryClick
    end
    object MICopy: TMenuItem
      Caption = '&Copy'
      ShortCut = 16451
      OnClick = MICopyClick
    end
    object MIDelete: TMenuItem
      Caption = '&Delete'
      Hint = 'Delete repetition history'
      ShortCut = 46
      OnClick = MIDeleteClick
    end
    object MIResave: TMenuItem
      Caption = '&Save'
      Enabled = False
      Hint = 'Save repetition history if it has been corrected for errors'
      ShortCut = 16467
      OnClick = MIResaveClick
    end
    object Close1: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = Close1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Memorystatus1: TMenuItem
      Caption = 'Memory status'
      Hint = 'Show changes in memory retrievability and stability over time'
      ShortCut = 113
      OnClick = Memorystatus1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MIFixAndEdit: TMenuItem
      Caption = 'Fix and Edit'
      Hint = 'Correct errors in repetition history before editing'
      OnClick = MIFixAndEditClick
    end
  end
end
