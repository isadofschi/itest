# This file builds the documentation using GAPDoc
# The files needed to produce the documentation are
# main.xml
# itest.xml
# install.xml
# itest.bib
# manual.css
# makedoc.g
# itest.bib

path := Directory("./");;
main := "main.xml";;
files := [
		"../lib/itest.gd", "../lib/itest.gi"
];;
bookname := "G2Comp";;
doc := ComposedDocument("GAPDoc", path, main, files, true);;

MakeGAPDocDoc( path, main, files, bookname);
