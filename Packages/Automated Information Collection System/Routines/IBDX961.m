IBDX961 ; ;05/04/04
 S X=DG(DQ),DIC=DIE
 S ^IBD(357.96,"AN",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S:+$P(^IBD(357.96,DA,0),"^",3)'="" ^IBD(357.96,"ADATNA",$P(^IBD(357.96,DA,0),"^",3),X,DA)=""
