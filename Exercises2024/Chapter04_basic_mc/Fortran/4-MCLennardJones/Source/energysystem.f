      Subroutine EnergySystem(TotalEnergy, TotalVirial)
C
C     Calculates Total Energy Of The System
C     Only Used In The Beginning Or At The End Of The Program
C
C     TotalEnergy (Output) : Total Energy
C     TotalVirial (Output) : Total Virial
C
 
      Implicit None

      Include 'parameter.inc'
      Include 'conf.inc'
      Include 'system.inc'
      Include 'potential.inc'
 
      Double Precision Xi,Yi,Zi,Sig,Eps,TotalEnergy,TotalVirial,Energy,Virial
      Integer I, Jb
 
      TotalEnergy = 0.0d0
      TotalVirial  = 0.0d0

      Do I = 1, NumberOfParticles - 1
         Xi = X(I)
         Yi = Y(I)
         Zi = Z(I)
         Jb = I + 1

         Call EnergyParticle(Xi, Yi, Zi, I, Jb, Energy, Virial)

         TotalEnergy = TotalEnergy + Energy
         TotalVirial = TotalVirial + Virial
      End Do

      Energy = Energy + NumberOfParticles*(8.0d0/3.0d0)*4.0d0*Atan(1.0)*
     &         (Dble(NumberOfParticles)/Box**3)*Eps*
     &         ((1.0d0/3.0d0)*(Sig/Rc)**9-(Sig/Rc)**3)

      Return
      End
