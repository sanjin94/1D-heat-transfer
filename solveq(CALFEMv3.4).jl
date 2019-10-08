#FEM Solution function (translated from CALFEM v3.4)
function solveq(K,f,bc=0)
    if bc==0
        d=K\f
    else
        nd=size(K)[1]
        fdof=Array(1:nd)
        d=zeros(size(fdof)[1])
        Q=zeros(size(fdof)[1])
        pdof=bc[:,1]
        dp=bc[:,2]
        deleteat!(fdof,[pdof[1],pdof[2]])
        s=K[fdof,fdof]\(f[fdof]-(K[fdof,pdof])*dp)
        d[pdof]=dp
        d[fdof]=s
    end
    d    
end