unit Pump.model;

interface

uses
  Base.model,
  Model.intf,
  Attributes;

type
  [TTable('Pump')]
  TPumpModel = class(TBaseModel, IModel)
  private
    FID: Integer;
    FTankId: Integer;
    FDescription: string;

  public
    procedure ValidateData; override;

    [TDBField('ID', 'ID', True, False, '', 0, '', True), TNotNull]
    property ID: Integer read FID write FID;

    [TForeignKey('Tank', 'TankId', 'ID')]
    [TDBField('TankId', 'ID Tanque', True, True), TNotNull]
    property TankId: Integer read FTankId write FTankId;

    [TDBField('Description', 'Descrição', True, True), TNotNull]
    property Description: string read FDescription write FDescription;
  end;

implementation

{ TPumpModel }

procedure TPumpModel.ValidateData;

begin
  inherited;
end;

end.
