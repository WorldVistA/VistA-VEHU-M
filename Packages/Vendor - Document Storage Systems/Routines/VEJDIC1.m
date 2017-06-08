VEJDIC1 ;DSS/LM - Insurance card RPC's ;12/14/2004 [3/12/05 9:55pm]
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;
 ; 
 Q
REQALL(RESULT,VEJDHNDL,VEJDSDT,VEJDEDT,VEJDAYS) ;;Request all appointments
 ; Implements VEJDIC ALL APPOINTMENTS remote procedure call
 ; VEJDHNDL=Handle (optional) - If omitted, RPC creates handle.
 ; VEJDSDT=Start date/time (optional)
 ; VEJDEDT=End date/time (optional)
 ; VEJDAYS=Number of days since insurance verified (optional)
 ; RESULT=Task number if request accepted, -1^Error message if otherwise
 ; 
 I '$L($G(VEJDHNDL)) D
 .S VEJDHNDL=DUZ_"~"_$J_"~"_$TR($J($R(10000),4)," ",0) ; Create handle
 .Q
 I $D(^XTMP("VEJDIC",VEJDHNDL)) D  Q
 .S RESULT="-1^Duplicate request^"_VEJDHNDL
 .Q
 I '$$TM^%ZTLOAD S RESULT="-1^TaskMan not running^"_VEJDHNDL Q
 S ^XTMP("VEJDIC",VEJDHNDL)=$$NOW^XLFDT
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTDESC="VEJDIC Appointment List "_VEJDHNDL
 S ZTDTH=$H,ZTIO="",ZTRTN="DQ^VEJDIC1"
 S ZTSAVE("VEJD*")="" D ^%ZTLOAD
 I $G(ZTSK)>0 S RESULT=ZTSK_U_VEJDHNDL Q
 S RESULT="-1^Attempt to schedule task failed^"_VEJDHNDL
 Q
POLL(RESULT,VEJDHNDL) ;;Poll for appointment list
 ; Implements VEJDIC POLL APPOINTMENTS remote procedure call
 ; VEJDHNDL=Handle (required)
 ; RESULT=Global Array of all scheduled appointments
 ;        ^-pieces 1-6 from VEJDSD GET SCHEDULED APPTS
 ;        ^-piece 7=1 iff insurance check fails for any reason
 ;        ^-piece 8-9 [Optional] Returned if verified NO coverage
 ;     or RESULT(1)=0^Results not ready or -1^Error message
 ;
 S RESULT=$NA(^TMP("VEJD",$J)) K @RESULT
 I '$L($G(VEJDHNDL)) S @RESULT@(1)="-1^Invalid Handle" Q
 N R S R=$NA(^XTMP("VEJDIC",VEJDHNDL)) ;Data
 I '$D(@R) S @RESULT@(1)="-1^List not found" Q
 I $P($G(@R),U,3) S @R@(1)="-1^Request was cancelled" Q
 I $P($G(@R),U,4) S @R@(1)="-1^Error in background^"_$P(@R,U,4,5) Q
 I '$P($G(@R),U,2) S @R@(1)="0^Results not ready" Q
 M @RESULT=@R S @RESULT="" K @R
 Q
CANCEL(RESULT,VEJDHNDL,FLAG) ;;Cancel previous REQALL
 ; Implements VEJDIC CANCEL APPOINTMENT LIST remote procedure call
 ; VEJDHNDL=Handle (required)
 ; FLAG=Unconditional cancel (optional)
 ; RESULT=0 (success) or -1^Message if failure
 ; 
 I '$L($G(VEJDHNDL)) S RESULT="-1^Invalid Handle^"_$G(VEJDHNDL) Q
 I '$D(^XTMP("VEJDIC",VEJDHNDL)) S RESULT="-1^List not found" Q
 I $G(FLAG) K ^XTMP("VEJDIC",VEJDHNDL) S RESULT=0 Q  ;Unconditional cancel
 I $P($G(^XTMP("VEJDIC",VEJDHNDL)),U,2) S RESULT="-1^Processing complete" Q
 L +^XTMP("VEJDIC",VEJDHNDL):2  E  S RESULT="-1^Lock failed" Q
 S $P(^XTMP("VEJDIC",VEJDHNDL),U,3)=1,RESULT=0 ;Cancel requested
 L -^XTMP("VEJDIC",VEJDHNDL)
 Q
