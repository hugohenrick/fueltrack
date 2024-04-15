unit Fueling.controller;

interface

uses
  Model.intf,
  Base.controller,
  Controller.intf;

type
  TFuelingController = class(TBaseController, IController)
  private

  public
    constructor Create;
  end;

implementation

{ TFuelingController }

uses
  dmConnection,
  Fueling.model,
  Fueling.dao;

constructor TFuelingController.Create;
begin
  FDAO := TFuelingDAO.Create(
    DtmConneCtion.FDConnection1,
    TFuelingModel
  );
end;

end.

