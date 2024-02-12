{******************************************************************************}
{*               Delphi example using the Prototype pattern                   *}
{******************************************************************************}
program Prototype;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinApi.Windows,
  Colors in 'Colors.pas',
  ColorManager in 'ColorManager.pas';

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
      var LColorManager := TColorManager.Create;
      try
        LColorManager['red'] := TProductionColor.Create(255, 0, 0);
        LColorManager['green'] := TProductionColor.Create(0, 255, 0);
        LColorManager['blue'] := TProductionColor.Create(0, 0, 255);

        LColorManager['angry'] := TProductionColor.Create(255, 54, 0);
        LColorManager['peace'] := TProductionColor.Create(128, 211, 128);
        LColorManager['flame'] := TProductionColor.Create(211, 34, 20);

        var LColor := LColorManager['red'].Clone as TProductionColor;
        LColor.Free;
        LColor := LColorManager['peace'].Clone as TProductionColor;
        LColor.Free;
        LColor := LColorManager['flame'].Clone as TProductionColor;
        LColor.Free;
      finally
        LColorManager.Free;
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
