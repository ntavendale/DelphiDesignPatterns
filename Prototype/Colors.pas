unit Colors;

interface

uses
  System.SysUtils, System.Classes;

type
  // Prototype abstract class
  TPrototypeColor = class abstract
  public
    function Clone: TPrototypeColor; virtual; abstract;
  end;

  // Production class
  TProductionColor = class(TPrototypeColor)
  private
    FRed: Byte;
    FGreen: Byte;
    FBlue: Byte;
  public
    constructor Create(ARed, AGreen, ABlue: Byte);
    function Clone: TPrototypeColor; override;
  end;

implementation

constructor TProductionColor.Create(ARed, AGreen, ABlue: Byte);
begin
  FRed := ARed;
  FGreen := AGreen;
  FBlue := ABlue;
end;

function TProductionColor.Clone: TPrototypeColor;
begin
  WriteLn(String.Format('Cloning color RGB: %3d, %3d, %3d',[FRed, FGreen, FBlue]));
  Result := TProductionColor.Create(FRed, FGreen, FBlue);
end;

end.
