##***Function for K matrix of control volume method***##
function Kmat(S1,br_v,ΔT)
    
    MV=Array{Float64}(undef,br_v,5)
    
    MV[1,1]=1
    MV[1,2]=S1[1,1]/2
    MV[1,3]=S1[1,1]/2+S1[2,1]/2
    MV[1,4]=S1[1,3]*S1[1,4]
    MV[1,5]=S1[1,2]
    MV[br_v,1]=br_v
    MV[br_v,2]=S1[br_v-1,1]/2+S1[br_v,1]/2
    MV[br_v,3]=S1[br_v,1]/2
    MV[br_v,4]=S1[br_v,3]*S1[br_v,4]
    MV[br_v,5]=S1[br_v,2]
           
    for i=2:(br_v-1)
        MV[i,1]=i
        MV[i,2]=S1[i-1,1]/2+S1[i,1]/2
        MV[i,3]=S1[i,1]/2+S1[i+1,1]/2
        MV[i,4]=S1[i,3]*S1[i,4]
        MV[i,5]=S1[i,2]
    end
    
    Mk=Array{Float64}(undef,br_v,3)
    
    for i=2:(br_v-1)
        Mk[i,1]=MV[i,4]*S1[i,1]/ΔT
        Mk[i,2]=1/(MV[i,2]/2*(1/MV[i-1,5]+1/MV[i,5]))
        Mk[i,3]=1/(MV[i,3]/2*(1/MV[i,5]+1/MV[i+1,5]))
    end
    Mk[1,1]=MV[1,4]*S1[1,1]/ΔT
    Mk[1,2]=1/(MV[1,2]/2*(1/MV[1,5]))
    Mk[1,3]=1/(MV[1,3]/2*(1/MV[1,5]+1/MV[2,5]))
    Mk[br_v,1]=MV[br_v,4]*S1[br_v,1]/ΔT
    Mk[br_v,2]=1/(MV[br_v,2]/2*(1/MV[(br_v-1)-1,5]+1/MV[br_v,5]))
    Mk[br_v,3]=1/(MV[br_v,3]/2*(1/MV[br_v,5]))
       
    Km=zeros(br_v,br_v)
    
    for i=2:(br_v-1)
        Km[i,i]=Mk[i,1]+Mk[i,2]+Mk[i,3]
        Km[i,i-1]=-Mk[i,2]
        Km[i,i+1]=-Mk[i,3]
    end
    Km[1,1]=Mk[1,1]+Mk[1,2]+Mk[1,3]
    Km[1,2]=-Mk[1,3]
    Km[br_v,br_v]=Mk[br_v,1]+Mk[br_v,2]+Mk[br_v,3]
    Km[br_v,br_v-1]=-Mk[br_v,2]   
    
    ΔT*Km
end