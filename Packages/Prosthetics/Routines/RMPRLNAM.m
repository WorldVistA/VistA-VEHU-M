RMPRLNAM ;PHX/RFM-AMIS REPORT PART IV ;10/19/1993
 ;;2.0;PROSTHETICS;;10/19/1993
 D HOME^%ZIS,DIV4^RMPRSIT G:$D(X) EXIT S RMPRNA=1 D ^RMPRDT K RMPRNA G:'$D(RMPRFY)!('$D(RMPRQTR)) EXIT
 S RMPRPR=1,DIR(0)="S^1:Print Part IV Loan Program;2:Print 1465 Report;" D ^DIR G:$D(DIRUT) EXIT S ANS=+Y
 D HOME^%ZIS S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT
 I '$D(IO("Q")) U IO G EN1
 S ZTDESC=$S(ANS=1:"LOAN REPORT-PROS",ANS=2:"PRINT 1465 REPORT",1:"UNK")
 S ZTRTN="EN1^RMPRLNAM",ZTSAVE("RMPRPR")="",ZTSAVE("RMPRFY")="",ZTIO=IO,ZTSAVE("DATE(")="",ZTSAVE("ANS")="",ZTSAVE("CA(")=""
 S ZTSAVE("RMPR(""STA"")")="",ZTSAVE("RMPR(""SIG"")")=""
 D ^%ZTLOAD G EXIT
