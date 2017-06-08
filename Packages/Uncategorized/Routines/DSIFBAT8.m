DSIFBAT8 ;DSS/RED - RPC FOR FEE BASIS FINALIZE BATCHES ;10/17/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; ICR'S
 ;    315  EN3^PRCS58
 ;  5300  ^PRC(424,"E")
 ;  5330  STA^PRCSUT
 Q
 ;
VERIFY ; Called from FINALIZE^DSIFBAT5
 ; Called by DSIFBAT5 to verify all data in a batch before it can be finalized
 ; Please note that this is a validation process only, it verifies that all of the rejected lines can be rejected as a group before passing control back
 ; to DSIFBAT5 so that the lines can actually be rejected.
 ;
 I $G(FBN)="" S FBOUT(0)="-1^No batch number entered" Q
 I '$D(^FBAA(161.7,FBN,0)) S FBOUT(0)="-1^Invalid Batch number" Q
 ;  FBTAMT=Total dollars in batch,  FBLCNT=payment line count  
 S FZ=^FBAA(161.7,FBN,0),B=FBN,FBTYPE=$P(FZ,"^",3),FBST=$G(^FBAA(161.7,FBN,"ST")),FBTAMT=$P(FZ,U,9),FBLCNT=$P(FZ,U,11)
 D DT^DICRW
 I $G(REJALL)'=1 S REJALL=0
 I "TV"'[FBST D  Q:FBERR
 . I FBST="O" S FBOUT(0)="-1^Batch is still Open, cannot finalize!",FBERR=1 Q
 . I FBST="C" S FBOUT(0)="-1^Supervisor has not Released Batch yet, cannot finalize!",FBERR=1 Q
 . I FBST="S" S FBOUT(0)="-1^Batch has not been Transmitted yet, cannot finalize!",FBERR=1 Q
 . S FBOUT(0)="-1^Batch doesn't have the proper status, cannot finalize",FBERR=1 Q
 I FBTYPE="B9",$P(FZ,U,15)="" S FBCNH=1
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) S FBOUT(0)="-1^Sorry, only Supervisor can Finalize batch!",FBERR=1 Q
 I $P(FZ,U,8)="" D STA^PRCSUT S $P(FZ,U,8)=PRC("SITE")
 S FBAAON=$P(FZ,U,2),FBAARA=0,FBAAB=$P(FZ,U),FBAAOB=$P(FZ,U,8)_"-"_FBAAON,FBCOMM="Rejects deleted from batch "_FBAAB
 S (FBTAMT,FBLCNT)=0 D CNTTOT^FBAARB(FBN) S FBTAMT=$S($G(FBTOTAL)>0:$G(FBTOTAL),1:0),FBLCNT=$S($G(FBLCNT)>0:$G(FBLCNT),1:0)
 I 'FBTAMT,'FBLCNT S FBOUT(0)="-1^Cannot finalize batch: "_$P(FZ,U)_", total $ in Batch: "_FBTAMT_" with pmt count: "_FBLCNT,FBERR=1 Q
 S OUT=0  ;Flag
 S PRCS("X")=FBAAOB,PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 S FBOUT(0)="-1^1358 not available for posting!",FBERR=1 Q
 ;Reject submitted lines
 I LINREJ,FBTYPE="B3" S (HX,QQ,FBINTOT)=0 F LIN=0:0 S LIN=$O(FBREJL(LIN)) Q:'LIN!(FBERR)  D
 . N ID,LINE S ID=$P(FBREJL(LIN),U,2) S J=$P(ID,";"),K=$P(ID,";",2),L=$P(ID,";",3),M=$P(ID,";",4),LINE=$P(FBREJL(LIN),U)
 . S FBRR=$P(FBREJL(LIN),U,4),FBIN=$P(FBREJL(LIN),U,3)  ;(FBAARA,FBAAMT)=+$P(^FBAAC(J,1,K,1,L,1,M,0),"^",3)
 . I '$D(^FBAAC("AC",FBN,J)) S FBOUT(0)="-1^No payments in this batch for that patient (LINE;ID: "_LINE_";"_ID_") !",FBERR=1 Q
 . S HX=HX+1,QQ(HX)=J_"^"_K_"^"_L_"^"_M
 . I FBTYPE="B3" N FBADDX S FBADDX=$O(^PRC(424,"E",+$G(FBN),0)) I FBADDX<1 S FBOUT(0)="-1^Pmt: "_LINE_"^ID: "_ID_"^Check your 1358",FBERR=1
 . Q
 ; B9 batch -FBREJL = array of reject lines [FBREJL(1)=Invoice^reject reason (2-40 characters)]
 I LINREJ,FBTYPE="B9" D  Q:FBERR
 .I $G(FBREJL(1))="" S FBOUT(0)="-1^Invalid input, no rejected invoices entered",FBERR=1 Q
 .S FBIN=$P(FBREJL(1),U),FBRR=$P(FBREJL(1),U,2) I '$D(^FBAAI("AC",FBN,FBIN)) S FBOUT(0)="-1^Invoice number '"_FBIN_" is not in Batch number: '"_+$G(^FBAA(161.7,FBIN,0)),FBERR=1 Q
 .I FBRR="" S FBOUT(0)="-1^Invalid invoice reject reason",FBERR=1 Q
 Q
