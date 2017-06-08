%AAHGLS2 ;402,DJB,3/24/92**Code Search,Hot key,Headings
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
CODE ;Get CODE for doing a Code Search.
 W ?15,"Variables: GLNAM=""^DIC(4,1,0)""   GL=""^DIC""   GLSUB=""4,1,0""",!?26,"GLVAL=The data in node ^DIC(4,1,0)   U=""^"""
CODE1 R !?1,"Enter Mumps Code: ",CODE:GEMTIME S:'$T CODE=0 I "^"[CODE S CODE=0
 I $E(CODE)="?" W "   If code evaluates to TRUE, node will be displayed." G CODE1
 I $F(CODE,"ZTSAV")>0 W *7,"   'ZTSAV' is used by GEM and can't be in your code." G CODE1
 I CODE'=0 S ZTSAV=$ZT,$ZT="ERROR1^%AAHGLZ" X CODE S $ZT=ZTSAV
 Q
HOT ;Code that allows HOT key to switch between globals.
 N CHK,CHKPG,FLAGQ S (CHK,CHKPG,FLAGQ)=0 F  S CHK=$O(^TMP("A#GL",$J,1,CHK)) Q:CHK=""  S CHKPG=CHK
 S FLAGHOT=$S(+FLAGHOT'=FLAGHOT:CHKPG,FLAGHOT<1:1,FLAGHOT>CHKPG:CHKPG,1:FLAGHOT)
 D HD2
 S CNTY="" F  S CNTY=$O(^TMP("A#GL",$J,1,FLAGHOT,CNTY)) Q:CNTY=""!FLAGQ  D
 .S GLNAM=^TMP("A#GL",$J,1,FLAGHOT,CNTY),GLVAL=@GLNAM
 .S GLSUB=$P($E(GLNAM,1,$L(GLNAM)-1),"(",2,99)
 .S GL=$P(GLNAM,"(")
 .W !,$J(CNTY,2),") ",$S('FLAGREV:GLNAM,1:$$GLOBNAME^%AAHGLA1(GLNAM))
 .S COL=$X,TOTAL=(GEMIOM-4-COL) W " = ",$E(GLVAL,1,TOTAL)
 .F  Q:$L(GLVAL)'>TOTAL  S TOTAL1=(TOTAL+GEMIOM-4-COL) W !?COL," = ",$E(GLVAL,TOTAL+1,TOTAL1) S TOTAL=TOTAL1
 D HOTASK Q:FLAGQ
 I Z1["?" W "   When in HOT KEY mode your options are restricted." D PAUSE G HOT
 I Z1="J" S FLAGHOT=Z2 G HOT
 I Z1="B" S FLAGHOT=FLAGHOT-1 G HOT
 I Z1="R" S FLAGREV=FLAGREV=0 G HOT
 I Z1="H" Q
 S FLAGHOT=FLAGHOT+1 I '$D(^TMP("A#GL",$J,1,FLAGHOT)) S FLAGHOT=FLAGHOT-1
 G HOT
HOTASK ;'Select:' prompt
 Q:FLAGQ
 I $Y'>GEMSIZE F I=$Y:1:GEMSIZE W !
 W !,$E(GEMLINE1,1,GEMIOM),!?1,"^,"" ""=Quit  H=Hot  B=BkUp  Jn=Jmp  R=RevVid  ?=Help"
HOTASK1 S FLAGQ=0
 R !?1,"Select: ",Z1:GEMTIME S:'$T!(Z1=" ") Z1="^" I Z1="^" S FLAGQ=1 Q
 S Z1=$S($E(Z1)=" ":"",Z1["?":"?",Z1="b":"B",Z1="h":"H",Z1="r":"R",1:Z1)
 I $E(Z1)="J"!($E(Z1)="j") S Z2=$E(Z1,2,99),Z1="J"
 I "?,B,H,J,R"'[Z1 W *7,"   Invalid entry..HOT KEY ACTIVE" G HOTASK1
 Q
PAUSE ;Pause screen
 R !?1,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
HD ;Heading
 W @GEMIOF W:CODE'=0 ?8,"* CODE SEARCH ACTIVE *" W ?45,"Session: ",GLS,?(GEMIOM-14-(2*$L(PAGE))),"Page: "_PAGE_"  Top: "_PAGE,!,$E(GEMLINE1,1,GEMIOM)
 Q
HD1 ;
 W @GEMIOF W:CODE'=0 ?8,"* CODE SEARCH ACTIVE *" W ?45,"Session: ",GLS,?(GEMIOM-14-($L(PAGETEMP)+$L(PAGE))),"Page: "_PAGETEMP_"  Top: "_PAGE,!,$E(GEMLINE1,1,GEMIOM)
 Q
HD2 ;
 W @GEMIOF W ?8,"* HOT KEY ACTIVE *",?45,"Session: ",GLS,?(GEMIOM-14-($L(FLAGHOT)+$L(CHKPG))),"Page: "_FLAGHOT_"  Top: "_CHKPG,!,$E(GEMLINE1,1,GEMIOM)
 Q
