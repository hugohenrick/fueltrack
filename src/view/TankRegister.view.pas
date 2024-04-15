unit TankRegister.view;

interface

uses
  Attributes,
  BaseRegister.view,
  BaseRegister.intf,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Mask, Vcl.ExtCtrls;

type
  TFrmTankRegisterView = class(TFrmBaseRegisterView)
    [TDBField('LiterPrice')]
    edtLiterPrice: TMaskEdit;
    Label3: TLabel;
    [TDBField('FuelType')]
    EdtFuelType: TComboBox;
    Label2: TLabel;
    [TDBField('ID')]
    EdtIdTank: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    [TDBField('CurrentLevel')]
    edtCurrentLevel: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTankRegisterView: TFrmTankRegisterView;

implementation

uses
  Tank.model;

{$R *.dfm}

procedure TFrmTankRegisterView.FormCreate(Sender: TObject);
begin
  inherited;
  FModelClass := TTankModel;
end;

end.
