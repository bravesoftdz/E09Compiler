object frmOptions: TfrmOptions
  Left = 198
  Top = 190
  BorderStyle = bsDialog
  Caption = 'Επιλογές'
  ClientHeight = 400
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GradientShape1: TGradientShape
    Left = 136
    Top = 8
    Width = 561
    Height = 25
    FirstColor = clGray
    LastColor = clSilver
    GradientType = gtLeftToRight
    object lblShortDesc: TLabel
      Left = 8
      Top = 6
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblLongDesc: TLabel
      Left = 549
      Top = 6
      Width = 3
      Height = 13
      Alignment = taRightJustify
      Transparent = True
    end
  end
  object btnOk: TBitBtn
    Left = 528
    Top = 368
    Width = 81
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 616
    Top = 368
    Width = 81
    Height = 25
    Caption = '’κυρο'
    TabOrder = 1
    Kind = bkCancel
  end
  object tvOptions: TTreeView
    Left = 8
    Top = 8
    Width = 121
    Height = 345
    Indent = 19
    ReadOnly = True
    TabOrder = 2
    OnChange = tvOptionsChange
    OnDeletion = tvOptionsDeletion
  end
  object panCon: TScrollBox
    Left = 136
    Top = 40
    Width = 561
    Height = 313
    BorderStyle = bsNone
    TabOrder = 4
  end
end
