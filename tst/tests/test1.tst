# Test 1
gap> F:=FreeGroup(["x","y","z","w"]);;
gap> AssignGeneratorVariables(F);
#I  Assigned the global variables [ x, y, z, w ]
gap> G:=F/[x^2*y^2*z^2, x*y*x^-1*z*y*z^-1, w^2*x^-1*w^-1*z];;
gap> SubwordMatrix(G);
[
[[x^2*y^2*z^2,x*y^2*z^2],[x*y*x^-1*z*y*z^-1,z*y*z^-1 ],[w^-1*z]                         ],
[[y^2*z^2,y*z^2],        [y*x^-1*z*y*z^-1,y*z^-1 ],    []                               ], 
[[z^2,z],                [z*y*z^-1,<identity ...>],    [z]                              ], 
[[],                     [],                           [w^2*x^-1*w^-1*z,w*x^-1*w^-1*z,z]]
]
