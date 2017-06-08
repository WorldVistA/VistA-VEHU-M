%AAHGLSA ;402,DJB,10/29/92**Ask - Called by ^%AAHGLS
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
ASK ;'Select:' prompt
 Q:FLAGQ
 I $Y'>GEMSIZE F I=$Y:1:GEMSIZE W !
 W !,$E(GEMLINE1,1,GEMIOM),!?1,"^,"" ""=Quit  'n'=Piece  B=BkUp  J'n'=Jmp  A=Alt("_GLS_")  E=EDD  O=Other  ?=Help"
ASK1 S (FLAGQ,FLAGWP,FLAGXREF,FLAGZERO)=0 K Z2
 R !?1,"Select: ",Z1:GEMTIME S:'$T!(Z1=" ") Z1="^" I Z1="^" S FLAGQ=1 Q
 S Z1=$TR(Z1,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I Z1?1.N1","1.N S Z2=$P(Z1,",",2),Z1=+Z1
 S Z1=$S($E(Z1)="0":+Z1,Z1[".":Z1\1,Z1["?":"?",1:Z1)
 I $E(Z1)="S" S SKIP=+$E(Z1,2,99),Z1="S"
 I $E(Z1)="J" S Z2=$E(Z1,2,99),Z1="J"
 I "?,A,B,C,E,ES,EV,H,J,O,R,S"'[Z1,Z1'?1.N,Z1'="" W *7,"   Invalid entry." G ASK1
 I Z1="O" W ?15,"S'n'=Skp  C=Cd  R=RevVid  H=Hot" G ASK1
 I Z1="H",GLS'>1 W *7,"  Invalid with only 1 session running." G ASK1
 I Z1="E",$G(FLAGEDD)="EDD" W *7,"   You are already running EDD." G ASK1
 I Z1="E",GLS>1 W *7,"   Calling EDD from an Alternate Session is not allowed." G ASK1
 I Z1="E",$T(^%AAHDD)']"" W *7,"   You do not have ^%AAHDD routine on your system." G ASK1
 I ",C,ES,EV,"[(","_Z1_","),$G(DUZ(0))'["@" W *7,"   You don't have access. See Help option." G ASK1
 I Z1="A",GLS>1 W *7,"   Only 1 Alternate Session allowed." G ASK1
 I Z1="A",PARTAGL2>$S W *7,"   You don't have enough partition space to run an Alternate Session.",!?20,"Partition: ",$S,"    Required: ",PARTAGL2 G ASK1
 I Z1="A",$G(FLAGARR)="ARR" W *7,"   No Alternate Session allowed when ARR is running." G ASK1
 I Z1="A",$G(FLAGEDD)="EDD" W *7,"   No Alternate Session allowed when EDD is running." G ASK1
 I Z1="R" D CHECKFM^%AAHGLS1 G:FLAGQ ASK1
 I Z1'?1.N Q
 I '$D(^TMP("A#GL",$J,GLS,PAGETEMP,Z1)) W *7,"  Enter number from left hand column." G ASK1
 D CHECKFM^%AAHGLS1 G:FLAGQ ASK1
 S GEMXX=^TMP("A#GL",$J,GLS,PAGETEMP,Z1) I GEMXX'?.E1"(".E W *7,"   This node is not viewable." G ASK1
 D SUBSET^%AAHGLA1(GEMXX) I SUBNUM="NOFM" W *7,"   Node not viewable. Isn't in standard Fileman format." G ASK1
 D CHKNODE^%AAHGLS1 G:FLAGQ ASK1
 Q
