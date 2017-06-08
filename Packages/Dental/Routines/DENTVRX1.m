DENTVRX1 ;DSS/SGM - KERNEL PARAMETER RPCS ;07/24/2003 15:15
 ;;1.2;DENTAL;**31**;Aug 10, 2001
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ------------------------------------------
 ;  2336      x      BLDLST^XPAREDIT
 ;  2051      x      $$FIND1^DIC
 ;  2056      x      $$GET1^DIQ
 ;  3127  Cont Sub   Fileman read of all fields in file 8989.51
 ;
MULT(DENTV,PARAM,FLAG,OTHER) ; RPC: DENTV MULT PARAM
 ;  This will get all the instances for a parameter.  It returns the
 ;  instance, value, and entity of the entity of highest precedence
 ;  that has this parameter set.  Thus there will be only one return
 ;  for each parameter-instance combination.
 ;
 ;  This is not totally generic and there are some assumptions:
 ;  1. For any one entity class there must be one and only one entity
 ;     passed in for that entity class
 ;  2. If USR is an allowable entity, and no specific USR is passed in,
 ;     then assume current user (i.e., DUZ)
 ;  3. The only entity classes allowed with just the 3 character code
 ;     and no specific entity are USR, PKG, SYS
 ;     a. If these three entity classes are allowable entity types,
 ;        then they do not need to be explicity passed in.
 ;     b. All other allowable entity types from the parameter definition
 ;        will be ignored unless explicitly passed in.
 ;
 ;  DENTV - return array in $NAME closed form
 ;  PARAM - required - parameter definition name
 ;   FLAG - optional - default = "iv"
 ;          I FLAG["I" then return internal instance
 ;                ["i" then return external instance
 ;                ["V" then return internal value
 ;                ["v" then return external value
 ;  OTHER - optional - list of specific entities to check for
 ;    OTHER(#) = 3 char code.<name of corresponding entity>
 ;               name must be the external name or `ien
 ;               This can also be variable pointer syntax
 ;
 ;  RETURN ARRAY:  return @DENTV@(internal instance) = data
 ;                 if $D(DENTV)="" S DENTV=$NA(^TMP("DSIC",$J))
 ;  Return @DENTV@(n) = entity^p2^p3^p4^p5   where
 ;         n = internal instance, or if error n=1
 ;         entity = 3 character code for entity
 ;         data returned in p2,p3,p4,p5 determined by FLAG
 ;         p2 = data represented by $E(FLAG)
 ;         p3 = data represented by $E(FLAG,2), etc for p4,p5
 ;  On error return @DENTV@(1) = -1^error message
 ;
 N I,J,X,Y,Z,DENENT,DENV,INST,XD
 I '$D(DENTV) S DENTV=$NA(^TMP("DSIC",$J))
 K @DENTV
 S FLAG=$$FLAG I +FLAG=-1 S @DENTV@(1)=FLAG Q
 I $G(PARAM)="" S @DENTV@(1)="-1^No parameter name received" Q
 ;
 ;  get param ien - check for multiple instance - return ien^param
 I $$PARM(PARAM)<1 Q
 ;
 ;  get list of entities - DENENT(seq)=entity (var ptr) ^ entity 3 char
 D LST
 ;
 ;  now let's get all instances for specific entity/param
 S DENENT=0 F  S DENENT=$O(DENENT(DENENT)) Q:'DENENT  D
 .S X=$P(DENENT(DENENT),U)_"~"_$P(PARAM,U,2) K DENV
 .D GET^DSICXPR(.DENV,X) Q:+$G(DENV(1))=-1
 .F I=0:0 S I=$O(DENV(I)) Q:'I  S X=DENV(I) D
 ..S INST=$P(X,U) Q:$D(@DENTV@(INST))
 ..S XD=$P(DENENT(DENENT),U,2)_U
 ..F J=1:1:$L(FLAG) S Y=$E(FLAG,J),Z=$F("IiVv",Y)-1,$P(XD,U,J+1)=$P(X,U,Z)
 ..S @DENTV@(INST)=XD
 ..Q
 .Q
 I '$D(@DENTV) S @DENTV@(1)="-1^No values found"
 Q
 ;
 ; --------------------  subroutines  --------------------
FLAG() ;  evaluate valid FLAG input parameter
 ;  default flag is 'iv'.  Return 1 if valid flag, else -1^message
 N I,X,Y
 S FLAG=$G(FLAG,"iv") S:FLAG="" FLAG="iv"
 S Y=FLAG,X=""
 F I=1:1:$L(FLAG) I "IiVv"[$E(FLAG,I) S X=X_$E(FLAG,I)
 S FLAG=X I FLAG="" S X="-1^Invalid format flag received: "_Y
 Q X
 ;
LST ;  get list of acceptable entities for param
 ;  expects PARAM = ien ^ parameter name
 ;  Returns: DENENT(SEQ) = specific entity name
 ;
 ;  DEN is based upon parameter definition
 ;  DEN(seq#)     = file# ^ 3 char ^ global ref ^ default
 ;     (3-char)   = seq#
 ;     (glob ref) = seq #
 ;
 ;  DENX(3-char) = entity in variable (or pseudo) pointer syntax
 ;
 N I,X,Y,Z,CHAR,DEF,DEN,DENX,ENT,FILE,GLB,SEQ
 K DENENT
 D ENT^DSICXPR1(.DEN,+PARAM)
 ;
 ;  first check for specific entities passed in
 ;  set ENT = variable pointer syntax
 S I="" F  S I=$O(OTHER(I)) Q:'I  S X=OTHER(I),ENT="" D
 .I X="USR",$D(DEN(X)) S ENT=X_".`"_DUZ
 .I X="PKG",$D(DEN(X)) S ENT=$P(DEN(DEN(X)),U,4)
 .I X="SYS",$D(DEN(X)) S ENT=$P(DEN(DEN(X)),U,4)
 .I X?3U1".".E S Z=$P(X,".") S:$D(DEN(Z)) ENT=X
 .I X[";" S Z=$P(X,";",2) I Z'="",$D(DEN(Z)) S ENT=X
 .Q:ENT=""  S CHAR=""
 .I ENT?3U1".".E S CHAR=$P(ENT,".")
 .I ENT[";" S Z=$P(ENT,";",2),Z=$G(DEN(Z)) S:Z CHAR=$P(DEN(Z),U,2)
 .I CHAR'="",'$D(DENX(CHAR)) S DENX(CHAR)=ENT
 .Q
 ;
 ;  check for allowable entities not in list
 F CHAR="USR","PKG","SYS" I '$D(DENX(CHAR)),$D(DEN(CHAR)) D
 .I CHAR="USR" S DENX(CHAR)=CHAR_".`"_DUZ
 .E  S Y=DEN(CHAR),ENT=$P(DEN(Y),U,4) S:ENT'="" DENX(CHAR)=ENT
 .Q
 ;
 ;  now create return array in precedence order
 S CHAR=""
 F  S CHAR=$O(DENX(CHAR)) Q:CHAR=""  S SEQ=DEN(CHAR),DENENT(SEQ)=DENX(CHAR)_U_CHAR
 Q
 ;
PARM(PARM) ;  get parameter definitions
 ;  PARM - required - name of parameter definition
 ;  Return 1 if everything ok, else return -1
 N I,X,Y,Z,DEN,DENTER,DENX,DIERR,FILE,FLD,IEN,SEQ
 S IEN=$$NM^DSICXPR1($G(PARM))
 I 'IEN S @DENTV@(1)="-1^Invalid parameter received: "_$G(PARM) Q -1
 S X=$$MULT^DSICXPR1(IEN)
 I X<1 S @DENTV@(1)="-1^Only multiple valued parameters allowed" Q -1
 S PARAM=IEN_U_PARM
 Q 1
