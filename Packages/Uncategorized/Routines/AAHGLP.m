%AAHGLP ;402,DJB,3/24/92**Display Global PIECES
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
 NEW COL,FILE,FLAGDATA,FLAGQ,FLD,LEV,NODECNT,TEMP,TEMP1,Z2 S (FLAGQ,Z2)=0,GLVAL=@GLNAM,FLAGDATA="V"
TOP ;
 S COL=1
 D @$S(FLAGDATA="N":"LISTNAM^%AAHGLPV",FLAGDATA="X":"LISTXVAL^%AAHGLPV",1:"LISTIVAL^%AAHGLPV")
 D ASK Q:"^"[Z2
 I Z2="?" D ^%AAHGLH3 G TOP
 I Z2="A" N FLAGHOT S FLAGHOT=PAGE D START^%AAHGL G TOP
 I Z2="E" D EDD^%AAHGLZ G TOP
 I Z2="I" S FLAGDATA="I" G TOP
 I Z2="X" S FLAGDATA="X" G TOP
 I Z2="N" S FLAGDATA="N" G TOP
 D PIECE
 G TOP
EX ;
 Q
 ;=====================================================================
ASK ;Get Piece
 I $Y'>GEMSIZE F I=$Y:1:GEMSIZE W !
 W !,$E(GEMLINE1,1,GEMIOM)
 W !,?1,"<RETURN>=Quit   'n'=Piece   IorX=Value   N=Name   A=Alt("_GLS_")   E=EDD   ?=Help"
ASK1 R !?1,"Select PIECE: ",Z2:GEMTIME S:'$T Z2="^" I "^"[Z2 Q
 S Z2=$S(Z2["?":"?",$E(Z2)="0":+Z2,Z2[".":Z2\1,Z2="a":"A",Z2="e":"E",Z2="n":"N",Z2="i":"I",Z2="x":"X",1:Z2)
 I "?,A,E,I,N,X"'[Z2,Z2'?1.N W *7,"   Invalid entry." G ASK1
 I Z2="E",$G(FLAGEDD)="EDD" W *7,"   You are already running EDD." G ASK1
 I Z2="E",GLS>1 W *7,"   Calling EDD from an Alternate Session is not allowed." G ASK1
 I Z2="E",$T(^%AAHDD)']"" W *7,"   You do not have ^%AAHDD routine on your system." G ASK1
 I Z2="A",GLS>1 W *7,"   Only 1 Alternate Session allowed." G ASK1
 I Z2="A",PARTAGL2>$S W *7,"   You don't have enough partition space to run an Alt Session.",!?20,"Partition: ",$S,"    Required: ",PARTAGL2 G ASK1
 I Z2="A",$G(FLAGARR)="ARR" W *7,"   No Alternate Session allowed when ARR is running." G ASK1
 I Z2="A",$G(FLAGEDD)="EDD" W *7,"   No Alternate Session allowed when EDD is running." G ASK1
 Q
PIECE ;Determine if Global root has a numeric and Print data
 NEW FLAGQ,FNAM,FNUM,LENGTH,M1,M2,M3,M4,M5
 S FLAGQ=0,M1=2,M2=15,M3=20,M4=22,M5=25 ;Variables for column numbers
 D GETNODE^%AAHGLPV I $G(FILE(LEV))']"" D PIECEMSG,PAUSE Q
 I $O(^DD(FILE(LEV),"GL",NODE,""))["E" S Z2=$O(^DD(FILE(LEV),"GL",NODE,"")) ;MUMPS Data Type
 I '$D(^DD(FILE(LEV),"GL",NODE,Z2)) D PIECEMSG,PAUSE Q
 S FNUM=$O(^DD(FILE(LEV),"GL",NODE,Z2,0))
 I $G(FNUM)]"" S FNAM=$P(^DD(FILE(LEV),FNUM,0),"^")
 I $G(FNUM)']""!($G(FNAM)']"") D PIECEMSG,PAUSE Q
 D ^%AAHGLP1 I 'FLAGQ D PAUSE
 Q
PIECEMSG ;Display message if field is not viewable or no longer in use.
 W *7,"   This field is not viewable, or is no longer in use."
 Q
PAUSE ;
 R !?1,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
