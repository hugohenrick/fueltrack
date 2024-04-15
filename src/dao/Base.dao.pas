unit Base.dao;

interface

uses
  Data.DB,
  base.model,
  model.intf,
  Dao.intf,
  System.Classes,
  System.SysUtils,
  System.Types,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Phys,
  FireDAC.Comp.Client,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Param;

type
  TBaseDAO = class(TInterfacedObject, IDAO)
  private
    FConnection: TFDConnection;
    FModelClass: TBaseModelClass;

    function GetFieldList(const AAsParameter: Boolean = False): string;
    function GetFieldsWithParameter(const AAddPKFields: Boolean = False): string;
    function GetPkField: string;
    function GetModelClass: TBaseModelClass;
    procedure ConfigureFieldsDataset(ADataset: TDataSet);
    function RemoveFinalComma(const AString: string): string;
    function GetInsertSQL: string;
    function GetUpdateSQL: string;
    function GetParamsFromObj(const AObject: TBaseModel;
      const AGetParamID: Boolean = True): TFDParams;
  public
    constructor Create(AFDConnection: TFDConnection; AModel: TBaseModelClass);
    function GetConnection: TFDConnection;

    function GetSQLCreateTable: string;
    function GetTableName: string;
    function GetSelect: string;

    function GetDataset(const AWhere: string = ''): TDataSet;

    procedure Save(const AObject: TBaseModel); virtual;
    procedure Update(const AID: Integer; const AObject: TBaseModel);
    procedure Delete(const AID: Integer);
  end;

  TBaseDAOClass = class of TBaseDAO;

implementation

uses
  Attributes,
  System.Variants,
  System.StrUtils,
  System.RTTI;

{ TBaseDAO }

constructor TBaseDAO.Create(AFDConnection: TFDConnection; AModel: TBaseModelClass);
begin
  FConnection  := AFDConnection;
  FModelClass := AModel;
end;

function TBaseDAO.GetConnection: TFDConnection;
begin
  Result := FConnection;
end;

function TBaseDAO.RemoveFinalComma(const AString: string): string;
begin
  Result := AString.Trim;
  if not Result.IsEmpty then
  begin
    if Result[Result.Length] = ',' then
      Result[Result.Length] := ' ';
    Result := Result.Trim;
  end;
end;

function TBaseDAO.GetSQLCreateTable: string;
var
  RContext: TRttiContext;
  RType: TRttiType;
  RAttribute: TCustomAttribute;
  RProperty: TRttiProperty;

  TableName: string;
  TableFields: string;
  sPropType: string;

  FieldString: string;
  FieldName: string;
  FieldPK: string;
  FieldType: string;
  FieldNotNull: string;
begin
  TableFields := EmptyStr;

  RType := RContext.GetType(FModelClass);
  try
    // Table name
    for RAttribute in RType.GetAttributes do
    begin
      if RAttribute is TTable then
        TableName := TTable(RAttribute).TableName;
    end;

    // Field names and types as per property type
    for RProperty in RType.GetProperties do
    begin
      // Field type
      sPropType := RProperty.PropertyType.Name.ToUpper;
      if sPropType.Equals('INTEGER') then
        FieldType := 'integer'
      else if sPropType.Equals('TDATE') then
        FieldType := 'date'
      else if sPropType.Equals('TDATETIME') then
        FieldType := 'datetime'
      else if sPropType.Equals('DOUBLE') then
        FieldType := 'double precision'
      else
        FieldType := 'text';

      FieldName    := '';
      FieldPK      := '';
      FieldNotNull := '';
      for RAttribute in RProperty.GetAttributes do
      begin
        if RAttribute is TDBField then
        begin
          FieldName := TDBField(RAttribute).FieldName;

          if TDBField(RAttribute).IsPrimaryKey then
            FieldPK := 'primary key';
        end;

        if RAttribute is TNotNull then
          FieldNotNull := 'not null';
      end;

      FieldString := FieldName;

      if not FieldString.IsEmpty then
        FieldString := FieldString + ' ' + FieldType;

      if not FieldNotNull.IsEmpty then
        FieldString := FieldString + ' ' + FieldNotNull;

      if not FieldPk.IsEmpty then
        FieldString := FieldString + ' ' + FieldPk;

      if not FieldString.IsEmpty then
      begin
        FieldString := FieldString + ',';
        TableFields := TableFields + sLineBreak + FieldString;
      end;
    end;

    TableFields := RemoveFinalComma(TableFields);
  finally
    RContext.Free;
  end;

  Result :=
    'create table if not exists ' + TableName + ' (' + sLineBreak +
    TableFields.Trim + sLineBreak +
    ');';
end;

function TBaseDAO.GetTableName: string;
var
  RContext: TRttiContext;
  RType: TRttiType;
  RAttribute: TCustomAttribute;
begin
  Result := EmptyStr;

  RType := RContext.GetType(FModelClass);
  try
    // Table name
    for RAttribute in RType.GetAttributes do
    begin
      if RAttribute is TTable then
        Result := TTable(RAttribute).TableName;
    end;
  finally
    RContext.Free;
  end;
