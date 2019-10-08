#Element matrix
function Edof(br_e)
    M=Array{Int64}(undef,br_e,3)
    for i=1:br_e
        M[i,1]=i
        M[i,2]=i
        M[i,3]=1+i
    end
    M
end