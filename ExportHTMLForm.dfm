object frmExportHTMLWizard: TfrmExportHTMLWizard
  Left = 234
  Top = 242
  Width = 699
  Height = 505
  Caption = '������ ��� ��� ���������� �����������'
  Color = clBtnFace
  Font.Charset = GREEK_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 72
    Height = 13
    Caption = '�������������'
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 139
    Height = 13
    Caption = '����� ������������� ������'
  end
  object Label3: TLabel
    Left = 248
    Top = 8
    Width = 41
    Height = 13
    Caption = '�������'
  end
  object btnOK: TBitBtn
    Left = 514
    Top = 444
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 0
    OnClick = btnOKClick
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 602
    Top = 444
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '�����'
    TabOrder = 1
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 8
    Top = 72
    Width = 673
    Height = 360
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 2
    object WebBrowser1: TWebBrowser
      Left = 1
      Top = 1
      Width = 671
      Height = 358
      Align = alClient
      TabOrder = 0
      ControlData = {
        4C0000008E450000A82300000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object cmbFontFace: TComboBox
    Left = 88
    Top = 8
    Width = 145
    Height = 21
    Hint = '����������� ��� <FONT FACE="�������������">'
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = 'Courier New'
    OnChange = cmbFontFaceChange
  end
  object txtFontSize: TEdit
    Left = 296
    Top = 8
    Width = 49
    Height = 21
    Hint = '����������� ��� <FONT SIZE="�������������">'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = '-1'
    OnChange = txtFontSizeChange
  end
  object txtBorder: TEdit
    Left = 160
    Top = 40
    Width = 41
    Height = 21
    Hint = '����������� ��� <TABLE BORDER="�����">'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Text = '0'
    OnChange = txtBorderChange
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 368
    Top = 8
  end
end
