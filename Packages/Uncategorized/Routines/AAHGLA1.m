%AAHGLA1 ;402,DJB,3/24/92**Print Global Nodes Cont
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
GLOBNAME(GLOB) ;Write Global name with variable subscripts in reverse video.
 I GLOB'?.E1"(".E Q GLOB
 D SUBSET(GLOB) W GL_"("
 S FLAGT=0 F I=1:1:$L(SUBCHK,ZDELIM) S FLAGT1=0 D  ;FLAGT set to stop printing reverse video after a Xref.
 .I SUBNUM="Y",(I#2)=0 S:+$P(SUBCHK,ZDELIM,I)=0 FLAGT=1 I 'FLAGT W @GEMRON S FLAGT1=1
 .I SUBNUM="N",I#2 S:+$P(SUBCHK,ZDELIM,I)=0 FLAGT=1 I 'FLAGT W @GEMRON S FLAGT1=1
 .W $P(SUBCHK,ZDELIM,I) I FLAGT1 W @GEMROFF
 .W $S(I=$L(SUBCHK,ZDELIM):")",1:",")
 Q ""
SUBSET(GLOB) ;Set up variables GL,GLNAM,GLSUB,SUBCHK,SUBNUM. SUBNUM="Y" if Global root is numeric (Ex ^VA(200 ).
 Q:$G(GLOB)=""
 S GLNAM=GLOB,GL=$P(GLNAM,"("),GLSUB=$P($E(GLOB,1,$L(GLOB)-1),"(",2,99)
 S SUBCHK=$$ZDELIM^%AAHGLU(GLOB) ;replace commas with ZDELIM (if not between quotes)
 ;Next determine if file has a numeric root.
 S SUBNUM="NOFM" I GL="^DIA" Q
 S TEMP=GL_"("_$P(SUBCHK,ZDELIM)_",0)" I $D(@TEMP)#2 D
 .S GEMXX=$P(@TEMP,U) Q:GEMXX']""  I '$D(^DIC("B",GEMXX)) D  Q:'$D(^DIC("B",GEMXX))
 ..Q:$L(GEMXX)<31  F  S GEMXX=$E(GEMXX,1,$L(GEMXX)-1) Q:$L(GEMXX)<31!($D(^DIC("B",GEMXX)))  ;Allow for subscripts which are longer than 30 characters
 .I GL'="^DIC" S SUBNUM="Y" Q
 .S GEMXY=$O(^DIC("B",GEMXX,0)) I $G(^DIC(GEMXY,0,"GL"))=(GL_"("_$P(SUBCHK,ZDELIM)_",") S SUBNUM="Y"
 .E  S SUBNUM="DIC"
 .I $G(^DIC(GEMXY,0,"GL"))="" W *7,"   You are missing node ^DIC(",GEMXY,",0,""GL"")",!
 I SUBNUM="NOFM" S TEMP=GL_"(0)" I $D(@TEMP)#2 D
 .S GEMXX=$P(@TEMP,U) Q:GEMXX']""  S:$D(^DIC("B",GEMXX)) SUBNUM="N" I SUBNUM'="N" D  S:$D(^DIC("B",GEMXX)) SUBNUM="N"
 ..Q:$L(GEMXX)<31  F  S GEMXX=$E(GEMXX,1,$L(GEMXX)-1) Q:$L(GEMXX)<31!($D(^DIC("B",GEMXX)))
 Q
