VEJDVGR0 ;DSS/DBB; VISTA GATEWAY - various RPCs.
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;copied from ORWU
RPT(AXY,PTEMP,INFO,MAXL) ;DBB; BROKER ('VEJD REPORTS')CALL
 G RPT2^VEJDVGR9
 ;
TESTR D DT^DICRW
 I '$G(DUZ) S DUZ=10000000034
 K AXY ;D RPT(.AXY,"VEJDVG RADWISE","71;;;;80;999",500)
 D RPT(.AXY,"VEJDVG LAB","60;;;;132;999",900)
 Q
 ; FUNCTION VEJDVGCOMMA -
COMMA N XX
 S XX=""""_$TR(X,"""")_""","
 S X=XX Q
 ;RPC:  VEJDVG VALIDSIG
 ;arguments: DUZ: Provider DUZ to check against; SIG: electronic signature to check
 ;return:  1 if valid
 ;        -1^message if invalid
VALIDSIG(ESOK,TSTDUZ,SIG) ; returns TRUE if valid electronic signature
 I SIG="" S ESOK="-1^no signature passed" Q
 S X=$$DECRYP^XUSRB1(SIG),ESOK="-1^invalid signature" ; network encrypted
 I " "[X S ESOK=2 Q  ;ALLOW NULL SIGNATURE
 D HASH^XUSHSHP
 I X]"",X=$P($G(^VA(200,+TSTDUZ,20)),U,4) S ESOK=1
 Q
TESTSIG K RET D VALIDSIG(.RET,10000000032,",aAAZ:4?R/") ;,10000000038,".n11Zz+/B,")
 W RET Q
 ; AUTHENTICATE USER
 ; RPC:  VEJD VG AUTHENTICATE USER 
 ; PARAMETER1 = "ACCESSCODE;VERIFYCODE"
 ; RETURN - ARRAY OF DATA
 ; -1^error message
 ; UserDUZ^KeyCount^VerifyExpiration^authorized to write med orders
 ; - a UserDUZ > 0 indicates the user is authenticated as a VistA user.  
 ; - VerifyExpiration - days to VERIFY CODE expiration (-1 means NEVER expires)
 ; - authorized to write med orders - this is required to be a '1' for a provider to be allowed to write med orders
 ; - KeyCount will be the count of keys following.
 ;  KEY NAME 1 ;KEY NAME 2 ;  KEY NAME n
AUTH(AXY,ACCVER) N ADUZ  N VEJDVGR0,VEJDMES,X1 K X1
 I ACCVER="" S ADUZ=$G(DUZ),X1="" G:ADUZ AU2 S AXY(0)="-1^Nil ACCESS/VERIFY code, but user is not logged in"
 S XUF=0,ADUZ=$$CHECKAV^XUS(ACCVER) IF 'ADUZ S AXY(0)="-1^INVALID ACCESS/VERIFY CODES"
 S X=$P(ACCVER,";")
 S X=$$EN^XUSHSH($$UP^XUS(X)) I '$D(^VA(200,"A",X)) S AXY(0)="-1^Access code: "_$P(ACCVER,";")_" does not exist."
 I $G(AXY(0))<0 Q
