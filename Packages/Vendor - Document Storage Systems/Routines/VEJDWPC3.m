VEJDWPC3 ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;3.0;ORDER ENTRY/RESULTS REPORTING;Dec 17, 1997
 ;ORQOR1  slc/CLA - Functions which return order information ;12/15/97
LIST(ORY,PATIENT,GROUP,FLAG,SDT,EDT) ;return list of patient orders
 ; return PATIENT's orders for a display GROUP of type FLAG
 ; between start (SDT) and end dates (EDT)
 ; dates can be in Fileman or T, T-14 formats
 N GIEN S GIEN=""
 I $L($G(SDT)) D DT^DILF("T",SDT,.SDT,"","")
 I $L($G(EDT)) D DT^DILF("T",EDT,.EDT,"","")
 I (SDT=-1)!(EDT=-1) S ORY(1)="^Error in date range." Q
 S PATIENT=PATIENT_";DPT("
 S:$L($G(GROUP)) GIEN=$O(^ORD(100.98,"B",GROUP,GIEN))
 K ^TMP("ORR",$J)
 D EN^VEJDWPC4(PATIENT,GIEN,FLAG,"",SDT,EDT,1,0)
 N J,HOR,SEQ,X S J=1,HOR=0,SEQ=0
 S HOR=$O(^TMP("ORR",$J,HOR)) Q:+HOR<1
 F  S SEQ=$O(^TMP("ORR",$J,HOR,SEQ)) Q:+SEQ<1  D
 .S X=^TMP("ORR",$J,HOR,SEQ)
 .S ORY(J)=$P(X,U)_U_$E(^TMP("ORR",$J,HOR,SEQ,"TX",1),1,60)_U_$P(X,U,4)_U_$P(X,U,6),J=J+1
 K ^TMP("ORR",$J)
 S:+$G(ORY(1))<1 ORY(1)="^No orders found."
 Q
