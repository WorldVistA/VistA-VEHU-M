SDES2VALISODTTM ;ALB/BWF - SDES2 VALIDATE ISO DATE/TIMES ;JUL 28, 2023
 ;;5.3;Scheduling;**853,866**;Aug 13, 1993;Build 22
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ; extrinsic function to validate a date using specific error codes from 409.93
 ; returns Fileman date if valid or "" if invalid
 ; DATE - Date/time in ISO Format (required)
 ; CLINIC - clinic IEN to apply clinic timezone offset (optional)
 ; REQUIRED - 1 for required - This tells the validator if this field should be required (optional - defaults to not required)
 ; MISSINGERRORID - The custom error ID for a "Missing" date. If not passed, will default to '45 - Missing date' (optional)
 ; INVALIDERRORID - The custom error ID for an "Invalid" date. If not passed, will default to '46 - Invalid date' (optional)
 ; DELERRID - Deletion error ID, when process is trying to delete a required field with '@'
 ; MISSERRTEXT - Error text to add to the returned 'MISSING' error
 ; INVALERRTEXT - Error text to add to the returned 'INVALID' error
 ; DELERRTEXT - Error text to add to the returned 'DELETE' error
 ;
VALISODTTM(ERRORS,DATETIME,CLINIC,REQUIRED,MISSINGERRID,INVALIDERRID,DELERRID,MISSERRTEXT,INVALERRTEXT,DELERRTEXT) ;
 N FMSDATE,MISSINGID,INVALIDID
 S MISSINGID=$S($G(MISSINGERRID):MISSINGERRID,$P($G(DATETIME),"T",2)'="":496,1:45)
 S INVALIDID=$S($G(INVALIDERRID):INVALIDERRID,$P($G(DATETIME),"T",2)'="":497,1:46)
 I '$G(REQUIRED),$G(DATETIME)="" Q ""
 I $G(REQUIRED),$G(DATETIME)="" D ERRLOG^SDES2JSON(.ERRORS,MISSINGID,$G(MISSERRTEXT)) Q ""
 I $G(REQUIRED),$G(DATETIME)="@" D  Q ""
 .I $G(DELERRID) D ERRLOG^SDES2JSON(.ERRORS,DELERRID,$G(DELERRTEXT)) Q
 .D ERRLOG^SDES2JSON(.ERRORS,229,$G(DELERRTEXT))
 S FMSDATE=$$ISOTFM^SDAMUTDT($G(DATETIME),$G(CLINIC))
 I FMSDATE<1 D ERRLOG^SDES2JSON(.ERRORS,INVALIDID,$G(INVALERRTEXT)) Q ""
 Q FMSDATE
 ;
 ; extrinsic function to validate a date/time range
 ; STARTDTTM (REQUIRED) - Start date or date/time in ISO format
 ; ENDDTTM   (REQUIRED) - End date or date/time in ISO format
 ; REQUIRED  (OPTIONAL) - 1 if the date range is required,
 ;                       if required start date/time and end date/time must be passed in or an error will be returned
 ; CLINIC    (OPTIONAL) - Clinic IEN to apply clinic timezone offset
 ;
VALISODATERANGE(ERRORS,STARTDTTM,ENDDTTM,REQUIRED,CLINIC) ;
 N FMSDATE,MISSINGID,INVALIDID,FMSTART,FMEND,ERRORFLAG
 I '$G(REQUIRED),('$L($G(STARTDTTM))!('$L($G(ENDDTTM)))) Q ""
 I $G(REQUIRED),'$L($G(STARTDTTM)) S ERRORFLAG=1 D ERRLOG^SDES2JSON(.ERRORS,498)
 I $G(REQUIRED),'$L($G(ENDDTTM)) S ERRORFLAG=1 D ERRLOG^SDES2JSON(.ERRORS,501)
 I $G(ERRORFLAG) Q ""
 S FMSTART=$$ISOTFM^SDAMUTDT(STARTDTTM,$G(CLINIC))
 I FMSTART<1 S ERRORFLAG=1 D ERRLOG^SDES2JSON(.ERRORS,499)
 S FMEND=$$ISOTFM^SDAMUTDT(ENDDTTM,$G(CLINIC))
 I FMEND<1 S ERRORFLAG=1 D ERRLOG^SDES2JSON(.ERRORS,502)
 I $G(ERRORFLAG) Q ""
 I FMEND<FMSTART D ERRLOG^SDES2JSON(.ERRORS,503) Q ""
 Q FMSTART_U_FMEND
