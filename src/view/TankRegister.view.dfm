inherited FrmTankRegisterView: TFrmTankRegisterView
  Caption = 'Registro de Tanque'
  ClientHeight = 194
  ClientWidth = 371
  ExplicitWidth = 387
  ExplicitHeight = 233
  TextHeight = 15
  object Label3: TLabel [0]
    Left = 8
    Top = 98
    Width = 53
    Height = 15
    Caption = 'Valor Litro'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 52
    Width = 67
    Height = 15
    Caption = 'Combust'#237'vel'
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 6
    Width = 11
    Height = 15
    Caption = 'ID'
  end
  object Label4: TLabel [3]
    Left = 144
    Top = 98
    Width = 58
    Height = 15
    Caption = 'N'#237'vel Atual'
  end
  inherited Panel1: TPanel
    Top = 160
    Width = 371
    inherited btnSalvar: TButton
      Left = 271
      ExplicitHeight = 34
    end
  end
  object edtLiterPrice: TMaskEdit
    Left = 8
    Top = 117
    Width = 121
    Height = 23
    TabOrder = 1
    Text = ''
  end
  object EdtFuelType: TComboBox
    Left = 8
    Top = 71
    Width = 257
    Height = 23
    Style = csDropDownList
    TabOrder = 2
  end
  object EdtIdTank: TEdit
    Left = 8
    Top = 25
    Width = 121
    Height = 23
    TabOrder = 3
  end
  object edtCurrentLevel: TEdit
    Left = 144
    Top = 117
    Width = 121
    Height = 23
    TabOrder = 4
  end
end
