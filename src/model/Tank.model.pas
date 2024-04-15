unit Tank.model;

interface

uses
  base.model,
  model.intf,
  Attributes;

type
  [TTable('Tank')]
  TTankModel = class(TBaseModel, IModel)
  private
    FId: Integer;
    FFuelType: string;
    FLiterPrice: Double;
    FCurrentLevel: Double;
  public
    procedure ValidateData; override;

    [TDBField('ID', 'Tank ID', True, False, '', 0, '', True), TNotNull]
    property Id: Integer read FId write FId;

    [TDBField('FuelType', 'Tipo Combustível', True, True, '', 20, 'Gasolina;Óleo Diesel'), TNotNull]
    property FuelType: string read FFuelType write FFuelType;

    [TDBField('LiterPrice', 'Preço Litro', True, True, 'R$ ,#.000'), TNotNull]
    property LiterPrice: Double read FLiterPrice write FLiterPrice;

    [TDBField('CurrentLevel', 'Nível Atual', True, True), TNotNull]
    property CurrentLevel: Double read FCurrentLevel write FCurrentLevel;
  end;

implementation

{ TTankModel }

procedure TTankModel.ValidateData;
begin
  inherited;

end;

end.
