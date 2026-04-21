object ImgDown: TImgDown
  Left = 352
  Top = 174
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Download images'
  ClientHeight = 876
  ClientWidth = 1265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 29
  object Splitter1: TSplitter
    Left = 459
    Top = 0
    Width = 8
    Height = 812
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Color = clBtnShadow
    MinSize = 45
    ParentColor = False
  end
  object ListBox1: TCheckListBox
    Left = 0
    Top = 0
    Width = 459
    Height = 812
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alLeft
    ItemHeight = 29
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = ListBox1Click
    OnClickCheck = ListBox1ClickCheck
    OnKeyPress = ListBox1KeyPress
  end
  object Panel1: TPanel
    Left = 0
    Top = 812
    Width = 1265
    Height = 64
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    TabOrder = 1
    object InsertBtn: TButton
      Left = 177
      Top = 9
      Width = 159
      Height = 50
      Hint = 
        'Import images to image registry and insert them into the current' +
        ' element'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Cancel = True
      Caption = '&Insert'
      TabOrder = 0
      OnClick = InsertBtnClick
    end
    object LocalizeBtn: TButton
      Left = 681
      Top = 6
      Width = 159
      Height = 50
      Hint = 'Convert remote images to local images'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Localize'
      TabOrder = 1
      OnClick = LocalizeBtnClick
    end
    object SelectAll: TButton
      Left = 11
      Top = 6
      Width = 157
      Height = 50
      Hint = 'Select all images'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Select &All'
      TabOrder = 2
      OnClick = SelectAllClick
    end
    object OKBtn: TButton
      Left = 851
      Top = 6
      Width = 157
      Height = 50
      Hint = 'Close this dialog without taking any action'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&OK'
      TabOrder = 3
      OnClick = OKBtnClick
    end
    object DeleteBtn: TButton
      Left = 345
      Top = 6
      Width = 158
      Height = 50
      Hint = 
        'Delete selected images from the article (from the HTML source co' +
        'de)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = '&Delete'
      TabOrder = 4
      OnClick = DeleteBtnClick
    end
    object ViewBtn: TButton
      Left = 513
      Top = 6
      Width = 161
      Height = 50
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'View'
      TabOrder = 5
      OnClick = ViewBtnClick
    end
  end
  object Panel2: TPanel
    Left = 467
    Top = 0
    Width = 798
    Height = 812
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Color = clBtnShadow
    TabOrder = 2
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 796
      Height = 576
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Proportional = True
      Stretch = True
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 786
      ExplicitHeight = 574
    end
    object DataPanel: TPanel
      Left = 1
      Top = 577
      Width = 796
      Height = 234
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alBottom
      TabOrder = 0
      object LabelX: TLabel
        Left = 14
        Top = 171
        Width = 122
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&New name:'
        FocusControl = NewName
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 71
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Name:'
      end
      object Label2: TLabel
        Left = 14
        Top = 66
        Width = 53
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Size:'
      end
      object Label3: TLabel
        Left = 14
        Top = 119
        Width = 53
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'URL:'
      end
      object NameLabel: TLabel
        Left = 216
        Top = 14
        Width = 12
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '?'
      end
      object Size: TLabel
        Left = 216
        Top = 66
        Width = 12
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '?'
      end
      object URLLabel: TLabel
        Left = 216
        Top = 119
        Width = 12
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '?'
      end
      object NewName: TEdit
        Left = 216
        Top = 161
        Width = 558
        Height = 52
        Hint = 'New name for this image'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        AutoSize = False
        TabOrder = 0
        OnExit = NewNameExit
        OnKeyPress = NewNameKeyPress
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 144
    Top = 192
    object MIEditName: TMenuItem
      Caption = 'Edit name'
      Hint = 'Editing image'#39's name'
      ShortCut = 16453
      OnClick = MIEditNameClick
    end
    object MIDelete: TMenuItem
      Caption = 'Delete'
      Hint = 'Delete current image from the HTML file'
      ShortCut = 46
      OnClick = MIDeleteClick
    end
    object MISelectAll: TMenuItem
      Caption = 'Select All'
      Hint = 'Select all images'
      ShortCut = 16449
      OnClick = SelectAllClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MIClose: TMenuItem
      Caption = 'Close'
      Hint = 'Close image downloads'
      ShortCut = 27
      OnClick = MICloseClick
    end
    object MIRename: TMenuItem
      Caption = 'Inv: Rename'
      ShortCut = 32850
      Visible = False
      OnClick = MIRenameClick
    end
  end
end
