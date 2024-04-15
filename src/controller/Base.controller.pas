unit Base.controller;

interface

uses
  Base.model,
  Model.intf,
  Dao.intf,
  Controller.intf,
  BaseList.view,

  System.Classes,
  System.SysUtils,
  System.Types,

  Vcl.Forms,

  FireDAC.Comp.Client;

type
  TBaseController = class(TInterfacedObject, IController)
  private
    function GetDAO: IDAO;
    function GetModel: TBaseModelClass;
  protected
    FDAO: IDAO;
  public
    procedure ShowList(const AFormListView: TFrmBaseListViewClass);
    procedure Save(const AObjeto: TBaseModel);
    procedure Delete(const AID: Integer);
  end;

implementation

{ TBaseController }

function TBaseController.GetDAO: IDAO;
begin
  Result := FDAO;
end;

function TBaseController.GetModel: TBaseModelClass;
begin
  Result := FDAO.Model;
end;

procedure TBaseController.Delete(const AID: Integer);
begin
  FDAO.Delete(AID);
end;

procedure TBaseController.Save(const AObjeto: TBaseModel);
begin
  FDAO.Save(AObjeto);
end;

procedure TBaseController.ShowList(const AFormListView: TFrmBaseListViewClass);
var
  FrmList: TFrmBaseListView;
begin
  Assert(FDAO <> nil, 'Classe ADO não foi informada.');
  Assert(FDAO.Connection <> nil, 'Conexão ao banco de dados não foi informada.');
  Assert(FDAO.Model <> nil, 'Classe do Modelo não foi informada.');

  FrmList := AFormListView.Create(nil, FDAO);
  try
    FrmList.ShowModal;
  finally
    FreeAndNil(FrmList);
  end;
end;

end.
