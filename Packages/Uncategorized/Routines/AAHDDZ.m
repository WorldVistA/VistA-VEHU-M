%AAHDDZ ;402,DJB,11/2/91,EDD**Init,Partition,Branching,Error
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
INIT ;
 S M1=2,M2=15,M3=20,M4=22,M5=25 ;Variables for column numbers
 S:'$D(FLAGNFF) FLAGNFF=0 S:'$D(FLAGH) FLAGH=0
 S PRINTING="NO" I $D(^%ZIS(1)),$D(^%ZIS(2)) S PRINTING="YES" ;If PRINTING="YES", Print option in Main Menu will be enabled.
 I $G(FLAGAGL)="AGL"!($G(FLAGARR)="ARR") Q  ;If FLAGAGL or FLAGARR the remaining variables have already been set up.
 S GEMTIME=$S($D(DTIME):DTIME,1:600),U="^"
 S $P(GEMLINE,"-",212)="",$P(GEMLINE1,"=",212)="",$P(GEMLINE2,". ",106)=""
 I PRINTING="YES" S IOP="HOME" D ^%ZIS K IOP D  I 1
 .S GEMSIZE=(IOSL-6),GEMIOF=IOF,GEMIOM=IOM-1,GEMIOSL=IOSL,GEMIOST=IOST
 .I $D(^%ZIS(2,IO(0),5)),$P(^(5),U,4)]"",$P(^(5),U,5)]"" S GEMRON=$P(^(5),U,4),GEMROFF=$P(^(5),U,5)
 E  S GEMSIZE=18,GEMIOM=79,GEMIOF="#,*27,""[2J"",*27,""[H""",GEMIOSL=24,GEMIOST="C-VT100"
 S:'$D(GEMRON) GEMRON="*27,*91,*55,*109" S:'$D(GEMROFF) GEMROFF="*27,*91,*48,*109" ;Reverse Video
 Q
AGL1 ;Global Lister called from Main Menu
 I $G(FLAGARR)="ARR" W *7,"   You can't call AGL when ARR is running." S FLAGG=1 Q
 I $G(FLAGAGL)="AGL" W *7,"   You are already running AGL." S FLAGG=1 Q
 I $T(^%AAHGL)']"" W *7,"   You don't have the 'Acme Global Lister' Routines." S FLAGG=1 Q
 I $G(DUZ(0))'["@",$G(DUZ(0))'["#" W *7,"   You don't have access. See Help option." S FLAGG=1 Q
 D AGLRUN Q
AGL2 ;Global Lister called from 'Fld Global Location' option
 I $G(FLAGARR)="ARR" W *7,!?1,"You can't call AGL when ARR is running." D PAUSE1^%AAHDDU Q
 I $G(FLAGAGL)="AGL" W *7,!?1,"You are already running AGL." D PAUSE1^%AAHDDU Q
 I $T(^%AAHGL)']"" W *7,!?1,"You don't have the 'Acme Global Lister' Routines." D PAUSE1^%AAHDDU Q
 I $G(DUZ(0))'["@",$G(DUZ(0))'["#" W *7,!?1,"You don't have access. See Help option in Main Menu." D PAUSE1^%AAHDDU Q
 D AGLRUN Q
AGLRUN ;Run the Acme Global Lister
 NEW FLAGEDD S FLAGEDD="EDD"
 D PART^%AAHGLZ K PARTAGL1,PARTAGL2 I FLAGQ Q
 I FLAGP D PRINT^%AAHDDPR ;Shut off printing
 W !!?1,"AGL - Acme Global Lister",!
 S ZTSAV=$ZT D ^%AAHGL
 S $ZT=ZTSAV,FLAGQ=1
 Q
PART ;Set lower limit for the partition table. Check against $S.
 NEW X1,X2,X3,X4
 I $G(FLAGAGL)="AGL" S X1=$S,X2="XXXXXXXXXX",X3=$S,X4=X1-X3\2,PARTEDD=X4*75 ;If EDD is called from AGL IO&GEM&ZLINE variables are already set
 E  S X1=$S,X2="XXXXXXXXXX",X3=$S,X4=X1-X3\2,PARTEDD=X4*101
 I $G(FLAGAGL)="AGL" K X1,X3 S X1=$S,X2(1)="XXXXXXXXXX",X3=$S+X4,PARTEDD=PARTEDD+(X1-X3*2) ;X2 is already defined. Certain variables already set is EDD is called from AGL.
 E  K X1,X3 S X1=$S,X2(1)="XXXXXXXXXX",X3=$S+X4,PARTEDD=PARTEDD+(X1-X3*4) ;X2 is already defined
 K X1,X2,X3 S X1=$S,X2(1)="XXXXXXXXXX",X3=$S+X4,PARTEDD=PARTEDD+(X1-X3*2) ;X2 is new
 K X1,X3 S X1=$S,X2(2)="XXXXXXXXXX",X3=$S+X4,PARTEDD=PARTEDD+(X1-X3*5)
 I $G(FLAGAGL)'="AGL" K X1,X3 S X1=$S,X2(1,2)="XXXXXXXXXX",X3=$S+X4,PARTEDD=PARTEDD+(X1-X3*1) ;X2 is already defined
 I $G(FLAGAGL)'="AGL" K X1,X2,X3 S X1=$S,$P(X2,"-",212)="",X3=$S+X4,PARTEDD=PARTEDD+(X1-X3*3)
 Q:PARTEDD<$S  S FLAGQ=1
 W *7,!!?10,"You don't have enough partition space to run EDD."
 W !?10,"Clear your partition and try again."
 W !!?10,"Partition: ",$S,"   Required: ",PARTEDD
 I $G(FLAGARR)="ARR"!($G(FLAGAGL)="AGL") R !!?2,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
ERROR ;Error trap.
 S FLAGE=1 K ^UTILITY($J) I $ZE["<INRPT>" W !!?1,"....Interrupted.",!! Q
 W *7,!!?2,"NOTE: You've discovered an error in EDD."
 W !?2,"Error: ",$ZE,!?2,"Please report error to BOLDUC,DAVID@TOGUS.VA.GOV.",!
 I $G(FLAGAGL)="AGL"!($G(FLAGARR)="ARR") D PAUSE1^%AAHDDU
 Q
