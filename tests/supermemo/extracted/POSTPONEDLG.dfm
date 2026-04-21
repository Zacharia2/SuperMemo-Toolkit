object PostponeDlg: TPostponeDlg
  Left = 914
  Top = 360
  HelpContext = 26
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Postpone Repetitions'
  ClientHeight = 864
  ClientWidth = 1130
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 29
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1130
    Height = 864
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ActivePage = Adjust
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    object Scope: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Scope'
      object ScopeGroup: TRadioGroup
        Left = 21
        Top = 27
        Width = 1068
        Height = 248
        Hint = 'Select the group of elements on which Postpone will be executed'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Subset'
        ItemIndex = 0
        Items.Strings = (
          'All outstanding repetitions'
          'Selected branch or concept'
          'Current browser')
        TabOrder = 0
        OnClick = ScopeGroupClick
      end
      object GroupBox1: TGroupBox
        Left = 21
        Top = 489
        Width = 1068
        Height = 227
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Settings'
        TabOrder = 1
        object Label1: TLabel
          Left = 12
          Top = 113
          Width = 153
          Height = 29
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Branch scope:'
        end
        object Label11: TLabel
          Left = 12
          Top = 50
          Width = 71
          Height = 29
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Name:'
        end
        object BranchScope: TEdit
          Left = 224
          Top = 108
          Width = 823
          Height = 37
          Hint = 'Name of the branch to postpone'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Color = clBtnFace
          Enabled = False
          TabOrder = 0
        end
        object ComboBox1: TComboBox
          Left = 224
          Top = 41
          Width = 823
          Height = 37
          Hint = 'Change the postpone settings for the selected branch'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabOrder = 1
          OnChange = ComboBox1Change
        end
        object Save: TButton
          Left = 458
          Top = 162
          Width = 190
          Height = 50
          Hint = 'Save the current settings for the currently selected branch'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Save'
          TabOrder = 2
          OnClick = SaveClick
        end
        object Delete: TButton
          Left = 854
          Top = 162
          Width = 190
          Height = 50
          Hint = 'Delete the currently selected branch settings'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Delete'
          TabOrder = 3
          OnClick = DeleteClick
        end
        object Default: TButton
          Left = 656
          Top = 162
          Width = 189
          Height = 50
          Hint = 'Save the current setting as default branch settings'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Default'
          TabOrder = 4
          OnClick = DefaultClick
        end
        object ChangeBranch: TButton
          Left = 260
          Top = 162
          Width = 189
          Height = 50
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Change'
          TabOrder = 5
          Visible = False
        end
      end
      object MethodGroup: TRadioGroup
        Left = 21
        Top = 284
        Width = 1068
        Height = 192
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Method'
        ItemIndex = 0
        Items.Strings = (
          'Skip the following number of top priority elements'
          'Skip elements as defined by Parameters (next page)')
        TabOrder = 2
        OnClick = MethodGroupClick
      end
      object RangeEdit: TEdit
        Left = 953
        Top = 323
        Width = 123
        Height = 37
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 3
        Text = '50'
      end
    end
    object Parameters: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Parameters'
      ImageIndex = 1
      object Bevel1: TBevel
        Left = 17
        Top = 293
        Width = 1111
        Height = 4
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
      end
      object Bevel2: TBevel
        Left = 800
        Top = 12
        Width = 6
        Height = 693
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
      end
      object Bevel3: TBevel
        Left = 458
        Top = 12
        Width = 6
        Height = 693
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
      end
      object Bevel4: TBevel
        Left = 17
        Top = 71
        Width = 1111
        Height = 6
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
      end
      object Label2: TLabel
        Left = 557
        Top = 26
        Width = 58
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Items'
      end
      object Label3: TLabel
        Left = 896
        Top = 26
        Width = 74
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Topics'
      end
      object Label4: TLabel
        Left = 48
        Top = 107
        Width = 132
        Height = 29
        Hint = 
          'Delay factors determines by how much intervals should increase i' +
          'n Postpone'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Delay factor:'
      end
      object Label5: TLabel
        Left = 48
        Top = 171
        Width = 192
        Height = 29
        Hint = 'Maximum interval limits the maximum delay of repetitions'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Maximum interval:'
      end
      object Label6: TLabel
        Left = 48
        Top = 234
        Width = 187
        Height = 29
        Hint = 'Minimum intervals defines the minimum period of delay'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Minimum interval:'
      end
      object ItemDelayPercent: TLabel
        Left = 656
        Top = 99
        Width = 35
        Height = 29
        Hint = 
          'Delay factors determines by how much intervals should increase i' +
          'n Postpone'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '1%'
      end
      object TopicDelayPercent: TLabel
        Left = 1007
        Top = 99
        Width = 35
        Height = 29
        Hint = 
          'Delay factors determines by how much intervals should increase i' +
          'n Postpone'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '2%'
      end
      object Label12: TLabel
        Left = 48
        Top = 363
        Width = 61
        Height = 29
        Hint = 'You can postpone only topics or only items'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Type:'
      end
      object Label14: TLabel
        Left = 48
        Top = 423
        Width = 169
        Height = 29
        Hint = 
          'Elements with interval greater than defined will not be postpone' +
          'd'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Interval beyond:'
      end
      object Label15: TLabel
        Left = 48
        Top = 485
        Width = 252
        Height = 29
        Hint = 
          'Items with forgetting index below the specified value will not b' +
          'e postponed'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Forgetting index below:'
      end
      object Label16: TLabel
        Left = 48
        Top = 545
        Width = 169
        Height = 29
        Hint = 
          'Topics with A-Factors less than specified value will not be post' +
          'poned'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'A-Factor below:'
      end
      object PriorityLabel: TLabel
        Left = 48
        Top = 669
        Width = 119
        Height = 29
        Hint = 
          'Elements whose cumulative delay reaches beyond the given percent' +
          'age of their interval will not be postponed'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Priority (%)'
      end
      object Label7: TLabel
        Left = 107
        Top = 318
        Width = 170
        Height = 29
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Skip conditions:'
      end
      object Label8: TLabel
        Left = 48
        Top = 606
        Width = 173
        Height = 29
        Hint = 
          'Elements with postpone count greater than defined will not be po' +
          'stponed'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Postpone count:'
      end
      object ItemDelayEdit: TEdit
        Left = 503
        Top = 93
        Width = 103
        Height = 37
        Hint = 
          'Delay factors determines by how much intervals should increase i' +
          'n Postpone'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 1
        Text = '1.01'
      end
      object TopicDelayEdit: TEdit
        Left = 854
        Top = 93
        Width = 103
        Height = 37
        Hint = 
          'Delay factors determines by how much intervals should increase i' +
          'n Postpone'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 2
        Text = '1.02'
      end
      object ItemMaxIntervalEdit: TEdit
        Left = 503
        Top = 170
        Width = 220
        Height = 37
        Hint = 'Maximum interval limits the maximum delay of repetitions'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 3
        Text = '30'
      end
      object ItemMinIntervalEdit: TEdit
        Left = 503
        Top = 224
        Width = 220
        Height = 37
        Hint = 'Minimum intervals defines the minimum period of delay'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 5
        Text = '1'
      end
      object TopicMaxIntervalEdit: TEdit
        Left = 854
        Top = 165
        Width = 220
        Height = 37
        Hint = 'Maximum interval limits the maximum delay of repetitions'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 4
        Text = '80'
      end
      object TopicMinIntervalEdit: TEdit
        Left = 854
        Top = 224
        Width = 220
        Height = 37
        Hint = 'Minimum intervals defines the minimum period of delay'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 6
        Text = '1'
      end
      object SkipItemsBox: TCheckBox
        Left = 503
        Top = 363
        Width = 271
        Height = 29
        Hint = 'You can postpone only topics or only items'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Skip items'
        TabOrder = 7
        OnClick = SkipItemsBoxClick
      end
      object SkipTopicsBox: TCheckBox
        Left = 854
        Top = 363
        Width = 271
        Height = 29
        Hint = 'You can postpone only topics or only items'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Skip topics'
        TabOrder = 8
        OnClick = SkipTopicsBoxClick
      end
      object ItemSkipIntervalEdit: TEdit
        Left = 503
        Top = 417
        Width = 220
        Height = 37
        Hint = 
          'Elements with interval greater than defined will not be postpone' +
          'd'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 9
        Text = '400'
      end
      object TopicSkipIntervalEdit: TEdit
        Left = 854
        Top = 417
        Width = 220
        Height = 37
        Hint = 
          'Elements with interval greater than defined will not be postpone' +
          'd'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 10
        Text = '500'
      end
      object ItemSkipFIEdit: TEdit
        Left = 503
        Top = 480
        Width = 220
        Height = 37
        Hint = 
          'Items with forgetting index below the specified value will not b' +
          'e postponed'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 11
        Text = '6'
      end
      object ItemPriorityEdit: TEdit
        Left = 503
        Top = 662
        Width = 220
        Height = 37
        Hint = 
          'Elements whose cumulative delay reaches beyond the given percent' +
          'age of their interval will not be postponed'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 15
        Text = '5'
      end
      object TopicPriorityEdit: TEdit
        Left = 854
        Top = 662
        Width = 220
        Height = 37
        Hint = 
          'Elements whose cumulative delay reaches beyond the given percent' +
          'age of their interval will not be postponed'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 16
        Text = '5'
      end
      object Edit12: TEdit
        Left = 854
        Top = 480
        Width = 220
        Height = 37
        Hint = 
          'Items with forgetting index below the specified value will not b' +
          'e postponed'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Color = clBtnFace
        Enabled = False
        TabOrder = 17
        Text = 'N/A'
      end
      object Edit13: TEdit
        Left = 503
        Top = 539
        Width = 220
        Height = 37
        Hint = 
          'Topics with A-Factors less than specified value will not be post' +
          'poned'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Color = clBtnFace
        Enabled = False
        TabOrder = 18
        Text = 'N/A'
      end
      object TopicSkipAFEdit: TEdit
        Left = 854
        Top = 539
        Width = 220
        Height = 37
        Hint = 
          'Topics with A-Factors less than specified value will not be post' +
          'poned'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 12
        Text = '1.2'
      end
      object RestoreDefaultsBtn: TButton
        Left = 59
        Top = 12
        Width = 282
        Height = 50
        Hint = 'Restore default setting of postpone parameters'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Restore defaults'
        TabOrder = 0
        OnClick = RestoreDefaultsBtnClick
      end
      object ItemSkipPostponeEdit: TEdit
        Left = 503
        Top = 602
        Width = 220
        Height = 37
        Hint = 
          'Items with the postpone count greater than specified will not be' +
          ' postponed'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 13
        Text = '20'
      end
      object TopicSkipPostponeEdit: TEdit
        Left = 854
        Top = 602
        Width = 220
        Height = 37
        Hint = 
          'Topics with the postpone count greater than specified will not b' +
          'e postponed'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabOrder = 14
        Text = '10'
      end
    end
    object Adjust: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Adjust'
      ImageIndex = 2
      object ItemModifyByFIBox: TCheckBox
        Left = 35
        Top = 494
        Width = 1090
        Height = 36
        Hint = 'Items with lower forgetting indices will suffer less delay'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Modify item delay in proportion to forgetting index'
        TabOrder = 0
      end
      object TopicModifyByAFBox: TCheckBox
        Left = 35
        Top = 561
        Width = 1090
        Height = 36
        Hint = 'Topics with lower A-Factors will suffer less delay'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Modify topic delay in proportion to A-Factor'
        TabOrder = 2
      end
      object SubBranchPostpones: TRadioGroup
        Left = 35
        Top = 48
        Width = 1054
        Height = 348
        Hint = 
          'Choose how postpone should be applied to sub-branches which have' +
          ' their own postpone settings'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Sub-branch postpones'
        ItemIndex = 0
        Items.Strings = (
          'Respect settings'
          'Ignore settings'
          'Always choose most conservative settings'
          'Always choose most liberal settings')
        TabOrder = 3
      end
      object DelayAllBox: TCheckBox
        Left = 35
        Top = 428
        Width = 1090
        Height = 36
        Hint = 'Postpone all elements, even if they are not outstanding'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Include elements that are not outstanding'
        TabOrder = 1
        OnClick = DelayAllBoxClick
      end
      object List: TButton
        Left = 878
        Top = 126
        Width = 192
        Height = 48
        Hint = 'List branches for which settings have been defined'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'List'
        TabOrder = 4
        OnClick = ListClick
      end
      object ModifyByPriorityCheckBox: TCheckBox
        Left = 35
        Top = 630
        Width = 1050
        Height = 30
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Modify delay in proportion to element priority'
        TabOrder = 5
      end
    end
  end
  object Postpone: TButton
    Left = 246
    Top = 788
    Width = 200
    Height = 52
    Hint = 'Postpone repetitions'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Postpone'
    Default = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = PostponeClick
  end
  object Simulate: TButton
    Left = 458
    Top = 788
    Width = 202
    Height = 52
    Hint = 'Simulate postponing repetitions to view postpone statistics'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Simulate'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = SimulateClick
  end
  object CloseDlg: TButton
    Left = 669
    Top = 788
    Width = 203
    Height = 52
    Hint = 'Close this dialog without postponing repetitions'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Cancel = True
    Caption = 'Close'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = CloseDlgClick
  end
  object BitBtn1: TBitBtn
    Left = 882
    Top = 788
    Width = 201
    Height = 52
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 3
  end
end
