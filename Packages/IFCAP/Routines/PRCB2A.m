PRCB2A ;WISC/(SKR@LBVAMC) - PLT,DGL-ROUTINE TO PRINT RECEIVING REPORT PENDING ACTION; 7/20/98 2:18pm
V ;;5.1;IFCAP;**126,186,217**;Oct 20, 2000;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*186 Added new reporting for all approved amendments
 ;            to insure fiscal is aware of any dangling 
 ;            amendments waiting fiscal processing.
 ;PRC*5.1*217 Fixed display issues in header
 ;            User terminated message
 ;
 QUIT  ;invalid entry point
 ;
EN ;pending fiscal action rpt
INIT S U="^",LINE="" K %ZIS,%IS,IOP,IOC,ZTIO S %IS="MQ" D ^%ZIS Q:POP
 S (ZSTAT,IEN,PRCQ,A,C)=0,PAGE=1
 S $P(LINE,"=",IOM)=""
 U IO(0) S TRM=1 S:IO=IO(0) IOC=1
 I $D(IO("Q")) S ZTRTN="START^PRCB2A",ZTDTH="OBLIGATIONS PENDING ACTION",ZTSAVE("IOC")=1,ZTSAVE("LINE")="",ZTSAVE("PRCQ")="",ZTSAVE("PAGE")=""
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED" G EXIT
START ;Loop picks up only specific entries
 S A="",A0="",A1="",A2="",B=0,C=" - Purchase Orders",D=""
 D HDR,HDR1
 S PRCQ="" F ZSTAT=10,15,20 QUIT:PRCQ  S IEN="" F  S IEN=$O(^PRC(442,"AI",ZSTAT,IEN)) Q:IEN'>0  D PRINT QUIT:PRCQ
 I PRCQ=1 G EXIT
 ;
 ;PRC*5.1*186 Check for dangling amendments
 D ASK G:PRCQ EXIT D HDR0,HDR1A
 S PRCTT=0,PRCQ=0 S IEN=0 F  S IEN=$O(^PRC(443.6,IEN)) Q:IEN'>0  D PRINT1 QUIT:PRCQ
 I PRCTT=0 W !!,"** NO APPROVED AMENDMENTS AWAITING FISCAL ACTION **"
 I PRCQ=1 G EXIT
 ;
 ;Loop through 2237s & 1358s looking for GFP entries with status=10
 S IEN=0,IEN1=0,IEN2=0,B=0,C=" - 2237s & 1358s"
 D ASK G:PRCQ EXIT D HDR,HDR2   ;PRC*5.1*186
 F  S IEN1=$O(^PRC(420,IEN1)),IEN2=0 Q:IEN1'>0  D  G:PRCQ EXIT
  . F  S IEN2=$O(^PRC(420,IEN1,1,IEN2)),IEN=0 Q:IEN2'>0  S D=$P($G(^PRC(420,IEN1,1,IEN2,0)),U,1) D:$G(D)'=""  Q:PRCQ
  . . F  S IEN=$O(^PRCS(410,"AN",D,IEN)) Q:IEN'>0  D  Q:PRCQ
  . . . S A=$G(^PRCS(410,IEN,3)) Q:A=""
  . . . S A=$G(^PRCS(410,IEN,1)) Q:A=""  S A=$P(A,U,1) Q:A=""
  . . . S A0=$G(^PRCS(410,IEN,0)) Q:A0=""
  . . . S A1=$G(^PRCS(410,IEN,10)) Q:A1=""
  . . . I $P(A0,U,4)=1&($P(A1,U,4)=10) D PRINT2(1) Q  ; form type 1358
  . . . S A2=$G(^PRC(443,IEN,0)) Q:A2=""
  . . . I $P(A1,U,3)=""&($P(A2,U,7)=10) D PRINT2(0) Q  ; No PO#
 I B=0 W !!,"NO 2237s or 1358s to print"
 E  W !!,"(Note:  '*' indicates transaction is a 1358.  All others are 2237s.)",!
EXIT ;PRC*5.1*217 ADDS USER TERMINTED REPORT
 I PRCQ=1 D EN^DDIOL("USER TERMINATED REPORT")
 I PRCQ'=1 D EN^DDIOL("END OF REPORT")
 K ZSTAT,IEN,L1,POP,ZTDTH,ZTRTN,ZTSAVE,TRM,LINE,PAGE,PRCQ,PRCTT,A,A0,A1,A2,B,C,D
 D ^%ZISC
 Q
