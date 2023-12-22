      Function Selectint(J)
      Implicit None

C     Select A Random Number From The Range 1 To J
      
      Integer Selectint,J
      Double Precision Ran_Uniform

C     Avoid Numerical Roundoff Errors That Cause A Number Larger Than J
      
 1    Continue
      Selectint = 1 + Int(Dble(J)*Ran_Uniform())
      If (Selectint.Gt.J) Goto 1

      Return
      End
