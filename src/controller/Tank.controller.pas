unit Tank.controller;

interface

uses
  Model.intf,
  Base.controller,
  Controller.intf;

type
  TTankController = class(TBaseController, IController)
  private

  public
    constructor Create;
  end;

implementation

{ TTankController }

uses
  dmConnection,
  Tank.model,
  Tank.dao;

constructor TTankController.Create;
begin
  FDAO := TTankDAO.Create(
    DtmConneCtion.FDConnection1,
    TTankModel
  );
end;

end.

