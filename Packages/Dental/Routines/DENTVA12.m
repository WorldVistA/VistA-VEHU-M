DENTVA12 ;DSS/KC - DRM SUMMARY REPORTS USING RVU;11/18/2003 13:26
 ;;1.2;DENTAL;**50,53,59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 3744       x       $$TESTPAT^VADPT 
 ; 2056       x       $$GET1^DIQ
 ; 
 ;This routine collects RVU, VA-DSS Product line information
 ;
 ;P50 changes from DENTVA11 include Distributed Provider totals
 ;so we are always using the "AS" xref without individual providers
 ;P59 NEED to use AS or AF xref based on DENV!
 ;
PROV(RET) ; Provider Summary Report called by DENTVAU
 N I,PROV,IP,IDT,IEN,PCODE,TOT,XREF,P,ALLPR
 K ^TMP("DENTPAT",$J),^TMP("DENTVIS",$J),^TMP("DENTVP",$J)
 I $G(DATA("PROV"))'="ALL" S ALLPR=0,PROV=$G(DATA("PROV")),I=1 F  Q:'$P(PROV,U,I)  D
 .S P=+$P(PROV,U,I),P=P_";"_$E($$PROV^DENTVA6(P),2,9)
 .I $P(P,";",2)]"" S $P(PROV,U,I)=P
 .S I=I+1
 .Q
 I $G(DATA("PROV"))="ALL" S ALLPR=1 D GETP^DENTVA1
 I +PROV=0 S @RET@(1)="-1^Invalid Provider" Q
 I $G(@RET@(1))]"" Q
 S I=1 F  Q:'$P(PROV,U,I)  S ^TMP("DENTVP",$J,+$P(PROV,U,I))=$P($P(PROV,U,I),";",2),I=I+1
 K PROV S I=0,CNT=0,EDT=EDT_.9,TOT=0,XREF=$S($G(DENV)=1:"AF",1:"AS") ;P59 use correct x-ref
 S IDT=SDT-.0001 F  S IDT=$O(^DENT(228.1,XREF,IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IDT,IEN)) Q:'IEN  D HST
 .Q
 K ^TMP("DENTPAT",$J),^TMP("DENTVIS",$J),^TMP("DENTVP",$J)
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 Q
 ;
HST ;process history records
 N NODE,CAT,CNT,VIS,PROV,DNAM
 S NODE=$G(^DENT(228.1,IEN,0)),CAT=+$P(NODE,U,13) Q:'CAT  Q:+$G(^DENT(228.1,IEN,1))
 I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 I PTYP<3,'$D(^TMP("DENTPAT",$J,+$P(NODE,U,2))) D PATSTA^DENTVA1
 I PTYP<3,PTYP'=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) Q  ;not selected pt status
 I PTYP=4 S X=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) I "02"'[X Q  ;act/maint only
 I STN,$P(NODE,U,18)'=STN Q  ;not selected station/facility
 S PCODE="",DPCODE=""
 S PROV=$P(NODE,U,7) I PROV,$D(^TMP("DENTVP",$J,PROV)) S PCODE="X"_$G(^TMP("DENTVP",$J,+PROV))
 S DPROV=$P(NODE,U,8) I DPROV D
 .I $D(^TMP("DENTVP",$J,DPROV)) S DPCODE="X"_$G(^TMP("DENTVP",$J,+DPROV)) Q
 .I 'ALLPR Q  ;only force dist provs if All providers
 .S DNAM=$$GET1^DIQ(200,DPROV_",",.01),DPCODE="X"_$S(DNAM]"":"("_$E(DNAM,1,29)_")",1:"(Unknown)")
 .S ^TMP("DENTVP",$J,DPROV)=$E(DPCODE,2,99) ;distributed provider not in 220.5
 .Q
 I PCODE="",DPCODE="" Q  ;not selected provider or distributed provider
 S CNT=0 D TXN I CNT=0 Q  ;no txns to add to totals
 I PCODE="" Q  ;only add visit counts for provider, not dist prov
 S VIS=$S($P(NODE,U,5):$P(NODE,U,5),1:IEN),TOT=0
 I '$D(^TMP("DENTVIS",$J,VIS)) S ^TMP("DENTVIS",$J,VIS)="",TOT=1 ;add to total visits
 I TOT S $P(@RET@(PCODE),U,3)=$P(@RET@(PCODE),U,3)+TOT Q
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
 .S FLD=$$FLD^DENTVA11(CATG) I FLD="" Q
 .S RVU=""
 .I IDT>3061001 S RVU=$P($G(^DENT(228,+$P(X0,U,4),0)),U,18) ;P50 12.28.06
 .I RVU="" S RVU=$P(X1,U,12)
 .S CNT=CNT+1,SFLD=$P(FLD," ",1)
 .I PCODE]"" D ADD(PCODE)
 .I DPCODE]"" D ADD(DPCODE)
 .Q
 Q
ADD(PCODE) ;add totals
 I '$D(@RET@(PCODE)) S @RET@(PCODE)="$START"_U_$S($G(PROVIDEN):$$PNAM^DENTVAU($E(PCODE,2,99)),1:$E(PCODE,2,99))_U_TOT
 S $P(@RET@(PCODE,SFLD),U,CAT)=+$P($G(@RET@(PCODE,SFLD)),U,CAT)+1 ;CAT TOTAL
 S $P(@RET@(PCODE,SFLD),U,23)=+$P($G(@RET@(PCODE,SFLD)),U,23)+1 ;PROC TOTAL
 S $P(@RET@(PCODE,SFLD),U,24)=+$P($G(@RET@(PCODE,SFLD)),U,24)+RVU ;RVU TOTAL P50
 I $P(@RET@(PCODE,SFLD),U,25)="" S $P(@RET@(PCODE,SFLD),U,25)=$S($E(FLD)'="X":FLD,1:$E(FLD,2,99))
 I $P(X0,U,4) S COST=$P($G(^DENT(228,+$P(X0,U,4),1)),U,14,15) I $L(COST)>1 D
 .S $P(@RET@(PCODE,SFLD),U,26)=+$P($G(@RET@(PCODE,SFLD)),U,26)+COST ;va cost total
 .S $P(@RET@(PCODE,SFLD),U,27)=+$P($G(@RET@(PCODE,SFLD)),U,27)+$P(COST,U,2) ;private cost total
 .Q
 Q
