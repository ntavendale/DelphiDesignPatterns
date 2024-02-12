unit LoadBalancer;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.SyncObjs;

type
  TLoadBalancer = class
  private
    class var FInstance: TLoadBalancer;
    FServers: TList<string>;
    function GetServer: String;
  protected
    constructor Create;
  public
    destructor Destroy; override;
    class function GetLoadBalancer: TLoadBalancer;
    property Server: String read GetServer;
  end;

implementation

var
  FCriticalSection: TCriticalSection;

constructor TLoadBalancer.Create;
begin
  FServers := TList<string>.Create;
  // List of available servers
  FServers.Add('ServerI');
  FServers.Add('ServerII');
  FServers.Add('ServerIII');
  FServers.Add('ServerIV');
  FServers.Add('ServerV');
  Randomize; // initialize random number generator
end;

destructor TLoadBalancer.Destroy;
begin
  FServers.Free;
  inherited Destroy;
end;

function TLoadBalancer.GetServer: String;
begin
  Result := FServers[Random(5)];
end;

// Only ever one instance of class so use class function to create and return it.
// If allready exists, then just return it
class function TLoadBalancer.GetLoadBalancer: TLoadBalancer;
begin
  if nil = FInstance then
  begin
    FCriticalSection.Enter;
    try
      if nil = FInstance then
        FInstance := TLoadBalancer.Create;
    finally
      FCriticalSection.Leave;
    end;
  end;
  Result := FInstance;
end;

initialization
  FCriticalSection := TCriticalSection.Create;
finalization
  FCriticalSection.Free;

end.
