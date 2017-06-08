DENTVA1 ;DSS/KC - PROVIDER-CLINIC SUMMARY REPORTS;11/18/2003 13:26
 ;;1.2;DENTAL;**38,39,43,4,53**;Aug 10, 2001;Build 10
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ;  3744       x      $$TESTPAT^VADPT    ;
 ;
PROV(RET) ; Provider Summary Report called by DENTVAU
 N I,PROV,IP,IDT,IEN,NODE,CAT,ADA,PCODE,TOT,X0,X1,TXN,CTV,CNT,FLD,VAL,X,Y,P,XREF,TOS
 I $G(DATA("PROV"))'="ALL" S PROV=$G(DATA("PROV")),I=1 F  Q:'$P(PROV,U,I)  D
 .S P=+$P(PROV,U,I),P=P_";"_$E($$PROV^DENTVA6(P),2,9)
 .I $P(P,";",2)]"" S $P(PROV,U,I)=P
 .S I=I+1
 .Q
 I $G(DATA("PROV"))="ALL" D GETP
 I +PROV=0 S @RET@(1)="-1^Invalid Provider" Q
 I $G(@RET@(1))]"" Q
 D SET,DOL^DENTVA5 S I=0,CNT=0,EDT=EDT_.9,XREF=$S($G(DENV)=0:"AP",1:"AG")
 F  S I=I+1,IP=$P(PROV,U,I),PCODE="X"_$P(IP,";",2),IP=+IP Q:IP=0  D PRE D
 .S IDT=SDT-.0001 F  S IDT=$O(^DENT(228.1,XREF,IP,IDT)) Q:'IDT!(IDT>EDT)  D
 ..S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IP,IDT,IEN)) Q:'IEN  D HST
 ..Q
 .; handle duplicate provider numbers going to the same report (based on prov#)
 .I $P($G(@RET@(PCODE)),U,3) S:TOT $P(@RET@(PCODE),U,3)=$P(@RET@(PCODE),U,3)+TOT Q
 .I TOT S @RET@(PCODE)="$START"_U_$S($G(PROVIDEN):$$PNAM^DENTVAU($E(PCODE,2,9)),1:$E(PCODE,2,9))_U_TOT
 .E  K @RET@(PCODE) Q
 .Q
 K ^TMP("DENTPAT",$J)
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 S @RET@("~")="$START" ;finish the last provider so the grid can stop correctly
 Q
CLINIC(RET) ; Clinic Summary Report called by DENTVAU
 N I,IDT,IEN,NODE,CAT,ADA,X0,X1,TXN,CTV,CNT,FLD,VAL,X,Y,PCODE,TOT,TOS,XREF
 S PCODE=STN,IDT=SDT-.0001,CNT=0,EDT=EDT_.9,XREF=$S($G(DENV)=0:"AS",1:"AF")
 I 'PCODE S PCODE=0
 D SET,PRE,DOL^DENTVA5
 F  S IDT=$O(^DENT(228.1,XREF,IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IDT,IEN)) Q:'IEN  D HST
 .Q
 K ^TMP("DENTPAT",$J)
 I TOT S @RET@(PCODE)="$START"_U_$S($G(DATA("STN"))]"":DATA("STN"),1:STN)_U_TOT
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 S @RET@("~")="$START" ;finish the last provider so the grid can stop correctly
 Q
