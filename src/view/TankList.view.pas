unit TankList.view;

interface

uses
  BaseList.view,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, Data.DB, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmTankListView = class(TFrmBaseListView)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTankListView: TFrmTankListView;

implementation

uses
  TankRegister.view;

{$R *.dfm}

procedure TFrmTankListView.FormCreate(Sender: TObject);
begin
  inherited;
  RegisterView := TFrmTankRegisterView.Create(Self);
end;

end.
