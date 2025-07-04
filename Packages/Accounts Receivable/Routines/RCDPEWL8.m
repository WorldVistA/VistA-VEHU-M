RCDPEWL8 ;ALB/TMK/PJH - EDI LOCKBOX WORKLIST ERA LEVEL ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**208,269,276,298,304,318,321,326,439**;Mar 20, 1995;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
FILESP ; Action that files the split lines
 ; Assumes RCDIR,RCLINE,RCSCR,RCSPLIT array defined
 N RCTOT,Z,RCZ0,RCZ1,DTOUT,DUOUT,DIR,X,Y,DIE,DA,DR,DIC,DD,DO,DLAYGO,RCZ,RCZZ,RCZT,VALBCK
 D FULL^VALM1
 I '$G(^TMP("RCDPE_EOB_SPLIT_OK",$J)) D  Q
 . S VALMBCK="R"
 . F Z=2,3 S RCTOT(Z)=$$TOT^RCDPEWL3(Z,.RCSPLIT)
 . S DIR(0)="EA"
 . S DIR("A",1)="TOTAL "_$S(+RCTOT(2)'=+$P(RCDIR,U,2):"PAYMENTS",1:"ADJUSTMENTS")_$S(+RCTOT(3)=+$P(RCDIR,U,3):"",+RCTOT(2)'=+$P(RCDIR,U,2):" AND ADJUSTMENTS",1:"")_" DO NOT MATCH THE ORIGINAL AMOUNT(s):"
 . S DIR("A",2)=$E("  ORIG PAY AMT: "_$J(+$P(RCDIR,U,2),"",2)_$J("",35),1,35)_" ORIG ADJ AMT: "_$J(+$P(RCDIR,U,3),"",2)
 . S DIR("A",3)=$E("   AMT ENTERED: "_$J(+RCTOT(2),"",2)_$J("",35),1,35)_"  AMT ENTERED: "_$J(+RCTOT(3),"",2)
 . S DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR
 S DA(1)=RCSCR
 S RCZ0=+$P(RCLINE,U,2),RCZZ=+$G(^RCY(344.49,DA(1),1,RCZ0,0)),RCZZ(1)=""
 S RCZ=+$O(RCSPLIT(0))
 ;
 ;Option to move/copy EOB
 I RCZ D  Q:$G(VALMBCK)="Q"
 .;;Move/Copy removed 10/19/11-now in receipt creation +136^RCDPEM
 .;;Q:$$UPDWL^RCDPEM5($P(RCDIR,U),.RCSPLIT,RCERA)
 .;;User abort
 .;;K ^TMP($J,"RCDPE_SPLIT_FILE") S VALMBCK="Q"
 ;
 I RCZ D
 . S DIE="^RCY(344.49,"_DA(1)_",1,",DA=RCZ0,RCZT=$P(RCSPLIT(RCZ),U,2)+$P(RCSPLIT(RCZ),U,3)
 . S DR=".02////"_$P(RCSPLIT(RCZ),U)_";.05////"_$J(+$P(RCSPLIT(RCZ),U,2),"",2)_";.06////"_$J(+RCZT,"",2)_";.08////"_$J($P(RCSPLIT(RCZ),U,3),"",2)
 . S DR=DR_";.07///"_$S($P(RCSPLIT(RCZ),U,5):"/"_$P(RCSPLIT(RCZ),U,5),1:"@")_";.03////"_$S(RCZT'<0:$J(+RCZT,"",2),1:"0.00")_$S($P(RCSPLIT(RCZ),U,6)'="":";.1///"_$S($P(RCSPLIT(RCZ),U,6)'="@":"/^S X=$P(RCSPLIT(RCZ),U,6)",1:"@"),1:"")
 . D ^DIE,UPD^RCDPEWL3(DA(1),DA)
 . I $P(RCDIR,U,3) D
 .. N DA
 .. S DA(2)=RCSCR,DA(1)=RCZ0,DA=1,DIE="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",1,"
 .. S RCZZ(1)=$G(^RCY(344.49,DA(2),1,DA(1),1,1,0))
 .. S DR=".03////"_$J(+$P(RCSPLIT(RCZ),U,3),"",2)_$S($P(RCSPLIT(RCZ),U,4)'="":".09////"_$P(RCSPLIT(RCZ),U,4),1:"")
 .. D ^DIE
 F  S RCZ=$O(RCSPLIT(RCZ)) Q:'RCZ  D
 . S DIC(0)="L",DLAYGO=344.491,DIC="^RCY(344.49,"_DA(1)_",1,",X=+$O(^RCY(344.49,RCSCR,1,"B",RCZZ\1+.999),-1)+.001
 . S DIC("DR")=".02////"_$P(RCSPLIT(RCZ),U)_";.05////"_$J(+$P(RCSPLIT(RCZ),U,2),"",2)_";.08////"_$J(+$P(RCSPLIT(RCZ),U,3),"",2)_";.06////"_$J($P(RCSPLIT(RCZ),U,2)+$P(RCSPLIT(RCZ),U,3),"",2)
 . I $P(RCSPLIT(RCZ),U,6)'="" S DIC("DR")=DIC("DR")_";.1///"_$S($P(RCSPLIT(RCZ),U,6)'="@":"/^S X=$P(RCSPLIT(RCZ),U,6)",1:"@")
 . I $P(RCSPLIT(RCZ),U,5) S DIC("DR")=DIC("DR")_";.07////"_$P(RCSPLIT(RCZ),U,5)
 . K DD,DO D FILE^DICN K DIC,DLAYGO,DD,DO
 . S RCZ1=+Y
 . I Y D UPD^RCDPEWL3(RCSCR,RCZ1)
 . I Y,$P(RCDIR,U,3) D
 .. N DA
 .. S DA(2)=RCSCR,DA(1)=RCZ1,X=1,DIC(0)="L",DIC="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",1,"
 .. S DIC("DR")=".02////"_$P(RCZZ(1),U,2)_";.03////"_$J(+$P(RCSPLIT(RCZ),U,3),"",2)_$S($P(RCSPLIT(RCZ),U,4)'="":";.09////"_$P(RCSPLIT(RCZ),U,4),$P(RCZZ(1),U,9)'="":";.09////"_$P(RCZZ(1),U,9),1:"")
 .. F Z=4:1:8 I $P(RCZZ(1),U,Z)'="" S DIC("DR")=DIC("DR")_";"_(Z/100)_"////"_$P(RCZZ(1),U,Z)
 .. D FILE^DICN K DIC,DLAYGO,DD,DO
 K ^TMP($J,"RCDPE_SPLIT_FILE")
 S VALMBCK="Q"
 Q
 ;
SELBAT(RCERA,RCQUIT) ; Select a batch
 ; If batch is selected, global ^TMP("RCBATCH_SELECTED",$J) is set = 
 ;   batch ien selected
 ; RCQUIT = 1 if selection not made
 ; prca*4.5*298 per requirements, keep code for creating/maintaining batches but remove from execution
 Q  ;prca*4.5*298
 N DA,DIC,DIE,DIR,DR,DTOUT,DUOUT,RCBAT,X,Y
 S RCQUIT=0
 S DA(1)=RCERA,DIC(0)="AEMQ",DIC="^RCY(344.49,"_DA(1)_",3,",DIC("S")="I '$P(^(0),U,5)" D ^DIC
 I Y'>0 S RCQUIT=1 Q
 S RCBAT=+Y
 L +^RCY(344.4,RCERA,0):5 I '$T S DIR("A",1)="ANOTHER USER HAS JUST ACCESSED THE ENTIRE ERA - TRY AGAIN LATER",DIR("A")="PRESS RETURN TO CONTINUE ",DIR(0)="EA" W ! D ^DIR K DIR S RCQUIT=1 Q
 L +^RCY(344.49,RCERA,3,RCBAT,0):5 I '$T!$P($G(^(0)),U,5) S DIR("A",1)="ANOTHER USER HAS JUST OPENED THIS BATCH - TRY AGAIN LATER",DIR("A")="PRESS RETURN TO CONTINUE ",DIR(0)=-"EA" W ! D ^DIR K DIR S RCQUIT=1 Q
 S DA=RCBAT,DA(1)=RCERA,DIE="^RCY(344.49,"_DA(1)_",3,",DR=".05////1" D ^DIE L -^RCY(344.49,RCERA,3,RCBAT,0)
 I $P($G(^RCY(344.49,RCERA,3,RCBAT,0)),U,3) D
 . S DIR(0)="EA",DIR("A",1)="** WARNING - THIS BATCH HAS BEEN FLAGGED AS READY TO POST",DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR
 S ^TMP("RCBATCH_SELECTED",$J)=RCBAT
 L -^RCY(344.4,RCERA,0)
 Q
 ;
SORT ; Select a new sort for the list of ERAs
 D FULL^VALM1
 N RCSORT,DUOUT,DTOUT,DIR,X,Y,RCS1,RCS2,RCORD
 S VALMBCK="R"
 S DIR("L",1)="  SELECT A FIRST LEVEL SORT",DIR("L",2)=" "
 S DIR("L",3)="    A  AMOUNT PAID      E  ERA PAID DATE"
 S DIR("L")="    P  PAYER NAME       D  DATE ERA RECEIVED"
 S DIR(0)="S^A:AMOUNT PAID;E:ERA PAID DATE;P:PAYER NAME;D:DATE ERA RECEIVED",DIR("B")=$P($P(DIR(0),"D:",2),";")
 W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) Q
 S RCS1=$S(Y="A":"AP",Y="E":"DP",Y="P":"PN",1:"DR")
 S RCORD=$$ORD(.RCS1)
 Q:'$D(RCS1)
 S $P(RCSORT,U)=(RCS1_";"_RCORD)
 K X
 S X(1)=$S(RCS1'="AP":"A:AMOUNT PAID",1:"E:ERA PAID DATE")
 S X(2)=$S(RCS1'="AP"&(RCS1'="DP"):"E:ERA PAID DATE",1:"P:PAYER NAME")
 S X(3)=$S(RCS1="DR":"P:PAYER NAME",1:"D:DATE ERA RECEIVED")
 S DIR(0)="S^N:NONE;"_X(1)_";"_X(2)_";"_X(3)
 S DIR("B")="NONE"
 S DIR("L",1)="  SELECT A SECOND LEVEL SORT",DIR("L",2)=" "
 S DIR("L",3)="    N  NONE"_$J("",13)_$P(X(1),":")_"  "_$P(X(1),":",2)
 S DIR("L")="    "_$E($P(X(2),":")_"  "_$P(X(2),":",2)_$J("",20),1,20)_$P(X(3),":")_"  "_$P(X(3),":",2)
 K X W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) Q
 S RCS2=$S(Y="N":"N",Y="A":"AP",Y="E":"DP",Y="P":"PN",1:"DR")
 S RCORD=$$ORD(.RCS2)
 Q:'$D(RCS2)
 S $P(RCSORT,U,2)=(RCS2_";"_RCORD)
 K ^TMP($J,"RCERA_LIST") D BLD^RCDPEWL7(RCSORT)
 Q
 ;
