      Subroutine Mdloop
      Implicit None
 
      Include 'system.inc'

      Integer I,J,CycleMultiplication
      Double Precision Cstart,Cc1,Cc2,Tt1,Tt2

      Parameter (CycleMultiplication=1000)

      Cc1    = 0.0d0
      Cc2    = 0.0d0
      Cstart = 0.0d0
      Tt1    = 0.0d0
      Tt2    = 0.0d0
 
      Call Sample_Diff(1)
      Call Sample_Prof(1)

      Write(6,*)
      Write(6,*) '   Conserved           Temp'
      Write(6,*)

      Do I = 1,Nstep
         Do J=1,CycleMultiplication

            If(Choice.Eq.1) Then
               Call Integrate_Nve
            Elseif(Choice.Eq.2) Then
               Call Integrate_And
            Elseif(Choice.Eq.3) Then
               Call Integrate_Res
            Elseif(choice.eq.4) Then
               Call Integrate_Mc

c     possibility to use the Berendsen thermostat
            Else
               Call Integrate_ber
            Endif

            If(I.Gt.Ninit) Then
               Call Sample_Diff(2)
               Call Sample_Prof(2)

               Tt1 = Tt1 + Vpos*Vpos
               Tt2 = Tt2 + 1.0d0

               If(Mod(J,200).Eq.0) Write(22,*) Xpos,Vpos
               If(Mod(I,10).Eq.0.And.J.Eq.1) Write(6,'(2e20.10)')  
     &              Cons,Vpos*Vpos
                  
               Endif

            If(I.Eq.Ninit) Then
               Cstart = Cons
            Elseif(I.Gt.Ninit) Then
               If(Choice.Ne.2.And.Choice.Ne.4) 
     &              Cc1 = Cc1 + Dabs((Cons-Cstart)/Cstart)
               Cc2 = Cc2 + 1.0d0
            Endif
         Enddo
      Enddo

      Call Sample_Diff(3)
      Call Sample_Prof(3)

      Write (6,*)
      Write (6,*) 'Energy Drift          : ',Cc1/Cc2
      Write (6,*) 'Average Temp.         : ',Tt1/Tt2

      Return
      End
