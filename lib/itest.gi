#############################################################################
##
#W  itest.gi             Itest Package		Iván Sadofschi Costa
##
##  An implementation of Barmak and Minian's I-test
##
##  
##  
##


LoadPackage("Semigroups");
LoadPackage("polymaking");

InstallGlobalFunction(q,function(gens, w)
	local v,l,i,x;
	l:=Length(w);
	v:=0*[1..Size(gens)];
	for i in [1..l] do
		x:=Subword(w,i,i);
		if x in gens then
			v[Position(gens,x)]:=v[Position(gens,x)]+1;
		else
			v[Position(gens,x^-1)]:=v[Position(gens,x^-1)]-1;
		fi;
	od;
	return v;
end);

InstallGlobalFunction(IsGoodMatrixByDefinition,function(M)
	# definition 2.5
	local n,m, i,j,iter,iter2,k,lambda_k,good;
	n:=Size(M);
	m:=Size(M[1]);
	if n>= m then
		iter:=IteratorOfArrangements(n,m);
		for i in iter do
			iter2:=IteratorOfArrangements(m,m);
			for j in iter2 do
				good:=true;
				for k in [1..m] do
					if M[i[k]][j[k]]=[] then # condition (1)
						good:=false;
						break;
					else
						lambda_k:=Maximum(M[i[k]][j[k]]);
						if lambda_k < Maximum(Union(M[i[k]])) then # condition (2)
							good:=false;
							break;
						else
							if Size(Positions(Concatenation(M[i[k]]{List([k..m],t->j[t])}),lambda_k))>1 then # condition (3)
								good:=false;
								break;
							fi;
						fi;
					fi;
				od;
				if good then
					Print("# columns:", j, ", rows: ",i,"\n");
					return true;
				fi;
			od;
		od;	 
	fi;
	return false;
end);

InstallGlobalFunction(Matrix012,function(M)
	local m,n,i,j,T;
	n:=Size(M);
	m:=Size(M[1]);
	T:=List([1..n], x-> List([1..m],y->0));
	for i in [1..n] do
        	for j in [1..m] do
			if (not Size(M[i][j]) = 0) and Maximum(M[i][j]) = Maximum(Union(M[i])) then
				if Number( M[i][j], x-> (x = Maximum(M[i][j])) ) = 1 then
					T[i][j]:=1;
				else
					T[i][j]:=2;
				fi;
			fi;
		od;
	od;
	return T;
end);

InstallGlobalFunction(ReduceMatrix,function(T)
	# this function was replaced by ReduceMatrixMoreInfo
	local m,n,i;
	n:=Size(T);
	m:=Size(T[1]);
	for i in [1..n] do
        	if Sum( List(T[i],x->AbsInt(x)) ) = 1 then
        	        return ReduceMatrix( T{ Filtered([1..n], x-> not x=i) }{ Filtered([1..m], j -> T[i][j]=0) } );
		fi;
	od;
	return T;
end);

InstallGlobalFunction(ReduceMatrixMoreInfo,function(T)
	# The difference with ReduceMatrix is that this one
	# allows us to know [i1,...,im] and [j1,...,jm]
	local _ReduceMatrix, rownames,colnames,chosen;

	_ReduceMatrix:=function(T,rownames,colnames,chosen)
		local m,n,i,j,irows,icols;
		n:=Size(T);
		m:=Size(T[1]);
		for i in [1..n] do
			if Sum( List(T[i],x->AbsInt(x)) ) = 1 then
				j:=Position(T[i],1);
				irows:=Filtered([1..n], x-> not x=i);
				icols:=Filtered([1..m], j -> T[i][j]=0);
			        return _ReduceMatrix( T{ irows }{ icols }, rownames{irows},colnames{icols}, Concatenation(chosen,[[rownames[i],colnames[j]]]) );
			fi;
		od;
		return [T,rownames,colnames,chosen];
	end;;

	rownames:=[1..Size(T)];
	colnames:=[1..Size(T[1])];
	chosen:=[];
	return _ReduceMatrix(T,rownames,colnames,chosen);

end);

InstallGlobalFunction(IsGoodMatrix,function(M)
	local aux,chosen,cols,rows;
	aux:=ReduceMatrixMoreInfo(Matrix012(M));
	chosen:=aux[4];
	if Size(Union(aux[1]))=0 then # the matrix is good
		cols:=List(chosen,x->x[2]);
		rows:=List(chosen,x->x[1]);
		Print("# columns:", cols , ", rows: " , rows , "\n");
		return true;
	else
		return false;
	fi;
end);

InstallGlobalFunction(SubwordMatrix,function(G)
	local gens,R,n,m,M,i,j,r,l,t,x;
	gens:=GeneratorsOfGroup(FreeGroupOfFpGroup(G));
	R:=RelatorsOfFpGroup(G);
	n:=Size(gens);
	m:=Size(R);
	M:=List([1..n], i-> List([1..m], j->[]));
	for j in [1..m] do
		r:=R[j];
		l:=Length(r);
		for t in [1..l] do
			x:=Subword(r,t,t);
			if x in gens then
				# sign +
				i:=Position(gens,x);
				Add(M[i][j], Subword(r,t,l));
			else 
				# sign -
				i:=Position(gens,x^-1);
				Add(M[i][j], Subword(r,t+1,l));
			fi;
		od;
	od;
	return M;
end);

