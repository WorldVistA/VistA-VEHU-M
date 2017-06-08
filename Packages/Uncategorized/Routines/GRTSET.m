GRTSET ;CREATES ^%Q FOR GRT ROUTINES  ; 01 FEB 85  9:59 AM
 F I=1:1 S X=$T(Q+I) Q:X=""  S Y=$P(X,"=",2,99),X=$P($E(X,3,99),"=",1) S @X=Y
Q Q
 ;^%Q(1)=F %A=0:1 D @QUES W %YN,%QMK,"   " W:DEF'="" "<",DEF W ">   " R ANS,! X:ANS="?" ^(2) I ANS'="?" S %A=ANS="^" Q:%A  S:ANS="" ANS=DEF Q:%YN=""  S ANS=$E(ANS,1) Q:"YN"[ANS  W !,"Enter Y or N"
 ;^%Q(2)=ZL:QUES["^" @$P(QUES,"^",2) D:$L($T(@($P(QUES,"^")_"H"))) @($P(QUES,"^")_"H")
 ;^%Q("ASKN")=S %QMK=" ?",%YN=" [Y OR N]",DEF="N" X ^(1)
 ;^%Q("ASKY")=S %QMK=" ?",%YN=" [Y OR N]",DEF="Y" X ^(1)
 ;^%Q("ASKYN")=S %QMK=" ?",%YN=" [Y OR N]" X ^(1)
 ;^%Q("EN")=S %QMK="",%YN="" X ^(1)
 ;^%Q("SGCNV")=S %A=ANS,ANS="" F %I=1:1:$L(%A) S ANS=ANS_$E(%A,%I) I $A(%A,%I)>96,$A(%A,%I)<123 S ANS=$E(ANS,1,$L(ANS)-1)_$C($A(%A,%I)-32)
