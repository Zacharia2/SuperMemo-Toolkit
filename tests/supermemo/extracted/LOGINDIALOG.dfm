object LoginDialog: TLoginDialog
  Left = 307
  Top = 131
  ActiveControl = Password
  BorderStyle = bsDialog
  Caption = 'Database Login'
  ClientHeight = 147
  ClientWidth = 283
  Color = clBtnFace
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object OKButton: TButton
    Left = 119
    Top = 114
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelButton: TButton
    Left = 200
    Top = 114
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Panel: TPanel
    Left = 8
    Top = 7
    Width = 267
    Height = 98
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label3: TLabel
      Left = 10
      Top = 6
      Width = 50
      Height = 13
      Caption = 'Database:'
    end
    object DatabaseName: TLabel
      Left = 106
      Top = 6
      Width = 3
      Height = 13
    end
    object Bevel: TBevel
      Left = 1
      Top = 24
      Width = 264
      Height = 9
      Shape = bsTopLine
    end
    object Panel1: TPanel
      Left = 2
      Top = 31
      Width = 263
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 56
        Height = 13
        Caption = '&User Name:'
        FocusControl = UserName
      end
      object Label2: TLabel
        Left = 8
        Top = 36
        Width = 50
        Height = 13
        Caption = '&Password:'
        FocusControl = Password
      end
      object UserName: TEdit
        Left = 101
        Top = 5
        Width = 153
        Height = 21
        MaxLength = 31
        TabOrder = 0
      end
      object Password: TEdit
        Left = 101
        Top = 33
        Width = 153
        Height = 21
        MaxLength = 31
        PasswordChar = '*'
        TabOrder = 1
      end
    end
  end
end
