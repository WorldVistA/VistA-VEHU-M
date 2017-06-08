%AAHDDI ;402,DJB,11/2/91,EDD**Indiv Fld Sum
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
 NEW A,CNT,DATA,FILE,FNAM,FNUM,LENGTH,LEV,ZDSUB
 D INIT D:FLAGP HD D GETFLD
 I FLAGP,$D(^UTILITY($J,"INDIV")) D PRINT
EX ;
 K DIC,^UTILITY($J,"INDIV") S FLAGQ=1
 Q
GETFLD ;Field lookup. Var LEV increments and decrements with Multiple layers.
 S DIC="^DD("_FILE(LEV)_",",DIC("A")=$S(LEV=1:"  Select FIELD: ",1:"  Select SUBFIELD: ") D ^DIC K DIC("A") I Y<0 S LEV=LEV-1 Q:LEV=0  G GETFLD
 S FNUM=+Y,FNAM=$P(Y,U,2),GEMXX=+$P(^DD(FILE(LEV),FNUM,0),U,2)
 I GEMXX S LEV=LEV+1,FILE(LEV)=GEMXX G GETFLD
 I 'FLAGP D ^%AAHDDI1 Q:FLAGQ  G GETFLD
 S ^UTILITY($J,"INDIV",CNT)=FILE(LEV)_"^"_FNUM_"^"_FNAM,CNT=CNT+1
 G GETFLD
PRINT ;
 W:$E(GEMIOST,1,2)="P-" "  Printing.." U IO D TXT^%AAHDDPR
 S CNT="" F  S CNT=$O(^UTILITY($J,"INDIV",CNT)) Q:CNT=""  S DATA=^UTILITY($J,"INDIV",CNT),FILE(LEV)=$P(DATA,U),FNUM=$P(DATA,U,2),FNAM=$P(DATA,U,3) D ^%AAHDDI1 Q:FLAGQ  W !!,$E(GEMLINE2,1,GEMIOM),!!
 Q
HD ;
 W @GEMIOF,!,$E(GEMLINE1,1,80),!?5,"Enter one at a time, as many fields as you wish to print. Fields will",!?5,"print in the order entered.",!,$E(GEMLINE1,1,80),!
 Q
INIT ;
 S (CNT,LEV)=1,FILE(LEV)=ZNUM K ^UTILITY($J,"INDIV")
 S DIC(0)="QEAM",DIC("W")="I $P(^DD(FILE(LEV),Y,0),U,2)>0 W ""    -->Mult Fld"""
 Q
