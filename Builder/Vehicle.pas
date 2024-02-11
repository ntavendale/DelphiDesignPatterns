unit Vehicle;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  TVehicle = class
  private
    FVehicleType: String;
    FParts: TDictionary<string, string>;
    function GetPart(AKey: String): String;
    procedure SetPart(AKey: String; AValue: String);
  public
    constructor Create(AVehicleType: String);
    destructor Destroy; override;
    procedure Show;
    property Parts[AKey: String]: String read GetPart write SetPart; default;
  end;

implementation

constructor TVehicle.Create(AVehicleType: String);
begin
  FVehicleType := AVehicleType;
  FParts := TDictionary<string, string>.Create;
end;

destructor TVehicle.Destroy;
begin
  FParts.Free;
  inherited Destroy;
end;

function TVehicle.GetPart(AKey: String): String;
begin
  if not FParts.TryGetValue(AKey, Result) then
    Result := String.Empty;
end;

procedure TVehicle.SetPart(AKey: String; AValue: String);
begin
  FParts.AddOrSetValue(AKey, AValue);
end;

procedure TVehicle.Show;
begin
  WriteLn(String.Empty);
  WriteLn('---------------------------');
  WriteLn('Vehicle Type: ', FVehicleType);
  var LPart: String := String.Empty;
  if FParts.TryGetValue('frame', LPart) then
    WriteLn('Frame: ', LPart);
  if FParts.TryGetValue('engine', LPart) then
    WriteLn('Engine: ', LPart);
  if FParts.TryGetValue('wheels', LPart) then
    WriteLn('# Wheels: ', LPart)
  else
    WriteLn('# Wheels: 0');
  if FParts.TryGetValue('doors', LPart) then
    WriteLn('# Doors: ', LPart)
  else
    WriteLn('# Doors: 0');
end;

end.
