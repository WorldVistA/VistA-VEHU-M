DSIVXPR1 ;DSS/AJ - RPCs/APIs FOR PARAMETERS ;4/27/2016 11:52
 ;;2.2;INSURANCE CAPTURE BUFFER;**11,12**;May 19, 2009;Build 13
 ;Copyright 1995-2016, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;this routine is not directly invokable
 ;see corresponding line labels in ^DSIVXPR
 ;^DSIVXPR also documents the input parameters for each call
 ;EXCEPTIONS: subroutine line tags ENT, MULT, NM may be called  
 ;
 ; DBIA#  Supported - Description
 ; -----  --------------------------------------------------
 ;  2051  $$FIND1^DIC
 ;  2052  $$GET1^DID
 ;  2056  $$GET1^DIQ
 ;  2263  ^XPAR: ADD,CHG,DEL,NDEL,GET,GETLST,GETWP,ENVAL,REP
 ;  2336  BLDLST^XPAREDIT
 ;  2263  ADDWP^XPAR
 ;  3127  FM read of all fields in file 8989.51 [control sub IA]
 ;
 Q
 ;
OUT ;  common exit - if '$D(RET) then expects DSIERR to be defined
 I $G(RET)]"" Q:$G(FUN) RET Q
 S DSIERR=$G(DSIERR,"Unexpected problem encountered")
 I DSIERR[U S DSIERR=$P(DSIERR,U,2)
 S RET=$S(DSIERR=0:1,1:"-1^"_DSIERR)
 Q:$G(FUN) RET Q
 ;       ;
ADD ;  add a new entity/parameter/instance
 ;  INSTANCE is optional even for multiple
 N I,X,Y,Z,ARR,DSIERR
 S X=$$PARSE(1) I X<1 S DSIERR=X G OUT
 I ARR(4)="@" S DSIERR="-1^Deletion is not allowed in the ADD RPC" G OUT
 ;  in multiple instance, instance="", then get next numeric value
 I ARR(3)="",$$MULT(X) D  G:$D(DSIERR) OUT
 .N TMP D GET(.TMP,$P(DATA,"~",1,2))
 .I +TMP(1)=-1 S DSIERR=TMP(1) Q
 .S X=0 F I=1:1 Q:'$D(TMP(I))  S:+TMP(I)>X X=+TMP(I)
 .S ARR(3)=X+1
 .Q
 D ADD^XPAR(ARR(1),ARR(2),ARR(3),ARR(4),.DSIERR)
 G OUT
 ;
CHG ;  edit a Value for existing parameter/entity/instance
 ; INSTANCE is optional
 ; DBIA #2263 - CHG^XPAR
 N X,Y,Z,ARR,DSIERR
 S X=$$PARSE(1) I X<1 S DSIERR=X G OUT
 I ARR(3)="" D CHG^XPAR(ARR(1),ARR(2),,ARR(4),.DSIERR)
 I ARR(3)'="" D CHG^XPAR(ARR(1),ARR(2),ARR(3),ARR(4),.DSIERR)
 G OUT
 ;
CHGWP ;
 ;Change a word-processing type parameter value
 ; DBIA #2263 - CHG^XPAR
 ;
 N ENT,PAR,ERR,INST,WPA
 S ERR="" K RET
 I DATA']"" S RET(0)="-1^No Data string defined" Q
 S ENT=$S($P(DATA,"~",1)'="":$P(DATA,"~",1),1:"SYS")
 S PAR=$P(DATA,"~",2) I PAR="" S RET(0)="-1^No parameter defined in Data string" Q
 S INST=$P(DATA,"~",3) S:INST="" INST=1
 D INTERN^XPAR1 I ERR S RET(0)="-1^Parameter not defined" Q
 D CHG^XPAR(ENT,PAR,INST,.DSIVLT,.WPA) I +WPA S RET(0)="-1^"_$P(WPA,U,2) Q
 S RET(0)="1^Parameter changed successfully"
 Q
 ;
DEL ;  delete existing parameter/entity/instance
 ;  VALUE is not expected
 ;  DBIA #2263 - DEL^XPAR
 N X,Y,Z,ARR,DSIERR
 S X=$$PARSE(13) I X<0 S DSIERR=X G OUT
 I ARR(3)="" S DSIERR="-1^No Instance received"
 E  D DEL^XPAR(ARR(1),ARR(2),ARR(3),.DSIERR)
 G OUT
 ;
DELALL ;  delete all instances for entity/parameter
 ;  neither INSTANCE nor VALUE expected
 N X,Y,Z,ARR,DSIERR
 S X=$$PARSE(13) I X<0 S DSIERR=X
 E  D NDEL^XPAR(ARR(1),ARR(2),.DSIERR)
 G OUT
 ;
GET ;  RPC: DSIV XPAR GET ALL FOR ENT
 ;  this will return values for all instances of an entity/param
 ;  Exception: only needed elements: entity, parameter, format
 ;  DATA = "ARR(1)~ARR(2)~ARR(3)~ARR(4)~ARR(5)~ARR(6)"
 ;     e.g. "SYS~DSIV PAGE SETUP~~~~"
 ;  ARR(1) = entity     ARR(2) = param name    ARR(3) = instance
 ;  ARR(4) = value      ARR(5) = new instance value
 ;  ARR(6) = format for GET1, Default = "Q"
 ;        "Q" - quick,    #)=internal instance^internal value
 ;        "E" - external, #)=external instance^external value
 ;        "B" - both,     #,"N")=internal instance^external instance
 ;                        #,"V")=internal value^external value
 ;        "N" - external instance)=internal value^external value
 ;     some of those pieces may be <null> depends upon ARR(6)
 ;     On error, return DSILIST(1)=-1^error message
 N I,P,X,Y,Z,ARR,DSIERR
 S X=$$PARSE(34) I X<1 S RET(1)=X Q
 D GETLST^XPAR(.RET,ARR(1),ARR(2),ARR(6),.DSIERR)
 I $G(DSIERR)'=0 S RET(1)="-1^"_$P(DSIERR,U,2) Q
 I '$G(RET) S RET(1)="-1^No data found" Q
 Q
 ;
GET1 ;  return value of a single entity/param/instance combo
 ;  Format codes [ARR(6)] = [Q]uick    - return iV
 ;                          [E]xternal - return eV
 ;                          [B]oth     - return iV^eV
 N X,Y,Z,ARR,DSIERR
 S X=$$PARSE(34) I X<1 S DSIERR=X G OUT
 I "N"[ARR(6) S DSIERR="-1^Invalid format parameter received" G OUT
 I ARR(3)="" S X=$$GET^XPAR(ARR(1),ARR(2),,ARR(6))
 I ARR(3)'="" S X=$$GET^XPAR(ARR(1),ARR(2),ARR(3),ARR(6))
 I X="" S DSIERR="-1^No value found"
 E  S RET=X
 G OUT
 ;
GETALL ;  Return all entity/parameter combinations for an instance
 ;  Expects only PARAMETER, INSTANCE
 ;  RETURN:  RET = ^TMP("DSIV",$J,3-char entity,file_ien)=value
 ;  Return: if problems return @RET@(1) = -1^error message
 ;    else return @RET@(#) = 3-char entity code ^ entity ien ^ value
 ;    return array will be sorted by 3-char , ien
 N X,Y,Z,ARR,DSIERR,DSILST,ENT,IEN,LST,PARM,ROOT,SEQ,STOP,TMP,VAL,CNT,INST,ENTEX,ENTITY,DSIVDUZ
 S RET=$NA(^TMP("DSIV",$J)),TMP=$NA(^TMP("DSIVX",$J)) K @RET,@TMP S ENTITY="",DSIVDUZ=""
 S:$P(DATA,"~")'="" ENTITY=$P(DATA,"~")
 S:ENTITY["." DSIVDUZ=$P(ENTITY,"`",2),ENTITY=$P(ENTITY,".")
 S PARM=$$PARSE(3) I PARM<1 S @RET@(1)=PARM Q
 D ENVAL(TMP,ARR(2),ARR(3),.DSIERR,1)
 S CNT=1
 ;  @TMP@(entity-variable-pointer,iI)=iV
 I $G(DSIERR)>0 S @RET@(1)="-1^"_$P(DSIERR,U,2) K @TMP Q
 D ENT(.LST,PARM) S ROOT=TMP,STOP=$P(TMP,")")
 F  S ROOT=$Q(@ROOT) Q:ROOT=""  Q:ROOT'[STOP  D
 .S VAL=@ROOT,X=$QS(ROOT,3),IEN=+X,X=$P(X,";",2) Q:X=""
 .S SEQ=$G(LST(X)) Q:'SEQ  S ENT=$P(LST(SEQ),U,2) S INST=$QS(ROOT,4),ENTEX=$QS(ROOT,3)
 .I ENTITY'="",ENTITY=ENT D
 ..I DSIVDUZ'="",DSIVDUZ=$P($$ENTVAL(ENTEX),U) S @RET@(CNT)=ENT_U_$$ENTVAL(ENTEX)_U_INST,CNT=CNT+1
 ..I DSIVDUZ="" S @RET@(CNT)=ENT_U_$$ENTVAL(ENTEX)_U_INST,CNT=CNT+1
 .I ENTITY="" S @RET@(CNT)=ENT_U_$$ENTVAL(ENTEX)_U_INST,CNT=CNT+1
 .Q
 I '$D(@RET) S @RET@(1)="-1^No data found"
 Q
 ;
GETWP ;  Retrieve a word-processing type parameter value
 N I,X,Y,Z,ARR,DSIERR,DSILST
 S X=$$PARSE(34) I X<1 S RET(1)=X Q
 S:ARR(3)="" ARR(3)=1
 D GETWP^XPAR(.DSILST,ARR(1),ARR(2),ARR(3),.DSIERR)
 I $G(DSIERR)>0 G OUT
 I '$D(DSILST) K DSIERR G OUT
 S X=0,Y=0,RET(1)=DSILST
 F  S X=$O(DSILST(X)) Q:X=""  S Y=Y+1,RET(Y)=DSILST(X,0)
 Q
 ;
NMALL ; 9/20/2005 - do not call this line directly
 ; use $$NMALL^DSIVXPR() instead
 N A,I,Y,Z,DSI,DSIVAL,DSIX,RET
 S Y=$G(FLDS),DSIVAL=$G(X),EXACT=$G(EXACT)
 I $E(Y,1,2)="@;" S Y=$E(Y,3,$L(Y))
 S Z=0 F I=1:1:$L(Y,";") I +$P(Y,";",I)=.01 S Z=I Q
 I 'Z S Y=".01;"_Y
 I Z>1 S A=$P(Y,";",Z),$P(Y,";",Z)="",Z=Y,Y=A D
 .F  Q:Z'[";;"  S Z=$P(Z,";;")_";"_$P(Z,";;",2,999)
 .S Y=Y_";"_Z
 .Q
 S DSI(1)="FILE^8989.51"
 S DSI(2)="FIELDS^@;"_Y
 S DSI(3)="FLAGS^APQ"
 S DSI(4)="INDEX^B"
 S DSI(5)="VAL^"_DSIVAL
 D FIND^DSIVFM05(.DSIX,.DSI)
 S (A,I,RET)=0,X=$G(@DSIX@(1,0))
 I +X=-1 S RET=X F  S I=$O(@DSIX@(I)) Q:'I  S A=A+1,DSIV(A)=@DSIX@(I,0)
 I +X>0 D
 .F  S I=$O(@DSIX@(I)) Q:'I  S X=@DSIX@(I,0) D
 ..I EXACT,$P(X,U,2)'=DSIVAL Q
 ..S A=A+1,DSIV(A)=X,RET=1
 ..Q
 .Q
 I A=1,EXACT S RET=DSIV(1)
 I 'RET S (RET,DSIV(1))="-1^No matches found for "_DSIVAL
 Q RET
 ;
REPL ;  Change an instance value for an existing entry
 N I,P,X,Y,Z,ARR,DSIERR
 S X=$$PARSE(13) I X<1 S DSIERR=X G OUT
 I ARR(5)="" S DSIERR="-1^No replacement instance value received"
 E  D REP^XPAR(ARR(1),ARR(2),ARR(3),ARR(5),.DSIERR)
 G OUT
 ;
 ;--------------------  subroutines  -----------------------
ENT(DSIVX,PARM,UNCH) ;  API
 ;  return all allowable entities for parameter PARM
 ;  PARM - req - full name of the parameter or the pointer (IEN) to
 ;               the PARAMETER DEFINITION
 ;  UNCH - opt - I $G(UNCH) then return results of BLDLST^XPAREDIT
 ;               unchanged.
 ;  RETURN:
 ;   DSIVX = # entities in parameter definition
 ;   DSIVX(seq#) = p1^p2^p3^p4  where
 ;                 p1 = file# of entity class
 ;                 p2 = entity class 3 char code
 ;                 p3 = global name of entity class
 ;                 p4 = default entity (e.g., for PKG, SYS)
 ;   DSIVX(entity class 3 char code) = seq#
 ;   DSIVX(entity class global name) = seq#
 ;     global name = root of entity file without ^ - [e.g., VA(200,]
 ;
 ;   If problems, return DSIVX = -1^message
 ;
 N I,X,Y,Z,CHAR,DEF,DIERR,DSI,DSIERR,FILE,GLB,SEQ
 I $G(PARM)="" S DSIVX="-1^No parameter received" Q
 I PARM'=+PARM D  Q:$D(DSIVX)
 .S X=$$NM(PARM) I 'X S DSIVX="-1^Parameter "_PARM_" not found"
 .E  S PARM=+X
 .Q
 D BLDLST^XPAREDIT(.DSI,PARM) S DSIVX=0
 I $G(UNCH) M DSIVX=DSI
 E  F SEQ=0:0 S SEQ=$O(DSI(SEQ)) Q:'SEQ  D
 .K DIERR,DSIERR
 .S GLB=$P($$GET1^DID(+DSI(SEQ),,,"GLOBAL NAME",,"DSIERR"),U,2)
 .S X=DSI(SEQ),FILE=+X,CHAR=$P(X,U,4),DEF=$P(X,U,5)
 .S DSIVX(SEQ)=FILE_U_CHAR_U_GLB_U_DEF,DSIVX=1+DSIVX
 .S:GLB'="" DSIVX(GLB)=SEQ S:CHAR'="" DSIVX(CHAR)=SEQ
 .Q
 I DSIVX=0 S DSIVX="-1^Parameter (ien="_PARM_") not found"
 Q
 ;
MULT(IEN) ;  return 1 if parameter is multi-instance
 N X,DIERR,DSIERR Q $$GET1^DIQ(8989.51,$G(IEN)_",",.03,"I",,"DSIERR")
 ;
NM(P) ;  return the ien for a parameter definition P (#8989.51)
 N DIERR,DSIERR Q $$FIND1^DIC(8989.51,,"QX",$G(P),"B",,"DSIERR")
 ;
PARSE(FLG) ;  parse up DATA string and set up ARR() array
 ;  FLG - optional
 ;    If FLG[1 then explicit entity required - default to USR
 ;    If FLG[4 then explicit entity required - default to ALL
 ;    If FLG[2 then set GET format to B
 ;    If FLG[3 then value not needed
 ;  Return: PARAMETER DEFINITION ien
 ;     else return -1^error message
 ;
 ;  ARR(1) = entity     ARR(2) = param name    ARR(3) = instance
 ;  ARR(4) = value      ARR(5) = new instance value
 ;  ARR(6) = format for GET1
 ;
 N I,X,Y,Z,RTN K ARR S FLG=$G(FLG)
 F I=1:1:6 S ARR(I)=$P($G(DATA),"~",I)
 I FLG[1,ARR(1)="" S ARR(1)="USR"
 I FLG[4,ARR(1)="" S ARR(1)="ALL"
 I ARR(6)="" S ARR(6)=$S(FLG[2:"B",1:"Q")
 I FLG[2 S ARR(6)="B"
 I "QEBN"'[ARR(6)!(ARR(6)'?1U) S ARR(6)=""
 I ARR(2)="" Q "-1^No parameter name received"
 S RTN=$$NM(ARR(2))
 I 'RTN S RTN="-1^Parameter Definition "_ARR(2)_" not found"
 I RTN>0,FLG'[3,ARR(4)="" S RTN="-1^No value received"
 Q RTN
ENTVAL(ENT) ; Return ENT value: INTERNAL^EXTERNAL
 N FN
 S FN=+$P(@(U_$P(ENT,";",2)_"0)"),U,2)
 Q $P(ENT,";")_U_$$EXTPTR^XPARDD(+ENT,FN)
 ;
ENVAL(LIST,PAR,INST,ERR,GBL) ; return all parameter instances
 ; .LIST: array of returned entity/instance/values in the format:
 ;        LIST(entity,instance)=value  (LIST = # of array elements)
 ;        or a Closed Global root  ($NA(^TMP($J)))
 ;   PAR: parameter in external or internal format
 ;  INST: instance (optional) in external or internal format
 ;   ERR: error (0 if no error found)
 ;   GBL: Set to 1 if LIST holds a Closed Global root
 N ENT,VAL,XPARGET,ROOT
 S ENT="",VAL="",ERR=0,XPARGET=""
 ;Setup ROOT
 I '$G(GBL) K LIST S ROOT=$NA(LIST)
 I $G(GBL) D  Q:ERR
 . I $E($G(LIST),1)'="^" S ERR=$$ERR^XPARDD(89895015) Q
 . S ROOT=LIST
 . Q
 ;
 S @ROOT=0
 ; -- parameter to internal format:
 I PAR'?1.N S PAR=+$O(^XTV(8989.51,"B",PAR,0))
 I '$D(^XTV(8989.51,PAR,0)) S ERR=$$ERR^XPARDD(89895001) Q  ;missing par
 ; -- instance
 I $L($G(INST)) D VALID^XPARDD(PAR,.INST,"I",.ERR) Q:ERR
 F  S ENT=$O(^XTV(8989.5,"AC",PAR,ENT)) Q:ENT=""  D
 . I $L($G(INST)) D
 .. S VAL=$G(^XTV(8989.5,"AC",PAR,ENT,INST))
 .. S:$L($G(VAL)) @ROOT@(ENT,INST)=VAL,@ROOT=@ROOT+1
 . I '$L($G(INST)) D
 .. S INST="" F  S INST=$O(^XTV(8989.5,"AC",PAR,ENT,INST)) Q:INST=""  D
 ... S VAL=$G(^XTV(8989.5,"AC",PAR,ENT,INST))
 ... S:$L($G(VAL)) @ROOT@(ENT,INST)=VAL,@ROOT=@ROOT+1
 ... S:'$L($G(VAL)) @ROOT@(ENT,INST)="WP",@ROOT=@ROOT+1
 Q
