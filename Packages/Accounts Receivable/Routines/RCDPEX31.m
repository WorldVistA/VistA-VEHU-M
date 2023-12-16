RCDPEX31 ;ALB/TMK - ELECTRONIC EOB EXCEPTION PROCESSING - FILE 344.4 ;Jun 11, 2014@15:50:59
 ;;4.5;Accounts Receivable;**173,208,298,321,409**;Mar 20, 1995;Build 17
 ;Per VA Directive 6402, this routine should not be modified.
 ;
UPD ; Try to update the IB EOB file from exception in 344.41
 N RCDA,RCTDA,RCTDA1,RCWHY,Z,DA,DIE,DR
 D FULL^VALM1
 D SEL^RCDPEX3(.RCDA,1)
 S RCDA=$O(RCDA(0)) G:'RCDA UPDQ
 S RCTDA=+RCDA(RCDA),RCTDA1=+$P(RCDA(RCDA),U,2)
 I '$$LOCK(RCTDA,RCTDA1,0) G UPDQ
 I $P($G(^RCY(344.4,RCTDA,1,RCTDA1,0)),U,7)'=2 D  G UPDQ
 . W !,"EEOB cannot be filed in IB"_$S($P($G(^RCY(344.4,RCTDA,1,RCTDA1,0)),U,7)=1:" - the bill # is invalid",1:"")
 . D PAUSE^VALM1
 I RCTDA,RCTDA1 D UPDEOB^RCDPESR2(RCTDA_";"_RCTDA1,4)
 S Z=$P($G(^RCY(344.4,RCTDA,1,RCTDA1,0)),U,2)
 I Z D  ; Update file 344.41 record
 . S DA(1)=RCTDA,DA=RCTDA1,DR=".07///@;.13////1;.02////"_Z,DIE="^RCY(344.4,"_DA(1)_",1," D ^DIE
 W !,"EEOB DETAIL UPDATE ",$S(Z:"WAS SUCCESSFUL",1:"ENCOUNTERED ERRORS")
 S RCWHY(1)="Update IB with EEOB detail",RCWHY(2)="Update EEOB detail was "_$S('Z:"NOT",1:"")_" successful"
 D STORACT(RCTDA,RCTDA1,.RCWHY)
 D PAUSE^VALM1
 D BLD^RCDPEX2
 ;
UPDQ S VALMBCK="R"
 Q
 ;
 ; PRCA*4.5*409 Added entry point
REMEXC(ERA,REASON,NOMESS) ;EP  from RCDPEM2@RETN, RCP409
 ; Remove any existing Data Exception for  any EOBs of the specified ERA 
 ; Input:   ERA     - ERA to removed data exceptions from
 ;          REASON  - Reason ERA was removed from the worklist
 ;          NOMESS  - 1 to not display locked warning message, 0 otherwise
 ;                    optiona, defaults to 0
 N EOB,NOLOCK,RCDA,RCTDA,RCTDA1,XX,ZZ
 Q:ERA=""
 S:'$D(NOMESS) NOMESS=0
 S XX=ERA_"^^"_REASON
 S EOB=0,NOLOCK=0                               ; Assume we can lock all EOBs
 F  D  Q:'EOB
 . S EOB=$O(^RCY(344.4,ERA,1,EOB))
 . Q:'EOB
 . Q:$P(^RCY(344.4,ERA,1,EOB,0),"^",7)=""       ; EOB is not on the Data Exceptions list
 . S $P(XX,"^",2)=EOB
 . S RCDA(1)=ERA_"^"_EOB
 . S RCDA=$O(RCDA(""))
 . S RCTDA=+RCDA(RCDA),RCTDA1=$P(RCDA(RCDA),U,2)
 . I '$$LOCK(RCTDA,RCTDA1,1) S NOLOCK=1  Q      ; Couldn't lock EOB
 . D DEL2(RCTDA,RCTDA1,REASON)                  ; Remove data exception for EOB
 . L -^RCY(344.4,RCTDA,1,RCTDA1,0)              ; Unlock the EOB
 . K RCDA,RCDTA,RCDTA1
 ;
 I 'NOMESS,NOLOCK D  Q
 . W !!,*7,"Warning: Not all of the data exceptions could be removed."
 . W !,"Please manually remove any remaining data exceptions for this ERA."
 . D PAUSE^VALM1
 Q
 ;
DEL ; Delete exception conditions from EOB detail list - file 344.4
 N DIR,DA,DIE,DR,DTOUT,DUOUT,RCT,RCTDA,RCTDA1,X,Y,Z
 D FULL^VALM1
 D SEL^RCDPEX3(.RCDA,1)
 S RCDA=$O(RCDA(""))
 I RCDA="" D DELQ Q
 S RCTDA=+RCDA(RCDA),RCTDA1=$P(RCDA(RCDA),U,2)
 I '$$LOCK(RCTDA,RCTDA1,0) D DELQ Q
 W !
 S DIR(0)="YA"
 S DIR("A",1)="This action will mark this EEOB detail record so it no longer appears as an"
 S DIR("A",2)="exception.  A MailMan message will be sent to report this action."
 S DIR("A",3)=" "
 S DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE? ",DIR("B")="NO"
 D ^DIR K DIR
 I Y'=1 D DELQ Q
 ;
 S DIR(0)="FA;3:60"
 S DIR("A")="ENTER A REASON FOR THIS ACTION: "
 S DIR("?",1)="Enter the reason why this EEOB exception is being removed from the"
 S DIR("?")=" exception list (3-60 characters are REQUIRED)"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) D DELQ Q
 D DEL2(RCTDA,RCTDA1,Y)                         ; PRCA*4.5*409 added line
 W !,"A MailMan message has been sent to report this action.",!
 D PAUSE^VALM1
 D BLD^RCDPEX2
 D DELQ
 Q
 ;
