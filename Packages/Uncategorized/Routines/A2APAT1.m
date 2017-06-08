A2APAT1 ;WASH/PEH - CHECK PATCH ROUTINE FINDER ;2/10/93  15:50
 ;;1.0;VERHLP;;
 ;This routine is used to lookup Package/Namespaced routines that
 ;have been patched. At entry 'P' it will retrieve routines for
 ;selected package. At 'A' it will retrieve all patched routines.
 ;
 Q
A D MESS S N=0 F  S N=$O(^DIC(1200036,N)) Q:N=""!(+N<0)  S NODE=$G(^DIC(1200036,N,0)) I NODE'="",$P(NODE,"^",3)'="",$P(NODE,"^",2)'="" S PACK=$P(NODE,"^",3),CVER=+$P(NODE,"^",2) D GET
 Q
 ;
P ;Lookup Package
 S DIC="^DIC(1200036,",DIC(0)="AEMQZ",DIC("A")="Select Package Name: " D ^DIC
 Q:Y=-1  S CVER=+$P(Y(0),"^",2),PACK=$P(Y(0),"^",3)
 Q
GET ;Retrieve patched routines
 D:SEL="P" MESS
 Q:PACK=""  S PAT=0 F  S PAT=$O(^A2AP(1200035,"AC",PACK,CVER,PAT)),DA=0 Q:PAT=""  F  S DA=$O(^A2AP(1200035,"AC",PACK,CVER,PAT,DA)) Q:DA=""  D  ;
 .Q:'$D(^A2AP(1200035,DA))  S ROU="" F  S ROU=$O(^A2AP(1200035,DA,"P","B",ROU)) Q:ROU=""  S ^TMP($J,ROU)=CVER
 Q
MESS ;Message for getting routines
 W !!,"Please hold on... I'm collecting all patched routines" Q
