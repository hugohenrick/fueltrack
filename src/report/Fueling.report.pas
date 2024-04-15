unit Fueling.report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmFuelingReport = class(TForm)
    RepFuelings: TRLReport;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLLabel1: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    DtsFuelings: TDataSource;
    QryFuelings: TFDQuery;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLDBResult1: TRLDBResult;
    QryFuelingsDateOfFueling: TDateTimeField;
    QryFuelingsPumpID: TIntegerField;
    QryFuelingsTankID: TIntegerField;
    QryFuelingsTotalFueled: TFloatField;
  private

  public
    class procedure FuelingsPreview;
  end;

implementation

uses
  dmConnection;

{$R *.dfm}

{ TForm1 }

class procedure TFrmFuelingReport.FuelingsPreview;
var
  FrmFuelingReport: TFrmFuelingReport;
begin
  FrmFuelingReport := TFrmFuelingReport.Create(nil);
  try
    FrmFuelingReport.QryFuelings.Open();
    if FrmFuelingReport.RepFuelings.Prepare then
      FrmFuelingReport.RepFuelings.PreviewModal;
  finally
    FreeAndNil(FrmFuelingReport);
  end;
end;

end.
