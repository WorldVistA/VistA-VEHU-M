DENTVDD ;DSS/SGM - CALLS FROM DENTAL DDs ;03/19/2002 22:35
 ;;1.2;DENTAL;**30,35,36,31**;Aug 10, 2001
 ;the various entry points here are called from data dictionary elements
 ;They may also be invoked by dentv* routines
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  -----------------------------------------
 ;  2052      x      FIELD^DID
 ;  2055      x      DILFD: $$EXTERNAL,$$VFIELD
 ;  2056      x      $$GET1^DIQ
 ; 10103      x      FMTE^XLFDT
 ; 10104      x      $$UP^XLFSTR
 ; 10142      x      EN^DDIOL
 ;
 ;=========================== file 228 =================================
EXH(XRF) ;executable help on fields 5 & 6 in file 228
 ;  XRF = xref subscript from fields 5 & 6
 N SUB,I,Z S Z=""
 F I=1:1 S Z=$O(^DENT(228,XRF,Z)) Q:Z=""  S SUB(I)="   "_Z
 D EN^DDIOL(.SUB)
 Q
 ;
FLD() Q $P(^DENT(228,DA,0),U,4) ;  return field# for file 221
 ;
FLD4(F) ;  input transform on ^DD(228,4)
 ;  Ensures that value entered here is compatible with
 ;  corresponding field in file 221
 ;  F - optional - field number for file 221
 ;     if F="" then assumes DA (file 228) exists
 N %,Y,AX,AY,AZ,DIERR,DSI,DSIERR,DSINP,DSIX,SUB
 S SUB=$S($G(F):F,1:$$FLD),DSIX=X
 ;  must have field pointer
 I 'SUB K X Q
 ;  check for calid field number
 I '$$VFIELD^DILFD(221,SUB) K X Q
 D FIELD^DID(221,SUB,,"INPUT TRANSFORM;SPECIFIER","DSI","DSIERR")
 S X=DSIX
 ;  if field is set of codes, check if valid code
 I DSI("SPECIFIER")["S",$$EXTERNAL^DILFD(221,SUB,,X,"DIERR")="" K X Q
 ;  execute input transform
 S AX=DSI("INPUT TRANSFORM") Q:"Q"[AX
 S AY=",*7 D YN^DENTCRD1"
 I AX[AY S AX=$P(AX,AY)_$P(AX,AY,2)
 I SUB=19!(SUB=34) S AX=$P(AX," I $D")
 X AX
 Q
 ;
FLD4E(F) ;  executable help on DD(228,4)
 ;  Shows help text and field description from file 221
 ;  depending upon ? or ??
 N X,Y,AX,AZ,DIERR,DSI,DSIERR
 S AX=$S($G(F):F,1:$$FLD)
 Q:'AX  Q:'$$VFIELD^DILFD(221,AX)
 D FIELD^DID(221,AX,,"DESCRIPTION;HELP-PROMPT","DSI","DSIERR")
 I X'="??" D EN^DDIOL(DSI("HELP-PROMPT"),"","!?3") Q
 M AZ=DSI("DESCRIPTION") K DSI
 F AX=0:0 S AX=$O(AZ(AX)) Q:'AX  S AZ(AX)="  "_AZ(AX)
 S AX=1+$O(AZ(" "),-1),AZ(AX)=" "
 D EN^DDIOL(.AZ)
 Q
 ;
NUM ;  called from input transform on dd(228,2.01)
 ;  string of teeth numbers, 1-32
 N I,J,ARR,NSTR,STR,X1,X2
 S STR=$TR(X,";:",",-"),ARR=0
 K X Q:STR?.E1A.E
 F I=1:1:$L(STR,",") S NSTR=$P(STR,",",I) D:NSTR'=""  Q:'$D(STR)
 .S X1=$P(NSTR,"-"),X2=$P(NSTR,"-",2)
 .I X1\1'=X1 K STR Q
 .I X2'="",X2\1'=X2 K STR Q
 .I X1<1!(X1>32) K STR Q
 .I X2,X2<1!(X2>32)!(X2<X1) K STR Q
 .I 'X2 S:'$D(ARR(X1)) ARR=ARR+1,ARR(X1)="" Q
 .F J=X1:1:X2 S:'$D(ARR(J)) ARR=ARR+1,ARR(J)=""
 .Q
 Q:'$D(STR)!'ARR  S X="",(I,J)=0
 F  S J=$O(ARR(J)) Q:'J  S I=I+1,$P(X,",",I)=J
 Q
 ;
 ;=========================== file 228.1 ===============================
ID ;  pseudo-identifier on file 228.1
 N X,DIERR,DEN,DENERR,DENX,DENY S DENY=Y N Y
 S DEN=+$P(^(0),U,5),DENX=$P(^(0),U,3)
 S DEN=$$GET1^DIQ(9000010,DEN_",",.01,,,"DENERR")
 I DEN="",DENX S DEN=$$FMTE^XLFDT(DENX)
 I DEN'="" D EN^DDIOL(DEN,"","?44")
 I $D(@(DIC_"DENY,0)"))
 Q
