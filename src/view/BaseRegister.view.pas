unit BaseRegister.view;

interface

uses
  Base.model,
  Model.intf,
  DAO.intf,
  BaseRegister.intf,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Mask;

type
  TFrmBaseRegisterView = class(TForm, IRegisterView)
    Panel1: TPanel;
    btnSalvar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    FUpdate: Boolean;
    FDAO: IDAO;
    FID: Integer;
    FObject: IModel;
  protected
    FModelClass: TBaseModelClass;
  public
    { Public declarations }
    function ShowRegister(AOwner: TComponent; ADAO: IDAO): Boolean;
    function ShowUpdate(AOwner: TComponent; ADAO: IDAO; AObject: IModel; AID: Integer): Boolean;
  end;

var
  FrmBaseRegisterView: TFrmBaseRegisterView;

implementation

{$R *.dfm}

{ TFrmBaseRegisterView }

procedure TFrmBaseRegisterView.btnSalvarClick(Sender: TObject);
var
  ObjSalve: TBaseModel;
begin
  if Application.MessageBox(
    'Deseja gravar os dados?',
    'Salvar',
    MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2
  ) = ID_YES then
  begin
    ObjSalve := FModelClass.Create;
    try
      ObjSalve.BingObjectFromForm(Self);

      if FUpdate then
        FDAO.Update(FID, ObjSalve)
      else
        FDAO.Save(ObjSalve);
    finally
      ObjSalve.Free;
    end;

    Self.Close;
    Self.ModalResult := mrOK;

    ShowMessage('Registro gravado com sucesso!');
  end;
end;

procedure TFrmBaseRegisterView.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount - 1 do
  begin
    if (Self.Components[I] is TEdit) then
      (Self.Components[I] as TEdit).Clear
    else
    if (Self.Components[I] is TComboBox) then
      (Self.Components[I] as TComboBox).Clear
    else
    if (Self.Components[I] is TMaskEdit) then
      (Self.Components[I] as TMaskEdit).Clear
    else
    if (Self.Components[I] is TDateTimePicker) then
      (Self.Components[I] as TDateTimePicker).Date := Date;
  end;
end;

procedure TFrmBaseRegisterView.FormShow(Sender: TObject);
begin
  FModelClass.ConfigureForm(Self);

  if Assigned(FObject) then
    FObject.BindForm(Self);
end;

function TFrmBaseRegisterView.ShowRegister(AOwner: TComponent;
  ADAO: IDAO): Boolean;
begin
  Self.FUpdate := False;
  Self.FDAO       := ADAO;
  Self.FObject    := nil;
  Self.FID        := 0;

  Result := Self.ShowModal = mrOk;
end;

function TFrmBaseRegisterView.ShowUpdate(AOwner: TComponent; ADAO: IDAO;
  AObject: IModel; AID: Integer): Boolean;
begin
  Self.FUpdate := True;
  Self.FDAO       := ADAO;
  Self.FObject    := AObject;
  Self.FID        := AID;

  Result := Self.ShowModal = mrOk;
end;

end.
