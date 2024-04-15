unit Fueling.model;

interface

uses
  Base.model,
  Model.intf,
  Attributes;

type
  [TTable('Fueling')]
  TFuelingModel = class(TBaseModel, IModel)
  private
    FID: Integer;
    FPumpId: Integer;
    FFuelingDate: TDateTime;
    FLitersQty: Double;
    FFueledValue: Double;
    FTaxValue: Double;
    FUnitPrice: Double;
    function GetTaxValue: Double;
    function GetTaxRate: Double;
  public
    procedure ValidateData; override;

    [TDBField('ID', 'ID', True, False, '', 0, '', True), TNotNull]
    property ID: Integer read FID write FID;

    [TDBField('PumpId', 'ID Bomba', True, True), TNotNull]
    property PumpId: Integer read FPumpId write FPumpId;

    [TDBField('FuelingDate', 'Data', True, True, 'dd/MM/yyyy'), TNotNull]
    property FuelingDate: TDateTime read FFuelingDate write FFuelingDate;

    [TDBField('LitersQty', 'QTD Litros', True, True, ',#0.000'), TNotNull]
    property LitersQty: Double read FLitersQty write FLitersQty;

    [TDBField('UnitPrice', 'Preço Unit.', True, False, ',#0.000')]
    property UnitPrice: Double read FUnitPrice write FUnitPrice;

    [TDBField('FueledValue', 'Valor Total', True, True, ',#0.00'), TNotNull]
    property FueledValue: Double read FFueledValue write FFueledValue;

    [TDBField('TaxValue', 'Valor Imposto', True, False, ',#0.00'), TNotNull]
    property TaxValue: Double read GetTaxValue write FTaxValue;

    property TaxRate: Double read GetTaxRate;
  end;

implementation

{ TFuelingModel }

function TFuelingModel.GetTaxRate: Double;
begin
  Result := 13.00;
end;

function TFuelingModel.GetTaxValue: Double;
begin
  if (FFueledValue > 0) and (TaxRate > 0) then
    FTaxValue := FFueledValue * (TaxRate / 100)
  else
    FTaxValue := 0.00;

  Result := FTaxValue;
end;

procedure TFuelingModel.ValidateData;
begin
  inherited;

end;

end.

