SDES2VALUTIL ;ALB/BWF - SDES2 VALIDATION UTILITY ;JUL 28, 2023
 ;;5.3;Scheduling;**853,861,866**;Aug 13, 1993;Build 22
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ; VALRETURN - 1 for success, 0 for failure
 ; FILE - File Manager file number
 ; FIELD - File Manager field number
 ; VALUE - input value, either text or numeric value - value will be checked against the input transform
 ; REQUIRED - (1 for required, otherwise, not required)
 ; CANDELETE - (1 - deletion allowed, otherwise, deletion is not allowed)
 ; MISSINGERRID - Error ID from the SDEC ERROR CODES file (409.93) - overrides defualt missing error
 ; INVALIDERRID - Error ID from the SDEC ERROR CODES file (409.93) - overrides default invalid error
 ; DELERRID - Error ID from teh SDEC ERRRO CODES file (409.93) - overrides default delete error
 ; MISSERRTEXT - Error text to add to the returned 'MISSING' error
 ; INVALERRTEXT - Error text to add to the returned 'INVALID' error
 ; DELERRTEXT - Error text to add to the returned 'DELETE' error
 ;
VALFILEIEN(VALRETURN,ERRORS,FILENUM,VALUE,REQUIRED,CANDELETE,MISSINGERRID,INVALIDERRID,DELERRID,MISSERRTEXT,INVALERRTEXT,DELERRTEXT) ;
 N FDATA,FILERR,GLOBALROOT,FERR,ERRLOOP,ERRTEXT
 K VALRETURN
 S VALRETURN=0
 I '$L($G(FILENUM)) Q
 I $G(REQUIRED),$G(VALUE)="@" D  Q
 .I $G(DELERRID) D ERRLOG^SDES2JSON(.ERRORS,DELERRID,$G(DELERRTEXT)) Q
 .D ERRLOG^SDES2JSON(.ERRORS,52,"This field cannot be deleted.")
 I $G(CANDELETE),($G(VALUE)="@"!($G(VALUE)="")) S VALRETURN=1 Q
 D FILE^DID(FILENUM,,"GLOBAL NAME;NAME","FDATA","FERR")
 I $D(FERR) D  Q
 .S ERRLOOP=0 F  S ERRLOOP=$O(FERR("DIERR",1,"TEXT",ERRLOOP)) Q:'ERRLOOP  D
 ..S ERRTEXT=$G(FERR("DIERR",1,"TEXT",ERRLOOP))
 ..D ERRLOG^SDES2JSON(.ERRORS,52,ERRTEXT) Q
 I $G(REQUIRED),$G(VALUE)="" D  Q
 .I $G(MISSINGERRID) D ERRLOG^SDES2JSON(.ERRORS,MISSINGERRID,$G(MISSERRTEXT)) Q
 .D ERRLOG^SDES2JSON(.ERRORS,52,"Missing IEN for file: "_$G(FDATA("NAME")))
 ; if we get to this point and the field is not required, quit, no need to check the global
 I '$G(REQUIRED),$G(VALUE)="" S VALRETURN=1 Q
 ; force the value to a string in the event there are alpha-numeric characters in VALUE
 S VALUE=""""_VALUE_""""
 S GLOBALROOT=$G(FDATA("GLOBAL NAME"))
 S GLOBALROOT=GLOBALROOT_VALUE_")"
 I '$D(@GLOBALROOT@(0)) D  Q
 .I $G(INVALIDERRID) D ERRLOG^SDES2JSON(.ERRORS,INVALIDERRID,$G(INVALERRTEXT)) Q
 .D ERRLOG^SDES2JSON(.ERRORS,52,"Invalid IEN for file:"_$G(FDATA("NAME"))_": "_VALUE)
 S VALRETURN=1
 Q
 ;
 ; VALRETURN - return array
 ;             VALRETURN= 1 - valid, 0 - not valid
 ;             VALRETURN(FILENUMBER, FIELD NUMBER,"I")=INTERNAL FILEMAN VALUE
 ;             VALRETURN(FILENUMBER, FIELD NUMBER,"E")=EXTERNAL FILEMAN VALUE
 ; ERRORS - error array contains errors
 ; FILE - File Manager file number
 ; FIELD - File Manager field number
 ; VALUE - input value, either text or numeric value - value will be checked against the input transform
 ; REQUIRED - (1 for required, otherwise, not required)
 ; CANDELETE - (1 - deletion allowed, otherwise, deletion is not allowed)
 ; MISSINGERRID - Error ID from the SDEC ERROR CODES file (409.93)
 ; INVALIDERRID - Error ID from the SDEC ERROR CODES file (409.93)
 ; DELERRID - Error ID from teh SDEC ERRRO CODES file (409.93) - overrides default delete error
 ; MISSERRTEXT - Error text to add to the returned 'MISSING' error
 ; INVALERRTEXT - Error text to add to the returned 'INVALID' error
 ; DELERRTEXT - Error text to add to the returned 'DELETE' error
 ;
