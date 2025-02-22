SDCCRSEN ;CCRA/LB,PB - Appointment retrieval API;APR 4, 2019
 ;;5.3;Scheduling;**707,730,735,764,768,741,795,808,822,841,865**;APR 4, 2019;Build 51
 Q
 ; Documented API's and Integration Agreements
 ; ----------------------------------------------
 ; Reference to GENACK^HLMA1 in ICR #2165
 ; Reference to $$GETDFN^MPIF001,$$GETICN^MPIF001 in ICR #2701
 ; Reference to MAKEADD^TIUSRVP2 in ICR #3535
 ; Reference to $$HL7TFM^XLFDT in ICR #10103
 ; Reference to $$PATCH^XPDUTL in ICR #10141
 ; Patch 764 changed the SDECEND and SDECSTART times to send them in external format
 ; Patch 741 stopped sending a NAK for inactive clinic status and VistA messages for a successful appointment
 ; Patch 795 added code to lookup up COM CARE-OTEHR-DIVISIONID clinics and to check for the clinic to be non-count
 ; Patch 808 adds code to use the Related Hospital Location file in the Request Services File (#123.5) to lookup of the clinic for the appointment
 ; Patch 822 adds code to insure the consult id is stored in the Hospital Location File, Appointment multiple
 ; and when canceling an appointment, only cancel the appointment if it is for a com care clinic that matches the 
 ; consult service and consult id. Patch 822 also split this routine and move the MAKE, CANCEL and NO SHOW code to SDCCRSEN1
 ; PB - patch 841 adding code to improve the scheduler lookup the scheduler based on the schedulers email. 
 ; and adds code to provide additional data to the NAK when a clinic can't be found for the appointment. 
 ; Patch 865 changes the text in the NAK messages to be more meaningful for the end user
EN() ;Primary entry routine for HL7 based CCRA scheduling processing.
 ;Will take all scheduling messages through this one point.
 N FS,CS,RS,ES,SS,MID,HLQUIT,HLNODE,USER,USERMAIL,NAKMSG,ICN,MSH,FMDTTM,STARTFM,MSGTXT,ER,ER1,ER2,ER3
 N MSG,HDR,SEG,SEGTYPE,MSGARY,LASTSEG,HDRTIME,ABORT,BASEDT,CLINARY,COUNT,PROVDTL,RESULTS,P694,TYPE,STARTFM1
 D INT^SDCCRCOR
 D COPYMSG^SDCCRCOR(.MSG)
 Q:$$CHKMSG^SDCCRCOR(.MSG)
 Q:$$PROCMSG(.MSG)
 D:+$G(ABORT)'>0 ACK^SDCCRCOR("CA",MID) ;PB - Patch 764
 Q
PROCMSG(MSG1) ; Process message
 N QUIT,I,SEGTYPE,ERR1
 N GMRCDFN,GMRCTIU,GMRCTIUS,CID,ADDTXT,GMRCATIU,STID,RAWSEG,APTTM,DFN,CONID,CONTITLE,PROVIDER,SRVNAME1,SRVNAMEX,LOC,PROV,SDECRESA,DIVID
 K SDECSTART,SDECEND,SDDFN,SITECODE,SDECRES,SDECLEN,SDECNOTE,SDECATID,SDECCR,SDMRTC,SDDDT,SDREQBY,SDLAB,PROVIEN,SDID,SDAPTYP,SDSVCP,SDSVCPR,SDCL,SDEKG,SDXRAY,APPTYPE,EESTAT,OVB,SDPARENT,SDEL
 S (SDECSTART,SDECEND,SDDFN,SDECRES,SDECLEN,CID,PROV,LOC,SDECNOTE,SDECATID,SDECCR,SDMRTC,SDDDT,SDREQBY,SDLAB,PROVIEN,SDID,SDAPTYP,SDSVCP,SDSVCPR,SDCL,SDEKG,SDXRAY,APPTYPE,EESTAT,OVB,SDPARENT,SDEL)=""
 S ABORT=0,BASEDT=""
 S (QUIT,XX)=0
 F  S XX=$O(MSG1(XX)) Q:XX'>0  D
 . S SEGTYPE=$E(MSG1(XX),1,3),RAWSEG=$G(MSG1(XX))
 . I SEGTYPE'="NTE" S LASTSEG=SEGTYPE
 . S SEG=$G(MSG1(XX))
 . I SEGTYPE="MSH" D MSH(SEG,.MSGARY)
 . I SEGTYPE="SCH" D SCH(SEG,.MSGARY,.ABORT,.BASEDT) ;SCH MUST BE PROCESSED FIRST SOME VALIDATION DEPENDS ON APPOINTMENT STATUS IN SCH-25
 . I SEGTYPE="NTE" D NTE(SEG,.MSGARY,LASTSEG,.CLINARY,.ABORT,.PROVDTL)
 . I SEGTYPE="PID" D PID(SEG,.MSGARY,.ABORT)
 . I SEGTYPE="PV1" D PV1(SEG,.MSGARY,HDRTIME,.ABORT)
 . I SEGTYPE="RGS" D RGS(SEG,.MSGARY)
 . I SEGTYPE="AIS" D AIS(SEG,.MSGARY)
 . I SEGTYPE="AIG" D AIG(SEG,.MSGARY,.PROVDTL,BASEDT)
 . I SEGTYPE="AIP" D AIP(SEG,.MSGARY,.PROVDTL,BASEDT)
 K XX
 ;I $G(NAKMSG)'="" S DUZ=.5,QUIT=1 D ANAK^SDCCRCOR($G(NAKMSG),$G(USERMAIL),$G(ICN),$G(DFN),$G(APTTM),$G(CONID))
 ;I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,.ABORT) Q 1
 I +$G(ABORT)=2 D APPMSG^SDCCRCOR(MID,.ABORT) Q 1
 I +$G(QUIT)=1 Q 1
 S QUIT=0
 I MSGARY("EVENT")="SCHEDULE" D MAKE^SDCCRSEN1
 I MSGARY("EVENT")="CANCEL" D CANCEL^SDCCRSEN1
 I MSGARY("EVENT")="NOSHOW" D NOSHOW^SDCCRSEN1
 D DONEINC^SDCCRCOR
 K MSG1,SDRES,SDECY,SDECDATE,SDECAPTID,RSNAME,SDAPTYP,SDCL,SDDFN,SDECNOT,SDECNOTE,INP,RET
 Q QUIT
