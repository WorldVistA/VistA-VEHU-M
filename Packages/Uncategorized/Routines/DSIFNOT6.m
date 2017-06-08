DSIFNOT6 ;DSS/AMC - FEE NOTIFICATION ENTER/EDIT ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ; 10009  FILE^DICN
 ;  2053  FILE^DIE,UPDATE^DIE
 ;  2056  GETS^DIQ                                     
 ; 10060  ^VA(200
 ;  5104  ^FB7078
 ;  2053  UPDATE^DIE
 ;  5744  $$EDCNTRA^FBUTL7
 ;  2056  GET1^DIQ
 ;  
 ;
 ;Cloned logic contained in FBCHREQ* routines and input template FBCH ENTER REQUEST to enter/edit entries in 162.2 via RPC Broker
 ;
 Q
EN(AXY,IEN,REQDT,DFN,VEN,WHO,ADMDT,AUTHDT,ADMDX,ATPHY,PHYPH,TOC,REFPROV) ;RPC - DSIF REQUEST ENTER/EDIT
 ;Input Parameters
 ;    IEN - Internal Entry Number to file 162.2 (Enter when false, Edit when true)
 ;    REQDT - Request Date/Time (Required on enter, optional on edit)
 ;    DFN - Patient IEN (Required on enter, optional on edit)
 ;    VEN - Vendor IEN (Required on enter, optional on edit)
 ;    WHO - Person Who Called (Optional - Free Text 3 to 30 Characters)
 ;    ADMDT - Admission Date/Time (Required on enter, optional on edit)
 ;    AUTHDT - Authorized From Date/Time (Optional - Default is ADMDT)
 ;    ADMDX - Admitting Diagnosis (Optional - Free Text 3 to 45 Characters)
 ;    ATPHY - Attending Physician (Optional - Free Text 3 to 30 Characters)
 ;    PHYPH - Attending Physicians Phone Number (Optional - Free Text 3 to 20 Characters)
 ;    TOC - Type of Contact (Optional - T : Telephone, P - Personal)
 ;    REFPROV - Referring Provider (added by patch DSIF*3.2*1)
 ;    
 ;Return Value
 ;    -1 ^ Invalid/Missing Parameter(s)!
 ;    -1 ^ Cannot edit status of Complete!
 ;    -1 ^ Admission overlaps another request for this patient!
 ;    -1 ^ Incomplete 7078 Ref# NNNN exists for this patient!
 ;    NNN - Internal Entry Number of created/edited request
 ;    
 N NEW,IENS,FIL,DSIF,DSIF1,FBBEGDT,FBPROG,FBFLAG,FBSW,FB7078,FBVT
 S FBSW=0
 S IEN=$G(IEN),REQDT=$G(REQDT),DFN=$G(DFN),VEN=$G(VEN),WHO=$G(WHO),ADMDT=$G(ADMDT),AUTHDT=$G(AUTHDT)
 S ADMDX=$G(ADMDX),ATPHY=$G(ATPHY),PHYPH=$G(PHYPH),TOC=$G(TOC),REFPROV=$G(REFPROV)
 I REFPROV]"",REFPROV'="@",'$D(^VA(200,REFPROV,0)) S AXY="-1^Invalid referring provider" Q  ; (added by patch DSIF*3.2*1)
 S NEW='IEN,IENS=$S(NEW:"+1",1:IEN)_",",FIL=162.2
 I NEW,('REQDT!'DFN!'VEN!'ADMDT) S AXY="-1^Invalid/Missing Parameter(s)!" Q
 G EDT:'NEW
 ;Copied from CHEK^FBCHREQ
 S FBVT=DFN I $D(^FB7078("AC","I",FBVT)) S FB7078=$O(^FB7078("AC","I",FBVT,0)),FB7078=$S($D(^FB7078(FB7078,0)):$P(^(0),"^",1),1:"") D  Q
 .S AXY="-1^Incomplete 7078 Ref# "_FB7078_" exists for this patient!"
 S:'AUTHDT AUTHDT=ADMDT
