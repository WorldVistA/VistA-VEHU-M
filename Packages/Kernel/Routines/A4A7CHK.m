A4A7CHK ;CLKS/SO  CHECK NEW PERSON, USER, & PERSON FILES ;6/22/94  12:30
 ;;1.01;A4A7;**7**;12/29/94
ASK ; Ask Beginning & Ending VA(200 IEN
RA1 S A4UX="" W !,"Begin checking the New Person file at IEN: FIRST//" R A4UX:$S($D(DTIME):DTIME,1:180) G XIT:'$T!(A4UX[U) S:A4UX="" A4UX=0 I A4UX'=+A4UX W *7,!,"Responce must be a number." G RA1
 S A4UBIEN=+A4UX I A4UBIEN'=0 S A4UBIEN=A4UBIEN-.00001
RA2 S A4UX="" W !,"End checking the New Person file at IEN: LAST//" R A4UX:$S($D(DTIME):DTIME,1:180) G XIT:'$T!(A4UX[U) S:A4UX="" A4UX=9E12 I A4UX'=+A4UX W *7,!,"Responce must be a number." G RA2
 S A4UEIEN=+A4UX
 I A4UEIEN<A4UBIEN W *7,!,"Beginning IEN must be less than the Ending IEN." K A4UBIEN,A4UEIEN G RA1
RA3 S A4UX="" W !,"How would you like 'Out of SYNC' conditions reported?",!,?10,"D=detail  S=summary: S//" R A4UX:$S($D(DTIME):DTIME,1:180) G XIT:'$T!(A4UX[U)
 I A4UX=""!("Ss"[A4UX) S A4USD=0 ; Summary only
 I '$D(A4USD),"Dd"[A4UX S A4USD=1 ; Detail list
 I '$D(A4USD) W !,*7,"Please tell me how you want 'Out of SYNC' reported." G RA3
RA4 ; Also Check Provider File Linkage
 S DIR("A")="Would you also like to check the PROVIDER File linkage? ",DIR(0)="Y",DIR("B")="Yes" D ^DIR G XIT:$D(DIRUT) S A4UCPL=$S(Y=1:1,1:0)
DEV ; Get device info
 S %ZIS="MQ" D ^%ZIS K %ZIS I POP S POP=0 G XIT
 I $D(IO("Q")) S ZTRTN="DEQUE^A4A7CHK",ZTDESC="CHECK NEW PERSON, USER & PERSON FILE",ZTIO=ION,(ZTSAVE("A4UBIEN"),ZTSAVE("A4UEIEN"),ZTSAVE("A4USD"))="",ZTSAVE("A4UCPL")=""
 I $D(IO("Q")) S %DT="AEFRX",%DT("A")="Queue for what date & time? ",%DT("B")="NOW",%DT(0)="NOW" D ^%DT K %DT G XIT:Y<0 S ZTDTH=Y
 I $D(IO("Q")) K IO("Q") S ZTDTH=$S($D(ZTDTH):ZTDTH,1:$H) D ^%ZTLOAD,HOME^%ZIS W !,"Task number: ",ZTSK G XIT
 U IO
DEQUE ; Do the report thing
 D RPT^A4A7CHKA,RSYNCP3 D:$D(A4UBS) SUMMW^A4A7CHKA D:A4UCPL RPT^A4A7CHKB
XIT ; Common Exit Point
 K A4UBIEN,A4UCPL,A4UCS,A4UEIEN,A4UHDR,A4UNPL,A4UO,A4UPG,A4UPL,A4URDT,A4URDW,A4USD,A4UUL,A4UX,DTOUT,DUOUT,IO("Q") I '$D(ZTQUEUED),$E(IOST)="P" D ^%ZISC
 Q
RSYNCP3 ; Resync $Piece #3 VA(200, DIC(3, DIC(16
 L +^VA(200,0),+^DIC(3,0),+^DIC(16,0)
 S A4UMAX=$$MAX^XLFMTH(+$P(^VA(200,0),U,3),+$P(^DIC(3,0),U,3)),A4UMAX=$$MAX^XLFMTH(A4UMAX,+$P(^DIC(16,0),U,3))
 S $P(^VA(200,0),U,3)=A4UMAX,$P(^DIC(3,0),U,3)=A4UMAX,$P(^DIC(16,0),U,3)=A4UMAX L
 K A4UMAX,%1,%2
 Q
NOASKS ; Check VA(200 from beginning to the end - Summary
 S A4UBIEN=0,A4UEIEN=9E12,A4USD=0 G DEV
NOASKD ; Check VA(200 from beginning to end - Detail
 S A4UBIEN=0,A4UEIEN=9E12,A4USD=1 G DEV
DEQUES ; Queueable entry point - Summary
 S A4UBIEN=0,A4UEIEN=9E12,A4USD=0 G DEQUE
DEQUED ; Queueable entry point - Detail
 S A4UBIEN=0,A4UEIEN=9E12,A4USD=1 G DEQUE