end;

function TBaseDAO.GetPkField: string;
var
  RContext: TRttiContext;
  RType: TRttiType;
  RAttribute: TCustomAttribute;
  RProperty: TRttiProperty;
  SFieldName: string;
begin
  Result := EmptyStr;

  RType := RContext.GetType(FModelClass);
  try
    for RProperty in RType.GetProperties do
    begin
      for RAttribute in RProperty.GetAttributes do
      begin
        if (RAttribute is TDBField) then
        begin
          SFieldName := TDBField(RAttribute).FieldName;
          if (TDBField(RAttribute).IsPrimaryKey) then
          begin
            Result := SFieldName;
            Break;
          end;
        end;
      end;
    end;
  finally
    RContext.Free;
  end;
end;

function TBaseDAO.GetFieldList(const AAsParameter: Boolean): string;
var
  RContext: TRttiContext;
  RType: TRttiType;
  RAttribute: TCustomAttribute;
  RProperty: TRttiProperty;
begin
  Result := EmptyStr;

  RType := RContext.GetType(FModelClass);
  try
    for RProperty in RType.GetProperties do
    begin
      for RAttribute in RProperty.GetAttributes do
      begin
        if RAttribute is TDBField then
        begin
          Result := Result + IfThen(AAsParameter, ':') + TDBField(RAttribute).FieldName;
          Result := Result + ',';
        end;
      end;
    end;

    Result := RemoveFinalComma(Result);
  finally
    RContext.Free;
  end;
end;

function TBaseDAO.GetFieldsWithParameter(const AAddPKFields: Boolean): string;
var
  RContext: TRttiContext;
  RType: TRttiType;
  RAttribute: TCustomAttribute;
  RProperty: TRttiProperty;
  LineField: string;
begin
  Result := EmptyStr;

  RType := RContext.GetType(FModelClass);
  try
    for RProperty in RType.GetProperties do
    begin
      LineField := EmptyStr;

      for RAttribute in RProperty.GetAttributes do
      begin
        if RAttribute is TDBField then
        begin
          if (TDBField(RAttribute).IsPrimaryKey) and not(AAddPKFields) then
            LineField := ''
          else
          begin
            LineField := TDBField(RAttribute).FieldName;
            LineField := LineField + '= :' + LineField + ',';
          end;
        end;
      end;

      if not LineField.Trim.IsEmpty then
        Result := Result + LineField + sLineBreak;
    end;

    Result := RemoveFinalComma(Result);
  finally
    RContext.Free;
  end;
end;

function TBaseDAO.GetModelClass: TBaseModelClass;
begin
  Result := FModelClass;
end;

procedure TBaseDAO.ConfigureFieldsDataset(ADataset: TDataSet);
var
  RContext: TRttiContext;
  RType: TRttiType;
  RAttribute: TCustomAttribute;
  RProperty: TRttiProperty;
  FieldAttribute: TDBField;
  CurrentField: TField;
begin
  RType := RContext.GetType(FModelClass);
  try
    for RProperty in RType.GetProperties do
    begin
      for RAttribute in RProperty.GetAttributes do
      begin
        if RAttribute is TDBField then
        begin
          FieldAttribute := (RAttribute as TDBField);

          CurrentField := ADataset.FindField(FieldAttribute.FieldName);
          if Assigned(CurrentField) then
          begin
            CurrentField.DisplayLabel := FieldAttribute.DisplayText;
            CurrentField.ReadOnly     := not FieldAttribute.Editable;
            CurrentField.Visible      := FieldAttribute.Visible;

            case CurrentField.DataType of
              ftFloat, ftCurrency, ftBCD, ftFMTBcd:
                begin
                  (CurrentField as TFloatField).DisplayFormat := FieldAttribute.Mask;
                  (CurrentField as TFloatField).EditFormat    := FieldAttribute.Mask;
                end;

              ftDate, ftTime, ftDateTime, ftTimeStamp:
                begin
                  (CurrentField as TDateTimeField).DisplayFormat := FieldAttribute.Mask;
                  (CurrentField as TDateTimeField).EditMask      := FieldAttribute.Mask;
                end;

              ftMemo, ftWideMemo:
                begin
                  (CurrentField as TWideMemoField).DisplayValue := TBlobDisplayValue.dvFit;
                end;
            end;
          end;
        end;
      end;
    end;
  finally
    RContext.Free;
  end;
end;

function TBaseDAO.GetSelect: string;
begin
  Result := Format('select %s from %s', [
    Self.GetFieldList, Self.GetTableName
  ]);
end;

function TBaseDAO.GetInsertSQL: string;
begin
  Result :=
    Format('Insert into %s (%s) values (%s)', [
      GetTableName, GetFieldList, GetFieldList(True)
    ]);
end;

