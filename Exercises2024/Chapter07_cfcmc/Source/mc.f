      Program Mc
      Implicit None
      
C     Monte Carlo In The Npt, Nvt, Muvt, And Gibbs Ensemble
      
      Include 'commons.inc'

      Logical Linit,Lweight,LWL,LIT
      Integer Ncycle,Ninit,Nmove,I,J,K,Icycle,Idummy,Icycle2,Dd(2),ierr
      Double Precision Pdisp,Pswap,Pvol,Temp,Deltax,Deltav,Deltal,E,Rm
     $     ,Ran_Uniform,Dummy,Avv1,Avv2,Avd1,Avd2,Avl1,Avl2,Avc1,Avc2
     $     ,Avs1,Avs2,Rm2,Problambda(2,Maxbl),Problambda2,Av2
     $     ,Av1(9),Avdens(2,4),Avbox1,Avbox2,Norm1,Norm2,Myweight,
     $     Flatness_Ratio, Reduction_Factor

C     Set Counters To Zero
      
      Avv1 = 0.0d0
      Avv2 = 0.0d0
      Avd1 = 0.0d0
      Avd2 = 0.0d0
      Avl1 = 0.0d0
      Avl2 = 0.0d0
      Avc1 = 0.0d0
      Avc2 = 0.0d0
      Avs1 = 0.0d0
      Avs2 = 0.0d0
      
      Avbox1 = 0.0d0
      Avbox2 = 0.0d0
      
      Do I=1,Maxbl
         Do J=1,2
            Do K=1,2
               Weight(K,I)      = 0.0d0
               Av_Change(K,I,J) = 0.0d0
               Av_Swap(K,I,J)   = 0.0d0
            Enddo
         Enddo
      Enddo

      Do J=1,9
         Av1(J) = 0.0d0
      Enddo

      Do I=1,2
         Do J=1,4
            Avdens(I,J) = 0.0d0
         Enddo
      Enddo
      
      Av2 = 0.0d0
      
      Do I=1,Maxbl
         Do J=1,2
            Problambda(J,I)=0.0d0
         Enddo
      Enddo

      Problambda2 = 0.0d0

C     Read Input From Disk
      
      Open(21,File="Input",Status="Unknown")
      Read(21,*)
      Read(21,*) Ncycle,Ninit,Npart,Linit,Lweight,LWL,LIT,Temp
      Read(21,*)
      Read(21,*) Pdisp,Pswap,Pvol
      Read(21,*)
      Read(21,*) Deltax,Deltav,Deltal
      Read(21,*)
      Read(21,*) Box(1),Box(2)
      Read(21,*) 
      Read(21,*) F_Modification,Flatness_Ratio,Reduction_Factor
      Close(21)

      If(Temp.Le.0.0d0)   Stop "Error Temperature !!!"
      If(Pdisp.Le.0.0d0)  Pdisp = 0.0d0
      If(Pvol.Le.0.0d0)   Pvol  = 0.0d0
      If(Pswap.Le.0.0d0)  Pswap = 0.0d0
      If(Deltax.Lt.0.0d0) Stop "Error Deltax !!"
      If(Deltav.Lt.0.0d0) Stop "Error Deltav !!"
      If(Deltal.Lt.0.0d0) Stop "Error Deltal !!"
      If(Ncycle.Lt.100)   Stop "Minimal 100 Cycles !!!"

C     Initialize Parameters
C     Wang-Landau Initialization, Modification Factor, Idummy: cycle counter
      If(LWL)Then
         Idummy=0
C     Set Wang-Landau Histogram to zero
         Call WL_Update(1,Flatness_Ratio,Reduction_Factor,Idummy)
C     Remove The Content Of The Old 'Fstep' File 
         Open(21, file='Fstep',Status='Unknown', iostat=ierr)
         If(ierr.Eq.0) Then
            Close(21,Status='Delete')
         EndIf
      EndIf