SETEVENT(EVENT,MSGARY) ;Takes the scheduling event and sets a message event to process.
 ;EVENT (I/REQ) - Message event from the MSH header. EX. S12, S14, S15, S26
 ;MSGARY (I/O,REQ) message array structure with reformatted and translated data ready for filing. See PARSEMSG for details.
 I $G(EVENT)="" Q 0
 I EVENT="S12" S MSGARY("EVENT")="SCHEDULE" Q 1
 I EVENT="S15" S MSGARY("EVENT")="CANCEL" Q 1
 I EVENT="S26" S MSGARY("EVENT")="NOSHOW" Q 1
 Q 0
MSH(MSH,MSGARY) ; RGS segment
 D PARSESEG^SDCCRSCU(MSH,.MSH)
 S SITECODE=$G(MSH(5,1,1))
 Q
SCH(SCH,MSGARY,ABORT,BASEDT) ;SCH segment processing.:
 ;SEG (I/REQ) - SCH message segment data
 ;MSGARY (I/O,REQ) message array structure with unformatted and translated data ready for filing. See PARSEMSG for details.
 ;ABORT (O,OPT) - Error parameter if we did not receive an appointment date and time. Fatal case to this message.
 ;BASEDT (O,REQ) - appointment base date/time to use. May be incremented later if processing multiple joint clinic scheduling
 N ORDIDTYP,SRVNAME,CONSULTID
 D PARSESEG^SDCCRSCU(SCH,.SCH)
 S MSGARY("PLACER ID")=$G(SCH(1)) ;SCH-1.1
 ;Cancel Reason
 S CONID=$G(SCH(2)),PROVIDER=$G(SCH(12,1,2))_" "_$G(SCH(12,1,3))
 I MSGARY("EVENT")="CANCEL" S MSGARY("CANCEL REASON")=$$GETRSN^SDCCRCOR($G(SCH(6,1,2))),MSGARY("CANCEL CODE")=$G(SCH(6,1,5)) ;SCH-6
 I $G(MSGARY("CANCEL REASON"))'="" N CANRSN S CANRSN=$O(^SD(409.2,"B",$G(MSGARY("CANCEL REASON")),"")) I CANRSN="" S MSGARY("CANCEL REASON")=11
 ;Duration
 S (SDECLEN,MSGARY("DURATION"))=$G(SCH(9)) ;SCH-9,10
 ;Appointment Date
 S P694=0 S P694=$$PATCH^XPDUTL("SD*5.3*694")
 S APTTM=$G(SCH(11,1,4)) I $G(APTTM)'="" S SDECSTART=$$TIMES^SDCCRCOR($G(SCH(11,1,4)),SITECODE),STARTFM1=STARTFM,SDECEND=$$TIMES^SDCCRCOR($G(SCH(11,1,5)),SITECODE)
 I $G(SCH(11,1,4))="" S QUIT=$$MSGTXT^SDCCRSEN1(1),ABORT="1^"_ERR1 Q  ;PB - Patch 865 changing error messages
 ;User
 S (MSGARY("USER"))=$$GETUSER^SDCCRCOR($G(SCH(20,1,1))) ;SCH-20
 ;Feb 24, 23 -PB - patch 841 - code to enhances the lookup for the scheduler
 S USERMAIL=$G(SCH(13,1,4)) S DUZ=$O(^VA(200,"ADUPN",$G(USERMAIL),""))
 I DUZ="" D
 .S USERMAIL=$$LOW^XLFSTR($G(SCH(13,1,4))) S:$G(USERMAIL)'="" DUZ=$O(^VA(200,"ADUPN",$G(USERMAIL),""))
 .S:DUZ=0 USERMAIL=$$UP^XLFSTR($G(SCH(13,1,4))) S:$G(USERMAIL)'="" DUZ=$O(^VA(200,"ADUPN",$G(USERMAIL),""))
 S:$G(DUZ)'>0 DUZ=$O(^VA(200,"ADUPN",$E(USERMAIL,1,30),"")) ;29 JAN 2020 - PB - Change for patch 735 to look emails longer than 30 characters
 I $G(DUZ)'>0 S:$G(USERMAIL)'="" DUZ=$O(^VA(200,"ADUPN",$$UP^XLFSTR(USERMAIL),""))
 ;I DUZ'>0 S DUZ=.5,(NAKMSG,ERR1)="SCHEDULER DOESN'T HAVE AN ACCOUNT ON THIS SYSTEM",ABORT="1^"_ERR1 Q
 ;I DUZ'>0 S DUZ=.5,(NAKMSG,ERR1)=$P($T(REJECTREASONS+1^SDCCRCOR),";;",2),ABORT="1^"_ERR1 Q  ;PB - Patch 865 changing error messages
 I DUZ'>0 D
 .S TYPE=$S(MSGARY("EVENT")="CANCEL":1,MSGARY("EVENT")="SCHEDULE":"",1:"")
 .S QUIT=$$MSGTXT^SDCCRSEN1("SCHEDULER "_$G(USERMAIL)_" DOESN'T HAVE AN ACCOUNT ON THIS SYSTEM",TYPE),DUZ=.5,ABORT="1^"_ERR1 Q  ;PB - Patch 865 changing error messages
 Q:+$G(QUIT)=1
 S MSGARY("STATUS")=$$GETSTAT($G(SCH(25))) ;SCH-25
 ; Linked Consults/Orders
 S ORDIDTYP=$$GET^SDCCRSCU(.SCH,27,2) ;Placer ID Type
 Q
