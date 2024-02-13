unit Customers;

interface

uses
  System.SysUtils, System.Classes, DataObjects;

type
  // This class acts as a bridge between the TDataObject class and
  // the TCustomers class below, which refines the abstraction.
  TCustomersBase = class
  private
    FDataObject: TDataObject;
  public
    destructor Destroy; override;
    procedure Next; virtual;
    procedure Prior; virtual;
    procedure Add(AValue: String); virtual;
    procedure Delete(AValue: String); virtual;
    procedure Show; virtual;
    procedure ShowAll; virtual;
    property Data: TDataObject read FDataObject write FDataObject;
  end;

  TCustomers = class(TCustomersBase)
  public
    procedure ShowAll; override;
  end;

implementation

destructor TCustomersBase.Destroy;
begin
  if nil <> FDataObject then
    FDataObject.Free;
  inherited Destroy;
end;

procedure TCustomersBase.Next;
begin
  if nil <> FDataObject then
    FDataobject.NextRecord;
end;

procedure TCustomersBase.Prior;
begin
  if nil <> FDataObject then
    FDataobject.PriorRecord;
end;

procedure TCustomersBase.Add(AValue: String);
begin
  if nil <> FDataObject then
    FDataobject.AddRecord(AValue);
end;

procedure TCustomersBase.Delete(AValue: String);
begin
  if nil <> FDataObject then
    FDataobject.DeleteRecord(AValue);
end;

procedure TCustomersBase.Show;
begin
  if nil <> FDataObject then
    FDataobject.ShowRecord;
end;

procedure TCustomersBase.ShowAll;
begin
  if nil <> FDataObject then
    FDataobject.ShowAllRecords;
end;

procedure TCustomers.ShowAll;
begin
  WriteLn(sLinebreak, '------------------------');
  inherited ShowAll;
  WriteLn('------------------------');
end;

end.
