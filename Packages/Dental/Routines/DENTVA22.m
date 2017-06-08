DENTVA22 ;DSS/KC - DRM SITTINGS REPORTS USING RVU, DISTPROV;11/18/2003 13:26
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
 N I,PROV,IP,IDT,IEN,PCODE,TOT,XREF,P,DPRO,PRON,CNT,ALLPR
 K @RET,^TMP("DENTPAT",$J),^TMP("DENTVIS",$J),^TMP("DENTVP",$J)
 I $G(DATA("PROV"))'="ALL" S ALLPR=0,PROV=$G(DATA("PROV")),I=1 F  Q:'$P(PROV,U,I)  D
 .S P=+$P(PROV,U,I),P=P_";"_$E($$PROV^DENTVA6(P),2,9)
 .I $P(P,";",2)]"" S $P(PROV,U,I)=P
 .S I=I+1
 .Q
 I $G(DATA("PROV"))="ALL" S ALLPR=1 D GETP^DENTVA1
 I +PROV=0 S @RET@(1)="-1^Invalid Provider" Q
 I $G(@RET@(1))]"" Q
 S I=1 F  Q:'$P(PROV,U,I)  S ^TMP("DENTVP",$J,+$P(PROV,U,I))=$P($P(PROV,U,I),";",2),I=I+1
 K PROV S I=0,CNT=0,EDT=EDT_.9,DPRO="",XREF=$S($G(DENV)=1:"AF",1:"AS") ;P59 use correct x-ref
 S IDT=SDT-.0001 F  S IDT=$O(^DENT(228.1,XREF,IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IDT,IEN)) Q:'IEN  D HST
 .Q
 K ^TMP("DENTPAT",$J),^TMP("DENTVIS",$J),^TMP("DENTVP",$J)
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 S I="" F  S I=$O(@RET@(I)) Q:I=""  S X=$G(@RET@(I)) I $P(X,U,2)]"" S DPRO=DPRO_$P(X,U,2)_U
 S @RET@(0)=DPRO ;save the provider list of prov's with data
 S @RET@("~")="$START"
 Q
 ;
HST ;process history records
 ;TOT=total sittings (only count if txns are counted)
 ;PTOT=procedure totals (weighted for DAS)
 N SSN,NAM,NODE,RP,PROV,DPROV,PCODE,DPCODE,DNAM,VIS
 S NODE=$G(^DENT(228.1,IEN,0)) Q:+$G(^DENT(228.1,IEN,1))  ;deleted
 I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 I STN,$P(NODE,U,18)'=STN Q
 I PTYP<3,'$D(^TMP("DENTPAT",$J,+$P(NODE,U,2))) D PATSTA^DENTVA1
 I PTYP<3,PTYP'=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) Q  ;not selected pt status
 I PTYP=4 S X=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) I "02"'[X Q  ;act/maint only
 S PCODE="",DPCODE=""
 S PROV=$P(NODE,U,7) I PROV,$D(^TMP("DENTVP",$J,PROV)) S PCODE="X"_$G(^TMP("DENTVP",$J,+PROV))
 S DPROV=$P(NODE,U,8) I DPROV D
 .I $D(^TMP("DENTVP",$J,DPROV)) S DPCODE="X"_$G(^TMP("DENTVP",$J,+DPROV)) Q
 .I 'ALLPR Q  ;only force dist provs if All providers
 .S DNAM=$$GET1^DIQ(200,DPROV_",",.01),DPCODE="X"_$S(DNAM]"":"("_$E(DNAM,1,29)_")",1:"(Unknown)")
 .S ^TMP("DENTVP",$J,DPROV)=$E(DPCODE,2,99) ;distributed provider not in 220.5
 .Q
 I PCODE="",DPCODE="" Q  ;not selected provider or distributed provider
 ;RP piece1=Visit Date, piece2=provnum, piece 3=patname, piece4=cat, piece5=bed, piece6=catg (ada code, etc)
 S RP="^^^^^",$P(RP,U)=$$FMTE^XLFDT($E(IDT,1,12))
 S $P(RP,U,2)=PCODE,$P(RP,U,4)=+$P(NODE,U,13),$P(RP,U,5)=$P(NODE,U,14)
 S SSN=$E($$GET1^DIQ(2,$P(NODE,U,2)_",",.09),6,10)
 S NAM=$$GET1^DIQ(2,$P(NODE,U,2)_",",.01),$P(RP,U,3)=$E(NAM,1,18)_" "_SSN
 ; loop through txns, if NUM>1 then at least 1 is on the report - so count the visit
 S TOT=0 D TXN I TOT=0 Q  ;no txns to add to totals
 I PCODE="" Q  ;only add visit counts for provider, not dist prov
 S VIS=$S($P(NODE,U,5):$P(NODE,U,5),1:IEN)
 I $D(^TMP("DENTVIS",$J,VIS)) Q  ;already counted visit
 S ^TMP("DENTVIS",$J,VIS)="",$P(@RET@(PCODE),U,3)=$P(@RET@(PCODE),U,3)+1
 Q
 ;
TXN ; get the transactions, don't process if no ADA code, not a txn, or deleted
 N Y,Z,X0,X1,TXN,TOOTH,SURF,TR,DENT,QUAD S TXN=0
 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1))
 .Q:X0=""!($P(X0,U,4)="")!($P(X0,U,29)'=1)  ;bad data, no ada code, not a txn
 .I TTYP'[(","_$P(X0,U,12)_",") Q  ;only want certain statuses
 .I $P(X0,U,9)=23,$P(X0,U,22)>1 Q  ;only count the first tooth for partials
 .I TDEL,'$P(X1,U,3) Q  ;only show deleted, transactions (also only 'completed' txns)
 .I 'TDEL,$P(X1,U,3) Q  ;don't show deleted txns unless user wants them
 .S FLD=$$FLD^DENTVA21(CATG) I FLD="" Q  ;can't figure out the category
 .S DENT(FLD)=+$G(DENT(FLD))+1 ;save like data "roll up" to conserve lines going back
 .Q
 S Y="" F  S Y=$O(DENT(Y)) Q:Y=""  D  ;set the "rolled up" data into the return array
 .S X=Y_U_DENT(Y) S:$E(Y)="Z" $P(X,U)=$E(Y,2,99)
 .S CNT=CNT+1,TOT=+DENT(Y)
 .I PCODE]"" D ADD(PCODE,RP_X,TOT)
 .I DPCODE]"" S Z=$P(RP,U)_U_DPCODE_U_$P(RP,U,3,5)_U_$P(X,U)_" (Distributed)"_U_$P(X,U,2) D ADD(DPCODE,Z,TOT)
 .Q
 Q
ADD(PCODE,DATA,TOTL) ;add data to node
 I '$D(@RET@(PCODE)) S @RET@(PCODE)="$START"_U_$S($G(PROVIDEN):$$PNAM^DENTVAU($E(PCODE,2,99)),1:$E(PCODE,2,99))_U_0
 S @RET@(PCODE,CNT)=DATA,$P(@RET@(PCODE),U,4)=$P(@RET@(PCODE),U,4)+$G(TOTL)
 Q
