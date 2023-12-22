      Subroutine Change_Fractional(Av1,Av2)
      Implicit None

      Include 'commons.inc'

      Logical Laccept
      Integer Ibnew,Ibold,Ipart,Inew,Selectint,Ic,Lold
      Double Precision Unew1,Unew2,Uold1,Uold2,Mylambda,Xold,Yold,Zold
     $     ,Xnew,Ynew,Znew,Av1,Av2

C     Transfer The Fractional Molecule Into A Whole One
C     And Make A Random Molecule In The Other Box A Fractional One
C     Lambda Will Stay The Same
C     Beware The Fractional Particle Is Always Npart
      
      Mylambda = Lambda
      Ipart    = Npart
      Ibold    = Ibox(Npart)
      Ibnew    = 3 - Ibold
C	Switching the boxes
C	if old box(ibold)=1, then new box(Ibnew)=3-1=2
C	if old box(ibold)=2, then new box(Ibnew)=3-2=1

      Xold     = Rx(Npart)
      Yold     = Ry(Npart)
      Zold     = Rz(Npart)

C     Reject If The Other Box Is Empty
      
      If(Npbox(Ibnew).Eq.0) Return

C     Find The Bin For Lambda
      
      Ic = 1 + Int(Mylambda*Dble(Maxbl))
      If(Ic.Gt.Maxbl) Stop "Error Maxbl Change"

C     Select A Random Whole Particle In The Other Box
      
 1    Continue
      Inew = Selectint(Npart)
      If(Inew.Eq.Npart.Or.Ibox(Inew).Eq.Ibold) Goto 1
C	selects a new particle and makes sure that: 
C	(a) The selected particle is not Npart (Lambda) and 
C	(b) The selected particle is in the other box (Ibox(Inew) .nq. Ibox(Npart))

      Xnew = Rx(Inew)
      Ynew = Ry(Inew)
      Znew = Rz(Inew)

C     Calculate The Energy Change Of The Fractional Particle
C     In The Box It Is Currently In
      
      Call Epart(Ibold,Uold1,Xold,Yold,Zold,Ipart,Mylambda)
      Call Epart(Ibold,Unew1,Xold,Yold,Zold,Ipart,1.0d0)

C     Calculate The Energy Of The Old Configuration Of The Whole
C     Particle That Will Be Transformed Into A Fractional One
      
      Call Epart(Ibnew,Uold2,Xnew,Ynew,Znew,Inew,1.0d0)

C     As The Subroutine Epart Requires That The Fractional Particle
C     Always Has An Index Npart We Need To Shuffle A Bit
      
      Rx(Npart)   = Xnew
      Ry(Npart)   = Ynew
      Rz(Npart)   = Znew
      Ibox(Npart) = Ibnew
C	Particle Ibnew coordinates transferred to particle index "Npart" because Npart is always the
C	fractional component, and the old (original) Npart coordinates transferred 
C	to "Inew" particle index in return.

C	Xold=Rx(Npart)              Rx(Npart)=Xnew
C	Yold=Ry(Npart)				Ry(Npart)=Ynew
C	Zold=Rz(Npart)		 		Rz(Npart)=Znew
C                      ======> 	
C	Xnew=Rx(Inew)   			Rx(Inew)=Xold
C	Ynew=Ry(Inew)				Ry(Inew)=Yold
C	Znew=Rz(Inew)				Rz(Inew)=Zold

C	Fractional particle also swaps box identity with the whole particle, so the box changes:

C	Ibox(Npart)=Ibold           Ibox(Npart)=Inew         
C                      ======>
C	Ibox(Inew) =Ibnew           Ibox(Inew) =Ibold 

      Rx(Inew)   = Xold
      Ry(Inew)   = Yold
      Rz(Inew)   = Zold
      Ibox(Inew) = Ibold

      Call Epart(Ibnew,Unew2,Xnew,Ynew,Znew,Ipart,Mylambda)

C     Note That Box Ibold Contained The Fractional Particle Hence The
C     Total Real Particles In Ibold Equals Npbox(Ibold)-1

      Lold = 1 + Int(Dble(Maxbl)*Mylambda)
      If(Lold.Gt.Maxbl) Stop
      
      Call Accept((Dble(Npbox(Ibnew))/Dble(Npbox(Ibold)))*
     &     Dexp(-Beta*(Unew1+Unew2-Uold1-Uold2) +
     &     Weight(Ibnew,Lold) - Weight(Ibold,Lold)),Laccept)

      Av2 = Av2 + 1.0d0
      Av_Change(Ibold,Ic,2) = Av_Change(Ibold,Ic,2) + 1.0d0

C     Accept Or Reject
C     Nb The Total Number Of Particles In Each Box (Including The Fractional One
C     Does Not Change So Npbox(1) And Npbox(2) Are Unchanged

      If(Laccept) Then
         Av1 = Av1 + 1.0d0
         Av_Change(Ibold,Ic,1) = Av_Change(Ibold,Ic,1) + 1.0d0

         Etotal(Ibnew) = Etotal(Ibnew) + Unew2 - Uold2
         Etotal(Ibold) = Etotal(Ibold) + Unew1 - Uold1
      Else

C   Rejected Restore The Coordinates

C	Rx(Npart)=Xnew              Rx(Npart)= Xold
C	Ry(Npart)=Ynew				Ry(Npart)= Yold
C	Rz(Npart)=Znew		 		Rz(Npart)= Zold
C                      ======> 	
C	Rx(Inew)=Xold   			Rx(Inew)=Xnew
C	Ry(Inew)=Yold				Ry(Inew)=Ynew
C	Rz(Inew)=Zold				Rz(Inew)=Znew

C	Ibox(Npart)=Inew            Ibox(Npart)=Ibold        
C                      ======>
C	Ibox(Inew) =Ibold           Ibox(Inew) =Ibnew 
         
         Rx(Npart)   = Xold
         Ry(Npart)   = Yold
         Rz(Npart)   = Zold
         Ibox(Npart) = Ibold

         Rx(Inew)   = Xnew
         Ry(Inew)   = Ynew
         Rz(Inew)   = Znew
         Ibox(Inew) = Ibnew
		 
		 
		 
		 
		 
      Endif
      
      Return
      End
