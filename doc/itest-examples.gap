LoadPackage("itest");

# Examples

is_good_matrix([ 
[ [0,-1],  [0,0],  [-3]      ],
[ [-2,-2], [-1,1], []        ],
[ [-2,-1], [0,0],  [-1]      ],
[ [],      [],     [0,-2,-1] ]
]);

F:=FreeGroup(2);;x:=F.1;;y:=F.2;;
G:=F/[x^3*y*x*y];;
ITestVector(G,[1,-2]);

I_test_simplex(G); # returns v=[1/2, -1]

F:=FreeGroup(["x","y","z","w"]);; x:=F.1;;y:=F.2;;z:=F.3;;w:=F.4;;
G:=F/[x^2*y^2*z^2, x*y*x^-1*z*y*z^-1, w^2*x^-1*w^-1*z];;
ITestVector(G,[1,0,-1,2]); # true
ITestSimplex(G); # returns [ 1/2, 0, -1/2, 1 ]

F:=FreeGroup(["x","y","z"]);; x:=F.1;;y:=F.2;;z:=F.3;;
G:=F/[x*z*x^-1*y*z*y^-1*z^-1*y^-1, x*y^-1*x^-1*y^-1*x*y];;
ITestVector(G,[1,1,1]); # false
ITestVector(G,-[1,1,1]); # false
I_test_simplex(G); # false
