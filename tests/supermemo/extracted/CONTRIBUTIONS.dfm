object Contributions: TContributions
  Left = 444
  Top = 129
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Contributions'
  ClientHeight = 589
  ClientWidth = 685
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBtnText
  Font.Height = -17
  Font.Name = 'Microsoft YaHei'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 20
  object Label1: TLabel
    Left = 18
    Top = 20
    Width = 663
    Height = 31
    Alignment = taCenter
    AutoSize = False
    Caption = 'SuperMemo 19 Contributions: 1987-2025'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -24
    Font.Name = 'Microsoft YaHei'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 221
    Top = 560
    Width = 248
    Height = 16
    Cursor = crHandPoint
    Caption = 'SuperMemo learning material contributors'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -15
    Font.Name = 'Microsoft YaHei'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label2Click
  end
  object Cancel: TBitBtn
    Left = 552
    Top = 388
    Width = 1
    Height = 1
    Cancel = True
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 8
    Top = 65
    Width = 665
    Height = 489
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -20
    Font.Name = 'Microsoft YaHei'
    Font.Style = []
    Lines.Strings = (
      'Design: Dr Piotr Wozniak, SuperMemo R&D, SuperMemo Library, '
      'SuperMemo World, and users of SuperMemo'
      ''
      
        'Software: Delphi XE3, Embarcadero’s Technologies, USA. Formerly:' +
        ' '
      
        'Delphi 1.0, Delpi 3.0, Delphi 4.0, Delphi 5.0, Delphi 6.0, Delph' +
        'i 2005, '
      'Delphi 2006 (by Borland and CodeGear), Delphi 2010, Delphi XE3, '
      'Delphi XE7, Delphi 10.2 (by Embarcadero)'
      ''
      
        'Some code derived from SuperMemo 7 written in Borland Pascal 7.0' +
        '.'
      
        'DOS versions were originally written in Turbo Pascal 3.0, 4.0 an' +
        'd 6.0.'
      ''
      'Delphi SuperMemo Development Spots:'
      '"Gorska Perla" in the Bystrzyckie Mountains, Nowa Wies (1995)'
      'Strzeszynek lakeside near Poznan (1996)'
      'SuperMemo World (1996-1997)'
      'SuperMemo Research (1997-2002)'
      '"Kolo" resort (2003-present)'
      ''
      
        'SuperMemo repetition spacing technology: Dr P. A. Wozniak, Polan' +
        'd, '
      '1982-2012 (major contributors: Dr E. Gorzelanczyk, Dr J.'
      'Murakowski, A. Blazejewski)'
      ''
      'Programming: Piotr Wozniak (chief programmer), Miko Hejwosz '
      '(SuperMemo Install Wizard, incremental video, '
      
        'CSS, plan scheduler), Oliwer Ptak (browsers), Anders Melander (G' +
        'IF '
      'images), Finn Tolderlund (GIF animations), '
      'Sven Lohmann (MapiControl), Robert Chandler (HTML Viewer), Brad '
      'Stowers (directory browser), Zoran Maximovic (XML, MSHTML), '
      'UtilMind (HTTP downloads), Gustavo Huffenbacher Daud (PNG), Per '
      'Linds'#248' Larsen and Christian Lovis (Internet Cache), '
      ''
      
        'Mike Lischke (TVirtualTree), Microsoft (TWebBrowser, UI Automati' +
        'on), '
      'and more.'
      ''
      
        'Contributors to previous versions (programming): Access Softek (' +
        'rich '
      
        'text editing), Janick Fortin (GIF format), Raymond Bell (Tip of ' +
        'the Day),'
      
        'Stanley Fischer (internationalization), Bartosz Dreger (neural n' +
        'etwork '
      'plug-in), Piotr Metzler (DLL interface), Andrzej Lapa (DLLs and'
      
        'add-ins), Grzegorz Malewski (installer), Zoran Maximovic (Quizer' +
        '), '
      'Vimas International (sound compression).'
      ''
      
        'Graphic design: A. Jablonski, O. Ptak, R. Sniegowski, P. Szczuko' +
        ' '
      '(Einstein in Genius 1.0), P. Maksimczyk, M. Hejwosz'
      ''
      'Video Clips: O.Ptak, K.Biedalak'
      ''
      'Music: Break Band, 1983, Mr Zoob, 1997'
      ''
      
        'Special thanks for unusual and lasting contribution to SuperMemo' +
        ':'
      'M. Hejwosz, Dr J. Murakowski, K. Biedalak, William Palace, M. '
      'Morawska, D. '
      'Murakowski, Dr E. Gorzelanczyk, P. Glowacki, T. Szynalski, K. '
      'Wojcieszek, '#11
      
        'Dr W. Abramowicz, Alexis, M. Georgiew, Z. Maximovic, P. Bajer, P' +
        '. '
      'Wimmer, J. Ast, '#11
      'Luis Gustavo Neves da Silva, M. Butrymowicz, M. Newcomer, B. '
      'Kowalewski, '
      
        'V. Losik, A. Horodenski, A. Lapa, S. Fischer, B. Dreger, F. Kier' +
        'zek, '
      'Dr Z. Kierzkowski, P. Maksimczyk, T. Kuehn, K. Kowalczyk, '
      
        'T.Chodakowski, K. Chodakowski, S. Chodakowski, and ... too many ' +
        'to '
      'list.'
      ''
      
        'Neural Network plug-in: B. Dreger, P. Wierzejewski, T. Biedka, K' +
        '. '
      
        'Kachlicki, M. Plazewski, P. Wozniak, K. Krawiec (Institute of Co' +
        'mputer'
      'Science, Technical University of Poznan)')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
