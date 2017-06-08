DSIVICR2 ;DSS/KC - NIGHTLY EXCEPTION REPORT ;07/03/2012 2:21
 ;;2.2;INSURANCE CAPTURE BUFFER;**1,4,6,7**;May 19, 2009;Build 1
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;  2051    LIST^DIC
 ;  10009   FILE^DICN
 ;  2056    $$GET1^DIQ
 ;  5322    $$GET1^DSICXPR,GETWP^DSICXPR
 ;  10103   $$FMADD^XLFDT,$$FMTE^XLFDT,$$NOW^XLFDT
 Q
N1 ;called by DSIV NIGHTLY EXCEPTION RPT
 N DSIVSDT,DSIVEDT,DSIVICR,DSIVNITE,RDATE,NEWDT,LOOPDT,DSIVVER,DSIVVERM,DSIVVERN,DSIVAY,DSIVAYM,DSIVAYN,DSIVMS,ONEPAT,DSIVIEN
 S DSIVNITE=1 D PARMD(.DSIVMS) ;get params
 S DSIVEDT=$$FMADD^XLFDT(DT,-1)+.9,DSIVSDT=$O(^DSI(19625.1,"B",DSIVEDT),-1)
 I 'DSIVSDT S DSIVSDT=$$FMADD^XLFDT(DT,-1)
 E  S DSIVSDT=$$FMADD^XLFDT(DSIVSDT,1)
 I DSIVEDT<DSIVSDT Q
 ; loop to run report for each date (catch up if job not run every day)
 S RDATE(DSIVSDT)="",NEWDT=DSIVSDT D  ;Add days until we get to end date to get array of rpt dates
 .F  S NEWDT=$$FMADD^XLFDT(NEWDT,1) Q:NEWDT>DSIVEDT  S RDATE(NEWDT)="",DSIVSDT=NEWDT
 S LOOPDT=0 F  S LOOPDT=$O(RDATE(LOOPDT)) Q:'LOOPDT  S (DSIVSDT,DSIVEDT)=LOOPDT D N2
 Q
N2 ;get exception report for a single date
 S DSIVVER=$$FMADD^XLFDT(DSIVSDT,-DSIVAY) ;days back
 S DSIVVERM=$$FMADD^XLFDT(DSIVSDT,-DSIVAYM) ;days back medicare
 S DSIVVERN=$$FMADD^XLFDT(DSIVSDT,-DSIVAYN) ;days back no insurance
 S DSIVICR=$NA(^TMP("DSIVIC",$J))
 D DQ I $G(@DSIVICR@(1)) D ERR(3) G NEND
 S X=DSIVSDT,DIC("DR")=".02///E"
 K DO S DIC="^DSI(19625.1,",DIC(0)="FL",DLAYGO=19625.1 D FILE^DICN K DIC,DA,DLAYGO ;DSIV 2.2T12
 I Y<0 D ERR(2) G NEND
 S DSIVIEN=+Y
 I '$D(@DSIVICR) Q  ;no data for date
 ;^TMP("DSIVIC",2800,"CLINIC",3071102,3071102.093,1)=Clinic name^apptdt^patient^checkin user^checkout user
 N DSIVICN,DSIVICEN,I,X,DATA
 S DSIVICN=DSIVICR,DSIVICEN=$E(DSIVICN,1,$L(DSIVICN)-1)
 F I=1:1 S DSIVICN=$Q(@DSIVICN) Q:'(DSIVICN[DSIVICEN)  D
 .S DATA=@DSIVICN,X=$P(DATA,U) I X=DT Q  ;the two housekeeping nodes shouldn't file
 .S DA(1)=$G(DSIVIEN) I $E(X)="'" S X=$E(X,2,99)  ;DSIV*2.2*7 NCR 070312 - check for "'" in first character of clinic name
 .S DIC("DR")=".02////"_$P(DATA,U,2)_";.03////"_$P(DATA,U,3)
 .S:$P(DATA,U,4) DIC("DR")=DIC("DR")_";.04////"_$P(DATA,U,4)
 .S:$P(DATA,U,5) DIC("DR")=DIC("DR")_";.05////"_$P(DATA,U,5)
 .K DO S DIC="^DSI(19625.1,"_DA(1)_",1,",DIC(0)="FL",DLAYGO=19625.1 D FILE^DICN Q:Y<0  K DIC,DA,DLAYGO ;DSIV 2.2T12
 .Q
 ;fall through and kill tmp global
