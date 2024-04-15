unit FuelingList.view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.view, System.Actions,
  Vcl.ActnList, Data.DB, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmFuelingListView = class(TFrmBaseListView)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFuelingListView: TFrmFuelingListView;

implementation

uses
  FuelingRegister.view;

{$R *.dfm}

procedure TFrmFuelingListView.FormCreate(Sender: TObject);
begin
  inherited;
  RegisterView := TFrmFuelingRegisterView.Create(Self);
end;

end.
