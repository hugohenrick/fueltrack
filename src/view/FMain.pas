unit FMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus;

type
  TMainForm = class(TForm)
    mMainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    anques1: TMenuItem;
    Bombas1: TMenuItem;
    Abastecimentos1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Relatrios1: TMenuItem;
    otais1: TMenuItem;
    procedure anques1Click(Sender: TObject);
    procedure Bombas1Click(Sender: TObject);
    procedure Abastecimentos1Click(Sender: TObject);
    procedure otais1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  Controller.intf,
  Tank.controller,
  TankList.view,
  Pump.controller,
  PumpList.view,
  FuelingList.view,
  Fueling.controller, Fueling.report;

{$R *.dfm}

procedure TMainForm.Abastecimentos1Click(Sender: TObject);
  var
  FuelingController: IController;
begin
  FuelingController := TFuelingController.Create;
  FuelingController.ShowList(TFrmFuelingListView);
end;

procedure TMainForm.anques1Click(Sender: TObject);
var
  TankController: IController;
begin
  TankController := TTankController.Create;
  TankController.ShowList(TFrmTankListView);
end;

procedure TMainForm.Bombas1Click(Sender: TObject);
var
  PumpController: IController;
begin
  PumpController := TPumpController.Create;
  PumpController.ShowList(TFrmPumpListView);
end;

procedure TMainForm.otais1Click(Sender: TObject);
begin
  TFrmFuelingReport.FuelingsPreview;
end;

end.
