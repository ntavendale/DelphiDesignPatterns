unit MathClasses;

interface

uses
  System.SysUtils, System.Classes;

type
  IMath = interface
    function Add(x, y: Double): Double;
    function Subtract(x, y: Double): Double;
    function Multiply(x, y: Double): Double;
    function Divide(x, y: Double): Double;
  end;

  TMath = class(TInterfacedObject, IMath)
  public
    function Add(x, y: Double): Double;
    function Subtract(x, y: Double): Double;
    function Multiply(x, y: Double): Double;
    function Divide(x, y: Double): Double;
  end;

  // TMath is nice but we want to order up some changes. We want subtract
  // to return the absolute difference and thus be always positive.
  // In addition we want to return Divide to rturn 0 if eitgher the neumerator
  // or the deniminator is zero.
  // We can do this though a proxy class. The proxy class will allow us to do
  // this without re-implenmting the logic in the TMath class.
  TMathProxy = class(TInterfacedObject, IMath)
  private
    FMath: TMath;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(x, y: Double): Double;
    function Subtract(x, y: Double): Double;
    function Multiply(x, y: Double): Double;
    function Divide(x, y: Double): Double;
  end;

implementation

function TMath.Add(x, y: Double): Double;
begin
  Result := x + y
end;

function TMath.Subtract(x, y: Double): Double;
begin
  Result := x - y
end;

function TMath.Multiply(x, y: Double): Double;
begin
  Result := x * y
end;

function TMath.Divide(x, y: Double): Double;
begin
  Result := x / y
end;

constructor TMathProxy.Create;
begin
  FMath := TMath.Create;
end;

destructor TMathProxy.Destroy;
begin
  FMath.Free;
  inherited Destroy;
end;

function TMathProxy.Add(x, y: Double): Double;
begin
  Result := FMath.Add(x, y);
end;

function TMathProxy.Subtract(x, y: Double): Double;
begin
  // Return absolute difference
  if x < y then
    Result := FMath.Subtract(y, x)
  else
    Result := FMath.Subtract(x, y);
end;

function TMathProxy.Multiply(x, y: Double): Double;
begin
  Result := FMath.Multiply(x, y);
end;

function TMathProxy.Divide(x, y: Double): Double;
begin
  try
    Result := FMath.Divide(x, y);
  except
   on EZeroDivide do
     Result := 0.00;
  end;
end;

end.
