unit LibraryItem;

interface

uses
  System.SysUtils;

type
  TLibraryItem = class
  protected
    FNumCopies: NativeInt;
  public
    procedure Display(); virtual; abstract;
    property NumCopies: NativeInt read FNumCopies write FNumCopies;
  end;

  TLibraryBook = class(TLibraryItem)
  private
    FAuthor: String;
    FTitle: String;
  public
    constructor Create(AAuthor: String; ATitle: String; ANumCopies: NativeInt); virtual;
    procedure Display(); override;
    property Author: String read FAuthor write FAuthor;
    property Title: String read FTitle write FTitle;
  end;

  TBluRay = class(TLibraryItem)
  private
    FDirector: String;
    FTitle: String;
    FRunningTimeMinutes: Nativeint;
  public
    constructor Create(ADirector: String; ATitle: String; ANumCopies: NativeInt; ARunningTimeMinutes: Nativeint); virtual;
    procedure Display(); override;
    property Director: String read FDirector write FDirector;
    property Title: String read FTitle write FTitle;
    property RunningTimeMinutes: NativeInt read FRunningTimeMinutes write FRunningTimeMinutes;
  end;

  TNewspaper = class(TLibraryItem)
  private
    FTitle: String;
    FPublicationDate: TDateTime;
  public
    constructor Create(ATitle: String; ANumCopies: NativeInt; APublicationDate: TDateTime); virtual;
    procedure Display(); override;
    property Title: String read FTitle write FTitle;
    property APublicationDate: TDateTime read FPublicationDate write FPublicationDate;
  end;

implementation

constructor TLibraryBook.Create(AAuthor: String; ATitle: String; ANumCopies: NativeInt);
begin
  FAuthor := AAuthor;
  FTitle := ATitle;
  FNumCopies := ANumCopies;
end;

procedure TLibraryBook.Display();
begin
  WriteLn('');
  WriteLn('Book ------ ');
  WriteLn(' Author: ', FAuthor);
  WriteLn(' Title: ', title);
  WriteLn(' # Copies: ', FNumCopies);
end;

constructor TBluRay.Create(ADirector: String; ATitle: String; ANumCopies: NativeInt; ARunningTimeMinutes: Nativeint);
begin
  FDirector := ADirector;
  FTitle := ATitle;
  FNumCopies := ANumCopies;
  FRunningTimeMinutes := ARunningTimeMinutes;
end;

procedure TBluRay.Display();
begin
  WriteLn('');
  WriteLn('BluRay ---- ');
  WriteLn(' Director: ', FDirector);
  WriteLn(' Title: ', title);
  WriteLn(' # Copies: ', FNumCopies);
  WriteLn(' Runtime: ', FRunningTimeMinutes, ' min.');
end;

constructor TNewspaper.Create(ATitle: String; ANumCopies: NativeInt; APublicationDate: TDateTime);
begin
  FTitle := ATitle;
  FPublicationDate := APublicationDate;
  FNumCopies := ANumCopies;
end;

procedure TNewspaper.Display();
begin
  WriteLn('');
  WriteLn('Newspaper ------ ');
  WriteLn(' Title: ', FTitle);
  WriteLn(' Date: ', FormatDateTime('dddd dd-MMMM-yyyy', FPublicationDate));
  WriteLn(' # Copies: ', FNumCopies);
end;

end.
