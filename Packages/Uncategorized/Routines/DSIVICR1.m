DSIVICR1 ;DSS/KC - ICB EXCEPTION REPORT ;05/17/2006 11:19
 ;;2.2;INSURANCE CAPTURE BUFFER;**1,4**;May 19, 2009;Build 7
 ;Copyright 1995-2010, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 10000  %DT
 ; 10086  %ZIS
 ; 10089  %ZISC
 ; 2056   GETS^DIQ
 ; 10063  %ZTLOAD,$$TM^%ZTLOAD
 ; 10103  $$FMADD^XLFDT,$$FMTE^XLFDT,$$NOW^XLFDT
 ;
 Q
RPTP(DSIVRET,DSIVSDT,DSIVEDT,DSIVHNDL,DSIVLOCS) ; RPC: DSIV EXCEPTION REPORT2
 I '$G(DSIVHNDL) D
 .S DSIVHNDL=DUZ_"~"_$J_"~"_$TR($J($R(10000),4)," ",0) ; Create handle
 .Q
 I $D(^XTMP("DSIVICR1",DSIVHNDL)) D  Q
 .S DSIVRET="-1^Duplicate request^"_DSIVHNDL
 .Q
 S DSIVICR=$NA(^XTMP("DSIVICR1",DSIVHNDL))
 S @DSIVICR@(0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1 ;;SACC required node
 S @DSIVICR@(1)=DT ;keep track of report progress
 I '$$TM^%ZTLOAD S DSIVRET="-1^TaskMan not running^"_DSIVHNDL Q
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTDESC="DSIV Exception Report "_DSIVHNDL
 S ZTDTH=$H,ZTIO="",ZTRTN="DQR^DSIVICR1"
 S ZTSAVE("DSIV*")="" D ^%ZTLOAD
 I $G(ZTSK)>0 S DSIVRET=ZTSK_U_DSIVHNDL Q
 S DSIVRET="-1^Attempt to schedule task failed^"_DSIVHNDL
 Q
DQR ;come in from new tasked call
 N DSIVICR,DSIVICRT,ZZ,DSIVLOC,DSIVINEX
 S DSIVICRT=$NA(^TMP("DSIVICRT",$J)) K @DSIVICRT
 S DSIVICR=$NA(^XTMP("DSIVICR1",DSIVHNDL))
 I '$D(@DSIVICR) S @DSIVICR@(0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1 ;;SACC required node
 S @DSIVICR@(1)=DT_"^^^^^^"_$$NOW^XLFDT ;keep track of report progress
 S DSIVLOC=0,DSIVINEX=0
 N I,X S I=0 F  S I=$O(DSIVLOCS(I)) Q:'I  D  Q:DSIVLOC
 .S X=$G(DSIVLOCS(I)) S:X DSIVLOC(X)=""
 .I X="EXCLUDE" S DSIVINEX=1 ;list can include or exclude clinics 3.5.07
 .Q
 K DSIVLOCS
 D DQ
 I +$G(@DSIVICR@(1))=-1 S @DSIVICR@(1)=DT_"^1^^"_@DSIVICR@(1)
 S ZZ=$G(@DSIVICR@(1))
 S $P(ZZ,U,2)=1,$P(ZZ,U,5)=DSIVSDT,$P(ZZ,U,6)=DSIVEDT,$P(ZZ,U,8)=$$NOW^XLFDT
 S @DSIVICR@(1)=ZZ
 Q
POLL(RESULT,DSIVHNDL,NUMS,MORE) ;rpc DSIV POLL REPORT
 ; DSIVHNDL =Handle (required)  
 ; RESULT   = formatted rpt data or RESULT(1)=0^Results not ready 
 ;     or -1^Error message
 ;
 N CNT,I,SPACE,R,X,QUIT,STDT,ETDT
 S CNT=0,NUMS=$G(NUMS,999),MORE=$G(MORE)
 S RESULT=$NA(^TMP("DSIVIC",$J)) K @RESULT
 I '$L($G(DSIVHNDL)) S @RESULT@(1)="-1^Invalid Handle" Q
 S R=$NA(^XTMP("DSIVICR1",DSIVHNDL)) ;Data
 S X=$G(@R@(1))
 I '$D(X) S @RESULT@(1)="-1^List not found" Q
 I $P(X,U,3) S @RESULT@(1)="-1^Request was cancelled" Q
 I $P(X,U,4) S @RESULT@(1)="-1^Error in background" Q
 I '$P(X,U,2) S @RESULT@(1)="0^Results not ready" Q
 I MORE=9 K @R S @RESULT@(1)="0^Remaining report data removed from saved area" Q
 I 'MORE S CNT=CNT+1,@RESULT@(CNT)="$START$"_$P(X,U,5)_U_$P(X,U,6) ;report date ranges
 N DSIVICN,DSIVICEN,I,X
 S DSIVICN=R,DSIVICEN=$E(DSIVICN,1,$L(DSIVICN)-1),QUIT=0
 F I=1:1 S DSIVICN=$Q(@DSIVICN) Q:QUIT!'(DSIVICN[DSIVICEN)  D
 .S X=@DSIVICN I $P(X,U)=DT D  Q  ;the two housekeeping nodes shouldn't print
 ..I $QS(DSIVICN,3)=0 S STDT=$P(X,U,2) Q  ;STDT = queued time
 ..S ETDT=$P(X,U,7)_U_$P(X,U,8) ;ETDT = elapsed run time (start^end)
 ..Q
 .S CNT=CNT+1,@RESULT@(CNT)=$P(X,U)_U_$P(X,U,2)_U_$P(X,U,3)_U_$P(X,U,4)_U_$P(X,U,5)
 .I CNT=NUMS S QUIT=1
 .K @DSIVICN
 .Q
 S X=$O(@R@(1))
 I X="" K @R S @RESULT@("~")="$END$"_$G(STDT)_U_$G(ETDT) ;report queued/elapsed times
 Q
RPT ;VistA option DSIV EXCEPTION REPORT
 N Y D DATE G:Y<0 EXIT
 S %ZIS="MQ" K IO("Q") D ^%ZIS G EXIT:IO=""
 I $D(IO("Q")) S ZTRTN="QUE^DSIVICR1",ZTSAVE("DSIV*")="" D ^%ZTLOAD K ZTSK,ZTRTN,ZTSAVE G EXIT
QUE U IO D EN,CLOSE
 Q
EN N DSIVICR,RDATE,NEWDT,LOOPDT,DSIVVER,DSIVVERM,DSIVVERN,DSIVAY,DSIVAYM,DSIVAYN,DSIVMS,ONEPAT
 S DSIVICR=$NA(^TMP("DSIVIC",$J))
 S RDATE(DSIVSDT)="",NEWDT=DSIVSDT D  ;Add days until we get to end date to get array of rpt dates
 .F  S NEWDT=$$FMADD^XLFDT(NEWDT,1) Q:NEWDT>DSIVEDT  S RDATE(NEWDT)="",DSIVSDT=NEWDT
 S LOOPDT=0 F  S LOOPDT=$O(RDATE(LOOPDT)) Q:'LOOPDT  S (DSIVSDT,DSIVEDT)=LOOPDT D
 .D PARMS,DQ^DSIVICR2
 .Q
 I $E(IOST,1,2)="C-" W @IOF
 S DSIVSDT=$O(RDATE(0)),DSIVEDT=$O(RDATE(9999999),-1)
 W ?10,"ICB EXCEPTION REPORT for ",$$FMTE^XLFDT(DSIVSDT)," to ",$$FMTE^XLFDT(DSIVEDT),!
 W !,"CLINIC",?14,"APPT DATE/TIME",?35,"PATIENT",?57,"CK-IN USER",?69,"CK-OUT USER"
 W !,"-------------------------------------------------------------------------------"
 I $G(@DSIVICR@(1)) W $G(@DSIVICR@(1)) K @DSIVICR Q
 I '$D(@DSIVICR) W !,"No exceptions for the selected date range."
 N DSIVICN,DSIVICEN,I,X S DSIVICN=DSIVICR,DSIVICEN=$E(DSIVICN,1,$L(DSIVICN)-1)
 F I=1:1 S DSIVICN=$Q(@DSIVICN) Q:'(DSIVICN[DSIVICEN)  D
 .S X=@DSIVICN I $P(X,U)=DT Q  ;the two housekeeping nodes shouldn't print
 .W !,$E($P(X,U),1,13),?14,$P(X,U,2),?35,$P(X,U,3),?57,$E($P(X,U,4),1,10),?69,$E($P(X,U,5),1,10)
 .Q
 W !! K @DSIVICR
 Q:$D(ZTSK)!($E(IOST,1,2)'="C-")
 N Z5 S Z5="" R !,"Press return to continue",Z5:DTIME
 Q
 ;
DQ N DSIVIC,I,DSIVI,DSIVICD,DSIVICP,DSIVEXP,X,DSIVCL
 N DSIVVER,DSIVVERM,DSIVVERN,DSIVAY,DSIVAYM,DSIVAYN,DSIVMS,ONEPAT
 D PARMS,DQ^DSIVICR2
 Q
 ;
DATE ;prompt for date range
D1 W !!,"Enter the starting and ending dates for the data entries that",!,"you wish to include in this report.",!
 S %DT("A")="STARTING DATE: ",%DT="AEPX" D ^%DT K %DT("A") Q:Y<0  S DSIVSDT=Y
 S %DT("A")="ENDING DATE: ",%DT="AEPX" D ^%DT K %DT("A") Q:Y<0  S DSIVEDT=Y
 I DSIVEDT<DSIVSDT W *7,!!,"End Date before Start Date?" G D1
 Q
CLOSE D ^%ZISC
EXIT K DSIVSDT,DSIVEDT K:$D(ZTSK) ^%ZTSK(ZTSK),ZTSK
 Q
PARMS ;get parameters
 D PARMD^DSIVICR2(.DSIVMS) ;get params
 S DSIVVER=$$FMADD^XLFDT(DSIVSDT,-DSIVAY) ;days back
 S DSIVVERM=$$FMADD^XLFDT(DSIVSDT,-DSIVAYM) ;days back medicare
 S DSIVVERN=$$FMADD^XLFDT(DSIVSDT,-DSIVAYN) ;days back no insurance
 Q
ONEPAT(IEN) ;sort by pt/appt date to only return first appt for patient/date
 ;called by DSIVICR2 with params already set
 ;DSIV*2.2*1 EVAL complete day, then send the data back in chunks if necessary
 N STOP,LOOP,DSIVPT S STOP=0,DSIVPT=$NA(^XTMP("DSIVPT;"_$J))
 S LOOP=$P($G(^XTMP("DSIVICR2;"_$J,1)),U) I LOOP="DSIVICR2" D  G END
 .S DSIVSDT=$P(^(1),U,2)-.001
 .D EVAL,LOOP(0)
 I LOOP="DSIVPT" D  G END
 .S DSIVSDT=$P($G(^XTMP("DSIVICR2;"_$J,1)),U,2),IEN=$P(^(1),U,3)
 .D LOOP(IEN) ;getting chunks of data within a day
 D EVAL,LOOP(0)
 ;
END ;check for no data, end of report or MORE
 I ('STOP&'DSIVSDT)!(DSIVSDT>DSIVEDT) S @DSIV@("~",1)="~END~" G QUIT
 I '$D(@DSIV),MORE S @DSIV@(1)="~END~" G QUIT
 I '$D(@DSIV) S @DSIV@(1)="~END~" G QUIT
 I MORE,'$D(@DSIVPT),$P(@DSIV@(1),U,6)\1=DSIVSDT S @DSIV@("~",1)="~END~" G QUIT ;DSIV*2.2*4
 I $P($G(^XTMP("DSIVICR2;"_$J,1)),U)'="DSIVPT" S ^XTMP("DSIVICR2;"_$J,1)="DSIVICR2"_U_DSIVSDT
 S ^XTMP("DSIVICR2;"_$J,0)=DT_U_DT_U_"Exception Report temp" ;SAC required node
 Q
QUIT K ^XTMP("DSIVICR2;"_$J)
 Q
LOOP(J)  ;Loop through patient sorted data to get first appt for the day
 N K,L,RETDATA,CNT S CNT=0,STOP=0 F  S J=$O(@DSIVPT@(J)) Q:'J!STOP  D
 .S K=$O(@DSIVPT@(J,0)),L=$O(@DSIVPT@(J,K,0))
 .S CNT=CNT+1,@DSIV@(CNT)=$G(@DSIVPT@(J,K,L))
 .I CNT=TOTAL S STOP=1,^XTMP("DSIVICR2;"_$J,1)="DSIVPT"_U_($S(DSIVSDT:DSIVSDT,1:DSIVEDT\1))_U_J_U_0
 .Q
 ;we got them all for the day, set up for next day
 I 'STOP K @DSIVPT,^XTMP("DSIVICR2;"_$J,1)
 Q
EVAL ;evaluate the entire day for ONEPAT, STOP means we have data for this date
 N IEN,EDN,DATA,LOC,PAT,RETDATA K @DSIVPT
 F  S DSIVSDT=$O(^DSI(19625.1,"AT","E",DSIVSDT)) Q:'DSIVSDT!(DSIVSDT>DSIVEDT)!STOP  D
 .S IEN=0 F  S IEN=$O(^DSI(19625.1,"AT","E",DSIVSDT,IEN)) Q:'IEN  D
 ..S EDN=0 F  S EDN=$O(^DSI(19625.1,IEN,1,EDN)) Q:'EDN  D
 ...S DATA=$G(^DSI(19625.1,IEN,1,EDN,0))
 ...S LOC=$P(DATA,U) I LOC="" Q
 ...I $$EXC(LOC) Q  ;not selected, OR excluded loc
 ...S PAT=$$GET1^DIQ(2,+$P(DATA,U,3),.01)
 ...S PAT=PAT_" ("_$E(PAT)_$E($$GET1^DIQ(2,$P(DATA,U,3),.09),6,10)_")"
 ...S RETDATA=LOC_U_$$FMTE^XLFDT($P(DATA,U,2))_U_PAT
 ...S:$P(DATA,U,4) $P(RETDATA,U,4)=$$GET1^DIQ(200,+$P(DATA,U,4),.01)
 ...S:$P(DATA,U,5) $P(RETDATA,U,5)=$$GET1^DIQ(200,+$P(DATA,U,5),.01)
 ...S $P(RETDATA,U,6)=$P(DATA,U,2) ;DSIV*2.2*1 used by the GUI for sorting
 ...S @DSIVPT@(+$P(DATA,U,3),+$P(DATA,U,2),LOC)=RETDATA,STOP=1
 ...Q
 ..Q
 .Q
 Q
EXC(LOCN) ;EXCLUDE CLINIC?  (not selected or excluded)
 ;exclude clinic from exception list, clinic may be added to 19625.2 after nightly run
 ;so we have to re-check for exclusion during report run, plus check the passed in
 ;exclude/include list
 N DSIVL,EXC,J,FOUND S EXC=0,FOUND=0
 I LOCN="" Q 1
 S FOUND=$O(^SC("B",LOCN,0)) I FOUND S EXC=$O(^DSI(19625.2,"B",FOUND,0)) I EXC Q 1 ;DSIV*2.2*1
 I $D(DSIVLOC)>10 I $S($G(DSIVINEX):$D(DSIVLOC(LOCN)),1:'$D(DSIVLOC(LOCN))) Q 1 ;not selected, OR excluded loc 3.5.07
 Q 0
