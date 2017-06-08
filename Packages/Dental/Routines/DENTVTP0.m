DENTVTP0 ;DSS/SGM - COMMON UTILITIES FOR TP ;11/23/2003 22:29
 ;;1.2;DENTAL;**39,47,53,55**;Aug 10, 2001;Build 5
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;this contains various utilities for use in treatment planning software
 ;
 ; DBIA#  Supported  Description
 ; -----  ---------  ---------------------------
 ; 10104      x      ^XLFSTR: $$UP, $$TRIM
 ; 10103      x      ^XLFDT: $$HL7TFM, $$FMTE, $$FMADD
 ;  2263      x      EN^XPAR
 ;  3812  control'd  $$FINDCUR^DGENA, $$GET^DGENA (DENTAL requested addition to controlled IA)
 ;  2919      x      $$PREF^DGENPTA   
 ;  2056      x      $$GET1^DIQ       
 ;    21   private   FM access to file 2, fields 220, 220.1
 ;  3292  control'd  PTINQ^ORWPT       
 ; 10061      x      ELIG^VADPT, SVC^VADPT, KVA^VADPT
 ;  2171      x      $$WHAT^XUAF4  
 ;  3744      x      $$TESTPAT^VADPT       
 ;
PTR(TYPE,VAL,NAME) ;  return pointer value to file 228.3 or -1
 ;  TYPE = set of code value from ^DD(228.3,.02)
 ;   VAL = numeric value received from Discus software
 ;  NAME = .01 field value from file 228.3
 ; Required: either NAME or (TYPE & VALUE)
 N X S X=-1
 S NAME=$G(NAME),TYPE=$G(TYPE),VAL=$G(VAL)
 I TYPE'="" D  Q X
 .Q:VAL=""  Q:TYPE'?1N  Q:TYPE<1!(TYPE>7)
 .S X=$O(^DENT(228.3,"E",TYPE,VAL,0)) S:X="" X=-1
 .Q
 I NAME?.E1L.E S NAME=$$UP^XLFSTR(NAME)
 S X=$O(^DENT(228.3,"B",NAME,0)) S:X="" X=-1
 Q X
 ;
COM(IEN,NODE,FLG) ;  determine if transaction is for DAS/PCE
 ;  IEN - optional - pointer to file 228.2
 ; NODE - optional - string equal to the zeroth node of a 228.2 record
 ;  FLG - optional - I $G(FLG), then status must be completed
 ; NOTE: you must pass IEN or NODE
 ; Return: -1 if problems
 ;          1 if transaction has an ADA code.  I $G(FLG) then status
 ;               must also be completed
 ;          0 if transaction has no ADA code or transaction is not
 ;               completed I $G(FLG)
 N X
 S IEN=$G(IEN),NODE=$G(NODE) I IEN="",NODE="" Q -1
 I NODE="" S NODE=$G(^DENT(228.2,+IEN,0)) I NODE="" Q -1
 I '$P(NODE,U,4) Q 0 ;  no cpt code
 I '$G(FLG) Q 1
 S X=$$PTR(7,,"DSCOMPLETED")
 Q $P(NODE,U,12)=X
 ;
PAR(RET,ENT,PAR,INST,DATA) ; RPC DENTV FILE PARAMETERS
 ;this rpc will allow the addition, update, or deletion of parameters 
 ;  including WP parameters (not available in DSIC routines)
 ;  
 ;  ENT = entity (REQUIRED) USR, SYS, PKG, etc
 ;  PAT = parameter (REQUIRED) name of parameter
 ;  INST = instance (OPTIONAL - defaults to 1 if not defined)
 ;  DATA = value (REQUIRED) - value to file, may be array for WP
 ;  
 ;  RET = 1^Success, else return -1^error message
 N ERR
 I '$D(ENT)!'$D(PAR)!'$D(DATA) S RET="-1^Missing input" Q
 S ERR=0,INST=$G(INST,1)
 D EN^XPAR(ENT,PAR,INST,.DATA,.ERR)
 I +ERR S RET="-1^"_$P(ERR,U,2) Q
 S RET="1^Success"
 Q
 ;