DEL2(RCTDA,RCTDA1,REASON) ; Unflag the EOB as a data exception
 ; PRCA*4.5*409 This is a new method that was previously part of th DEL method above
 ;              It was broken out so that it could be called by new method REMEXC
 ;              to unflag a data exception without any messages to the screen or user input
 ; Input:   RCTDA   - ERA IEN of the EOB to be unflagged
 ;          RCTDA1  - IEN of the EOB to be unflagged
 ;          REASON  - Reason why the EOB was unflagged
 N DA,RC0,RC00,RCDIQ,RCDIQ1,RCE,RCT,RCWHY,RCWHYTXT,RCX,Z
 S RCWHY(1)="Removal of EEOB detail entry from the exception list"
 S RCWHY(2)="  Reason Entered: "_REASON,RCWHYTXT=REASON
 S RC0=$G(^RCY(344.4,RCTDA,0)),RC00=$G(^(1,RCTDA1,0))
 ;
 D GETS^DIQ(344.4,RCTDA_",","*","IEN","RCDIQ")
 D GETS^DIQ(344.41,RCTDA1_","_RCTDA_",","*","IEN","RCDIQ1")
 S RCE=0
 D TXT0(RCTDA,.RCDIQ,.RCX,.RCE)
 S RCE=RCE+1,RCX(RCE)="RAW MESSAGE DATA:"
 D TXT00(RCTDA,RCTDA1,.RCDIQ1,.RCX,.RCE)
 S DA=RCTDA1,DA(1)=RCTDA,DR=".07///@;.13////0",DIE="^RCY(344.4,"_DA(1)_",1,"
 D ^DIE
 D STORACT(RCTDA,RCTDA1,.RCWHY)
 ;
 ; Removed the sending of mailman message about the removed data exception
 ; since prior to a just made bug fix (see SENDMSG^XMXAPI line below) no
 ; mailman messages were being sent and eBusiness decided not to fix the bug.
 Q                                              ; PRCA*4.5*409 Added line
 ;
 S RCT(1)="The electronic EEOB detail for Trace #: "
 S RCT(1)=RCT(1)_$P(RC0,U,2)_" and Seq #"
 S RCT(1)=RCT(1)_$P(RC00,U)
 S RCT(2)=" is no longer flagged for an exception condition"
 S RCT(3)="PAYMENT FROM: "_$P(RC0,U,6)_" on "_$$FMTE^XLFDT($P(RC0,U,4),2)
 S RCT(4)=" "
 S RCT(5)="REASON: "_RCWHYTXT
 S RCT(6)="ACTION PERFORMED BY: "_$P($G(^VA(200,+$G(DUZ),0)),U)_"   "_$$FMTE^XLFDT($$NOW^XLFDT,2)
 S RCT(7)=" ",RCE=+$O(RCT(""),-1)
 S Z=0
 F  S Z=$O(RCX(Z)) Q:'Z  S RCE=RCE+1,RCT(RCE)=RCX(Z)
 S RCE=RCE+1,RCT(RCE)=" "
 D  ; send MailMan message
 . N XMBODY,XMINSTR,XMSUBJ,XMZ
 . S XMSUBJ="EDI LBOX EEOB DETAIL EXCEPTION REMOVED"
 . S XMBODY="RCT",XMTO("G.RCDPE PAYMENTS")=""
 . S XMTO(DUZ)="",XMINSTR("FROM")="POSTMASTER"
 . D SENDMSG^XMXAPI(DUZ,XMSUBJ,XMBODY,.XMTO,.XMINSTR,.XMZ)  ;PRCA*4.5*409 Changed .5, to DUZ,
 Q
 ;
