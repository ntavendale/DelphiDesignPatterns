unit VehicleBuilders;

interface

uses
  System.SysUtils, System.Classes, Vehicle;

type
  // All vehicles are built using the same series of steps
  // and that's all the abstract builder class needs to know.
  TVehicleBuilder = class abstract
  protected
    FVehicle: TVehicle;
  public
    procedure BuildFrame; virtual; abstract;
    procedure BuildEngine; virtual; abstract;
    procedure BuildWheels; virtual; abstract;
    procedure BuildDoors; virtual; abstract;
    property Vehicle: TVehicle read FVehicle;
  end;

  // The individual builder classes for the distinct vehicles
  // are the ones that have to implement the actual build steps.
  TMotorcycleBuilder = class(TVehicleBuilder)
  public
    constructor Create;
    destructor Destroy; override;
    procedure BuildFrame; override;
    procedure BuildEngine; override;
    procedure BuildWheels; override;
    procedure BuildDoors; override;
  end;

  TCarBuilder = class(TVehicleBuilder)
  public
    constructor Create;
    destructor Destroy; override;
    procedure BuildFrame; override;
    procedure BuildEngine; override;
    procedure BuildWheels; override;
    procedure BuildDoors; override;
  end;

  TScooterBuilder = class(TVehicleBuilder)
  public
    constructor Create;
    destructor Destroy; override;
    procedure BuildFrame; override;
    procedure BuildEngine; override;
    procedure BuildWheels; override;
    procedure BuildDoors; override;
  end;

implementation

constructor TMotorcycleBuilder.Create;
begin
  FVehicle := TVehicle.Create('Motorcycle');
end;

destructor TMotorcycleBuilder.Destroy;
begin
  FVehicle.Free;
  inherited Destroy;
end;

procedure TMotorcycleBuilder.BuildFrame;
begin
  FVehicle['frame'] := 'Motorcycle Frame';
end;

procedure TMotorcycleBuilder.BuildEngine;
begin
  FVehicle['engine'] := '500 cc';
end;

procedure TMotorcycleBuilder.BuildWheels;
begin
  FVehicle['wheels'] := '2';
end;

procedure TMotorcycleBuilder.BuildDoors;
begin
  FVehicle['doors'] := '0';
end;

constructor TCarBuilder.Create;
begin
  FVehicle := TVehicle.Create('Car');
end;

destructor TCarBuilder.Destroy;
begin
  FVehicle.Free;
  inherited Destroy;
end;

procedure TCarBuilder.BuildFrame;
begin
  FVehicle['frame'] := 'Car Frame';
end;

procedure TCarBuilder.BuildEngine;
begin
  FVehicle['engine'] := '2500 cc';
end;

procedure TCarBuilder.BuildWheels;
begin
  FVehicle['wheels'] := '4';
end;

procedure TCarBuilder.BuildDoors;
begin
  FVehicle['doors'] := '4';
end;

constructor TScooterBuilder.Create;
begin
  FVehicle := TVehicle.Create('Scooter');
end;

destructor TScooterBuilder.Destroy;
begin
  FVehicle.Free;
  inherited Destroy;
end;

procedure TScooterBuilder.BuildFrame;
begin
  FVehicle['frame'] := 'Scooter Frame';
end;

procedure TScooterBuilder.BuildEngine;
begin
  FVehicle['engine'] := '50 cc';
end;

procedure TScooterBuilder.BuildWheels;
begin
  FVehicle['wheels'] := '2';
end;

procedure TScooterBuilder.BuildDoors;
begin
  FVehicle['doors'] := '0';
end;

end.