CP(RET,DFN) ;RPC DENTV GET COVER PAGE INFO
 ; this rpc returns all the data for the cover page.
 ; RET(0)="-1^ERROR" or
 ; RET(1)=elig;eligExpire^RehabDt^SCTeeth^Status^RecareDt^LCompDt^LBriefDt^LPerioDt^LPanoDt^LFMX^LBW^LProphy^LencIEN^LVisitDt^LVisitProv^LMonDt
 ; RET(2)=$START^AMC
 ; RET(3)=adjunctive medical conditions (could be multiple)
 ; RET(n)=$START^DEMO
 ; RET(n)=fieldname: data (FBStat,PrefFAC,ENRLDt,POWStatus,POWCL,POWFrom,POWTo,CSInd,CSL,CSFrom,CSTo
 ; RET(n)=...etc
 ; RET(n)=$START^AN
 ; RET(n)...admin notes
 ; RET(n)=$START^PL 
 ; RET(n)...planned data
 ;
 S RET=$NA(^TMP("DENTVCP",$J)) K @RET
 S DFN=$G(DFN) I 'DFN S @RET@(1)="-1^no patient" Q
 N DATA,X,Y,Z,LV,IEN,I,J,DENTVD,ADA,N0,PC,TXN,NODE,CNT,CNTS,OK,DENTR,TXND,SEED,ROOT,K,KS,FLAG,JS,QUIT
 S X=+$$GET1^DIQ(2,DFN,220,"I"),DATA=X,CNT=1 ;elig
 S X=$$GET1^DIQ(2,DFN,220.1,"I"),DATA=DATA_";"_X ;eligExpire
 S $P(DATA,U,4)=0,$P(DATA,U,13)=0 ;set required variables to go back
 F I=1:1 S X=$G(^DENT(220,DFN,5,I,0)) Q:X=""  D
 .I $P(X,":")="SCTeeth" S $P(DATA,U,3)=$P(X,":",2) Q  ;SCTeeth
 .I $P(X,":")="REHAB" S:$P(X,":",2)]"" $P(DATA,U,2)=$P(X,":",2) Q  ;RehabDt
 .I $P(X,":")="Adjuctive Medical Conditions" S CNT=CNT+1,@RET@(CNT)="$START^AMC" Q
 .S CNT=CNT+1,@RET@(CNT)=X
 .Q
 D LDATA(.DATA)
 F I=6:1:12 S:$P(DATA,U,I) $P(DATA,U,I)=$$FMTE^XLFDT($P(DATA,U,I),1)
 I $P(DATA,U,16) S $P(DATA,U,16)=$$FMTE^XLFDT($P(DATA,U,16),1) ;P55 Last monitored proc code
 S QUIT=0,LV="" F  S LV=$O(^DENT(228.1,"AE",DFN,LV),-1) Q:'LV!(QUIT)  D
 .S IEN="" F  S IEN=$O(^DENT(228.1,"AE",DFN,LV,IEN),-1) Q:'IEN!(QUIT)  D
 ..Q:+$G(^DENT(228.1,IEN,1))  ;deleted
 ..S N0=$G(^DENT(228.1,IEN,0)) Q:N0=""
 ..S X=$P(N0,U,16),$P(DATA,U,4)=$S(X=1:0,X=2:1,X=3:1,X=4:2,1:0),$P(DATA,U,13)=IEN ;Status
 ..S $P(DATA,U,14)=$$FMTE^XLFDT(LV\1,1) ;LVisitDt
 ..S $P(DATA,U,15)=$E($$GET1^DIQ(228.1,IEN,.07),1,18) ;LVisitProv
 ..S QUIT=1
 ..Q
 .Q
 S $P(DATA,U,5)=$P($G(^DENT(220,DFN,8)),U),@RET@(1)=DATA ;RecareDt and now first row complete
 S CNT=CNT+1,@RET@(CNT)="$START^DEMO"
 D ELIG^VADPT
 S CNT=CNT+1,@RET@(CNT)="Primary Eligibility:^"_$P($G(VAEL(1)),U,2)
 I $P($G(VAEL(8)),U,2)]"" S @RET@(CNT)=@RET@(CNT)_" ("_$P($G(VAEL(8)),U,2)_")"
 D PTINQ^ORWPT(.DENTR,DFN) S I=0,OK=0
 F  S I=$O(@DENTR@(I)) Q:'I  S X=$G(@DENTR@(I)) I X]"" D
 .S X=$$TRIM^XLFSTR(X) I X["SC Percent:" S OK=1
 .Q:'OK  I OK,X["Next of Kin" S OK=0 Q
 .I X'[":" S CNT=CNT+1,@RET@(CNT)=U_X Q
 .S CNT=CNT+1,@RET@(CNT)=$P(X,":")_":"_U_$$TRIM^XLFSTR($P(X,":",2))
 .Q
 D SVC^VADPT
 I $P($G(VASV(6,5)),U,2)]"" D
 .S CNT=CNT+1,@RET@(CNT)="Service Separation Date:^"_$P($G(VASV(6,5)),U,2)
 .I $P($G(VASV(6,1)),U,2)]"" S @RET@(CNT)=@RET@(CNT)_"   ("_$P($G(VASV(6,1)),U,2)_")"
 .Q
 S X=$$PREF^DGENPTA(DFN) I X S CNT=CNT+1,@RET@(CNT)="Preferred Facility: ^"_$$WHAT^XUAF4(X,.01)
 S X=$$FINDCUR^DGENA(DFN) I X D
 .K DENTVE I '$$GET^DGENA(X,.DENTVE) Q
 .S X=$G(DENTVE("APP")) I X S CNT=CNT+1,@RET@(CNT)="Current Enrollment: ^"_$$FMTE^XLFDT(X)
 .S X=$G(DENTVE("ELIG","UNEMPLOY")) I X]"" S CNT=CNT+1,@RET@(CNT)="Unemployable: ^"_X
 .Q
 I $D(^DENT(228.5,"C",DFN)) S CNT=CNT+1,@RET@(CNT)="Dental Fee Basis entries? ^Yes"
 ;S X=$$GET1^DIQ(2,DFN,27.01) I X]"" S CNT=CNT+1,@RET@(CNT)="Current Enrollment: ^"_X
 ;S X=$$GET1^DIQ(2,DFN,.305) I X]"" S CNT=CNT+1,@RET@(CNT)="Unemployable: ^"_X
 ;S X=$$CHECK^DENTVEST S CNT=CNT+1,@RET@(CNT)="Vested?^"_$S(X=1:"Yes",1:"No")
 ;D OPD^VADPT I +$G(VAPD(7)) S CNT=CNT+1,@RET@(CNT)="Employment Status: ^"_$P(VAPD(7),U,2)
 I $G(VASV(5)) D
 .S CNT=CNT+1,@RET@(CNT)="COMBAT SERVICE INDICATED?^YES"
 .S CNT=CNT+1,@RET@(CNT)="COMBAT SERVICE LOCATION:^"_$P($G(VASV(5,3)),U,2)
 .S CNT=CNT+1,@RET@(CNT)="COMBAT SERVICE FROM DATE:^"_$P($G(VASV(5,1)),U,2)
 .S CNT=CNT+1,@RET@(CNT)="COMBAT SERVICE TO DATE:^"_$P($G(VASV(5,2)),U,2)
 .Q
 I $G(VASV(4)) D
 .S CNT=CNT+1,@RET@(CNT)="POW INDICATED?^YES"
 .S CNT=CNT+1,@RET@(CNT)="POW LOCATION:^"_$P($G(VASV(4,3)),U,2)
 .S CNT=CNT+1,@RET@(CNT)="POW STATUS FROM DATE:^"_$P($G(VASV(4,1)),U,2)
 .S CNT=CNT+1,@RET@(CNT)="POW STATUS TO DATE:^"_$P($G(VASV(4,2)),U,2)
 .Q
 D KVA^VADPT ;kill VADPT variables
 ;
 S IEN=0,QUIT=0
 F  S IEN=$O(^DENT(228.6,"B",DFN,IEN)) Q:'IEN!QUIT  D
 .S X=$P($G(^DENT(228.6,IEN,0)),U,4) I X'=5 Q  ;not a cover page note
 .S CNT=CNT+1,@RET@(CNT)="$START^NOTES",CNT=CNT+1,@RET@(CNT)="IEN^"_IEN_":"_$P($G(^DENT(228.6,IEN,0)),U,2)
 .S Y=0 F  S Y=$O(^DENT(228.6,IEN,1,Y)) Q:'Y  S CNT=CNT+1,@RET@(CNT)=$G(^DENT(228.6,IEN,1,Y,0))
 .S QUIT=1
 .Q
 ;
 K TXND D TXN Q:'$D(TXND)
 S CNT=CNT+1,@RET@(CNT)="$START^PLAN"
 S CNT=CNT+1,@RET@(CNT)="^Treatment Plan:",J=0,JS=0,K="@",KS="@"
 S SEED=$NA(TXND(0)) F  S SEED=$Q(@SEED) Q:$G(SEED)=""  D
 .S J=$QS(SEED,1) I J'=JS S CNT=CNT+1,@RET@(CNT)="^Phase "_J,JS=J
 .S K=$QS(SEED,2) I K'=KS,K'="@" S CNT=CNT+1,@RET@(CNT)=U_K,KS=K
 .S CNT=CNT+1,@RET@(CNT)=@SEED
 .Q
 ;
 Q
 ;
