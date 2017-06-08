DSIFINP4 ;DSS/RED - RPC FOR B9 FEE BASIS BATCHES ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;  2056  GETS^DIQ
 ; 10061  PID^VADPT
 ;
 ;Routine for APIs used in Fee Basis batches. RPC's: DSIF INP BATCH DISPLAY 
 ;
 Q
INVDISP(FBOUT,BATCH,INV) ;RPC: DSIF INVOICE DISPLAY
 ;Input:  Batch IEN, Invoice number  (either or can be entered)  
 ;Output:  ^TMP($J,"DSIFINP4",0) = "Batch"^Batch IEN;Batch number^Invoice^Obligation Number  (or error message)
 ;               
 ;                               ,1) = "Demog"^Patient Name^SSN^Vendor name^Vendor ID
 ;                            ,1,n) = "Data"^FLAGS^Dt Inv Rec'd^FR DATE^TO DATE^CLAIMED^PAID^ADJ CODE
 K FBOUT,^TMP($J,"DSIFPAY2") S FBOUT=$NA(^TMP($J,"DSIFPAY2"))
 N FBINV,SSN,TARGET,DFN,FIELD,FLAG,TCNT S (TCNT,FLAG)=0
 ; get invoice number to display payments for the batch
 S FBOUT=$NA(^TMP($J,"DSIFINP4")) K @FBOUT,^TMP("LIST",$J)
 I $G(BATCH)="" S BATCH=0
 I BATCH I '$D(^FBAA(161.7,BATCH)) S @FBOUT@(0)="-1^Invalid batch" Q
 I $G(INV)]"" S FBINV=INV I '$D(^FBAAI(FBINV)) S FBINV=0
 I $G(FBINV)="" S FBINV=0
 I 'BATCH,'FBINV S @FBOUT@(0)="-1^Invalid batch and/or Invoice entered, quitting" Q
 S FILE=162.5,FIELD="**",FLAGS="IE",MSG="MSG"
 I FBINV,'BATCH D
 . S IENS=FBINV_",",TARGET=$NA(^TMP("LIST",$J))
 . D GETS^DIQ(FILE,IENS,FIELD,FLAGS,TARGET,MSG) S TARGET=$NA(^TMP("LIST",$J,FILE,IENS))
 . S DFN=$G(@TARGET@(3,"I")) D PID^VADPT S SSN=VA("PID"),SSN=$TR(SSN,"-","") ;changed to conform to SAC
 . N I F I=0:0 S I=$O(@TARGET@(I)) Q:'I  D
 . . Q:I=.01
 . . I @TARGET@(I,"I")]"",(@TARGET@(I,"I")'=@TARGET@(I,"E")) S @FBOUT@(FBINV,I)=I_U_@TARGET@(I,"I")_";"_@TARGET@(I,"E")
 . . I @TARGET@(I,"I")]"",(@TARGET@(I,"I")=@TARGET@(I,"E")) S @FBOUT@(FBINV,I)=I_U_@TARGET@(I,"I")
 . . I I=3 S @FBOUT@(I)=@FBOUT@(FBINV,I)_";"_SSN
 . I 'BATCH S BATCH=@TARGET@(20,"I")
 I BATCH F FBINV=0:0 S FBINV=$O(^FBAAI("AC",BATCH,FBINV)) Q:'FBINV  D
 . S IENS=FBINV_",",TARGET=$NA(^TMP("LIST",$J))
 . D GETS^DIQ(FILE,IENS,FIELD,FLAGS,TARGET,MSG) S TARGET=$NA(^TMP("LIST",$J,FILE,IENS))
 . S DFN=$G(@TARGET@(3,"I")) D PID^VADPT S SSN=VA("PID"),SSN=$TR(SSN,"-","") ;changed to conform to SAC
 . N I,ZSUB F I=0:0 S I=$O(@TARGET@(I)) Q:'I  D
 . . Q:I=.01
 . . I @TARGET@(I,"I")]"",(@TARGET@(I,"I")'=@TARGET@(I,"E")) S @FBOUT@(FBINV,I)=I_U_@TARGET@(I,"I")_";"_@TARGET@(I,"E")
 . . I @TARGET@(I,"I")]"",(@TARGET@(I,"I")=@TARGET@(I,"E")) S @FBOUT@(FBINV,I)=I_U_@TARGET@(I,"I")
 . . I I=3 S @FBOUT@(I)=@FBOUT@(FBINV,I)_";"_SSN
 . I $D(^TMP("LIST",$J,162.558)) N TARGET1,I S TARGET1=$NA(^TMP("LIST",$J,162.558,"1,"_FBINV_",")),I="" F  S I=$O(@TARGET1@(I)) Q:'I  D
 . . I @TARGET1@(I,"I")]"",(@TARGET1@(I,"I")'=@TARGET1@(I,"E")) S @FBOUT@(FBINV,58,I)="58;"_I_U_@TARGET1@(I,"I")_";"_@TARGET1@(I,"E")
 . . I @TARGET1@(I,"I")]"",(@TARGET1@(I,"I")=@TARGET1@(I,"E")) S @FBOUT@(FBINV,58,I)="58;"_I_U_@TARGET1@(I,"I")
 . I $D(^TMP("LIST",$J,162.559)) N TARGET2,I S TARGET2=$NA(^TMP("LIST",$J,162.559,"1,"_FBINV_",")),I="" F  S I=$O(@TARGET2@(I)) Q:'I!(I>.01)  D
 . . I @TARGET2@(I,"I")]"",(@TARGET2@(I,"I")'=@TARGET2@(I,"E")) S @FBOUT@(FBINV,59,I)="59;"_I_U_@TARGET2@(I,"I")_";"_@TARGET2@(I,"E")
 . . I @TARGET2@(I,"I")]"",(@TARGET2@(I,"I")=@TARGET2@(I,"E")) S @FBOUT@(FBINV,59,I)="59;"_I_U_@TARGET2@(I,"I")
 . I 'BATCH S BATCH=@TARGET@(20,"I")
 . S @FBOUT@(FBINV,0)="Batch"_U_BATCH_";"_$P($G(^FBAA(161.7,BATCH,0)),U)_U_FBINV_U_$G(@TARGET@(4,"I"))_";"_$G(@TARGET@(4,"E"))
 . K ^TMP("LIST",$J)
 I FBINV="" I '$D(^TMP($J,"DSIFINP4"))="-1^No invoices found for this request "_U_$S(BATCH>1:BATCH,1:"")_U_FBINV Q
 K ^TMP("LIST",$J)
 Q
