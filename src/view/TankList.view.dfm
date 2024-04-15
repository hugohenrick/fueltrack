inherited FrmTankListView: TFrmTankListView
  Caption = 'Lista de Tanques'
  ClientHeight = 299
  ClientWidth = 541
  OnCreate = FormCreate
  ExplicitWidth = 553
  ExplicitHeight = 337
  TextHeight = 15
  inherited Panel1: TPanel
    Top = 265
    Width = 541
    ExplicitTop = 265
    ExplicitWidth = 541
    inherited btnIncluir: TButton
      Left = 315
      ExplicitLeft = 311
    end
    inherited btnAlterar: TButton
      Left = 390
      ExplicitLeft = 386
    end
    inherited btnExcluir: TButton
      Left = 465
      ExplicitLeft = 461
    end
  end
  inherited sgList: TStringGrid
    Width = 541
    Height = 265
    ExplicitWidth = 537
    ExplicitHeight = 274
  end
end