DELQ ; Unlock EOB (if locked) and refresh the listman screen
 I $G(RCTDA),$G(RCTDA1) L -^RCY(344.4,RCTDA,1,RCTDA1,0)
 S VALMBCK="R"
 Q
 ;
TXT0(RCTDA,RCDIQ,RCXM1,RC) ; Append 0-node captioned data to array RCXM1
 ; which is then used to populate the body of a mailman message which 
 ; contains the detail of which EOB was unflagged
 ; Input:   RCTDA   - ERA IEN of the EOB that is being unflagged
 ;          RCDIQ   - Array of fields from ^RCY(344.4,RCTDA)
 ;          RCXM1   - Current Array of text
 ;          RC      - Current line counter for the RCXM1 array
 ; Output:  RCXM1   - Updated Array of text
 ;          RC      - Updated line counter for the RCXM1 array
 ;
 N DAT,LINE,Z,Z0,Z1
 S LINE="",RC=+$G(RC)
 S RC=RC+1,RCXM1(RC)="  **ERA SUMMARY DATA**"
 S Z=0 F  S Z=$O(RCDIQ(344.4,RCTDA_",",Z)) Q:'Z  D   ;prca*4.5*298  need to get additional fields for display
 . I $G(RCDIQ(344.4,RCTDA_",",Z,"E"))="" Q
 . S Z0=$$GET1^DID(344.4,Z,,"LABEL")
 . S DAT=Z0_": "_$G(RCDIQ(344.4,RCTDA_",",Z,"E"))
 . I $L(DAT)>39 S:$L(LINE) RC=RC+1,RCXM1(RC)=LINE S RC=RC+1,RCXM1(RC)=DAT,LINE="" Q
 . I $L(LINE) D  Q:LINE=""  ; Left side exists
 . . I $L(LINE)+$L(DAT)>75 S RC=RC+1,RCXM1(RC)=LINE,LINE=DAT Q
 . . S LINE=LINE_"  "_DAT,RC=RC+1,RCXM1(RC)=LINE,LINE=""
 . S LINE=$E(DAT_$J("",39),1,39)
 I $L(LINE) S RC=RC+1,RCXM1(RC)=LINE
 S:RC RC=RC+1,RCXM1(RC)=" "
 Q
 ;
