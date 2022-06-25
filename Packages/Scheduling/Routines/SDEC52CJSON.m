SDEC52CJSON ;ALB/BLB,TAW - VISTA SCHEDULING RPCS ;JUL 23, 2021@10:48
 ;;5.3;Scheduling;**784,785,788,790,799**;Aug 13, 1993;Build 7
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;Reference is made to ICR #10035
 Q
 ;
RECGETJSON(SDECY,DFN) ;Return a list of OPEN recall appointment types for patient
 ;INPUT - DFN (Date File Number) Pointer to PATIENT (#2) File.
 ;RETURN PARMETER:
 ;List of recalls associated with a given patient
 ;Data is delimited by carat (^).
 ; Field List:
 ; (1)     Internal IEN
 ; (2)     Accession #
 ; (3)     Comment
 ; (4)     Fast/Non-Fasting
 ; (5)     Test/App
 ; (6)     Provider IEN
 ; (7)     Provider Name
 ; (8)     Clinic IEN
 ; (9)     Clinic Name
 ; (10)    Length of Appointment
 ; (11)    Recall Date
 ; (12)    Recall Date (Per Patient)
 ; (13)    Date Reminder Sent
 ; (14)    Second Print
 ; (15)    Date/Time Recall Added
 ; (16)    GAF Score
 ; (17)    Patient Sensitive & Record Access Checks
 ; (18)    Similar Patient Data
 ; (19)    Number of Call Attempts
 ; (20)    Recall Reminders Letter Date
 ;
 N SDRECALL,IEN,NUM,ERR,IENS,SDESJSONERR
 S DFN=$G(DFN),SDESJSONERR=0
 I DFN="" S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALL,1)
 S ERR=0,IEN=0,NUM=0
 I DFN'="",'$D(^DPT(DFN,0)) S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALL,2)
 I 'SDESJSONERR D
 . F  S IEN=$O(^SD(403.5,"B",DFN,IEN)) Q:IEN=""  D
 . . S NUM=NUM+1
 . . D RECDATA(DFN,IEN)
 . . D PATDATA(DFN,IEN)
 .I '$D(SDRECALL("Recall")) S SDRECALL("Recall")=""
 D BUILDER
 Q
 ;
RECDATA(DFN,IEN) ;
 N F,DAPTDT,DATE,DATE1,DATE2,DATE3,RECARY
 D GETS^DIQ(403.5,IEN,"**","IE","RECARY","SDMSG")
 S F=403.5
 S IENS=IEN_","
 S SDRECALL("Recall",NUM,"RecallIEN")=IEN
 S SDRECALL("Recall",NUM,"EASTrackingNumber")=$G(RECARY(F,IENS,100,"E"))
 S SDRECALL("Recall",NUM,"Accession")=$G(RECARY(F,IENS,2,"E"))
 S SDRECALL("Recall",NUM,"Comment")=$G(RECARY(F,IENS,2.5,"E"))
 S SDRECALL("Recall",NUM,"FastingNonFasting")=$G(RECARY(F,IENS,2.6,"I"))
 S SDRECALL("Recall",NUM,"ProviderIEN")=$G(RECARY(F,IENS,4,"I"))
 S SDRECALL("Recall",NUM,"ProviderName")=$$GET1^DIQ(403.54,SDRECALL("Recall",NUM,"ProviderIEN"),.01,"E")
 S SDRECALL("Recall",NUM,"ClinicIEN")=$G(RECARY(F,IENS,4.5,"I"))
 S SDRECALL("Recall",NUM,"ClinicName")=$G(RECARY(F,IENS,4.5,"E"))
 S SDRECALL("Recall",NUM,"AppointmentLength")=$G(RECARY(F,IENS,4.7,"E"))
 S DATE=$G(RECARY(F,IENS,5,"I")) S DATE=$$FMTE^XLFDT(DATE)
 S DATE1=$G(RECARY(F,IENS,5.5,"I")) S DATE1=$$FMTE^XLFDT(DATE1)
 S DAPTDT=$G(RECARY(F,IENS,6,"I")) S DAPTDT=$$FMTE^XLFDT(DAPTDT)
 S DATE2=$G(RECARY(F,IENS,8,"I")) S DATE2=$$FMTE^XLFDT(DATE2)
 S DATE3=$G(RECARY(403.5,IENS,7.5,"E")) S DATE3=$$FMTE^XLFDT(DATE3)
 S SDRECALL("Recall",NUM,"RecallDate")=DATE
 S SDRECALL("Recall",NUM,"RecallDatePerPatient")=DATE1
 S SDRECALL("Recall",NUM,"DateReminderSent")=DAPTDT
 S SDRECALL("Recall",NUM,"SecondPrint")=DATE2
 S SDRECALL("Recall",NUM,"DateTimeRecallAdded")=DATE3
 Q
 ;
PATDATA(DFN,IEN) ;
 N SDREC
 S SDRECALL("Recall",NUM,"GAFScore")=$$GAF^SDECU2(DFN)
 S SDRECALL("Recall",NUM,"PatientSensitiveRecordAccessChecks")=$$PTSEC^SDECUTL(DFN)
 S SDRECALL("Recall",NUM,"SimilarPatientData")=$$SIM^SDECU3(DFN)
 S SDREC=$$RECALL^SDECAR1A(DFN,IEN)
 S SDRECALL("Recall",NUM,"NumberOfCallAttempts")=$P(SDREC,U)
 S SDRECALL("Recall",NUM,"RecallRemindersLetterDate")=$P(SDREC,U,2)
 Q
 ;
BUILDER ;
 D ENCODE^XLFJSON("SDRECALL","SDECY","ERR")
 Q
 ;
