DENTVA21 ;DSS/KC - DRM SITTINGS REPORTS;11/20/2003 13:26
 ;;1.2;DENTAL;**43,45,50,53**;Aug 10, 2001;Build 10
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;This routine collects RVU, VA-DSS Product line information
 ;vs. the CTV, DAS Category information in DENTVA2.
 ; DBIA#  SUPPORTED
 ; -----  ---------  ----------------------------------
 ;  10103     x      FMTE^XLFDT
 ;  2056      x      $$GET1^DIQ
 ;  3744      x      $$TESTPAT^VADPT 
 ;
PROV(RET) ; Provider Sittings Report called by DENTVAU
 I $G(DATA("DISTPROV")) D PROV^DENTVA22(.RET) Q  ;P50
 K @RET,^TMP("DENTPAT",$J),^TMP("DENTVIS",$J)
 N I,PROV,IP,IDT,IEN,TOT,CNT,ADA,PCODE,NUM,DPRO,PRON,PTOT,X,XREF
 I $G(DATA("PROV"))'="ALL" S PROV=$G(DATA("PROV")),I=1 F  Q:'$P(PROV,U,I)  D
 .S P=+$P(PROV,U,I),P=P_";"_$E($$PROV^DENTVA6(P),2,9)
 .I $P(P,";",2)]"" S $P(PROV,U,I)=P
 .S I=I+1
 .Q
 I $G(DATA("PROV"))="ALL" D GETP^DENTVA1
 I +PROV=0 S @RET@(1)="-1^Invalid Provider" Q
 I $G(@RET@(1))]"" Q
 I 'CATG D SET^DENTVA1 S I=0 F  S I=$O(ADA(I)) Q:'I  S ADA(I)=I_U_$$GET1^DIQ(220.3,+ADA(I)_",",.01) ;$$GET1^DID(221,I,,"LABEL",,"DENTER")
 S CNT=0,I=0,NUM=0,DPRO="",EDT=EDT_.9,XREF=$S($G(DENV)=0:"AP",1:"AG")
 F  S I=I+1,IP=$P(PROV,U,I),PCODE="X"_$P(IP,";",2),IP=+IP Q:IP=0  D
 .S IDT=SDT-.0001,TOT=0,PTOT=0 F  S IDT=$O(^DENT(228.1,XREF,IP,IDT)) Q:'IDT!(IDT>EDT)  D
 ..S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IP,IDT,IEN)) Q:'IEN  D HST
 ..Q
 .; handle duplicate provider numbers going to the same report (based on prov#)
 .I $P($G(@RET@(PCODE)),U,3) D  Q
 ..S:TOT $P(@RET@(PCODE),U,3)=$P(@RET@(PCODE),U,3)+TOT
 ..S:PTOT $P(@RET@(PCODE),U,4)=$P(@RET@(PCODE),U,4)+PTOT
 ..Q
 .I TOT S PRON=$S($G(PROVIDEN):$$PNAM^DENTVAU($E(PCODE,2,9)),1:$E(PCODE,2,9)) D
 ..S @RET@(PCODE)="$START"_U_PRON_U_TOT_U_PTOT,DPRO=$S(DPRO]"":DPRO_U_PRON,1:PRON)
 ..Q
 .E  K @RET@(PCODE) Q
 .Q
 K ^TMP("DENTPAT",$J),^TMP("DENTVIS",$J)
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 S @RET@(0)=DPRO ;save the provider list of prov's with data
 S @RET@("~")="$START" ;finish the last provider so the grid can stop correctly
 Q
 ;
SIT(RET) ; Individual Sittings Report called by DENTVAU
 K @RET,^TMP("DENTPAT",$J),^TMP("DENTVIS",$J)
 N I,PROV,IP,IEN,TOT,CNT,ADA,RP,NUM,X,PTOT,J,IDT,PCODE,XREF
 I 'CATG D SET^DENTVA1 S I=0 F  S I=$O(ADA(I)) Q:'I  S ADA(I)=I_U_$$GET1^DIQ(220.3,+ADA(I)_",",.01) ;$$GET1^DID(221,I,,"LABEL",,"DENTER") 
 S PCODE=STN,IDT=SDT-.0001,TOT=0,CNT=0,EDT=EDT_.9,PTOT=0,XREF=$S($G(DENV)=0:"AS",1:"AF")
 I 'PCODE S PCODE=0
 F  S IDT=$O(^DENT(228.1,XREF,IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IDT,IEN)) Q:'IEN  D HST
 .Q
 K ^TMP("DENTPAT",$J),^TMP("DENTVIS",$J)
 I TOT S @RET@(PCODE)="$START"_U_$S($G(DATA("STN"))]"":DATA("STN"),1:STN)_U_TOT_U_PTOT
 E  S @RET@(1)="-1^No data for the selected criteria" Q
 S @RET@("~")="$START"
 Q
 ;
