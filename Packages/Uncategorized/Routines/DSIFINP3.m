DSIFINP3 ;DSS/RED - RPC FOR FEE BASIS, INPATIENT ;9/6/2007 9:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   5090  STATION^FBAAUTL
 ;   5093  ADDRESS^FBAAV01,NEWMSG^FBAAV01,STORE^FBAAV01,XMIT^FBAAV01
 ;   5094  $$AUTH^FBAAV6
 ;   5098  $$CHKICD0^FBCSV1,$$CHKICD9^FBCSV1,$$STR2FBDT^FBCSV1
 ;
 ;build a transaction to send to the Austin Pricer system
 ;this data will NOT be stored anywhere. It serves only
 ;as a tool to determine reimbursement rates.
GENERIC(FBOUT,NAME,VENDAT,ADMDAT,REIMB,ICD,PROC,CHARGES) ;RPC: DSIF GENERIC PRICER
 ;Pass in generic data for pricer release to Austin
 ;Input: NAME = "Lastname,Firstname MI;DOB (date);SSN;SEX"
 ;                     Date format - "01151966" [MMDDYYYY]
 ;          VENDAT = "Vendor name;Medicare ID;State (Abreviation 2 Alpha)"
 ;          ADMDAT = "Admission date;Discharge date;Admitting Authority IEN;Disposition code IEN"
 ;          REIMB = "Patient Reimbursement (0/1);Payment by Medicare or Other Federal Agency (0/1)"
 ;          ICD = "ICD1;ICD2;ICD3:ICD4;ICD5" [ICD1 is Mandatory - Primary Diagnosis]
 ;          PROC = "PROC1;PROC2;PROC3"  [PROC1 is mandatory, Primary procedure]
 ;          CHARGES = "Billed Charges;Amount Claimed"
 ; Output = 1^Case sent to pricer  (or)  -1^Error message
 N DSIFERR,PAD,FB,FBSTAN,FBLNAM,FBMI,FBFI,FBSSN,FBDOB
 K FBOUT S FBOUT=""
 S PAD="                              ",FB("ERROR")="",DSIFERR=" 'Fee Basis setup error' "
 D STATION^FBAAUTL G END:FB("ERROR") K FB("ERROR")
 I NAME="" S FBOUT="-1^No name, DOB, SSN, Sex entered, quitting" Q
 I ADMDT="" S FBOUT="-1^No Admission date entered, quitting" Q
 I VENDAT="" S FBOUT="-1^No Vendor data entered, quitting" Q
 S NAME=$P(NAME,";"),FBDOB=$P(NAME,";",2),SSN=$P(NAME,";",3),FBSEX=$P(NAME,";",4)
 ;S ADMDT=$P(ADMDAT,";"),DISDT=$P(ADMDAT,";",2),ADMAUT=$P(ADMDAT,";",3),DISCD=$P(ADMDAT,";",4)
 S ADMDT=$P(ADMDAT,";")
 D ERRCHK Q:FBOUT]""
 S FBLNAM=$E($P(NAME,","),1,12),FBSSN=$E(SSN,10)_$E(SSN,1,9)_" "
 S FBLNAM=FBLNAM_$E(PAD,$L(Y)+1,12),FBFI=$E($P(NAME,",",2),1),FBMI=$S($P(NAME," ",2)]"":$E($P(NAME," ",2),1),1:" ")
 S FBNAME=FBLNAM_FBFI_FBMI,FBSSN=" "_SSN_" "
 S FBSTAN=FBAASN_$E(PAD,$L(FBAASN)+1,6)
 S FBVEN=$P(VENDAT,";"),FBVID=$P(VENDAT,";",2),FBSTABR=$S($L($P(VENDAT,";",3)):$P(VENDAT,";",3),1:"  ")
 S FBFDT=$P(ADMDAT,";"),FBTDT=$P(ADMDAT,";",2),FBAUTH=$$AUTH^FBAAV6($P(ADMDAT,";",3)),FBDISP=$E("00",$L($P(ADMDAT,";",4))+1,2)_$P(ADMDAT,";",4)
 S FBPAYT=$S($P(REIMB,";"):"P",1:"V"),FBMED=$S($P(REIMB,";",2):"Y",1:"N")
 F I=1:1:5 S FBDX(I)="       "
 F I=1:1:5 Q:'$P(ICD,";",I)  D
 . N ICDVDT S ICDVDT=$$STR2FBDT^FBCSV1($G(FBFDT))
 . N FBRT S FBRT=$$CHKICD9^FBCSV1($P(ICD,";",I),$$STR2FBDT^FBCSV1($G(FBFDT))) I FBRT]"" S FBDX(I)=$TR(FBRT,"."),FBDX(I)=FBDX(I)_$E(PAD,$L(FBDX(I))+1,7)
 F I=1:1:3 S FBPRC(I)="       "
 F I=1:1:3 Q:'$P(PROC,";",I)  D
 . N ICDVDT S ICDVDT=$$STR2FBDT^FBCSV1($G(FBFDT))
 . N FBRT S FBRT=$$CHKICD0^FBCSV1($P(PROC,";",I),$$STR2FBDT^FBCSV1($G(FBFDT))) I FBRT]"" S FBPRC(I)=$TR(FBRT,"."),FBPRC(I)=FBPRC(I)_$E(PAD,$L(FBPRC(I))+1,7) Q
 S FBBILL=$FN($P(CHARGES,";"),"",2),FBBILL=$TR(FBBILL,"."),FBBILL=$E("00000000",$L(FBBILL)+1,8)_FBBILL
 S FBCLAIM=$FN($P(CHARGES,";",2),"",2),FBCLAIM=$TR(FBCLAIM,"."),FBCLAIM=$E("00000000",$L(FBCLAIM)+1,8)_FBCLAIM
 S FBOBL="000000"
 ;