NTE(NTE,MSGARY,LASTSEG,CLINARY,ABORT,PROVDTL) ;NTE segment processing.
 ;NTE (I/REQ) - NTE message segment data
 ;MSGARY (I/O,REQ) - message array structure with unformatted and translated data ready for filing. See PARSEMSG for details.
 ;LASTSEG (I,REQ) - segment previous to the NTE to determine context of note.
 ;CLINARY (I/O,REQ) - List of Clinics to be scheduled. Could contain more than one for joint appointments
 ;ABORT (O,REQ) - quit parameter to the whole tag. Having one clinic unmapped must stop filing.
 ;PROVDTL (I/OPT) - passed when NTE concerns a preceding AIP or AIG segment
 N NOTE,NOTETYPE,CLINIC
 S LASTSEG=$G(LASTSEG)
 D PARSESEG^SDCCRSCU(NTE,.NTE)
 S NOTE="HSRM CONSULT "_$G(CONID)_" "_$G(NTE(3))  ;NTE-3.1
 S NOTETYPE=$$GET^SDCCRSCU(.NTE,4,1)  ;NTE-4.1
 ;Process NTE following SCH for scheduling comments.
 S (SDECNOTE,NOTE)=$TR(NOTE,"^","?")  ;JAN 21, 2020 - PB - adding SDECNOTE to have the booking notes
 I LASTSEG="SCH" D
 . I ($G(MSGARY("COMMENT"))'=""),(NOTE'="") S MSGARY("COMMENT")=$G(MSGARY("COMMENT"))_" "
 . S MSGARY("COMMENT")=NOTE
 Q
