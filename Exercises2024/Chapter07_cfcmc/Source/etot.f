      Subroutine Etot(Ib,Upot)
      Implicit None

      Include 'commons.inc'

C     Compute The Total Energy Of Box Ib
C     Molecule Npart Is The Fractional Molecule

      Integer I,J,Ib
      Double Precision Upot,Dx,Dy,Dz,R2,Bx,Hbx,Off,Ecutlambda

      Upot = 0.0d0
      Bx   = Box(Ib)
      Hbx  = 0.5d0*Box(Ib)

      R2         = Rcutsq
      Off        = 0.5d0*((1.0d0-Lambda)**2)
      R2         = 1.0d0/(R2*R2*R2 + Off)
      Ecutlambda = 4.0d0*Lambda*R2*(R2-1.0d0)
      
      Do I=1,Npart-1

         If(Ibox(I).Eq.Ib) Then

            Do J=I+1,Npart

               If(Ibox(J).Eq.Ib) Then

                  Dx = Rx(I)-Rx(J)
                  Dy = Ry(I)-Ry(J)
                  Dz = Rz(I)-Rz(J)

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
C	             Periodic boundary conditions , half box length

                  R2 = Dx**2 + Dy**2 + Dz**2

                  If(R2.Lt.Rcutsq) Then
                     If(J.Eq.Npart) Then
C                  Nth-part is the fractional molecule (check if J=Nth particle)

C     Interactions With A Fractional Molecule
                        
                        R2   = 1.0d0/(R2*R2*R2 + Off)
                        Upot = Upot + 4.0d0*Lambda*R2*(R2-1.0d0) - Ecutlambda
						
C     Truncated And Shifted LJ for lambda and whole particle at cutoff radius
C	  Calculatting the cut-off energy for lambda
C	  CFCMC Shi & Maginn 2007 section 4. Simulation details, eq.s 18 & 20
                      
                     Else

C     Interactions With A Real Molecule
                        
                        R2   = 1.0d0/(R2*R2*R2)
                        Upot = Upot + 4.0d0*R2*(R2-1.0d0) - Ecut
                     Endif
                  Endif
               Endif
            Enddo
         Endif
      Enddo

      Return
      End
