ATSHECTR ;WVAMC/HAG-TERMINATE USERS THAT HAVE NOT SIGNED ON OVER 120 DAYS;1/12/95  15:09 ;1/3/96  09:03
VERSION ;
B S DD=$T(+0) D DT^DICRW S X1=DT,X2=-120 D C^%DTC S OV120=X,OV120D=$E(X,2,7),Y=DT X ^DD("DD") S DTT=Y I $D(^TMP(DD)) K:$P(^TMP(DD),U,4)<DT ^TMP(DD)
 S %ZIS="MQ" K IO("Q") D ^%ZIS G:IO="" EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="Q^ATSHECTR" F A="OV120","OV120D","DD","DTT" S ZTSAVE(A)=""
 . D ^%ZTLOAD
 ;D:'$D(^TMP(DD)) WAIT^DICD
Q U IO S A="",(HLD,PRIM,PAG)=0 I '$D(^TMP(DD)) D BLDGBL S TERMFLG=""
 F  S A=$O(^TMP(DD,A)) Q:A=""!(HLD[U)  S B="" F  S B=$O(^TMP(DD,A,B)) Q:B=""!(HLD[U)  S NODE=^VA(200,B,0),NODE2="" S:$D(^VA(200,B,1)) NODE2=^(1) S DATENT=$P(NODE2,U,7) D DELRPT
TOTAL D:$D(PRIM) HDR
 I HLD'[U D
 . W !!,"OVER 120 DAYS ",$J($P(^TMP(DD),U,2),4),!,"NOT SIGN ON   ",$J($P(^TMP(DD),U),4),!,"------------------",!,"TOTAL:      ",$J($P(^TMP(DD),U,3),6)
 I HLD'[U D:$D(TERMFLG)!($D(^TMP(DD)))
 . I $P(^TMP(DD),U,5)'="DONE" D TERM W !!,"Done, user(s) have been terminated!" Q
 . W !!,"User(s) have been terminated earlier in the day!"
EXIT D ^%ZISC K A,A1,CNT,DATENT,DD,DTT,HLD,J,LSTSGN,LV,NODE,OV120,OV120D,OVRCNT,PAG,PT,TERM,TERMFLG
 Q
DELRPT I IOSL-($Y#IOSL)<4 D:IOST["C-"  Q:HLD[U  D HDR
 . K HLD R !!,"Press enter to continue or '^' to exit. ",HLD:DTIME
 S LSTSGN="" I $D(^VA(200,B,1.1)),$P(^(1.1),U)'="" S LSTSGN=$E($P(^(1.1),U),2,7)
 S LV="" I $D(^VA(200,B,.1)),$P(^(.1),U)'="",$P(^(.1),U)["," S %H=$P(^(.1),U) D YMD^%DTC S LV=$E(X,2,7)
 D:$D(PRIM) HDR
 W !,B W:A["*" ?7,"*"
 W ?7,$E($P(NODE,U),1,20),?28,$P(NODE2,U,9),?38,$E(DATENT,2,7),?45,LV,?52,LSTSGN D
 . I $D(^VA(200,B,5)) S PT=$P(^(5),U) D:PT'=""  Q
 . . ;I $P(^DIC(49,PT,0),U,2)'="" W ?59,$P(^(0),U,2) Q
 . . W ?59,$E($P(^DIC(49,PT,0),U),1,21)
 Q
HDR S PAG=PAG+1,A1=$P(^XMB(1,1,0),U) I $D(^DIC(4.2,A1,0)) S A1=$P(^(0),U)
 W @IOF,"USER WHO HAVE NOT SIGNED ON WITHIN 120 DAYS (",OV120D,") ",A1,!,?69,DTT
 W !?37,"ENTERED",?45,"VERIFY",?52,"LAST",?73,"PAGE ",$J(PAG,1),!,"DUZ",?7,"USER",?28,"SSN",?37,"DATE",?45,"CHANGE",?52,"SIGNED",?59,"SERVICE",!,"--------------------------------------------------------------------------------" K PRIM
QUIT Q
BLDGBL ;BUILD THE TEMP ^TMP(DD, GLOBAL
 K ^TMP(DD) S A=.999,(CNT,OVRCNT)=0
 ;D WAIT^DICD K ^TMP(DD) S A=.999,(CNT,OVRCNT)=0
 F  S A=$O(^VA(200,A)) Q:'+A  S NODE=^VA(200,A,0),TERM=$P(NODE,U,11) D:TERM>DT!(TERM="")  I $D(FLG) S ^TMP(DD,($P(NODE,U)_AST),A)="" K FLG
 . S AST="" I $D(^PRSPC(A,1))#2,$P(^PRSPC(A,1),U,33)="Y" S AST="*"
 . I $P(NODE,U)="" S ^TMP(DD,A)="" Q
 . S DATENT="",LV="",LSTSGN="" S:$D(^VA(200,A,.1)) LV=$P(^(.1),U) S:$D(^VA(200,A,1)) DATENT=$P(^(1),U,7) S:$D(^VA(200,A,1.1)) LSTSGN=$P(^(1.1),U)
 . I LV'="",LV["," S %H=LV D YMD^%DTC S LV=X
 . I LSTSGN="" D  Q
 . . I (LV="") D  Q
 . . . I DATENT<OV120 S CNT=CNT+1,FLG="" Q
 . . I (LV<OV120) S CNT=CNT+1,FLG=""
 . I LSTSGN'="" D  Q
 . . I LSTSGN<OV120,(LV<OV120) S OVRCNT=OVRCNT+1,FLG="" Q
12 ;W !!,"OVER 120 DAYS ",$J(OVRCNT,4),!,"NOT SIGN ON   ",$J(CNT,4),!,"------------------",!,"TOTAL:      ",$J(CNT+OVRCNT,6)
 S ^TMP(DD)=CNT_U_OVRCNT_U_(CNT+OVRCNT)_U_DT
BLDGBLN Q
TERM ;SET TERMINATION DATE AND ACCESS CODE
 S A="",DD=$T(+0) D DT^DICRW
 F  S A=$O(^TMP(DD,A)) Q:A=""  S BB="" F  S BB=$O(^TMP(DD,A,BB)) Q:BB=""  D
 . S NODE=^VA(200,BB,0) S X=BB_$E($P(NODE,U),1,9) D ^XUSHSH S XUSH=X,DIE="^VA(200,",DA=BB,DR="9.2///^S X=DT;9.21///"_"y"_";9.22///"_"y"_";9.23///"_"y" S:$P(NODE,U,3)="" DR=DR_";2///^S X=XUSH" D ^DIE
 S $P(^TMP(DD),U,5)="DONE"
 Q
RESTORE ;RESTORE DELETED USERS, YOU MUST SET THE DATE BELOW
 D DT^DICRW S A=.9999,CNT=0
 F  S A=$O(^VA(200,A)) Q:'+A  S NODE=^VA(200,A,0) I $P(NODE,U,11)="2950224" S CNT=CNT+1,$P(^VA(200,A,0),U,11)="" W !,$P(NODE,U,11)," ",$P(NODE,U)
 W !,"TOTAL: ",CNT
 Q
