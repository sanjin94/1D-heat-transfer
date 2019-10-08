###***Matrix transformation (moisture) to be slovable with existing functions***###
function mattrans(Sv1,pu)
    s=size(Sv1)[1]
    S=Array{Float64}(undef,br_v,4)
    S[:,1]=Sv1[:,1]
    S[:,3]=Sv1[:,3]
    S[:,4]=Sv1[:,4]
    for i=1:s
        if pu[i,1]<0
            a=22.4
            T0=272.44
            P=101300 #Ambient atmospheric pressure (set to be standard atmospheric pressure)
            δ=2.0*10^(-7)*pu[i]^(0.81)/P #Schirmer, R.: Die Diffusionszahl von Wasserdampf-Luft-Gemischen und die Verdampfungsgeschwindigkeit,
                                         #Beiheft VDI-Zeitschrift, Verfahrenstechnik (1938), H. 6, p. 170-177.
            psat=611*ℯ^((a*pu[i])/(T0+pu[i]))
            S[i,2]=psat*δ*(1/Sv1[i,5]-1/Sv1[i,6])
        else
            a=17.08
            T0=234.18
            P=101300 #Ambient atmospheric pressure (set to be standard atmospheric pressure)
            δ=2.0*10^(-7)*pu[i]^(0.81)/P #Schirmer, R.: Die Diffusionszahl von Wasserdampf-Luft-Gemischen und die Verdampfungsgeschwindigkeit,
                                         #Beiheft VDI-Zeitschrift, Verfahrenstechnik (1938), H. 6, p. 170-177.
            psat=611*ℯ^((a*pu[i])/(T0+pu[i]))
            S[i,2]=psat*δ*(1/Sv1[i,5]-1/Sv1[i,6])
        end
    end
    S
end