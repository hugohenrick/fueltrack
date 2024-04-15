unit PumpRegister.view;

interface

uses
  Attributes,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.view, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TFrmPumpRegisterView = class(TFrmBaseRegisterView)
    [TDBField('Description')]
    EdtDescricao: TEdit;
    Label3: TLabel;
    //[TDBField('TankId')]
    EdtTanque: TEdit;
    Label2: TLabel;
    //[TDBField('ID')]
    EdtID: TEdit;
    Label1: TLabel;
    [TForeignKey('Tank', 'TankId', 'ID')]
    [TDBField('TankId')]
    cbTankId: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPumpRegisterView: TFrmPumpRegisterView;

implementation

uses
  Pump.model;

{$R *.dfm}

procedure TFrmPumpRegisterView.FormCreate(Sender: TObject);
begin
  inherited;
  FModelClass := TPumpModel;
end;

end.
