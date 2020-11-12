gap> F:=FreeGroup(["x","y","z","w"]);;
gap> x:=F.1;;y:=F.2;;z:=F.3;;w:=F.4;;
gap> G:=F/[x^2*y^2*z^2, x*y*x^-1*z*y*z^-1, w^2*x^-1*w^-1*z];;
gap> ITestVector(G,[1,0,-1,3]);
# v must be orthogonal to q(r) for each relator r.
false

