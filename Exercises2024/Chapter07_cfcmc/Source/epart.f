      Subroutine Epart(Ib,Upot,Xi,Yi,Zi,Ipart,Mylambda)
      Implicit None

      Include 'commons.inc'

C     Compute The Energy Of Particle In Box Ib(=1 or 2)
C     Interactions With Particle Ipart Are Excluded
C     Mylambda Is The Value Of Lambda
C     The Last Particle Npart Is Always The Fractional Particle

      Integer I,Ib,Ipart
      Double Precision Upot,Dx,Dy,Dz,R2,Bx,Hbx,Xi,Yi,Zi,Mylambda
     $     ,Ecutlambda,Off

      Upot = 0.0d0
      Bx   = Box(Ib)
      Hbx  = 0.5d0*Box(Ib)
C	Bx  	 = Box(Ib) length
C	HBx  	 = Half a box(Ib) length


C     The Interaction Potential Of The Fractional Particle Is Also
C     Truncated And Shifted

      R2         = Rcutsq
      Off        = 0.5d0*((1.0d0-Mylambda)**2)
      R2         = 1.0d0/(R2*R2*R2 + Off)
      Ecutlambda = 4.0d0*Mylambda*R2*(R2-1.0d0)
C     Truncated And Shifted LJ for lambda and whole particle at cutoff radius
C	  Calculatting the cut-off energy for lambda
C	  CFCMC Shi & Maginn 2007 section 4. Simulation details, eq.s 18 & 20

      Do I=1,Npart
         If(Ibox(I).Eq.Ib.And.I.Ne.Ipart) Then

            Dx = Rx(I)-Xi
            Dy = Ry(I)-Yi
            Dz = Rz(I)-Zi
C	  Xi, Yi, Zi are coordinates of the ''Ipart'' particle calculated in init.f
C	  Dx, Dy, Dz distance between Ipart and another particle from I=1,Npart
            
            If (Dx.Gt.Hbx) Then
               Dx = Dx - Bx
            Elseif (Dx.Lt.-Hbx) Then
               Dx = Dx + Bx
            Endif
                  
            If (Dy.Gt.Hbx) Then
               Dy = Dy - Bx
            Elseif (Dy.Lt.-Hbx) Then
               Dy = Dy + Bx
            Endif
                  
            If (Dz.Gt.Hbx) Then
               Dz = Dz - Bx
            Elseif (Dz.Lt.-Hbx) Then
               Dz = Dz + Bx
            Endif
C	  Periodic boundary conditions , half box length

            R2 = Dx**2 + Dy**2 + Dz**2

            If(R2.Lt.Rcutsq) Then

               If(Ipart.Eq.Npart.Or.I.Eq.Npart) Then
C              Interaction Of A Fractional Molecule (Nth-part is the fractional molecule )
                  
                  R2   = 1.0d0/(R2*R2*R2 + Off)
                  Upot = Upot + 4.0d0*Mylambda*R2*(R2-1.0d0) - Ecutlambda 
C				  LJ Truncated and shifted fractional molecule with the rest of the box
               Else

C     Interaction Of A Real Molecule
                  
                  R2   = 1.0d0/(R2*R2*R2)
                  Upot = Upot + 4.0d0*R2*(R2-1.0d0) - Ecut
C					LJ truncated and shifted for the whole molecule.
               Endif
            Endif
         Endif
      Enddo

      Return
      End
