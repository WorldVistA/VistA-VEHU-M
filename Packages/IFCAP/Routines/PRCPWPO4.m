PRCPWPO4 ;WISC/RFJ-end of posting; final? ;17 July 91
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
CHECKFIN ;     |-> check on final
 I '$D(PRCPDT) D NOW^%DTC S PRCPDT=%
 I PRCPFINL D
 .   W ! I $G(PRIMORD) W !,"***** DECREMENTING DUE-INS AT THE PRIMARY",?67,"*****"
 .   W !,"***** DECREMENTING DUE-OUTS AT THE WAREHOUSE",?67,"*****"
 .   I '$D(^PRCS(410,PRCPDA,0)) Q
 .   S $P(^PRCS(410,PRCPDA,9),"^",3)=$P(PRCPDT,".",1),$P(^PRCS(410,PRCPDA,10),"^",4)=$O(^PRCD(442.3,"C",40,0))
 .   F LINEDA=0:0 S LINEDA=$O(^PRCS(410,PRCPDA,"IT",LINEDA)) Q:'LINEDA  S PRCPITEM=+$P(^(LINEDA,0),"^",5),PRCPQTY=$P(^(0),"^",2)-$P(^(0),"^",12) S:PRCPQTY<0 PRCPQTY=0 D
 .   .   I $D(^PRCP(445,PRCP("I"),1,PRCPITEM,0)) S Y=$P(^(0),"^",20)-PRCPQTY S:Y<0 Y=0 S $P(^(0),"^",20)=Y
 .   .   I $G(PRIMORD) D KILLTRAN^PRCPUTRA(PRCPSRC1,PRCPITEM,PRCPDA)
 .   W !,"***** REMOVING 2237 FROM REQUEST WORKSHEET FILE",?67,"*****"
 .   S DIK="^PRC(443,",DA=PRCPDA D ^DIK K DIK
 Q:PRCPREPT=1!(PRCPREPT=2)  S PRCPREPT(1)="AFTER POSTING" S PRCPREPT=3 D:'$D(IO("Q"))&(IO=IO(0)) R^PRCPU4 D QUE^PRCPWPOR Q
 ;
 ;
FINALASK ;     |-> final posting
 S XP="Is this the FINAL receipt to be posted for this request (i.e. you will not be",XP(1)="able to distribute any more items on this request).",XP(2)="FINAL REQUEST",%=2
 S XH="Enter 'YES' to make this a FINAL receipt, 'NO' or '^' to retain for later",XH(1)="distribution.  If you answer 'YES', you will have to delete the Date Distributed",XH(2)="before posting the outstanding items." W ! D YN^PRCPU4
 S PRCPFINL=$S(%=1:1,1:0) Q