DQ ;;Background task to complete request from REQALL
 ; Private - Not a remote procedure call
 Q:'$L($G(VEJDHNDL))  ;Required
 N VEJDIC,VEJDICR S VEJDICR=$NA(^XTMP("VEJDIC",VEJDHNDL))
 Q:$$DQCAN(VEJDICR)
 N I,VEJDI,VEJDICD,VEJDICL,VEJDICP
 D LIST^DIC(44,,"@",,,,,,"I $P(^(0),U,3)=""C""",,"VEJDIC") ;All Clinics
 Q:$$DQCAN(VEJDICR)
 F I=1:1 Q:'$D(VEJDIC("DILIST",2,I))  S VEJDICD(I)="C^"_VEJDIC("DILIST",2,I)
 Q:$$DQCAN(VEJDICR)
 I $D(VEJDICD) K VEJDIC D
 .D @("APPL^VEJDSD01(.VEJDIC,"_$G(VEJDSDT)_","_$G(VEJDEDT)_",.VEJDICD)")
 .Q
 I '$L($G(VEJDIC)) D  Q
 .S $P(@VEJDICR,U,4)="-1",$P(@VEJDICR,U,5)="APPL~VEJDSD01 call failed"
 .Q
 N DFN,VEJDI,VEJDT,VEJDICX,VEJDICQ,VEJDVER,X
 S VEJDAYS=$G(VEJDAYS,182),VEJDT=$P($$NOW^XLFDT,".")
 S VEJDVER=$$FMADD^XLFDT(VEJDT,-VEJDAYS) ;
 S VEJDICX=VEJDIC,VEJDICQ=$E(VEJDIC,1,$L(VEJDIC)-1)
 F VEJDI=1:1 S VEJDICX=$Q(@VEJDICX) Q:'(VEJDICX[VEJDICQ)  D
 .Q:$$DQCAN(VEJDICR)  S X=@VEJDICX,DFN=+$P(X,U,4)
 .S @VEJDICR@(VEJDI)=X_"^"_$$INS(DFN) ;Add insurance flag
 .Q
 K @VEJDIC Q:$$DQCAN(VEJDICR)
 S $P(@VEJDICR,U,2)=1 ;Complete 
 Q
INS(DFN) ;;Check insurance
 ; Private - Not a remote procedure call
 ; DFN=Patient IEN
 ; Return 1=Any of the following conditions are met
 ;        Field #.3192 COVERED BY INSURANCE=NO or UNKNOWN
 ;        For any .312 field 3 entry
 ;          IF Last verified more than VEJDAYS days before today (or never verified)
 ;          OR  expiration date is > today OR expiration date is NULL
 ; Return 0=Otherwise
 Q:'$G(DFN) 1 ;If DFN is not specified, then coverage is UNKNOWN=1
 N VEJDICOV S VEJDICOV=$$GET1^DIQ(2,+DFN,.3192,"I")
 Q:VEJDICOV="N" "1^NO INSURANCE COVERAGE^"_$$GET1^DIQ(354,+DFN,60,"I")
 Q:'(VEJDICOV="Y") 1 ;Insurance coverage neither "yes" nor "no"
 N VEJDIC D LIST^DIC(2.312,","_DFN_",","@;1.03;3","I",,,,,,,"VEJDIC")
 N I,VEJDFLG S VEJDFLG=0
 F I=1:1 Q:'$D(VEJDIC("DILIST","ID",I))  D  Q:VEJDFLG
 .I $G(VEJDIC("DILIST","ID",I,1.03))<VEJDVER S VEJDFLG=1 Q  ;not verified within VEJDAYS
 .I $$GET1^DSICXPR(,"SYS~VEJDIC VALIDATE EXPIRE DATE",1)<1 Q  ;don't check expire dt KC 9.29.05
 .I '($G(VEJDIC("DILIST","ID",I,3))>VEJDT) S VEJDFLG=1 Q  ;Expired or NULL
 .Q
 Q VEJDFLG
 ;
