# Test 1
gap> F:=FreeGroup(["x","y","z","w"]);;
gap> x:=F.1;;y:=F.2;;z:=F.3;;w:=F.4;;
gap> G:=F/[x^2*y^2*z^2, x*y*x^-1*z*y*z^-1, w^2*x^-1*w^-1*z];;
gap> SubwordMatrix(G);
[
[[x^2*y^2*z^2,x*y^2*z^2],[x*y*x^-1*z*y*z^-1,z*y*z^-1 ],[w^-1*z]                         ],
[[y^2*z^2,y*z^2],        [y*x^-1*z*y*z^-1,y*z^-1 ],    []                               ], 
[[z^2,z],                [z*y*z^-1,<identity ...>],    [z]                              ], 
[[],                     [],                           [w^2*x^-1*w^-1*z,w*x^-1*w^-1*z,z]]
]
gap> M:=WeightMatrix(G,[1,0,-1,2]);
[ 
[ [0,-1],  [0,0],  [-3]      ],
[ [-2,-2], [-1,1], []        ],
[ [-2,-1], [0,0],  [-1]      ],
[ [],      [],     [0,-2,-1] ]
]
gap> IsGoodMatrix(M);
#columns:[ 2, 1, 3 ], rows: [ 2, 1, 4 ]
true
gap> IsGoodMatrixByDefinition(M);
# columns:[ 2, 1, 3 ], rows: [ 2, 1, 4 ]
true
gap> ReduceMatrixMoreInfo(Matrix012(M))[1]=ReduceMatrix(Matrix012(M));
true
gap> ITestVector(G,[1,0,-1,2]);
# columns:[ 2, 1, 3 ], rows: [ 2, 1, 4 ]
true
gap> v:=ITest(G,0);
# Tried 0 random vectors without success.
# Now I am trying with every possible vector...
[ 1/2, 0, -1/2, 1 ]
gap> ITestVector(G,v);
# columns:[ 2, 1, 3 ], rows: [ 2, 1, 4 ]
true

