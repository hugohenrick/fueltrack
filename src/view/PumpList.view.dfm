inherited FrmPumpListView: TFrmPumpListView
  Caption = 'Lista de Bombas'
  OnCreate = FormCreate
  ExplicitWidth = 555
  ExplicitHeight = 358
  TextHeight = 15
  inherited Panel1: TPanel
    ExplicitTop = 285
    ExplicitWidth = 539
  end
  inherited sgList: TStringGrid
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 539
    ExplicitHeight = 285
  end
end
