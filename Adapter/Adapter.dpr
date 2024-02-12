{******************************************************************************}
{*                Delphi example using the Adapter pattern                    *}
{*                                                                            *}
{* The Adapter design pattern converts the interface of a class into another  *}
{* interface clients expect. This design pattern lets classes work together   *}
{* that couldn‘t otherwise because of incompatible interfaces.                *}
{******************************************************************************}
program Adapter;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinApi.Windows,
  Compound in 'Compound.pas',
  ChemicalDatabank in 'ChemicalDatabank.pas';

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
      var LUnknown := TCompound.Create;
      try
        LUnknown.Display;
      finally
        LUnknown.Free;
      end;

      var LWater := TRichCompound.Create('Water');
      try
        LWater.Display;
      finally
        LWater.Free;
      end;

      var LBenzene := TRichCompound.Create('Benzene');
      try
        LBenzene.Display;
      finally
        LBenzene.Free;
      end;

      var LEthanol := TRichCompound.Create('Ethanol');
      try
        LEthanol.Display;
      finally
        LEthanol.Free;
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
