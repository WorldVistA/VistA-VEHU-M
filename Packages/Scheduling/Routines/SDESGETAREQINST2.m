SDESGETAREQINST2 ;ALB/ANU - GET APPT REQ RPCS ;Oct 01, 2023@15:35
 ;;5.3;Scheduling;**861**;Aug 13, 1993;Build 17
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to ^VA(200 in ICR #10060
 ; Reference to $$GET1^DIQ  in ICR #2056
 Q
 ;
 ; For an example of the return object, see SDESGETREQWRAPPR due to its length.
 ; If you add new components to the JSON return object in this routine, document
 ; them in header of SDESGETREQWRAPPR and initialize them in APPTREQUEST.
 ;
GETREQSBYINST(JSONRETURN,INST,YEAR,EAS) ; SDES GET APPT REQ BY INST OPEN
 N ISINSTVALID,ISEASVALID,RETURN,ERRORS,REQUESTIEN,REQUEST,REQUESTDT,COUNT,ISYRVALID
 N RECALLCNT,SDNYEAR,RECALLDTTM,RECALLUSER,RECALLIEN,RECALLCLIN,RECALLDIV,RECALLINST,DFN,X,Y
 N CONSULTIEN,SDNAM,SDI,CPRSSTATUS,CONSINST,CONSCNT,SDIYEAR
 ;
 S ISINSTVALID=$$VALIDATEINST(.ERRORS,$G(INST))
 S ISYRVALID=$$VALIDATEYEAR(.ERRORS,$G(YEAR))
 S ISEASVALID=$$VALIDATEEAS(.ERRORS,$G(EAS))
 I $D(ERRORS) M RETURN=ERRORS D BUILDJSON(.JSONRETURN,.RETURN) Q
 ;
 ; get appointment requests
 S REQUESTIEN=0,COUNT=1,REQUESTDT=""
 F  S REQUESTIEN=$O(^SDEC(409.85,"C",INST,REQUESTIEN)) Q:'REQUESTIEN!(COUNT>100)  D
 .I $$GET1^DIQ(409.85,REQUESTIEN,23,"I")="C" Q
 .S REQUESTDT=$$GET1^DIQ(409.85,REQUESTIEN,9.5,"I")
 .I REQUESTDT="" Q
 .I YEAR'=$$FMTE^XLFDT($E(REQUESTDT,1,3)_"0000") Q
 .I COUNT=101 Q
 .D GETREQUEST^SDESGETAPPTREQ(.REQUEST,REQUESTIEN)
 .S COUNT=COUNT+1
 ;
 ; get recalls
 S RECALLCNT=1
 S SDNYEAR=0
 S SDIYEAR=0
 S X=YEAR+1 D ^%DT S SDNYEAR=Y
 S X=YEAR D ^%DT S SDIYEAR=Y
 S RECALLDTTM=Y F  S RECALLDTTM=$O(^SD(403.5,"AC",RECALLDTTM)) Q:'RECALLDTTM!(RECALLDTTM>=SDNYEAR)!(RECALLCNT>100)  D
 .S RECALLUSER=0 F  S RECALLUSER=$O(^SD(403.5,"AC",RECALLDTTM,RECALLUSER)) Q:'RECALLUSER  D
 ..S RECALLIEN=0 F  S RECALLIEN=$O(^SD(403.5,"AC",RECALLDTTM,RECALLUSER,RECALLIEN)) Q:'RECALLIEN  D
 ...S RECALLCLIN=$$GET1^DIQ(403.5,RECALLIEN,4.5,"I")
 ...S RECALLDIV=$$GET1^DIQ(44,RECALLCLIN,3.5,"I")
 ...S RECALLINST=$$GET1^DIQ(40.8,RECALLDIV,.07,"I")
 ...I INST,INST'=RECALLINST Q
 ...I RECALLCNT=101 Q
 ...S DFN=$$GET1^DIQ(403.5,RECALLIEN,.01,"I")
 ...D GETRECALL^SDESGETRECALL(.REQUEST,RECALLIEN,DFN)
 ...S RECALLCNT=RECALLCNT+1
 ;
 ; get consults
 S CONSCNT=1
 S CONSULTIEN=0
 S SDNAM=SDIYEAR F  S SDNAM=$O(^GMR(123,"E",SDNAM)) Q:'SDNAM!(SDNAM>=SDNYEAR)!(CONSCNT>100)  D
 .S CONSULTIEN="" F  S CONSULTIEN=$O(^GMR(123,"E",SDNAM,CONSULTIEN)) Q:CONSULTIEN=""  D
 ..S CPRSSTATUS=$$GET1^DIQ(123,CONSULTIEN,8,"E")
 ..I CPRSSTATUS'="PENDING",CPRSSTATUS'="ACTIVE" Q
 ..S CONSINST=$$GET1^DIQ(123,CONSULTIEN,.05,"I")
 ..I INST,CONSINST,(CONSINST'=INST) Q
 ..I CONSCNT=101 Q
 ..D GETCONSULT^SDESGETCONSULTS(.REQUEST,CONSULTIEN)
 ..S CONSCNT=CONSCNT+1
 ;
 I '$D(REQUEST) S REQUEST("Request",1)=""
 M RETURN=REQUEST
 ;
 D BUILDJSON(.JSONRETURN,.RETURN)
 Q
 ;
VALIDATEINST(ERRORS,INST) ;
 I INST="" D ERRLOG^SDESJSON(.ERRORS,409) Q 0
 I INST'="",'$D(^DIC(4,INST,0)) D ERRLOG^SDESJSON(.ERRORS,410) Q 0
 Q 1
 ;
VALIDATEYEAR(ERRORS,YEAR) ;
 I YEAR="" D ERRLOG^SDESJSON(.ERRORS,411) Q 0
 I YEAR>$$FMTE^XLFDT($E($$NOW^XLFDT,1,3)_"0000") D ERRLOG^SDESJSON(.ERRORS,412) Q 0
 I +YEAR<1900 D ERRLOG^SDESJSON(.ERRORS,412) Q 0
 Q 1
 ;
VALIDATEEAS(ERRORS,EAS) ;
 I $L(EAS) S EAS=$$EASVALIDATE^SDESUTIL($G(EAS))
 I $P($G(EAS),U)=-1 D ERRLOG^SDESJSON(.ERRORS,142) Q 0
 Q 1
 ;
BUILDJSON(JSONRETURN,RETURN) ;
 N JSONERROR
 D ENCODE^XLFJSON("RETURN","JSONRETURN","JSONERROR")
 ;
 Q
