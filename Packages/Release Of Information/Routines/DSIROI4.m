DSIROI4 ;DSS/EWL - Document Storage Systems;ROI ;11/21/2011 08:55
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2053  UPDATE^DIE
 ;2053  WP^DIE
 ;2056  $$GET1^DIQ
 ;2056  GETS^DIQ
 ;3065  STDNAME^XLFNAME
 ;10060 $$GET1^DIQ(200,duz,.01)
 ;10061 ADD^VADPT
 Q
BTCH(RET,TYPE,IEN,SELLIST) ; RPC - DSIROI4 BTCH BATCH PROCESSING
 ; INPUT PARAMETERS
 ;   TYPE    : The type of cloning (1=multi patient, 2=multi requestors)
 ;   IEN     : The IEN of the request being cloned from 19620
 ;   SELLIST : A list of requestors or patients as follows: 
 ;          REQUESTOR IEN^REQUESTOR ADDRESS IEN
 ;          or 
 ;          PATIENT IEN^PATIENT ADDRESS IEN^ADDRESS TYPE
 ;                  (PATIENT IEN MUST BE FULLY QUALIFIED)
 ; RETURN VALUE
 ;   ONE BATCH REQUEST HAS BEEN CREATED
 ;   or
 ;   ## BATCH REQUESTS HAVE BEEN CREATED
 ;   or
 ;   -1^error message
 ;
 S TYPE=$G(TYPE),IEN=+(IEN)
 I '(TYPE=1!(TYPE=2)) S RET="-1^TYPE must be a 1 for multiple patient or 2 for multiple requestors."
 I '(IEN&$D(^DSIR(19620,IEN))) S RET="-1^ROI Instance file does not have an IEN of "_IEN_"."
 N LSTCT,PATDFN S LSTCT=0
 ;----------------
 ; VALIDATION CODE
 ;-------------------------------
 ; VALIDATE FOR MULTIPLE PATIENTS
 ;-------------------------------
 I TYPE=1 F  S LSTCT=$O(SELLIST(LSTCT)) Q:'LSTCT!($D(RET))  D
 .I $P(SELLIST(LSTCT),U,2)']"" S RET="-1^A patient was missing the address pointer." Q
 .I '$D(^DSIR(19620.92,$P(SELLIST(LSTCT),U,2))) S RET="-1^An invalid address was selected - "_$P(SELLIST(LSTCT),U,2) Q
 .;-----------------
 .; CHECK DOCUMENTS:
 .;-----------------
 .D EDOCS(.RET,IEN) K:RET=0 RET
 .I $G(RET)=1 S RET="-1^Original request contains electronic documents and cannot be cloned." Q:$D(RET)
 .;------------------------------------------------
 .;CODE FOR VALIDATING THE PATIENTS: NEED MORE INFO
 .;------------------------------------------------
 .S PATDFN=$P(SELLIST(LSTCT),U)
 .I PATDFN[";DPT(",$D(^DPT($P(PATDFN,";"))) Q
 .I PATDFN="1:DSIR(19620.95," Q
 .I PATDFN["DSIR(19620.96,",$D(^DSIR(19620.96,$P(PATDFN,";"))) Q
 .S RET="-1^AN INVALID PATIENT ID WAS SUBMITTED: "_PATDFN
 ;---------------------------------
 ; VALIDATE FOR MULTIPLE REQUESTORS
 ;---------------------------------
 I TYPE=2 F  S LSTCT=$O(SELLIST(LSTCT)) Q:'LSTCT!($D(RET))  D
 .I $P(SELLIST(LSTCT),U,2)']"" S RET="-1^A requestor was missing the address pointer." Q
 .I '$D(^DSIR(19620.12,$P(SELLIST(LSTCT),U,1))) S RET="-1^An invalid requestor was selected - "_$P(SELLIST(LSTCT),U,1) Q
 .I '$D(^DSIR(19620.92,$P(SELLIST(LSTCT),U,2))) S RET="-1^An invalid address was selected - "_$P(SELLIST(LSTCT),U,2) Q
 I $D(RET) Q
 ;---------------------------
 ; BEGIN CLONING THE REQUESTS 
 ;----------------------------------------------
 ; GET THE ORIGINAL REQUEST INSTANCE INFORMATION
 ;----------------------------------------------
 N GET,IENS,TFDA,TCMTS,CMTS,TICMTS,ICMTS,QRY
 S IENS=IEN_","
 ;---------------------------------------------------
 ; GET THE ORIGINAL IFORMATION FROM THE INSTANCE FILE
 ;---------------------------------------------------
 D GETS^DIQ(19620,IENS,"**","I","GET")
 S QRY=$NA(GET(19620)) K TFDA F  S QRY=$Q(@QRY) Q:QRY']""  D
 .I '(($QS(QRY,3)=.31)!($QS(QRY,3)=.32)!($QS(QRY,3)=203)!($QS(QRY,3)=204)) D
 ..S TFDA(19620,"+1,",$QS(QRY,3))=@QRY Q
 .;-----------------
 .; PROCESS COMMENTS
 .;-----------------
 .I $QS(QRY,3)=.31,$QS(QRY,4) S TCMTS($QS(QRY,4))=@QRY Q
 .;--------------------------
 .; PROCESS INTERNAL COMMENTS
 .;--------------------------
 .I $QS(QRY,3)=.32,$QS(QRY,4) S TICMTS($QS(QRY,4))=@QRY
 ;---------------------------
 ; GET THE ORIGINAL DOCUMENTS
 ;---------------------------
 N TDOCS,TDCMTS,REC,DOCCT,CCT S DOCCT=0,REC=0
 F  S REC=$O(^DSIR(19620.1,"B",IEN,REC)) Q:'REC  S DOCCT=DOCCT+1 D
 .K TDOC D GETS^DIQ(19620.1,REC_",","**","I","TDOC")
 .S TDOCS(19620.1,"+"_DOCCT_",",.01)=$G(TDOC(19620.1,REC_",",.01,"I"))
 .S TDOCS(19620.1,"+"_DOCCT_",",.02)=$G(TDOC(19620.1,REC_",",.02,"I"))
 .S TDOCS(19620.1,"+"_DOCCT_",",.03)=$G(TDOC(19620.1,REC_",",.03,"I"))
 .S TDOCS(19620.1,"+"_DOCCT_",",.04)=$G(TDOC(19620.1,REC_",",.04,"I"))
 .S TDOCS(19620.1,"+"_DOCCT_",",.05)=$G(TDOC(19620.1,REC_",",.05,"I"))
 .S TDOCS(19620.1,"+"_DOCCT_",",.06)=$G(TDOC(19620.1,REC_",",.06,"I"))
 .S TDOCS(19620.1,"+"_DOCCT_",",.07)=$G(TDOC(19620.1,REC_",",.07,"I"))
 .S TDOCS(19620.1,"+"_DOCCT_",",.08)=$G(TDOC(19620.1,REC_",",.08,"I"))
 .S TDOCS(19620.1,"+"_DOCCT_",",.09)=$G(TDOC(19620.1,REC_",",.09,"I"))
 .S TDOCS(19620.1,"+"_DOCCT_",",2.01)=$G(TDOC(19620.1,REC_",",2.01,"I"))
 .I $D(TDOC(19620.1,REC_",",1,"I")) S CCT=0 D
 ..F  S CCT=$O(TDOC(19620.1,REC_",",1,CCT)) Q:'CCT  D
 ...S TDCMTS(DOCCT,CCT)=TDOC(19620.1,REC_",",1,+CCT)
 ;--------------------------------------------------------
 ; PROCESS THE NEW REQUESTS
 ;--------------------------------------------------------
 N PATDFN,PATADDR,ADDRTYP,REQESTOR,RQSTRADR,FDA,IROOT,MSG,MSG1,MSG2,MSG3,RCT S (LSTCT,RCT)=0
 F  S LSTCT=$O(SELLIST(LSTCT)) Q:'LSTCT  S RCT=RCT+1 D
 .K FDA M FDA=TFDA
 .S FDA(19620,"+1,",10.09)=0
 .;-----------------------------
 .;PROCESS FOR MULTIPLE PATIENTS
 .;-----------------------------
 .I TYPE=1 D
 ..S PATDFN=$P(SELLIST(LSTCT),U,1),PATADDR=$P(SELLIST(LSTCT),U,2),ADDRTYP=+$P(SELLIST(LSTCT),U,3)
 ..S FDA(19620,"+1,",.01)=PATDFN
 ..S FDA(19620,"+1,",.82)=PATADDR
 ..S FDA(19620,"+1,",.83)=ADDRTYP
 ..S FDA(19620,"+1,",6.09)="P"
 .;---------------------------------
 .; PROCESSS FOR MULTIPLE REQUESTORS
 .;---------------------------------
 .I TYPE=2 D
 ..S REQESTOR=$P(SELLIST(LSTCT),U,1),RQSTRADR=$P(SELLIST(LSTCT),U,2)
 ..S FDA(19620,"+1,",.11)=REQESTOR
 ..S FDA(19620,"+1,",.81)=RQSTRADR
 ..S FDA(19620,"+1,",6.09)="R"
 .;-------------------------------------
 .; PERFORM UPDATES ON THE INSTANCE FILE
 .;-------------------------------------
 .K IROOT D UPDATE^DIE(,"FDA","IROOT","MSG")
 .I $D(TCMTS) M CMTS=TCMTS D WP^DIE(19620,IROOT(1)_",",.31,,"CMTS","MSG1")
 .I $D(TICMTS) M ICMTS=TICMTS D WP^DIE(19620,IROOT(1)_",",.32,,"ICMTS","MSG2")
 .;--------------------------
 .; UPDATE THE STATUS HISTORY
 .;--------------------------
 .D STATUS^DSIROI8(IROOT(1),"O",DUZ,GET(19620,IENS,10.06,"I"))
 .I TYPE=1 S TMPST=$$CURSTAT2^DSIROI6(IEN),ST=$P(TMPST,":") I ST'="O"  D
 ..D STATUS^DSIROI8(IROOT(1),ST,DUZ,$P(TMPST,":",4))
 .;---------------------
 .; UPDATE THE DOCUMENTS
 .;---------------------
 .K DROOT,FDA M FDA=TDOCS
 .S QRY="FDA" F  S QRY=$Q(@QRY) Q:QRY']""  S:$QS(QRY,3)=.01 @QRY=IROOT(1)
 .D UPDATE^DIE(,"FDA","DROOT","MSG")
 .I $D(TDCMTS) S REC=0 F  S REC=$O(TDCMTS(REC)) Q:'REC  D 
 ..K CMTS M CMTS=TDCMTS(REC) D WP^DIE(19620.1,DROOT(REC)_",",1,,"CMTS","MSG")
 I RCT>1 S RET=RCT_" BATCH REQUESTS HAVE BEEN CREATED"
 I RCT=1 S RET=RCT_" BATCH REQUEST HAS BEEN CREATED"
 I RCT=0 S RET="-1^NO BATCH REQUESTS WERE CREATED"
 Q
EDOCS(RET,IEN) ; RPC - DSIROI4 EDOCS CHECK FOR E DOCS
 ; INPUT PARAMETERS
 ;    IEN - THIS IS THE IEN OF THE REQUEST BEING TESTED FOR E-DOCS
 ; RETURN 
 ;    1 = YES, THE REQUEST CONTAINS ELECTRONIC DOCUMENTS
 ;    0 = YES, THE REQUEST DOESN NOT CONTAIN ELECTRONIC DOCUMENTS
 ;    OR
 ;    -1^ERROR MESSAGE
 N DIEN S DIEN=0 K RET
 I '$G(IEN) S RET="-1^THE REQUEST IEN IS A REQUIRED FIELD."
 F  S DIEN=$O(^DSIR(19620.1,"B",IEN,DIEN)) Q:'DIEN!$D(RET)  D
 .S MEDIA=$$GET1^DIQ(19620.1,DIEN_",",.04,"I")
 .S:'MEDIA RET=1 Q
 .S:MEDIA DOCCT=DOCCT+1
 I $D(RET) Q
 E  S RET=0
 Q
GETDEM(RET,IFN) ; RPC - DSIROI4 GETDEM GET DEMOGRAPHIC
 ; INPUT PARAMETER
 ;   IFN - Patient IFN
 ; RETURNS THE FOLLOWING LABELS WITH VALUES
 ;  1 "NAME"
 ;  2 "FIRST"
 ;  3 "MIDDLE"
 ;  4 "LAST"
 ;  5 "SUFFIX"
 ;  6 "GENDER"
 ;  7 "DOB"
 ;  8 "DOD"
 ;  9 "WORK PHONE"
 ; 10 "SSN"
 ; 11 "ADDRESS TYPE"
 ; 12 "ADDRESS STREET 1"
 ; 13 "ADDRESS STREET 2"
 ; 14 "ADDRESS STREET 3"
 ; 15 "ADDRESS CITY"
 ; 16 "ADDRESS STATE"
 ; 17 "ADDRESS ZIP"
 ; 18 "ADDRESS COUNTY"
 ; 19 "HOME PHONE"
 ;
 I '$G(IFN) S RET(1)="-1^Missing IFN. This is a required field." Q
 I '$D(^DPT(IFN)) S RET(1)="-1^Provided IFN is invalid." Q
 N FLDS,GET,IFNS,MSG S IFNS=IFN_","
 D GETS^DIQ(2,IFNS,".01;.02;.03;.09;.12105;.1217;.1218;.132;.351","IE","GET","MSG")
 I $D(MSG) S RET(1)="-1^Lookup failed" Q
 N X,NAME,SSN,Y
 S NAME=$G(GET(2,IFNS,.01,"E"))
 D STDNAME^XLFNAME(.NAME,"CF")
 S SSN=$G(GET(2,IFNS,.09,"E"))
 S Y=SSN I Y]"" S Y=Y_U_$E(Y,1,3)_"-"_$E(Y,4,5)_"-"_$E(Y,6,99),SSN=Y
 S RET(1)="NAME"_U_NAME
 S RET(2)="FIRST"_U_NAME("GIVEN")
 S RET(3)="MIDDLE"_U_NAME("MIDDLE")
 S RET(4)="LAST"_U_NAME("FAMILY")
 S RET(5)="SUFFIX"_U_NAME("SUFFIX")
 S RET(7)="DOB"_U_$G(GET(2,IFNS,.03,"I"))_U_$$FIXDT($G(GET(2,IFNS,.03,"I")))
 S RET(6)="GENDER"_U_$G(GET(2,IFNS,.02,"I"))_U_$G(GET(2,IFNS,.02,"E"))
 S RET(8)="DOD"_U_$G(GET(2,IFNS,.351,"I"))_U_$$FIXDT($G(GET(2,IFNS,.351,"I")))
 S RET(9)="WORK PHONE"_U_$G(GET(2,IFNS,.132,"E"))
 S RET(10)="SSN"_U_SSN
 N DFN,STR1,STR2,STR3,CITY,STAT,ZIPC,CNTY,PHON,CFLG,ADDRTYPE,TA,TASTART,TAEND S DFN=IFN
 D ADD^VADPT S CFLG=+VAPA(12) I 'CFLG D
 .S TA=$G(GET(2,IFNS,.12105,"I")),TASTART=$G(GET(2,IFNS,.1217,"I")),TAEND=$G(GET(2,IFNS,.1218,"I"))
 .I TA="Y",TASTART'>DT,TAEND'<DT S ADDRTYPE="TEMPORARY ADDRESS"
 .E  S ADDRTYPE="PRIMARY ADDRESS"
 .S STR1=VAPA(1),STR2=VAPA(2),STR3=VAPA(3),CITY=VAPA(4)
 .S STAT=VAPA(5),ZIPC=VAPA(6),CNTY=VAPA(7),PHON=VAPA(8)
 I CFLG D
 .S STR1=VAPA(13),STR2=VAPA(14),STR3=VAPA(15),CITY=VAPA(16)
 .S STAT=VAPA(17),ZIPC=VAPA(18),CNTY=VAPA(19),PHON=""
 .S ADDRTYPE="CONFIDENTIAL ADDRESS"
 S RET(11)="ADDRESS TYPE"_U_ADDRTYPE
 S RET(12)="ADDRESS STREET 1"_U_STR1
 S RET(13)="ADDRESS STREET 2"_U_STR2
 S RET(14)="ADDRESS STREET 3"_U_STR3
 S RET(15)="ADDRESS CITY"_U_CITY
 N STABRV S STABRV="" S:+$G(STAT) STABRV=$$GET1^DIQ(5,+STAT,1)
 S RET(16)="ADDRESS STATE"_U_STAT_U_STABRV
 S RET(17)="ADDRESS ZIP"_U_ZIPC
 S RET(18)="ADDRESS COUNTY"_U_CNTY
 I ADDRTYPE="TEMPORARY ADDRESS" S RET(19)="HOME PHONE"_U_PHON
 E  S RET(19)="HOME PHONE"_U_$G(GET(2,IFNS,.131,"I"))
 Q
FIXDT(FMDT) ; FORMAT TO MM/DD/YY
 I '$G(FMDT) Q ""
 Q $E(FMDT,4,5)_"/"_$E(FMDT,6,7)_"/"_($E(FMDT,1,3)+1700)
