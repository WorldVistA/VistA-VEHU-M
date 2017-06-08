DSIFEP1 ;DSS/AMC - FEE BASIS PAYMENT RETRIEVAL; 03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;  2056  GETS^DIQ
 ;  2051  FIND^DIC
 ;
LOOKUP(AXY,FB7078) ;RPC - DSIF INP PAYMENT LIST
 ;Input Parameter
 ;    FB7078 - Internal Entry Number to file 162.4
 ;    
 ;Return Array
 ;    -1^Invalid Input!
 ;    -1^No Entries Found!
 ;    Invoice IEN ^ Invoice Number^Invoice Date Received (I;E) ^Vendor (I;E) ^Date Paid (I;E) ^Check Number
 ;    
 N AXY1
 S AXY=$NA(^TMP("DSIFEP1",$J)),AXY1=$NA(^TMP("DSIF",$J)) K @AXY,@AXY1
 N YY,XX,FIND,ERRM S YY=0
 I '$G(FB7078) S @AXY@(YY)="-1^Invalid Input!" Q
 D FIND^DIC(162.5,,".01;1IE;2IE;45IE;48","P",FB7078,,"E",,,AXY1,"ERRM")
 F  S YY=$O(@AXY1@("DILIST",YY)) Q:'YY  S XX=$G(@AXY1@("DILIST",YY,0)) D
 .S @AXY@(YY)=$P(XX,U,1,2)_U_$P(XX,U,4)_";"_$P(XX,U,5)_U_$P(XX,U,6)_";"_$P(XX,U,7)_U_$P(XX,U,8)_";"_$P(XX,U,9)_U_$P(XX,U,10)
 I '$O(@AXY@(0)) S @AXY@(0)="-1^No Entries Found!"
 K @AXY1
 Q
EN(AXY,IEN) ;RPC - DSIF INP GET PAYMENT
 ;Input Parameters
 ;    IEN - Internal Entry Number to file 162.5
 ;    
 ;Return Array
 ;    -1^Invalid Input!
 ;    Data List will contain Field # ^ Internal Data ; External Data
 ;           1 ^ Invoice Date Received
 ;           24 ^ Dsch DRG 
 ;           46 ^ Vendor Invoice Date
 ;           55 ^ Patient Control Number
 ;           47 ^ Prompt Pay Type 
 ;           6.5 ^ Dsch Type Code 
 ;           54 ^ Covered Days 
 ;           6.6 ^ Billed Charges 
 ;           7 ^ Amount Claimed 
 ;           8 ^ Amount Paid 
 ;           6.7 ^ Payment by Medicare/Fed Agency 
 ;           30 ^ ICD1 
 ;           31 ^ ICD2 
 ;           32 ^ ICD3 
 ;           33 ^ ICD4 
 ;           34 ^ ICD5 
 ;           40 ^ PROC1
 ;           41 ^ PROC2
 ;           42 ^ PROC3
 ;           43 ^ PROC4
 ;           44 ^ PROC5
 ;           25 ^ Resubmission
 ;                
 ;Note the following have 3 pieces
 ;
 ;           58 ^ .01 ^ Adj Reason 
 ;           58 ^ 1 ^ Adj Group 
 ;           58 ^ 2 ^ Adj Amount 
 ;           59 ^ Seq # (1 or 2) ^ Remittance Remark 
 ;           
 S IEN=+$G(IEN),AXY=$NA(^TMP("DSIFEP1",$J)) K @AXY
 N GET,IENS,FIL,XX,YY S YY=0
 I 'IEN S @AXY@(YY)="-1^Invalid Input!" Q
 S FIL=162.5,IENS=IEN_","
 D GETS^DIQ(FIL,IENS,"**","IE","GET")
 N ZZ
 F ZZ=1,6.5,6.6,7,8,24,25,30,31,34,33,34,40,41,42,43,44,46,47,54,55 S:$G(GET(FIL,IENS,ZZ,"I"))]"" XX=ZZ_U_$G(GET(FIL,IENS,ZZ,"I"))_";"_$G(GET(FIL,IENS,ZZ,"E")),YY=YY+1,@AXY@(YY)=XX
 D:$D(GET(162.558))
 .N IEN1,FLE S IEN1="",FLE=162.558
 .S IEN1=$O(GET(FLE,IEN1))
 .S:$G(GET(FLE,IEN1,".01","I"))]"" XX="58^.01^"_$G(GET(FLE,IEN1,.01,"I"))_";"_$G(GET(FLE,IEN1,.01,"E")),YY=YY+1,@AXY@(YY)=XX
 .S:$G(GET(FLE,IEN1,1,"I"))]"" XX="58^1^"_$G(GET(FLE,IEN1,1,"I"))_";"_$G(GET(FLE,IEN1,1,"E")),YY=YY+1,@AXY@(YY)=XX
 .S:$G(GET(FLE,IEN1,2,"I"))]"" XX="58^2^"_$G(GET(FLE,IEN1,2,"I"))_";"_$G(GET(FLE,IEN1,2,"E")),YY=YY+1,@AXY@(YY)=XX
 D:$D(GET(162.559))
 .N IEN1,FLE S IEN1="",FLE=162.559
 .F  S IEN1=$O(GET(FLE,IEN1)) Q:IEN1=""  D
 ..S XX="59^"_+IEN1_U_$G(GET(FLE,IEN1,.01,"I"))_";"_$G(GET(FLE,IEN1,.01,"E")),YY=YY+1,@AXY@(YY)=XX
 Q