RECGETONEJSON(SDECY,IEN) ;Return a single OPEN recall appointment type in JSON format based on the IEN passed
 ;INPUT - IEN (Internal Entry Number) RECALL REMINDERS File (403.5)
 ;RETURN PARAMETER: recall based on IEN being passed
 ;Data is delimited by carat (^).
 ; Field List:
 ; (1)     Internal IEN
 ; (2)     Accession #
 ; (3)     Comment
 ; (4)     Fast/Non-Fasting
 ; (5)     Test/App
 ; (6)     Provider IEN
 ; (7)     Provider Name
 ; (8)     Clinic IEN
 ; (9)     Clinic Name
 ; (10)    Length of Appointment
 ; (11)    Recall Date
 ; (12)    Recall Date (Per Patient)
 ; (13)    Date Reminder Sent
 ; (14)    Second Print
 ; (15)    Date/Time Recall Added
 ; (16)    GAF Score
 ; (17)    Patient Sensitive & Record Access Checks
 ; (18)    Similar Patient Data
 ; (19)    Number of Call Attempts
 ; (20)    Recall Reminders Letter Date
 ;
 N ERR,NUM,F,IENS,ACCESION,COMM,FASTING,RRAPPTYP,RRPROVIEN,PROVNAME,CLINIEN,SDTMP,NUM,SDECI,DFN,SDESJSONERR
 N CLINNAME,APPTLEN,DATE,DATE1,DAPTDT,DATE2,DATE3,MSGTYP,GAF,SENSITIVE,SIMILAR,SDREC,CPHONE,CLET,SDRECALL
 S SDESJSONERR=0
 S IEN=$G(IEN)
 I IEN="" S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALL,16)
 K RETURN
 S ERR=0,NUM=0
 I IEN'="",'$D(^SD(403.5,IEN)) S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALL,17)  ; send error and quit if patient has no entry in the RECALL REMINDERS File (403.5)
 I 'SDESJSONERR D
 . D RECDATAONEJSON(IEN) ; build out recall data
 . D PATDATAONEJSON(IEN) ; build out required patient data
 D BUILDER ; build return
 Q
 ;
RECDATAONEJSON(IEN) ;
 N RECARY
 D GETS^DIQ(403.5,IEN,"**","IE","RECARY","SDMSG")
 S F=403.5
 S IENS=IEN_","
 S NUM=NUM+1
 S SDRECALL("Recall",NUM,"RecallIEN")=IEN
 S SDRECALL("Recall",NUM,"EASTrackingNumber")=$G(RECARY(F,IENS,100,"E"))
 S SDRECALL("Recall",NUM,"Accession")=$G(RECARY(F,IENS,2,"E"))
 S SDRECALL("Recall",NUM,"Comment")=$G(RECARY(F,IENS,2.5,"E"))
 S SDRECALL("Recall",NUM,"FastingNonFasting")=$G(RECARY(F,IENS,2.6,"I"))
 S SDRECALL("Recall",NUM,"TestApp")=$G(RECARY(F,IENS,3,"I"))
 S SDRECALL("Recall",NUM,"ProviderIEN")=$G(RECARY(F,IENS,4,"I"))
 S SDRECALL("Recall",NUM,"ProviderName")=$$GET1^DIQ(403.54,SDRECALL("Recall",NUM,"ProviderIEN"),.01,"E")
 S SDRECALL("Recall",NUM,"ClinicIEN")=$G(RECARY(F,IENS,4.5,"I"))
 S SDRECALL("Recall",NUM,"ClinicName")=$G(RECARY(F,IENS,4.5,"E"))
 S SDRECALL("Recall",NUM,"AppointmentLength")=$G(RECARY(F,IENS,4.7,"E"))
 S DATE=$G(RECARY(F,IENS,5,"I")) S DATE=$$FMTE^XLFDT(DATE)
 S DATE1=$G(RECARY(F,IENS,5.5,"I")) S DATE1=$$FMTE^XLFDT(DATE1)
 S DAPTDT=$G(RECARY(F,IENS,6,"I")) S DAPTDT=$$FMTE^XLFDT(DAPTDT)
 S DATE2=$G(RECARY(F,IENS,8,"I")) S DATE2=$$FMTE^XLFDT(DATE2)
 S DATE3=$G(RECARY(403.5,IENS,7.5,"E")) S DATE3=$$FMTE^XLFDT(DATE3)
 S SDRECALL("Recall",NUM,"RecallDate")=DATE
 S SDRECALL("Recall",NUM,"RecallDatePerPatient")=DATE1
 S SDRECALL("Recall",NUM,"DateReminderSent")=DAPTDT
 S SDRECALL("Recall",NUM,"SecondPrint")=DATE2
 S SDRECALL("Recall",NUM,"DateTimeRecallAdded")=DATE3
 Q
 ;
PATDATAONEJSON(IEN) ;
 N SDECALL,SDECLET
 S DFN=$$GET1^DIQ(403.5,IEN,.01,"I")
 S SDRECALL("Recall",NUM,"GAFScore")=$$GAF^SDECU2(DFN)
 S SDRECALL("Recall",NUM,"PatientSensitiveRecordAccessChecks")=$$PTSEC^SDECUTL(DFN)
 S SDRECALL("Recall",NUM,"SimilarPatientData")=$$SIM^SDECU3(DFN)
 S SDREC=$$RECALL^SDECAR1A(DFN,IEN)
 S SDRECALL("Recall",NUM,"NumberOfCallAttempts")=$P(SDREC,U)
 S SDRECALL("Recall",NUM,"RecallRemindersLetterDate")=$P(SDREC,U,2)
 Q
