PRCATA3 ; ;03/11/23
 S X=DG(DQ),DIC=DIE
 S ^PRCA(430,"AC",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I $P(^PRCA(430,DA,0),"^",9) S ^PRCA(430,"AS",$P(^PRCA(430,DA,0),"^",9),X,DA)=""
 S X=DG(DQ),DIC=DIE
 X ^DD(430,8,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^PRCA(430,D0,6)):^(6),1:"") S X=$P(Y(1),U,21),X=X S DIU=X K Y S X=DIV D NOW^%DTC S X=% X ^DD(430,8,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^PRCA(430,D0,0)):^(0),1:"") S X=$P(Y(1),U,14),X=X S DIU=X K Y S X=DIV S X=DT X ^DD(430,8,1,4,1.4)
 S X=DG(DQ),DIC=DIE
 I $P(^PRCA(430,DA,0),U,14) S ^PRCA(430,"ASDT",X,$P($P(^PRCA(430,DA,0),U,14),"."),DA)=""
 S X=DG(DQ),DIC=DIE
 I X=16,+$P($G(^PRCA(430,+DA,0)),"^",10) S ^PRCA(430,"AJK1",$P(^PRCA(430,+DA,0),"^",10),DA)=""
