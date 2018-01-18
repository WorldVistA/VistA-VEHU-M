A4APIP ;HINES-CIOFO/JJM UTILITY #1; 6/24/98 10:45
 ;;0.0;JJM UTILITIES;;JUNE 18, 1998
PIP1 ;
 K ^UTILITY($J)
 S CNT=0
 D CHKPKG
 K DIC,DIR,XCN,XTRNAME,XTRNCNT,XU1,XTSIZE,XTDT,DIE,XTRNEXT,XT,X,Y
SAVERTN ; SAVE RETURNS ENTERED
 K ^XTMP("PIP",$J)
 S ^XTMP("PIP",$J,0)=DT
 S RTN=" " F  S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""  S ^XTMP("PIP",$J,RTN)="" S CNT=CNT+1
 W !,"NUMBER OF ROUTINES SAVED ",$J(CNT,10),!
ENDPIP1 K CNT,RTN
 QUIT
PIP3 ;
 S DIC=9.7,DIC(0)="AEMNQZ"
 D ^DIC
 S IEN=+Y
 S BLD=$O(^XTMP("XPDI",IEN,"BLD",0)) Q:'BLD  W !,^XTMP("XPDI",IEN,"BLD",BLD,0)
ENDPIP3 K BLD,DIC,IEN
 QUIT
PIP5 ;
 I '$D(^XTMP("PIP",$J)) D PIP1,ENDPIP5 Q
 K ^UTILITY($J)
 D LOADRTN
 D CHK2
ENDPIP5 K CNT,RTN
 K DIC,DIR,XCN,XTRNAME,XTRNCNT,XU1,XTSIZE,XTDT,DIE,XTRNEXT,XT,X,Y
 W !!,".PIP6",!
PIP6 ;
 K ^UTILITY($J)
 Q:'$D(^XTMP("PIP",$J))
 D LOADRTN
 S RTN=" " F  S RTN=$O(^UTILITY($J,RTN)) Q:RTN']""   D
   . X "ZL @RTN S S(1)=$T(+1),S(2)=$T(+2)"
   . W RTN,?10,$P(S(1)," ",2,999),!,?10,S(2),!
ENDPIP6 ;
 K ^UTILITY($J)
 K RTN,S,CNT,S
 QUIT
PIP7 K ^UTILITY($J),RTN,S,^XTMP("PIP",$J),CNT
 QUIT
LOADRTN ; LOAD SAVED ROUTINES
 S CNT=0
 S RTN=" " F  S RTN=$O(^XTMP("PIP",$J,RTN)) Q:RTN=""  S ^UTILITY($J,RTN)="" S CNT=CNT+1
 W !,"NUMBER OF ROUTINES LOADED ",$J(CNT,10),!
 QUIT
XTSUMBLD ;SF/RWF - BUILD PACKAGE INTEG ROUTINE ;5/20/96  15:31
 ;;7.3;TOOLKIT;**11**;Apr 25, 1995
