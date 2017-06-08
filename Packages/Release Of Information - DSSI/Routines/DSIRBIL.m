DSIRBIL ;AMC/EWL - Document Storage System;Billing RPC's and other ;04/14/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2053  FILE^DIE
 ;2056  GETS^DIQ
 ;10000 NOW^%DTC
 ;10009 FILE^DICN
 Q
UPDBILL(AXY,REQN,BILN,DATA) ;RPC - DSIR UPDATE BILL
 ;Input Variables:
 ;                REQN - Request pointer to file 19620 (Required)
 ;                BILN - Internal Entry Number to file 19620.2 (Optional)
 ;                       If null new entry in 19620.2 will be created
 ;                DATA - Array of data for the fields in file 19620.2 (Required)
 ;                       Format of Array:
 ;                                  Field Number ^ Internal Data Value
 ;                                  .01^12345
 ;                                  .02^3030911
 ;
 ;Return Value in AXY:
 ;                -1^Missing Required Input Variable(s)
 ;                -2^Request IEN Missing in file 19620
 ;                -3^Bill IEN Missing in file 19620.2
 ;                -4^Unable to add Bill
 ;                BILL IEN
 ;
 N DSIRFDA,FIL,IENS,ARY,NEW,AUD
 S BILN=+$G(BILN),REQN=+$G(REQN),DATA=$D(DATA),NEW='BILN I 'REQN!'DATA S AXY="-1^Missing Required Input Variable(s)" Q
 I '$D(^DSIR(19620,REQN)) S AXY="-2^Request IEN Missing in file 19620" Q
 I BILN,'$D(^DSIR(19620.2,BILN)) S AXY="-3^Bill IEN Missing in file 19620.2" Q
 D:'BILN  I BILN<0 S AXY="-4^Unable to add Bill" Q
 .N DIC,X S DIC="^DSIR(19620.2,",X=REQN,DIC(0)="L" D FILE^DICN S BILN=+Y
 S FIL=19620.2,IENS=BILN_","
 S ARY="" F  S ARY=$O(DATA(ARY)) Q:ARY=""  S DATA(ARY)=$TR(DATA(ARY),"~",U),DSIRFDA(FIL,IENS,$P(DATA(ARY),U))=$P(DATA(ARY),U,2)
 D:'NEW
 .N FLD,FLDS,GET S FLDS=""
 .S FLD=0 F  S FLD=$O(DSIRFDA(FIL,IENS,FLD)) Q:'FLD  S FLDS=FLDS_FLD_";"
 .S FLDS=$E(FLDS,1,$L(FLDS)-1) D GETS^DIQ(FIL,IENS,FLDS,"I","GET")
 .I $D(DSIRFDA(FIL,IENS,2.01)),+DSIRFDA(FIL,IENS,2.01)'=+$G(GET(FIL,IENS,2.01,"I")) D
 ..N AMTDU,PMT,PMTAMT
 ..S AMTDU=+DSIRFDA(FIL,IENS,2.01),PMT=0
 ..F  S PMT=$O(^DSIR(19620.21,"B",BILN,PMT)) Q:'PMT  S PMTAMT=+$P($G(^DSIR(19620.21,PMT,0)),U,2),AMTDU=AMTDU-PMTAMT
 ..S:AMTDU<0 AMTDU=0
 ..S DSIRFDA(FIL,IENS,2.05)=AMTDU
 .S FLD=0 F  S FLD=$O(DSIRFDA(FIL,IENS,FLD)) Q:'FLD  I FLD'=2.05,DSIRFDA(FIL,IENS,FLD)'=$G(GET(FIL,IENS,FLD,"I")) S AUD(FLD)=$G(GET(FIL,IENS,FLD,"I"))_U_DSIRFDA(FIL,IENS,FLD)
 .D:$O(AUD(0))]"" AUDIT
 D:NEW 
 .S:'$D(DSIRFDA(FIL,IENS,2.05)) DSIRFDA(FIL,IENS,2.05)=$S($G(DSIRFDA(FIL,IENS,.05))=2:0,1:+$G(DSIRFDA(FIL,IENS,2.01)))
 .S:'$D(DSIRFDA(FIL,IENS,.05)) DSIRFDA(FIL,IENS,.05)=0
 .S:'$D(DSIRFDA(FIL,IENS,.03)) DSIRFDA(FIL,IENS,.03)=DUZ
 .S DSIRFDA(FIL,IENS,.02)=DT
 D FILE^DIE("","DSIRFDA")
 ;S AMNT="W" D PAY
 S AXY=BILN
 Q
