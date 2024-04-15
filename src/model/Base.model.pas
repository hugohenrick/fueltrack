unit Base.model;

interface

uses
  Attributes,
  Data.DB,
  Vcl.Forms,
  System.Classes,
  model.intf, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TBaseModel = class(TInterfacedObject, IModel)
  private
    class function GetFormComponentList(const AForm: TForm): TStringList;
    function SetDefaultIfEmpty(const AType: string; const AValue: Variant): Variant;
    function StrToVarType(const AValue: string; AType: String): Variant;
  public
    procedure ValidateData; virtual;

    procedure BindObjectFromFields(const AFields: TFields);
    procedure BingObjectFromForm(const AForm: TForm);
    procedure BindForm(const AForm: TForm);

    class procedure ConfigureForm(const AForm: TForm);
    class procedure LoadForeignKeyData(ComboBox: TComboBox; ContextType: TClass);
    class procedure LoadForeignKeyDataToComboBox(AForm: TForm; ComboBox: TComboBox; AForeignKeyAttribute: TForeignKey);
  end;

  TBaseModelClass = class of TBaseModel;

implementation

uses
  System.SysUtils,
  System.RTTI,
  System.Variants,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.Mask, dmConnection;

{ TBaseModel }

procedure TBaseModel.ValidateData;
begin
  // Override in subclasses
end;

class function TBaseModel.GetFormComponentList(const AForm: TForm): TStringList;
var
  RType: TRttiType;
  RContext: TRttiContext;
  RField: TRttiField;
  RAttribute: TCustomAttribute;
begin
  Result := TStringList.Create;
  Result.Clear;

  RType := RContext.GetType(AForm.ClassInfo);
  try
    for RField in RType.GetFields do
    begin
      for RAttribute in RField.GetAttributes do
      begin
        if RAttribute is TDBField then
          Result.Add((RAttribute as TDBField).FieldName + '=' + RField.Name);
      end;
    end;
  finally
    RContext.Free;
  end;

  Assert(Result.Count > 0, 'No form component has been configured for binding.');
end;

procedure TBaseModel.BindObjectFromFields(const AFields: TFields);
var
  RType: TRttiType;
  RContext: TRttiContext;
  RProperty: TRttiProperty;
  RAttribute: TCustomAttribute;
  CurrentField: TField;
  PropValue: Variant;
begin
  RType := RContext.GetType(Self.ClassInfo);
  try
    for RProperty in RType.GetProperties do
    begin
      for RAttribute in RProperty.GetAttributes do
      begin
        if RAttribute is TDBField then
        begin
          CurrentField := AFields.FindField(TDBField(RAttribute).FieldName);
          if Assigned(CurrentField) then
            PropValue := CurrentField.Value
          else
            PropValue := '';

          RProperty.SetValue(
            Pointer(Self), TValue.FromVariant(PropValue)
          );
        end;
      end;
    end;
  finally
    RContext.Free;
  end;
end;

procedure TBaseModel.BindForm(const AForm: TForm);
var
  RType: TRttiType;
  RContext: TRttiContext;
  RProperty: TRttiProperty;
  RAttribute: TCustomAttribute;
  Component: TComponent;
  FormComponentList: TStringList;
  FormField: string;
begin
  FormComponentList := GetFormComponentList(AForm);
  try
    RType := RContext.GetType(Self.ClassInfo);
    try
      for RProperty in RType.GetProperties do
      begin
        for RAttribute in RProperty.GetAttributes do
        begin
          if RAttribute is TDBField then
          begin
            FormField := FormComponentList.Values[(RAttribute as TDBField).FieldName];
            if not FormField.Trim.IsEmpty then
            begin
              Component := AForm.FindComponent(FormField);
              if Assigned(Component) then
              begin
                if (Component is TEdit) then
                  (Component as TEdit).Text := RProperty.GetValue(Self).ToString
                else
                if (Component is TComboBox) then
                begin
                  if (Component as TComboBox).Items.Count > 0 then
                    (Component as TComboBox).ItemIndex := (Component as TComboBox).Items.IndexOf(RProperty.GetValue(Self).ToString)
                  else
                    (Component as TComboBox).Text := RProperty.GetValue(Self).ToString;
                end
                else
                if (Component is TMaskEdit) then
                  (Component as TMaskEdit).Text := RProperty.GetValue(Self).ToString
                else
                if (Component is TDateTimePicker) then
                  (Component as TDateTimePicker).Date := RProperty.GetValue(Self).AsVariant;
              end;
            end;
          end;
        end;
      end;
    finally
      RContext.Free;
    end;
  finally
    FormComponentList.Free;
  end;
