C     Global Variables
C
C     Maxpart   = Maximum Number Of Particles
C     Maxbl     = In How Many Bins Do We Divide Lambda Space?
C     Npart     = Number Of Particles
C                 The Fractional Particle Is Always The Last One
C     Ibox      = In Which Box Is A Particle ?
C     Npbox     = Number Of Particles In A Box Including The Fractional One
C     Rx/Ry/Rz  = Coordinates
C     Ecut      = Cut-Off Energy Of Real Particles
C     Rcutsq    = Cut-Off Radius Squared
C     Beta      = 1/Temperature
C     Etotal    = Total Energy Of A Box
C     Lambda    = Lambda In Cfcmc
C     Weight    = Weightfunction
C     Av_Change = Acceptance Probability Of Changing The Fractional Molecule
C                 As A Function Of Lambda
C     Av_Swap   = Acceptance Probability Of Swapping The Fractional Molecule
C                 As A Function Of Lambda

      Integer Maxpart,Maxbl

      Parameter (Maxpart = 256)
      Parameter (Maxbl   = 100)

      Integer Npart,Ibox(Maxpart),Npbox(2)

      Double Precision Rx(Maxpart),Ry(Maxpart),Rz(Maxpart),Box(2),F_Modification,Ecut
     $     ,Rcutsq,Beta,Etotal(2),Lambda,Av_Change(2,Maxbl,2)
     $     ,Av_Swap(2,Maxbl,2),Weight(2,Maxbl)

      Common /Mycomms/ Rx,Ry,Rz,Box,F_Modification,Ecut,Rcutsq,Beta,Etotal,Lambda
     $     ,Av_Change,Av_Swap,Weight,Npart,Ibox,Npbox
