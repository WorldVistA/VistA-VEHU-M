A2APATC2 ;WASH/PEH - CHECK PATCH ROUTINE FINDER ;2/13/01  15:26
 ;;1.0;VERHLP;;
 ;This routine is used to lookup Package/Namespaced routines that
 ;have been patched. At entry 'P' it will retrieve routines for
 ;selected package. At 'A' it will retrieve all patched routines.
 ;
 Q
A D MESS S N=0 F  S N=$O(^DIC(1200036,N)) Q:N=""!(+N<0)  S NODE=$G(^DIC(1200036,N,0)) I NODE'="",$P(NODE,U,3)'="",$P(NODE,U,2)'="" S PACK=$P(NODE,U,3),CVER=+$P(NODE,U,2),PAC=$P(NODE,U) D PAC D:'$D(Q1) GET K Q1
 Q
 ;
P ;Lookup Package
 K CVER S DIC="^DIC(1200036,",DIC(0)="AEMQZ",DIC("A")="Select Package Name: " D ^DIC
 Q:Y=-1  S Q1="",CVER=+$P(Y(0),"^",2),PACK=$P(Y(0),"^",3),PACK1=$P(Y(0),"^",1)_"V"_$P(Y(0),"^",2) D PAC K:Q1=1 CVER
 Q
GET ;Retrieve patched routines
 I SEL="P" D MESS S PAC=$P(Y(0),"^")
 Q:PACK=""  S PAT=0 F  S PAT=$O(^A2AP(1200035,"AC",PACK,CVER,PAT)),DA=0 Q:PAT=""  F  S DA=$O(^A2AP(1200035,"AC",PACK,CVER,PAT,DA)) Q:DA=""  D  ;
 .Q:'$D(^A2AP(1200035,DA))  S ROU="" F  S ROU=$O(^A2AP(1200035,DA,"P","B",ROU)) Q:ROU=""  S ^TMP($J,PAC,ROU)=CVER_"^"_PACK
 Q
MESS ;Message for getting routines
 W !!,"Please hold on... I'm collecting all ",$S(SEL="R":"selected",1:"patched")," routines" W !!,"PACKAGE ERRORS ------------" Q
PAC ; CHECK THE EXISTENCE OF A PACKAGE
 I '$D(^DIC(9.4,"C",PACK)) W !,"PACKAGE FILE SHOWS THAT  " W:SEL="A" PAC W:SEL="M" PACK1 W " IS NOT LOADED"  S Q1=1  Q
 S PK=$O(^DIC(9.4,"C",PACK,0)) I '$D(^DIC(9.4,PK,"VERSION"))  W !!,"THE PACKAGE '" W:SEL="A" PAC W:SEL="P" PACK1 W "' IS NULL IN YOUR PACKAGE FILE 'CUR VER IS:",CVER S Q1=1 Q
 I +^DIC(9.4,PK,"VERSION")'=+CVER W !!,"THE PKG '" W:SEL="A" PAC W:SEL="P" PACK1 W "' IS NOT CURRENT IN YOUR PACKAGE FILE(",^DIC(9.4,PK,"VERSION"),")"," CUR VER IS:",CVER S Q1=1 Q
 Q
