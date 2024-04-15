program FuelTrack;

uses
  Vcl.Forms,
  FMain in 'view\FMain.pas' {MainForm},
  Attributes in 'utils\Attributes.pas',
  Model.intf in 'model\Model.intf.pas',
  Base.model in 'model\Base.model.pas',
  Tank.model in 'model\Tank.model.pas',
  Pump.model in 'model\Pump.model.pas',
  Fueling.model in 'model\Fueling.model.pas',
  dmConnection in 'infra\dmConnection.pas' {DtmConnection: TDataModule},
  Dao.intf in 'dao\Dao.intf.pas',
  Base.dao in 'dao\Base.dao.pas',
  Fueling.dao in 'dao\Fueling.dao.pas',
  Pump.dao in 'dao\Pump.dao.pas',
  Tank.dao in 'dao\Tank.dao.pas',
  BaseList.view in 'view\BaseList.view.pas' {FrmBaseListView},
  BaseList.intf in 'view\BaseList.intf.pas',
  TankList.view in 'view\TankList.view.pas' {FrmTankListView},
  Controller.intf in 'controller\Controller.intf.pas',
  Base.controller in 'controller\Base.controller.pas',
  Tank.controller in 'controller\Tank.controller.pas',
  BaseRegister.intf in 'view\BaseRegister.intf.pas',
  BaseRegister.view in 'view\BaseRegister.view.pas' {FrmBaseRegisterView},
  TankRegister.view in 'view\TankRegister.view.pas' {FrmTankRegisterView},
  PumpRegister.view in 'view\PumpRegister.view.pas' {FrmPumpRegisterView},
  PumpList.view in 'view\PumpList.view.pas' {FrmPumpListView},
  Pump.controller in 'controller\Pump.controller.pas',
  FuelingRegister.view in 'view\FuelingRegister.view.pas' {FrmFuelingRegisterView},
  Fueling.controller in 'controller\Fueling.controller.pas',
  FuelingList.view in 'view\FuelingList.view.pas' {FrmFuelingListView},
  StringGrid.helper in 'utils\StringGrid.helper.pas',
  Fueling.report in 'report\Fueling.report.pas' {FrmFuelingReport};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDtmConnection, DtmConnection);
  Application.Run;
end.
