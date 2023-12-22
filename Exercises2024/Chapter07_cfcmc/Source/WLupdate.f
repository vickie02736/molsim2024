      Subroutine  WL_update(IC_WL,Flatness_Ratio,Reduction_Factor,
     &     Idummy)
      Implicit None

      Include 'commons.inc'

      Integer J, I, m, k, IC_WL, Idummy,Idummy2, Nflat_acc 
      Double Precision H(2,Maxbl), Min_H , Max_H, Ave_H, Diff_H, Min_W,
     $    Flatness_Ratio,Reduction_Factor, H_norm1, H_norm2
      Save H, Idummy2,Nflat_acc

      If(F_Modification.Lt.1.0D-6) Then
         Write(6,*)
         Write(6,*)'Modification Factor Below The Allowed Limit'
         Write(6,*)'Final Accepted F= ',Reduction_Factor*F_Modification
         Write(6,*)'End of Wang-Landau Algorithm'
         Write(6,*)
         Stop
      EndIf

C     IC=1 Set Histogram to Zero & Initialize Flatness Acceptance Counter and Icycle Counter Idummy 
      
      If(IC_WL.Eq.1) Then
         Do m=1,Maxbl
            Do k=1,2
               H(k,m)=0.0d0
            Enddo
         Enddo
         
         Nflat_acc=1
         Idummy2=0
                
C     IC=2 Update Weight Function and Histogram
         
      ElseIf(IC_WL.Eq.2) Then
         J = 1 + Int(Dble(Maxbl)*Lambda)
         If(J.Gt.Maxbl) Stop "Error Maxbl Mc !!!!"

         Weight(Ibox(Npart),J)= Weight(Ibox(Npart),J)-F_Modification
         H(Ibox(Npart),J)= H(Ibox(Npart),J)+1.0d0
         
C     IC=3 Check for Flatness
         
      ElseIf(IC_WL.Eq.3) Then
         Min_H=H(1,1)
         Max_H=H(1,1)
         Ave_H=0.0d0
          
         Do m=1,Maxbl
            Do k=1,2 
               Min_H=Min(Min_H,H(k,m))
               Max_H=Max(Max_H,H(k,m))
               Ave_H=Ave_H+H(k,m)
            Enddo
         Enddo
          
         Ave_H=Ave_H/(2.0d0*Dble(Maxbl))
         Diff_H=ABS(Max_H-Min_H)
          
C     If Flat, Then Write New Weight to file AND Set the Minimun of The  Weight Function to Zero
          
         If(Diff_H.Lt.(Flatness_Ratio*Ave_H))Then
            Min_W=Weight(1,1)
            Do m=1,Maxbl
               Do k=1,2
                  Min_W=Min(Min_W,Weight(k,m))
               Enddo
            Enddo
             
            Do m=1,Maxbl
               Do k=1,2
                  Weight(k,m)=Weight(k,m)-Min_W
               Enddo
            Enddo
             
C     Nflat_acc Is Used To Suquence The File Names Chronologically

            Open(21,file="Weightnew.WL."//Char(48+(Nflat_acc-mod(
     &           Nflat_acc,100))/100)//Char(48+(Nflat_acc-(Nflat_acc-mo
     &           d(Nflat_acc,100))-mod(Nflat_acc,10))/10)//Char(48+mod
     &           (Nflat_acc,10)),Status="Unknown")
             
            Do m=1,Maxbl
               Write(21,*) m,Weight(1,m),Weight(2,m)
            Enddo
            close(21)
             
C     Write Icycle Steps After Each Update, The Number of States Between The Updates & F  
             
            Open(21,file="Fstep",Status="Unknown", position="append",
     &           action="Write")
 100        FORMAT(' ',I10,I10,E20.5,E20.5,E20.5)
            Write(21,100) Idummy,Idummy-Idummy2,F_Modification,
     &                 Flatness_Ratio,Reduction_Factor
            Close(21)
            Idummy2=Idummy
             
C     Normalize And Write Histogram To File 
             
            H_Norm1=0.0d0
            H_Norm2=0.0d0
            Do m=1,Maxbl
               H_Norm1=H_Norm1+H(1,m)
               H_Norm2=H_Norm2+H(2,m)
            Enddo

            Open(21,file="H1.WL."//Char(48+(Nflat_acc-mod(Nflat_acc,
     &           100))/100)//Char(48+(Nflat_acc-(Nflat_acc-mod(Nflat_ac
     &           c,100))-mod(Nflat_acc,10))/10)//Char(48+mod(Nflat_acc,
     &           10)),Status="Unknown")
            Do I=1,Maxbl
               Write(21,'(2e30.15)') (Dble(I)-0.5d0)/Dble(Maxbl),
     &              H(1,I)/H_Norm1
            Enddo
            close(21)

             
            Open(21,file="H2.WL."//Char(48+(Nflat_acc-mod(Nflat_acc,
     &           100))/100)//Char(48+(Nflat_acc-(Nflat_acc-mod(Nflat_ac
     &           c,100))-mod(Nflat_acc,10))/10)//Char(48+mod(Nflat_acc,
     &           10)),Status="Unknown")
            Do I=1,Maxbl
               Write(21,'(2e30.15)') (Dble(I)-0.5d0)/Dble(Maxbl),
     &              H(2,I)/H_Norm2
            Enddo
            close(21)
            
C     Reduce Modification Factor F AND Set Histogram to Zero
            
            Nflat_acc=Nflat_acc+1
            F_Modification=F_Modification/Reduction_Factor
             
            Do m=1,Maxbl
               Do k=1,2
                  H(k,m)=0.0d0
               Enddo
            Enddo
         EndIf
      Else
         
         Write(6,*)'Wrong Value Of IC_WL!'

      Endif
	  
      Return
      End