PID(PID,MSGARY,ABORT) ;PID segment
 ;PID (I/REQ) - PID message segment
 ;MSGARY (I/O,REQ) message array structure with unformatted and translated data ready for filing. See PARSEMSG for details.
 ;ABORT (O,OPT) - Error parameter if we failed to find a valid patient. Fatal case to this message.
 N IDENTIFIERS,IENCHECK,OK
 D PARSESEG^SDCCRSCU(PID,.PID)
 S ICN=$G(PID(3,1,1)),(SDDFN,DFN)=$$GETDFN^MPIF001($P(ICN,"V"))
 Q
PV1(PV1,MSGARY,HDRTIME,ABORT) ;PV1 segment
 ;PV1 (I/REQ) - PV1 message segment data
 ;MSGARY (I/O,REQ) message array structure with unformatted and translated data ready for filing. See PARSEMSG for details.
 ;HDRTIME (I,OPT) - TIME FROM MSH-7, USED AS A DEFAULTING OPTION
 ;ABORT (O,OPT) - Error parameter if we failed to find a valid patient. Fatal case to this message.
 N ERROR
 D PARSESEG^SDCCRSCU(PV1,.PV1)
 ;I $G(PV1(19))'>0 S (NAKMSG,ERR1)="CONSULT ID MISSING. " S ABORT="1^"_ERR1 Q 
 I $G(PV1(19))'>0 S QUIT=$$MSGTXT^SDCCRSEN1("CONSULT ID MISSING."),ABORT="1^"_ERR1 Q  ;PB - Patch 865 changing error messages
 S CONSULTID=0,(CONID,CONSULTID)=$G(PV1(19))
 S MSGARY("FILLER ID")=CONSULTID
 S SDAPTYP="C|"_$G(CONSULTID)
 N Y,RESNAME
 S DIVID=$G(PV1(3,1,4))
 S CID=$$GET1^DIQ(123,$G(CONSULTID)_",",17,"E") S:$G(CID)'="" CID=$P($$FMTE^XLFDT(CID,1),"@",1)
 S SDECRESA=$$GET1^DIQ(123,$G(CONSULTID)_",",1,"I"),(CONTITLE,SRVNAME)=$$GET1^DIQ(123,$G(CONSULTID)_",",1,"E")
 ;I $G(SRVNAME)'["COMMUNITY CARE" S (NAKMSG,ERR1)="Not a Community Care Consult",ABORT="2^"_ERR1 Q
 I $G(SRVNAME)'["COMMUNITY CARE" S QUIT=$$MSGTXT^SDCCRSEN1("Not a Community Care Consult"),ABORT="2^"_ERR1 Q  ;PB - Patch 865 changing error messages
 ; patch 808 - PB lookup the clinic in the Related Hospital Location multiple in the Request Services file (#123.5), gets the last clinic in the list
 I $G(^GMR(123.5,SDECRESA,123.4,0))'="" D
 .N T1,T2,T3
 .S (T1,T2)=0 F  S T1=$O(^GMR(123.5,SDECRESA,123.4,T1)) Q:T1'>0  S T2=$P($G(^GMR(123.5,SDECRESA,123.4,T1,0)),"^")
 .S:$$GET1^DIQ(44,T2_",",.01,"E")["COM CARE-" SDCL=T2,SRVNAMEX=$$GET1^DIQ(44,T2_",",.01,"E")
 I SDCL>0 D  ;PB - Patch 865 changing error messages
 . N INACT S INACT=$$INACTIVE^SDEC32(SDCL)
 . I $G(INACT)=1 S QUIT=$$MSGTXT^SDCCRSEN1("Clinic "_$P(^SC(SDCL,0),"^")_" is inactive"),ABORT="1^"_ERR1 ;PB - Patch 865 changing error messages
 Q:$G(QUIT)=1
 I $G(SDCL)'>0 S SDCL=$$CHECKLST($G(SRVNAME))
 I $G(SDCL)=0 S QUIT=1 Q 0
 I SDCL>0&($$GET1^DIQ(44,$G(SDCL)_",",2502,"E")'="YES") S QUIT=$$MSGTXT^SDCCRSEN1(SRVNAMEX_" IS NOT A NON COUNT CLINIC FOR CONSULT ID: "_CONSULTID),ABORT="1^"_ERR1 Q  ;PB - Patch 865 changing error messages
 ; Feb 24, 23 - PB - added additional information to the refect reason to include the clinic that we searched for
 I $G(SDCL)'>0 S QUIT=$$MSGTXT^SDCCRSEN1("NO CLINIC MATCH FOR CONSULT ID, "_CONSULTID_" FOR CONSULT TITLE, "_$G(SRVNAME)_" LOOKING FOR CLINIC "_$G(SRVNAMEX)),ABORT="1^"_ERR1 Q  ;WE NEED AN ERR HERE FOR PV1(19)
 N SDRES S SDRES=$O(^SDEC(409.831,"B",$G(SRVNAMEX),"")) S:$G(SDRES)>0 SDECRES=$G(SDRES)
 I $G(SDECRES)="" S QUIT=$$MSGTXT^SDCCRSEN1("NO CLINIC RESOURCE MATCH FOR "_$G(SRVNAMEX)),ABORT="1^"_ERR1 Q  ;PB - Patch 865 changing error messages
 ;Need to check to see if the clinic is inactive - is there an SDEC API for this?
 S MSGARY("CHECKINDT")=$$DETTIME($$GET^SDCCRSCU(.PV1,44,1),$G(HDRTIME),.ERROR)   ;PV1-44.1
 I ($G(ERROR)'=""),($G(MSGARY("STATUS"))="CHECKED IN") S NAKMSG=" NO CHECK IN TIME IN PV1-44 ",ABORT="1^ NO CHECK IN TIME IN PV1-44 "_ERROR Q
 ;CHECK OUT DATE/TIME
 S MSGARY("CHECKOUTDT")=$$DETTIME($$GET^SDCCRSCU(.PV1,45,1),$G(HDRTIME),.ERROR)   ;PV1-45.1
 I ($G(ERROR)'=""),($G(MSGARY("STATUS"))="CHECKED OUT") S NAKMSG=" NO CHECK IN TIME IN PV1-45 ",ABORT="1^ NO CHECK IN TIME IN PV1-44 "_ERROR Q
 Q
RGS(RGS,MSGARY) ; RGS segment
 Q
AIS(AIS,MSGARY) ;AIS segment
 Q
AIP(AIP,MSGARY,PROVDTL,BASEDTE) ;AIP segment processing.
 ;Per HL7 this field can repeat within each RGS group.
 ;AIP (I/REQ) - AIP message segment data
 ;MSGARY (I/O,REQ) message array structure with unformatted and translated data ready for filing. See PARSEMSG for details.
 ;PROVDTL (O,REQ) - AIP date/time and length
 ;BASEDTE (I,REQ) - Appt D/T from SCH
 D PARSESEG^SDCCRSCU(AIP,.AIP)
 S PROV=$G(AIP(3,1,2))_" "_$G(AIP(3,1,3))
 Q
 ;
AIG(AIG,MSGARY,PROVDTL,BASEDTE) ;AIG segment processing.
 ;Per HL7 this field can repeat within each RGS group.
 ;AIG (I/REQ) - AIG message segment data
 ;MSGARY (I/O,REQ) message array structure with unformatted and translated data ready for filing. See PARSEMSG for details.
 ;PROVDTL (O,REQ) - AIG date/time and length
 ;BASEDTE (I,REQ) - Appt D/T from SCH
 D PARSESEG^SDCCRSCU(AIG,.AIG)
 I $$HL7TFM^XLFDT($$GET^SDCCRSCU(.AIG,8,1),"L")'="" S PROVDTL("DT")=$$HL7TFM^XLFDT($$GET^SDCCRSCU(.AIG,8,1),"L")  ;AIG-8
 E  S PROVDTL("DT")=BASEDTE
 S PROVDTL("LN")=MSGARY("DURATION")
 Q
 ;
GETSTAT(SCH) ; Translates status into appropriate scheduling statuses
 ;Options: (SCHEDULED,CHECKED IN,CHECKED OUT,CANCELLED,NO SHOW)
 N STATUS,ID,TITLE
 S ID=$$GET^SDCCRSCU(.SCH,25,1)
 S TITLE=$$GET^SDCCRSCU(.SCH,25,2)
 I $$INSTRING^SDCCRCOR(TITLE,"SCHEDULED,CHECKED IN,CHECKED OUT,CANCELLED,NO SHOW") Q TITLE
 I $$INSTRING^SDCCRCOR(ID,"SCHEDULED,CHECKED IN,CHECKED OUT,CANCELLED,NO SHOW") Q ID
 I (ID'="")!(TITLE'="") S QUIT=$$MSGTXT^SDCCRSEN1("SCHEDULING STATUS MAPPING ERROR"),ABORT="1^ SCHEDULING STATUS MAPPING ERROR" Q
 Q "NA"
DETTIME(PV1TIME,HDRTIME,ERROR) ;RETURNS THE BEST CHECK IN/OUT TIME AVAILABLE IN THE MESSAGE OR DEFAULTS TO NOW
 ;PV1TIME (I,OPT)   - HIGHEST PRIORITY TIME TO RETURN FROM EITHER PV1-44 OR PV1-45
 ;HDRTIME (I,OPT)   - TIME FROM MSH-7
 ;ERROR   (O,OPT)   - ERROR OUTPUT PARAMETER
 K ERROR
 I $G(PV1TIME)'="" Q $$HL7TFM^XLFDT(PV1TIME,"L")
 I $G(HDRTIME)'="" S ERROR="FALLING BACK TO MSH-7" Q $$HL7TFM^XLFDT(HDRTIME,"L")
 S ERROR="FALLING BACK TO FILING TIME"
 Q $$NOW^XLFDT()
CHECKLST(SRVNAME) ;
 ; lookup matching clinic for imaging comm care consults
 I $G(SRVNAME)="" Q 0
 N CLINID,CLINIC,CONTITLE,LEN,I,XC
 S CLINID=0
 S:$G(SRVNAME)[" - " SRVNAME=$P(SRVNAME," - ",1)_"-"_$P(SRVNAME," - ",2)
 S:$G(SRVNAME)[" -" SRVNAME=$P(SRVNAME," -",1)_"-"_$P(SRVNAME," -",2)
 S:$G(SRVNAME)["- " SRVNAME=$P(SRVNAME,"- ",1)_"-"_$P(SRVNAME,"- ",2)
 S LEN=$L(SRVNAME),XC=1
 F I=0:1:LEN I $E(SRVNAME,I)="-" S XC=XC+1
 S CONTITLE=SRVNAME
 S (RSNAME,SRVNAME)="COM CARE-"_$P(SRVNAME,"-",2,XC),SRVNAME=$E(SRVNAME,1,30) S:$E(SRVNAME,30)=" " SRVNAME=$E(SRVNAME,1,29)
 S:$E($P(RSNAME,"-",2),1,3)="DOD" (RSNAME,SRVNAME)="CC-"_$P(RSNAME,"-",2,XC)
 S CLINID=$O(^SC("B",$E($G(SRVNAME),1,30),""))
 I $G(CLINID)'>0 D
 .F I=1:1:20 D
 ..Q:$G(CLINID)>0
 ..I $P($P($T(LIST+I),";;",2),"^",1)=CONTITLE S CLINIC=$P($P($T(LIST+I),";;",2),"^",2),CLINID=$O(^SC("B",$G(CLINIC),"")),SRVNAME=CLINIC
 I CLINID'>0 D
 . N LENG,SRVNAME1
 . S LENG=0
 . S LENG=$L(SRVNAME)
 . S (SRVNAME,SRVNAME1)=$S(LENG>28:$E(SRVNAME,1,28)_"-X",1:$G(SRVNAME)_"-X"),CLINID=$O(^SC("B",$G(SRVNAME1),""))
 S SRVNAMEX=SRVNAME
 ;Need to check to see if the clinic is inactive - is there an SDEC API for this?
 N INACT S:$G(CLINID)>0 INACT=$$INACTIVE^SDEC32(CLINID)
 ;I $G(INACT)=1 S (NAKMSG,ERR1)="Clinic "_$P(^SC(CLINID,0),"^")_" is inactive",ABORT="1^"_ERR1 Q 0
 I $G(INACT)=1 S QUIT=$$MSGTXT^SDCCRSEN1("Clinic "_$P(^SC(CLINID,0),"^")_" is inactive"),ABORT="1^"_ERR1 Q 0   ;PB - Patch 865 changing error messages
 Q:$G(QUIT)=1
 ;If no matching clinic found look for com care-other-DIVID (DIVID from the PV! segment)
 I CLINID'>0!$G(INACT)=1 S CLINID=$O(^SC("B","COM CARE-OTHER-"_DIVID,"")) S:$G(CLINID)>0 (SRVNAMEX,SRVNAME)=$P(^SC(CLINID,0),"^") S:$G(CLINID)'>0 (SRVNAMEX,SRVNAME)="COM CARE-OTHER-"_$G(DIVID)
 I CLINID'>0!$G(INACT)=1 S CLINID=$O(^SC("B","COM CARE-OTHER","")) S:$G(CLINID)>0 (SRVNAMEX,SRVNAME)=$P(^SC(CLINID,0),"^") S:$G(CLINID)'>0 (SRVNAMEX,SRVNAME)="COM CARE-OTHER"
 Q CLINID
LIST ; List of Imaging Community Care consult titles and clinics
 ;;COMMUNITY CARE-IMAGING CT-AUTO^COM CARE-IMAG CT-AUTO
 ;;COMMUNITY CARE-IMAGING GENERAL RADIOLOGY-AUTO^COM CARE-IMAG GEN RAD-AUTO
 ;;COMMUNITY CARE-IMAGING MAGNETIC RESONANCE IMAGING-AUTO^COM CARE-IMAG MRI-AUTO
 ;;COMMUNITY CARE-IMAGING MAMMOGRAPHY DIAGNOSTIC-AUTO^COM CARE-IMAG MAM DIAG-AUTO
 ;;COMMUNITY CARE-IMAGING MAMMOGRAPHY SCREEN-AUTO^COM CARE-IMAG MAM SCR-AUTO
 ;;COMMUNITY CARE-IMAGING NUCLEAR MEDICINE-AUTO^COM CARE-IMAG NUC MEC-AUTO
 ;;COMMUNITY CARE-IMAGING ULTRASOUND-AUTO^COM CARE-IMAG U/S-AUTO
 ;;COMMUNITY CARE-CIH BIOFEEDBACK/NEUROFEEDBACK^COM CARE-CIH BIO/NEURO FB
 ;;COMMUNITY CARE-CIH CLINICAL/BEHAVIORAL HYPNOTHERAPY^COM CARE-CIH CLIN/BEH HYPNO
 ;;COMMUNITY CARE-EMERGENCY TREATMENT APPROVED^COM CARE-EMER TREAT APPR
 ;;COMMUNITY CARE-INFERTILITY EVAL ONLY^COM CARE-INFERTILITY EVAL
 ;;COMMUNITY CARE-GEC ADULT DAY HEALTH CARE^COM CARE-GEC ADHC
 ;;COMMUNITY CARE-GEC NON-SKILLED HOME HEALTH AIDE^COM CARE-GEC NON-SK HHA
 ;;COMMUNITY CARE-IMAGING CT COLONOGRAPHY^COM CARE-IMAG CT COLON
 ;;COMMUNITY CARE-IMAGING BARIUM ENEMA^COM CARE-IMAG BARIUM ENEMA
 ;;COMMUNITY CARE-HOME SLEEP APNEA TEST^COM CARE-HOME SLEEP APNEA
 ;;COMMUNITY CARE-PTSD CLINICAL DEMONSTRATION (HBOT)^COM CARE-PTSD CL DEMO (HBOT)
 ;;COMMUNITY CARE-TREATMENT RESISTANT DEPRESSION^COM CARE-TRT RESIST DEP
 ;;COMMUNITY CARE-HEMATOLOGY/ONCOLOGY^COM CARE-HEMATOLOGY/ONCOLOGY
 ;;COMMUNITY CARE-HARDSHIP DETERMINATION^COM CARE-HARDSHIP DETER
