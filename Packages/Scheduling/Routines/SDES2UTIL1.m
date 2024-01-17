SDES2UTIL1 ;ALB/MGD/TJB/MGD - SDES2 UTILITIES Continued ;NOV 09, 2023
 ;;5.3;Scheduling;**870,861**;Aug 13, 1993;Build 17
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
VALBOOLEAN(SDERRORS,SDBOOLEAN,SDREQUIRED,SDERRORTEXT) ;
 ; SDERRORS = Array to hold any logged errors
 ; SDBOOLEAN = Boolean input array element to validate
 ; SDREQUIRED = 1:Required, 0:Optional, Defaults to 0
 ; SDERRORTEXT = Additional text to append to error message. This is normally the name of the input parameter element.
 ;
 I SDREQUIRED=0,SDBOOLEAN="" Q
 S SDREQUIRED=$S($G(SDREQUIRED)="":0,1:$G(SDREQUIRED))
 I SDREQUIRED=1,SDBOOLEAN="" D ERRLOG^SDESJSON(.SDERRORS,519,SDERRORTEXT)
 I SDBOOLEAN'="1",SDBOOLEAN'="0" D ERRLOG^SDESJSON(.SDERRORS,518,SDERRORTEXT)
 Q
 ;
GETRES(SDCL,INACT)  ; Extrinsic function to return resource for clinic - SDEC RESOURCE (409.831)
 ; SDCL = Clinic IEN from File 44
 ; INACT = If not null, skip check to see if resource is inactive
 ; Return value is the associated resource or the empty string
 ;
 ; SDHLN - Name of the Clinic from File 44
 ; SDI - Resource IEN from file 409.831
 ; SDRESTYP - RESOURCE TYPE, Field .012 from File 409.831
 N SDHLN,SDI,SDRESTYP,SDRES,SDRES1
 S (SDRES,SDRES1)=""
 S SDHLN=$$GET1^DIQ(44,SDCL_",",.01,"E")
 Q:SDHLN="" ""
 S SDI="" F  S SDI=$O(^SDEC(409.831,"ALOC",SDCL,SDI)) Q:SDI=""  D  Q:SDRES'=""
 .S SDRESTYP=$$GET1^DIQ(409.831,SDI_",",.012,"I")
 .I '$G(INACT) Q:$$GET1^DIQ(409.831,SDI_",",.02)="YES"
 .S:SDRES1="" SDRES1=SDI
 .Q:$P(SDRESTYP,";",2)'="SC("
 .S SDRES=SDI
 I SDRES="",SDRES1'="" S SDRES=SDRES1
 Q SDRES
