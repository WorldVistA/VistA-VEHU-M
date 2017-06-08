%AAHGLA(ZGR) ;402,DJB,3/24/92**Print Global Nodes
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
 ;ZGR contains starting point, such as ^VA(200).
 I FLAGOPEN NEW GLB,SKIP,SKIPHLD,STK S (SKIP,SKIPHLD)=0,STK=1,GLB(STK)=ZGR D:$D(@GLB(STK))#2 PRINT Q
 NEW ZCHK,ZORD,GLB,SKIP,SKIPHLD,STK
 S STK=1,GLB(STK)=ZGR,ZORD(STK)="",(SKIP,SKIPHLD)=0
LOOP ;Loop to increment and decrement STK to go up and down the subscript.
 S ZCHK=$D(@GLB(STK)) D:ZCHK#2 PRINT Q:FLAGQ  I ZCHK=0 S STK=STK-1 Q:STK=0
LOOP1 ;When ZORD(STK) is null come here
 ;Next 2 lines: I ZORD(STK) contains double quotes, convert to single quotes.
 I ZORD(STK)["""""" D  S ZORD(STK)=GEMXX
 .S GEMXX="" F I=1:1:$L(ZORD(STK),"""""") S GEMXX=GEMXX_$P(ZORD(STK),"""""",I)_$S(I'=$L(ZORD(STK),""""""):"""",1:"")
 S ZORD(STK)=$O(@GLB(STK)@(ZORD(STK))) I ZORD(STK)="" S STK=STK-1 Q:STK=0  G LOOP1
 ;Next line: If ZORD(STK) contains quotes, convert to double quotes
 I ZORD(STK)["""" S GEMXX=0 F  S GEMXX=GEMXX+1 Q:$E(ZORD(STK),GEMXX)=""  I $E(ZORD(STK),GEMXX)="""" S ZORD(STK)=$E(ZORD(STK),1,GEMXX-1)_""""""_$E(ZORD(STK),GEMXX+1,99) S GEMXX=GEMXX+1
 I GLB(STK)?.E1")" S GEMXX=$E(GLB(STK),1,$L(GLB(STK))-1)_","""_ZORD(STK)_""")",STK=STK+1,ZORD(STK)="",GLB(STK)=GEMXX G LOOP
 S GEMXX=ZGL_"("""_ZORD(STK)_""")",STK=STK+1,GLB(STK)=GEMXX,ZORD(STK)="" G LOOP
 ;==================================================================
PRINT ;Print a single node
 ;Next line processes Skipping to another node.
 I SKIP S SUBCHK=$$ZDELIM^%AAHGLU(GLB(STK)) Q:$P(SUBCHK,ZDELIM,SKIP)=SKIPHLD  S (SKIP,SKIPHLD)=0
 I FLAGC S SUBCHK=$$ZDELIM^%AAHGLU(GLB(STK)) Q:FLAGC1="NP"&($L(SUBCHK,ZDELIM)<FLAGC)  Q:FLAGC1="P"&($L(SUBCHK,ZDELIM)'=FLAGC)  ;Restrict levels because user entered commas.
 I 'FLAG1ST S FLAG1ST=1 W @GEMIOF,?45,"Session: ",GLS,?(GEMIOM-14-(2*$L(PAGE))),"Page: "_PAGE_"  Top: "_PAGE,!,$E(GEMLINE1,1,GEMIOM)
 S GLNAM=GLB(STK),GL=$P(GLNAM,"("),GLVAL=@GLB(STK),GLSUB=$P($E(GLNAM,1,$L(GLNAM)-1),"(",2,99)
 ;Next strip quotes from numeric subscripts.
 F I=1:1 S GEMXX=$P(GLSUB,",",I) Q:GEMXX=""  I GEMXX?1"""".E1"""" S GEMXX=$E(GEMXX,2,$L(GEMXX)-1) I +GEMXX=GEMXX S $P(GLSUB,",",I)=GEMXX
 I GLSUB]"" S GLNAM=GL_"("_GLSUB_")"
 I CODE'=0 X CODE E  R GEMXX#1:0 S:$T CODE=0 Q
 W !,$J(CNT,2),") ",$S('FLAGREV:GLNAM,1:$$GLOBNAME^%AAHGLA1(GLNAM))
 S ^TMP("A#GL",$J,GLS,PAGE,CNT)=GLNAM,CNT=CNT+1
 S GLVAL1=GLVAL,COL=$X,TOTAL=(GEMIOM-4-COL) I COL>80 S COL=(COL-79),TOTAL=(GEMIOM-4-COL)
 I TOTAL>0 W " = "_$E(GLVAL1,1,TOTAL) S GLVAL1=$E(GLVAL1,(TOTAL+1),999)
 I $Y>AGLSIZE(GLS) D ^%AAHGLS Q:FLAGQ
 I TOTAL<30 S TOTAL=65,COL=10 ;Make allowances if subscript is too long
PRINT1 ;Use GOTO to conserve stack levels
 Q:GLVAL1=""
 W !?COL," = "_$E(GLVAL1,1,TOTAL) D:$Y>AGLSIZE(GLS) ^%AAHGLS Q:FLAGQ  S GLVAL1=$E(GLVAL1,(TOTAL+1),999)
 G PRINT1
