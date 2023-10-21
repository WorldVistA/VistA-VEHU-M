IBECECX1 ;BSL/DVA - BILLING  EXTRACTION AND FILING UTILITIES FOR IN PATIENT ACCUMULATOR INTERFACE ; 16 May 2022  8:47 AM
 ;;2.0;INTEGRATED BILLING;**704**;21-MAR-94;Build 49
 ;Per VA Directive 6402, this routine should not be modified.
 ; 
 ; Reference to ^DGPT("AAD",^DGPT( in ICR #418
 ;
 Q   ;No direct routine calls
 ;
EN(DFN) ;Retrieve existing Billing clock if present for this patient
 N IBERROR,IBECDT,IBECLDT S IBERROR=0
 S IBEVFAC=+$$SITE^VASITE                             ;Event Facility
 S IBECADM=IBADMIT_.9999
 I 'DFN D NOCLOCK Q  ;bjr - No billing clock data found, set all values NULL (for now)
 ; IBIEN = IEN of billing clock
 S IBECDT=-IBECADM F  S IBECDT=$O(^IBE(351,"AIVDT",DFN,IBECDT)) D  Q:'IBECDT  Q:$G(IBCLDT)  ;Get billing clock that was active at date/time of admission
 . I 'IBECDT D NOCLOCK Q
 . S IBIEN=$O(^IBE(351,"AIVDT",DFN,IBECDT,";"),-1)    ;Get billing clock IEN
 . I IBIEN<1 S IBERROR="0^NO RECORDS FOUND" Q
 . S IBECLDT=$$GET1^DIQ(351,IBIEN_",",.1,"I") I 'IBECLDT S IBECLDT=$$CLSDT(-IBECDT)
 . I IBECLDT,(IBECLDT<IBECADM) D  Q     ;Quit if billing clock closed at time of admission
 .. D NOCLOCK
 . I $P(^IBE(351,IBIEN,0),U,4)=3 D NOCLOCK  Q         ;Don't return canceled clock
 . S IBCLDT=$P(^IBE(351,IBIEN,0),U,3)                 ;Billing clock begin date
 . S IBSTAT=$P(^IBE(351,IBIEN,0),U,4)                 ;Status
 . S IB901=$P(^IBE(351,IBIEN,0),U,5)                  ;1st QTR Billing
 . S IB902=$P(^IBE(351,IBIEN,0),U,6)                  ;2nd QTR Billing
 . S IB903=$P(^IBE(351,IBIEN,0),U,7)                  ;3rd QTR Billing
 . S IB904=$P(^IBE(351,IBIEN,0),U,8)                  ;4th QTR Billing
 . S IBCLDAY=$P(^IBE(351,IBIEN,0),U,9)                ;Number of Inpatient days
 . S IBCLNDT=+$P(^IBE(351,IBIEN,0),U,10)              ;End date of 365 day clock
 . S IBCKNUM=1                                        ;Number of billing clocks sent (FT1)
 . S IBICNUM=1                                        ;Number of billing clocks sent (FT2)
 Q
 ;
INPT(DFN) ;Gather inpatient data
 ; Retrieve most recent Admission and Discharge dates from the PTF file
 I $G(IBNGHTSK) S IBADMIT=DT-1,IBDISCH="" Q
 S (IBADMIT,IBDISCH)=""
 Q:'$D(^DGPT("AAD",DFN))  ;quit if nothing found
 S IBADMIT="9999999.9999",IBADMIT=$O(^DGPT("AAD",DFN,IBADMIT),-1),IBADM1=IBADMIT,IBIEN=$O(^DGPT("AAD",DFN,IBADMIT,0)),IBDISCH=$P($G(^DGPT(IBIEN,70)),U)
 S IBOADMIT=$$FMTHL7^XLFDT(IBADMIT),IBADMIT=$$FMTHL7^XLFDT($P(IBADMIT,"."))                ;convert admission date to HL7
 I IBDISCH'="" S IBODISCH=$$FMTHL7^XLFDT(IBDISCH),IBDISCH=$$FMTHL7^XLFDT($P(IBDISCH,"."))  ;Get discharge dates (HL7 format), no times needed
 Q
 ;
CCINPT(DFN,IBADMIT) ;Gather inpatient data for CC billing
 ; Retrieve most recent Admission and Discharge dates from the PTF file
 S IBDISCH=""
 Q:'$D(^DGPT("AAD",DFN))  ;quit if nothing found
 S IBADMIT=IBADMIT_".9999",IBADMIT=$O(^DGPT("AAD",DFN,IBADMIT),-1),IBADM1=IBADMIT I IBADMIT S IBIEN=$O(^DGPT("AAD",DFN,IBADMIT,0)),IBDISCH=$P($G(^DGPT(IBIEN,70)),U)
 S IBOADMIT=$$FMTHL7^XLFDT(IBADMIT),IBADMIT=$$FMTHL7^XLFDT($P(IBADMIT,"."))                ;convert admission date to HL7
 I IBDISCH'="" S IBODISCH=$$FMTHL7^XLFDT(IBDISCH),IBDISCH=$$FMTHL7^XLFDT($P(IBDISCH,"."))  ;Get discharge dates (HL7 format), no times needed
 Q
 ;
NOCLOCK ;Set variables if no clock found
 S (IBIEN,IBADM,IEN,IBCLNDT,IB901,IB902,IB903,IB904,IBCLDAY,IBCKNUM,IBICNUM,IBSTAT)="" S:$G(IBCLDT)="" IBCLDT=""
 Q
CLSDT(IBECDT) ;Calculate billing clock closed date taking into acct leap year
 N IBYEAR,IBMTHDAY,IBLEAP,IBECLDT
 S IBYEAR=$E(IBECDT,1,3),IBMTHDAY=$E(IBECDT,4,7)
 I IBMTHDAY<229 S IBLEAP=$$LEAP^XLFDT3(IBYEAR)
 I IBMTHDAY>229 S IBLEAP=$$LEAP^XLFDT3(IBYEAR+1)
 I IBLEAP S IBECLDT=$$FMADD^XLFDT(IBECDT,365) S:IBECLDT>DT IBECLDT="" Q IBECLDT
 I 'IBLEAP S IBECLDT=$$FMADD^XLFDT(IBECDT,364) S:IBECLDT>DT IBECLDT="" Q IBECLDT
 Q
