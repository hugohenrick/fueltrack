unit Pump.dao;

interface

uses
  base.DAO,
  Pump.model, FireDAC.Comp.Client, System.SysUtils, Base.model;

type
  TPumpDAO = class(TBaseDAO)
  private

  public
    procedure Save(const AObject: TBaseModel); override;
    procedure ValidateQtdPumps(aID: Integer);
  end;

implementation

uses
  FireDAC.Stan.Param;

procedure TPumpDAO.Save(const AObject: TBaseModel);
begin
  // Verifica se o objeto é do tipo TPumpModel antes de cast
  if AObject is TPumpModel then
  begin
    ValidateQtdPumps(TPumpModel(AObject).TankID);
  end;
  inherited Save(AObject);
end;

procedure TPumpDAO.ValidateQtdPumps(aID: Integer);
var
  PumpCount: Integer;
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := GetConnection;
    Query.SQL.Text := 'SELECT COUNT(*) AS Count FROM Pump WHERE TankID = :TankID';
    Query.ParamByName('TankID').AsInteger := aID;
    Query.Open;
    PumpCount := Query.FieldByName('Count').AsInteger;
  finally
    Query.Free;
  end;

  if PumpCount >= 2 then
    raise Exception.Create('Não é possível adicionar mais do que duas bombas para um único tanque.');
end;


end.
