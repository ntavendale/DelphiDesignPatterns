unit Compound;

interface

uses
  System.SysUtils, System.Classes, ChemicalDatabank;

type
  TCompound = class
  protected
    FBoilingPoint: Single;
    FMeltingPoint: Single;
    FMolecularWeight: Double;
    FMolecularFormula: String;
  public
    procedure Display; virtual;
  end;

  TRichCompound = class(TCompound)
  private
    FChemical: String;
  public
    constructor Create(AChemical: String);
    procedure Display; override;
  end;

implementation

procedure TCompound.Display;
begin
  WriteLn(sLineBreak, 'Compound: Unknown ------ ');
end;


constructor TRichCompound.Create(AChemical: String);
begin
  FChemical := AChemical;
end;

procedure TRichCompound.Display;
begin
  var LDatabank := TChemicalDatabank.Create;
  try
    FBoilingPoint := LDatabank.GetCriticalPoint(FChemical, 'B');
    FMeltingPoint := LDatabank.GetCriticalPoint(FChemical, 'M');
    FMolecularWeight := LDatabank.GetMolecularWeight(FChemical);
    FMolecularFormula := LDatabank.GetMolecularStructure(FChemical);
    WriteLn(sLineBreak, 'Compound: ', FChemical, ' ------ ');
    WriteLn(' Formula: ', FMolecularFormula);
    WriteLn(' Weight : ', FMolecularWeight);
    WriteLn(' Melting Pt: ', FMeltingPoint);
    WriteLn(' Boiling Pt: ', FBoilingPoint);
  finally
    LDatabank.Free;
  end;
end;

end.
