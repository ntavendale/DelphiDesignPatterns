unit Animals;

interface

uses
  System.SysUtils, System.Classes;

type
  // Abstract animal classes - hervivores and canrnivores
  // While different parts of the world have different destinct speciaes of
  // herbivores and carnivores, the interactioons among them remain the same
  // i.e carnivores eat herbivores no matter where in the world they are.
  // So this interaction is defined in the abstract classes.
  THerbivore = class abstract
  end;

  TCarnivore = class abstract
  public
    procedure Eat(AHerbivore: THerbivore); virtual; abstract;
  end;

  // In North America we have Elk (a herbivore) and they are
  // eaten by wolves (carnivores).
  TElk = class(THerbivore)
  end;

  TWolf = class(TCarnivore)
  public
    procedure Eat(AHerbivore: THerbivore); override;
  end;

  // Africa has the same interaction among it's carnivores and herbivores
  // but in Africa they are Lions and Gazelles
  TGazelle = class(THerbivore)
  end;

  TLion = class(TCarnivore)
  public
    procedure Eat(AHerbivore: THerbivore); override;
  end;

implementation

procedure TWolf.Eat(AHerbivore: THerbivore);
begin
  WriteLn(Self.ClassName, ' eats the ' + AHerbivore.ClassName);
end;

procedure TLion.Eat(AHerbivore: THerbivore);
begin
  WriteLn(Self.ClassName, ' eats the ' + AHerbivore.ClassName);
end;

end.
