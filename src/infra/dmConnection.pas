unit dmConnection;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.DApt,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite,
  FireDAC.VCLUI.Error,
  FireDAC.VCLUI.Login,
  FireDAC.VCLUI.Script,
  FireDAC.Comp.UI;

type
  TDtmConnection = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxLoginDialog1: TFDGUIxLoginDialog;
    FDGUIxScriptDialog1: TFDGUIxScriptDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure CheckAndBuildDatabase;
  public

  end;

var
  DtmConnection: TDtmConnection;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  Model.intf,
  Dao.intf,
  Pump.DAO,
  Tank.DAO,
  Fueling.DAO,
  Fueling.model,
  Pump.model,
  Tank.model;

procedure TDtmConnection.CheckAndBuildDatabase;
var
  Tabelas: TStringList;
  PumpDao, TankDao, FuelingDao: IDAO;
begin
  Tabelas := TStringList.Create;
  try
    FDConnection1.GetTableNames('', '', '', Tabelas);

    TankDao := TTankDao.Create(FDConnection1, TTankModel);
    if Tabelas.IndexOf(TankDao.GetTableName) < 0 then
      FDConnection1.ExecSQL(TankDao.GetSQLCreateTable);

    PumpDao := TPumpDao.Create(FDConnection1, TPumpModel);
    if Tabelas.IndexOf(PumpDao.GetTableName) < 0 then
      FDConnection1.ExecSQL(PumpDao.GetSQLCreateTable);

    FuelingDao := TFuelingDao.Create(FDConnection1, TFuelingModel);
    if Tabelas.IndexOf(FuelingDao.GetTableName) < 0 then
      FDConnection1.ExecSQL(FuelingDao.GetSQLCreateTable);

    FDConnection1.Close;
  finally
    Tabelas.Free;
  end;
end;

procedure TDtmConnection.FDConnection1BeforeConnect(Sender: TObject);
var
  DatabaseFolder: string;
  DatabasePath: string;
begin
  DatabaseFolder := TPath.Combine(
    TPath.GetDirectoryName(ParamStr(0)), 'database'
  );
  ForceDirectories(DatabaseFolder);

  DatabasePath := TPath.Combine(
    DatabaseFolder, 'FuelTrack.db'
  );

  FDConnection1.Params.Database := DatabasePath;
end;

procedure TDtmConnection.DataModuleCreate(Sender: TObject);
begin
  CheckAndBuildDatabase;
end;

end.
