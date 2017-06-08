DGPMX11 ; ;12/05/12
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPM(D0,0)):^(0),1:"") S X=$P(Y(1),U,18),X=X S DIU=X K Y S X=DIV S X=$S($D(^DG(405.1,X,0)):$P(^(0),"^",3),1:"") X ^DD(405,.04,1,1,1.4)
