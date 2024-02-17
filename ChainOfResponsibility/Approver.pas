unit Approver;

interface

uses
  System.SysUtils, System.Classes, Purchase;

type
  TApprover = class abstract
  protected
    FName: String;
    FSuccessor: TApprover;
  public
    constructor Create(AName: String);
    procedure SetSuccessor(ASuccessor: TApprover);
    procedure ProcessRequest(APurchase: TPurchase); virtual; abstract;
    property Name: String read FName write FName;
  end;

  TDirector = class(TApprover)
  public
    procedure ProcessRequest(APurchase: TPurchase); override;
  end;

  TVicePresident = class(TApprover)
  public
    procedure ProcessRequest(APurchase: TPurchase); override;
  end;

  TPresident = class(TApprover)
  public
    procedure ProcessRequest(APurchase: TPurchase); override;
  end;

implementation

constructor TApprover.Create(AName: String);
begin
  FName := AName;
end;

procedure TApprover.SetSuccessor(ASuccessor: TApprover);
begin
  FSuccessor := ASuccessor;
end;

procedure TDirector.ProcessRequest(APurchase: TPurchase);
begin
  if (APurchase.Amount < 10000.0) then
    WriteLn(FName, ' approved request# ', APurchase.Number)
  else if (nil <> FSuccessor) then
    FSuccessor.ProcessRequest(APurchase);
end;

procedure TVicePresident.ProcessRequest(APurchase: TPurchase);
begin
  if (APurchase.Amount < 25000.0) then
    WriteLn(FName, ' approved request# ', APurchase.Number)
  else if (nil <> FSuccessor) then
    FSuccessor.ProcessRequest(APurchase);
end;

procedure TPresident.ProcessRequest(APurchase: TPurchase);
begin
  if (APurchase.Amount < 100000.0) then
    WriteLn(FName, ' approved request# ', APurchase.Number)
  else
    WriteLn('Request# ', APurchase.Number, ' requires an executive meeting!');
end;

end.
