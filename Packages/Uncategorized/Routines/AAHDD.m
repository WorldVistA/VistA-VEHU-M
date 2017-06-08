%AAHDD ;402,DJB,11/2/91,EDD**Electronic Data Dictionary
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 ;;FLAGQ='^',FLAGE='^^',FLAGP=Printing on,FLAGP1=Option 12 selected to turn on printing
 ;;FLAGH=Bypass 1st screen
 ;;FLAGL=Last item in list,FLAGM='^' or '^^' in menu
 ;;FLAGG=No Groups,FLAGNFF=Suppress Form Feed,FLAGPT=Pointer File or Field nonexistent
 ;;FLAGGL=Invalid entry in GLOBAL
EN ;Entry point
 I '$D(^DD(0)) W *7,!!?2,"You don't have Filemanager in this UCI.",!! D:$G(FLAGAGL)="AGL"!($G(FLAGARR)="ARR") PAUSE1^%AAHDDU Q
 I $G(FLAGARR)'="ARR",$G(FLAGAGL)'="AGL",$G(DUZ)'>0 D ID Q:$G(DUZ)=""
 S $ZT="ERROR^%AAHDDZ"
START ;
 I '$D(GEMIOF) K FLAGAGL,FLAGARR
 NEW FLAGE,FLAGG,FLAGGL,FLAGGL1,FLAGH,FLAGL,FLAGM,FLAGNFF,FLAGP,FLAGP1,FLAGQ
 NEW DIC,EDDDATE,I,M1,M2,M3,M4,M5,O,PARTEDD,PRINTING,X,Y,Z1,ZGL,ZNAM,ZNUM,ZTSAV,ZZGL
 S:$G(GEMXX)="TAG-DIR" FLAGH=1 S:$G(GEMXX)="TAG-PRT" (FLAGH,FLAGNFF)=1 K GEMXX
 I $G(FLAGAGL)'="AGL",$G(FLAGARR)'="ARR" NEW GEMIOF,GEMIOM,GEMIOSL,GEMIOST,GEMLINE,GEMLINE1,GEMLINE2,GEMRON,GEMROFF,GEMSIZE,GEMTIME,GEMXX,GEMXY,U
 D INIT^%AAHDDZ
 S FLAGQ=0 D PART^%AAHDDZ Q:FLAGQ  ;Check partition size
TOP ;
 S (FLAGP,FLAGQ)=0 K ^UTILITY($J)
 D:'FLAGH HD^%AAHDD1
 D GETFILE G:FLAGQ EX D MULT^%AAHDDPR,MENU G:FLAGE EX
 S FLAGH=1 G TOP ;Set FLAGH to bypass opening screen
EX ;Exit
 K ^UTILITY($J)
 Q
 ;==================================================================
GETFILE ;File lookup
 NEW DIC
 R !?2,"Select FILE: ",X:GEMTIME S:'$T X="^" I "^"[X S FLAGQ=1 Q
 I $L(X)>1,$E(X)="^" D GLOBAL^%AAHDDN G:FLAGGL GETFILE Q
 I X="?" W !?1,"Enter global in the format '^DG' or '^RA(78', or"
 S DIC="^DIC(",DIC(0)="QEM" D ^DIC I Y<0 G GETFILE
 S ZNUM=+Y,ZNAM=$P(Y,U,2)
 I '$D(^DIC(ZNUM,0,"GL")) W *7,!!?2,"WARNING...This file is missing node ^DIC(",ZNUM,",0,""GL"")",! S FLAGQ=1 Q
 I ^DIC(ZNUM,0,"GL")']"" W *7,!!?2,"WARNING...Node ^DIC(",ZNUM,",0,""GL"") is null.",! S FLAGQ=1 Q
 S GEMXX=^DIC(ZNUM,0,"GL")_"0)" I '$D(@GEMXX) W *7,!!?2,"WARNING...This file is missing its data global - ",^DIC(ZNUM,0,"GL"),! S FLAGQ=1 Q
 S ZGL=^DIC(ZNUM,0,"GL")
 Q
MENU ;
 S (FLAGE,FLAGG,FLAGL,FLAGM,FLAGQ,FLAGP1)=0
 D HD1^%AAHDD1,^%AAHDDM G:FLAGP1 MENU I FLAGP S:$E(GEMIOST,1,2)="P-" FLAGQ=1 D PRINT^%AAHDDPR ;Turn off printing
 Q:FLAGM!FLAGE  G:FLAGQ MENU
 I $Y'>GEMSIZE F I=$Y:1:GEMSIZE W !
 R !!?2,"<RETURN> to go to Main Menu, '^' to exit: ",Z1:GEMTIME S:'$T Z1="^" I Z1="^" S FLAGE=1 Q
 G MENU
DIR ;Supress heading
 I $G(DUZ)'>0 D ID Q:$G(DUZ)=""
 S GEMXX="TAG-DIR" G EN
GL ;Call ^%AAHDD here to get listing of Globals in ASCII order.
 NEW FLAGH,FLAGNFF,FLAGP,FLAGQ,M1,M2,M3,M4,M5,PRINTING,Z1
 NEW GEMIOF,GEMIOM,GEMIOSL,GEMIOST,GEMLINE,GEMLINE1,GEMLINE2,GEMROFF,GEMRON,GEMSIZE,GEMTIME,GEMXX,GEMXY
 S (FLAGP,FLAGQ)=0 D INIT^%AAHDDZ,GL^%AAHDDG
 G EX
PRT ;Stop page feeds. Use on ptr/keyboard
 I $G(DUZ)'>0 D ID Q:$G(DUZ)=""
 S GEMXX="TAG-PRT" G EN
P ;Call here if you are not running KERNEL
 I $G(DUZ)'>0 D ID Q:$G(DUZ)=""
 G EN
ID ;Get DUZ
 I $D(^XUSEC(0)) D ^XUP Q  ;KERNEL loaded
 S DUZ=0,DUZ(0)=$S($G(DUZ(0))]"":DUZ(0),1:"@")
 Q
