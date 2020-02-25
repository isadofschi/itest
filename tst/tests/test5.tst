gap> F:=FreeGroup(["x","y","z"]);;
gap> x:=F.1;;y:=F.2;;z:=F.3;;
gap> G:=F/[x*z*x^-1*y*z*y^-1*z^-1*y^-1, x*y^-1*x^-1*y^-1*x*y];;
gap> ITestPoly(G);
false

