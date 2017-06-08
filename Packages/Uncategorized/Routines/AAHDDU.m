%AAHDDU ;402,DJB,11/2/91,EDD**Xref,Groups,Required Fields
 ;;GEM III;;
 ;; David Bolduc - Togus, ME
XREF ;Cross Reference Listing
 I '$D(^DD(ZNUM,0,"IX")) W ?30,"No XREF for this file." S FLAGG=1 Q
 NEW GLTEMP,HD,NM,Z1,ZDD,ZFLD
 S NM="",HD="HD1" D INIT^%AAHDDPR G:FLAGQ EX D HD1
 F  S NM=$O(^DD(ZNUM,0,"IX",NM)) Q:NM=""  D:$Y>GEMSIZE PAGE Q:FLAGQ  S ZDD="",ZDD=$O(^DD(ZNUM,0,"IX",NM,ZDD)),ZFLD="",ZFLD=$O(^DD(ZNUM,0,"IX",NM,ZDD,ZFLD)) D XREFPRT
 G EX
XREFPRT ;
 S GLTEMP=ZGL_""""_NM_""""_")"
 W ! W:$D(@(GLTEMP)) ?1,"*" W ?4,"""",NM,"""",?22,$J(ZDD,8),?33,$J(ZFLD,10)
 I $D(^DD(ZDD,ZFLD,0)) W ?46,$P(^(0),U) Q
 W ?46,"---> Field doesn't exist"
 Q
 ;====================================================================
GRP ;Groups
 NEW GRP,GRP1,GRP2,HD,X,Z,Z1,ZFLD,ZMULT
 S ZMULT="",HD="HD2" D GRPBLD G:FLAGG EX D INIT^%AAHDDPR G:FLAGQ EX D HD2,GRPPRT
 G EX
GRPBLD ;
 S Z="",X=1
 F  S Z=$O(^UTILITY($J,"TMP",Z)) Q:Z=""  I $D(^DD(Z,"GR")) S GRP="" F  S GRP=$O(^DD(Z,"GR",GRP)) Q:GRP=""  S ZFLD="" F  S ZFLD=$O(^DD(Z,"GR",GRP,ZFLD)) Q:ZFLD=""  S ^UTILITY($J,"GROUP",GRP,Z,ZFLD)=$P(^DD(Z,ZFLD,0),U),X=X+1 I X#9=0 W "."
 I '$D(^UTILITY($J,"GROUP")) W ?30,"No Groups established." S FLAGG=1
 Q
GRPPRT ;
 S GRP="" F I=1:1 S GRP=$O(^UTILITY($J,"GROUP",GRP)) Q:GRP=""!FLAGQ  W !,$J(I,3),". ",GRP D GRPPRT1
 Q
GRPPRT1 ;
 S GRP1=""
 F  S GRP1=$O(^UTILITY($J,"GROUP",GRP,GRP1)) Q:GRP1=""!FLAGQ  S GRP2="" F  S GRP2=$O(^UTILITY($J,"GROUP",GRP,GRP1,GRP2)) Q:GRP2=""  W ?18,$J(GRP1,6),?27,$J(GRP2,8),?39,^(GRP2),! I $Y>GEMSIZE D PAGE Q:FLAGQ
 Q
 ;====================================================================
REQ ;Required Fields
 NEW FILE,FLD,HD,LEV,PAGE,PIECE,ZDATA
 S HD="HD" D INIT^%AAHDDPR G:FLAGQ EX D @HD,LOOP
 G EX
 ;
LOOP ;Start For Loop
 S (LEV,PAGE)=1,FILE(LEV)=ZNUM,FLD(LEV)=0 K ^UTILITY($J,"REQ")
 F  S FLD(LEV)=$O(^DD(FILE(LEV),FLD(LEV))) D  Q:'LEV!(FLAGQ)
 .I +FLD(LEV)=0 S LEV=LEV-1 Q
 .Q:'$D(^DD(FILE(LEV),FLD(LEV),0))  S ZDATA=^DD(FILE(LEV),FLD(LEV),0)
 .I $P($P(ZDATA,U,4),";",2)=0 S LEV=LEV+1,FILE(LEV)=+$P(ZDATA,U,2),FLD(LEV)=0 Q
 .Q:$P(ZDATA,U,2)'["R"
 .W !?1,$J(FLD(LEV),10),?14,$J(FILE(LEV),8),?25,$P(ZDATA,U)
 .I $Y>(GEMSIZE-1) D PAUSE Q:FLAGQ  W @GEMIOF W:$E(GEMIOST,1,2)="P-" !!! D @HD
 Q
PAUSE ;
 Q:$E(GEMIOST,1,2)="P-"
 W !!?2,"<RETURN> to continue, '^' to quit, '^^' to exit: "
 R GEMXX:GEMTIME S:'$T GEMXX="^^" I GEMXX["^" S FLAGQ=1 S:GEMXX="^^" FLAGE=1
 Q
PAUSE1 ;
 Q:$E(GEMIOST,1,2)="P-"
 R !?1,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
 ;====================================================================
EX ;Exit
 K ^UTILITY($J,"GROUP"),^UTILITY($J,"REQ")
 Q
HD ;Required Fields
 W !?1,"Required Fields..",!?2,"FLD NUM",?17,"DD",?48,"FIELD NAME"
 W !?1,"----------",?14,"--------",?25,"------------------------------------------------------"
 Q
HD1 ;XREF
 W !?9,"XREF",?25,"DD",?34,"FLD NUM",?56,"FIELD NAME",!?4,"---------------",?22,"--------",?33,"----------",?46,"------------------------------"
 Q
HD2 ;Groups
 W !?5,"GROUP NAME",?20,"DD",?27,"FLD NUM",?48,"FIELD NAME",!?5,"-----------",?18,"------",?27,"--------",?39,"------------------------------",!
 Q
PAGE ;
 I FLAGP,$E(GEMIOST,1,2)="P-" W @GEMIOF,!!! D @HD Q
 R !!?2,"<RETURN> to continue, '^' to quit, '^^' to exit: ",Z1:GEMTIME S:'$T Z1="^" I Z1["^" S FLAGQ=1 S:Z1="^^" FLAGE=1 Q
 W @GEMIOF D @HD
 Q
