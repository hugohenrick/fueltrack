unit Pump.controller;

interface

uses
  Model.intf,
  Base.controller,
  Controller.intf;

type
  TPumpController = class(TBaseController, IController)
  private

  public
    constructor Create;
  end;

implementation

{ TPumpController }

uses
  dmConnection,
  Pump.model,
  Pump.dao, System.SysUtils;

constructor TPumpController.Create;
begin
  FDAO := TPumpDAO.Create(
    DtmConneCtion.FDConnection1,
    TPumpModel
  );
end;

end.