NEND K @DSIVICR Q
ERR(NUM,MSG) ;error running nightly job
 N ERR S ERR=$S(NUM=1:"Cannot lock 19625.1",NUM=2:"Cannot file to 19625.1",1:"Rpt Error")
 S ^XTMP("DSIVICR2;"_$J,0)=$$FMADD^XLFDT(DT,2)_U_$$NOW^XLFDT_U_"Error in Exception Rpt:"_ERR
 I NUM=2,$D(ERR) M ^XTMP("DSIVICR2;"_$J,"E")=ERR
 I NUM=3 S ^XTMP("DSIVICR2;"_$J,"E")=$G(@DSIVICR@(1))
 Q
RRPT(DSIV,DSIVSDT,DSIVEDT,MORE,DSIVLOCS) ;called by rpc DSIV EXCEPTION REPORT
 ;DSIVSDT=start date, DSIVEDT=end data
 ;MORE=0 start at the beginning,
 ;MORE=1 get the next 'set' of records if ~END~ was not received (meaning there are more)
 ;DSIVLOCS=array of include or exclude locations for this run of the report
 S DSIV=$NA(^TMP("DSIV",$J)) K @DSIV N DSIVLOC,DSIVINEX,ONEPAT,TOTAL,IEN,EDN,QUIT,SEED
 S DSIVSDT=$G(DSIVSDT,DT),DSIVEDT=$G(DSIVEDT,DT),MORE=$G(MORE),QUIT=0,IEN=0,EDN=0
 S DSIVSDT=DSIVSDT-.001,DSIVEDT=DSIVEDT+.9
 S DSIVLOC=0,DSIVINEX=0
 N I,X,Y S I=0 F  S I=$O(DSIVLOCS(I)) Q:'I  D  Q:DSIVLOC  ;DSIV*2.2*7 NCR NEW'd Y
 .S X=$G(DSIVLOCS(I))
 .I X S Y=$$GET1^DIQ(44,X,.01) S:Y]"" DSIVLOC(Y)=""
 .I X="EXCLUDE" S DSIVINEX=1 ;list can include or exclude clinics 3.5.07
 .Q
 K DSIVLOCS ;by ien, keep DSIVLOC by name
 S TOTAL=$$GET1^DSICXPR(,"SYS~DSIV MAX NUM ENTRIES",1) S:TOTAL<10 TOTAL=100
 S ONEPAT=$$GET1^DSICXPR(,"SYS~DSIV EXCEPTION PAT COUNTING",1) S:ONEPAT<0 ONEPAT=0
 I ONEPAT D ONEPAT^DSIVICR1(IEN) Q
 I MORE S IEN=$P($G(^XTMP("DSIVICR2;"_$J,1)),U,2) I IEN S EDN=$P(^(1),U,3)+1
 I 'MORE!'IEN D  I QUIT G END
 .S DSIVSDT=$O(^DSI(19625.1,"AT","E",DSIVSDT)) I 'DSIVSDT S QUIT=1 Q  ;no data
 .S IEN=$O(^DSI(19625.1,"AT","E",DSIVSDT,0))
 .S EDN=0
 .S ^XTMP("DSIVICR2;"_$J,0)=DT_U_DT_U_"Exception Report temp" ;SAC required node
 S SEED=$NA(^DSI(19625.1,IEN,1,EDN))
 N DAT,DATA,PAT,LOC,CNT,RETDATA,STOP S CNT=0,STOP=0
 F  S SEED=$Q(@SEED) S:SEED="" QUIT=1 Q:QUIT  D  Q:QUIT!STOP
 .I +$QS(SEED,2)'=$QS(SEED,2) S QUIT=1 Q  ;in the x-refs now
 .I $QL(SEED)=3 S DSIVSDT=$P(@SEED,U) I DSIVSDT>DSIVEDT S QUIT=1 Q  ;past end date
 .I $QL(SEED)=3 Q  ;ignore this node
 .I $QL(SEED)=4 Q  ;ignore this node
 .S IEN=$QS(SEED,2),EDN=$QS(SEED,4) ;save for "MORE"
 .S DATA=@SEED,LOC=$P(DATA,U) I LOC="" Q
 .I $$EXC^DSIVICR1(LOC) Q  ;clinic not selected or excluded
 .S PAT=$$GET1^DIQ(2,+$P(DATA,U,3),.01)
 .S PAT=PAT_" ("_$E(PAT)_$E($$GET1^DIQ(2,$P(DATA,U,3),.09),6,10)_")"
 .I LOC?.N1"E".N S LOC="'"_LOC ;special code to format clinic name in Excel
 .S RETDATA=LOC_U_$$FMTE^XLFDT($P(DATA,U,2))_U_PAT
 .S:$P(DATA,U,4) $P(RETDATA,U,4)=$$GET1^DIQ(200,+$P(DATA,U,4),.01)
 .S:$P(DATA,U,5) $P(RETDATA,U,5)=$$GET1^DIQ(200,+$P(DATA,U,5),.01)
 .S $P(RETDATA,U,6)=$P(DATA,U,2) ;DSIV*2.2*1 used by the GUI for sorting
 .S CNT=CNT+1,@DSIV@(CNT)=RETDATA
 .I CNT=TOTAL S ^XTMP("DSIVICR2;"_$J,1)=DSIVSDT_U_IEN_U_EDN,STOP=1
 .Q
