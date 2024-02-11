unit LoanableItem;

interface

uses
  System.SysUtils, System.Generics.Collections, LibraryItem;

type
  TDecorator = class(TLibraryItem)
  protected
    FItem: TLibraryItem;
  public
    constructor Create(ALibraryItem: TLibraryItem); reintroduce;
    procedure Display(); override;
  end;

  TLoanableItem = class(TDecorator)
  protected
    FBorrowers: TList<string>;
  public
    constructor Create(ALibraryItem: TLibraryItem); reintroduce;
    destructor Destroy; override;
  end;

implementation

constructor TDecorator.Create(ALibraryItem: TLibraryItem);
begin
  FItem := ALibraryItem;
end;

procedure TDecorator.Display();
begin
  FItem.Display;
end;

constructor TLoanableItem.Create(ALibraryItem: TLibraryItem);
begin
  inherited Create(ALibraryItem);
  FBorrowers := TList<String>.Create;
end;

destructor TLoanableItem.Destroy;
begin
  FBorrowers.Free;
  inherited Destroy;
end;

end.
