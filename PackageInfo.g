#############################################################################
##  
##  PackageInfo.g for the package `Itest'             Iván Sadofschi Costa
##  
##  An implementation of Barmak and Minian's I-test
##
##

SetPackageInfo( rec(

PackageName := "Itest",

Subtitle := "An implementation of Barmak and Minian's I-test.",


Version := "1.0.2",
Date := "10/04/2019",

PackageWWWHome :=
  Concatenation( "https://github.com/isadofschi/", LowercaseString( ~.PackageName ) ),

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/isadofschi/", LowercaseString( ~.PackageName ) ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
SupportEmail := "isadofschi@dm.uba.ar",

ArchiveURL := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),


ArchiveFormats := ".tar.gz",


Persons := [
  rec( 
    LastName      := "Sadofschi Costa",
    FirstNames    := "Iván",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "isadofschi@dm.uba.ar",
    WWWHome       := "http://mate.dm.uba.ar/~isadofschi",
    PostalAddress := Concatenation( [
                       "Pabellón I - Ciudad Universitaria (1428)\n",
                       "Buenos Aires\n",
                       "Argentina" ] ),
    Place         := "Buenos Aires",
    Institution   := "University of Buenos Aires"
  ),
 
],

Status := "dev",

README_URL := 
  Concatenation( ~.PackageWWWHome, "/README.md" ),

PackageInfoURL := 
  Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),

AbstractHTML := 
  "An implementation of Barmak and Minian's I-test.",


PackageDoc := rec(
  BookName  := "Itest",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Itest/An implementation of Barmak and Minian's I-test.",
),


Dependencies := rec(
  GAP := "4.9.2",

  NeededOtherPackages := [["polymaking", "0.8.1"], ["semigroups", "2.8.0"]],


  SuggestedOtherPackages := [],


  ExternalConditions := []),


AvailabilityTest := ReturnTrue,

BannerString := Concatenation( 
    "─────────────────────────────────────────────────────────────────────────────\n",
    "Loading  Itest - ", ~.Version, "\n",
    "An implementation of Barmak and Minian's I-test \n",
    "by ",
    JoinStringsWithSeparator( List( Filtered( ~.Persons, r -> r.IsAuthor ),
                                    r -> Concatenation(
        r.FirstNames, " ", r.LastName, " (", r.WWWHome, ")\n" ) ), "   " ),
    "For help, type: ?Itest \n",
    "─────────────────────────────────────────────────────────────────────────────\n" ),

TestFile := "tst/testall.g",

Autoload := false,

Keywords := ["package I-test", "asphericity", "diagrammatic reducibility", "DR"]

));