HDR ; 
 U IO W @IOF W !,?70,"Page ",PAGE S PAGE=PAGE+1
 W !,"IFCAP OBLIGATIONS PENDING ACTION REPORT",C
 W !,?45,"PRINTED ON " D ^%D W " AT " D ^%T
 Q
HDR0 ;prc*5.1*186
 U IO W @IOF W !,?70,"Page ",PAGE S PAGE=PAGE+1
 W !,"IFCAP APPROVED AMENDMENTS PENDING FISCAL ACTION REPORT",C
 W !,?45,"PRINTED ON " D ^%D W " AT " D ^%T
 Q
HDR1 ;Purchase orders
 W !,LINE,!,"P.O. NUMBER",?12,"FCP ",?18,"AMOUNT",?32,"DATE",?42,"STATUS",!,LINE,!
 Q
HDR1A ;Purchase orders  PRC*5.1*186
 W !,LINE,!,"P.O. NUMBER",?12,"FCP ",?18,"AMOUNT",?32,"DATE",?45,"DAYS SINCE APPROVED",!,LINE,!
 Q
HDR2 ;GPF 2237s
 W !,LINE,!,"TRANSACTION NUMBER",?22,"FCP ",?32,"AMOUNT",?45,"DATE",?55,"STATUS",?77,"SCP",!,LINE,!
 Q
PRINT ;
 Q:'$D(^PRC(442,IEN,0))
 I $Y+8>IOSL D ASK Q:PRCQ  D HDR,HDR1
 W !,$P(^PRC(442,+IEN,0),U,1),?12,$P($P(^(0),U,3)," "),?18,"$"_$J($P(^(0),U,15),9,2)
 W:$D(^PRC(442,IEN,1)) ?32,$E($P(^(1),U,15),4,5)_"-"_$E($P(^(1),U,15),6,7)_"-"_$E($P(^(1),U,15),2,3),?42,$E($S($D(^PRCD(442.3,+$P(^PRC(442,+IEN,7),U,1),0)):$P(^(0),U,1),1:""),1,39)
 Q
PRINT1 ;PRC*5.1*186
 N PRCAMD,PRCAMD1,X1,X2
 Q:'$D(^PRC(443.6,IEN,0))
 S PRCAMD=0,PRCAMD=$O(^PRC(443.6,IEN,6,PRCAMD)) Q:'PRCAMD
 S PRCAMD1=$G(^PRC(443.6,IEN,6,PRCAMD,1))
 I $P(PRCAMD1,U,2)']"" Q
 S PRCTT=PRCTT+1
 I $Y+8>IOSL D ASK Q:PRCQ  D HDR0,HDR1A
 W !,$P(^PRC(442,+IEN,0),U,1),?12,$P($P(^(0),U,3)," "),?18,"$"_$J($P(^(0),U,15),9,2)
 I $D(^PRC(442,IEN,1)) W ?32,$E($P(^(1),U,15),4,5),"-",$E($P(^(1),U,15),6,7),"-",$E($P(^(1),U,15),2,3)
 I $P(PRCAMD1,U,3)]"" S X1=DT,X2=$P($P(PRCAMD1,U,3),".") D ^%DTC W ?51,X
 Q
PRINT2(X) ;
 I $Y+8>IOSL D ASK Q:PRCQ  D HDR,HDR2 ;PRC*5.1*217 HEADER PRINT FIX
 W !,$P(A0,U,1)
 I X=1 W "*"
 W ?22,$P($P(^PRCS(410,IEN,3),U,1)," "),?28
 I $D(^PRCS(410,IEN,4))=0 W "Bad record"
 E  W "$"_$J($P(^(4),U,8),9,2),?42,$E(A,4,5),"-",$E(A,6,7),"-",$E(A,2,3)
 W ?52,$P(^PRCD(442.3,10,0),U,1),?77,$P("NON^GPF^SF^CON^CAN",U,($P(^PRC(420,IEN1,1,IEN2,0),U,12)+1))
 S B=B+1
 Q
ASK ;
 I B>0 W !!,"(Note:  '*' indicates transaction is a 1358.  All others are 2237s.)"
 I $E(IOST,1,2)="C-" W !!,"Press <RET> to continue or '^' to quit.  " R X:DTIME I '$T!(X="^") S PRCQ=1 Q
 Q
INFO ;routine provides Fiscal Service with a listing of all Purchase orders
 ;from file 442, that have a Supply Status of 10,15,20.  These numbers
 ;reflect IEN from file 442.3
 ;As of PRC*5*163, the routine also lists 2237s in General Post Funds
