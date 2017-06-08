DENTVA3 ;DSS/KC - DRM SITTING AND VISITS REPORT;10/20/2003 11:26
 ;;1.2;DENTAL;**43,45,47,59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 3744       x      $$TESTPAT^VADPT 
 ;
PSIT(RET) ; Sitting/Visits Report by Provider - called by DENTVAU
 ; Returns array with counts
 ;^TMP("DENT",$J,prov)=PROV NAME^inpt visit^outpt visit^inpt sitting^outpt sitting^total procedures
 ;OR
 ;^TMP("DENT",$J,1)="No data for the selected criteria"
 ;
 N IEN,NODE,CNT,CAT,F,X,PROV,I,P,PCODE,IP,IDT,STOT,VTOT,XREF,DEN,TOT K ^TMP("DENTVR",$J)
 I $G(DATA("PROV"))'="ALL" S PROV=$G(DATA("PROV")),I=1 F  Q:'$P(PROV,U,I)  D
 .S P=+$P(PROV,U,I),P=P_";"_$P($G(^DENT(220.5,+$O(^DENT(220.5,"B",P,0)),0)),U,4)
 .I $P(P,";",2) S $P(PROV,U,I)=P
 .S I=I+1
 .Q
 I $G(DATA("PROV"))="ALL" D GETP^DENTVA1
 I +PROV=0 S @RET@(1)="-1^Invalid Provider" Q
 I $G(@RET@(1))]"" Q
 S I=0,EDT=EDT_.9,XREF=$S($G(DENV)=0:"AP",1:"AG")
 F  S I=I+1,IP=$P(PROV,U,I),PCODE="X"_$P(IP,";",2),IP=+IP Q:IP=0  D
 .S IDT=SDT-.0001,STOT=0,VTOT=0,F=0
 .F  S IDT=$O(^DENT(228.1,XREF,IP,IDT)) Q:'IDT!(IDT>EDT)  D
 ..S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IP,IDT,IEN)) Q:'IEN  D
 ...S NODE=$G(^DENT(228.1,IEN,0)) Q:+$G(^DENT(228.1,IEN,1))  ;quit if deleted
 ...I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 ...I STN,$P(NODE,U,18)'=STN Q  ;quit if station doesn't match
 ...S TOT=$$TXN^DENTVA4(1) I +TOT=0 Q  ;no transactions for this encounter
 ...S CAT=$P(NODE,U,13) I CAT="" S F=F+1 Q  ;count missing cat's and quit
 ...S X=$S(CAT<9:1,1:2)
 ...S DEN=$G(@RET@(PCODE)) S:DEN="" DEN=$S($G(PROVIDEN):$$PNAM^DENTVAU($E(PCODE,2,9)),1:$E(PCODE,2,9))
 ...S $P(DEN,U,3+X)=$P(DEN,U,3+X)+1 ;sittings
 ...S $P(DEN,U,6)=$P(DEN,U,6)+$P(TOT,U,2)
 ...I '$D(^TMP("DENTVR",$J,PCODE,+$P(NODE,U,5))) D
 ....S ^TMP("DENTVR",$J,PCODE,+$P(NODE,U,5))=""
 ....S $P(DEN,U,1+X)=$P(DEN,U,1+X)+1 ;visits
 ....Q
 ...S @RET@(PCODE)=DEN
 ...Q
 ..Q
 .Q
 K ^TMP("DENTVR",$J)
 I '$D(@RET) K @RET S @RET@(1)="-1^No data for the selected criteria" Q
 Q
 ;
