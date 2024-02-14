unit DrawingElements;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  TDrawingElement = class abstract
  protected
    FName: String;
  public
    constructor Create(AName: String); virtual;
    procedure Add(ADrawingElement: TDrawingElement); virtual; abstract;
    procedure Remove(ADrawingElement: TDrawingElement); virtual; abstract;
    procedure Display(AIndent: Integer); virtual; abstract;
  end;

  TPrimitiveElement = class(TDrawingElement)
  public
    procedure Add(ADrawingElement: TDrawingElement); override;
    procedure Remove(ADrawingElement: TDrawingElement); override;
    procedure Display(AIndent: Integer); override;
  end;

  TCompositeElement = class(TDrawingElement)
  private
    FElements: TObjectList<TDrawingElement>;
  public
    constructor Create(AName: String); override;
    destructor Destroy; override;
    procedure Add(ADrawingElement: TDrawingElement); override;
    procedure Remove(ADrawingElement: TDrawingElement); override;
    procedure Display(AIndent: Integer); override;
  end;

implementation

constructor TDrawingElement.Create(AName: string);
begin
  FName := AName;
end;

procedure TPrimitiveElement.Add(ADrawingElement: TDrawingElement);
begin
  WriteLn('Cannot add to a PrimitiveElement!');
end;

procedure TPrimitiveElement.Remove(ADrawingElement: TDrawingElement);
begin
  WriteLn('Cannot remove from a PrimitiveElement!');
end;

procedure TPrimitiveElement.Display(AIndent: Integer);
begin
  var LName: String := ' ' + FName;
  LName := LName.PadLeft(AIndent + LName.Length, '-');
  Writeln(LName);
end;

constructor TCompositeElement.Create(AName: String);
begin
  inherited Create(AName);
  FElements := TObjectList<TDrawingElement>.Create(TRUE);
end;

destructor TCompositeElement.Destroy;
begin
  FElements.Free;
  inherited Destroy;
end;

procedure TCompositeElement.Add(ADrawingElement: TDrawingElement);
begin
  FElements.Add(ADrawingElement);
end;

procedure TCompositeElement.Remove(ADrawingElement: TDrawingElement);
begin
  FElements.Remove(ADrawingElement);
end;

procedure TCompositeElement.Display(AIndent: Integer);
begin
  var LName: String := ('+ ' + FName).PadLeft(AIndent, '-');
  Writeln(LName);
  for var LElement in FElements do
    LElement.Display(AIndent+2);
end;

end.