AUDIT ;
 N FIL,IENS,FLDS,FLD,DIC,AUDIT,TIM S FIL=19620.29 D NOW^%DTC S TIM=%
 S FLD=0 F  S FLD=$O(AUD(FLD)) Q:'FLD  D
 .S DIC="^DSIR(19620.29,",DIC(0)="L",X=BILN D FILE^DICN S IENS=+Y_","
 .S AUDIT(FIL,IENS,.02)=TIM,AUDIT(FIL,IENS,.03)=DUZ,AUDIT(FIL,IENS,.04)=FLD,AUDIT(FIL,IENS,.05)=$P(AUD(FLD),U),AUDIT(FIL,IENS,.06)=$P(AUD(FLD),U,2)
 .D FILE^DIE("","AUDIT")
 .K AUDIT
 Q
PAYMENT(AXY,BILN,AMNT,RCVDT,CMT,ALLOW) ;RPC - DSIR PAYMENT
 ;Used to receive and record a payment
 ;
 ;Input Variables:
 ;                               BILN -  Internal Bill Number to file 19620.2 (Required)
 ;                               AMNT -  Payment amount - Numeric dollar value or 'W' to indicate fee is to be Waived (Required)
 ;                               RCVDT - Date Payment Received (Optional - Default = Current Date)
 ;                               CMT  -  Comment (Optional Free Text 100 char max)
 ;                               
 ;Return Value in AXY:
 ;                               -1^Missing Required Input Variable(s)
 ;                               -2^Bill IEN Missing in file 19620.2
 ;                               -3^Fee Waived, Create New Bill to Record Payment
 ;                               BILL IEN - Successful Payment Recorded
 ;                               
PAY N WAIV,DSIRFDA,FIL,IENS,DIC,X,PAY,BILD,AMDU,TIM
 S BILN=+$G(BILN),AMNT=$G(AMNT),RCVDT=$G(RCVDT,DT),CMT=$G(CMT),ALLOW=$G(ALLOW) D NOW^%DTC S TIM=%
 I AMNT=""!'BILN S AXY="-1^Missing Required Input Variable(s)" Q
 I '$D(^DSIR(19620.2,BILN)) S AXY="-2^Bill IEN Missing in file 19620.2" Q
 S BILD(0)=$G(^DSIR(19620.2,BILN,0)),BILD(2)=$G(^DSIR(19620.2,BILN,2))
 ;I $P(BILD(0),U,5)=2 S AXY="-3^Fee Waived, Create New Bill to Record Payment" Q
 S DIC="^DSIR(19620.21,",X=BILN,DIC(0)="L" D FILE^DICN S PAY=+Y
 S WAIV=AMNT="W",FIL=19620.2,IENS=BILN_","
 I WAIV D  Q
 .D:'$G(NEW)
 ..S DSIRFDA(FIL,IENS,.05)=2,DSIRFDA(FIL,IENS,.04)=TIM,DSIRFDA(FIL,IENS,2.05)=0
 ..D FILE^DIE("","DSIRFDA") K DSIRFDA
 .S FIL=19620.21,IENS=PAY_","
 .S DSIRFDA(FIL,IENS,.05)=1,DSIRFDA(FIL,IENS,.04)=TIM,DSIRFDA(FIL,IENS,.03)=DUZ
 .S DSIRFDA(FIL,IENS,.06)=RCVDT,DSIRFDA(FIL,IENS,1.01)=CMT
 .D FILE^DIE("","DSIRFDA")
 .S AXY=BILN
 S AMDU=$P(BILD(2),U,5)-AMNT S:AMDU<0 AMDU=0
 S DSIRFDA(FIL,IENS,2.05)=AMDU
 S:'AMDU DSIRFDA(FIL,IENS,.04)=TIM,DSIRFDA(FIL,IENS,.05)=1
 D FILE^DIE("","DSIRFDA") K DSIRFDA
 S FIL=FIL+.01,IENS=PAY_","
 S DSIRFDA(FIL,IENS,.02)=AMNT,DSIRFDA(FIL,IENS,.03)=DUZ,DSIRFDA(FIL,IENS,.04)=TIM
 S DSIRFDA(FIL,IENS,.06)=RCVDT,DSIRFDA(FIL,IENS,1.01)=CMT,DSIRFDA(FIL,IENS,.07)=ALLOW
 D FILE^DIE("","DSIRFDA")
 S AXY=BILN
 Q
 ;
