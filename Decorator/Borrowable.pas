unit Borrowable;

interface

uses
  System.SysUtils, System.Generics.Collections, LibraryItem;

type
  TDecorator = class(TLibraryItem)
  protected
    FItem: TLibraryItem;
    FOwnsItem: Boolean;
  public
    constructor Create(ALibraryItem: TLibraryItem; AOwnsItem: Boolean); reintroduce;
    destructor Destroy; override;
    procedure Display(); override;
  end;

  TBorrowable = class(TDecorator)
  protected
    FBorrowers: TList<string>;
  public
    constructor Create(ALibraryItem: TLibraryItem; AOwnsItem: Boolean); reintroduce;
    destructor Destroy; override;
    procedure BorrowItem(ABorrower: String);
    procedure ReturnItem(ABorrower: String);
    procedure Display(); override;
  end;

implementation

constructor TDecorator.Create(ALibraryItem: TLibraryItem; AOwnsItem: Boolean);
begin
  FItem := ALibraryItem;
  FOwnsItem := AOwnsItem;
end;

destructor TDecorator.Destroy;
begin
  if FOwnsItem then
    FItem.Free;
  inherited Destroy;
end;

procedure TDecorator.Display();
begin
  FItem.Display;
end;

constructor TBorrowable.Create(ALibraryItem: TLibraryItem; AOwnsItem: Boolean);
begin
  inherited Create(ALibraryItem, AOwnsItem);
  FBorrowers := TList<String>.Create;
end;

destructor TBorrowable.Destroy;
begin
  FBorrowers.Free;
  inherited Destroy;
end;

procedure TBorrowable.BorrowItem(ABorrower: String);
begin
  FBorrowers.Add(ABorrower);
  FItem.NumCopies := FItem.NumCopies - 1;
end;

procedure TBorrowable.ReturnItem(ABorrower: String);
begin
  FBorrowers.Remove(ABorrower);
  FItem.NumCopies := FItem.NumCopies + 1;
end;

procedure TBorrowable.Display();
begin
  inherited Display;
  for var LBorrower in FBorrowers do
    WriteLn(' Borrower: ', LBorrower);
end;

end.
