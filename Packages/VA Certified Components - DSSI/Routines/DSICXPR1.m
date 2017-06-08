DSICXPR1 ;DSS/SGM - RPCs/APIs FOR PARAMETERS ;12/09/2003 15:46
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;this routine is not directly invokable
 ;see corresponding line labels in ^DSICXPR
 ;^DSICXPR also documents the input parameters for each call
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
 S INST=+$P(DATA,"~",3) S:'INST INST=1
 D INTERN^XPAR1 I ERR S RET(0)="-1^Parameter not defined" Q
 D CHG^XPAR(ENT,PAR,INST,.DSICLT,.WPA) I +WPA S RET(0)="-1^"_$P(WPA,U,2) Q
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
GET ;  return values for all instances of an entity/param
 ;  Expects only ENTITY, PARAMETER
 ;               FORMAT is optional - default to B
 ;               FORMAT input is ignored and always set to B
 ;  ARR(6) = Q - return list(#)=iI^iV
 ;           E - return list(#)=eI^eV
 ;           B - return list(#,"N")=iI^eI
 ;                      list(#,"V")=iV^eV
 ;           N - return list(#,"N")=iV^eI
 ;  Return RET(#) = iI^eI^iV^eV
 ;     some of those pieces may be <null> depends upon ARR(6)
 ;     On error, return RET(1)=-1^error message
 N I,P,X,Y,Z,ARR,DSIERR,DSILIST
 S X=$$PARSE(234) I X<1 S RET(1)=X Q
 D GETLST^XPAR(.DSILIST,ARR(1),ARR(2),ARR(6),.DSIERR)
 I $G(DSIERR)'=0 S RET(1)="-1^"_$P(DSIERR,U,2) Q
 I '$G(DSILIST) S RET(1)="-1^No data found" Q
 ;  following FOR loop intentional.  Kill off return array element
 ;  after it has been processed.  Help to avoid <alloc> errors
 K P S Z=0,Y=ARR(6) F  S I=$O(DSILIST(0)) Q:'I  S Z=Z+1 D
 .F X=1:1:4 S P(X)=""
 .I Y="Q" S P(1)=$P(DSILIST(I),U),P(3)=$P(DSILIST(I),U,2)
 .I Y="E" S P(2)=$P(DSILIST(I),U),P(4)=$P(DSILIST(I),U,2)
 .I Y="N" S P(3)=$P(DSILIST(I,"N"),U),P(2)=$P(DSILIST(I),U,2)
 .I Y'="B" S RET(Z)=P(1)_U_P(2)_U_P(3)_U_P(4)
 .E  S RET(Z)=DSILIST(I,"N")_U_DSILIST(I,"V")
 .K DSILIST(I)
 .Q
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
 ;  RETURN:  RET = ^TMP("DSIC",$J,3-char entity,file_ien)=value
 ;  Return: if problems return @RET@(1) = -1^error message
 ;    else return @RET@(#) = 3-char entity code ^ entity ien ^ value
 ;    return array will be sorted by 3-char , ien
 N X,Y,Z,ARR,DSIERR,DSILST,ENT,IEN,LST,PARM,ROOT,SEQ,STOP,TMP,VAL
 S RET=$NA(^TMP("DSIC",$J)),TMP=$NA(^TMP("DSICX",$J)) K @RET,@TMP
 S PARM=$$PARSE(3) I PARM<1 S @RET@(1)=PARM Q
 D ENVAL^XPAR(TMP,ARR(2),ARR(3),.DSIERR,1)
 ;  @TMP@(entity-variable-pointer,iI)=iV
 I $G(DSIERR)>0 S @RET@(1)="-1^"_$P(DSIERR,U,2) K @TMP Q
 D ENT(.LST,PARM) S ROOT=TMP,STOP=$P(TMP,")")
 F  S ROOT=$Q(@ROOT) Q:ROOT=""  Q:ROOT'[STOP  D
 .S VAL=@ROOT,X=$QS(ROOT,3),IEN=+X,X=$P(X,";",2) Q:X=""
 .S SEQ=$G(LST(X)) Q:'SEQ  S ENT=$P(LST(SEQ),U,2)
 .S @RET@(ENT,IEN)=ENT_U_IEN_U_VAL
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
 ; use $$NMALL^DSICXPR() instead
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
 D FIND^DSICFM05(.DSIX,.DSI)
 S (A,I,RET)=0,X=$G(@DSIX@(1,0))
 I +X=-1 S RET=X F  S I=$O(@DSIX@(I)) Q:'I  S A=A+1,DSIC(A)=@DSIX@(I,0)
 I +X>0 D
 .F  S I=$O(@DSIX@(I)) Q:'I  S X=@DSIX@(I,0) D
 ..I EXACT,$P(X,U,2)'=DSIVAL Q
 ..S A=A+1,DSIC(A)=X,RET=1
 ..Q
 .Q
 I A=1,EXACT S RET=DSIC(1)
 I 'RET S (RET,DSIC(1))="-1^No matches found for "_DSIVAL
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
ENT(DSICX,PARM,UNCH) ;  API
 ;  return all allowable entities for parameter PARM
 ;  PARM - req - full name of the parameter or the pointer (IEN) to
 ;               the PARAMETER DEFINITION
 ;  UNCH - opt - I $G(UNCH) then return results of BLDLST^XPAREDIT
 ;               unchanged.
 ;  RETURN:
 ;   DSICX = # entities in parameter definition
 ;   DSICX(seq#) = p1^p2^p3^p4  where
 ;                 p1 = file# of entity class
 ;                 p2 = entity class 3 char code
 ;                 p3 = global name of entity class
 ;                 p4 = default entity (e.g., for PKG, SYS)
 ;   DSICX(entity class 3 char code) = seq#
 ;   DSICX(entity class global name) = seq#
 ;     global name = root of entity file without ^ - [e.g., VA(200,]
 ;
 ;   If problems, return DSICX = -1^message
 ;
 N I,X,Y,Z,CHAR,DEF,DIERR,DSI,DSIERR,FILE,GLB,SEQ
 I $G(PARM)="" S DSICX="-1^No parameter received" Q
 I PARM'=+PARM D  Q:$D(DSICX)
 .S X=$$NM(PARM) I 'X S DSICX="-1^Parameter "_PARM_" not found"
 .E  S PARM=+X
 .Q
 D BLDLST^XPAREDIT(.DSI,PARM) S DSICX=0
 I $G(UNCH) M DSICX=DSI
 E  F SEQ=0:0 S SEQ=$O(DSI(SEQ)) Q:'SEQ  D
 .K DIERR,DSIERR
 .S GLB=$P($$GET1^DID(+DSI(SEQ),,,"GLOBAL NAME",,"DSIERR"),U,2)
 .S X=DSI(SEQ),FILE=+X,CHAR=$P(X,U,4),DEF=$P(X,U,5)
 .S DSICX(SEQ)=FILE_U_CHAR_U_GLB_U_DEF,DSICX=1+DSICX
 .S:GLB'="" DSICX(GLB)=SEQ S:CHAR'="" DSICX(CHAR)=SEQ
 .Q
 I DSICX=0 S DSICX="-1^Parameter (ien="_PARM_") not found"
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
