		Subroutine Movelambda(Av1,Av2,Delta)
      Implicit None

      Include 'commons.inc'
C     Generates New Value Of Lambda And
C     Rejects Move When Outside Interval 0 1


C     Displace Lambda

      Logical Laccept
      Integer Ib,Ipart,Lnew,Lold
      Double Precision Xi,Yi,Zi,Ran_Uniform,Unew,Uold,Av1,Av2,Delta
     $     ,Lambdaold,Lambdanew

      If(Npart.Eq.0) Return

C     Generate New Value Of Lambda And
C     Reject Move When Outside Interval 0 1
      
      Lambdaold = Lambda
      Lambdanew = Lambda + (2.0d0*Ran_Uniform()-1.0d0)*Delta

      If(Lambdanew.Le.0.0d0.Or.Lambdanew.Ge.1.0d0) Return

C     The Last Particle Npart Is Always The Fractional Particle (Npart)
      
      Ipart = Npart
      Ib    = Ibox(Npart)
      Xi    = Rx(Npart)
      Yi    = Ry(Npart)
      Zi    = Rz(Npart)

      Call Epart(Ib,Uold,Xi,Yi,Zi,Ipart,Lambdaold)
      Call Epart(Ib,Unew,Xi,Yi,Zi,Ipart,Lambdanew)

      Lnew = 1 + Int(Dble(Maxbl)*Lambdanew)
      If(Lnew.Gt.Maxbl) Stop

      Lold = 1 + Int(Dble(Maxbl)*Lambdaold)
      If(Lold.Gt.Maxbl) Stop
	  
C     Weight(Ib,Lnew) = Weight function is a matrix, Weight specific to each bin is located in the
C     in the matrix in arrays [Ib(box number), Lambda bin(discretized lambda)]
C	  initial weight=0
      
      Call Accept(Dexp(-Beta*(Unew-Uold) +
     &     Weight(Ib,Lnew) - Weight(Ib,Lold)),Laccept)
C	  Acceptance Criteria derived in Ali's paper	 


      Av2 = Av2 + 1.0d0

C     Accept Or Reject

      If(Laccept) Then
         Av1 = Av1 + 1.0d0

         Etotal(Ib) = Etotal(Ib) + Unew - Uold
        
         Lambda = Lambdanew
      Endif

      Return
      End
