      Subroutine Move(Av1,Av2,Delta)
      Implicit None

      Include 'commons.inc'

C     Displace A Randomly Selected Particle
C     This Can Be A Fractional Molecule

      Logical Laccept
      Integer Ib,Ipart,Selectint
      Double Precision Rxn,Ryn,Rzn,Xi,Yi,Zi,Ran_Uniform,Unew,Uold
     $     ,Av1,Av2,Delta,Mylambda

      If(Npart.Eq.0) Return

      Ipart = Selectint(Npart)
      Ib    = Ibox(Ipart)
C    Select the particle at random and determine the box
	  
	  
C	  Cccccccccccccccccc Selectint() psuedo-code ccccccccccccccccccccccC
C     C 		1   Continue                                           C        
C 	  C 		Selectint = 1 + Int(Dble(Npart)*Ran_Uniform())         C
C	  C 		If (Selectint.Gt.J) Goto 1                             C
C	  CccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccC
      
      Mylambda = Lambda

      Rxn = Rx(Ipart) + (2.0d0*Ran_Uniform()-1.0d0)*Delta
      Ryn = Ry(Ipart) + (2.0d0*Ran_Uniform()-1.0d0)*Delta
      Rzn = Rz(Ipart) + (2.0d0*Ran_Uniform()-1.0d0)*Delta

C     Put Back In The Box

      If(Rxn.Lt.0.0d0) Then
         Rxn = Rxn + Box(Ib)
      Elseif(Rxn.Gt.Box(Ib)) Then
         Rxn = Rxn - Box(Ib)
      Endif

      If(Ryn.Lt.0.0d0) Then
         Ryn = Ryn + Box(Ib)
      Elseif(Ryn.Gt.Box(Ib)) Then
         Ryn = Ryn - Box(Ib)
      Endif

      If(Rzn.Lt.0.0d0) Then
         Rzn = Rzn + Box(Ib)
      Elseif(Rzn.Gt.Box(Ib)) Then
         Rzn = Rzn - Box(Ib)
      Endif
C	  Periodic boundary conditions if the dicplaced particle crosses the boundaries
C	  Putting the particle back in the box Rxn, Ryn, Rzn

      Xi = Rx(Ipart)
      Yi = Ry(Ipart)
      Zi = Rz(Ipart)
C     Old Random coordinates of the particles (Xi,Yi,Zi)
C 	  Ipart 		=	Randomly selected particle


      Call Epart(Ib,Uold,Xi,Yi,Zi,Ipart,Mylambda)
      Call Epart(Ib,Unew,Rxn,Ryn,Rzn,Ipart,Mylambda)

      Call Accept(Dexp(-Beta*(Unew-Uold)),Laccept)

      Av2 = Av2 + 1.0d0
C	Counting all trial moves
      
C     Accept Or Reject

      If(Laccept) Then
         Av1 = Av1 + 1.0d0
C	Counting accepted trial moves

         Etotal(Ib) = Etotal(Ib) + Unew - Uold
C	Energy difference of the moved particle added to the total energy of the box(Ib)
        
         Rx(Ipart) = Rxn
         Ry(Ipart) = Ryn
         Rz(Ipart) = Rzn
      Endif

      Return
      End
