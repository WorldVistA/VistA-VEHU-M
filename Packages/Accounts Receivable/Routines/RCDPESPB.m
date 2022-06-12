RCDPESPB ;ALB/SAB, OI&T/hrubovcak - ePayment Lockbox Site Parameters Definition - Files 344.71 ;29 Jan 2019 18:00:14
 ;;4.5;Accounts Receivable;**345**;Mar 20, 1995;Build 34
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; code moved from RCDPESP5, 14 January 2019
 Q
 ;
GETCARC() ; function, Retrieve the next CARC code to enable/disable
 ; Returns: CARC IEN or, -1 - User '^' out, or 0 - User didn't select a CARC
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("?")="Enter a CARC code to enable/disable or Q to Quit."
 S DIR(0)="FAO"
 S DIR("??")="^D LIST^RCDPCRR(345)"
 S DIR("A")="CARC: "
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 I Y="" Q 0
 Q Y
 ;
GETAMT(RCARCTYP) ; Ask user the maximum amount to allow for auto-decrease
 ; PRCA4*5*345 - Added RCARCTYP
 ; Input:   RCARCTYP   - 0 - Medical, 1 - Pharmacy
 ; BEGIN PRCA*4.5*326
 N DA,DIR,DIRUT,DIROUT,DTOUT,DUOUT,RCMAX,X,Y
 S RCMAX=+$$GET1^DIQ(344.61,"1,",$S(RCARCTYP=0:.05,1:1.04)) ; PRCA*4.5*345 different RCMAX for pharmacy
 S DIR("?")="Enter the maximum amount the CARC can be auto-decreased between $1 and $"_RCMAX
 S DIR(0)="NA^1:"_RCMAX_":0"
 ; PRCA4*5*345 - Added X in next 2 lines
 S X=$S(RCARCTYP=0:"MEDICAL",1:"PHARMACY")
 S DIR("A")="MAXIMUM DOLLAR AMOUNT TO AUTO-DECREASE PER "_X_" CLAIM (1-"_RCMAX_"): "
 ; END PRCA*4.5*326
 D ^DIR
 K DIR
 I $G(DUOUT) S Y=-1
 Q Y
 ;