EDT ;
 S:REQDT DSIF(FIL,IENS,.01)=+REQDT  ;Changed in DSIF*3.2*1 to stop trailing zero's in time
 S:NEW DSIF(FIL,IENS,3)=DFN
 S:VEN DSIF(FIL,IENS,1)=VEN
 S:WHO]"" DSIF(FIL,IENS,2)=WHO
 S:ADMDT DSIF(FIL,IENS,3.5)=ADMDT
 S:AUTHDT DSIF(FIL,IENS,4)=AUTHDT
 S FBBEGDT=AUTHDT,FBPROG=6,FBFLAG=2 S AXY=$$EN^DSIFUTL(DFN) I AXY<0 S FBSW=1 G EDT1
 S:ADMDX]"" DSIF(FIL,IENS,5)=ADMDX
 S:ATPHY]"" DSIF(FIL,IENS,6)=ATPHY
 S:PHYPH]"" DSIF(FIL,IENS,6.5)=PHYPH
 S:REFPROV]"" DSIF(FIL,IENS,17)=REFPROV  ; (added by patch DSIF*3.2*1)
EDT1 ;
 I 'NEW D FILE^DIE(,"DSIF") S AXY=$S(AXY<0:AXY,1:IEN) Q
 S DSIF(FIL,IENS,7)=DUZ
 S DSIF(FIL,IENS,100)=$S(FBSW:3,1:1)
 I FBSW S DSIF(FIL,IENS,8)="N",DSIF(FIL,IENS,9)=DT,DSIF(FIL,IENS,10)=DUZ
 D UPDATE^DIE(,"DSIF","DSIF1") S AXY=$S(AXY<0:AXY,1:DSIF1(1))
 Q:AXY<0
ROC ;Copied from FBCHROC
 K DD,DO S DIC="^FBAA(161.5,",DIC(0)="L",DLAYGO=161.5,(X,DINUM)=AXY D FILE^DICN K DLAYGO S REQDT=$E(REQDT,1,12)
 S IENS=AXY_",",FIL=161.5 K DSIF
 S DSIF(FIL,IENS,1)=VEN,DSIF(FIL,IENS,2)=DFN,DSIF(FIL,IENS,3)=REQDT,DSIF(FIL,IENS,4)=AUTHDT
 S DSIF(FIL,IENS,12)=ATPHY,DSIF(FIL,IENS,13)=PHYPH,DSIF(FIL,IENS,14)=ADMDX
 S DSIF(FIL,IENS,19)=ADMDT,DSIF(FIL,IENS,5)=TOC
 D FILE^DIE(,"DSIF")
 Q
 ;
