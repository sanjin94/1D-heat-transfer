#Control Volume Method Solution function
function seq(K,pu,S1,bc=0)
    
    br_v=size(K)[1]
    
    f=zeros(br_v,1)
    for i=1:br_v
        f[i,1]=S1[i,1]*S1[i,3]*S1[i,4]*pu[i,1]
    end
    
    if bc==0
        d=K\f
    else
        fdof=Array(1:br_v)
        d=zeros(size(fdof)[1])
        Q=zeros(size(fdof)[1])
        pdof=bc[:,1]
        dp=bc[:,2]
        deleteat!(fdof,[floor(Int64,pdof[1]);floor(Int64,pdof[2])])
        s=K[fdof,fdof]\(f[fdof]-(K[fdof,[floor(Int64,pdof[1]);floor(Int64,pdof[2])]])*dp)
        d[[floor(Int64,pdof[1]);floor(Int64,pdof[2])]]=dp
        d[fdof]=s
    end
    d    
end