C     Truncate And Shift At 2.5 Sigma
      Beta       = 1.0d0/Temp
      Npbox(1)   = 0
      Npbox(2)   = 0

      Lambda = 0.5d0
      Rcutsq = (2.5d0)**2
      Ecut   = Rcutsq**3
      Ecut   = 1.0d0/Ecut
      Ecut   = 4.0d0*Ecut*(Ecut-1.0d0)

      Write(6,*) 'Ncycle               : ',Ncycle
      Write(6,*) 'Ninit                : ',Ninit
      Write(6,*) 'Linit                : ',Linit
      Write(6,*) 'Lweight              : ',Lweight
      Write(6,*) 'LWL                  : ',LWL
      Write(6,*) 'LIT                  : ',LIT
      Write(6,*) 'Temp                 : ',Temp
      Write(6,*) 'Deltax               : ',Deltax
      Write(6,*) 'Deltav               : ',Deltav
      Write(6,*) 'Deltal               : ',Deltal
      Write(6,*) 'F_Modification       : ',F_Modification
      Write(6,*) 'Flatness_Ratio       : ',Flatness_Ratio
      Write(6,*) 'Reduction_Factor     : ',Reduction_Factor
      
      Dummy = Pdisp + Pswap + Pvol
      Pdisp = Pdisp/Dummy
      Pswap = Pswap/Dummy
      Pvol  = Pvol/Dummy 

      Write(6,*) 'Pdisp                : ',Pdisp
      Write(6,*) 'Pswap                : ',Pswap
      Write(6,*) 'Pvol                 : ',Pvol
      
      Pswap = Pswap + Pvol
      
      If(Linit) Then
         Write(6,*)
         Write(6,*) 'Generate Initial Coordinates'
         Write(6,*)

         If(Npart.Le.0.Or.Npart.Gt.Maxpart) Stop "Error Npart !!!"
         If(Min(Box(1),Box(2)).Lt.5.0d0) Stop "Boxes Too Small !!!"

         Call Init

      Else
         Write(6,*)
         Write(6,*) 'Read Coordinates From Disk'
         Write(6,*)

         Open(21,File="Coordold",Status="Unknown")
         Read(21,*) Box(1),Box(2)
         Read(21,*) Npart
         

         If(Npart.Le.0.Or.Npart.Gt.Maxpart) Stop "Error Npart !!!"
         If(Min(Box(1),Box(2)).Lt.5.0d0) Stop "Boxes Too Small !!!"

         Do I=1,Npart
            Read(21,*) Rx(I),Ry(I),Rz(I),Ibox(I)
            
            Npbox(Ibox(I)) = Npbox(Ibox(I)) + 1
         Enddo
      Endif

      If(Lweight) Then
         Write(6,*)
         Write(6,*)
         Write(6,*) 'Read Weightfunction From Disk'
         Write(6,*)
         Write(6,*)

         Open(21,File="Weightold",Status="Unknown")
         Do J=1,Maxbl
            Read(21,*) K,Weight(1,J),Weight(2,J)
         Enddo
         Close(21)
      Else
         Write(6,*)
         Write(6,*)
         Write(6,*) 'Weightfunction Set To Zero'
         Write(6,*)
         Write(6,*)
      Endif
      
      Write(6,*) 'Box 1                : ',Box(1)
      Write(6,*) 'Box 2                : ',Box(2)
      Write(6,*) 'Npart                : ',Npart
      Write(6,*) 'Npbox 1              : ',Npbox(1)
      Write(6,*) 'Npbox 2              : ',Npbox(2)
      Write(6,*) 'Rho1                 : ',Dble(Npbox(1))/(Box(1)**3)
      Write(6,*) 'Rho2                 : ',Dble(Npbox(2))/(Box(2)**3)
      Write(6,*) 'Fractional In Box    : ',Ibox(Npart)

      If(Deltax.Gt.0.25d0*Min(Box(1),Box(2))) Stop "Deltax Too Large"
      If(Deltal.Gt.0.9d0) Stop "Deltalambda Too Large"

