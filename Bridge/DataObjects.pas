unit DataObjects;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  TDataObject = class abstract
  public
    procedure NextRecord; virtual; abstract;
    procedure PriorRecord; virtual; abstract;
    procedure AddRecord(AName: String); virtual; abstract;
    procedure DeleteRecord(AName: String); virtual; abstract;
    function GetCurrentRecord: String; virtual; abstract;
    procedure ShowRecord; virtual; abstract;
    procedure ShowAllRecords; virtual; abstract;
  end;

  TCustomersData = class(TDataObject)
  private
    FCustomers: TList<String>;
    FCurrent: Integer;
    FCity: String;
  public
    constructor Create(ACity: String);
    destructor Destroy; override;
    procedure NextRecord; override;
    procedure PriorRecord; override;
    procedure AddRecord(AName: String); override;
    procedure DeleteRecord(AName: String); override;
    function GetCurrentRecord: String; override;
    procedure ShowRecord; override;
    procedure ShowAllRecords; override;
  end;

implementation

constructor TCustomersData.Create;
begin
  FCity := ACity;
  FCustomers := TList<String>.Create;
  // Loaded from a database
  FCustomers.Add('Jim Jones');
  FCustomers.Add('Samual Jackson');
  FCustomers.Add('Allen Good');
  FCustomers.Add('Ann Stills');
  FCustomers.Add('Lisa Giolani');
end;

destructor TCustomersData.Destroy;
begin
  FCustomers.Free;
  inherited Destroy;
end;

procedure TCustomersData.NextRecord;
begin
  if FCurrent <= (FCustomers.Count - 1)  then
    Inc(FCurrent);
end;

procedure TCustomersData.PriorRecord;
begin
  if FCurrent > 0  then
    Dec(FCurrent);
end;

procedure TCustomersData.AddRecord(AName: String);
begin
  FCustomers.Add(AName);
end;

procedure TCustomersData.DeleteRecord(AName: String);
begin
  FCustomers.Remove(AName);
end;

function TCustomersData.GetCurrentRecord: String;
begin
  Result := FCustomers[FCurrent];
end;

procedure TCustomersData.ShowRecord;
begin
  WriteLn(FCustomers[FCurrent]);
end;

procedure TCustomersData.ShowAllRecords;
begin
  WriteLn('Customer City: ', FCity);
  for var LCustomer in FCustomers do
    WriteLn(' ', LCustomer);
end;

end.