CKINS(RESULT,DFN,VEJDAYS) ;Adapt INS(DFN) extrinsic function as RPC
 ; DFN=Patient IEN
 ; VEJDAYS=Number of days since insurance verified (optional)
 Q:'$G(DFN) 1 ;If DFN is not specified, then coverage is UNKNOWN=1
 S VEJDAYS=$G(VEJDAYS,182) N VEJDT,VEJDVER
 S VEJDT=$P($$NOW^XLFDT,"."),VEJDVER=$$FMADD^XLFDT(VEJDT,-VEJDAYS)
 S RESULT=$$INS(DFN)
 Q
DQCAN(X) ;;From DQ - Check if cancelled and perform cleanup
 ; Private - Not a remote procedure call
 ; X=Root
 ; Return 1=Cancelled
 I $L($G(X)),$P(@X,U,3) L +@X:2 I  K @X L -@X Q 1
 Q 0
REQONE(RESULT,VEJDLOC,VEJDSDT,VEJDEDT,VEJDAYS,VEJDSCRN) ;;Request appointments for Locn.
 ; Implements VEJDIC ONE LOC APPOINTMENTS remote procedure call
 ; VEJDLOC=Location (required) Hospital Location IEN
 ; VEJDSDT=Start date/time (optional)
 ; VEJDEDT=End date/time (optional)
 ; VEJDAYS=Number of days since insurance verified (optional)
 ; VEJDSCRN=screen out checked in/checked out appts (1=CHKIN 2=CHKOUT 0=no screen)
 ;          screening out checked in appts automatically screens out checked out appts!!
 ;          this is being defaulted right now to 2 (checked out won't be returned) 
 ; RESULT=Global Array of all scheduled appointments
 ;        ^-pieces 1-6 from VEJDSD GET SCHEDULED APPTS
 ;        ^-piece 7=1 iff insurance check fails for any reason
 ;        ^-piece 8-9 [Optional] Returned if verified NO coverage
 ;     or RESULT(1)=-1^Error message
 ;
 S RESULT=$NA(^TMP("VEJDIC",$J)) K @RESULT
 I $G(VEJDLOC) N VEJDIC,VEJDICD S VEJDICD(1)="C^"_VEJDLOC
 E  S @RESULT@(1)="-1^Invalid Location" Q
 S VEJDSCRN=$G(VEJDSCRN) I VEJDSCRN S VEJDICD(2)=$S(VEJDSCRN=1:"FI^1",1:"FO^1")
 D @("APPL^VEJDSD01(.VEJDIC,"_$G(VEJDSDT)_","_$G(VEJDEDT)_",.VEJDICD)")
 N DFN,VEJDI,VEJDT,VEJDICX,VEJDICQ,VEJDVER,X K @RESULT@(1)
 S VEJDAYS=$G(VEJDAYS,182),VEJDT=$P($$NOW^XLFDT,".")
 S VEJDVER=$$FMADD^XLFDT(VEJDT,-VEJDAYS) ;
 S VEJDICX=VEJDIC,VEJDICQ=$E(VEJDIC,1,$L(VEJDIC)-1)
 F VEJDI=1:1 S VEJDICX=$Q(@VEJDICX) Q:'(VEJDICX[VEJDICQ)  D
 .S X=@VEJDICX,DFN=+$P(X,U,4)
 .S @RESULT@(VEJDI)=X_"^"_$$INS(DFN) ;Add insurance flag
 .Q
 K @VEJDIC
 Q
PURGE(RESULT,VEJD) ;;Purge old entries from file 19625
 ; Implements VEJDIC PURGE AUDIT remote procedure
 ; VEJD=Days to keep OR last date to purge
 ; RESULT=0 OR -1^Error message
 ; 
 I $G(VEJD)?1.7N S:$L(VEJD)<7 RESULT=0,VEJD=$$FMADD^XLFDT($$DT^XLFDT,-VEJD)
 E  S RESULT="-1^Invalid purge parameter" Q
 S VEJD=VEJD_".24" N DA,R,VEJDFDA,X S R=$NA(VEJDFDA(19625)),X=""
 F  S X=$O(^DSI(19625,"AC",X))  Q:X>VEJD!'X  D
 .S DA=0 F  S DA=$O(^DSI(19625,"AC",X,DA)) Q:'DA  S @R@(DA_",",.01)="@"
 .Q
 D FILE^DIE(,"VEJDFDA")
 Q
