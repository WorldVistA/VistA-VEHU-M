DSIFPAYR ;DSS/RED - RPC FOR FEE BASIS PAYMENTS ;12/31/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,19,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   2051  LIST^DIC
 ;   2052  FIELD^DID
 ;   2053  FILE^DIE
 ;   2171 - $$STA^XUAF4
 ;   5107  ^FBAAC & File 162.01
 ;   5216  ^FBAACO4
 ;   5087  ANES^FBAAFS  ;added DSIF*3.2*1
 ;   5274  File 442 access
 ;   3990  $$ICDDX^ICDCODE
 ;   1995  $$CPT^ICPTCOD
 ;  10103  $$FMTE^XLFDT
 ;   5091  $$CPT^FBAAUTL4
 ;   5273  ^FBAA(161.7
 ;   5744  $$VCNTR^FBUTL7,$$EDCNTRA^FBUTL7
 ;   2056  GETS^DIQ
 ;
 Q    ;no direct calls to the routine
 ;  ICR's:  3990, 1995 and 1996
ERRCHK ; Data validation, error checking and required field checks, called from DSIFPAY3
 ; Error checking routine for payments
 ; return -1^missing fields^...
 N DSIFANES  ; Anesthesia Flag added with DSIF*3.2*1
 S (DSIFANES,DSIFERR)=0  ; Error flags set to default of off
 I '$D(FBSUS) S FBSUS="FBSUS^"
 ; Check for time requirement for Anesthesia Added DSIF*3.2*1  (New field #43 added)
 I $$ANES^FBAAFS($$CPT^FBAAUTL4($G(FBAACPT))) S DSIFANES=1,FBTIME=$P(FBSERV,U,14) I '$G(FBTIME) S DSIFOUT="-1^Time is required for anesthesia",DSIFERR=1 Q
 ; Added descriptive text to the next entry if no CPT code exists
 S DSIFCPT=$$CPT^ICPTCOD($P($G(FBSERV),U),$P(FBID,U,2)) I +DSIFCPT=-1 S DSIFERR=1,FBOUT=$S(DSIFCPT["NO SUCH":"-1^Invalid CPT Code "_$P($G(FBSERV),U)_" entered",1:DSIFCPT) Q
 I $P(DSIFCPT,U,7)'=1 S DSIFERR=1,FBOUT="-1^CPT code inactive on date of service: "_$$FMTE^XLFDT($P(FBID,U,2)) Q
 S $P(FBSERV,U)=+DSIFCPT  ;Set CPT code equal to internal value in file 81
 I $P(FBSERV,U,8)="" S FBOUT="-1^No invoice number",DSIFERR=1 Q
 ; Invoice number must be >0 and 1-16 numbers
 I $P(FBSERV,U,8)'?1.16N!($P(FBSERV,U,8)<1) S FBOUT="-1^Invoice number is in invalid format - "_$P(FBSERV,U,8),DSIFERR=1 Q
 I $P(FBSERV,U,12)'["583",$P(FBDIAG,U)="" S FBOUT="-1^Primary Diagnosis is not present it is a required field, quitting",DSIFERR=1 Q
 S FBRET=$$ICDDX^ICDCODE($P(FBDIAG,U),$P(FBID,U,2)) D
 . I $P(FBRET,U,2)["INVALID" S FBOUT="-1^ "_$P(FBDIAG,U)_" is an invalid primary diagnosis, quitting",DSIFERR=1 Q
 . I $P(FBRET,"^",10)=0 S FBOUT="-1^Primary Diagnosis entered in inactive on "_$$FMTE^XLFDT($P(FBID,U,2),5)_", quitting",DSIFERR=1 Q
 I $P(FBDIAG,U,3),'$D(^IBE(353.2,$P(FBDIAG,U,3),0)) S FBOUT="-1^Invalid HCFA type of service entered, quitting",DSIFERR=1 Q
 S $P(FBDIAG,U,4)=$S($P(FBDIAG,U,4)="":"N",$P(FBDIAG,U,4)=0:"N",$P(FBDIAG,U,4)="N":"N",1:"Y")  ;Default to "N"
 I $P(FBSERV,U,2)=""!($P(FBSERV,U,3)="")!($P(FBSERV,U,6)="") S FBOUT="-1^Data error in Service provided field: "_$P(FBSERV,U,2)=""_U_($P(FBSERV,U,3)="")_U_($P(FBSERV,U,6)=""),DSIFERR=1 Q
 I $L($P(FBSERV,U,4))>0 S FBOUT="-1^Batch has been Finalized.",DSIFERR=1 Q
 I $P(FBSERV,U,5)="" S FBOUT="-1^No batch number entered, cannot proceed",DSIFERR=1 Q
 I '$D(^FBAA(161.7,$P(FBSERV,U,5),0)) S FBOUT="-1^Invalid Batch number entered",DSIFERR=1 Q
 ; As per issue reported at Columbia, SC  added a check to see if we are editing a payment, if so bypass the max line check below:  DSIF*3.2*1
 I FBNEWP,$P(^FBAA(161.7,$P(FBSERV,U,5),0),U,11)>(FBAAMPI-1) S FBOUT="-1^This Batch already has the maximum number of Payments!",DSIFERR=1 Q
 I '$D(^PRC(442,"B",$$STA^XUAF4($P($G(FBSITE(1)),U,3))_"-"_$P(FBSERV,U,6))) S FBOUT="-1^Invalid Obligation number",DSIFERR=1 Q
 S PID=$P(FBID,U),DFN=$P(PID,";"),FBV=$P(PID,";",2),FBSD=$P(PID,";",3),FBCNT=$P(PID,";",4),FBAADT=$P(FBID,U,2),FBCNP=$P(FBID,U,5)
 I $G(DFN)="" S FBOUT="-1^No patient entered, quitting",DSIFERR=1 Q
 ; Set Fee program = 2 (Outpatient)
 S:$P(FBID,U,3)="B3" $P(FBID,U,3)=2 I $P(FBID,U,3)'=2 S FBOUT="-1^Invalid Fee Program entered",DSIFERR=1 Q 
 I FBAADT'?7N S FBOUT="-1^Invalid date entered for Date of service: "_FBAADT,DSIFERR=1 Q
 I $P(FBDIAG,U,5)'?7N S FBOUT="-1^Invalid Vendor invoice date entered or missing: "_$P(FBDIAG,U,7),DSIFERR=1 Q
 S FBCNP=$P(FBID,U,5),FBAAID=$P(FBSERV,U,7),FBTAS=0
 S:$G(FBCNP)="" FBCNP=0
 I '$D(^FBAAA(DFN)) S FBOUT="-1^Invalid patient, not a current fee basis patient",DSIFERR=1 Q
 S MFLAG=0,FBAAID=$P(FBAAID,".")  ;set invoice received to date only
 I FBAAID'?7N S FBOUT="-1^Invalid or missing 'Date correct invoiced received'!",DSIFERR=1 Q
 I $P($G(^FBAAV(FBV,"ADEL")),U)="Y" S FBOUT="-1^Vendor has been flagged for Austin deletion!",DSIFERR=1 Q
 K F15,FBVER,FBVALID D FIELD^DID(162.03,15,"","POINTER","F15","MSG") S F15=F15("POINTER"),FBVER="" F I=1:1:$L(F15,";")-1 S FBVER=$S(I=1:$P($P(F15,";",I),":"),1:FBVER_U_$P($P(F15,";",I),":"))
 S FBVALID=0 F I=1:1:$L(FBVER,U)-1 I $P(FBSERV,U,9)=$P(FBVER,U,I) S FBVALID=1
 I 'FBVALID S FBOUT="-1^Invalid Patient type code entered",DSIFERR=1 Q
 ;Delete existing adjustments if "@" is passed into adjustments
 I '$P(FBID,U,6) N FBIENS I $P(FBADJ,U)="@" S FBIENS=FBCNT_","_FBSD_","_FBV_","_DFN_"," D DELADJ^DSIFPAYR(FBIENS)
 K MFLAGS,MFLAGD,FBIENS
 ;  Authorization IEN validity check
 S AUTHIEN=$P(FBID,U,4) I $G(AUTHIEN)<1 S FBOUT="-1^Invalid Authorization entered",DSIFERR=1 Q
 I '$D(^FBAAA(DFN,1,AUTHIEN)) S FBOUT="-1^Invalid Authorization entered",DSIFERR=1 Q
 I AUTHIEN'="" S FBAABDT=$P($G(^FBAAA(DFN,1,AUTHIEN)),"^")
 I FBAAID<FBAABDT S FBOUT="-1^Invoice date is earlier than Patient's Authorization date!!",DSIFERR=1 Q
 I $P(FBDIAG,U,5)>FBAAID S FBOUT="-1^Vendor's invoice date is later than the date you received it!!",DSIFERR=1 Q
 ;  Check Place of Service
 S DSIFPOS=$P(FBDIAG,U,2) I DSIFPOS,'$D(^IBE(353.1,DSIFPOS)) S FBOUT="-1^Place of Service is not valid!!",DSIFERR=1 Q
 ; This code will be reinstated once the modifiers code check is validated by the VA 
 ; No POV entered
 I $P(FBSERV,U,10)="" S $P(FBSERV,U,10)=$P(^FBAAA(DFN,1,AUTHIEN,0),U,7)
 I $P(FBSERV,U,10)="" S FBOUT="-1^Invalid POV entered or does not exist",DSIFERR=1 Q
 I $P(FBSERV,U,13)'="" D  Q:DSIFERR
 . ;DSIF*3.2*19  replace pattern match with $Piece, due to possible incompatibility issue with Cache 2008
 . I $P($P(FBSERV,U,13),";",2)'["FB583("&($P($P(FBSERV,U,13),";",2)'["FB7078(") S FBOUT="-1^The 7078 or 583 pointer is in invalid format",DSIFERR=1 Q
 . I $P(FBSERV,U,13)["FB7078",'$D(^FB7078(+$P(FBSERV,U,13),0)) S FBOUT="-1^Invalid 7078 pointer entered",DSIFERR=1 Q  ;DSIF*3.2*1 (changed 7078 to FB7078)
 . I $P(FBSERV,U,13)["FB583",'$D(^FB583(+$P(FBSERV,U,13),0)) S FBOUT="-1^Invalid 583 pointer entered",DSIFERR=1 Q       ;DSIF*3.2*1 (changed  583 to FB583)
 I '$D(^FBAA(161.82,$P(FBSERV,U,10),0)) S FBOUT="-1^Invalid POV entered or does not exist",DSIFERR=1 Q
 N I F I=1,2,3,6,7,8,9,10 I $P(FBSERV,U,I)="" S MFLAGS=$S(I="":I,1:MFLAGS_","_I)  ;change the values of the flag more appropriate
 N I F I=5,6,7 I $P(FBDIAG,U,I)="" S MFLAGD=$S(I="":I,1:MFLAGD_","_I)
 I $D(^FBAAC("C",$P(FBSERV,U,8))) S DA=FBV,FBAR(DA)="" D ^FBAACO4,CHKINV^DSIFPAY4
 I $D(MFLAGS) S FBOUT="-1^Required record fields in Service fields: "_MFLAGS_" are missing",DSIFERR=1 Q
 I $D(MFLAGD) S FBOUT="-1^Required record fields in Diagnosis fields: "_MFLAGD_" are missing",DSIFERR=1 Q
 I 'FBCNP,(FBAAID<FBAABDT) S FBOUT="-1^Invoice date is earlier than Patient's Authorization date!!",DSIFERR=1 Q
 S FBSCH1=$P(FBDIAG,U,14)  ;Fee Schedule (should be R, F or null)
 Q:$G(FBSCH1)=""  I "RF"'[FBSCH1 S FBOUT="-1^Invalid Fee Schedule entered",DSIFERR=1 Q
 ; DSIF*3.2*2 value checks 
 ; Contract number field 54
 I $G(DSFLDS(54)) D  Q:DSIFERR
 . I $G(^FBAA(161.43,"B",DSFLDS(54)))="" S FBOUT="-1^Invalid Contract number entered",DSIFERR=1 Q
 . I '$D(^FBAA(161.43,"AV",DSFLDS(54))) S FBOUT="-1^Contract number: "_DSFLDS(54)_" is not valid for this vendor",DSIFERR=1 Q
 ; Check for NPI and Taxonomy fields to ensure length of 10 characters DSIF*3.2*2
 N I F I=59,60,62,64,65,67,69,74,75 I $G(DSFLDS(I)),$L($G(DSFLDS(I)))'=10 S FBOUT="-1^Field #"_I_" must be 10 characters",DSIFERR=1 Q
 ; Name Fields should be 1-30 characters
 N I F I=58,61,63,66,68,73 I $G(DSFLDS(I))'="",($L(DSFLDS(I))>30) S FBOUT="-1^Field #"_I_" must be 1-30 characters",DSIFERR=1 Q
 Q
 ;
SITEP() ; extrinsic function used for validation
 ;Used to verify and set FBSITE - Fee Basis Site parameters, returns 1 if valid, 0 if not
 N FBPOP S FBPOP=1,FBSITE(0)=$G(^FBAA(161.4,1,0)) S:FBSITE(0)']"" FBPOP=0
 S FBSITE(1)=$G(^FBAA(161.4,1,1)) S:FBSITE(1)']"" FBPOP=0
 Q FBPOP
GETXREF(FBVAL) ;
 ; Used to get values from a file, based on entries, screens and cross references
 D LIST^DIC(FILE,IENS,FIELDS,FLAGS,NUMBER,.FROM,.PART,INDEX,.SCREEN,ID,TARGET,MSG)
 Q
DELADJ(FBIENS) ;Loop through and delete existing adjustments if "@" is passed in
 K FBFDA,I Q:(FBCNT=""!(FBV=""))
 Q:'$D(^FBAAC(DFN,1,FBV,1,FBSD,1,FBCNT,7))
 F I=1:1:$P($G(^FBAAC(DFN,1,FBV,1,FBSD,1,FBCNT,7,0)),U,4) D
 .S FBIENS=I_","_FBIENS
 .S FBFDA(162.07,FBIENS,.01)="@"
 .S FBFDA(162.07,FBIENS,1)="@"
 .S FBFDA(162.07,FBIENS,2)="@"
 .I $D(FBFDA) D FILE^DIE("","FBFDA")
 Q
CONTRACT ;
 ;DSIF*3.2*2  Check for valid contract and see if can be edited/deleted
 ;DSIFCNT = Contract number passed in or "@" for deletion, EXCNT = Existing contract number on file (edit)
 N IENS2,EXCNT,DSIFCE
 S DSIFCNT=$G(DSFLDS(54)) Q:DSIFCNT="@"
 I DSIFCNT>0,'$$VCNTR^FBUTL7(FBV,DSIFCNT) S FBOUT="-1^Contract number is not valid for this vendor, quitting",DSIFERR=1 Q
 S IENS2=AUTHIEN_","_DFN_",",DSIFCE=1
 D GETS^DIQ(161.01,IENS2,105,"I","EXCNT") S EXCNT=$G(EXCNT(161.01,IENS2,105,"I")),DSIFCE=$$EDCNTRA^FBUTL7(DFN,AUTHIEN)
 Q:EXCNT=DSIFCNT  ;Quit screen if existing contract equals contract entered for edit
 I +$G(DSIFCE)=0 S FBOUT="-1^Cannot edit Contract",DSIFERR=1 Q
 I DSIFCNT>0,$G(EXCNT)]"",+$G(EXCNT)'=DSIFCNT S FBOUT="-1^"_$P(DSIFCE,U,2),DSIFERR=1 Q
 Q
