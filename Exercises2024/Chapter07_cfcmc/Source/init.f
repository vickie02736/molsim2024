      Subroutine Init
      Implicit None

      Include 'commons.inc'

C     Generate An Initial Configuration
C     Not An Eqwuilibrium Configuration, But Just Avoid Overlaps

      Logical Laccept
      Integer I,J,Ipart,Ib,Selectint
      Double Precision Fac,Ran_Uniform,Xi,Yi,Zi,Rxn,Ryn,Rzn,Unew,Uold
	  
C     Generate Random Coordinates And 
C     Place Particles In A Certain Box


      Fac = Box(1)**3/(Box(1)**3 + Box(2)**3)
C	  Box(1), Box(2) defined in run

      Npbox(1) = 0
      Npbox(2) = 0
C	  Npbox     = Number Of Particles In A Box ******Including The Fractional One********

      Do I=1,Npart
	
         If(Ran_Uniform().Lt.Fac) Then
            Ibox(I) = 1
         Else
            Ibox(I) = 2
         Endif
C	  Ibox(I)    = In Which Box Is A Particle ?


         Npbox(Ibox(I)) = Npbox(Ibox(I)) + 1
C	  filling boxes Ibox(I)=1 & Ibox(I)=2 with particles
C     Npbox     = Number Of Particles In A Box ******Including The Fractional One********

         Rx(I) = Box(Ibox(I))*Ran_Uniform()
         Ry(I) = Box(Ibox(I))*Ran_Uniform()
         Rz(I) = Box(Ibox(I))*Ran_Uniform()
C	   Random coordinates for all particles in each box
      Enddo

C     Monte Carlo Displacements To Remove Initial Overlaps
C     On Average 50 Displacements Per Particle

      Do J=1,Npart*50
         Ipart = Selectint(Npart)
         Ib    = Ibox(Ipart)
C	  Ipart		=	Randomly selected particle
C	  Ib		=	To which box does this particle belong? 1 or 2


         
         Rxn = Rx(Ipart) + Ran_Uniform() - 0.5d0
         Ryn = Ry(Ipart) + Ran_Uniform() - 0.5d0
         Rzn = Rz(Ipart) + Ran_Uniform() - 0.5d0
C     Random Displacement Maximum Dispacement Fixed
C	  New coordinates for particle Ipart in box Ib


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
C     Assume That All Particles Are Real Particles
         
         Call Epart(Ib,Uold,Xi,Yi,Zi,Ipart,1.0d0)
         Call Epart(Ib,Unew,Rxn,Ryn,Rzn,Ipart,1.0d0)
C	  Ipart has 2 sets of coordinates, New set: yet not accepted Xn,Yn,Zn and Actual pos. Xi,Yi,Zi

C     Assume The Temperature Is 2 So No Phase Transitions Initially
         
         Call Accept(Dexp(-0.5d0*(Unew-Uold)),Laccept)

         If(Laccept) Then
            Rx(Ipart) = Rxn
            Ry(Ipart) = Ryn
            Rz(Ipart) = Rzn
         Endif
C	  Accepting new positions Xn, Yn, Zn for the particles		 
      Enddo
C	  Finishing MC move, on Average 50 Displacements Per Particle
	  
      Return
      End
