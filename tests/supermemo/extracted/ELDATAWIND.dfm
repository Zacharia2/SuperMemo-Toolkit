object ElDataWind: TElDataWind
  Left = -5000
  Top = 219
  HelpContext = 15
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  HorzScrollBar.Visible = False
  Caption = 'Element data'
  ClientHeight = 359
  ClientWidth = 1818
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -23
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    7777777077777777077777777700000000000077000000077000000077700008
    88888800FFFFFFF00FFFFFFF0770008888888880FFFFFFFF0FFFFFFFF0700888
    8888888800000000000000000070088888888888888888888888888880700000
    000000000000000000000000007008880FFFFF8FFFFF8FFFFF8FFFFFF0700888
    0FFFFF8FFFFF8FFFFF8FFFFFF070000008888888888888888888888880700888
    0FFFFF8FFFFF8FFFFF8FFFFFF07008880FFFFF8FFFFF8FFFFF8FFFFFF0700000
    088888888888888888888888807008880FFFFF8FFFFF8FFFFF8FFFFFF0700888
    0FFFFF8FFFFF8FFFFF8FFFFFF070000008888888888888888888888880700888
    0FFFFF8FFFFF8FFFFF8FFFFFF07008880FFFFF8FFFFF8FFFFF8FFFFFF0700000
    088888888888888888888888807008880FFFFF8FFFFF8FFFFF8FFFFFF0700888
    0FFFFF8FFFFF8FFFFF8FFFFFF070000000000000000000000000000000700888
    0888880888880888880888888070088808888808888808888808888880000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0100803E0000001C0000001800000010000
    0001000000010000000100000001000000010000000100000001000000010000
    0001000000010000000100000001000000010000000100000001000000010000
    000100000001000000010000000300000003FFFFFFFFFFFFFFFFFFFFFFFF}
  KeyPreview = True
  PopupMenu = PopupMenu1
  PopupMode = pmAuto
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 144
  TextHeight = 20
  object SM17Stats: TCategoryButtons
    Left = 0
    Top = 0
    Width = 1818
    Height = 359
    HelpContext = 15
    Align = alClient
    BackgroundGradientColor = clBlue
    BackgroundGradientDirection = gdVertical
    ButtonFlow = cbfHorizontal
    ButtonHeight = 30
    ButtonWidth = 207
    ButtonOptions = [boGradientFill, boShowCaptions, boVerticalCategoryCaptions, boUsePlusMinus, boCaptionOnlyBorder]
    Categories = <
      item
        Caption = 'Priority'
        Color = 16771818
        Collapsed = False
        Items = <
          item
            Caption = 'Priority'
            ImageIndex = 138
          end
          item
            Caption = 'Position'
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end>
      end
      item
        Caption = 'Dates'
        Color = 15466474
        Collapsed = False
        Items = <
          item
            Caption = 'Last'
          end
          item
            Caption = 'Next'
          end
          item
            Caption = 'First'
          end
          item
          end
          item
          end
          item
          end
          item
          end>
      end
      item
        Caption = 'Interval'
        Color = 15395839
        Collapsed = False
        Items = <
          item
            Caption = 'Interval'
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end>
      end
      item
        Caption = 'DSR Stats'
        Color = 16777194
        Collapsed = False
        Items = <
          item
            Caption = 'Stability'
            Hint = 'Memory stability expressed as optimum interval'
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end>
      end
      item
        Caption = 'Repetitions'
        Color = 16053492
        Collapsed = False
        Items = <
          item
            Caption = 'Repetitions'
          end
          item
            Caption = 'Lapses'
          end
          item
            Caption = 'Future reps'
          end
          item
          end
          item
          end
          item
          end
          item
          end>
      end
      item
        Caption = 'Difficulty'
        Color = 16771818
        Collapsed = False
        Items = <
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end>
      end
      item
        Caption = 'Status'
        Color = 15395839
        Collapsed = False
        Items = <
          item
            Caption = 'Grade'
          end
          item
            Caption = 'FI'
          end
          item
            Caption = 'Ordinal'
          end
          item
          end
          item
          end
          item
          end
          item
          end>
      end>
    Color = 16756398
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Microsoft YaHei'
    Font.Style = []
    Images = ElWind.ImageList1
    PopupMenu = PopupMenu1
    RegularButtonColor = clWhite
    SelectedButtonColor = 16745604
    ShowHint = True
    TabOrder = 0
    OnButtonClicked = SM17StatsButtonClicked
    OnCategoryCollapase = SM17StatsCategoryCollapase
    OnKeyDown = SM17StatsKeyDown
    OnMouseMove = SM17StatsMouseMove
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 1120
    Top = 16
    object MIDifficulty: TMenuItem
      Caption = '&Difficulty'
      Hint = 'Show the estimation of element'#39's difficulty'
      OnClick = MIDifficultyClick
    end
    object MIRestoreLayout: TMenuItem
      Caption = '&Restore layout'
      ShortCut = 16500
      OnClick = MIRestoreLayoutClick
    end
    object Classiclayout1: TMenuItem
      Caption = '&Classic layout'
      ShortCut = 116
      OnClick = Classiclayout1Click
    end
    object MIBringUpTheElementWindow: TMenuItem
      Caption = '&Element window'
      Hint = 'Shift focus to the element window'
      ShortCut = 27
      OnClick = MIBringUpTheElementWindowClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MIFormatIntervals: TMenuItem
      Caption = 'Format intervals'
      Checked = True
      Hint = 'Format intervals as years, months, days, etc.'
      OnClick = MIFormatIntervalsClick
    end
  end
end
