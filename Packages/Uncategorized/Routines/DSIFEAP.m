DSIFEAP ;DSS/RED - FEE BASIS COMPLETE PAYMENT (INPATIENT) ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  Integration Agreements
 ; 10018  ^DIE
 ;  2053  FILE^DIE,UPDATE^DIE
 ;  5392  END^FBCHDI
 ;  4052  $$DRG^ICDGTDRG
 ;  10103  $$FMDIFF,$$FMTE^XLFDT
 ;
 ;
 ;  Vendor must be exempt
 ;  logic and coding was cloned from existing routine ^FBCHEAP
 ;
 Q   ; No direct entry allowed
COMP(DSIFOUT,PRICEX,DSIFTMID,DATA) ;RPC: DSIF INP COMPLETE PAYMENT
 ;  LOGIC FROM FBCHEAP
 ;             Inputs: 
 ;       PRICEX - Invoice Pricer exempt flag (1 - Yes, Null for no)
 ;       DSIFTMID - Medicare ID Number
 ;         (REQ) REJ=1 (Rejects flag) (if no rejects, set REJ=0)    
 ;         (OPT) REJ(*n)=(REQ) IEN of Invoice #^Reason for reject  (2-40 characters)  
 ;              [*n should start with 1]
 ;          (Req - DATA(*InvIEN,n)=
 ;           1 ^ Invoice Date Received (Opt - FM Date)
 ;           2 ^ Vendor (Req - IEN to file 161.2 or changed)
 ;           4 ^ Pointer to 7078 or 583 (format: "IEN;FB7078("  or "IEN;FB583(" )
 ;           5 ^ Treatment from date (Opt - FM date);1 (Special flag for treatment dates) (1 means bypass the treatment date verification and allow the user to input any date)
 ;           6 ^ Treatment to Date (req if not stored in 162.5 previously)
 ;        6.6 ^ BILLED CHARGES
 ;           7 ^ AMOUNT CLAIMED
 ;           8 ^ AMOUNT PAID                        
 ;         11 ^ FEE PROGRAM (Req)  Pointer to 161.8
 ;         15 ^ New Batch IEN (Opt - if rejects) ;         
 ;         20 ^ Batch IEN
 ;         24 ^ DISCHARGE DRG
 ;      24.5 ^ DRG Weight (Req - Type a Number between 0 and 999.9999)
 ;         26 ^ NVH PRICER AMOUNT
 ;         56 ^ FPPS CLAIM ID (Opt - Enter a non-zero number from 1 to 32 digits long, 0 decimal digits)
 ;         57 ^ FPPS LINE ITEM (Opt - This response must be a number or a list or range or ALL, e.g., 1,3,5 or 2-4,8)
 ;         58 ^ .01 ^ Adj Reason (Req if Amount Paid not equal to Amount Claimed - Pntr to ADJUSTMENT REASON File #161.91)
 ;         58 ^ 1 ^ Adj Group (Req as Adj Reason - Pntr to ADJUSTMENT GROUP File #161.92)
 ;         58 ^ 2 ^ Adj Amount (Req as Adj Reason - Numeric : Amount Claimed - Amount Paid)
 ;         59 ^ Seq # (1 or 2) ^ Remittance Remark (Opt - Pntr to REMITTANCE REMARK File #161.93)
 ;                (For Inpatient Invoices there is a max of 2 remarks)
 ;          *InvIEN = Invoice IEN (file 162.5)
 ;  Outputs:  1^Successful of -1^error message
 N FBADJLA,FBN,FBADJLR,ERR,AMT,DSIFBAT,DSIFD,FIL,FBCHSW,FLD,FLDU,IEN,IENS,IENS1,INV,FBCDAYS,FBCSID,FBFPPSC,FBFPPSL,FBRRMKL,FBY2,FBY3,VAL,FBN,FB1725,FBINV,FBCNT
 N DFN,NUM,NEW,DSIFCOVD,DSIFSD,DSIFED,FBVE,FIL1,DSIFFLAG
 ;  Established a new flag DSIFFLAG to change the treatment from and treatment to dates if the second ";" piece of the value for 5 (treatment to) date is passed in as a "1"
 S DSIFOUT=$NA(^TMP("DSIFEAP",$J)) K @DSIFOUT
 S @DSIFOUT@(0)=3,(FBCHSW,NEW,DSIFCOVD,DSIFERR,DSIFSD,DSIFED,DSIFFLAG)=0
 ; Process invoices  (get treatment to and treatment from dates from 162.7 (UNA) or 162.4 (7078)
 I $O(DATA(""))']"" S @DSIFOUT@(0)="-1^Invalid Input! All data fields missing" Q
 I $G(DUZ)="" S @DSIFOUT@(0)="-1^Invalid Input! Clerk/User field is missing" Q
 S INV="" F  S INV=$O(DATA(INV)) Q:INV=""  D
 .S (IEN,FBINV)=INV
 .I '$D(^FBAAI(+FBINV,0)) S @DSIFOUT@(0)="-1^Invoice number: "_FBINV_" invalid, missing or has been rejected" Q
 .S (DA,FBI)=+FBINV,FBI(0)=^FBAAI(+FBINV,0),DFN=$P(FBI(0),U,4)
 .S FB1725=$S($P(FBI(0),U,5)["FB583":+$P($G(^FB583(+$P(FBI(0),U,5),0)),U,28),1:0)
 .I FB1725 S @DSIFOUT@(FBINV,0)="*Payment is for emergency treatment under 38 U.S.C. 1725."
 .I $P(^FBAAI(FBI,0),U,4)'=DFN S @DSIFOUT@(0)="-1^Invalid patient: "_$G(VADM(1))
 .D PROCESS
 Q:@DSIFOUT@(0)<0
 S DA=FBN,(DIC,DIE)="^FBAA(161.7,",DIC(0)="LQ",DR="11////^S X=""A""",DLAYGO=161.7 D ^DIE
 I @DSIFOUT@(0)'<0 S @DSIFOUT@(0)="1^Entry successfully completed, batch status changed"
 ;  end, kill variables
 K DA,DSIFINV,DIC,DIE,DR,FBAAOUT,FBDX,FBI,FBIN,FBJ,FBK,FBLISTC,FBN,FBPROC,FBVEN,FBVID,I,J,K,L,POP,Q,VA,VADM,X,POP,YS,VAL,ZZ,Y,FBRR,FBTYPE,FBCHSW,DIRUT,FB1725,FBPAMT
 K FBADJ,FBRRMK,DSIFTMID,FBVE,PRICEX
 D END^FBCHDI
 Q
CDAT S Y=$E(Y,4,5)_"/"_$S($E(Y,6,7)="00":$E(Y,2,3),1:$E(Y,6,7)_"/"_$E(Y,2,3)) Q
 ;
REJECTS ;  Reject processing
 Q  ;Not used as this time
 ;N I S FBCNT=40 F I=0:0 S I=$O(REJ(I)) Q:'I  D
 ;.S FBRR=$P(REJ(I),U,2) I FBRR=""!($L(FBRR)<2)!($L(FBRR)>40) S @DSIFOUT@(0)="-1^Invalid reason for Invoice^Reason: "_REJ(I) Q
 ;.S FBLISTC="",FBI=$P(REJ(I),U) I '$D(^FBAAI(FBI,0)) S @DSIFOUT@(0)="-1^Invalid Invoice number" Q
 ;.S FBN=DSIFBAT I $P(^FBAAI(FBI,0),U,17)'=FBN S @DSIFOUT@(0)="-1^Invalid Batch number for this Invoice" Q
 ;.I $P(^FBAAI(FBI,0),U,9)'="" S @DSIFOUT@(0)="-1^Amount paid is null for this Invoice" Q
 ;.S (DLAYGO,DIDEL)=162.5,DIC(0)="AEQLM"
 ;.S (DIC,DIE)="^FBAAI(",DA=FBI,DR="13////^S X=""P"";14///^S X=FBRR;15///^S X=FBN;20///^S X=""@""" D ^DIE
 ;.S $P(FBN(0),"^",10)=$P(FBN(0),"^",10)-1,$P(FBN(0),"^",11)=$P(FBN(0),"^",11)-1,$P(FBN(0),"^",17)="Y",^FBAA(161.7,FBN,0)=FBN(0)
 ;.S @DSIFOUT@(FBCNT)="1^Rejected Invoice # "_FBI_" is successful",FBCNT=FBCNT+1
 ;Q
PROCESS ;
 ;  Modify entry in file 162.5
 S NUM=""
 F  S NUM=$O(DATA(INV,NUM)) Q:NUM=""  S FLD=$P(DATA(INV,NUM),U),VAL=$P(DATA(INV,NUM),U,2+(FLD=59!(FLD=58))) D  Q:$G(@DSIFOUT@(0))<0
 .S FLDU=U_FLD_U
 .I "^1^2^4^6.6^7^11^"[FLDU,VAL="" S @DSIFOUT@(0)="-1^Invalid data field: "_FLD,DSIFERR=1 Q
 .I FLD=2,VAL="" S DSIFOUT="-1^Vendor is a required field!",DSIFERR=1 Q
 .I FLD=2 S FBVEN=VAL,FBVE="" S:$D(^FBAAV(VAL,"AMS")) FBVE=$P(^("AMS"),"^",2) S:$G(FBVE)'="Y" FBVE="N"
 .I FLD>2,FBVEN="" S @DSIFOUT@(0)="-1^Vendor is a required field",DSIFERR=1 Q
 .I $G(FBVE)="Y",PRICEX="" S @DSIFOUT@(0)="-1^Vendor is listed as 'exempt from the pricer'. Do you wish to keep this invoice exempt from the pricer?",DSIFERR=1 Q
 .I $G(FBVE)'="Y",($P($G(^FBAAV(FBVEN,0)),"^",17)']"") I DSIFTMID="" S @DSIFOUT@(0)="-1^Medicare ID Number is needed for this Vendor!",DSIFERR=1 Q 
 .I FLD=4 D  Q:DSIFERR
 ..I '$D(^FBAAA("AG",VAL,DFN)) S @DSIFOUT@(0)="-1^Pointer to 7078/583 does not match Authorization file",DSIFERR=1 Q
 ..I $P(^FBAAI(INV,0),U,5)'=VAL S @DSIFOUT@(0)="-1^Invoice pointer to 583/7078 is invalid, Invoice pointer: "_$P(^FBAAI(INV,0),U,5),DSIFERR=1 Q
 .I FLD=4,VAL["FB583" D  Q:DSIFERR  ;DSIF*3.2*8
 ..S DSIFSD=$P($G(^FB583(+VAL,0)),U,5),DSIFED=$P($G(^FB583(+VAL,0)),U,6)
 ..I $G(DSIFSD)="" S @DSIFOUT@(0)="-1^Invalid Treatment from date on 583",DSIFERR=1 Q
 ..I $G(DSIFED)="" S @DSIFOUT@(0)="-1^Invalid Treatment to date on 583",DSIFERR=1 Q
 .I FLD=4,VAL["FB7078" D  Q:DSIFERR  ;DSIF*3.2*8
 ..S DSIFSD=$P($G(^FB7078(+VAL,0)),U,4),DSIFED=$P($G(^FB7078(+VAL,0)),U,5)
 ..I $G(DSIFSD)="" S @DSIFOUT@(0)="-1^Invalid Authorization from date on 7078",DSIFERR=1 Q
 ..I $G(DSIFED)="" S @DSIFOUT@(0)="-1^Invalid Authorization to date on 7078",DSIFERR=1 Q
 .I FLD=5,$P(VAL,";",2),VAL'="" S DSIFFLAG=1,DSIFSD=+VAL
 .I FLD=5 S VAL=+VAL  ;Remove flag set in input array field 5
 .I FLD=6,VAL'="",DSIFFLAG S DSIFED=VAL
 .I FLD=6,DSIFED="" S DSIFED=$P($G(^FBAAI(INV,0)),U,7) I DSIFED="" S @DSIFOUT@(0)="-1^Treatment to date is missing!",DSIFERR=1 Q
 .I FLD=8,VAL>9999999.99 S @DSIFOUT@(0)="-1^Invalid amount paid, max payment level reached",DSIFERR=1 Q   ;DSIF*3.2*2
 .I FLD=11,$P($G(^FBAAI(INV,0)),U,12)=""!(VAL="") D  Q:$G(@DSIFOUT@(0))<0
 ..I '$D(^FBAA(161.8,VAL))  S @DSIFOUT@(0)="-1^Required Fee Program not entered or Invalid" Q
 ..I $P(^FBAA(161.8,VAL,0),U,3)=0 S @DSIFOUT@(0)="-1^Required Fee Program entered is not active, Invalid selection" Q
 .I 'PRICEX,"^4^6.6^7^8^24^24.5^26^"[FLDU,VAL="" S @DSIFOUT@(0)="-1^Invalid Field Input! "_FLD Q
 .;  ** If pricer exempt skips fields 24 (DISCHARGE DRG) and 24.5 (DRG WEIGHT)
 .I PRICEX,"^4^6.6^7^8^26^"[FLDU,VAL="" S @DSIFOUT@(0)="-1^Invalid Field Input! "_FLD Q
 . ;Batch number validation, and check for clerk who opened or supervisor key to continue
 .I "^20^"[FLDU D  Q:$G(@DSIFOUT@(0))<0
 ..S FBN=VAL I 'VAL S @DSIFOUT@(0)="-1^Required Batch Number not entered" Q
 ..I DUZ'=$P(^FBAA(161.7,FBN,0),U,5),'$D(^XUSEC("FBAASUPERVISOR",DUZ)) S @DSIFOUT@(0)="-1^To complete the payment you must be the clerk who entered or a Supervisor" Q
 ..I '$D(^FBAA(161.7,FBN)) S @DSIFOUT@(0)="-1^Required Batch Number is not Valid" Q
 ..I $P($G(^FBAA(161.7,FBN,0)),U,15)'="Y" S @DSIFOUT@(0)="-1^Batch must be a Contract Hospital Batch" Q
 ..I 'PRICEX,$G(^FBAA(161.7,FBN,"ST"))'="P" S @DSIFOUT@(0)="-1^Batch must have a status of Released to Pricer" Q
 ..I $P($G(^FBAA(161.7,FBN,0)),U,3)'="B9" S @DSIFOUT@(0)="-1^Required Batch Number is not a Civil Hospital type" Q
 .I FLD=58,'VAL S @DSIFOUT@(0)="-1^Invalid Input! "_FLD_" - "_$P(DATA(INV,NUM),U,2,4)
 .; If field equls 24 and the Batch is not exempt and the PRICEX flag is not set, then check the Discharge DRG validity
 .I FLD=24,'PRICEX,FBVE="N" N FBRET D  Q:$G(@DSIFOUT@(0))<0
 ..S FBRET=$$DRG^ICDGTDRG($G(VAL),$S($G(DSIFED)="":DT,1:DSIFED))
 ..I +FBRET<0 S @DSIFOUT@(0)="-1^Invalid DRG Code " Q
 ..I $P(FBRET,"^",14)=0 S @DSIFOUT@(0)="-1^Code: "_VAL_" is inactive on the date specified" Q
 .I "^6.6^7^8^26^"[FLDU S AMT(FLD)=VAL
 .I FLD=58,$P(DATA(INV,NUM),U,2)=2 S AMT(58.2)=VAL
 Q:$G(@DSIFOUT@(0))<0
 S DSIFCOVD=$$FMDIFF^XLFDT(DSIFED,DSIFSD,1) I DSIFCOVD<1 S DSIFCOVD=1
 ;I 'DSIFCOVD S DSIFCOVD=1
 I $G(AMT(7))>$G(AMT(6.6)) S @DSIFOUT@(0)="-1^Amount Claimed is Greater Than Billed Charges!" Q
 I $G(AMT(8))>$G(AMT(7)),(AMT(7)-$G(AMT(58.2))'=+AMT(8)) S @DSIFOUT@(0)="-1^Amount paid is greater than amount claimed without proper adjustment!" Q
 I $G(AMT(8))'=$G(AMT(7)),$G(AMT(7))-$G(AMT(8))'=+$G(AMT(58.2)) S @DSIFOUT@(0)="-1^Adjustment Amount is not equal to Amount Claimed - Amount Paid!" Q
 Q:$G(@DSIFOUT@(0))<0
 S FIL=162.5,NUM="",IENS=FBINV_",",DSIFD(54)=$G(DSIFCOVD)
 F  S NUM=$O(DATA(INV,NUM)) Q:NUM=""  D
 .S FLD=+DATA(INV,NUM),VAL=$P(DATA(INV,NUM),U,2+(FLD=59!(FLD=58)))
 .I FLD<58 S DSIFD(FLD)=VAL Q
 .S DSIFD(FLD,$P(DATA(FBINV,NUM),U,2))=VAL
 S DSIFD(5)=$G(DSIFSD),DSIFD(6)=$G(DSIFED),DSIFD(54)=DSIFCOVD   ;Set fields 5,6 and 54
 M DSIF(FIL,IENS)=DSIFD K DSIF(FIL,IENS,58),DSIF(FIL,IENS,59)
 L +^FBAAI(FBINV):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S @DSIFOUT@(0)="-1^Unable to lock file, try again later" Q
 D FILE^DIE(,"DSIF") L -^FBAAI(FBINV)
 K DSIF S NEW=0
 ; Check and store adjustment reasons if present
 I $D(DSIFD(58)) D
 .N NEW S NEW='$D(^FBAAI(+IENS,8,1,0))
 .S IENS1="1,"_IENS,FIL1=162.558 S:NEW IENS1="+"_IENS1 F NUM=.01,1,2 S DSIF(FIL1,IENS1,NUM)=$G(DSIFD(58,NUM))
 .I NEW D UPDATE^DIE(,"DSIF") Q
 .D FILE^DIE(,"DSIF")
 ; Check and store remittance remarks if present
 I $D(DSIFD(59)) D
 .N NEW S NEW='$D(^FBAAI(+IENS,9,0)) S NUM=1 D
 ..S FIL1=162.559,IENS1=$S(NEW:"+1",1:NUM)_","_IENS,DSIF(FIL1,IENS1,.01)=$S(DSIFD(59,NUM):DSIFD(59,NUM),1:"@")
 ..D UPDATE^DIE(,"DSIF"):NEW,FILE^DIE(,"DSIF"):'NEW
 ; Reset batch fields
 S FBN(0)=$G(^FBAA(161.7,FBN,0)) Q:'$D(FBN(0))
 D TOT S $P(FBN(0),"^",9)=FBK(1),^FBAA(161.7,FBN,0)=FBN(0)
 D CHK I $D(FBCHSW) Q
 I '$D(FBCHSW) S DA=FBN,(DIC,DIE)="^FBAA(161.7,",DIC(0)="LQ",DR="11////^S X=""A""",DLAYGO=161.7 D ^DIE
 I $P(^FBAA(161.7,FBN,0),"^",11)=0 S (DIC,DIE)="^FBAA(161.7,",DIC(0)="AEQM",DA=FBN,DR="11////^S X=""V"";12////^S X=DT" D ^DIE
 ;   end of new logic for setting batch
 Q
TOT S FBK(1)=0 F I=0:0 S I=$O(^FBAAI("AC",FBN,I)) Q:'I  S FBK(1)=FBK(1)+$P($G(^FBAAI(I,0)),"^",9)
 Q
CHK F I=0:0 S I=$O(^FBAAI("AC",FBN,I)) Q:I'>0  I $D(^FBAAI(I,0)),$P(^(0),"^",9)="" S FBCHSW=1
 Q
DGPCHK(DATA,FLDU,VAL)    ;Check for existance and validity of diagnosis and present on admission codes.  DSIF*3.2*2
 N DSIFLD,DSIFPOA,POANODE,FOUND
 S DSIFLD=$TR(FLDU,U,"")
 S FBRET=$$ICDDX^ICDCODE(VAL,.DSIFICDDATE)
 I $P(FBRET,U,2)["INVALID" Q "-1^ "_VAL_" is an invalid diagnosis, quitting"
 I $P(FBRET,"^",10)=0 Q "-1^Diagnosis "_$P(FBRET,"^",2)_" entered is inactive on:  "_$$FMTE^XLFDT(DSIFICDDATE)_", quitting"
 ;if present in the data array, locate the POA data for this diagnosis code. DSIF*3.2*2
 S POANODE=DSIFLD+0.02,FOUND=0
 S NDX=0 F  S NDX=$O(DATA(NDX)) Q:NDX=""  D  Q:FOUND
 .S:+DATA(NDX)=POANODE FOUND=1
 I NDX="" Q "-1^No present on admission code entered for diagnosis code "_VAL
 S DSIFPOA=$P(DATA(NDX),U,2)
 I '$D(^FB(161.94,"B",DSIFPOA)) Q "-1^Invalid present on admission code entered for diagnosis code "_VAL
 S $P(DATA(NDX),U,2)=$O(^FB(161.94,"B",DSIFPOA,0)) ;reset the poa from external value to the IEN for storage in the payment file.
 Q 1
