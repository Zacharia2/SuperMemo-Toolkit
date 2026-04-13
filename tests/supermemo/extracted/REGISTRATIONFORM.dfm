object RegistrationForm: TRegistrationForm
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Registering SuperMemo'
  ClientHeight = 1311
  ClientWidth = 1443
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsStayOnTop
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 25
  object Bevel1: TBevel
    Left = 36
    Top = 372
    Width = 1395
    Height = 908
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
  end
  object Label1: TLabel
    Left = 36
    Top = 48
    Width = 177
    Height = 25
    Hint = 'Unique identifier of the machine on which SuperMemo will be used'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Machine identification:'
  end
  object Label2: TLabel
    Left = 66
    Top = 395
    Width = 420
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'User data (optional, but might be helpful at upgrade)'
  end
  object Label3: TLabel
    Left = 66
    Top = 468
    Width = 47
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Name'
  end
  object Label4: TLabel
    Left = 66
    Top = 528
    Width = 63
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Country'
  end
  object Label5: TLabel
    Left = 66
    Top = 593
    Width = 465
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Alternative contact (Facebook, Discord, Twitter, phone, etc.)'
  end
  object Label7: TLabel
    Left = 36
    Top = 168
    Width = 247
    Height = 25
    Hint = 
      'Provide order ID or order number (e.g. see mail sent by the shop' +
      ' at ordering)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Order ID: #XXXXX-supermemo'
  end
  object CopyIDBtn: TSpeedButton
    Left = 970
    Top = 91
    Width = 33
    Height = 33
    Hint = 'Copy Machine ID to clipboard'
    ImageIndex = 81
    ImageName = 'icon_081'
    Images = AboutBox.VirtualImageList32
    Flat = True
    OnClick = CopyIDBtnClick
  end
  object Label6: TLabel
    Left = 66
    Top = 948
    Width = 79
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Comment'
  end
  object UserIDEdit: TEdit
    Left = 36
    Top = 91
    Width = 925
    Height = 33
    Hint = 'Unique identifier of the machine on which SuperMemo will be used'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 10
  end
  object SendBtn: TButton
    Left = 996
    Top = 12
    Width = 435
    Height = 62
    Hint = 'Send registration data to SuperMemo World'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = '&Send'
    TabOrder = 0
    OnClick = SendBtnClick
  end
  object Button3: TButton
    Left = 996
    Top = 266
    Width = 194
    Height = 66
    Hint = 'Explain the process of registering and unlocking SuperMemo'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Help'
    TabOrder = 1
    OnClick = Button3Click
  end
  object OrderIDEdit: TEdit
    Left = 36
    Top = 224
    Width = 925
    Height = 33
    Hint = 
      'SuperMemo order ID or order number (e.g. see mail sent by the Su' +
      'perMemo Store at ordering)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 2
  end
  object NameEdit: TEdit
    Left = 384
    Top = 468
    Width = 1022
    Height = 33
    Hint = 'Name of the owner of SuperMemo license'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 3
  end
  object CountryEdit: TEdit
    Left = 384
    Top = 524
    Width = 1022
    Height = 33
    Hint = 'Owner'#39's countr (optional)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 4
  end
  object Button2: TButton
    Left = 1199
    Top = 266
    Width = 232
    Height = 66
    Hint = 'Exit'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = Button2Click
  end
  object ContactMemo: TMemo
    Left = 66
    Top = 660
    Width = 1340
    Height = 254
    Hint = 
      'Alternative means of contact in case there are problems with e-m' +
      'ail delivery'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 6
  end
  object CommentMemo: TMemo
    Left = 66
    Top = 1008
    Width = 1340
    Height = 254
    Hint = 
      'Comment (incl. suggestion for better service or better SuperMemo' +
      ')'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 7
  end
  object FileEdit: TButton
    Left = 996
    Top = 168
    Width = 194
    Height = 66
    Hint = 
      'Generate a registration file that can be send to SuperMemo World' +
      ' at any time'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'File'
    TabOrder = 8
    OnClick = FileEditClick
  end
  object PasswordBtn: TButton
    Left = 1199
    Top = 168
    Width = 232
    Height = 66
    Hint = 
      'Insert unlock password once you receive it (otherwise register b' +
      'y clicking Send)'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Password'
    TabOrder = 9
    OnClick = PasswordBtnClick
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 208
    object Close1: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = Close1Click
    end
  end
end
