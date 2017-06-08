DSIFPAY1 ;DSS/RED - RPC FOR FEE BASIS PAYMENTS ;12/31/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;  2051  LIST^DIC
 ;  2055  $$EXTERNAL^DILFD
 ;  2056  GETS^DIQ
 ;  5087  $$FAC^FBAAFS,$$GET^FBAAFS
 ;  1997  $$CAT^ICPTAPIU
 ;  1995  $$CPT^ICPTCOD
 ; 10103  $$FMTE^XLFDT
 ;
 Q
DISPAY(FBOUT,DFN,FBV,DSIEN,CIEN) ; RPC: DSIF PAY PAYMENT DISPLAY (used for edit)
 ; Input:  DFN=Pt IEN, FBV=Vendor IEN, DSIEN=Date of service IEN, CIEN=CPT code IEN
 ; Output: (excludes all payments that have been finalized, these cannot be edited)
 ; ^TMP($J,"DSIFPAY1",0)="Fee_prog"^Date of service (internal;external)^Fee program^Auth IEN
 ; ^TMP($J,"DSIFPAY1",ID,0)="ID"^ID^Invoice Number
 ; ^TMP($J,"DSIFPAY1",ID,1)=)="Line 1"^Service provided (i;e)^Amt Claimed^Amount Paid^Date Finalized^Batch #^Obligation #^Date correct invoice received^
 ;                       Patient type^POV^Treatment type^Primary Service facility^Money managed/Prompt pay^Contract number
 ; ^TMP($J,"DSIFPAY1",ID,2)="Line 2"^Primary Diagnosis^Place of service^HCFA type of service^Service connected condition^
 ; Vendor invoice date^Site of service zip code^Units paid^Revenue code^Patient account number^FPPS claim ID^FPPS line item^Fee schedule
 ;   ^Fee Program^Associated 7078 or 583^Mill Bill (YES only if true)^Anesthesia time (17th Piece Added in DSIF*3.2*1)
 ; ^TMP($J,"DSIFPAY1",ID,3)="Line 3"^Attending Prov Name^Attending Prov NPI^Attending Prov Taxonomy Code^Operating Prov Name^Operation Prov NPI
 ;   ^Rendering Prov Name^Rendering Prov NPI^Rendering Prov Taxonomy Code^Servicing Prov Name^Servicing Prov NPI^Referring Prov Name^Referring Prov NPI
 ; ^TMP($J,"DSIFPAY1",ID,4)="Line 4"^Servicing Facility Address^Servicing Facility City^Servicing Facility State^Servicing Facility ZIP (added in DSIF*3.2*2)
 ;       (CIEN= Service provided IEN [CPT])^LI Rendering Prov Name^LI Rendering Prov NPI^LI Rendering Prov Taxonomy (added in DSIF*3.2*2)
  ; ^TMP($J,"DSIFPAY1",ID,5)="Remit_remark"^IEN;Remittance remark^ [repeat for each remark]
 ; ^TMP($J,"DSIFPAY1",ID,6)="CPT_modifiers"^IEN;Cpt modifier 1^ [repeat for each modifier]
 ; ^TMP($J,"DSIFPAY1",ID,7)="Adjustments"^(#.01) Adjustment reason^(#1)Adjustment group^(#2)Adjustment amount^ [repeat for each adjustment]
 ;
 K FBOUT,^TMP($J,"DSIFPAY1") N I,IENS,FLAG
 S IEN="",CNT=0,FLAG=0
 S FBOUT=$NA(^TMP($J,"DSIFPAY1"))
 ; DSIF*3.2*2 (verify input variables)
 I $G(DFN)<1 S @FBOUT@(0)="-1^Patient does not have payments" Q
 N Z F Z=$G(DFN),$G(FBV),$G(DSIEN),$G(CIEN) I $G(Z)<1 S FLAG=1
 I FLAG S @FBOUT@(0)="-1^Required entry not provided" Q
 I '$D(^FBAAC(DFN)) S @FBOUT@(0)="-1^Patient does not have payments" Q
 I $G(FBV)<1 S @FBOUT@(0)="-1^Not a valid vendor for this patient" Q
 I '$D(^FBAAC(DFN,1,FBV)) S @FBOUT@(0)="-1^Not a valid vendor for this patient" Q
 I '$D(^FBAAC(DFN,1,FBV,1,DSIEN)) S @FBOUT@(0)="-1^Not a valid payment for this patient" Q  ;Additional verifications for payment DSIF*3.2*2
 I '$D(^FBAAC(DFN,1,FBV,1,DSIEN,1,CIEN,0)) S @FBOUT@(0)="-1^Not a valid payment for this patient" Q
 ; retrieve payment data
 N VAR,FLD,ARRAY,ID,ADAT,CPTM,REMIT,MSG1,MSG2,MSG3,K,NIENS,ADJ,AIENS,RIENS,FBADJ,FBREM,FBMOD,MIENS,INVIEN,IENS2,LINE
 S IENS=CIEN_","_DSIEN_","_FBV_","_DFN_",",IENS2=DSIEN_","_FBV_","_DFN_"," ;DSIF*3.2*2 set IENS2
 S ID=DFN_";"_FBV_";"_DSIEN_";"_CIEN,LINE=0
 S @FBOUT@(ID,0)="ID^"_ID,@FBOUT@(ID,1)="Line 1",@FBOUT@(ID,2)="Line 2",@FBOUT@(ID,3)="Line 3",@FBOUT@(ID,4)="Line 4" ;DSIF*3.2*2 new fields
 D GETS^DIQ(162.03,IENS,"**","IE","ARRAY","MSG1")   ;DSIF*3.2*2 Modified to get all available fields 
 S ADAT=$NA(ARRAY(162.03,IENS)),INVIEN=$G(@ADAT@(14,"I"))
 F FLD=.01,1,2,5,7,8,13,15,16,17,26,28,30,31,32,33,34,42,47,48,49,50,51,45,23,27,43,54 D   ;DSIF*3.2*1 Field 43 added ;DSIF*3.2*2 Field 54 added 
 . I $D(@ADAT@(FLD,"I")),FLD S VAR=$S($G(@ADAT@(FLD,"I"))'=@ADAT@(FLD,"E"):$G(@ADAT@(FLD,"I"))_";"_$G(@ADAT@(FLD,"E")),1:$G(@ADAT@(FLD,"I")))
 . S:FLD=".01" VAR=$G(@ADAT@(.01,"I"))_";"_$G(@ADAT@(.01,"E")) S:FLD=28 VAR=$G(@ADAT@(28,"I"))_";"_$G(@ADAT@(28,"E"))
 . I $P($G(@ADAT@(FLD,"I")),U)=""!($P($G(@ADAT@(FLD,"I")),U)=0) S VAR=""
 . I FLD<28,FLD'=23,FLD'=27,FLD'=43 S @FBOUT@(ID,1)=@FBOUT@(ID,1)_U_VAR Q
 . I FLD=27,$G(@ADAT@(27,"I"))["583" S @FBOUT@(ID,2)=@FBOUT@(ID,2)_U_$$GET1^DIQ(162.7,+$G(@ADAT@(27,"I"))_",",31)
 . I FLD=34 S $P(@FBOUT@(ID,1),U,13)=$G(VAR) Q   ;DSIF*3.2*2 Manually set the 13th piece of line 1 to Money managed/Prompt pay 
 . I FLD=43 S $P(@FBOUT@(ID,2),U,17)=$G(@ADAT@(43,"I")) Q   ;DSIF*3.2*1 Manually set the 17th piece to field 43
 . I FLD=54 S $P(@FBOUT@(ID,1),U,14)=$G(VAR) Q  ;DSIF*3.2*2 Manually set the 14th piece of line 1 to contract 
 . I FLD'=43 S @FBOUT@(ID,2)=@FBOUT@(ID,2)_U_$G(VAR)
 F FLD=58,59,60,61,62,63,64,65,66,67,68,69,76,77,78,79 D   ;DSIF*3.2*2 for loop to access different fields
 . S LINE=3 I FLD>69 S LINE=4 ;DSIF*3.2*2 depending on their fields, assign different lines
 . S @FBOUT@(ID,LINE)=@FBOUT@(ID,LINE)_U_$G(@ADAT@(FLD,"I"))
 . I $G(@ADAT@(FLD,"I"))'=$G(@ADAT@(FLD,"E")) S @FBOUT@(ID,LINE)=@FBOUT@(ID,LINE)_";"_$G(@ADAT@(FLD,"E")) ;DSIF*3.2*2 if internal is different from external, show external
 S @FBOUT@(ID,0)=@FBOUT@(ID,0)_U_INVIEN
 S NIENS=","_IENS,(RIENS,AIENS,MIENS)=""
 ;get Remittance remarks
 S @FBOUT@(ID,5)="Remit_remark" S FBREM=$P($G(^FBAAC(DFN,1,FBV,1,DSIEN,1,CIEN,8,0)),U,3) I FBREM'="" N X F X=1:1:FBREM D
 . Q:'$D(^FBAAC(DFN,1,FBV,1,DSIEN,1,CIEN,8,X))
 . S RIENS=X_NIENS K REMIT,MSG2
 . D GETS^DIQ(162.08,RIENS,".01","IE","REMIT","MSG2") I $D(REMIT(162.08,RIENS)) S @FBOUT@(ID,5)=@FBOUT@(ID,5)_U_$G(REMIT(162.08,RIENS,.01,"I"))_";"_$G(REMIT(162.08,RIENS,.01,"E"))
 ;get CPT modifiers
 S @FBOUT@(ID,6)="CPT_modifiers" S FBMOD=$P($G(^FBAAC(DFN,1,FBV,1,DSIEN,1,CIEN,"M",0)),U,3) I FBMOD'="" N X F X=1:1:FBMOD D
 . Q:'$D(^FBAAC(DFN,1,FBV,1,DSIEN,1,CIEN,"M",X))
 . S MIENS=X_NIENS K CPTM,MSG3
 . D GETS^DIQ(162.06,MIENS,".01","IE","CPTM","MSG3") I $D(CPTM(162.06,MIENS)) S @FBOUT@(ID,4)=@FBOUT@(ID,4)_U_$G(CPTM(162.06,MIENS,.01,"I"))_";"_$G(CPTM(162.06,MIENS,.01,"E"))
 ;Get adjustments
 S @FBOUT@(ID,7)="Adjustments" S FBADJ=$P($G(^FBAAC(DFN,1,FBV,1,DSIEN,1,CIEN,7,0)),U,3) I FBADJ'="" N X F X=1:1:FBADJ D
 . Q:'$D(^FBAAC(DFN,1,FBV,1,DSIEN,1,CIEN,7,X))
 . S AIENS=X_NIENS K ADJ,MSG4
 . D GETS^DIQ(162.07,AIENS,".01;1;2","IE","ADJ","MSG4") I $D(ADJ(162.07,AIENS)) D
 . S @FBOUT@(ID,7)=@FBOUT@(ID,7)_U_$G(ADJ(162.07,AIENS,.01,"I"))_";"_$G(ADJ(162.07,AIENS,.01,"E"))_U_$G(ADJ(162.07,AIENS,1,"I"))_";"_$G(ADJ(162.07,AIENS,1,"E"))_U_$G(ADJ(162.07,AIENS,2,"E"))
 S @FBOUT@(0)=1,@FBOUT@(1)="Fee_prog"_U_$P($G(^FBAAC(DFN,1,FBV,1,DSIEN,0)),U)_";"_$$FMTE^XLFDT($P($G(^FBAAC(DFN,1,FBV,1,DSIEN,0)),U),5)_U_$P($G(^FBAAC(DFN,1,FBV,1,DSIEN,0)),U,3,4)
 ;Add Fee basis program^Auth IEN
 I '$D(^TMP($J,"DSIFPAY1")) S @FBOUT@(0)="-1^No editable payments found for the values entered"
 Q
 ;
REJECTS(FBOUT) ; RPC:  DSIF BATCH GET REJECTS
 ; Display batches with rejects pending 
 ; OUTPUT:  FBOUT(0)=1^Number of rejects OR -1^Error message
 ;               FBOUT(n)=IEN^Batch number^Obligation^Rejects pending^Clerk who opened
 K FBOUT
 N ARRAY,DATA,MSG
 D LIST^DIC(161.7,"",".01;1;4IE;11;15","","","","","","","","ARRAY","MSG") S DATA=$NA(ARRAY("DILIST","ID"))
 I $D(MSG) S FBOUT(0)="-1^Error in processing" Q
 N IEN,CNT S IEN=0,CNT=1 F  S IEN=$O(ARRAY("DILIST",2,IEN)) Q:IEN<1  D
 . I @DATA@(IEN,15)="YES" S FBOUT(CNT)=IEN_";"_@DATA@(IEN,.01)_U_@DATA@(IEN,1)_U_@DATA@(IEN,15)_U_@DATA@(IEN,4,"I")_";"_@DATA@(IEN,4,"E"),CNT=CNT+1
 I '$D(FBOUT) S FBOUT(0)="-1^No rejects pending at this time" Q
 S FBOUT(0)="1"_U_(CNT-1)
 Q
 ;
PAYSCH(FBOUT,FBCPT,FBMODL,FBDOS,FBZIP,FBVEN,FBSER) ; RPC: DSIF PAY SCHEDULE
 ; Get pay schedule amounts by CPT, Modifiers and Zip code  [FBAAFS]
 ;INPUT: FBCPT=CPT code, FBMODL=CPT modifiers (comma delimited),FBDOS=Date of service,FBZip=Zip code
 ;           FBVEN=Vendor IEN, FBSER=Place of service (#353.1 - NOT IEN)
 ;OUTPUT: FBOUT=^amount^FEE SCHEDULE^Major Category^Sub-Category^Procedure^Year         
 N FBRSLT,FBHCFA,FBFAC,FBOUTX,FBAMT,DSIFCPT,FBCATX,FBFAC,FBCHFA,FBOUTX,FBRSLT,FBTIME K FBOUT
 I $G(FBCPT)']""!($G(FBDOS)']"")!($G(FBZIP)']"")!($G(FBSER)']"") S FBOUT="-1^Required variables not entered" Q
 S FBSER=$O(^IBE(353.1,"B",FBSER,""))   ;Convert entry to 353.1
 S FBHCFA(30)=FBSER,FBFAC=$$FAC^FBAAFS(FBHCFA(30)),FBOUTX=""
 S DSIFCPT=$$CPT^ICPTCOD(FBCPT,FBDOS,1) I '$P(DSIFCPT,U,7) S FBOUT="-1^CPT code inactive on date of service" Q
 S FBCATX=$$CAT^ICPTAPIU($P(DSIFCPT,U,4))
 I $G(FBMODL)="" S FBMODL=""
 I FBMODL["^" S FBMODL=$TR(FBMODL,"^",",")  ;Need modifiers to comma delimited not "^" delimited
 I $P(FBCATX,U)'=-1 S FBOUTX=$P(FBCATX,U,4)_U_$P(FBCATX,U)
 S FBOUTX=FBOUTX_U_$P(DSIFCPT,U,2),FBTIME=""
 S FBRSLT=$$GET^FBAAFS(FBCPT,FBMODL,FBDOS,FBZIP,FBFAC)
 I $P($G(FBRSLT),U)]"" D
 . S FBOUT="1^"_$P(FBRSLT,U) I $P(FBRSLT,U,2)]"" S FBOUT=FBOUT_U_$P(FBRSLT,U,2)_";"_$$EXTERNAL^DILFD(162.03,45,"",$P(FBRSLT,U,2))
 I $P($G(FBRSLT),U)']"" D
 . S FBOUT="-1^"_"Unable to determine a FEE schedule amount.^"
 I $D(FBOUTX) S FBOUT=FBOUT_U_FBOUTX_U_$P(FBRSLT,U,3) ; year if returned
 Q
