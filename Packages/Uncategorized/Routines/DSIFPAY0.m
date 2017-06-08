DSIFPAY0 ;DSS/RED - RPC FOR FEE BASIS PAYMENTS ;09/13/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   2051  LIST^DIC
 ;   2055  $$EXTERNAL^DILFD
 ;   2056  $$GET1^DIQ,GETS^DIQ
 ;   2071   $$GET1^DIQ(420.6
 ;   5084  $$CKVEN^FBAADV
 ;   5090  $$DATX^FBAAUTL,$$SSN^FBAAUTL
 ;  10103  $$FMTE^XLFDT
 ;
 Q  ; Direct calls not allowed
 ;
VENDINFO(FBOUT,DFN) ; RPC: DSIF PAY PT VENDOR
 ;  Input = Patient IEN
 ;OUTPUT:  ^TMP($J,"DSIFPAY0",0)="Vendor demographics: "^Pt name^SSN 
 ;               n,1)="IEN"^Pt Vendor IEN^DATE (INT;EXT)^NAME^ID
 ;               n,2)="Add"^Vendor Address data
 ;               n,3)="Add2"^Vendor info
 ;               N,4)="Austin"^Austin data  
 ;                           Note: {i.e. 1,1 to 1,999)}
 ;            Same as ^FBAAVD               
 ;  ; Now screens out entries with 1st peice of ^FBAAV(IEN,"ADEL") (If "Y" Austin delete flag)
 ; Output(0)=1^count 
 ; Output(n)=Name^ID #^Street address^Street Address 2^City^State^Zip^Type of vendor^Speciality Code
 N FBAAFN,FBDEL,FBI,FBAAPN,FBRR,FBXX,SPEC,T,OUT,FLAG
 K ^TMP($J,"DSIFPAY0"),FBOUT S:$G(U)="" U="^"
 S FBOUT=$NA(^TMP($J,"DSIFPAY0"))  ;Used as reference needed by broker and accessed by @FBOUT@ (indirection)
 I '$D(DFN)!('$D(^FBAAA(DFN))) S @FBOUT@(0)="-1^INVALID PT RECORD" Q
 I '$D(^FBAAC(DFN,1,0)) S @FBOUT@(0)="-1^No vendor/payment entries found" Q
 S @FBOUT@(0)="Vendor demographics"_U_$P($G(^DPT(DFN,0)),U)_U_$$SSN^FBAAUTL(DFN),(FLAG,FBI)=0
 F  S FBI=$O(^FBAAC(DFN,1,FBI)) Q:'FBI!(FLAG)  D
 . K IEN,ARR,MSG,OUT I $P(^FBAAV(FBI,"ADEL"),U)'="" Q  ;Austin deleted flag 
 . S IEN=FBI_"," D GETS^DIQ(161.2,IEN,"**","IE","ARR","MSG") S OUT=$NA(ARR(161.2,IEN)) I $D(MSG) S FLAG=1 Q 
 . S @FBOUT@(FBI,1)="IEN"_U_FBI_";"_@OUT@(.01,"E")_U_@OUT@(1,"I")
 . S @FBOUT@(FBI,2)="Add1"_U_@OUT@(2,"E")_U_@OUT@(2.5,"E")_U_@OUT@(3,"E")_U_@OUT@(4,"E")_U_@OUT@(5,"E")_U_@OUT@(5.5,"E")_U_@OUT@(14,"E")_U_@OUT@(23,"E")
 . S @FBOUT@(FBI,3)="Add2"_U_@OUT@(.05,"E")_U_@OUT@(6,"E")_U_@OUT@(7,"E")_U_@OUT@(19,"E")_U_@OUT@(8,"E")_U_@OUT@(24,"E")
 . S @FBOUT@(FBI,4)="Austin"_U_@OUT@(30.01,"E")_U_@OUT@(12,"I")_";"_@OUT@(12,"E")_U_@OUT@(12.1,"I")_";"_@OUT@(12.1,"E")
 I '$D(@FBOUT@(0)) S @FBOUT@(0)="-1^ERROR"
 Q
 ;
