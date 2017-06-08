%AAHDDL1 ;402,DJB,11/2/91,EDD**Fld Global Location - Screens
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
SCREEN ;Locate starting point for selected screen
 NEW CNT,CNT1,SCRNCNT S SCRNCNT=^UTILITY($J,"TOT")/17 S:SCRNCNT=0 SCRNCNT=1 S:SCRNCNT["." SCRNCNT=SCRNCNT\1+1
 D GETSCRN G:FLAGQ EX D LOOP
EX ;
 Q
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
GETSCRN ;Get screen
 W !?2,"Enter Starting Screen (1-",SCRNCNT,"): "
 R SCREEN:GEMTIME S:'$T SCREEN="^^" S:SCREEN="" SCREEN="^" I SCREEN["^" S FLAGQ=1 S:SCREEN="^^" FLAGE=1 Q
 I SCREEN["?" W !?10,"This file has ",SCRNCNT,$S(SCRNCNT>1:" screens.",1:" screen.")," Enter a number from 1 to ",SCRNCNT," and I will",!?10,"start the listing at that screen." G GETSCRN
 I SCREEN<1!(SCREEN>SCRNCNT) W *7,"  Enter a number from 1 to ",SCRNCNT,".." G GETSCRN
 Q
LOOP ;Loop through ^DD to get starting field
 W "  Please wait.."
 S CNT1=(SCREEN-1*17)+1,CNT=1 F  S FLD(LEV)=$O(^DD(FILE(LEV),FLD(LEV))) D  Q:CNT=CNT1  S CNT=CNT+1 I CNT#50=0 W CNT F I=1:1:$L(CNT) W *8
 .I +FLD(LEV)=0 S LEV=LEV-1 S CNT=CNT-1 Q
 .S ZDATA=^DD(FILE(LEV),FLD(LEV),0) I $P($P(ZDATA,U,4),";",2)'=0 Q  ;Field not a multiple
 .S LEV=LEV+1,FILE(LEV)=+$P(ZDATA,U,2),FLD(LEV)=0
 Q
