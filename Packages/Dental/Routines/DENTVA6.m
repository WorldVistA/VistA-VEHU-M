DENTVA6 ;DSS/KC - KLF Dental Reports;10/27/2003 10:05
 ;;1.2;DENTAL;**43,45,50**;Aug 10, 2001
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 3744       x      $$TESTPAT^VADPT 
 ;
FOUR(REP) ;called by DENTVAU for KLF table 4 report
 ;^TMP("DENT",964,4)=$START^4
 ;^TMP("DENT",964,4,"X02012099")=02012099^190.5^4^11   provider^ctvs^pts^visits
 ;                  "X03072103")=03072103^68.5^1^1
 ;                  
 ;^TMP("DENT",964,5)=$START^5
 ;^TMP("DENT",964,5,5)=5^36^1^2     category^ctvs^pts^visits
 ;                  8)=8^39^1^1
 ;                  9)=9^17.5^1^5
 ;                 15)=15^119.5^2^2
 ;                 17)=17^36^^1
 ;                 20)=20^11^^1
 ;                 
 ;^TMP("DENT",964,7)=$START^7
 ;^TMP("DENT",964,7,1)=CL I-VI OPT^173^3^8^44   grouping^ctvs^pts^visits^encounters
 ;                  4)=HOSPITAL^39^1^1^2
 ;                  5)=DOMICILIARY^47^1^3^9
 N I,IDT,IEN,NODE,PCODE,X0,X1,TXN,CTV,VIS,SIT,X,Y,CAT,CAT7,DVIS,DPAT,CAT7SAV
 N CTVTOT,PATTOT,VISTOT,SITTOT,PAT,QUIT,XREF
 K ^TMP("DENTPAT4",$J),^TMP("DENTPAT5",$J),^TMP("DENTPAT7",$J)
 K ^TMP("DENTVR4",$J),^TMP("DENTVR5",$J),^TMP("DENTSIT7",$J)
 S I=0,EDT=EDT_.9,IDT=SDT-.0001,XREF=$S($G(DENV)=0:"AS",1:"AF")
 F  S IDT=$O(^DENT(228.1,XREF,IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,XREF,IDT,IEN)) Q:'IEN  D
 ..S NODE=$G(^DENT(228.1,IEN,0)) Q:+$G(^DENT(228.1,IEN,1))  ;quit if deleted
 ..I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 ..I STN,$P(NODE,U,18)'=STN Q  ;only selected station
 ..I PROV'="ALL",PROV'[(U_$P(NODE,U,7)_U) Q  ;not selected provider(s)
 ..S PCODE=$$PROV($P(NODE,U,7)),DPAT=$P(NODE,U,2)
 ..S CAT=+$P(NODE,U,13),CAT7=$$CAT^DENTVA4(7,$P(NODE,U,13))
 ..D TXN
 ..Q
 .Q
 I REP["7" S DPAT=0,CTVTOT=0,PATTOT=0,VISTOT=0,SITTOT=0 F  S QUIT=0,DPAT=$O(^TMP("DENTPAT7",$J,DPAT)) Q:'DPAT!QUIT  D
 .S CAT7=0,CAT7SAV="" F  S CAT7=$O(^TMP("DENTPAT7",$J,DPAT,CAT7)) Q:'CAT7!QUIT  D
 ..I 'QUIT,CAT7SAV'=CAT7 S CAT7SAV=CAT7 D 7 S QUIT=1
 ..Q
 .Q
 K ^TMP("DENTPAT4",$J),^TMP("DENTPAT5",$J),^TMP("DENTPAT7",$J)
 K ^TMP("DENTVR4",$J),^TMP("DENTVR5",$J),^TMP("DENTSIT7",$J)
 I $D(@RET@(4)) S @RET@(4)="$START^4",@RET@(4,"~")="$END^4"
 I $D(@RET@(5)) S @RET@(5)="$START^5",@RET@(5,"~")="$END^5"
 I $D(@RET@(7)) S @RET@(7)="$START^7^"_CTVTOT_U_PATTOT_U_VISTOT_U_SITTOT,@RET@(7,"~")="$END^7"
 Q
7 ;now we go back through the saved data for report 7 - we only show the FIRST unique patient for each category
 N V,VIS,CTV,PAT,SIT
 I '$D(@RET@(7,CAT7)) S @RET@(7,CAT7)=$P($T(DESC+CAT7),";",3)
 S V=0,VIS=0,SIT=0,CTV=0 F  S V=$O(^TMP("DENTPAT7",$J,DPAT,CAT7,V)) Q:'V  D
 .S VIS=VIS+1,SIT=SIT+$G(^TMP("DENTPAT7",$J,DPAT,CAT7,V)),CTV=CTV+$P($G(^(V)),U,2)
 .Q
 I VIS=0 Q
 S CTVTOT=CTVTOT+CTV,PATTOT=PATTOT+1,VISTOT=VISTOT+VIS,SITTOT=SITTOT+SIT
 S CTV=$P(@RET@(7,CAT7),U,2)+CTV,PAT=$P(@RET@(7,CAT7),U,3)+1
 S VIS=$P(@RET@(7,CAT7),U,4)+VIS,SIT=$P(@RET@(7,CAT7),U,5)+SIT
 S $P(@RET@(7,CAT7),U,2,5)=CTV_U_PAT_U_VIS_U_SIT
 Q
TXN ; get the transaction data for this ENCOUNTER, 
 ; don't process if not a txn, or deleted
 N EXTR,XRAY,CTV,FLD S EXTR=0,XRAY=0,TXN=0
 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1)) Q:$P(X0,U,12)'=104  ;only complete txns
 .I X0=""!($P(X0,U,29)'=1)!($P(X1,U,3)) Q  ;if no data, not a txn type, or deleted, then quit
 .I $P(X0,U,9)=23,$P(X0,U,22)>1 Q  ;only count the first tooth for partials 6.25.2004 KC
 .S FLD=$P(X1,U,13) I 'CATG,FLD="" Q  ;quit if DAS type rpt, no FLD
 .I CATG S FLD=0
 .;set up initial report nodes
 .I REP["4" I '$D(@RET@(4,PCODE)) S @RET@(4,PCODE)=$S($G(PROVIDEN):$$PNAM^DENTVAU($E(PCODE,2,9)),1:$E(PCODE,2,9))
 .I REP["5" I '$D(@RET@(5,CAT)) S @RET@(5,CAT)=CAT
 .;start counting things...check for complete/screening
 .S CTV=$S('CATG:$P(X1,U,11),1:$P(X1,U,12)) ;use RVUs for DES style rpts
 .I CATG,IDT>3061001 S RVU=$P($G(^DENT(228,+$P(X0,U,4),0)),U,18) S:RVU]"" CTV=RVU ;P50 12.28.06
 .I FLD=8!(FLD=10) S CTV=0 S:'XRAY CTV=2 S XRAY=1 ;2 per pat per day
 .I FLD=35 S CTV=1 S:'EXTR CTV=4 S EXTR=1 ;4 for first, then one
 .I REP["4" S $P(@RET@(4,PCODE),U,2)=$P(@RET@(4,PCODE),U,2)+CTV ;count ctvs
 .I REP["5" S $P(@RET@(5,CAT),U,2)=$P(@RET@(5,CAT),U,2)+CTV ;count ctvs
 .S DVIS=$P(NODE,U,5)_"V" I 'DVIS S DVIS=$P(NODE,U,3)\1 ; if no visit, use create date
 .I REP["4" D VS4,PT4
 .I REP["5" D VS5,PT5
 .I REP["7" D PAT7
 .Q
 Q
VS4 ;keep track of visits for report 4
 I $D(^TMP("DENTVR4",$J,PCODE,DVIS)) Q
 S ^TMP("DENTVR4",$J,PCODE,DVIS)=""
 S $P(@RET@(4,PCODE),U,4)=$P(@RET@(4,PCODE),U,4)+1
 Q
VS5 ;keep track of visits for report 5
 I $D(^TMP("DENTVR5",$J,CAT,DVIS)) Q
 S ^TMP("DENTVR5",$J,CAT,DVIS)=""
 S $P(@RET@(5,CAT),U,4)=$P(@RET@(5,CAT),U,4)+1
 Q
PT4 ;keep track of patients for report 4
 I $D(^TMP("DENTPAT4",$J,PCODE,DPAT)) Q  ;only unique pat's per PROV
 S ^TMP("DENTPAT4",$J,PCODE,DPAT)="" ;add patiet to tmp
 S $P(@RET@(4,PCODE),U,3)=$P(@RET@(4,PCODE),U,3)+1 ;count patient
 Q
PT5 ;keep track of patients for report 5
 I $D(^TMP("DENTPAT5",$J,CAT,DPAT)) Q  ;only unique pat's per CAT
 S ^TMP("DENTPAT5",$J,CAT,DPAT)="" ;add patiet to tmp
 S $P(@RET@(5,CAT),U,3)=$P(@RET@(5,CAT),U,3)+1 ;count patient
 Q
PAT7 ;count pts by cat7 by visit with sittings totaled
 N SIT,TMP S SIT=0 I '$D(^TMP("DENTSIT7",$J,IEN)) S SIT=1,^TMP("DENTSIT7",$J,IEN)=""
 S TMP=$G(^TMP("DENTPAT7",$J,DPAT,+CAT7,DVIS)),$P(TMP,U)=$P(TMP,U)+SIT,$P(TMP,U,2)=$P(TMP,U,2)+CTV
 S ^TMP("DENTPAT7",$J,DPAT,+CAT7,DVIS)=TMP
 Q
PROV(PIEN) ;get the provider id
 N IEN,Z S IEN=$O(^DENT(220.5,"B",+PIEN,0)) I 'IEN Q "XUNKNOWN"
 S Z=$$GET1^DIQ(220.5,IEN_",",.04) I Z]"" Q "X"_Z
 S Z=$$GET1^DIQ(220.5,IEN_",",1) I Z]"" Q "X"_Z
 Q "XUNKNOWN"
DESC ;DESCRIPTIONS FOR RPT 7
 ;;CLASS I-VI
 ;;NURSING HOME
 ;;DOMICILIARY
 ;;HOSPITAL
 ;;OTHER OPT