HST ;process history records
 ;TOT=total sittings (only count if txns are counted)
 ;PTOT=procedure totals (weighted for DAS)
 N SSN,NAM,NODE,RP,VIS S NODE=$G(^DENT(228.1,IEN,0)) Q:+$G(^DENT(228.1,IEN,1))  ;deleted
 I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 I STN,$P(NODE,U,18)'=STN Q
 I PTYP<3,'$D(^TMP("DENTPAT",$J,+$P(NODE,U,2))) D PATSTA^DENTVA1
 I PTYP<3,PTYP'=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) Q  ;not selected pt status
 I PTYP=4 S X=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) I "02"'[X Q  ;act/maint only
 S RP="^^^^^",$P(RP,U)=$$FMTE^XLFDT($E(IDT,1,12))
 S $P(RP,U,2)=$S(PCODE'=0&(PCODE'=STN):PCODE,1:$E($$PROV^DENTVA6($P(NODE,U,7)),2,9))
 S $P(RP,U,4)=+$P(NODE,U,13),$P(RP,U,5)=$P(NODE,U,14)
 S SSN=$E($$GET1^DIQ(2,$P(NODE,U,2)_",",.09),6,10)
 S NAM=$$GET1^DIQ(2,$P(NODE,U,2)_",",.01),$P(RP,U,3)=$E(NAM,1,18)_" "_SSN
 ; loop through txns, if NUM>1 then at least 1 is on the report - so count the visit
 S NUM=0 D TXN I NUM=0 Q  ;no txns
 I 'CATG,$P(NODE,U,16),"23"[$P(NODE,U,16) D
 .S CNT=CNT+1,PTOT=PTOT+1,@RET@(PCODE,CNT)=RP_$S($P(NODE,U,16)=2:"CASE COMPLETED",1:"CASE TERMINATED")_U_1
 .Q
 S VIS=$S($P(NODE,U,5):$P(NODE,U,5),1:IEN)
 I '$D(^TMP("DENTVIS",$J,VIS)) S ^TMP("DENTVIS",$J,VIS)="",TOT=TOT+1
 Q
 ;
TXN ; get the transactions, don't process if no ADA code, not a txn, or deleted
 N Y,Z,X0,X1,TXN,DENT,FLD,VAL S TXN=0
 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1))
 .Q:X0=""!($P(X0,U,4)="")!($P(X0,U,29)'=1)  ;!($P(X1,U,3))
 .I TTYP'[(","_$P(X0,U,12)_",") Q  ;only want certain statuses
 .I $P(X0,U,9)=23,$P(X0,U,22)>1 Q  ;only count the first tooth for partials
 .I TDEL,'$P(X1,U,3) Q  ;only show deleted, transactions (also only 'completed' txns)
 .I 'TDEL,$P(X1,U,3) Q  ;don't show deleted txns unless user wants them
 .I 'CATG,$P(X1,U,13)=6 S FLD=6
 .E  S FLD=$$FLD(CATG) I FLD="" Q  ;can't figure out the category
 .S VAL=$S(CATG:1,1:$P($G(^DENT(228.2,TXN,1.2)),U,1))
 .I 'CATG,FLD=6 S FLD=$S(VAL="S":4,1:5),VAL=1,FLD=$$GET1^DIQ(220.3,FLD_",",.01)
 .S NUM=NUM+1,PTOT=PTOT+VAL
 .S DENT(FLD)=+$G(DENT(FLD))+VAL ;save like data "roll up" to conserve lines going back
 .Q
 S Y="" F  S Y=$O(DENT(Y)) Q:Y=""  D  ;set the "rolled up" data into the return array
 .S X=Y_U_DENT(Y) S:$E(Y)="Z" $P(X,U)=$E(Y,2,99)
 .S CNT=CNT+1,@RET@(PCODE,CNT)=RP_X
 .Q
 Q
 ;
FLD(SORT) ;get the correct sort field for the Sittings report 
 ; SORT=0:DAS Category, SORT=1:ADA cat, SORT=2:VA-DSS, SORT=3:ADA/CPT)
 N X I SORT=2 S X=$S($P(X1,U,16)]"":$P(X1,U,16),1:"DES131") Q $$DES(X)  ;VA-DSS product lines
 I SORT=0 S X=+$P(X1,U,13),X=+$G(ADA(X)) Q:X="" ""  Q $P($G(ADA(X)),U,2)
 I $P(X0,U,4)="" Q "ZNO ADA CODE" ;unknown
 N DCODE,X S X=$$CPT^DSICCPT(,$P(X0,U,4),,,,1)
 I X<0 Q "ZUNKNOWN" ;can't find it
 S DCODE=$P(X,U,2)_"   "_$P(X,U,3) ;dcode with short description
 I +$P(X,U,2)=$P(X,U,2) Q:SORT=3 "Z"_DCODE Q "CPT CODES" ;cpt codes sort to the bottom
 I SORT=3 Q DCODE ;ADA/CPT code  
 S X=$E(DCODE,2) I X<5 Q $$CAT(X+1) ;ada categories 1-5
 I X>6 Q $$CAT(X+3) ;ada categories 10-12
 S X=$E(DCODE,2,3) I X<59 Q "PROSTHODONTIC, REM" ; ada category 6
 I X<60 Q "MAXILLOFACIAL PROST" ;ada category 7
 I X<62 Q "IMPLANT SERVICES" ;ada category 8
 Q "PROSTHODONTIC, FIXED" ;ada category 9
DES(CODE) Q CODE_" "_$P($G(^DENT(228.42,+$O(^DENT(228.42,"B",CODE,0)),0)),U,3)
CAT(CODE) ;
 I '$D(ADAC) D
 .S ADAC(1)="DIAGNOSTIC",ADAC(2)="PREVENTIVE",ADAC(3)="RESTORATIVE",ADAC(4)="ENDODONTIC",ADAC(5)="PERIODONTIC"
 .S ADAC(10)="ORAL/MAXILLOFACIAL SURG",ADAC(11)="ORTHODONTICS",ADAC(12)="ADJUNCTIVE GENERAL"
 .Q
 Q $G(ADAC(CODE))
