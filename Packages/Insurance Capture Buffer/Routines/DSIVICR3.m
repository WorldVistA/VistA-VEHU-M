DSIVICR3 ;DSS/KC - ICB PRODUCTIVITY REPORT ;04/26/2012 08:18
 ;;2.2;INSURANCE CAPTURE BUFFER;**7,9,11**;May 19, 2009;Build 16
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Control Registrations
 ; 2056   GETS^DIQ, $$GET1^DIQ
 ; 10063  %ZTLOAD,$$TM^%ZTLOAD
 ; 10103  $$NOW^XLFDT
 ;
 Q
RPT(DSIVRET,DSIVSDT,DSIVEDT,DSIVRPT,DSIVHNDL,DSIVLOCS) ; RPC: DSIV PRODUCTIVITY REPORT
 ;DSIVSDT=start date, DSIVEDT=end date, 
 ;DSIVRPT="C" for Clinic - Return=Clinic^totalentries^totalnoins^totalexceptions
 ;DSIVRPT="U" for User - Return=User^totalentries^totalnoins^totalexceptions
 ;DSIVRPT="CU" for Both Clinic and User - Return=Clinic|User^totalentries^totalnoins^totalexceptions
 ;DSIVRPT="UC" for User and Clinic - Return=User|Clinic^totalentries^totalnoins^totalexceptions
 ;DSIVHNDL=unique numeric report id for this report  (OPTIONAL, will default)
 ;DSIVLOCS(1)="INCLUDE" or "EXCLUDE"   (OPTIONAL ARRAY)
 ;DSIVLOCS(2-n)=CLINIC IEN to include or exclude
 ;
 I '$G(DSIVSDT) S DSIVRET="-1^Missing Start Date" Q
 I '$G(DSIVEDT) S DSIVRET="-1^Missing End Date" Q
 S DSIVEDT=DSIVEDT+.9 I DSIVSDT>DSIVEDT S DSIVRET="-1^Start Date after End Date" Q
 I $G(DSIVRPT)="" S DSIVRET="-1^Report Type Missing" Q
 I ",C,U,CU,UC,"'[(","_DSIVRPT_",") S DSIVRET="-1^Invalid Report Type (C,U,CU,UC allowed)" Q
 I '$G(DSIVHNDL) D
 .S DSIVHNDL=DUZ_"~"_$J_"~"_$TR($J($R(10000),4)," ",0) ; Create handle
 .Q
 I $D(^XTMP("DSIVICR3"_DSIVHNDL)) D  Q
 .S DSIVRET="-1^Duplicate request^"_DSIVHNDL
 .Q
 S DSIVICR=$NA(^XTMP("DSIVICR3"_DSIVHNDL))
 S @DSIVICR@(0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1 ;;SACC required node
 S @DSIVICR@(1)=DT ;keep track of report progress
 I '$$TM^%ZTLOAD S DSIVRET="-1^TaskMan not running^"_DSIVHNDL Q
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTDESC="DSIV Productivity Report "_DSIVHNDL
 S ZTDTH=$H,ZTIO="",ZTRTN="DQR^DSIVICR3"
 S ZTSAVE("DSIV*")="" D ^%ZTLOAD
 I $G(ZTSK)>0 S DSIVRET=ZTSK_U_DSIVHNDL Q
 S DSIVRET="-1^Attempt to schedule task failed^"_DSIVHNDL
 Q
POLL(RESULT,DSIVHNDL,NUMS,MORE) ;rpc DSIV POLL PRODUCTIVITY
 ; DSIVHNDL =Handle (required)  
 ; RESULT   = formatted rpt data or RESULT(1)=0^Results not ready 
 ;     or -1^Error message
 ;
 N CNT,I,SPACE,R,X,QUIT,STDT,ETDT
 S CNT=0,NUMS=$G(NUMS,999),MORE=$G(MORE)
 S RESULT=$NA(^TMP("DSIVICR3",$J)) K @RESULT
 I '$L($G(DSIVHNDL)) S @RESULT@(1)="-1^Invalid Handle" Q
 S R=$NA(^XTMP("DSIVICR3"_DSIVHNDL)) ;Data
 S X=$G(@R@(1)) I '$D(X) S @RESULT@(1)="-1^List not found" Q
 I $P(X,U,3) S @RESULT@(1)="-1^Request was cancelled" Q
 I $P(X,U,4) S @RESULT@(1)="-1^Error in background" Q
 I '$P(X,U,2) S @RESULT@(1)="0^Results not ready" Q
 I MORE=9 K @R S @RESULT@(1)="0^Remaining report data removed from saved area" Q
 S X=$O(@R@(1)) I X="" S @RESULT@(1)="-1^No report data found" K @R Q
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
DQR ;come in from new tasked call
 ;DSIVSDT, DSIVEDT, DSIVRPT and DSIVLOCS comes in from the tasked job
 N DSIVICR,DSIVICRT,ZZ,DSIVLOC,DSIVINEX
 S DSIVICR=$NA(^XTMP("DSIVICR3"_DSIVHNDL))
 I '$D(@DSIVICR) S @DSIVICR@(0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1 ;SACC required node
 S @DSIVICR@(1)=DT_"^^^^^^"_$$NOW^XLFDT ;keep track of report progress
 S DSIVLOC=0,DSIVINEX=0
 N I,X S I=0 F  S I=$O(DSIVLOCS(I)) Q:'I  D  Q:DSIVLOC
 .S X=$G(DSIVLOCS(I)) S:X DSIVLOC(X)=""
 .I X="EXCLUDE" S DSIVINEX=1 ;list can include or exclude clinics
 .Q
 K DSIVLOCS
 D EXC,EBU
 I +$G(@DSIVICR@(1))=-1 S @DSIVICR@(1)=DT_"^1^^"_@DSIVICR@(1)
 S ZZ=$G(@DSIVICR@(1))
 S $P(ZZ,U,2)=1,$P(ZZ,U,5)=DSIVSDT,$P(ZZ,U,6)=DSIVEDT,$P(ZZ,U,8)=$$NOW^XLFDT
 S @DSIVICR@(1)=ZZ
 Q
EXC ;get exception data
 N IEN,SEED,QUIT,DATA,LOC,CIU,COU,USER,RDATA
 S IEN=$O(^DSI(19625.1,"AT","E",DSIVSDT,0)) Q:'IEN
 S SEED=$NA(^DSI(19625.1,IEN,1,0)),QUIT=0
 F  S SEED=$Q(@SEED) S:SEED="" QUIT=1 Q:QUIT  D  Q:QUIT
 .I +$QS(SEED,2)'=$QS(SEED,2) S QUIT=1 Q  ;in the x-refs now
 .I $QL(SEED)=3 I $P(@SEED,U)>DSIVEDT S QUIT=1 Q  ;past end date
 .I $QL(SEED)=3 Q  ;ignore this node
 .I $QL(SEED)=4 Q  ;ignore this node
 .S DATA=@SEED,LOC=$P($G(DATA),U),CIU="",COU="" I LOC="" Q
 .I $$LOC(LOC) Q  ;clinic not selected or excluded
 .I LOC?.N1"E".N S LOC="'"_LOC ;special code to format clinic name in Excel
 .S:$P(DATA,U,4) CIU=$$GET1^DIQ(200,+$P(DATA,U,4),.01)
 .S:$P(DATA,U,5) COU=$$GET1^DIQ(200,+$P(DATA,U,5),.01)
 .S USER=$S(CIU]"":CIU,COU]"":COU,1:"UNKNOWN")
 .I DSIVRPT="C" S $P(@DSIVICR@(LOC),U)=LOC,$P(@DSIVICR@(LOC),U,4)=$P($G(@DSIVICR@(LOC)),U,4)+1 Q
 .I DSIVRPT="U" S $P(@DSIVICR@(USER),U)=USER,$P(@DSIVICR@(USER),U,4)=$P($G(@DSIVICR@(USER)),U,4)+1 Q
 .I DSIVRPT="UC" D  Q
 ..S RDATA=$G(@DSIVICR@(USER,LOC)),$P(RDATA,U)=USER_"|"_LOC
 ..S $P(RDATA,U,4)=$P(RDATA,U,4)+1,@DSIVICR@(USER,LOC)=RDATA
 .I DSIVRPT="CU" D
 ..S RDATA=$G(@DSIVICR@(LOC,USER)),$P(RDATA,U)=LOC_"|"_USER
 ..S $P(RDATA,U,4)=$P(RDATA,U,4)+1,@DSIVICR@(LOC,USER)=RDATA
 Q
