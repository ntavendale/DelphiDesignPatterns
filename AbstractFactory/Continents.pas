unit Continents;

interface

uses
  System.SysUtils, System.Classes, Animals;

type
  // Every continent has herbivores and carnivores.
  // Continents produce animals - both herboveres and carnivores.
  // They are Animal Factories.
  // A TContinent abstract class is therefore an Abstract Factory.
  TContinent = class abstract
  public
    function CreateHerbivore: THerbivore; virtual; abstract;
    function CreateCarnivore: TCarnivore; virtual; abstract;
  end;

  // NorthAmerica overiides the CreateHerbivore and CreateCarnivore methods
  // to produce herbivore and carnivore species specific to it.
  TNorthAmerica = class(TContinent)
  public
    function CreateHerbivore: THerbivore; override;
    function CreateCarnivore: TCarnivore; override;
  end;

  // Africa overiides the CreateHerbivore and CreateCarnivore methods
  // to produce herbivore and carnivore species specific to it.
  TAfrica = class(TContinent)
  public
    function CreateHerbivore: THerbivore; override;
    function CreateCarnivore: TCarnivore; override;
  end;

implementation

// NorthAmerica has Elk and Wolf speciaes
function TNorthAmerica.CreateHerbivore: THerbivore;
begin
  Result := TElk.Create;
end;

function TNorthAmerica.CreateCarnivore: TCarnivore;
begin
  Result := TWolf.Create;
end;

// Africa has Gazelles and Lions
function TAfrica.CreateHerbivore: THerbivore;
begin
  Result := TGazelle.Create;
end;

function TAfrica.CreateCarnivore: TCarnivore;
begin
  Result := TLion.Create;
end;

end.
