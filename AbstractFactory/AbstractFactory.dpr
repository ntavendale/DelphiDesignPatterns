{******************************************************************************}
{*           Delphi example using the Abstract Factory pattern                *}
{******************************************************************************}
program AbstractFactory;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinApi.Windows,
  Animals in 'Animals.pas',
  Continents in 'Continents.pas',
  AnimalEcosystem in 'AnimalEcosystem.pas';

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
  FEvent := CreateEvent(nil, TRUe, FALSE, nil);
  try
    try
      { TODO -oUser -cConsole Main : Insert code here }
      var LContinent: TContinent;
      LContinent := TAfrica.Create;
      try
        var LAnimalEcosystem := TAnimalEcosystem.Create(LContinent);
        try
          LAnimalEcosystem.DoFoodChain;
        finally
          LAnimalEcosystem.Free;
        end;
      finally
        LContinent.Free;
      end;

      LContinent := TNorthAmerica.Create;
      try
        var LAnimalEcosystem := TAnimalEcosystem.Create(LContinent);
        try
          LAnimalEcosystem.DoFoodChain;
        finally
          LAnimalEcosystem.Free;
        end;
      finally
        LContinent.Free;
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
