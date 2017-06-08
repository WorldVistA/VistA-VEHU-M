%AAHDDL2 ;402,DJB,11/2/91,EDD**Fld Global Location - Pages
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
TOP S PAGETEMP=PAGE D ASK
 I Z1?1.N S PAGETEMP=Z1 D MOVE
 I Z1="B" S PAGETEMP=PAGE-1 D MOVE
 I Z1="I" D ^%AAHDDI Q:FLAGE  D MOVE
 I Z1="D" D ^%AAHDDD Q:FLAGE  D MOVE
 I Z1="R" D ^%AAHDDI4 Q:FLAGE  D MOVE
 I Z1="N" D ^%AAHDDN Q:FLAGE  D MOVE
 I Z1="A" D AGL2^%AAHDDZ D MOVE
 I Z1="?" D ^%AAHDDH4,MOVE
 Q:FLAGQ!FLAGE  I FLAGL,Z1="" Q
 S (PAGE,PAGETEMP)=PAGE+1,PCNT=1 S:SCREEN'="***" SCREEN=SCREEN+1 S ^UTILITY($J,"LIST",PAGE,"SCRN")=SCREEN
 D HD
 Q
ASK ;'Select:' prompt
 S FLAGQ=0 I $Y'>GEMSIZE F I=$Y:1:(GEMSIZE-1) W !
 W !,$E(GEMLINE1,1,GEMIOM),!?1,"^=Quit  ^^=Exit  B=BkUp  'n'=Jmp  I,R=IndFldSm  N=Node  D=Data  A=AGL  ?=Help"
ASK1 ;
 R !?1,"Select: ",Z1:GEMTIME S:'$T!(Z1=" ") Z1="^" I Z1["^" S FLAGQ=1 S:Z1="^^" FLAGE=1 Q
 S Z1=$S($E(Z1)="?":"?",Z1="b":"B",Z1="i":"I",Z1="d":"D",Z1="r":"R",Z1="n":"N",Z1="a":"A",1:Z1)
 S:$E(Z1)="0" Z1=+Z1 S:Z1["." Z1=Z1\1
 I ",?,A,B,D,I,N,R,"'[(","_Z1_","),Z1'?1.N,Z1'="" W *7,"   ??" G ASK1
 Q
MOVE ;Redraw same screen
 S PAGETEMP=$S(PAGETEMP<1:1,PAGETEMP>PAGE:PAGE,1:PAGETEMP)
 D HD1
 S GEMXX="" F I=0:0 S GEMXX=$O(^UTILITY($J,"LIST",PAGETEMP,GEMXX)) Q:GEMXX'>0  S GEMXY=^(GEMXX) D
 .W !,$J($P(GEMXY,U),3),?5,$P(GEMXY,U,2),?19,$J($P(GEMXY,U,3),8),?29,$P(GEMXY,U,4)
 D ASK Q:FLAGQ
 I Z1?1.N S PAGETEMP=Z1 G MOVE
 I Z1="B" S PAGETEMP=PAGETEMP-1 G MOVE
 I Z1="I" D ^%AAHDDI Q:FLAGE  G MOVE
 I Z1="D" D ^%AAHDDD Q:FLAGE  G MOVE
 I Z1="R" D ^%AAHDDI4 Q:FLAGE  G MOVE
 I Z1="N" D ^%AAHDDN Q:FLAGE  G MOVE
 I Z1="A" D AGL2^%AAHDDZ G MOVE
 I Z1="?" D ^%AAHDDH4 G MOVE
 S PAGETEMP=PAGETEMP+1 Q:PAGETEMP>PAGE
 G MOVE
HD ;Heading
 W @GEMIOF
 W ?6,"Screen: ",SCREEN,?59,"Page: ",PAGETEMP,"   Top: ",PAGE,!,$E(GEMLINE1,1,GEMIOM)
 W !,"REF",?5,"NODE ; PIECE",?19,"FLD NUM",?49,"FIELD NAME"
 W !,"---",?5,"------------",?19,"--------",?29,"--------------------------------------------------"
 Q
HD1 ;Called from MOVE
 W @GEMIOF
 W ?6,"Screen: ",^UTILITY($J,"LIST",PAGETEMP,"SCRN"),?59,"Page: ",PAGETEMP,"   Top: ",PAGE,!,$E(GEMLINE1,1,GEMIOM)
 W !,"REF",?5,"NODE ; PIECE",?19,"FLD NUM",?49,"FIELD NAME"
 W !,"---",?5,"------------",?19,"--------",?29,"--------------------------------------------------"
 Q
