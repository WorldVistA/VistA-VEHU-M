DENTVA51 ;DSS/KC - KLF Dental Reports;10/27/2003 10:05
 ;;1.2;DENTAL;**43,45,50**;Aug 10, 2001
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 3744       x      $$TESTPAT^VADPT 
 ;
TWO(REP) ; DES Service Profile (Table 2) called by DENTVAU
 ;^TMP("DENT",1600,2)=$START^2
 ;^TMP("DENT",1600,2,4)=4^4^6   
 ;                   5)=5^1^3   13 ada cats^total^rvus^tot va cost^tot private cost
 ;                   7)=7^1^2   131 VA-DSS cats^total^rvus^tot va cost^tot private cost
 ;                   9)=9^18^2  ADA/CPT cats^total^rvus^tot va cost^tot private cost
 ;                  12)=12^4^48
 ;                  15)=15^1^6
 ;                  17)=17^3^3
 ;                  18)=18^2^3^   
 ;                  23)=23^14^14
 ;                  24)=24^1^15
 ;                  32)=32^1^1
 ;^TMP("DENT",1600,3)=$START^3
 ;^TMP("DENT",1600,3,1)=1^^^^^^^^^^^^^^^9^^^^^^^^9  ada group^classes rvu...^total rvus
 ;                   2)=2^^^^^^^^3^8^^^^^^^^^^^^^^11 
 ;                   4)=4^^^^^^^^^^^^^^^15^^^^^^^^15
 ;                   6)=6^^^^^^^^36^^^^^^^12^^^^^^^^48
 ;                   7)=7^^^^^^^^^8^^^^^^14^^^^^^^^22
 ;                   8)=8^^^^^^^^^^^^^^^1^^^^^^^^1
 ;                   
 N I,IDT,IEN,NODE,CAT,ADA,X0,X1,TXN,CTV,CNT,X,Y,TOT,CTVTOT,GROUP,DPAT,INTOT,OUTTOT,PTOT,XREF
 S IDT=SDT-.0001,CNT=0,EDT=EDT_.9,(TOT,CTV,CTVTOT,INTOT,OUTTOT,PTOT)=0,XREF=$S($G(DENV)=0:"AS",1:"AF")
 K ^TMP("DENTPAT",$J)
 F  S IDT=$O(^DENT(228.1,XREF,IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IDT,IEN)) Q:'IEN  D
 ..S NODE=$G(^DENT(228.1,IEN,0)),CAT=+$P(NODE,U,13) Q:+$G(^DENT(228.1,IEN,1))  ;quit if deleted
 ..I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 ..I STN,$P(NODE,U,18)'=STN Q  ;not selected station
 ..I PROV'="ALL",PROV'[(U_$P(NODE,U,7)_U) Q  ;not selected provider(s)
 ..S DPAT=$P(NODE,U,2)
 ..S CNT=0 D TXN I CNT>0 S TOT=TOT+1
 ..Q
 .Q
 I TOT D
 .I REP["2" S @RET@(2)="$START^2^"_CTVTOT_U_PTOT,@RET@(2,"~")="$END^2"
 .S @RET@(3)="$START^3^"_CTVTOT_U_OUTTOT_U_INTOT,@RET@(3,"~")="$END^3"
 K ^TMP("DENTPAT",$J)
 Q
 ;
TXN ; get the transaction data for this ENCOUNTER, 
 ; don't process if no ADA code, not a txn, or deleted
 N EXTR,XRAY,GRP,COST,FLD S EXTR=0,XRAY=0,TXN=0
 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1)) Q:$P(X0,U,12)'=104  ;only complete txns
 .I X0=""!($P(X0,U,4)="")!($P(X0,U,29)'=1)!($P(X1,U,3)) Q
 .I $P(X0,U,9)=23,$P(X0,U,22)>1 Q  ;only count the first tooth for partials 6.25.2004 KC
 .S FLD=$$FLD^DENTVA11(CATG) I FLD="" Q  ;quit if no fld
 .S CNT=CNT+1,CTV=$P(X1,U,12) S GRP=$$FLD^DENTVA11(1) ;rpt3 always sorts by 13 ada cats for des style
 .I IDT>3061001 S RVU=$P($G(^DENT(228,+$P(X0,U,4),0)),U,18) S:RVU]"" CTV=RVU ;P50 12.28.06
 .I '$D(^TMP("DENTPAT",$J,0,DPAT)) S PTOT=PTOT+1,^TMP("DENTPAT",$J,0,DPAT)="" ;count overall unique pts
 .I '$D(@RET@(3,+GRP)) S @RET@(3,+GRP)=GRP
 .S $P(@RET@(3,+GRP),U,CAT+1)=+$P($G(@RET@(3,+GRP)),U,CAT+1)+CTV ;CTV TOTAL by GRP/CAT
 .S $P(@RET@(3,+GRP),U,24)=+$P($G(@RET@(3,+GRP)),U,24)+CTV ;CTV TOTAL by GRP
 .S CTVTOT=CTVTOT+CTV
 .I CAT<9 S INTOT=INTOT+CTV
 .E  S OUTTOT=OUTTOT+CTV
 .I REP'["2" Q
 .I '$D(@RET@(2,FLD)) S @RET@(2,FLD)=$S($E(FLD)'="X":FLD,1:$E(FLD,2,99))
 .S $P(@RET@(2,FLD),U,2)=+$P($G(@RET@(2,FLD)),U,2)+1 ;PROC TOTAL
 .S $P(@RET@(2,FLD),U,3)=+$P($G(@RET@(2,FLD)),U,3)+CTV ;CTV TOTAL
 .I $P(X0,U,4) S COST=$P($G(^DENT(228,+$P(X0,U,4),1)),U,14,15) I $L(COST)>1 D
 ..S $P(@RET@(2,FLD),U,4)=+$P($G(@RET@(2,FLD)),U,4)+COST ;va cost total
 ..S $P(@RET@(2,FLD),U,5)=+$P($G(@RET@(2,FLD)),U,5)+$P(COST,U,2) ;private cost total
 ..Q
 .I '$D(^TMP("DENTPAT",$J,DPAT,FLD)) D  ;count unique patients for each code(category)
 ..S ^TMP("DENTPAT",$J,DPAT,FLD)=1,$P(@RET@(2,FLD),U,6)=+$P($G(@RET@(2,FLD)),U,6)+1
 ..Q
 .Q
 Q
