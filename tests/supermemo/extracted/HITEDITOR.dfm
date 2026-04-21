object HitEditor: THitEditor
  Left = 404
  Top = 170
  ActiveControl = Memo1
  Caption = 'Hit-Area Editor'
  ClientHeight = 369
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = True
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Image1: TImage
    Left = 0
    Top = 69
    Width = 734
    Height = 258
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    OnMouseDown = Image1MouseDown
  end
  object Label1: TLabel
    Left = 0
    Top = 37
    Width = 734
    Height = 32
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Alignment = taCenter
    Caption = 
      'Instructions: (1) Choose the editing mode: DragMatch or HitTest,' +
      ' (2) define an area by clicking points, (3) click Copy to copy t' +
      'he coordinates to the clipboard, (4) Close the dialog and (5) pa' +
      'ste the coordinates in ScriptEditor.'
    WordWrap = True
    ExplicitWidth = 723
  end
  object Panel1: TPanel
    Left = 0
    Top = 327
    Width = 734
    Height = 42
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object ColorPanel: TPanel
      Left = 531
      Top = 5
      Width = 41
      Height = 33
      Hint = 'Color of the hit area border xored with the image'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      BevelInner = bvRaised
      TabOrder = 6
    end
    object Color: TButton
      Left = 571
      Top = 5
      Width = 72
      Height = 33
      Hint = 'Change the color of the hit area polygon'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'C&olor'
      TabOrder = 7
      OnClick = ColorClick
    end
    object Clone: TButton
      Left = 67
      Top = 5
      Width = 68
      Height = 33
      Hint = 'Convert coordinates into a hit area'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'C&lone'
      TabOrder = 1
      OnClick = CloneClick
    end
    object Copy: TButton
      Left = 135
      Top = 5
      Width = 67
      Height = 33
      Hint = 'Copy the hit area coordinates to the clipboard'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Co&py'
      TabOrder = 2
      OnClick = CopyClick
    end
    object Paste: TButton
      Left = 0
      Top = 5
      Width = 67
      Height = 33
      Hint = 
        'Paste the coordinates from the clipboard (e.g. as taken from an ' +
        'edited script command)'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&Paste'
      TabOrder = 0
      OnClick = PasteClick
    end
    object Clear: TButton
      Left = 202
      Top = 5
      Width = 67
      Height = 33
      Hint = 'Clear the hit area'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Clea&r'
      TabOrder = 3
      OnClick = ClearClick
    end
    object Close_: TButton
      Left = 269
      Top = 5
      Width = 67
      Height = 33
      Hint = 'Close the hit area editor'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Cancel = True
      Caption = '&Close'
      ModalResult = 2
      TabOrder = 4
      OnClick = Close_Click
    end
    object ComboBox1: TComboBox
      Left = 342
      Top = 8
      Width = 182
      Height = 24
      Hint = 'Choose the script command for which hit area is being defined'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 5
      Text = 'HitTest'
      OnChange = ComboBox1Change
      Items.Strings = (
        'HitTest'
        'DragMatch')
    end
    object Help: TButton
      Left = 643
      Top = 5
      Width = 84
      Height = 33
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&Help'
      TabOrder = 8
      Visible = False
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 734
    Height = 37
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Lines.Strings = (
      '')
    TabOrder = 0
  end
  object ColorDialog1: TColorDialog
    Left = 8
    Top = 192
  end
end
