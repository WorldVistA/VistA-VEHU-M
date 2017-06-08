DSIFNOT3 ;DSS/AMC - FEE BASIS INTERFACE RPC'S ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ; 10000  ^%DTC
 ;  2051  FIND^DIC
 ;  2053  FILE^DIE,UPDATE^DIE,WP^DIE
 ;  5410  ^FBAA(162.2
 ;
REG(AXY,DFN,DATE,VNDR,DTOA,PERS,IEN,ADMDX,ATPHY,ATPHPH) ;RPC - DSIF INP PATIENT REG
 ;Input Parameters
 ;     DFN - Patient File (#2) pointer (Required)
 ;     DATE - Date and Time (Required - FM format)
 ;     VNDR - Vendor (Required - Pointer to file 161.2 FEE BASIS VENDOR)
 ;     DTOA - Date & Time of Admission (Required - FM format)
 ;     PERS - Person who called (Optional - Free Text)
 ;     IEN - Internal Entry Number to file 162.2 FEE NOTIFICATION/REQUEST (Optional - Null = Add, Value = Edit)
 ;     ADMDX - Admitting Diagnosis (Optional - Free Text)
 ;     ATPHY - Attending Physician (Optional - Free Text)
 ;     ATPHPH - Attending Physician Phone Number (Optional - Free Text)
 ;     
 ;     
 ;Return Values
 ;     -1 ^ Invalid Input!
 ;     -1 ^ This notification has a status of complete.  Cannot edit.
 ;     -1 ^ This Authorization From Date exceeds the 72 hour notification period.
 ;     1^NNN^DATE.TIME = Internal number of newly created record, record updated
 ;          
 ;     
 N DSIF,DSIF1,NEW,ABC,ERRM,FIL,IENS,FBX,X,X1,FBVT,X2,Y
 I '$G(IEN)&('$G(DFN)!'$G(DATE)!'$G(VNDR)!'$G(DTOA)) S AXY="-1^Invalid Input!" Q
 S NEW='$G(IEN),FIL=162.2,PERS=$G(PERS)
 I 'NEW D EDIT Q
 S FBVT=DFN,DATE=+DATE  ;Added with DSIF*3.2*1 Miami reported that trailing zeros were being stored
 D CHKINOT(.DSIF1,DFN) I DSIF1<0 S AXY=DSIF1 K DSIF1 Q
 S IENS="+1,"
 D FIND^DIC(FIL,,.01,"P",DATE,,,"I $P(^(0),U,4)=DFN",,"ABC","ERRM")
 I +ABC("DILIST",0) S AXY="-1^Record Exists for Patient and Date!" Q
 S DSIF(FIL,IENS,.01)=DATE,DSIF(FIL,IENS,1)=VNDR,DSIF(FIL,IENS,3)=DFN,DSIF(FIL,IENS,3.5)=DTOA
 S DSIF(FIL,IENS,2)=PERS,DSIF(FIL,IENS,4)=DTOA
 ;72 hour time check
 S X1=DATE,X=DTOA
 S Y=$E(X1_"000",9,10)-$E(X_"000",9,10)*60+$E(X1_"00000",11,12)-$E(X_"00000",11,12),X2=X,X=$P(X,".",1)'=$P(X1,".",1) D ^%DTC:X S FBX=X*1440+Y
 I FBX>4320 S AXY="-1^This Authorization From Date exceeds the 72 hour notification period." Q
 S DSIF(FIL,IENS,5)=$G(ADMDX),DSIF(FIL,IENS,6)=$G(ATPHY),DSIF(FIL,IENS,6.5)=$G(ATPHPH)
 D UPDATE^DIE(,"DSIF","AXY")
 S AXY="1^"_+AXY(1)_U_$P($G(^FBAA(162.2,+AXY(1),0)),U) K AXY(1)
 Q
 ;
EDIT ;NOT WORKING YET
 S IENS=IEN_"," I '$D(^FBAA(162.2,IEN,0)) S AXY="-1^Invalid Input!" Q
 S:$G(ADMDX)]"" DSIF(FIL,IENS,5)=ADMDX
 S:$G(ATPHY)]"" DSIF(FIL,IENS,6)=ATPHY
 S:$G(ATPHPH)]"" DSIF(FIL,IENS,6.5)=ATPHPH
 S:PERS]"" DSIF(FIL,IENS,2)=PERS
 D FILE^DIE(,"DSIF")
 S AXY=IEN
 Q
