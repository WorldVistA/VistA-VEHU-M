PRMQWE7 ;Chicago ISC/DDA- PRMQ EDIT 7 ;5/25/90  11:53
 ;;1.2;Utilization Review;;
EN1 ; ENTRY POINT FOR OPTION PRMQ EDIT 7, LOS INSURANCE REVIEW
 W !! S DIC="^PRMQ(513.8,",DIC(0)="AELMNQZ",DLAYGO=513.8 D ^DIC K DIC,DLAYGO G:Y=-1 EXIT
 S D0=+Y D ENLOOK^PRMQW G:PRMQDATE="^"!(PRMQDATE="") XIT
 I $P(PRMQDATE,"^",5)="" S VAIP("E")=$P(PRMQDATE,"^",6) D IN5^VADPT S $P(PRMQDATE,"^",5)=VAIP(13) K VAIP,VAERR
 I $P(PRMQDATE,"^",4)="*" S (PRMQOUT,PRMQD1)=0 F PRMQI=0:0 S PRMQD1=$O(^PRMQ(513.8,PRMQD0,1,"B",$P(PRMQDATE,"^",2),PRMQD1)) Q:PRMQD1'>0  D EN1I Q:PRMQOUT=1
 I $P(PRMQDATE,"^",4)'="*" S DIE="^PRMQ(513.8,",DA=PRMQD0,DR="2///^S X=$P(PRMQDATE,""^"")",DR(2,513.801)=".01;S PRMQD1=DA" D ^DIE K DA,DIE,DR,DIDEL
 I PRMQD1'>0 W !!,"ERROR IN UR RECORD: IEN=",D0,"  DATE: ",$P(PRMQDATE,"^"),! G XIT
 S DIE="^PRMQ(513.8,"_PRMQD0_",1,",(DA,D1)=PRMQD1,DA(1)=PRMQD0,DIDEL=513.801
 S DR="10;9.5"
 S DR(2,513.804)="1///^S X=DUZ;1.51;S:+X<1 Y=""@1"";1.52;1.53;S Y=""@2"";@1;1.52///@;1.53///@;@2;1.61//^S X=""NOT APPLICABLE"";S:X=1 Y=""@4"";1.62///@;S Y=""@5"";@4;1.62;@5;1.63;1.64//^S X=""NO"";1.71//^S X=""NO"";S:X=1 Y=""@5"""
 S DR(2,513.804,1)="1.72///@;1.73///@;S Y=""@6"";@5;1.72//^S X=""YES"";1.73//^S X=""NO"";@6;1.74;2"
 D ^DIE K DA,DIE,DR,DIDEL
XIT D EXIT G EN1
 Q
EN1I S PRMQ(.2)=$P(^PRMQ(513.8,D0,1,PRMQD1,7),"^",4),PRMQ("D.2")=$E($P(PRMQDATE,"^",3),1),PRMQOUT=$S(PRMQ(.2)=1&(PRMQ("D.2")="T"):1,PRMQ(.2)=2&(PRMQ("D.2")="A"):1,PRMQ(.2)=""&(PRMQ("D.2")="A"):1,1:0)
 Q
EXIT ; KILL VARIABLES
 K %,%DT,%T,%W,%X,%Y,C,D0,D1,DFN,DI,DA,DIE,DR,DIDEL,DQ,I,J,PRMQDATE,PRMQDFN,PRMQ,PRMQD0,PRMQD1,PRMQE,PRMQX,PRMQXF,PRMQOUT,PRMQI,PRMQPOST,PRMQPRE,PRMQSUR,PRMQDIS,PRMQADTT,PRMQINAP,PRMQPLOS,PRMQTOT,X,Y
 Q
