object ProgressBox: TProgressBox
  Left = 501
  Top = 298
  Cursor = crHourGlass
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  VertScrollBar.Visible = False
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Progress'
  ClientHeight = 353
  ClientWidth = 1151
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 29
  object Passed_: TLabel
    Left = 12
    Top = 113
    Width = 58
    Height = 29
    Caption = 'Done'
    Color = clBtnFace
    ParentColor = False
  end
  object ToDo_: TLabel
    Left = 12
    Top = 161
    Width = 64
    Height = 29
    Caption = 'To do'
    Color = clBtnFace
    ParentColor = False
  end
  object Total_: TLabel
    Left = 12
    Top = 209
    Width = 55
    Height = 29
    Caption = 'Total'
    Color = clBtnFace
    ParentColor = False
  end
  object Passed: TLabel
    Left = 479
    Top = 113
    Width = 13
    Height = 29
    Alignment = taRightJustify
    Caption = '0'
    Color = clBtnFace
    ParentColor = False
  end
  object ToDo: TLabel
    Left = 479
    Top = 161
    Width = 13
    Height = 29
    Alignment = taRightJustify
    Caption = '0'
    Color = clBtnFace
    ParentColor = False
  end
  object Total: TLabel
    Left = 383
    Top = 209
    Width = 109
    Height = 29
    Alignment = taRightJustify
    Caption = 'Searching'
    Color = clBtnFace
    ParentColor = False
  end
  object PaintBox1: TPaintBox
    Left = 12
    Top = 3
    Width = 1113
    Height = 51
    Cursor = crHourGlass
    Color = clBtnShadow
    ParentColor = False
    OnPaint = PaintBox1Paint
  end
  object MemoryLabel: TLabel
    Left = 416
    Top = 288
    Width = 138
    Height = 29
    Caption = 'Memory use:'
    Color = clBtnFace
    ParentColor = False
  end
  object Memory: TLabel
    Left = 651
    Top = 288
    Width = 13
    Height = 29
    Caption = '0'
    Color = clBtnFace
    ParentColor = False
  end
  object CountLabel: TLabel
    Left = 12
    Top = 288
    Width = 72
    Height = 29
    Caption = 'Errors:'
    Color = clBtnFace
    ParentColor = False
  end
  object CountValue: TLabel
    Left = 257
    Top = 288
    Width = 13
    Height = 29
    Caption = '0'
    Color = clBtnFace
    ParentColor = False
  end
  object Panel2: TPanel
    Left = 527
    Top = 104
    Width = 598
    Height = 156
    Cursor = crHourGlass
    Color = clBtnShadow
    TabOrder = 0
    object TimePassed_: TLabel
      Left = 20
      Top = 12
      Width = 149
      Height = 29
      Caption = 'Time elapsed'
      Color = clBtnShadow
      ParentColor = False
    end
    object TimeLeft_: TLabel
      Left = 20
      Top = 57
      Width = 94
      Height = 29
      Caption = 'Time left'
      Color = clBtnShadow
      ParentColor = False
    end
    object TimePassed: TLabel
      Left = 353
      Top = 12
      Width = 39
      Height = 29
      Caption = '000'
    end
    object TimeLeft: TLabel
      Left = 353
      Top = 57
      Width = 39
      Height = 29
      Caption = '000'
    end
    object TimeExpected_: TLabel
      Left = 20
      Top = 104
      Width = 161
      Height = 29
      Caption = 'Time expected'
      Color = clBtnShadow
      ParentColor = False
    end
    object TimeExpected: TLabel
      Left = 353
      Top = 104
      Width = 39
      Height = 29
      Caption = '000'
    end
  end
  object Cancel: TBitBtn
    Left = 840
    Top = 267
    Width = 285
    Height = 75
    Cursor = crArrow
    Enabled = False
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
    OnClick = CancelClick
  end
  object ReportLabel: TPanel
    Left = 11
    Top = 51
    Width = 1113
    Height = 47
    Cursor = crHourGlass
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = 'Please wait ...'
    Color = clWindow
    TabOrder = 2
  end
end
