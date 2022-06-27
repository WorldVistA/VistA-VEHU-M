SDESGETRECALL ;ALB/BLB,MGD,KML,LAB - VISTA SCHEDULING RPCS ;March 23, 2022
 ;;5.3;Scheduling;**803,805,809,813**;Aug 13, 1993;Build 6
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;Reference is made to ICR #10035
 Q
 ;
RECGETLIST(SDECY,DFN,SDEAS) ;Return a list of OPEN recall appointment types for patient
 ;INPUT  - DFN (Date File Number) Pointer to PATIENT (#2) File.
 ; SDEAS - [optional] Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
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
 ;         Number of Email Contacts
 ;         Number of Text Contacts
 ;         Number of Secure messages contact
 ;
 N SDRECALL,IEN,NUM,ERR,IENS,SDESJSONERR
 S DFN=$G(DFN),SDESJSONERR=0
 I DFN="" S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALL,1)
 S ERR=0,IEN=0,NUM=0
 I DFN'="",'$D(^DPT(DFN,0)) S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALL,2)
 S SDEAS=$G(SDEAS,"")
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL(SDEAS)
 I +SDEAS=-1 S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALL,142)
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
 N F,RECARY
 D GETS^DIQ(403.5,IEN,"**","IE","RECARY","SDMSG")
 S F=403.5
 S IENS=IEN_","
 S SDRECALL("Recall",NUM,"RecallIEN")=IEN
 S SDRECALL("Recall",NUM,"EASTrackingNumber")=RECARY(F,IENS,100,"E")
 S SDRECALL("Recall",NUM,"Accession")=RECARY(F,IENS,2,"E")
 S SDRECALL("Recall",NUM,"Comment")=RECARY(F,IENS,2.5,"E")
 S SDRECALL("Recall",NUM,"FastingNonFasting")=RECARY(F,IENS,2.6,"I")
 S SDRECALL("Recall",NUM,"ProviderIEN")=RECARY(F,IENS,4,"I")
 S SDRECALL("Recall",NUM,"ProviderName")=$$GET1^DIQ(403.54,SDRECALL("Recall",NUM,"ProviderIEN"),.01,"E")
 S SDRECALL("Recall",NUM,"ClinicIEN")=RECARY(F,IENS,4.5,"I")
 S SDRECALL("Recall",NUM,"ClinicName")=RECARY(F,IENS,4.5,"E")
 S SDRECALL("Recall",NUM,"AppointmentLength")=RECARY(F,IENS,4.7,"E")
 S SDRECALL("Recall",NUM,"RecallDate")=$$FMTISO^SDAMUTDT(RECARY(F,IENS,5,"I")) ; vse-2500
 S SDRECALL("Recall",NUM,"RecallDatePerPatient")=$$FMTISO^SDAMUTDT(RECARY(F,IENS,5.5,"I")) ; vse-2500
 S SDRECALL("Recall",NUM,"DateReminderSent")=$$FMTISO^SDAMUTDT(RECARY(F,IENS,6,"I")) ;vse-2500
 S SDRECALL("Recall",NUM,"SecondPrint")=$$FMTISO^SDAMUTDT(RECARY(F,IENS,8,"I")) ;vse-2500
 S SDRECALL("Recall",NUM,"DateTimeRecallAdded")=$$FMTISO^SDAMUTDT(RECARY(403.5,IENS,7.5,"I")) ;vse-2500
 Q
 ;
PATDATA(DFN,IEN) ;
 N SDREC
 S SDRECALL("Recall",NUM,"GAFScore")=$$GAF^SDECU2(DFN)
 S SDRECALL("Recall",NUM,"PatientSensitiveRecordAccessChecks")=$$PTSEC^SDECUTL(DFN)
 S SDRECALL("Recall",NUM,"SimilarPatientData")=$$SIM^SDECU3(DFN)
 S SDREC=$$RECALL^SDECAR1A(DFN,IEN)
 ;vse-2500 $$RECALL funtion returns external date (e.g., Mar 07, 2022) so need to convert to ISO8601
 ;first convert external date to fileman date before converting to ISO8601
 S X=$P(SDREC,U,2),%DT="T" D ^%DT S LETTERDATE=Y
 S SDRECALL("Recall",NUM,"NumberOfCallAttempts")=$P(SDREC,U)
 S SDRECALL("Recall",NUM,"RecallRemindersLetterDate")=$S(LETTERDATE=-1:"",1:$$FMTISO^SDAMUTDT(LETTERDATE))  ; vse-2500
 S SDRECALL("Recall",NUM,"NumberOfEmailContact")=$P(SDREC,U,3)
 S SDRECALL("Recall",NUM,"NumberOfTextContact")=$P(SDREC,U,4)
 S SDRECALL("Recall",NUM,"NumberOfSecureMessage")=$P(SDREC,U,5)
 Q
 ;
BUILDER ;
 D ENCODE^XLFJSON("SDRECALL","SDECY","ERR")
 Q
 ;
