VEJDWPBX ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ; slc/STAFF - Functions which return patient medication data ;12/15/97 [ 04/02/97  3:52 PM ]
 ;ORQQPS;3.0;ORDER ENTRY/RESULTS REPORTING;**9**;Dec 17, 1997
 Q
NUMRX(DFN) ;extrinsic funct returns number of active meds patient is taking
 N NUMRX,ORPTYPE,ORX,ORY,ORS,ORNUM,ORPRENEW
 S NUMRX=0
 Q:+$G(DFN)<1 NUMRX
 ;
 ;check to determine if inpatient or outpatient:
 D ADM^VADPT2
 S ORPTYPE=$S(+$G(VADMVT)>0:"I",1:"O")
 ;
 K ^TMP("PS",$J)
 D OCL^VEJDWPBY(DFN,"","")  ;if no date range, returns active meds for pt
 N X
 S X=0
 F  S X=$O(^TMP("PS",$J,X)) Q:X<1  D
 .S ORX=$G(^TMP("PS",$J,X,0))
 .S ORY=$P(ORX,U)
 .S ORNUM=$P(ORX,U,8) ;order entry order number
 .S ORS=$P(ORX,U,9) ;medication status from pharmacy
 .S ORPRENEW=$P(ORX,U,14)  ;pending renewal flag (1: pending renewal)
 .Q:+ORX<1
 .Q:$P(ORY,";",2)'=ORPTYPE  ;quit if med is not pt type (inpt/outpt)
 .;quit if status is a non-active type:
 .Q:$G(ORS)="EXPIRED"
 .Q:$G(ORS)["DISCONTINUE"
 .Q:$G(ORS)="DELETED"
 .Q:+$G(ORPRENEW)>0
 .Q:$$SUPPLY($$OI^ORQOR2(ORNUM))=1  ;quit if a supply
 .S NUMRX=NUMRX+1
 K ^TMP("PS",$J)
 Q NUMRX
LIST(ORY,ORPT,ORSTRTDT,ORSTOPDT) ;return pt's condensed medication list
 ;id^nameform^stop date^route^schedule/infusion rate^refills remaining
 K ^TMP("PS",$J),^TMP("PSS",$J)
 D OCL^VEJDWPBY(ORPT,ORSTRTDT,ORSTOPDT)
 N I,J,K,X,Z,ZZ,NODE,RSORT,NAME,SCH,MDR,RATE,TYPE,ADD,SOL,IVX
 S I=0,X=0,NODE=0,SCH="",MDR=""
 F  S X=$O(^TMP("PS",$J,X)) Q:X<1  D
 .Q:+$P(^TMP("PS",$J,X,0),U)<1
 .S TYPE=$P(^TMP("PS",$J,X,0),U)
 .I +$G(^TMP("PS",$J,X,"MDR",0))>0 D  ;get abbrev med route
 ..S ZZ=^TMP("PS",$J,X,"MDR",0) F Z=1:1:ZZ D
 ...I Z=1 S MDR=^TMP("PS",$J,X,"MDR",Z,0)
 ...E  S MDR=MDR_", "_^TMP("PS",$J,X,"MDR",Z,0)
 .I +$G(^TMP("PS",$J,X,"SCH",0))>0 D  ;get schedule
 ..S ZZ=^TMP("PS",$J,X,"SCH",0) F Z=1:1:ZZ D
 ...I Z=1 S SCH=^TMP("PS",$J,X,"SCH",Z,0)
 ...E  S SCH=SCH_", "_^TMP("PS",$J,X,"SCH",Z,0)
 .;
 .I TYPE["I",+$G(^TMP("PS",$J,X,"B",0))>0 D  ;IV meds - get solution
 ..S ZZ=^TMP("PS",$J,X,"B",0) F Z=1:1:ZZ D
 ...I Z=1 S SOL=$P(^TMP("PS",$J,X,"B",Z,0),U)_" "_$P(^(0),U,2)
 ...E  S SOL=SOL_", "_$P(^TMP("PS",$J,X,"B",Z,0),U)_" "_$P(^(0),U,2)
 ..I +$G(^TMP("PS",$J,X,"A",0))>0 D  ;get additive
 ...S ZZ=^TMP("PS",$J,X,"A",0) F Z=1:1:ZZ D
 ....S ADD=$P(^TMP("PS",$J,X,"A",Z,0),U)_" "_$P(^(0),U,2)
 ....S NAME=ADD_" in "_$G(SOL)
 ....S RSORT=9999999-$P(^TMP("PS",$J,X,0),U,4)_$P(^(0),U)_NAME
 ....S ^TMP("PSS",$J,RSORT)=$P(^TMP("PS",$J,X,0),U)_U_NAME_U_$P(^(0),U,4)_U_$G(MDR)_U_$P(^(0),U,3)
 ..E  D
 ...S NAME=$G(SOL)
 ...S RSORT=9999999-$P(^TMP("PS",$J,X,0),U,4)_$P(^(0),U)
 ...S ^TMP("PSS",$J,RSORT)=$P(^TMP("PS",$J,X,0),U)_U_NAME_U_$P(^(0),U,4)_U_$G(MDR)_U_$P(^(0),U,3)
 .;
 .I TYPE["I",'(+$G(^TMP("PS",$J,X,"B",0))>0) D  ;unit dose inpatient meds
 ..S RSORT=9999999-$P(^TMP("PS",$J,X,0),U,4)_$P(^(0),U)_$P(^(0),U,2)
 ..S ^TMP("PSS",$J,RSORT)=$P(^TMP("PS",$J,X,0),U)_U_$P(^(0),U,2)_U_$P(^(0),U,4)_U_$G(MDR)_U_$G(SCH)
 .;
 .I TYPE["O" D  ;outpatient meds
 ..S RSORT=9999999-$P(^TMP("PS",$J,X,0),U,4)_$P(^(0),U)_$P(^(0),U,2)
 ..S ^TMP("PSS",$J,RSORT)=$P(^TMP("PS",$J,X,0),U)_U_$P(^(0),U,2)_U_$P(^(0),U,4)_U_$G(MDR)_U_$G(SCH)_U_$P(^(0),U,5)
 .;
 ;
 F  S NODE=$O(^TMP("PSS",$J,NODE)) Q:NODE<1  D
 .S I=I+1
 .S ORY(I)=^TMP("PSS",$J,NODE)
 S:+$G(ORY(1))<1 ORY(1)="^No medications found."
 K ^TMP("PS",$J),^TMP("PSS",$J)
 Q
DETAIL(ORY,ORPT,ORMED) ; return detailed information for a drug
 K ^TMP("PS",$J)
 D OEL^VEJDWPBY(ORPT,ORMED)
 N I,J,CR,X,Z,ZZ,MDR,SCH,SIG,COM,ADD,SOL,DATE,TYPE
 S I=0,J=1,CR=$CHAR(13),DATE=""
 S TYPE=$P(ORMED,";",2)
 S X=$G(^TMP("PS",$J,0))
 I '$L($G(X)) S ORY(J)="No detailed information found." Q
 S ORY(J)="     "_$P(X,U)
 ;get abbreviated med route(s):
 I +$G(^TMP("PS",$J,"MDR",0))>0 D
 .S ZZ=^TMP("PS",$J,"MDR",0) F Z=1:1:ZZ D
 ..I Z=1 S MDR=^TMP("PS",$J,"MDR",Z,0)
 ..E  S MDR=MDR_", "_^TMP("PS",$J,"MDR",Z,0)
 I $L($G(MDR)) S ORY(J)=ORY(J)_"  "_MDR
 S ORY(J)=ORY(J)_"  "_$P(X,U,2)
 ; get schedule(s):
 I +$G(^TMP("PS",$J,"SCH",0))>0 D
 .S ZZ=^TMP("PS",$J,"SCH",0) F Z=1:1:ZZ D
 ..I Z=1 S SCH=^TMP("PS",$J,"SCH",Z,0)
 ..E  S SCH=SCH_", "_^TMP("PS",$J,"SCH",Z,0)
 I $L($G(SCH)) S ORY(J)=ORY(J)_"  "_SCH
 S ORY(J)=ORY(J),J=J+1
 ; get SIG(s):
 I +$G(^TMP("PS",$J,"SIG",0))>0 D
 .S ZZ=^TMP("PS",$J,"SIG",0) F Z=1:1:ZZ D
 ..I Z=1 S SIG=^TMP("PS",$J,"SIG",Z,0)
 ..E  S SIG=SIG_", "_^TMP("PS",$J,"SIG",Z,0)
 I $L($G(SIG)) S ORY(J)="        "_SIG,J=J+1
 S ORY(J)=" ",J=J+1
 ; get solution(s):
 I +$G(^TMP("PS",$J,"B",0))>0 D
 .S ZZ=^TMP("PS",$J,"B",0) F Z=1:1:ZZ D
 ..S SOL=^TMP("PS",$J,"B",Z,0),ORY(J)="        "_$P(SOL,U)_" "_$P(SOL,U,2),J=J+1
 ; get additive(s):
 I +$G(^TMP("PS",$J,"A",0))>0 D
 .S ZZ=^TMP("PS",$J,"A",0) F Z=1:1:ZZ D
 ..S ADD=^TMP("PS",$J,"A",Z,0)
 ..S ORY(J)="        "_$P(ADD,U)
 ..S IVX=$P(ADD,U,2)
 ..S ORY(J)=ORY(J)_$S($D(IVX):" "_IVX,1:"")_" "_$P(ADD,U,3),J=J+1
 I $L($G(SOL))!($L($G(ADD))) S ORY(J)=" ",J=J+1
 ; get other information:
 S ORY(J)="           Status: "_$P(X,U,6),J=J+1
 S DATE=$P(X,U,5) I $L($G(DATE)) D
 .D DT^DILF("ET",DATE,.DATE,"","")
 S ORY(J)="       Start date: "_$G(DATE(0)),J=J+1
 S DATE=$P(X,U,3) I $L($G(DATE)) D
 .D DT^DILF("ET",DATE,.DATE,"","")
 S ORY(J)="        Stop date: "_$G(DATE(0)),J=J+1
 I TYPE="O" D  ; if outpatient med
 .S ORY(J)="Refills remaining: "_$P(X,U,4),J=J+1
 .S ORY(J)="      Days supply: "_$P(X,U,7),J=J+1
 .S ORY(J)="         Quantity: "_$P(X,U,8),J=J+1
 .S ORY(J)=" ",J=J+1
 S ORY(J)="Comments:",J=J+1
 S I=0 F  S I=$O(^TMP("PS",$J,"PC",I)) Q:'I  D
 .S ORY(J)=^TMP("PS",$J,"PC",I,0),J=J+1
 K ^TMP("PS",$J)
 Q
SUPPLY(OI) ;extrinsic function returns 1 (true) if the orderable item is
 ; a supply
 Q:+$G(OI)<1 ""
 N OITEXT
 S OITEXT=$G(^VEJ(101.43,OI,0))
 Q:'$L(OITEXT) ""
 S OITEXT=$P(OITEXT,U)
 Q:$D(^VEJ(101.43,"S.SPLY",OITEXT)) 1
 Q ""
