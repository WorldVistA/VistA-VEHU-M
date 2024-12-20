DSIRRPTV ;EWL - Document Storage System;Year End FOIA Report ;04/14/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2053  WP^DIE
 ;2056  GETS^DIQ
 ;10000 ^%DTC
 ;10046 EN^XUWORKDY
 Q
 ;
FOIAV(AXY,FRDT,TODT,DIV,SCHED,ESTART) ;RPC - DSIRRPTV FOIAV FOIA VALIDATION
 ; INPUT 
 ; STDT - REPORT STARTING DATE
 ; ENDT - REPORT ENDING DATE
 ; DIV - DIVISION - REQUIRED FOR MULTIDIVISIONAL USER 
 ; 
 ; RETURNS: GLOBAL ARRAY 
 ; The return array will have the following data (^ delimited)
 ; Piece Description
 ;  1 Request IEN
 ;  2 Patient/FOIA
 ;  3 Date Opened
 ;  4 Date ClosedX
 ;  6 EX3 5705
 ;  7 EX3 7332
 ;  8 EX3 5701
 ;  9 EX3 253B
 ; 10 EX3 APP3
 ; 11 EX3 205
 ; 12 Processed
 ; 13 Pend at Start
 ; 14 Received
 ; 15 Pend at End
 ; 16 Granted
 ; 17 Partial
 ; 18 Denied
 ; 19 Exemption 1
 ; 20 Exemption 2
 ; 21 Exemption 3
 ; 22 Exemption 4
 ; 23 Exemption 5
 ; 24 Exemption 6
 ; 25 Exemption 7A
 ; 26 Exemption 7B
 ; 27 Exemption 7C
 ; 28 Exemption 7D
 ; 29 Exemption 7E
 ; 30 Exemption 7F
 ; 31 Exemption 8
 ; 32 Exemption 9
 ; 33 OTH REAS ND-No Records
 ; 34 OTH REAS ND-Withdrawn
 ; 35 OTH REAS ND-Fee
 ; 36 OTH REAS ND-Not Described
 ; 37 OTH REAS ND-Not Proper FOIA
 ; 38 OTH REAS ND-Not Agency Record
 ; 39 OTH REAS ND-Other
 ; 40 OTH REAS ND-Medically Sensitive
 ; 41 OTH REAS ND-Patient Died Before Completion
 ; 42 OTH REAS ND-Publicly Available
 ; 43 OTH REAS ND-Glomar
 ; 44 OTH REAS ND-Subsumed by Litigation
 ; 45 Perfected
 ; 46 Perf Workdays
 ; 47 Perf Granted
 ; 48 Response <= 20
 ; 49 Response <= 40
 ; 50 Response <= 60
 ; 51 Response <= 80
 ; 52 Response <= 100
 ; 53 Response <= 120
 ; 54 Response <= 140
 ; 55 Response <= 160
 ; 56 Response <= 180
 ; 57 Response <= 200
 ; 58 Response <= 300
 ; 59 Response <= 400
 ; 60 Response > 400
 ; 61 Perf Pending
 ; 62 Perf Pend Days
 ; 63 Exp Requested
 ; 64 Exp Adjudicated
 ; 65 Exp Granted^
 ; 66 Exp Denied
 ; 67 Exp Cal Days
 ; 68 Fee Wav Requested
 ; 69 F W Adjudicated
 ; 70 F W Granted
 ; 71 F W Denied
 ; 72 F W Workdays 
 ;
 ; Example: EXEMP1^12^EXEMPTION 1 
 ;*******************************
 S AXY=$NA(^TMP("DSIRYRFOIAV",$J)) K @AXY
 S SCHED=+$G(SCHED),FRDT=+$G(FRDT),TODT=$S(+$G(TODT):TODT,1:DT)
 I ('FRDT)!('TODT) S @AXY@(1)="-1^Missing Start Date or End Date! Both are required fields" Q
 I 'SCHED D FOIAV3(.AXY,FRDT,TODT,+$G(DIV))
 I SCHED D
 .N RPT,EMSG,PARRAY,I
 .;CREATE THE REPORT SCHEDULE RECORD, FILE THE PARAMETERS, AND SUBMIT
 .S ESTART=$G(ESTART),RPT="FOIA VALIDATION",IEN=$$UDSCHED^DSIRRPTR(RPT,.ESTART)
 .S PARRAY(1)="S FRDT="_$G(FRDT),PARRAY(2)="S TODT="_$G(TODT),PARRAY(3)="S DIV="""_$G(DIV)_""""
 .D PREPSUB^DSIRRPTR(.AXY,ESTART,RPT,"FOIAV2^DSIRRPTV",IEN,.PARRAY)
 Q
FOIAV2(SIEN) ; THIS IS LAUNCHED BY THE TASK MANAGER AND IT REASSEMBLES THE PARAMETERS 
 N DONE,FRDT,TODT,DIVL,REQS,PRMS,RET S DONE=0,RET="TASK",ZTREQ="@" I '$$INIT^DSIRRPTR(SIEN) Q
 D FOIAV3(.RET,FRDT,TODT,DIV)  I 'DONE,'$$STOPCHK^DSIRRPTR(SIEN) D RPTDONE^DSIRRPTR(SIEN) ;
 Q
FOIAV3(AXY,STDT,ENDT,DIV) ;Run FOIA validation task
 N TASK,CDIV,DLIST,NLIST ; THESE LINES ADDED TO CORRECTLY ESTALBLISH THE DIVISION(S)
 S TASK=($G(AXY)="TASK") I TASK S AXY=$NA(^TMP("DSIRYRFOIAV",$J)) K @AXY
 S CDIV=DUZ(2) I $G(DIV)  S DIV=$P(DIV,U)
 I '$G(DIV) S DIV=CDIV
 ;
 N PAREQ,LODT,XRF,WRKD,FIL,STH,STH0,ROI,LXR,QGL,STAD,STDP,GBL,CTR,CNT,YY S YY=0
 N ROI0,ROI10,ROI12,ROI13,ROI4,ROI6,ST2,REQTY,FOPDT,FCLST,FCLDP,FCLDT
 N LOOPCT,LOOPCHK S LOOPCT=1,LOOPCHK=50
 S CNT=0,STDT=+$G(STDT)\1,ENDT=+$G(ENDT)\1,CTR=0
 ;
 D:$D(^DSIR(19620.3,"AFYDIV",ENDT,DIV))
 .S TST=0 F  S TST=$O(^DSIR(19620.3,"AFYDIV",ENDT,DIV,TST)) Q:'TST  S IEN=TST
 D CLEANUP S DONE=0
 ;
 ; TEST FOR OPEN DATES WITHIN RANGE
 S XRF="AOP",LODT=STDT-.1,QGL=$NA(^DSIR(19620,XRF,LODT))
 F  S QGL=$Q(@QGL) Q:(($QS(QGL,2)'=XRF))!($QS(QGL,3)>(ENDT+.3))!DONE  D
 .S LOOPCT=LOOPCT+1 I ('(LOOPCT#LOOPCHK)),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) D CLEANUP Q
 .S ROI=$QS(QGL,4) D CHK
 Q:DONE
 ;
 ; CHECK FOR CLOSED DATE IN RANGE
 S XRF="ACL",LODT=STDT-.1,QGL=$NA(^DSIR(19620,XRF,LODT))
 F  S QGL=$Q(@QGL) Q:($QS(QGL,2)'=XRF)!DONE  S ROI=$QS(QGL,4) D
 .S LOOPCT=LOOPCT+1 I ('(LOOPCT#LOOPCHK)),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) D CLEANUP Q
 .D:'$D(^TMP("DSIR20",$J,ROI,"V")) CHK
 Q:DONE
 ; 
 ; CHECK IF THE REQUEST IS STILL OPEN OR PENDING
 S XRF="AFOIA",QGL=$NA(^DSIR(19620,XRF))
 F  S QGL=$Q(@QGL) Q:($QS(QGL,2)'=XRF)!DONE  S ROI=$QS(QGL,3) D
 .S LOOPCT=LOOPCT+1 I ('(LOOPCT#LOOPCHK)),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) D CLEANUP Q
 .D:'$D(^TMP("DSIR20",$J,ROI,"V")) CHK
 Q:DONE
 ;
 ;GET TOTALS AND DELETE TEMP GLOBALS
 D TOTALS Q:DONE
 K ^TMP("DSIR20",$J),^TMP("DSIR",$J),^TMP("DSIR91",$J),^TMP("DSIR20",$J)
 K ^TMP("DSIRFWADJ",$J),^TMP("DSIREXPADJ",$J),^TMP("DSIRROI",$J)
 I TASK,'DONE N CT D WP^DIE(19620.35,SIEN_",",2,"",AXY,"EMSG") K @AXY
 Q
 ;*****
CHK ;
 N ROISTAT,AUTH,TYPORQ,DIVT,ABC,R5,QQ
 S ABC=""
 ; DIVISION CHECK
 S DIVT=$P($G(^DSIR(19620,ROI,6)),U,3) Q:DIVT'=DIV
 ; NODE 10 CONTAINS REQUEST INFO (TYPE, REASON, AUTHORITY, 
 ; REQUESTOR TYPE, STATUS, RECEIVED DATE, CLOSED DATE AND DISPOSITION)
 S ROI10=$G(^DSIR(19620,ROI,10))
 ; ZERO NODE CONTAINS PATIENT, CLERK AND EXPEDITED DATA 
 S ROI0=$G(^DSIR(19620,ROI,0))
 ; PAREQ=0 IF FOIA OTHERWISE IT IS A 1
 S PAREQ=$P(ROI0,U)'="1;DSIR(19620.95,"
 ; GET THE CURRENT STATUS
 S ROISTAT=$P(ROI10,U,8)
 ;Request counted in previous time period?
 S FOPDT=+$P(ROI10,U,6),FCLDT=+$P(ROI10,U,7)
 S:FCLDT FCLST=ROISTAT
 I FCLDT>0,FCLDT<STDT Q
 ;Request opened after report time period?
 I FOPDT>ENDT Q
 ;EXCLUDE if request was ever marked with an error status
 S QQ=$Q(^DSIR(19620.91,"AREQFSC",ROI,17))
 I $QS(QQ,4)=17,$QS(QQ,3)=ROI D REAS(5,"ERROR") S ^TMP("DSIROIRV",$J,ROI)=ABC Q
 ; EXCLUDE IF GRANTED, OPEN, DUPLICATE, REFERRAL OR ANY PENDING STATUS AND 1ST OR 3RD PARTY
 ; (PENDING PAYMENT RELEASED IS A CLOSED STATUS AND IS TREATE LIKE CLOSED GRANTED)
 ;
 ; SETUP STATUS AND AUTHORIZATION WITH LEADING AND TRAILING "^" DELIMITERS.
 S R5="" I PAREQ D
 .I ROISTAT=3 S R5="CLOSED GRANTED" Q
 .I ROISTAT=1 S R5="OPEN" Q
 .I ROISTAT=2 S R5="PENDING" Q
 .I ROISTAT=19 S R5="PENDING CLARIFICATION" Q
 .I ROISTAT=25 S R5="PENDING PAYMENT HELD" Q
 .I ROISTAT=26 S R5="PENDING PAYMENT RELEASED" Q
 .I ROISTAT=18 S R5="PENDING PAYMENT" Q
 I ROISTAT=14 S R5="APPEALED REVERSED"
 I ROISTAT=15 S R5="APPEALED PARTIAL REVERSED"
 I ROISTAT=7 S R5="REFERRAL"
 I ROISTAT=12 S R5="DUPLICATE"
 ; GET THE REQUEST TYPE
 S TYPORQ=+ROI10
 ; GET THE REASON FOR REQUEST
 S RQREAS=+$P(ROI10,U,2)
 ; GET THE AUTHORITY
 S AUTH=+$P(ROI10,U,3)
 ; GET THE REQUESTOR TYPE
 S RQSTRTYP=+$P(ROI10,U,4)
 ;EXCLUDE IF MEDICAL FORMS
 I (RQREAS=11)!(TYPORQ=5) S R5="MEDICAL FORMS"
 ;EXCLUDE IF STATE REPORTING
 I (RQREAS=8)!(TYPORQ=4) S R5="STATE REPORTING"
 ;EXCLUDE IF SOCIAL SECURITY
 I RQSTRTYP=8 S R5="SOCIAL SECURITY ADMIN"
 ;EXCLUDE IF OTHER FEDERAL AGENCY
 I RQSTRTYP=11 S R5="OTHER FEDERAL AGENCY"
 ;EXCLUDE IF MEDICAL FORMS OR STATE REPORTING
 ;
 I R5'="" D REAS(5,R5) S ^TMP("DSIROIRV",$J,ROI)=ABC Q
 ;
 D REAS(5,"NO") S ^TMP("DSIROIRV",$J,ROI)=ABC
 ;
 ; This request is a Keeper!
 S ^TMP("DSIR20",$J,ROI,"V")="",CTR=CTR+1
 Q 
 ;
TOTALS ;
 S ROI=0 F  S ROI=$O(^TMP("DSIROIRV",$J,ROI)) Q:('ROI)!DONE  S XX=$G(^TMP("DSIROIRV",$J,ROI)) D
 .I TASK S LOOPCT=LOOPCT+1 I ('(LOOPCT#LOOPCHK)),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) D CLEANUP Q
 .N GET,IENS,GLDX,ABC S IENS=ROI_",",GLDX="DSIROIRV"
 .D GETS^DIQ(19620,ROI,".01;10.06;10.07","EI","GET")
 .S ABC=^TMP("DSIROIRV",$J,ROI),$P(ABC,U,1)=ROI
 .S $P(ABC,U,2)=$G(GET(19620,IENS,.01,"E"),"Unknown")
 .S $P(ABC,U,3)=$S($G(GET(19620,IENS,10.06,"I")):$G(GET(19620,IENS,10.06,"E")),1:$$FMDT($P($G(^TMP("DSIR20",$J,ROI)),U)))
 .S $P(ABC,U,4)=$S($G(GET(19620,IENS,10.07,"I")):$G(GET(19620,IENS,10.07,"E")),1:$$FMDT($P($G(^TMP("DSIR20",$J,ROI)),U,2)))
 .S $P(ABC,U,72)=""
 .; ZERO NODE CONTAINS PATIENT, CLERK AND EXPEDITED DATA 
 .S ROI0=$G(^DSIR(19620,ROI,0))
 .S ROI10=$G(^DSIR(19620,ROI,10))
 .; PAREQ=0 IF FOIA OTHERWISE IT IS A 1
 .S PAREQ=$P(ROI0,U)'="1;DSIR(19620.95,"
 .S FOPDT=$P(ROI10,U,6),FCLDT=$P(ROI10,U,7),FCLST=$P(ROI10,U,8)
 .; NODE 4 CONTAINS FEE WAIVER INFORMATION
 .S ROI4=$G(^DSIR(19620,ROI,4))
 .D EXPPROC,FWPROC
 .;
 .; STOP PROCESSING IF ANY REASON FOR EXCLUSION
 .I $P(ABC,U,5)'="NO" S @AXY@(ROI)=ABC Q
 .; NODE 12 EXEMPTION DATA
 .S ROI12=$G(^DSIR(19620,ROI,12))
 .; NODE 13 EXEMPTION 3 STATUTES
 .S ROI13=$G(^DSIR(19620,ROI,13))
 .;*********************************
 .S ^TMP("DSIR20",$J,ROI,"V")="",CTR=CTR+1
 .;WAS THIS REQUEST PENDING AT START OF REPORTING PERIOD?
 .I '$D(^TMP("DSIR20",$J,ROI,"NBRPNDST")) D
 ..I FOPDT<STDT S ^TMP("DSIR20",$J,ROI,"NBRPNDST")="" D REAS(13) ;Pending at start
 .;
 .;WAS THIS REQUEST OPENED DURING THE REPORTING PERIOD?
 .I '$D(^TMP("DSIR20",$J,ROI,"NBRRECVD")) D
 ..I FOPDT'<STDT S ^TMP("DSIR20",$J,ROI,"NBRRECVD")="" D REAS(14) ;Opened during
 .;
 .;WAS THIS REQUEST CLOSED DURING THE REPORTING PERIOD?
 .I FCLDT,FCLDT'>ENDT,'$D(^TMP("DSIR20",$J,ROI,"NBRPROCD")) D 
 ..S ^TMP("DSIR20",$J,ROI,"NBRPROCD")="" D REAS(12)
 ..D RQSTCTS,STATPROC
 .S:FOPDT<STDT FOPDT=STDT
 .;
 .;WAS THIS REQUEST PENDING AT END OF REPORTING PERIOD?
 .I '$D(^TMP("DSIR20",$J,ROI,"NBRPNDED")) I 'FCLDT!(FCLDT>ENDT) D
 ..S FCLDT=ENDT,^TMP("DSIR20",$J,ROI,"NBRPNDED")=""
 ..D REAS(15),STATPEND ;EXPPROC,FWPROC ;Pending at end
 .S STH=0 F  S STH=$O(^DSIR(19620.91,"B",ROI,STH)) Q:'STH  D
 ..S STH0=$G(^DSIR(19620.91,STH,0)),STAD=$P(STH0,U,3),ST=$P(STH0,U,2)
 ..S CLDT=$P(ROI10,U,7) S:CLDT>ENDT CLDT=""
 ..I STAD'<STDT,STAD'>ENDT S ^TMP("DSIR20",$J,ROI)=FOPDT_U_CLDT,^TMP("DSIR20",$J,ROI,STH)=""
 .S ^TMP("DSIR20",$J,ROI,"V")=""
 .S ^TMP("DSIROIRV",$J,ROI)=ABC
 .S @AXY@(ROI)=ABC
 Q
RQSTCTS ; REQUESTS (ALL)
 ; NO NEED TO PROCESS EXEMPTIONS FOR MOST STATUSES
 ;
 ; GRANTED (3)OR PENDING PAYMENT RELEASED (26)CANCELLED(16)
 I (FCLST=3)!(FCLST=26) D REAS(16) Q
 ;
 ; THESE ARE ALL OTHER NON DISCLOSURES
 ;
 ; NO RECORD
 I FCLST=6 D REAS(33) Q 
 ; Cancelled (16) = WITHDRAWN 
 I FCLST=16 D REAS(34) Q
 ; FEE RELATED (11)
 I FCLST=11  D REAS(35) Q
 ; NOT DESCRIBED (8)
 I FCLST=8 D REAS(36) Q
 ; NOT A PROPER FOIA (13)
 I FCLST=13 D REAS(37) Q
 ; NOT AN AGENCY RECORD (9)
 I FCLST=9 D REAS(38) Q
 ; OTHER (10) - GOING AWAY 
 I FCLST=10 D REAS(39) Q
 ; MEDICALLY SENSITIVE (20)
 I FCLST=20 D REAS(40) Q
 ; PATIENT DIED (21)
 I FCLST=21 D REAS(41) Q
 ; PUBLICLY AVAILABLE (22)
 I FCLST=22 D REAS(42) Q
 ; GLOMAR (23)
 I FCLST=23 D REAS(43) Q
 ; SUBSUMED BY LITIGATION(24)
 I FCLST=24 D REAS(44) Q
 ;************************
 ; CLOSED PARTIAL/DENIED WITH EXEMPTIONS
 ; PARTIAL REQUESTS
 I FCLST=4 D REAS(17)
 ; DENIED REQUESTS
 I FCLST=5 D REAS(18)
 ;
 ;EXEMPTION PROCESSING
 ; EX 1
 I $P(ROI12,U,1) D REAS(19)
 ; EX 2
 I $P(ROI12,U,2) D REAS(20)
 ; EX 3
 I +$P(ROI12,U,3) D
 .;IF EXEMPTION 3 THEN INCREMENT AND PROCESS STATUTES
 .D REAS(21)
 .; 5701
 .I $P(ROI13,U) D REAS(8)
 .; 5705
 .I $P(ROI13,U,2) D REAS(6)
 .; 205
 .I $P(ROI13,U,3) D REAS(11)
 .; 7332
 .I $P(ROI13,U,4) D REAS(7)
 .; 253B
 .I $P(ROI13,U,11) D REAS(9)
 .; APP3
 .I $P(ROI13,U,12) D REAS(10)
 ; EX 4
 I $P(ROI12,U,4) D REAS(22)
 ; EX 5
 I $P(ROI12,U,5) D REAS(23)
 ; EX 6
 I $P(ROI12,U,6) D REAS(24)
 ; EX 7A
 I $P(ROI12,U,7) D REAS(25)
 ; EX 7B
 I $P(ROI12,U,8) D REAS(26)
 ; EX 7C
 I $P(ROI12,U,9) D REAS(27)
 ; EX 7D
 I $P(ROI12,U,10) D REAS(28)
 ; EX 7E
 I $P(ROI12,U,11) D REAS(29)
 ; EX 7F
 I $P(ROI12,U,12) D REAS(30)
 ; EX 8
 I $P(ROI12,U,13) D REAS(31)
 ; EX 9
 I $P(ROI12,U,14) D REAS(32)
 Q
 ;**********
EXPPROC ; EXPEDITED PROCESSING
 N EXPR,EXPDT,ADJDT,EXADJ,EXGR,EXADJDYS,X1,X2 S (EXADJ,GRNT,EXADJDYS)=0
 ; ALREADY PROCESSED THIS ONE
 Q:$D(^TMP("DSIREXPADJ",$J,"TRACK",ROI))
 ; DO NOT COUNT IF CLOSED WITHIN 10 DAYS OF OPEN
 I +FCLDT S X2=FOPDT,X1=+FCLDT D ^%DTC Q:X<10
 S EXPR=+$P(ROI0,U,4) Q:'EXPR  S EXPDT=+$P(ROI0,U,6) Q:'EXPDT
 S ADJDT=+$P(ROI0,U,8)
 ;******** PROCESS *********
 S ^TMP("DSIREXPADJ",$J,"TRACK",ROI)="" D REAS(63)
 S EXADJ=+$P(ROI0,U,7) D:EXADJ REAS(64) D
 .; GRANTED OR DENIED 
 .S EXGR=+$P(ROI0,U,5) D REAS($S(EXGR:65,1:66))
 .; CALENDAR DAYS TO ADJUDICATE
 .S X2=EXPDT,X1=ADJDT D ^%DTC S EXADJDYS=$S(X:X,1:1) D REAS(67,EXADJDYS)
 Q
 ;********
FWPROC ; FEE WAIVER PROCESSING
 N FWR,FWRDT,ADJDT,FWADJ,FWGR,FWADJDYS S (FWADJ,FWGR,FWADJDYS)=0
 ; ALREADY PROCESSED THIS ONE
 Q:$D(^TMP("DSIRFWADJ",$J,"TRACK",ROI))
 S FWR=+$P(ROI4,U,1) Q:'FWR  S FWRDT=+$P(ROI4,U,2) Q:'FWRDT
 ;S ADJDT=$P(ROI4,U,4) Q:(FWRDT<(STDT-.1))&(ADJDT<(STDT-.1))
 S ADJDT=$P(ROI4,U,4)
 ;******** PROCESS *********
 S ^TMP("DSIRFWADJ",$J,"TRACK",ROI)="" D REAS(68)
 S FWADJ=+$P(ROI4,U,3) I FWADJ D:FWADJ REAS(69) D
 .; GRANT OR DENY ^
 .S FWGR=+$P(ROI4,U,5) D REAS($S(FWGR:70,1:71))
 .; WORK DAYS TO ADJUDICATE
 .S FWADJDYS=$$EN^XUWORKDY(FWRDT,ADJDT) S:'FWADJDYS FWADJDYS=1 D REAS(72,FWADJDYS)
 Q
 ;*****
STATPROC ; STATISTICS FOR PERFECTED CLOSED REQUESTS
 I $$PERFCHK^DSIRRPTF(0) D REAS(45) D
 .N WRKDT,WORKDAYS
 .S WRKDT=+$P(ROI10,U,6)
 .S WORKDAYS=$$EN^XUWORKDY(WRKDT,FCLDT)-$$PNDCLR^DSIRRPTF(ROI,ENDT)-$$PAYPND^DSIRRPTF(ROI,ENDT)
 .N STATUS S STATUS=U_$P(ROI10,U,8)_U
 .D:"^3^26^"[STATUS REAS(47)
 .S:WORKDAYS<1 WORKDAYS=1 D REAS(46,WORKDAYS)
 .I WORKDAYS<21 D REAS(48,WORKDAYS) Q
 .I WORKDAYS<41 D REAS(49,WORKDAYS) Q
 .I WORKDAYS<61 D REAS(50,WORKDAYS) Q
 .I WORKDAYS<81 D REAS(51,WORKDAYS) Q
 .I WORKDAYS<101 D REAS(52,WORKDAYS) Q
 .I WORKDAYS<121 D REAS(53,WORKDAYS) Q
 .I WORKDAYS<141 D REAS(54,WORKDAYS) Q
 .I WORKDAYS<161 D REAS(55,WORKDAYS) Q
 .I WORKDAYS<181 D REAS(56,WORKDAYS) Q
 .I WORKDAYS<201 D REAS(57,WORKDAYS) Q
 .I WORKDAYS<301 D REAS(58,WORKDAYS) Q
 .I WORKDAYS<401 D REAS(59,WORKDAYS) Q
 .I WORKDAYS>400 D REAS(60,WORKDAYS)
 Q
 ;*******
STATPEND ; STATISTICS FOR PENDING REQUESTS
 N OPDT,WRKD S OPDT=+$P(ROI10,U,6)
 S WRKD=$$EN^XUWORKDY(OPDT,ENDT)-$$PNDCLR^DSIRRPTF(ROI,ENDT)-$$PAYPND^DSIRRPTF(ROI,ENDT)
 S:WRKD<1 WRKD=1
 I $$PERFCHK^DSIRRPTF(1) D REAS(61),REAS(62,WRKD)
 Q
 ;*******
REAS(XX,YY) ;
 S $P(ABC,U,XX)=$S($G(YY)]"":YY,1:1)
 Q
 ;*******
FMDT(Y) ;
 Q:'Y ""
 X ^DD("DD")
 Q Y
 ;*******
CLEANUP ;
 S DONE=1
 K ^TMP("DSIR",$J),^TMP("DSIR91",$J),^TMP("DSIR20",$J),^TMP("DSIROIRV",$J)
 K ^TMP("DSIRFWADJ",$J),^TMP("DSIREXPADJ",$J),^TMP("DSIRROI",$J),@AXY
 Q
