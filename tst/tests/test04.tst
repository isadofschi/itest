gap> F:=FreeGroup(8);;
gap> f1:=F.1;;f2:=F.2;;f3:=F.3;;f4:=F.4;;f5:=F.5;;f6:=F.6;;f7:=F.7;;f8:=F.8;;
gap> R:=[
> f6^-1*f4^-1*f7^-1*f1*f7*f5^-1*f3^-1,
> f3^-1*f1^-1*f5*f6*f8^-1*f6*f3^-1*f2, 
> f1*f7^-1*f3^-1*f8^-1*f7*f2^2*f8^-1*f7^-1*f6^-1, 
> f7^-1*f3*f8^-1*f1*f2*f3*f8^2*f2,
> f4^-1*f1*f2^-1*f5^-1*f2
> ];;
gap> G:=F/R;;
gap> ITest(G);
# columns:[ 1, 4, 3, 5, 2 ], rows: [ 1, 2, 3, 4, 6 ]
[ 237, 694, 243, -116, 353, -243, 1949, -162 ]
gap> F:=FreeGroup(["x","y","z"]);;
gap> x:=F.1;;y:=F.2;;z:=F.3;;
gap> G:=F/[x*z*x^-1*y*z*y^-1*z^-1*y^-1, x*y^-1*x^-1*y^-1*x*y];;
gap> ITest(G);
# Tried 10000 random vectors without success.
# Now I am trying with every possible vector...
false