C     Compute Initial Energies

      Etotal(1) = 0.0d0
      Etotal(2) = 0.0d0
      
      Do I=1,2
         Call Etot(I,E)
         Etotal(I) = E
      Enddo

      Write(6,*)
      Write(6,*) 'Initial Energy Box 1 : ',Etotal(1)
      Write(6,*) 'Initial Energy Box 2 : ',Etotal(2)
      Write(6,*)

C     Start Of The Simulation

      Write(6,*)
      Write(6,*)
      Write(6,*) 'The Simulation Is Running.....'
      Write(6,*)
      Write(6,*)

      Open(22,File="Traject.xyz",Status="Unknown")
      Open(23,File="Results",Status="Unknown")
      
      If(LWL) Then
         Write(6,*)
         Write(6,*)'WARNING!!! Wang-Landau Is Being Used'
         Write(6,*)'Ensemble Averages Are Meaningless!!!'
         Write(6,*)
      EndIf

      Do Icycle=1,Ncycle
         
         Nmove = Max(20,Npart)

         Do Icycle2=1,Nmove

C     Select Trial Move At Random

            Rm = Ran_Uniform()
            
            If(Rm.Lt.Pvol) Then

C     Volume change

               Call Volume_Gibbs(Avv1,Avv2,Deltav)
               
            Elseif(Rm.Lt.Pswap) Then

C     Particle Swap
C     Now 3 Possibilities
C     Choose One At Random
               
               Rm2 = Ran_Uniform()
               
               If(Rm2.Lt.0.5d0) Then

C     Change The Value Of Lambda
C     Position And Box Unchanged
                  
                  Call Movelambda(Avl1,Avl2,Deltal)

               Elseif(Rm2.Lt.0.75d0) Then
                  
C     Attempt To Move The Fractional Molecule To The Other Box

                  Call Swap_Fractional(Avs1,Avs2)

               Else

C     Change The Fractional Molecule Into A Real One And Make
C     A Real Molecule In The Other Box The Fractional One

                  Call Change_Fractional(Avc1,Avc2)
                  
               Endif
               
            Else
               
C     Particle Displacement

               Call Move(Avd1,Avd2,Deltax)
               
            Endif
            
            If(Icycle.Gt.Ninit) Then
               
C     Sample The Probability Of Lambda 
               
               J = 1 + Int(Dble(Maxbl)*Lambda)
               If(J.Gt.Maxbl) Stop "Error Maxbl Mc !!!!"
               Problambda(Ibox(Npart),J)=Problambda(Ibox(Npart),J)+1.0d0
               Problambda2 = Problambda2 + 1.0d0
            Endif

            If(Ibox(Npart).Eq.1) Avbox1 = Avbox1 + 1.0d0
            Avbox2 = Avbox2 + 1.0d0
            
C     Call Wang-Landau Reweighting Subroutine
            If(LWL)Then
               Call WL_update(2,Flatness_Ratio,Reduction_Factor,Idummy)
            EndIf
         Enddo

C     Check For Flatness in Wang-Landau Scheme  
         If(LWL)Then
            Idummy=Icycle
            Call WL_update(3,Flatness_Ratio,Reduction_Factor,Idummy)
         Endif
         
C     Sample Other Stuff

         If(Icycle.Gt.Ninit) Then
            J = 1 + Int(Dble(Maxbl)*Lambda)
            If(J.Gt.Maxbl) Stop "Error Maxbl Mc !!!!"
            
            Myweight = Dexp(-Weight(Ibox(Npart),J))
            
            Av2 = Av2 + Myweight