A ;
 K ^UTILITY($J),DIR D MSG
 S DIR(0)="SM^P:Package;B:Build",DIR("A")="Build from" D ^DIR K DIR Q:X[U
 G PKG:Y="P",BUILD:Y="B" Q
PKG W !!,"This will build a checksum routine for a package from the package file",!
 S DIC=9.4,DIC(0)="AEMQZ" D ^DIC Q  ; G EXIT:Y'>0
 D NAME($P(Y(0),U,2)) Q  ; G EXIT:'$D(XTRNAME)
 X ^%ZOSF("RSEL") Q  ; G EXIT:$O(^UTILITY($J,""))=""
 G BLD
 ;
BUILD W !!,"This will build a checksum routine from the BUILD file."
 S DIC="^XPD(9.6,",DIC(0)="AEMQZ" D ^DIC Q  ; G EXIT:Y'>0 S BLDA=+Y
 S X=$P(^DIC(9.4,+$P(Y(0),U,2),0),U,2) D NAME(X) Q  ; G EXIT:'$D(XTRNAME)
 F IX=0:0 S IX=$O(^XPD(9.6,BLDA,"KRN",9.8,"NM",IX)) Q:IX'>0  S X=^(IX,0) S:'$P(X,U,3) ^UTILITY($J,$P(X,U))=""
 Q  ; G EXIT:$O(^UTILITY($J,""))=""
 G BLD
 ;
NAME(Y) S XTRNAME=Y_"NTEG" W !,"I will create a routine ",XTRNAME
 S X=XTRNAME X ^%ZOSF("TEST") I $T S DIR(0)="YA",DIR("A")="But you already have one on file!  OK to replace? ",DIR("B")="NO" D ^DIR I Y'=1 K XTRNAME
 Q
 ;
BLD S X=XTRNAME F I=0:0 K ^UTILITY($J,X) S X=$O(^UTILITY($J,X)) Q:X'[XTRNAME
 I $O(^UTILITY($J,""))="" W !,"Routine list is empty" Q  ; G EXIT
 W !,"Calculating check-sums" S XTDT=$$NOW^XLFDT()
 S X=" " F I=0:0 S X=$O(^UTILITY($J,X)) Q:X=""  W !,X X ^%ZOSF("RSUM") S ^UTILITY($J,X)=Y
 W !,"Building routine" S RN=" ",XTRNCNT=0
B K ^UTILITY($J,0) S XTSIZE=0,XCN=0,DIE="^UTILITY($J,0,",XTRNEXT=$E(XTRNAME,1,7)_XTRNCNT,XTRNCNT=XTRNCNT+1
 F I=1:1 S XT=$P($T(ROU+I),";;",2,99) D ADD Q:$E(XT,1,3)="ROU"
 S @(DIE_"1,0)")=XTRNAME_$P($T(ROU+1),";;",2)_XTDT,@(DIE_"3,0)")=" ;;"_$P($T(+2),";",3)_";"_XTDT
 F I=0:0 S RN=$O(^UTILITY($J,RN)) Q:RN=""  S %=^(RN),XT=RN_" ;;"_% D ADD Q:XTSIZE>3700
 I RN]"" S @(DIE_"6,0)")=" G CONT^"_XTRNEXT
 S XCN=0,X=XTRNAME W !!,"Filing routine ",XTRNAME X ^%ZOSF("SAVE") S XTRNAME=XTRNEXT G:RN]"" B
 W !,"  DONE",!
EXIT K ^UTILITY($J),DIC,DIR,XCN,XTRNAME,XTRNCNT,XU1,XTSIZE,XTDT,DIE,XTRNEXT,XT,X,Y
 Q
ADD S XCN=XCN+1,XTSIZE=XTSIZE+$L(XT)+2,@(DIE_XCN_",0)")=XT Q
 Q
CHECK D MSG
 S DIR(0)="SM^P:Package;B:Build",DIR("A")="Build from" D ^DIR K DIR Q:X[U
 G CHKPKG:Y="P",CHKBLD:Y="B" Q
CHKPKG W !! K ^UTILITY($J) X ^%ZOSF("RSEL") I $O(^UTILITY($J,0))']"" W !!,"NO SELECTED ROUTINES" Q  ; G EXIT
CHK2 S X=" " F XU1=0:0 S X=$O(^UTILITY($J,X)) Q:X']""  W !,X,?10 X ^%ZOSF("RSUM") W "value = ",Y
 W !,"done" Q  ; G EXIT
CHKBLD W !!,"This will check the routines from a BUILD file."
 S DIC="^XPD(9.6,",DIC(0)="AEMQZ" D ^DIC Q  ; G EXIT:Y'>0 S BLDA=+Y
 S X=$P(^DIC(9.4,+$P(Y(0),U,2),0),U,2)
 F IX=0:0 S IX=$O(^XPD(9.6,BLDA,"KRN",9.8,"NM",IX)) Q:IX'>0  S X=^(IX,0) S:'$P(X,U,3) ^UTILITY($J,$P(X,U))=""
 Q  ; G EXIT:$O(^UTILITY($J,""))=""
 G CHK2
 ;
MSG W !!,"This option determines the current checksum of selected routine(s)."
 W !,"The Checksum of the routine is determined as follows:",!
 W !,"1. Any comment line with a single semi-colon is presumed to be"
 W !,"   followed by comments and only the line tag will be included."
 W !!,"2. Line 2 will be excluded from the count.",!
 W !,"3. The total value of the routine is determined by taking, excluding the"
 W !,"   exception, as noted above, and multipling the ASCII value of each"
 W !,"   character by its position on the line being checked."
 Q
ROU ;;
 ;; ;ISC/XTSUMBLD KERNEL - Package checksum checker ;
 ;; ;;0.0;
 ;; ;;7.3;10/1/94
 ;; S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 ;;CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;; ;
 ;; K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
 ;;ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 ;; W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 ;; W ! G CONT
 ;;ROU ;;
