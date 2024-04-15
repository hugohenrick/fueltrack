inherited FrmFuelingRegisterView: TFrmFuelingRegisterView
  Caption = 'Registro de Abastecimento'
  ClientHeight = 224
  ClientWidth = 537
  ExplicitWidth = 553
  ExplicitHeight = 263
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 8
    Top = 12
    Width = 10
    Height = 15
    Caption = 'Id'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 73
    Width = 24
    Height = 15
    Caption = 'Data'
  end
  object Label3: TLabel [2]
    Left = 135
    Top = 73
    Width = 38
    Height = 15
    Caption = 'Bomba'
  end
  object Label4: TLabel [3]
    Left = 8
    Top = 119
    Width = 54
    Height = 15
    Caption = 'QTD Litros'
  end
  object Label6: TLabel [4]
    Left = 389
    Top = 119
    Width = 54
    Height = 15
    Caption = 'Valor Total'
  end
  object Label5: TLabel [5]
    Left = 135
    Top = 119
    Width = 71
    Height = 15
    Caption = 'Valor Unit'#225'rio'
  end
  object Label7: TLabel [6]
    Left = 262
    Top = 119
    Width = 73
    Height = 15
    Caption = 'Valor Imposto'
  end
  inherited Panel1: TPanel
    Top = 190
    Width = 537
    inherited btnSalvar: TButton
      Left = 437
      ExplicitHeight = 34
    end
  end
  object EdtId: TEdit
    Left = 8
    Top = 31
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'EdtId'
  end
  object EdtDataLancamento: TDateTimePicker
    Left = 8
    Top = 92
    Width = 121
    Height = 21
    Date = 44397.000000000000000000
    Time = 0.563457210650085500
    TabOrder = 2
  end
  object EdtLitros: TMaskEdit
    Left = 8
    Top = 138
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'EdtLitros'
  end
  object EdtValorTotal: TMaskEdit
    Left = 389
    Top = 138
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'MaskEdit1'
  end
  object EdtBomba: TEdit
    Left = 135
    Top = 92
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'EdtBomba'
  end
  object EdtValorUnitario: TMaskEdit
    Left = 135
    Top = 138
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'EdtValorUnitario'
  end
  object EdtValorImposto: TMaskEdit
    Left = 262
    Top = 138
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'MaskEdit1'
  end
end