DISP7078(FBOUT,REF) ; RPC: DSIF INP DISP PAYMENT
 ;  Input: REF= 7078 IEN
 ;  Output:  ^TMP($J,"DSIFINP4",0)="FB7078"^Patient (I;E)^7078 IEN^Status (I;E)
 ;                                           ,field)=field number^value (I;E)
 K FBOUT,^TMP($J,"DSIFINP4") S FBOUT=$NA(^TMP($J,"DSIFINP4"))
 N MSG,I,FILE,DATA,IENS,FIELDS,FLAGS,TARGET,AUTHIEN,INPUT,STATUS,VA S:$G(U)="" U="^"
 I '$D(^FB7078(REF)) S @FBOUT@(0)="-1^Invalid 7078 IEN entered" Q
 ; Retrieve all data for the INPT Payment 
 S IENS=REF_",",TARGET=$NA(^TMP("LIST",$J)),FILE=162.4,FIELDS="**",FLAGS="IE"
 D GETS^DIQ(FILE,IENS,FIELDS,FLAGS,TARGET,"MSG") S TARGET=$NA(^TMP("LIST",$J,FILE,IENS))
 I $D(MSG) S @FBOUT@(0)=-1_U_REF_U_"Invalid reference number entered" Q
 N I F I=0:0 S I=$O(@TARGET@(I)) Q:'I  D
 . I I=.01 Q
 . K ARRAY,J I I=7 D GETS^DIQ(FILE,IENS,"7","","ARRAY","MSG") Q:$D(MSG)  S DATA=$NA(ARRAY(FILE,IENS,7)) D
 . . F J=0:0 S J=$O(@DATA@(J)) Q:'J  S @FBOUT@(7,J)=7_U_J_U_@DATA@(J)
 . Q:I=7
 . I I=2 S DFN=@TARGET@(I,"I") Q
 . I I=9 S STATUS=@TARGET@(I,"I")_";"_@TARGET@(I,"E") Q
 . I @TARGET@(I,"I")]"",(@TARGET@(I,"I")'=@TARGET@(I,"E")) S @FBOUT@(I)=I_U_@TARGET@(I,"I")_";"_@TARGET@(I,"E")
 . I @TARGET@(I,"I")]"",(@TARGET@(I,"I")=@TARGET@(I,"E")) S @FBOUT@(I)=I_U_@TARGET@(I,"I")
 D DEM^VADPT I '$D(^TMP("LIST",$J)) S @FBOUT@(0)=-1_U_DFN_";"_$G(VADM(1))_U_AUTHIEN_U_"Invalid auth for this Pt" D KVAR^VADPT Q
 S @FBOUT@(0)="FB7078"_U_DFN_";"_$G(VADM(1))_U_REF_";"_@TARGET@(.01,"E")_U_STATUS D KVAR^VADPT
 K ^TMP("LIST",$J)
 Q
