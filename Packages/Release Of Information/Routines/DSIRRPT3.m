DSIRRPT3 ;EWL - Document Storage Systems; ROI Report RPC'S ;07/01/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2053  WP^DIE
 ;2056  GETS^DIQ
 ;10000 NOW^%DTC
 Q
 ;*****************************************************************************
 ;*****************************************************************************
 ; REQUESTS BY DELIVERY TYPE
 ;*****************************************************************************
 ;*****************************************************************************
DTR(AXY,FRDT,TODT,DIVL,SCHED,ESTART) ; RPC - DSIRRPT3 DTR DELIVERY TYPE RPT
 ; INPUT PARAMETERS:
 ;   FRDT = START DATE
 ;   TODT = END DATE
 ;   DIVL = DIVISION LIST
 ;   SCHED  Schedule - Boolean for scheduled or immediate run
 ;          1 = Schedule / 0 or Null = Run Immediately
 ;   ESTART Earliet time to start the scheaduled task
 ;
 ; RETURN ARRAY
 ;   if immediate
 ;   ##^DESCRIPTION    Where ## = a positive integer count >= Zero
 ;   or
 ;   if scheduled
 ;   Task^REPORT AFTER yyymmdd.hhmmss
 ;   or
 ;   -1^Error Message
 ;
 S AXY=$NA(^TMP("DSIRRPT3DTR",$J)),SCHED=+$G(SCHED)
 I 'SCHED D DTR3(.AXY,FRDT,TODT,DIVL)
 I SCHED D
 .N RPT,EMSG,PARRAY,I
 .;CREATE THE REPORT SCHEDULE RECORD, FILE THE PARAMETERS, AND SUBMIT
 .S ESTART=$G(ESTART),RPT="DELIVERY TYPE",IEN=$$UDSCHED^DSIRRPTR(RPT,.ESTART)
 .S PARRAY(1)="S FRDT="_$G(FRDT),PARRAY(2)="S TODT="_$G(TODT),PARRAY(3)="S DIVL="""_$G(DIVL)_""""
 .D PREPSUB^DSIRRPTR(.AXY,ESTART,RPT,"DTR2^DSIRRPT3",IEN,.PARRAY)
 Q
DTR2(SIEN) ; THIS IS LAUNCHED BY THE TASK MANAGER AND IT REASSEMBLES THE PARAMETERS
 N DONE,FRDT,TODT,DIVL,REQS,PRMS,RET S DONE=0,RET="TASK",ZTREQ="@" I '$$INIT^DSIRRPTR(SIEN) Q
 D DTR3(.RET,FRDT,TODT,DIVL)  I 'DONE,'$$STOPCHK^DSIRRPTR(SIEN) D RPTDONE^DSIRRPTR(SIEN)
 Q
DTR3(AXY,SDATE,EDATE,DIVL) ; RPC - DSIR DELIVERY TYPE SUMMARY RPT
 ; DESCRIPTION
 ; This RPC returns an array for the Delivery Type Summary Report.
 ; The optional date parameters work off of the date closed only.
 ; INPUT PARAMETERS
 ; SDATE - Optional - Report start date in Fileman format
 ; EDATE - Optional - Report end date in Fileman format
 ; DIVL  - Optional - List of selected divisions - NULL means all divisions
 ;
 ; RETURN ARRAY
 ; ##^DESCRIPTION    Where ## = a positive integer count >= Zero
 ;
 ; OR
 ; -1^Error Message
 ;
 N TASK,CDIV,MDIV,DIVS,II,IEN,CTR,QRY,DELIVCD,DIV,DIVISION,RET,STATUS,LOOPCT,LOOPCHK
 S LOOPCT=1,LOOPCHK=50
 S TASK=($G(AXY)="TASK")
 S CDIV=$G(DUZ(2))
 S SDATE=+$G(SDATE),EDATE=+$G(EDATE),(IEN,PREVIEN)=0,QRY=$NA(^DSIR(19620,"ACL",SDATE))
 I 'EDATE D NOW^%DTC S EDATE=X
 S DIVL=$TR($G(DIVL),"~",U),MDIV=$D(^XUSEC("DSIR MDIV",DUZ)) S DIVS=$G(DIVL)]""
 I DIVS F II=1:1:$L(DIVL,U) S:$P(DIVL,U,II) DIVS($P(DIVL,U,II))=""
 S @AXY@("GRAND",0)="^^0^NOT SPECIFIED"
 S @AXY@("GRAND",1)="^^0^IN PERSON"
 S @AXY@("GRAND",2)="^^0^BY MAIL"
 S @AXY@("GRAND",3)="^^0^BY FAX"
 S @AXY@("GRAND",4)="^^0^CD"
 S @AXY@("GRAND",5)="^^0^ELECTRONIC TRANSFER"
 S @AXY@("GRAND","TOT")="^^0^TOTAL"
 F  S QRY=$Q(@QRY) Q:($QS(QRY,3)>EDATE)!($QS(QRY,2)'="ACL")!(DONE)  D
 .I TASK S LOOPCT=LOOPCT+1 I '(LOOPCT#LOOPCHK),SIEN,$$STOPCHK^DSIRRPTR(SIEN) S DONE=1 Q
 .S IEN=$QS(QRY,4),IENS=IEN_"," K RET D GETS^DIQ(19620,IENS,".63;6.07;10.08","IE","RET")
 .S DIV=RET(19620,IENS,.63,"I") Q:'MDIV&(DIV'=CDIV)
 .; Multidivisional Check - Key holder and divisions selected and not a selected division
 .I MDIV,DIVS,'$D(DIVS(DIV)) Q
 .; CHECK FOR A CLOSED AND RELEASED STATUS
 .S STATUS=RET(19620,IENS,10.08,"I") Q:";3;4;26;"'[(";"_STATUS_";")
 .S DIVISION=RET(19620,IENS,.63,"E"),DELIVCD=+$G(RET(19620,IENS,6.07,"I"))
 .I '$D(@AXY@(DIV)) D
 ..S @AXY@(DIV,0)=DIV_U_DIVISION_U_"0^NOT SPECIFIED"
 ..S @AXY@(DIV,1)=DIV_U_DIVISION_U_"0^IN PERSON"
 ..S @AXY@(DIV,2)=DIV_U_DIVISION_U_"0^BY MAIL"
 ..S @AXY@(DIV,3)=DIV_U_DIVISION_U_"0^BY FAX"
 ..S @AXY@(DIV,4)=DIV_U_DIVISION_U_"0^CD"
 ..S @AXY@(DIV,5)=DIV_U_DIVISION_U_"0^ELECTRONIC TRANSFER"
 ..S @AXY@(DIV,"TOT")=DIV_U_DIVISION_U_"0^TOTAL"
 .S $P(@AXY@(DIV,DELIVCD),U,3)=+$P(@AXY@(DIV,DELIVCD),U,3)+1
 .S $P(@AXY@(DIV,"TOT"),U,3)=+$P(@AXY@(DIV,"TOT"),U,3)+1
 .S $P(@AXY@("GRAND",DELIVCD),U,3)=+$P(@AXY@("GRAND",DELIVCD),U,3)+1
 .S $P(@AXY@("GRAND","TOT"),U,3)=+$P(@AXY@("GRAND","TOT"),U,3)+1
 Q:DONE
 I AXY="TASK" D
 .N DATA,DTMP,CT S CT=0,DTMP=$NA(TASK) F  S DTMP=$Q(@DTMP) Q:DTMP']""  S CT=CT+1,DATA(CT)=@DTMP
 .D WP^DIE(19620.35,SIEN_",",2,,"DATA","EMSG") K @AXY
 Q
 ;
RTR(AXY,FRDT,TODT,DIVL,SCHED,ESTART) ; RPC - DSIRRPT3 RTR HOW RECEIVED RPT
 ; INPUT PARAMETERS:
 ;   FRDT = START DATE
 ;   TODT = END DATE
 ;   DIVL = DIVISION LIST
 ;   SCHED  Schedule - Boolean for scheduled or immediate run
 ;          1 = Schedule / 0 or Null = Run Immediately
 ;   ESTART Earliet time to start the scheaduled task
 ;
 ; RETURN ARRAY
 ;   if immediate
 ;   ##^DESCRIPTION    Where ## = a positive integer count >= Zero
 ;   or
 ;   if scheduled
 ;   Task^REPORT AFTER yyymmdd.hhmmss
 ;   or
 ;   -1^Error Message
 ;
 S AXY=$NA(^TMP("DSIRRPT3RTR",$J)),SCHED=+$G(SCHED)
 I 'SCHED D RTR3(.AXY,FRDT,TODT,DIVL)
 I SCHED D
 .N RPT,EMSG,PARRAY,I
 .;CREATE THE REPORT SCHEDULE RECORD, FILE THE PARAMETERS, AND SUBMIT
 .S ESTART=$G(ESTART),RPT="RECEIVED TYPE",IEN=$$UDSCHED^DSIRRPTR(RPT,.ESTART)
 .S PARRAY(1)="S FRDT="_$G(FRDT),PARRAY(2)="S TODT="_$G(TODT),PARRAY(3)="S DIVL="""_$G(DIVL)_""""
 .D PREPSUB^DSIRRPTR(.AXY,ESTART,RPT,"RTR2^DSIRRPT3",IEN,.PARRAY)
 Q
RTR2(SIEN) ; THIS IS LAUNCHED BY THE TASK MANAGER AND IT REASSEMBLES THE PARAMETERS
 N DONE,FRDT,TODT,DIVL,REQS,PRMS,RET S DONE=0,RET="TASK",ZTREQ="@" I '$$INIT^DSIRRPTR(SIEN) Q
 D RTR3(.RET,FRDT,TODT,DIVL)  I 'DONE,'$$STOPCHK^DSIRRPTR(SIEN) D RPTDONE^DSIRRPTR(SIEN)
 Q
RTR3(AXY,SDATE,EDATE,DIVL) ; RECEIVED METHOD
 ; DESCRIPTION
 ; This RPC returns an array for the Received Method Summary Report.
 ; The optional date parameters work off of the date closed only.
 ; INPUT PARAMETERS
 ; SDATE - Optional - Report start date in Fileman format
 ; EDATE - Optional - Report end date in Fileman format
 ; DIVL  - Optional - List of selected divisions - NULL means all divisions 
 ;
 ; RETURN ARRAY
 ; ##^DESCRIPTION    Where ## = a positive integer count >= Zero
 ;
 ; OR
 ; -1^Error Message
 N TASK,CDIV,MDIV,DIVS,II,IEN,CTR,QRY,RECVDCD,DIV,DIVISION,RET,STATUS,LOOPCT,LOOPCHK
 S CDIV=$G(DUZ(2)),LOOPCT=1,LOOPCHK=50
 S TASK=($G(AXY)="TASK")
 I '$D(CDIV) S @RET@(1)="-1^Missing the requestor division or not logged in." Q
 S SDATE=+$G(SDATE),EDATE=+$G(EDATE),(IEN,PREVIEN)=0,QRY=$NA(^DSIR(19620,"AOP",SDATE))
 I 'EDATE D NOW^%DTC S EDATE=X
 S DIVL=$TR($G(DIVL),"~",U),MDIV=$D(^XUSEC("DSIR MDIV",DUZ)) S DIVS=$G(DIVL)]""
 I DIVS F II=1:1:$L(DIVL,U) S:$P(DIVL,U,II) DIVS($P(DIVL,U,II))=""
 S @AXY@("GRAND",0)="^^0^NOT SPECIFIED"
 S @AXY@("GRAND",1)="^^0^IN PERSON"
 S @AXY@("GRAND",2)="^^0^BY MAIL"
 S @AXY@("GRAND",3)="^^0^BY FAX"
 S @AXY@("GRAND",4)="^^0^OTHER"
 S @AXY@("GRAND","TOT")="^^0^TOTAL"
 F  S QRY=$Q(@QRY) Q:($QS(QRY,3)>EDATE)!($QS(QRY,2)'="AOP")!(DONE)  D
 .I TASK S LOOPCT=LOOPCT+1 I '(LOOPCT#LOOPCHK),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) S DONE=1 Q
 .S IEN=$QS(QRY,4),IENS=IEN_"," K RET D GETS^DIQ(19620,IENS,".63;6.08","IE","RET")
 .S DIV=RET(19620,IENS,.63,"I") Q:'MDIV&(DIV'=CDIV)
 .; Multidivisional Check - Key holder and divisions selected and not a selected division
 .I MDIV,DIVS,'$D(DIVS(DIV)) Q
 .S DIVISION=RET(19620,IENS,.63,"E"),RECVDCD=+$G(RET(19620,IENS,6.08,"I"))
 .I '$D(@AXY@(DIV)) D
 ..S @AXY@(DIV,0)=DIV_U_DIVISION_U_"0^NOT SPECIFIED"
 ..S @AXY@(DIV,1)=DIV_U_DIVISION_U_"0^IN PERSON"
 ..S @AXY@(DIV,2)=DIV_U_DIVISION_U_"0^BY MAIL"
 ..S @AXY@(DIV,3)=DIV_U_DIVISION_U_"0^BY FAX"
 ..S @AXY@(DIV,4)=DIV_U_DIVISION_U_"0^OTHER"
 ..S @AXY@(DIV,"TOT")=DIV_U_DIVISION_U_"0^TOTAL"
 .S $P(@AXY@(DIV,RECVDCD),U,3)=+$P(@AXY@(DIV,RECVDCD),U,3)+1
 .S $P(@AXY@(DIV,"TOT"),U,3)=+$P(@AXY@(DIV,"TOT"),U,3)+1
 .S $P(@AXY@("GRAND",RECVDCD),U,3)=+$P(@AXY@("GRAND",RECVDCD),U,3)+1
 .S $P(@AXY@("GRAND","TOT"),U,3)=+$P(@AXY@("GRAND","TOT"),U,3)+1
 Q:DONE
 I AXY="TASK" D
 .N DATA,DTMP,CT S CT=0,DTMP=$NA(TASK) F  S DTMP=$Q(@DTMP) Q:DTMP']""  S CT=CT+1,DATA(CT)=@DTMP
 .D WP^DIE(19620.35,SIEN_",",2,,"DATA","EMSG") K @AXY
 Q
