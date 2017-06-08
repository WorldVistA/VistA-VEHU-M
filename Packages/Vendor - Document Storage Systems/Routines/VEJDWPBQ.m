VEJDWPBQ ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;; slc/CLA - Functions which return order information ;12/15/97 [ 04/02/97  3:01 PM ]
 ; ORQOR1;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
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
 D EN^VEJDWPBR(PATIENT,GIEN,FLAG,"",SDT,EDT,1,0)
 N J,HOR,SEQ,X S J=1,HOR=0,SEQ=0
 S HOR=$O(^TMP("ORR",$J,HOR)) Q:+HOR<1
 F  S SEQ=$O(^TMP("ORR",$J,HOR,SEQ)) Q:+SEQ<1  D
 .S X=^TMP("ORR",$J,HOR,SEQ)
 .S ORY(J)=$P(X,U)_U_$E(^TMP("ORR",$J,HOR,SEQ,"TX",1),1,60)_U_$P(X,U,4)_U_$P(X,U,6),J=J+1
 K ^TMP("ORR",$J)
 S:+$G(ORY(1))<1 ORY(1)="^No orders found."
 Q
DETAIL(ORY,ORDER) ; return details for an order:
 D DETAIL^VEJDWPBS(.ORY,ORDER)
 Q
STATI(ORY) ; return stati from ORDER STATUS file [#100.01]
 N STATUS,IEN,I S STATUS="",IEN=0,I=1
 F  S STATUS=$O(^ORD(100.01,"B",STATUS)) Q:STATUS=""  D
 .S IEN=$O(^ORD(100.01,"B",STATUS,IEN)),ORY(I)=IEN_"^"_STATUS
 .S IEN=0,I=I+1
 Q
DG(DGNAME) ; extrinsic function returns display group ien
 Q:'$L($G(DGNAME)) ""
 N DGIEN S DGIEN=0
 S DGIEN=$O(^ORD(100.98,"B",DGNAME,DGIEN))
 Q +$G(DGIEN)
OI(OINAME) ; extrinsic function returns orderable item ien
 Q:'$L($G(OINAME)) ""
 N OI S OI=""
 S OI=$O(^VEJ(101.43,"B",OINAME,OI))
 Q +$G(OI)
TEXTSTAT(ORNUM) ;extrinsic function returns the first 200 chars of order text
 ;and order status in format: <order text>^<order status>
 ;ORNUM - order number (main order number - $P(ORNUM,";",1))
 S ORNUM=+ORNUM
 Q:'$L($G(ORNUM)) ""
 Q:'$L($G(^OR(100,ORNUM,0))) ""
 N ORSTATUS,ORY
 ; blj/dss 14/6/2000  Routine ^VEORQ12 is no longer present.
 ; D TEXT^VEORQ12(.ORY,ORNUM,200)
 Q:+$G(ORY)<1 "Order text not found.^"
 S ORSTATUS=$P(^OR(100,ORNUM,3),U,3)
 S ORSTATUS=$G(^ORD(100.01,+ORSTATUS,0))
 S ORSTATUS=$P(ORSTATUS,U)
 Q ORY(1)_U_ORSTATUS