end;

function TBaseModel.SetDefaultIfEmpty(const AType: string; const AValue: Variant): Variant;
begin
  Result := AValue;

  if VarIsNull(Result) then
  begin
    if AType.ToUpper.Equals('INTEGER') then
      Result := 0
    else
    if AType.ToUpper.Equals('TDATE') then
      Result := 0
    else
    if AType.ToUpper.Equals('TDATETIME') then
      Result := 0.0
    else
    if AType.ToUpper.Equals('DOUBLE') then
      Result := '0'
    else
      Result := '';
  end;
end;

function TBaseModel.StrToVarType(const AValue: string; AType: String): Variant;
begin
  Result := AValue;
  if AType.ToUpper.Equals('INTEGER') then
    Result := StrToIntDef(VarToStr(Result), 0)
  else
  if AType.ToUpper.Equals('TDATE') then
    Result := StrToDateDef(VarToStr(Result), 0)
  else
  if AType.ToUpper.Equals('TDATETIME') then
    Result := StrToDateTimeDef(VarToStr(Result), 0.0)
  else
  if AType.ToUpper.Equals('DOUBLE') then
    Result := StrToFloatDef(VarToStr(Result).Replace('.', ''), 0.00);
end;

procedure TBaseModel.BingObjectFromForm(const AForm: TForm);
var
  RType: TRttiType;
  RContext: TRttiContext;
  RProperty: TRttiProperty;
  RAttribute: TCustomAttribute;
  Component: TComponent;
  FormComponentList: TStringList;
  FormField: string;
  EnteredValue: Variant;
  Value: TValue;
  PropertyType: string;
begin
  FormComponentList := GetFormComponentList(AForm);
  try
    RType := RContext.GetType(Self.ClassInfo);
    try
      for RProperty in RType.GetProperties do
      begin
        EnteredValue   := null;
        PropertyType := RProperty.PropertyType.Name;

        for RAttribute in RProperty.GetAttributes do
        begin
          EnteredValue := Null;

          if RAttribute is TDBField then
          begin
            FormField := FormComponentList.Values[(RAttribute as TDBField).FieldName];
            if not FormField.Trim.IsEmpty then
            begin
              Component := AForm.FindComponent(FormField);
              if Assigned(Component) then
              begin
                if (Component is TEdit) then
                  EnteredValue := StrToVarType((Component as TEdit).Text, PropertyType)
                else
                if (Component is TComboBox) then
                begin
                  EnteredValue := (Component as TComboBox).Items[(Component as TComboBox).ItemIndex];
                  EnteredValue := StrToVarType(EnteredValue, PropertyType)
                end
                else
                if (Component is TMaskEdit) then
                  EnteredValue := StrToVarType((Component as TMaskEdit).Text, PropertyType)
                else
                if (Component is TDateTimePicker) then
                  EnteredValue := (Component as TDateTimePicker).DateTime;
              end;
            end;

            EnteredValue := SetDefaultIfEmpty(PropertyType, EnteredValue);
            Value         := TValue.FromVariant(EnteredValue);

            RProperty.SetValue(Pointer(Self), Value);
            Break;
          end;
        end;
      end;
    finally
      RContext.Free;
    end;
  finally
    FormComponentList.Free;
  end;
end;

class procedure TBaseModel.ConfigureForm(const AForm: TForm);
var
  RContext: TRttiContext;
  RType: TRttiType;
  RProperty: TRttiProperty;
  RAttribute: TCustomAttribute;
  Component: TComponent;
  FormComponentList: TStringList;
  ComponentName: string;