TXN ; get the transactions, don't process if no ADA code, not a txn, or deleted
 N X0,X1,TXN,TR,TOOTH,SURF,XA,QUAD,Z,TEXT S TXN=0
 F  S TXN=$O(^DENT(228.2,"AP",DFN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1))
 .Q:X0=""!($P(X0,U,4)="")!($P(X0,U,29)'=1)!($P(X1,U,3))
 .I $P(X0,U,9)=23,$P(X0,U,22)>1 Q  ;only count the first tooth for partials
 .S:$P(X0,U,25)="" $P(X0,U,25)="@"
 .;S TXND(+$P(X0,U,17),+$P(X0,U,26),0)=$P(X0,U,25)
 .S XA=$$CPT^DSICCPT(,$P(X0,U,4),,,,1) Q:'XA!(XA<0)
 .S TR=$E($P($G(^DENT(228.2,TXN,1.2)),U,2)),TOOTH=""
 .I 'TR D
 ..S QUAD=$$GET1^DIQ(228.2,TXN_",",1.8) I QUAD]"" S TOOTH=QUAD Q
 ..S Z=$$GET1^DIQ(228,+XA,.17) I Z["A" S TOOTH=$S(Z["U":"Upper",1:"Lower")
 ..Q
 .I TR D  ;only if tooth related
 ..I $P(X0,U,15) S TOOTH=$P(X0,U,15)
 ..I $P(X0,U,16)]"" S TOOTH=TOOTH_" ("_$P(X0,U,16)_")"
 ..Q
 .S TEXT="("_$P(XA,U,2)_") "_$P(XA,U,3)_$S(TOOTH]"":": "_TOOTH,1:"")
 .S TXND(+$P(X0,U,17),$P(X0,U,25),+$P(X0,U,26),TXN)=TXN_U_"   "_TEXT
 .Q
 Q
