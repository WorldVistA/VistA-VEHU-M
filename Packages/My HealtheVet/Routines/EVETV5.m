EVETV5 ;DALOI/KML - Extraction procedures for OUTPATIENT PHARMACY data to be stored on eVault ; 12/3/02 9:57am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 Q
 ; usage of PSOHCSUM supported by subscription to IA# 330
 ; access of VA PRODUCT NAME field (#21) contained in DRUG file (#50) 
 ;        supported by subscription to IA #553. 
 ; 
 ; EVETDFN       = DFN (ien of PATIENT file (#2)
 ; EVBDATE       = FileMan date at which to begin data extraction
 ; EVREQID       = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                 FROM HEALTH EVET
 ; PSOBEGIN      = Input variable needed when calling PSOHCSUM.
 ;                 represents date to begin search for prescriptions
 ;
GET(EVETDFN,EVBDATE,EVREQID) ; 
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVRTN,EVTMPGBL,DFN,EVCNT,EVETERR,EVETX3,PSOBEGIN
 S EVRTN="EVETLIS"
 S DFN=EVETDFN,PSOBEGIN=EVBDATE
 S EVTMPGBL="^TMP(EVRTN,$J,EVREQID,EVCNT)"
 S EVCNT=$O(^TMP(EVRTN,$J,EVREQID,""),-1)+1
 S @EVTMPGBL@("START_Prescriptions")=""
 S EVCNT=EVCNT+1
 D MEDS
 S @EVTMPGBL@("END_Prescriptions")=""
 Q
 ;
MEDS ;
 N EVMEDSTR,EVETSIG
 D ^PSOHCSUM
 ;I '$D(^TMP("PSOO",$J)) S EVETERR="No prescription data available for patient.",@EVTMPGBL@("error")=EVETERR,EVCNT=EVCNT+1 Q
 S EVETX3=0 F  S EVETX3=$O(^TMP("PSOO",$J,EVETX3)) Q:EVETX3<1  S EVMEDSTR=^(EVETX3,0),EVETSIG=$G(^TMP("PSOO",$J,EVETX3,1,0)) D BLDTMP
 Q
 ;
BLDTMP ;
 N EVVC,EVEEVC
 ;TEMP CODE TO RETURN 'ACTIVE' FOR TEST PURPOSES ONLY - LEL
 ;I EVCNT#5=0 S $P($P(EVMEDSTR,U,5),";",2)="ACTIVE"
 S @EVTMPGBL@("issue_date")=$$XMLDATE^EVETU1($P(EVMEDSTR,U))
 S @EVTMPGBL@("last_fill_date")=$$XMLDATE^EVETU1($P(EVMEDSTR,U,2))
 S @EVTMPGBL@("drug")=$P($P(EVMEDSTR,U,3),";",2)
 S @EVTMPGBL@("provider")=$P($P(EVMEDSTR,U,4),";",2)
 S @EVTMPGBL@("status")=$P($P(EVMEDSTR,U,5),";",2)
 S @EVTMPGBL@("prescription_number")=$P(EVMEDSTR,U,6)
 S @EVTMPGBL@("qty")=$P(EVMEDSTR,U,7)
 S @EVTMPGBL@("number_of_refills")=$P(EVMEDSTR,U,8)
 S @EVTMPGBL@("ien")=$P(EVMEDSTR,U,9)
 S @EVTMPGBL@("cost_fill")=$P(EVMEDSTR,U,10)
 S @EVTMPGBL@("expiration_cancel_date")=$$XMLDATE^EVETU1($P(EVMEDSTR,U,11))
 S @EVTMPGBL@("sig")=EVETSIG
 S @EVTMPGBL@("national_drug_formulary")=$$GET1^DIQ(50,$P($P(EVMEDSTR,U,3),";")_",",21)
 ;convoluted method of getting text va drug class. Broken down into 
 ;multiple lines for clarity.
 S EVEEVC=$P($P(EVMEDSTR,U,3),";")
 S EVVC=$$GET1^DIQ(50,EVEEVC_",",2)
 I EVVC'="" S @EVTMPGBL@("va_class")=$$GET1^DIQ(50.605,$$FIND1^DIC(50.605,"","",EVVC,"B")_",",1)
 S EVCNT=EVCNT+1
 Q