VENDISP(FBOUT,FBDA) ; RPC: DSIF PAY VENDOR DETAILS
 ; INPUT: FBDA - Vendor file IEN (IEN of vendor in file 161.2)
 ; OUTPUT:  ^TMP($J,"DSOFPAY0",n)  
 ;   0)=SUCCESS OR FAILURE FLAG^ERROR MESSAGE
 ;   1)=NAME^ID #^PRICER EXEMPT (Y OR "")^SPECIALITY^ADDRESS1^ADDRESS2^CITY^STATE^ZIP^COUNTY^PHONE^FAX
 ;   2)=DEL FLAG (OR AWAITING AUSTIN APPROVAL)^TYPE^PARTICIPATION CODE^MEDICARE ID^CHAIN^TYPE(FPDS)
 ;   3)=Group (FPDS)^Group (FPDS)^Group (FPDS)^Group (FPDS)^Group (FPDS)
 ;   4)=AUSTIN NAME^CHANGE TO DATE^CHANGE FROM DATE
 ;   
 N A,Z,FBAAFN,FBDEL,FBI,FBAAPN,FBRR,FBXX,SPEC,T,V,X,Y
 K ^TMP($J,"DSIFPAY0"),FBOUT S:$G(U)="" U="^"
 S FBOUT=$NA(^TMP($J,"DSIFPAY0"))  ;Used as reference needed by broker and accessed by @FBOUT@ (indirection)
 I $G(FBDA)="" S @FBOUT@(0)="-1^Not a valid Vendor file number" Q
 N C,I S Z=$G(^FBAAV(FBDA,0)),V=$G(^(1)),T=$G(^("AMS")),A=$G(^("ADEL"))
 F X=1:1:17 S Z(X)=$P(Z,U,X)
 S FBDEL=$S($P(A,U)="Y":1,1:0),FBAAPN=$P(V,U),FBAAFN=$P(V,U,9),SPEC=$P($G(^FBAA(161.6,+Z(8),0)),U)
 I FBDEL S @FBOUT@(2)="**FLAGGED FOR DELETION" Q
 I $$CKVEN^FBAADV(FBDA) S @FBOUT@(2)="**AWAITING AUSTIN APPROVAL"
 S @FBOUT@(1)=$E(Z(1),1,30)_U_Z(2)_U_$P(T,U,2)_U_SPEC_U_Z(3)_U_Z(14)_U_Z(4)_U_$P($G(^DIC(5,+Z(5),0)),U)_U_Z(6)_U_Z(13)
 S @FBOUT@(1)=@FBOUT@(1)_U_FBAAPN_U_FBAAFN
 S @FBOUT@(2)=$E($P($G(^FBAA(161.6,+Z(8),0)),U),1,20)
 S @FBOUT@(2)=@FBOUT@(2)_U_$P($P(^DD(161.2,6,0),Z(7)_":",2),";")_U_$S($D(^FBAA(161.81,+Z(9),0)):$E($P(^(0),U),1,21),1:"UNKNOWN")
 S @FBOUT@(2)=@FBOUT@(2)_U_Z(6)_U_Z(17)_U_$$EXTERNAL^DILFD(161.2,24,"",$P(V,U,10))
 S @FBOUT@(3)="",(C,I)=0 F  S I=$O(^FBAAV(FBDA,2,I)) Q:'I  D
 . S X=$P($G(^FBAAV(FBDA,2,I,0)),U) Q:'X
 . S X=$$GET1^DIQ(420.6,X,1) Q:X=""   ; ICR: 2071
 . S @FBOUT@(3)=$S(@FBOUT@(3)="":$E(X,1,21),1:@FBOUT@(3)_U_$E(X,1,21))
 S @FBOUT@(4)=$P(T,U)
 I $P(A,U,5)]"" S @FBOUT@(4)=@FBOUT@(4)_U_" by "_$S($P(A,U,5)="000":"Non-Fee User",1:"Station ")
 I $P(A,U,2)]""!($P(A,U,4)]"") S @FBOUT@(5)="Last Change"_" - TO Austin:"_$$DATX^FBAAUTL($P(A,U,2))_";"_$$FMTE^XLFDT($P(A,U,2),5)
 I $P(A,U,4)'="" S @FBOUT@(5)=@FBOUT@(5)_U_" - FROM Austin:  "_$$DATX^FBAAUTL($P(A,U,4))_";"_$$FMTE^XLFDT($P(A,U,4),5)
 I $D(@FBOUT@(1)) S @FBOUT@(0)="1^VENDOR DETAILS"
 Q
 ;