begin
  FormComponentList := GetFormComponentList(AForm);
  try
    if FormComponentList.Count <= 0 then
      Exit;

    RContext := TRttiContext.Create;
    try
      RType := RContext.GetType(Self.ClassInfo);
      for RProperty in RType.GetProperties do
      begin
        Component := AForm.FindComponent(RProperty.Name);

//        if not Assigned(Component) then
//          Continue;

        for RAttribute in RProperty.GetAttributes do
        begin
          if RAttribute is TDBField then
          begin
            ComponentName := FormComponentList.Values[TDBField(RAttribute).FieldName];
            Component := AForm.FindComponent(ComponentName);
            if Assigned(Component) then
            begin
              (Component as TWinControl).Enabled := TDBField(RAttribute).Editable;
              (Component as TWinControl).SetTextBuf('');

              if Component is TEdit then
                (Component as TEdit).MaxLength := TDBField(RAttribute).Size
              else if Component is TComboBox then
              begin
                if not TDBField(RAttribute).List.Trim.IsEmpty then
                begin
                  (Component as TComboBox).Style := csDropDownList;
                  (Component as TComboBox).Items.Text := TDBField(RAttribute).List.Replace(';', sLineBreak);
                end;
              end
              else if Component is TDateTimePicker then
                (Component as TDateTimePicker).Format := TDBField(RAttribute).Mask;
            end;
          end
          else if RAttribute is TForeignKey then
          begin
            if Component is TComboBox then
              LoadForeignKeyDataToComboBox(AForm, Component as TComboBox, TForeignKey(RAttribute));
          end;
        end;
      end;
    finally
      RContext.Free;
    end;
  finally
    FormComponentList.Free;
  end;
end;

class procedure TBaseModel.LoadForeignKeyDataToComboBox(AForm: TForm; ComboBox: TComboBox; AForeignKeyAttribute: TForeignKey);
var
  Query: TFDQuery;
begin
  if Assigned(ComboBox) then
  begin
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := DtmConnection.FDConnection1;
      Query.SQL.Text := Format('SELECT %s, %s FROM %s',
        [AForeignKeyAttribute.KeyField, AForeignKeyAttribute.DisplayField, AForeignKeyAttribute.ReferenceTable]);
      Query.Open;
      ComboBox.Items.BeginUpdate;
      try
        ComboBox.Items.Clear;
        while not Query.Eof do
        begin
          ComboBox.Items.AddObject(Query.FieldByName(AForeignKeyAttribute.DisplayField).AsString,
                                   TObject(Query.FieldByName(AForeignKeyAttribute.KeyField).AsInteger));
          Query.Next;
        end;
      finally
        ComboBox.Items.EndUpdate;
      end;
    finally
      Query.Free;
    end;
  end;
end;

class procedure TBaseModel.LoadForeignKeyData(ComboBox: TComboBox; ContextType: TClass);
var
  Context: TRttiContext;
  RType: TRttiType;
  Prop: TRttiProperty;
  Attr: TCustomAttribute;
  Query: TFDQuery;
  ForeignKey: TForeignKey;
begin
  Context := TRttiContext.Create;
  try
    RType := Context.GetType(ContextType);
    for Prop in RType.GetProperties do
      for Attr in Prop.GetAttributes do
        if Attr is TForeignKey then
        begin
          ForeignKey := TForeignKey(Attr);
          Query := TFDQuery.Create(nil);
          try
            Query.Connection := DtmConnection.FDConnection1;  // Assume uma conexão global ou passada como parâmetro
            Query.SQL.Text := Format('SELECT %s, %s FROM %s', [ForeignKey.KeyField, ForeignKey.DisplayField, ForeignKey.ReferenceTable]);
            Query.Open;
            ComboBox.Items.BeginUpdate;
            try
              ComboBox.Items.Clear;
              while not Query.Eof do
              begin
                ComboBox.Items.AddObject(Query.FieldByName(ForeignKey.DisplayField).AsString, TObject(Query.FieldByName(ForeignKey.KeyField).AsInteger));
                Query.Next;
              end;
            finally
              ComboBox.Items.EndUpdate;
            end;
          finally
            Query.Free;
          end;
          Break;  // Supõe-se que apenas uma propriedade com ForeignKey por classe, se não remover o break
        end;
  finally
    Context.Free;
  end;
end;

end.

