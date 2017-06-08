%AAHGLR ;402,DJB,3/24/92**Process a Range of nodes
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
RANGE ;User asked for a range with ":" or ",,"
 ;Set up GLOBAL,START(),END()
 I ZGL'?.E1"(".E D ^%AAHGLA(ZGL) W:'$D(^TMP("A#GL",$J,GLS)) "   No data." Q
 NEW END,HOLD,I1,II,GLOBAL,LIMIT,START S GLOBAL=$P(ZGL,"(")
 D VARIABLE^%AAHGLR1 Q:FLAGQ  ;VARIABLE will replace any variables with their values.
 I NEWSUB[ZDELIM1 D SPACES^%AAHGLR1 Q  ;Process a range with "spaces".
 D SETPARAM I FLAGQ W *7,"   Invalid quote marks." Q  ;Process and print a range entered with ":" or ",,".
 D START I '$D(^TMP("A#GL",$J,GLS)) W "   No data."
 Q
SETPARAM ;Set starting and ending parameters
 S LIMIT=$L(NEWSUB,ZDELIM) F I=1:1:LIMIT D  Q:FLAGQ  I START(I)'=END(I) S HOLD(I)=START(I)
 .S (START(I),END(I))=$P(NEWSUB,ZDELIM,I)
 .I START(I)[ZDELIM2 S END(I)=$P(START(I),ZDELIM2,2),START(I)=$P(START(I),ZDELIM2) ;handle ":" range using ZDELIM2
 .S:START(I)="" START(I)=0 S:END(I)="" END(I)="zzzzz"
 .S $P(NEWSUB,ZDELIM,I)=START(I)
 .;Next check validity of any quote marks.
 .I START(I)?1""""1.E1"""" F II=2:1:($L(START(I))-1) Q:$E(START(I),II)'=""""&FLAGQ  I $E(START(I),II)="""" S FLAGQ=FLAGQ=0
 .Q:FLAGQ
 .I END(I)?1""""1.E1"""" F II=2:1:($L(END(I))-1) Q:$E(END(I),II)'=""""&FLAGQ  I $E(END(I),II)="""" S FLAGQ=FLAGQ=0
 Q
START ;Move up and down the subscript
 NEW ACTLEV,LOWLEV,RUNSUB,TEMPSUB,UPLEV
 S (ACTLEV,UPLEV)=LIMIT,LOWLEV=1,FLAGQ=0
 F I=1:1:UPLEV S GLX(I)=START(I)
START1 ;Set each part of subscript to correct value during looping.
 S RUNSUB="" F I=1:1:UPLEV S RUNSUB=RUNSUB_$S($G(HOLD(I))]"":HOLD(I),I=ACTLEV:GLX(I),1:START(I))_$S(I=UPLEV:"",1:ZDELIM)
 ;W !,$$TRAN^%AAHGLU(GLOBAL_"("_RUNSUB_")") R XXX ;Used for tracking the subscript when a range was specified.
 D ^%AAHGLA($$TRAN^%AAHGLU(GLOBAL_"("_RUNSUB_")")) Q:FLAGQ
START2 ;Now get new values for RUNSUB
 Q:ACTLEV<LOWLEV
 S TEMPSUB="" F I=1:1:ACTLEV S TEMPSUB=TEMPSUB_$S($G(HOLD(I))]"":HOLD(I),I=ACTLEV:GLX(I),1:START(I))_$S(I=ACTLEV:"",1:ZDELIM)
 S GLX(ACTLEV)=$O(@$$TRAN^%AAHGLU(GLOBAL_"("_TEMPSUB_")")) I +GLX(ACTLEV)'=GLX(ACTLEV),GLX(ACTLEV)'="" D QUOTES S GLX(ACTLEV)=""""_GLX(ACTLEV)_""""
 I GLX(ACTLEV)="" D RESET G START2
 I +GLX(ACTLEV)=GLX(ACTLEV),+END(ACTLEV)=END(ACTLEV),GLX(ACTLEV)>END(ACTLEV) D RESET G START2
 I +GLX(ACTLEV)'=GLX(ACTLEV),+END(ACTLEV)'=END(ACTLEV),GLX(ACTLEV)]END(ACTLEV) D RESET G START2
 I +GLX(ACTLEV)'=GLX(ACTLEV),+END(ACTLEV)=END(ACTLEV) D RESET G START2
 I $G(HOLD(ACTLEV))]"" S HOLD(ACTLEV)=GLX(ACTLEV),ACTLEV=UPLEV ;HOLD(ACTLEV) handles ranges like ^DIC(3,,1:200
 G START1
 ;
QUOTES ;If GLX(ACTLEV) contains quotes, convert to double quotes
 I GLX(ACTLEV)["""" S GEMXX=0 F  S GEMXX=GEMXX+1 Q:$E(GLX(ACTLEV),GEMXX)=""  I $E(GLX(ACTLEV),GEMXX)="""" S GLX(ACTLEV)=$E(GLX(ACTLEV),1,GEMXX-1)_""""""_$E(GLX(ACTLEV),GEMXX+1,99) S GEMXX=GEMXX+1
 Q
RESET ;Set HOLD to current value and go back up to UPLEV
 S:$G(HOLD(ACTLEV))]"" HOLD(ACTLEV)=START(ACTLEV) S GLX(ACTLEV)=START(ACTLEV),ACTLEV=ACTLEV-1
 Q
