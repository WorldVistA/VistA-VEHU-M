DSICFM06 ;DSS/SGM - FILEMAN DD UTILITIES ;10/21/2005 14:27
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;Fileman utilites for accessing the DD structure
 ;
 ;DBIA#  Supported References
 ;-----  -----------------------------------------------------
 ; 2051  $$FIND1^DIC
 ; 2052  ^DID: FIELD, FIELDLST
 ; 2054  ^DILF: CLEAN, DA
 ; 2055  ^DILFD: $$VFILE, $$VFIELD, FLDNUM, $$EXTERNAL, $$ROOT
 ;10104  $$UP^XLFSTR
 ;
 ;Common input parameters
 ;---------------------------------------------------------
 ;  FILE - req - file (or subfile) number or full file name
 ;   FUN - opt - if $G(FUN) then extrinsic function
 ; FIELD - req - field number or full field name
 ;
OUT Q:$G(FUN) DSIC Q
 ;
EXTERNAL(DSIC,FILE,FIELD,VALUE,FUN) ; RPC: DSIC FM EXTERNAL
 ; convert data from internal to external format
 ; does not require ien to file
 ; VALUE - req - internal value to be converted to external
 N X,Y,DIERR,FLAG,TYPE
 D INIT("FILE^FIELD^VALUE^FUN")
 I VALUE="" D ERM(1) G OUT
 S FILE=$$VFILE(,FILE,1) I +FILE=-1 S DSIC=FILE G OUT
 S FIELD=$$VFIELD(,FILE,FIELD,1) I +FIELD=+1 S DSIC=FIELD G OUT
 S X=$$EXTERNAL^DILFD(FILE,FIELD,,VALUE)
 I '$D(DIERR) S DSIC=X
 E  S DSIC=$$ERR
 G OUT
 ;
