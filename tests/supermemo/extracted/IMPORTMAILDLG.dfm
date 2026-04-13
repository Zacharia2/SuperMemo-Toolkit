object ImportMailDlg: TImportMailDlg
  Left = 366
  Top = 124
  ActiveControl = Senders
  Caption = 'Import Mail'
  ClientHeight = 845
  ClientWidth = 1144
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 25
  object From: TLabel
    Left = 12
    Top = 160
    Width = 45
    Height = 25
    Caption = 'From'
  end
  object To_: TLabel
    Left = 12
    Top = 192
    Width = 24
    Height = 25
    Caption = 'To'
  end
  object Sent: TLabel
    Left = 12
    Top = 224
    Width = 41
    Height = 25
    Caption = 'Sent'
  end
  object Label4: TLabel
    Left = 12
    Top = 15
    Width = 129
    Height = 25
    Caption = 'Importing from:'
  end
  object Label5: TLabel
    Left = 12
    Top = 70
    Width = 72
    Height = 25
    Caption = 'Archive:'
  end
  object Subject: TLabel
    Left = 12
    Top = 257
    Width = 66
    Height = 25
    Caption = 'Subject'
  end
  object FromLabel: TLabel
    Left = 12
    Top = 299
    Width = 51
    Height = 25
    Caption = 'From:'
  end
  object Label2: TLabel
    Left = 304
    Top = 299
    Width = 72
    Height = 25
    Caption = 'Subject:'
  end
  object SortSenders: TSpeedButton
    Left = 262
    Top = 299
    Width = 27
    Height = 22
    Hint = 'Sort mail by senders'
    Flat = True
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000074140000741400000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFC0C0C000
      0000C0C0C0FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OnClick = SortSendersClick
  end
  object SortSubjects: TSpeedButton
    Left = 595
    Top = 299
    Width = 26
    Height = 22
    Hint = 'Sort mail by subject'
    Flat = True
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000074140000741400000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFC0C0C000
      0000C0C0C0FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OnClick = SortSubjectsClick
  end
  object Label1: TLabel
    Left = 12
    Top = 122
    Width = 54
    Height = 25
    Hint = 'Concept group'
    Caption = 'Group'
  end
  object Preview: TMemo
    Left = 636
    Top = 189
    Width = 493
    Height = 596
    Hint = 'Preview the mail text'
    Color = clWhite
    Lines.Strings = (
      '')
    TabOrder = 0
  end
  object PickInbox: TButton
    Left = 692
    Top = 12
    Width = 201
    Height = 34
    Hint = 'Select an Outlook folder whose mail is to be processed'
    Caption = 'Import Folder'
    TabOrder = 1
    OnClick = PickInboxClick
  end
  object ImportFolder: TEdit
    Left = 236
    Top = 12
    Width = 439
    Height = 33
    Hint = 'Select an Outlook folder whose mail is to be processed'
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
    Text = 'Inbox'
  end
  object ArchiveFolder: TEdit
    Left = 236
    Top = 61
    Width = 439
    Height = 33
    Hint = 
      'Select an Outlook folder that will be used as a default archive ' +
      'for mail'
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 3
    Text = 'Archive'
  end
  object PickArchive: TButton
    Left = 692
    Top = 60
    Width = 201
    Height = 34
    Hint = 
      'Select an Outlook folder that will be used as a default archive ' +
      'for mail'
    Caption = 'Archive'
    TabOrder = 4
    OnClick = PickArchiveClick
  end
  object Subjects: TListBox
    Left = 304
    Top = 330
    Width = 323
    Height = 455
    Hint = 'The list of mail subjects'
    Color = clWhite
    ItemHeight = 25
    TabOrder = 5
    OnClick = ListBoxClick
    OnDblClick = SendersDblClick
    OnEnter = ListBoxEnter
    OnExit = ListBoxExit
  end
  object BitBtn1: TBitBtn
    Left = 906
    Top = 12
    Width = 206
    Height = 80
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 6
  end
  object Senders: TListBox
    Left = 12
    Top = 332
    Width = 284
    Height = 453
    Hint = 'The list of mail senders'
    Color = clWhite
    ItemHeight = 25
    TabOrder = 7
    OnClick = ListBoxClick
    OnDblClick = SendersDblClick
    OnEnter = ListBoxEnter
    OnExit = ListBoxExit
  end
  object Panel1: TPanel
    Left = 0
    Top = 801
    Width = 1144
    Height = 44
    Align = alBottom
    TabOrder = 8
    object ImportAll: TButton
      Left = 12
      Top = 0
      Width = 144
      Height = 41
      Hint = 'Import all e-mails from the import folder to SuperMemo'
      Caption = '&Import All'
      Default = True
      TabOrder = 0
      OnClick = ImportAllClick
    end
    object Delete: TButton
      Left = 167
      Top = 0
      Width = 146
      Height = 41
      Hint = 
        'Delete the selected e-mail (it will be stored in Deleted Items f' +
        'older in Outlook)'
      Caption = 'Delete'
      TabOrder = 1
      OnClick = DeleteClick
    end
    object ToArchive: TButton
      Left = 328
      Top = 0
      Width = 146
      Height = 41
      Hint = 'Move the selected e-mail to the archive folder in Outlook'
      Caption = 'Archive'
      TabOrder = 2
      OnClick = ToArchiveClick
    end
    object Import: TButton
      Left = 483
      Top = 0
      Width = 144
      Height = 41
      Hint = 'Add only the selected e-mail to SuperMemo'
      Caption = 'Insert'
      TabOrder = 3
      OnClick = ImportClick
    end
    object ViewMail: TButton
      Left = 636
      Top = 0
      Width = 144
      Height = 41
      Hint = 'Inspect the selected e-mail in Outlook'
      Caption = 'View'
      TabOrder = 4
      OnClick = ViewMailClick
    end
    object Reply: TButton
      Left = 789
      Top = 0
      Width = 144
      Height = 41
      Hint = 'Reply to the selected e-mail'
      Caption = 'Reply'
      TabOrder = 5
      Visible = False
      OnClick = ReplyClick
    end
    object Move: TButton
      Left = 942
      Top = 0
      Width = 144
      Height = 41
      Hint = 'Move the selected e-mail to a given folder in Outlook'
      Caption = 'Move'
      TabOrder = 6
      Visible = False
      OnClick = MoveClick
    end
  end
  object CategoryCombo: TComboBox
    Left = 236
    Top = 112
    Width = 439
    Height = 33
    TabOrder = 9
    OnChange = CategoryComboChange
    OnClick = CategoryComboClick
    OnDropDown = CategoryComboDropDown
    OnKeyPress = CategoryComboKeyPress
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 120
    object MIClose: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = MICloseClick
    end
    object MISwitch: TMenuItem
      Caption = 'Switch'
      ShortCut = 9
      OnClick = MISwitchClick
    end
  end
end
