RCTASFH ;AITC/CJE - Receive FHIR message for ePayments 835 EFT/ERA
 ;;4.5;Accounts Receivable;**455**;Oct 4, 2018;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR 6682  - ENCODE^XLFJSON
 ; ICR 10097 - $$EC^%ZOSV
 ; ICR 1621  - ^%ZTER
 ; ICR 2053  - ^DIE
 ; ICR 2263  - $$GET^XPAR
 ; ICR 4440  - $$PROD^XUPROD
 ; ICR 10103 - ^XLFDT
 ;
 Q
 ;
POST(RESULT,ARG) ;Entry point to receive 835 EFT message from ARG array
 ; Input: ARG
 N $ESTACK,$ETRAP,GLBO,RETURN
 S $ETRAP="D ERR^RCTASFH",$ECODE=""
 S GLBO="^TMP(""RCD835"",$J,""OUT"")"
 K ^TMP("RCD835",$J)
 I $D(ARG)'>1 D  G EXIT
 . S @GLBO@("Status")="0^ARG parameter is missing or has bad format"
 . D ENCODE^XLFJSON(GLBO,"RESULT") S RESULT(1)="["_RESULT(1)_"]"
 ;
 S RETURN=$$PARSEEFT(.ARG)
 ; Success or failure returned by PARSEEFT
ERRET ; return here after error
 I $D(^TMP("RCD835",$J,"ERROR")) S RETURN=^TMP("RCD835",$J,"ERROR")
 S @GLBO@("Status")=RETURN
 D ENCODE^XLFJSON(GLBO,"RESULT") S RESULT(1)="["_RESULT(1)_"]"  ;
EXIT ; Common exit point
 K ^TMP("RCD835",$J)
 Q
 ;
