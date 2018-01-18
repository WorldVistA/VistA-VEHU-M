EVETV1 ;DALOI/KML - Extraction procedures for patient demogrphic data to be stored on eVault ; 12/3/02 9:33am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 ; field references to the PATIENT File (#2) supported by IA#10035
 ; usage of VADPT utilities supported by IA#10061
 Q
 ;
 ; EVETDFN       = DFN (ien of PATIENT file (#2)
 ; EVETXX        = null value representing a placeholder for the calling
 ;                 front-end processing routine
 ; EVREQID       = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                 FROM HEALTH EVET
 ;
GET(EVETDFN,EVETXX,EVREQID) ;patient PROFILE
 ;
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVRTN,EVTAG,EVTMPGBL,DFN,EVCNT,EVVADM,EVETERR
 N VAERR,VADM,VAEL,VAPA,VAQEL,VAOA
 S EVRTN="EVETLIS",EVVADM=0
 S DFN=EVETDFN
 S EVTMPGBL="^TMP(EVRTN,$J,EVREQID,EVCNT)"
 S EVCNT=$O(^TMP(EVRTN,$J,EVREQID,""),-1)+1
 S @EVTMPGBL@("START_Personal_Information")=""
 S EVCNT=EVCNT+1
 S @EVTMPGBL@("ien")=EVETDFN
 F EVTAG="DEM","ELIG","ADD","OAD" D @EVTAG
 I EVVADM,$D(EVETERR) K EVETERR
 ;I $D(EVETERR) S @EVTMPGBL@("error")=EVETERR
 I '$D(EVETERR) D OTHER
 S EVCNT=EVCNT+1,@EVTMPGBL@("END_Personal_Information")=""
 Q
 ;
DEM ;
 N EVNAM
 D DEM^VADPT
 I VAERR S EVETERR="Patient Record not found" Q
 S EVVADM=1 ; flag indicating demo data found
 S EVNAM=$P(VADM(1),",",2)
 S @EVTMPGBL@("first_name")=$P(EVNAM," ")
 S @EVTMPGBL@("middle_initial")=$P(EVNAM," ",2)
 S @EVTMPGBL@("last_name")=$P(VADM(1),",")
 S:$D(VADM(2))'=0 @EVTMPGBL@("social_security_number")=$P(VADM(2),U,2)
 S:$D(VADM(5))'=0 @EVTMPGBL@("sex")=$P(VADM(5),U,2)
 S:$D(VADM(3))'=0 @EVTMPGBL@("date_of_birth")=$$XMLDATE^EVETU1($P(VADM(3),U))
 S:$D(VADM(10))'=0 @EVTMPGBL@("marital_status")=$P(VADM(10),U,2)
 Q
ELIG ;
 D ELIG^VADPT,ADD^VADPT
 I VAERR S EVETERR="Patient Record not found" Q
 S:$D(VAEL(3))'=0 @EVTMPGBL@("service_connected")=$P(VAEL(3),U)
 S:$D(VAEL(3))'=0 @EVTMPGBL@("service_connected_percentage")=$P(VAEL(3),U,2)
 S:$D(VAQEL(1))'=0 @EVTMPGBL@("primary_eligibility")=$P(VAEL(1),U,2)
 Q
 ;
ADD ; address data
 D ADD^VADPT
 I VAERR S EVETERR="Patient Record not found" Q
 S:$D(VAPA(1))'=0 @EVTMPGBL@("res_addr_1")=VAPA(1)
 S:$D(VAPA(2))'=0 @EVTMPGBL@("res_addr_2")=VAPA(2)
 S:$D(VAPA(3))'=0 @EVTMPGBL@("res_addr_3")=VAPA(3)
 S:$D(VAPA(4))'=0 @EVTMPGBL@("res_city")=VAPA(4)
 S:$D(VAPA(5))'=0 @EVTMPGBL@("res_state")=$P(VAPA(5),U,2)
 S:$D(VAPA(11))'=0 @EVTMPGBL@("res_zip")=$P(VAPA(11),U,2)
 S:$D(VAPA(8))'=0 @EVTMPGBL@("res_phone")=VAPA(8)
 Q
 ;
OAD ;Emergency contact info
 D OAD^VADPT
 I VAERR S EVETERR="Patient Record not found" Q
 S:$D(VAOA(9))'=0 @EVTMPGBL@("contact_name")=VAOA(9)
 S:$D(VAOA(10))'=0 @EVTMPGBL@("contact_relationship")=VAOA(10)
 S:$D(VAOA(1))'=0 @EVTMPGBL@("contact_addr_1")=VAOA(1)
 S:$D(VAOA(2))'=0 @EVTMPGBL@("contact_addr_2")=VAOA(2)
 S:$D(VAOA(3))'=0 @EVTMPGBL@("contact_addr_3")=VAOA(3)
 S:$D(VAOA(4))'=0 @EVTMPGBL@("contact_city")=VAOA(4)
 S:$D(VAOA(5))'=0 @EVTMPGBL@("contact_state")=$P(VAOA(5),U,2)
 S:$D(VAOA(11))'=0 @EVTMPGBL@("contact_zip")=$P(VAOA(11),U,2)
 S:$D(VAOA(8))'=0 @EVTMPGBL@("contact_phone")=VAOA(8)
 Q
 ;
OTHER ;
 S @EVTMPGBL@("occupation")=$$GET1^DIQ(2,EVETDFN_",",.07)
 S @EVTMPGBL@("provider")=$$GET1^DIQ(2,EVETDFN_",",.104)
 S @EVTMPGBL@("attending_physician")=$$GET1^DIQ(2,EVETDFN_",",.1041)
 Q
