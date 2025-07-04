RCDPEWL6 ;ALB/TMK/KML - ELECTRONIC EOB WORKLIST ACTIONS ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,208,222,276,298,303,318,326,439**;Mar 20, 1995;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
DISTADJ ;EP - Protocol action - RCDPE EOB WORKLIST DIST ADJ
 ; Distribute an adjustment that retracts a payment to other bill(s)
 ;
 ; Input - RCSCR - Scratchpad #344.49 IEN
 ;
 N RCDA,RCDA1,RCAMT,RCADJ,RCQUIT,Z,Z0,Z1,DIR,X,Y,CT,RCZ,RCZ1,RCZ2,RCADJOK,TOT,DTOUT,DUOUT
 N RCNONSP,RCACTIVE,RCZZ1,RCZZ2,RCADJSTR  ; prca276 - variables used to establish non-specific payment adjustments and AR BILL claim status (fix to negative claim balance issue)
 D FULL^VALM1
 I $S($P($G(^RCY(344.4,RCSCR,4)),U,2)]"":1,1:0) D NOEDIT^RCDPEWLP G DISTQ   ;prca*4.5*298  auto-posted ERAs cannot enter dISTRIBUTE ADJ AMTS action      
 I $G(RCSCR("NOEDIT")) D NOEDIT^RCDPEWL G DISTQ
 I $G(^TMP("RCBATCH_SELECTED",$J)) D NOBATCH^RCDPEWL G DISTQ
 ;
 S Z=0,RCADJOK="" F  S Z=$O(^TMP("RCDPE-EOB_WLDX",$J,Z)) Q:'Z  S Z1=+$P($G(^(Z)),U,2),Z0=$G(^RCY(344.49,RCSCR,1,Z1,0)) D
 . I $P(Z0,U)'["." S RCADJOK=($P(Z0,U,2)["**ADJ") Q
 . ; Following validation line removed - allow distribution to non-VA claims - PRCA*4.5*326
 . ;I '$P(Z0,U,7),'RCADJOK Q  ; Suspense item cannot be used to adjust
 . I $P(Z0,U,6)<0 S RCZ(Z)=$P(Z0,U,6)_U_Z1 Q
 . I $P(Z0,U,6)>0 D  Q
 .. N Q,ONHLD,IBA
 .. S ONHLD=0
 .. I $P(Z0,U,7) I $$IB^IBRUTL(+$P(Z0,U,7),1) S Q=0 F  S Q=$O(IBA(Q)) Q:'Q  I $P($G(^IB(+IBA(Q),0)),U,5)=8 S ONHLD=1 Q
 .. S RCZ1(+$P(Z0,U,6),Z)=Z1_U_ONHLD,RCZ2(Z)=Z1_U_$P(Z0,U,6)_U_ONHLD Q
 ;
 I $O(RCZ(0))="" D  G DISTQ
 . S DIR(0)="EA",DIR("A",1)="NO LINES EXIST NEEDING ADJUSTMENT DISTRIBUTION",DIR("A")="PRESS RETURN TO CONTINUE" W ! D ^DIR K DIR
 ;
 I $O(RCZ1(0))="" D  G DISTQ
 . S DIR(0)="EA",DIR("A",1)="NO VALID LINES EXIST ON THIS ERA WHERE A DISTRIBUTION CAN BE MADE",DIR("A",2)=$$WHAT(RCSCR),DIR("A")="PRESS RETURN TO CONTINUE" W ! D ^DIR K DIR
 ;
 S RCQUIT=0
 F  S DIR(0)="NA^1:9999:3",DIR("A")="SELECT A LINE THAT NEEDS AN ADJUSTMENT AMOUNT DISTRIBUTED: " D  Q:RCQUIT
 . S DIR("?",1)="THE FOLLOWING LINE(S) HAVE AN ADJUSTMENT THAT CAUSED A NEGATIVE NET PAYMENT.",DIR("?",2)="IN ORDER TO BALANCE THE RECEIPT AND THE DEPOSIT, THESE AMOUNTS WILL NEED TO",DIR("?",3)="  BE DISTRIBUTED TO OTHER LINE(S)",CT=3
 . S Z=0
 . F  S Z=$O(RCZ(Z)) Q:'Z  S CT=CT+1,DIR("?",CT)="  "_$J(Z,8)_"  "_$J($P(RCZ(Z),U),15,2)
 . S DIR("?")=" "
 . I $O(RCZ(0))=$O(RCZ(""),-1) S DIR("B")=$O(RCZ(0))
 . W ! D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT)!(Y="") S RCQUIT=1,RCDA="" Q
 . I '$D(^TMP("RCDPE-EOB_WLDX",$J,Y)) W !,"THIS LINE DOES NOT EXIST FOR THIS ERA" W ! Q
 . I '$D(RCZ(Y)) D  Q:Y=""
 .. I Y'[".",$D(RCZ(Y_".001")),$O(RCZ(Y+1),-1)=(Y_".001") S Y=Y_".001" Q
 .. W !,$S(Y["."!($O(RCZ(Y))\1'=(Y\1)):"THIS LINE DOESN'T NEED AN ADJUSTMENT DISTRIBUTION",1:"PLEASE ENTER THE ENTIRE LINE # (Such as: 1.001)") W !
 .. S Y=""
 . W !,"  LINE #: "_+Y_"  AMOUNT NEEDED TO DISTRIBUTE: "_$J(+RCZ(Y),"",2),!
 . ; RCDA = the ien of the line in file 344.491
 . ; RCDA(1) = the line #        RCDA(2) = the amount to be adjusted (+)
 . S RCDA=$P(RCZ(Y),U,2),RCDA(1)=Y,RCQUIT=1,RCDA(2)=-$P(RCZ(Y),U)
 ;
 G:$G(RCDA)="" DISTQ
 ;
 S RCQUIT=0
 ;
 ; PRCA*4.5*303 - May miss if multiple amounts are equal, changed calculation to use RCZ2 instead of RCZ1 
 ; Old code: S (TOT,Z)=0 F  S Z=$O(RCZ1(Z)) Q:'Z  S TOT=TOT+Z
 S (TOT,Z)=0 F  S Z=$O(RCZ2(Z)) Q:'Z  S TOT=TOT+$P(RCZ2(Z),U,2)
 I TOT<RCDA(2) D  G DISTQ
 . S DIR(0)="EA",DIR("A",1)="THE ERA DOES NOT HAVE ENOUGH VALID PAYMENTS TO OFFSET THIS DISTRIBUTION",DIR("A",2)=$$WHAT(RCSCR),DIR("A")="PRESS RETURN TO CONTINUE" W ! D ^DIR K DIR
 F  S DIR(0)="NA^1:9999:3",DIR("A")="SELECT A LINE TO DISTRIBUTE THE ADJUSTMENT AMOUNT TO: " D  Q:RCQUIT
 . S DIR("?",1)="THE FOLLOWING LINE(S) HAVE A NET PAYMENT THAT CAN BE USED TO OFFSET THE",DIR("?",2)="  NEGATIVE NET PAYMENT FOR LINE "_RCDA(1)_" ("_$J(+$P(RCZ(RCDA(1)),U),"",2)_"):",CT=2
 . S Z="" F  S Z=$O(RCZ1(Z),-1) Q:'Z  S Z0=0 F  S Z0=$O(RCZ1(Z,Z0)) Q:'Z0  S CT=CT+1,DIR("?",CT)="  "_$J(Z0,8)_"  "_$J(+Z,15,2)_$S($P(RCZ1(Z,Z0),U,2):" On hold exists",1:"")
 . S DIR("?")=" "
 . I $O(RCZ2(0))=$O(RCZ2(""),-1) S DIR("B")=$O(RCZ2(0))
 . W ! D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT)!(Y="") S RCQUIT=1,RCDA1="" Q
 . I '$D(^TMP("RCDPE-EOB_WLDX",$J,Y)) W !,"THIS LINE DOES NOT EXIST FOR THIS ERA" W ! Q
 . I '$D(RCZ2(Y)) D  Q:Y=""
 .. I Y'[".",$D(RCZ2(Y_".001")),$O(RCZ2(Y+1),-1)=(Y_".001") S Y=Y_".001" Q
 .. I Y'[".",$O(RCZ2(Y))\1'=Y S Y=Y_"."
 .. W !,$S(Y[".":"THIS LINE CANNOT BE USED FOR AN ADJUSTMENT DISTRIBUTION",1:"PLEASE ENTER THE ENTIRE LINE # (Such as: 1.001)") W !
 .. S Y=""
 . ; prca276 - next few lines represent the a fix to prevent distributions agains collected/closed claims (claim balance = zero dollars)
 . ;distributions should only occur on line items that have specific payments against active claims 
 . S RCZZ1=$P(^TMP("RCDPE-EOB_WLDX",$J,Y),U,2) ; get line item sequence # off the VIEW order before accessing the scratchpad
 . S (RCZZ2,RCNONSP)=0 F  S RCZZ2=$O(^RCY(344.49,RCSCR,1,RCZZ1,1,RCZZ2)) Q:'RCZZ2  Q:RCNONSP  S RCADJSTR=$G(^(RCZZ2,0)) S RCNONSP=$S($P(RCADJSTR,U,2)=3:1,$P(RCADJSTR,U,2)=5:1,1:0)    ;identify if non-specific payment adjustments exist
 . ; do not evaluate claim status for non-specific payment adjustments
 . ;  or distributions to non-VistA claims - PRCA*4.5*326
 . I 'RCNONSP,$P(^RCY(344.49,RCSCR,1,RCZZ1,0),U,7) D  Q:'RCACTIVE  ; PRCA*4.5*326
 . . S RCACTIVE=$$GET1^DIQ(430,$P(^RCY(344.49,RCSCR,1,RCZZ1,0),U,7),8)
 . . I (RCACTIVE'="ACTIVE")&(RCACTIVE'="OPEN") S RCACTIVE=0 W !,"THIS IS NOT AN ACTIVE BILL !",!,"CANNOT PERFORM DISTRIBUTION TO THIS CLAIM",! Q
 . . S RCACTIVE=1
 . I $P(RCZ2(Y),U,3) W !,"Warning - on-hold exists for this claim",!
 . W !,"  LINE #: "_+Y_"  LINE BALANCE: "_$J(+$P(RCZ2(Y),U,2),"",2),!
 . ; RCDA1 = the ien of the line in file 344.491
 . ; RCDA1(1) = the line # in the display
 . S RCDA1(1)=Y,RCDA1=+$G(RCZ2(Y)),RCQUIT=1
 . S Z=$O(^RCY(344.49,RCSCR,1,"B",RCDA1(1)\1,0))
 . S RCADJ=0
 . I $P($G(^RCY(344.49,RCSCR,1,Z,0)),U,2)["**ADJ" S RCADJ=1 W !,"THE LINE SELECTED IS AN ADDITIONAL PAYMENT LINE, NOT SPECIFIC TO A CLAIM",!,"THE AMT WILL BE DISTRIBUTED, BUT A DECREASE ADJUSTMENT WILL NOT BE PERFORMED",!
 ;
 G:'$G(RCDA1) DISTQ
 ;
 S DIR("B")=$S(RCDA(2)<$P(RCZ2(RCDA1(1)),U,2):$J(RCDA(2),"",2),1:$J($P(RCZ2(+RCDA1(1)),U,2),"",2))
 S DIR(0)="NA^.01:"_DIR("B")_":2",DIR("A")="ADJUSTMENT AMOUNT TO DISTRIBUTE: "
 S DIR("?",1)="THIS IS THE AMOUNT OF THE ADJUSTMENT THAT SHOULD BE APPLIED TO THIS",DIR("?")="PAYMENT LINE.  THE AMT ENTERED MUST BE BETWEEN .01 AND "_$J(DIR("B"),"",2)
 D ^DIR K DIR
 ;
 I $D(DUOUT)!$D(DTOUT)!'Y D  G DISTQ
 . S DIR(0)="EA",DIR("A",1)="NO AMOUNT WAS ENTERED - TRY AGAIN LATER",DIR("A")="PRESS RETURN TO CONTINUE " D ^DIR K DIR
 S RCAMT=$J(Y,"",2)
 ;
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) D  G DISTQ
 . S DIR(0)="EA",DIR("A")="USER ABORT - PRESS RETURN TO CONTINUE " D ^DIR K DIR
 ;
 S Y=""
 I 'RCADJ D  G:'$D(RCDA) DISTQ
 . N Z,RCA
 . S RCA=0,Z1=+$P($G(^TMP("RCDPE-EOB_WLDX",$J,RCDA(1)\1)),U,2),Z=$G(^RCY(344.49,RCSCR,1,Z1,0)),RCA("#")=+$P($P(Z,U,2),"**ADJ",2)
 . I $P(Z,U,2)["**ADJ" D
 .. S RCA=1
 .. S RCA("REF")=$S(RCA("#"):$P($G(^RCY(344.4,RCSCR,2,RCA("#"),0)),U),1:$P(Z,U,9))
 . S Z=$S(RCA:RCA("#"),1:$G(^RCY(344.49,RCSCR,1,RCDA,0)))
 . S DIR(0)="FAO^1:60",DIR("A")="  > ",DIR("A",1)="DECREASE ADJ COMMENT (1-60 CHARACTERS): "
 . S DIR("B")="RETRACTED FOR "
 . S DIR("B")=DIR("B")_$S(RCA:"ERA ADJ #"_Z_" Ref: "_RCA("REF"),1:"CLAIM "_$S($P(Z,U,2)'="":$P(Z,U,2),1:"UNKNOWN"))
 . I $L(DIR("B"))>60 S DIR("B")=$E(DIR("B"),1,60)
 . D ^DIR K DIR
 . ;
 . I $D(DUOUT)!$D(DTOUT) D  Q
 .. K RCDA
 .. S DIR(0)="EA",DIR("A")="USER ABORT - PRESS RETURN TO CONTINUE " D ^DIR K DIR
 ;
 D DISTADJ^RCDPEWL4(RCDA,RCDA1,RCAMT,Y)
 ;
DISTQ S VALMBCK="R"
 Q
 ;
REFRESH ;EP - Protocol action - RCDPE EOB WORKLIST REFRESH
 ; Refresh the entry in file 344.49 to remove all user adjustments
 N DA,DIK,DIR,RCQUIT,RCREDEF,X,Y,Z,Z0
 D FULL^VALM1
 ; PRCA*4.5*439 Remove security key check, RCDPEPP
 I $S($P($G(^RCY(344.4,RCSCR,4)),U,2)]"":1,1:0) D NOEDIT^RCDPEWLP G REFQ   ;prca*4.5*298  auto-posted ERAs cannot enter REFRESH SCRATCHPAD action      
 I $G(RCSCR("NOEDIT")) D NOEDIT^RCDPEWL G REFQ
 ; prca*4.5*298  per patch requirements, keep code related to creating/maintaining
 ; batches but just remove from execution
 ;I $G(^TMP("RCBATCH_SELECTED",$J)) D NOBATCH^RCDPEWL G REFQ  ;prca*4.5*298
 S DIR(0)="YA"
 S DIR("A",1)="THIS ACTION WILL DELETE AND REBUILD THIS EEOB WORKLIST SCRATCH PAD ENTRY",DIR("A",2)="ALL EDITS/SPLITS/DISTRIBUTE ADJUSTMENTS ENTERED FOR THIS ERA WILL BE ERASED"
 S DIR("A",3)="AND ALL ENTRIES MARKED AS MANUALLY VERIFIED WILL BE UNMARKED",DIR("A",4)=" "
 S DIR("A")="ARE YOU SURE YOU WANT TO DO THIS?: "
 W ! D ^DIR K DIR
 I Y'=1 G REFQ
 ; prca*4.5*298  per patch requirements, keep code related to creating/maintaining
 ; batches but just remove from execution
 ;I $O(^RCY(344.49,RCSCR,3,0)) S RCQUIT=0 D  I RCQUIT G REFQ
 ;. S DIR(0)="YA",DIR("A")="DO YOU WANT TO REDEFINE YOUR BATCHES TOO?: ",DIR("B")="NO" W ! D ^DIR K DIR
 ;. I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 ;. S RCREDEF=+Y
 ;. K ^TMP($J,"BATCHES")
 ;. S Z=0 F  S Z=$O(^RCY(344.49,RCSCR,3,Z)) Q:'Z  S Z0=$G(^(Z,0)) D
 ;.. I RCREDEF S DA=Z,DA(1)=RCSCR,DIK="^RCY(344.49,"_DA(1)_",3," D ^DIK Q
 ;.. S ^TMP($J,"BATCHES",+$P(Z0,U,6),$P(Z0,U,7))=+Z0_U_$P(Z0,U,8)
 ;. I 'RCREDEF S ^TMP($J,"BATCHES")=+$O(^TMP($J,"BATCHES",0))
 ;. I RCREDEF D SETBATCH^RCDPEWLB(RCSCR)
 D ADDLINES^RCDPEWLA(RCSCR)
 D BLD^RCDPEWL1($G(^TMP($J,"RC_SORTPARM")))
 K ^TMP($J,"BATCHES")
REFQ S VALMBG=1,VALMBCK="R"
 Q
 ;
WHAT(RCSCR) ; Text for what to do if not enough funds found for dist adj
 Q $S($O(^RCY(344.31,"AERA",+RCSCR,0)):"THIS ERA MUST BE MOVED TO SUSPENSE",1:"THIS ERA'S RECEIPT MUST BE ENTERED MANUALLY")
 ;
ADJUST ; Allow entry into increase/decrease adjustment functions
 N DIR,X,Y,RCTYP,RCY,DIC
 D FULL^VALM1
 ;
 I $G(RCSCR("NOEDIT"))=2 D NOTAV^RCDPEWL2 G ADJUSTQ
 ; PRCA*4.5*276 - check for authorized user
 I '$D(^XUSEC("PRCADJ",DUZ)) D  Q
 .S DIR(0)="EA",DIR("A",1)="The Adjust (Inc/Dec) Action is locked."
 .S DIR("A",2)="Please speak to your Supervisor to request the key."
 .S DIR("A")="PRESS RETURN TO CONTINUE" W ! D ^DIR K DIR
 ; PRCA*4.5*276 - end of changes
 ;
 S DIR(0)="SA^D:DECREASE ADJUSTMENT;I:INCREASE ADJUSTMENT",DIR("B")="DECREASE ADJUSTMENT",DIR("A")="TYPE OF ADJUSTMENT: "
 W ! D ^DIR K DIR
 M ^TMP("RC_SAVE_TMP",$J)=^TMP($J)
 I $D(DUOUT)!$D(DTOUT)!(Y="") G ADJUSTQ
 ;
 S RCTYP=$S(Y="D":"DECREASE",1:"INCREASE")
 F  S RCY=$$GETABILL^RCBEUBIL Q:RCY<0!(RCY'<1)
 G:RCY<1 ADJUSTQ
 D ADJUST^RCBEADJ(RCTYP,RCY_";"_RCSCR)
 I $D(^TMP("RC_BILL",$J,RCY)) D
 . D UPDBAL(RCY)
 . W !,"Claim balance is now: ",$J(+$P($$BILL^RCJIBFN2(RCY),U,3),"",2)
 ;
ADJUSTQ D RESTMP
 D RET^RCDPEWL2
 S VALMBCK="R"
 Q
 ;
RESTMP ;
 I $D(^TMP("RC_SAVE_TMP",$J)) M ^TMP($J)=^TMP("RC_SAVE_TMP",$J) K ^TMP("RC_SAVE_TMP")
 Q
 ;
UPDBAL(RCY) ; Updates the claim balance if bill exists in list
 ; RCY = ien of bill in file 430
 ;
 N X,Y,Z,Z0,Z1
 S Z0=$J(+$P($$BILL^RCJIBFN2(RCY),U,3),"",2)
 S Z=0 F  S Z=$O(^TMP("RC_BILL",$J,RCY,Z)) Q:'Z  D
 . S X=+$G(^TMP("RCDPE-EOB_WLDX",$J,Z))
 . Q:'X
 . S Y=$G(^TMP("RCDPE-EOB_WL",$J,X+1,0))
 . I Y["Claim Bal: " S Z1=$P(Y,"Claim Bal: ")_"Claim Bal: "_Z0_$G(^TMP("RC_BILL",$J,RCY,Z)),^TMP("RCDPE-EOB_WL",$J,X+1,0)=Z1
 Q
 ;