STRING ;set-up message text for pricer
 D ADDRESS^FBAAV01 Q:$G(VATERR)  K VAT
 S FBFLAG=1 D NEWMSG^FBAAV01
 S FBPART1=FBSSN_FBFDT_FBSTAN
 S FBSTR(1)=FBPART1_21_FBLNAM_FBFI_FBMI_FBSEX_FBDOB_FBLOS_FBDISP_FBBILL_FBCLAIM_FBAUTH_FBPAYT_FBOBL_"Y"
 S FBSTR(2)=FBPART1_22_FBVID_FBMED_$E(PAD,1,29)_FBTDT_FBSTABR_FBDX(1)
 S FBSTR(3)=FBPART1_23_FBDX(2)_FBDX(3)_FBDX(4)_FBDX(5)_FBPRC(1)_FBPRC(2)_FBPRC(3)_"    "
 F I=1:1:3 S FBSTR=FBSTR(I) D STORE^FBAAV01
 D XMIT^FBAAV01 K FBFLAG
 S FBOUT="1^Case sent to pricer."
 Q
 ;
END K FBSTAN,FBAUTH,FBBILL,FBCLAIM,FBDISP,FBDOB,FBDX,FBFDT,FBFI,FBFLNAM,FBLNAM,FBLOS,FBMED,FBMI,FBNAME,FBOBL,FBPAYT,FBPRC,FBSEX,FBSITE,FB,FBAASN,FBFEE,FBI,FBJ,FBLN,FBNVP,FBOKTX,FBSN,FBXMZ
 K FBSSN,FBSTR,FBSTABR,FBTDT,FBVID,PAD,POP,PRC,FBPART1,FBVEN,FBSDI,VAT,VATERR,VATNAME,Y,FBPOP,FBVAR,FBXMFEE,FBXMNVP,FBPOP
 I '$D(FBOUT) S FBOUT="-1^Error in generic pricer "
 Q
 ;
ERRCHK ;
 ;Check input data validity and required values/fields
 N VAL,VAL1
 D  I $D(VAL) D ERROR G END
 . I NAME="" S VAL="patient name" Q 
 . I FBDOB=""!(FBDOB'?8N) S VAL="date format for DOB or no DOB" Q
 . I SSN=""!(SSN'?9N.1A) S VAL="SSN" Q
 . I $P(VENDAT,";")]"",($L($P(VENDAT,";"))<2),($L($P(VENDAT,";")>46)) S VAL="or no Vendor name" Q
 . I $P(VENDAT,";",2)="" S VAL="Q",VAL1="Vendor must have a Medicare ID number to send to the pricer" Q
 . I $L($P(VENDAT,";",2))'=6 S VAL="Q",VAL1="Medicare ID must be 6 characters in length" Q
 . I $P(VENDAT,";",3)'="",'$D(^DIC(5,"C",$P(VENDAT,";",3))) S VAL="state abbreviation entered" Q 
 . I $P(ADMDAT,";")=""!($L($P(ADMDAT,";"))'=8) S VAL="date of Admission" Q
 . I $P(ADMDAT,";",2)=""!($L($P(ADMDAT,";",2))'=8) S VAL="date of Discharge" Q
 . I $P(ADMDAT,";",3)=""!('$D(^DIC(43.4,$P(ADMDAT,";",3),0))) S VAL="admitting authority" Q
 . I $P(ADMDAT,";",4)=""!('$D(^FBAA(162.6,$P(ADMDAT,";",4),0))) S VAL="admitting authority" Q
 . I $P(REIMB,";")'=0!($P(REIMB,";")'=1) S VAL="Patient Reimbursement" Q
 . I $P(REIMB,";",2)'=0!($P(REIMB,";",2)'=1) S VAL="Payment by Medicare or Other Federal Agency" Q
 . I FBSEX="" S VAL="No sex entered" Q
 . I FBSEX'="M"&(FBSEX'="F") S VAL="sex type" Q
 . I $P(ICD,";")="" S VAL="primary diagnosis must be" Q
 . I $P(CHARGES,";")="" S VAL="billed charges" Q
 . I $P(CHARGES,";",2)="" S VAL="amount claimed" Q
 Q
ERROR ; Set error returns
 S:VAL="Q" FBOUT=VAL1 Q
 S FBOUT="-1^Invalid "_VAL_" entered"
 Q
