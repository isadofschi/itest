LoadPackage( "AutoDoc" );
LoadPackage("itest");
AutoDoc( rec( scaffold := true,
              autodoc  := rec( files := [ "doc/chapters.autodoc" ])
));
QUIT;

