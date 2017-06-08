A4A7CHKB ;CLKS/SO,ISCSF/RWF - CHECK PROVIDER FILE LINKAGE ;3/14/93  16:23
 ;;1.01;A4A7;**7**;12/29/94
 N DIR
 S DIR(0)="Y",DIR("A",1)="If there are problems in the linkage between the PROVIDER file",DIR("A",2)=" and the NEW PERSON file.",DIR("A")="Should Problems be  FIXed"
 D ^DIR G:$D(DUOUT) XIT S A4FIX=+Y
DEV ; Get Output Device
 S %ZIS="MQ" D ^%ZIS I POP S POP=0 G XIT
 I $D(IO("Q")) S ZTDESC="PROVIDER FILE LINKAGE CHECK",ZTRTN="DEQUE^A4A7CHKB"
 I $D(IO("Q")) S %DT="AEFRX",%DT("A")="Queue for what date & time? ",%DT("B")="NOW",%DT(0)="NOW" D ^%DT K %DT G XIT:Y<0 S ZTDTH=Y
 I $D(IO("Q")) K IO("Q") S ZTDTH=$S($D(ZTDTH):ZTDTH,1:$H) D ^%ZTLOAD,HOME^%ZIS W !,"Task number: ",ZTSK G XIT
 U IO
DEQUE ; Deque Entry Point
RPT ; Print Report ; Called fron ^A4A7CHK
 D HDR S A4UX=0,A4FIX=+$G(A4FIX)
 F  S A4UX=$O(^DIC(6,+A4UX)) Q:+A4UX<1  D CHK
XIT ; Common Exit Point
 K A4UA3,A4UA6,A4UC,A4UHDR,A4UPG,A4URDT,A4URDW,A4UX
 Q:$D(A4UCPL)
 I '$D(ZTQUEUED),$E(IOST)="P" D ^%ZISC
 Q
CHK ; Begin Linkage Checks
 S (A4UN,A4UN(16),A4UN(3),A4UN(200),A4UC)="",X=$G(^DIC(6,+A4UX,0))
 I X="" S A4UC="Missing Zero node" D W Q
 I A4UX'=+X S A4UC="IEN '= .01 Pointer Value" S (A4UN,A4UN(16))="" D W Q
 S A4UN(16)=$P($G(^DIC(16,+A4UX,0)),U),A4UA3=+$P($G(^DIC(16,+A4UX,"A3")),U),A4UA6=+$P($G(^DIC(16,+A4UX,"A6")),U)
 I 'A4UA6 S A4UC="Missing 'A6' Pointer value" D W Q
 I A4UX'=+A4UA6 S A4UC="Coorupted 'A6' Pointer value." D W Q
 I 'A4UA3 S A4UC="Missing 'A3' Pointer value." D W Q
 S A4UN(3)=$P(^DIC(3,+A4UA3,0),U),A4UN(200)=$P(^VA(200,+A4UA3,0),U)
 I '$D(^XUSEC("PROVIDER",+A4UA3))#2 S A4UNPK=1 I A4FIX D PKFIX S A4UNPK=2
 I A4UN(16)'=A4UN(3),A4UN(3)'=A4UN(200) D
 . S A4UC="Names are not equal "_A4UN(16)_$S(A4UN(16)=A4UN(3):" = ",1:" '= ")_A4UN(3)_$S(A4UN(3)=A4UN(200):" = ",1:" '= ")_A4UN(200)
 . I $D(A4UNPK) S A4UNC=A4UC_$S(A4UNPK=2:" & PROVIDER key added.",1:" & doesn't own  PROVIDER key.")
 . Q
 I A4UC]"" D W K A4UNPK Q
 I $D(A4UNPK) S A4UC="Doesn't own PROVIDER key." D W K A4UNPK Q
 Q
W ; Write Out Error
 W !,+A4UX,?15,A4UN(16),?50,A4UC S A4UC="" K A4UN Q
HDR ; Header Sub-Routine
 I '$D(A4UHDR) S (A4UHDR,A4UPG)=0 D NOW^%DTC,YX^%DTC S Y=$TR(Y,"@"," "),A4URDT=$P(Y,":",1,2) D DW^%DTC S A4URDW=X
 I A4UHDR W @IOF
 S A4UHDR=1,A4UPG=A4UPG+1 W "Provider File Linkage Checks     ",A4URDW,"     ",A4URDT,?(IOM-10),"Page: ",A4UPG
 W !,"Prov. IEN",?15,"Provider",?50,"Comment" S A4UX1="",$P(A4UX1,"=",IOM)="" W !,A4UX1 K A4UX1
 Q
PKFIX ;Fix missing Provider key
 N DIK,DA
 S DIK="^DIC(6,",DIK(0)=.01,DA=A4UX D EN1^DIK
 Q
