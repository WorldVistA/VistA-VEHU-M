%AAHDDD1 ;402,DJB,11/2/91,EDD**Data Type,Access
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
GETTYPE ;Select data type for DATA Option
 W !?1,"Select DISPLAY TYPE: EN//",?50,"[Display Types: E I EN IN]" F I=1:1:50 W *8
 R ZDIQ:GEMTIME S:'$T ZDIQ="^^" I ZDIQ["^" S FLAGQ=1 S:ZDIQ="^^" FLAGE=1 Q
 I ZDIQ["?" D HELP G GETTYPE
 S:ZDIQ="" ZDIQ="EN"
 S ZDIQ=$S(ZDIQ="e":"E",ZDIQ="i":"I",ZDIQ="en":"EN",ZDIQ="in":"IN",1:ZDIQ)
 I ",E,I,EN,IN,"'[(","_ZDIQ_",") W *7,"  ??" G GETTYPE
 S TYPE=$S(",E,EN,"[(","_ZDIQ_","):"E",1:"I")
 Q
HELP ;
 W !?10,"'E' Display external value of fields",!?10,"'I' Display internal value of fields",!?9,"'EN' Display external value of fields and ignore null fields",!?9,"'IN' Display internal value of fields and ignore null fields"
 Q
ACCESS ;Check users READ access
 NEW DIFILE,DIAC
 Q:DUZ(0)["@"!('$D(^DIC(ZNUM,0,"RD")))
 I ^DD("VERSION")<18 D:DUZ(0)'=^DIC(ZNUM,0,"RD") MSG Q
 S DIFILE=ZNUM,DIAC="RD" D ^DIAC I DIAC<1 D MSG
 Q
MSG ;Access message
 S FLAGQ=1 W *7,!!?2,"You do not have READ access to the ",ZNAM," file." R !!?2,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
PRINT ;Print Field(s)
 W @GEMIOF D HD S FILE=""
 F  S FILE=$O(^UTILITY("DIQ1",$J,FILE)) Q:FILE=""!FLAGQ  S DA="" F  S DA=$O(^UTILITY("DIQ1",$J,FILE,DA)) Q:DA=""!FLAGQ  S FLD="" F  S FLD=$O(^UTILITY("DIQ1",$J,FILE,DA,FLD)) Q:FLD=""!FLAGQ  D  I $Y>GEMSIZE D PAGE
 .I $D(^UTILITY("DIQ1",$J,FILE,DA,FLD,TYPE)) W !,$J($P(^DD(FILE,FLD,0),U),20),":  ",^UTILITY("DIQ1",$J,FILE,DA,FLD,TYPE) Q
 .W !!,$J($P(^DD(FILE,FLD,0),U),20),":   Word Processing" I $Y>GEMSIZE D PAGE Q:FLAGQ
 .S WP="" F  S WP=$O(^UTILITY("DIQ1",$J,FILE,DA,FLD,WP)) Q:WP=""  W !,^UTILITY("DIQ1",$J,FILE,DA,FLD,WP) I $Y>GEMSIZE D PAGE Q:FLAGQ
 .W !
 Q:FLAGE
 W:'$D(^UTILITY("DIQ1",$J)) !?2,"No data in requested fields." W !,$E(GEMLINE,1,GEMIOM)
 Q
PAGE ;Page
 R !!?2,"<RETURN> to continue, '^' to quit, '^^' to exit: ",ANS:GEMTIME S:'$T ANS="^^" I ANS["^" S FLAGQ=1 S:ANS="^^" FLAGE=1 Q
 W @GEMIOF Q
HD ;Heading
 I FLAGLONG W *7,!?2,"NOTE: You asked for too many fields. I will display as many as I can.",!
 W !?29,"D A T A   D I S P L A Y",!?2,"File: ",ZNAM,!,$E(GEMLINE,1,GEMIOM)
 Q