EBU ;get entered by user data - ENSURE DSIVSDT,DSIVEDT have not been changed before we get here!
 N IEN
 F  S DSIVSDT=$O(^DSI(19625,"C",DSIVSDT)) Q:'DSIVSDT!(DSIVSDT>DSIVEDT)  D
 .S IEN=0 F  S IEN=$O(^DSI(19625,"C",DSIVSDT,IEN)) Q:'IEN  I $P($G(^DSI(19625,+IEN,0)),U,2) D DATA
 Q
DATA ;get data and set report xtmp
 N DSIVD,LOC,USER,INS,NOINS,DATA
 D GETS^DIQ(19625,+IEN,".03;1;1.11","E","DSIVD")
 I $G(DSIVD(19625,IEN_",",1.11,"E"))]"" S LOC=$G(DSIVD(19625,IEN_",",1.11,"E"))
 I $G(DSIVD(19625,IEN_",",1,"E"))]"" S USER=$G(DSIVD(19625,IEN_",",1,"E"))
 ;
 ;handle issue with eIV audit record having no location data DSIV*2.2*T3 NCR
 S:$G(LOC)="" LOC="UNKNOWN"
 ;prepare for audit record with no user DSIV*2.2*T3 NCR
 S:$G(USER)="" USER="UNKNOWN"
 S INS=$G(DSIVD(19625,IEN_",",.03,"E")),NOINS=$S(INS="NO INSURANCE":1,1:0) ;protect insurance name in audit file
 I DSIVRPT="C" S DATA=$G(@DSIVICR@(LOC)) D  Q
 .S $P(DATA,U,2)=$P(DATA,U,2)+1 ;add count for entered by user
 .I NOINS S $P(DATA,U,3)=$P(DATA,U,3)+1 ;add no insurance count
 .S $P(DATA,U)=LOC,@DSIVICR@(LOC)=DATA
 I DSIVRPT="U" S DATA=$G(@DSIVICR@(USER)) D  Q
 .S $P(DATA,U,2)=$P(DATA,U,2)+1 ;add count for entered by user
 .I NOINS S $P(DATA,U,3)=$P(DATA,U,3)+1 ;add no insurance count
 .S $P(DATA,U)=USER,@DSIVICR@(USER)=DATA
 I DSIVRPT="UC" S DATA=$G(@DSIVICR@(USER,LOC)) D  Q
 .S $P(DATA,U,2)=$P(DATA,U,2)+1 ;add count for entered by user
 .I NOINS S $P(DATA,U,3)=$P(DATA,U,3)+1 ;add no insurance count
 .S $P(DATA,U)=USER_"|"_LOC,@DSIVICR@(USER,LOC)=DATA
 I DSIVRPT="CU" D
 .S DATA=$G(@DSIVICR@(LOC,USER))
 .S $P(DATA,U,2)=$P(DATA,U,2)+1
 .I NOINS S $P(DATA,U,3)=$P(DATA,U,3)+1
 .S $P(DATA,U)=LOC_"|"_USER,@DSIVICR@(LOC,USER)=DATA
 Q
LOC(LOCN) ;EXCLUDE CLINIC?  (not selected or excluded)
 ;exclude clinic from exception list, clinic may be added to 19625.2 after nightly run
 ;so we have to re-check for exclusion during report run, plus check the passed in
 ;exclude/include list
 N DSIVL,EXC,J,FOUND S EXC=0,FOUND=0
 I LOCN="" Q 1
 S FOUND=$O(^SC("B",LOCN,0)) I FOUND S EXC=$O(^DSI(19625.2,"B",FOUND,0)) I EXC Q 1 ;always exclude clinics from 19625.2
 I 'FOUND Q 1 ;use ien in array
 I $D(DSIVLOC)>10 I $S($G(DSIVINEX):$D(DSIVLOC(FOUND)),1:'$D(DSIVLOC(FOUND))) Q 1 ;not selected, OR excluded
 Q 0
