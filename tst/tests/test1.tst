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
