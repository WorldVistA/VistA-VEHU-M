DSIFPAY7 ;DSS/RED,DLF - RPC FOR FEE BASIS PAYMENTS ;2/1/2007 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,4,10,8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   2056  GETS^DIQ
 ;   5084  $$CKVEN^FBAADV
 ;   5113  $$VNAME^FBNHEXP
 ;   1074  ^VATRAN
 ;   5111  ^FBAAV5
 ;   5094  ^FBAAV6
 ;   5273  ^FBAA(161.7
 ;   2171  $$NS^XUAF4
 ;   5277  ^FBAAI
 ;   2056  $$GET1^DIQ
 ;
 Q  ;No direct access 
SITEP ;SET FBSITE(0),FBSITE(1) VARIABLE TO FEE SITE PARAMETERS
 S FBPOP=0,FBSITE(0)=$G(^FBAA(161.4,1,0)) S:FBSITE(0)']"" FBPOP=1
 S FBSITE(1)=$G(^FBAA(161.4,1,1)) S:FBSITE(1)']"" FBPOP=1
 S:FBPOP @DSIFOUT@(0)="-1^Fee Basis Site Parameters must be entered to proceed"
 Q
STATION ;GET STATION NUMBER FROM INSTITUTION FILE
 I '$D(FBSITE(1)) D SITEP
 I $P($$NS^XUAF4($P(FBSITE(1),U,3)),U,2)="" G NOSTA
 S (FBSN,FBAASN)=$P($$NS^XUAF4($P(FBSITE(1),U,3)),U,2)
 Q
CKB9V ;
 F FB1=0:0 S FB1=$O(^FBAAI("AC",J,FB1)) Q:'FB1  I $G(^FBAAI(FB1,0)) S FB2=+$P(^FBAAI(FB1,0),"^",3) D CHKV   ;Remove FBERR DSIF*3.2*10
 Q
CHKV I $$CKVEN^FBAADV(FB2) S @DSIFOUT@(J)="-1^"_DSIFBN_U_"Vendor #"_FB2_" Not approved in Austin. Batch will NOT TRANSMIT!!!" Q   ;Remove FBERR DSIF*3.2*10
 Q:$G(FBAABT)'="B9"   ; Added check for B9 batch with DSIF*3.2*1
 I $G(Y(0))="" Q  ;Added validity check with DSIF*3.2*8
 G:FBSTAT="S"&($G(FBCHB)="Y")&($P(Y(0),"^",18)'="Y") ^FBAAV6
 D DETCH^FBAAV5
 Q
NOSTA S FB("ERROR")=1 I '$D(ZTQUEUED) S @DSIFOUT@(0)="-1^Unable to determine Station Number. Check Fee Site Parameters or Station Number in the Institution File." Q
 Q
ADDRESS ;set up recipient array, FBXMFEE( for FEE router, FBXMNVP( for NVP router
 F VATNAME="FEE","NVP" D ^VATRAN G:VATERR ADDQ S FBI=0 F  S FBI=$O(VAT(FBI)) Q:'FBI  S FBVAR="FBXM"_VATNAME_"("_FBI_")" S @FBVAR=VAT(FBI)
ADDQ Q
 ;Following checks for Austin Name Field in Vendor file in order to continue transmitting that batch.
CKB3V F FB1=0:0 S FB1=$O(^FBAAC("AC",J,FB1)) Q:'FB1  F FB2=0:0 S FB2=$O(^FBAAC("AC",J,FB1,FB2)) Q:FB2'>0  D CHKV   ;Remove FBERR DSIF*3.2*10
 Q
INDISP(FBOUT,VAL) ;  RPC: DSIF VIEW INVOICE
 ; INPUT: VAL=File IEN   - Used for file 162.5 
 ; OUTPUT:  ^TMP($J,"DSIFPAY7",field number)=field number^internal value;external value
 ; 
 N LIST,NUM,MSG,CNTR ;DSIF*3.2*2  added CNTR
 S FBOUT=$NA(^TMP($J,"DSIFPAY7")) K @FBOUT
 S FILE=162.5  ;Fee Basis Invoices
 I $G(VAL)=""!('$D(^FBAAI(VAL))) S @FBOUT@(0)="-1^Invalid or missing Invoice number entered" Q 
 D GETS^DIQ(FILE,VAL_",","**","IE","LIST","MSG")
 I $D(MSG) S @FBOUT@(0)="-1^Data retrieval error, or data error in entry # "_VAL_" in file 162.5" Q
 S NUM=0 F  S NUM=$O(LIST(FILE,VAL_",",NUM)) Q:'NUM  I $G(LIST(FILE,VAL_",",NUM,"I"))]"" D
 . I NUM'=18,NUM<29.99!(NUM>36.99) S @FBOUT@(NUM)=NUM_U_$G(LIST(FILE,VAL_",",NUM,"I"))_";"_$G(LIST(FILE,VAL_",",NUM,"E"))
 . I (NUM>=30)&(NUM<37) D
 . . I ($E(NUM,$L(NUM))=2)&($E(NUM,$L(NUM)-2)=".") D   ;DSIF*3.2*2 Checking if it ends in .02 for POA 
 . . . S @FBOUT@(NUM-0.02)=@FBOUT@(NUM-0.02)_U_$G(LIST(FILE,VAL_",",NUM,"I")) ;DSIF*3.2*2 
 . . . S @FBOUT@(NUM-0.02)=@FBOUT@(NUM-0.02)_";"_$G(LIST(FILE,VAL_",",NUM,"E")) ;DSIF*3.2*2 
 . . E  S @FBOUT@(NUM)=NUM_U_$G(LIST(FILE,VAL_",",NUM,"I"))_";"_$G(LIST(FILE,VAL_",",NUM,"E")) ;DSIF*3.2*2 
 ; Return line items
 S CNTR=0 ;DSIF*3.2*2  the following block code adds line items according to their number in FBOUT("LI",0.0X-5.0X)
 ; So, line item 3 properties will be saved in FBOUT("LI",3.01-3.04)
 S NUM=0 F  S NUM=$O(LIST(FILE+.079,CNTR_","_VAL_",",NUM)) Q:CNTR>5  D   ;DSIF*3.2*2  
 . I $G(NUM) S @FBOUT@("LI",CNTR+NUM)=NUM_U_$G(LIST(FILE+.079,CNTR_","_VAL_",",NUM,"I")) ;DSIF*3.2*2 
 . I '$G(NUM) S CNTR=CNTR+1,NUM=0 ;DSIF*3.2*2 
 ; Subfile data retrieval
 I $D(^FBAAI(VAL,1)) D
 . N IENS,I,LIST0,MSG,DATA518 F I=1:1:$P(^FBAAI(VAL,1,0),U,4) S IENS=I_","_VAL_"," S DATA518(I)=$$GET1^DIQ(162.518,IENS,".01",,"DATA","MSG") D
 . . S @FBOUT@(18,I)="18"_U_I_U_$G(DATA518(I))
 I $D(^FBAAI(VAL,8))  D
 . N IENS,I,LIST1,MSG F I=1:1:$P(^FBAAI(VAL,8,0),U,4) S IENS=I_","_VAL_"," D GETS^DIQ(162.558,IENS,"**","IE","MSG","LIST1") D
 . . S @FBOUT@(58,I,.01)="58^"_I_"^.01^"_MSG(162.558,IENS,.01,"I")_";"_MSG(162.558,IENS,.01,"E")
 . . S @FBOUT@(58,I,1)="58^"_I_"^1^"_MSG(162.558,IENS,1,"I")_";"_MSG(162.558,IENS,1,"E")
 . . S @FBOUT@(58,I,2)="58^"_I_"^2^"_MSG(162.558,IENS,2,"I")_";"_MSG(162.558,IENS,2,"E")
 I $D(^FBAAI(VAL,9)) D
 . N IENS,I,LIST2,MSG F I=1:1:$P(^FBAAI(VAL,9,0),U,4) S IENS=I_","_VAL_"," D GETS^DIQ(162.559,IENS,"**","IE","MSG","LIST2") D
 . . S @FBOUT@(59,I,.01)="59^"_I_"^.01^"_MSG(162.559,IENS,.01,"I")_";"_MSG(162.559,IENS,.01,"E")
 . Q
 Q
