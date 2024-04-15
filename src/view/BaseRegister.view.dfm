object FrmBaseRegisterView: TFrmBaseRegisterView
  Left = 0
  Top = 0
  Caption = 'Cadastro'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 408
    Width = 628
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitTop = 407
    ExplicitWidth = 624
    object btnSalvar: TButton
      Left = 528
      Top = 0
      Width = 100
      Height = 34
      Align = alRight
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
      ExplicitLeft = 524
    end
  end
end
