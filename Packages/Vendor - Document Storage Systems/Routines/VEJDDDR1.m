VEJDDDR1 ; BLJ/DSS-More Fileman utilities ; 04/22/1999  10:10 AM
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ; This routine copyright 2000 by Document Storage Systems, Inc.  All rights reserved.
 Q 
 ; Only call via line tags.
 ;
GETPRINT(VEJDRETN) ; Gets a list of printers
 ; No input
 ;
 ; Return: Array of printers
 ;
 N VEJDLOOP,VEJDTYPE S VEJDLOOP=0,VEJDTYPE=""
 F  S VEJDLOOP=$O(^%ZIS(1,VEJDLOOP)) Q:'VEJDLOOP  D
 .S VEJDTYPE=$P($G(^%ZIS(1,VEJDLOOP,"SUBTYPE")),U)
 .I VEJDTYPE'=""!(VEJDTYPE'?." ") D
 ..S VEJDPRNT=$P($G(^%ZIS(2,VEJDTYPE,0)),U)
 ..S:VEJDPRNT?1"P-".E VEJDRETN(VEJDLOOP)=$P($G(^%ZIS(1,VEJDLOOP,0)),U)
 Q
GETFILES(VEJDRETN) ; Get a list of files
 ; No input
 ;
 ; Return: Array of file names
 ;
 N VEJDLOOP,VEJDFILE S VEJDLOOP=0
 F  S VEJDLOOP=$O(^DD(VEJDLOOP)) Q:'VEJDLOOP  D
 .S VEJDFILE=$P($G(^DIC(VEJDLOOP,0)),U)
 .S:VEJDFILE'="" ^TMP("VEJDDDR1",$J,VEJDLOOP)=VEJDLOOP_U_VEJDFILE
 S VEJDRETN=$NA(^TMP("VEJDDDR1",$J))
 Q
GETTMPLT(VEJDRETN,VEJDFILE) ; Get list of templates for a file
 ; Input: VEJDFILE
 ;
 ; Return: Array of templates for file in form:
 ;   Template Type^TemplateNumber^TemplateName
 ;
 N VEJDLOOP,VEJDCNT S (VEJDLOOP,VEJDCNT)=0
 F  S VEJDLOOP=$O(^DIPT(VEJDLOOP)) Q:'VEJDLOOP  D
 .S:$P($G(^DIPT(VEJDLOOP,0)),U,4)=VEJDFILE VEJDRETN(VEJDCNT)="P^"_VEJDLOOP_U_$P($G(^DIPT(VEJDLOOP,0)),U)
 .S VEJDCNT=VEJDCNT+1
 S VEJDLOOP=0
 F  S VEJDLOOP=$O(^DIBT(VEJDLOOP)) Q:'VEJDLOOP  D
 .S:$P($G(^DIBT(VEJDLOOP,0)),U,4)=VEJDFILE VEJDRETN(VEJDCNT)="S^"_VEJDLOOP_U_$P($G(^DIBT(VEJDLOOP,0)),U)
 .S VEJDCNT=VEJDCNT+1
 Q
PRINT(VEJDRETN,VEJDFILE,VEJDFLDS,VEJDBY,VEJDFROM,VEJDTO,VEJDIOP,VEJDQTME) ; Print data
 ; Input: VEJDFILE: File number
 ;        VEJDFLDS: Fields (or print template) to print
 ;        VEJDBY:   Sort by (or sort template)
 ;        VEJDFROM: Entry to start from
 ;        VEJDTO:   Entry to go to
 ;        VEJDIOP:  Printer to print to
 ;        VEJDQTME: If printout is queued, time to print
 N VEJDROOT S VEJDROOT=$G(^DIC($G(VEJDFILE),0,"GL"))
 S L=0,DIC=$G(VEJDROOT),FLDS=$G(VEJDFLDS),BY=$G(VEJDBY),FR=$G(VEJDFROM),TO=$G(VEJDTO),IOP=$G(VEJDIOP)
 S:IOP?1"Q;".E DQTIME=$G(VEJDQTME,"NOW")
 D EN1^DIP
 Q
FIELDS(VEJDRETN,VEJDFILE) ; Get fields for a given file
 ; Input: VEJDFILE: File number
 ;
 ; Return: Array of
 ;         FieldNumber^FieldName
 ;
 N VEJDLOOP S VEJDLOOP=""
 F  S VEJDLOOP=$O(^DD(VEJDFILE,"B",VEJDLOOP)) Q:VEJDLOOP=""  D
 .S VEJDRETN(VEJDLOOP)=$O(^DD(VEJDFILE,"B",VEJDLOOP,0))_U_VEJDLOOP
 Q
SUBTYPE(VEJDDEV) ; Extrinsic function to return device subtype
 ; Input: VEJDDEV: Device IFN
 ; 
 ; Return: if item is a printer: "PRINTER"
 ;         else "TERMINAL"
 ;
 N VEJDTYPE
 S VEJDTYPE=$G(^%ZIS(1,VEJDDEV,"SUBTYPE"))
 S VEJDTYPE=$P($G(^%ZIS(2,VEJDTYPE,0)),U)
 Q:VEJDTYPE="" "TERMINAL"
 S VEJDTYPE=$S(VEJDTYPE?1"P-".E:"PRINTER",1:"TERMINAL")
 Q VEJDTYPE
