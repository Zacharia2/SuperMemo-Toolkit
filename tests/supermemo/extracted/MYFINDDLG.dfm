object MyFindDlg: TMyFindDlg
  Left = 542
  Top = 131
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  ActiveControl = FindText
  BorderStyle = bsDialog
  Caption = 'Find elements'
  ClientHeight = 981
  ClientWidth = 989
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -23
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 29
  object Label1: TLabel
    Left = 14
    Top = 14
    Width = 97
    Height = 29
    Caption = 'Find te&xt:'
    FocusControl = FindText
  end
  object Bevel1: TBevel
    Left = 12
    Top = 198
    Width = 965
    Height = 5
  end
  object Label2: TLabel
    Left = 12
    Top = 465
    Width = 572
    Height = 29
    Hint = 'Words and phrases that will all contribute to search results'
    Caption = 'Phrases that may be included: &OR-Search (May Find):'
    FocusControl = MayFindList
  end
  object Label3: TLabel
    Left = 12
    Top = 692
    Width = 653
    Height = 29
    Hint = 
      'Words and phrases that should eliminate elements from search res' +
      'ults'
    Caption = 'Phrases that must be excluded: &NOT-Search (Must Not Find):'
    FocusControl = MustNotFindList
  end
  object Delete: TSpeedButton
    Left = 725
    Top = 825
    Width = 37
    Height = 36
    Hint = 'Delete the currently selected search definition'
    OnClick = DeleteClick
  end
  object Label4: TLabel
    Left = 12
    Top = 219
    Width = 594
    Height = 29
    Hint = 'Words and phrases that must be included in found elements'
    Caption = 'Phrases that must be included: &AND-Search (Must Find)'
    FocusControl = MustFindList
  end
  object LastUsed: TSpeedButton
    Left = 686
    Top = 825
    Width = 36
    Height = 36
    Hint = 'Restore the last used search definition (Ctrl+R)'
    OnClick = LastUsedClick
  end
  object FindText: TEdit
    Left = 204
    Top = 14
    Width = 539
    Height = 37
    TabOrder = 0
  end
  object FindNextBtn: TButton
    Left = 767
    Top = 11
    Width = 202
    Height = 48
    Caption = '&Find'
    Default = True
    TabOrder = 7
    OnClick = FindNextBtnClick
  end
  object MatchingWords: TCheckBox
    Left = 12
    Top = 81
    Width = 690
    Height = 30
    Hint = 'Exclude matches that are not complete words'
    Caption = 'Match &whole word only'
    TabOrder = 1
  end
  object MatchingCase: TCheckBox
    Left = 12
    Top = 126
    Width = 690
    Height = 27
    Hint = 'Check the exact lowercase and uppercase match'
    Caption = 'Match &case'
    TabOrder = 2
  end
  object Cancel: TButton
    Left = 767
    Top = 65
    Width = 202
    Height = 48
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 8
    OnClick = CancelClick
  end
  object Details: TButton
    Left = 767
    Top = 119
    Width = 202
    Height = 48
    Hint = 'Show or hide AND-OR-NOT search options'
    Caption = '<< &Details'
    TabOrder = 9
    OnClick = DetailsClick
  end
  object MayFindList: TMemo
    Left = 12
    Top = 513
    Width = 965
    Height = 152
    Hint = 'Words and phrases that should be included in the search'
    TabOrder = 4
  end
  object MustNotFindList: TMemo
    Left = 12
    Top = 743
    Width = 668
    Height = 76
    Hint = 
      'Words and phrases that should eliminate elements from search res' +
      'ults'
    TabOrder = 5
  end
  object SearchDefinitions: TComboBox
    Left = 12
    Top = 825
    Width = 669
    Height = 37
    Hint = 'Choose one of previously saved search definitions (Ctrl+S)'
    DropDownCount = 15
    TabOrder = 6
    Text = 'Recent searches'
    OnChange = SearchDefinitionsChange
  end
  object MustFindList: TMemo
    Left = 12
    Top = 272
    Width = 965
    Height = 169
    Hint = 'Words and phrases that must be included in found elements'
    TabOrder = 3
  end
  object Google: TBitBtn
    Left = 767
    Top = 741
    Width = 202
    Height = 57
    Hint = 'Search for the terms on Google'
    Caption = 'Web'
    Layout = blGlyphRight
    TabOrder = 10
    OnClick = GoogleClick
  end
  object Save: TBitBtn
    Left = 767
    Top = 806
    Width = 202
    Height = 55
    Hint = 'Save the current search definition for later use'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Save'
    Layout = blGlyphRight
    TabOrder = 11
    OnClick = SaveClick
  end
  object PopupMenu1: TPopupMenu
    Left = 47
    Top = 168
    object MIRestoreLast: TMenuItem
      Caption = '&Restore last'
      Hint = 'Restore the last used search definition'
      ShortCut = 16466
      OnClick = LastUsedClick
    end
    object MIChooseDefinition: TMenuItem
      Caption = '&Choose definition'
      Hint = 'Choose a previously saved search definition'
      ShortCut = 16467
      OnClick = MIChooseDefinitionClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Edittext1: TMenuItem
      Caption = 'Edit find te&xt'
      ShortCut = 32856
      OnClick = Edittext1Click
    end
    object EditANDtext1: TMenuItem
      Caption = 'Edit AND text'
      ShortCut = 32833
      OnClick = EditANDtext1Click
    end
    object EditORtext1: TMenuItem
      Caption = 'Edit OR text'
      ShortCut = 32847
      OnClick = EditORtext1Click
    end
    object EditNOTtext1: TMenuItem
      Caption = 'Edit NOT text'
      ShortCut = 32846
      OnClick = EditNOTtext1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Close1: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = Close1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object InvEitFindtext1: TMenuItem
      Caption = 'Inv: Edit Find text'
      ShortCut = 32852
      Visible = False
      OnClick = InvEitFindtext1Click
    end
    object InvChangeMatchcase1: TMenuItem
      Caption = 'Inv: Change Match case'
      ShortCut = 32835
      Visible = False
      OnClick = InvChangeMatchcase1Click
    end
  end
end
