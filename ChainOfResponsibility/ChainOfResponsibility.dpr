program ChainOfResponsibility;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinApi.Windows,
  Purchase in 'Purchase.pas',
  Approver in 'Approver.pas';

type
  PConsoleFontInfoEx = ^TConsoleFontInfoEx;
  TConsoleFontInfoEx = record
    cbSize: ULONG;
    nFont: DWORD;
    dwFontSize: TCoord;
    FontFamily: UINT;
    FontWeight: UINT;
    FaceName: array [0..(LF_FACESIZE-1)] of Char;
  end;

function SetCurrentConsoleFontEx(ConsoleOutput: THandle; MaximumWindow: BOOL;
  ConsoleInfo: PConsoleFontInfoEx): BOOL; stdcall;
  external kernel32 name 'SetCurrentConsoleFontEx';
function GetCurrentConsoleFontEx(ConsoleOutput: THandle; MaximumWindow: BOOL;
  ConsoleInfo: PConsoleFontInfoEx): BOOL; stdcall;
  external kernel32 name 'GetCurrentConsoleFontEx';

var
  FEvent: THandle;

procedure SetUpConsole(AFontSize: DWORD);
begin
  // Must be vista or higer
  if NOT CheckWin32Version(6) then
    EXIT;

  var ci: TConsoleFontInfoEx;
  FillChar(ci, SizeOf(TConsoleFontInfoEx), 0);
  ci.cbSize := SizeOf(TConsoleFontInfoEx);

  var ch: THandle := GetStdHandle(STD_OUTPUT_HANDLE);
  GetCurrentConsoleFontEx(ch, FALSE, @ci); // AV Here!

  ci.FontFamily := FF_DONTCARE;
  ci.FaceName := 'Consolas';
  ci.dwFontSize.X := 0;
  ci.dwFontSize.Y := AFontSize;
  ci.FontWeight := FW_BOLD;
  SetCurrentConsoleFontEx(ch, FALSE, @ci);
end;

function ConsoleEventProc(CtrlType: DWORD): BOOL; stdcall;
begin
  if (CTRL_CLOSE_EVENT = CtrlType) or (CTRL_C_EVENT = CtrlType) then
  begin
    SetEvent(FEvent);
  end;
  Result := True;
end;

begin
  SetUpConsole(20);
  SetConsoleCtrlHandler(@ConsoleEventProc, True);
  FEvent := CreateEvent(nil, TRUE, FALSE, nil);
  try
    try
      { TODO -oUser -cConsole Main : Insert code here }
      var LLarry := TDirector.Create('Larry');
      var LSam := TVicePresident.Create('Sam');
      var LTammy := TPresident.Create('Tammy');
      try
        LLarry.SetSuccessor(LSam);
        LSam.SetSuccessor(LTammy);
        var LPurchase := TPurchase.Create(2034, 350.00, 'Supplies');
        try
          LLarry.ProcessRequest(LPurchase);
        finally
          LPurchase.Free;
        end;

        LPurchase := TPurchase.Create(2035, 32590.10, 'Project X');
        try
          LLarry.ProcessRequest(LPurchase);
        finally
          LPurchase.Free;
        end;

        LPurchase := TPurchase.Create(2036, 122100.00, 'Project Y');
        try
          LLarry.ProcessRequest(LPurchase);
        finally
          LPurchase.Free;
        end;
      finally
        LTammy.Free;
        LSam.Free;
        LLarry.Free;
      end;

    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;
    WaitForSingleObject(FEvent, INFINITE);
  finally
    CloseHandle(FEvent);
  end;
end.
