#############################################################################
##
#W  itest.gd             Itest Package		Iván Sadofschi Costa
##
##  An implementation of Barmak and Minian's I-test
##
##  
##  
##


DeclareGlobalFunction("q");

DeclareGlobalFunction("IsGoodMatrixByDefinition");
DeclareGlobalFunction("Matrix012");
DeclareGlobalFunction("ReduceMatrix");
DeclareGlobalFunction("ReduceMatrixMoreInfo");

#############################################################################
##
#F  IsGoodMatrix( M )
##
##  <#GAPDoc Label="IsGoodMatrix">
##  <ManSection>
##  <Func Name="IsGoodMatrix" Arg="M"/>
##  
##  <Description>
##  Returns <K>true</K> if the matrix <A>M</A> is <E>good</E> in the sense of <Cite Key="BarmakMinian" Where="Definition 2.5"/>.
##  <Example>
##gap> IsGoodMatrix(M);
###columns:[ 2, 1, 3 ], rows: [ 2, 1, 4 ]
##true
##</Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction("IsGoodMatrix");




#############################################################################
##
#F  SubwordMatrix( G )
##
##  <#GAPDoc Label="SubwordMatrix">
##  <ManSection>
##  <Func Name="SubwordMatrix" Arg="G"/>
##  
##  <Description>
##  <A>G</A>  must be an FpGroup.
##  Returns the subword matrix of <A>G</A> .
##<Example>
##gap> F:=FreeGroup(["x","y","z","w"]);;
##gap> AssignGeneratorVariables(F);
###I  Assigned the global variables [ x, y, z, w ]
##gap> G:=F/[x^2*y^2*z^2, x*y*x^-1*z*y*z^-1, w^2*x^-1*w^-1*z];;
##gap> SubwordMatrix(G);
##[
##[[x^2*y^2*z^2,x*y^2*z^2],[x*y*x^-1*z*y*z^-1,z*y*z^-1 ],[w^-1*z]                         ],
##[[y^2*z^2,y*z^2],        [y*x^-1*z*y*z^-1,y*z^-1 ],    []                               ], 
##[[z^2,z],                [z*y*z^-1,&lt;identity ...&gt;],    [z]                              ], 
##[[],                     [],                           [w^2*x^-1*w^-1*z,w*x^-1*w^-1*z,z]]
##]
##</Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction("SubwordMatrix");


#############################################################################
##
#F  WeightMatrix( G,v )
##
##  <#GAPDoc Label="WeightMatrix">
##  <ManSection>
##  <Func Name="WeightMatrix" Arg="G,v"/>
##  
##  <Description>
##  <A>G</A>  must be an FpGroup, <A>v</A> a vector orthogonal to <A>q(r)</A> for each relator <A>r</A> of <A>G</A>.
##  Returns the weight matrix of <A>G</A> .
##<Example>
##gap> M:=WeightMatrix(G,[1,0,-1,2]);
##[ 
##[ [0,-1],  [0,0],  [-3]      ],
##[ [-2,-2], [-1,1], []        ],
##[ [-2,-1], [0,0],  [-1]      ],
##[ [],      [],     [0,-2,-1] ]
##]
##</Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction("WeightMatrix");

#############################################################################
##
#F  ITestVector( G , v )
##
##  <#GAPDoc Label="ITestVector">
##  <ManSection>
##  <Func Name="ITestVector" Arg="G,v"/>
##  
##  <Description>
##  <A>G</A> must be an FpGroup. The vector <A>v</A> must be orthogonal to the exponent matrix of the presentation defining <A>G</A>.
##  Returns <K>true</K> if <A>G</A> satisfies the I-test for <A>v</A>.
##<Example>
##gap> ITestVector(G,[1,0,-1,2]);
### columns:[ 2, 1, 3 ], rows: [ 2, 1, 4 ]
##true
##</Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction("ITestVector");

#############################################################################
##
#F  ITestSimplex( G )
##
##  <#GAPDoc Label="ITestSimplex">
##  <ManSection>
##  <Func Name="ITestSimplex" Arg="G"/>
##  
##  <Description>
##  <A>G</A> must be an FpGroup.
## Returns a vector <A>v</A> such that <A>G</A> satisfies the I-test for <A>v</A> or <K>False</K> if there is no such vector. 
## It works by solving lots of linear programs using the package <Package>Polymaking</Package>.
##<Example>
##gap> F:=FreeGroup(["x","y","z"]);;
##gap> AssignGeneratorVariables(F);;
##gap> G:=F/[x*z*x^-1*y*z*y^-1*z^-1*y^-1, x*y^-1*x^-1*y^-1*x*y];;
##gap> ITestSimplex(G);
##false
##</Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction("ITestSimplex");

#############################################################################
##
#F  ITest( G[,n])
##  <#GAPDoc Label="ITest">
##  <ManSection>
##  <Func Name="ITest" Arg="G[,n]"/>
##  
##  <Description>
##  <A>G</A> must be an FpGroup.
## Returns a vector <A>v</A> such that <A>G</A> satisfies the I-test for <A>v</A> or <K>False</K> if there is no such vector.
## First tries a number of random vectors and if none of these vectors works it uses <C>ITestSimplex</C>.
## The number of vectors tried can be specified by the optional parameter <A>n</A> and by default is set to <M>10000</M>.
##<Example>
##gap> F:=FreeGroup(8);;
##gap> AssignGeneratorVariables(F);;
###I  Assigned the global variables [ f1, f2, f3, f4, f5, f6, f7, f8 ]
##gap> R:=[
##> f6^-1*f4^-1*f7^-1*f1*f7*f5^-1*f3^-1,
##> f3^-1*f1^-1*f5*f6*f8^-1*f6*f3^-1*f2, 
##> f1*f7^-1*f3^-1*f8^-1*f7*f2^2*f8^-1*f7^-1*f6^-1, 
##> f7^-1*f3*f8^-1*f1*f2*f3*f8^2*f2,
##> f4^-1*f1*f2^-1*f5^-1*f2
##> ];;
##gap> G:=F/R;;
##gap> ITest(G);
### columns:[ 1, 4, 3, 5, 2 ], rows: [ 1, 2, 3, 4, 6 ]
##[ 237, 694, 243, -116, 353, -243, 1949, -162 ]
##gap> F:=FreeGroup(["x","y","z"]);;
##gap> AssignGeneratorVariables(F);;
##gap> G:=F/[x*z*x^-1*y*z*y^-1*z^-1*y^-1, x*y^-1*x^-1*y^-1*x*y];;
##gap> ITest(G);
### Tried 10000 random vectors without success.
### Now I am trying with every possible vector...
##false
##</Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction("ITest");

