      Subroutine Volume_Gibbs(Av1,Av2,Delta)
      Implicit None

C     Volume Change In The Gibbs Ensemble

      Include 'commons.inc'

      Logical Laccept
      Integer I
      Double Precision Rxo(Maxpart),Ryo(Maxpart),Rzo(Maxpart),Df(2)
     $     ,Unew1,Unew2,Delta,Av1,Av2,Ran_Uniform
     $     ,Volold(2),Boxold(2),Volnew(2)

C     Store Old Box Size And Volume
      
      Do I=1,2
         Boxold(I) = Box(I)
         Volold(I) = Box(I)**3
      Enddo

C     New Volume Random Walk In V Not Its Logarithm
      
      Volnew(1) = Volold(1) + (2.0d0*Ran_Uniform()-1.0d0)*Delta

C     Reject Negative Volume

      If(Volnew(1).Le.0.0d0) Return

      Volnew(2) = Volold(1) + Volold(2) - Volnew(1)

C     Reject Negative Volume

      If(Volnew(2).Le.0.0d0) Return

C     Scaling Factor For Particle Positions And New Box Length
      
      Do I=1,2
         Df(I)  = (Volnew(I)/Volold(I))**(1.0d0/3.0d0)
         Box(I) = Volnew(I)**(1.0d0/3.0d0)
      Enddo
C      write(6,*) Box(1),Box(2)
      If(Dsqrt(Rcutsq).Gt.0.5d0*Min(Box(1),Box(2)))
     &     Stop "Error Volume; Rcut Is Too Smal !!!"

C     Transform Coordinates

      Do I=1,Npart
         Rxo(I) = Rx(I)
         Ryo(I) = Ry(I)
         Rzo(I) = Rz(I)

         Rx(I) = Rx(I)*Df(Ibox(I))
         Ry(I) = Ry(I)*Df(Ibox(I))
         Rz(I) = Rz(I)*Df(Ibox(I))
      Enddo

C     Compute New Energy Of Both Boxes

      Call Etot(1,Unew1)  
      Call Etot(2,Unew2)

      Call Accept(Dexp(-Beta*(Unew1 + Unew2 - Etotal(1) - Etotal(2)) + 
     &     Dble(Npbox(1))*Dlog(Volnew(1)/Volold(1)) + 
     &     Dble(Npbox(2))*Dlog(Volnew(2)/Volold(2))),Laccept)
      
      Av2 = Av2 + 1.0d0

      If(Laccept) Then
         Av1 = Av1 + 1.0d0
         
         Etotal(1) = Unew1
         Etotal(2) = Unew2
      Else

C     Reejct, Restore Coordinates and Box Length

         Box(1) = Boxold(1)
         Box(2) = Boxold(2)

         Do I=1,Npart
            Rx(I) = Rxo(I)
            Ry(I) = Ryo(I)
            Rz(I) = Rzo(I)
         Enddo
      Endif

      Return
      End
