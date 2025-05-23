IBNCPLOG ;BHAM ISC/SS - IB ECME EVNT REPORT ;3/5/08  14:02
 ;;2.0;INTEGRATED BILLING;**342,339,363,383,411,435,452,534,550,647**;21-MAR-94;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;store data related to the IB calls made by ECME package in the file #366.14
 ;input:
 ;.IBIBD - (by reference) IBD array with parameter sent to IB by ECME
 ;DFN patient's ien
 ;IBPROC - type of event. i.e. content of CALL such as BILL, REJECT and so on
 ;IBRESULT - (optional) result of the event processing, format: return_code^message
 ;IBJOB - (optional) job, default = $J
 ;IBDTTM - (optional) datetime, default = "NOW"
 ;IBUSR - (optional) user ID, default = DUZ
 ;output:
 ;none
LOG(IBIBD,DFN,IBPROC,IBRESULT,IBJOB,IBDTTM,IBUSR) ;Store the data
 N NDX,Z,REF,IBDATE,IBDTIEN,IBEVNIEN,IBIBDTYP,IBRETV,IBPTR
 S IBRESULT=$G(IBRESULT)
 ;
 I '$G(IBJOB) S IBJOB=$J
 I '$G(IBDTTM) S IBDTTM=$$NOW^XLFDT()
 I '$G(IBUSR) S IBUSR=+DUZ
 ;
 S IBDATE=DT
 S IBDTIEN=+$O(^IBCNR(366.14,"B",IBDATE,0))
 L +^IBCNR(366.14):30 E  Q
 I IBDTIEN=0 S IBDTIEN=+$$ADDDATE(IBDATE)
 ;create an event
 S IBEVNIEN=$$NEWEVENT(IBDTIEN,IBPROC)
 L -^IBCNR(366.14)
 I IBEVNIEN=0 W !,"New event creation Error : LOG^IBNCPLOG",! Q
 ;
 I +$$FILLFLDS^IBNCPUT1(366.141,".03",IBEVNIEN_","_IBDTIEN,DFN) ;DFN
 I +$$FILLFLDS^IBNCPUT1(366.141,".04",IBEVNIEN_","_IBDTIEN,IBJOB) ;JOB
 I +$$FILLFLDS^IBNCPUT1(366.141,".05",IBEVNIEN_","_IBDTIEN,IBDTTM) ;DATETIME
 I +$$FILLFLDS^IBNCPUT1(366.141,".06",IBEVNIEN_","_IBDTIEN,DUZ) ;USER
 I IBRESULT'="" D
 . S IBRETV=+$$FILLFLDS^IBNCPUT1(366.141,".07",IBEVNIEN_","_IBDTIEN,+IBRESULT) ;RESULT
 . S IBRETV=+$$FILLFLDS^IBNCPUT1(366.141,".08",IBEVNIEN_","_IBDTIEN,$P(IBRESULT,U,2)) ;RESULT MESSAGE
 . I IBPROC="BILLABLE STATUS CHECK",$P(IBRESULT,U,2)]"" D
 .. S IBPTR=$$GETREAS($P(IBRESULT,U,2))
 .. I IBPTR S IBRETV=+$$FILLFLDS^IBNCPUT1(366.141,".02",IBEVNIEN_","_IBDTIEN,IBPTR) ; Non-Billable Status Reason
 . I $P(IBRESULT,U,3)'="" S IBRETV=+$$FILLFLDS^IBNCPUT1(366.141,"7.05",IBEVNIEN_","_IBDTIEN,$P(IBRESULT,U,3)) ; Eligibility from IB billing determination (IB*2*452)
 . Q
 ;
 ;store IBIBD array
 S IBIBDTYP=""
 F  S IBIBDTYP=$O(IBIBD(IBIBDTYP)) Q:IBIBDTYP=""  D
 . D IBD(IBDTIEN,IBEVNIEN,IBIBDTYP,$G(IBIBD(IBIBDTYP)),.IBIBD)
 ;store "INS" node of IBIBD array
 I $D(IBIBD("INS")) I $$INS(.IBIBD,IBDTIEN,IBEVNIEN)
 Q
 ;
 ;store IBD array data
 ;IBDTIEN -  ien on top [DATE] level
 ;IBRECNO - ien in [EVENTS] multiple
 ;IBIBDTYP - type subscript in IBD array (BILL, PAID, RESPONSE, etc)
 ;IBVAL - value to store
 ;IBIBD - array with data passed by reference (for efficiency)