InstallGlobalFunction(WeightMatrix,function(G,v)
	local gens,qv;
	gens:=GeneratorsOfGroup(FreeGroupOfFpGroup(G));
	qv:= w -> q(gens,w)*v;
	return List(SubwordMatrix(G),Mi->List(Mi,Mij->List(Mij,qv)));
end);

InstallGlobalFunction(ITestVector,function(G,v)
	local gens,M,qv,R,r;
	gens:=GeneratorsOfGroup(FreeGroupOfFpGroup(G));
	qv:= w -> q(gens,w)*v;
	R:=RelatorsOfFpGroup(G);
	for r in R do
		if not qv(r)=0 then
			Print( "# v must be orthogonal to q(r) for each relator r.\n");
			return false;
		fi;	
	od;
	M:=WeightMatrix(G,v);
	return IsGoodMatrix(M);
end);


InstallGlobalFunction(ITestPoly,function(G)
	# if the i test can be applied returns a vector v
	# otherwise returns false
	local n,m, i,j,iter,iter2,iter3,k,lambda,good,f,w,v,ineq_list,P,q1,gens,M,R,s,r,vertices;
	gens:=GeneratorsOfGroup(FreeGroupOfFpGroup(G));
	R:=RelatorsOfFpGroup(G);
	M:=SubwordMatrix(G);
	q1:=w->q(gens,w);
	n:=Size(M);
	m:=Size(M[1]);
	if n>= m then
		iter:=IteratorOfArrangements(n,m);
		for i in iter do
			iter2:=IteratorOfArrangements(m,m);
			for j in iter2 do
				iter3:= IteratorOfCartesianProduct( List([1..m], k-> M[i[k]][j[k]]) );
				for lambda in iter3 do # for each way of choosing the lambda_k's
					# condition (1) is already satisfied
					# we create the polytope
					P:=CreatePolymakeObject();
					ineq_list:=[]; 
					# an inequality [a0,a1,...an,an+1]
					# represents a0+a1.x1+...+an.xn + an+1.eps >= 0
					# then we check if P has a vertex with with eps>0

					good:=true;

					# conditions for eps>=0 and eps<=1:
					Add(ineq_list, Concatenation([0],0*[1..n],[1]));
					Add(ineq_list, Concatenation([1],0*[1..n],[-1]));

					# conditions to bound r:
					for s in [1..n] do
						Add(ineq_list, Concatenation([1], -IdentityMat(n)[s] ,[0]));
						Add(ineq_list, Concatenation([1],IdentityMat(n)[s],[0]));
					od;

					# inequalities for orthogonality:
					for r in R do
						Add(ineq_list, Concatenation([0],q1(r),[0]));
						Add(ineq_list, Concatenation([0],-q1(r),[0]));					
					od;
					for k in [1..m] do
						# inequalities for condition (2):
						f:=Union(M[i[k]]);
						for w in f do
							v:=q1(lambda[k])-q1(w);
							Add(ineq_list, Concatenation([0],v,[0]));
						od;
						# now we check condition (3):
						f:=Concatenation(M[i[k]]{List([k..m],t->j[t])});
						if Size(Positions(f,lambda[k]))>1 then # condition (3) fails
							good:=false;
							break;
						fi;
						f:=Set(f);
						# inequalities for condition (3):
						for w in f do
							if not w=lambda[k] then
								v:=q1(lambda[k])-q1(w);
								Add(ineq_list, Concatenation([0],v,[-1]));
							fi;
						od;
					od;
			 		# we compute the polytope
					if good then
						# Print(ineq_list,"\n");
						AppendInequalitiesToPolymakeObject(P, ineq_list);;
						if Polymake(P,"N_VERTICES")>0 then
							vertices:=Polymake(P,"VERTICES");;
							for v in vertices do
								if v[n+1]>0 then
									return v{[1..n]};
								fi;
							od;
						fi;
					fi;
				od;
			od;
		od;
	fi;
	return false;
end);

InstallGlobalFunction(ITest,function(G,n...)
	local B,i,k,v,d,lambdas,maxTries,ExponentMatrixOfGroup;

	ExponentMatrixOfGroup := function(G)
		local gens,rels,M,i,j;
		gens:=GeneratorsOfGroup(FreeGroupOfFpGroup(G));;
		rels:=RelatorsOfFpGroup(G);;
		M:=NullMat(Size(rels),Size(gens));;
		for i in [1..Size(rels)] do
			for j in [1..Size(gens)] do
				M[i][j]:=ExponentSumWord(rels[i],gens[j]);
			od;
		od;
		return M;
	end;;

	B:=TriangulizedNullspaceMat(TransposedMat(ExponentMatrixOfGroup(G)));
	B:=List(B, v-> Lcm(List(v,DenominatorRat))*v);
	k:=Size(B);
	if n=[] then
		maxTries:=10000;
	else
		maxTries:=n[1];
	fi;
	for i in [1..maxTries] do
		lambdas:=List([1..k], x->Random([-1000..1000]));
		v:=Sum(List([1..k], i-> lambdas[i]*B[i]));
		d:=Gcd(Integers,v);
		if d=0 then continue; fi;
		v:=v/d;
		if not ITestVector(G,v)=false then
			return v;
		fi;
	od;
	Print("# Tried ", maxTries, " random vectors without success.\n# Now I am trying with every possible vector...\n");
	return ITestPoly(G);
end);