FIELD(DSIC,FILE,FIELD,FLAG,ATT,TYPE) ; RPC: DSIC FM GET FIELD ATTRIB
 ; this will return the inputed field attributes for a file
 ; FILE, FIELD - req - see above
 ; FLAG - opt - default value = ""
 ;       [ N - attribute not returned if the attribute is null
 ;       [ Z - WP attributes include zero (0) nodes with text
 ; TYPE - opt - default = 1
 ;        if TYPE=1, then return DSIC(attribute name)=value
 ;           for wp fields, return DSIC(att name,#)=text
 ;        else return DSIC(#)=attribute name^value  [from RPC]
 ;           for wp fields, return DSIC(#)=att name^text
 ;  ATT - req - list OR ';'-delimied string of attributes to return
 ;        from M routine you can pass att(attrib name)=""
 ;        from RPC, pass ATT(n) = attribute name
 ;        To get all field attributes, pass
 ;           ATT("*")=""  or  ATT(1) = "*"
 ; Return DSIC() - see TYPE definition
 ; Errors/problems - return DSIC(1)=-1^msg
 ;
 N A,I,X,Y,Z,DIERR,DSICX,FLGZ,VAL
 D INIT("FILE^FIELD^FLAG^TYPE"),FLDCK Q:$D(DSIC)
 I FLAG["Z",$$BROKER^DSICUTL S FLAG=$TR(FLAG,"Z")
 S FLGZ=FLAG["Z",FLAG=$TR(FLAG,"Z")
 D ATT Q:$D(DSIC)
 D FIELD^DID(FILE,FIELD,FLAG,ATT,"DSICX")
 I $D(DIERR) S DSIC(1)=$$ERR Q
 F A="DESCRIPTION","TECHNICAL DESCRIPTION" D
 .K Y,Z M Z=DSICX(A) K DSICX(A)
 .S X="Z",Y="DSICX(A,I"_$S(FLGZ:",0)",1:")")
 .F I=1:1 S X=$Q(@X) Q:X=""  S @Y=@X
 .Q
 I TYPE M DSIC=DSICX
 I 'TYPE S Z=0,X="" F  S X=$O(DSICX(X)) Q:X=""  D:$D(ATT(X))#2
 .I ATT(X)'="WP" S Z=Z+1,DSIC(Z)=X_U_DSICX(X) Q
 .F I=0:0 S I=$O(DSICX(X,I)) Q:I=""  D
 ..S Z=Z+1,DSIC(Z)=X_U_$S(FLGZ:DSICX(X,I,0),1:DSICX(X,I))
 ..Q
 .Q
 I '$D(DSIC) D ERM(2,1)
 Q
 ;
FIELDLST(DSICX,INPUT) ;  api - return list of field attributes
 ; INPUT - opt - pass by reference OR as a string
 ;    if INPUT(attrib name)="" then only return in DSICX those names
 ;    which are valid
 ;    if INPUT=string then string must be a ';'-delimited list of field
 ;    attributes
 ; Return: DSICX(attribute) = "" or WP (if attrib a word processing fld)
 ;
 N I,X,Y,Z,ATT,DSICA
 I $G(INPUT)'="" D
 .F I=1:1:$L(INPUT,";") S X=$P(INPUT,";",I) S:X'="" INPUT(X)=""
 .Q
 S X="" F  S X=$O(INPUT(X)) Q:X=""  Q:X'?.E1L.E  D
 .K INPUT(X) S X=$$UP^XLFSTR(X),INPUT(X)=""
 .Q
 D FIELDLST^DID("DSICA")
 S X="" F  S X=$O(DSICA(X)) Q:X=""  D
 .S Y="" I $D(DSICA(X,"#(word-processing)")) S Y="WP"
 .I '$D(INPUT)!$D(INPUT(X)) S DSICX(X)=Y
 .Q
 Q
 ;
MULT(DSICM,DSIN) ; rpc: DSIC FM GET FIELD ATTRIB MULT
 ; Return requested attributes for one or more fields in a file.
 ; DSIN(n) = label^value  [required]  for n=0,1,2,3,4,...  where
 ; Label  Req  Value
 ; -----  ---  ------------------------------------
 ; FILE    y   see above
 ; FIELD   y   see above - multiple input forms allowed
 ;               DSIN(i) = FIELD^fld#1;fld#2;fld#3;...
 ;               DSIN(i) = FIELD^fld#
 ;               DSIN(i) = FIELD^fld1;fld2:fld3;fld4;fld5:fld6;...
 ;                 where ':' indicates all field numbers inclusive
 ; FLAG    n   default value = ""
 ;             if FLAG["N" - att not returned if the att value is null
 ;                    ["Z" - WP att include zero (0) nodes with text
 ; TYPE    n   default = 1
 ;             if TYPE=1, then return DSICM(fld#,attrib_name)=value
 ;               for wp fields, return DSICM(fld#,att name,#)=text
 ;               else return DSICM(#)=field#^attrib_name^value  [for RPC]
 ;               for wp fields, return DSICM(#)=fld#^att name^text
 ; ATT     y   list of attributes to return
 ;             ';'-delimiter string of attrib names
 ;             or it can be a single attrib name
 ;             for all attributes, pass DSIN(i) = ATT^*
 ;
 ; Return DSICM() - see TYPE definition
 ; Any errors or problems will be returned in DSIC(1)=-1^err msg
 N A,I,J,X,Y,Z,ATT,DSIA,DSIC,DSIFLD,FIELD,FILE,FLAG,FLD,TYPE
 S I="" F  S I=$O(DSIN(I)) Q:I=""  S Z=DSIN(I) D
 .S Y=$P(Z,U),X=$P(Z,U,2)
 .I Y?.E1L.E S Y=$$UP^XLFSTR(Y)
 .I "^FILE^FLAG^TYPE^"[(U_Y_U) S @Y=X Q
 .I Y="ATT" S J=1+$O(ATT("A"),-1),ATT(J)=X
 .I Y="FIELD" S J=1+$O(FLD("A"),-1),FLD(J)=X
 .Q
 D INIT("FILE^FLAG^TYPE"),FLDCK
 I $D(DSIC) M DSICM=DSIC Q
 D ATT I $D(DSIC) M DSICM=DSIC Q
 M DSIA=ATT
 F I=0:0 S I=$O(FLD(I)) Q:'I  S X=FLD(I) D  Q:$$MT
 .F J=1:1:$L(X,";") S A=$P(X,";",J) D:+A  Q:$$MT
 ..I A'[":" S FLD=A D M1 Q
 ..I $D(^DD(FILE,+A)) S FLD=+A D M1 Q:$$MT
 ..S Y=+A
 ..F  S Y=$O(^DD(FILE,Y)) Q:'Y  Q:Y>+$P(A,":",2)  S FLD=Y D M1 Q:$$MT
 ..Q
 .Q
 I '$D(DSICM) D ERM(3,1)
 Q
 ;
M1 ;
 N A,I,J,X,Y,Z,ATT,DSIC
 M ATT=DSIA
 D FIELD(.DSIC,FILE,FLD,FLAG,.ATT,TYPE)
 I +$G(DSIC(1))=-1 K DSICM M DSICM=DSIC Q
 I TYPE M DSICM(FLD)=DSIC Q
 S J=$O(DSICM("A"),-1)
 F I=0:0 S I=$O(DSIC(I)) Q:'I  S J=J+1,DSICM(J)=FLD_U_DSIC(I)
 Q
 ;
MT() Q +$G(DSICM(1))=-1
 ;
ROOT(DSIC,FILE,IENS,FLAG,FUN) ; RPC: 
 ; Return global root (open or closed) for a file or subfile
 ; On error return -1^message
 ;   IENS - opt - needed if passing subfile
 ;   FLAG - opt - default to 0 - 1:closed root; 0:open root
 ;
 I $G(FILE)="" D ERM(4) G OUT
 N X,Y,Z,DIERR,DSIER,TYPE
 D INIT("FILE^IENS^FLAG^FUN")
 S FLAG=(FLAG'=0)
 I IENS'="" S X=$$VIENS(,IENS,1) I X<1 S DSIC=X G OUT
 S DSIC=$$ROOT^DILFD(FILE,IENS,FLAG,1) I DSIC?1"^".E G OUT
 I $D(DIERR) S DSIC=$$ERR
 I '$D(DIERR) D ERM(2)
 D CLEAN^DILF
 G OUT
 ;
VFILE(DSIC,FILE,FUN) ; RPC: DSIC FM VERIFY FILE
 ; verify whether or not a file or subfile exists
 ; Return - file number if file exists
 ;          -1^message if problem
 N X,Y,DIERR,DSI,FLAG,TYPE
 D INIT("FILE^FUN") S DSI=FILE
 I FILE="" D ERM(4) G OUT
 I FILE'=+FILE D  G:$D(DSIC) OUT
 .S X=$$FIND1^DIC(1,,"QX",FILE,"B")
 .I '$D(DIERR),X>0 S FILE=X
 .I $D(DIERR) S DSIC=$$ERR
 .Q
 S X=$$VFILE^DILFD(FILE) S:X DSIC=FILE D:'X ERM(5)
 G OUT
 ;
VFIELD(DSIC,FILE,FIELD,FUN) ; RPC: DSIC FM VERIFY FIELD
 ; verify whether or not a field exists
 ; Return - field number if file and field exist
 ;          -1^message if problem
 N X,Y,DIERR,FLAG,TYPE
 D INIT("FILE^FIELD^FUN")
 S FILE=$$VFILE(,FILE,1)
 I FILE<0 S DSIC=FILE G OUT
 I FIELD="" D ERM(6) G OUT
 I +FIELD=FIELD S X=$$VFIELD^DILFD(FILE,FIELD) I X>0 S DSIC=FIELD G OUT
 S X=$$FLDNUM^DILFD(FILE,FIELD)
 I '$D(DIERR),X>0 S DSIC=X
 I $D(DIERR) S DSIC=$$ERR
 G OUT
 ;
VIENS(DSIC,IENS,FUN) ; RPC:
 ; validate that IENS is a proper iens string
 ;   IENS - req
 ; RETURN - 1:valid iens string; -1^msg
 ;
 N X,Y,Z,DA,FLAG,TYPE
 D INIT("IENS^FUN")
 I IENS="" D ERM(7) G OUT
 D DA^DILF(IENS,.DA)
 S:$D(DA) DSIC=1 I '$D(DA) D ERM(8)
 G OUT
 ;
 ;--------------  subroutines  ---------------
ATT ; expects ATT=';' delimited string OR
 ; OR ATT(i)=attribute name or ""
 ; OR ATT(i)=1 or * [ get all attributes]
 ; If ATT(i)="" then assume i=attribute name or 1 or *
 ; Reset ATT - S ATT=';' delimited string of attribs to get
 ;             S ATT(attrib name) = "" or WP
 N A,I,J,X,Y,Z,ARR,DSI,ERR
 S X=$G(ATT)
 I X'="" F I=1:1:$L(X,";") S Y=$P(X,";",I) S:Y'="" ARR(Y)=""
 S X=""
 F  S X=$O(ATT(X)) Q:X=""  S Y=ATT(X) D
 .I Y="" S ARR(X)=""
 .I Y'="" S ARR(Y)=""
 .Q
 I $D(ARR(1))!$D(ARR("*")) K ARR S ARR("*")=""
 I $O(ARR(""))="" D ERM(9,1) Q
 K ATT D FIELDLST(.DSI)
 S (X,ATT,ERR)=""
 F  S X=$O(ARR(X)) Q:X=""  I X'="*",'$D(DSI(X)) S ERR=ERR_X_";"
 I ERR'="" D ERM(10,1) Q
 S X="" F  S X=$O(DSI(X)) Q:X=""  D
 .I $D(ARR("*")) S ATT=ATT_X_";",ATT(X)=DSI(X) Q
 .I $D(ARR(X)) S ATT=ATT_X_";",ATT(X)=DSI(X)
 .Q
 I $E(ATT,$L(ATT))=";" S ATT=$E(ATT,1,$L(ATT)-1)
 Q
 ;
ERM(A,B) ;
 N X
 I A=1 S X="No internal value received"
 I A=2 S X="Unexpected problem encountered"
 I A=3 S X="No data found"
 I A=4 S X="No file received"
 I A=5 S X="File '"_DSI_"' does not exist"
 I A=6 S X="No field value received"
 I A=7 S X="No IENS string received"
 I A=8 S X="'"_IENS_"' is not a valid iens string"
 I A=9 S X="No attributes received"
 I A=10 S X="Invalid attribute name(s) received: "_ERR
 S X="-1^"_X S:'$G(B) DSIC=X S:$G(B) DSIC(B)=X
 Q
 ;
ERR() ; if $D(DIERR) return "-1^"_error msg from DSIER or ^TMP("DIERR",$J)
 N DSIX,INPUT
 S INPUT=$S($D(DSIER):"DSIER",1:"")
 S DSIX="-1^"_$$MSG^DSICFM01("VE",,,,INPUT) D CLEAN^DILF
 Q DSIX
 ;
FLDCK ; check for valid file/fld
 S FILE=$$VFILE(,FILE,1) I +FILE=-1 S DSIC(1)=FILE Q
 I $D(FIELD) D  Q:$D(DSIC)
 .S FIELD=$$VFIELD(,FILE,FIELD,1)
 .I +FIELD=-1 S DSIC(1)=FIELD
 .Q
 Q
 ;
INIT(STR) ; str - ^-delimited string of variable names to initialize
 N I,X
 F I=1:1:$L(STR,U) S X=$P(STR,U,I) I X'="" S @X=$G(@X)
 I STR["FLAG",$G(FLAG)'="" S FLAG=$$CNVT^DSICUTL(FLAG,"10NZ","U")
 I STR["TYPE" S TYPE=$S(TYPE=1:1,$$BROKER^DSICUTL:0,TYPE="":1,1:TYPE)
 Q