GETPAY(FBOUT) ;  RPC: DSIF PAY GET VALUES
 ; List values needed for selection screens, no input
 ;   ^TMP($J,"DSIFPAY0","D",I)="Place of service"^353.1^IEN^Code^Name
 ;   ^TMP($J,"DSIFPAY0","E",I)="HCFA Type of service"^353.2^IEN^Code^Name
 ;   ^TMP($J,"DSIFPAY0","F",I)="Remittance remark"^161.93^IEN^Code^Status Effective date^Status [1 for active]^Fee use [1 yes or 0 no]
 ;   ^TMP($J,"DSIFPAY0","G",I)="Revenue Code"^399.2^IEN^Code^Std. Abbreviation^active code^Description^All inclusive
 ;   
 S FBOUT=$NA(^TMP($J,"DSIFPAY0"))
 K ^TMP($J,"DSIFPAY0")
 N LIST,ARRAY,ADAT,IEN
 D LIST^DIC(353.1,"",".01;.02","","","","","","","","ARRAY","MSG") S ADAT=$NA(ARRAY("DILIST","ID"))
 N I S I=0 F  S I=$O(@ADAT@(I)) Q:'I  S IEN=ARRAY("DILIST",2,I),^TMP($J,"DSIFPAY0","D",IEN)="Place of service^353.1"_U_IEN_U_@ADAT@(I,.01)_U_@ADAT@(I,.02)
 ; Type of service, file #353.2
 N LIST,ARRAY,ADAT,IEN
 D LIST^DIC(353.2,"",".01;.02","","","","","","","","ARRAY","MSG") S ADAT=$NA(ARRAY("DILIST","ID"))
 N I S I=0 F  S I=$O(@ADAT@(I)) Q:'I  S IEN=ARRAY("DILIST",2,I),^TMP($J,"DSIFPAY0","E",IEN)="Type of service^353.2"_U_IEN_U_@ADAT@(I,.01)_U_@ADAT@(I,.02)
 ;  Remittance remark, file #161.93
 N LIST,ARRAY,ADAT,IENS,IEN
 D LIST^DIC(161.93,"",".01","","","","","","","","ARRAY","MSG") S ADAT=$NA(ARRAY("DILIST","ID"))
 N I S I=0 F  S I=$O(@ADAT@(I)) Q:'I  S IEN=ARRAY("DILIST",2,I),^TMP($J,"DSIFPAY0","F",IEN)="Remittance remark^161.93"_U_IEN_U_@ADAT@(I,.01) D
 . N SUB,ADAT1 S IENS=","_IEN_"," D LIST^DIC(161.931,IENS,".01;1;2","I","","","","","","","SUB","MSG") S ADAT1=$NA(SUB("DILIST","ID"))
 . ;   Get last effective date, check to see if status is inactive {0}
 . N K S K=0 F  S K=$O(@ADAT1@(K)) Q:'K  I @ADAT1@(K,1)'=0 S $P(^TMP($J,"DSIFPAY0","F",IEN),U,5,7)=@ADAT1@(K,.01)_";"_$$FMTE^XLFDT(@ADAT1@(K,.01),5)_U_@ADAT1@(K,1)_U_@ADAT1@(K,2)
 ; Revenue Code, file #399.2
 N LIST,ARRAY,ADAT,IEN
 D LIST^DIC(399.2,"",".01;2;3;4","","","","","","","","ARRAY","MSG") S ADAT=$NA(ARRAY("DILIST","ID"))
 N I S I=0 F  S I=$O(@ADAT@(I)) Q:'I  D
 . S IEN=ARRAY("DILIST",2,I)
 . S ^TMP($J,"DSIFPAY0","G",IEN)="Revenue code^399.2"_U_IEN_U_@ADAT@(I,.01)_U_@ADAT@(I,2)_U_@ADAT@(I,3)_U_@ADAT@(I,4)
 Q
 ;
USERBATS(FBOUT,USER) ; RPC: DSIF BATCH OPEN USER 
 ; show open batches with associated control points,  input =  USER IEN
 ; Output:  FBOUT(0)=1^count or -1^error message
 ;     FBOUT(n)=Batch number^Type^Control Point^Date opened (INT;EXT)
 K FBOUT N CNT,FBBN,FBBT,FBDO,FBON,J S CNT=0
 I '$D(^FBAA(161.4,1,0)) S FBOUT(0)="-1^Site parameters must be entered before using the Fee system!" Q
 I $G(USER)="" S FBOUT(0)="-1^No user entered" Q
 I '$D(^VA(200,USER,0)) S FBOUT(0)="-1^Invalid user" Q
 I '$D(^FBAA(161.7,"AB","O",USER)) S FBOUT(0)="1^You have no open Batches!!" Q
 F J=0:0 S J=$O(^FBAA(161.7,"AB","O",USER,J)) Q:J'>0  I $D(^FBAA(161.7,J,0)) S Y(0)=^(0) D
 . S FBBN=$P(Y(0),"^",1),FBON=$P(Y(0),"^",2),FBBT=$P(Y(0),"^",3),FBDO=$P(Y(0),"^",4)
 . S CNT=CNT+1,FBOUT(CNT)=FBBN_U_$S(FBBT="B3":"Medical",FBBT="B5":"Pharmacy",FBBT="B2":"Travel",FBBT="B9":"CH/CNH",1:"Unknown")_U_FBON_U_FBDO_";"_$$FMTE^XLFDT(FBDO,5)
 S FBOUT(0)="1^"_CNT Q
 ;
CPT(FBOUT) ;  RPC:  DSIF CPT CR DISPLAY
 ;  Display CPT warning message, no input
 K FBOUT N VARR,VAXX,X
 F VARR=0:0 S VARR=$O(^DIC(81.2,1,1,VARR)) Q:VARR'>0  S VAXX=^(VARR,0),X=VAXX S FBOUT(VARR)=X
 Q
