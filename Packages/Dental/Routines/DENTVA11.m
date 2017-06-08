DENTVA11 ;DSS/KC - DRM SUMMARY REPORTS USING RVU;11/18/2003 13:26
 ;;1.2;DENTAL;**43,45,50,53**;Aug 10, 2001;Build 10
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 3744       x      $$TESTPAT^VADPT 
 ; 
 ;This routine collects RVU, VA-DSS Product line information
 ;vs. the CTV, DAS Category information in DENTVA1.
 ;
 ;^DENT(228.2,"AP", is visit date xref
 ;^DENT(228.2,"AG", is create date xref
 ;
PROV(RET) ; Provider Summary Report called by DENTVAU
 I $G(DATA("DISTPROV")) D PROV^DENTVA12(.RET) Q  ;P50
 N I,PROV,IP,IDT,IEN,PCODE,TOT,XREF,P
 I $G(DATA("PROV"))'="ALL" S PROV=$G(DATA("PROV")),I=1 F  Q:'$P(PROV,U,I)  D
 .S P=+$P(PROV,U,I),P=P_";"_$E($$PROV^DENTVA6(P),2,9)
 .I $P(P,";",2)]"" S $P(PROV,U,I)=P
 .S I=I+1
 .Q
 I $G(DATA("PROV"))="ALL" D GETP^DENTVA1
 I +PROV=0 S @RET@(1)="-1^Invalid Provider" Q
 I $G(@RET@(1))]"" Q
 S I=0,CNT=0,EDT=EDT_.9,XREF=$S($G(DENV)=0:"AP",1:"AG")
 F  S I=I+1,IP=$P(PROV,U,I),PCODE="X"_$P(IP,";",2),IP=+IP Q:IP=0  S TOT=0 D
 .S IDT=SDT-.0001 F  S IDT=$O(^DENT(228.1,XREF,IP,IDT)) Q:'IDT!(IDT>EDT)  D
 ..S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IP,IDT,IEN)) Q:'IEN  D HST
 ..Q
 .; handle duplicate provider numbers going to the same report (based on prov#)
 .I $P($G(@RET@(PCODE)),U,3) S:TOT $P(@RET@(PCODE),U,3)=$P(@RET@(PCODE),U,3)+TOT Q
 .I TOT S @RET@(PCODE)="$START"_U_$S($G(PROVIDEN):$$PNAM^DENTVAU($E(PCODE,2,9)),1:$E(PCODE,2,9))_U_TOT
 .E  K @RET@(PCODE) Q
 .Q
 K ^TMP("DENTPAT",$J),^TMP("DENTVIS",$J)
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 Q
 ;
CLINIC(RET) ; Clinic Summary Report called by DENTVAU
 N I,IDT,IEN,PCODE,TOT,XREF
 S PCODE=+STN,IDT=SDT-.0001,CNT=0,TOT=0,EDT=EDT_.9,XREF=$S($G(DENV)=0:"AS",1:"AF")
 F  S IDT=$O(^DENT(228.1,XREF,IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IDT,IEN)) Q:'IEN  D HST
 .Q
 K ^TMP("DENTPAT",$J),^TMP("DENTVIS",$J)
 I TOT S @RET@(PCODE)="$START"_U_$S($G(DATA("STN"))]"":DATA("STN"),1:STN)_U_TOT
 E  S @RET@(1)="-1^No data for the selected criteria" Q
 Q
 ;
HST ;process history records
 N NODE,CAT,CNT,VIS,LSTAT
 S NODE=$G(^DENT(228.1,IEN,0)),CAT=+$P(NODE,U,13) Q:'CAT  Q:+$G(^DENT(228.1,IEN,1))
 I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 I PTYP<3,'$D(^TMP("DENTPAT",$J,+$P(NODE,U,2))) D PATSTA^DENTVA1
 I PTYP<3,PTYP'=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) Q  ;not selected pt status
 I PTYP=4 S X=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) I "02"'[X Q  ;act/maint only
 I STN,$P(NODE,U,18)'=STN Q  ;not selected station/facility
 S CNT=0 D TXN I CNT=0 Q  ;no txns to add to totals
 S VIS=$S($P(NODE,U,5):$P(NODE,U,5),1:IEN)
 I '$D(^TMP("DENTVIS",$J,VIS)) S ^TMP("DENTVIS",$J,VIS)="",TOT=TOT+1 ;add to total visits
 Q
 ;
