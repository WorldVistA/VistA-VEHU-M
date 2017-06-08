VEJDVGR9 ;DSS/DBB; VISTA GATEWAY - various RPCs.
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;oVERFLOW FROM VEJDVGR0
RPT(AXY,PTEMP,INFO,MAXL) ;DBB; BROKER ('VEJD REPORTS')CALL
RPT2 K AXY
 ; RETURNS ARRAY CONTAINING PRINT TEMPLATE RESULTS
 ; PARAMETERS:
 ; 1 = PRINT TEMPLATE NAME
 ; 2 = FILE#;BEGIN;END;SORT BY;MARGIN;PAGE LENGTH (fm file # followed by optional BEGIN/END/SORT values for template
 ; (NOTE, THE SORT WILL NORMALLY = "@.01" BUT CAN BE ANY FIELD (OR MULTIPLE ONES)
 ; 3 = max lines to be returned (nil = ALL)
 ; RETURN:
 ; 0) = -1^ ERROR IF A PROBLEM
 ; OTHERWISE, 0) = LINE COUNT
         ; SUBSEQUENT LINES ARE REPORT CONTENT
 S FILEN=+INFO
 I '$D(^DD(FILEN)) S AXY(0)="FILE #"_FILEN_", DOES NOT EXIST" Q
 S SCREEN="I $P(^(0),U,4)="_FILEN
 S X=$$FIND1^DIC(.4,"","X",PTEMP,"",SCREEN,"VEJDMSG") K SCREEN
 S FLDS="" I 'X,PTEMP?.E1",".E,PTEMP'?.1"."1.5N.E S FLDS=PTEMP G GO
 I 'X S AXY(0)="PRINT TEMPLATE: "_PTEMP_", IN FILE #"_FILEN_", DOES NOT EXIST" Q
GO S INPUT("RTN")="EN1^DIP"
 S INPUT("CTRL")=1,INPUT("DEL")=1
 S INPUT("DEL")=0,VRM=$P(INFO,";",5) S:'VRM VRM=80
 S (IOM,INPUT("VRM"))=VRM K VRM
 S INPUT("VPG")=$P(INFO,";",6)
 K DSI S DSI=$NA(^XTMP("VEJDVGR0",$J))
 S L=0,DIC=$$ROOT^DILFD(FILEN) I FLDS="" S FLDS="["_PTEMP_"]"
 S FR=$P(INFO,";",2),TO=$P(INFO,";",3)
 S BY=$P(INFO,";",4) I BY="" S BY="@.01"
 I $E(BY)'="@",BY?.E1.N.1",".E S BY="@"_BY
 K @DSI S X=$$GET^DSICHFS(.DSI,.INPUT) I X<0 K AXY S AXY(0)=X Q
 K AXY S (I,L)=0 F  S L=$O(@DSI@(L)) Q:'L  D  I MAXL Q:I'<MAXL
 . S X=^(L),AXY(L)=X,I=I+1
 S AXY(0)=I
 Q
 ; FUNCTION VEJDVGCOMMA -
COMMA N XX
 S XX=""""_$TR(X,"""")_""","
 S X=XX Q
ORDROLE()    ; returns the role a person takes in ordering
 ; VAL: 0=nokey, 1=clerk, 2=nurse, 3=physician, 4=student, 5=bad keys
 ;I '$G(ORWCLVER) Q 0  ; version of client is to old for ordering
 I ($D(^XUSEC("OREMAS",DUZ))+$D(^XUSEC("ORELSE",DUZ))+$D(^XUSEC("ORES",DUZ)))>1 Q 5
 I $D(^XUSEC("OREMAS",DUZ)) Q 1                           ; clerk
 I $D(^XUSEC("ORELSE",DUZ)) Q 2                           ; nurse
 I $D(^XUSEC("ORES",DUZ)),$D(^XUSEC("PROVIDER",DUZ)) Q 3  ; doctor
 I $D(^XUSEC("PROVIDER",DUZ)) Q 4                         ; student
 Q 0
 ;COPIED FROM: ORWDRA32  ; - Radiology calls to support windows [6/28/02]
 ; RPC ENTRY:  VEJDVG RADIOLOGY GET LISTS
 ; LST = RETURN ARRAY
 ; PATID = PATINT IEN
 ; EVTDIV (NO LONGER USED)
 ; IMGTYP = IEN of DISPLAY GROUP (9= radiology)
 ;
 ;VEJDVG RADIOLOGY PLACE ORDER.
 ;INPUT: PatientIFN,     ;       CPT code of Radiology order
 ;       Modifiers list of internal numbers delimited by ";"
 ;       Transport Code
 ;       Urgency Code
 ;       Category Code (I=Inpatient, O=Outpatient)
 ;       Submit to location code
 ;       Electronic Signature
