unit ChemicalDatabank;

interface

uses
  System.SysUtils, System.Classes;

type
  //This is the class that will be adapted.
  TChemicalDatabank = class
  public
    function GetCriticalPoint(ACompound, APoint: String): Single;
    function GetMolecularStructure(ACompound: String): String;
    function GetMolecularWeight(ACompound: String): Double;
  end;

implementation

// The databank 'legacy API'
function TChemicalDatabank.GetCriticalPoint(ACompound, APoint: String): Single;
begin
  // Melting Point
  if ('M' = APoint.ToUpper) then
  begin
    if ('water' = ACompound.ToLower) then
      Result := 0.0
    else if ('benzene' = ACompound.ToLower) then
      Result := 5.5
    else if ('ethanol' = ACompound.ToLower) then
      Result := -114.1
    else
      Result := 0.0;
    EXIT;
  end else
  // Boiling Point
  begin
    if ('water' = ACompound.ToLower) then
      Result := 100.0
    else if ('benzene' = ACompound.ToLower) then
      Result := 80.1
    else if ('ethanol' = ACompound.ToLower) then
      Result := 78.3
    else
      Result := 0.0;
    EXIT;
  end;
end;

function TChemicalDatabank.GetMolecularStructure(ACompound: String): String;
begin
  Result := String.Empty;
  if ('water' = ACompound.ToLower) then
    Result := 'H2O'
  else if ('benzene' = ACompound.ToLower) then
    Result := 'C6H6'
  else if ('ethanol' = ACompound.ToLower) then
    Result := 'C2H5OH';
end;

function TChemicalDatabank.GetMolecularWeight(ACompound: String): Double;
begin
  if ('water' = ACompound.ToLower) then
    Result := 18.015
  else if ('benzene' = ACompound.ToLower) then
    Result := 78.1134
  else if ('ethanol' = ACompound.ToLower) then
    Result := 46.0688
  else
    Result := 0.0;
end;

end.
