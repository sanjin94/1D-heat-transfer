###***Material input matrix for every control volume (moisture)***###
function matv_pom(S,br_v,L)
    
    s=size(S)[1]
    
    #*Checking sum == L*#
    ss=0
    for i=1:s
        ss+=S[i,1]
    end
    
    tol=10^-4
    if abs(ss-L)>tol
        println("ERROR! Check the length of layers!")
        return
    end
    #*-------*#
        
    S1=[1 1 1 1 1 1]
    le=L/br_v
    for i=1:s
        if S[i,1]%le==0
            m=floor(Int64,S[i,1]÷le)
            Sp=Array{Float64}(undef,m,6)
            for j=1:m
                Sp[j,1]=le
                Sp[j,2]=S[i,2]
                Sp[j,3]=S[i,3]
                Sp[j,4]=S[i,4]
                Sp[j,5]=S[i,5]
                Sp[j,6]=S[i,6]
            end
        else
            m=floor(Int64,S[i,1]÷le)
            Sp=Array{Float64}(undef,m+1,6)
            for j=1:m
                Sp[j,1]=le
                Sp[j,2]=S[i,2]
                Sp[j,3]=S[i,3]
                Sp[j,4]=S[i,4]
                Sp[j,5]=S[i,5]
                Sp[j,6]=S[i,6]
            end
            Sp[m+1,1]=S[i,1]-m*le
            Sp[m+1,2]=S[i,2]
            Sp[m+1,3]=S[i,3]
            Sp[m+1,4]=S[i,4]
            Sp[m+1,5]=S[i,5]
            Sp[m+1,6]=S[i,6]
        end
        S1=[S1;Sp]
    end
    S1 = S1[setdiff(1:end, 1), :]
    #*-------*#
end