C     Beware That Npbox Also Includes The Fractional Molecule

            If(J.Eq.Maxbl.And.Ibox(Npart).Eq.1)
     &           Av1(1) = Av1(1) + Myweight/Dble(Npbox(1))
            
            If(J.Eq.Maxbl.And.Ibox(Npart).Eq.2)
     &           Av1(2) = Av1(2) + Myweight/Dble(Npbox(2))
            
            If(J.Eq.1.And.Ibox(Npart).Eq.1)
     &           Av1(3) = Av1(3) + Myweight/(Box(1)**3)

            If(J.Eq.1.And.Ibox(Npart).Eq.2)
     &           Av1(4) = Av1(4) + Myweight/(Box(2)**3)

            If(Ibox(Npart).Eq.1) Then
               Av1(6) = Av1(6) + Myweight/Dble(Npbox(1))
               Av1(7) = Av1(7) + Myweight/(Box(1)**3)
            Endif

            If(Ibox(Npart).Eq.2) Then
               Av1(8) = Av1(8) + Myweight/Dble(Npbox(2))
               Av1(9) = Av1(9) + Myweight/(Box(2)**3)
            Endif
            
            Do J=1,2
               K = Npbox(J)
               If(Ibox(Npart).Eq.J) K=K-1
               Avdens(J,1) = Avdens(J,1) + Myweight*Etotal(J)
               Avdens(J,2) = Avdens(J,2) + Myweight*Dble(K)/(Box(J)**
     &              3)
               Avdens(J,3) = Avdens(J,3) + Myweight*(Box(J)**3)
               Avdens(J,4) = Avdens(J,4) + Myweight*Dble(K)
            Enddo
         Endif
         
         If (Mod(Icycle,1000).Eq.0) Then
            Write(23,'(5e20.10)') 
     &           Dble(Icycle),
     &           Dble(Npbox(1))/(Box(1)**3),
     &           Dble(Npbox(2))/(Box(2)**3),
     &           Etotal(1)/Max(0.5d0,Dble(Npbox(1))),
     &           Etotal(2)/Max(0.5d0,Dble(Npbox(2)))
         Endif
         
         If(Mod(Icycle,Ncycle/100).Eq.0) Then
            Write(22,*) Npart
            Write(22,*)
            
            Do J=1,Npart
               If(Ibox(J).Eq.2) Then
                  Dummy = 4.0d0*(Box(1) + 2.0d0)
               Else
                  Dummy = 0.0d0
               Endif

C     Give The Fractional Particle A Special Color In Vmd

               If(J.Eq.Npart) Then
                  Write(22,'(A,3f15.5)') 'Ne  ',4.0d0*Rx(J)+Dummy,4.0d0*
     &                 Ry(J),4.0d0*Rz(J)
               Else
                  Write(22,'(A,3f15.5)') 'Ar  ',4.0d0*Rx(J)+Dummy,4.0d0*
     &                 Ry(J),4.0d0*Rz(J)
               Endif
            Enddo
         Endif
      Enddo

      Close(22)
      Close(23)
      

      IF(LWL)THEN  

      Write(6,*)
      Write(6,*)'WARNING!!! Wang-Landau Is Being Used.'
      Write(6,*)'Ensemble Averages Are Meaningless!!!.'
      Write(6,*)

      ENDIF

      Write(6,*) 'Frac. Acc. Displ.    : ',Avd1/Max(0.5d0,Avd2)
      Write(6,*) 'Frac. Acc. Volume    : ',Avv1/Max(0.5d0,Avv2)
      Write(6,*) 'Frac. Acc. Lambda    : ',Avl1/Max(0.5d0,Avl2)
      Write(6,*) 'Frac. Acc. Change    : ',Avc1/Max(0.5d0,Avc2)
      Write(6,*) 'Frac. Acc. Swap      : ',Avs1/Max(0.5d0,Avs2)
C     Histogram of accepted moves

C     Write New Coordinates To Disk

      Open(21,File="Coordnew",Status="Unknown")
      Write(21,*) Box(1),Box(2)
      Write(21,*) Npart

      Do I=1,Npart
         Write(21,'(3e20.10,i5)') Rx(I),Ry(I),Rz(I),Ibox(I)
      Enddo
      Close(21)