IBD(IBDTIEN,IBRECNO,IBIBDTYP,IBVAL,IBIBD) ;
 N IBFLDNO
 ;W !," - ",IBRECNO," ",IBIBDTYP," = ",IBVAL
 ;free text like "WEBMD: PAID"
 I IBIBDTYP="AUTH #" S IBFLDNO=".11",IBVAL=$E(IBVAL,1,30) G EDITIBD
 ;free text like "0504597;3051229"
 I IBIBDTYP="BCID" S IBFLDNO=".12" G EDITIBD
 ;7 or 12 digit ECME number - identifier (stored as a text - might have leading zeroes)
 I IBIBDTYP="CLAIMID" S IBFLDNO=".13" G EDITIBD
 ;pointer to file #2
 I IBIBDTYP="DFN" S IBFLDNO=".14" G EDITIBD
 ;pointer to file #40.8
 I IBIBDTYP="DIVISION" S IBFLDNO=".15" G EDITIBD
 ;free text
 I IBIBDTYP="RESPONSE" S IBFLDNO=".16",IBVAL=$E(IBVAL,1,20) G EDITIBD
 ;free text
 I IBIBDTYP="REVERSAL REASON" S IBFLDNO=".17",IBVAL=$E(IBVAL,1,40) G EDITIBD
 ;1 digit number
 I IBIBDTYP="RTS-DEL" S IBFLDNO=".18" G EDITIBD
 ;free text
 I IBIBDTYP="STATUS" S IBFLDNO=".19",IBVAL=$E(IBVAL,1,20) G EDITIBD
 ;Prescription number as a text, might have alpha characters (external value, this is not IEN)
 I IBIBDTYP="RX NO" S IBFLDNO=".202",IBVAL=$E(IBVAL,1,20) G EDITIBD
 ;0 - original, 1,2,3,... - refill number
 I IBIBDTYP="FILL NUMBER" S IBFLDNO=".203" G EDITIBD
 ;internal identifier number for a DRUG
 I IBIBDTYP="DRUG" S IBFLDNO=".204" G EDITIBD
 I IBIBDTYP="NDC" S IBFLDNO=".205" G EDITIBD
 I IBIBDTYP="DOS" S IBFLDNO=".206" G EDITIBD
 I IBIBDTYP="RELEASE DATE" S IBFLDNO=".207" G EDITIBD
 I IBIBDTYP="QTY" S IBFLDNO=".208" G EDITIBD
 I IBIBDTYP="UNITS" S IBFLDNO=".213" G EDITIBD
 I IBIBDTYP="NCPDP QTY" S IBFLDNO=".214" G EDITIBD
 I IBIBDTYP="NCPDP UNITS" S IBFLDNO=".215" G EDITIBD
 I IBIBDTYP="DAYS SUPPLY" S IBFLDNO=".209" G EDITIBD
 I IBIBDTYP="DEA" S IBFLDNO=".21" G EDITIBD
 I IBIBDTYP="FILLED BY" S IBFLDNO=".211" G EDITIBD
 I IBIBDTYP="COPAY" S IBFLDNO=".311" G EDITIBD
 I IBIBDTYP="ING COST PAID" S IBFLDNO=".312" G EDITIBD
 I IBIBDTYP="DISP FEE PAID" S IBFLDNO=".313" G EDITIBD
 I IBIBDTYP="PAT RESP" S IBFLDNO=".314" G EDITIBD
 ; for environmental indicators:
 ; if IBIBD("SC/EI OVR")=1 - the user overrides any answers (3)
 ; if $G(IBIBD("SC/EI NO ANSW")) contains the IBIBDTYP - this question was not answered (2)
 ; otherwise - use whatever in the IBVAL (0 - NO, 1 -YES)
 I IBIBDTYP="AO" S IBFLDNO=".401",IBVAL=$S($G(IBIBD("SC/EI OVR"))=1:3,(","_$G(IBIBD("SC/EI NO ANSW"))_",")[(","_IBIBDTYP_","):2,1:IBVAL) G EDITIBD
 I IBIBDTYP="CV" S IBFLDNO=".402",IBVAL=$S($G(IBIBD("SC/EI OVR"))=1:3,(","_$G(IBIBD("SC/EI NO ANSW"))_",")[(","_IBIBDTYP_","):2,1:IBVAL) G EDITIBD
 I IBIBDTYP="SWA" S IBFLDNO=".403",IBVAL=$S($G(IBIBD("SC/EI OVR"))=1:3,(","_$G(IBIBD("SC/EI NO ANSW"))_",")[(","_IBIBDTYP_","):2,1:IBVAL) G EDITIBD
 I IBIBDTYP="IR" S IBFLDNO=".404",IBVAL=$S($G(IBIBD("SC/EI OVR"))=1:3,(","_$G(IBIBD("SC/EI NO ANSW"))_",")[(","_IBIBDTYP_","):2,1:IBVAL) G EDITIBD
 I IBIBDTYP="MST" S IBFLDNO=".405",IBVAL=$S($G(IBIBD("SC/EI OVR"))=1:3,(","_$G(IBIBD("SC/EI NO ANSW"))_",")[(","_IBIBDTYP_","):2,1:IBVAL) G EDITIBD
 I IBIBDTYP="HNC" S IBFLDNO=".406",IBVAL=$S($G(IBIBD("SC/EI OVR"))=1:3,(","_$G(IBIBD("SC/EI NO ANSW"))_",")[(","_IBIBDTYP_","):2,1:IBVAL) G EDITIBD
 I IBIBDTYP="SC" S IBFLDNO=".407",IBVAL=$S($G(IBIBD("SC/EI OVR"))=1:3,(","_$G(IBIBD("SC/EI NO ANSW"))_",")[(","_IBIBDTYP_","):2,1:IBVAL) G EDITIBD
 I IBIBDTYP="SHAD" S IBFLDNO=".408",IBVAL=$S($G(IBIBD("SC/EI OVR"))=1:3,(","_$G(IBIBD("SC/EI NO ANSW"))_",")[(","_IBIBDTYP_","):2,1:IBVAL) G EDITIBD
 I IBIBDTYP="ACT DTY OVR" S IBFLDNO=".409" G EDITIBD
 I IBIBDTYP="BILL" S IBFLDNO=".301" G EDITIBD
 I IBIBDTYP="BILLED" S IBFLDNO=".302" G EDITIBD
 I IBIBDTYP="PLAN" S IBFLDNO=".303" G EDITIBD
 I IBIBDTYP="COST" S IBFLDNO=".304" G EDITIBD
 I IBIBDTYP="PAID" S IBFLDNO=".305" G EDITIBD
 I IBIBDTYP="CLOSE COMMENT" S IBFLDNO=".306" G EDITIBD
 I IBIBDTYP="REOPEN COMMENT" S IBFLDNO=".306" G EDITIBD
 I IBIBDTYP="CLOSE REASON" S IBFLDNO=".307" G EDITIBD
 I IBIBDTYP="DROP TO PAPER" S IBFLDNO=".308" G EDITIBD
 I IBIBDTYP="RELEASE COPAY" S IBFLDNO=".309" G EDITIBD
 I IBIBDTYP="USER" S IBFLDNO=".31" G EDITIBD
 I IBIBDTYP="PRESCRIPTION" S IBFLDNO=".201" G EDITIBD
 I IBIBDTYP="IEN" S IBFLDNO=".212" G EDITIBD
 I IBIBDTYP="EPHARM" S IBFLDNO=".09" G EDITIBD
 I IBIBDTYP="RXCOB" S IBFLDNO="7.01" G EDITIBD
 I IBIBDTYP="PRIMARY BILL" S IBFLDNO="7.02" G EDITIBD
 I IBIBDTYP="PRIOR PAYMENT" S IBFLDNO="7.03" G EDITIBD
 I IBIBDTYP="RTYPE" S IBFLDNO="7.04" G EDITIBD
 I IBIBDTYP="DRUG-BILLABLE" S IBFLDNO=7.06 G EDITIBD
 I IBIBDTYP="DRUG-BILLABLE TRICARE" S IBFLDNO=7.07 G EDITIBD
 I IBIBDTYP="DRUG-BILLABLE CHAMPVA" S IBFLDNO=7.08 G EDITIBD
 I IBIBDTYP="DRUG-SENSITIVE DX" S IBFLDNO=7.09 G EDITIBD
 Q 0
EDITIBD ;
 Q +$$FILLFLDS^IBNCPUT1(366.141,IBFLDNO,IBRECNO_","_IBDTIEN,IBVAL)
 ;------
 ;to store IBD("INS") array data
 ;input:
 ;IBDARR - IBD array by reference
 ;IBDTIEN -  ien on top [DATE] level
 ;IBRECNO - ien in [EVENTS] multiple
 ;output:
 ; record number if success
 ; 0 if failure
INS(IBDARR,IBDTIEN,IBRECNO) ;
 N IBSET1,IBSET2,IBSET3,IBFLDNO,IBINSNO,RECNO,IBVAL
 S IBINSNO=0
 ; Only create entry for first insurance found. BNT 07/07/2010
 F  S IBINSNO=$O(IBDARR("INS",IBINSNO)) Q:+IBINSNO=0  D  Q:$D(RECNO)
 . S IBSET1=$G(IBDARR("INS",IBINSNO,1))
 . S IBSET2=$G(IBDARR("INS",IBINSNO,2))
 . S IBSET3=$G(IBDARR("INS",IBINSNO,3))
 . S RECNO=$$ADDINS(IBDTIEN,IBRECNO)
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.02,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,1))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.03,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,2))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.04,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,3))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.05,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,4))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.06,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,5))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.07,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,6))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.08,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,7))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.09,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,20))
 . ;
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.101,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,8))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.102,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,9))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.103,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,10))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.104,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,11))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.105,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,12))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.106,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,13))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.107,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET1,U,14))
 . ;
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.201,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET2,U,1))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.202,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET2,U,2))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.203,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET2,U,3))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.204,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET2,U,4))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.205,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET2,U,5))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.206,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET2,U,6))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.207,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET2,U,7))
 . ;
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.301,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET3,U,1))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.302,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET3,U,2))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.303,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET3,U,3))
 . I +$$FILLFLDS^IBNCPUT1(366.1412,.304,RECNO_","_IBRECNO_","_IBDTIEN,$P(IBSET3,U,7))
 . Q
 ;
 Q RECNO
 ;create top level entry in #366.14
 ;input:
 ; IBDATE - date in FileMan format
 ;output
 ; returns ien created
