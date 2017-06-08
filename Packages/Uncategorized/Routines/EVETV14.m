EVETV14 ;DALOI/KML - Extraction procedures for ADVERSE REACTION TRACKING data to be stored on eVault ; 12/26/02 3:53pm
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 Q
 ;
 ; usage of EN1^GMRAOR1 supported by subscription to IA #2421
 ; usage of EN1^GMRAOR2 supported by IA #2422
 ;
 ; EVETDFN       = DFN (ien of PATIENT file (#2)
 ; EVBDATE       = FileMan date at which to begin data extraction
 ; EVREQID       = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                 FROM HEALTH EVET
 ;
GET(EVETDFN,EVBDATE,EVREQID) ;
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVRTN,EVTMPGBL,EVCNT,EVEX1,EVCX,EVC1,EVC2,EVO1,EVS1,EV1208DA,EVV1,EVX1
 K EVPL,EVPLDET
 S EVRTN="EVETLIS"
 S EVTMPGBL="^TMP(EVRTN,$J,EVREQID,EVCNT)"
 S EVCNT=$O(^TMP(EVRTN,$J,EVREQID,""),-1)+1
 S @EVTMPGBL@("START_Allergies")=""
 S EVCNT=EVCNT+1
 D ALLERGY
 S @EVTMPGBL@("END_Allergies")=""
 Q
 ;
ALLERGY ;
 K GMRARXN
 D EN1^GMRAOR1(EVETDFN,"GMRARXN")  ; pass GMR routine the patient DFN and name of output array
 ; pass the second GMR API the IEN of file 120.8, which was returned in 
 ; the GMRARXN output array.  The GMRACT output array contains more data 
 ; on patient allergy history
 S EVX1=0 F  S EVX1=$O(GMRARXN(EVX1)) Q:EVX1<1  S EV1208DA=$P(GMRARXN(EVX1),U,3) D EN1^GMRAOR2(EV1208DA,"GMRACT"),PARSE K GMRACT
 Q
 ;
PARSE ; extract data from the GMR array
 ; process verified tx only
 I $P(GMRACT,U,4)'="VERIFIED" Q
 S EVC1=0 F  S EVC1=$O(GMRACT("C",EVC1)) Q:EVC1<1  D DCMTS S EVC2=0 F  S EVC2=$O(GMRACT("C",EVC1,EVC2)) Q:EVC2<1  D CMTS
 S EVO1=0 F  S EVO1=$O(GMRACT("O",EVO1)) Q:EVO1<1  S @EVTMPGBL@("date_observed_severity",EVO1)=$$XMLDATE^EVETU1($P(GMRACT("O",EVO1),U)),@EVTMPGBL@("severity",EVO1)=$P(GMRACT("O",EVO1),U,2)
 S EVS1=0 F  S EVS1=$O(GMRACT("S",EVS1)) Q:EVS1<1  S @EVTMPGBL@("symptom",EVS1)=GMRACT("S",EVS1)
 S EVV1=0 F  S EVV1=$O(GMRACT("V",EVV1)) Q:EVV1<1  S @EVTMPGBL@("VA_drug_class_name",EVV1)=$P(GMRACT("V",EVV1),U,2)
 D BLDTMP
 Q
 ;
DCMTS ; build nodes with date/time entered of comments
 S @EVTMPGBL@("date_time_entered_comments",EVC1)=$$XMLDATE^EVETU1($P(GMRACT("C",EVC1),U))
 Q
 ;
CMTS ; build nodes with existing comments
 S @EVTMPGBL@("comments",EVC1_"-"_EVC2)=GMRACT("C",EVC1,EVC2,0)
 Q
 ;
BLDTMP ; construct EVET temporary global
 ;Q:$P(GMRACT)<EVBDATE  ; records having an earlier date than that passed to VISTA extract process are not to be sent back to Health eVet dB.
 S @EVTMPGBL@("ien")=EV1208DA
 S @EVTMPGBL@("reactant")=$P(GMRACT,U)
 S @EVTMPGBL@("entered_by")=$P(GMRACT,U,2)
 I $P(GMRACT,U,3)]"" S @EVTMPGBL@("entered_by")=@EVTMPGBL@("entered_by")_", "_$P(GMRACT,U,3)
 S @EVTMPGBL@("is_verified")=$P(GMRACT,U,4)
 S @EVTMPGBL@("observed_historical")=$P(GMRACT,U,5)
 S @EVTMPGBL@("allergy_type")=$P(GMRACT,U,7)
 S @EVTMPGBL@("verified_by")=$$GET1^DIQ(120.8,EV1208DA_",",21)
 I $L(@EVTMPGBL@("verified_by"))=0 S @EVTMPGBL@("verified_by")="AUTOVERIFIED"
 S EVCNT=EVCNT+1
 Q