C     Write The Acceptance Probability Of The Swap And Change Move 
C     Of The Fractional Particle To Disk

      Open(21,File="Pswapfractional",Status="Unknown")
      Do I=1,Maxbl
         Write(21,*) (Dble(I)-0.5d0)/Dble(Maxbl),
     &        Av_Swap(1,I,1)/Max(0.5d0,Av_Swap(1,I,2)),
     &        Av_Swap(2,I,1)/Max(0.5d0,Av_Swap(2,I,2))    
      Enddo
      Close(21)

      Open(21,File="Pchangefractional",Status="Unknown")
      Do I=1,Maxbl
         Write(21,*) (Dble(I)-0.5d0)/Dble(Maxbl),
     &        Av_Change(1,I,1)/Max(0.5d0,Av_Change(1,I,2)),
     &        Av_Change(2,I,1)/Max(0.5d0,Av_Change(2,I,2))
      Enddo
      Close(21)

      Open(21,File="Plambda1",Status="Unknown")
      Norm1 = 0.0d0
      Norm2 = 0.0d0

      Do I=1,Maxbl
         Norm1 = Norm1 + Problambda(1,I)
         Norm2 = Norm2 + Problambda(1,I)*Dexp(-Weight(1,I))
      Enddo
      
      Do I=1,Maxbl
         Write(21,'(3e30.15)') (Dble(I)-0.5d0)/Dble(Maxbl),
     &        Problambda(1,I)/Norm1,Dexp(-Weight(1,I))*Problambda(1,I
     &        )/Norm2
      Enddo
      Close(21)

      Open(21,File="Plambda2",Status="Unknown")
      Norm1 = 0.0d0
      Norm2 = 0.0d0

      Do I=1,Maxbl
         Norm1 = Norm1 + Problambda(2,I)
         Norm2 = Norm2 + Problambda(2,I)*Dexp(-Weight(2,I))
      Enddo
      
      Do I=1,Maxbl
         Write(21,'(3e30.15)') (Dble(I)-0.5d0)/Dble(Maxbl),
     &        Problambda(2,I)/Norm1,Dexp(-Weight(2,I))*Problambda(2,I
     &        )/Norm2
      Enddo
      Close(21)

