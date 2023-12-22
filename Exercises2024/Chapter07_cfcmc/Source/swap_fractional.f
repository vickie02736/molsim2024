      Subroutine Swap_Fractional(Av1,Av2)
      Implicit None

      Include 'commons.inc'

      Logical Laccept
      Integer Ibnew,Ibold,Ipart,Ic,Lold
      Double Precision Xi,Yi,Zi,Ran_Uniform,Unew,Uold,
     &     Mylambda,Av1,Av2

C     Swap The Fractional Molecule The Other Box While Keeping
C     Lambda Constant
C     Particle Npart Is Always The Fractional Particle
C
C     Ibold = The Box In Which The Fractional Particle Is In Now
C     Ibnew = The New Box Of The Fractional Molecule
      
      Mylambda = Lambda
      Ipart    = Npart
      Ibold    = Ibox(Npart)
      Ibnew    = 3 - Ibold
      Xi       = Rx(Npart)
      Yi       = Ry(Npart)
      Zi       = Rz(Npart)

C     Check In Which Bin Is Lambda
C     We Want To Know The Acceptance Rate For This Move As
C     A Function Of Lambda
      
      Ic = 1 + Int(Mylambda*Dble(Maxbl))
      If(Ic.Gt.Maxbl) Stop "Error Maxbl Swap_Fractional"

C     Energy Of The Old Configuration
      
      Call Epart(Ibold,Uold,Xi,Yi,Zi,Ipart,Mylambda)

C     Random Position In The New Box
      
      Xi = Ran_Uniform()*Box(Ibnew)
      Yi = Ran_Uniform()*Box(Ibnew)
      Zi = Ran_Uniform()*Box(Ibnew)

C     Energy Of The New Configuration
      
      Call Epart(Ibnew,Unew,Xi,Yi,Zi,Ipart,Mylambda)

      Lold = 1 + Int(Dble(Maxbl)*Mylambda)
	  
      If(Lold.Gt.Maxbl) Stop
      
      Call Accept(((Box(Ibnew)/Box(Ibold))**3)*
     &     Dexp(-Beta*(Unew-Uold) +
     &     Weight(Ibnew,Lold) - Weight(Ibold,Lold)),Laccept)

      Av2 = Av2 + 1.0d0
      Av_Swap(Ibold,Ic,2) = Av_Swap(Ibold,Ic,2) + 1.0d0

C     Accept Or Reject

      If(Laccept) Then
         Npbox(Ibnew) = Npbox(Ibnew) + 1
         Npbox(Ibold) = Npbox(Ibold) - 1

         Rx(Npart) = Xi
         Ry(Npart) = Yi
         Rz(Npart) = Zi

         Ibox(Npart) = Ibnew

         Av1 = Av1 + 1.0d0
         Av_Swap(Ibold,Ic,1) = Av_Swap(Ibold,Ic,1) + 1.0d0

         Etotal(Ibnew) = Etotal(Ibnew) + Unew
         Etotal(Ibold) = Etotal(Ibold) - Uold
      Endif
      
      Return
      End
