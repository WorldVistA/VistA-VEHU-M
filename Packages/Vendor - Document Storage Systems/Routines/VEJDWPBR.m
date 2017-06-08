VEJDWPBR ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;; slc/dcm - Get orders for a patient. ;6/26/96  12:52
 ;ORQ1;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
EN(PAT,GROUP,FLG,EXPAND,SDATE,EDATE,DETAIL,MULT) ;Get orders
 ; Returns orders in ^TMP("ORR",$J,ORLIST,i) for defined context:
 ;
 ; PAT=patient variable ptr in format "DFN;DPT("
 ; GROUP=Display group
 ; FLG=#:
 ; 1 => All                8 => Unverified   15 => Admission
 ; 2 => Active/Current     9 => Unver/Nurse  16 => Discharge
 ; 3 => Discontinued/Canc 10 => Unver/Clerk  17 => Transfer
 ; 4 => Completed/Expired 11 => Unsigned     18 => On Hold
 ; 5 => Expiring          12 => Flagged      19 => New Orders
 ; 6 => New Activity      13 => Verbal/Phone
 ; 7 => Pending           14 => V/P Unsigned
 ; EXPAND=ifn of parent order, used to expand child orders
 ; SDATE=Start date
 ; EDATE=End date
 ; DETAIL=Data to be returned (optional, default=0):
 ; 0 => ^TMP("ORR",$J,ORLIST,i) = order #
 ; 1 => ^TMP("ORR",$J,ORLIST,i) = order #^display group^when entered^
 ;                                start d/t^stop d/t^status
 ;      ^TMP("ORR",$J,ORLIST,i,"TX",j) = order text
 ; MULT=0:Don't allow multiple occurances of order, 1:Allow multiple occurances
EN0 ;
 ; Order Status:
 ; 1 => Discontinued (dc) 6 => Active ( )          11 => Unreleased (u)
 ; 2 => Complete (c)      7 => Expired (e)         12 => Replaced (r)
 ; 3 => Hold (h)          8 => Scheduled (s)       13 => Canceled (x)
 ; 4 => Flagged (?)       9 => Partial Results (i) 14 => Lapsed (l)
 ; 5 => Pending (p)      10 => Pre-Release (pr)    15 => Renewed (rn)
 ;                                                 99 => No Status (')
 ;   
 ; FLG Context:            Includes status:
 ; 1. All               => 1,2,3,4,5,6,7,8,9,   11,12,13,14,15
 ; 2. Active/Current    =>     3,4,5,6,  8,9,   11,         15
 ;    Includes CONTEXT HRS 1,2,7,13 & Action Status=13
 ;                         Orders in ^OR(100,"AC",PAT,TM,IFN,ACTION)
 ; 3. Discontinued      => 1                       12,13
 ; 4. Completed/Expired =>   2,        7
 ; 5. Expiring          =>     3,4,5,6,  8,9
 ; 6. New Activity      => 1,2,3,4,5,6,7,8,9,   11,   13,14,15
 ;    Includes Date of Last Activity within 24 hours
 ; 7. Pending           =>         5
 ; 8. Unverified        => 1,2,3,4,5,6,7,8,9,         13,14,15
 ; 9. Unverified/Nurse  => 1,2,3,4,5,6,7,8,9,         13,14,15
 ;10. Unverified/Clerk  => 1,2,3,4,5,6,7,8,9,         13,14,15
 ;11. Unsigned          =>     3,4,5,6,  8,9,   11,         15
 ;                         Orders in ^OR(100,"AS",PAT,TM,IFN)
 ;12. Flagged           => 1,2,3,4,5,6,7,8,9,   11,12,13,14,15
 ;13. Verbal/Phoned     => 1,2,3,4,5,6,7,8,9,   11,12,13,14,15
 ;                         Nature of order of verbal or phoned
 ;14. Verb/Phn unsigned => 1,2,3,4,5,6,7,8,9,   11,12,13,14,15
 ;                         Nature of order V or P & unsigned
 ;15. Admission         =>                   10
 ;16. Discharge         =>                   10
 ;17. Transfer          =>                   10
 ;                         Orders in ^OR(100,"AEVNT",PAT,<A,D or T>,IFN)
 ;18. On Hold           =>     3
 ;19. New Orders        =>                   10,11
 ;                         Orders in ORNEW(ORIFN)
 ;
EN1 Q:'$G(PAT)  S:'$G(FLG) FLG=2 S:'$G(DETAIL) DETAIL=0 S:'$G(MULT) MULT=0
 S:'$G(GROUP) GROUP=$O(^ORD(100.98,"B","ALL SERVICES",0))
 I $G(EDATE)<$G(SDATE) S X=EDATE,EDATE=SDATE,SDATE=X
 I $G(EDATE) S EDATE=$S($L(EDATE,".")=2:EDATE+.0001,1:EDATE+1)
 I $G(SDATE) S SDATE=$S($L(SDATE,".")=2:SDATE-.0001,1:SDATE)
 S SDATE=$S($G(SDATE):9999999-SDATE,1:9999999),EDATE=$S($G(EDATE):9999999-EDATE,1:1)
 N ORLST,ORGRP
 S ORLST=0,X=EDATE,EDATE=SDATE,SDATE=X
 D GRP(GROUP),LIST
 D @($S(FLG=2:"CUR",FLG=5:"EXG",FLG=6:"ACT",FLG=11:"SIG",FLG=15:"ADM",FLG=16:"DIS",FLG=17:"XFR",FLG=19:"NEW","^1^3^4^7^8^9^10^12^13^14^18^"[(U_FLG_U):"LOOP",1:"QUIT")_"^VEORQ11")
 Q
 ;
LIST ;Get entry in ^TMP("ORR",$J,ORLIST)
 S ORLIST=$H L +^TMP("ORR",$J,ORLIST)
 I $D(^TMP("ORR",$J,ORLIST)) L -^TMP("ORR",$J,ORLIST) H 1 G LIST
 S ^TMP("ORR",$J,ORLIST)="" L -^TMP("ORR",$J,ORLIST)
 Q
 ;
GRP(DG) ;Setup display groups
 ;DG=Display group to expand
 N STK,MEM,I
 S ORGRP(DG)="",STK=1,STK(STK)=DG_"^0",STK(0)=0,MEM=0
 F I=0:0 S MEM=$O(^ORD(100.98,+STK(STK),1,MEM)) D @$S(+MEM'>0:"POP",1:"PROC") Q:STK<1
 Q
 ;
POP S STK=STK-1,MEM=$P(STK(STK),"^",2) Q
PROC S $P(STK(STK),"^",2)=MEM,DG=$P(^ORD(100.98,+STK(STK),1,MEM,0),"^",1)
 S ORGRP(DG)="",STK=STK+1,STK(STK)=DG_"^0",MEM=0
 Q
