PRCPEPSU ;WISC/RFJ-procurement source update utilities ;1 Oct 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
SETMAN(V1,V2,V3) ;     |-> set mandatory source for inventory point
 ;     |-> v1, item v2, and source v3.
 I '$D(^PRCP(445,+V1,1,+V2,0)) Q
 N %,VENOLD,VENNEW
 S %=$P(^PRCP(445,+V1,1,+V2,0),"^",12),VENOLD=$S(%="":"<<NOT DEFINED>>",%["PRC(440":$P($G(^PRC(440,+%,0)),"^"),1:$P($G(^PRCP(445,+%,0)),"^")) S:VENOLD="" VENOLD="<<NOT FOUND>>"
 S VENNEW=$S(V3="":"<<NOT DEFINED>>",V3["PRC(440":$P($G(^PRC(440,+V3,0)),"^"),1:$P($G(^PRCP(445,+V3,0)),"^")) S:VENNEW="" VENNEW="<<NOT FOUND>>"
 I %=V3 W !!?5,"MANDATORY SOURCE (for inventory point item): ",VENOLD Q
 W !!?5,"...inventory point item mandatory source being changed",!?8,"from: ",VENOLD,!?8,"  to: ",VENNEW
 K:%'="" ^PRCP(445,V1,1,"AC",%,V2) S $P(^PRCP(445,V1,1,V2,0),"^",12)=V3 S:V3'="" ^PRCP(445,V1,1,"AC",V3,V2)=""
 Q
 ;
 ;
SOURCES(V1,V2) ;     |-> main edit program for enter/edit inv item
 ;     |-> v1=invpt, v2=item
 N INVPT,ITEMDA
 S INVPT=+V1,ITEMDA=+V2 I '$D(^PRCP(445,INVPT,1,ITEMDA,0)) Q
 D SOURCES^PRCPEPS(INVPT,ITEMDA)
 W !!?25,"*----------------------------*",!,"You will now have the option to override the changes I made, be careful though!",!?25,"*----------------------------*",!
 D EDITSOUR(INVPT,ITEMDA)
 Q
 ;
 ;
EDITSOUR(V1,V2) ;     |-> edit procurement sources for invpt v1, item v2
 I '$D(^PRCP(445,+V1,1,+V2)) Q
 N %,D,D0,D1,DA,PRCPPRIV,DD,DI,DIC,DIE,DIX,DIY,D0,DQ,DR,X,Y
 S:'$D(^PRCP(445,V1,1,V2,5,0)) ^(0)="^445.07I^^"
 S (DIC,DIE)="^PRCP(445,"_V1_",1,",DA(1)=V1,DA=V2,DR=".6;.4" D ^DIE
 Q
 ;
 ;
UPDATE(V1,V2) ;     |-> update the unit per receipt = unit per issue
 ;     |-> for all inventory points stocked by invpt v1
 I '$D(^PRCP(445,+V1,1,+V2,0)) Q
 N %,D,INVPT,INVPTDA,INVPTNM,ITEMDA,SOURCE,TYPE,UI,UNITS
 S INVPT=+V1,ITEMDA=+V2,UI=$$UNIT^PRCPUX1(INVPT,ITEMDA," per ") I UI["?" Q
 S INVPTNM=$$INVNAME^PRCPUX1(INVPT),TYPE=$P(^PRCP(445,INVPT,0),"^",3),D=^PRCP(445,INVPT,1,ITEMDA,0),UNITS=$P(D,"^",5)_"^"_$P(D,"^",14)
 I TYPE="S" Q
 S XP="  Do you want to update the UNIT per RECEIPT (equal to the UNIT PER ISSUE) for",XP(1)="  ALL distribution points stocked by "_INVPTNM
 S XH="  Enter 'YES' to loop through ALL the distribution points changing the receipt",XH(1)="  units equal to the issue units for the "_$E(INVPTNM,1,25)_" procurement",XH(2)="  source."
 S %=1 D YN^PRCPU4 I %'=1 Q
 W !!,"updating the u/r equal to u/i ***PLEASE CHECK CONVERSION FACTORS***"
 S SOURCE=INVPT_";PRCP(445,"
 I TYPE="W" S SOURCE=$O(^PRC(440,"AC","S",0))_";PRC(440," I 'SOURCE W !,"THERE IS NOT A VENDOR DEFINED AS SUPPLY WAREHOUSE IN THE VENDOR FILE." Q
 S INVPTDA=0 F  S INVPTDA=$O(^PRCP(445,INVPTDA)) Q:'INVPTDA  I $D(^PRCP(445,INVPTDA,1,ITEMDA,0)) S D=$$GETVEN^PRCPUVEN(INVPTDA,ITEMDA,SOURCE,1) I $P(D,"^",5) D
 .   I $P(D,"^",2,3)=UNITS Q
 .   W !,$E($$INVNAME^PRCPUX1(INVPTDA),1,17),?19,"OLD U/R: ",$$UNITVAL^PRCPUX1($P(D,"^",3),$P(D,"^",2)," per "),?44,"NEW U/R: ",UI,?69,"CF: ",$P(D,"^",4)
 .   S $P(D,"^",2,3)=UNITS,^PRCP(445,INVPTDA,1,ITEMDA,5,$P(D,"^",5),0)=D
 Q