ORD(RCS) ; Select an order for the sorted field code in RCS
 ; Kill RCS if nothing selected, passed by reference
 ; Returns '-' if reverse order selected
 N DIR,X,Y,ORD,RCQUIT
 S RCQUIT=0,ORD=""
 I RCS="N" G ORDQ
 I RCS="PN" D  G ORDQ
 . S DIR(0)="SA^F:FIRST TO LAST;L:LAST TO FIRST"
 . S DIR("B")=$P($P(DIR(0),"F:",2),";")
 . S DIR("A")="  SORT (F)IRST TO LAST OR (L)AST TO FIRST?: "
 . D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT) S RCQUIT=1 Q
 . S ORD=$S(Y="F":"",1:"-")
 ;
 I RCS="AP" D  G ORDQ
 . S DIR("A")="  SORT (L)OWEST TO HIGHEST OR (H)IGHEST TO LOWEST?: "
 . S DIR(0)="SA^L:LOWEST TO HIGHEST;H:HIGHEST TO LOWEST"
 . S DIR("B")=$P($P(DIR(0),"L:",2),";")
 . D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT) S RCQUIT=1 Q
 . S ORD=$S(Y="L":"",1:"-")
 ;
 I RCS="DP"!(RCS="DR") D  G ORDQ
 . S DIR("A")="  SORT (E)ARLIEST TO LATEST OR (L)ATEST TO EARLIEST?: "
 . S DIR(0)="SA^E:EARLIEST TO LATEST;L:LATEST TO EARLIEST"
 . S DIR("B")=$P($P(DIR(0),"E:",2),";")
 . D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT) S RCQUIT=1 Q
 . S ORD=$S(Y="E":"",1:"-")
 ;
 ; Invalid sort code
 S RCQUIT=1
 ;
