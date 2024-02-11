unit AnimalEcosystem;

interface

uses
  System.SysUtils, System.Classes, Animals, Continents;

type
  // This is the client class. The species in an animal ecosystem's food
  // chain depend on which continet that ecosystem is located.
  TAnimalEcosystem = class
  private
    FHerbivore: THerbivore;
    FCarnivore: TCarnivore;
  public
    constructor Create(AContient: TContinent);
    destructor Destroy; override;
    procedure DoFoodChain;
  end;

implementation

constructor TAnimalEcosystem.Create(AContient: TContinent);
begin
  FHerbivore := AContient.CreateHerbivore;
  FCarnivore := AContient.CreateCarnivore;
end;

destructor TAnimalEcosystem.Destroy;
begin
  FCarnivore.Free;
  FHerbivore.Free;
  inherited Destroy;
end;

procedure TAnimalEcosystem.DoFoodChain;
begin
  FCarnivore.Eat(FHerbivore);
end;

end.
