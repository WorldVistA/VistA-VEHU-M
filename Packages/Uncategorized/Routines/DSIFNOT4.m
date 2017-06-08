DSIFNOT4 ;DSS/RED,AMC - RPC'S FOR 7078 AUTHORIZATION ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   287  $$HDR^FBAAUTL3,HDR^FBAAUTL3
 ;   315  EN2^PRCS58,EN3^PRCS58
 ;   832  EN1^PRCSUT31
 ;  2053  FILE^DIE,UPDATE^DIE,WP^DIE
 ;  2171 - $$STA^XUAF4
 ;  4436  $$CREATE^DGPTFEE
 ;  5090  $$SSN^FBAAUTL,SITEP^FBAAUTL
 ;  5274  File 442 access
 ;  5300  ^PRC(424,"AD")
 ;  5301  ^PRC(420)
 ;  5082  SITE^FBAACO 
 ;  5336  ^PRC(411,D0,0)
 ; 10000  NOW^%DTC
 ; 10008  ^DIE
 ; 10009  FILE^DICN
 ; 10061  4^VADPT,DEM^VADPT,KVAR^VADPT
 ;  5744  $$VCNTR^FBUTL7
 ; 10060  ^VA(200
 ; 
EN7078(AXY,REQ,OBNUM,AUTODT,DSCHDT,AUTH,ESTAMT,PATYP,PDISP,DCHTYP,POV,PSA,ACCR,PCRC,REFPROV,CNTIEN,AUTHSVC) ;RPC - DSIF INP ENTER 7078
 ;Input Parameters
 ;     REQ - Internal Number of Request (Required, Pointer to file 162.2)
 ;     OBNUM - Obligation Number (Required, complete with sequence number after the '.')
 ;     AUTODT - Authorized TO Date (Required, FM Date - Must be later than Authorized FROM date in file 162.2)
 ;     DSCHDT - Discharge Date (Optional, FM Date - Must not be earlier than AUTODT)
 ;     AUTH - Admitting Authority (Required, Pointer to file 43.4 VA ADMITTING REGULATION)
 ;     ESTAMT - Estimated cost to the Veteran, will be passed to IFCAP (Required, Numeric upto 2 decimals)
 ;     PATYP - Patient Type (Required, Set of Codes - 00 = Surgical; 10 = Medical; 86 = Psychiatry)
 ;     PDSIP - Reason for Pending Disposition (Optional, Required if AUTODT is null)
 ;             (Set of Codes: 1 = FOLLOW-UP/NOT STABLE, 2 = AWAITING DISCHARGE/TRANSFER)
 ;     DCHTYP - Discharge Type (Optional, Set of Codes)
 ;              1 - Transfer to VA
 ;              2 - Death With Autopsy
 ;              3 - Death Without Autopsy
 ;              4 - Discharge
 ;     POV - Purpose of Visit (Optional - Pointer to file 161.82 FEE BASIS PURPOSE OF VISIT)
 ;     PSA - Primary Service Area (Required - Pointer to file 4 INSITIUTION)
 ;     ACCR - Accident Related (Optional Yes/No - Y : Yes, N : No)
 ;     PCRC - Potential Cost Recovery Case (Required Yes/No - Y : Yes, N : No [DEFAULT = N])
 ;     REFPROV - Referring Provider (Optional - Pointer to file 200 NEW PERSON)
 ;     CNTIEN - Contract IEN (Optional)
 ;     AUTHSVC - Authorized Services (Word Processing - Default text from Site Parameter file 161.4 field #28) Array must start with (1)
 ;     
 ;
 ;Return Values
 ;     NNN = Internal Number for 7078, if no second piece all is well
 ;     NNN ^ Fee Basis Site Parameters are NOT set. Unable to authorize.
 ;     NNN ^ Unable to create PTF Record!
 ;     NNN ^ Unable to find/create Fee Basis Patient Record.
 ;     -1^1358^OBLIGATION NUMBER NOT FOUND
 ;                    CPA NUMBER INVALID
 ;                    Unauthorized control point user
 ;                    OBLIGATION HAS NOT BEEN ESTABLISHED
 ;                    TRANSACTION IS COMPLETE
 ;                    NO SERVICE BALANCE ESTABLISHED
 ;                    INSUFFICIENT REFERENCE BALANCE TO POST COMMITTED AMOUNT
 ;                    INSUFFICIENT SERVICE BALANCE TO POST ACTUAL AMOUNT
 ;                    INVALID DATE/TIME
 ;                    NEED AT LEAST AN ESTIMATE OR AN ACTUAL AMOUNT
 ;                    NEED THE REFERENCE FOR THIS OBLIGATION
 ;                    COULD NOT CREATE RECORD
 ;                    1358 not available for posting!
 ;     -1 ^ Invalid Input!
 ; (Logic from FBCH78)
 N DSI,DSIF,DSIF0,DSIF1,VEN,DFN,FRDT,DTOA,DXS,FIL,IENS,PTFIEN,DA,DQ,DR,DIE,DLAYGO,FBTYPE,FB78,FB7078,FBI,X,%,DINUM,FBSITE,FBINTID,PRCSS,PRCSX
 N FBNAME,FBSSN,FBSEQ
 K AXY
 S AUTODT=$G(AUTODT),DSCHDT=$G(DSCHDT),AUTH=$G(AUTH),ESTAMT=$G(ESTAMT),PDISP=$G(PDISP),PCRC=$G(PCRC),ACCR=$G(ACCR),REFPROV=$G(REFPROV) S:PCRC="" PCRC="N"
 I '$$SITEP^DSIFPAYR S AXY="-1^Fee Basis Site Parameters are NOT set!" Q
 S DSIF0=$G(^FBAA(162.2,+$G(REQ),0)) I DSIF0=""!($G(OBNUM)="")!'$G(PSA)!("YN"'[PCRC) S AXY="-1^Invalid Input!" Q
 S VEN=$P(DSIF0,U,2)_";FBAAV(",DFN=$P(DSIF0,U,4),FRDT=$P(DSIF0,U,5)\1,DTOA=$S($P(DSIF0,U,19):$P(DSIF0,U,19)\1,1:""),DXS=$P(DSIF0,U,6)
 I $G(CNTIEN)'="",'$$VCNTR^FBUTL7($P(VEN,";"),CNTIEN) S AXY="-1^Invalid contract for this vendor" Q  ;DSIF*3.2*2 Check for valid contract
 ; Check 1358 before filing 7078
 N FOBNUM D SITEP^FBAAUTL S FOBNUM=$$STA^XUAF4($P($G(FBSITE(1)),U,3))_"-"_$P(OBNUM,".")
 S FBINTID=DFN_";"_""_";"_$P(OBNUM,"."),FBSEQ=$P(OBNUM,".",2)
 S PRCS("X")=FOBNUM,PRCS("TYPE")="FB"
 D COMM,NOW^%DTC S X=FOBNUM_U_%_U_ESTAMT_U_U_FBSEQ_U_FBCOMM_U_FBINTID,PRCS("TYPE")="FB"
 D EN3^PRCS58 I Y=-1 S AXY="-1^1358 not available for posting!" Q
 S X=FOBNUM_U_%_U_ESTAMT_U_U_FBSEQ_U_FBCOMM_U_FBINTID,PRCS("TYPE")="FB"
 D EN2 I 'Y S AXY="-1^"_"1358^"_$P(Y,U) Q
 S FIL=162.4,IENS="+1,"
 S DSIF(FIL,IENS,.01)=OBNUM,DSIF(FIL,IENS,.5)=6,DSIF(FIL,IENS,9)="I",DSIF(FIL,IENS,10)=DT,DSIF(FIL,IENS,8)=DUZ
 S DSIF(FIL,IENS,1)=VEN,DSIF(FIL,IENS,2)=DFN,DSIF(FIL,IENS,3)=FRDT,DSIF(FIL,IENS,3.5)=DTOA,DSIF(FIL,IENS,4)=AUTODT
 S DSIF(FIL,IENS,4.5)=DSCHDT,DSIF(FIL,IENS,5)=AUTH,DSIF(FIL,IENS,6)=ESTAMT
 I REFPROV,$D(^VA(200,REFPROV,0)) S DSIF(FIL,IENS,15)=REFPROV
 D UPDATE^DIE(,"DSIF","AXY") S AXY=$G(AXY(1)),IENS=AXY_",",FB78=AXY_";FB7078(",FB7078=+AXY K DSIF
 S DSIF(162.2,REQ_",",16)=FB7078 D FILE^DIE(,"DSIF") K DSIF
 I $O(AUTHSVC(0)) D WP^DIE(FIL,AXY_",",7,,"AUTHSVC")
 I 'AUTODT S DSIF(162.4,IENS,12)=PDISP,DSIF(162.4,IENS,9)="I" D FILE^DIE(,"DSIF") K DSIF
 S PTFIEN=$$CREATE^DGPTFEE(DFN,DTOA,1) I PTFIEN<0 S AXY=AXY_"^Unable to create PTF Record!" Q
 S VEN=$P(VEN,";")
 I '$D(^FBAAA(DFN,0)) L +^FBAAA(DFN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S AXY="-1^Unable to lock file, try again later" Q
 I '$D(^FBAAA(DFN,0)) K DD,DO S (X,DINUM)=DFN,DIC="^FBAAA(",DIC(0)="LM",DLAYGO=161 D FILE^DICN L -^FBAAA(DFN) I Y<0 S AXY=Y_"^Unable to find/create Fee Basis Patient Record." Q
 S:'$D(^FBAAA(DFN,1,0)) ^(0)="^161.01D^^"
 K DE,DQ,DR,DIE,DLAYGO
 S IENS1="+1,"_DFN_",",FIL=161.01
 S DSIF(FIL,IENS1,.01)=FRDT,DSIF(FIL,IENS1,.02)=AUTODT,DSIF(FIL,IENS1,.06)=DCHTYP,DSIF(FIL,IENS1,101)=PSA,DSIF(FIL,IENS1,.07)=$G(POV)
 S DSIF(FIL,IENS1,.03)=6,DSIF(FIL,IENS1,100)=DUZ,DSIF(FIL,IENS1,1)="Y",DSIF(FIL,IENS1,.055)=FB78
 S DSIF(FIL,IENS1,.04)=VEN,DSIF(FIL,IENS1,.065)=PATYP,DSIF(FIL,IENS1,.095)=1,DSIF(FIL,IENS1,.08)=DXS
 S DSIF(FIL,IENS1,.096)=ACCR,DSIF(FIL,IENS1,.097)=PCRC,DSIF(FIL,IENS1,104)=REFPROV I $G(CNTIEN)'="" S DSIF(FIL,IENS1,105)=CNTIEN  ;DSIF*3.2*2
 D UPDATE^DIE(,"DSIF","DSIF1") S DSI=DSIF1(1)
 S FBTYPE=6
 I $D(^FB7078(FB7078,1,0)) S ^FBAAA(DFN,1,DSI,2,0)=^(0) F FBI=1:1 Q:'$D(^FB7078(FB7078,1,FBI,0))  I $D(^(0)) S ^FBAAA(DFN,1,DSI,2,FBI,0)=^(0)
 I AUTODT S DIE="^FB7078(",DA=FB7078,DR="9///^S X=""C"";12///^S X=""@""" D ^DIE K DIE,DA,X
 S FBINTID=DFN_";"_+AXY_";"_$P(OBNUM,".")
 ;INTERFACE ID = DFN_";"_INTERNAL ENTRY NUMBER OF 7078_";"_FBAAON  (OBLIGATION)_";" if CNH _FBMM (month of service)
 ;PRCSX=Sta-obl#^int. Date/time^est amt^act amt^reference^comments(up to 78 characters)^interface id^complete payment flag
 D COMM,NOW^%DTC S X=FOBNUM_U_%_U_ESTAMT_U_U_FBSEQ_U_FBCOMM_U_FBINTID,PRCS("TYPE")="FB"
 S PRCSX=X D EN2^PRCS58
 I 'Y S AXY="-1^"_AXY_"^1358^"_$P(Y,U)   ;Added the "-1" piece if Y is not=1, error returned from EN2^PRCS58
 S AXY=AXY_U_Y
 Q
CHK7078(AXY,REQ) ;RPC - DSIF INP VALID FOR 7078
 ;Input Parameters
 ;     REQ - Internal Number of Request (Required, Pointer to file 162.2)
 ;
 ;Return Values
 ;
 ;     -1 ^ Invalid Input!
 ;     -1 ^ A 7078 already exists, #NNNN.
 ;     -1 ^ Request not Complete.
 ;     -1 ^ Medical Entitlement not entered.
 ;     1 = Request OK
 ;
 I '$D(^FBAA(162.2,+$G(REQ),0)) S AXY="-1^Invalid Input!" Q
 N FB0 S FB0=^FBAA(162.2,REQ,0)
 I $P(FB0,U,17) S AXY="-1^A 7078 already exists, #"_$P(^FB7078($P(FB0,U,17),0),U)_"." Q
 I $P(FB0,U,15)'=3 S AXY="-1^Request not Complete." Q
 I $P(FB0,U,12)'="Y" S AXY="-1^Medical Entitlement not entered." Q
 S AXY=1
 Q
 ;
NEWOBL(FBOUT,FBVEN,FBADT,FBDFN,FBFCP,FBOBL,FBNIEN,FBEST) ; RPC: DSIF INP NEW 7078 OBLIGATION
 ;Used to setup a new obligation sequence number for a 7078
 ;  Input:  FBVEN - IEN of FB Vendor; FBADT -  FM date.time of admission;FBDFN - IEN of patient
 ;             FBFCP - Fund control point;FBOBL - Obligation number;FBNIEN - IEN of Notification (162.2)
 ;             FBEST - Estimated amount
 ;  Output: 1^7078 created (INT;EXT)  or -1^error message
 K FBOUT
 N FB7078,FB78,FBAA78,FBCHOB,FBCOMM,FBDA,FBSEQ,FBSTA,IENS1,FBFLAG,ZX,PRCSCAN,Y,FBDFA,PRCSCPAN,FBNAME,FBSSN,PRC,DFN
 S FBFLAG=0
 ;error checking
 N I F I="FBVEN","FBADT","FBDFN","FBFCP","FBOBL","FBNIEN","FBEST" I $G(@I)="" S FBOUT="-1^Required input data is missing, cannot continue",FBFLAG=1 Q
 Q:FBFLAG
 I '$D(^FBAA(162.2,FBNIEN)) S FBOUT="-1^There must be an existing Notification entered to setup an Obligation" Q
 ;  Do not change the message text for the next line of code.
 I $P(^FBAA(162.2,FBNIEN,0),"^",17)]"" S FBOUT="-1^There is an existing 7078 set up for this request. The number is "_$P(^FB7078($P(^FBAA(162.2,FBNIEN,0),"^",17),0),"^") Q
 I $P(^FBAA(162.2,FBNIEN,0),U,19)'=FBADT S FBOUT="-1^Admission date.time entered is invalid" Q
 S PRC("CP")=FBFCP
 S DFN=$P(^FBAA(162.2,FBNIEN,0),"^",4) D DEM^VADPT S FBNAME=VADM(1),FBSSN=+VADM(2) D KVAR^VADPT
 D SITE^FBAACO I $G(FBPOP) S FBOUT="-1^Invalid Fee basis site parameters" Q
 S PRC("SITE")=$$STA^XUAF4($P($G(FBSITE(1)),U,3))  ;Changed in DSIF*3.2*1 to use 
 I '$D(PRC("SITE"))!('$D(PRC("CP"))) S FBOUT="-1^IFCAP setup error, please advise DSS" Q
 ; New logic below to verify that the user has access to the facility and the FCP, and level of access is 1 or 2 (not 3 - Requestor)
 ;            DSIF*3.2*1 changed 1 to -1 in error report in file 420 check
 I '$D(^PRC(420,"A",DUZ,PRC("SITE"),+FBFCP,1)),('$D(^(2))) S FBOUT="-1^Invalid FCP/User combination entry or FCP level of access error" Q
 S PRCS("TYPE")="FB",PRC("X")=FBOBL
 S Y="",Y=$O(^PRC(442,"B",(PRC("SITE")_"-"_FBOBL),Y))_U_PRC("SITE")_"-"_FBOBL,Y(0)=$G(^PRC(442,+Y,0))
 S ZX=$S($D(^PRC(442,+Y,7)):+^(7),1:"") I ZX=""!(ZX=40)!(ZX=45)!(ZX=105) S FBOUT="-1^Obligation number not accessible." Q
 S ZX=$P($G(^PRC(442,+Y,23)),"^",7) S:ZX ZX=$P(^PRC(411,ZX,0),"^",1)
 S Y=Y_U_$P(Y(0),U,3,9),$P(Y,"^",10)=ZX,PRCSCPAN=$P(Y(0),"^",12)
 S (X,FBCHOB)=$P(Y,"^",2) K PRCS("A") S PRCS("TYPE")="FB" D EN1^PRCSUT31 G:Y="" NOGOOD S FB7078=$P(FBCHOB,"-",2)_"."_Y S FBSEQ=Y
 S FBOUT="1^"_FB7078_";"_FB7078_";"_FBSEQ Q
 Q