ADA(ADA) ;get these ada codes
 N I,TEXT,Z S I=3 F  S I=I+1,TEXT=$P($T(ADA+I),";",3) Q:TEXT=""  D
 .S Z=+$$CPT^DSICCPT(,$P(TEXT,U,2),,,,1) Q:'Z  S ADA(+TEXT,Z)=+TEXT
 Q
 ;;6^D0150
 ;;6^D0160
 ;;7^D0120
 ;;7^D0140
 ;;7^D0170
 ;;8^D0180
 ;;9^D0330
 ;;10^D0210
 ;;11^D0270
 ;;11^D0272
 ;;11^D0274
 ;;11^D0277
 ;;12^D1110
 ;;12^D1205
 ;;12^D4341
 ;;12^D4342
 ;;12^D4910
 ;;16^D0120
 ;;16^D0150
 ;;16^D0180
 ;;
LDATA(VAR) ;get recent dental activity
 N ADAI
 D ADA(.ADA) S PC=5 ;PC is the piece we've found (for recent dental activity)
 F  S PC=$O(ADA(PC)) Q:'PC  S ADAI=0 F  S ADAI=$O(ADA(PC,ADAI)) Q:'ADAI  D
 .S LV="",QUIT=0 F  S LV=$O(^DENT(228.2,"AC",DFN,ADAI,LV),-1) Q:'LV!QUIT  D
 ..S IEN="" F  S IEN=$O(^DENT(228.2,"AC",DFN,ADAI,LV,IEN),-1) Q:'IEN!QUIT  D
 ...S NODE=$G(^DENT(228.2,IEN,0)) Q:NODE=""!+$P($G(^DENT(228.2,IEN,1)),U,3)
 ...I $P(VAR,U,PC),LV<$P(VAR,U,PC) S QUIT=1 Q  ;already have this code
 ...S $P(VAR,U,PC)=LV\1 ;Latest visit for this code
 ...S QUIT=1
 ...Q
 ..Q
 .Q
 Q
LAP() ;get the next dental appt
 N AP,SC,X,I,QUIT,APDT
 S SC(1)="S^180",SC(2)="S^181",QUIT=0,APDT=U
 D VSIT^DSICVST2(.AP,DFN_U_$$FMADD^XLFDT(DT,-365)_U_DT_"^^1",.SC)
 I +$G(@AP@(1))'=-1 D
 .F I=0:0 S I=$O(@AP@(I)) Q:'I!QUIT  S X=$G(@AP@(I)) I $P(X,U)="V" S APDT=$P(X,U,3)_" "_$P(X,U,4),QUIT=1
 .Q
 Q APDT