PARSEEFT(ARG) ; Parse the incomming EFT Message
 ; Get the following fields that are needed to file the deposit info and the EFT detail
 ;
 ; paymentnotice-pncdepositnumber VistA Deposit Number is derive from "569"_$E(pncdeposit#,7,12)
 ; paymentnotice-paymentDate = DepositDate (CCYY-MM-DD)
 ; 
 ; id = "EFT"_Trace#_"."_PayerTIN
 ; paymentnotice-created = Date/Time CCYY-MM-DD_"T"_HH:MM_"-"_HH:MM (UTC OFFSET)
 ; 
 ;
 ; Fields for 344.31 - 06/17/2025 - Changes for new flattened json
 ; PAYER ID (.03)               - payer-identifier ** BECOMES payer-identifier-value **
 ; TRACE # (.04)                - $P(paymentnotice-identifier,".",1) ** BECOMES paymentnotice-payment-identifier-value **
 ;
 ; Fields for 344.3
 ; FILE DATE/TIME (.02)             - paymentnotice-created (convert to FileMan Date/Time)
 ; DEPOSIT NUMBER (.06)             - Bytes 7-13 of paymentnotice-pncdepositnumber
 ; DEPOSIT DATE (.07)               - paymentnotice-paymentDate (convert to FileMan Date/Time)
 ; TOTAL DEPOSIT AMOUNT (.08)       - Sum of paymentnotice-amount from each EFT detail added
 ; DATE/TIME ADDED (.13)            - (Calculated) $$NOW^XLFDT
 ; AMOUNT POSTED TO DEPOSIT (.12)   - Default to 0
 ; TOTAL AMOUNT MATCHED (.14)       - Default to 0
 ;
 ; Fields for 344.31
 ; PAYER NAME (.02)             - payer-name
 ; PAYER ID (.03)               - payer-identifier-value
 ; TRACE # (.04)                - $P(paymentnotice-payment-identifier-value,".",1)
 ; AMOUNT OF PAYMENT (.07)      - paymentnotice-amount
 ; MATCH STATUS (.08)           - Default to 0
 ; EFT RECORDED AT SITE (.11)   - Default to 0
 ; DATE CLAIMS PAID (.12)       - paymentnotice-paymentDate (convert to FileMan Date/Time)
 ; ACH TRACE NUMBERS FDA (.15)  - paymentnotice-pnctrackingnumber
 ;
 N AMOUNT,DATE,DEBIT,ERRMSG,ERRSTAT,ERROR,FDA,FDATE,FHRDATE,IENS,LCNT,LTRUE
 N RCDDAT,RCDEPNO,RCDUP,RCLOCKTM,RCTDA,RCTT,RCUNIT,RCTRACE,RCODE,RCX,X,Z,Z0
 ;
 S RCLOCKTM=$$GET^XPAR("PKG.ACCOUNTS RECEIVABLE","RCDPE FHIR EFT LOCK TIMEOUT",1)
 I 'RCLOCKTM S RCLOCKTM=5
 S ERRMSG="Error Filing EFT in VistA"
 S ERRSTAT=0
 S (RCTT,RCUNIT)=0
 ; Set debugging flags for non-production system
 I '$$PROD^XUPROD D  ;
 . I $D(RCDPTT) S RCTT=1
 . I $D(IrisTestCase) S RCUNIT=1
 . ; I 'RCTT,'RCUNIT D MRGTMP(.ARG) ; Save data in ^ZZCJE global
 . D MRGTMP(.ARG) ; Save data in ^ZZCJE global
 ;
 S FHRDATE=$G(ARG("paymentnotice-paymentdate"))
 S RCDDAT=$$FHRTFM(FHRDATE,0)
 S RCDEPNO=$G(ARG("paymentnotice-pncdepositnumber"))
 S RCODE=$$VALID(.ARG)
 I 'RCODE Q RCODE
 ;
 S RCTRACE=$G(ARG("paymentnotice-payment-identifier-value"))
 S AMOUNT=+$G(ARG("paymentnotice-amount"))
 ;
 ; Before doing anything with an EDI Lockbox deposit get an overall lock. Lock on ^RCY(344.3,"ALOCK") is also used in AR
 ; nightly process during posting and matching so will make sure FHIR EFT filing does not happen while that is running.
 S (ERROR,LCNT,LTRUE,RCTDA,RCX,Z)=0
 F LCNT=1:1:6 D  I LTRUE Q  ;
 . L +^RCY(344.3,"ALOCK"):RCLOCKTM
 . I $T S LTRUE=1 Q
 . H 5
 I 'LTRUE S ERRMSG="Could not get overall lock on EDI Lockbox Deposit",ERROR=1,ERRSTAT=2
 I ERROR D  Q ERRSTAT_"^"_ERRMSG
 . I ERRSTAT=0 D FILERR^RCTASFH1(.ARG,"835EFT",3,ERRMSG)
 . I ERRSTAT=2 D LOGFAIL(RCTRACE)
 ;
 ; Does deposit already exist?
 F  S Z=$O(^RCY(344.3,"ADEP",RCDDAT,RCDEPNO,Z)) Q:'Z  S Z0=$G(^RCY(344.3,Z,0)) S:'$P(Z0,U,3) RCTDA=Z Q:RCTDA  D  Q:RCTDA
 . ; Deposit found - find receipt
 . I $O(^RCY(344,"AD",$P(Z0,U,3),0)) S RCDUP=Z Q
 . S RCTDA=Z
 ; I deposit exists get a lock and keep it till update of 344.3 and 344.31 is complete or there is an error
 I RCTDA D  ;
 . L +^RCY(344.3,RCTDA,0):RCLOCKTM I '$T S ERRMSG="Could not get lock on EDI Lockbox Deposit",ERROR=1,ERRSTAT=2
 . L -^RCY(344.3,"ALOCK") ; Deposit exists so release overall lock on 344.3
 ; Following code to file a new LOCKBOX DEPOSIT in 344.3
 E  D  ;
 . K ^TMP("DIERR",$J)
 . S RCX=+$O(^RCY(344.3," "),-1)
 . F RCX=RCX+1:1 I '$D(^RCY(344.3,RCX,0)) L +^RCY(344.3,RCX,0):DILOCKTM I $T Q
 . S IENS(1)=RCX
 . S IENS="+1,"
 . S FHRDATE=$G(ARG("paymentnotice-created"))
 . ; Date to Fileman format
 . S FDA(344.3,"+1,",.01)=IENS(1)                                       ; Internal Entry Number
 . S FDA(344.3,"+1,",.02)=$$FHRTFM(FHRDATE,1)                           ; FILE DATE/TIME
 . S FDA(344.3,IENS,.06)=RCDEPNO                                        ; DEPOSIT NUMBER
 . S FDA(344.3,IENS,.07)=RCDDAT                                         ; DEPOSIT DATE
 . S FDA(344.3,IENS,.08)=0                                              ; DEPOSIT AMOUNT - Default to 0. Is be updated after EFT is added
 . S FDA(344.3,IENS,.13)=$$NOW^XLFDT()                                  ; DATE/TIME ADDED
 . S FDA(344.3,IENS,.12)=0                                              ; AMOUNT POSTED  ) 0 for new entry
 . S FDA(344.3,IENS,.14)=0                                              ; AMOUNT MATCHED
 . S FDA(344.3,IENS,.15)=1                                              ; UNBALANCED FLAG - Default to unbalanced - set to balanced one EFT total is calculated
 . D UPDATE^DIE("","FDA","IENS")
 . I RCTT,$E(RCTRACE,1,6)="ERRDEP" D GENERR("D")
 . I $D(^TMP("DIERR",$J)) S ERRMSG="Error filing EDI LOCKBOX DEPOSIT in VistA",ERROR=1,ERRSTAT=0
 . E  D  ;
 . . S RCTDA=IENS(1)
 . . I 'RCTDA S ERRMSG="No deposit IEN returned; not filing EFT detail",ERROR=1,ERRSTAT=0
 . . I RCUNIT S IrisTestCase("IEN3443")=RCTDA
 . L -^RCY(344.3,"ALOCK") ; Attempt to create EDI Lockbox deposit is complete so release overall lock on 344.3
 ;
 I ERROR D  Q ERRSTAT_"^"_ERRMSG
 . N KEY3
 . I ERRSTAT=0 D FILERR^RCTASFH1(.ARG,"835EFT",3,ERRMSG)
 . I ERRSTAT=2 D LOGFAIL(RCTRACE)
 . S KEY3=$S(RCTDA:RCTDA,1:RCX)
 . L -^RCY(344.3,KEY3,0)
 ;
 ; EDI LOCKBOX DEPOSIT has been created or updated, so now add the EFT DETAIL TO 344.31
 K IENS,FDA,^TMP("DIERR",$J)
 S IENS="+1,"
 S FDA(344.31,IENS,.01)=RCTDA
 S FDA(344.31,IENS,.02)=$G(ARG("payer-name"))
 S FDA(344.31,IENS,.03)=$G(ARG("payer-identifier-value"))
 S FDA(344.31,IENS,.04)=$P(RCTRACE,".",1)
 ; Amount filed in the EFT is always positive. If amount in the message is negative, the debit flag is set.
 S FDA(344.31,IENS,.07)=$J($S(AMOUNT<0:-AMOUNT,1:AMOUNT),"",2)
 S DEBIT=$S(AMOUNT<0:"D",1:"")
 S FDA(344.31,IENS,3)=DEBIT
 ;
 S FDA(344.31,IENS,.08)=0
 S FDA(344.31,IENS,.11)=0
 S FDA(344.31,IENS,.12)=RCDDAT
 S FDA(344.31,IENS,.13)=$$DT^XLFDT()
 S FDA(344.31,IENS,.15)=$G(ARG("paymentnotice-pnctrackingnumber"))
 D UPDATE^DIE("","FDA","IENS")
 I RCTT,$E(RCTRACE,1,6)="ERREFT" D GENERR("E")
 I $D(^TMP("DIERR",$J)) D  Q ERRSTAT_"^"_ERRMSG
 . S ERRMSG="Error filing EFT DETAIL in VistA",ERROR=1,ERRSTAT=0
 . D FILERR^RCTASFH1(.ARG,"835EFT",3,ERRMSG)
 . L -^RCY(344.3,RCTDA,0)
 ;
 I ERROR D  Q ERRSTAT_"^"_ERRMSG
 . D FILERR^RCTASFH1(.ARG,"835EFT",3,ERRMSG)
 ;
 I RCUNIT S IrisTestCase("IENS34431")=IENS(1)
 ;
 ; EDI LOCKBOX DEPOSIT total should always be the sum on the EFTs. So update now.
 K IENS,FDA,^TMP("DIERR",$J)
 S IENS=RCTDA_","
 S FDA(344.3,IENS,.08)=$$SUMEFT^RCDPESR3(RCTDA)
 S FDA(344.3,IENS,.15)="@"
 D FILE^DIE("","FDA")
 L -^RCY(344.3,RCTDA,0) ; Release lock on EDI Lockbox deposit when all updates are completed
 ;
 I RCUNIT Q "1^EFT message successfully filed^"_$G(IrisTestCase("IEN3443"))_"^"_$G(IrisTestCase("IENS34431"))
 Q "1^EFT message successfully filed"
 ;
