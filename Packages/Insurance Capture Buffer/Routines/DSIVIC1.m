DSIVIC1 ;DSS/NR - Insurance card RPC's ;05/17/2006 11:19
 ;;2.2;INSURANCE CAPTURE BUFFER;**7**;May 8, 2009;Build 1
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;  2051     LIST^DIC
 ;  2053     FILE^DIE
 ;  2056     $$GET1^DIQ
 ;  5322     $$GET1^DSICXPR,GETWP^DSICXPR
 ;  10103    $$DT^XLFDT,$$FMADD^XLFDT,$$NOW^XLFDT
 ; 
 Q
REQALL(RESULT,DSIVHNDL,DSIVSDT,DSIVEDT,DSIVAYS,DSIVBUF) ;rpc DSIV ALL APPOINTMENTS
 S RESULT="-1^This call is no longer supported"
 Q
POLL(RESULT,DSIVHNDL,NUMS) ;rpc DSIV POLL APPOINTMENTS
 S RESULT="-1^This call is no longer supported"
 Q
CANCEL(RESULT,DSIVHNDL,FLAG) ;rpc DSIV CANCEL APPOINTMENT LIST
 S RESULT="-1^This call is no longer supported"
 Q
INS(DFN,DSIVVER,DSIVVERM,DSIVVERN,DSIVDT) ;Check insurance
 ; Return 1=Any of the following conditions are met
 ;        Field #.3192 COVERED BY INSURANCE=UNKNOWN
 ;        Field #.3191 COVERED BY INSURNACE=NO and no insurance not verified in DSIVVERN of days
 ;        For any .312 field 3 entry
 ;          IF Last verified more than DSIVVER days before today (or never verified)
 ;          OR  expiration date is < today
 ;        Field PATIENT (.01) in the DSIV MANUAL VERIFICATION FILE (19625.3) exists,
 ;          the patient is manually flagged for insurance verification.
 ; Return 0=Otherwise
 ; DSIVVER=# of days back to check for most insurances
 ; DSIVVERM=# of days back to check for DSIVMS list of insurances
 ; DSIVVERN=# of days back to check for No Insurance
 ; DSIVDT=date for comparison (appt date or current date)
 Q:'$G(DFN) 1 ;If DFN is not specified, then coverage is UNKNOWN=1
 S DSIVDT=$G(DSIVDT,DT)
 N COV,COVN S COV=$$GET1^DIQ(2,+DFN,.3192,"I") I COV="N" D  Q COVN
 .S COVN=$$GET1^DIQ(354,+DFN,60,"I") I 'COVN S COVN="1^NO INSURANCE COVERAGE^" Q
 .I COVN<DSIVVERN S COVN="1^NO INSURANCE COVERAGE^"_COVN Q
 .S COVN=0
 .Q
 Q:'(COV="Y") "1^MISSING COVERAGE FIELD"
 N DSIVR,I,DSIVFLG,DSIVINS,DSIVEXP,DSIVIC,DSIVMFLG
 D LIST^DIC(2.312,","_DFN_",","@;.01;1.03;3","I",,,,,,,"DSIVIC")
 S DSIVFLG="",DSIVEXP="",DSIVMFLG=""
 M DSIVINS=DSIVIC("DILIST","ID") K DSIVIC
 F I=1:1 Q:'$D(DSIVINS(I))  D  Q:DSIVFLG
 .I $G(DSIVINS(I,3)),$G(DSIVINS(I,3))<DSIVDT S DSIVEXP=1 Q  ;expired
 .I '$G(DSIVINS(I,1.03)) S DSIVFLG=1 Q  ;never verified
 .I $D(DSIVMS(+$G(DSIVINS(I,.01)))) S DSIVFLG=$S($G(DSIVINS(I,1.03))<DSIVVERM:1,1:0) Q  ;medicare
 .I $G(DSIVINS(I,1.03))<DSIVVER S DSIVFLG=1 Q  ;not verified within DSIVAYS
 .S DSIVFLG=0,DSIVMFLG=0
 .Q
 I DSIVFLG="",DSIVEXP Q "1^ALL INSURANCE(S) EXPIRED"
 I DSIVFLG="" Q "1^COVERED, BUT NO INSURANCE LISTED"
 I DSIVFLG Q "1^UPDATE VERIFY DATE"
 S DSIVMFLG=$O(^DSI(19625.3,"B",DFN,0))  ;If patient manually flagged, DSIVMFLG=IEN of file 19625.3.  DSIV*2.2*7S3 NCR 5.8.12 
 ;If patient does not require other verification but the manual flag is turned on, turn insurance flag on  DSIV*2.2*7S3 NCR 5.8.12
 I $G(DSIVMFLG) S DSIVFLG="1^MANUAL VERIFICATION" Q DSIVFLG
 Q +DSIVFLG
 ;
