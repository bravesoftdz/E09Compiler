object frmOptions: TfrmOptions
  Left = 198
  Top = 190
  BorderStyle = bsDialog
  Caption = #197#240#233#235#239#227#221#242
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
    Caption = #162#234#245#241#239
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
    TabOrder = 3
  end
end