EN1 G:ANS=2 ^RMPRLNAN
EN2 ;Entry Point for AMIS
 S X1=DATE(1),X2=-1 D C^%DTC S DATE("1A")=X,X1=DATE(2),X2=1 D C^%DTC S DATE("2A")=X
 S (RO,RP,RR)=0,CA("T1")="" S:'$D(RMPRPR) RMPRPR=0 F I=1:1:7 S CA(I)=""
 F  S RR=$O(^RMPR(660.1,"AG",RR)) Q:RR'>0  F  S RO=$O(^RMPR(660.1,"AG",RR,RO)) Q:RO=""  D
 .Q:'$D(^RMPR(660.1,RO,0))  Q:$P(^(0),U,15)'=RMPR("STA")
 .S RB=^RMPR(660.1,RO,0),ROB="S RP=$S(+$P(RB,U,13):$P(RB,U,13),1:7)"
 .I $P(RB,U,10),$P(RB,U,11),$P(RB,U,11)<DATE("2A"),$P(RB,U,11)>DATE("1A") D
 ..X ROB
 ..S $P(CA(RP),U)=$P(CA(RP),U,1)+$P(RB,U,4),$P(CA("T1"),U,1)=$P(CA("T1"),U,1)+$P(RB,U,4)
 ..S $P(CA(RP),U,2)=$P(CA(RP),U,2)+$P(RB,U,5),$P(CA("T1"),U,2)=$P(CA("T1"),U,2)+$P(RB,U,5)
 ..Q
 .I $P(RB,U,10)>DATE("1A") D
 ..X ROB
 ..S VAR=$S($P(RB,U,17)["N":3,1:5),$P(CA(RP),U,VAR)=$P(CA(RP),U,VAR)+$P(RB,U,4),$P(CA("T1"),U,VAR)=$P(CA("T1"),U,VAR)+$P(RB,U,4),$P(CA(RP),U,8)=$P(CA(RP),U,8)+$P(RB,U,4),$P(CA("T1"),U,8)=$P(CA("T1"),U,8)+$P(RB,U,4)
 ..S VAR=$S($P(RB,U,17)["N":4,1:6),$P(CA(RP),U,VAR)=$P(CA(RP),U,VAR)+$P(RB,U,5),$P(CA("T1"),U,VAR)=$P(CA("T1"),U,VAR)+$P(RB,U,5)
 S (RZ,RO)=0 F  S RZ=$O(^RMPR(660.2,"B",RZ)) Q:RZ'>0!(RZ>DATE(2))  F  S RO=$O(^RMPR(660.2,"B",RZ,RO)) Q:RO=""  D
 .Q:'$D(^RMPR(660.2,RO,0))  Q:(RMPR("STA")'=$P(^(0),U,15))!($P(^(0),U,9)'=1)!($P(^(0),U,19)'["A")  S TYP=$S($P(^(0),U,13)="":7,1:$P(^(0),U,13))
 .I $P(^RMPR(660.2,RO,0),U,19)["A" S $P(CA(TYP),U,7)=$P(CA(TYP),U,7)+1,$P(CA("T1"),U,7)=$P(CA("T1"),U,7)+1
 .Q
 D:RMPRPR PRINT
ASK I $E(IOST)["C",'$D(RMPRGEC) K DIR W ! S DIR(0)="E" D ^DIR
EXIT K DIR,RP,VAR,RO,RZ,RR,I,ROB,RB,TYP,DIC,QTR,%DT,ANS I $D(RMPRPR),'$D(RMPRGEC) K DATE,RMPRPR,RMPRQTR,RMPRFY,CA D ^%ZISC Q
 Q
PRINT W:$E(IOST)["C" @IOF
 W !?10,"PART IV - STATUS OF LOAN EQUIPMENT " S Y=DATE(1) X ^DD("DD") W Y_"-" S Y=DATE(2) X ^DD("DD") W Y,"  STA: ",$$STA^RMPRUTIL W ! F I=1:1:79 W "-"
 W !?12,"ITEMS RECOVERED",?28,"|",?32,"ITEMS LOANED DURING PERIOD",?61,"|",?63,"AVAIL FOR",?73,"|",?75,"ON"
 W !?13,"DURING PERIOD",?28,"|",?32,"NEW  ITEMS",?44,"|",?46,"RECOVERED ITEMS",?61,"|",?64,"REISSUE",?73,"|",?75,"LOAN"
 W !?13,"NUMBER  VALUE",?28,"|",?31,"NUMBER  COST",?44,"|",?46,"NUMBER   VALUE",?61,"|",?66,"EQP",?73,"|",?75,"EQP"
 W ! F I=1:1:79 W "-"
 W !,"BED, HOSP",?14,$J($P(CA(1),U),4),?19,$J($P(CA(1),U,2),8,2),?30,$J($P(CA(1),U,3),4),?34,$J($P(CA(1),U,4),10,2),?46,$J($P(CA(1),U,5),4),?49,$J($P(CA(1),U,6),10,2),?66,$J($P(CA(1),U,7),3)
 W ?74,$J($P(CA(1),U,8),4)
 W !!,"VAN LIFTS",?14,$J($P(CA(2),U),4),?19,$J($P(CA(2),U,2),8,2),?30,$J($P(CA(2),U,3),4),?34,$J($P(CA(2),U,4),10,2),?46,$J($P(CA(2),U,5),4),?49,$J($P(CA(2),U,6),10,2),?66,$J($P(CA(2),U,7),3)
 W ?74,$J($P(CA(2),U,8),4)
 W !!,"HOME DIA EQP",?14,$J($P(CA(3),U),4),?19,$J($P(CA(3),U,2),8,2),?30,$J($P(CA(3),U,3),4),?34,$J($P(CA(3),U,4),10,2),?46,$J($P(CA(3),U,5),4),?49,$J($P(CA(3),U,6),10,2),?66,$J($P(CA(3),U,7),3)
 W ?74,$J($P(CA(3),U,8),4)
 W !!,"INVALID LIFT",?14,$J($P(CA(4),U),4),?19,$J($P(CA(4),U,2),8,2),?30,$J($P(CA(4),U,3),4),?34,$J($P(CA(4),U,4),10,2),?46,$J($P(CA(4),U,5),4),?49,$J($P(CA(4),U,6),10,2),?66,$J($P(CA(4),U,7),3)
 W ?74,$J($P(CA(4),U,8),4)
 W !!,"RESPIRATORS",?14,$J($P(CA(5),U),4),?19,$J($P(CA(5),U,2),8,2),?30,$J($P(CA(5),U,3),4),?34,$J($P(CA(5),U,4),10,2),?46,$J($P(CA(5),U,5),4),?49,$J($P(CA(5),U,6),10,2),?66,$J($P(CA(5),U,7),3)
 W ?74,$J($P(CA(5),U,8),4)
 W !!,"WHEELCHAIRS",?14,$J($P(CA(6),U),4),?19,$J($P(CA(6),U,2),8,2),?30,$J($P(CA(6),U,3),4),?34,$J($P(CA(6),U,4),10,2),?46,$J($P(CA(6),U,5),4),?49,$J($P(CA(6),U,6),10,2),?66,$J($P(CA(6),U,7),3)
 W ?74,$J($P(CA(6),U,8),4)
 W !!,"A/O LN ITEMS",?14,$J($P(CA(7),U),4),?19,$J($P(CA(7),U,2),8,2),?30,$J($P(CA(7),U,3),4),?34,$J($P(CA(7),U,4),10,2),?46,$J($P(CA(7),U,5),4),?49,$J($P(CA(7),U,6),10,2),?66,$J($P(CA(7),U,7),3)
 W ?74,$J($P(CA(7),U,8),4)
 W !!,"TOTAL",?14,$J($P(CA("T1"),U),4),?18,$J($P(CA("T1"),U,2),9,2),?30,$J($P(CA("T1"),U,3),4),?34,$J($P(CA("T1"),U,4),10,2),?46,$J($P(CA("T1"),U,5),4),?49,$J($P(CA("T1"),U,6),10,2),?66,$J($P(CA("T1"),U,7),3)
 W ?74,$J($P(CA("T1"),U,8),4)
 Q