HST ;process history records
 S NODE=$G(^DENT(228.1,IEN,0)),CAT=+$P(NODE,U,13) Q:'CAT  Q:+$G(^DENT(228.1,IEN,1))
 I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 I PTYP<3,'$D(^TMP("DENTPAT",$J,+$P(NODE,U,2))) D PATSTA^DENTVA1
 I PTYP<3,PTYP'=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) Q  ;not selected pt status
 I PTYP=4 S X=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) I "02"'[X Q  ;act/maint only
 I STN,$P(NODE,U,18)'=STN Q  ;only selected station
 S CNT=0 D TXN
 I CNT>0 S TOT=TOT+1 I $P(NODE,U,16),"23"[$P(NODE,U,16) S VAL=$P(NODE,U,16) D  ;check for complete/terminated
 .S $P(@RET@(PCODE,VAL),U,CAT)=+$P($G(@RET@(PCODE,VAL)),U,CAT)+1
 .S $P(@RET@(PCODE,VAL),U,23)=+$P($G(@RET@(PCODE,VAL)),U,23)+1 ;TOTAL
 .S $P(@RET@(PCODE,VAL),U,24)=0,$P(@RET@(PCODE,VAL),U,25)=0,$P(@RET@(PCODE,VAL),U,27)=VAL
 .I $G(TOS(VAL)) S $P(@RET@(PCODE,VAL),U,26)=+$P($G(@RET@(PCODE,VAL)),U,26)+TOS(VAL) ;$VALUE
 .Q
 Q
 ;
 ;
TXN ; get the transaction data for this ENCOUNTER, 
 ; don't process txns if this patient doesn't match pat type selected
 ; don't process if no ADA code, not a txn, or deleted
 N EXTR,XRAY,DEN S EXTR=0,XRAY=0,TXN=0
 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1))
 .I X0=""!($P(X0,U,4)="")!($P(X0,U,29)'=1)!($P(X1,U,3)) Q
 .I TTYP'[(","_$P(X0,U,12)_",") Q  ;only want certain statuses
 .I $P(X0,U,9)=23,$P(X0,U,22)>1 Q  ;only count the first tooth for partials 6.25.2004 KC
 .S FLD=$P(X1,U,13),VAL=$P($G(^DENT(228.2,TXN,1.2)),U)
 .I FLD=""!(VAL="") D ERR(1) Q
 .; check for complete/screening
 .I FLD=6 S VAL=$S(VAL="S":4,1:5),CTV=$S(VAL=4:1.5,1:3) D  Q
 ..S DEN=$G(@RET@(PCODE,VAL)),CNT=CNT+1
 ..S $P(DEN,U,CAT)=+$P(DEN,U,CAT)+1 ;CAT TOTAL
 ..S $P(DEN,U,23)=+$P(DEN,U,23)+1 ; PROC TOTAL
 ..S $P(DEN,U,24)=+CTV ;ctv per unit
 ..S $P(DEN,U,25)=+$P(DEN,U,25)+CTV ;CTV TOTAL
 ..S $P(DEN,U,27)=VAL ;procedure
 ..I $G(TOS(VAL)) S $P(DEN,U,26)=+$P(DEN,U,26)+TOS(VAL) ;$VALUE
 ..S @RET@(PCODE,VAL)=DEN
 ..Q
 .; combine the extraoral/intraoral x-ray totals here
 .I FLD=8!(FLD=10) D:'XRAY  S XRAY=1
 ..S DEN=$G(@RET@(PCODE,7))
 ..S $P(DEN,U,CAT)=+$P(DEN,U,CAT)+1 ;CAT TOTAL
 ..S $P(DEN,U,23)=+$P(DEN,U,23)+1 ;PROC TOTAL
 ..S $P(DEN,U,24)=2 ;ctv per unit
 ..S $P(DEN,U,25)=+$P(DEN,U,25)+2 ;CTV TOTAL
 ..S $P(DEN,U,27)=7 ;procedure
 ..I $G(TOS(7)) S $P(DEN,U,26)=+$P(DEN,U,26)+TOS(7) ;$VALUE
 ..S @RET@(PCODE,7)=DEN
 ..Q
 .I '$D(ADA(FLD)) D ERR(2) Q
 .S CNT=CNT+1,CTV=$S(FLD=8:0,FLD=10:0,1:$P(X1,U,11)) I CTV="" D ERR(3)
 .I FLD=35 S CTV=1 S:'EXTR CTV=4 S EXTR=1 ; Extractions CTVs are weighted (4 for first, then 1)
 .S DEN=$G(@RET@(PCODE,+ADA(FLD)))
 .S $P(DEN,U,CAT)=+$P(DEN,U,CAT)+VAL ;CAT TOTAL
 .S $P(DEN,U,23)=+$P(DEN,U,23)+VAL ;PROC TOTAL
 .S $P(DEN,U,24)=$S(FLD=35:4,1:+CTV) ;ctv per unit
 .S $P(DEN,U,25)=+$P(DEN,U,25)+CTV ;CTV TOTAL
 .S $P(DEN,U,27)=+ADA(FLD) ;procedure
 .I $G(TOS(+ADA(FLD))) S $P(DEN,U,26)=+$P(DEN,U,26)+TOS(+ADA(FLD)) ;$VALUE
 .S @RET@(PCODE,+ADA(FLD))=DEN
 .Q
 Q
 ;
SET F I=2:1:34 I $P($T(ADA),";",I) S ADA($P($T(ADA),";",I))=I
 Q
ADA ;;;;;6;;8;10;;21;22;23;24;11;12;25;35;36;15;16;17;19;27;28;29;30;31;32;33;34;37;38;6.2
 ;
PRE ; preset the return global so that we know where the data is, 
 ; 23rd piece=total for all categories for this procedure
 S TOT=0,CTV=0
 Q
 I $D(@RET@(PCODE)) Q  ;duplicate provider number has already been set up
 N I F I=2:1:5,7,8,9,11:1:15,17:1:34 D
 .;S @RET@(PCODE,I)="^^^^^^^^^^^^^^^^^^^^^^0^"_$P($G(^DIC(220.3,I,0)),U,2)_"^0^"_$S(+$P($G(^(0)),U,3):$FN($P(^(0),U,3),",",2),1:"")
 .S @RET@(PCODE,I)="^^^^^^^^^^^^^^^^^^^^^^0^"_$P($G(^DIC(220.3,I,0)),U,2)_"^0^"_$S(+$P($G(^(0)),U,3):$P(^(0),U,3),1:"")
 .Q
 Q
 ;
ERR(NUM) ; set an error node in the report global
 ;;Missing Field/Value data for Transaction IEN
 ;;Missing Type of Service (220.3) for Field
 ;;Missing CTV count for Transaction IEN 
 ;S @RET@("E",+$G(ERR)+1)=$P($T(ERR+NUM),";",3)_$S(NUM=2:" "_FLD,1:" "_TXN)
 Q
GETP ;get all the dental providers in an up-arrow string
 N I,RET,X S PROV=""
 D PROV^DENTVAU(.RET)
 F I=0:0 S I=$O(RET(I)) Q:'I  D
 .S X=$G(RET(I)),PROV=PROV_$P(X,U,2)_";"_$P(X,U,3)_U
 .Q
 Q
PATSET ;set patient history file ien of last completed encounter
 N PAT,PIEN,PDIS,QUIT S QUIT=0,PAT=$P(NODE,U,2) Q:'PAT
 S PIEN="" F  S PIEN=$O(^DENT(228.1,"C",PAT,PIEN),-1) D:'PIEN  Q:'PIEN  D  Q:QUIT
 .I 'PIEN S ^TMP("DENTPAT",$J,PAT)=0 Q
 .S PDIS=+$P($G(^DENT(228.1,PIEN,0)),U,16) Q:PDIS<2  ;ACTIVE
 .S ^TMP("DENTPAT",$J,PAT)=PIEN,QUIT=1
 .Q
 Q
PATSTA ;set last status for the patient (replaces above call) P53
 N STATUS,PAT S PAT=$P(NODE,U,2)
 D LST^DENTVTP5(.STATUS,PAT)
 S ^TMP("DENTPAT",$J,PAT)=+STATUS
 Q
