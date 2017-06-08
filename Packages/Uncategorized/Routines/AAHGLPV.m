%AAHGLPV ;402,DJB,3/24/92**PIECES - Internal/External Value,Name
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
LISTIVAL ;Print pieces with internal values
 W @GEMIOF,!?1,"Global Pieces(INT VALUE): ",Z1,") ",GLNAM,!,$E(GEMLINE1,1,GEMIOM)
 D GETNODE S GEMXY=$O(^DD(FILE(LEV),"GL",NODE,"")) I GEMXY["E" D LISTCD,LISTPRT Q  ;MUMPS data type field
 S (NODECNT,I)=0 F  S I=$O(^DD(FILE(LEV),"GL",NODE,I)) Q:I=""  S NODECNT=I
 F I=1:1:NODECNT D  D LISTPRT
 .S GEMXX=".) "
 .I $D(^DD(FILE(LEV),"GL",NODE,I)) S TEMP=$O(^DD(FILE(LEV),"GL",NODE,I,"")) I TEMP,$D(^DD(FILE(LEV),TEMP,0)) S GEMXX=$S($P(^(0),U,2)["P":"p) ",$P(^(0),U,2)["S":"s) ",1:GEMXX)
 .S FLD=$P(GLVAL,U,I)
 Q
LISTXVAL ;Print external values for Pointers and Set Of Code fields
 W @GEMIOF,!?1,"Global Pieces(EXT VALUE): ",Z1,") ",GLNAM,!,$E(GEMLINE1,1,GEMIOM)
 D GETNODE S GEMXY=$O(^DD(FILE(LEV),"GL",NODE,"")) I GEMXY["E" D LISTCD,LISTPRT Q  ;MUMPS data type field
 S (NODECNT,I)=0 F  S I=$O(^DD(FILE(LEV),"GL",NODE,I)) Q:I=""  S NODECNT=I
 F I=1:1:NODECNT D  D LISTPRT
 .S GEMXX=".) " K TEMP
 .I $D(^DD(FILE(LEV),"GL",NODE,I)) S FLD=$O(^(I,"")) I FLD,$D(^DD(FILE(LEV),FLD,0)) S TEMP=$P(^(0),U,3),GEMXX=$S($P(^(0),U,2)["P":"p) ",$P(^(0),U,2)["S":"s) ",1:GEMXX)
 .I GEMXX="p) ",$P(GLVAL,U,I)]"",+$P(GLVAL,U,I)'=$P(GLVAL,U,I) S FLD="--> *Bad Pointer*" Q
 .I GEMXX="p) ",$P(GLVAL,U,I)]"" S TEMP="^"_TEMP_$P(GLVAL,U,I)_",0)" I $D(@TEMP) S FLD=$P(@TEMP,U) Q
 .I GEMXX="s) " S TEMP1=0 I $P(GLVAL,U,I)]"" F II=1:1:$L(TEMP,";") S GEMXY=$P(TEMP,";",II) I $P(GEMXY,":")=$P(GLVAL,U,I) S FLD=$P(GEMXY,":",2),TEMP1=1 Q
 .I GEMXX="s) ",TEMP1 Q
 .S FLD=$P(GLVAL,U,I)
 Q
LISTNAM ;Print pieces with field names
 W @GEMIOF,!?1,"Global Pieces(FLD NAME): ",Z1,") ",GLNAM,!,$E(GEMLINE1,1,GEMIOM)
 D GETNODE S GEMXY=$O(^DD(FILE(LEV),"GL",NODE,"")) I GEMXY["E" D LISTCD1,LISTPRT Q  ;MUMPS data type field
 S (NODECNT,I)=0 F  S I=$O(^DD(FILE(LEV),"GL",NODE,I)) Q:I=""  S NODECNT=I
 F I=1:1:NODECNT D  D LISTPRT
 .S GEMXX=".) "
 .I $D(^DD(FILE(LEV),"GL",NODE,I)) S FLD=$O(^DD(FILE(LEV),"GL",NODE,I,"")) I FLD,$D(^DD(FILE(LEV),FLD,0)) S FLD=$P(^(0),U),GEMXX=$S($P(^(0),U,2)["P":"p) ",$P(^(0),U,2)["S":"s) ",1:GEMXX) Q
 .S FLD="--> *Not in use*"
 Q
LISTCD ;Field is MUMPS Data Type
 S I=1,NODECNT=1,GEMXX=".) ",FLD=GLVAL
 Q
LISTCD1 ;Field is MUMPS Data Type and displaying field name
 S I=1,NODECNT=1,GEMXX=".) "
 S FLD=$O(^DD(FILE(LEV),"GL",NODE,GEMXY,""))
 I FLD,$D(^DD(FILE(LEV),FLD,0)) S FLD=$P(^(0),U) Q
 S FLD="--> *Not in use*"
 Q
LISTPRT ;Print Pieces - Either value or name. Needs NODECNT and FLD defined.
 I NODECNT<18 W !?COL,$J(I,2),GEMXX,$E(FLD,1,73) Q
 I NODECNT<35 W:COL=1 ! W ?COL,$J(I,2),GEMXX,$E(FLD,1,29) S COL=COL+39 S:COL>50 COL=1 Q
 W:COL=1 ! W ?COL,$J(I,2),GEMXX,$E(FLD,1,21) S COL=COL+26 S:COL>55 COL=1 ;Node has more than 34 pieces
 Q
GETNODE ;Get Node and Pieces. Zero node has been verified with CHKNODE^%AAHGLS1 called by ASK^%AAHGLS.
 S TEMP="" I $L(SUBCHK,ZDELIM)>2 F I=1:1:$L(SUBCHK,ZDELIM)-2 S TEMP=TEMP_$P(SUBCHK,ZDELIM,I)_","
 S TEMP=GL_"("_TEMP_"0)",TEMP1=$P(@TEMP,U,2)
 S LEV=1,FILE(LEV)=+TEMP1,NODE=$P(SUBCHK,ZDELIM,$L(SUBCHK,ZDELIM)) ;Use +TEMP1 to strip off any alph
 I +NODE'=NODE S NODE=$E(NODE,2,$L(NODE)-1) ;If NODE is alpha strip off quotes.
 Q
