unit PumpList.view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.view, System.Actions,
  Vcl.ActnList, Data.DB, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmPumpListView = class(TFrmBaseListView)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPumpListView: TFrmPumpListView;

implementation

uses
  PumpRegister.view;

{$R *.dfm}

procedure TFrmPumpListView.FormCreate(Sender: TObject);
begin
  inherited;
  RegisterView := TFrmPumpRegisterView.Create(Self);
end;

end.
