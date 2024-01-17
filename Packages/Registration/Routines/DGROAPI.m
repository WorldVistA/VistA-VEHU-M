DGROAPI ;DJH/AMA - ROM EXTERNAL USER INTERFACE APIs ; 27 Apr 2004  4:42 PM
 ;;5.3;Registration;**533,572,1102**;Aug 13, 1993;Build 4
 ;
 ;This routine contains API entry points that are used by packages
 ;and modules that are external to the Register Once module.
 ;
 ; Reference to (#350.9,54.01) supported by ICR #7429
 ; Reference to BACKGND^IBCNRDV supported by ICR #4288
 Q  ;no direct entry
 ;
ROMQRY(DGDFN) ;query the LST for all patient demographic data
 ;This function queries a given patient's Last Site Treated (LST)
 ;site to retrieve all patient demographic data for the patient.
 ;The function will only succeed when the QRY HL7 interface is
 ;enabled, the patient has a national Integrated Control Number
 ;(ICN), the patient's LST is not the local site and the HL7 query
 ;receives an ACK from the LST site.
 ;
 ;  Input:
 ;     DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;     Function value - 1 on success, 0 on failure
 ;
 N DGRSLT,STRTIME,ENDTIME,ELAPTIME
 S STRTIME=$P($H,",",2)
 ;
 S DGRSLT=$$SNDQRY^DGROHLS(DGDFN)
 S ENDTIME=$P($H,",",2)
 S ELAPTIME=ENDTIME-STRTIME
 I DGRSLT=0&(ELAPTIME>59) D
 . S DGMSG(1)=" "
 . S DGMSG(2)="The connection to the Last Site Treated failed and timed out."
 . S DGMSG(3)="Please continue with registration."
 . S DGMSG(4)=" "
 . D EN^DDIOL(.DGMSG)
 ;
 I DGRSLT D
 . N ZTSAVE,A,ZTRTN,ZTDESC,ZTIO,ZTDTH,DGMSG
 . ;Invoke IB Insurance Query (Query was introduced with IB*2.0*214)
 . ;DG*1102/TAZ - Check Insurance Import Enabled flag
 . ; Reference to Field 54.01 in File 350.9 supported by ICR #7429
 . I '$$GET1^DIQ(350.9,"1,",54.01,"I") D  Q
 .. S DGMSG(1)="Insurance data retrieval is not currently enabled."
 .. S DGMSG(2)=" "
 .. D EN^DDIOL(.DGMSG) R A:5
 . S ZTSAVE("IBTYPE")=1,ZTSAVE("DFN")=DGDFN,ZTSAVE("IBDUZ")=$G(DUZ)
 . S ZTRTN="BACKGND^IBCNRDV"  ;Supported by ICR #4288
 . S ZTDTH=$H
 . S ZTDESC="IBCN INSURANCE QUERY TASK"
 . S ZTIO=""
 . D ^%ZTLOAD
 . ;display busy message to interactive users
 . S DGMSG(2)="Insurance data retrieval has been initiated."
 . S DGMSG(3)=" "
 . D EN^DDIOL(.DGMSG) R A:5
 Q DGRSLT
 ;