VALFIELD(VALRETURN,ERRORS,FILE,FLD,VALUE,REQUIRED,CANDELETE,MISSINGERRID,INVALIDERRID,DELERRID,MISSERRTEXT,INVALERRTEXT,DELERRTEXT) ;
 N RESULTS,VALERR,FMERRNUM,FMERRTEXT,LABEL,INPUTCHK,FLDINFO,FERR,ITERR,I,CHKVAL,INPUTCHK
 K VALRETURN
 S VALRETURN=0
 I $G(FILE)=""!($G(FLD)="") D ERRLOG^SDES2JSON(.ERRORS,52,"Invalid file or field.") Q
 ; not a valid DD reference
 I '$D(^DD(FILE,FLD)) D ERRLOG^SDES2JSON(.ERRORS,52,"Invalid file or field.") Q
 D FIELD^DID(FILE,FLD,"","LABEL;INPUT TRANSFORM","FLDINFO","FERR")
 I $D(FERR) D ERRLOG^SDES2JSON(.ERRORS,52,"A problem occured finding the field definition.") Q
 S INPUTCHK=$G(FLDINFO("INPUT TRANSFORM"))
 I INPUTCHK["DA" D ERRLOG^SDES2JSON(.ERRORS,52,"Cannot validate fields where the input transform requires DA.") Q
 F I=1:1:9 D
 .S CHKVAL="D"_I
 .I INPUTCHK[CHKVAL S ITERR=1
 I $G(ITERR) D ERRLOG^SDES2JSON(.ERRORS,52,"Cannot validate fields that require D0, D1, D2, etc.") Q
 I INPUTCHK["$$"!(INPUTCHK["D:")!(INPUTCHK[" D ") D ERRLOG^SDES2JSON(.ERRORS,52,"Cannot validate fields that call additional functions.") Q
 I INPUTCHK["D ",$P(INPUTCHK,"D ",2)["^" D ERRLOG^SDES2JSON(.ERRORS,52,"Cannot validate fields that call additional functions.") Q
 I $D(^DD(FILE,FLD,12.1)) D ERRLOG^SDES2JSON(.ERRORS,52,"Cannot validate fields that contain screening logic.") Q
 I $D(^DD(FILE,FLD,2))!($D(^DD(FILE,FLD,2.1))) D ERRLOG^SDES2JSON(.ERRORS,52,"Cannot validate fields containing Output transform logic.") Q
 S LABEL=$G(FLDINFO("LABEL"))
 I $G(VALUE)["^" D ERRLOG^SDES2JSON(.ERRORS,52,"Input containing '^' is prohibited.") Q
 ; calling function wants this field to be required.
 I $G(REQUIRED),$G(VALUE)="" D  Q
 .I $G(MISSINGERRID) D ERRLOG^SDES2JSON(.ERRORS,MISSINGERRID,$G(MISSERRTEXT)) Q
 .D ERRLOG^SDES2JSON(.ERRORS,52,"Missing required value for field: "_LABEL_" (#"_FLD_")")
 I '$G(REQUIRED),$G(VALUE)="" S VALRETURN=1 Q
 ;
 ; if calling application indicates 'required' and '@' is passed, produce an error.
 I $G(REQUIRED),$G(VALUE)="@" D ERRLOG^SDES2JSON(.ERRORS,229,$S($L($G(DELERRTEXT)):DELERRTEXT,1:LABEL)) Q
 I '$G(CANDELETE),(VALUE="@"!(VALUE="")) D  Q
 .I $G(DELERRID) D ERRLOG^SDES2JSON(.ERRORS,DELERRID,$G(DELERRTEXT)) Q
 .D ERRLOG^SDES2JSON(.ERRORS,52,"This field cannot be deleted: "_LABEL_" (#"_FLD_")")
 ; for non-required fields, if this is '@' or "", quit, no need to check further
 I $G(CANDELETE),($G(VALUE)="@"!($G(VALUE)="")) S VALRETURN=1 Q
 ;
 D CHK^DIE(FILE,FLD,"E",VALUE,.RESULTS,"VALERR")
 I $D(VALERR) D  Q
 .I $G(INVALIDERRID) D ERRLOG^SDES2JSON(.ERRORS,INVALIDERRID,$G(INVALERRTEXT)) Q
 .S FMERRNUM=0 F  S FMERRNUM=$O(VALERR("DIERR",FMERRNUM)) Q:'FMERRNUM  D
 ..S FMERRTEXT=$G(VALERR("DIERR",FMERRNUM,"TEXT",1))
 ..D ERRLOG^SDES2JSON(.ERRORS,52,FMERRTEXT)
 D SETRETURN(.VALRETURN,FILE,FLD,$G(RESULTS),$G(RESULTS(0)))
 Q
 ; validate number is within given range LOW to HIGH
VALNUMBERRNG(VALRETURN,ERRORS,INPUTVALUE,LOW,HIGH,ISREQUIRED,MISSINGERRID,INVALIDERRID)  ;
 K VALRETURN
 S VALRETURN=0
 I $G(ISREQUIRED),$G(INPUTVALUE)="" D  Q
 .I $G(MISSINGERRID) D ERRLOG^SDES2JSON(.ERRORS,MISSINGERRID) Q
 .D ERRLOG^SDES2JSON(.ERRORS,52,"Missing numeric input.")
 I '$G(ISREQUIRED),$G(INPUTVALUE)="" Q
 I INPUTVALUE<LOW!(INPUTVALUE>HIGH) D  Q
 .I $G(INVALIDERRID) D ERRLOG^SDES2JSON(.ERRORS,INVALIDERRID) Q
 .D ERRLOG^SDES2JSON(.ERRORS,52,"Number must be between "_LOW_"-"_HIGH)
 D SETRETURN(.VALRETURN)
 Q
SETRETURN(VALRETURN,FILE,FLD,INTERNALVAL,EXTERNALVAL)   ;
 S VALRETURN=1
 Q:'$D(FILE)!('$D(FLD))
 I $L($G(INTERNALVAL)) S VALRETURN(FILE,FLD,"I")=INTERNALVAL
 I $L($G(EXTERNALVAL)) S VALRETURN(FILE,FLD,"E")=EXTERNALVAL
 Q
