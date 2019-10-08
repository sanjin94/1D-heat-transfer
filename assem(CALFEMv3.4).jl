#Function for global stifness matrix (translated from CALFEM v3.4)
function assem(edof,K,Ke,f=0,fe=0)
    nie=size(edof)[1]
    n=size(edof)[2]
    t=edof[:,2:n]
    for i=1:nie
        K[t[i,:],t[i,:]] = K[t[i,:],t[i,:]]+Ke
        if f!=0*fe!=0
            f[t[i,:]]=f[t[i,:]]+fe
        end
    end
    K
end