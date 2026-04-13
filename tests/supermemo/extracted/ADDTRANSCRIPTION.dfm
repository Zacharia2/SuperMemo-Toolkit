object AddTranscription: TAddTranscription
  Left = 445
  Top = 297
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Add pronunciation'
  ClientHeight = 215
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 26
    Height = 16
    Caption = 'Te&xt'
    FocusControl = Word
  end
  object Label2: TLabel
    Left = 10
    Top = 91
    Width = 78
    Height = 16
    Caption = '&Transcription'
    FocusControl = Transcription
  end
  object Word: TEdit
    Left = 10
    Top = 40
    Width = 535
    Height = 34
    Hint = 'A word that will be added to the Transcription Registry'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Transcription: TEdit
    Left = 10
    Top = 123
    Width = 535
    Height = 34
    Hint = 
      'Transcription of the word (see Search : Other texts : Pronunciat' +
      'ion)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object OK: TBitBtn
    Left = 300
    Top = 166
    Width = 117
    Height = 38
    Caption = '&OK'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = OKClick
  end
  object Cancel: TBitBtn
    Left = 423
    Top = 166
    Width = 116
    Height = 38
    Caption = '&Cancel'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
    OnClick = CancelClick
  end
end
