unit Attributes;

interface

uses
  System.RTTI,
  System.Variants,
  System.Classes;

type
  TTable = class(TCustomAttribute)
  private
    FTableName: string;
  public
    constructor Create(const AName: string);
    property TableName: string read FTableName write FTableName;
  end;

  TDBField  = class(TCustomAttribute)
  private
    FVisible: Boolean;
    FFieldName: string;
    FEditable: Boolean;
    FDisplayText: string;
    FMask: string;
    FSize: Integer;
    FList: string;
    FIsPrimaryKey: Boolean;
  public
    constructor Create(const AFieldName: string; const ADisplayText: string = '';
      const AVisible: Boolean = True; const AEditable: Boolean = True;
      const AMask: string = ''; const ASize: Integer = 0;
      const AList: string = ''; const AIsPrimaryKey: Boolean = False);

    property IsPrimaryKey: Boolean read FIsPrimaryKey write FIsPrimaryKey;
    property FieldName: string read FFieldName write FFieldName;
    property DisplayText: string read FDisplayText write FDisplayText;
    property Mask: string read FMask write FMask;
    property Size: Integer read FSize write FSize;
    property Visible: Boolean read FVisible write FVisible;
    property Editable: Boolean read FEditable write FEditable;
    property List: string read FList write FList;
  end;

  TNotNull = class(TCustomAttribute)
  end;

  TForeignKey = class(TCustomAttribute)
  private
    FReferenceTable: string;
    FDisplayField: string;
    FKeyField: string;
  public
    constructor Create(const ReferenceTable, DisplayField, KeyField: string);
    property ReferenceTable: string read FReferenceTable;
    property DisplayField: string read FDisplayField;
    property KeyField: string read FKeyField;
  end;

implementation

{ TTable }

constructor TTable.Create(const AName: string);
begin
  FTableName := AName;
end;

{ TField }

constructor TDBField.Create(const AFieldName, ADisplayText: string;
  const AVisible, AEditable: Boolean; const AMask: string;
  const ASize: Integer; const AList: string; const AIsPrimaryKey: Boolean);
begin
  FIsPrimaryKey := AIsPrimaryKey;
  FFieldName    := AFieldName;
  FDisplayText  := ADisplayText;
  FMask         := AMask;
  FSize         := ASize;
  FVisible      := AVisible;
  FEditable     := AEditable;
  FList         := AList;
end;

{ TForeignKey }

constructor TForeignKey.Create(const ReferenceTable, DisplayField, KeyField: string);
begin
  FReferenceTable := ReferenceTable;
  FDisplayField := DisplayField;
  FKeyField := KeyField;
end;

end.
