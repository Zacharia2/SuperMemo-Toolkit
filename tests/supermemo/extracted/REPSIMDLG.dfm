object RepSimDlg: TRepSimDlg
  Left = 0
  Top = 0
  Caption = 'Repetition simulator'
  ClientHeight = 284
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -19
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 22
  object Label1: TLabel
    Left = 48
    Top = 27
    Width = 117
    Height = 22
    Caption = 'Period [years]'
  end
  object Label2: TLabel
    Left = 48
    Top = 64
    Width = 201
    Height = 22
    Caption = 'Max forgetting index [%]'
  end
  object Label3: TLabel
    Left = 48
    Top = 104
    Width = 106
    Height = 22
    Caption = 'Best stability'
  end
  object BestStabilityL: TLabel
    Left = 344
    Top = 104
    Width = 56
    Height = 22
    Caption = '0 days'
  end
  object Label4: TLabel
    Left = 48
    Top = 144
    Width = 168
    Height = 22
    Caption = 'Minimum repetitions'
  end
  object MinimumRepsL: TLabel
    Left = 344
    Top = 144
    Width = 11
    Height = 22
    Caption = '1'
  end
  object Label6: TLabel
    Left = 48
    Top = 184
    Width = 133
    Height = 22
    Caption = 'Samples tested'
  end
  object SamplesL: TLabel
    Left = 342
    Top = 184
    Width = 11
    Height = 22
    Caption = '0'
  end
  object Edit1: TEdit
    Left = 344
    Top = 24
    Width = 113
    Height = 30
    TabOrder = 0
    Text = '30.0'
  end
  object Edit2: TEdit
    Left = 344
    Top = 64
    Width = 113
    Height = 30
    TabOrder = 1
    Text = '25'
  end
  object Button1: TButton
    Left = 48
    Top = 224
    Width = 136
    Height = 41
    Caption = 'Simulate'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 374
    Top = 224
    Width = 147
    Height = 41
    Caption = 'Close'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 206
    Top = 224
    Width = 147
    Height = 41
    Caption = 'Stop'
    TabOrder = 4
    OnClick = Button3Click
  end
  object PopupMenu1: TPopupMenu
    Left = 464
    Top = 24
    object MIClose: TMenuItem
      Caption = 'Close'
      ShortCut = 27
      OnClick = MICloseClick
    end
  end
end
