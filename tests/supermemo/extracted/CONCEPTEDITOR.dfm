object ConceptEditor: TConceptEditor
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'ConceptEditor'
  ClientHeight = 869
  ClientWidth = 1408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object TopicTemplateLabel: TLabel
    Left = 284
    Top = 214
    Width = 45
    Height = 19
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Article'
  end
  object ItemTemplateLabel: TLabel
    Left = 284
    Top = 169
    Width = 47
    Height = 19
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Classic'
  end
  object RootLabel: TLabel
    Left = 284
    Top = 79
    Width = 33
    Height = 19
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Root'
  end
  object HookLabel: TLabel
    Left = 284
    Top = 124
    Width = 37
    Height = 19
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Hook'
  end
  object TaskTemplateLabel: TLabel
    Left = 284
    Top = 259
    Width = 33
    Height = 19
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Task'
  end
  object DefaultElement: TLabel
    Left = 108
    Top = 26
    Width = 111
    Height = 19
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Default element'
  end
  object GoToConceptBtn: TSpeedButton
    Left = 28
    Top = 24
    Width = 30
    Height = 30
    Hint = 'Go to the concept element'
    OnClick = GoToConceptBtnClick
  end
  object TopicTemplateBtn: TButton
    Left = 28
    Top = 206
    Width = 225
    Height = 37
    Hint = 'Change the default topic template for the concept'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Topic template'
    TabOrder = 0
    OnClick = TopicTemplateBtnClick
  end
  object ItemTemplateBtn: TButton
    Left = 28
    Top = 160
    Width = 225
    Height = 37
    Hint = 'Change the default item template for the concept'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Item template'
    TabOrder = 1
    OnClick = ItemTemplateBtnClick
  end
  object RootBtn: TButton
    Left = 28
    Top = 70
    Width = 225
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Root element'
    TabOrder = 2
    OnClick = RootBtnClick
  end
  object HookBtn: TButton
    Left = 28
    Top = 115
    Width = 225
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Hook branch'
    TabOrder = 3
    OnClick = HookBtnClick
  end
  object TopicAutoApplyCheck: TCheckBox
    Left = 28
    Top = 360
    Width = 757
    Height = 25
    Hint = 'Decide how topic templates are applied'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    AllowGrayed = True
    Caption = 'Auto-apply topic templates'
    TabOrder = 4
    OnMouseDown = AutoApplyCheckMouseDown
  end
  object Button5: TButton
    Left = 28
    Top = 297
    Width = 225
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Default priority'
    TabOrder = 5
    OnClick = Button5Click
  end
  object PriorityEdit: TEdit
    Left = 280
    Top = 302
    Width = 135
    Height = 27
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Alignment = taCenter
    TabOrder = 6
    Text = '5.0'
    OnKeyDown = PriorityEditKeyDown
  end
  object TaskTemplateBtn: TButton
    Left = 28
    Top = 251
    Width = 225
    Height = 38
    Hint = 'Change the default concept template for the concept'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Task template'
    TabOrder = 7
    OnClick = TaskTemplateBtnClick
  end
  object ItemAutoApplyCheck: TCheckBox
    Left = 28
    Top = 408
    Width = 757
    Height = 25
    Hint = 'Decide how item templates are applied'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    AllowGrayed = True
    Caption = 'Auto-apply item template'
    TabOrder = 8
    OnMouseDown = AutoApplyCheckMouseDown
  end
  object SimilarAutoApplyCheck: TCheckBox
    Left = 28
    Top = 456
    Width = 757
    Height = 25
    Hint = 
      'Decide how derived templates are applied (e.g. picture templates' +
      ')'
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    AllowGrayed = True
    Caption = 'Auto-apply similar templates (pictures, sounds, etc.)'
    TabOrder = 9
    OnMouseDown = AutoApplyCheckMouseDown
  end
end
