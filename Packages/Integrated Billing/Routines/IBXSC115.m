IBXSC115 ; ;08/28/09
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.12105,1,7,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.121)):^(.121),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X="" X ^DD(2,.12105,1,7,1.4)
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.12105,1,8,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.121)):^(.121),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" X ^DD(2,.12105,1,8,1.4)
