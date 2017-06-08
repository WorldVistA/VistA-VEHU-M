%AAHRRS ;402,DJB,6/25/92**Get Program
 ;;GEM III;;
 ;;David Bolduc - Augusta,ME
 Q
EN ;Enter here from ^%AAHRR
 D HD,GETPGM G:"^"[ARRPGM EX D SETGLB
EX ;
 Q
GETPGM ;
 NEW RTN S RTN=""
 I $D(^TMP("A#RR",DUZ)) S RTN=^(DUZ) S X=RTN X GEMSYS("EXIST") K X E  S RTN="" K ^TMP("A#RR",DUZ) ;If routine doesn't exist it shouldn't be the default routine
 W !?1,"Select ROUTINE: ",$S(RTN]"":RTN_"//",1:"")
 R ARRPGM:GEMTIME S:'$T!(ARRPGM=" ") ARRPGM="^" I ARRPGM="",$D(^TMP("A#RR",DUZ)) S ARRPGM=^TMP("A#RR",DUZ)
 Q:"^"[ARRPGM
 S:ARRPGM["^" ARRPGM=$P(ARRPGM,"^",2) S:ARRPGM["(" ARRPGM=$P(ARRPGM,"(")
 I ARRPGM="?" D HELP G GETPGM
 I ARRPGM="??" D LIST K ^UTILITY($J) W ! G GETPGM
 I ARRPGM'?.1"%"1A.7AN D MSG1 G GETPGM
 S ^TMP("A#RR",DUZ)=ARRPGM
 ;Next line checks to see if anyone else is editing this routine.
 I $G(FLAGEDIT)="EDIT",ARRS=1 L ^%AAHE("LOCK",ARRPGM):0 I '$T W *7,!!?5,"This program is currently being edited. Try later.",! S ARRPGM="^"
 Q
LIST ;List routines
 K ^UTILITY($J)
 D @$S($D(^%ZOSF("RSEL")):"ZOSF^%AAHRRSS",1:GEMSYS_"^%AAHRRSS") Q:$O(^UTILITY($J,""))=""
LIST1 R !!?1,"Select [B]lock or [L]ist: L// ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX="" GEMXX="L" I GEMXX="^" Q
 I GEMXX="?" W "   Enter 'B' or 'L'" G LIST1
 I ",B,b,L,l,"'[(","_GEMXX_",") W *7,"   ??" G LIST1
 S GEMXX=$S(GEMXX="b":"B",GEMXX="l":"L",1:GEMXX)
 D @$S(GEMXX="B":"LISTB",GEMXX="L":"LISTL",1:"")
 Q
LISTB ;Block list of programs, 8 to a line, 5 lines at a time
 NEW CNT,COL,I,X,XX S (CNT,X,XX)=0,COL=1 W !
 F I=1:1 S X=$O(^UTILITY($J,X)) Q:X=""  W:COL=1 ! W ?COL,X S COL=COL+10 I COL>75 D  Q:XX="^"
 .S COL=1,CNT=CNT+1 I '(CNT#5) D PAGE W !
 D:I=1 MSG1 W:I>1 !
 Q
LISTL ;List top line of selected programs
 NEW CNT,RTN,XX S (RTN,XX)=0 W @GEMIOF
 F CNT=1:1 S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""  D  I $Y>GEMSIZE D PAGE Q:XX="^"  W @GEMIOF,!
 .W !,$J(CNT,3),". ",RTN,?14,$E($P($T(^@RTN)," ",2,99),1,65)
 Q
SETGLB ;Put routine into global
 NEW I,TXT,X K ^TMP("PGM",$J,ARRS)
 S X=ARRPGM,^TMP("PGM",$J,ARRS,"NAME")=ARRPGM
 I '$$EXIST^%AAHRRZ(X) S ARRHIGH=0 Q
 X "ZL @ARRPGM F I=1:1 S TXT=$T(+I) Q:TXT=""""  S TXT=$P(TXT,"" "")_$C(9)_$P(TXT,"" "",2,999),^TMP(""PGM"",$J,ARRS,""TXT"",I)=TXT"
 S ARRHIGH=I-1
 Q
PAGE ;
 R !!?1,"<RETURN> to continue, '^' to quit: ",XX:GEMTIME S:'$T!($E(XX)="^") XX="^"
 Q
MSG ;Messages
MSG1 W *7,"   Invalid Program" Q
HELP ;Help text
 W !!?5,"Enter a routine name, or <RETURN> to select default routine."
 W !?5,"Enter '??' to display routine names in one of the following forms:"
 W !!?10,"BLOCK.....Routines listed 8 to a line, 5 lines at a time."
 W !?10,"LIST......Lists top line of each selected routine."
 W !!?5,"Default routine is stored in ^TMP(""A#RR"",DUZ).",!
 Q
HD ;Heading
 Q:ARRS>1  ;Don't display heading when branching to another program
 W !?1,"The Acme Routine ",$S($G(FLAGEDIT)="EDIT":"Editor",1:"Reader")," . . . . . . . . GEM III . . . . . . . . David Bolduc"
 W !?1,"^=Quit   <RETURN>=DefaultRtn   ?=Help   ??=RtnList",!
 Q
