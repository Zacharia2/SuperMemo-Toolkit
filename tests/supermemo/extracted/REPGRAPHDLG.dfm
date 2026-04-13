object RepGraphDlg: TRepGraphDlg
  Left = 388
  Top = 204
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Repetitions graph'
  ClientHeight = 514
  ClientWidth = 768
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 8
    Top = 8
    Width = 751
    Height = 466
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Color = clLime
    ParentColor = False
    OnPaint = PaintBox1Paint
  end
  object CloseBtn: TButton
    Left = 685
    Top = 479
    Width = 75
    Height = 31
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Cancel = True
    Caption = '&Close'
    ModalResult = 2
    TabOrder = 0
    OnClick = CloseBtnClick
  end
  object Resume: TButton
    Left = 605
    Top = 479
    Width = 76
    Height = 31
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Resume'
    TabOrder = 1
    Visible = False
  end
  object Stop: TButton
    Left = 524
    Top = 479
    Width = 76
    Height = 31
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'St&op'
    TabOrder = 2
    Visible = False
  end
  object Start: TButton
    Left = 443
    Top = 479
    Width = 76
    Height = 31
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Start'
    TabOrder = 3
    Visible = False
  end
end
