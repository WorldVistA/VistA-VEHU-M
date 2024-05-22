RCDPTAR2 ;AITC/CJE - EFT TRANSACTION AUDIT REPORT (Continued) ;08/14/23
 ;;4.5;Accounts Receivable;**424**;Mar 20, 1995;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; PRCA*4.5*424 - Moved subroutine RC from ^RCDPTAR and added FMS doc ID search
RC(RCDATA) ; Lookup by Receipt Number
 ; Input:   RCDATA  - null on entry
 ;          RCDET - Environmental variable assumed to be set to "R" - Reciept or "F" - FMS Document
 ; Output:  RCDATA  - passed by refence - see subroutine EFTDATA for delimited list of fields
 ;
 N D,DIC,DTOUT,DUOUT,EFTIEN,ERAIEN,RCDTN,RCED,RCIEN,STOP,X,Y
 S STOP=0
RC2 ;
 W !
 S DIC="^RCY(344,"
 S DIC(0)=$S(RCDET="F":"QEAn",1:"QEAMn")
 S DIC("A")=$S(RCDET="F":"Select FMS DOCUMENT NUMBER: ",1:"Select RECEIPT: ")
 S DIC("W")="D DICW^RCDPUREC"
 S DIC("S")="I $$EDILBEV^RCDPEU($P($G(^(0)),U,4))"
 I RCDET="R" D ^DIC
 I RCDET="F" S D="ADOC" D IX^DIC
 I $D(DTOUT)!$D(DUOUT)!(Y=-1) S RCDATA=-1 Q
 ;
 ; Check if there is a pointer to the AR Deposit
 S RCDATA=""
 S RCIEN=$P($G(^RCY(344,+Y,0)),U,6)
 ;
 ; If there is, then get the EFT via AR Deposit and EDI LockBox files
 I RCIEN D
 . ; Get Ticket Number
 . S RCDTN=$P($G(^RCY(344.1,RCIEN,0)),U,1)
 . I RCDTN="" Q
 . ;
 . ; Get EDI Lockbox Deposit File
 . S RCED=$O(^RCY(344.3,"C",RCDTN,""))
 . I RCED="" Q
 . S RCDATA=$$EFT^RCDPTAR(RCED)
 ;
 ; If this AR Deposit record is not found, check if it is a receipt on the ERA
 I 'RCIEN D
 . S ERAIEN=$O(^RCY(344.4,"H",+Y,""))
 . I 'ERAIEN S ERAIEN=$O(^RCY(344.4,"ARCT",+Y,""))
 . I 'ERAIEN Q
 . S EFTIEN=$O(^RCY(344.31,"AERA",ERAIEN,""))
 . I EFTIEN S RCDATA=$$EFTDATA^RCDPTAR(EFTIEN)
 ;
 I RCDATA="" D  G RC2
 . W !!,"EFT NOT FOUND - please check Receipt"
 . D PAUSE^RCDPTAR
 ;
 Q:RCDATA=-1
 Q:RCDATA=""                                    ; No EFTs found
 D SHOWONE^RCDPTAR(.STOP)                       ; Display output
 Q:STOP
 G RC2
 Q