CHKINOT(AXY,DFN) ;RPC - DSIF INP CHECK INCOMPLETE NOTE
 ;Input Parameters
 ;     DFN - Patient File Pointer (File #2, Required)
 ;     
 ;Return Value
 ;     -1 ^ Invalid Input!
 ;     -1 ^ There is an incomplete 7078 for this patient reference number is NNNNN (Reference Number of existing incomplete request)
 ;     1 = No existing incomplete requests
 ;     
 N FB7078,IEN
 I '$G(DFN) S AXY="-1^Invalid Input!" Q
 I $D(^FB7078("AC","I",DFN)) S IEN=$O(^FB7078("AC","I",DFN,0)),FB7078=$S($D(^FB7078(IEN,0)):$P(^(0),"^",1),1:"") D  Q
 .S AXY="-2^"_IEN_";"_FB7078
 I $G(AXY)="" S AXY=1
 Q
CHKOVLP(AXY,DFN,FBBEGDT,FBENDDT) ;RPC - DSIF INP CHECK OVERLAP DATES
 ;Input Parameters
 ;     DFN - Patient File Pointer (File #2, Required)
 ;     FBBEGDT - From Date to check (FM format, Required)
 ;     FBENDDT - To Date (FM format, Optional)
 ;     
 ;Return Values
 ;     -1^Invalid Input!
 ;     -1^FROM Date entered overlaps another request for this patient.
 ;     -1^TO Date entered overlaps another request for this patient.
 ;     1 = Date(s) are good
 ;     
 N FBAUT,FBOUT,Z,FBFLAG,FBLG
 S FBFLAG=$S($G(FBENDDT):1,1:2)
 I '$G(FBBEGDT)!'$G(DFN)!(12'[FBFLAG) S AXY="-1^Invalid Input!" Q
 ;COPIED FROM FBAAUTL2
 S (FBOUT,FBLG)=0 F Z=0:0 S Z=$O(^FBAAA(DFN,1,Z)) Q:Z'>0  I $D(^(Z,0)) S Z(0)=^(0) I $P(Z(0),"^",3)=6 S FBAUT($P(Z(0),"^"))=$P(Z(0),"^",2)
 F Z=0:0 S Z=$O(FBAUT(Z)) Q:Z'>0!(FBOUT)  D
 .I FBFLAG=2 D  Q
 ..I FBBEGDT'<Z,FBBEGDT'>FBAUT(Z) S FBOUT=1,AXY=$$ERM(1) Q
 .I FBBEGDT<Z,FBENDDT<Z S FBOUT=1 Q
 .I FBBEGDT<Z,FBENDDT'<Z S FBOUT=1,AXY=$$ERM(0) Q
 I '$G(AXY) S AXY=1
 Q
ERM(X) ;Error message
 Q "-1^"_$S(X:"FROM",1:"TO")_"Date entered overlaps another request for this patient."
 ;
ENTS(AXY,DFN,IEN,LEME,SUSP,SDESC) ;RPC - DSIF INP ENTITLEMENTS
 ;Input Parameters
 ;     DFN - Patient File Pointer (File #2, Required)
 ;     IEN - Internal Entry Number for File 162.2 FEE NOTIFICATION/REQUEST (Required)
 ;     LEME - Legal, Medical Indicators (Multi-Piece Legal Entitlement;Medical Entitlement 1=Yes, 0=No, Null=Not Applicable)
 ;            If Legal cannot be ""
 ;            If Legal is 0 Medical is forced to be 0 and Suspense code should be entered
 ;            If Legal is 1 Medical can be Null or 1
 ;     SUSP - Suspense Code (Pointer to file 161.27, Required if Legal or Medical is 0)
 ;     SDESC - Suspense Description (WP Array MUST START WITH 1. Only used if Suspense Code = 4 [Other]) 
 ;     
 ;Return Value
 ;     -1 ^ Invalid Input!
 ;     -1 ^ Selected Entry has a Status of COMPLETE.
 ;      1 = Entry updated
 ;      
 N FB0,DSIF,FIL,IENS
 I '$G(DFN)!'$G(IEN)!($P($G(LEME),";")="")!($TR($G(LEME),";")="") S AXY="-1^Invalid Input!" Q
 S FB0=$G(^FBAA(162.2,IEN,0)) S:$P(LEME,";")=0 $P(LEME,";",1,2)="0;0"
 I $P(FB0,U,4)'=DFN S AXY="-1^Invalid Input!" Q
 I $P(LEME,";",2)=0,'$G(SUSP) S AXY="-1^Invalid Input!" Q
 I $P(FB0,U,9)="Y",$P(FB0,U,12)="Y",$P(FB0,U,15)=3 S AXY="-1^Selected Entry has a Status of COMPLETE." Q
 S FIL=162.2,IENS=IEN_","
 I +LEME=1,$P(LEME,";",2)'=1 D  S AXY=1 Q
 .S DSIF(FIL,IENS,8)="Y",DSIF(FIL,IENS,9)=DT,DSIF(FIL,IENS,10)=DUZ
 .I $P(LEME,";",2)=0 S DSIF(FIL,IENS,100)=3,DSIF(FIL,IENS,11)="N"
 .I $P(LEME,";",2)="" S DSIF(FIL,IENS,100)=2
 .S DSIF(FIL,IENS,14)=SUSP
 .D FILE^DIE(,"DSIF")
 .I SUSP=4,$O(SDESC(0)) D WP^DIE(FIL,IENS,15,,"SDESC")  ; Field was improperly set to 100, changed to field 15 in DSIF*3.2*1
 I $P(LEME,";")=0,$P(LEME,";",2)=1 D  S AXY=1 Q
 .S DSIF(FIL,IENS,8)="N",DSIF(FIL,IENS,9)=DT,DSIF(FIL,IENS,11)="Y",DSIF(FIL,IENS,12)=DT,DSIF(FIL,IENS,10)=DUZ,DSIF(FIL,IENS,100)=3
 .S DSIF(FIL,IENS,14)=SUSP
 .D FILE^DIE(,"DSIF")
 ; Added line and modified code below as part of T27, code need to save values if not legal entitlement
 ;  As part of DSIF*3.2*1 field 100 below is set to "3" if legal;medical "0;0" (both set to no), was setting field 100 = 1
 I LEME="0;0" S DSIF(FIL,IENS,8)="N",DSIF(FIL,IENS,9)=DT,DSIF(FIL,IENS,11)="N",DSIF(FIL,IENS,100)=3 S:$G(SUSP) DSIF(FIL,IENS,14)=SUSP
 ;Q:LEME'="1;1"
 I LEME="1;1" S DSIF(FIL,IENS,8)="Y",DSIF(FIL,IENS,9)=DT,DSIF(FIL,IENS,11)="Y",DSIF(FIL,IENS,12)=DT,DSIF(FIL,IENS,100)=3
 D FILE^DIE(,"DSIF")
 I $G(SUSP)=4,$O(SDESC(0)) D WP^DIE(FIL,IENS,15,,"SDESC")  ; Field was set to 100, changed to 15 in (T27)
 S AXY=1
 Q