RECGETONE(SDECY,IEN,SDEAS) ;Return a single OPEN recall appointment type in JSON format based on the IEN passed
 ;INPUT - IEN (Internal Entry Number) RECALL REMINDERS File (403.5)
 ; SDEAS - [optional] Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
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
 ;         Number of Email Contacts
 ;         Number of Text Contacts
 ;         Number of Secure messages contact 
 ;
 N ERR,NUM,F,IENS,ACCESION,COMM,FASTING,RRAPPTYP,RRPROVIEN,PROVNAME,CLINIEN,SDTMP,NUM,SDECI,DFN,SDESJSONERR
 N CLINNAME,APPTLEN,MSGTYP,GAF,SENSITIVE,SIMILAR,SDREC,CPHONE,CLET,SDRECALL
 S SDESJSONERR=0
 S IEN=$G(IEN)
 I IEN="" S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALL,16)
 K RETURN
 S ERR=0,NUM=0
 I IEN'="",'$D(^SD(403.5,IEN)) S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALL,17)  ; send error and quit if patient has no entry in the RECALL REMINDERS File (403.5)
 S SDEAS=$G(SDEAS,"")
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL(SDEAS)
 I +SDEAS=-1 S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALL,142)
 I 'SDESJSONERR D
 . D RECDATAONE(IEN) ; build out recall data
 . D PATDATAONE(IEN) ; build out required patient data
 D BUILDER ; build return
 Q
 ;
RECDATAONE(IEN) ;
 N RECARY
 D GETS^DIQ(403.5,IEN,"**","IE","RECARY","SDMSG")
 S F=403.5
 S IENS=IEN_","
 S NUM=NUM+1
 S SDRECALL("Recall",NUM,"RecallIEN")=IEN
 S SDRECALL("Recall",NUM,"EASTrackingNumber")=RECARY(F,IENS,100,"E")
 S SDRECALL("Recall",NUM,"Accession")=RECARY(F,IENS,2,"E")
 S SDRECALL("Recall",NUM,"Comment")=RECARY(F,IENS,2.5,"E")
 S SDRECALL("Recall",NUM,"FastingNonFasting")=RECARY(F,IENS,2.6,"I")
 S SDRECALL("Recall",NUM,"TestApp")=RECARY(F,IENS,3,"I")
 S SDRECALL("Recall",NUM,"ProviderIEN")=RECARY(F,IENS,4,"I")
 S SDRECALL("Recall",NUM,"ProviderName")=$$GET1^DIQ(403.54,SDRECALL("Recall",NUM,"ProviderIEN"),.01,"E")
 S SDRECALL("Recall",NUM,"ClinicIEN")=RECARY(F,IENS,4.5,"I")
 S SDRECALL("Recall",NUM,"ClinicName")=RECARY(F,IENS,4.5,"E")
 S SDRECALL("Recall",NUM,"AppointmentLength")=RECARY(F,IENS,4.7,"E")
 S SDRECALL("Recall",NUM,"RecallDate")=$$FMTISO^SDAMUTDT(RECARY(F,IENS,5,"I")) ; vse-2500
 S SDRECALL("Recall",NUM,"RecallDatePerPatient")=$$FMTISO^SDAMUTDT(RECARY(F,IENS,5.5,"I")) ; vse-2500
 S SDRECALL("Recall",NUM,"DateReminderSent")=$$FMTISO^SDAMUTDT(RECARY(F,IENS,6,"I")) ;vse-2500
 S SDRECALL("Recall",NUM,"SecondPrint")=$$FMTISO^SDAMUTDT(RECARY(F,IENS,8,"I")) ;vse-2500
 S SDRECALL("Recall",NUM,"DateTimeRecallAdded")=$$FMTISO^SDAMUTDT(RECARY(403.5,IENS,7.5,"I")) ;vse-2500
 Q
 ;
PATDATAONE(IEN) ;
 N SDECALL,SDECLET,LETTERDATE,X,Y,%DT
 S DFN=$$GET1^DIQ(403.5,IEN,.01,"I")
 S SDRECALL("Recall",NUM,"GAFScore")=$$GAF^SDECU2(DFN)
 S SDRECALL("Recall",NUM,"PatientSensitiveRecordAccessChecks")=$$PTSEC^SDECUTL(DFN)
 S SDRECALL("Recall",NUM,"SimilarPatientData")=$$SIM^SDECU3(DFN)
 S SDREC=$$RECALL^SDECAR1A(DFN,IEN)
 ;vse-2500 $$RECALL funtion returns external date (e.g., Mar 07, 2022) so need to convert to ISO8601
 ;first convert external date to fileman date before converting to ISO8601
 S X=$P(SDREC,U,2),%DT="T" D ^%DT S LETTERDATE=Y
 S SDRECALL("Recall",NUM,"NumberOfCallAttempts")=$P(SDREC,U)
 S SDRECALL("Recall",NUM,"RecallRemindersLetterDate")=$S(LETTERDATE=-1:"",1:$$FMTISO^SDAMUTDT(LETTERDATE))  ; vse-2500
 S SDRECALL("Recall",NUM,"NumberOfEmailContact")=$P(SDREC,U,3)
 S SDRECALL("Recall",NUM,"NumberOfTextContact")=$P(SDREC,U,4)
 S SDRECALL("Recall",NUM,"NumberOfSecureMessage")=$P(SDREC,U,5)
 Q
