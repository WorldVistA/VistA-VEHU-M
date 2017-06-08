%AAHGLS1 ;402,DJB,3/24/92**Check,BASIC,SKIP
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
CHKNODE ;Do not display Xref or Zero nodes
 I SUBNUM="Y" D  Q:FLAGQ
 .I $P(SUBCHK,ZDELIM,2)=0,$L(SUBCHK,ZDELIM)>2 W *7,"   This node is not viewable." S FLAGQ=1 Q
 .F I=2:2:$L(SUBCHK,ZDELIM) I +$P(SUBCHK,ZDELIM,I)'=$P(SUBCHK,ZDELIM,I) D  Q
 ..I $P(SUBCHK,ZDELIM,I)["%" W *7,"   Invalid selection ('%' Node)." S FLAGQ=1 Q
 ..S FLAGXREF=I ;Marks a Xref node
 I SUBNUM="Y",'FLAGXREF,$L(SUBCHK,ZDELIM)#2=0 S FLAGZERO=1
 I SUBNUM="N" S FLAGQ=0 D  Q:FLAGQ
 .I $P(SUBCHK,ZDELIM)=0,$L(SUBCHK,ZDELIM)>1 W *7,"   This node is not viewable." S FLAGQ=1 Q
 .F I=1:2:$L(SUBCHK,ZDELIM) I +$P(SUBCHK,ZDELIM,I)'=$P(SUBCHK,ZDELIM,I) D  Q
 ..I $P(SUBCHK,ZDELIM,I)["%" W *7,"   Invalid selection ('%' Node)." S FLAGQ=1 Q
 ..S FLAGXREF=I ;Marks a Xref node
 I SUBNUM="N",'FLAGXREF,$L(SUBCHK,ZDELIM)#2 S FLAGZERO=1
 I SUBNUM="DIC" W *7,"   Invalid selection (File of files not viewable)." S FLAGQ=1 Q
 Q:FLAGXREF!FLAGZERO
 ;Verify zero node and check for Word Processing field.
 S TEMP="" I $L(SUBCHK,ZDELIM)>2 F I=1:1:$L(SUBCHK,ZDELIM)-2 S TEMP=TEMP_$P(SUBCHK,ZDELIM,I)_","
 S TEMP=GL_"("_TEMP_"0)" I '$D(@TEMP)#2 W *7,"   This is not a valid node." S FLAGQ=1 Q
 S TEMP1=$P(@TEMP,U,2),GEMXX="" F I=1:1:$L(TEMP1) I $E(TEMP1,I)?1N!($E(TEMP1,I)?1".") S GEMXX=GEMXX_$E(TEMP1,I) ;Strip off alpha
 I GEMXX!($L(SUBCHK,ZDELIM)<4) Q
 S TEMP="" F I=1:1:($L(SUBCHK,ZDELIM)-4) S TEMP=TEMP_$P(SUBCHK,ZDELIM,I)_","
 S TEMP=GL_"("_TEMP_"0)" I '$D(@TEMP)#2 W *7,"   Invalid node." S FLAGQ=1 Q
 S GEMXX=$P(@TEMP,U,2),GEMXY="" F I=1:1:$L(GEMXX) I $E(GEMXX,I)?1N!($E(GEMXX,I)?1".") S GEMXY=GEMXY_$E(GEMXX,I) ;Strip off alpha
 I GEMXX']""!(GEMXY']"") W *7,"   Invalid node." S FLAGQ=1 Q
 S FLAGWP=1
 Q
SKIP ;Set up Skipping to another node. Also, see first line of PRINT^%AAHGLA.
 I FLAGL Q  ;Quit if last node has been displayed.
 I SKIP S SUBCHK=$$ZDELIM^%AAHGLU(GLB(STK)),SKIP=$S(SKIP<1:0,SKIP>$L(SUBCHK,ZDELIM):0,1:SKIP) I SKIP D  S:STK<1 FLAGQ=2
 .S STK=SKIP-($L(SUBCHK,ZDELIM)+1-STK)
 .S SKIPHLD=$P(SUBCHK,ZDELIM,SKIP)
 Q
BASIC ;Runs basic lister only.
 I $Y'>GEMSIZE F I=$Y:1:GEMSIZE W !
 W !,$E(GEMLINE1,1,GEMIOM),!?1,"<RETURN> to continue, '^' to quit: "
 R GEMXX:GEMTIME S:'$T GEMXX="^" I GEMXX["^" S FLAGQ=1 Q
 Q:FLAGL
 S PAGE=PAGE+1 W @GEMIOF,?(GEMIOM-14-(2*$L(PAGE))),"Page: "_PAGE_"  Top: "_PAGE,!,$E(GEMLINE1,1,GEMIOM)
 Q
CHECKFM ;Make sure Fileman is present.
 I '$D(^DD)!('$D(^DIC)) S FLAGQ=1 W *7,"  You must have VA Filemanager in this UCI to run this option."
 Q
