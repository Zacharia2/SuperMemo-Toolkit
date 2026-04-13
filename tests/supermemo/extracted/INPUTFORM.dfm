object InputForm: TInputForm
  Left = 0
  Top = 0
  Caption = 'Sleep hours'
  ClientHeight = 319
  ClientWidth = 727
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -37
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 45
  object Label5: TLabel
    Left = 32
    Top = 64
    Width = 287
    Height = 45
    Caption = 'Start (bedtime)'
  end
  object Label6: TLabel
    Left = 32
    Top = 143
    Width = 214
    Height = 45
    Caption = 'End (wake)'
  end
  object Label1: TLabel
    Left = 392
    Top = 9
    Width = 91
    Height = 45
    Caption = 'Hour'
  end
  object Label2: TLabel
    Left = 568
    Top = 9
    Width = 129
    Height = 45
    Caption = 'Minute'
  end
  object StartHour: TEdit
    Left = 376
    Top = 60
    Width = 121
    Height = 53
    TabOrder = 0
    Text = '11'
  end
  object EndHour: TEdit
    Left = 376
    Top = 140
    Width = 121
    Height = 53
    TabOrder = 1
    Text = '11'
  end
  object StartMinute: TEdit
    Left = 568
    Top = 60
    Width = 121
    Height = 53
    TabOrder = 2
    Text = '11'
  end
  object EndMinute: TEdit
    Left = 568
    Top = 140
    Width = 121
    Height = 53
    TabOrder = 3
    Text = '11'
  end
  object BitBtn1: TBitBtn
    Left = 138
    Top = 240
    Width = 297
    Height = 65
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
  object BitBtn2: TBitBtn
    Left = 456
    Top = 240
    Width = 233
    Height = 65
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 5
  end
  object PopupMenu1: TPopupMenu
    Left = 16
    Top = 16
    object Exit1: TMenuItem
      Caption = 'Exit'
      ShortCut = 27
      OnClick = Exit1Click
    end
  end
end
