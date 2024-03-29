{******************************************************************************}
{*              Delphi example using the Composite pattern                    *}
{*                                                                            *}
{* The Composite design pattern composes objects into tree structures to      *}
{* represent part-whole hierarchies. This pattern lets clients treat          *}
{* individual objects and compositions of objects uniformly.                  *}
{******************************************************************************}

program Composite;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinApi.Windows,
  DrawingElements in 'DrawingElements.pas';

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
      var LRoot := TCompositeElement.Create('Picture');
      LRoot.Add(TPrimitiveElement.Create('Red Line'));
      LRoot.Add(TPrimitiveElement.Create('Blue Circle'));
      LRoot.Add(TPrimitiveElement.Create('Green Box'));
      // Create a branch
      var LComp := TCompositeElement.Create('Two Circles');
      LComp.Add(TPrimitiveElement.Create('Black Circle'));
      LComp.Add(TPrimitiveElement.Create('White Circle'));
      LRoot.Add(LComp);

      var pe := TPrimitiveElement.Create('Yellow Line');
      LRoot.Add(pe);
      LRoot.Remove(pe);

      LRoot.Display(1);
    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;
    WaitForSingleobject(FEvent, INFINITE);
  finally
    Closehandle(FEvent);
  end;
end.
