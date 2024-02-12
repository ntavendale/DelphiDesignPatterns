unit Documents;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Pages;

type
  // Abstract TDocument class defines the contract for creating pages
  TDocument = class abstract
  private
    FPages: TObjectList<TPage>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CreatePages; virtual; abstract;
    property Pages: TObjectList<TPage> read FPages;
  end;

  // The descendent classes, TResume & TReport, are the ones that actually
  // decide which types of pages to create.
  TResume = class(TDocument)
  public
    procedure CreatePages; override;
  end;

  TReport = class(TDocument)
  public
    procedure CreatePages; override;
  end;

implementation

constructor TDocument.Create;
begin
  FPages := TObjectList<TPage>.Create(TRUE);
  CreatePages;
end;

destructor TDocument.Destroy;
begin
  FPages.Free;
  inherited Destroy;
end;

procedure TResume.CreatePages;
begin
  FPages.Add(TSkillsPage.Create);
  FPages.Add(TEducationPage.Create);
  FPages.Add(TExperiencePage.Create);
end;

procedure TReport.CreatePages;
begin
  FPages.Add(TIntroductionPage.Create);
  FPages.Add(TResultsPage.Create);
  FPages.Add(TConclusionPage.Create);
  FPages.Add(TSummaryPage.Create);
  FPages.Add(TBibliographyPage.Create);
end;

end.
