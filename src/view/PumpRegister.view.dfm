inherited FrmPumpRegisterView: TFrmPumpRegisterView
  Caption = 'Registro de Bomba'
  ClientHeight = 196
  ClientWidth = 384
  ExplicitWidth = 396
  ExplicitHeight = 234
  TextHeight = 15
  object Label3: TLabel [0]
    Left = 8
    Top = 98
    Width = 108
    Height = 15
    Caption = 'Descri'#231#227'o da Bomba'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 52
    Width = 38
    Height = 15
    Caption = 'Tanque'
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 6
    Width = 10
    Height = 15
    Caption = 'Id'
  end
  inherited Panel1: TPanel
    Top = 162
    Width = 384
    ExplicitTop = 161
    ExplicitWidth = 380
    inherited btnSalvar: TButton
      Left = 284
      ExplicitLeft = 280
    end
  end
  object EdtDescricao: TEdit
    Left = 8
    Top = 117
    Width = 351
    Height = 23
    TabOrder = 1
  end
  object EdtTanque: TEdit
    Left = 8
    Top = 71
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object EdtID: TEdit
    Left = 8
    Top = 25
    Width = 121
    Height = 23
    TabOrder = 3
  end
  object cbTankId: TComboBox
    Left = 168
    Top = 56
    Width = 145
    Height = 23
    TabOrder = 4
    Text = 'cbTankId'
  end
end
