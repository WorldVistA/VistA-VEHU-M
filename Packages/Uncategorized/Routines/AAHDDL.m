%AAHDDL ;402,DJB,11/2/91,EDD**Fld Global Location
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
PRINT ;Called by START,LOOP
 Q:'$D(^DD(FILE(LEV),FLD(LEV),0))
 S ZDATA=^DD(FILE(LEV),FLD(LEV),0),FLDNAM=$P(ZDATA,U),NP=$S($P(ZDATA,U,4)=" ; ":"Computed",1:$P(ZDATA,U,4))
 S PIECE=$P($P(ZDATA,U,4),";",2),MULT=$S(PIECE'=0:"",1:"<-Mult "_+$P(ZDATA,U,2))
 W ! W:'FLAGP $S(PIECE=0:" ",1:$J(RCNT,3)) W ?5,DASHES_NP,?19,$J(FLD(LEV),8),?29,DASHES,FLDNAM W:PIECE=0 ?(GEMIOM-$L(MULT)-1),MULT
 I MULT]"" F II=1:1:(GEMIOM-$L(FLDNAM)-$L(MULT)-$L(DASHES)-30) S MULT=" "_MULT
 I 'FLAGP S ^UTILITY($J,"LIST",PAGE,PCNT)=$S(PIECE=0:" ",1:RCNT)_"^"_(DASHES_NP)_"^"_FLD(LEV)_"^"_DASHES_FLDNAM_MULT
 I PIECE'=0 S ^UTILITY($J,"LIST","REF",RCNT)=FILE(LEV)_"^"_FLD(LEV),RCNT=RCNT+1
 S PCNT=PCNT+1,SCNT=SCNT+1 ;PCNT starts over each page. RCNT is for REF column, SCNT is for subdivisions
 Q
EN ;Entry Point
 NEW A,BAR,PCNT,DASHES,FILE,FLD,FLDNAM,HD,II,LENGTH,LEV,MULT,NP,PAGE,PAGETEMP,PIECE,RCNT,SCNT,SCREEN,SFLD,SPACE,SUB,SUBCNT,SUBSEL,SUBTEXT,TOT,Z1,ZDATA,ZDSUB
 D ASK G:FLAGQ EX
 S HD="HD" D INIT^%AAHDDPR G:FLAGQ EX D @HD,START,LOOP
EX ;
 I FLAGQ!FLAGE!FLAGP S:$E(GEMIOST,1,2)="P-" FLAGQ=1 D KILL Q
 S FLAGL=1 D ^%AAHDDL2 S:'FLAGQ FLAGQ=1 D KILL
 Q
KILL ;Kill ^UTILITY global
 K ^UTILITY($J,"LIST") Q
ASK ;
 W !?24,"""F""........ to select Starting Field",!?24,"""S""........ to select Starting Screen",!?24,"<RETURN>... for all Fields"
ASK1 W !?28,"Select: ALL// " R SFLD:GEMTIME S:'$T SFLD="^" I SFLD["^" S FLAGQ=1 S:SFLD="^^" FLAGE=1 Q
 I SFLD="?" W !?10,"Type ""^"" to quit",!?10,"<RETURN> to see all fields",!?10,"""F"" to start listing at a particular field",!?10,"""S"" to start listing at a particular screen" G ASK1
 S SFLD=$S(SFLD="f":"F",SFLD="s":"S",1:SFLD)
 S (LEV,PAGE,PCNT,RCNT,SCREEN)=1,FILE(LEV)=ZNUM,FLD(LEV)=0,DASHES="",SCNT=0
 I SFLD="F" S SCREEN="***" W ! S DIC="^DD("_ZNUM_",",DIC(0)="QEAM",DIC("W")="I $P(^DD(ZNUM,Y,0),U,2)>0 W ?65,""  -->Mult""",DIC("A")="  Select FIELD: " D ^DIC K DIC("A"),DIC("W") S:Y<0 FLAGQ=1 Q:Y<0  S FLD(LEV)=+Y
 I SFLD="S" W ! D SCREEN^%AAHDDL1 Q:FLAGQ
 S ^UTILITY($J,"LIST",PAGE,"SCRN")=SCREEN
 Q
START ;Print if data, otherwise continue to loop.
 I $D(^DD(FILE(LEV),FLD(LEV),0))#2 D DASHES,PRINT I PIECE=0 S LEV=LEV+1,FILE(LEV)=+$P(ZDATA,U,2),FLD(LEV)=0
 Q
LOOP ;Start For Loop
 S FLD(LEV)=$O(^DD(FILE(LEV),FLD(LEV))) I +FLD(LEV)=0 S LEV=LEV-1 G:LEV LOOP Q
 D DASHES,PRINT I PIECE=0 S LEV=LEV+1,FILE(LEV)=+$P(ZDATA,U,2),FLD(LEV)=0
 I $Y>GEMSIZE D:'FLAGP ^%AAHDDL2 Q:FLAGQ  I FLAGP D PAUSE^%AAHDDU Q:FLAGQ  W @GEMIOF W:$E(GEMIOST,1,2)="P-" !!! D HD
 G LOOP
DASHES ;Set dashes for mult level flds
 S (SPACE,BAR)="" F II=1:1:LEV-1 S SPACE=SPACE_" ",BAR=BAR_"-"
 S DASHES=SPACE_BAR
 Q
HD ;
 I 'FLAGP W ?6,"Screen: ",SCREEN,?59,"Page: ",PAGE,"   Top: ",PAGE,!,$E(GEMLINE1,1,GEMIOM)
 W ! W:'FLAGP "REF" W ?5,"NODE ; PIECE",?19,"FLD NUM",?49,"FIELD NAME"
 W ! W:'FLAGP "---" W ?5,"------------",?19,"--------",?29,"--------------------------------------------------"
 Q
