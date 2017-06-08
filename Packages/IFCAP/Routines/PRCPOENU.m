PRCPOENU ;WISC/RFJ-distribution order utility routine ;19 Oct 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
NEWORDER(V1) ;     |-> get next new order number
 ;     |-> v1 = primary inventory point
 ;     |-> called from 445.3,.01 input transform when entering 'new'.
 I '$D(^PRCP(445,+V1,0)) K X Q
 N END,FLAG,Z
 L +^PRCP(445.3,"ANXT",V1)
 S (END,X)=+$G(^PRCP(445.3,"ANXT",V1))
 F  S X=X+1 Q:X=END  S:X>999999 X=1 Q:'$D(^PRCP(445.3,"B",X))  D  Q:'$G(FLAG)
 .   K FLAG S Z=0 F  S Z=$O(^PRCP(445.3,"B",X,Z)) Q:'Z  I $D(^PRCP(445.3,"AC",V1,Z)) S FLAG=1 Q
 S ^PRCP(445.3,"ANXT",V1)=X L -^PRCP(445.3,"ANXT",V1)
 I X=END W !!?10,"YOU NEED TO DELETE SOME OF THE OLD ORDERS FIRST!" K X
 Q
 ;
 ;
LOCK(V1) ;     |-> lock order number v1 and inventory points
 ;     |-> return prcpflag if not successful
 I '$D(^PRCP(445.3,+V1,0)) S PRCPFLAG=1 Q
 N D,ORDERNO,PDA,SDA
 S ORDERNO=+V1,D=$G(^PRCP(445.3,ORDERNO,0)),PDA=+$P(D,"^",2),SDA=+$P(D,"^",3)
 W !!,"<*> Locking Distribution Order..." L +^PRCP(445.3,ORDERNO):5 I '$T W !,?5,"ANOTHER USER IS WORKING WITH THIS DISTRIBUTION ORDER." S PRCPFLAG=1 Q
 W !,"<*> Locking Primary   Inventory Point '",$$INVNAME^PRCPUX1(PDA),"'..." L +^PRCP(445,PDA,1):5 I '$T W !?5,"ANOTHER USER IS WORKING WITH THE PRIMARY INVENTORY POINT." S PRCPFLAG=1 D UNLOCK(ORDERNO,0,0) Q
 W !,"<*> Locking Secondary Inventory Point '",$$INVNAME^PRCPUX1(SDA),"'..." L +^PRCP(445,SDA,1):5 I '$T W !?5,"ANOTHER USER IS WORKING WITH THE SECONDARY INVENTORY POINT." S PRCPFLAG=1 D UNLOCK(ORDERNO,PDA,0) Q
 Q
 ;
 ;
UNLOCK(V1,V2,V3) ;     |-> unlock distribution order v1 and inventory points
 L -^PRCP(445.3,+V1),-^PRCP(445,+V2,1),-^PRCP(445,+V3,1)
 Q