C     Check Energy Calculation

      Do I=1,2
         Call Etot(I,E)
         
         Write(6,*)
         Write(6,*) 'Box                  : ',I
         Write(6,*) 'Particles            : ',Npbox(I)
         Write(6,*) 'Box                  : ',Box(I)
         Write(6,*) 'Volume               : ',Box(I)**3
         Write(6,*) 'Rho                  : ',Dble(Npbox(I))/(Box(I)*
     &        *3)
         Write(6,*) 'Energy               : ',E
         Write(6,*) 'Energy Sim.          : ',Etotal(I)
         Write(6,*) 'Diff                 : ',Dabs(Etotal(I)-E)
         Write(6,*)
      Enddo

      Write(6,*)
      Write(6,*)
      Write(6,*) 'Averages Box 1'
      Write(6,*)
      Write(6,*) '<E>                  : ',Avdens(1,1)/Av2
      Write(6,*) '<Rho>                : ',Avdens(1,2)/Av2
      Write(6,*) '<V>                  : ',Avdens(1,3)/Av2
      Write(6,*) '<N>                  : ',Avdens(1,4)/Av2
      Write(6,*)
      Write(6,*)
      Write(6,*) 'Averages Box 2'
      Write(6,*)
      Write(6,*) '<E>                  : ',Avdens(2,1)/Av2
      Write(6,*) '<Rho>                : ',Avdens(2,2)/Av2
      Write(6,*) '<V>                  : ',Avdens(2,3)/Av2
      Write(6,*) '<N>                  : ',Avdens(2,4)/Av2
      Write(6,*)
      Write(6,*)
      Write(6,*)
      Write(6,*)
      Write(6,*) 'Prob Box 1           : ',Avbox1/Avbox2
      Write(6,*)
      Write(6,*)
      
      Write(6,*) 'Aprox. Chem. Pot. 1  : ',
     &     -Dlog((Dexp(-Weight(1,Maxbl))*Problambda(1,Maxbl)+
     &     0.5d0*(Dexp(-Weight(1,Maxbl))*Problambda(1,Maxbl)-
     &     Dexp(-Weight(1,Maxbl-1))*Problambda(1,Maxbl-1)))/
     &     (Dexp(-Weight(1,1))*Problambda(1,1)))/Beta - Dlog(Av1(6)/A
     &     v1(7))/Beta
      
      Write(6,*) 'Aprox. Chem. Pot. 2  : ',
     &     -Dlog((Dexp(-Weight(2,Maxbl))*Problambda(2,Maxbl)+
     &     0.5d0*(Dexp(-Weight(2,Maxbl))*Problambda(2,Maxbl)-
     &     Dexp(-Weight(2,Maxbl-1))*Problambda(2,Maxbl-1)))/
     &     (Dexp(-Weight(2,1))*Problambda(2,1)))/Beta - Dlog(Av1(8)/
     &     Av1(9))/Beta

      Write(6,*)
      Write(6,*)
      
      Write(6,*) 'Excess 1             : ',
     &     -Dlog((Dexp(-Weight(1,Maxbl))*Problambda(1,Maxbl)+
     &     0.5d0*(Dexp(-Weight(1,Maxbl))*Problambda(1,Maxbl)-
     &     Dexp(-Weight(1,Maxbl-1))*Problambda(1,Maxbl-1)))/
     &     (Dexp(-Weight(1,1))*Problambda(1,1)))/Beta 
      
      Write(6,*) 'Excess 2             : ',
     &     -Dlog((Dexp(-Weight(2,Maxbl))*Problambda(2,Maxbl)+
     &     0.5d0*(Dexp(-Weight(2,Maxbl))*Problambda(2,Maxbl)-
     &     Dexp(-Weight(2,Maxbl-1))*Problambda(2,Maxbl-1)))/
     &     (Dexp(-Weight(2,1))*Problambda(2,1)))/Beta
      
      Write(6,*)
      Write(6,*)
      Write(6,*) 'Ig 1                 : ',-Dlog(Av1(6)/Av1(7))/Beta
      Write(6,*) 'Ig 2                 : ',-Dlog(Av1(8)/Av1(9))/Beta
      Write(6,*)
      Write(6,*)
      
C     EndIF
C     New Weight Function

      If(.NOT.LWL.AND. LIT) Then

         Do J=1,Maxbl
            Do K=1,2
               Weight(K,J) = Weight(K,J) -
     &              0.5d0*Dlog(Max(1.0d0,Problambda(K,J)))
            Enddo
         Enddo

         Dummy = Weight(1,1)

         Do J=1,Maxbl
            Do K=1,2
               Dummy = Min(Dummy,Weight(K,J))
            Enddo
         Enddo

         Do J=1,Maxbl
            Do K=1,2
               Weight(K,J) = Weight(K,J) - Dummy
            Enddo
         Enddo
         
         Open(21,File="Weightnew",Status="Unknown")
         Do J=1,Maxbl
            Write(21,*) J,Weight(1,J),Weight(2,J)
         Enddo
         Close(21)
      EndIf
      
      Dd(1) = 0
      Dd(2) = 0

      Do I=1,Npart
         Dd(Ibox(I)) = Dd(Ibox(I)) + 1
         If(Ibox(I).Ne.1.And.Ibox(I).Ne.2) Stop "Error Ibox !!!!"
      Enddo

      If(Dd(1).Ne.Npbox(1).Or.Dd(2).Ne.Npbox(2)) Then
         Write(6,*) 'Error Boxes Mc !!!!'
         Write(6,*) Dd(1),Npbox(1)
         Write(6,*) Dd(2),Npbox(2)
         Stop
      EndIf
      
      Stop
      End
