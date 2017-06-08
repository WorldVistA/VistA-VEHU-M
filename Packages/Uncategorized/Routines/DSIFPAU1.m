DSIFPAU1 ;DSS/KSD,RED - Unauthorized Medical Payment Routine ;4/30/93  11:34
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;   1995  $$CPT^ICPTCOD                             1996  $$MOD^ICPTMOD,MODA^ICPTMOD (waiting approval)
 ;   3990  $$ICDDX^ICDCODE (7078)                    5098  $$FRDTINV^FBCSV1  (7078)
 ;   5086  FILERR^FBAAFR                             5085  FILEADJ^FBAAFA 
 ;   5090  GETNXI^FBAAUTL,SITE^FBAAUTL               5091  $$CPT^FBAAUTL4, $$MODL^FBAAUTL4  5082  Q^FBAACO
 ;   5099  LOCK^FBUCUTL                              5104  ^FB7078
 ;   5107  ^FBAAC,^FBAAC("AE",^FBAAC("AJ",FBAAC("C"
 ;   5272  ^FBAAA                                    5273  ^FBAA(161.7
 ;   5275  ^FBAA(161.4                               5278  ^FBAAV
 ;   5397  ^FB583                                    5398  ^FBAA(161.25
 ;   5442  SVCPR^FBAACO1                             5443  CALC^FBAACO3,SETO^FBAACO3
 ;   10009  FILE^DICN                               10103  $$FMTE^XLFDT
 ;   10013  ^DIK                                    10018  ^DIE
 ;   5087  ANES^FBAAFS                               5104  ^FB7078
 ;  10076  ^XUSEC("FBAASUPERVISOR"                   5745  FILERP^FBUTL8
 ;   5091  REPMOD^FBAAUTL4
 Q   ;No direct calls
 ;
6 ;    entry point for Ancillary payments for Unauth.
 S FBCHCO=1,DSIFOUT=1
EN583 ;driver for opt payments (entry point for uc)
 ;from EN583^FBAACO
 K FBAAOUT,FBPOP,IDIN
 N DSIFANES S DSIFANES=0  ;Anesthesia services flag added with DSIF*3.2*1
 D SITE I $G(FBPOP) S DSIFOUT="-1^Site parameters need to be setup properly, quitting",DSIFERR=1 Q
 D BT
 ;convert CPT code external to internal, if this is a Medical claim and/or the CPT/HCPCS code is present
 S DSIFCPT=$$CPT^ICPTCOD($P(DSIFIN,U,14),+$P(DSIFIN,U,12)) I +DSIFCPT=-1 S DSIFOUT=$S(DSIFCPT["NO SUCH":"-1^Invalid CPT Code "_$P(DSIFIN,U,14)_" entered",DSIFCPT["NO CODE":"-1^No CPT Code entered",1:DSIFCPT),DSIFERR=1 Q
 I $P(DSIFCPT,U,7)'=1 S DSIFOUT="-1^CPT code inactive on date of service: "_$$FMTE^XLFDT($P(DSIFIN,U,12)),DSIFERR=1 Q
 S FBAACPT=+DSIFCPT  ; IEN of file #81
 S IDIN=$P(MEDATA,U),FBSDI=+$P(IDIN,";")  ;Date of service multiple, usually null unless 2nd service provided same day
 S FBAACPI=$P(IDIN,";",2) I FBAACPI'="" S DSIFOUT="-1^Payment must be edited with payment edit API",DSIFERR=1 Q
 S FBX=$P(DSIFIN1,U,7),FBV=FBVEN,FBUNITS=$P(MEDATA,U,2),FBAADT=$P(DSIFIN,U,12),FBSCID=$P(DSIFIN1,U,5),FBAAID=$P(DSIFIN,U,6)
 I FBUNITS<1 S DSIFOUT="-1^Units paid must be greater than 0",DSIFERR=1 Q
 I $P(DSIFIN,U,10)'="Y" S $P(DSIFIN,U,10)="N"
 K FBAAOUT,FBDL,FBAAMM S FBINTOT=0
 I '$D(FB583) K FBDL,FBAR S (D0,DFN)=+DSIFIN K FBDMRA D GETAUTH
 I FTP']"" S DSIFOUT="-1^Patient auth not identified",DSIFERR=1 Q
 S FBFUSD=$P(MEDATA,U,6)   ;Fee Schedule (should be R, F or null)
 I "RF"'[FBFUSD S DSIFOUT="-1^Invalid Fee Schedule entered",DSIFERR=1 Q 
 S FBFSAMT=$P(MEDATA,U,7)  ;Amount paid
 S FBFACNT=$P(MEDATA,U,10)  ;Contract
 S FBAAMM1=$P(DSIFIN,"^",16) ;Contracted service
 ;Add verifcation of the POS (Place of Service)S IEN as part of DSIF*3.2*8
 S FBCHFA(30)=$P(MEDATA,U,4) I FBCHFA(30),'$D(^IBE(353.1,FBCHFA(30))) S FBOUT="-1^Place of Service is not valid!!",DSIFERR=1 Q  ;Place of service IEN
 I FBCHFA(30)="" S FBOUT="-1^Place of Service must be entered and valid!!",DSIFERR=1 Q
 I $G(FBCHCO) S FB7078=$S($G(FB7078):FB7078_";FB7078(",$D(FB583):FB583_";FB583(",1:"")
 D PAT,GETVEN1:$D(FB583) Q:DSIFERR
 D FILEV(DFN,FBV) Q:DSIFERR
 ;check for payments against all linked vendors "B2" batch types cross reference
 I FBAAIN="" S DSIFOUT="-1^Missing Invoice number",DSIFERR=1 Q
 I '$D(FBAADT)!('$D(FBAAVID)) D GETINDT Q:DSIFERR
 S FBCSID=$P(DSIFIN,"^",8)  ; set patient account number
 ; if U/C then get FPPS Claim ID 
 I $D(FB583) S FBFPPSC=$P($G(^FB583(FB583,5)),U)
 I FBFPPSC="" S FBFPPSC=$P(DSIFIN1,U,6),FBEDI=$P(DSIFIN,"^",9)
 D MM
 I $P(DSIFIN1,U,9)="" S DSIFOUT="-1^Primary diagnosis field is required",DSIFERR=1 Q
 S FBRET=$$ICDDX^ICDCODE($P(DSIFIN1,U,9),$P(DSIFIN,U,12)) D  Q:DSIFERR   ;Primary diagnosis
 . I $P(FBRET,U,2)["INVALID" S DSIFOUT="-1^ "_$P(DSIFIN1,U,9)_" is an invalid primary diagnosis, quitting",DSIFERR=1 Q
 . I $P(FBRET,"^",10)=0 S DSIFOUT="-1^Primary Diagnosis entered in inactive on "_$$FMTE^XLFDT($P(DSIFIN,U,12),5)_", quitting",DSIFERR=1 Q
SVDT K HOLDY
 I 'FBSDI D GETSVDT(DFN,FBV,FBASSOC,0,FBAADT) Q:DSIFERR
 D SETO^FBAACO3  ; Set FY year
 S FBZIP=$P(DSIFIN,"^",13)
 I FBZIP="" S DSIFOUT="-1^Site of Service Zipcode is a required entry!",DSIFERR=1 Q   ;DSIF 3.2
CPT ;K DSIFOUT
 D CPTM($G(FBAADT),$G(DFN)) Q:DSIFERR
 I $G(FBV)'="",$G(FBAADT)'="" D CHK42 I FBJ']"" G SVPR
CHKE ;determines what action to take on duplicate services entered
 I $P(DSIFIN,U,18) G SVPR
 S FBDEN=$P(DSIFIN,U,17)
SVPR K DSIFOUT
 ; Add a new variable for field #43, Anesthesia time to the line below ****
 I $$ANES^FBAAFS($$CPT^FBAAUTL4($G(FBAACPT))) S DSIFANES=1,FBTIME=$P(DSIFIN,U,11) I '$G(FBTIME) S DSIFOUT="-1^Time is required for Anesthesia",DSIFERR=1 Q
 ; ; Add checks for proper adjustments DSIF*3.2*8 if overpaying amount claimed
 S FBAMTPD=$P(MEDATA,U,7) I FBAMTPD>$P(DSIFIN,U,15),($P(DSIFIN,U,15)-$G(DSIFADJ)'=+FBAMTPD) S DSIFOUT="-1^Cannot pay more than amount claimed without proper adjustment value",DSIFERR=1 Q
 D FILE Q:DSIFERR
 ; reset batch totals
 S DSIFOUT=1_U_DSIFID
 K Z1,FBINTOT S Z1=$P(^FBAA(161.7,DSIFBT,0),"^",11)+1,FBINTOT=$P(^FBAA(161.7,DSIFBT,0),"^",9)+FBAMTPD,$P(^FBAA(161.7,DSIFBT,0),"^",11)=Z1,$P(^FBAA(161.7,DSIFBT,0),"^",9)=FBINTOT
 Q
 ;
SITE ;set up site variables
 D:'$D(FBSITE(0)) SITEP^DSIFPAY7 Q:$G(FBPOP)  I '$G(FBPROG) D
 .I $G(FBCHCO) S FBPROG="I ($P(^(0),""^"",3)=6!($P(^(0),""^"",3)=7))&($P(^(0),U,9)'[""FB583"")" Q
 .S FBPROG=$S($P(FBSITE(1),"^",6)="":"I $P(^(0),""^"",9)'[""FB583""",1:"I $P(^(0),""^"",3)=2,($P(^(0),""^"",9)'[""FB583"")")
 S:'$D(FBAAPTC) FBAAPTC="V"
 S FBAAMPI=$P($G(^FBAA(161.4,1,"FBNUM")),"^",3),FBAAMPI=$S(FBAAMPI]"":FBAAMPI,1:100)
 Q
 ;
BT ;select batch
 S DSIFBT=$P(DSIFIN,U,5) I $G(DSIFBT)="" S DSIFOUT="-1^No Batch selected",DSIFERR=1 Q
 I '$D(^FBAA(161.7,DSIFBT,0)) S DSIFOUT="-1^Invalid Batch number selected",DSIFERR=1 Q
 S Y(0)=$G(^FBAA(161.7,DSIFBT,0)),BTUSER=$P(Y(0),U,5)
 I +Y(0)="" S DSIFOUT="-1^Invalid Batch number selected",DSIFERR=1 Q
 I $G(^FBAA(161.7,DSIFBT,"ST"))'="O" S DSIFOUT="-1^Batch must have a status of Open",DSIFERR=1 Q
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ))&($G(BTUSER)'=DUZ) S DSIFOUT="-1^Must be the clerk who opened or supervisor",DSIFERR=1 Q
 I $P(Y(0),"^",11)>(FBAAMPI-1) S DSIFOUT="This Batch has the maximum number of Payments!",DSIFERR=1 Q
 S Z1=$P(Y(0),"^",11),Z2=$P(Y(0),"^",9),FB7078="",BO=$P(^FBAA(161.7,DSIFBT,0),"^",2)
 Q
PAT ;set up patient in patient file
 ;required input variable DFN
 I '$D(^FBAAC(DFN,0)) K DD,DO S (X,DINUM)=DFN,DIC(0)="L",DLAYGO=162,DIC="^FBAAC(" D FILE^DICN K DLAYGO,DIC,DINUM,DD,DO,DA
 Q
MM ;check for money management of entire invoice
 I FBAAPTC="R" S FBAAMM="" Q
 S FBAAMM=$P(DSIFIN,"^",16)  ;Contract services no interest
 Q
GETAUTH ;
 ; from GETAUTH^FBAAUTL1
 S CNT=0,FTP="" N FB
 I '$D(^FBAAA(DFN,1)) S DSIFOUT="-1^PATIENT HAS NO AUTHORIZATIONS ",DSIFERR=1 Q
 S FBAAID=$P(DSIFIN,"^",6),(FTP,X)=$O(^FBAAA(DFN,1,"B",FBAAID,""))
 S FB=$G(^FBAAA(DFN,1,X,0)),FBAABDT=$P(FB,"^"),FBAAEDT=$P(FB,"^",2),FBTYPE=$P(FB,"^",3),TA=$P(FB,"^",11),FBTT=$P(FB,"^",13),FBPOV=$P(FB,"^",7),FBPT=$P(FB,"^",18),FBPSA=$P(FB,"^",5),FBVEN=$P(FB,"^",4),FB7078=""
 I $P(FB,"^",9)[";FB7078(" S FB7078=+$P(FB,"^",9)
 I $P(FB,"^",9)[";FB583(" S FB583=+$P(FB,"^",9)
 S FBDMRA=$G(^FBAAA(DFN,1,X,"ADEL")) I FBDMRA']"" K FBDMRA
 S FBASSOC=X
 I FBAAID<FBAABDT S DSIFOUT="-1^Invoice date "_$$FMTE^XLFDT(FBAAID)_" is earlier than Patient's Authorization 'from date' "_$$FMTE^XLFDT(FBAABDT)_" !!",DSIFERR=1 Q
 I FBAAID>FBAAEDT S DSIFOUT="-1^Invoice date "_$$FMTE^XLFDT(FBAAID)_" is later than Patient's Authorization 'to date' "_$$FMTE^XLFDT(FBAAEDT)_" !!",DSIFERR=1 Q 
 I FB7078]"" S FBVEN=+$P($G(^FB7078(+FB7078,0)),U,2)
 Q
 ;
GETVEN1 ;
 ; from GETVEN1^FBAACO1
 I $D(FB583) S DA=FBVEN
 I $D(^FBAAV(DA,0)),$P($G(^("ADEL")),U)="Y" S DSIFOUT="Vendor has been flagged for Austin deletion!",DSIFERR=1 Q
 ;
GETVEN2 ;
 S FBV=DA,FBAR(DA)="" D CO4
 Q
 ;
FILEV(DFN,FBV) ;files vendor multiple in op payment file
 ; Cloned from FBAACO5
 ;required input variable DFN,FBV (vendor ien)
 I '$G(DFN)!('FBV) S DSIFERR=1 Q
 S:'$D(^FBAAC(DFN,1,0)) ^FBAAC(DFN,1,0)="^162.01P^0^0"
 I $D(^FBAAC(DFN,1,FBV)) Q  ;DSIF*3.2*1  (quit is the Vendor node exists)
 S DLAYGO=162,DIC="^FBAAC("_DFN_",1,",DIC(0)="LNM",DA(1)=DFN,X="`"_FBV D ^DIC K DIC,DLAYGO I Y<0 S DSIFOUT="You are missing proper FM permissions to add vendor #"_FBV_" to this record",DSIFERR=1 Q
 Q
 ;
GETINDT ;get invoice dates
 ;from FBAACO1
 ;input requires FBAABDT (authorization from date)
 I '$G(FBCNP) I FBAAID<FBAABDT S DSIFOUT="-1^Invoice date "_$$FMTE^XLFDT(FBAAID)_" is earlier than Patient's Authorization date "_$$FMTE^XLFDT(FBAABDT)_" !!",DSIFERR=1 Q
 Q
 ;from FBAACO5
GETSVDT(DFN,FBV,FBASSOC,FBA,X) ;set date of service multiple
  ;VALUE determined in IDIN
 ;required input DFN,FBV (vendor ien),FBASSOC (auth ptr,0 if not known)
 ;optional/required input X (dt) - X req if FBA=0 (do not ask)
 ;output FBSDI=ien of svc date mult,FBAADT=svc date
 I '$G(DFN)!('$G(FBV))!('$D(FBASSOC)) S DSIFOUT="-1^Required variables for GETSVDT are not set",DSIFERR=1 Q
 I $D(^FBAAC(DFN,1,FBV,1,0)),FBSDI<1 D DOS
 I '$D(^FBAAC(DFN,1,FBV,1,0)) D DOS Q:DSIFERR
 I 'FBSDI S DSIFOUT="-1^Date of service not created",DSIFERR=1 Q
 ;if date of service input transform called skip checks
 I $D(FBAADT),FBAADT>FBAAVID S DSIFOUT="-1^Date of Service "_$$FMTE^XLFDT(FBAADT)_" cannot be later than Invoice Date: "_$$FMTE^XLFDT(FBAAVID)_" !",DSIFERR=1 Q
 I $D(FBAABDT),$D(FBAAEDT),(FBAADT<FBAABDT)!(FBAADT>FBAAEDT) S DSIFOUT="-1^Date of Service "_$S(FBAADT<FBAABDT:"prior to ",1:"later than ")_"Authorization period.",DSIFERR=1 Q
 Q
 ;from FBAACO3
DEL ;delete date of service if no service provided entered
 I '$O(^FBAAC(DFN,1,FBV,1,FBSDI,1,0)) D
 .S DIK="^FBAAC(DFN,1,FBV,1,",DA(2)=DFN,DA(1)=FBV,DA=FBSDI D ^DIK S DSIFOUT="-1^Incomplete payment entry deleted."
 K DIK,DA
 Q
 ;
CPTM(FBAADT,DFN) ;
 ; Cloned from FBAALU   FBMODL=external modifiers   FBMODLE=internal modifiers
 K FBMODA N FBI,FBMOD,FBMODX
 I $G(FBAACPT)="" S DSIFOUT="-1^No CPT code entered, required",DSIFERR=1 Q
 S FBMODL=DSIFMOD I FBMODL["^" S FBMODL=$TR(FBMODL,"^",",")  ;Set modifiers and make sure they are "," delimited
 I $G(FBAACPT)>0,$G(FBMODL)]"" F FBI=1:1 S FBMOD=$P(FBMODL,",",FBI) Q:FBMOD=""!(DSIFERR)  D MODCHK Q:DSIFERR   ;DSIF*3.2*2 (validate modifiers)
 Q
 ;
FILE ;from Routine FBAACO2  ;files sp multiple entry to 162.03
 K DR,FDC,MSG S TP="" I $G(FBDEN) S FBAMTPD=0
 ; quit if date of service and CPT exists and flag for same service on date is now set
 I '$D(^FBAAC(DFN,1,FBV,1,FBSDI)) S DSIFOUT="-1^Date of service IEN does not exist "_$G(FBSDI),DSIFERR=1 Q
 I $D(^FBAAC(DFN,1,FBV,1,FBSDI,1,"B",FBAACPT,0)),'$P(DSIFIN,U,18) S DSIFOUT="-1^The CPT code provided exists on that date of service!",DSIFERR=1 Q
 I $G(FBAAIN)="" S DSIFERR="-1^Invoice number is missing, required field",DSIFERR=1 Q
 N ERROR,CPTIENS,FDC,CPTROOT I $G(FBSDI)="" S DSIFOUT="-1^Missing date of service IEN",DSIFERR=1 Q
 S CPTIENS="+1"_","_FBSDI_","_FBV_","_DFN_",",ERROR=""
 S FDC(162.03,CPTIENS,.01)=FBAACPT,FDC(162.03,CPTIENS,1)=$P(DSIFIN,U,15),FDC(162.03,CPTIENS,2)=$G(FBAMTPD),FDC(162.03,CPTIENS,3)=$S($P(DSIFIN,U,15)-$P(MEDATA,U,7)>0:$P(DSIFIN,U,15)-$P(MEDATA,U,7),1:"0")
 I FBAMTPD<$P(DSIFIN,U,15),$P(MEDATA,U,8) S DSIFOUT="-1^Suspended amount code error",DSIFERR=1 Q
 I FBAMTPD<$P(DSIFIN,U,15) S FDC(162.03,CPTIENS,3)=$P(DSIFIN,U,15)-FBAMTPD,FDC(162.03,CPTIENS,3.5)=DT,FDC(162.03,CPTIENS,5)=$P(MEDATA,U,8)  ;Amount suspended
 S FDC(162.03,CPTIENS,4)=$P(MEDATA,U,8),FDC(162.03,CPTIENS,6)=DUZ,FDC(162.03,CPTIENS,7)=DSIFBT
 S FDC(162.03,CPTIENS,8)=$G(BO),FDC(162.03,CPTIENS,13)=$G(FBAAID),FDC(162.03,CPTIENS,14)=$G(FBAAIN)
 S FDC(162.03,CPTIENS,15)=$G(FBPT),FDC(162.03,CPTIENS,16)=$G(FBPOV),FDC(162.03,CPTIENS,17)=$G(FBTT)
 S FDC(162.03,CPTIENS,18)=$G(FBAAPTC),FDC(162.03,CPTIENS,23)=$G(FBTYPE),FDC(162.03,CPTIENS,26)=$G(FBPSA),FDC(162.03,CPTIENS,32)=$P(DSIFIN,U,10)
 S FDC(162.03,CPTIENS,27)=$G(FBV583),FDC(162.03,CPTIENS,28)=+$G(FBRET),FDC(162.03,CPTIENS,30)=$G(FBCHFA(30)),FDC(162.03,CPTIENS,33)=$G(FBAAVID)
 S:$G(FBAAMM1)=1 FDC(162.03,CPTIENS,34)=$G(FBAAMM1)
 S:$G(FBTIME)]"" FDC(162.03,CPTIENS,43)=FBTIME  ;Added with DSIF*3.2*1 Anesthesia Time field
 S FDC(162.03,CPTIENS,42)=$G(FBZIP),FDC(162.03,CPTIENS,44)=$G(FBFSAMT),FDC(162.03,CPTIENS,45)=$G(FBFUSD)
 S FDC(162.03,CPTIENS,47)=$G(FBUNITS),FDC(162.03,CPTIENS,48)=$P(MEDATA,U,9),FDC(162.03,CPTIENS,49)=$G(FBSCID),FDC(162.03,CPTIENS,50)=$G(FBFPPSC)
 S FDC(162.03,CPTIENS,51)=$G(FBX) I $D(SUSDESC),$P(MEDATA,U,8)=4 S FDC(162.03,CPTIENS,22)=$G(SUSDESC),CPTROOT=""
 S FDC(162.03,CPTIENS,54)=$P(MEDATA,U,10) ;DSIF*3.2*2
 F II=11:1:22  S FDC(162.03,CPTIENS,47+II)=$P(MEDATA,U,II)
 S FDC(162.03,CPTIENS,73)=$P(MEDATA,U,23)
 S FDC(162.03,CPTIENS,74)=$P(MEDATA,U,24)
 S FDC(162.03,CPTIENS,75)=$P(MEDATA,U,25)
 D UPDATE^DIE("S","FDC","CPTROOT",ERROR)
 I $D(ERROR("DIERR")) S DSIFOUT="-1^Service provided FM file failure 1"_$G(ERROR("DIERR",1,"TEXT",1)),DSIFERR=1 Q
 S FBAACPI=$G(CPTROOT(1)) I 'FBAACPI S DSIFOUT="-1^No entry created",DSIFERR=1 Q
 S DA(3)=DFN,DA(2)=FBV,DA(1)=FBSDI,DA=FBAACPI
 N DSIFIEN  ;set reverse ien for remittance remarks and adjustments
 S DSIFIEN=FBAACPI_","_FBSDI_","_FBV_","_DFN_","
 I $G(FBRRMK(1))'="" D FILERR^FBAAFR(DSIFIEN,.FBRRMK)
 I $G(FBADJ(1))'="" D FILEADJ^DSIFPAY4(DSIFIEN,.FBADJ)
 I $D(FBLIPROV(1)) D FILERP^FBUTL8(FBAAIN_",",.FBLIPROV) ;DSIF*3.2*2
 L -^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI)
 S DSIFID=DFN_";"_FBV_";"_FBSDI_";"_FBAACPI
 ; Save modifiers
 D REPMOD^FBAAUTL4(DFN,FBV,FBSDI,FBAACPI)
 K FBTST,FBDEN,FBAAMM1,DIE,DR,DA,FBX,FBMODA
 Q
 ;
CO4 ;
 S FBJ=0,FBDA=DA
CORRF I $D(^FBAA(161.25,"AF",FBDA)) F  S FBJ=$O(^FBAA(161.25,"AF",FBDA,FBJ)) Q:'FBJ  S:'$D(FBAR(FBJ)) FBA(FBJ)=""
 S FBJ=0 I $D(^FBAA(161.25,FBDA,0)) S FBJ=$P(^(0),"^",6) I $G(FBJ)]"",(FBJ'=FBDA) S:'$D(FBAR(FBJ)) FBA(FBJ)=""
 S FBDA=0,FBDA=$O(FBA(FBDA)) Q:'FBDA  S FBAR(FBDA)="" K FBA(FBDA) ;D CORRF
 Q
CHK41 ;Checks for valid invoice selected from linked vendors.
 K FBAACK1
 I $D(^FBAAC("C",X)) S FBJ=0 F  S FBJ=$O(FBAR(FBJ)) Q:'FBJ  D  K X(1) I $G(FBAACK1) S FBV=FBJ Q
 .I '$G(FBCNP) I $D(^FBAAC("C",X,DFN,FBJ)) S FBAACK1=1
 .I $G(FBCNP) S X(1)=$O(^FBAAC("C",X,0)) I $D(^FBAAC("C",X,X(1),FBJ)) S FBAACK1=1
 I '$G(FBAACK1) S DSIFOUT="-1^That number not valid for this vendor!",DSIFERR=1 Q
 Q
CHK42 ;Checks for duplicate payments on all linked vendors.
 N FBMODL
 S FBMODL=$$MODL^FBAAUTL4("FBMODA","I")
 I $D(^FBAAC("AE",DFN,FBV,FBAADT,FBAACPT_$S($G(FBMODL)]"":"-"_FBMODL,1:""))) S FBJ=FBV Q
 S FBJ=0 F  S FBJ=$O(FBAR(FBJ)) Q:$S('FBJ:1,$D(^FBAAC("AE",DFN,FBJ,FBAADT,FBAACPT_$S($G(FBMODL)]"":"-"_FBMODL,1:""))):1,1:0)
 Q
DOS ;    Set new service date if it doesn't exist
 N J F J=0:0 S J=$O(^FBAAC(DFN,1,FBV,1,J)) Q:'J  I +^FBAAC(DFN,1,FBV,1,J,0)=FBAADT S FBSDI=J Q
 I FBSDI,$D(^FBAAC(DFN,1,FBV,1,FBSDI)),$D(^FBAAC(DFN,1,FBV,1,FBSDI,1,"B",FBAACPT)),$P(DSIFIN,U,18)'=1 S DSIFOUT="-1^Multiple service on same date error",DSIFERR=1 Q
 I 'FBSDI K FDA,IENROOT,MSG D
 . I '$D(^FBAAC(DFN,1,FBV,0)) D ADDVEN Q:DSIFERR
 . K FDA,IENROOT,MSG
 . S FDA(162.02,"+1,"_FBV_","_DFN_",",.01)=FBAADT,FDA(162.02,"+1,"_FBV_","_DFN_",",3)=$G(FBASSOC)
 . S FDA(162.02,"+1,"_FBV_","_DFN_",",1.5)=FBTYPE
 . D UPDATE^DIE("","FDA","IENROOT","MSG") I $D(MSG) S DSIFOUT="-1^Service date exists",DSIFERR=1 Q
 . I '$D(IENROOT(1)) S DSIFOUT="-1^Unable to create new date of service global node",DSIFERR=1 Q
 . S FBSDI=$G(IENROOT(1))
 L -^FBAAC(DFN,1,FBV,1,FBSDI) K FDA
 Q
ADDVEN ;
 K FDA,IENROOT,MSG D
 . S FDA(162.01,"+1"_","_DFN_",",.01)=FBV,IENROOT(1)=FBV
 . D UPDATE^DIE("","FDA","IENROOT","MSG") I $D(MSG) S DSIFOUT="-1^Vendor already exists"
 . I '$D(IENROOT(1)) S DSIFOUT="-1^Vendor not added",DSIFERR=1
 Q
MODCHK ;
 S FBMODZ="" K FBMODZ,ARY D MODA^ICPTMOD(+FBAACPT,FBAADT,.ARY) D  Q:+DSIFOUT<0
 . I $D(ARY("A",FBMOD)) S FBMODA(FBI)=+$G(ARY("A",FBMOD)) Q
 . I '$D(ARY("A",FBMOD)) S FBMODV=$$MOD^ICPTMOD(FBMOD,,FBAADT)
 . I FBMODV'["IEN",$P(FBMODV,U,7)=0 S DSIFOUT="-1^CPT modifier '"_FBMOD_"' is inactive on - "_$$FMTE^XLFDT(FBAADT,5),DSIFERR=1 Q
 . I +FBMODV>1,($P(FBMODV,U,7)=1) S FBMODA(FBI)=+FBMODV Q
 . I +FBMODV<1,FBMODV["IEN" N X,FBIEN,MIEN S X=$TR($P(FBMODV,":",2),";",U) F FBIEN=1:1:($L(X,"^")-1) S MIEN=$TR($P(X,U,FBIEN)," ") D
 . . S FBMODV=$$MOD^ICPTMOD(MIEN,"I",FBAADT)
 . . Q:+FBMODV<1  ;not found or local
 . . Q:$P(FBMODV,U,7)=0  ; mod is inactive
 . . S FBMODA(FBI)=+FBMODV Q
 . . I $D(FBMODA(FBI)) S DSIFOUT="-1^"_FBMOD_" has more than one valid IEN:"_+FBMODA(CNT)_" and "_+FBMODV,DSIFERR=1 K FBMODA(CNT) Q
 . I $G(FBMODA(FBI))="" S DSIFOUT="-1^Invalid CPT modifier '"_FBMOD_"', or modifier is inactive on - "_$$FMTE^XLFDT(FBAADT,5),DSIFERR=1 Q
 Q
