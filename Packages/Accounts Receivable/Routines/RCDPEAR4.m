RCDPEAR4 ;ALB/TMK/PJH - ERA Unmatched Aging Report (file #344.4) ;Dec 20, 2014@18:41:35
 ;;4.5;Accounts Receivable;**409**;Mar 20, 1995;Build 17
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; PRCA*4.5*409 New routine - RCEPEAR1 split due to size limitations
 ;
RPTOUT2 ;EP from RCDPEAR1
 ; Input:   LNECNT      - # of lines on current page
 ;          RCDISPTY    - Display type (Excel)
 ;          RCFLIEN     - IEN in file #344.4
 ;          RCHDR       - Header array
 ;          RCLNCNT     - Global Line counter
 ;          RCLSTMGR    - List manager flag
 ;          RCTMPND     - Name of the subscript for ^TMP to use to return all lines
 ;                       (for bulletin).  If undefined or null, output is printed
 ;          RCSF0       - Zero node of sub-file entry (^RCY(344.4,RCFLIEN,1,RCSFIEN,0)
 ;          RCSTOP      - Flag used to stop output of report
 ;
 ;PRCA*4.5*409 Begin - Lines restored ePayments Build 17 version of routine
 N Z
 I "23"[$$ADJ^RCDPEU(RCFLIEN) D
 . D SL^RCDPEARL($J("",9)_"** CLAIM LEVEL ADJUSTMENTS EXIST FOR THIS ERA ***",.RCLNCNT,RCTMPND)
 . S LNECNT=LNECNT+1
 I $O(^RCY(344.4,RCFLIEN,2,0)) D  ; ERA level adjustments exist
 . N Q
 . D DISPADJ^RCDPESR8(RCFLIEN,"^TMP("_$J_",""RCERA_ADJ"")")
 . I $O(^TMP($J,"RCERA_ADJ",0)) D
 . . D SL^RCDPEARL($J("",9)_"** GENERAL ADJUSTMENT DATA EXIST FOR THIS ERA **",.RCLNCNT,RCTMPND)
 . . S LNECNT=LNECNT+1
 . S Q=0
 . F  D  Q:'Q
 . . S Q=$O(^TMP($J,"RCERA_ADJ",Q))
 . . Q:'Q
 . . I 'RCLSTMGR,LNECNT>(IOSL-2) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 . . D SL^RCDPEARL($J("",9)_$G(^TMP($J,"RCERA_ADJ",Q)),.RCLNCNT,RCTMPND)
 . . S LNECNT=LNECNT+1
 ;
 N D,RCSFIEN
 S RCSFIEN=0                        ; RCSFIEN - sub-file ien, RCSF0 - zero node of sub-file entry
 F  S RCSFIEN=$O(^RCY(344.4,RCFLIEN,1,RCSFIEN)) Q:'RCSFIEN  S RCSF0=$G(^(RCSFIEN,0)) D  Q:RCSTOP
 . N RCDATA,RCOUT  ; set by RCDPESR0, RCDATA - message data, RCOUT - formatted message display
 . I 'RCLSTMGR,RCLNCNT>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 . S D=$J("",7)_" EEOB Seq #: "_$P(RCSF0,U)_$S($D(^RCY(344.4,RCFLIEN,1,"ATB",1,RCSFIEN)):" (REVERSAL)",1:"")_"  EEOB "
 . S D=D_$S('$P(RCSF0,U,2):"not on file",1:"on file for "_$P($G(^DGCR(399,+$G(^IBM(361.1,+$P(RCSF0,U,2),0)),0)),U))_"  "_$J(+$P(RCSF0,U,3),"",2)
 . D SL^RCDPEARL(D,.RCLNCNT,RCTMPND)
 . S LNECNT=LNECNT+1
 . Q:$P(RCSF0,U,2)
 . D DISP^RCDPESR0("^RCY(344.4,"_RCFLIEN_",1,"_RCSFIEN_",1)","RCDATA",1,"RCOUT",68,1)
 . I '$O(RCOUT(0)) D SL^RCDPEARL($J("",9)_" NO DETAIL FOUND",.RCLNCNT,RCTMPND) Q
 . S Z=0 F  S Z=$O(RCOUT(Z)) Q:'Z  D  Q:RCSTOP
 . . I 'RCDISPTY,'RCLSTMGR,LNECNT>(IOSL-2) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 . . D SL^RCDPEARL($J("",9)_"*"_RCOUT(Z),.RCLNCNT,RCTMPND)
 . . S LNECNT=LNECNT+1
 Q
