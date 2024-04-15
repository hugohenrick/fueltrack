unit BaseList.view;

interface

uses
  Dao.intf,
  Base.Model,
  BaseList.intf,
  BaseRegister.intf,
  Model.intf,

  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  System.Actions,
  Vcl.ActnList,
  Vcl.Menus,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.RTTI;

type
  TFrmBaseListView = class(TForm, IListView)
    Panel1: TPanel;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    DtsList: TDataSource;
    ActionList1: TActionList;
    ActNewRecord: TAction;
    ActUpdateRecord: TAction;
    ActDeleteRecord: TAction;
    ActRefreshList: TAction;
    sgList: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure sgListDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure ActNewRecordExecute(Sender: TObject);
    procedure ActUpdateRecordExecute(Sender: TObject);
    procedure ActDeleteRecordExecute(Sender: TObject);
    procedure ActRefreshListExecute(Sender: TObject);
    procedure sgListSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    FListDAO: IDAO;
    FRegisterView: IRegisterView;
    FSelectedID: string;

    procedure OpenTable;
    procedure ConfigureGrid;
    procedure LoadDataIntoGrid(aDataSource: TDataSource);
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const ADAO: IDAO); overload;
    property RegisterView: IRegisterView read FRegisterView write FRegisterView;
  end;

  TFrmBaseListViewClass = class of TFrmBaseListView;

  var
    ColumnMasks: TArray<string>;

implementation

uses
  System.TypInfo, Attributes;

{$R *.dfm}

{ TFrmBaseListView }

constructor TFrmBaseListView.Create(const AOwner: TComponent; const ADAO: IDAO);
begin
inherited Create(AOwner);

  FListDAO := ADAO;

  Assert(FListDAO <> nil, 'Classe ADO não foi informada.');
  Assert(FListDAO.Connection <> nil, 'Conexão ao banco de dados não foi informada.');
  Assert(FListDAO.Model <> nil, 'Classe do Modelo não foi informada.');
end;

procedure TFrmBaseListView.FormShow(Sender: TObject);
begin
  OpenTable;
  if sgList.RowCount > 1 then
  begin
    sgList.Row := 1;
    sgList.SetFocus;
  end;
end;

procedure TFrmBaseListView.OpenTable;
begin
  if Assigned(DtsList.DataSet) then
    FreeAndNil(DtsList.DataSet);

  DtsList.DataSet := FListDAO.GetDataset;

  ConfigureGrid;
  LoadDataIntoGrid(DtsList);

  if FSelectedID.IsEmpty then
  begin
    FSelectedID := sgList.Cells[0, 1];
    if not FSelectedID.IsEmpty then
      DtsList.DataSet.Locate('ID', FSelectedID, []);
  end;
end;

procedure TFrmBaseListView.sgListDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  FormatStr, CellText: string;
  Num: Extended;
begin
  if ARow = 0 then
    CellText := sgList.Cells[ACol, ARow]
  else
  begin
    FormatStr := ColumnMasks[ACol];
    if (FormatStr <> '') and TryStrToFloat(sgList.Cells[ACol, ARow], Num) then
      CellText := FormatFloat(FormatStr, Num)
    else
      CellText := sgList.Cells[ACol, ARow];
  end;

  with TStringGrid(Sender).Canvas do
  begin
    if ARow < sgList.FixedRows then
    begin
      Brush.Color := TColor($00CCCCCC);
      Font.Color := clBlack;
      Font.Style := [fsBold];
      FillRect(Rect);
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, TStringGrid(Sender).Cells[ACol, ARow]);
    end
    else if gdSelected in State then
    begin
      Brush.Color := clHighlight;
      Font.Color := clHighlightText;
      FillRect(Rect);
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, CellText);
    end
    else
    begin
      Brush.Color := clWindow;
      Font.Color := clWindowText;
      Font.Style := [];
      FillRect(Rect);
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, CellText);
    end;
  end;
end;

procedure TFrmBaseListView.sgListSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := ARow > 0;
  FSelectedID := sgList.Cells[0, Arow];
  if not FSelectedID.IsEmpty then
    DtsList.DataSet.Locate('ID', FSelectedID, []);
end;

procedure TFrmBaseListView.ActDeleteRecordExecute(Sender: TObject);
begin
  if FSelectedID.IsEmpty then
    Exit;

  if Application.MessageBox(
  'Deseja realmente apagar o registro?',
  'Deletar',
  MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = ID_YES then
  begin
    FListDAO.Delete(
      FSelectedID.ToInteger
    );

    OpenTable;
  end;
end;

procedure TFrmBaseListView.ActNewRecordExecute(Sender: TObject);
begin
  if FRegisterView.ShowRegister(Self, FListDAO) then
    OpenTable;
end;

procedure TFrmBaseListView.ActRefreshListExecute(Sender: TObject);
begin
  OpenTable;
end;

procedure TFrmBaseListView.ActUpdateRecordExecute(Sender: TObject);
var
  ObjSelected: IModel;
begin
  if FSelectedID.IsEmpty then
    Exit;

  ObjSelected := FListDAO.Model.Create;
  ObjSelected.BindObjectFromFields(DtsList.DataSet.Fields);

  if RegisterView.ShowUpdate(
    Self,
    FListDAO,
    ObjSelected,
    FSelectedID.ToInteger
  ) then
  begin
    OpenTable;
  end;
end;

procedure TFrmBaseListView.ConfigureGrid;
var
  ctx: TRttiContext;
  typ: TRttiType;
  prop: TRttiProperty;
  properties: TArray<TRttiProperty>;
  ColIndex: Integer;
  attr: TCustomAttribute;
begin
  ctx := TRttiContext.Create;
  SetLength(ColumnMasks, 0);
  try
    typ := ctx.GetType(FListDAO.Model);
    properties := typ.GetProperties;
    sgList.ColCount := Length(properties) -1;
    sgList.FixedCols := 0;
    sgList.Options := sgList.Options + [goRowSelect];

    ColIndex := 0;
    for prop in properties do
    begin
      for attr in prop.GetAttributes do
      begin
        if attr is TDBField then
        begin
          if sgList.ColCount <= ColIndex then
            sgList.ColCount := ColIndex + 1;

          sgList.ColWidths[ColIndex] := 100;
          SetLength(ColumnMasks, sgList.ColCount);

          sgList.Cells[ColIndex, 0] := TDBField(attr).DisplayText;
          ColumnMasks[ColIndex] := TDBField(attr).Mask;
          Inc(ColIndex);
        end;
      end;
    end;
  finally
    ctx.Free;
  end;
end;

procedure TFrmBaseListView.LoadDataIntoGrid(aDataSource: TDataSource);
var
  i, j: Integer;
begin
  if not Assigned(aDataSource.DataSet) then
  begin
    ShowMessage('DataSet não definido!');
    Exit;
  end;

  if not aDataSource.DataSet.Active then
    aDataSource.DataSet.Open;

  sgList.RowCount := aDataSource.DataSet.RecordCount + 1;

  if sgList.RowCount = 1 then
  sgList.RowCount := 2;

  sgList.FixedRows := 1;

  aDataSource.DataSet.First;
  i := 1;
  while not aDataSource.DataSet.Eof do
  begin
    for j := 0 to sgList.ColCount - 1 do
    begin
      if aDataSource.DataSet.Fields.Count > j then
        sgList.Cells[j, i] := aDataSource.DataSet.Fields[j].AsString;
    end;
    Inc(i);
    aDataSource.DataSet.Next;
  end;

  sgList.Refresh;
end;

end.
