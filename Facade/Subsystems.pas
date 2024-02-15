unit Subsystems;

interface

uses
  System.SysUtils, System.Classes;

type
  TCustomer = record
    Name: String;
    constructor Create(AName: String);
  end;

  TBank = class
  public
    function HasSufficientSavings(ACustomer: TCustomer; AAmount: Integer): Boolean;
  end;

  TCredit = class
  public
    function HasGoodCredit(ACustomer: TCustomer): Boolean;
  end;

  TLoan = class
  public
    function HasNoBadLoans(ACustomer: TCustomer): Boolean;
  end;

implementation

constructor TCustomer.Create(AName: string);
begin
  Name := AName;
end;

function TBank.HasSufficientSavings(ACustomer: TCustomer; AAmount: Integer): Boolean;
begin
  WriteLn('Check bank for ', ACustomer.Name);
  Result := TRUE;
end;

function TCredit.HasGoodCredit(ACustomer: TCustomer): Boolean;
begin
  WriteLn('Check credit for ', ACustomer.Name);
  Result := TRUE;
end;

function TLoan.HasNoBadLoans(ACustomer: TCustomer): Boolean;
begin
  WriteLn('Check loans for ', ACustomer.Name);
  Result := TRUE;
end;

end.
