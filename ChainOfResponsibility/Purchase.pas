unit Purchase;

interface

uses
  System.SysUtils, System.Classes;

type
  TPurchase = class
  private
    FNumber: Integer;
    FAmount: Double;
    FPurpose: String;
  public
    constructor Create(ANumber: Integer; AAmount: Double; APurpose: String);
    property Number: Integer read FNumber write FNumber;
    property Amount: Double read FAmount write FAmount;
    property Purpose: String read FPurpose write FPurpose;
  end;

implementation

constructor TPurchase.Create(ANumber: Integer; AAmount: Double; APurpose: String);
begin
  FNumber := ANumber;
  FAmount := AAmount;
  FPurpose := APurpose;
end;

end.
