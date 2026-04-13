object QODDlg: TQODDlg
  Left = 497
  Top = 245
  HelpContext = 20
  ActiveControl = NextQuestion
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Question of the Day'
  ClientHeight = 510
  ClientWidth = 786
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 25
  object Label1: TLabel
    Left = 26
    Top = 12
    Width = 79
    Height = 25
    Caption = 'Question'
  end
  object Label2: TLabel
    Left = 26
    Top = 213
    Width = 66
    Height = 25
    Caption = 'Answer'
  end
  object Question: TMemo
    Left = 26
    Top = 51
    Width = 750
    Height = 150
    ReadOnly = True
    TabOrder = 0
  end
  object Answer: TMemo
    Left = 26
    Top = 249
    Width = 750
    Height = 165
    ReadOnly = True
    TabOrder = 1
  end
  object Remember: TButton
    Left = 215
    Top = 462
    Width = 184
    Height = 39
    Hint = 'Add this question to standard repetitions in SuperMemo'
    Caption = '&Remember'
    TabOrder = 4
    OnClick = RememberClick
  end
  object NextQuestion: TButton
    Left = 27
    Top = 462
    Width = 182
    Height = 39
    Hint = 'Show this question again later'
    Caption = '&Next question'
    Default = True
    TabOrder = 3
    OnClick = NextQuestionClick
  end
  object DeleteBtn: TButton
    Left = 405
    Top = 462
    Width = 182
    Height = 39
    Hint = 'Delete this question from the question set'
    Caption = '&Delete'
    TabOrder = 5
    OnClick = DeleteBtnClick
  end
  object CloseBtn: TButton
    Left = 593
    Top = 462
    Width = 183
    Height = 39
    Hint = 'Close the Question of the Day'
    Cancel = True
    Caption = 'Cl&ose'
    ModalResult = 1
    TabOrder = 6
    OnClick = CloseBtnClick
  end
  object ShowTipsBox: TCheckBox
    Left = 26
    Top = 422
    Width = 750
    Height = 34
    Caption = '&Show Question of the Day on starting SuperMemo'
    TabOrder = 2
    OnClick = ShowTipsBoxClick
  end
end