END ;check for no data, end of report - otherwise quit and wait for MORE
 I '$D(@DSIV),MORE S @DSIV@(1)="~END~" G QUIT ;DSIV*2.2*1T6
 I '$D(@DSIV) S @DSIV@(1)="~END~" G QUIT
 I QUIT S @DSIV@("~",1)="~END~" G QUIT
 Q
QUIT K ^XTMP("DSIVICR2;"_$J)
 Q
 ;
DQ N DSIVIC,I,DSIVI,DSIVICD,DSIVICP,DSIVAY,DSIVAYM,DSIVAYN,DSIVEXP,X,CNT
 K DSIVD,^TMP("DILIST",$J),^TMP("DSIVICD",$J)
 S DSISCR="I $P(^(0),U,3)=""C""",CNT=0
 D LIST^DIC(44,,"@",,,,,,DSISCR) ;All Clinics
 F I=1:1 Q:'$D(^TMP("DILIST",$J,2,I))  S DSICL=+$G(^TMP("DILIST",$J,2,I)) D:DSICL
 .I $O(^DSI(19625.2,"B",DSICL,0)) Q  ;exclude clinic
 .I $D(DSIVLOC)>10 I $S($G(DSIVINEX):$D(DSIVLOC(DSICL)),1:'$D(DSIVLOC(DSICL))) Q  ;not selected, OR excluded loc 3.5.07
 .S CNT=CNT+1,DSIVICD(CNT)="C^"_DSICL
 .I CNT#50=0 D APT K DSIVICD
 .Q
 I $D(DSIVICD) S DSIVI=$O(DSIVICD(99999),-1) D APT ;catch the rest of them
 K ^TMP("DILIST",$J),DSISCR,DSICL,DSIVICD
 I '$D(^TMP("DSIVICAP",$J)) D  Q
 .S @DSIVICR@(1)="-1^APPL~DSICVT2 call failed"
 .Q
 ;loop through all appts and put them in pt / date order
 N DSIVICX,DSIVICQ,XDATA,CIP,COP K ^TMP("DSIVICPT",$J)
 S DSIVIC=$NA(^TMP("DSIVICAP",$J))
 S DSIVICX=DSIVIC,DSIVICQ=$E(DSIVIC,1,$L(DSIVIC)-1)
 F I=1:1 S DSIVICX=$Q(@DSIVICX) Q:'(DSIVICX[DSIVICQ)  D
 .S XDATA=@DSIVICX Q:XDATA=""  Q:XDATA<0  S CIP="",COP=""
 .I $P(XDATA,U,7) S CIP=+$P(XDATA,U,7) ;Check-in user
 .I $P(XDATA,U,8) S COP=+$P(XDATA,U,8) ;Check-out user
 .I 'CIP,'COP Q  ;no checkin or checkout user, ignore appt!
 .S ^TMP("DSIVICPT",$J,+$P(XDATA,U,4),+$P(XDATA,U,2)\1,+$P(XDATA,U,2))=XDATA ;dfn,dateonly,apptdt/tm
 .Q
 K @DSIVIC,DSIVICX,DSIVICQ
 N DFN,DSIVT,DSIVAPT,DSIVB,DSIVL,PPOL,QUIT,DSIVIEN,DSISRCA,DSIVDFN
 ;now, loop through these in pt / date order
 S CNT=0,DFN=0 F  S DFN=$O(^TMP("DSIVICPT",$J,DFN)) Q:'DFN  D
 .S DSISRCA=0,DSIVIEN=$O(^IBA(355.33,"C",DFN,999999999),-1) D:DSIVIEN  I DSISRCA Q  ;DSIV 2.2T11
 ..S DSISRCA=$$GET1^DIQ(355.33,DSIVIEN,.03,"E") ;check automated entries (probably no 19625 entry)
 ..I DSISRCA="eIV"!(DSISRCA="HMS")!(DSISRCA="IVM") S DSISRCA=1 Q  ;quit if no audit but active buffer
 ..S DSIVDFN=$$GET1^DIQ(355.33,DSIVIEN,60.01,"I")
 ..I DSIVDFN,'$D(^DSI(19625,"G",DSIVDFN,DSIVIEN)) S DSISRCA=1 ;has buffer, but no audit DSIV*2.2*1T6
 ..Q
 .D BUF1 ;get all buffer(audit) entries 60 days prior to start and 30 days after end dates
 .S DSIVT=0 F  S DSIVT=$O(^TMP("DSIVICPT",$J,DFN,DSIVT)) Q:'DSIVT  D
 ..;only quit:'ppol if no buffer for DATE OF APPT!  May have needed ins review for early appts!
 ..S PPOL=$$INS^DSIVIC1(DFN,DSIVVER,DSIVVERM,DSIVVERN,DSIVT) Q:'PPOL  ;doesn't need ins review-quit
 ..S DSIVAPT=0,QUIT=0 F  S DSIVAPT=$O(^TMP("DSIVICPT",$J,DFN,DSIVT,DSIVAPT)) Q:'DSIVAPT!QUIT  D
 ...S X=$G(^(DSIVAPT)) ;naked ref to TMP("DSIVICPT",$J,DFN,DSIVT,DSIVAPT)
 ...S DSIVL=$P($P(X,U,3),";",2) Q:DSIVL=""  I DSIVL?.N1"E".N S DSIVL="'"_DSIVL
 ...I '$D(DSIVB),PPOL S CNT=CNT+1,@DSIVICR@(DSIVL,DSIVT,DSIVAPT,CNT)=DSIVL_U_$$FMT(X) S:ONEPAT QUIT=1 Q
 ...I $$BCHK(X) S CNT=CNT+1,@DSIVICR@(DSIVL,DSIVT,DSIVAPT,CNT)=DSIVL_U_$$FMT(X) S:ONEPAT QUIT=1
 ...Q
 ..Q
 .Q
 K ^TMP("DSIVICPT",$J)
 Q
BCHK(X) ; check appt against buffer entries.
 ; X = visit IFN^date.time^loc^patient^ssn^division^Check-in User
 ; Z = buff enterd dt/tm^buff accepted dt/tm^clinic^user entered buff^ppol needs ver
 N I,Z,B,APD,LOC S I=0,B=1,APD=+$P(X,U,2),LOC=$P($P(X,U,3),";",2)
 F  S I=$O(DSIVB(I)) Q:'I  D
 .S Z=DSIVB(I) I APD>$P(Z,U,1),APD<$P(Z,U,2) S B=0 ;buffer created before appt, still open
 .;check for buffer created the same day as appt, the first clinic to create buffer is OK
 .I (APD\1)=($P(Z,U)\1),LOC=$P(Z,U,3) S B=0,QUIT=1 ;QUIT=1 means any appt after this is excused (not an exception)
 .Q
 Q B
 ;
APT ;get all appts for the list of clinics
 N J S J=$G(DSIVI)+1,DSIVICD(J)="FI^0" ;checked in only
 D @("APPL^DSICVT2(.DSIVIC,"_$G(DSIVSDT)_","_$G(DSIVEDT)_",.DSIVICD)")
 M ^TMP("DSIVICAP",$J)=@DSIVIC K @DSIVIC,DSIVICD ;MERGE all appts into one global 
 Q
BUF1 ;get all buffer entries for the patient/date
 K DSIVB N X0,X1,X4,SDT,EDT,DSIVIEN,EEDT,EEDTN,DSIVBUF    ;DSIV*2.2*7 NCR NEW'd EEDTN
 S SDT=$$FMADD^XLFDT(DSIVSDT,-60),EDT=$$FMADD^XLFDT(DSIVEDT,30) ;DSIV*2.2*1 open window to 60 days
 F  S SDT=$O(^DSI(19625,"AD",DFN,SDT)) Q:'SDT!(SDT>EDT)  S DSIVIEN=0 D
 .F  S DSIVIEN=$O(^DSI(19625,"AD",DFN,SDT,DSIVIEN)) Q:'DSIVIEN  D
 ..S X0=$G(^DSI(19625,DSIVIEN,0)),X1=$G(^(1)),X4=$P($G(^(4)),U)
 ..Q:'$P(X0,U,2)  ;don't look at "stub" records
 ..S EEDT=$S($P(X1,U,10):$P(X1,U,10)+.24,$P(X1,U,8):$P(X1,U,8)+.24,$P(X1,U,12):$P(X1,U,12)+.24,1:9999999) ;EEDT is accpt or del or reject or 9's if still open
 ..I EEDT=9999999 D  ;may have been processed by eIV/VistA buffer
 ...S DSIVBUF=$P($G(^DSI(19625,DSIVIEN,0)),U,2) Q:'DSIVBUF
 ...I $$GET1^DIQ(355.33,DSIVBUF,.04,"I")="E" Q  ;Still active. DSIV*2.2*6 get internal value
 ...S EEDTN=$$GET1^DIQ(355.33,DSIVBUF,.05,"I") ;use buffer processed date as end date if later than EEDT
 ...I EEDTN,EEDTN>EEDT S EEDT=EEDTN
 ..S DSIVB(DSIVIEN)=$P(X1,U,4)_U_EEDT_U_X4_U_$P(X1,U,3)_U_$P(X1,U,2) ;dt entered^enddt^location^enteredby^polneedupdt
 ..Q
 .Q
 Q
FMT(DATA) ;fmt the data on the report KC 1.5.07 ICB changes
 ; DATA = visit IFN^date.time^loc^patient^ssn^division^Check-in User^Check-out User
 ;        where P2-P8 is IEN;external value
 I $G(DSIVNITE) Q +$P(DATA,U,2)_U_+$P(DATA,U,4)_U_+$P(DATA,U,7)_U_+$P(DATA,U,8) ;NIGHTLY job uses pointers
 Q $P($P(DATA,U,2),";",2)_U_$E($P($P(DATA,U,4),";",2),1,13)_" ("_$E($P($P(DATA,U,4),";",2))_$E($P($P(DATA,U,5),";"),6,10)_")"_U_$P($P(DATA,U,7),";",2)_U_$P($P(DATA,U,8),";",2)
 ;
PARMD(DSIVMS) ;get days back params DSIVAY,DSIVAYM, DSIVAYN
 ;ONEPAT is if we're counting pts vs clerks (appts), so quit after the first hit per pt per day
 N X,I,DSIVD
 S ONEPAT=$$GET1^DSICXPR(,"SYS~DSIV EXCEPTION PAT COUNTING",1) S:ONEPAT<0 ONEPAT=0
 I $G(DSIVNITE) S ONEPAT=0 ;override ONEPAT for nightly process - always do details! 2.0T7
 S DSIVAY=$$GET1^DSICXPR(,"SYS~DSIV VER DAYS BACK",1) S:DSIVAY<0 DSIVAY=0
 S DSIVAYN=$$GET1^DSICXPR(,"SYS~DSIV VER NO INSURANCE",1) S:DSIVAYN<0 DSIVAYN=0
 S DSIVAYM=365 ;Default days back for listed (medicare type) insurances
 D GETWP^DSICXPR(.DSIVD,"SYS~DSIV VER DAYS BACK SPECIFIC~1")
 F I=1:1 Q:'$D(DSIVD(I))  S X=$G(DSIVD(I)) D
 .I X=+X,X>0 S DSIVAYM=X
 .I X["=",+X S DSIVMS(+X)="" ;list of special insurance IENs using DSIVAYM
 .Q
 Q
