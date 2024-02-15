unit Mortgage;

interface

uses
  System.SysUtils, System.Classes, Subsystems;

type
  TMortgage = class
  private
    FBank: TBank;
    FCredit: TCredit;
    FLoan: TLoan;
  public
    constructor Create;
    destructor Destroy; override;
    function IsEligible(ACustomer: TCustomer; AAmount: Integer): Boolean;
  end;

implementation

constructor TMortgage.Create;
begin
  FBank := TBank.Create;
  FCredit := TCredit.Create;
  FLoan := TLoan.Create;
end;

destructor TMortgage.Destroy;
begin
  FLoan.Free;
  FCredit.Free;
  FBank.Free;
  inherited Destroy;
end;

function TMortgage.IsEligible(ACustomer: TCustomer; AAmount: Integer): Boolean;
begin
  WriteLn(String.Format('%s applies for %m loan', [ACustomer.Name, Double(AAmount)]));

  Result := FBank.HasSufficientSavings(ACustomer, AAmount) and
            FCredit.HasGoodCredit(ACustomer) and
            FLoan.HasNoBadLoans(ACustomer);
end;

end.
