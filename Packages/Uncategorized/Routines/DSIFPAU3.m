DSIFPAU3 ;DSS/RED - FEE BASIS ADD Unauthorized CH PAYMENT (INPATIENT) ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;  2053  UPDATE^DIE
 ;  2056  GETS^DIQ                         5088  CNTTOT^FBAARB
 ;  5272  ^FBAAA
 ;  5273  ^FBAA(161.7                     5277  ^FBAAI
 ;  5096  FILEADJ^FBCHFA               5212 FILERR^FBCHFR
 ;  5397  ^FB583                            10103 ^XLFDT
 ;  5744  $$VCNTR^FBUTL7              5745 FILERP^FBUTL8 
 ;
 ;Input Parameters
 ;    CHDATA - List of CHDATA formatted FIELD # ^ Internal Value
 ;          1 ^ Invoice Date Received (Opt - FM Date)
 ;          2 ^ Vendor (REQ - IEN to file 161.2 or changed)
 ;          5 ^ Treatment from date (Opt - FM date);1 (Special flag for treatment dates) (1 means bypass the treatment date verification and allow the user to input any date)
 ;          6 ^ Treatment to date (Opt - FM date)
 ;        6.5 ^ Dsch Type Code (Opt - Pntr to FEE BASIS DISPOSITION CODE File #162.6)
 ;        6.6 ^ Billed Charges (Req - Numeric - Dollar Amount between .01 and 999999.99)
 ;        6.7 ^ Payment by Medicare/Fed Agency (Req - Y = Yes, N = No)
 ;                 (Answer 'Yes' if Medicare or some other federal agency has paid some of the bill for contract hospital.)
 ;           7 ^ Amount Claimed (Req - Numeric - Dollar Amount between .01 and 999999)
 ;              (Amount Claimed cannot be greater than the 'BILLED CHARGES')
 ;           8 ^ Amount Paid
 ;          12 ^ Payment type: R - Reimbursement, V - Vendor, S - Statistical, SR - Stat-reimbursement
 ;          20 ^ Batch IEN (Req - Pntr to file #161.7, must be a "B9" type and Open)
 ;          21 ^ Purpose of Visit pointer (#161.82)
 ;          22 ^ Patient type code: '00' FOR SURGICAL; '10' FOR MEDICAL; '60' FOR HOME NURSING SERVICE; '85' FOR PSYCHIATRIC-CONTRACT; '86' FOR PSYCHIATRIC; '95' FOR NEUROLOGICAL-CONTRACT;'96' FOR NEUROLOGICAL;
 ;          23 ^ Primary service facitlity pointer (#4)
 ;          24 ^ Dsch DRG (Opt - Pntr to DRG File #80.2 use Dsch date of 7078 for code set versioning)
 ;                (NOTE: This field should contain the discharge DRG that is returned from the Austin Pricer System.
 ;          24.5 ^ DRG weight (Opt numeric)
 ;           25 ^ Resubmission (Opt - 1 = Yes)
 ;                (Entry into this field indicates that this invoice is a resubmission. Failure to annotate an invoice 
 ;                  in such a manner would cause Austin to reject the payment as duplicate.)
 ;           26 ^ NVH Pricer amount (Dollar Amount between .01 and 999999.99, 2 Decimal Digits)
 ;           30 ^ ICD1 (Req - Pntr to ICD-9 File #80 **)
 ;           30.02 ^ POA1
 ;           31 ^ ICD2 (Opt - Pntr to ICD-9 File #80 **)
 ;           31.02 ^ POA2
 ;           32 ^ ICD3 (Opt - Pntr to ICD-9 File #80 **)
 ;           32.02 ^ POA3
 ;           33 ^ ICD4 (Opt - Pntr to ICD-9 File #80 **)
 ;           33.02 ^ POA4
 ;           34 ^ ICD5 (Opt - Pntr to ICD-9 File #80 **)
 ;           34.02 ^ POA5
 ;           35 ^ ICD6 (Opt - Pntr to ICD-9 File #80 **) 
 ;           35.02 ^ POA6 
 ;           35.1 ^ ICD7 (Opt - Pntr to ICD-9 File #80 **) 
 ;           35.12 ^ POA7 
 ;           35.2 ^ ICD8 (Opt - Pntr to ICD-9 File #80 **) 
 ;           35.22 ^ POA8 
 ;           35.3 ^ ICD9 (Opt - Pntr to ICD-9 File #80 **) 
 ;           35.32 ^ POA9 
 ;           35.4 ^ ICD10 (Opt - Pntr to ICD-9 File #80 **) 
 ;           35.42 ^ POA10 
 ;           35.5 ^ ICD11 (Opt - Pntr to ICD-9 File #80 **) 
 ;           35.52 ^ POA11 
 ;           35.6 ^ ICD12 (Opt - Pntr to ICD-9 File #80 **) 
 ;           35.62 ^ POA12 
 ;           35.7 ^ ICD13 (Opt - Pntr to ICD-9 File #80 **) 
 ;           35.72 ^ POA13 
 ;           35.8 ^ ICD14 (Opt - Pntr to ICD-9 File #80 **) 
 ;           35.82 ^ POA14 
 ;           35.9 ^ ICD15 (Opt - Pntr to ICD-9 File #80 **) 
 ;           35.92 ^ POA15 
 ;           36 ^ ICD16 (Opt - Pntr to ICD-9 File #80 **) 
 ;           36.02 ^ POA16 
 ;           36.1 ^ ICD17 (Opt - Pntr to ICD-9 File #80 **) 
 ;           36.12 ^ POA17 
 ;           36.2 ^ ICD18 (Opt - Pntr to ICD-9 File #80 **) 
 ;           36.22 ^ POA18 
 ;           36.3 ^ ICD19 (Opt - Pntr to ICD-9 File #80 **) 
 ;           36.32 ^ POA19 
 ;           36.4 ^ ICD20 (Opt - Pntr to ICD-9 File #80 **) 
 ;           36.42 ^ POA20 
 ;           36.5 ^ ICD21 (Opt - Pntr to ICD-9 File #80 **) 
 ;           36.52 ^ POA21 
 ;           36.6 ^ ICD22 (Opt - Pntr to ICD-9 File #80 **) 
 ;           36.62 ^ POA22 
 ;           36.7 ^ ICD23 (Opt - Pntr to ICD-9 File #80 **) 
 ;           36.72 ^ POA23 
 ;           36.8 ^ ICD24 (Opt - Pntr to ICD-9 File #80 **) 
 ;           36.82 ^ POA24 
 ;           36.9 ^ ICD25 (Opt - Pntr to ICD-9 File #80 **) 
 ;           36.92 ^ POA25
 ;           39 ^ ADMITTING DIAGNOSIS
 ;           40 ^ PROC1 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;           41 ^ PROC2 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;           42 ^ PROC3 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;           43 ^ PROC4 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;           44 ^ PROC5 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;           44.06 ^ PROC6 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.07 ^ PROC7 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.08 ^ PROC8 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.09 ^ PROC9 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.1 ^ PROC10 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.11 ^ PROC11 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.12 ^ PROC12 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.13 ^ PROC13 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.14 ^ PROC14 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.15 ^ PROC15 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.16 ^ PROC16 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.17 ^ PROC17 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;           44.18 ^ PROC18 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.19 ^ PROC19 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.2 ^ PROC20 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.21 ^ PROC21 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;           44.22 ^ PROC22 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.23 ^ PROC23 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.24 ^ PROC24 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;           44.25 ^ PROC25 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;           46 ^ Vendor Invoice Date (Req - FM Date)
 ;           47 ^ Prompt Pay Type (0 = No, 1 = Yes)
 ;           54 ^ Covered Days (Opt, minimum = 1 - Calculated with FM if not passed)
 ;           55 ^ Patient Control Number (Req - Free Text 1 - 20 characters)
 ;           56 ^ FPPS Claim ID
 ;           57 ^ FPPS Line Item
 ;           60 ^ CONTRACT
 ;           64 ^ ATTENDING PROV NAME
 ;           65 ^ ATTENDING PROV NPI
 ;           66 ^ ATTENDING PROV TAXONOMY CODE
 ;           67 ^ OPERATING PROV NAME
 ;           68 ^ OPERATING PROV NPI
 ;           69 ^ RENDERING PROV NAME
 ;           70 ^ RENDERING PROV NPI
 ;           71 ^ RENDERING PROV TAXONOMY CODE
 ;           72 ^ SERVICING PROV NAME
 ;           73 ^ SERVICING PROV NPI
 ;           74 ^ REFERRING PROV NAME
 ;           75 ^ REFERRING PROV NPI
 ;           79 ^ .01 ^ LINE ITEM NUMBER
 ;           79 ^ .02 ^ FEE BASIS INVOICE (162.579) RENDERING PROV NAME
 ;           79 ^ .03 ^ FEE BASIS INVOICE (162.579) RENDERING PROV NPI
 ;           79 ^ .04 ^ FEE BASIS INVOICE (162.579) RENDERING PROV TAXONOMY CODE
 ;
 ;            
 ;Return Values
 ;    -1 ^ Invalid Input! (Followed by either Pn[param#] or Field # in CHDATA list)
 ;    -1 ^ Amount Claimed is Greater Than Billed Charges!
 ;    -1 ^ Amount Paid is Greater Than Amount Claimed!
 ;    -1 ^ Adjustment Amount is not equal to Amount Claimed - Amount Paid!
 ;    
 ;    NNN = New IEN on Enter, IEN passed on successful Edit
 ;    
 ;
EN ; ADD CH UNAUTHORIZED PAYMENT
 N P,II,FBPT,AMT,FBAMTC,FBAMTC,FBAMTP,FLDU,DSIF,DSIFD,FIL1,IENS,IENS1,FLD,VAL,ERROR,PAUSTDT,PAUEDDT,PAUCOVD,PAUCLM,PAUVEN,PAUDFN,PAUEEP,DSIFED,DSIFSTD,DSIFFLAG,DSIFDS
 S DSIFOUT="1",(PAUEDDT,PAUSTDT,DSIFERR,PAUCOVD,FBAMTPD,DSIFFLAG,DSICDDT)=0
 S DFN=$P(DSIFIN,U) I '$D(^FBAAA(DFN,0)) S DSIFOUT="-1^Invalid Patient" Q
 I '$G(FB583) S DSIFOUT="-1^Invalid Unauthorized Claim IEN" Q
 I '$G(FBASSOC) S DSIFOUT="-1^Invalid Auth IEN" Q
 I $O(CHDATA(""))']"" S DSIFOUT="-1^Invalid Input! P4",DSIFERR=1 Q
 I $G(FBAABE)="" S FBAABE=$P(DSIFIN1,"^",3)
 S PAUCLM=$P($G(^FB583(FB583,0)),U,9),PAUDFN=$P($G(^FB583(FB583,0)),U,4),PAUVEN=$P($G(^FB583(FB583,0)),U,3),PAUEEP=$P($G(^FB583(FB583,0)),U,2)
 I DFN'=PAUDFN S DSIFOUT="-1^Patient IEN does not match the 583 file",DSIFERR=1 Q
 S DSICDDT=$P(CHDATA(6),U,2) ;DSIF*3.2*2
 S II="" F  S II=$O(CHDATA(II)) Q:II=""  S FLD=+CHDATA(II),VAL=$P(CHDATA(II),U,2+(FLD=58)) D  Q:DSIFOUT<0
 .S FLDU=U_FLD_U
 .Q:"^61^62^63^"[FLDU  ; ignore banking information if sent.  DSIF*3.2*2
 .I FLD=3 K CHDATA(II) Q  ;No edits in this RPC
 .I "^1^2^6.6^6.7^7^8^12^21^22^23^30^46^55^"[FLDU,VAL="" S DSIFOUT="-1^Invalid DATA field: "_FLD,DSIFERR=1 Q
 .I FLD=2,VAL'=PAUVEN S DSIFOUT="-1^Vendor IEN does not match the 583 file",DSIFERR=1 Q
 .I FLD=5,$P(VAL,";",2),VAL'="" S DSIFFLAG=1,DSIFSD=VAL
 .I FLD=6,VAL'="",DSIFFLAG S DSIFED=VAL
 .I FLD=8 S FBAMTPD=FBAMTPD+VAL
 .I "^20^"[FLDU D  Q:DSIFOUT<0
 ..I 'VAL S DSIFOUT="-1^Required Batch Number not entered",DSIFERR=1 Q
 ..I '$D(^FBAA(161.7,VAL)) S DSIFOUT="-1^Required Batch Number is not Valid",DSIFERR=1 Q
 ..I $P($G(^FBAA(161.7,VAL,0)),U,5)'=$G(DUZ) S DSIFOUT="-1^Must be the Clerk who entered",DSIFERR=1 Q
 ..I $P($G(^FBAA(161.7,VAL,0)),U,15)'="Y" S DSIFOUT="-1^Batch must be a Contract Hospital Batch",DSIFERR=1 Q
 ..I $G(^FBAA(161.7,VAL,"ST"))'="O" S DSIFOUT="-1^Batch must have a status of Open",DSIFERR=1 Q
 ..I $P($G(^FBAA(161.7,VAL,0)),U,3)'="B9" S DSIFOUT="-1^Required Batch Number is not a Civil Hospital type",DSIFERR=1 Q
 .I "^6.6^7^"[FLDU S AMT(FLD)=VAL
 .;verify icd codes DSIF*3.2*2
 .I "^30^31^32^33^34^35^35.1^35.2^35.3^35.4^35.4^35.5^35.6^35.7^35.8^35.9^36^36.1^36.2^36.3^36.4^36.5^36.6^36.7^36.8^36.9^"[FLDU  D  I DSIFOUT<0 S DSIFERR=1 Q
 ..S DSIFOUT=$$DGPCHK^DSIFEAP(.CHDATA,FLDU,VAL)
 .I FLD=54,VAL>0 S PAUCOVD=VAL
 .I FLD=60,VAL>0,'$$VCNTR^FBUTL7(PAUVEN,VAL) S DSIFOUT="-1^Invalid contract for this vendor",DSIFERR=1 Q  ;DSIF*3.2*2 Check for valid contract IEN
 .I FLD=79 S NDX=$P(CHDATA(II),U,2),FBLIPROV(NDX)=$P(CHDATA(II),U,3,5)
 Q:DSIFOUT<0!(DSIFERR)
 ; Add checks for proper adjustments DSIF*3.2*8 if overpaying amount claimed
 I AMT(7)>AMT(6.6),(AMT(6.6)-$G(FBADJ)'=+AMT(7)) S DSIFOUT="-1^Amount Claimed is Greater Than Billed Charges, without proper adjustment!",DSIFERR=1 Q
 S PAUSTDT=$P($G(^FB583(+FBV583,0)),U,13),PAUEDDT=$P($G(^FB583(+FBV583,0)),U,14)
 I DSIFFLAG S PAUSTDT=DSIFSD,PAUEDDT=DSIFED
 I 'PAUCOVD S PAUCOVD=$$FMDIFF^XLFDT(PAUEDDT,PAUSTDT,1) I PAUCOVD<1 S PAUCOVD=1
 ;
EN1 ;
 I $D(^FBAAI(FBAAIN)) S DSIFERR=1,DSIFOUT="-1^Invalid Invoice number, that invoice exists" Q
 K FDAIEN,DSIF,ERRMSG
 S FIL=162.5,II="",IENS="+1,"
 L +^FBAAI(FBAAIN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S DSIFOUT="-1^Unable to lock Invoice file, try again later",DSIFERR=1 Q
 F  S II=$O(CHDATA(II)) Q:II=""  D
 .S FLD=+CHDATA(II),VAL=$P(CHDATA(II),U,2)
 .S DSIFD(FLD)=VAL Q
 S DSIFSTD=$P($G(^FB583(+FB583,0)),U,5),DSIFED=$P($G(^FB583(+FB583,0)),U,6)
 I $G(DSIFSTD)="" S DSIFOUT(0)="-1^Invalid Treatment from date on 583",DSIFERR=1 Q
 I $G(DSIFED)="" S DSIFOUT(0)="-1^Invalid Treatment from date on 583",DSIFERR=1 Q
 ;I DSIFED>0 S DSIFCOVD=$$FMDIFF^XLFDT(DSIFED,DSIFSTD,1) I DSIFCOVD<1 S DSIFCOVD=1
 ;I 'DSIFCOVD S DSIFCOVD=1
 S DSIFD(.01)=FBAAIN,DSIFD(4)=$G(FBV583),DSIFD(3)=$G(DFN),DSIFD(54)=$G(PAUCOVD),DSIFD(5)=PAUSTDT,DSIFD(11)=$G(PAUEEP),DSIFD(20)=$G(FBAABE)
 I PAUEDDT S DSIFD(6)=PAUEDDT
 M DSIF(FIL,IENS)=DSIFD K DSIF(FIL,IENS,58)
 S FDAIEN(1)=FBAAIN D UPDATE^DIE(,"DSIF","FDAIEN") L -^FBAAI(FBAAIN)
 K DSIF,IENS1,ERROR S IENS=FBAAIN_","
 I $G(FBADJ(1))'="" D FILEADJ^FBCHFA(FBAAIN_",",.FBADJ)
 ; if remit remark data changed then file
 I $G(FBRRMK(1))'="" D FILERR^FBCHFR(FBAAIN_",",.FBRRMK)
  ; if line item provider data changed then file
 I $D(FBLIPROV) D FILERP^FBUTL8(FBAAIN_",",.FBLIPROV)       ;DSIF*3.2*2
 D  Q:DSIFERR
 .N FBX
 .S FBX=FBAAMPI-(FBINC+1)
 .I FBX<6 S DSIFOUT(0)="-1^Warning, you can only enter "_FBX_" more invoices in this batch!",DSIFERR=1
 S DSIFOUT="1^"_FBAAIN
 K DSIF,IENS,DSIFD,FDAIEN,FIL,FIL1
 Q
