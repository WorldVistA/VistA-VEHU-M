%AAHGL ;402,DJB,3/24/92**Acme Global Lister
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
EN ;Entry point
 I $G(DUZ)'>0 D ID Q:$G(DUZ)=""
 I $G(FLAGARR)'="ARR",$G(FLAGEDD)'="EDD",$G(DUZ)'>0 D ID Q:$G(DUZ)=""
 S $ZT="ERROR^%AAHGLZ"
 ;================================================================
START ;
 I '$D(GEMIOF) K FLAGAGL,FLAGARR,FLAGEDD
 NEW ZGL,CHK,CNT,CNTX,CNTY,CODE,COL,DATA,I,II,NEWSUB,NODE,PAGE,SUBCHK,SUBNAM,SUBNUM,TEMP,TEMP1,TOTAL,TOTAL1,Z1,Z2,ZDSUB
 NEW GL,GLNAM,GLSUB,GLVAL,GLVAL1,GLX
 NEW FLAG1ST,FLAGC,FLAGC1,FLAGE,FLAGL,FLAGOPEN,FLAGQ,FLAGREV,FLAGT,FLAGT1,FLAGWP,FLAGXREF,FLAGZERO
 I $G(FLAGAGL)'="AGL" NEW AGLSIZE,FLAGAGL,FLAGLIST,GLS,PARTAGL1,PARTAGL2,ZDELIM,ZDELIM1,ZDELIM2,ZTSAV K ^TMP("A#GL",$J) S:$G(GEMXX)="TAG-S" AGLSIZE(1)="*58*" S:$G(GEMXX)="TAG-B" FLAGLIST="BASIC" K GEMXX
 I $G(FLAGEDD)'="EDD",$G(FLAGAGL)'="AGL",$G(FLAGARR)'="ARR" NEW GEMIOF,GEMIOM,GEMIOSL,GEMIOST,GEMLINE,GEMLINE1,GEMLINE2,GEMRON,GEMROFF,GEMSIZE,GEMTIME,U,GEMXX,GEMXY
 I $G(FLAGLIST)'="BASIC",$G(FLAGAGL)'="AGL" S FLAGQ=0 D PART^%AAHGLZ Q:FLAGQ  ;Check partition size
 D INIT^%AAHGLZ
 S AGLSIZE(GLS)=$S($G(AGLSIZE(GLS))?1"*"1.N1"*":$E(AGLSIZE(GLS),2,$L(AGLSIZE(GLS))-1),1:GEMSIZE) ;Sets length of screen display in ^%AAHGLA.
 S FLAGAGL="AGL" D:GLS=1 HD^%AAHGLU ;Marks the start of AGL so an alternate session doesn't set up unneeded variables.
TOP ;Start of Loop
 S (CODE,FLAGC,FLAGC1,FLAGL,FLAGOPEN,FLAGQ,FLAGREV,FLAG1ST)=0,(CNT,PAGE)=1 K ^TMP("A#GL",$J,GLS)
 D GETGL G:FLAGQ=1 EX G:FLAGQ=2 TOP D ^%AAHGLR
 I 'FLAGQ,$D(^TMP("A#GL",$J,GLS)) S FLAGL=1 NEW SKIP D ^%AAHGLS ;Handles final screen
 G TOP
EX ;
 K ^TMP("A#GL",$J,GLS) S GLS=GLS-1
 Q
 ;====================================================================
GETGL ;Get Global
 W !?1,"Session ",GLS,"...Global ^"
 R ZGL:GEMTIME S:'$T ZGL="^" I "^"[ZGL S FLAGQ=1 Q
 I ZGL=" " D GETFILE^%AAHGLU I ZGL']"" S FLAGQ=2 Q  ;User can now enter File name or number.
 I $E(ZGL)="?" D ^%AAHGLH W !! D HD^%AAHGLU G GETGL
 I ZGL="*D" W @GEMIOF D ^%GD G GETGL
 I ZGL="*%D" W @GEMIOF D LIB^%GD G GETGL
 I ZGL'?1"^".E S ZGL="^"_ZGL
 I $E(ZGL,2)'="%",$E(ZGL,2)'="[",$E(ZGL,2)'?1U W *7,"  Global name must begin with uppercase or '%'." G GETGL
 I ZGL?.E1."," D  S FLAGC1="NP" ;FLAGC used in PRINT^%AAHGLA to limit subscript levels to that marked by commas.
 .F  Q:ZGL'?.E1","  S FLAGC=FLAGC+1,ZGL=$E(ZGL,1,$L(ZGL)-1)
 I ZGL?.E1.","1")" S ZGL=$E(ZGL,1,$L(ZGL)-1) D  S FLAGC1="P"
 .F  Q:ZGL'?.E1","  S FLAGC=FLAGC+1,ZGL=$E(ZGL,1,$L(ZGL)-1)
 I ZGL?.E1"(".E1")" S FLAGOPEN=1 ;FLAGOPEN notes if right parenthesis was entered.
 I ZGL?.E1"(" S ZGL=$P(ZGL,"(")
 I ZGL?.E1"(".E,ZGL'?.E1")" S ZGL=ZGL_")"
 S TEMP=$P(ZGL,"(") D  Q:FLAGQ
 .I TEMP["[" S:TEMP'?1"^"1"["""1.AN1""","""1.AN1"""]".E FLAGQ=2 S:($P(TEMP,"]",2)'?1"%".AN)&($P(TEMP,"]",2)'?1U.AN) FLAGQ=2 W:FLAGQ "   Invalid global name." Q
 .I TEMP'?1"^".1P.AN S FLAGQ=2 W "   Invalid global name."
 S NEWSUB=$$ZDELIM^%AAHGLU(ZGL) ;Replace commas,spaces,colons (if not between quotes) with variable ZDELIM,ZDELIM1, or ZDELIM2
 I FLAGQ=2 W *7,"   Invalid subscript." Q
 I FLAGC S FLAGC=FLAGC+($L(NEWSUB,ZDELIM))
 I NEWSUB="" S ZGL=$P(ZGL,"(")
 Q
P ;Call here if KERNEL isn't running. This call is no longer needed.
 I $G(DUZ)'>0 D ID Q:$G(DUZ)=""
 G EN
S ;Call here to set page length to 58.
 I $G(DUZ)'>0 D ID Q:$G(DUZ)=""
 S GEMXX="TAG-S" G EN
B ;Call here to run basic lister beause your partition space is not big enough to run ^%AAHGL.
 I $G(DUZ)'>0 D ID Q:$G(DUZ)=""
 S GEMXX="TAG-B" G EN
ID ;Get DUZ
 I $D(^XUSEC(0)) D ^XUP Q  ;KERNEL loaded
 S DUZ=0,DUZ(0)=$S($G(DUZ(0))]"":DUZ(0),1:"@")
 Q
