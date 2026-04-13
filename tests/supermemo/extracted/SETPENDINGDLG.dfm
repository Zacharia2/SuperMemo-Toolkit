object SetPendingDlg: TSetPendingDlg
  Left = 474
  Top = 254
  ActiveControl = PlacementEdit
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Pending queue'
  ClientHeight = 372
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 24
  object Bevel1: TBevel
    Left = 12
    Top = 81
    Width = 362
    Height = 223
  end
  object PendingSizeLabel: TLabel
    Left = 23
    Top = 23
    Width = 189
    Height = 24
    Caption = 'Pending queue size: 1'
  end
  object Label2: TLabel
    Left = 23
    Top = 105
    Width = 119
    Height = 24
    Caption = 'Place&ment [%]'
    FocusControl = PlacementEdit
  end
  object Label3: TLabel
    Left = 23
    Top = 215
    Width = 151
    Height = 24
    Caption = '&Position in queue:'
    FocusControl = PositionEdit
  end
  object BitBtn2: TBitBtn
    Left = 233
    Top = 315
    Width = 141
    Height = 48
    Hint = 'Cancel the selection'
    Caption = '&Cancel'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 0
  end
  object OK: TBitBtn
    Left = 81
    Top = 315
    Width = 141
    Height = 48
    Hint = 'Accept the currently selected interval'
    Caption = '&OK'
    Default = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
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
    TabOrder = 1
  end
  object PlacementEdit: TEdit
    Left = 23
    Top = 147
    Width = 340
    Height = 32
    TabOrder = 2
    Text = '100'
    OnChange = PlacementEditChange
  end
  object PositionEdit: TEdit
    Left = 23
    Top = 256
    Width = 340
    Height = 32
    TabOrder = 3
    Text = '1'
    OnChange = PositionEditChange
  end
end
