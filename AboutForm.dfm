object frmAbout: TfrmAbout
  Left = 348
  Top = 304
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = '����������� ���������'
  ClientHeight = 121
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = GREEK_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 62
    Height = 13
    Caption = 'E09 Compiler'
  end
  object lblVersion: TLabel
    Left = 8
    Top = 32
    Width = 111
    Height = 13
    Caption = '������ 1.0.0.3 Debug'
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 119
    Height = 13
    Caption = '(C) 2002 ����� ��������'
  end
  object Button1: TButton
    Left = 136
    Top = 88
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
end
