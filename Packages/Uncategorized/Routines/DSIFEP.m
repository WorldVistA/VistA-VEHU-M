DSIFEP ;DSS/AMC,RED - FEE BASIS ADD/EDIT PAYMENT (INPATIENT) ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;  2051  FIND^DIC
 ;  2053  FILE^DIE,UPDATE^DIE
 ;  2056  GETS^DIQ
 ;  5088  CNTTOT^FBAARB
 ;  5090  GETNXI^FBAAUTL
 ;  5096  FILEADJ^FBCHFA
 ;  5212  FILERR^FBCHFR
 ; 10013  ^DIK
 ; 10103  $$FMDIFF,$$FMTE^XLFDT
 Q
EN(AXY,DFN,FB7078,AUTH,DATA) ;RPC - DSIF INP ADD/EDIT PAYMENT
 ;Input Parameters
 ;    DFN - Pntr to Patient File #2 (Req - also must be in FEE BASIS PATIENT File #161)
 ;          (On edit this field should = "E")
 ;    FB7078 - Pntr to 7078 File #162.4 (Req)
 ;             (On edit this field is IEN of FEE BASIS INVOICE File #162.5)
 ;    AUTH - Authorization IEN from AUTHORIZATION multiple of FEE BASIS PATIENT File #161 (Req on Enter only should be null on Edit);Duplicate Invoice same day Flag (1) if yes
 ;    DATA - List of Data formatted FIELD # ^ Internal Value
 ;          1 ^ Invoice Date Received (Opt - FM Date)
 ;          2 ^ Vendor (Opt - IEN to file 161.2 or changed)
 ;          5 ^ Treatment from date (Opt - FM date);1 (Special flag for treatment dates) (1 means bypass the treatment date verification and allow the user to input any date)
 ;          6 ^ Treatment to date (Opt - FM date)
 ;          6.5 ^ Dsch Type Code (Opt - Pntr to FEE BASIS DISPOSITION CODE File #162.6)
 ;          6.6 ^ Billed Charges (Req - Numeric - Dollar Amount between .01 and 999999.99)
 ;          6.7 ^ Payment by Medicare/Fed Agency (Req - Y = Yes, N = No)
 ;              (Answer 'Yes' if Medicare or some other federal agency has paid some of the bill for contract hospital.)
 ;          7 ^ Amount Claimed (Req - Numeric - Dollar Amount between .01 and 999999)
 ;              (Amount Claimed cannot be greater than the 'BILLED CHARGES')
 ;          8 ^ AMOUNT PAID                                                                             Added with DSIF*3.2*1
  ;        11 ^ Fee Program (Req - IEN 161.8) [6 for B9 batches]
 ;         12 ^ Payment type code (Req, set of codes)                                           Added with DSIF*3.2*1
 ;         20 ^ Batch IEN (Req - Pntr to file #161.7, must be a "B9" type and Open)
 ;         21 ^ Purpose of Visit (Req - IEN of file 161.82)                                      Added with DSIF*3.2*1
 ;         22 ^ Patient type code (Req - set of codes)                                            Added with DSIF*3.2*1
 ;         23 ^ Primary Service facility  (Req - IEN of file #4)                                 Added with DSIF*3.2*1
 ;         24 ^ Dsch DRG (Opt - Pntr to DRG File #80.2 use Dsch date of 7078 for code set versioning)
 ;             (NOTE: This field should contain the discharge DRG that is returned from the Austin Pricer System.)
 ;         24.5 ^ DRG Weight (Req - Type a Number between 0 and 999.9999)                       Added with DSIF*3.2*1
 ;         25 ^ Resubmission (Opt - 1 = Yes)
 ;             (Entry into this field indicates that this invoice is a resubmission. Failure to annotate an invoice 
 ;              in such a manner would cause Austin to reject the payment as duplicate.)
 ;         26 ^ NVH PRICER AMOUNT                                                                   Added with DSIF*3.2*1
 ;         30 ^ ICD1 (Req - Pntr to ICD-9 File #80 **)         Added ICD6-ICD25,POA1-25 and PROC 6-25 with DSIF*3.2*2
 ;         30.02 ^ POA1
 ;         31 ^ ICD2 (Opt - Pntr to ICD-9 File #80 **)
 ;         31.02 ^ POA2
 ;         32 ^ ICD3 (Opt - Pntr to ICD-9 File #80 **)
 ;         32.02 ^ POA3
 ;         33 ^ ICD4 (Opt - Pntr to ICD-9 File #80 **)
 ;         33.02 ^ POA4
 ;         34 ^ ICD5 (Opt - Pntr to ICD-9 File #80 **)
 ;         34.02 ^ POA5
 ;         35 ^ ICD6 (Opt - Pntr to ICD-9 File #80 **) 
 ;         35.02 ^ POA6 
 ;         35.1 ^ ICD7 (Opt - Pntr to ICD-9 File #80 **) 
 ;         35.12 ^ POA7 
 ;         35.2 ^ ICD8 (Opt - Pntr to ICD-9 File #80 **) 
 ;         35.22 ^ POA8 
 ;         35.3 ^ ICD9 (Opt - Pntr to ICD-9 File #80 **) 
 ;         35.32 ^ POA9 
 ;         35.4 ^ ICD10 (Opt - Pntr to ICD-9 File #80 **) 
 ;         35.42 ^ POA10 
 ;         35.5 ^ ICD11 (Opt - Pntr to ICD-9 File #80 **) 
 ;         35.52 ^ POA11 
 ;         35.6 ^ ICD12 (Opt - Pntr to ICD-9 File #80 **) 
 ;         35.62 ^ POA12 
 ;         35.7 ^ ICD13 (Opt - Pntr to ICD-9 File #80 **) 
 ;         35.72 ^ POA13 
 ;         35.8 ^ ICD14 (Opt - Pntr to ICD-9 File #80 **) 
 ;         35.82 ^ POA14 
 ;         35.9 ^ ICD15 (Opt - Pntr to ICD-9 File #80 **) 
 ;         35.92 ^ POA15 
 ;         36 ^ ICD16 (Opt - Pntr to ICD-9 File #80 **) 
 ;         36.02 ^ POA16 
 ;         36.1 ^ ICD17 (Opt - Pntr to ICD-9 File #80 **) 
 ;         36.12 ^ POA17 
 ;         36.2 ^ ICD18 (Opt - Pntr to ICD-9 File #80 **) 
 ;         36.22 ^ POA18 
 ;         36.3 ^ ICD19 (Opt - Pntr to ICD-9 File #80 **) 
 ;         36.32 ^ POA19 
 ;         36.4 ^ ICD20 (Opt - Pntr to ICD-9 File #80 **) 
 ;         36.42 ^ POA20 
 ;         36.5 ^ ICD21 (Opt - Pntr to ICD-9 File #80 **) 
 ;         36.52 ^ POA21 
 ;         36.6 ^ ICD22 (Opt - Pntr to ICD-9 File #80 **) 
 ;         36.62 ^ POA22 
 ;         36.7 ^ ICD23 (Opt - Pntr to ICD-9 File #80 **) 
 ;         36.72 ^ POA23 
 ;         36.8 ^ ICD24 (Opt - Pntr to ICD-9 File #80 **) 
 ;         36.82 ^ POA24 
 ;         36.9 ^ ICD25 (Opt - Pntr to ICD-9 File #80 **) 
 ;         36.92 ^ POA25 
 ;         39 ^ ADMITTING DIAGNOSIS
 ;         40 ^ PROC1 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;         41 ^ PROC2 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;         42 ^ PROC3 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;         43 ^ PROC4 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;         44 ^ PROC5 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;         44.06 ^ PROC6 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.07 ^ PROC7 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.08 ^ PROC8 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.09 ^ PROC9 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.1 ^ PROC10 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.11 ^ PROC11 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.12 ^ PROC12 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.13 ^ PROC13 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.14 ^ PROC14 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.15 ^ PROC15 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.16 ^ PROC16 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.17 ^ PROC17 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;         44.18 ^ PROC18 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.19 ^ PROC19 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.2 ^ PROC20 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.21 ^ PROC21 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;         44.22 ^ PROC22 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.23 ^ PROC23 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.24 ^ PROC24 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **) 
 ;         44.25 ^ PROC25 (Opt - Pntr to ICD OPERATION/PROCEDURE File #80.1 **)
 ;         47 ^ Prompt Pay Type (Opt -"" = No, 1 = Yes, Default = "")
 ;         58 ^ .01 ^ Adj Reason (Req if Amount Paid not equal to Amount Claimed - Pntr to ADJUSTMENT REASON File #161.91)
 ;         58 ^ 1 ^ Adj Group (Req as Adj Reason - Pntr to ADJUSTMENT GROUP File #161.92)
 ;         58 ^ 2 ^ Adj Amount (Req as Adj Reason - Numeric : Amount Claimed - Amount Paid)
 ;         59 ^ Seq # (1 or 2) ^ Remittance Remark (Opt - Pntr to REMITTANCE REMARK File #161.93)
 ;                (For Inpatient Invoices there is a max of 2 remarks)
 ;         60 ^ CONTRACT                  ;Added fields 60-79 with DSIF*3.2*2
 ;         64 ^ ATTENDING PROV NAME
 ;         65 ^ ATTENDING PROV NPI
 ;         66 ^ ATTENDING PROV TAXONOMY CODE
 ;         67 ^ OPERATING PROV NAME
 ;         68 ^ OPERATING PROV NPI
 ;         69 ^ RENDERING PROV NAME
 ;         70 ^ RENDERING PROV NPI
 ;         71 ^ RENDERING PROV TAXONOMY CODE
 ;         72 ^ SERVICING PROV NAME
 ;         73 ^ SERVICING PROV NPI
 ;         74 ^ REFERRING PROV NAME
 ;         75 ^ REFERRING PROV NPI
 ;         79 ^ .01 ^ LINE ITEM NUMBER
 ;         79 ^ .02 ^ FEE BASIS INVOICE (162.579) RENDERING PROV NAME
 ;         79 ^ .03 ^ FEE BASIS INVOICE (162.579) RENDERING PROV NPI
 ;         79 ^ .04 ^ FEE BASIS INVOICE (162.579) RENDERING PROV TAXONOMY CODE
 ;Return Values
 ;    -1 ^ Invalid Input! (Followed by either Pn[param#] or Field # in DATA list)
 ;    -1 ^ Amount Claimed is Greater Than Billed Charges!
 ;    -1 ^ Amount Paid is Greater Than Amount Claimed!
 ;    -1 ^ Adjustment Amount is not equal to Amount Claimed - Amount Paid!
 ;    -1^Invoice number NNNN has already been entered for this authorization.
 ;    NNN = New IEN on Enter, IEN passed on successful Edit
 N FBADJ,FBRRMK,II,CNT59,CNT59,DSIF,FIL,IENS,FBAAIN,FBVET,FBPT,FBAABE,AMT,FBAMTP,FBAMTC,FBAMTC,FBAMTP,NEW,FLDU,DSIFB,DSIFI,DSIFD,FIL1,IENS1,FLD,VAL,DSIFCOVD
 N DSIFSD,DSIFED,FBI7078,DSIFFLAG,FBN,FBK,FBNK,FBBAMT,NDX,FBLIPROV,DSIFICDDATE,DSIFCNT,EXCNT,FBVEN,FBDFN
 K AXY
 ;  Established a new flag DSIFFLAG to change the treatment from and treatment to dates if the second ";" piece of the value for 5 (treatment to) date is passed in as a "1"
 S (FBDFN,NEW)=+$G(DFN),(FBRRMK,FBADJ,AXY)="",(DSIFCOVD,DSIFSD,DSIFED,DSIFFLAG)=0
 S DSIFSD=$P($G(^FB7078(+FB7078,0)),U,4),DSIFED=$P($G(^FB7078(+FB7078,0)),U,5),FBI7078=+FB7078_";FB7078("
 I 'NEW D  Q:AXY<0  G EN1
 .S IENS=FB7078_","
 .I 'IENS!'$D(^FBAAI(+IENS,0)) S AXY="-1^Invalid Invoice number" Q
 I DFN=NEW,'$D(^FBAAA(DFN,0)) S AXY="-1^Invalid Patient" Q
 I '$G(FB7078) S AXY="-1^Invalid Notification IEN" Q
 I '$G(AUTH) S AXY="-1^Invalid Auth IEN" Q
 I $O(DATA(""))']"" S AXY="-1^Invalid Input! P4" Q
 ;Check for duplicate service for Auth and validity flag for ok to duplicate
 I $P(AUTH,";",2)'=1,$G(FBI7078),$D(^FBAAI("E",FBI7078)) S FBAAIN=$O(^FBAAI("E",FBI7078,0)),AXY="-1^Invoice number "_FBAAIN_" has already been entered for this authorization." Q
 ; end of duplicate service check
 I +FBDFN=0 N FBZ78 D GETS^DIQ(162.4,FB7078_",","1;2","I","FBZ78") S FBDFN=FBZ78(162.4,FB7078_",",2,"I"),FBVEN=+FBZ78(162.4,FB7078_",",1,"I") K FBZ78  ;On edit find Pt, Vendor from 7078
 S II="" F  S II=$O(DATA(II)) Q:II=""  S FLD=+DATA(II),VAL=$P(DATA(II),U,2+(FLD=59!(FLD=58))) D  Q:AXY<0
 .S FLDU=U_FLD_U
 .Q:"61,62,63"[FLD  ;Ignore financial information fields/  DSIF*3.2*2
 .I "^1^2^6.6^6.7^7^11^12^21^22^23^30^46^47^55^"[FLDU,VAL="" S AXY="-1^Invalid data field: "_FLD Q
 . I FLD=2,VAL'="" S FBVEN=VAL
 .I FLD=5,$P(VAL,";",2),VAL'="" S DSIFFLAG=1,DSIFSD=+VAL
 .I FLD=5 S VAL=+VAL  ;Remove flag set in input array field 5
 .I FLD=5,'DSIFFLAG D  Q:+AXY=-1   ;Check for valid treatment from and to dates if special dates flag not passed in (second ";" piece of the field 5 value)
 ..I VAL<DSIFSD!(VAL>DSIFED) S AXY="-1^From date "_$$FMTE^XLFDT(VAL)_" is not within the authorized dates on the  7078 entry "_$$FMTE^XLFDT(DSIFSD) Q
 .I FLD=6,VAL'="",DSIFFLAG S DSIFED=VAL
 .S:FLD=6 DSIFICDDATE=VAL
 .I FLD=11 D
 ..I '$D(^FBAA(161.8,VAL))  S AXY="-1^Required Fee Program not entered or Invalid" Q
 ..I $P(^FBAA(161.8,VAL,0),U,3)=0 S AXY="-1^Required Fee Program entered is not active, Invalid selection" Q
 .I "^20^"[FLDU D  Q:AXY<0
 ..I 'VAL S AXY="-1^Required Batch Number not entered" Q
 ..I '$D(^FBAA(161.7,VAL)) S AXY="-1^Required Batch Number is not Valid" Q
 ..I $P($G(^FBAA(161.7,VAL,0)),U,5)'=$G(DUZ) S AXY="-1^Must be the Clerk who entered" Q
 ..I $P($G(^FBAA(161.7,VAL,0)),U,15)'="Y" S AXY="-1^Batch must be a Contract Hospital Batch" Q
 ..I $G(^FBAA(161.7,VAL,"ST"))'="O" S AXY="-1^Batch must have a status of Open" Q
 ..I $P($G(^FBAA(161.7,VAL,0)),U,3)'="B9" S AXY="-1^Required Batch Number is not a Civil Hospital type" Q
 .I FLD=21,'VAL!('$D(^FBAA(161.82,VAL,0))) S AXY="-1^Purpose of Visit missing or invalid" Q
 .I FLD=24,$G(VAL)]"",'$D(^ICD(VAL)) S AXY="-1^Invalid Discharge DRG entered" Q    ;(Added validity check with DSIF*3.2*1)
 .I FLD=25,VAL'=1,VAL'="" S AXY="-1^Invalid input "_VAL_" for field #25, only the value of '1' or 'null' is allowed" Q
 .I FLD=47,VAL'=1 S AXY="-1^Invalid input "_VAL_" for field #47, only the value of '1' is allowed" Q
 .;verify icd and poa codes dsif*3.2*2
 .I "^30^31^32^33^34^35^35.1^35.2^35.3^35.4^35.4^35.5^35.6^35.7^35.8^35.9^36^36.1^36.2^36.3^36.4^36.5^36.6^36.7^36.8^36.9^"[FLDU  D  Q:AXY<0
 ..S AXY=$$DGPCHK^DSIFEAP(.DATA,FLDU,VAL)
 .I FLD=47,VAL'=1 S AXY="-1^Invalid input "_VAL_" for field #47, only the value of '1' is allowed" Q
 .I FLD=54,VAL>0 S DSIFCOVD=VAL
 .I FLD=58,'VAL S AXY="-1^Invalid Input! "_FLD_" - "_$P(DATA(II),U,2)
 . ; DSIF*3.2*2 (as per FB*3.5*108)
 .I FLD=60 D
 ..N DSIFCE,EXCNT
 ..D GETS^DIQ(161.01,+AUTH_","_FBDFN_",",105,"I","EXCNT") S EXCNT=$G(EXCNT(161.01,+AUTH_","_FBDFN_",",105,"I")),DSIFCE=1
 ..I EXCNT S DSIFCE=$$EDCNTRA^FBUTL7(FBDFN,+AUTH)
 ..I $G(DSIFCE)=0 S AXY="-1^Cannot edit Contract" Q
 ..I VAL'="@",'DSIFCE,VAL>0,+$G(EXCNT)'=VAL S AXY="-1^"_$P(DSIFCE,U,2) Q   ;Don't allow edit
 ..I VAL="@",'DSIFCE S AXY="-1^"_$P(DSIFCE,U,2) Q
 . S DSIFCNT=VAL
 .I FLD=79,'VAL S AXY="-1^Invalid Input! "_FLD_" - "_$P(DATA(II),U,2)
 .I "^6.6^7^"[FLDU S AMT(FLD)=VAL
 .I FLD=58,$P(DATA(II),U,2)=2 S AMT(58.2)=VAL
 Q:AXY<0
 I AMT(7)>AMT(6.6) S AXY="-1^Amount Claimed is Greater Than Billed Charges!" Q
 I 'DSIFCOVD S DSIFCOVD=$$FMDIFF^XLFDT(DSIFED,DSIFSD,1) I DSIFCOVD<1 S DSIFCOVD=1
 ;
EN1 ;
 I DFN D GETNXI^FBAAUTL S DSIFD(3)=DFN,(DSIFD(.01),DSIFI(1))=FBAAIN,IENS="+1,",DSIFD(4)=FB7078_";FB7078("
 I DFN="E" S FBAAIN=FB7078
 S FIL=162.5,II="",DSIFD(54)=$G(DSIFCOVD),(FBNK,FBK)=0
 L +^FBAAI(FBAAIN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S AXY="-1^Unable to lock Invoice file, try again later" Q
 F  S II=$O(DATA(II)) Q:II=""  D
 .S FLD=+DATA(II),VAL=$P(DATA(II),U,2+(FLD=59!(FLD=58)))
 .;new code to put dollar values in file 161.7 - DSIF*3.2*8
 .I FLD=8 S FBNK=VAL  ;Amount to pay
 .I FLD=20 D  ;direct global write copied from FBCHEP1
 ..S FBN=VAL  ;Batch IEN
 ..I FBAAIN S FBK=$S($P($G(^FBAAI(FBAAIN,0)),"^",9)="":0,1:$P(^(0),"^",9))  ;Amount currently in Invoice  DSIF*3.2*8
 .I ",58,59,79,"'[(","_FLD_",") S DSIFD(FLD)=VAL Q
 .I FLD=79 S NDX=$P(DATA(II),U,2),FBLIPROV(NDX)=$P(DATA(II),U,3,5) ;Line item provider DSIF*3.2*2
 .S DSIFD(FLD,$P(DATA(II),U,2))=VAL
 S FBBAMT=FBK
 I FBNK'=FBK,(FBBAMT>0) S $P(^FBAA(161.7,FBN,0),"^",9)=FBBAMT+(FBNK-FBK)  ;If amount to pay doesn't match batch file, reset batch file
 M DSIF(FIL,IENS)=DSIFD K DSIF(FIL,IENS,58),DSIF(FIL,IENS,59),DSIF(FIL,IENS,79)
 D:NEW UPDATE^DIE(,"DSIF","DSIFI") L -^FBAAI(FBAAIN)
 D:'NEW FILE^DIE(,"DSIF") L -^FBAAI(FBAAIN)
 K DSIF
 I NEW D
 .I $D(DSIFD(58)) D  D UPDATE^DIE(,"DSIF")
 ..F II=.01,1,2 S DSIF(162.558,"+1,"_IENS,II)=DSIFD(58,II)
 .K DSIF,DSIFI
 .I $D(DSIFD(59)) F II=1,2 S:$D(DSIFD(59,II)) DSIF(162.559,"+"_II_","_IENS,.01)=$S($G(DSIFD(59,II)):DSIFD(59,II),1:"@"),DSIFI(II)=II
 .I $O(DSIF(0)) D UPDATE^DIE(,"DSIF","DSIFI")
 I $D(DSIFD(58)) D
 .N NEW S NEW='$D(^FBAAI(+IENS,8,1,0))
 .S IENS1="1,"_IENS,FIL1=162.558 S:NEW IENS1="+"_IENS1 F II=.01,1,2 S DSIF(FIL1,IENS1,II)=$G(DSIFD(58,II)),FBADJ(1)=$S(II=.01:$G(DSIFD(58,II)),1:FBADJ(1)_U_$G(DSIFD(58,II)))
 .I NEW D UPDATE^DIE(,"DSIF")
 .D FILE^DIE(,"DSIF")
 I $D(DSIFD(59)) D
 .N NEW S FIL1=162.559
 .F II=1,2 D:$D(DSIFD(59,II))
 ..S NEW='$D(^FBAAI(+IENS,9,II,0))
 ..S IENS1=$S(NEW:"+1",1:II)_","_IENS,DSIF(FIL1,IENS1,.01)=$S(DSIFD(59,II):DSIFD(59,II),1:"@"),FBRRMK(II)=$G(DSIFD(59,II))
 ..D UPDATE^DIE(,"DSIF"):NEW
 ..D FILE^DIE(,"DSIF"):'NEW
 ; if adjustment data changed then file
 I $D(FBADJ(1)) D FILEADJ^FBCHFA(FBAAIN_",",.FBADJ)
 ; if remit remark data changed then file
 I $D(FBRRMK(1)) D FILERR^FBCHFR(FBAAIN_",",.FBRRMK)
 ; if referring provider info changed then file
 I $D(FBLIPROV) D FILERP^FBUTL8(FBAAIN_",",.FBLIPROV)
 S AXY="1^"_FBAAIN
 Q
VALDEL(AXY,IEN) ;RPC - DSIF INP CHK DEL BATCH
 ;Input Parameters
 ;    IEN - Internal Entry Number of Batch that has Invoice to delete (Req - Pntr to FEE BASIS BATCH File #161.7)
 ;    
 ;Return Values
 ;    -1 ^ Invalid Input!
 ;    0 = Not a valid batch for current user
 ;    1 = Batch Valid for Invoice selection
 ;    
 ;    
 S IEN=+$G(IEN)  I '$D(^FBAA(161.7,IEN,0)) S AXY="-1^Invalid Input!" Q
 N CHK,DSIF,DSIF0
 S CHK=$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"I ""TV""'[$G(^(""ST""))",1:"I $P(^(0),U,5)=DUZ&(""TVRS""'[($G(^(""ST""))))")_"&($P(^(0),U,3)=""B9"")"
 S DSIF0=$G(^FBAA(161.7,IEN,0))
 X CHK I  S AXY=1 Q
 S AXY=0
 Q
DELINV(AXY,IEN,BAT) ;RPC - DSIF INP DELETE INVOICE
 ;Input Parameters
 ;    IEN - Internal Entry Number for FEE BASIS INVOICE File #162.5 (Req)
 ;    BAT - Internal Entry Number for FEE BASIS BATCH File #161.7 (Req)
 ;Return Value
 ;    -1 ^ Invalid Input!
 ;    -1 ^ Invoice/Batch Doesn't Exist!
 ;    1 = Invoice Deleted
 I '$G(IEN)!'$G(BAT) S AXY="-1^Invalid Input!" Q
 I '$D(^FBAAI(IEN,0)) S AXY="-1^Invoice Doesn't Exist!" Q  ;DSIF*3.2*2 (Split verification for clarity)
 I '$D(^FBAA(161.7,BAT,0)) S AXY="-1^Batch Doesn't Exist!" Q
 N FBBAT,FBTOTAL,FBLCNT,DA,DIK,CHK
 D VALDEL(.CHK,BAT) I CHK'>0 S AXY="-1^You cannot delete this invoice" Q   ;DSIF*3.2*1
 L +^FBAA(161.7,BAT):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S AXY="-1^Unable to lock file, try again later" Q
 S FBBAT(0)=^FBAA(161.7,BAT,0)
 S DIK="^FBAAI(",DA=IEN D ^DIK
 ;reset batch dollar amount, total payment items and invoice count
 D CNTTOT^FBAARB(BAT)
 S $P(FBBAT(0),"^",9)=+FBTOTAL
 S $P(FBBAT(0),"^",10)=+FBLCNT
 S $P(FBBAT(0),"^",11)=+FBLCNT
 S:$P(FBBAT(0),"^",10)'>0 $P(FBBAT(0),"^",18)=""
 S $P(^FBAA(161.7,BAT,0),"^",9,11)=$P(FBBAT(0),"^",9,11),$P(^FBAA(161.7,BAT,0),"^",18)=$P(FBBAT(0),"^",18)
 L -^FBAA(161.7,BAT)
 S AXY=1
 Q
