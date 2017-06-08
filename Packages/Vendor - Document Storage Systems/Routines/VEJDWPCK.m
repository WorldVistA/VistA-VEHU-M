VEJDWPCK ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;ORCXPND2 ; SLC/MKB - Expanded display cont ;2/12/97  11:50
XRAY ; -- Single xray report per procedure
 N CASE,PROC
 S CASE=0 F  S CASE=$O(^TMP($J,"RAE2",+ORVP,CASE)) Q:CASE'>0  D
 . S PROC="" F  S PROC=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC)) Q:PROC=""  D ITEM^VEJDWPCJ(PROC),BLANK^VEJDWPCJ,XRPT,BLANK^VEJDWPCJ
 Q
 ;
XRPT ; -- body of report for CASE, PROC
 N NODE,ST,ORD,X,I S ORD=$G(^TMP($J,"RAE2",+ORVP,"ORD"))
 I $L(ORD),ORD'=PROC S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Procedure Ordered: "_ORD D BLANK^VEJDWPCJ
 I $G(EXAMDATE) S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Exam Date: "_$$DATETIME^VEJDWPCO(EXAMDATE) D BLANK^VEJDWPCJ
 I $D(CASENMBR) D  ; Case number(s)
 . S X="" I $G(CASENMBR)<0 S X=$P(CASENMBR,U,2)
 . E  S I="" F  S I=$O(CASENMBR(I)) Q:I=""  S X=X_$S($L(X):", ",1:"")_I
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Case #: "_X D BLANK^VEJDWPCJ
 S X="Exam Modifiers: " I '$O(^TMP($J,"RAE2",+ORVP,CASE,PROC,"M",0)) S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X_"none"
 E  S I=0 F  S I=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC,"M",I)) Q:I'>0  S X=X_^(I),LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X,X="                "
 D BLANK^VEJDWPCJ S NODE=$G(^TMP($J,"RAE2",+ORVP,CASE,PROC)),ST=$P(NODE,U)
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Report Status: "_ST
 Q:$$UP^XLFSTR(ST)="NO REPORT"
 I $P(NODE,U,2)="Y" S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="            ** ABNORMAL RESULTS **" D:$D(IOINHI) CNTRL^VALM10(LCNT,13,22,IOINHI,IOINORM)
 D XRTEXT("Clinical History: ","H")
 D XRTEXT("Report: ","R")
 D XRTEXT("Impression: ","I")
 D XRTEXT("Diagnostic Code: ","D"),BLANK^VEJDWPCJ
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Verified by: "_$P($G(^TMP($J,"RAE2",+ORVP,CASE,PROC,"V")),U,2)
 Q
 ;
XRTEXT(CAPTION,SUB) ; -- include wp text
 N I D BLANK^VEJDWPCJ
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=CAPTION
 S I=0 F  S I=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC,SUB,I)) Q:I'>0  S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=^(I)
 Q