CHECK(RCMAX,RCPAID,RCDSP,RCCNT,RCARCTYP) ; Display/Reset any CARC maximum values which exceed upper limit
 ; PRCA*4.5*345 - Added RCARCTYP
 ; Input:   RCMAX   - Maximum allowed $ decrease per claim (from #344.61, #.05)
 ;          RCPAID  - 1 - CARCs for paid claims, 0 - CARCs for NO-PAY claims
 ;          RCDSP   - 1 - Display only, 0 - Update only
 ;          RCCNT   - 1 - Cumulative count of pay and no-pay records found
 ;          RCARCTYP   - 0 - Medical CARCs, 1 - Rx CARCS
 ; Output:  Updates #344.62 - RCDPE CARC-RARC AUTO DEC
 ;          Updates #344.7 - RCDPE PARAMETER AUDIT
 ;
 N RCACT,RCAMT,RCARR,RCCIEN,RCCODE,RCCT,RCDESC,RCFLD,RCFLDA,RCI,RCSTAT,RCSUB,RCTXT
 ;
 ; Max Amount field PRCA*4.5*345 - Added checks for pharmacy
 ;  *future build* add check for Tricare
 D:RCPAID
 . I RCARCTYP=0 S RCFLDA=.06 Q  ;(#.06) CARC DECREASE AMOUNT [6N]
 . S RCARCTYP=1 S RCFLDA=2.05  ;(#2.05) PHARM W. PAYMNTS CARC DEC AMNT [5N]
 I 'RCPAID,RCARCTYP=0 S RCFLDA=.12
 ;
 ; Auto-decrease Y/N field PRCA*4.5*345 - Added checks for Pharmacy
 D:RCPAID
 . I RCARCTYP=0 S RCFLD=.02 Q  ;(#.02) CARC AUTO DECREASE [2S]
 . I RCARCTYP=1 S RCFLD=2.01  ;(#2.01) CARC PHARM AUTO DECREASE [1S]
 I 'RCPAID,RCARCTYP=0 S RCFLD=.08  ;(#.08) CARC AUTO DECREASE NO-PAY [1S]
 ;
 ; Search for entries that need reducing
 S RCI=0,RCARR=0
 F  S RCI=$O(^RCY(344.62,RCI)) Q:'RCI  D
 . S RCACT=$$GET1^DIQ(344.62,RCI_",",RCFLD,"I")  ; Check if this is an active code
 . Q:'RCACT
 . S RCAMT=$$GET1^DIQ(344.62,RCI_",",RCFLDA)  ; Maximum amount for CARC
 . Q:RCAMT'>RCMAX  ; Check if limit exceeded
 . ; Save CARC  for reset and/or display
 . S RCARR=RCARR+1,RCCNT=RCCNT+1,RCARR(RCARR)=RCI_U_RCAMT
 Q:RCARR=0
 ;
 I RCDSP=1 D
 . S RCTXT=$S('RCPAID:"NO-PAY ",1:"")
 . W !!,"Warning:"
 . W !," The following "_RCTXT_"CARC codes' max. amt will be changed to the new limit $"_RCMAX
 S RCSUB=0
 F  S RCSUB=$O(RCARR(RCSUB)) Q:'RCSUB  D
 . S RCI=$P(RCARR(RCSUB),U)
 . S RCAMT=$P(RCARR(RCSUB),U,2)
 . ; Display line
 . I RCDSP D
 ..  S RCCODE=$$GET1^DIQ(344.62,RCI_",",.01)
 ..  S RCCIEN=$O(^RC(345,"B",RCCODE,""))
 ..  S RCDESC=$G(^RC(345,RCCIEN,1,1,0))
 ..  I $L(RCDESC)>50 S RCDESC=$E(RCDESC,1,50)_" ..."
 ..  W !,"  "_RCCODE,?9,$E(RCDESC,1,55),?63,$J(RCAMT,10,0)
 . ; Reset CARC to top limit
 . I 'RCDSP D
 ..  N RCAUDARY,RCSTAT,RCTXT
 ..  S RCSTAT=$$GET1^DIQ(344.62,RCI_",",.02) ; Leave status unchanged
 ..  S RCTXT="Max. Amt reduced to top limit"
 ..  ; Update #344.62 - RCDPE CARC-RARC AUTO DEC
 ..  D UPDDATA^RCDPESP5(RCI,RCSTAT,RCMAX,RCTXT,RCPAID,RCARCTYP) ; PRCA*4.5*345 - Added RCARCTYP
 ..  S RCTXT="Updated automatically - over maximum allowed"
 ..  ; Update #344.7 - RCDPE PARAMETER AUDIT
 ..  S RCAUDARY(1)="344.62^"_RCFLD_"^"_RCI_"^"_RCMAX_"^"_RCAMT_"^"_RCTXT
 ..  D AUDIT^RCDPESP(.RCAUDARY)
 Q
 ; end PRCA*4.5*326
XMSGBODY(TXT) ; create Mail message body, TXT passed by ref.
 ; TXT=line count
 N SITE K TXT
 S TXT=7,SITE=$$SITE^VASITE
 S TXT(1)=" "
 S TXT(2)="        Site: "_$P(SITE,U,2)
 S TXT(3)="   Station #: "_$P(SITE,U,3)
 S TXT(4)="      Domain: "_$G(^XMB("NETNAME"))
 S TXT(5)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"1PM")
 S TXT(6)="  Changed by: "_$P($G(^VA(200,DUZ,0)),U)_" (User #"_DUZ_")"
 S TXT(7)=" " Q
 ;
PADPRMPT(P) ; add space to prompt if needed
 Q:'$L($G(P)) ""  ; must have prompt
 S:'($E($RE(P))=" ") P=P_" " Q P
 ;