TXT00(RCTDA,RCTDA1,RCDIQ1,RCXM1,RC) ; Extract 0-node data for file 344.41
 ; which is then used to populate the body of a mailman message which 
 ; contains the detail of which EOB was unflagged
 ; Input:   RCTDA   - ERA IEN of the EOB that is being unflagged
 ;          RCTDA1  - EOB IEN of the EOB that is being unflagged
 ;          RCDIQ1  - Array of fields from EOB subfile 344.4
 ;          RCXM1   - Current Array of text
 ;          RC      - Current line counter for the RCXM1 array
 ; Output:  RCXM1   - Updated Array of text
 ;          RC      - Updated line counter for the RCXM1 array
 ;
 N DAT,RCT,LINE,Z,Z0,Z1
 S LINE="",RC=+$G(RC)
 S RC=RC+1,RCXM1(RC)="  **EEOB DETAIL DATA**",RCT=RCTDA1_","_RCTDA_","
 S Z=0
 F  S Z=$O(RCDIQ1(344.41,RCT,Z)) Q:'Z  D            ;prca*4.5*298  need to get additional fields for display
 . I (Z'=.25),$G(RCDIQ1(344.41,RCT,Z,"E"))="" Q     ;prca*4.5*298  even if RECEIPT # (.25) is null, display the label
 . I (Z=1)!(Z=2) Q  ; Suppress display of RAW DATA and EXCEPTION LOG field - PRCA*4.5*321
 . S Z0=$$GET1^DID(344.41,Z,,"LABEL")
 . S DAT=Z0_": "_$G(RCDIQ1(344.41,RCT,Z,"E"))
 . ; PRCA*4.5*321 - END
 . I $L(DAT)>39 S:$L(LINE) RC=RC+1,RCXM1(RC)=LINE S RC=RC+1,RCXM1(RC)=DAT,LINE="" Q
 . I $L(LINE) D  Q:LINE=""  ; Left side exists
 . . I $L(LINE)+$L(DAT)>75 S RC=RC+1,RCXM1(RC)=LINE,LINE=DAT Q
 . . S LINE=LINE_"  "_DAT,RC=RC+1,RCXM1(RC)=LINE,LINE=""
 . S LINE=$E(DAT_$J("",39),1,39)
 I $L(LINE) S RC=RC+1,RCXM1(RC)=LINE
 S:RC RC=RC+1,RCXM1(RC)=" "
 Q
 ;
TXT2(RCTDA,RCTDA1,RCDIQ2,RCXM1,RC) ; Extract all data from subfile ^RCY(344.4,RCTDA,2,0)
 ; Input:   RCTDA   - ERA IEN of the EOB that is being unflagged
 ;          RCTDA1  - EOB IEN of the EOB that is being unflagged
 ;          RCDIQ2  - Array of fields from ^RCY(344.4,RCTDA,2,0)
 ;          RCXM1   - Current Array of text
 ;          RC      - Current line counter for the RCXM1 array
 ; Output:  RCXM1   - Updated Array of text
 ;          RC      - Updated line counter for the RCXM1 array
 ;
 N RCT,LINE,DAT,Z,Z0
 S LINE="",RC=+$G(RC)
 S RCT=RCTDA1_","_RCTDA_","
 S Z=0 F  S Z=$O(RCDIQ2(344.42,RCT,Z)) Q:'Z  D
 . I $G(RCDIQ2(344.42,RCT,Z,"E"))="" Q
 . S Z0=$$GET1^DID(344.42,Z,,"LABEL")
 . S DAT=Z0_": "_$G(RCDIQ2(344.42,RCT,Z,"E"))
 . I $L(DAT)>39 S:$L(LINE) RC=RC+1,RCXM1(RC)=LINE S RC=RC+1,RCXM1(RC)=DAT,LINE="" Q
 . I $L(LINE) D  Q:LINE=""  ; Left side exists
 .. I $L(LINE)+$L(DAT)>75 S RC=RC+1,RCXM1(RC)=LINE,LINE=DAT Q
 .. S LINE=LINE_"  "_DAT,RC=RC+1,RCXM1(RC)=LINE,LINE=""
 . S LINE=$E(DAT_$J("",39),1,39)
 I $L(LINE) S RC=RC+1,RCXM1(RC)=LINE
 S:RC RC=RC+1,RCXM1(RC)=" "
 Q
 ;
LOCK(RCTDA,RCTDA1,RCSHH) ; Attempt to lock file entry in file 344.41
 ; Return 1 if successful, 0 if not able to lock
 ; Input:   RCTDA   - ERA IEN of the EOB line being locked
 ;          RCTDA1  - EOB IEN of the EOB line being locked
 ;          RCSHH   - Optiona1, 1 if there should be no direct writes
 ;
 N OK
 S OK=1
 L +^RCY(344.4,RCTDA,1,RCTDA1,0):5
 I '$T D
 . I '$D(DIQUIET),'$G(RCSHH) D
 . . W !,*7,"Another user is editing this entry ... please try again later"
 . . D PAUSE^VALM1
 . S OK=0
 Q OK
 ;
STORACT(RCTDA,RCTDA1,RCWHY) ; Store the detail for the action taken for
 ; the exception record at ^RCY(344.4,RCTDA,1,RCTDA,0)
 ; Input:   RCTDA   - ERA IEN of the EOB line being locked
 ;          RCTDA1  - EOB IEN of the EOB line being locked 
 ;          RCWHY(#)- Lines containing the reason/explanation for the action
 ;          RCWHY(1)- Should contain the description of the action taken
 ;                    It will be appended to the first line of the message after
 ;                    the date and user who made the change.
 ;
 N RC,RCDA,RCTXT,Z
 S RCDA(1)=RCTDA,RCDA=RCTDA1
 S RCTXT(1)=$$FMTE^XLFDT($$NOW^XLFDT(),2)_" "_$P($G(^VA(200,+DUZ,0)),U)_" "_$G(RCWHY(1))
 S (RC,Z)=1
 F  S Z=$O(RCWHY(Z)) Q:'Z  S RC=RC+1,RCTXT(RC)=" "_RCWHY(Z)
 D WP^DIE(344.41,$$IENS^DILF(.RCDA),2,"A","RCTXT")
 Q
 ;