NOGOOD S FBOUT="-1^Unable to set new obligation sequence number" Q
 ;
FB() ;FEE BASIS calm code sheet record identifier for 994
 ;this extrinsic variable called from edit-template for code sheet
 S X="FEN"
 I $T(HDR^FBAAUTL3)]"" S X=$$HDR^FBAAUTL3
 Q X
 ;
EN2 ; Copied in part from PRCS58, to check if 1358 is valid to post amounts to
 ;check prior to POSTING A TRANSACTION Y=1 IF SUCCESSFUL, +Y=0 WHEN FAILED AND Y CONTAINS ERROR MESSAGE
 ;requires PRCSX=Sta-obl#^int. Date/time^est amt^act amt^reference^comments(up to 78 characters)^interface id^complete payment flag
 ;PRCS("TYPE")= "FB" or "COUNTER"
 I '$D(X) S Y="NO ENTRY PASSED" Q
 S PRCSX=X S:$P(PRCSX,U,3)="" $P(PRCSX,U,3)=$P(PRCSX,U,4)
 S PRCSON=$O(^PRC(442,"B",$P(PRCSX,U),0)) I PRCSON'>0 S Y="OBLIGATION NUMBER NOT FOUND" Q
 S PRCSCPAN=$P(^PRC(442,PRCSON,0),U,12) I 'PRCSCPAN S Y="CPA NUMBER INVALID" Q
 I '$D(^PRC(420,+PRCSX,1,+$P(^PRC(442,PRCSON,0),U,3),1,DUZ,0)) S Y="Unauthorized control point user" Q
 I '$D(^PRC(424,"AD",$P(PRCSX,U))) S Y="OBLIGATION HAS NOT BEEN ESTABLISHED" Q
 I $D(^PRC(442,PRCSON,7)) I $P(^(7),U)=40 S Y="TRANSACTION IS COMPLETE" Q     ;REMOVE "AC" X REF AND PRCSS VARIABLE
 I '$D(^PRC(442,PRCSON,8)) S Y="NO SERVICE BALANCE ESTABLISHED" Q
 ;FEE BASIS PAYMENT AMOUNT IS IFCAP'S DAILY RECORD ACTUAL AMOUNT
 ;FEE BASIS COMMITTED AMOUNT IS IFCAP'S DAILY RECORD ESTIMATED AMOUNT
 ;DAILY RECORD REFERENCE BALANCE = OBLIGATED $ MINUS ESTIMATED $ PLUS NET/ADJ $
 ;DAILY RECORD SERVICE BALANCE = OBLIGATED $ MINUS ACTUAL AMOUNTS
 I $P(PRCSX,U,3)>(+^PRC(442,PRCSON,8)-$P(^PRC(442,PRCSON,8),U,3)) S Y="INSUFFICIENT REFERENCE BALANCE TO POST COMMITTED AMOUNT" Q
 I $P(PRCSX,U,4)>$P(^PRC(442,PRCSON,8),U) S Y="INSUFFICIENT SERVICE BALANCE TO POST ACTUAL AMOUNT" Q
 S %DT="TX",X=$P(PRCSX,U,2) D ^%DT S:Y>0 $P(PRCSX,U,2)=Y I Y=-1 S Y="INVALID DATE/TIME" Q
 I $P(PRCSX,U,3)=""&($P(PRCSX,U,4)="") S Y="NEED AT LEAST AN ESTIMATE OR AN ACTUAL AMOUNT" Q
 I $P(PRCSX,U,5)="" S Y="NEED THE REFERENCE FOR THIS OBLIGATION" Q
 S Y=1 Q
 ;
COMM ; added fields to FBCOMM as per FBCH780
 N VAPA,VADM
 D 4^VADPT S FBNAME=$G(VADM(1)),FBSSN=$P($G(VADM(2)),U,2) K VAPA,VADM
 S FBCOMM=$S($D(FBNAME):FBNAME_" - "_FBSSN,1:"Estimated amount")
 Q
