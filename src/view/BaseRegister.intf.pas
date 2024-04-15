unit BaseRegister.intf;

interface

uses
  System.Classes,
  Model.intf,
  Dao.intf;

type
  IRegisterView = interface
    ['{ECFB88A4-1A63-4AC6-981E-88BE8E109788}']
    function ShowRegister(AOwner: TComponent; ADAO: IDAO): Boolean;
    function ShowUpdate(AOwner: TComponent; ADAO: IDAO; AObject: IModel; AID: Integer): Boolean;
  end;

implementation

end.
