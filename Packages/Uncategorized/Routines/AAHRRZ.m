%AAHRRZ ;402,DJB,6/25/92**Init,Branching,Error
 ;;GEM III;;
 ;;David Bolduc - Augusta,ME
INIT ;Initialize variables
 S ARRS=$S($G(ARRS)="":1,1:(ARRS+1)) ;ARRS is the number of programs you are viewing.
 S (PGTOP,START)=1 Q:$G(FLAGARR)="ARR"
 S ARRSP=1,GEMTIME=$S($D(DTIME):DTIME,1:600),U="^" ;ARRSP=1 Sets single spacing as the default
 I $D(^%ZIS(1)),$D(^%ZIS(2)) S IOP="HOME" D ^%ZIS K IOP D  I 1
 .S GEMSIZE=(IOSL-6),GEMIOF=IOF,GEMIOM=IOM-1,GEMIOSL=IOSL,GEMIOST=IOST
 .I $D(^%ZIS(2,IO(0),5)),$P(^(5),U,4)]"",$P(^(5),U,5)]"" S GEMRON=$P(^(5),U,4),GEMROFF=$P(^(5),U,5)
 E  S GEMSIZE=18,GEMIOM=79,GEMIOF="#,*27,""[2J"",*27,""[H""",GEMIOSL=24,GEMIOST="C-VT100"
 S:'$D(GEMRON) GEMRON="*27,*91,*55,*109" S:'$D(GEMROFF) GEMROFF="*27,*91,*48,*109" ;Reverse Video
 S $P(GEMLINE,"-",212)="",$P(GEMLINE1,"=",212)="",$P(GEMLINE2,". ",106)=""
 S $P(ARRLINE,"=",212)="",ARRLINE="|"_$E(ARRLINE,2,8)_"|"_$E(ARRLINE,10,(GEMIOM-1))_"|"
 Q
AGL ;Run the Acme Global Lister
 I $G(ARRS)>2 W *7,!?1,"You can't call AGL if you've branched to more than 2 programs." D PAUSE Q
 I $G(DUZ(0))'["@",$G(DUZ(0))'["#" W *7,"   You don't have access. See Help option." D PAUSE Q
 I '$$EXIST("%AAHGL") W *7,"   You don't have the 'Acme Global Lister' Routines." D PAUSE Q
 D PART^%AAHGLZ K PARTAGL1,PARTAGL2 I FLAGQ S FLAGQ=0 Q
 S ZTSAV=$ZT D ^%AAHGL
 S $ZT=ZTSAV
 Q
EDD ;Call EDD, Electronic Data Dictionary
 I $G(ARRS)>2 W *7,!?1,"You can't call EDD if you've branched to more than 2 programs." D PAUSE Q
 I '$$EXIST("%AAHDD") W *7,"   You don't have the 'Electronic Data Dictionary' Routines." D PAUSE Q
 D PART^%AAHDDZ K PARTEDD I FLAGQ S FLAGQ=0 Q
 S ZTSAV=$ZT D DIR^%AAHDD
 S $ZT=ZTSAV
 Q
EXIST(X) ;0=Routine doesn't exist, 1=Routine exists
 I $G(X)']"" Q 0
 I "8,16"[GEMSYS,$E(X)="%",@("$T(^"_X_")]""""") Q 1
 X GEMSYS("EXIST") E  Q 0
 Q 1
RSE ;Search Routine for string(s)
 I $G(ARRS)>2 W *7,!?1,"You can't do Routine(s) Search if you've branched to more than 2 programs." D PAUSE Q
 S ZTSAV=$ZT D ^%AAHRRSS S $ZT=ZTSAV
 Q
ERROR ;Error trap.
 I $G(FLAGEDIT)'="EDIT"!(ARRS>1) K ^TMP("PGM",$J,ARRS)
 S FLAGQ=1 I $ZE["<INRPT>" W !!?1,"....Interrupted.",!! Q
 W *7,!!?2,"NOTE: You've discovered an error in ARR."
 W !?2,"Error: ",$ZE,!?2,"Please report error to BOLDUC,DAVID@TOGUS.VA.GOV.",!
 Q
PAUSE ;Pause screen
 R !?1,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