ED7078(AXY,FB7078,AUTHFRDT,AUTHTODT,DSCHDT,ADMAUTH,POV,PSA,ACCREL,PCR,PATYP,REFPROV,PENDISP,CNTIEN,AUTHSVC) ;RPC - DSIF INP EDIT 7078 
 ;                   added CONTRACT IEN with *DSIF*3.2*2
 ;Input Parameters
 ;    FB7078 - Internal Entry Number for 7078 (Required)
 ;    AUTHFRDT - Authorized From Date (Optional - FileMan Date)
 ;    AUTHTODT - Authorized To Date (Optional - FM Date)
 ;    DSCHDT - Discharge Date (Optional - FM Date)
 ;    ADMAUTH - Admitting Authority (Optional, Pointer to file 43.4 VA ADMITTING REGULATION)
 ;    POV - Purpose of Visit (Optional - Pointer to file 161.82 FEE BASIS PURPOSE OF VISIT)
 ;    PSA - Primary Service Area (Required - Pointer to file 4 INSITIUTION)
 ;    ACCREL - Accident Related (Optional Yes/No - Y : Yes, N : No)
 ;    PCR - Potential Cost Recovery Case (Optional Yes/No - Y : Yes, N : No [DEFAULT = N])
 ;    PATYP - Patient Type (Optional, Set of Codes - 00 = Surgical; 10 = Medical; 86 = Psychiatry)
 ;    REFPROV - Referring Provider (Optional - Pointer to file 200 NEW PERSON)
 ;    PENDISP - Pending Disposition ("" for none; '1' FOR FOLLOW-UP/NOT STABLE; '2' FOR AWAITING DISCHARGE/TRANSFER;)
 ;    CNTIEN - Contract IEN (Optional - Pointer to file 161.43 CONTRACT) "@" deletion is allowed;DSIF*3.2*2
 ;    AUTHSVC - Authorized Services (Word Processing - Default text from Site Parameter file 161.4 field #28), Array must start with (1)
 ;Return Values
 ;    -1 ^ Invalid 7078 Number!
 ;    -1 ^ Contract does not match Vendor ;DSIF*3.2*2 
 ;    -1 ^ Payment exists on file ;DSIF*3.2*2 
 ;    -1 ^ Invalid contract for this vendor ;DSIF*3.2*2 
 ;    -1 ^Contract cannot be edited
 ;    NNN - 7078 IEN for a successful update
 N XX,YY,DSIF,IENS,FIL,FIL2,IENS2,FBDFN,GET,DSIF2,NEXT,EXISTS,GET2,ERR,FBVEN,EXCNT,FBVEN,AUTH,DSIFCE ;DSIF*3.2*2 added new variables
 S REFPROV=$G(REFPROV),EXCNT=""
 I REFPROV]"",REFPROV'="@",'$D(^VA(200,REFPROV,0)) S AXY="-1^Invalid referring provider" Q  ; (added by patch DSIF*3.2*1)
 I '$D(^FB7078(+$G(FB7078),0)) S AXY="-1^Invalid 7078 Number!" Q
 D EDTCHK^DSIFUTL(.NEXT,FB7078) I +$G(NEXT)<1 S AXY="-1^Payment exists on file" Q  ;quit when payments are on file.
 S FIL=162.4,IENS=FB7078_",",FIL2=161.01,IENS2=FB7078_";FB7078("
 ; DSIF*3.2*2 Get vendor and Patient IEN
 D GETS^DIQ(FIL,IENS,"1;2","I","GET") S FBDFN=$G(GET(FIL,IENS,2,"I")),FBVEN=+$G(GET(FIL,IENS,1,"I"))
 I FBDFN<1 S AXY="-1^Missing patient IEN" Q
 I FBVEN<1 S AXY="-1^Missing Vendor IEN" Q
 S IENS2=$O(^FBAAA("AG",IENS2,FBDFN,0))_","_FBDFN_",",AUTH=+IENS2
 I $G(CNTIEN)>0,'$$VCNTR^FBUTL7($P(FBVEN,";"),CNTIEN) S AXY="-1^Invalid contract for this vendor" Q
 ;  DSIF*3.2*2 get existing contract number and if different see if it can be edited, also allow it to be deleted
 D GETS^DIQ(161.01,IENS2,105,"I","EXCNT") S EXCNT=$G(EXCNT(161.01,IENS2,105,"I")),DSIFCE=1
 I EXCNT S DSIFCE=$$EDCNTRA^FBUTL7(FBDFN,AUTH)
 I $G(DSIFCE)=0 S AXY="-1^Cannot edit Contract" Q
 I CNTIEN'="@",'DSIFCE,$G(CNTIEN)>0,+$G(EXCNT)'=$G(CNTIEN) S AXY="-1^"_$P(DSIFCE,U,2) Q
 I CNTIEN="@",'DSIFCE S AXY="-1^"_$P(DSIFCE,U,2) Q
 ; DSIF*3.2*1  allow date's to be deleted
 I $G(AUTHFRDT)]"" S DSIF(FIL,IENS,3)=AUTHFRDT S:IENS2 DSIF2(FIL2,IENS2,.01)=AUTHFRDT
 I $G(AUTHTODT)]"" S DSIF(FIL,IENS,4)=AUTHTODT S:IENS2 DSIF2(FIL2,IENS2,.02)=AUTHTODT
 I $G(DSCHDT)]"" S DSIF(FIL,IENS,4.5)=DSCHDT,DSIF(FIL,IENS,9)="C"  ;Status of closed once Discharge date is entered.
 I '$G(DSCHDT),$$GET1^DIQ(162.4,FB7078,4.5,"I")'="" S DSIF(FIL,IENS,9)="C"  ;Status of closed if a Discharge date exists.
 S:$G(ADMAUTH)]"" DSIF(FIL,IENS,5)=ADMAUTH
 S:$G(PENDISP) DSIF(FIL,IENS,12)=PENDISP
 I $G(PENDISP)="" S DSIF(FIL,IENS,12)="@"
 I $O(AUTHSVC(0)) D WP^DIE(FIL,IENS,7,,"AUTHSVC")
 D:IENS2
 .S:$G(POV) DSIF2(FIL2,IENS2,.07)=POV
 .S:$G(PSA) DSIF2(FIL2,IENS2,101)=PSA
 .S:$G(ACCREL)]"" DSIF2(FIL2,IENS2,.096)=ACCREL
 .S:$G(PCR)]"" DSIF2(FIL2,IENS2,.097)=PCR
 .S:$G(PATYP)]"" DSIF2(FIL2,IENS2,.065)=PATYP
 .S:$G(REFPROV)]"" DSIF2(FIL2,IENS2,104)=REFPROV
 .S:$G(CNTIEN)]"" DSIF2(FIL2,IENS2,105)=CNTIEN ;DSIF*3.2*2 add/edit contract to file. (Deleted if "@" passed in and allowed)
 D FILE^DIE(,"DSIF"),FILE^DIE(,"DSIF2")
 S AXY=FB7078
 Q