ADDDATE(IBDATE) ;
 N IBIEN
 S IBIEN=+$O(^IBCNR(366.14,"B",IBDATE,0))
 I IBIEN>0 Q IBIEN
 I $$INSITEM^IBNCPUT1(366.14,"",IBDATE,"")
 Q +$O(^IBCNR(366.14,"B",IBDATE,0))
 ;
 ;create EVENT entry in #366.14
 ;input:
 ;IBIEN - ien on top [DATE] level
 ;EVNTTYPE event type (value for .01)
 ;returns ien for the event
 ;or 0 if failed
NEWEVENT(IBIEN,EVNTTYPE) ;
 N EVNTRECN
 S EVNTRECN=$$INSITEM^IBNCPUT1(366.141,IBIEN,$$EXT2INT^IBNCPUT1(EVNTTYPE),"","")
 I EVNTRECN>0 Q EVNTRECN
 Q 0
 ;
 ;add insurance node
 ;IBDTIEN - ien on top [DATE] level
 ;IBEVIEN - ien in [EVENTS] multiple
 ;returns :
 ; new ien in INSURANCE multiple
ADDINS(IBDTIEN,IBEVIEN) ;
 N IBX,IBX2
 F IBX=1:1:99999 I '$D(^IBCNR(366.14,IBDTIEN,1,IBEVIEN,5,IBX)) D  Q
 . S IBX2=$$INSITEM^IBNCPUT1(366.1412,IBEVIEN_","_IBDTIEN,IBX,IBX)
 Q +$O(^IBCNR(366.14,IBDTIEN,1,IBEVIEN,5,"B",IBX,0))
 ;
GETREAS(REASON) ;
 ; Get the pointer of the IB NCPDP NON-BILLABLE REASON file - Create the 
 ;   entry if needed.
 ;
 ; Input:
 ;   REASON: Non-billable reason text
 ; Output:
 ;   IEN of the IB NCPPD NON-BILLABLE REASON file
 ;
 I $G(REASON)="" Q ""
 N NBSTS,DIC,X,Y,DTOUT,DUOUT
 ;
 ; Make uppercase and less than 60 characters
 S REASON=$TR($E($$UP^XLFSTR(REASON),1,60),"^")
 I $E(REASON,$L(REASON))="." S REASON=$E(REASON,1,$L(REASON)-1)
 ;
 ; Check if it already exists.  If so, return the IEN
 S NBSTS=$O(^IBCNR(366.17,"B",REASON,""))
 I NBSTS Q NBSTS
 ;
 ; If it does not exist not, add to the dictionary
 S DIC="^IBCNR(366.17,",DIC(0)="F",X=REASON
 D FILE^DICN
 I Y=-1 Q ""
 Q +Y
