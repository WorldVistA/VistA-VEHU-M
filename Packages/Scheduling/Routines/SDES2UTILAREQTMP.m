SDES2UTILAREQTMP ;ALB/AGW - SDES2 UTILITY TO REQ GLOBAL ARRAY ; JUL 10,2026
 ;;5.3;Scheduling;**951**;Aug 13, 1993;Build 5
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to ^VA(200 in ICR #10060 ;
 ;
 ; called by SDES2GETAPPTREQ for SDES2 GET APPT REQ BY TYP VET to set up global array for RESULT
 Q
 ;
GETREQUESTTMP(REQUEST,REQUESTIEN,NUM) ;
 N ERR,IENS,FN,REQDATA,CLINSTOPIEN,CLINCREDIEN,DFN,SENSITIVE,CONTACTIEN,PRIOGROUP
 S FN=409.85
 S IENS=REQUESTIEN_","
 D GETS^DIQ(FN,IENS,"**","IE","REQDATA","ERR")
 Q:$D(ERR)
 ; Check the AMIS Stop codes on clinic
 S CLINSTOPIEN=$S(REQDATA(FN,REQUESTIEN_",",8.5,"I")'="":REQDATA(FN,REQUESTIEN_",",8.5,"I"),1:$$GET1^DIQ(44,REQDATA(FN,REQUESTIEN_",",8,"I")_",",8,"I"))
 S CLINCREDIEN=$S(REQDATA(FN,REQUESTIEN_",",13.5,"I")'="":REQDATA(FN,REQUESTIEN_",",13.5,"I"),1:$$GET1^DIQ(44,REQDATA(FN,REQUESTIEN_",",8,"I")_",",2503,"I"))
 ;
 I $D(^SDEC(409.85,REQUESTIEN,"PATCOM")) D BLDPATCMTSTMP(.REQUEST,REQUESTIEN,NUM)
 I '$D(^SDEC(409.85,REQUESTIEN,"PATCOM")) S @REQUEST@("Request",NUM,"PatientComment",1)=""
 ;
 I $D(^SDEC(409.85,REQUESTIEN,"COMAUD")) D BLDCOMMAUDITTMP(.REQUEST,REQUESTIEN,NUM)
 I '$D(^SDEC(409.85,REQUESTIEN,"COMAUD")) S @REQUEST@("Request",NUM,"CommentMultiple",1)=""
 ;
 I $D(^SDEC(409.85,REQUESTIEN,8)) D BDCPRSPREREQSTMP(.REQUEST,REQUESTIEN,NUM)
 I '$D(^SDEC(409.85,REQUESTIEN,8)) S @REQUEST@("Request",NUM,"CPRSPreRequisites",1)=""
 ;
 I $D(^SDEC(409.85,REQUESTIEN,2)) D BLDMRTCSTMP(.REQUEST,REQUESTIEN,NUM) ;MRTCs
 I '$D(^SDEC(409.85,REQUESTIEN,2)) S @REQUEST@("Request",NUM,"MRTC",1)=""
 ;
 D GETCONTACTIEN^SDES2CONTACTS(.CONTACTIEN,REQUESTIEN_";SDEC(409.85,")
 D BLDSDECONTMP(.REQUEST,REQUESTIEN,NUM,"A")
 I 'CONTACTIEN D SDECONTACT^SDES2GETREQS(.REQUEST,NUM) D
 .S @REQUEST@("Request",NUM,"SdecContactNumberOfCalls")=""
 .S @REQUEST@("Request",NUM,"SdecContactNumberOfEmailContact")=""
 .S @REQUEST@("Request",NUM,"SdecContactNumberOfTextContact")=""
 .S @REQUEST@("Request",NUM,"SdecContactNumberOfSecureMessage")=""
 .S @REQUEST@("Request",NUM,"SdecContactDateOfLastLetterSent")=""
 .S @REQUEST@("Request",NUM,"SdecContactNumberOfLetters")=""
 .S @REQUEST@("Request",NUM,"SdecContactNumberOfContacts")=0
 .Q
 ;
 S DFN=REQDATA(FN,REQUESTIEN_",",.01,"I")
 S PRIOGROUP=$$PRIORITY^DGENA(DFN)
 I PRIOGROUP S PRIOGROUP="GROUP "_PRIOGROUP
 ;
 S @REQUEST@("Request",NUM,"Type")="Appt Request"
 S @REQUEST@("Request",NUM,"PatientIEN")=DFN
 S @REQUEST@("Request",NUM,"PatientICN")=$$GETPATICN^SDESINPUTVALUTL(DFN)
 S @REQUEST@("Request",NUM,"PatientName")=REQDATA(FN,REQUESTIEN_",",.01,"E") ;
 S @REQUEST@("Request",NUM,"PatientPhone")=$$GET1^DIQ(2,DFN_",",.131,"E")
 S @REQUEST@("Request",NUM,"RequestIEN")=REQUESTIEN
 S @REQUEST@("Request",NUM,"RequestComments")=REQDATA(FN,REQUESTIEN_",",25,"E")
 S @REQUEST@("Request",NUM,"CreateDate")=$$FMTISO^SDAMUTDT(REQDATA(FN,REQUESTIEN_",",1,"I"))
 S @REQUEST@("Request",NUM,"InstitutionIEN")=REQDATA(FN,REQUESTIEN_",",2,"I")
 S @REQUEST@("Request",NUM,"InstitutionName")=REQDATA(FN,REQUESTIEN_",",2,"E")
 S @REQUEST@("Request",NUM,"InstitutionNumber")=$$GET1^DIQ(4,REQDATA(FN,REQUESTIEN_",",2,"I"),99)
 S @REQUEST@("Request",NUM,"RequestSubType")=REQDATA(FN,REQUESTIEN_",",4,"E")
 S @REQUEST@("Request",NUM,"ChildRequestSequenceNumber")=$$GET1^DIQ(409.85,REQUESTIEN,43.1,"I")
 S @REQUEST@("Request",NUM,"ClinicIEN")=REQDATA(FN,REQUESTIEN_",",8,"I")
 S @REQUEST@("Request",NUM,"ClinicName")=REQDATA(FN,REQUESTIEN_",",8,"E")
 S @REQUEST@("Request",NUM,"ClinicStopCodeIEN")=CLINSTOPIEN
 S @REQUEST@("Request",NUM,"ClinicStopCodeName")=$$GET1^DIQ(40.7,CLINSTOPIEN_",",.01,"E")
 S @REQUEST@("Request",NUM,"ClinicStopCodeAMIS")=$$GET1^DIQ(40.7,CLINSTOPIEN_",",1,"E")
 S @REQUEST@("Request",NUM,"ClinicSecondaryStopCodeIEN")=REQDATA(FN,REQUESTIEN_",",8.6,"I")
 S @REQUEST@("Request",NUM,"ClinicSecondaryStopCodeName")=REQDATA(FN,REQUESTIEN_",",8.6,"E")
 S @REQUEST@("Request",NUM,"ClinicSecondaryStopCodeAMIS")=$$GET1^DIQ(40.7,REQDATA(FN,REQUESTIEN_",",8.6,"I"),1)
 S @REQUEST@("Request",NUM,"CreditStopCodeIEN")=CLINCREDIEN
 S @REQUEST@("Request",NUM,"CreditStopCodeName")=$$GET1^DIQ(40.7,CLINCREDIEN_",",.01,"E")
 S @REQUEST@("Request",NUM,"CreditStopCodeAMIS")=$$GET1^DIQ(40.7,CLINCREDIEN_",",1,"E")
 S @REQUEST@("Request",NUM,"DisplayClinicAppt")=$$GET1^DIQ(44,REQDATA(FN,REQUESTIEN_",",8,"I")_",",62,"E")
 S @REQUEST@("Request",NUM,"ApptType")=REQDATA(FN,REQUESTIEN_",",8.7,"E")
 S @REQUEST@("Request",NUM,"EnteredByName")=REQDATA(FN,REQUESTIEN_",",9,"E")
 S @REQUEST@("Request",NUM,"EnteredByIEN")=REQDATA(FN,REQUESTIEN_",",9,"I")
 S @REQUEST@("Request",NUM,"DateTimeEntered")=$$FMTISO^SDAMUTDT($G(REQDATA(FN,REQUESTIEN_",",9.5,"I")))
 S @REQUEST@("Request",NUM,"Priority")=REQDATA(FN,REQUESTIEN_",",10,"E")
 S @REQUEST@("Request",NUM,"EnrollmentPriorityGroup")=PRIOGROUP
 S @REQUEST@("Request",NUM,"ByPatientOrProvider")=REQDATA(FN,REQUESTIEN_",",11,"E")
 S @REQUEST@("Request",NUM,"ProviderIEN")=REQDATA(FN,REQUESTIEN_",",12,"I")
 S @REQUEST@("Request",NUM,"ProviderName")=REQDATA(FN,REQUESTIEN_",",12,"E")
 S @REQUEST@("Request",NUM,"ProviderSecID")=$$GET1^DIQ(200,REQDATA(FN,REQUESTIEN_",",12,"I"),205.1)
 S @REQUEST@("Request",NUM,"ScheduledDateOfAppt")=$$FMTISO^SDAMUTDT(REQDATA(FN,REQUESTIEN_",",13,"I"))
 S @REQUEST@("Request",NUM,"DateLinkedApptMade")=$$FMTISO^SDAMUTDT(REQDATA(FN,REQUESTIEN_",",13.1,"I"))
 S @REQUEST@("Request",NUM,"LinkedApptClinic")=REQDATA(FN,REQUESTIEN_",",13.2,"E")
 S @REQUEST@("Request",NUM,"LinkedApptInstitutionName")=REQDATA(FN,REQUESTIEN_",",13.3,"E")
 S @REQUEST@("Request",NUM,"LinkedApptInstitutionNumber")=REQDATA(FN,REQUESTIEN_",",13.3,"I")
 S @REQUEST@("Request",NUM,"LinkedApptStopCode")=REQDATA(FN,REQUESTIEN_",",13.4,"E")
 S @REQUEST@("Request",NUM,"LinkedApptCreditStopCode")=REQDATA(FN,REQUESTIEN_",",13.5,"E")
 S @REQUEST@("Request",NUM,"LinkedApptStationNumber")=REQDATA(FN,REQUESTIEN_",",13.6,"E")
 S @REQUEST@("Request",NUM,"LinkedApptEnteredBy")=REQDATA(FN,REQUESTIEN_",",13.7,"E")
 S @REQUEST@("Request",NUM,"LinkedApptStatus")=REQDATA(FN,REQUESTIEN_",",13.8,"E")
 S @REQUEST@("Request",NUM,"ServiceConnectedPercentage")=REQDATA(FN,REQUESTIEN_",",14,"E")
 S @REQUEST@("Request",NUM,"PatientIndicatedDate")=$$FMTISO^SDAMUTDT(REQDATA(FN,REQUESTIEN_",",22,"I"))
 S @REQUEST@("Request",NUM,"Status")=(REQDATA(FN,REQUESTIEN_",",23,"E"))
 S @REQUEST@("Request",NUM,"MRTCNeeded")=REQDATA(409.85,REQUESTIEN_",",41,"E")
 S @REQUEST@("Request",NUM,"MRTCDaysBetweenAppts")=REQDATA(409.85,REQUESTIEN_",",42,"E")
 S @REQUEST@("Request",NUM,"MRTCHowManyNeeded")=REQDATA(409.85,REQUESTIEN_",",43,"E")
 S @REQUEST@("Request",NUM,"EASTrackingNumber")=REQDATA(FN,REQUESTIEN_",",100,"E")
 S @REQUEST@("Request",NUM,"DispositionedDate")=$$FMTISO^SDAMUTDT(REQDATA(FN,REQUESTIEN_",",19,"I"))
 S @REQUEST@("Request",NUM,"DispositionedBy")=REQDATA(FN,REQUESTIEN_",",20,"I")
 S @REQUEST@("Request",NUM,"DispositionedBy")=REQDATA(FN,REQUESTIEN_",",20,"E")
 S @REQUEST@("Request",NUM,"DispositionReason")=REQDATA(FN,REQUESTIEN_",",21,"E")
 S @REQUEST@("Request",NUM,"DispositionIEN")=REQDATA(FN,REQUESTIEN_",",21,"I")
 S @REQUEST@("Request",NUM,"ServiceConnectedPriority")=REQDATA(FN,REQUESTIEN_",",15,"E")
 S @REQUEST@("Request",NUM,"PatientStatus")=REQDATA(FN,REQUESTIEN_",",.02,"E")
 S @REQUEST@("Request",NUM,"ParentRequestIEN")=REQDATA(FN,REQUESTIEN_",",43.8,"I")
 S @REQUEST@("Request",NUM,"ModalityName")=REQDATA(FN,REQUESTIEN_",",6,"E")
 S @REQUEST@("Request",NUM,"ModalityCode")=REQDATA(FN,REQUESTIEN_",",6,"I")
 S @REQUEST@("Request",NUM,"CPRSOrderID")=REQDATA(FN,REQUESTIEN_",",46,"I")
 S @REQUEST@("Request",NUM,"CPRSTimeSensitive")=REQDATA(FN,REQUESTIEN_",",47,"I")
 S @REQUEST@("Request",NUM,"PIDChangeAllowed")=$S(+$G(REQDATA(FN,REQUESTIEN_",",49,"I"))=1:1,1:0)
 S @REQUEST@("Request",NUM,"PatientLast4")=$$LAST4SSN^SDESINPUTVALUTL(DFN)
 S @REQUEST@("Request",NUM,"DuplicateReason")=$G(REQDATA(FN,REQUESTIEN_",",51,"E"))
 ; sensitive record indicator
 D SENSITIVE^SDES2UTIL(.SENSITIVE,DFN,DUZ)
 S @REQUEST@("Request",NUM,"SensitiveRecord")=$G(SENSITIVE(1))
 ; build recall and consult
  S @REQUEST@("Request",NUM,"RecallAccessionNumber")=""
 S @REQUEST@("Request",NUM,"RecallComment")=""
 S @REQUEST@("Request",NUM,"RecallFastingNonFasting")=""
 S @REQUEST@("Request",NUM,"RecallProviderIEN")=""
 S @REQUEST@("Request",NUM,"RecallProviderName")=""
 S @REQUEST@("Request",NUM,"RecallAppointmentLength")=""
 S @REQUEST@("Request",NUM,"RecallProviderIndicatedDate")=""
 S @REQUEST@("Request",NUM,"RecallDateReminderSent")=""
 S @REQUEST@("Request",NUM,"RecallSecondPrint")=""
 S @REQUEST@("Request",NUM,"RecallGAFScore")=""
 S @REQUEST@("Request",NUM,"RecallSimilarPatientData")=""
 S @REQUEST@("Request",NUM,"RecallAppointmentType")=""
 S @REQUEST@("Request",NUM,"RecallProviderNewPersonIEN")=""
 S @REQUEST@("Request",NUM,"RecallProviderSecID")=""
 S @REQUEST@("Request",NUM,"RecallClinicStopCodeIEN")=""
 S @REQUEST@("Request",NUM,"RecallClinicStopCodeAMIS")=""
 S @REQUEST@("Request",NUM,"RecallClinicStopCodeName")=""
 S @REQUEST@("Request",NUM,"RecallClinicSecondaryStopCodeIEN")=""
 S @REQUEST@("Request",NUM,"RecallClinicSecondaryStopCodeAMIS")=""
 S @REQUEST@("Request",NUM,"RecallClinicSecondaryStopCodeName")=""
 S @REQUEST@("Request",NUM,"RecallEnteredBySecID")=""
 I '$D(@REQUEST@("Request",NUM,"DuplicateReason")) S @REQUEST@("Request",NUM,"DuplicateReason")=""
 I '$D(@REQUEST@("Request",NUM,"EASTrackingNumber")) S @REQUEST@("Request",NUM,"EASTrackingNumber")=""
 S @REQUEST@("Request",NUM,"ConsultAssociatedStopCodes",1)=""
 S @REQUEST@("Request",NUM,"ConsultRequestType")=""
 S @REQUEST@("Request",NUM,"ConsultToService")=""
 S @REQUEST@("Request",NUM,"ConsultCovidPriority")=""
 S @REQUEST@("Request",NUM,"ConsultDateReleasedFromCPRS")="" ; check
 S @REQUEST@("Request",NUM,"ConsultUrgencyOrEarliestDate")=""
 S @REQUEST@("Request",NUM,"ConsultServiceRenderedAs")=""
 S @REQUEST@("Request",NUM,"ConsultProhibitedClinicFlag")=""
 S @REQUEST@("Request",NUM,"ConsultClinicIndicatedDate")=""
 S @REQUEST@("Request",NUM,"ConsultCanEditPid")=""
 S @REQUEST@("Request",NUM,"CPRSStatus")=""
 I '$D(@REQUEST@("Request",NUM,"DuplicateReason")) S @REQUEST@("Request",NUM,"DuplicateReason")=""
 I '$D(@REQUEST@("Request",NUM,"EASTrackingNumber")) S @REQUEST@("Request",NUM,"EASTrackingNumber")=""
 Q
 ;
BLDSDECONTMP(REQUEST,REQUESTIEN,NUM,REQUESTTYPE) ;get consult/recall
 N CONTACTIEN,SUBIEN,CLINICIEN,CIENS,COUNT,CONTARY,CONTACTYPE,CONTACTS,ERRORS
 S COUNT=0,CONTACTIEN=0
 S CLINICIEN=$$GET1^DIQ(409.85,REQUESTIEN,8,"I")
 S CONTACTIEN=$$GETCONTIEN^SDESCONTACTS(.ERRORS,REQUESTIEN,REQUESTTYPE)
 I 'CONTACTIEN S @REQUEST@("Request",NUM,"Contact",1)="" Q
 S SUBIEN=$$GET1^DIQ(409.86,CONTACTIEN,2.2,"I")-1
 F  S SUBIEN=$O(^SDEC(409.86,CONTACTIEN,1,SUBIEN)) Q:'SUBIEN  D
 .S CIENS=SUBIEN_","_CONTACTIEN_","
 .S CONTACTYPE=$$GET1^DIQ(409.863,CIENS,1,"I")
 .I $L($G(CONTACTYPE)) D
 ..S CONTARY(CONTACTYPE)=$G(CONTARY(CONTACTYPE))+1
 ..S COUNT=COUNT+1
 ..S @REQUEST@("Request",NUM,"SdecContactNumberOfCalls")=$G(CONTARY("C"))
 ..S @REQUEST@("Request",NUM,"SdecContactNumberOfEmailContact")=$G(CONTARY("E"))
 ..S @REQUEST@("Request",NUM,"SdecContactNumberOfTextContact")=$G(CONTARY("T"))
 ..S @REQUEST@("Request",NUM,"SdecContactNumberOfSecureMessage")=$G(CONTARY("S"))
 ..S @REQUEST@("Request",NUM,"SdecContactNumberOfLetters")=$G(CONTARY("L"))
 ..S:($G(CONTACTYPE)="L") @REQUEST@("Request",NUM,"SdecContactDateOfLastLetterSent")=$$FMTISO^SDAMUTDT($$GET1^DIQ(409.863,CIENS,.01,"I"),$G(CLINICIEN))
 .S:('$D(@REQUEST@("Request",NUM,"SdecContactDateOfLastLetterSent"))) @REQUEST@("Request",NUM,"SdecContactDateOfLastLetterSent")=""
 S @REQUEST@("Request",NUM,"SdecContactNumberOfContacts")=COUNT
 D BLDCONTACT^SDESCONTACTS(.CONTACTS,CONTACTIEN)
 D DISPMULT^SDESCONTACTS(.CONTACTS,CONTACTIEN)
 I $D(CONTACTS) M @REQUEST@("Request",NUM)=CONTACTS Q
 I '$D(CONTACTS) S @REQUEST@("Request",NUM,"Contact",1)=""
 Q
 ;
BLDPATCMTSTMP(REQUEST,REQUESTIEN,NUM) ;
 N SUBIEN,COUNT
 S SUBIEN=0,COUNT=0
 F  S SUBIEN=$O(^SDEC(409.85,REQUESTIEN,"PATCOM",SUBIEN)) Q:'SUBIEN  D
 .S COUNT=COUNT+1
 .S @REQUEST@("Request",NUM,"PatientComment",COUNT,"Comment")=$$GET1^DIQ(409.855,SUBIEN_","_REQUESTIEN_",",.01,"E")
 Q
 ;
BLDCOMMAUDITTMP(REQUEST,REQUESTIEN,NUM) ;Comments Audit Multiple (#27)
 N SUBIEN,COUNT
 S SUBIEN=0,COUNT=0
 F  S SUBIEN=$O(^SDEC(409.85,REQUESTIEN,"COMAUD",SUBIEN)) Q:'SUBIEN  D
 .S COUNT=COUNT+1
 .S @REQUEST@("Request",NUM,"CommentMultiple",COUNT,"DateCommAdded")=$$FMTISO^SDAMUTDT($$GET1^DIQ(409.8527,SUBIEN_","_REQUESTIEN_",",.01,"I"))
 .S @REQUEST@("Request",NUM,"CommentMultiple",COUNT,"CommAddedByDUZ")=$$GET1^DIQ(409.8527,SUBIEN_","_REQUESTIEN_",",1,"I")
 .S @REQUEST@("Request",NUM,"CommentMultiple",COUNT,"CommAddedByName")=$$GET1^DIQ(409.8527,SUBIEN_","_REQUESTIEN_",",1,"E")
 .S @REQUEST@("Request",NUM,"CommentMultiple",COUNT,"Comment")=$$GET1^DIQ(409.8527,SUBIEN_","_REQUESTIEN_",",2,"I")
 Q
 ;
BDCPRSPREREQSTMP(REQUEST,REQUESTIEN,NUM) ;
 N SUBIEN,COUNT,PIENS
 S SUBIEN=0,COUNT=0
 F  S SUBIEN=$O(^SDEC(409.85,REQUESTIEN,8,SUBIEN)) Q:'SUBIEN  D
 .S COUNT=COUNT+1
 .S PIENS=SUBIEN_","_REQUESTIEN_","
 .S @REQUEST@("Request",NUM,"CPRSPreRequisites",COUNT,"PreRequisite")=$$GET1^DIQ(409.8548,PIENS,.01,"E")
 Q
 ;
BLDMRTCSTMP(REQUEST,REQUESTIEN,NUM) ;
 N SUBIEN,COUNT,MIENS,CHILDIEN
 S SUBIEN=0,COUNT=0
 F  S SUBIEN=$O(^SDEC(409.85,REQUESTIEN,2,SUBIEN)) Q:'SUBIEN  D
 .S COUNT=COUNT+1
 .S MIENS=SUBIEN_","_REQUESTIEN_","
 .S CHILDIEN=$$GET1^DIQ(409.852,MIENS,.01,"I")
 .S @REQUEST@("Request",NUM,"MRTC",COUNT,"ChildRequestIEN")=CHILDIEN
 .S @REQUEST@("Request",NUM,"MRTC",COUNT,"LinkedAppointmentIEN")=$$GET1^DIQ(409.852,MIENS,.02,"I")
 .S @REQUEST@("Request",NUM,"MRTC",COUNT,"ChildRequestSequenceNumber")=$$GET1^DIQ(409.85,CHILDIEN,43.1,"I")
 .S @REQUEST@("Request",NUM,"MRTC",COUNT,"PatientIndicatedDate")=$$FMTISO^SDAMUTDT($$GET1^DIQ(409.85,CHILDIEN,22,"I"))
 S @REQUEST@("Request",NUM,"MRTCTotal")=COUNT
 Q
