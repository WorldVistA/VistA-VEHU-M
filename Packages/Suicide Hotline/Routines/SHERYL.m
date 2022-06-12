IBOSTUS ;ALB/SGD - MCCR BILL STATUS REPORT ;25 MAY 88 14:19
 ;;2.0;INTEGRATED BILLING;**118**;21-MAR-94
 ;
 ;MAP TO DGCROST
 ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOSTUS-1" D T0^%ZOSV ;start rt clock
 I '$D(DT) D DT^DICRW
 ;
SORT ; - Choose the date type to sort on.
 W !!,"Sort by 1-EVENT DATE 2-BILL DATE or 3-ENTERED DATE: 1// "
 R X:DTIME G:X["^" ENQ S:X="" X=1 I X["?"!(X<1)!(X>3) D HELP G SORT
 S IBDTP=$S(X=1:"EVENT DATE",X=2:"BILL DATE",1:"ENTERED DATE")
 W "  ",IBDTP
 ;
DATE W ! S %DT="AEPX",%DT("A")="Start with "_IBDTP_": ",%DT(0)=-DT
 D ^%DT G:Y<0 ENQ S IBBEG=Y
DATE1 S %DT="EPX" W !,"     Go to "_IBDTP_": TODAY// " R X:DTIME
 S:X=" " X=IBBEG G:X["^" ENQ S:X="" X="TODAY" D ^%DT I Y<0 G DATE1
 S IBEND=Y I IBEND<IBBEG W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G DATE1
 I IBEND>DT W *7," ??" G DATE1
 ;
 W !!,*7,"*** Margin width of this output is 80 ***"
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) K IO("Q") D  G ENQ
 .S ZTRTN="DQ^IBOSTUS",ZTDESC="IB - Bill Status Report",ZTSAVE("IB*")=""
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOSTUS" D T1^%ZOSV ;stop rt clock
 ;
DQ ; - Entry point if queued.
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOSTUS-2" D T0^%ZOSV ;start rt clock
 ;
 D EN^IBOSTUS1 ; Compile and print report.
 ;
ENQ K %,X,X1,X2,Y,IBAMT,IBIFN,IBQ,%DT,POP,IBNEX,IBF,IBBEF,IBBEG,IBCAT
 K IBEND,IBDTP,IBSUB,IBST1,IBST2,IBTOT,IBBS,IB0,IB1,IBS,IBU1
 I '$D(ZTQUEUED) D ^%ZISC
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOSTUS" D T1^%ZOSV ;stop rt clock
 ;
 Q
 ;
HELP ; - Help for "Sort by..." prompt.
 W !!,"  EVENT DATE is the date beginning the bill's episode of care"
 W !,"  BILL DATE is the date the bill was initially printed"
 W !,"  ENTERED DATE is the date the bill was first entered"
 Q
