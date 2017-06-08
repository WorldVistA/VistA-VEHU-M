%AAHDDT ;402,DJB,11/2/91,EDD**Trace a Field
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
EN ;
 NEW CNT,DATA,FLD,FLD1,FLDCNT,I,LEVEL,MAR,MAR1,Z1,ZDD,ZNAME,ZNUMBER
 K ^UTILITY($J,"FLD")
 I FLAGP D PRINT^%AAHDDPR ;Turn off printing
 D GETFLD G:FLAGQ EX D LIST G:FLAGG!(FLAGE) EX
 D TRACE G:FLAGQ EX D PRINT,ASK
EX ;
 K ^UTILITY($J,"FLD") S FLAGQ=1
 Q
GETFLD ;
 R !?2,"Enter Field Name: ALL FIELDS//",FLD:GEMTIME S:'$T FLD="^^" I FLD["^" S FLAGQ=1 S:FLD="^^" FLAGE=1 Q
 I FLD="?" W !?2,"Enter field name or any portion of name. I will display the field's path.",!?2,"Use this option if you get ""beeped"" in the INDIVIDUAL FIELD SUMMARY because",!?2,"the field is decendent from a multiple." G GETFLD
 Q
LIST ;
 S ZDD="",FLDCNT=1
 F  S ZDD=$O(^UTILITY($J,"TMP",ZDD)) Q:ZDD=""!(FLAGQ)  S LEVEL=$P(^(ZDD),U,2),ZNAME="" F  S ZNAME=$O(^DD(ZDD,"B",ZNAME)) Q:ZNAME=""  I $E(ZNAME,1,$L(FLD))=FLD D LIST1 Q:FLAGQ
 I '$D(^UTILITY($J,"FLD")) W ?50,"No such field." S FLAGG=1
 S FLAGQ=0 Q
LIST1 ;
 S ZNUMBER=$O(^DD(ZDD,"B",ZNAME,"")) Q:^DD(ZDD,"B",ZNAME,ZNUMBER)=1
 D:FLDCNT=1 HD
 W ! W:$P(^DD(ZDD,ZNUMBER,0),U,2)>0 "Mult->" W ?6,$J(FLDCNT,3),".",?LEVEL*5+6,"  ",ZNAME,"  (",ZNUMBER,")"
 S ^UTILITY($J,"FLD",FLDCNT)=ZNAME_"^"_ZDD_"^"_ZNUMBER_"^"_LEVEL
 S FLDCNT=FLDCNT+1
 D:$Y>GEMSIZE PAGE Q:FLAGQ
 Q
TRACE ;If more than one match do NUM
 R !!?2,"Select Number: ",FLD1:GEMTIME S:'$T FLD1="^^" S:FLD1="" FLD1="^" I FLD1["^" S FLAGQ=1 S:FLD1="^^" FLAGE=1 Q
 I FLD1<1!(FLD1>(FLDCNT-1)) W *7,!?2,"Enter a number from the left hand column." G TRACE
 S CNT=1,ZNAME(CNT)=$P(^UTILITY($J,"FLD",FLD1),U),ZNUMBER(CNT)=$P(^(FLD1),U,3),ZDD=$P(^(FLD1),U,2)
 Q:ZDD=ZNUM
 F  S CNT=CNT+1,ZNUMBER(CNT)=$P(^UTILITY($J,"TMP",ZDD),U,3),ZDD=^DD(ZDD,0,"UP"),ZNAME(CNT)=$P(^DD(ZDD,ZNUMBER(CNT),0),U) Q:ZDD=ZNUM
 Q
PRINT ;Print data.
 W @GEMIOF,!!!,?GEMIOM\2-11,"F I E L D    T R A C E",!,$E(GEMLINE1,1,GEMIOM)
 S MAR=5,MAR1=15
 F  W !!?MAR,ZNUMBER(CNT),?MAR1,ZNAME(CNT) S CNT=CNT-1 Q:CNT=0  S MAR=MAR+5,MAR1=MAR1+5
 Q
ASK ;
 I $Y'>GEMSIZE F I=$Y:1:GEMSIZE W !
 W !,$E(GEMLINE1,1,GEMIOM)
 W !?2,"(<RETURN>=Main Menu)  ('I'=Individual Field Summary)"
ASK1 R !?2,"Select: ",Z1:GEMTIME S:'$T Z1="^^" I Z1="^^" S FLAGE=1
 I Z1="?" W *7,!?2,"See menu on line above." G ASK1
 S:Z1="i" Z1="I" I Z1="I" D ^%AAHDDI
 Q
PAGE ;
 R !!?2,"<RETURN> to continue, '^' to quit, '^^' to exit: ",Z1:GEMTIME S:'$T Z1="^" I Z1["^" S FLAGQ=1 S:Z1="^^" FLAGE=1 Q
 D HD Q
HD ;Trace a field
 W @GEMIOF,!!,"MULTIPLE",?13,"1    2    3    4    5    6    7",!,"LEVELS",?13,"|    |    |    |    |    |    |",!,$E(GEMLINE,1,GEMIOM),!
 Q
