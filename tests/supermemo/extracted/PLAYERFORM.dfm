object PlayerForm: TPlayerForm
  Left = 592
  Top = 299
  Hint = 'Player component'
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'PlayerForm'
  ClientHeight = 475
  ClientWidth = 653
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBar: TPaintBox
    Left = 0
    Top = 320
    Width = 653
    Height = 43
    Hint = 'Rewind bar'
    Align = alBottom
    Color = clBlue
    ParentColor = False
    Visible = False
    OnDblClick = PaintBarDblClick
    OnMouseDown = PaintBarMouseDown
    OnPaint = PaintBarPaint
  end
  object RecorderPanel: TPanel
    Left = 0
    Top = 423
    Width = 653
    Height = 30
    Hint = 'Sound recorder'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    PopupMenu = ElWind.ComponentMenu
    TabOrder = 0
    Visible = False
    OnContextPopup = PlayerContextPopup
    object OPlay: TSpeedButton
      Left = 0
      Top = 0
      Width = 24
      Height = 27
      Hint = 'Play the original sound associated with the sound component'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Glyph.Data = {
        72010000424D7201000000000000760000002800000015000000150000000100
        040000000000FC00000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777770007777777777777777777770007777777777777777777770007777
        77777777777777777000777777F77777777777777000777778AFF77777777777
        7000777778AAAFF7777777777000777778AAAAAFF77777777000777778AAAAAA
        AFF777777000777778AAAAAAAAAFF7777000777778AAAAAAAAA88F7770007777
        78AAAAAAA88777777000777778AAAAA8877777777000777778AAA88777777777
        7000777778A88777777777777000777778877777777777777000777777777777
        7777777770007777777777777777777770007777777777777777777770007777
        77777777777777777000777777777777777777777000}
      ParentShowHint = False
      PopupMenu = ElWind.ComponentMenu
      ShowHint = True
      OnClick = OPlayClick
      OnMouseDown = PlayerButtonPopUp
    end
    object UPlay: TSpeedButton
      Left = 22
      Top = 0
      Width = 24
      Height = 27
      Hint = 
        'Play the sound recorded by the user (for comparison with the ori' +
        'ginal sound)'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Glyph.Data = {
        72010000424D7201000000000000760000002800000015000000150000000100
        040000000000FC00000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777770007777777777777777777770007777777777777777777770007777
        77777777777777777000777777F77777777777777000777778CFF77777777777
        7000777778CCCFF7777777777000777778CCCCCFF77777777000777778CCCCCC
        CFF777777000777778CCCCCCCCCFF7777000777778CCCCCCCCC88F7770007777
        78CCCCCCC88777777000777778CCCCC8877777777000777778CCC88777777777
        7000777778C88777777777777000777778877777777777777000777777777777
        7777777770007777777777777777777770007777777777777777777770007777
        77777777777777777000777777777777777777777000}
      ParentShowHint = False
      PopupMenu = ElWind.ComponentMenu
      ShowHint = True
      OnClick = UPlayClick
      OnMouseDown = PlayerButtonPopUp
    end
    object URecord: TSpeedButton
      Left = 45
      Top = 0
      Width = 24
      Height = 27
      Hint = 'Record sound for comparison with the original recording'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      AllowAllUp = True
      GroupIndex = 1
      Glyph.Data = {
        72010000424D7201000000000000760000002800000015000000150000000100
        040000000000FC00000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777077
        7700000770007777777778070077770770007777777777000777770770007777
        77777777777770777000777777777777777007777000777777777777770B0777
        7000777777777777000077777000777777777770BB077777700077777777770B
        B007777770007777777770BB007777777000777777770BB00777777770007777
        7770BB007777777770007777770BB007777777777000777000BB007777777777
        70007700A0000777777777777000700A6600777777777777700000A666607777
        7777777770000A66660077777777777770000006600777777777777770007706
        00777777777777777000770007777777777777777000}
      ParentShowHint = False
      PopupMenu = ElWind.ComponentMenu
      ShowHint = True
      OnClick = URecordClick
      OnMouseDown = PlayerButtonPopUp
    end
    object UCancel: TSpeedButton
      Left = 68
      Top = 0
      Width = 24
      Height = 27
      Hint = 'Delete recorded file (if any)'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Glyph.Data = {
        72010000424D7201000000000000760000002800000015000000150000000100
        040000000000FC00000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFF0000FFFFFF000FFFF
        FFFFF0077880FFFFF000FFFFFFF007777880FFFFF000FFFFF00772777880FFFF
        F000FFFFF877222278880FFFF000FFFFF872727278880FFFF000FFFF87727777
        78880FFFF000FFFF8722272278880FFFF000FFFF87727722788880FFF000FFFF
        877722FFFF8880FFF000FFF87777FF8888FF80FFF000FFF877FF88F8FF8FF0FF
        F000FFF8FF88FFF8FF888FFFF000FFF888FFFF8FFF8FFFFFF000FFFFF88FF8FF
        88FFFFFFF000FFFFFFF88F88FFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFF
        FFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000}
      ParentShowHint = False
      PopupMenu = ElWind.ComponentMenu
      ShowHint = True
      OnClick = UCancelClick
      OnMouseDown = PlayerButtonPopUp
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 256
    Width = 653
    Height = 64
    Hint = 'Sound text'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BorderStyle = bsNone
    Color = clWhite
    PopupMenu = ElWind.ComponentMenu
    TabOrder = 1
    Visible = False
    StyleElements = []
  end
  object SliderPanel: TPanel
    Left = 0
    Top = 393
    Width = 653
    Height = 30
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 2
    Visible = False
    object ThreeButtonPanel: TPanel
      Left = 1
      Top = 1
      Width = 70
      Height = 28
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      TabOrder = 0
      object SliderPause: TSpeedButton
        Left = 23
        Top = 0
        Width = 23
        Height = 27
        Hint = 'Pause playing sound or video'
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Glyph.Data = {
          6E020000424D6E0200000000000076000000280000002A000000150000000100
          040000000000F801000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888888888888880000008888888888888888888888888888
          8888888888888800000088888888888888888888888888888888888888888800
          0000888888888888888888888888888888888888888888000000888888888888
          8888888888888888888888888888880000008888887FFF87FFF8888888888880
          FFF80FFF8888880000008888887BBF87BBF888888888888077F8077F88888800
          00008888887BBF87BBF888888888888077F8077F8888880000008888887BBF87
          BBF888888888888077F8077F8888880000008888887BBF87BBF8888888888880
          77F8077F8888880000008888887BBF87BBF888888888888077F8077F88888800
          00008888887BBF87BBF888888888888077F8077F8888880000008888887BBF87
          BBF888888888888077F8077F8888880000008888887BBF87BBF8888888888880
          77F8077F8888880000008888887BBF87BBF888888888888077F8077F88888800
          00008888887BBF87BBF888888888888077F8077F888888000000888888777F87
          77F888888888888000F8000F8888880000008888888888888888888888888888
          8888888888888800000088888888888888888888888888888888888888888800
          0000888888888888888888888888888888888888888888000000888888888888
          888888888888888888888888888888000000}
        NumGlyphs = 2
        ParentShowHint = False
        PopupMenu = ElWind.ComponentMenu
        ShowHint = True
        OnClick = SliderPauseClick
        OnMouseDown = PlayerButtonPopUp
      end
      object SliderStop: TSpeedButton
        Left = 46
        Top = 0
        Width = 22
        Height = 27
        Hint = 'Stop playing and rewind to the beginning'
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Glyph.Data = {
          6E020000424D6E0200000000000076000000280000002A000000150000000100
          040000000000F801000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888888888888880000008888888888888888888888888888
          8888888888888800000088888888888888888888888888888888888888888800
          0000888888888888888888888888888888888888888888000000888888888888
          88888888888888888888888888888800000088888FFFFFFFFFFFF888888888FF
          FFFFFFFFFF88880000008888799999999999F88888888077777777777F888800
          00008888799999999999F88888888077777777777F8888000000888879999999
          9999F88888888077777777777F88880000008888799999999999F88888888077
          777777777F88880000008888799999999999F88888888077777777777F888800
          00008888799999999999F88888888077777777777F8888000000888879999999
          9999F88888888077777777777F88880000008888799999999999F88888888077
          777777777F888800000088887777777777778888888880000000000008888800
          0000888888888888888888888888888888888888888888000000888888888888
          8888888888888888888888888888880000008888888888888888888888888888
          8888888888888800000088888888888888888888888888888888888888888800
          0000888888888888888888888888888888888888888888000000888888888888
          888888888888888888888888888888000000}
        NumGlyphs = 2
        ParentShowHint = False
        PopupMenu = ElWind.ComponentMenu
        ShowHint = True
        OnClick = SliderStopClick
        OnMouseDown = PlayerButtonPopUp
      end
      object SliderPlay: TSpeedButton
        Left = 0
        Top = 0
        Width = 23
        Height = 27
        Hint = 'Play the sound or video'
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Glyph.Data = {
          6E020000424D6E0200000000000076000000280000002A000000150000000100
          040000000000F801000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888888888888880000008888888888888888888888888888
          8888888888888800000088888888888888888888888888888888888888888800
          0000888888888888888888888888888888888888888888000000888888F88888
          888888888888888F88888888888888000000888887AFF8888888888888888807
          FF888888888888000000888887AAAFF8888888888888880777FF888888888800
          0000888887AAAAAFF8888888888888077777FF88888888000000888887AAAAAA
          AFF8888888888807777777FF888888000000888887AAAAAAAAAFF88888888807
          77777777FF8888000000888887AAAAAAAAA77F88888888077777777700F88800
          0000888887AAAAAAA77888888888880777777700888888000000888887AAAAA7
          788888888888880777770088888888000000888887AAA7788888888888888807
          77008888888888000000888887A7788888888888888888070088888888888800
          0000888887788888888888888888880088888888888888000000888888888888
          8888888888888888888888888888880000008888888888888888888888888888
          8888888888888800000088888888888888888888888888888888888888888800
          0000888888888888888888888888888888888888888888000000888888888888
          888888888888888888888888888888000000}
        NumGlyphs = 2
        ParentShowHint = False
        PopupMenu = ElWind.ComponentMenu
        ShowHint = True
        OnClick = SliderPlayClick
        OnMouseDown = PlayerButtonPopUp
      end
    end
    object SliderBar: TTrackBar
      Left = 73
      Top = 4
      Width = 522
      Height = 22
      Hint = 'Playback position'
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Ctl3D = False
      ParentCtl3D = False
      ParentShowHint = False
      PopupMenu = ElWind.ComponentMenu
      ShowHint = True
      TabOrder = 1
      ThumbLength = 30
      OnContextPopup = PlayerContextPopup
      OnChange = SliderBarChange
    end
  end
  object ExtractPanel: TToolBar
    Left = 0
    Top = 453
    Width = 653
    Height = 22
    Align = alBottom
    AutoSize = True
    ButtonWidth = 93
    Images = AboutBox.ImageList1
    List = True
    PopupMenu = ExtractorMenu
    ShowCaptions = True
    AllowTextButtons = True
    TabOrder = 3
    Visible = False
    Wrapable = False
    object PlayPause: TToolButton
      Left = 0
      Top = 0
      Hint = 
        'Pause or restart the playback (the number shows the playback pos' +
        'ition in seconds)'
      Caption = '23:24'
      ImageIndex = 45
      PopupMenu = ExtractorMenu
      Style = tbsTextButton
      OnClick = PlayPauseClick
    end
    object ToolButton14: TToolButton
      Left = 58
      Top = 0
      Width = 8
      Caption = 'ToolButton14'
      ImageIndex = 17
      Style = tbsSeparator
    end
    object StartBtn: TToolButton
      Left = 66
      Top = 0
      Hint = 
        'Mark the start of a playback selection (the number shows the sel' +
        'ected position in seconds)'
      Caption = 'Start'
      Style = tbsTextButton
      OnClick = StartBtnClick
    end
    object GoToStart: TToolButton
      Left = 99
      Top = 0
      Hint = 'Go to the start position of the current extract'
      Caption = 'GoToStart'
      ImageIndex = 56
      OnClick = GoToStartClick
    end
    object StartUpDown: TUpDown
      Left = 123
      Top = 0
      Width = 21
      Height = 22
      Hint = 'Increment or decrement the start position of the playback'
      TabOrder = 0
      OnChangingEx = StartUpDownChangingEx
    end
    object ToolButton10: TToolButton
      Left = 144
      Top = 0
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 17
      Style = tbsSeparator
    end
    object EndBtn: TToolButton
      Left = 152
      Top = 0
      Hint = 
        'Mark the end of a playback selection (the number shows the selec' +
        'ted position in seconds)'
      Caption = 'End'
      Style = tbsTextButton
      OnClick = EndBtnClick
    end
    object GoToEnd: TToolButton
      Left = 182
      Top = 0
      Hint = 'Go to the end position of the current extract'
      Caption = 'GoToEnd'
      ImageIndex = 56
      OnClick = GoToEndClick
    end
    object EndUpDown: TUpDown
      Left = 206
      Top = 0
      Width = 21
      Height = 22
      Hint = 'Increment or decrement the end position of the playback'
      TabOrder = 1
      OnChangingEx = EndUpDownChangingEx
    end
    object ToolButton13: TToolButton
      Left = 227
      Top = 0
      Width = 8
      Caption = 'ToolButton13'
      ImageIndex = 17
      Style = tbsSeparator
    end
    object MenuBtn: TToolButton
      Left = 235
      Top = 0
      Hint = 'Open the extractor menu'
      Caption = 'MenuBtn'
      ImageIndex = 4
      PopupMenu = ExtractorMenu
      OnClick = MenuBtnClick
    end
    object Extract: TToolButton
      Left = 259
      Top = 0
      Hint = 
        'Create a new element that would always play only a portion of th' +
        'e file from Start to End'
      Caption = 'Extract'
      ImageIndex = 144
      Style = tbsTextButton
      OnClick = ExtractClick
    end
    object ToolButton12: TToolButton
      Left = 323
      Top = 0
      Width = 8
      Caption = 'ToolButton12'
      ImageIndex = 17
      Style = tbsSeparator
    end
    object Test: TToolButton
      Left = 331
      Top = 0
      Hint = 'Test the playback of the section marked by Start and End'
      Caption = 'Test'
      Style = tbsTextButton
      OnClick = TestClick
    end
    object ToolButton15: TToolButton
      Left = 363
      Top = 0
      Width = 8
      Caption = 'ToolButton15'
      ImageIndex = 17
      Style = tbsSeparator
    end
    object Reset: TToolButton
      Left = 371
      Top = 0
      Hint = 
        'Reset the selection (i.e. set Start and End to enclose the entir' +
        'e file)'
      ImageIndex = 173
      OnClick = ResetClick
    end
    object FullScreenBtn: TToolButton
      Left = 395
      Top = 0
      Hint = 'Play the video in the whole area of the component (maximize)'
      Caption = 'FullScreenBtn'
      ImageIndex = 189
      Style = tbsCheck
      OnClick = FullScreenBtnClick
    end
    object ToolButton16: TToolButton
      Left = 419
      Top = 0
      Width = 8
      Caption = 'ToolButton16'
      ImageIndex = 17
      Style = tbsSeparator
      Visible = False
    end
  end
  object MediaPlayer1: TMediaPlayer
    Left = 7
    Top = 31
    Width = 253
    Height = 24
    Hint = 'Media player'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    AutoEnable = False
    AutoRewind = False
    DoubleBuffered = True
    Display = VideoPanel
    Visible = False
    ParentDoubleBuffered = False
    PopupMenu = ElWind.ComponentMenu
    TabOrder = 4
    OnClick = MediaPlayer1Click
  end
  object ExtractBar: TTrackBar
    Left = 0
    Top = 363
    Width = 653
    Height = 30
    Hint = 'Playback position'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    PageSize = 1
    PopupMenu = ElWind.ComponentMenu
    TabOrder = 5
    ThumbLength = 30
    Visible = False
    OnContextPopup = PlayerContextPopup
    OnChange = ExtractBarChange
    OnKeyDown = ExtractBarKeyDown
  end
  object VideoPanel: TPanel
    Left = 168
    Top = 192
    Width = 337
    Height = 41
    TabOrder = 6
  end
  object ExtractorMenu: TPopupMenu
    Left = 120
    Top = 125
    object ResetStart1: TMenuItem
      Caption = 'Reset Start'
      OnClick = ResetStart1Click
    end
    object ResetEnd1: TMenuItem
      Caption = 'Reset End'
      OnClick = ResetEnd1Click
    end
    object ChooseStart1: TMenuItem
      Caption = 'Choose Start'
      Visible = False
    end
    object ChooseEnd1: TMenuItem
      Caption = 'Choose End'
      Visible = False
    end
    object Frameback1: TMenuItem
      Caption = 'Frame back'
      Hint = 'Move one frame back if the video is paused and has focus'
      ShortCut = 37
      OnClick = Frameback1Click
    end
    object Frameforward1: TMenuItem
      Caption = 'Frame forward'
      Hint = 'Move one frame forward if the video is paused and has focus'
      ShortCut = 39
      OnClick = Frameforward1Click
    end
    object Stepback1: TMenuItem
      Caption = 'Step back'
      Visible = False
    end
    object Stepforward1: TMenuItem
      Caption = 'Step forward'
      Visible = False
    end
    object Framesperstep1: TMenuItem
      Caption = 'Frames per step'
      Visible = False
    end
  end
  object PlayerTimer: TTimer
    Enabled = False
    Interval = 300
    OnTimer = PlayerTimerTimer
    Left = 295
    Top = 127
  end
end
