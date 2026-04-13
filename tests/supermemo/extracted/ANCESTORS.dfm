object Ancestors: TAncestors
  Left = -5000
  Top = 225
  Hint = 'List of ancestors in the contents tree'
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Ancestors'
  ClientHeight = 554
  ClientWidth = 665
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  PopupMenu = PopupMenu1
  Position = poDesigned
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 16
  object ListBox1: TCheckListBox
    Left = 0
    Top = 0
    Width = 665
    Height = 554
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Microsoft YaHei'
    Font.Style = []
    ItemHeight = 26
    ParentFont = False
    TabOrder = 0
    OnClick = ListBox1Click
    OnDblClick = ListBox1DblClick
    OnKeyDown = ListBox1KeyDown
    ExplicitWidth = 621
    ExplicitHeight = 303
  end
  object PopupMenu1: TPopupMenu
    Left = 72
    Top = 72
    object ViewElement1: TMenuItem
      Caption = 'View element'
      Visible = False
    end
    object Viewbranch1: TMenuItem
      Caption = 'View branch'
      ShortCut = 16416
      OnClick = Viewbranch1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MILearn: TMenuItem
      Caption = 'Learn'
      Hint = 'Learn selected branch'
      Visible = False
    end
    object MIPostpone: TMenuItem
      Caption = 'Postpone branch'
      Hint = 'Postpone repetitions in the selected branch'
      OnClick = MIPostponeClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MIReturn: TMenuItem
      Caption = 'Element window'
      Hint = 'Return to the element window (e.g. to continue learning)'
      ShortCut = 27
      OnClick = MIReturnClick
    end
  end
end
