DSIFPAY3 ;DSS/RED - RPC FOR FEE BASIS PAYMENTS ;12/31/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;   2053  FILE^DIE,UPDATE^DIE,WP^DIE
 ;   SITE^FBAACO   5082
 ;  ^FBAAC 5107
 ;  REPMOD^FBAAUTL4  5091
 ;  $$RRL^FBUTL4  5102
 ;  FILERR^FBAAFR 5086
 ;  ^FBAA(161.7 5273
 ;  MODA^ICPTMOD 1996 
 ;  $$MOD^ICPTMOD 1996
 ;  $$FMTE^XLFDT  10103 
 ;
 Q    ;no direct calls to the routine
EDITPAY(FBOUT,FBID,FBSERV,FBDIAG,FBREM,FBMOD,FBADJ,FBSUS,FBSUSC,DSIFDATA) ; RPC: DSIF PAY MED PAYMENT ADD/EDIT
 ;Inputs:  FEE PROGRAM =2
 ; FBID=ID^Date of service:(2)^Fee program:(3)^Authorization pointer:(4)^C&P flag:(5)^Test payment only Flag:(6)^Fee basis reimbursement payment flag:(7)
 ; FBSERV=Service provided:(1)^Amt Claimed:(2)^Amount Paid:(3)^Date Finalized:(4)^Batch IEN :(5)^Obligation #:(6)^
 ;             Date correct invoice received:(7)^Invoice #:(8)^Patient type:(9)^POV:(10)^Treatment type:(11)^
 ;             Primary Service facility:(12)^Associated 7078/583:(13)**(SEE NOTE BELOW)^Anesthesia Time:(14)
 ;               ** Data passed in as IEN of 7078_";FB7078(" or IEN of 583_";FB583("  [example: "78;FB7078("]
 ; FBDIAG=Primary Diagnosis:(1)^Place of service:(2)^HCFA type of service:(3)^Service connected y/n:(4)^
 ;             Vendor invoice date:(5)^Site of service zip code:(6)^Units paid:(7)^Revenue code:(8)^
 ;             Patient account number:(9)^FPPS claim ID:(10)^FPPS line item:(11)^Prompt payment (1 or null only):(12)^Fee schedule Amt:(13)^Fee Schedule:(14)
 ; FBREM=IEN of remark:(1)^ [may repeat]
 ; FBMOD=Modifier (not IEN):(1)^ [may repeat]
 ; FBADJ=IEN of adjustment:(1)^IEN Adjustment Group:(2)^Adjustment amount:(3)^ [may repeat]
 ; FBSUS=Amount suspended:(1)^date suspended:(2)^Suspend code:(3)
 ; FBSUSC=Suspension text (free text)
 ;
 ; DSIFDATA array (New fields added DSIF*3.2*2)
 ;  54^CONTRACT (#54)
 ;  58^ATTENDING PROV NAME (#58)
 ;  59^ATTENDING PROV NPI (#59)
 ;  60^ATTENDING PROV TAXONOMY CODE (#60)
 ;  61^OPERATING PROV NAME (#61)
 ;  62^OPERATING PROV NPI (#62)
 ;  63^RENDERING PROV NAME (#63)
 ;  64^RENDERING PROV NPI (#64)
 ;  65^RENDERING PROV TAXONOMY CODE (#65)
 ;  66^SERVICING PROV NAME (#66)
 ;  67^SERVICING PROV NPI (#67)
 ;  68^REFERRING PROV NAME (#68)
 ;  69^REFERRING PROV NPI (#69)
 ;  73^LI RENDERING PROV NAME (#73)    (these are payment line specific)
 ;  74^LI RENDERING PROV NPI (#74)
 ;  75^LI RENDERING PROV TAXONOMY (#75)
 ;
 N PID,DFN,FBV,DA,FBNPV,FBNSDT,NEWSERV,NOADJ,BAT,FB1725,FBAACP,FBAACPI,FBAADT,NEWSP,CNT,FBAAC,FBAR,Y,CPTIENS,FBNEWP,AUTHIEN,FBMODV,FBRET
 N FBCNP,FBDUZ,FBFPPSC,FBFPPSL,FBHIGH,FBI,FBMSR,FBNPT,FBPOP,FBPROMP,FBJ,FBNCPT,FBAABDT,FBINV,FDB,FDC,FBFOUT,FBMODA,Z1,DSIFERR,FBSCH1,DSIFCPT
 N FBRRMK,FBRRMKL,FBSD,FBSV,FBTAS,K,MFLAG,NEWCPT,NEWSERV,FBMODL,FBAAID,FBAAPTC,FBAAMPI,FBCNT,FBAAOIN,FBADJA,FBSIEN,FBIENS,PMTCNT,X,DSIF,DSIFPOS
 N DSFLDS,FBN2,P1,P2,DSIFCNT,FBSUSCA
 K FBOUT S (FBNPT,FBNPV,FBNSDT,NEWSP,NEWSERV,NEWCPT,FBNCPT,NOADJ)=0
 S:$G(U)="" U="^" I $G(DUZ)="" S FBOUT="-1^User not defined" Q
 S FBOUT=""
 D SITE^FBAACO I $G(FBPOP) S FBOUT="-1^Invalid Fee basis site parameters" Q
 I $P(FBID,U,7)=1 S FBAAPTC="R"
 ; error checking for required fields, etc.
 I $P(FBSERV,U)="" S FBOUT="-1^CPT Code missing, quitting." Q
 S (Z1,FBNEWP)=0,FBSCH1=$P(FBDIAG,U,14)  I $P($P(FBID,U),";",4)="" S FBNEWP=1  ;edit flag for payment counter  
 ; DSIF*3.2*2, define new fields from Array to array by field numbers
 N I I $D(DSIFDATA) F I=0:0 S I=$O(DSIFDATA(I)) Q:I=""  I $P($G(DSIFDATA(I)),U,2)'="" S DSFLDS($P(DSIFDATA(I),U))=$P(DSIFDATA(I),U,2)
 ;
 D ERRCHK^DSIFPAYR Q:DSIFERR
 ; If contract number is entered or exists and payment is not prompt pay, contract number must be null/deleted, otherwise screen contract number - DSIF*3.2*2
 ; If prompt pay exists, it cannot be edited
 S FBPROMP=$P(FBDIAG,U,12) I $G(FBNEWP)=0  D  Q:DSIFERR
 . I $P($G(^FBAAC(DFN,1,FBV,1,FBSD,1,FBCNT,2)),U,2)=1,FBPROMP="" S FBOUT="-1^Prompt pay cannot be edited in payment",DSIFERR=1 Q
 . I FBPROMP="",$G(DSFLDS(54))'="@" D  Q:DSIFERR
 . . I $G(DSFLDS(54))>0 S FBOUT="-1^Contract number cannot be entered for a non-contract payment",DSIFERR=1 Q
 . I FBPROMP="",$P($G(^FBAAC(DFN,1,FBV,1,FBSD,1,FBCNT,2)),U,2)="",$P($G(^FBAAC(DFN,1,FBV,1,FBSD,1,FBCNT,3)),U,8)>0 S FBOUT="-1^When editing this payment a Contract number exists for a non-contract payment, it must be deleted",DSIFERR=1 Q
 I $G(DSFLDS(54))>0!($G(DSFLDS(54))="@") D CONTRACT^DSIFPAYR Q:DSIFERR
 N I S CNT=1 F I=1:4:$L(FBADJ,U) S:$P(FBADJ,U,I)'="" FBADJ(CNT)=$P(FBADJ,U,I,I+2),CNT=CNT+1
 S (FBI,FBHIGH,FBADJA,FBTAS)=0,FBMSR="" F  S FBI=$O(FBADJ(FBI)) Q:'FBI  S FBADJA=$P(FBADJ(FBI),U,3),FBTAS=FBTAS+FBADJA I $FN(FBADJA,"-")>$G(FBHIGH) S FBMSR=FBI,FBHIGH=$FN(FBADJA,"-")
 I +FBTAS=0 S NOADJ=1
 I $P(FBSERV,U,2)'=$P(FBSERV,U,3) S MFLAG=0 I $P(FBSERV,U,2)-$P(FBSERV,U,3)'=+FBTAS S FBOUT="-1^Paid amount vs claimed amount not adjusted properly" Q
 ; Modifier check
 I $P(FBMOD,U)'="" D MODCHK Q:+FBOUT<0
 I $G(FBPROMP)'="",FBPROMP'=1 S FBOUT="-1^Invalid entry for contracted services" Q
 ; Add Patient
 I '$D(^FBAAC(DFN,0)) S FBNPT=1 K DD,DO S (X,DINUM)=DFN,DIC(0)="L",DLAYGO=162,DIC="^FBAAC(" D FILE^DICN K DLAYGO,DIC,DINUM,DD,DO,DA
 I $P(FBID,U,4)'="",'$D(^FBAAA(DFN,1,$P(FBID,U,4),0)) S FBOUT="-1^Authorization is not valid" Q
 ; Add Vendor
 N FDA,IENROOT,MSG I '$D(^FBAAC(DFN,1,FBV)) D  Q:DSIFERR  ;added error check in DSIF*3.2*8
 . S FDA(162.01,"+1"_","_DFN_",",.01)=FBV,IENROOT(1)=FBV
 . D UPDATE^DIE("","FDA","IENROOT","MSG") I $D(MSG) S FBOUT="-1^Vendor already exists",DSIFERR=1
 . I '$D(IENROOT(1)) S FBOUT="-1^Vendor not added",DSIFERR=1
 S:FBSD="" FBNSDT=1 I FBSD,'$D(^FBAAC(DFN,1,FBV,1,FBSD)) S FBNSDT=1
 N FDA,IENROOT,MSG I FBNSDT D  Q:DSIFERR   ;added error check in DSIF*3.2*8
 . S FDA(162.02,"+1,"_FBV_","_DFN_",",.01)=FBAADT,FDA(162.02,"+1,"_FBV_","_DFN_",",3)=$P(FBID,U,4),FDA(162.02,"+1,"_FBV_","_DFN_",",1.5)=$P(FBID,U,3),IENROOT=""
 . D UPDATE^DIE("U","FDA","IENROOT","MSG") I $D(MSG) S FBOUT="-1^Service date exists",DSIFERR=1 Q
 I $D(IENROOT(1)) S FBSD=IENROOT(1)
 I FBSD="" S FBOUT="-1^Error in setting date of service IEN" Q  ;added error check in DSIF*3.2*8
 N IENROOT,MSG,FBFEEP S FBFEEP=$G(^FBAAC(DFN,1,FBV,1,FBSD,0)) D
 . I $P(FBFEEP,U,3)'=$P(FBID,U,2)!($P(FBFEEP,U,4)'=$P(FBID,U,3)) D
 . . S FDB(162.02,FBSD_","_FBV_","_DFN_",",1.5)=$P(FBID,U,3),FDB(162.02,FBSD_","_FBV_","_DFN_",",3)=$P(FBID,U,4)
 . . D FILE^DIE("U","FDB","MSG")
 I $D(MSG) S FBOUT="-1^Problems saving fee program or authorization" Q
 I FBNSDT=0,FBCNT'<1 Q:'$D(^FBAAC(DFN,1,FBV,1,FBSD,1,FBCNT))  D
 . S Y=FBCNT,Y(0)=^FBAAC(DFN,1,FBV,1,FBSD,1,FBCNT,0),(FBSV,FBAACPI,FBCNT)=+Y,BAT=$P(FBSERV,U,5),FBDUZ=$P(Y(0),U,7),(FBAACP,FBAACP(0))=$P(Y,U,2),K=$P(FBSERV,U,2)
 . S FB1725=$S($P(Y(0),U,13)["FB583":+$P($G(^FB583(+$P(Y(0),U,13),0)),U,28),1:0)
 I $G(FBDUZ)="" S FBDUZ=0
 I FBDUZ,FBDUZ'=DUZ&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) S FBOUT="-1^Only original clerk or supervisor can edit this payment." Q
 S $P(FBDIAG,U,12)=$S($P(FBDIAG,U,12)="":$P(FBSERV,U,2),$P(FBDIAG,U,12)>$P(FBSERV,U,2):$P(FBSERV,U,2),1:$P(FBDIAG,U,12))
 ; Add CPT
 S:$G(FBCNT)="" NEWSERV=1,FBCNT=0 I '$D(^FBAAC(DFN,1,FBV,1,FBSD,1,FBCNT,0)) S NEWSERV=1,FBCNT=""
 I $G(FBCNT)="" K CPTIENS,CPTROOT I NEWSERV D
 . S CPTIENS="+1,"_FBSD_","_FBV_","_DFN_","
 . S FDC(162.03,CPTIENS,.01)=$P(FBSERV,U),FDC(162.03,CPTIENS,1)=$P(FBSERV,U,2),FDC(162.03,CPTIENS,23)=$P(FBID,U,3)
 . S FDC(162.03,CPTIENS,6)=DUZ,FDC(162.03,CPTIENS,8)=$P(FBSERV,U,6),FDC(162.03,CPTIENS,13)=FBAAID
 . S FDC(162.03,CPTIENS,15)=$P(FBSERV,U,9),FDC(162.03,CPTIENS,16)=$P(FBSERV,U,10),FDC(162.03,CPTIENS,17)=$P(FBSERV,U,10)
 . S FDC(162.03,CPTIENS,18)=FBAAPTC,FDC(162.03,CPTIENS,33)=$P(FBDIAG,U,5),FDC(162.03,CPTIENS,42)=$P(FBDIAG,U,6)
 . I $G(DSIFCNT) S FDC(162.03,CPTIENS,54)=$G(DSIFCNT)  ;Allow deletion if passes verification
 . S FDC(162.03,CPTIENS,47)=$P(FBDIAG,U,7),CPTROOT=""
 . D UPDATE^DIE("S","FDC","CPTROOT","MSG") S FBCNT=$G(CPTROOT(1))
 I NEWSERV,$D(MSG) S FBOUT="-1^Service date file failure 1" Q
 I FBCNT="",$D(IENROOT(1)) S FBCNT=IENROOT(1)
 I NEWSERV,FBCNT="" S FBOUT="-1^Service date failure 2" Q
 I $D(FBMODA) D REPMOD^FBAAUTL4(DFN,FBV,FBSD,FBCNT)
 I FBREM]"" N Z,FBFLAG S FBFLAG=0 F Z=1:1:$L(FBREM,U) D  Q:FBFLAG
 . I '$D(^FB(161.93,$P(FBREM,U,Z))) S FBOUT="-1^Invalid remittance remark entry",FBFLAG=1 Q
 . S FBRRMK(Z)=$P(FBREM,U,Z)
 S FBRRMKL(0)=$$RRL^FBUTL4(.FBRRMK),FBFPPSC(0)=$P(FBDIAG,U,10),FBFPPSC=FBFPPSC(0),FBFPPSL(0)=$P(FBDIAG,U,11),FBFPPSL=FBFPPSL(0)
 N DSIF,FILE,MSG S FBIENS=FBCNT_","_FBSD_","_FBV_","_DFN_",",FILE=162.03
 S DSIF(FILE,FBIENS,.01)=$P(FBSERV,U),DSIF(FILE,FBIENS,1)=$P(FBSERV,U,2),DSIF(FILE,FBIENS,2)=$P(FBSERV,U,3),DSIF(FILE,FBIENS,5)=$P(FBSERV,U,4),DSIF(FILE,FBIENS,7)=$P(FBSERV,U,5),DSIF(FILE,FBIENS,8)=$P(FBSERV,U,6)
 S DSIF(FILE,FBIENS,13)=FBAAID,DSIF(FILE,FBIENS,14)=$P(FBSERV,U,8),DSIF(FILE,FBIENS,15)=$P(FBSERV,U,9),DSIF(FILE,FBIENS,16)=$P(FBSERV,U,10),DSIF(FILE,FBIENS,17)=$P(FBSERV,U,11),DSIF(FILE,FBIENS,26)=$P(FBSERV,U,12)
 S DSIF(FILE,FBIENS,28)=+FBRET,DSIF(FILE,FBIENS,30)=DSIFPOS,DSIF(FILE,FBIENS,31)=$P(FBDIAG,U,3),DSIF(FILE,FBIENS,32)=$P(FBDIAG,U,4),DSIF(FILE,FBIENS,33)=$P(FBDIAG,U,5),DSIF(FILE,FBIENS,42)=$P(FBDIAG,U,6)
 S:$P(FBSERV,U,14)>14 DSIF(FILE,FBIENS,43)=$P(FBSERV,U,14)  ;Added Anesthesia Time - DSIF*3.2*1, edited DSIF*3.2*8 to >14
 S DSIF(FILE,FBIENS,45)=FBSCH1,DSIF(FILE,FBIENS,47)=$P(FBDIAG,U,7),DSIF(FILE,FBIENS,48)=$P(FBDIAG,U,8),DSIF(FILE,FBIENS,49)=$P(FBDIAG,U,9),DSIF(FILE,FBIENS,23)=$P(FBID,U,3),DSIF(FILE,FBIENS,34)=FBPROMP
 S DSIF(FILE,FBIENS,44)=$S($P(FBDIAG,U,13)'>0:"",1:$P(FBDIAG,U,13))  ;FEE SCH AMOUNT
 S:$P(FBSERV,U,13)'="" DSIF(FILE,FBIENS,27)=$P(FBSERV,U,13)  ;7078 or 583 Pointer 
 S DSIF(FILE,FBIENS,50)=$P(FBDIAG,U,10),DSIF(FILE,FBIENS,51)=$P(FBDIAG,U,11)
 I $D(FBSUS) S DSIF(FILE,FBIENS,3)=$P(FBSUS,U),DSIF(FILE,FBIENS,3.5)=$P(FBSUS,U,1),DSIF(FILE,FBIENS,4)=$P(FBSUS,U,2)
 I $G(DSIFCNT) S DSIF(FILE,FBIENS,54)=$G(DSIFCNT)  ;Allow deletion if passes verification DSIF*3.2*2
 F P1=58:1:69 I $G(DSFLDS(P1))]"" S DSIF(FILE,FBIENS,P1)=$G(DSFLDS(P1))  ;DSIF*3.2*2
 F P2=73,74,75,76,77,78,79 I $G(DSFLDS(P2))]"" S DSIF(FILE,FBIENS,P2)=$G(DSFLDS(P2))   ;added new fields DSIF*3.2*2
 L +^FBAAC(DFN,1,FBV,1,FBSD):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S FBFOUT="-1^Please try later, payment file in use, unable to lock" Q
 D FILE^DIE("SU","DSIF","MSG") L -^FBAAC(DFN,1,FBV,1,FBSD):DTIME
 I $D(MSG) S FBOUT="-1^File #162.03 save error" Q
 I $P($G(^FBAAA(DFN,1,AUTHIEN,0)),U,4)="" S $P(^FBAAA(DFN,1,AUTHIEN,0),U,4)=$G(FBV)  ;Set vendor in Authorization
 I FBSUSC]"" S FBSUSCA(1)=FBSUSC   ;Pass in WP field up to 200 char to an array  DSIF3.2*2
 I $G(FBSUSCA(1))]"",$P(FBSUS,U)>0 D WP^DIE(162.03,FBIENS,22,"","FBSUSCA","NMSG")
 I $G(NMSG)]"" S FBOUT="-1^"_$G(NMSG("DIERR",1,"TEXT",1))  ;Error message return if present for WP field
 I 'NOADJ D FILEADJ^DSIFPAY4(FBIENS,.FBADJ)
 D FILERR^FBAAFR(FBIENS,.FBRRMK)
 I FBNEWP S PMTCNT=0 D PMCNT^DSIFBAT7(.PMTCNT,$P(FBSERV,U,5)) S $P(^FBAA(161.7,$P(FBSERV,U,5),0),"^",11)=PMTCNT
 S FBOUT="1^"_DFN_";"_FBV_";"_FBSD_";"_FBCNT_"^Entry add/edited successfully"
 K FBID,FBSERV,FBDIAG,FBREM,FBMOD,FBADJ,FBSUS,FBSUSC,DSIFDATA  ;Clean up variables to quit  DSIF*3.2*2
 Q
MODCHK ;
 S FBMODL="",CNT=0 K FBMODA,ARY D MODA^ICPTMOD(+DSIFCPT,$P(FBID,U,2),.ARY) F CNT=1:1:$L(FBMOD,U) D  Q:+FBOUT<0
 . I $D(ARY("A",$P(FBMOD,U,CNT))) S FBMODA(CNT)=+$G(ARY("A",$P(FBMOD,U,CNT))) Q
 . I '$D(ARY("A",$P(FBMOD,U,CNT))) S FBMODV=$$MOD^ICPTMOD($P(FBMOD,U,CNT),,$P(FBID,U,2))
 . I FBMODV'["IEN",$P(FBMODV,U,7)=0 S FBOUT="-1^CPT modifier '"_$P(FBMOD,U,CNT)_"' is inactive on - "_$$FMTE^XLFDT($P(FBID,U,2),5) Q
 . I +FBMODV>1,($P(FBMODV,U,7)=1) S FBMODA(CNT)=+FBMODV Q
 . I +FBMODV<1,FBMODV["IEN" N X,FBIEN,MIEN S X=$TR($P(FBMODV,":",2),";",U) F FBIEN=1:1:($L(X,"^")-1) S MIEN=$TR($P(X,U,FBIEN)," ") D
 . . S FBMODV=$$MOD^ICPTMOD(MIEN,"I",$P(FBID,U,2))
 . . Q:+FBMODV<1  ;not found or local
 . . Q:$P(FBMODV,U,7)=0  ; mod is inactive
 . . S FBMODA(CNT)=+FBMODV Q
 . . I $D(FBMODA(CNT)) S FBOUT="-1^"_$P(FBMOD,U,CNT)_" has more than one valid IEN:"_+FBMODA(CNT)_" and "_+FBMODV K FBMODA(CNT) Q
 . I $G(FBMODA(CNT))="" S FBOUT="-1^Invalid CPT modifier '"_$P(FBMOD,U,CNT)_"', or modifier is inactive on - "_$$FMTE^XLFDT($P(FBID,U,2),5) Q
 Q
