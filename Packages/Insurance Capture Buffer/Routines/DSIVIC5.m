DSIVIC5 ;DSS/NCR - Insurance card RPC's ;04/25/2012
 ;;2.2;INSURANCE CAPTURE BUFFER;**7**;May 19, 2009;Build 1
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
RQONELOC(RESULT,DSIVLOC,DSIVSDT,DSIVEDT,DSIVAYS,DSIVSCRN,DSIVBUF,NUMS,MORE) ;rpc DSIV ONE LOC APPTS
 ; Code identical to REQONE^DSIVIC1 with check-in user, check-out user, and manual verification
 ; flag added to RESULT array of all scheduled appointments  Any changes may need to made to
 ; DSIVIC1 as well.  DSIV*2.2*7T1 NR
 ;
 ; DSIVLOC=file 44 IEN (reqd)  DSIVSDT=Start dt/tm (opt)
 ; DSIVEDT=End dt/tm (opt)     DSIVAYS=# of days since ins verified (opt)
 ; DSIVSCRN=screen out checked in/checked out appts (1=CHKIN 2=CHKOUT 0=no screen)
 ;          screening out checked in appts automatically screens out checked out appts!!
 ;          this is being defaulted right now to 2 (checked out won't be returned) 
 ; DSIVBUF=1 we remove pts from the return if they have a buffer entry
 ; NUMS=# of records to return (opt)
 ; MORE=if there are more than NUMS records, this flag will get the rest from ^XTMP (optional)
 ; The data will be followed with $END$ to denote the end of the list
 ; We only use ^XTMP if we have MORE records to send back
 ; RESULT=Global Array of all sched appts
 ;        ^-pieces 1-6 from VEJDSD GET SCHEDULED APPTS
 ;        ^-piece 7=1 if insurance check fails for any reason
 ;        ^-piece 8-9 [Opt] Returned if verified NO coverage
 ;        ^-piece 10 check-in user from VEJDSD GET SCHEDULED APPTS
 ;        ^-piece 11 check-out user from VEJDSD GET SCHEDULED APPTS
 ;        ^-piece 12= manual patient verification flag
 ;     or RESULT(1)=-1^Error message
 ;
 N CNT,RESTMP,QUIT,DSIVVER,DSIVVERM,I,DSIVMS,X,DSIVVERN
 N DFN,DSIVI,DSIVICX,DSIVICQ,DSIINS,DSICHKN,DSICHKO,DSIENTRY,DSIMFLG
 S CNT=0,NUMS=$G(NUMS,99999),MORE=+$G(MORE)
 S RESULT=$NA(^TMP("DSIVIC",$J)) K @RESULT
 S RESTMP=$NA(^XTMP("DSIVIC"_$J)) ;2.17.06 KC get batches of data
 I MORE,$D(@RESTMP) D  S:'$O(@RESTMP@(0)) @RESULT@("~")="$END$" Q
 .S I=0,QUIT=0 F  S I=$O(@RESTMP@(I)) Q:'I!QUIT  D
 ..S CNT=CNT+1 I CNT>NUMS S QUIT=1 Q
 ..S @RESULT@(I)=$G(@RESTMP@(I)) K @RESTMP@(I)
 .Q
 D PARM^DSIVIC1(DSIVAYS,.DSIVVER,.DSIVVERM,.DSIVVERN,.DSIVMS) ;get verify params
 I $G(DSIVLOC) N DSIVIC,DSIVICD S DSIVICD(1)="C^"_DSIVLOC ;get appts for single loc
 E  S @RESULT@(1)="-1^Invalid Location" Q
 S DSIVSCRN=$G(DSIVSCRN) I DSIVSCRN S DSIVICD(2)=$S(DSIVSCRN=1:"FI^1",1:"FO^1")
 D @("APPL^DSICVT2(.DSIVIC,"_$G(DSIVSDT)_","_$G(DSIVEDT)_",.DSIVICD)")
 S DSIVICX=DSIVIC,DSIVICQ=$E(DSIVIC,1,$L(DSIVIC)-1)
 F DSIVI=1:1 S DSIVICX=$Q(@DSIVICX) Q:'(DSIVICX[DSIVICQ)  D
 .;DSIV 2.0P2T4 ;DSIC1.5 added pcs to this api; DSIV 2.2P7S2 all pcs from this api are now used NCR 4.27.12
 .S X=@DSIVICX,DFN=+$P(X,U,4),DSICHKN=$P(X,U,7),DSICHKO=$P(X,U,8),X=$P(X,U,1,6)
 .S DSIINS=$$INS^DSIVIC1(DFN,DSIVVER,DSIVVERM,DSIVVERN) ;verify ins flag
 .S DSIMFLG=$O(^DSI(19625.3,"B",DFN,0))  ;If patient manually flagged, DSIMFLG=IEN of file 19625.3.  DSIV*2.2*7S2 NCR 4.26.12 
 .I $G(DSIVBUF),$O(^IBA(355.33,"C",DFN,0)) Q  ;filtered, has buffer entry, skip appt 8.17.07 KC
 .S DSIENTRY=X_U_DSIINS   ; DSIV*2.2P7T1  NCR 4.27.12
 .S $P(DSIENTRY,U,10)=DSICHKN,$P(DSIENTRY,U,11)=DSICHKO,$P(DSIENTRY,U,12)=DSIMFLG
 .S CNT=CNT+1 I CNT'>NUMS S @RESULT@(DSIVI)=DSIENTRY Q   ; DSIENTRY=X_"^"_DSIINS_"^"_DSICHKN_"^"_DSICHKO_"^"_DSIMFLG Q
 .S @RESTMP@(DSIVI)=DSIENTRY   ;PREVIOUSLY X_U_DSIINS
 .Q
 K @DSIVIC
 I CNT'>NUMS S @RESULT@("~")="$END$"
 I $D(@RESTMP) S @RESTMP@(0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1
 Q
