unit BuildShop;

interface

uses
  System.SysUtils, System.Classes, VehicleBuilders;

type
  TBuildShop = class
  public
    class procedure Construct(AVehicleBuilder: TVehicleBuilder);
  end;

implementation

class procedure TBuildShop.Construct(AVehicleBuilder: TVehicleBuilder);
begin
  AVehicleBuilder.BuildFrame;
  AVehicleBuilder.BuildEngine;
  AVehicleBuilder.BuildWheels;
  AVehicleBuilder.BuildDoors;
end;

end.
