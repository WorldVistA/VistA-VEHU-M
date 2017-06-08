VEJDWPBV ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;; SLC/MKB - Detailed Order Report cont ;8/5/97  11:13
 ;ORQ20;3.0;ORDER ENTRY/RESULTS REPORTING;**12**;Dec 17, 1997
ACT ; -- add Activity [from ^ORQ2]
 S CNT=CNT+1,ORY(CNT)=$$DATE($P(ACTION,U))_"  "_$$ACTION($P(ACTION,U,2))
 I $P(ACTION,U,13) S ORY(CNT)=ORY(CNT)_" entered by "_$$USER(+$P(ACTION,U,13))
 I $P(OR3,U,11)=1,$P(OR3,U,5) D  ; changed - show original order
 . N ORZ,I D TEXT^VEJDWPBT(.ORZ,+$P(OR3,U,5),55)
 . S CNT=CNT+1,ORY(CNT)="     Original Order:    "_$G(ORZ(1))
 . S I=1 F  S I=$O(ORZ(I)) Q:I'>0  S CNT=CNT+1,ORY(CNT)=$$REPEAT^XLFSTR(" ",24)_$G(ORZ(I))
 I $P(ACTION,U,12) D  ;Nature of Order, released by
 . N ORZ S ORZ=$G(^ORD(100.02,+$P(ACTION,U,12),0))
 . S CNT=CNT+1,ORY(CNT)="     Nature of Order:   "_$P(ORZ,U)
 . I "^V^P^"[(U_$P(ORZ,U,2)_U),$P(ACTION,U,16) S CNT=CNT+1,ORY(CNT)="     Released by:       "_$$USER(+$P(ACTION,U,17))_" on "_$$DATE($P(ACTION,U,16))
 I $P(ACTION,U,5) S CNT=CNT+1,ORY(CNT)="     Elec Signature:    "_$$USER(+$P(ACTION,U,5))_" on "_$$DATE($P(ACTION,U,6))
 I '$P(ACTION,U,5) D
 . S:$P(ACTION,U,3) CNT=CNT+1,ORY(CNT)="     Ordered by:        "_$$USER(+$P(ACTION,U,3))
 . S:$L($P(ACTION,U,4)) CNT=CNT+1,ORY(CNT)="     Signature:         "_$$SIG($P(ACTION,U,4))
 I $P(ACTION,U,8) S CNT=CNT+1,ORY(CNT)="     Nurse Verified:    "_$$USER(+$P(ACTION,U,8))_" on "_$$DATE($P(ACTION,U,9))
 I $P(ACTION,U,10) S CNT=CNT+1,ORY(CNT)="     Clerk Verified:    "_$$USER(+$P(ACTION,U,10))_" on "_$$DATE($P(ACTION,U,11))
 I $P(ACTION,U,18) S CNT=CNT+1,ORY(CNT)="     Chart Reviewed:    "_$$USER(+$P(ACTION,U,18))_" on "_$$DATE($P(ACTION,U,19))
 I $L($G(^OR(100,ORIFN,8,ORI,1))) S CNT=CNT+1,ORY(CNT)="     "_$S($P(ACTION,U,2)="DC":"Reason for DC:     ",1:"Comments:          ")_^(1)
 E  I $P(ACTION,U,2)="DC",$L(OR6) S X=$S($L($P(OR6,U,5)):$P(OR6,U,5),$P(OR6,U,4):$P(^ORD(100.03,+$P(OR6,U,4),0),U),$P(OR6,U):$P(^ORD(100.02,+$P(OR6,U),0),U),1:"") S:$L(X) CNT=CNT+1,ORY(CNT)="     Reason for DC:     "_X
A1 I $D(^OR(100,ORIFN,8,ORI,5)) D  ; ward comments
 . N X,ORJ K ^UTILITY($J,"W")
 . S ORJ=0 F  S ORJ=$O(^OR(100,ORIFN,8,ORI,5,ORJ)) Q:ORJ'>0  S X=^(ORJ,0) D ^DIWP
 . S ORJ=0 F  S ORJ=$O(^UTILITY($J,"W",DIWL,ORJ)) Q:ORJ'>0  S CNT=CNT+1,ORY(CNT)=$S(ORJ=1:"     Ward Comments:     ",1:"                        ")_^(ORJ,0)
 . K ^UTILITY($J,"W")
 I $P(ACTION,U,2)="HD",$G(^OR(100,ORIFN,8,ORI,2)) S X2=^(2),CNT=CNT+1,ORY(CNT)="     Hold Released:     "_$$FMTE^XLFDT($P(X2,U),"2P")_" by "_$$USER($P(X2,U,2))
A2 I $D(^OR(100,ORIFN,8,ORI,3)) D  ; un-/flagged
 . N X S X=$G(^OR(100,ORIFN,8,ORI,3))
 . S CNT=CNT+1,ORY(CNT)="     Flagged by:        "_$$USER(+$P(X,U,4))_" on "_$$DATE($P(X,U,3))
 . S CNT=CNT+1,ORY(CNT)="                        "_$P(X,U,5)
 . Q:X  S CNT=CNT+1,ORY(CNT)="     Unflagged by:      "_$$USER(+$P(X,U,7))_" on "_$$DATE($P(X,U,6))
 . S CNT=CNT+1,ORY(CNT)="                        "_$P(X,U,8)
 Q
 ;
DC ; -- Add Reason for DC
 S CNT=CNT+1,ORY(CNT)=$$DATE($P(OR6,U,3))_"  Discontinued"_$S($P(OR6,U,2):" by "_$$USER($P(OR6,U,2)),1:"")
 N X S X=$S($L($P(OR6,U,5)):$P(OR6,U,5),$P(OR6,U,4):$P(^ORD(100.03,+$P(OR6,U,4),0),U),$P(OR6,U):$P(^ORD(100.02,+$P(OR6,U),0),U),1:"") S:$L(X) CNT=CNT+1,ORY(CNT)="     Reason for DC:     "_X
 Q
 ;
ACTION(CODE) ; -- Return name of action CODE
 S NAME=$S(CODE="NW":"New Order",CODE="DC":"Discontinue",CODE="HD":"Hold",1:"")
 I CODE="NW",$P(OR3,U,11) S NAME=NAME_$S($P(OR3,U,11)=1:" (Change)",$P(OR3,U,11)=2:" (Renewal)",1:"")
 Q NAME
 ;
DATE(X) ; -- Return date formatted as 00/00/00 00:00
 N T,Y  S T=$P(X,".",2)_"0000"
 S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" "_$E(T,1,2)_":"_$E(T,3,4)
 Q Y
 ;
USER(X) ; -- Returns NAME (TITLE) of New Person X
 N X0,Y S X0=$G(^VA(200,+X,0)),Y=$P(X0,U)
 S:$P(X0,U,9) Y=Y_" ("_$E($P($G(^DIC(3.1,+$P(X0,U,9),0)),U),1,15)_")"
 Q Y
 ;
SIG(X) ; -- Returns text of signature status X
 N Y S Y=""
 I X=0 S Y="ON CHART WITH WRITTEN ORDERS"
 I X=1 S Y="ELECTRONICALLY SIGNED"
 I X=2 S Y="NOT SIGNED"
 I X=3 S Y="NOT REQUIRED"
 I X=4 S Y="ON CHART WITH PRINTED ORDERS"
 I X=5 S Y="NOT REQUIRED DUE TO SERVICE CANCEL"
 I X=6 S Y="SERVICE CORRECTION TO SIGNED ORDER"
 Q Y