RADORD(AXY,PATID,PROVID,CPTCODE,MODS,TRANS,URGENCY,CATEGORY,SUBMITTO,ORL,REQDATE,ESIG,ORDTEXT) N RET
 K ORDIALOG
 S AXY(0)="" D  I $G(AXY(0))<0 S AXY(0)="-1^CPT Code '"_CPTCODE_"' is not in the ORDERABLE ITEMS FILE as an XRAY Procedure" Q
 . S X=$O(^ORD(101.43,"C.XRAY",CPTCODE_" ")) I X="" S AXY(0)=-1 Q
 . S X=$O(^ORD(101.43,"C.XRAY",X,"")) I 'X S AXY(0)=-1 Q
 . I X S X0=$G(^ORD(101.43,+X,0))  I +$P(X0,"^",3)'=+CPTCODE S AXY(0)=-1 Q
 . S ORDIALOG(4,1)=X ; THIS IS THE ACTUAL "ORDERABLE ITEM"
 ;D DEF(.LST,PATID,9) K LIST
 S I=0,L=0 F  S I=$O(LST(I)) Q:'I  D
 . S X=LST(I)
 . S X1="~Modifiers~Urgencies~Transport~Category~Submit to"
 . I X1[X S L=$F(X1,X)+2\10,J=1  Q
 . I $E(X)["~",'L Q
 .  I X?1.L1.4E1"^".E S J=$E($P(X,"^"),2,9),LIST(L,J)=X
 I TRANS="" S AXY(0)="-1^Transport Code is null" G Q
 I URGENCY="" S AXY(0)="-1^Urgency Code is null" G Q
 I CATEGORY="" S AXY(0)="-1^Category is null" G Q
 I SUBMITTO="" S AXY(0)="-1^Submit Code is null" G Q
 I REQDATE="" S AXY(0)="-1^No requested DATE/TIME specified" G Q
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
 D VALIDSIG^VEJDVGR0(.ESOK,PROVID,ESIG) I ESOK<1 S AXY(0)=ESOK Q
 ;PLACE ORDER HERE
 I '$G(PROVID) S PROVID=DUZ
 ;S ^DBB=14 M ^DBB("ORDIALOG")=ORDIALOG
 K RET D EN^VEJDVGR1(.RET,PATID,PROVID,ORL,"RAD",ESIG,.ORDIALOG) I $D(RET(0)) S AXY(0)=RET(0) Q
 ;I $L($P(DLG,U,2)) S ORCATFN=$P(DLG,U,2),DLG=$P(DLG,U,1)
 ;I $G(ORDIALOG("ORTS")) S ORTS=ORDIALOG("ORTS") K ORDIALOG("ORTS")
 ;I $G(ORDIALOG("ORSLOG")) S ORLOG=ORDIALOG("ORSLOG") K ORDIALOG("ORSLOG")
 ;I $D(ORDIALOG("OREVENT")) S OREVENT=ORDIALOG("OREVENT") K ORDIALOG("OREVENT")
 ;SAVE(REC,ORVP,ORNP,ORL,DLG,ORDG,ORIT,ORIFN,ORDIALOG,ORDEA)
 ;D SAVE^ORWDX(.REC,PATID,DUZ,ORL,DLG,ORDG,ORIT,"",ORDIALOG,ORDEA)
 ;
 ;S AXY(0)="0^ORDER PLACED"
Q ;AXY(0)
 Q
 ;DEF(LST,PATID,IMGTYP)  Get dialog data for radiology
DEF2 N ILST,I,X S ILST=0
 S LST($$NXT)="~ShortList"  D SHORT
 S IMGTYP=$$IMTYPE(IMGTYP)
 ;S LST($$NXT)="~Common Procedures" D COMMPRO
 S LST($$NXT)="~Modifiers" D MODIFYR
 S LST($$NXT)="~Urgencies" D URGENCY
 S LST($$NXT)="~Transport" D TRNSPRT
 S LST($$NXT)="~Category" D CATEGRY
 S LST($$NXT)="~Submit to" D SUBMIT
 ;S LST($$NXT)="~Last 7 Days" D LAST7
 Q
MODIFYR ; Get the modifiers (should be by imaging type)
 S I=$O(^RA(79.2,"C",IMGTYP,0)) Q:'I
 S X=0 F  S X=$O(^RAMIS(71.2,"AB",I,X)) Q:'X  S LST($$NXT)="i"_X_U_$P(^RAMIS(71.2,X,0),U)
 Q
SHORT ; from DEF, get short list of imaging quick orders
 N I,TMP
 D GETQLST^ORWDXQ(.TMP,IMGTYP,"Q")
 S I=0 F  S I=$O(TMP(I)) Q:'I  D
 . S LST($$NXT)="i"_TMP(I)
 Q
COMMPRO ; Get the common procedures
 S X=""
 F  S X=$O(^ORD(101.43,"COMMON",IMGTYP,X)) Q:X=""  D
 . S I=$O(^ORD(101.43,"COMMON",IMGTYP,X,0))
 . I $$REQDET,$P($G(^ORD(101.43,I,"RA")),U,2)="B" Q
 . S LST($$NXT)="i"_I_U_X_U_U_$$REQAPPR(I)
 Q
URGENCY ; Get the allowable urgencies and default
 S X="",I=0
 F  S X=$O(^ORD(101.42,"S.RA",X)) Q:X=""  D
 . S I=$O(^ORD(101.42,"S.RA",X,0))
 . S LST($$NXT)="i"_I_U_X
 S I=$O(^ORD(101.42,"B","ROUTINE",0))
 S LST($$NXT)="d"_I_U_"ROUTINE"
 Q
TRNSPRT ; Get the modes of transport
 F X="A^AMBULATORY","P^PORTABLE","S^STRETCHER","W^WHEELCHAIR" D
 . S LST($$NXT)="i"_X
 Q
CATEGRY ; Get the categories of exam  
 F X="I^INPATIENT","O^OUTPATIENT","E^EMPLOYEE","C^CONTRACT","S^SHARING","R^RESEARCH" D
 . S LST($$NXT)="i"_X
 Q
SUBMIT ; Get the locations to which the request may be submitted
 N TMPLST,ASK,X
 D EN4^RAO7PC1(IMGTYP,"TMPLST")
 S I=0 F  S I=$O(TMPLST(I)) Q:'I  S LST($$NXT)="i"_TMPLST(I)
 I $D(TMPLST) S I=$O(TMPLST(0)),X=$P(TMPLST(I),U,1,2),LST($$NXT)="d"_X
 ;S LST($$NXT)="~Ask Submit"
 I $G(EVTDIV) S X=$$GET^XPAR(+$G(EVTDIV)_";DIC(4,^SYS^PKG","RA SUBMIT PROMPT",1,"Q")
 E  S X=$$GET^XPAR("ALL","RA SUBMIT PROMPT",1,"Q")
 Q
NXT() S ILST=ILST+1 Q ILST  ; Increment index of LST
REQDET() ; Are "broad" procedures allowed for this division?
 N TMPDIV,RESULT
 S TMPDIV=DUZ(2)
 I $D(EVTDIV),$G(EVTDIV) S DUZ(2)=EVTDIV
 S RESULT=$$GET^XPAR("ALL","RA REQUIRE DETAILED",1,"Q")
 S DUZ(2)=TMPDIV
 Q RESULT
 ;
REQAPPR(IEN) ;  does procedure require radiologist approval?
 N RAIEN,X
 S RAIEN=$P($P($G(^ORD(101.43,IEN,0)),U,2),";",1)
 I +RAIEN=0 Q ""
 Q $P($G(^RAMIS(71,RAIEN,0)),U,11)
 ;
IMTYPE(DGRP) ; return the mnemonic for the imaging type
 Q $P(^ORD(100.98,DGRP,0),U,3)
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
