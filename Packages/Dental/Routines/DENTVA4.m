DENTVA4 ;DSS/KC - KLF Dental Reports;10/27/2003 10:05
 ;;1.2;DENTAL;**43,45**;Aug 10, 2001
 ;Copyright 1995-2005, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ----------------------------------
 ;  10103     x      FMTE^XLFDT
 ;  2056      x      $$GET1^DIQ
 ;  3744      x      $$TESTPAT^VADPT 
 ;
 Q
ONE(REP) ;called by DENTVAU for KLF table 1,6,8 reports
 ;   ^TMP("DENT",512,1)=$START^1^1               total encounters
 ;   ^TMP("DENT",512,1,"Nov 2004")=Nov 2004^1^1  date^unique pts^encounters
 ;   
 ;   ^TMP("DENT",512,6)=$START^6^1^1^2      unique pts^tot visits^tot encs
 ;   ^TMP("DENT",512,6,1)=OUTPATIENT^1^1^2  category^pts^visits^encounters
 ;
 ;   ^TMP("DENT",512,8)=$START^8^1^1     total unique pts^total unique in all categories
 ;   ^TMP("DENT",512,8,15)=CLASS IV^1    category^unique pts
 ; 
 N IEN,IDT,TOT,DPAT,TDT,NODE,N1,DVIS,CAT,ETOT,PTOT,VTOT,TOTP,XREF
 S IDT=SDT-.0001,EDT=EDT_.9,(TOT,ETOT,PTOT,VTOT,TOTP)=0,XREF=$S($G(DENV)=0:"AS",1:"AF")
 F  S IDT=$O(^DENT(228.1,XREF,IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IDT,IEN)) Q:'IEN  D
 ..S NODE=$G(^DENT(228.1,IEN,0)),DPAT=+$P(NODE,U,2) Q:+$G(^DENT(228.1,IEN,1))  ;quit if deleted
 ..I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 ..I STN]"",$P(NODE,U,18)'=STN Q  ;quit if incorrect stn
 ..I PROV'="ALL",PROV'[(U_$P(NODE,U,7)_U) Q  ;not selected provider(s)
 ..I '$$TXN(0) Q  ;no transactions for this encounter
 ..I '$D(^TMP("DENTPAT",$J,0,DPAT)) S PTOT=PTOT+1,^TMP("DENTPAT",$J,0,DPAT)="" ;count overall unique pts
 ..I REP["1" D
 ...S TOT=TOT+1,TDT=$$FMTE^XLFDT(IDT\1),TDT=$E(TDT,1,4)_$E(TDT,9,12),N1=$E(IDT\1,1,5)
 ...I '$D(@RET@(1,N1)) S @RET@(1,N1)=TDT
 ...S $P(@RET@(1,N1),U,3)=$P(@RET@(1,N1),U,3)+1 ;count encounter
 ...I $D(^TMP("DENTPAT",$J,N1,DPAT)) Q  ;only unique pat's per month
 ...S ^TMP("DENTPAT",$J,N1,DPAT)="" ;add patiet to tmp
 ...S $P(@RET@(1,N1),U,2)=$P(@RET@(1,N1),U,2)+1 ;count patient
 ...Q
 ..I REP["6" D
 ...S DVIS=$P(NODE,U,5)_"V",CAT=$$CAT(6,$P(NODE,U,13))
 ...I 'DVIS S DVIS=$P(NODE,U,3)\1 ; if no visit, use create date
 ...I '$D(@RET@(6,+CAT)) S @RET@(6,+CAT)=$P(CAT,U,2)
 ...S $P(@RET@(6,+CAT),U,4)=$P(@RET@(6,+CAT),U,4)+1,ETOT=ETOT+1 ;count encounter
 ...;I '$D(^TMP("DENTPAT",$J,0,DPAT)) S PTOT=PTOT+1,^TMP("DENTPAT",$J,0,DPAT)="" ;count overall unique pts
 ...I '$D(^TMP("DENTVR",$J,+CAT,DVIS)) D  ;count visits
 ....S ^TMP("DENTVR",$J,+CAT,DVIS)=""
 ....S $P(@RET@(6,+CAT),U,3)=$P(@RET@(6,+CAT),U,3)+1,VTOT=VTOT+1
 ....Q
 ...I $D(^TMP("DENTPAT",$J,+CAT,DPAT)) Q  ;only unique pat's per month
 ...S ^TMP("DENTPAT",$J,+CAT,DPAT)="" ;add patiet to tmp
 ...S $P(@RET@(6,+CAT),U,2)=$P(@RET@(6,+CAT),U,2)+1 ;count patient
 ...Q
 ..I REP["8" D
 ...S CAT=$P(NODE,U,13) I '$D(@RET@(8,+CAT)) S @RET@(8,+CAT)=CAT
 ...;I '$D(^TMP("DENTPAT",$J,0,DPAT)) S TOT=TOT+1,^TMP("DENTPAT",$J,0,DPAT)=""
 ...I $D(^TMP("DENTPAT",$J,+CAT,DPAT)) Q  ;only unique pat's per month
 ...S ^TMP("DENTPAT",$J,+CAT,DPAT)="" ;add patiet to tmp
 ...S $P(@RET@(8,+CAT),U,2)=$P(@RET@(8,+CAT),U,2)+1,TOTP=TOTP+1 ;count patient
 ...Q
 ..Q
 .Q
 K ^TMP("DENTPAT",$J),^TMP("DENTVR",$J)
 I REP["1",$D(@RET@(1)) S @RET@(1)="$START^1^"_TOT,@RET@(1,"~")="$END^1"
 I REP["6",$D(@RET@(6)) S @RET@(6)="$START^6^"_PTOT_U_VTOT_U_ETOT,@RET@(6,"~")="$END^6"
 I REP["8",$D(@RET@(8)) S @RET@(8)="$START^8^"_PTOT_U_TOTP,@RET@(8,"~")="$END^8"
 Q
CAT(RPT,CLAS) ;get report specific category
 I CLAS="" Q:RPT=6 "5^(NOSETTING)" Q "5^OTHER OPT"
 I CLAS=4 Q:RPT=6 "3^NURSING HOME" Q "2^NURSING HOME"
 I CLAS=5 Q:RPT=6 "4^DOMICILIARY" Q "3^DOMICILIARY"
 N X S X=$$GET1^DIQ(220.2,CLAS_",",.01)
 I ",1,2,3,6,7,8,"[(","_CLAS_",") Q:RPT=6 "2^HOSPITAL" Q "4^HOSPITAL"
 I RPT=6 Q "1^OUTPATIENT"
 I ",9,10,11,12,13,14,15,16,17,"[(","_CLAS_",") Q "1^CLASS I-VI"
 I RPT=7 Q "5^OTHER OPT"
 Q CLAS_U_"UNKNOWN"
 ;
TXN(PROC) ;only count encounters if there are valid transactions associated with them
 N TXN,X0,X1,CNT,VAL,TOT
 S TXN=0,CNT=0,VAL=0,TOT=0,PROC=+$G(PROC)
 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN!(CNT&'PROC)  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1)) Q:$P(X0,U,12)'=104  ;only complete txns
 .I X0=""!($P(X0,U,29)'=1)!($P(X1,U,3)) Q  ;not a txn or deleted
 .I $P(X0,U,9)=23,$P(X0,U,22)>1 Q  ;only count the first tooth for partials
 .S CNT=CNT+1 I 'PROC Q  ;simple counts
 .S VAL=$S(CATG:1,1:$P($G(^DENT(228.2,TXN,1.2)),U,1))
 .I VAL'=+VAL S VAL=1
 .S TOT=TOT+VAL
 .Q
 Q CNT_U_TOT
