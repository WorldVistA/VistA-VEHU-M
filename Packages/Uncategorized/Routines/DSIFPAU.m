DSIFPAU ;DSS/KSD,RED - ADD Unauthorized Payment RPC ;4/30/93  11:34
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements:
 ;  2056  GETS^DIQ                    5114  $$EXTRL^FBMRASVR
 ;  5327  2^FBAAUTL1                 5272  Global ^FBAAA
 ;  5278  Global ^FBAAV              5397  Global ^FB583
 ;  5441  DISP7^FBUCUTL5
 ;  
 ;
 ;Input Parameters
 ;    DSIFIN - (required) Input string (pieces below)
 ;       Piece  1 ^ Veteran IEN (FBVET)
 ;              2 ^ Fee Vendor IEN 
 ;              3 ^ Fee Basis Unauthorized Claims IEN (#162.7) (FBDA)
 ;              4 ^ Ancillary Payment (1=Y, null =no)
 ;              5 ^ Selected Batch IEN
 ;              6 ^ Date Correct Invoice Received or Last Date of Service for Authorizations
 ;              7 ^ Invoice # 
 ;              8 ^ Patient Account #
 ;              9 ^ EDI Claim
 ;             10 ^ Service connected condition (Y/N)
 ;             11 ^ Anesthesia Time (added DSIF*3.2*1)
 ;             12 ^ Date of Service (FM date)
 ;             13 ^ Site of Service Zip Code
 ;             14 ^ CPT code (#81 external value)
 ;             15 ^ Amount Claimed
 ;             16 ^ Prompt payment (1-Yes, Null N)
 ;             17 ^ Medical denial (1-Yes, Null N)  [We may not need this]
 ;             18 ^ Multiple service same day (1-Yes, Null N)
 ;     DSIFIN1 - (required) Input string, pieces below
 ;       Piece 1 ^ Exempt from pricer (1 - Yes, Null for no)
 ;             2 ^ Medicare ID Number
 ;             3 ^ IEN of Fee Basis Batch File (#161.7)
 ;             4 ^ Vendor's Invoice Date
 ;             5 ^ Patient Control Number (optional)
 ;             6 ^ FPPS CLAIM ID for the EDI claim (optional)
 ;             7 ^ FPPS LINE ITEM number (optional)
 ;             8 ^ New CH payment (1 for Yes)
 ;             9 ^ Primary Diagnosis (opt: external value)
 ;    DSIFMOD - (optional) CPT MODIFIER,CPT MODIFIER, ... (Up to 4)
 ;    CHDATA - (required for CH payments)  Data array defined in DSIFPAU3
 ;    FBRRMK -  (Optional), LITERAL passed by reference
 ;             remittance remarks to file, literal does not have to contain any data or be defined., format:
 ;               FBRRMK=FBRRMKC^(Repeat if needed)   
 ;                     FBRRMKC = remittance remark (internal value file 161.93)
 ;    FBADJ   - (Optional) Literal passed by reference
 ;             adjustments to file  array does not have to contain any data or be defined, format:
 ;           FBADJ=FBADJR;FBADJG;FBADJA^ (repeat if necessary)
 ;               FBADJR = adjustment reason (internal value file 161.91)
 ;               FBADJG = adjustment group (internal value file 161.92)
 ;               FBADJA = adjustment amount (dollar value)
 ;
 ;    MEDATA (Required for Med payments)
 ;             1 ^ DSIFID  (DATE OF SERVICE NUMBER;SERVICE PROVIDED NUMBER [DFN;VENIEN already passed])
 ;             2 ^ Units Paid
 ;             3 ^ FPPS Line item number
 ;             4 ^ Place of service IEN (File:  353.1)
 ;             5 ^ Fee schedule amount
 ;             6 ^ Fee schedule ("F","R" or NULL only)
 ;             7 ^ Amount paid
 ;             8 ^ Suspend code IEN of FILE (#161.27)
 ;             9 ^ Revenue Code IEN of File (#399.2)
 ;            54 ^ CONTRACT (#54)                ;DSIF*3.2*2
 ;            58 ^ ATTENDING PROV NAME (#58)
 ;            59 ^ ATTENDING PROV NPI (#59)
 ;            60 ^ ATTENDING PROV TAXONOMY CODE (#60)
 ;            61 ^ OPERATING PROV NAME (#61)
 ;            62 ^ OPERATING PROV NPI (#62)
 ;            63 ^ RENDERING PROV NAME (#63)
 ;            64 ^ RENDERING PROV NPI (#64)
 ;            65 ^ RENDERING PROV TAXONOMY CODE (#65)
 ;            66 ^ SERVICING PROV NAME (#66)
 ;            67 ^ SERVICING PROV NPI (#67)
 ;            68 ^ REFERRING PROV NAME (#68)
 ;            69 ^ REFERRING PROV NPI (#69)
 ;            73 ^ LI RENDERING PROV NAME (#73)    DSIF*3.2*2 next 3 fields(these are payment line specific)
 ;            74 ^ LI RENDERING PROV NPI (#74)
 ;            75 ^ LI RENDERING PROV TAXONOMY (#75)
 ;
 ;      SUSDESC (Required if suspend code =4  (word processing)
 ;     DSIFOUT - Output data 1^[Message]   or "-1^"error messages
 ;
 Q   ;No direct program calls
 ;
EN(DSIFOUT,DSIFIN,DSIFIN1,DSIFMOD,FBRRMK,FBADJ,CHDATA,MEDATA) ;RPC - DSIF UNA ADD PAYMENT
 ;
 N FBZ,DFN,FBSUBMIT,FBAAPTC,FBAIEN,FBPROG,FBANC,FBCNT,FBADOS,FBCHCO,FBAAMM,FBAAMM1,CNT,FB583,FBAAIN,FBAAID,DSIFERR,FBAMTPD
 N FBZ,FB7078,FBAABDT,FBAAEDT,FBARY,FBASSOC,FBD1,FBDA,FBDMRA,FBFDC,FBI,FBIEN,FBIX,FBMESS,FBMST,FBO,FBPAY,FBZIP,FBFPPSC,FBAABE
 N FBPOV,FBPSA,FBPT,FBTP,FBTT,FBTTYPE,FBI7078,FBOUT,FBV583,BTUSER,FBCHCO,FBAACPT,FBAACPI,FBCPTX,FBEDI,FBEDIT,FBLAST,FBMODL,FBFSUSD,FBDEN
 N FBMODX,ICPTVDT,FBAAFE,FBCNP,CNT,B1,B2,B0,D,DAT,NEW,FBVET,FBVEN,FBIN,FBIEN,FOUND,FBX,BO,FBCSID,FBUNITS,FBCHFA,FBFSAMT,FBAADT
 N FBCSVSTR,FBAR,I,SCR,DSIFCPT,DSIFBT,FBSDI,FBV,D0,FBRET,DSIFID,IDIN,FBTIME,FBAAVID,FBAAVID,DSIFADJ
 K DSIFOUT,^TMP("FBAR",$J)
 ; do input data validations
 S DSIFIN=$G(DSIFIN),FBANC="",(DSIFADJ,FBCHCO)=0,DSIFIN1=$G(DSIFIN1)
 I +DSIFIN=""!('$D(^FBAAA(+DSIFIN))) S DSIFOUT="-1^Patient number missing or invalid" D END Q
 S FBVEN=$P($G(DSIFIN),U,2) I FBVEN=""!('$D(^FBAAV(FBVEN))) S DSIFOUT="-1^Missing or invalid Vendor" D END Q
 I $P(DSIFIN,U,3)=""!('$D(^FB583($P(DSIFIN,U,3)))) S DSIFOUT="-1^Missing or invalid 583 ien" D END Q
 S FB583=$P(DSIFIN,U,3)   ;DSIF*3.2*1
 I $P($P($G(MEDATA),";",2),U)'="" S DSIFOUT="-1^Please do not use this RPC to edit existing Medical Payments" Q
 I $G(CHDATA)'="",$P(DSIFIN1,U,8)="" S DSIFOUT="-1^Please do not use this RPC to edit existing CH Payments" Q
 ; The next check may need removing for CH claims ***************
 I $P(DSIFIN,U,7)="" S DSIFOUT="-1^Invoice number is required" D END Q
 I '+$P(DSIFIN,"^",6) S DSIFOUT="-1^Required date of Correct Invoice Received or Last Date of Service missing!" D END Q
 S DSIFOUT="",FBZ=$G(^FB583($P(DSIFIN,"^",3),0)) I FBZ="" S DSIFOUT="-1^No data exists in the Unauthorized Claims file!" D END Q
 I '($P(FBZ,U,11)=1!($P(FBZ,U,11)=4)) S DSIFOUT="-1^Unauthorized claim must be Approved or Approved to Stabilization in order to make a payment." D END Q
 S (FBVET,DFN,D0)=+DSIFIN,FBPROG(1)=+$P(FBZ,U,2),FBSUBMIT=$P(FBZ,U,23),FBAIEN=+$P(FBZ,U,27)
 S FOUND=0
 ; Due to limitations with Broker build arrays (remittance remarks, adjustments, and Line Item Provider) from literals
 I $D(FBADJ) F I=1:1:$L(FBADJ,U) S FBADJ(I)=$P(FBADJ,U,I),FBADJ(I)=$TR(FBADJ(I),";",U),DSIFADJ=DSIFADJ+$P(FBADJ(I),U,3)
 I $D(FBRRMK) F I=1:1:$L(FBRRMK,U) S FBRRMK(I)=$P(FBRRMK,U,I)
 S FBIX="APMS",FBIEN=FBVET,FBO="40^70^90^" D DISP7^FBUCUTL5(FBIX,FBIEN,FBO) ;lookup by patient, dispositioned claim only
 ;delete entries from array which don't meet criteria:  program=7(cnh), vendor'=fbven, disposition not approved or approved to stabilization
 S (DSIFERR,FBCNT,FBI)=0 F  S FBI=$O(^TMP("FBAR",$J,FBI)) Q:'FBI!(DSIFERR)  S FBZ=$G(^FB583(+^TMP("FBAR",$J,FBI),0)) D
 .I $S($P(FBZ,U,2)=7:1,$P(FBZ,U,3)'=FBVEN:1,$P(FBZ,U,11)'=1&($P(FBZ,U,11)'=4):1,1:0) D:$$GO(FBI)  K ^TMP("FBAR",$J,FBI) S $P(^("FBAR"),";")=+^TMP("FBAR",$J,"FBAR")-1 Q
 ..S FBZ=$P(^(FBI+1),";")_";  "_$$EXTRL^FBMRASVR($P($P(^(FBI),U),";",2))_U_$P($P(^(FBI+1),U),";",2)_U_$P(^(FBI),U,3,8),$P(FBZ,U,7)="  "_$$EXTRL^FBMRASVR($P(FBZ,U,7)),^TMP("FBAR",$J,FBI+1)=FBZ K FBZ
 .S FBCNT=FBCNT+1 I FBI'=FBCNT S ^TMP("FBAR",$J,FBCNT)=^TMP("FBAR",$J,FBI) K ^TMP("FBAR",$J,FBI)
 S SCR=1,FBAR=$G(^TMP("FBAR",$J,"FBAR")) I '+FBAR  S:'SCR DSIFOUT="-1^No data on file." S:SCR DSIFOUT="-1^Claim is not ready for payment yet or invalid IEN."
 ; Check to see if claim is in ^TMP("FBAR" 
 F I=0:0 S I=$O(^TMP("FBAR",$J,I)) Q:'I!(FOUND)  S:+^TMP("FBAR",$J,I)=$P(DSIFIN,U,3) FOUND=1
 ;DSIF*3.2*8
 I 'FOUND S DSIFOUT="-1^The Patient and Vendor on the claim do not match the Patient and Vendor on the attached Authorization.  Please check the Authorization" D END Q
 ;DSIF*3.2*8
 S FBAAPTC="V"  ;1:"R"), ; Vendor only at this time  ;;FBAAPTC=$S(FBSUBMIT["DPT(":"R",FBSUBMIT["FBAAV(":"V",FBSUBMIT["VA(200,":"O",1:0)
 I FBPROG(1)=7 S DSIFOUT="-1^Fee program is community nursing home. Payments should not be authorized.",DSIFERR=1 D END Q
 S FBAAIN=$P(DSIFIN,U,7),FBAAVID=$P(DSIFIN1,U,4),FBADOS=+$P(DSIFIN,U,12)
 I FBAAVID=""!(FBAAVID'?7N) S DSIFOUT="-1^Invalid or missing Vendor Invoice date" D END Q
 I FBPROG(1)=6 S FBANC=$P(DSIFIN,"^",4)
 S FBPROG="I $P(^(0),""^"",9)[""FB583(""&($P(^(0),""^"",3)="_FBPROG(1)_")"
 S X=FBAIEN,CNT=X,CNT(CNT)=X D 2^FBAAUTL1 I FTP']"" S DSIFOUT="-1^FBAAUTL1 error" D END Q
 I 'FBAIEN S DSIFOUT="-1^No authorization associated with this 583!" D END Q
 I FBTYPE'=FBPROG(1) S DSIFOUT="-1^Authorization Fee program differs from Fee program in Unauthorized Claim." D END Q
 S FBV583=FB583_";FB583(",DSIFOUT="1^"
 S DSIFOUT=1 D  I DSIFERR D END Q
 .;payment for outpatient
 .I FBPROG(1)=2 D EN583^DSIFPAU1 Q:DSIFERR  S DSIFOUT=$S('$D(^FBAAC("AJ",DSIFBT,FBAAIN)):"-1^Payment was not completed",1:"1^"_DSIFID),DSIFERR=1 Q
 .I DSIFERR L -^FBAAC(DFN,1,FBV,1,FBSDI)
 . ;payments for pharmacy
 .I FBPROG(1)=3 S DSIFOUT="-1^Pharmacy is not supported at this time",DSIFERR=1 Q
 .;payments for civil hospital
 .I FBPROG(1)=6 S FBI583=FB583_";FB583(",$P(FBZ(0),"^",4)=$P(FBZ,U,5),FBRESUB="" D EN583^DSIFPAU2:'FBANC,6^DSIFPAU1:FBANC Q:DSIFERR  D  Q
 ..I FBANC S:$L(DSIFID,";")<3 DSIFID=DFN_";"_FBV_";"_FBSDI_";"_FBAACPI S DSIFOUT="1^"_DSIFID_"^Completed",DSIFERR=1 Q
 ..S DSIFOUT=$G(DSIFOUT)_"^Completed",DSIFERR=1 Q
 .;payments for community nursing home
 .I FBPROG(1)=7 S DSIFOUT="-1^Community Nursing Home is not supported at this time",DSIFERR=1 Q
 D END
 Q
 ;
END ;kill variables and quit
 K FBAABDT,FBAAEDT,FBAAPTC,FBAIEN,FBANC,FBASSOC,FBARY,FBCNT,FBDA,FBD1,FBFDC,FBI,FBIEN,FBIX,FBI7078,FBMST,FBO,FBOUT,DSIFMOD,FBMODA
 K FBRESUB,FBTTYPE,FBDMRA,FBMESS,FBPAY,FBPOV,FBPSA,FBPROG,FBPT,FBSUBMIT,FBTP,FBTT,FBTYPE,FBVEN,FBVET,FBV583,FBZ,FB583,FB7078,FTP
 K CNT,DFN,D0,X,Y,^TMP("FBAR",$J)
 Q
GETAUTH(DSIFOUT,DFN,AUTHIEN) ;RPC: DSIF UNA GET POINTER IEN
 ;
 K DSIFOUT N CNT,IENS,LIST,MSG
 I $G(DFN)=""!($G(AUTHIEN)="") S DSIFOUT(0)="-1^Invalid entry" Q
 I '$D(^FBAAA(DFN,1,AUTHIEN)) S DSIFOUT(0)="-1^No a valid combination of DFN and Auth IENs" Q 
 S IENS=AUTHIEN_","_DFN_","
 D GETS^DIQ(161.01,IENS,".055","I","LIST","MSG1")
 I $D(MSG) M DSIFOUT=MSG
 I $G(LIST(161.01,IENS,.055,"I"))="" S DSIFOUT="-1^No pointers found for this auth" Q
 S DSIFOUT="1^"_DFN_U_AUTHIEN_U_LIST(161.01,IENS,.055,"I")
 Q
 ;
GO(X) ;X=counter from ^TMP("FBAR",$J,X)
 I '$G(X) Q 0
 Q $S($P($G(^TMP("FBAR",$J,X)),U,3,8)']"":0,'$G(^TMP("FBAR",$J,X+1)):0,$P($G(^TMP("FBAR",$J,X+1)),U,3,8)]"":0,1:1)