ORDQ I RCQUIT K RCS
 Q ORD
 ;
BATDSP ; Ask Display/Hide batch info on ERA list screen
 ; prca*4.5*298 per requirements, keep code for creating/maintaining batches but remove from execution
 Q  ;prca*4.5*298
 N DIR,DTOUT,DUOUT,RCZ,X,Y
 D FULL^VALM1
 S RCZ=+$G(^TMP("RCERA_PARAMS",$J,"BATCHON"))
 S DIR("A",1)="BATCH INFO DISPLAY IS CURRENTLY TURNED "_$S('RCZ:"OFF",1:"ON"),DIR("A")="DO YOU WANT TO TURN IT "_$S('RCZ:"ON",1:"OFF")_" NOW?: "
 S DIR(0)="YA",DIR("B")="YES" W ! D ^DIR K DIR
 S VALMBCK="R"
 Q:$D(DUOUT)!$D(DTOUT)!'Y
 S ^TMP("RCERA_PARAMS",$J,"BATCHON")=$S(RCZ:0,1:1)
 D BLD^RCDPEWL7($G(^TMP("RCERA_PARAMS",$J,"SORT")))
 Q
 ;
HASADJ(RCSCR,RCOK) ; Function=1 if WL entry has any adj not yet distributed
 ; RCSCR = ien of entry in file 344.49
 ; RCOK = if passed by reference, returns 1 if ANY postable lines exist
 N Z,Z0,RCSTOP
 S RCSTOP=0,RCOK=0
 S Z=0 F  S Z=$O(^RCY(344.49,RCSCR,1,Z)) Q:'Z  S Z0=$G(^(Z,0)) D  Q:RCSTOP
 . ;HIPAA 5010 - negative value now takes precedence over adjustment
 . I $P(Z0,U,6)>0!$O(^RCY(344.49,RCSCR,1,Z,1,0)) S RCOK=1
 . I $P(Z0,U,6)<0 S RCSTOP=1
 Q RCSTOP
 ;
