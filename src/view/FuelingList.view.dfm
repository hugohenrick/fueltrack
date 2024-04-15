inherited FrmFuelingListView: TFrmFuelingListView
  Caption = 'Lista de Abastecimentos'
  ClientWidth = 871
  OnCreate = FormCreate
  ExplicitWidth = 883
  ExplicitHeight = 358
  TextHeight = 15
  inherited Panel1: TPanel
    Width = 871
    ExplicitTop = 285
    ExplicitWidth = 539
    inherited btnIncluir: TButton
      Left = 645
    end
    inherited btnAlterar: TButton
      Left = 720
    end
    inherited btnExcluir: TButton
      Left = 795
    end
  end
  inherited sgList: TStringGrid
    Width = 871
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 539
    ExplicitHeight = 285
  end
end
