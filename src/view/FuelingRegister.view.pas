unit FuelingRegister.view;

interface

uses
  Attributes,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.view, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls;

type
  TFrmFuelingRegisterView = class(TFrmBaseRegisterView)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    [TDBField('ID')]
    EdtId: TEdit;
    [TDBField('FuelingDate')]
    EdtDataLancamento: TDateTimePicker;
    [TDBField('LitersQty')]
    EdtLitros: TMaskEdit;
    [TDBField('FueledValue')]
    EdtValorTotal: TMaskEdit;
    [TDBField('PumpId')]
    EdtBomba: TEdit;
    [TDBField('UnitPrice')]
    EdtValorUnitario: TMaskEdit;
    [TDBField('TaxValue')]
    EdtValorImposto: TMaskEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFuelingRegisterView: TFrmFuelingRegisterView;

implementation

uses
  Fueling.model;

{$R *.dfm}

procedure TFrmFuelingRegisterView.FormCreate(Sender: TObject);
begin
  inherited;
  FModelClass := TFuelingModel;
end;

end.