VERIF ;EP - Protocol action - RCDPE EOB WORKLIST VERIFY
 ; Entrypoint to verification options
 N DIR,DTOUT,DUOUT,RCAUTO,RCQUIT,X,Y ; PRCA*4.5*326
 D FULL^VALM1
 ; PRCA*4.5*439 - Removed check on security key RCDPEPP
 ; BEGIN PRCA*4.5*326
 ;I $S($P($G(^RCY(344.4,RCSCR,4)),U,2)]"":1,1:0) D NOEDIT^RCDPEWLP G VERIFQ   ;prca*4.5*298  auto-posted ERAs cannot enter VERIFY action
 S RCAUTO=$$GET1^DIQ(344.4,RCSCR_",",4.02,"I") ; Autopost status
 ; If ERA is an auto-post allow report only
 I RCAUTO]"" D RPT1^RCDPEV0(RCERA) W !! Q
 ; END PRCA*4.5*326
 ;
 W !!!!
 S RCQUIT=0
 F  D  Q:RCQUIT
 . W !,"VERIFY EEOBs:",!,?10,"1",$J("",5),"MANUALLY MARK AS VERIFIED",!,?10,"2",$J("",5),"REPORT OF UNVERIFIED WITH DISCREPANCIES",!,?10,"3",$J("",5),"QUIT AND RETURN TO WORKLIST"
 . S DIR(0)="SAO^1:MANUAL VERIFICATION;2:REPORT UNVERIFIED DISCREPANCIES;3:QUIT"
 . S DIR("A")="Select Action: ",DIR("B")="QUIT" W ! D ^DIR K DIR
 . I Y=3!(Y="")!$D(DUOUT)!$D(DTOUT) S RCQUIT=1 Q
 . ;
 . I Y=1 D MVER^RCDPEV(RCERA) W !! Q
 . ;
 . I Y=2 D RPT^RCDPEV0(RCERA) W !! Q
 ;
VERIFQ S VALMBCK="R"
 Q
 ;