function TBaseDAO.GetUpdateSQL: string;
begin
  Result :=
    'update ' + GetTableName + ' set ' + sLineBreak +
    GetFieldsWithParameter             + sLineBreak +
    'where '                           + sLineBreak +
    GetPkField + ' = :' + GetPkField;
end;

function TBaseDAO.GetParamsFromObj(const AObject: TBaseModel;
  const AGetParamID: Boolean): TFDParams;
var
  RContext: TRttiContext;
  RType: TRttiType;
  RAttribute: TCustomAttribute;
  RProperty: TRttiProperty;
  ParamType: TFieldType;
  sPropType: string;
  sParamName: string;
  Value: Variant;
begin
  Result := TFDParams.Create;

  RType := RContext.GetType(AObject.ClassInfo);
  try
    for RProperty in RType.GetProperties do
    begin
      for RAttribute in RProperty.GetAttributes do
      begin
        if RAttribute is TDBField then
        begin
          sParamName := TDBField(RAttribute).FieldName;

          sPropType := RProperty.PropertyType.Name.ToUpper;
          if sPropType.Equals('INTEGER') then
            ParamType := TFieldType.ftInteger
          else if sPropType.Equals('TDATE') then
            ParamType := TFieldType.ftDate
          else if sPropType.Equals('TDATETIME') then
            ParamType := TFieldType.ftDateTime
          else if sPropType.Equals('DOUBLE') then
            ParamType := TFieldType.ftFloat
          else if sPropType.Equals('STRING') then
            ParamType := TFieldType.ftString
          else
            ParamType := TFieldType.ftUnknown;

          if (TDBField(RAttribute).IsPrimaryKey) and not(AGetParamID) then
            Continue;

          if ParamType <> TFieldType.ftUnknown then
          begin
            if TDBField(RAttribute).IsPrimaryKey then
              Value := Null
            else
              Value := RProperty.GetValue(AObject).AsVariant;

            if not VarIsNull(Value) then
            begin
              case ParamType of
                ftString   : Value := VarToStr(Value);
                ftInteger  : Value := StrToInt(VarToStr(Value));
                ftFloat    : Value := StrToFloat(VarToStr(Value).Replace('.', ''));
                ftDate     : Value := StrToDate(VarToStr(Value));
                ftDateTime : Value := StrToDateTime(VarToStr(Value));
              end;

              Result.CreateParam(
                ParamType, sParamName, TParamType.ptInput
              ).Value := Value;
            end
            else
            begin
              Result.CreateParam(
                ParamType, sParamName, TParamType.ptInput
              ).Clear;
            end;
          end;
        end;
      end;
    end;
  finally
    RContext.Free;
  end;
end;

function TBaseDAO.GetDataset(const AWhere: string): TDataSet;
var
  SQL: string;
begin
  if not Assigned(FConnection) then
    raise EDatabaseError.Create('Connection property not set.');

  SQL := self.GetSelect;
  if not AWhere.Trim.IsEmpty then
    SQL := SQL + ' where ' + AWhere;

  FConnection.ExecSQL(SQL, Result);
  ConfigureFieldsDataset(Result);
end;

procedure TBaseDAO.Delete(const AID: Integer);
var
  PkField: string;
  TableName: string;
  CountDelete: Integer;
begin
  if AID <= 0 then
    raise Exception.Create('Record ID not provided, cannot proceed.');

  if not Assigned(FConnection) then
    raise EDatabaseError.Create('Connection property not set.');

  PkField := GetPkField;
  if PkField.trim.IsEmpty then
    raise Exception.Create('Data model "TPK" property not properly configured.');

  TableName := GetTableName;
  if TableName.trim.IsEmpty then
    raise Exception.Create('Data model "TTableName" property not properly configured.');

  CountDelete := FConnection.ExecSQL(
    'delete from ' + TableName + ' where ' + PkField + ' = ' + AID.ToString
  );

  if CountDelete <= 0 then
    raise EDatabaseError.CreateFmt('No records deleted for the identifier "%s"', [AID]);
end;

procedure TBaseDAO.Save(const AObject: TBaseModel);
var
  Params: TFDParams;
  SQLInsert: string;
begin
  Assert(AObject <> nil, 'Object not provided.');
  AObject.ValidateData;

  SQLInsert  := GetInsertSQL;
  Params := GetParamsFromObj(AObject);
  try
    FConnection.ExecSQL(SQLInsert, Params);
  finally
    FreeAndNil(Params);
  end;
end;

procedure TBaseDAO.Update(const AID: Integer; const AObject: TBaseModel);
var
  Params: TFDParams;
  SQLUpdate: string;
begin
  Assert(AObject <> nil, 'Object not provided.');
  AObject.ValidateData;

  SQLUpdate  := GetUpdateSQL;
  Params := GetParamsFromObj(AObject, False);
  try
    Params.CreateParam(ftInteger, GetPkField, ptInput).AsInteger := AID;

    FConnection.ExecSQL(SQLUpdate, Params);
  finally
    FreeAndNil(Params);
  end;
end;

end.