FHRTFM(FHRDATE,TIME) ; Convert FHIR date to FileMan format
 ; Inputs FHRDATE - FHIR date/time in FHIR format
 ;        TIME    - Boolean flag to say if time should be included in the output
 N D,RETURN,T
 S TIME=+$G(TIME)
 S D=$P(FHRDATE,"T",1),T=$P(FHRDATE,"T",2)
 S D=($E(D,1,2)-17)_$E(D,3,4)_$P(D,"-",2)_$P(D,"-",3)
 S RETURN=D
 I TIME D  ;
 . I T["-" S T=$P(T,"-",1)
 . I T["+" S T=$P(T,"+",1)
 . S T=$TR(T,":","")
 . I 'T D  ;
 . . S RETURN=D
 . E  D  ;
 . . S RETURN=+(D_"."_T)
 Q RETURN
 ;
VALID(ARG) ; Check for error conditions before filing. If invalid set return error code.
 ; Inputs : ARG - Arguments passed from VistALink containing JSON name value pairs.
 ; RETURNS : 1 - Message is valid
 ;           0^Error Description - Message is invalid
 N X
 S X=$G(ARG("paymentnotice-pncdepositnumber"))
 I $L(X)<6!($L(X)>9) Q "0^Error. Invalid Deposit Number "_X
 S X=$G(ARG("payer-identifier-value"))
 I X="" Q "0^Error. Mising Payer ID "_X
 Q 1
 ;
GENERR(TYPE) ; Generate error in ^TMP("DIERR",$J) for testing purposes
 S ^TMP("DIERR",$J,1)=999
 S ^TMP("DIERR",$J,1,"PARAM",0)=0
 S ^TMP("DIERR",$J,1,"PARAM","FILE")=$S(TYPE="D":344.3,1:344.31)
 S ^TMP("DIERR",$J,1,"TEXT",1)="Testing tool generated error for filing "_$S(TYPE="D":"Deposit",1:"EFT")
 S ^TMP("DIERR",$J,"E",999,1)=""
 Q
ERR ; Error trap for parsing message.
 N KEY3,RCCODE
 S RCCODE=$$EC^%ZOSV
 S RCCODE=$TR(RCCODE,"^","~") ; Replace '^' since it is used as delimiter in the return value.
 S ^TMP("RCD835",$J,"ERROR")="0^Error. Remote proceedure call crashed. "_RCCODE
 D ^%ZTER ; Log error to error trap
 L -^RCY(344.3,"ALOCK")
 S KEY3=$S($G(RCTDA):$G(RCTDA),1:$G(RCX))
 I KEY3 L -^RCY(344.3,KEY3,0)
 Q
 ;
MRGTMP(ARG) ; For DEV/TEST system only save the data to ^XTMP
 N J,SH
 S SH=+$TR($H,",",".")
 F J=1:1 Q:'$D(^ZZCJE("EFT835",SH))  S SH=SH+0.000001
 M ^ZZCJE("EFT835",SH)=ARG
 Q
LOGFAIL(RCID) ; Log lock failure to XTMP for tuning purposes
 N PURGE,RCDATE,RDID,RCKEY,RCKEY2,SH,TODAY
 I RCID="" Q
 S TODAY=$$DT^XLFDT()
 S RCKEY="RCDPE"_TODAY_"FHIRLOCK"
 I '$D(^XTMP(RCKEY,0)) D  ; Node does not exist so create
 . S PURGE=$$FMADD^XLFDT(TODAY,3) ; Allow ^XTMP to be purged after 3 days
 . S ^XTMP(RCKEY,0)=PURGE_"^"_TODAY
 S ^XTMP(RCKEY,RCID)=$G(^XTMP(RCKEY,RCID))+1 ; Keep count of failures for this ID
 Q
