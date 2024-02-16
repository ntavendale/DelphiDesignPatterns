unit Character;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  TCharacter = class abstract
  protected
    FSymbol: Char;
    FWidth: Integer;
    FHeight: Integer;
    FAscent: Integer;
    FDescent: Integer;
    FPointSize: Integer;
  public
    procedure Display(APointSize: Integer); virtual; abstract;
  end;

  TCharacterA = class(TCharacter)
  public
    constructor Create;
    procedure Display(APointSize: Integer); override;
  end;

  TCharacterB = class(TCharacter)
  public
    constructor Create;
    procedure Display(APointSize: Integer); override;
  end;

  // C...Y  - you get the point of one for each character but this is a demo app
  // so we're not puitting in all the letters of the alphabet.

  TCharacterZ = class(TCharacter)
  public
    constructor Create;
    procedure Display(APointSize: Integer); override;
  end;

  TCharacterFactory = class
  private
    FCharacters: TObjectDictionary<Char, TCharacter>;
  public
    constructor Create;
    destructor Destroy; override;
    function GetCharacter(AKey: Char): TCharacter;
  end;

implementation

constructor TCharacterA.Create;
begin
  FSymbol := 'A';
  FHeight := 100;
  FWidth := 120;
  FAscent := 70;
  FDescent := 0;
end;

procedure TCharacterA.Display(APointSize: Integer);
begin
  FPointSize := APointSize;
  WriteLn(FSymbol, ' (pointsize ', FPointSize, ')');
end;

constructor TCharacterB.Create;
begin
  FSymbol := 'B';
  FHeight := 100;
  FWidth := 140;
  FAscent := 72;
  FDescent := 0;
end;

procedure TCharacterB.Display(APointSize: Integer);
begin
  FPointSize := APointSize;
  WriteLn(FSymbol, ' (pointsize ', FPointSize, ')');
end;

constructor TCharacterZ.Create;
begin
  FSymbol := 'Z';
  FHeight := 100;
  FWidth := 100;
  FAscent := 68;
  FDescent := 0;
end;

procedure TCharacterZ.Display(APointSize: Integer);
begin
  FPointSize := APointSize;
  WriteLn(FSymbol, ' (pointsize ', FPointSize, ')');
end;

constructor TCharacterFactory.Create;
begin
  FCharacters := TObjectDictionary<Char, TCharacter>.Create([doOwnsValues]);
end;

destructor TCharacterFactory.Destroy;
begin
  FCharacters.Free;
  inherited Destroy;
end;

function TCharacterFactory.GetCharacter(AKey: Char): TCharacter;
begin
  // If instance allready there, preference is to reuse it.
  if (FCharacters.ContainsKey(AKey)) then
  begin
    Result := FCharacters[AKey];
    EXIT;
  end;

  // Only add concrete flyweigth objects if not already instance
  // of class in Dictionary.
  if 'A' = AKey then
    FCharacters.Add(AKey, TCharacterA.Create)
  else if 'B' = AKey then
    FCharacters.Add(AKey, TCharacterB.Create)
  // C..Y
  else if 'Z' = AKey then
    FCharacters.Add(AKey, TCharacterZ.Create);

  Result := FCharacters[AKey];
end;

end.