ALLPAYB(FBOUT,FBBAT) ;RPC: DSIF PAY ALL BATCH
 ;FBBAT = Batch IEN
 ;Output: FBOUT(0)=1 OR -1^ERROR MESSAGE
 ;  FBOUT(CNT)=cnt^patient^vendor^service date^CPT^ID^Invoice number
 K FBOUT N FBVEN,CNT,PT,VID,SD,CP,DFN
 I '$D(^FBAA(161.7,FBBAT)) S FBOUT(0)="-1^Not a valid batch" Q
 S CNT=0,FBOUT(0)=1
 F PT=0:0 S PT=$O(^FBAAC("AC",FBBAT,PT)) Q:'PT  D
 . S DFN=PT D DEM^VADPT F VID=0:0 S VID=$O(^FBAAC("AC",FBBAT,PT,VID)) Q:'VID  D
 . . F SD=0:0 S SD=$O(^FBAAC("AC",FBBAT,PT,VID,SD)) Q:'SD  D
 . . . F CP=0:0 S CP=$O(^FBAAC("AC",FBBAT,PT,VID,SD,CP)) Q:'CP  D
 . . . . S CNT=CNT+1,FBOUT(CNT)=CNT_U_PT_";"_$G(VADM(1))_U_VID_";"_$P($G(^FBAAV(VID,0)),U)_U_$P($G(^FBAAC(PT,1,VID,1,SD,0)),U)_";"_$$FMTE^XLFDT($P($G(^FBAAC(PT,1,VID,1,SD,0)),U),5)
 . . . . S FBOUT(CNT)=FBOUT(CNT)_U_CP_";"_$P($G(^FBAAC(PT,1,VID,1,SD,1,CP,0)),U)_U_PT_";"_VID_";"_SD_";"_CP_U_$P($G(^FBAAC(PT,1,VID,1,SD,1,CP,0)),U,16)
 . . . . Q
 D KVAR^VADPT I '$D(FBOUT(1)) S FBOUT(0)="-1^No payments found" Q
 Q
