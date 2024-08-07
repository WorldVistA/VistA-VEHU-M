RCDPEAA2 ;ALB/KML - APAR Screen - SELECTED EOB ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298,304,318,321,326,332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
INIT(RCIENS) ; Entry point for List template to build the display of the EEOB on APAR
 ;  
 ;    Input - RCIENS = ien of entry in file 344.49^ien of 344.491^selectable line item from listman screen
 ;
 N FDTTM
 D CLEAN^VALM10
 K ^TMP("RCDPE-EOB_WL",$J),^TMP("RCDPE-EOB_WLDX",$J),^TMP("RCS",$J)
 S VALMCNT=0,VALMBG=1
 D BLD(RCIENS)
 Q
 ;
 ;
BLD(RCIENS) ; Display selected EEOB  on APAR screen
 N RCZ0,RCZ41,RCERA,RCECME,REASON,V1,RCLI1,TLINE,RCSCR,Z,ZZ,Z0,ZZ1,RC0,RCTL,RCTS,RCCL,RCCL1 ; PRCA*4.5*332
 S RCSCR=$P(RCIENS,U),Z=$P(^RCY(344.49,RCSCR,1,$P(RCIENS,U,2),0),U),RCPROG="RCDPEAA2"
 I Z#1=0 S ZZ=+$O(^RCY(344.49,RCSCR,1,"B",Z,0)) I ZZ D
 . S Z0=Z F  S Z0=$O(^RCY(344.49,RCSCR,1,"B",Z0)) Q:((Z0\1)'=(Z\1))  S Z=Z0,ZZ1=+$O(^RCY(344.49,RCSCR,1,"B",Z0,0)) I ZZ1 D
 .. S ^TMP("RCS",$J,ZZ,ZZ1)=""
 . S ^TMP("RCS",$J,ZZ)=""
 S (RCTS,ZZ)=0
 F  S ZZ=$O(^TMP("RCS",$J,ZZ)) Q:'ZZ  D
 . S RCZ0=$G(^RCY(344.49,RCSCR,1,ZZ,0))
 . S RCECME=$P($G(^RCY(344.4,RCSCR,1,+$P(RCZ0,U,9),4)),U,2)  ; ECME # (344.41,.24)
 . S REASON=$$GET1^DIQ(344.41,$P(RCZ0,U,9)_","_RCSCR_",",5)  ; AUTOPOST REJECTION REASON (344.41,5)
 . S TLINE=$$TOPLINE(RCZ0)
 . D SET(TLINE,$P(RCZ0,U),$P(RCZ0,U),ZZ)
 . ; PRCA*4.5*304 - Add claim comment to screen if it exists for this ERA EEOB detail line
 . S:$P(RCZ0,U,9)'="" RCCL=$$GET1^DIQ(344.41,$P(RCZ0,U,9)_","_RCSCR_",",4)
 . D:$G(RCCL)'=""  ; If we have a ERA Detail line comment, display it
 . . D SLINE(RCCL,"RCCL1",58,76)
 . . S TLINE=$J("",4)_"Claim Comment: "_RCCL1(1)
 . . D SET(TLINE,$P(RCZ0,U),$P(RCZ0,U),ZZ)
 . . ; If we have a second line for the comment then put it on the screen
 . . I RCCL1>1 D SET($J("",4)_RCCL1(2),$P(RCZ0,U),$P(RCZ0,U),ZZ) I RCCL1=3 D SET($J("",4)_RCCL1(3),$P(RCZ0,U),$P(RCZ0,U),ZZ)
 . ; **End of *304 modifications**
 . ; sub-line info (e.g., "n.001")
 . S ZZ1=0 F  S ZZ1=$O(^TMP("RCS",$J,ZZ,ZZ1)) Q:'ZZ1  D
 . . S RCZZ0=$G(^RCY(344.49,RCSCR,1,ZZ1,0))
 . . S RCT=$P(RCZZ0,U),RCTL=$L(RCT)
 . . S RCERA=+$G(^RCY(344.49,RCSCR,0)) ; PRCA*4.5*332
 . . S RCZ41=$$IEN41(RCERA,RCT)        ; PRCA*4.5*332
 . . S V1=$S($P(RCZZ0,U,2)'["**ADJ":"",$P($P(RCZZ0,U,2),"ADJ",2):"***ADJUSTMENT AT ERA LEVEL",1:"*** ADJUSTMENT LINE FOR TOTALS MISMATCH")
 . . S RCLI1=$S(V1="":" Claim #: "_$P(RCZZ0,U,2)_" Patient/Last 4: "_$S($P(RCZZ0,U,7):$$PNM4("","",$P(RCZZ0,U,7)),'$P($G(^RCY(344.49,RCSCR,1,ZZ1,2)),U,3):$$PNM4(RCERA,RCZ41),1:"??"),1:V1) ; PRCA*4.5*332
 . . D SET($J("",4)_$P("   ^(V)",U,$P(RCZZ0,U,13)+1)_RCT_RCLI1,RCT,RCT,ZZ1)
 . . I $P(RCZZ0,U,7) D CLINES(RCZZ0,RCT,ZZ1)
 . . ;
 . . D SET($J("",4+RCTL)_"Payment Amt: "_$J(+$P(RCZZ0,U,5),"",2)_"   Total Adjustments: "_$J(+$P(RCZZ0,U,8),"",2)_"  Net: "_$J($P(RCZZ0,U,5)+$P(RCZZ0,U,8),"",2),RCT,RCT,ZZ1)
 . . ; display pharmacy EEOB data  
 . . I RCECME]"" D RXLINES(RCZZ0,RCECME,RCT,ZZ1)
 . . ; PRCA*4.5*321 BEGIN
 . . I $P(RCZZ0,U,10)'="" D
 . . . D SET($J("",9)_"Receipt Comment: "_$P(RCZZ0,U,10),$P(RCZZ0,U),RCT,ZZ1)
 . . . D SET($J("",9)_"Added By User: "_$$GET1^DIQ(344.491,ZZ1_","_RCSCR_",",2.03),RCTS,RCT,ZZ1)
 . . . D SET($J("",9)_"Date/Time Added: "_$$GET1^DIQ(344.491,ZZ1_","_RCSCR_",",2.04),RCTS,RCT,ZZ1)
 . . ; PRCA*4.5*321 END
 . . I $O(^RCY(344.49,RCSCR,1,ZZ1,1,0)) D ADJLINES(RCZZ0,RCT,ZZ1)
 . . I $G(^TMP($J,"RC_REVIEW")) D REVLINES(RCSCR,RCZZ0,RCT,ZZ1)
 . . D SET($J("",7)_"APAR Reason: "_REASON,RCT,RCT,ZZ1)
 . . S A="",$P(A,".",79)="" D SET(A,RCT,RCT,ZZ1)
 I VALMCNT=0 D SET("THERE ARE NO EEOBs MATCHING YOUR SELECTION CRITERIA")
 K ^TMP($J,"RCS")
 Q
 ;
SET(X,RCSEQ,RCSEQ1,RCZ9) ; -- set ListManager arrays
 ; X = the data to set into the global
 ; RCSEQ = the selectable line #
 ; RCSEQ1 = = the sub line #
 ; RCZ9 = reference to the line(s) in file 344.41 or to the subline in
 ;        file 344.49 for RCSEQ having a decimal
 S VALMCNT=VALMCNT+1,^TMP("RCDPE-EOB_WL",$J,VALMCNT,0)=X
 I $G(RCSEQ) S ^TMP("RCDPE-EOB_WL",$J,"IDX",VALMCNT,RCSEQ)=""
 I $G(RCSEQ1),'$D(^TMP("RCDPE-EOB_WLDX",$J,RCSEQ1)) S ^TMP("RCDPE-EOB_WLDX",$J,RCSEQ1)=VALMCNT_U_$G(RCZ9)
 Q
 ;
TOPLINE(RCZ0) ; Function returns the top line of the EEOB display
 ; RCZ0 = the 0-node of the whole number entry line for the EEOB
 N A
 S A=" "_$S($P(RCZ0,U,13):"(V)",1:"   ")_"EEOB: ERA Seq #"_$S($P(RCZ0,U,9)[",":"'s",1:"")_" "_$S($P(RCZ0,U,9)'="":$P(RCZ0,U,9),1:"None")_"   Net Payment Amt: "_$J(+$P(RCZ0,U,6),"",2)
 I $G(^TMP($J,"RC_REVIEW")) S A=A_"  Reviewed?: "_$S($P(RCZ0,U,11)="":"NO",1:$$EXTERNAL^DILFD(344.491,.11,,$P(RCZ0,U,11)))
 Q A
 ;
 ;PRCA*4.5*304 - Split long line into printable lengths
SLINE(ZIN,ZARR,FLN,SLN) ;
 ; ZIN - Input string; ZARR - Array output of lines ; FLN - First line length ; SLN - Subsequent line lengths
 ; Assumes ZIN max length is 132 characters and FLN and SLN variables will make ZIN fit in 3 lines.
 N ZL,ZI,ZM
 I $L(ZIN)<(FLN+1) S @ZARR@(1)=ZIN,@ZARR=1 Q
 ; Otherwise we are spanning more than 1 line
 S ZL="" F ZI=1:1 Q:($L(ZL)+$L($P(ZIN," ",ZI)))>FLN  S ZL=ZL_$S($L(ZL)>0:" ",1:"")_$P(ZIN," ",ZI)
 S @ZARR@(1)=ZL,ZL=$P(ZIN," ",ZI,9999)
 I $L(ZL)<(SLN+1) S @ZARR@(2)=ZL,@ZARR=2 Q
 ; Spilling onto a third line.
 S ZM="" F ZI=1:1 Q:($L(ZM)+$L($P(ZL," ",ZI)))>SLN  S ZM=ZM_$S($L(ZM)>0:" ",1:"")_$P(ZL," ",ZI)
 S @ZARR@(2)=ZM,ZM=$P(ZL," ",ZI,9999)
 S @ZARR@(3)=ZM,@ZARR=3
 Q
 ; **END of *304 changes**
 ;
CLINES(RCZZ0,RCT,ZZ1) ;  called from BLD ; set up the claim information lines
 ; 
 ;  Input -   RCZZ0 = zero node data at 344.491
 ;            RCT   = sub line #
 ;            ZZ1   = reference to the to the subline in
 ;                    file 344.49 for RCSEQ having a decimal
 N A,RCX,Q,QQ
 S A("OA")=$$ORI^PRCAFN(+$P(RCZZ0,U,7)),A("SDT")=$P($G(^DGCR(399,+$P(RCZZ0,U,7),"U")),U),A("DFN")=+$P($G(^(0)),U,2),A("ENRPR")=""
 ; Find Rx copay status
 S A("RXCP")=$S('A("SDT"):"",1:$$RXST^IBARXEU(A("DFN"),A("SDT"))),A("RXCP")=$S($P(A("RXCP"),U)'="":$P(A("RXCP"),U,2),1:"UNKNOWN") ;IA #10147
 ; Find M/T status
 S RCX=$$LST^DGMTU(A("DFN"),A("SDT")),A("M/T")=$P(RCX,U,4)
 S A("M/T")=$S('RCX:"??",A("M/T")="P":"PEN",A("M/T")="C":"YES",A("M/T")="G":"GMT",A("M/T")="R":"REQ",1:"NO")
 S QQ="   Billed Amt: "_$J(A("OA"),"",2)_"   Amt To Post: "_$J(+$P(RCZZ0,U,3),"",2)
 D SET($J("",4+RCTL)_"Claim Bal: "_$J(+$P($$BILL^RCJIBFN2(+$P(RCZZ0,U,7)),U,3),"",2)_QQ,$P(RCZZ0,U),RCT,ZZ1)
 S ^TMP("RC_BILL",$J,$P(RCZZ0,U,7),RCT)=QQ
 S Z3=$J("",4+RCTL)_"Svc Dt: "_$S(A("SDT")'="":$$FMTE^XLFDT(A("SDT"),2),1:"UNKNOWN")
 S Z3=Z3_"  COB: "_$S($D(^DGCR(399,+$P(RCZZ0,U,7),"I"_($$COBN(+$P(RCZZ0,U,7))+1))):"YES",1:"NO ")
 D SET(Z3_"  Rx Copay: "_$E(A("RXCP"),1,17)_"  Means Tst: "_A("M/T"),$P(RCZZ0,U),RCT,ZZ1)
 Q
 ;
REVLINES(RCSCR,RCZZ0,RCT,ZZ1) ;called from BLD; set up the reviewed lines
 ; 
 ;    Input - RCSCR = ien of 344.49 (and 344.4)
 ;            RCZZ0 = zero node data at 344.491
 ;            RCT   = sub line #
 ;            ZZ1   = reference to the to the subline in
 ;                    file 344.49 for RCSEQ having a decimal
 N A,A0,B,B0
 S A=$J("",10)_"REVIEW STATUS: ("_$S($P(RCZZ0,U,11)="I":"REVIEW IN PROCESS",$P(RCZZ0,U,11)=1:"REVIEWED",1:"NOT REVIEWED")
 I $P(RCZZ0,U,12) S A=A_"   SET BY: "_$E($P($G(^VA(200,$P(RCZZ0,U,12),0)),U),1,20)
 D SET(A_")",+$P(RCZZ0,U),RCT,ZZ1)
 S A=0 F  S A=$O(^RCY(344.49,RCSCR,1,ZZ1,4,A)) Q:'A  S A0=$G(^(A,0)) D
 . D SET($J("",12)_$$FMTE^XLFDT($P(A0,U),2)_"  "_$P($G(^VA(200,+$P(A0,U,2),0)),U)_$S($P(A0,U,4):"  LAST EDIT: "_$$FMTE^XLFDT($P(A0,U,4),2),1:""),$P(RCZZ0,U),RCT,ZZ1)
 . S B=0 F  S B=$O(^RCY(344.49,RCSCR,1,ZZ1,4,A,1,B)) Q:'B  S B0=$G(^(B,0)) D
 . . I $L(B0)>64 D SET($J("",15)_$E(B0,1,64),$P(RCZZ0,U),RCT,ZZ1) S B0="  "_$E(B0,65,$L(B0)) ; Split line if > 64 characters in comment line
 . . D SET($J("",15)_B0,$P(RCZZ0,U),RCT,ZZ1)
 Q
 ;
ADJLINES(RCZZ0,RCT,ZZ1) ; called from BLD;  set up the adjustment lines
 ; 
 ;  Input -   RCZZ0 = zero node data at 344.491
 ;            RCT   = sub line #
 ;            ZZ1   = reference to the to the subline in
 ;                    file 344.49 for RCSEQ having a decimal
 N RCAZ,RCAZ0,Z3
 S Z3=""
 D SET($J("",4+RCTL)_"ADJUSTMENTS:",$P(RCZZ0,U),RCT,ZZ1)
 S RCAZ=0 F  S RCAZ=$O(^RCY(344.49,RCSCR,1,ZZ1,1,RCAZ)) Q:'RCAZ  S RCAZ0=$G(^(RCAZ,0)) D
 . S Z3=$J("",6+RCTL)_+RCAZ0_".  ",Q=$L(Z3)
 . I $P(RCAZ0,U,2)=0 S Z3=Z3_"Distributed adj dec for retraction "_$P(RCAZ0,U,4)_": "_$P(RCAZ0,U,3)
 . I $P(RCAZ0,U,2)=1 S Z3=Z3_"Adjustment distribution to balance receipt: "_$P(RCAZ0,U,3)
 . I $P(RCAZ0,U,2)=2!($P(RCAZ0,U,2)=4) D
 . . S Z3=Z3_"ERA payment adjusted from "_$J($P(RCZZ0,U,5)-$P(RCZZ0,U,6),"",2)_" to "_$J(+$P(RCZZ0,U,5),"",2)_"  NET: "_$J($P(RCZZ0,U,5)+$P(RCAZ0,U,3),"",2)
 . I $P(RCAZ0,U,2)=5 S Z3=Z3_"Non-specific payment (ref# "_$P(RCAZ0,U,4)_"): "_$P(RCAZ0,U,3)
 . I $P(RCAZ0,U,2)=3 S Z3=Z3_"Non-specific retraction (ref# "_$P(RCAZ0,U,4)_"): "_$P(RCAZ0,U,3)
 . D SET(Z3,$P(RCZZ0,U),RCT,ZZ1)
 . I $P(RCAZ0,U,9)'="" D SET($J("",Q)_$P(RCAZ0,U,9),$P(RCZZ0,U),RCT,ZZ1)
 Q
 ;
 ;
RXLINES(RCZZ0,RCECME,RCT,ZZ1) ; called from BLD ; set up the Pharmacy lines
 ;
 ;  Input -   RCZZ0   = zero node data at 344.491
 ;            RCECME  = ECME # for Pharmacy claims
 ;            RCT     = sub line #
 ;            ZZ1     = reference to the to the subline in
 ;                      file 344.49 for RCSEQ having a decimal
 N RXARRAY
 D GETPHARM^RCDPEWLP($P(RCZZ0,U,7),.RXARRAY)
 D SET($J("",9)_"ECME #: "_RCECME,$P(RCZZ0,U),RCT,ZZ1)
 I '$D(RXARRAY) D SET($J("",9)_" Pharmacy data does not exist for this claim",$P(RCZZ0,U),RCT,ZZ1) Q
 D SET($J("",9)_"Rx/Fill/Release Status: "_RXARRAY("RX")_"/"_RXARRAY("FILL")_"/"_RXARRAY("RELEASED STATUS"),$P(RCZZ0,U),RCT,ZZ1)
 D SET($J("",9)_"DOS: "_RXARRAY("DOS"),$P(RCZZ0,U),RCT,ZZ1)
 Q
 ;
HDR ; Creates header lines for the selected EEOB display
 N RC0,RC4,RC5,Z,RCDA,RCSEQ
 I '$G(RCIENS) S VALMQUIT=1 Q
 S RCDA=$P(RCIENS,U),RCSEQ=$P(RCIENS,U,3)
 S RC0=$G(^RCY(344.4,RCDA,0)),RC4=$G(^RCY(344.4,RCDA,4)),RC5=$G(^RCY(344.4,RCDA,5))
 S VALMHDR(1)=$E("ERA Entry #: "_$P(RC0,U)_$J("",31),1,31)_"Total Amt Pd: "_$J(+$P(RC0,U,5),"",2)
 I +RCSEQ S VALMHDR(2)=$E("Posted Amt: "_$J($P(^TMP("RCDPE-APAR_EEOB_WLDX",$J,RCSEQ),U,5),"",2)_$J("",31),1,31)
 S VALMHDR(2)=$G(VALMHDR(2))_"Un-posted balance: "_$J($P(^TMP("RCDPE-APAR_EEOB_WLDX",$J,RCSEQ),U,4),"",2)
 S VALMHDR(3)="Payer Name/ID: "_$P(RC0,U,6)_"/"_$P(RC0,U,3)
 S Z=+$O(^RCY(344.31,"AERA",RCDA,0))
 I Z S VALMHDR(4)="EFT #/TRACE #: "_$$GET1^DIQ(344.31,Z_",",.01,"E")_"/"_$P(RC0,U,2) ; PRCA*4.5*326
 I 'Z,$P(RC5,U,2)'="" S VALMHDR(4)="PAPER CHECK #: "_$P(RC5,U,2)
 S VALMHDR(5)="Posted Receipt #(s): "_$$RCPTS(RCDA,RC0)
 Q
 ;
RCPTS(RCDA,RC0) ; pull list of 'other receipt #s
 ;  input  - RCDA  = ien of entry in 344.4
 ;           RC0   = data string at zero node of entry in 344.4
 ;  output - RCPTS = returns list of receipts stored at 344.4,.08 and 344.48 multiple
 N X,RIEN,RCPTS
 S X=0
 S RCPTS=$P($G(^RCY(344,+$P(RC0,U,8),0)),U)
 I RCPTS="" G RCPTSQ  ; receipt not posted to any of EEOB items
 S RCPTS=RCPTS_","
 F  S X=$O(^RCY(344.4,RCDA,8,X)) Q:'X  S RIEN=+^(X,0) S RCPTS=RCPTS_$P($G(^RCY(344,RIEN,0)),U)_","
 S RCPTS=$$TRIM^XLFSTR(RCPTS,"R",",")  ; remove orphan comma from last receipt number
RCPTSQ ;
 Q RCPTS
 ;
EXIT ; -- Clean up list
 K RCFASTXT
 Q
 ;
PNM4(RCIFN,RCDA,RC) ; Returns either the patient name or patient name/last 4
 ; RCIFN = ien of file 344.4
 ; RCDA = ien of file 344.41
 ; RC = the ien of file 430
 N Z,Z0,Q
 S Z=""
 I $G(RCIFN)'="" D
 . S Z0=$G(^RCY(344.4,RCIFN,1,RCDA,0)),Z=""
 . I $P(Z0,U,2) S Q=+$P($G(^DGCR(399,+$G(^IBM(361.1,+$P(Z0,U,2),0)),0)),U,2),Z=$P($G(^DPT(Q,0)),U)_"/"_$E($P($G(^(0)),U,9),6,9) ; IA 4051
 . I $TR(Z,"/")="" S Z=$P(Z0,U,15)
 I $G(RC)'="" D
 . S Q=+$P($G(^PRCA(430,RC,0)),U,7)
 . I Q S Z=$P($G(^DPT(Q,0)),U)_"/"_$E($P($G(^(0)),U,9),6,9)
 Q Z
 ;
COBN(RC,A) ; Return seq # of selected payer
 ; A = 'PST' or null to get current bill payer seq #
 I $G(A)="" S A=$P($G(^DGCR(399,RC,0)),U,21) S:A="" A="P" S:"PST"'[A A="P"
 I 'A S A=$F("PST",A)-1 S:A<1 A=1
 Q A
 ;
COPAY(RCIFN)       ; Returns 1 if any not cancelled 1st party bills exist for
 ; a 3rd party bill or any bills related to this 3rd party bill
 ; RCIFN = the 3rd party bill #
 N FIRST,RCTP0,RCTP1,RCTP2
 K ^TMP("IBRBF",$J),^TMP($J,"IBRBF")
 D RELBILL^IBRFN(RCIFN) ; DBIA 3124
 S RCTP0=0 F  S RCTP0=$O(^TMP("IBRBF",$J,RCIFN,RCTP0)) Q:RCTP0=""  S RCTP1=$G(^(RCTP0)) D
 . I $P(RCTP1,U,3) K ^TMP("IBRBF",$J,RCIFN,RCTP0) Q  ; IB cancelled
 . S RCTP2=$O(^PRCA(430,"B",+$P(RCTP1,U,4),0)) I $P($G(^PRCA(430,+RCTP2,0)),U,8)=39 K ^TMP("IBRBF",$J,RCIFN,RCTP0) ; AR cancelled
 S FIRST=$S($O(^TMP("IBRBF",$J,RCIFN,0)):1,1:0)
 K ^TMP("IBRBF",$J),^TMP($J,"IBRBF")
 Q FIRST
 ;
MARK(RCIENS) ;EP - Protocol action - RCDPE MARK FOR AUTO POST
 ; Mark for Auto-Post - EEOB on APAR gets marked for auto-post if it passes
 ; autoposting validation
 ; Input:   RCIENS  - Internal IEN of entry in file 344.49^ien of 
 ;                    344.491^selectable line item from listman screen
 ;
 I '$D(^XUSEC("RCDPEPP",DUZ)) D  Q  ; PRCA*4.5*318 Added security key check
 . D FULL^VALM1
 . S VALMBCK="R"
 . W !!,"This action can only be taken by users that have the RCDPEPP security key.",!
 . D PAUSE^VALM1
 ;
 N RESULT,REASON,LINE,DIR,X,Y,RCERROR,XX,ERADA1,RCDFDA
 S:$G(RCIENS)="" RCIENS=+$$SEL^RCDPEAA1()
 Q:'RCIENS
 I '$$VALID($P(RCIENS,U),$P(RCIENS,U,2),.RESULT) D  G MARKQ ; $$VALID split from RCDPEAP - PRCA*4.5*326
 . S LINE=$O(RESULT(""))
 . S REASON=$TR(RESULT(LINE),U,"-")
 . S DIR(0)="EA",DIR("A",1)="EEOB cannot be marked for Auto-Post for the following reason:"
 . S DIR("A",2)=REASON
 . S DIR("A")="PRESS RETURN TO CONTINUE "
 . W ! D ^DIR K DIR W !
 ; EEOB passed validation; ready for Autopost
 L +^RCY(344.4,$P(RCIENS,U),0):5 I '$T D NOLOCK G MARKQ
 S ERADA1=$P($G(^RCY(344.49,$P(RCIENS,U),1,$P(RCIENS,U,2),0)),U,9)  ; get 344.41 ien (344.491,.09)
 S RCDFDA(344.41,ERADA1_","_$P(RCIENS,U)_",",6)=1
 S RCDFDA(344.41,ERADA1_","_$P(RCIENS,U)_",",6.01)=DUZ ; PRCA*4.5*326
 D FILE^DIE("","RCDFDA")
 D UPDERA($P(RCIENS,U),DUZ) ; PRCA*4.5*326 - also update top level ERA
 S DIR(0)="EA",DIR("A",1)=$P(RCIENS,U)_"."_ERADA1_" has been marked for auto-post and has been removed from the APAR List."
 S DIR("A")="PRESS RETURN TO CONTINUE "
 W ! D ^DIR K DIR W !
 L -^RCY(344.4,$P(RCIENS,U),0)
MARKQ ;
 Q
 ;
NOLOCK ; entry cannot be locked
 N DIR
 S DIR(0)="EA"
 S DIR("A",1)="Sorry, another user is editing this ERA entry."
 S DIR("A",2)="Try again later."
 S DIR("A",3)=""
 S DIR("A")="PRESS ENTER TO CONTINUE "
 D ^DIR
 Q
 ;
VIEWERA(RCIENS) ; View/Print ERA - protocol entry from APAR EEOB List screen and APAR - EEOB ITEM - SCRATCHPAD screen
 N RCSCR
 I RCPROG="RCDPEAA2" S RCSCR=$P(RCIENS,U)
 I RCPROG="RCDPEAA1" S RCSCR=+$$SEL^RCDPEAA1()
 I RCSCR>0 D PRERA^RCDPEWL0
 Q
 ;
VALID(RCSCR,SCRLINE,RCARRAY) ;Validates Scratchpad line - Used by APAR/Mark for Auto-post - split from RCDPEAP  - PRCA*4.5*326
 ;Input
 ;  RCSCR   - #344.4/#344.49 file IEN
 ;  SCRLINE - Subscript of first scratchpad entry for the ERA line
 ;  RCARRAY - Passed reference to result array
 ;Output
 ;  OK      - Boolean 1 or 0
 ;  RCARRAY - Array of claim(s) which fail validation
 ;
 ;            e.g  line number 2
 ;                 RCARRAY(2.001)="K800001^NOT AN ACTIVE CLAIM"
 ;
 ;            e.g. split line number 2
 ;                 RCARRAY(2.001)="K800002^CLAIM REFERRED TO GENERAL COUNCIL"
 ;                 RCARRAY(2.006)="K800003^PAYMENT EXCEEDS CLAIM BALANCE"
 ;
 N CLAIM,DONE,SEQ,SEQ1,SUB,STATUS,WLINE
 K RCARRAY,CLARRAY
 S SUB=SCRLINE,SEQ=$P($G(^RCY(344.49,RCSCR,1,SUB,0)),U),DONE=0
 F  S SUB=$O(^RCY(344.49,RCSCR,1,SUB)) Q:SUB=""  D  Q:DONE
 . ;Get scratchpad N.001 line and data
 . S WLINE=$G(^RCY(344.49,RCSCR,1,SUB,0)),SEQ1=$P(WLINE,".") I SEQ1'=SEQ S DONE=1 Q
 . ;Get claim number from N.00N line - ignore suspense lines
 . S CLAIM=$P(WLINE,U,7) I 'CLAIM Q
 . ;Claim must be OPEN or ACTIVE
 . S STATUS=$P($G(^PRCA(430,CLAIM,0)),"^",8) I STATUS'=42,STATUS'=16 S RCARRAY(SEQ1)=$P(WLINE,U,2)_"^NOT AN ACTIVE CLAIM" Q
 . ;Check that payment does not exceed balance and no pending payments (at the time of auto posting)
 . S CLARRAY(CLAIM)=+$G(CLARRAY(CLAIM))+$P(WLINE,U,3) I '$$CHECKPAY^RCDPEAP(.CLARRAY,CLAIM) S RCARRAY(SEQ1)=$P(WLINE,U,2)_"^PAYMENT EXCEEDS CLAIM BALANCE" Q
 . ;Check if referred to general council
 . I $P($G(^PRCA(430,CLAIM,6)),U,4)]"" S RCARRAY(SEQ1)=$P(WLINE,U,2)_"^CLAIM REFERRED TO GENERAL COUNCIL" Q
 . ;Check that payment is not negative
 . I $P(WLINE,U,6)<0 S RCARRAY(SEQ1)=$P(WLINE,U,2)_"^PAYMENT AMOUNT IS NEGATIVE" Q
 ;Returns 1 if line is OK
 Q $S($O(RCARRAY(""))]"":0,1:1)
 ;
UPDERA(ERAIEN,RCDUZ) ; Update MARK FOR AUTOPOST USER top level ERA with DUZ from detail line. PRCA*4.5*326
 ; MARK FOR AUTOPOST USER is required at ERA level for initial receipt and AR transaction crreation
 ; so the MARK FOR AUTOPOST USER at the top level will be equal to the last detail line marekd for autopost
 N FDA,IENS
 S FDA(344.4,ERAIEN_",",4.04)=RCDUZ
 D FILE^DIE("","FDA")
 Q
IEN41(IEN,LINE) ; Given a scratch pad line, find the original ERA detail line. PRCA*4.5*332
 ; Input: IEN - Internal Entry number of ERA scratchpad from file 344.49
 ;        LINE - Line from ERA scratchpad file 344.49
 N IEN2
 S IEN2=$O(^RCY(344.49,IEN,1,"ASEQ",LINE\1,0))
 Q +$$GET1^DIQ(344.491,IEN2_","_IEN_",",.09,"E")