BATED ; Entry point to batch edit options
 ; prca*4.5*298  per requirements, keep code for creating/maintaining batches but remove from execution
 Q  ; prca*4.5*298
 N DA,DIC,DIR,DTOUT,DUOUT,RCQUIT,X,Y
 D FULL^VALM1
 ;
 W !!!!
 S RCQUIT=0
 I '$O(^RCY(344.49,RCERA,3,0)) W !,"***** THERE ARE CURRENTLY NO BATCHES DEFINED FOR THIS ERA *****",!
 ; No menu if entering from a batch level
 I $G(^TMP("RCBATCH_SELECTED",$J)) W !,"EDITING BATCH #"_+^TMP("RCBATCH_SELECTED",$J) D EDIT^RCDPEWLB(RCERA,+^TMP("RCBATCH_SELECTED",$J)) G BATEDQ
 F  D  Q:RCQUIT
 . I '$D(^XUSEC("PRCA ERA BATCH MAINT",DUZ)) D  Q
 .. S RCQUIT=1
 .. S DIR(0)="EA",DIR("A")="YOU DO NOT HAVE SECURITY ACCESS TO THIS ACTION - Press ENTER to continue: " W ! D ^DIR K DIR
 .;
 . W !,"BATCH MAINTENANCE:",!,?10,"1",$J("",5),"EDIT BATCH",!,?10,"2",$J("",5),"NEW BATCH ASSIGNMENT",!,?10,"3",$J("",5),"MARK ALL READY TO POST",!,?10,"4",$J("",5),"BATCH SUMMARY REPORT",!,?10,"5",$J("",5),"QUIT AND RETURN TO WORKLIST"
 . S DIR(0)="SAO^1:EDIT BATCH;2:NEW BATCHES;3:MARK ALL;4:BATCH SUMMARY;5:QUIT"
 . S DIR("A")="Select Action: ",DIR("B")="Quit" W ! D ^DIR K DIR
 . I Y="5"!(Y="")!$D(DUOUT)!$D(DTOUT) S RCQUIT=1 Q
 . ;
 . I Y=1 D  W !! Q
 .. I '$O(^RCY(344.49,RCERA,3,0)) D NOTSET^RCDPEWLC Q
 .. S DIR("B")="ONE",DIR(0)="SA^A:ALL;O:ONE",DIR("A")="EDIT(A)LL or (O)NE BATCH?: " W ! D ^DIR K DIR
 .. I $D(DTOUT)!$D(DUOUT) Q
 .. I Y="A" D EDITALL^RCDPEWLB(RCERA) Q
 .. S DA(1)=RCERA,DIC="^RCY(344.49,"_DA(1)_",3,",DIC(0)="AEMQ" D ^DIC
 .. Q:Y'>0
 .. D EDIT^RCDPEWLB(RCERA,+Y)
 . ;
 . I Y=2 D REBATCH^RCDPEWLB(RCERA) W !! Q
 . ;
 . I Y=3 D MARKALL^RCDPEWLB(RCERA) W !! Q
 . ;
 . I Y=4 D SUMRPT^RCDPEWLC(RCERA) W !! Q
 ;
BATEDQ S VALMBCK="R"
 Q
 ;
AUTOPOST(SOURCE) ;EP Protocol action - RCDPE EOB WORKLIST MARK FOR AUTO POST
 ; Input:
 ;   SOURCE
 ;      1:Called by Worklist (RCDPE WORKLIST ERA MARK FOR AUTO POST)
 ;      2:Called by Scratchpad (RCDPE WORKLIST EOB MARK FOR AUTO POST)
 ;   If SOURCE=2, RCSCR will be set to the IEN of 344.4
 ;
 D FULL^VALM1
 I '$D(^XUSEC("RCDPEPP",DUZ)) D  Q  ; PRCA*4.5*318 Added security key check
 . W !!,"This action can only be taken by users that have the RCDPEPP security key.",!
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 ; If called by Worklist (SOURCE=1), then ask which ERA
 ; If called by Scratchpad (SOURCE=2), ERA is already in variable RCSCR
 N RCERA
 I SOURCE=1 S RCERA=$$SEL^RCDPEWL7()
 I SOURCE=2 S RCERA=$G(RCSCR)
 I 'RCERA S VALMBCK="R" Q
 ;
 N AUTOPOST
 S AUTOPOST=$$AUTOCHK2^RCDPEAP1(RCERA,0) ; added parameter - PRCA*4.5*321
 I AUTOPOST D
 . D SETSTA^RCDPEAP(RCERA,0,"Worklist: Marked as Auto-Post Candidate")
 . W !,"ERA has been successfully Marked as an Auto-Post CANDIDATE"
 I 'AUTOPOST D
 . D AUDITLOG^RCDPEAP(RCERA,"","Worklist: Not Marked as Auto-Post Candidate-"_$P(AUTOPOST,U,2))
 . W !,"ERA was NOT Marked as an Auto-Post CANDIDATE - ",$P(AUTOPOST,U,2)
 ;
AUTOPSTQ ;
 K DIR
 S DIR(0)="E" D ^DIR
 S VALMBCK="R"
 Q
