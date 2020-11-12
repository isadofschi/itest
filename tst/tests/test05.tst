gap> M :=[[[1,1]]];;
gap> IsGoodMatrix(M);
false
gap> IsGoodMatrixByDefinition(M);
false
gap> M:=[ 
> [ [0,-1],  [1,0,0],  [-3]      ],
> [ [-2,-2], [-1,1], []        ],
> [ [-2,-1], [0,0],  [-1]      ],
> [ [],      [],     [0,-1] ]
> ];;
gap> IsGoodMatrixByDefinition(M);
false
gap> IsGoodMatrix(M);
false

