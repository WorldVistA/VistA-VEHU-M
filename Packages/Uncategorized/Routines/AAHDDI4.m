%AAHDDI4 ;402,DJB,11/2/91,EDD**Indiv Fld Sum - Ref Number
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 NEW FLAGDASH,FLAGREF,REF
 F  D GETREF Q:FLAGQ  D PRINT Q:FLAGQ
 Q
GETREF ;Select Reference Number
 NEW I,REF1 S (FLAGDASH,FLAGREF)=0
 W !?1,"Enter REF Number or Range: "
 R REF#200:GEMTIME S:'$T REF="^^" I $L(REF)=200 S GEMXX=$L(REF,",")-1,REF=$P(REF,",",1,GEMXX) K GEMXX
 S:REF="" REF="^" I REF["^" S FLAGQ=1 S:REF="^^" FLAGE=1 Q
 I REF["?" W ?35,"Enter number from REF column, or a range",!?35,"of numbers. (Ex. 3-15 or 1,4,17)." G GETREF
 I REF["-",$P(REF,"-",2)'>$P(REF,"-") D ERROR G GETREF
 I REF["-" S FLAGDASH=1 F REF1=$P(REF,"-"):1:$P(REF,"-",2) Q:FLAGREF  D
 .I REF1']"" D ERROR Q
 .I '$D(^UTILITY($J,"LIST","REF",REF1)) D ERROR Q
 G:FLAGREF GETREF Q:FLAGDASH
 I 'FLAGREF F I=1:1:$L(REF,",") S REF1=$P(REF,",",I) D  Q:FLAGREF
 .I REF1']"" D ERROR Q
 .I '$D(^UTILITY($J,"LIST","REF",REF1)) D ERROR Q
 G:FLAGREF GETREF
 Q
PRINT ;Print Indiv Fld Sum
 NEW FILE,FNAM,FNUM,I,LEV,REF1
 I FLAGDASH F REF1=$P(REF,"-"):1:$P(REF,"-",2) D  Q:FLAGQ
 .S LEV=1,FILE(LEV)=$P(^UTILITY($J,"LIST","REF",REF1),U),FNUM=$P(^(REF1),U,2),FNAM=$P(^DD(FILE(LEV),FNUM,0),U)
 .D ^%AAHDDI1 Q:FLAGQ
 .I REF1'=$P(REF,"-",2) R !?2,"<RETURN> for next field..",GEMXX:GEMTIME
 Q:FLAGQ!FLAGDASH
 F I=1:1:$L(REF,",") D  Q:FLAGQ
 .S REF1=$P(REF,",",I),LEV=1,FILE(LEV)=$P(^UTILITY($J,"LIST","REF",REF1),U),FNUM=$P(^(REF1),U,2),FNAM=$P(^DD(FILE(LEV),FNUM,0),U)
 .D ^%AAHDDI1 Q:FLAGQ
 .I I<$L(REF,",") R !?2,"<RETURN> for next field..",GEMXX:GEMTIME
 Q
ERROR ;Invalid response
 W *7,"  Not a valid response." S FLAGREF=1
 Q