FEE(RET) ; Dental Fee Basis Report - called by DENTVAU - contains detail data
 N IEN,X,FB,CP,TOT,I,J,COST,DEN,SSN,NAM
 I STN S STN=$G(DATA("STN")),STN=$O(^DENT(225,"B",STN,0)) ; reset station to DENTAL SITE PARAM#
 S SDT=SDT-.0001,TOT=0,COST=0,EDT=EDT_.9 F I=1,2,3,5:1:9 S @RET@(I)=$$DESC(I)_"^^"
 F  S SDT=$O(^DENT(228.5,"AD",SDT)) Q:'SDT!(SDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.5,"AD",SDT,IEN)) Q:'IEN  D
 ..S FB=$G(^DENT(228.5,IEN,0)) Q:FB=""!(STN&($P(FB,U,5)'=STN))!($P(FB,U,9))
 ..I $$TESTPAT^VADPT(+$P(FB,U,4)) Q  ;test pt, don't count
 ..S CP=$P(FB,U,6)-8 I CP<1!(CP>9) Q
 ..S X=$G(@RET@(CP)) I X="" S X=$$DESC(CP)
 ..S $P(X,U,2)=+$P(X,U,2)+1,$P(X,U,3)=+$P(X,U,3)+$P(FB,U,8)
 ..S @RET@(CP)=X,TOT=TOT+1,COST=COST+$P(FB,U,8)
 ..S DEN="$^"_$$FMTE^XLFDT($P(FB,U,7))_U
 ..S SSN=$E($$GET1^DIQ(2,$P(FB,U,4)_",",.09),6,10)
 ..S NAM=$$GET1^DIQ(2,$P(FB,U,4)_",",.01),NAM=$E(NAM,1,18)_" "_SSN
 ..S DEN=DEN_NAM_U_$P(FB,U,8)
 ..S @RET@(CP,IEN)=DEN
 ..Q
 .Q
 I 'TOT K @RET S @RET@(1)="-1^No data for the selected criteria" Q
 F I=1,2,3,5:1:9 S Y=@RET@(I) I Y D
 .S $P(Y,U,3)=$P(Y,U,4)/$P(Y,U,2) F J=3,4 S $P(Y,U,J)=$FN($P(Y,U,J),",",2)
 .S @RET@(I)=Y
 .Q
 S Y=TOT_U_(COST/TOT)_U_COST F J=2,4 S $P(Y,U,J)=$FN($P(Y,U,J),",",2)
 S @RET@(10)="TOTAL^"_Y
 Q
DESC(CP) ;get the description for the classification
 Q $S(CP=1:"CLASS I",CP=2:"CLASS II",CP=3:"CLASS IIA",CP=4:"CLASS IIB",CP=5:"CLASS IIC",CP=6:"CLASS III",CP=7:"CLASS IV",CP=8:"CLASS V",CP=9:"CLASS VI",1:"UNK")
 ;
UNF(RET) ; Unfiled Data Report - called by DENTVAU
 ;PROVIDEN comes from calling routine DENTVAU
 N PROV,I,P,CNT,IP,PCODE,IDT,IEN,NAM,SSN,VIEN,DFN,NODE,PNAM,DPAT,PTCT,IEN2,NEWER,N0,INAC
 I $G(DATA("PROV"))'="ALL" S PROV=$G(DATA("PROV")),I=1 F  Q:'$P(PROV,U,I)  D
 .S P=+$P(PROV,U,I),P=P_";"_$E($$PROV^DENTVA6(P),2,9)
 .I $P(P,";",2)]"" S $P(PROV,U,I)=P
 .S I=I+1
 .Q
 I $G(DATA("PROV"))="ALL" D GETP^DENTVA1
 I +PROV=0 S @RET@(1)="-1^Invalid Provider" Q
 I $G(@RET@(1))]"" Q
 S I=0,CNT=0,PTCT=0
 F  S I=I+1,IP=$P(PROV,U,I),PCODE="X"_$P(IP,";",2),IP=+IP Q:IP=0  D
 .I $G(PROVIDEN) S PNAM=$$PNAM^DENTVAU($E(PCODE,2,9))
 .E  S PNAM=PCODE
 .S DPAT=0 F  S DPAT=$O(^DENT(228.7,"AC",IP,DPAT)) Q:'DPAT  D
 ..I $$TESTPAT^VADPT(DPAT) Q  ;test patient
 ..S SSN=$E($$GET1^DIQ(2,DPAT_",",.09),6,10)
 ..S NAM=$$GET1^DIQ(2,DPAT_",",.01) I NAM="" S NAM="Unknown"
 ..;S NAM=$E(NAM,1,18)_" "_SSN
 ..S IEN=0 F  S IEN=$O(^DENT(228.7,"AC",IP,DPAT,IEN)) Q:'IEN  D
 ...S N0=$G(^DENT(228.7,IEN,0)),CNT=CNT+1
 ...;Patch 59 additions by BPD
 ...N UNFDT S (UNFDT,IEN2)=$P(N0,U,4)
 ...S NEWER=""
 ...F IEN2=$O(^DENT(228.1,"AE",DPAT,IEN2)) Q:'IEN2  D 
 ....S:IEN2>UNFDT NEWER="Yes" Q:NEWER="Yes"
 ...S INAC=$$GET1^DIQ(228.7,IEN_",",.05)
 ...;Return will return Provider Name^Patient Name^Date of Unfiled Data^Yes (if newer work exists^IEN of unfiled data^Inactive flag
 ...S @RET@(PNAM,NAM,IEN)=PNAM_U_$E(NAM,1,18)_" ("_$E(NAM)_SSN_")"_U_$$FMTE^XLFDT($P(N0,U,4)\1)_U_NEWER_U_IEN_U_INAC
 ..Q
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 S @RET@(0)="$START"_U_CNT
 Q
