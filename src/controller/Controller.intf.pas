unit Controller.intf;

interface

uses
  Base.model,
  Model.intf,
  Dao.intf,
  BaseList.view;

type
  IController = interface
    ['{DBF80E76-6673-4B42-BFCB-78C15E945FFF}']
    function GetModel: TBaseModelClass;
    function GetDAO: IDAO;

    procedure ShowList(const AFormListView: TFrmBaseListViewClass);
    procedure Save(const AObjeto: TBaseModel);
    procedure Delete(const ID: Integer);

    property Model: TBaseModelClass read GetModel;
    property DAO: IDAO read GetDAO;
  end;

implementation

end.
