DENTVA5 ;DSS/KC - KLF Dental Reports;10/27/2003 10:05
 ;;1.2;DENTAL;**43,45**;Aug 10, 2001
 ;Copyright 1995-2005, Document Storage Systems, Inc., All Rights Reserved
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 3744       x      $$TESTPAT^VADPT 
 ;
TWO(REP) ; Aggregate Service Profile (Table 2) called by DENTVAU
 ; passes in the reports (requested by the user)
 ;^TMP("DENT",1600,2)=$START^2
 ;^TMP("DENT",1600,2,4)=4^4^6   service^total^ctvs^$VALUE^^unique pts
 ;                   5)=5^1^3
 ;                   7)=7^1^2
 ;                   9)=9^18^2
 ;                  12)=12^4^48
 ;                  15)=15^1^6
 ;                  17)=17^3^3
 ;                  18)=18^2^3
 ;                  23)=23^14^14
 ;                  24)=24^1^15
 ;                  32)=32^1^1
 ;^TMP("DENT",1600,3)=$START^3
 ;^TMP("DENT",1600,3,1)=1^^^^^^^^^^^^^^^9^^^^^^^^9  product group^classes ctv...^total ctvs
 ;                   2)=2^^^^^^^^3^8^^^^^^^^^^^^^^11 (or procedure grp^classes rvu...^total rvus for DES style
 ;                   4)=4^^^^^^^^^^^^^^^15^^^^^^^^15
 ;                   6)=6^^^^^^^^36^^^^^^^12^^^^^^^^48
 ;                   7)=7^^^^^^^^^8^^^^^^14^^^^^^^^22
 ;                   8)=8^^^^^^^^^^^^^^^1^^^^^^^^1
 ;                   
 N I,IDT,IEN,NODE,CAT,ADA,X0,X1,TXN,CTV,CNT,FLD,VAL,X,Y,TOT,CTVTOT,GROUP,DPAT,TOS,INTOT,OUTTOT,PTOT,XREF
 S IDT=SDT-.0001,CNT=0,EDT=EDT_.9,(TOT,CTV,CTVTOT,INTOT,OUTTOT,PTOT)=0,XREF=$S($G(DENV)=0:"AS",1:"AF")
 D SET^DENTVA1,GRP,DOL:REP["2"
 K ^TMP("DENTPAT",$J)
 F  S IDT=$O(^DENT(228.1,XREF,IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IDT,IEN)) Q:'IEN  D
 ..S NODE=$G(^DENT(228.1,IEN,0)),CAT=+$P(NODE,U,13) Q:+$G(^DENT(228,IEN,1))  ;quit if deleted
 ..I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 ..I STN,$P(NODE,U,18)'=STN Q  ;not selected station
 ..I PROV'="ALL",PROV'[(U_$P(NODE,U,7)_U) Q  ;not selected provider(s)
 ..S DPAT=$P(NODE,U,2)
 ..S CNT=0 D TXN
 ..I CNT>0 S TOT=TOT+1 I REP["2",$P(NODE,U,16),"23"[$P(NODE,U,16) S VAL=$P(NODE,U,16) D
 ...; check for complete/terminated
 ...S $P(@RET@(2,VAL),U,1)=+$P($G(@RET@(2,VAL)),U,1)+1 ;TOTAL
 ...S $P(@RET@(2,VAL),U,2)=+$P($G(@RET@(2,VAL)),U,2)+0 ;CTV TOTAL
 ...I $G(TOS(VAL)) S $P(@RET@(2,VAL),U,3)=+$P($G(@RET@(2,VAL)),U,3)+TOS(VAL) ;$VALUE
 ...I '$D(^TMP("DENTPAT",$J,DPAT,VAL)) D  ;count unique patients for each code(category)
 ....S ^TMP("DENTPAT",$J,DPAT,VAL)=1,$P(@RET@(2,VAL),U,5)=+$P($G(@RET@(2,VAL)),U,5)+1
 ....Q
 ...Q
 ..Q
 .Q
 I $D(@RET@(2)) S @RET@(2)="$START^2^"_CTVTOT_U_PTOT,@RET@(2,"~")="$END^2" D
 .S I=0 F  S I=$O(@RET@(2,I)) Q:'I  S @RET@(2,I)=I_U_@RET@(2,I) ;add the category
 .Q
 I $D(@RET@(3)) S @RET@(3)="$START^3^"_CTVTOT_U_OUTTOT_U_INTOT,@RET@(3,"~")="$END^3" D
 .S I=0 F  S I=$O(@RET@(3,I)) Q:'I  S @RET@(3,I)=I_U_@RET@(3,I) ;add the category
 .Q
 K ^TMP("DENTPAT",$J)
 Q
 ;
TXN ; get the transaction data for this ENCOUNTER, 
 ; don't process if no ADA code, not a txn, or deleted
 N EXTR,XRAY,GRP S EXTR=0,XRAY=0,TXN=0
 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1)) Q:$P(X0,U,12)'=104  ;only complete txns
 .I X0=""!($P(X0,U,4)="")!($P(X0,U,29)'=1)!($P(X1,U,3)) Q
 .I $P(X0,U,9)=23,$P(X0,U,22)>1 Q  ;only count the first tooth for partials 6.25.2004 KC
 .S FLD=$P(X1,U,13),VAL=$P($G(^DENT(228.2,TXN,1.2)),U)
 .I CATG=0 I FLD=""!(VAL="") Q  ;das style quits if no fld/val
 .I '$D(^TMP("DENTPAT",$J,0,DPAT)) S PTOT=PTOT+1,^TMP("DENTPAT",$J,0,DPAT)="" ;count overall unique pts
 .I CATG,FLD="" S FLD=0 ;default fld for des so that CPT codes can go through
 .; check for complete/screening
 .I FLD=6 S VAL=$S(VAL="S":4,1:5) D  Q
 ..S CNT=CNT+1,CTVTOT=CTVTOT+$S(VAL=4:1.5,1:3)
 ..I CAT<9 S INTOT=INTOT+$S(VAL=4:1.5,1:3)
 ..E  S OUTTOT=OUTTOT+$S(VAL=4:1.5,1:3)
 ..S $P(@RET@(3,2),U,CAT)=+$P($G(@RET@(3,2)),U,CAT)+$S(VAL=4:1.5,1:3) ;CTV TOTAL by GRP/CAT
 ..S $P(@RET@(3,2),U,23)=+$P($G(@RET@(3,2)),U,23)+$S(VAL=4:1.5,1:3) ;CTV TOTAL by GRP
 ..I REP'["2" Q
 ..S $P(@RET@(2,VAL),U,1)=+$P($G(@RET@(2,VAL)),U,1)+1 ; PROC TOTAL
 ..S $P(@RET@(2,VAL),U,2)=+$P($G(@RET@(2,VAL)),U,2)+$S(VAL=4:1.5,1:3) ;CTV TOTAL
 ..I $G(TOS(VAL)) S $P(@RET@(2,VAL),U,3)=+$P($G(@RET@(2,VAL)),U,3)+TOS(VAL) ;$VALUE
 ..I '$D(^TMP("DENTPAT",$J,DPAT,VAL)) D  ;count unique patients for each code(category)
 ...S ^TMP("DENTPAT",$J,DPAT,VAL)=1,$P(@RET@(2,VAL),U,5)=+$P($G(@RET@(2,VAL)),U,5)+1
 ...Q
 ..Q
 .; combine the extraoral/intraoral x-ray totals here
 .I FLD=8!(FLD=10) S $P(X1,U,11)=0 D:'XRAY  S XRAY=1
 ..S $P(@RET@(3,2),U,CAT)=+$P($G(@RET@(3,2)),U,CAT)+2 ;CTV TOTAL by GRP/CAT
 ..S $P(@RET@(3,2),U,23)=+$P($G(@RET@(3,2)),U,23)+2 ;CTV TOTAL by GRP
 ..S CTVTOT=CTVTOT+2
 ..I CAT<9 S INTOT=INTOT+2
 ..E  S OUTTOT=OUTTOT+2
 ..I REP'["2" Q
 ..S $P(@RET@(2,7),U,1)=+$P($G(@RET@(2,7)),U,1)+1 ;PROC TOTAL
 ..S $P(@RET@(2,7),U,2)=+$P($G(@RET@(2,7)),U,2)+2 ;CTV TOTAL
 ..I $G(TOS(7)) S $P(@RET@(2,7),U,3)=+$P($G(@RET@(2,7)),U,3)+TOS(7) ;$VALUE
 ..I '$D(^TMP("DENTPAT",$J,DPAT,7)) D  ;count unique patients for each code(category)
 ...S ^TMP("DENTPAT",$J,DPAT,7)=1,$P(@RET@(2,7),U,5)=+$P($G(@RET@(2,7)),U,5)+1
 ...Q
 ..Q
 .I '$D(ADA(FLD)) Q
 .S CNT=CNT+1,CTV=$P(X1,U,11) S GRP=$$GETG(+ADA(FLD))
 .I FLD=35 S CTV=1 S:'EXTR CTV=4 S EXTR=1 ; Extractions CTVs are weighted (4 for first, then 1)
 .S $P(@RET@(3,+GRP),U,CAT)=+$P($G(@RET@(3,+GRP)),U,CAT)+CTV ;CTV TOTAL by GRP/CAT
 .S $P(@RET@(3,+GRP),U,23)=+$P($G(@RET@(3,+GRP)),U,23)+CTV ;CTV TOTAL by GRP
 .S CTVTOT=CTVTOT+CTV
 .I CAT<9 S INTOT=INTOT+CTV
 .E  S OUTTOT=OUTTOT+CTV
 .I REP'["2" Q
 .S $P(@RET@(2,+ADA(FLD)),U,1)=+$P($G(@RET@(2,+ADA(FLD))),U,1)+VAL ;PROC TOTAL
 .S $P(@RET@(2,+ADA(FLD)),U,2)=+$P($G(@RET@(2,+ADA(FLD))),U,2)+CTV ;CTV TOTAL
 .I $G(TOS(+ADA(FLD))) S $P(@RET@(2,+ADA(FLD)),U,3)=+$P($G(@RET@(2,+ADA(FLD))),U,3)+TOS(+ADA(FLD)) ;$VALUE
 .I '$D(^TMP("DENTPAT",$J,DPAT,+ADA(FLD))) D  ;count unique patients for each code(category)
 ..S ^TMP("DENTPAT",$J,DPAT,+ADA(FLD))=1,$P(@RET@(2,+ADA(FLD)),U,5)=+$P($G(@RET@(2,+ADA(FLD))),U,5)+1
 ..Q
 .Q
 Q
 ;
GRP ;set group array for Table 3 categories
 N I
 S GROUP(11)=3
 S GROUP(12)=6
 S GROUP(32)=8
 F I=15,17 S GROUP(I)=1
 F I=4,5,6,8,9,10,34 S GROUP(I)=2
 F I=24:1:31 S GROUP(I)=4
 F I=13,14 S GROUP(I)=5
 F I=18:1:23,33 S GROUP(I)=7
 Q
GETG(GP) ;get the group
 I $G(GROUP(GP)) Q GROUP(GP)
 Q 9
 ;
DOL ;get the dental type of service dollar values
 N I,DOL S I=0 F  S I=$O(^DIC(220.3,I)) Q:'I  S DOL=$P($G(^DIC(220.3,I,0)),U,3) I DOL S TOS(I)=DOL
 Q
