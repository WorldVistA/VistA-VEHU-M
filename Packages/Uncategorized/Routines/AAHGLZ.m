%AAHGLZ ;402,DJB,3/24/92**Init,Partition,Branching,Error
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
INIT ;Initialize variables
 S GLS=$S($G(GLS)=1:GLS+1,1:1) ;GLS is the current session you are running.
 I $G(FLAGAGL)'="AGL" S ZDELIM=$C(127)_$C(124),ZDELIM1=$C(127)_$C(126),ZDELIM2=$C(127)_$C(64) ;Commas,Spaces,Colons
 I $G(FLAGAGL)="AGL"!($G(FLAGEDD)="EDD")!($G(FLAGARR)="ARR") Q  ;The remaining variables have already been set up.
 S GEMTIME=$S($D(DTIME):DTIME,1:600),U="^"
 S $P(GEMLINE,"-",212)="",$P(GEMLINE1,"=",212)="",$P(GEMLINE2,". ",106)=""
 I $D(^%ZIS(1)),$D(^%ZIS(2)) S IOP="HOME" D ^%ZIS K IOP D  I 1
 .S GEMSIZE=(IOSL-6),GEMIOF=IOF,GEMIOM=IOM-1,GEMIOSL=IOSL,GEMIOST=IOST
 .I $D(^%ZIS(2,IO(0),5)),$P(^(5),U,4)]"",$P(^(5),U,5)]"" S GEMRON=$P(^(5),U,4),GEMROFF=$P(^(5),U,5)
 E  S GEMSIZE=18,GEMIOM=79,GEMIOF="#,*27,""[2J"",*27,""[H""",GEMIOSL=24,GEMIOST="C-VT100"
 S:'$D(GEMRON) GEMRON="*27,*91,*55,*109" S:'$D(GEMROFF) GEMROFF="*27,*91,*48,*109" ;Reverse Video
 Q
EDD ;Call EDD, Electronic Data Dictionary
 I $G(FLAGARR)="ARR" W *7,"   You can't call EDD when ARR is running." D PAUSE Q
 D PART^%AAHDDZ K PARTEDD I FLAGQ S FLAGQ=0 Q
 W !!?2,"EDD - Electronic Data Dictionary",!
 S ZTSAV=$ZT D DIR^%AAHDD
 S $ZT=ZTSAV
 Q
PART ;Set lower limit for the partition table. Check against $S.
 ;Session 1=108 variables, Session 2=67 variables, 12 subscript levels = 36 array levels
 NEW X1,X2,X3,X4
 I $G(FLAGEDD)="EDD" S X1=$S,X2="XXXXXXXXXX",X3=$S,X4=X1-X3\2,PARTAGL1=X4*79,PARTAGL2=X4*67 ;If AGL is called from EDD IO&GEM variables are already set
 E  S X1=$S,X2="XXXXXXXXXX",X3=$S,X4=X1-X3\2,PARTAGL1=X4*108,PARTAGL2=X4*67
 I $G(FLAGEDD)'="EDD" K X1,X3 S X1=$S,X2(1)="XXXXXXXXXX",X3=$S+X4,PARTAGL1=PARTAGL1+(X1-X3*3) ;X2 is defined. If AGL is called from EDD, variables are already defined.
 K X1,X2,X3 S X1=$S,X2(1)="XXXXXXXXXX",X3=$S+X4,PARTAGL1=PARTAGL1+(X1-X3*11),PARTAGL2=PARTAGL2+(X1-X3*11) ;X2 is new
 K X1,X3 S X1=$S,X2(2)="XXXXXXXXXX",X3=$S+X4,PARTAGL1=PARTAGL1+(X1-X3*45),PARTAGL2=PARTAGL2+(X1-X3*45) ;X2(1) is defined
 I $G(FLAGEDD)'="EDD" K X1,X3 S X1=$S,X2(1,1)="XXXXXXXXXX",X3=$S+X4,PARTAGL1=PARTAGL1+(X1-X3*1) ;X2 is defined
 K X1,X2,X3 S X1=$S,X2(1,1)="XXXXXXXXXX",X3=$S+X4,PARTAGL1=PARTAGL1+(X1-X3*1),PARTAGL2=PARTAGL2+(X1-X3*1) ;X2 is new
 K X1,X3 S X1=$S,X2(1,2)="XXXXXXXXXX",X3=$S+X4,PARTAGL1=PARTAGL1+(X1-X3*25),PARTAGL2=PARTAGL2+(X1-X3*25) ;X2(1,1) is defined
 K X1,X3 S X1=$S,X2(2,1)="XXXXXXXXXX",X3=$S+X4,PARTAGL1=PARTAGL1+(X1-X3*5),PARTAGL2=PARTAGL2+(X1-X3*5) ;X2(1,1) is defined
 I $G(FLAGEDD)'="EDD" K X1,X2,X3 S X1=$S,$P(X2,"-",212)="",X3=$S+X4,PARTAGL1=PARTAGL1+(X1-X3*3)
 Q:PARTAGL1<$S  S FLAGQ=1
 W *7,!!?10,"You don't have enough partition space to run AGL."
 W !?10,"Clear your partition and try again, or call AGL at"
 W !?10,"B^%AAHGL to run the basic lister only."
 W !!?10,"Partition: ",$S,"   Required: ",PARTAGL1
 I $G(FLAGARR)="ARR"!($G(FLAGEDD)="EDD") R !!?2,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
PAUSE ;Pause screen
 Q:$E(GEMIOST,1,2)="P-"  R !?1,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
ERROR ;Normal error trap.
 S FLAGQ=1 K ^TMP("A#GL",$J) I $ZE["<INRPT>" W !!?1,"....Interrupted.",!! Q
 W *7,!!?2,"NOTE: You've discovered an error in AGL."
 W !?2,"Error: ",$ZE,!?2,"Please report error to BOLDUC,DAVID@TOGUS.VA.GOV.",!
 I $G(FLAGEDD)="EDD"!($G(FLAGARR)="ARR") D PAUSE
 Q
ERROR1 ;Error Trap when testing validity of CODE.
 W *7,!!?18,"There is an error in your code. Remember,",!?18,"you must set $T with an 'IF' statement."
 W !!?2,"Code Entered: ",CODE S CODE=0 D PAUSE
 Q
