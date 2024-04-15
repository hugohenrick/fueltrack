unit Model.intf;

interface

uses
  Data.DB,
  Vcl.Forms;

type
  IModel = interface
    ['{0C3ED95A-F86B-4380-8961-B8A3CF09C9B7}']
    procedure BindObjectFromFields(const AFields: TFields);
    procedure BingObjectFromForm(const AForm: TForm);
    procedure BindForm(const AForm: TForm);

    procedure ValidateData;
  end;

implementation

end.
