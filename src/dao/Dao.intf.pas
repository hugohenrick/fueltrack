unit Dao.intf;

interface

uses
  Data.DB,
  base.model,
  model.intf,
  System.Classes,
  System.SysUtils,
  System.Types,
  FireDAC.Comp.Client;

type
  IDAO  = interface
    ['{9BFA158D-ABF9-4F74-816E-18EFDD9C996B}']
    function GetConnection: TFDConnection;
    function GetModelClass: TBaseModelClass;
    function GetFieldList(const AToParametro: Boolean= False): string;
    function GetPkField: string;
    function GetSQLCreateTable: string;
    function GetTableName: string;

    function GetDataset(const AWhere: string = ''): TDataSet;

    procedure Save(const AObject: TBaseModel);
    procedure Update(const AID: Integer; const AObject: TBaseModel);
    procedure Delete(const AID: Integer);

    property Connection: TFDConnection read GetConnection;
    property Model: TBaseModelClass read GetModelClass;
  end;

implementation

end.
