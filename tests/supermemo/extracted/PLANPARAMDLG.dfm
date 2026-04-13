object PlanParamDlg: TPlanParamDlg
  Left = 424
  Top = 169
  Caption = 'Activity Options'
  ClientHeight = 459
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  PopupMode = pmAuto
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 652
    Height = 340
    Align = alClient
    ColCount = 3
    RowCount = 33
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goRowMoving, goEditing, goThumbTracking]
    TabOrder = 0
    OnKeyDown = StringGrid1KeyDown
    OnKeyPress = StringGrid1KeyPress
    OnSetEditText = StringGrid1SetEditText
  end
  object Panel1: TPanel
    Left = 0
    Top = 340
    Width = 652
    Height = 119
    Align = alBottom
    TabOrder = 1
    object Label2: TLabel
      Left = 15
      Top = 20
      Width = 89
      Height = 20
      Hint = 'Maximum length of the activity'
      Caption = '&Length (min)'
      FocusControl = LengthEdit
    end
    object Label3: TLabel
      Left = 15
      Top = 56
      Width = 76
      Height = 20
      Hint = 
        'How early should the alarm set off before the end of the activit' +
        'y'
      Caption = '&Margin (%)'
      FocusControl = MarginEdit
    end
    object Save: TSpeedButton
      Left = 591
      Top = 56
      Width = 40
      Height = 40
      Hint = 'Save activities and save the plan'
      ParentShowHint = False
      ShowHint = True
      OnClick = SaveClick
    end
    object LengthEdit: TEdit
      Left = 157
      Top = 20
      Width = 73
      Height = 28
      Hint = 'Maximum length of the activity'
      TabOrder = 0
      Text = '60'
    end
    object MarginEdit: TEdit
      Left = 157
      Top = 56
      Width = 73
      Height = 28
      Hint = 
        'How early should the alarm set off before the end of the activit' +
        'y'
      TabOrder = 1
      Text = '5'
    end
    object RadioGroup1: TRadioGroup
      Left = 244
      Top = 6
      Width = 212
      Height = 101
      Caption = 'Choice method'
      Items.Strings = (
        '&Random'
        'By &Day')
      TabOrder = 2
    end
    object OK: TBitBtn
      Left = 473
      Top = 10
      Width = 158
      Height = 40
      Caption = '&OK'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 3
      OnClick = OKClick
    end
    object Cancel: TBitBtn
      Left = 476
      Top = 56
      Width = 109
      Height = 40
      Caption = '&Cancel'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 4
      OnClick = CancelClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 160
    object CtrEPressed: TMenuItem
      Caption = 'Edit'
      Hint = 'Edit an activity'
      ShortCut = 16453
      OnClick = CtrEPressedClick
    end
    object Exit1: TMenuItem
      Caption = 'Exit'
      Hint = 'Close activity editing dialog'
      ShortCut = 27
      OnClick = Exit1Click
    end
    object EnterPressed: TMenuItem
      Caption = 'Edit invisible'
      ShortCut = 13
      Visible = False
      OnClick = EnterPressedClick
    end
  end
end
