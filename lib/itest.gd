#############################################################################
##
#W  itest.gd             Itest Package		Iván Sadofschi Costa
##
##  An implementation of Barmak and Minian's I-test
##
##  
##  
##

#! @Chapter I-test package


#! @Section The I-test
#! The I-test is an asphericity test that is not based on a non-positive curvature argument.
#! If a finite group presentation passes the I-test, then the associated 2-complex is diagrammatically reducible (DR), in particular it is aspherical.
#! This test was introduced by Barmak and Minian <Cite Key="BarmakMinian" Where="Theorem 2.6"/>.
#! The main function of the package is <Ref Func="ITest"/>.


#! @Section Required packages
#! The <Package>Itest</Package> package requires &GAP; (version&gt;=4.9.2) and the packages <Package>polymaking</Package> (version&gt;=0.8.1) and <Package>semigroups</Package> (version&gt;=2.8.0). Note that the package polymaking requires the external software Polymake.



#! @Section Applying the I-test

DeclareGlobalFunction("q");


DeclareGlobalFunction("IsGoodMatrixByDefinition");


DeclareGlobalFunction("Matrix012");


DeclareGlobalFunction("ReduceMatrix");


DeclareGlobalFunction("ReduceMatrixMoreInfo");

#! @Arguments M
#! @Description Returns <K>true</K> if the matrix <A>M</A> is <E>good</E> in the sense of <Cite Key="BarmakMinian" Where="Definition 2.5"/>.
#! @BeginExampleSession
#! gap> IsGoodMatrix(M);
#! # columns:[ 2, 1, 3 ], rows: [ 2, 1, 4 ]
#! true
#! @EndExampleSession
DeclareGlobalFunction("IsGoodMatrix");


#! @Arguments G
#! @Description Returns the subword matrix of the FpGroup <A>G</A>.
#! @BeginExampleSession
#! gap> F:=FreeGroup(["x","y","z","w"]);;
#! gap> AssignGeneratorVariables(F);
#! #I  Assigned the global variables [ x, y, z, w ]
#! gap> G:=F/[x^2*y^2*z^2, x*y*x^-1*z*y*z^-1, w^2*x^-1*w^-1*z];;
#! gap> SubwordMatrix(G);
#! [
#! [[x^2*y^2*z^2,x*y^2*z^2],[x*y*x^-1*z*y*z^-1,z*y*z^-1 ],[w^-1*z]                         ],
#! [[y^2*z^2,y*z^2],        [y*x^-1*z*y*z^-1,y*z^-1 ],    []                               ], 
#! [[z^2,z],                [z*y*z^-1,<identity ...>],    [z]                        ], 
#! [[],                     [],                           [w^2*x^-1*w^-1*z,w*x^-1*w^-1*z,z]]
#! ]
#! @EndExampleSession
DeclareGlobalFunction("SubwordMatrix");


#! @Arguments G,v
#! @Description <A>G</A>  must be an FpGroup, <A>v</A> a vector orthogonal to $q(r)$ for each relator $r$ of <A>G</A>. Returns the weight matrix of <A>G</A> .
#! @BeginExampleSession
#! gap> M:=WeightMatrix(G,[1,0,-1,2]);
#! [ 
#! [ [0,-1],  [0,0],  [-3]      ],
#! [ [-2,-2], [-1,1], []        ],
#! [ [-2,-1], [0,0],  [-1]      ],
#! [ [],      [],     [0,-2,-1] ]
#! ]
#! @EndExampleSession
DeclareGlobalFunction("WeightMatrix");


#! @Arguments G,v
#! @Description <A>G</A> must be an FpGroup. The vector <A>v</A> must be orthogonal to the exponent matrix of the presentation defining <A>G</A>. Returns <K>true</K> if <A>G</A> satisfies the I-test for <A>v</A>.
#! @BeginExampleSession
#! gap> ITestVector(G,[1,0,-1,2]);
#! # columns:[ 2, 1, 3 ], rows: [ 2, 1, 4 ]
#! true
#! @EndExampleSession
DeclareGlobalFunction("ITestVector");


#! @Arguments G
#! @Description <A>G</A> must be an FpGroup. Returns a vector <A>v</A> such that <A>G</A> satisfies the I-test for <A>v</A> or <K>False</K> if there is no such vector. It works by computing lots of polytopes using the package <Package>Polymaking</Package>.
#! @BeginExampleSession
##gap> F:=FreeGroup(["x","y","z"]);;
##gap> AssignGeneratorVariables(F);;
##gap> G:=F/[x*z*x^-1*y*z*y^-1*z^-1*y^-1, x*y^-1*x^-1*y^-1*x*y];;
##gap> ITestPoly(G);
##false
#! @EndExampleSession
DeclareGlobalFunction("ITestPoly");


#! @Arguments G[,n]
#! @Description Returns a vector <A>v</A> such that the FpGroup <A>G</A> satisfies the I-test for <A>v</A> or <K>False</K> if there is no such vector.
#! First tries a number of random vectors and if none of these vectors works <C>ITestPoly</C> is called.
#! The number of vectors tried can be specified by the optional parameter <A>n</A> and by default is set to <M>10000</M>.
#! @BeginExampleSession
#! gap> F:=FreeGroup(8);;
#! gap> AssignGeneratorVariables(F);;
#! #I  Assigned the global variables [ f1, f2, f3, f4, f5, f6, f7, f8 ]
#! gap> R:=[
#! > f6^-1*f4^-1*f7^-1*f1*f7*f5^-1*f3^-1,
#! > f3^-1*f1^-1*f5*f6*f8^-1*f6*f3^-1*f2, 
#! > f1*f7^-1*f3^-1*f8^-1*f7*f2^2*f8^-1*f7^-1*f6^-1, 
#! > f7^-1*f3*f8^-1*f1*f2*f3*f8^2*f2,
#! > f4^-1*f1*f2^-1*f5^-1*f2
#! > ];;
#! gap> G:=F/R;;
#! gap> ITest(G);
#! # columns:[ 1, 4, 3, 5, 2 ], rows: [ 1, 2, 3, 4, 6 ]
#! [ 237, 694, 243, -116, 353, -243, 1949, -162 ]
#! gap> F:=FreeGroup(["x","y","z"]);;
#! gap> AssignGeneratorVariables(F);;
#! gap> G:=F/[x*z*x^-1*y*z*y^-1*z^-1*y^-1, x*y^-1*x^-1*y^-1*x*y];;
#! gap> ITest(G);
#! # Tried 10000 random vectors without success.
#! # Now I am trying with every possible vector...
#! false
#! @EndExampleSession
DeclareGlobalFunction("ITest");

