{******************************************************************************}
{*              Delphi example using the Decorator pattern                    *}
{******************************************************************************}
program decorator;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinApi.Windows,
  LibraryItem in 'LibraryItem.pas',
  Borrowable in 'Borrowable.pas';

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
      var LBook := TLibraryBook.Create('Magni', 'Delphi GUI Programming with FireMonkey', 10);
      try
        LBook.Display();
      finally
        LBook.Free;
      end;

      // Create BluRay
      var LBluRay := TBluRay.Create('Spielberg', 'Jaws', 23, 92);
      try
        LBluRay.Display();

        // Make BluRay Borrowable
        var LBorrowableBluRay := TBorrowable.Create(LBluRay, FALSE);
        try
          LBorrowableBluRay.BorrowItem('Customer #1');
          LBorrowableBluRay.BorrowItem('Customer #2');
          LBorrowableBluRay.Display;
        finally
          LBorrowableBluRay.Free;
        end;
      finally
        LBluRay.Free;
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