TXN ; get the transaction data for this ENCOUNTER, 
 ; don't process txns if this patient doesn't match pat type selected
 ; don't process if no ADA code, not a txn, or deleted
 N COST,TXN,X0,X1,FLD,SFLD,RVU S TXN=0
 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1))
 .I X0=""!($P(X0,U,4)="")!($P(X0,U,29)'=1)!($P(X1,U,3)) Q
 .I TTYP'[(","_$P(X0,U,12)_",") Q  ;only want certain statuses
 .I $P(X0,U,9)=23,$P(X0,U,22)>1 Q  ;only count the first tooth for partials 6.25.2004 KC
 .S FLD=$$FLD(CATG) I FLD="" Q
 .S CNT=CNT+1,SFLD=$P(FLD," ",1)
 .S RVU=""
 .I IDT>3061001 S RVU=$P($G(^DENT(228,+$P(X0,U,4),0)),U,18) ;P50 12.28.06
 .I RVU="" S RVU=$P(X1,U,12)
 .S $P(@RET@(PCODE,SFLD),U,CAT)=+$P($G(@RET@(PCODE,SFLD)),U,CAT)+1 ;CAT TOTAL
 .S $P(@RET@(PCODE,SFLD),U,23)=+$P($G(@RET@(PCODE,SFLD)),U,23)+1 ;PROC TOTAL
 .S $P(@RET@(PCODE,SFLD),U,24)=+$P($G(@RET@(PCODE,SFLD)),U,24)+RVU ;RVU TOTAL
 .I $P(@RET@(PCODE,SFLD),U,25)="" S $P(@RET@(PCODE,SFLD),U,25)=$S($E(FLD)'="X":FLD,1:$E(FLD,2,99))
 .I $P(X0,U,4) S COST=$P($G(^DENT(228,+$P(X0,U,4),1)),U,14,15) I $L(COST)>1 D
 ..S $P(@RET@(PCODE,SFLD),U,26)=+$P($G(@RET@(PCODE,SFLD)),U,26)+COST ;va cost total
 ..S $P(@RET@(PCODE,SFLD),U,27)=+$P($G(@RET@(PCODE,SFLD)),U,27)+$P(COST,U,2) ;private cost total
 ..Q
 .Q
 Q
FLD(SORT) ;get the correct sort field for the DES report (SORT=1:13 ADA, SORT=2:131 VA-DSS, SORT=3:ADA/CPT)
 I SORT=2 Q:$P(X1,U,16)]"" $P(X1,U,16) Q "DES131" ;131 VA-DSS product lines
 I $P(X0,U,4)="" Q "XNO ADA CODE" ;unknown 'X' sorts this to the bottom
 N DCODE,X S X=$$CPT^DSICCPT(,$P(X0,U,4),,,,1)
 I X<0 Q "XUNKNOWN" ;can't find it
 S DCODE=$P(X,U,2)
 I +DCODE=DCODE Q:SORT=3 "X"_DCODE_"  "_$P(X,U,3) Q 13 ;cpt codes sort to the bottom
 I SORT=3 Q DCODE_"  "_$P(X,U,3) ;ADA/CPT code  
 S X=$E(DCODE,2) I X<5 Q X+1 ;ada categories 1-5
 I X>6 Q X+3 ;ada categories 10-12
 S X=$E(DCODE,2,3) I X<59 Q 6 ; ada category 6
 I X<60 Q 7 ;ada category 7
 I X<62 Q 8 ;ada category 8
 Q 9 ;ada category 9