GETDATA(AXY,DSIR) ;RPC - DSIR GET BILL INFO
 ;Retrieves billing data for a specific request
 ;
 ;Input Varaible(s):
 ;                               DSIR - Internal Entry Number to file 19620                               
 ;Return Array:
 ;                               -1^Missing Request Number!
 ;                               -2^No Bill on File!
 ;                               Field Number^Internal Value^External Value
 ;
 I '$G(DSIR) S AXY(0)="-1^Missing Request Number!" Q
 I '$O(^DSIR(19620.2,"B",DSIR,0)) S AXY(0)="-2^No Bill on File!" Q
 N GET,FIL,IEN,IENS,II,FLD
 S FIL=19620.2,IEN=+$O(^DSIR(19620.2,"B",DSIR,0)),IENS=IEN_","
 D GETS^DIQ(FIL,IENS,"*","IE","GET")
 S AXY(0)=".001^"_IEN
 S FLD=0 F II=1:1 S FLD=$O(GET(FIL,IENS,FLD)) Q:FLD=""  I $G(GET(FIL,IENS,FLD,"I"))]"" S AXY(II)=FLD_U_GET(FIL,IENS,FLD,"I")_U_$G(GET(FIL,IENS,FLD,"E"))
 Q
GETHIST(AXY,BILN) ;RPC - DSIR GET PAYMENT HISTORY
 ;Input Variable(s):
 ;                               BILN - Internal Entry Number to file 19620.2
 ;                               
 ;Return Array:
 ;                               -1^Missing Bill Number!
 ;                               -2^Bill Number not on File!
 ;                               -3^No History Records for Bill!
 ;                               History IEN^Amount Received I;E^Received By I;E^Date Received I;E^Waived (1/0)
 ;                               
 ;                               
 I '$G(BILN) S AXY(0)="-1^Missing Bill Number!" Q
 I '$D(^DSIR(19620.2,BILN,0)) S AXY(0)="-2^Bill Number not on File!" Q
 I '$O(^DSIR(19620.21,"B",BILN,0)) S AXY(0)="-3^No History Records for Bill!" Q
 N PAYS,II,GET,FIL,IENS S FIL=19620.21,II=0
 S PAYS=0 F  S PAYS=$O(^DSIR(19620.21,"B",BILN,PAYS)) Q:'PAYS  D
 .S IENS=PAYS_"," D GETS^DIQ(FIL,IENS,"*","IE","GET")
 .S II=II+1,AXY(II)=PAYS_U_+$G(GET(FIL,IENS,.02,"I"))_";"_$G(GET(FIL,IENS,.02,"E"))_U
 .S AXY(II)=AXY(II)_+$G(GET(FIL,IENS,.03,"I"))_";"_$G(GET(FIL,IENS,.03,"E"))_U
 .S AXY(II)=AXY(II)_+$G(GET(FIL,IENS,.04,"I"))_";"_$G(GET(FIL,IENS,.04,"E"))_U
 .S AXY(II)=AXY(II)_+$G(GET(FIL,IENS,.05,"I"))_U
 .S AXY(II)=AXY(II)_$G(GET(FIL,IENS,1.01,"I"))_U
 .S AXY(II)=AXY(II)_$G(GET(FIL,IENS,.07,"I"))
 .K GET
 Q
 ;
GETDOCS(AXY,DFN) ;RPC - DSIR GET BILL DOCS
 ;Retrieves all patient documents with billing flag from 19620.1
 ;
 ;Input Variable:
 ;                                       DFN - Patient File Internal Number
 ; 
 ;Return Array:
 ;                                       -1^Missing Patient Number!
 ;                                       -2^No Documents Found!
 ;                                       Document Type^Document IEN^Include in Billing
 ;
 N XRF,ROI,RTY,DXFN,DOC,GET,XX,YY S XRF="DSIRGETDOC",AXY=$NA(^TMP(XRF,$J)),YY=0
 S DFN=+$G(DFN) I 'DFN S ^TMP(XRF,$J,0)="-1^Missing Patient Number!" Q
 S DXFN=DFN_";DPT("
 S ROI=0 F  S ROI=$O(^DSIR(19620,"B",DXFN,ROI)) Q:'ROI  D
 .S RTY=$P($G(^DSIR(19620,ROI,10)),U,4) Q:RTY'=1
 .S DOC=0 F  S DOC=$O(^DSIR(19620.1,"B",ROI,DOC)) Q:'DOC  D
 ..D GETS^DIQ(19620.1,DOC,".02;.03;2.01","I","GET")
 ..S XX=$G(GET(19620.1,DOC_",",.02,"I"))_U_$G(GET(19620.1,DOC_",",.03,"I"))_U_$G(GET(19620.1,DOC_",",2.01,"I")),YY=YY+1
 ..S ^TMP(XRF,$J,YY)=XX K GET
 I 'YY S ^TMP(XRF,$J,0)="-2^No Documents Found!"
 Q
