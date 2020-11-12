gap> F:=FreeGroup("x","y","z");;
gap> x:=F.1;;y:=F.2;;z:=F.3;;
gap> G:=F/[x*y*z, x^3*y^-1, z*x*y^-1];;
gap> ITest(G);
false