CKINS(RESULT,DFN,DSIVAYS) ;Adapt INS(DFN) extrinsic function as RPC: DSIV PATIENT INSURANCE CHECK
 ; DFN=Patient IEN
 ; DSIVAYS=# of days since insurance verified (optional)
 Q:'$G(DFN) 1 ;If DFN is not specified, then coverage is UNKNOWN=1
 N DSIVVER,DSIVVERM,DSIVVERN,DSIVMS S DSIVAYS=$G(DSIVAYS,182)
 D PARM(DSIVAYS,.DSIVVER,.DSIVVERM,.DSIVVERN,.DSIVMS) ;get verify params
 S RESULT=$$INS(DFN,DSIVVER,DSIVVERM,DSIVVERN)
 Q
REQONE(RESULT,DSIVLOC,DSIVSDT,DSIVEDT,DSIVAYS,DSIVSCRN,DSIVBUF,NUMS,MORE) ;rpc DSIV ONE LOC APPOINTMENTS
 ; DSIVLOC=file 44 IEN (reqd)  DSIVSDT=Start dt/tm (opt)
 ; DSIVEDT=End dt/tm (opt)     DSIVAYS=# of days since ins verified (opt)
 ; DSIVSCRN=screen out checked in/checked out appts (1=CHKIN 2=CHKOUT 0=no screen)
 ;          screening out checked in appts automatically screens out checked out appts!!
 ;          this is being defaulted right now to 2 (checked out won't be returned) 
 ; DSIVBUF=1 we remove pts from the return if they have a buffer entry
 ; NUMS=# of records to return (opt)
 ; MORE=if there are more than NUMS records, this flag will get the rest from ^XTMP (optional)
 ; the data will be followed with $END$ to denote the end of the list
 ; We only use ^XTMP if we have MORE records to send back
 ; RESULT=Global Array of all sched appts
 ;        ^-pieces 1-6 from DSIVSD GET SCHEDULED APPTS
 ;        ^-piece 7=1 if insurance check fails for any reason
 ;        ^-piece 8-9 [Opt] Returned if verified NO coverage
 ;     or RESULT(1)=-1^Error message
 ;
 N CNT,RESTMP,QUIT,DSIVVER,DSIVVERM,I,DSIVMS,X,DSIVVERN
 N DFN,DSIVI,DSIVICX,DSIVICQ,DSIINS
 S CNT=0,NUMS=$G(NUMS,99999),MORE=+$G(MORE)
 S RESULT=$NA(^TMP("DSIVIC",$J)) K @RESULT
 S RESTMP=$NA(^XTMP("DSIVIC"_$J)) ;2.17.06 KC get batches of data
 I MORE,$D(@RESTMP) D  S:'$O(@RESTMP@(0)) @RESULT@("~")="$END$" Q
 .S I=0,QUIT=0 F  S I=$O(@RESTMP@(I)) Q:'I!QUIT  D
 ..S CNT=CNT+1 I CNT>NUMS S QUIT=1 Q
 ..S @RESULT@(I)=$G(@RESTMP@(I)) K @RESTMP@(I)
 .Q
 D PARM(DSIVAYS,.DSIVVER,.DSIVVERM,.DSIVVERN,.DSIVMS) ;get verify params
 I $G(DSIVLOC) N DSIVIC,DSIVICD S DSIVICD(1)="C^"_DSIVLOC ;get appts for single loc
 E  S @RESULT@(1)="-1^Invalid Location" Q
 S DSIVSCRN=$G(DSIVSCRN) I DSIVSCRN S DSIVICD(2)=$S(DSIVSCRN=1:"FI^1",1:"FO^1")
 D @("APPL^DSICVT2(.DSIVIC,"_$G(DSIVSDT)_","_$G(DSIVEDT)_",.DSIVICD)")
 S DSIVICX=DSIVIC,DSIVICQ=$E(DSIVIC,1,$L(DSIVIC)-1)
 F DSIVI=1:1 S DSIVICX=$Q(@DSIVICX) Q:'(DSIVICX[DSIVICQ)  D
 .S X=@DSIVICX,DFN=+$P(X,U,4),X=$P(X,U,1,6) ;DSIV 2.0P2T4 ;DSIC1.5 added pcs to this api
 .S DSIINS=$$INS(DFN,DSIVVER,DSIVVERM,DSIVVERN) ;verify ins flag
 .I $G(DSIVBUF),$O(^IBA(355.33,"C",DFN,0)) Q  ;has buffer entry 8.17.07 KC
 .S CNT=CNT+1 I CNT'>NUMS S @RESULT@(DSIVI)=X_"^"_DSIINS Q
 .S @RESTMP@(DSIVI)=X_U_DSIINS
 .Q
 K @DSIVIC
 I CNT'>NUMS S @RESULT@("~")="$END$"
 I $D(@RESTMP) S @RESTMP@(0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1
 Q
PURGE(RESULT,DSIV) ;Purge old entries from file 19625 rpc DSIV PURGE AUDIT
 ; DSIV=Days to keep OR last date to purge
 ; RESULT=0 OR -1^Error message
 ; 
 I $G(DSIV)?1.7N S:$L(DSIV)<7 RESULT=0,DSIV=$$FMADD^XLFDT($$DT^XLFDT,-DSIV)
 E  S RESULT="-1^Invalid purge parameter" Q
 S DSIV=DSIV_".24" N DA,R,DSIVFDA,X S R=$NA(DSIVFDA(19625)),X=""
 F  S X=$O(^DSI(19625,"C",X))  Q:X>DSIV!'X  D  ;V2.2T10 use "C" xref, "AC" is being removed
 .S DA=0 F  S DA=$O(^DSI(19625,"C",X,DA)) Q:'DA  S @R@(DA_",",.01)="@"
 .Q
 D FILE^DIE(,"DSIVFDA")
 Q
PARM(DAYS,DSIVVER,DSIVVERM,DSIVVERN,DSIVMS) ;get days back params
 N DAYSM,DSIVD,DAYSN,X,I
 S DAYS=$G(DAYS,182),DSIVVER=$$FMADD^XLFDT(DT,-DAYS) ;day back
 S DAYSM=365 ;Default days back for listed (medicare type) insurances KC 1.23.07
 D GETWP^DSICXPR(.DSIVD,"SYS~DSIV VER DAYS BACK SPECIFIC~1")
 F I=1:1 Q:'$D(DSIVD(I))  S X=$G(DSIVD(I)) D
 .I X=+X,X>0 S DAYSM=X
 .I X["=",+X S DSIVMS(+X)="" ;list of special insurance IENs using DAYSM
 .Q
 S DSIVVERM=$$FMADD^XLFDT(DT,-DAYSM)
 S DAYSN=$$GET1^DSICXPR(,"SYS~DSIV VER NO INSURANCE",1) S:DAYSN<0 DAYSN=0
 S DSIVVERN=$$FMADD^XLFDT(DT,-DAYSN)
 Q