AU2 D USER^XUS(ADUZ) ; GET EXPIRATATION & OTHER USER INFO
 S XOPT=$S($D(^XTV(8989.3,1,"XUS")):^("XUS"),1:"")
 I $P(XOPT,U,15) S X=$H-(XUSER(1)-$P(XOPT,U,15)) S X1=$S($P(XUSER(0),"^",8):-1,1:X) G AU3
 I $P(XOPT,U,15),(XUSER(1)-$P(XOPT,U,15)'>$H),'$P(XUSER(0),"^",8) S AXY(0)="-1^Verify code has expired"
 S X=$P(XUSER(0),"^",11) I X,X'>$H S AXY(0)="-1^User has been terminated"
AU3 I $G(AXY(0))<0 Q
 S AXY(0)=ADUZ_"^0^"_$G(X1)_"^"_+$$GET1^DIQ(200,ADUZ_",",53.1,"I","","VEJDMES")
 D GETS^DIQ(200,ADUZ_",","**","E","VEJDVGR0")
 S I=0,J=0 F  S J=$O(VEJDVGR0(200.051,J)) Q:'J  D
 . I $D(VEJDVGR0(200.051,J,.01,"E")) S I=I+1,AXY(I)=VEJDVGR0(200.051,J,.01,"E") ;W AXY(I),!
 S $P(AXY(0),"^",2)=I
 Q
TESTA ;K AXY S U="^" ;D AUTH(.AXY,"DBROWN2.;ZZZZZZZZZZ")
 ;D AUTH(.AXY,"PROG999-;999-PROG") ZW  Q
 ;COPIED FROM: ORWDRA32  ; - Radiology calls to support windows [6/28/02]
 ; RPC ENTRY:  VEJDVG RADIOLOGY GET LISTS
 ; LST = RETURN ARRAY
 ; PATID = PATINT IEN
 ; EVTDIV (NO LONGER USED)
 ; IMGTYP = IEN of DISPLAY GROUP (9= radiology)
 ;VEJDVG RADIOLOGY PLACE ORDER.
 ;INPUT: PatientIFN,Provider IEN, CPT code of Radiology order, Modifiers list of internal numbers delimited by ";"
 ; Transport Code, Urgency Code, Category Code (I=Inpatient, O=Outpatient), Submit to location code, Electronic Signature
RADORD(AXY,PATID,PROVID,CPTCODE,MODS,TRANS,URGENCY,CATEGORY,SUBMITTO,ORL,REQDATE,ESIG,ORDTEXT) N RET,VEJDMES
 N LIST,LST ;F X="PATID","PROVID","CPTCODE","MODS","TRANS","URGENCY","CATEGORY","SUBMITTO","ORL","REQDATE","ESIG" I $D(@X)#2 S ^DBB(X)=@X
 I $G(PROVID)?.N1";".1A1";".1A S ISOLATE=$P(PROVID,";",2),PREG=$P(PROVID,";",3),PROVID=+PROVID
 K ORDIALOG S AXY(0)="" I CPTCODE?1"i"1.N S CPTCODE=$TR(CPTCODE,"i","I")
 I CPTCODE?1"I"1.9N!(CPTCODE'?5N) D  Q:AXY(0)<0  G R2
 . S I=$S(CPTCODE?1"I".E:$E(CPTCODE,2,9),1:+CPTCODE) ; IEN into ORDERABLE ITEMS FILE
 . I $D(^ORD(101.43,+I,9,"B","RAD"))!$D(^("XRAY"))=0 S AXY(0)="-1^IEN '"_I_"' is not in the ORDERABLE ITEMS FILE as an XRAY Procedure" Q
 . S ORDIALOG(4,1)=I
 D  I $G(AXY(0))<0 S AXY(0)="-1^CPT Code '"_CPTCODE_"' is not in the ORDERABLE ITEMS FILE as an XRAY Procedure" Q
 . I CPTCODE?1"I"1.9N S X=+$E(CPTCODE,2,9) ; this is IEN into ORDERABLE ITEMS FILE
 . S X=$O(^ORD(101.43,"C.XRAY",CPTCODE_" ")) I X="" S AXY(0)=-1 Q
 . S X=$O(^ORD(101.43,"C.XRAY",X,"")) I 'X S AXY(0)=-1 Q
 . I X S X0=$G(^ORD(101.43,+X,0))  I +$P(X0,"^",3)'=+CPTCODE S AXY(0)=-1 Q
 . S ORDIALOG(4,1)=X ; THIS IS THE ACTUAL "ORDERABLE ITEM"
R2 D DEF(.LST,PATID,9) K LIST
 S I=0,L=0 F  S I=$O(LST(I)) Q:'I  D
 . S X=LST(I),X1="~Modifiers~Urgencies~Transport~Category~Submit to"
 . I X1[X S L=$F(X1,X)+2\10,J=1  Q
 . I $E(X)["~",'L Q
 . I X?1.L1.4E1"^".E S J=$E($P(X,"^"),2,9),LIST(L,J)=X
 I TRANS="" S AXY(0)="-1^Transport Code is null" G Q
 I URGENCY="" S AXY(0)="-1^Urgency Code is null" G Q
 I CATEGORY="" S AXY(0)="-1^Category is null" G Q
 I SUBMITTO="" S AXY(0)="-1^Submit Code is null" G Q
 S ISOLATE=$TR($G(ISOLATE),"yn","YN") I "YN"'[ISOLATE S AXY(0)="ISOLATION must be Y or N" G Q
 S:$G(ISOLATE)'="" ORDIALOG(177,1)=ISOLATE="Y"
 S PREG=$TR($G(PREG),"ynu","YNU") I "YNU"'[PREG S AXY(0)="PREGNANCY FLAG MUST BE 'Y', 'N' or 'U'" G Q
 S:$G(PREG)'="" ORDIALOG(14,1)=PREG
 I REQDATE="" S AXY(0)="-1^No requested DATE/TIME specified" G Q
 I REQDATE'?7N1".".N K VEJDMES D DT^DILF("T",REQDATE,.VEJD,"","VEJDMES") S REQDATE=VEJD I $D(VEJDMES) G MES
 I '$D(LIST(3,TRANS)) S AXY(0)="-1^Transport Code '"_TRANS_"' is not valid" G Q
 I '$D(LIST(2,URGENCY)) S AXY(0)="-1^Urgency Code '"_URGENCY_"' is not valid" G Q
 I '$D(LIST(4,CATEGORY)) S AXY(0)="-1^Category Code '"_CATEGORY_"' is not valid" G Q
 I '$D(LIST(5,SUBMITTO)) S AXY(0)="-1^Submit Code '"_SUBMITTO_"' is not valid" G Q
 S AXY(0)="" F I=1:1:$L(MODS,";") S X=$P(MODS,";",I) I X'="",'$D(LIST(1,X)) S AXY(0)=AXY(0)_"Modifier Code '"_X_"' is not valid. " S:AXY(0)'<0 AXY(0)="-1^"_AXY(0)
 I $G(AXY(0)) G Q
 S ORDIALOG(15,1)="ORDIALOG(""WP"",15,1)"
 S I="",J=0 F  S I=$O(ORDTEXT(I)) Q:I=""  S J=J+1,ORDIALOG("WP",15,1,J,0)=ORDTEXT(I)
 S ORDIALOG(6,1)=REQDATE,ORDIALOG(7,1)=URGENCY,ORDIALOG(9,1)=TRANS,ORDIALOG(10,1)=CATEGORY
 S ORDIALOG(4)="1^ORDERABLE",ORDIALOG(4,0)="P^101.43:EQSC"
 I '$G(PROVIDID) S PROVIDID=$G(DUZ) I 'DUZ S AXY(0)="-1^No provider specified" G Q
 I ESIG="" S AXY(0)="-1^NO encrypted ES code entered" Q
 I ESIG'="",$$DECRYP^XUSRB1(ESIG)="" S ESIG=""
 I ESIG'="" D VALIDSIG(.ESOK,PROVID,ESIG) I ESOK<1 S AXY(0)=ESOK Q
ORD I '$G(PROVID) S PROVID=DUZ ;PLACE ORDER HERE
 S ORDIALOG(177)=ISOLATE
 K RET D EN^VEJDVGR1(.RET,PATID,PROVID,ORL,"RAD",ESIG,.ORDIALOG) I $D(RET(0)) S AXY(0)=RET(0) Q
Q Q
TESTRAD D DT^DICRW
 I '$G(DUZ) S DUZ=10000000034
 K TXT S TXT(1)="LINE 1",TXT(2)="LINE 2",TXT(9)="LINE 3"
 D RADORD(.ZZ,441,"10000000034;;U","74000","1;2","A","1","O",2,99,"T+1@2P","%lbf/tttV ",.TXT)    ;,aAAZ:4?R/",.TXT) ;SIG FOR "DSS1234.-"
 X "ZW" Q
DEF(LST,PATID,IMGTYP) ; Get dialog data for radiology
 G DEF2^VEJDVGR9
TESTDEF K LIST D DEF^VEJDVGR0(.LIST,441,9)
 Q
 ; RPC: VEJDVG GET ORDERABLE ITEMS
 ; FROM = BEGINNING VALUE TO SEARCH FROM
 ; DIR = -1 FOR REVERSE.  = 1 (DEFAULT) FOR FORWARD
 ; IMGTYP = DISPLAY GROUP #(9 = RAD) OR SHORT NAME IN FILE 100.98 (RAD, LAB, ETC.)
 ; CNT = MAXIMUM NUMBER TO RETURN
RAORDITM(Y,FROM,DIR,IMGTYP,CNT) ; Return a subset of orderable items
 ; .Return Array, Starting Text, Direction, Cross Reference (S.xxx)
 N I,IEN,X,DTXT,REQDET,REQAPPR,XREF S I=0 I '$G(CNT) S CNT=44
 I IMGTYP'?1.3N,IMGTYP'?3.4A S Y="-1^DISPLAY TYPE MUST BE NUMERIC OR 3 ALPHAS" Q
 S XREF="S."_$S(IMGTYP?1.3N:$$IMTYPE(IMGTYP),1:IMGTYP)
 S:'DIR DIR=1
 F  Q:I'<CNT  S FROM=$O(^ORD(101.43,XREF,FROM),DIR) Q:FROM=""  D
 . S IEN=0 F  S IEN=$O(^ORD(101.43,XREF,FROM,IEN)) Q:'IEN  D
 . . I $$REQDET,$P($G(^ORD(101.43,IEN,"RA")),U,2)="B" Q
 . . S X=^ORD(101.43,XREF,FROM,IEN),X0=$G(^ORD(101.43,IEN,0))
 . . I +$P(X,U,3),$P(X,U,3)<DT Q
 . . S I=I+1
 . . ;In piece 3 is CPT code--piece 4 is coding system(CPT4, NLT or NDF)
 . . ;go to lab or pharmacy to get CPT code when code is not "C"
 . . I 'X S Y(I)=IEN_U_$P(X,U,2)_U_$$REQAPPR(IEN)_U_$S($E($P(X0,U,4))="C":$P(X0,U,3),$E($P(X0,U,4))="N":$$LABCPT(IEN),1:"")_U_$P(X0,U,2)
 . . ;I 'X S Y(I)=IEN_U_$P(X,U,2)_U_$P(X,U,2)_U_$$REQAPPR(IEN)
 . . ;E  S Y(I)=IEN_U_$P(X,U,2)_" <"_$P(X,U,4)_">"_U_$P(X,U,4)_U_$$REQAPPR(IEN) B
 Q
TESTORDI K LIST D RAORDITM(.LIST,"C",1,"CSLT",333)
 Q
TESTORD2 K LIST D RAORDITM(.LIST,"A",1,"LAB",35)
 Q
LABCPT(IEN) ;Used when coding system is 'NLT' DCN/DSS 3/3/05
 N X0,VAL,LR64,EN,CODED
 S LABCPT="",X0=$G(^ORD(101.43,IEN,0)) I $P(X0,U,4)'="NLT" Q LABCPT ;LAB ONLY
 S VAL=$P(X0,U,3),LR64=$$FIND1^DIC(64,"","",.VAL,"C")
 S EN=0 F  S EN=$O(^LAM(LR64,4,EN)) Q:+EN<1  S CODED=^(EN,0) I $P(CODED,U,4)="" D  ;ONLY DO THE ACTIVE ONES
 . S LABCPT=LABCPT_$P(CODED,";")_";"
 Q $E(LABCPT,1,($L(LABCPT)-1))
REQDET() ; Are "broad" procedures allowed for this division?
 N TMPDIV,RESULT
 S TMPDIV=DUZ(2)
 I $D(EVTDIV),$G(EVTDIV) S DUZ(2)=EVTDIV
 S RESULT=$$GET^XPAR("ALL","RA REQUIRE DETAILED",1,"Q")
 S DUZ(2)=TMPDIV
 Q RESULT
REQAPPR(IEN) ;  does procedure require radiologist approval?
 N RAIEN,X
 S RAIEN=$P($P($G(^ORD(101.43,IEN,0)),U,2),";",1)
 I +RAIEN=0 Q ""
 Q $P($G(^RAMIS(71,RAIEN,0)),U,11)
 ;
IMTYPE(DGRP) ; return the mnemonic for the imaging type
 Q $P($G(^ORD(100.98,DGRP,0)),U,3)
IMTYPSEL(Y,DUMMY) ;return list of active imaging types
 N X,I,IEN,DGRP,MNEM,NAME
 S X=""
 F I=1:1  S X=$O(^RA(79.2,"C",X)) Q:X=""  D
 . I '$D(^ORD(101.43,"S."_X)) Q
 . S IEN=$O(^RA(79.2,"C",X,0))
 . S NAME=$P(^RA(79.2,IEN,0),U,1)
 . S MNEM=$P(^RA(79.2,IEN,0),U,3)
 . S DGRP=$O(^ORD(100.98,"B",MNEM,0))
 . S Y(I)=IEN_U_NAME_U_MNEM_U_DGRP
 Q
TESTIMT K LIST D IMTYPSEL(.LIST,"")
 Q
RADSRC(Y,SRCTYPE) ; return list of available contract/sharing/research sources
 S X=0
 F I=1:1 S X=$O(^DIC(34,X)) Q:+X=0  D
 . Q:($P(^DIC(34,X,0),U,2)'=SRCTYPE)
 . I $D(^DIC(34,X,"I")),(^DIC(34,X,"I")<$$NOW^XLFDT) Q
 . S Y(I)=I_U_$P(^DIC(34,X,0),U,1)
 Q
MES ;
 N X K AXY
 S X="-1^" F I=1:1:VEJDMES("DIERR") S X=X_"^ "_VEJDMES("DIERR",I,"TEXT",1) Q:$L(X)>500
 S AXY(0)=X
 Q
