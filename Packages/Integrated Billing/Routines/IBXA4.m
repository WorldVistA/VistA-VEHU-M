IBXA4 ; COMPILED XREF FOR FILE #350 ; 03/23/98
 ; 
 S X=$P(DIKZ(0),U,16)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",5)=1,$P($G(^IBE(350.1,+$P(^(0),"^",3),0)),"^")'["ADMISSION" S ^IB("ACT",X,DA)=""
 S X=$P(DIKZ(0),U,17)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",2) S ^IB("AFDT",$P(^(0),"^",2),-X,DA)=""
 S DIKZ(1)=$G(^IB(DA,1))
 S X=$P(DIKZ(1),U,2)
 I X'="" S ^IB("D",$E(X,1,30),DA)=""
 S X=$P(DIKZ(1),U,2)
 I X'="" I $P(^IB(DA,0),"^",9) S ^IB("APDT",$P(^(0),"^",9),-X,DA)=""
 S X=$P(DIKZ(1),U,2)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",2) S ^IB("APTDT",$P(^(0),"^",2),X,DA)=""
 S X=$P(DIKZ(1),U,5)
 I X'="" I X,$D(^IB(DA,0)),$P(^(0),"^",2) S ^IB("ACVA",$P(^(0),"^",2),X,DA)=""
 S X=$P(DIKZ(1),U,6)
 I X'="" I $D(^IB(DA,1)),$P(^IB(DA,1),U,6) S ^IB("AHDT",+$P(^IB(DA,0),U,2),+$P(^IB(DA,0),U,5),X,DA)=""
END Q
