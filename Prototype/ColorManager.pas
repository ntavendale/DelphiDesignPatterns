unit ColorManager;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Colors;

type
  // Protoype Manager. Works with the prototype class.
  TColorManager = class
  private
    FColors : TObjectDictionary<string, TPrototypeColor>;
    function GetColor(AKey: String): TPrototypeColor;
    procedure SetColor(AKey: String; AValue: TPrototypeColor);
  public
    constructor Create;
    destructor Destroy; override;
    property Colors[AKey: String]: TPrototypeColor read GetColor write SetColor; default;
  end;

implementation

constructor TColorManager.Create;
begin
  FColors := TObjectDictionary<string, TPrototypeColor>.Create([doOwnsValues]);
end;

destructor TColorManager.Destroy;
begin
  FColors.Free;
  inherited Destroy;
end;

function TColorManager.GetColor(AKey: String): TPrototypeColor;
begin
  Result := FColors[AKey];
end;

procedure TColorManager.SetColor(AKey: String; AValue: TPrototypeColor);
begin
  FColors.AddOrSetValue(AKey, AValue);
end;

end.
