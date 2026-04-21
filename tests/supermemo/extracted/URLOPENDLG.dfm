object URLOpenDlg: TURLOpenDlg
  Left = 471
  Top = 152
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Web link available'
  ClientHeight = 537
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  TextHeight = 19
  object ListBox1: TCheckListBox
    Left = 0
    Top = 0
    Width = 530
    Height = 488
    Hint = 'List of articles opened in Internet Explorer'
    Align = alClient
    ItemHeight = 19
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 488
    Width = 530
    Height = 49
    Align = alBottom
    TabOrder = 1
    object OpenURLs: TButton
      Left = 165
      Top = 5
      Width = 146
      Height = 36
      Hint = 'Import selected articles to SuperMemo'
      Caption = '&Open'
      Default = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = OpenURLsClick
    end
    object Cancel: TButton
      Left = 320
      Top = 5
      Width = 145
      Height = 36
      Hint = 'Take no action and close this dialog box'
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = CancelClick
    end
    object SelectAll: TButton
      Left = 11
      Top = 5
      Width = 147
      Height = 36
      Hint = 'Select all checkboxes on the article list'
      Caption = 'Select &All'
      TabOrder = 2
      OnClick = SelectAllClick
    end
    object CloseSelected: TButton
      Left = 167
      Top = 210
      Width = 195
      Height = 29
      Hint = 'Close selected instances of Internet Explorer'
      Caption = 'Close Selected'
      TabOrder = 3
    end
  end
end
