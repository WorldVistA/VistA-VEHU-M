DSIRRPT2 ;EWL - Document Storage Systems; ROI Report RPC'S ;07/01/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2053  WP^DIE
 ;2056  GETS^DIQ
 ;10000 C^%DTC
 ;10046 EN^XUWORKDY
 ;10060 $$GET1^DIQ(200,duz,.01)
 Q
 ;*****************************************************************************
 ;*****************************************************************************
 ; Turnaround time report
 ;*****************************************************************************
 ;*****************************************************************************
TAT(AXY,FRDT,TODT,DIVL,SCHED,ESTART) ; DSIRRPT2 TTIM TURNAROUND TIME
 ; INPUT PARAMETERS: 
 ;   FRDT = START DATE
 ;   TODT = END DATE
 ;   DIVL = DIVISION LIST
 ;   SCHED  Schedule - Boolean for scheduled or immediate run
 ;          1 = Schedule / 0 or Null = Run Immediately
 ;   ESTART Earliet time to start the scheaduled task
 ; RETURNS AN ARRAY AS FOLLOWS:
 ; Return Array '^' Delimited:
 ;   1  ROI Instance IEN (integer)
 ;   2  Patient/FOIA (text)
 ;   3  Clerk IEN (integer)
 ;   4  Clerk IEN (text)
 ;   5  Work Days to Complete (integer)
 ;   6  Median work days for this clerk (number possible 1 decimal)
 ;   7  Average work days for this clerk (number possible 2 decimals)
 ;   8  Date Request Received (external format)
 ;   9  ROI Instance Closed Date (external format) ***
 ;  10  ROI Instance Current Status (external format)
 ;  11  Division
 ;  12  Division Number
 ;  13  Median work days for this division (number possible 1 decimal)
 ;  14  Average work days for this division (number possible 2 decimals)
 ;  15  Median work days Total (number possible 1 decimal)
 ;  16  Average work days Total (number possible 2 decimals)
 ;
 S AXY=$NA(^TMP("DSIRRPT2TTIM",$J)),SCHED=+$G(SCHED) K @AXY
 I 'SCHED D TAT3(.AXY,FRDT,TODT,DIVL)
 I SCHED D
 .N PARRAY,RPT,EMSG,I
 .;CREATE THE REPORT SCHEDULE RECORD, FILE THE PARAMETERS, AND SUBMIT
 .S RPT="TURNAROUND TIME",ESTART=$G(ESTART),IEN=$$UDSCHED^DSIRRPTR(RPT,.ESTART)
 .S PARRAY(1)="S FRDT="_$G(FRDT),PARRAY(2)="S TODT="_$G(TODT),PARRAY(3)="S DIVL="""_$G(DIVL)_""""
 .D PREPSUB^DSIRRPTR(.AXY,ESTART,RPT,"TAT2^DSIRRPT2",IEN,.PARRAY)
 Q
TAT2(SIEN) ; THIS IS LAUNCHED BY THE TASK MANAGER AND IT REASSEMBLES THE PARAMETERS
 N DONE,FRDT,TODT,DIVL,REQS,PRMS,RET S DONE=0,RET="TASK",ZTREQ="@" I '$$INIT^DSIRRPTR(SIEN) Q
 D TAT3(.RET,FRDT,TODT,DIVL)  I 'DONE,'$$STOPCHK^DSIRRPTR(SIEN) D RPTDONE^DSIRRPTR(SIEN) ;
 Q
TAT3(AXY,STDT,ENDT,DIVL) ; RUN THE TURNAROUND TIME REPORT
 K ^TMP("DSIRTA",$J)
 N CDIV,MDIV,DIVS,OPDT,CLDT,LDT,WRKD,ROI,ROI10,ROI0,II,CLRK,CLRKNAM,CCNT,CWRKD
 N TASK,DIV,DCNT,DWRKD,DAVG,DMED,TCNT,TWRKD,TAVG,TMED
 S TASK=($G(AXY)="TASK") I TASK S AXY=$NA(^TMP("DSIRRPT2TTIM",$J))
 S CDIV=$G(DUZ(2)),(CCNT,DCNT,DCNT,CWRKD,DWRKD,TWRKD)=0,MDIV=$D(^XUSEC("DSIR MDIV",DUZ))
 S STDT=+$G(STDT),ENDT=+$G(ENDT) S:'STDT STDT=0 S:'ENDT ENDT=DT
 S DIVS=$G(DIVL)]"" I DIVS F II=1:1:$L(DIVL,U) S:$P(DIVL,U,II) DIVS($P(DIVL,U,II))=""
 ;
 S LDT=0 I STDT S X1=STDT,X2=-1 D C^%DTC S LDT=X
 F  S LDT=$O(^DSIR(19620,"AFCLD",LDT)) Q:'LDT!(LDT>(ENDT))  D
 .S ROI=0 F  S ROI=$O(^DSIR(19620,"AFCLD",LDT,ROI)) Q:'ROI  D
 ..;
 ..S ROI6=$G(^DSIR(19620,ROI,6)),DIV=$P(ROI6,U,3)
 ..;Multidivisional Check - No key and not in your division
 ..I 'MDIV,DIV'=CDIV Q
 ..;Multidivisional Check - Key holder and divisions selected and not a selected division
 ..I MDIV,DIVS,'$D(DIVS(DIV)) Q
 ..;
 ..S ROI10=$G(^DSIR(19620,ROI,10)),ROI0=$G(^DSIR(19620,ROI,0))
 ..S CLRK=$P(ROI0,U,3),CLRKNAM=$$GET1^DIQ(200,CLRK,.01)
 ..;
 ..S OPDT=$P(ROI10,U,6),CLDT=$P(ROI10,U,7) Q:'CLDT!(CLDT'=LDT)
 ..S WRKD=$$EN^XUWORKDY(OPDT,CLDT)-$$PNDCLR^DSIRRPTF(ROI,ENDT)-$$PAYPND^DSIRRPTF(ROI,ENDT)
 ..S:WRKD<1 WRKD=1
 ..;
 ..S ^TMP("DSIRTA",$J,"CLERK",DIV,CLRK,WRKD,ROI)=""
 ..S ^TMP("DSIRTA",$J,"DIV",DIV,WRKD,ROI)=""
 ..S ^TMP("DSIRTA",$J,"TOT",WRKD,ROI)=""
 ;
 I '$D(^TMP("DSIRTA",$J)) S @AXY@(1)="-1^No Records Found in Date Range!" Q
 ;
 ;PROCESS TOTALS DATA
 S WRKD=0,TCNT=0 F  S WRKD=$O(^TMP("DSIRTA",$J,"TOT",WRKD)) Q:('WRKD)!DONE  D
 .S ROI=0 F  S ROI=$O(^TMP("DSIRTA",$J,"TOT",WRKD,ROI)) Q:'ROI!DONE  D
 ..S TCNT=TCNT+1 I 'TCNT#20,$$STOPCHK^DSIRRPTR(SIEN) K ^TMP("DSIRTA",$J) S DONE=1 Q
 ..S TWRKD=TWRKD+WRKD,^TMP("DSIRTA",$J,"T",TCNT)=WRKD
 S TAVG=((((TWRKD/TCNT)+.005)*100)\1)/100
 I (TCNT\2*2)'=TCNT S TMED=^TMP("DSIRTA",$J,"T",(TCNT\2)+1)
 I TCNT\2*2=TCNT S TMED=(^TMP("DSIRTA",$J,"T",TCNT/2)+^TMP("DSIRTA",$J,"T",(TCNT/2)+1))/2
 S ^TMP("DSIRTA",$J,"TAVG")=TAVG
 S ^TMP("DSIRTA",$J,"TMED")=TMED
 ;
 ;PROCESS DIVISION DATA
 S DIV=0 F  D:DIV>0 DIVSTATS(DIV) S DIV=$O(^TMP("DSIRTA",$J,"DIV",DIV)) Q:'DIV  S DCNT=0 D
 .S WRKD=0 F  S WRKD=$O(^TMP("DSIRTA",$J,"DIV",DIV,WRKD)) Q:'WRKD  D
 ..S ROI=0 F  S ROI=$O(^TMP("DSIRTA",$J,"DIV",DIV,WRKD,ROI)) Q:'ROI  D
 ...S DCNT=DCNT+1,DWRKD=DWRKD+WRKD,^TMP("DSIRTA",$J,"D",DIV,DCNT)=WRKD
 ;
 ;PROCESS CLERK DATA
 S DIV=0 F  S DIV=$O(^TMP("DSIRTA",$J,"CLERK",DIV)) Q:'DIV  D
 .S CLRK=0 F  D:CLRK>0 CLKSTATS(DIV,CLRK) S CLRK=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK)) Q:'CLRK  S CCNT=0 D
 ..S WRKD=0 F  S WRKD=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK,WRKD)) Q:'WRKD  D
 ...S ROI=0 F  S ROI=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK,WRKD,ROI)) Q:'ROI  D
 ....S CCNT=CCNT+1,CWRKD=CWRKD+WRKD,^TMP("DSIRTA",$J,"C",DIV,CLRK,CCNT)=WRKD
 ;
 ;PUT TOGETHER OUTPUT DATA
 S CCNT=0,DIV=0 F  S DIV=$O(^TMP("DSIRTA",$J,"CLERK",DIV)) Q:'DIV  D
 .S CLRK=0 F  S CLRK=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK)) Q:'CLRK  D
 ..S WRKD=0 F  S WRKD=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK,WRKD)) Q:'WRKD  D
 ...S ROI=0 F  S ROI=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK,WRKD,ROI)) Q:'ROI!$$S^%ZTLOAD  D
 ....S CCNT=CCNT+1,@AXY@(CCNT)=$$FORMTAT
 K ^TMP("DSIRTA",$J)
 I TASK,'DONE N CT D WP^DIE(19620.35,SIEN_",",2,"",AXY,"EMSG")
 I TASK K @AXY
 Q
 ;
FORMTAT() ;GETS ROI INFORMATION FOR DISPLAY
 Q:'$G(ROI) ""
 N GETS,FIL,IEN,FLDS,II,FCLD,CURST,XX,Y S XX="",FIL=19620,IEN=ROI_","
 S FLDS=".01;.03;10.06;10.07;.63"
 D GETS^DIQ(FIL,ROI,FLDS,"E","GETS")
 S FCLD=+$$LASTCLDT^DSIROI6(ROI) S:'FCLD FCLD="" I FCLD S Y=FCLD D DD^%DT S FCLD=Y
 S XX=ROI_U_$G(GETS(FIL,IEN,.01,"E"))_U_$P(^DSIR(19620,ROI,0),U,3)_U
 S XX=XX_$G(GETS(FIL,IEN,.03,"E"))_U_WRKD_U
 S XX=XX_^TMP("DSIRTA",$J,"CMED",DIV,CLRK)_U_^TMP("DSIRTA",$J,"CAVG",DIV,CLRK)_U
 S XX=XX_$G(GETS(FIL,IEN,10.06,"E"))_U_$G(GETS(FIL,IEN,10.07,"E"))_U_$P($$STONDAT^DSIROI6(ROI,DT),U,2)_U
 S XX=XX_DIV_U_$G(GETS(FIL,IEN,.63,"E"))_U_^TMP("DSIRTA",$J,"DMED",DIV)_U_^TMP("DSIRTA",$J,"DAVG",DIV)_U
 S XX=XX_^TMP("DSIRTA",$J,"TMED")_U_^TMP("DSIRTA",$J,"TAVG")
 Q XX
 ;
DIVSTATS(DIVSN) ;
 S DAVG=((((DWRKD/DCNT)+.005)*100)\1)/100
 S ^TMP("DSIRTA",$J,"DAVG",DIVSN)=DAVG
 I (DCNT\2*2)'=DCNT S DMED=^TMP("DSIRTA",$J,"D",DIVSN,(DCNT\2)+1)
 I DCNT\2*2=DCNT S DMED=(^TMP("DSIRTA",$J,"D",DIVSN,DCNT/2)+^TMP("DSIRTA",$J,"D",DIVSN,(DCNT/2)+1))/2
 S ^TMP("DSIRTA",$J,"DMED",DIVSN)=DMED
 S DCNT=0,DWRKD=0
 Q
CLKSTATS(DIVSN,CLERK) ;
 S CAVG=((((CWRKD/CCNT)+.005)*100)\1)/100
 S ^TMP("DSIRTA",$J,"CAVG",DIVSN,CLERK)=CAVG
 I (CCNT\2*2)'=CCNT S CMED=^TMP("DSIRTA",$J,"C",DIVSN,CLERK,(CCNT\2)+1)
 I CCNT\2*2=CCNT S CMED=(^TMP("DSIRTA",$J,"C",DIVSN,CLERK,CCNT/2)+^TMP("DSIRTA",$J,"C",DIVSN,CLERK,CCNT/2+1))/2
 S ^TMP("DSIRTA",$J,"CMED",DIVSN,CLERK)=CMED
 S CCNT=0,CWRKD=0
 Q
 ;
 ;****************************************************************************************************
 ;****************************************************************************************************
 ;
PDH(AXY,PAT,FRDT,TODT,PNAME,SCHED,ESTART) ; RPC - DSIRRPT2 PDH PATIENT DISC HIST
 ;Input Parameters
 ;     PAT    - Patient IEN
 ;     FRDT   - Start Date (FM Date Required)
 ;     TODT   - End Date (FM Date Optional - Defaults to current date)
 ;     SCHED  - Schedule - Boolean for scheduled or immediate run
 ;              1 = Schedule / 0 or Null = Run Immediately
 ;     ESTART - Earliet time to start the scheaduled task
 ;
 ;Return Array
 ; -1^Error message
 ; or
 ; The return array will contain strings formatted in groups (one per
 ; request) as follows:
 ;  $$REQUEST$$^IEN^Date Recieved^Requestor^Reason^RequestorType^Status
 ;  $$COMMENT1$$^Comment line 1 text
 ;  $$COMMENT2$$^Comment line 2 text
 ;  $$COMMENT3$$^Comment line 3 text
 ;  $$DOCUMENT$$^Document Caption^Document Date (one line like this for
 ;               each document)
 ;  $$ENDOFDOCS$$
 ;
 S AXY=$NA(^TMP("DSIRRPT2PDH",$J)),SCHED=+$G(SCHED) K @AXY
 ; Check input parameters
 S PAT=$G(PAT),PNAME=$G(PNAME),FRDT=+$G(FRDT),TODT=+$G(TODT) S:'TODT TODT=DT
 I 'FRDT S @AXY@(0)="-1^Missing From or To date!" Q
 I PAT']"" S @AXY@(0)="-1^Must provide patient pointer!" Q
 I '$D(^DSIR(19620,"APTDT",PAT)) S @AXY@(0)="-1^No records found for patient!" Q
 ;
 I 'SCHED D PDH3(.AXY,PAT,FRDT,TODT)
 I SCHED D
 .N RPT,EMSG,PARRAY,I
 .;CREATE THE REPORT SCHEDULE RECORD, FILE THE PARAMETERS, AND SUBMIT
 .S RPT="PATIENT DISCLOSURE HISTORY",ESTART=$G(ESTART),IEN=$$UDSCHED^DSIRRPTR(RPT,.ESTART)
 .S PARRAY(1)="S PAT="""_PAT_"""",PARRAY(2)="S FRDT="_$G(FRDT),PARRAY(3)="S TODT="_$G(TODT),PARRAY(4)="S PNAME="""_PNAME_""""
 .D PREPSUB^DSIRRPTR(.AXY,ESTART,RPT,"PDH2^DSIRRPT2",IEN,.PARRAY)
 Q
 ;
PDH2(SIEN) ; THIS IS LAUNCHED BY THE TASK MANAGER AND IT REASSEMBLES THE PARAMETERS
 N DONE,PAT,FRDT,TODT,PRMS,RET S DONE=0,RET="TASK",ZTREQ="@" I '$$INIT^DSIRRPTR(SIEN) Q
 D PDH3(.RET,PAT,FRDT,TODT)  I 'DONE,'$$STOPCHK^DSIRRPTR(SIEN) D RPTDONE^DSIRRPTR(SIEN) ;
 Q
PDH3(AXY,PAT,FRDT,TODT) ; RPC - DSIR GET PATIENT DISC HIST
 ;
 ; Required fields for this report:
 ;
 ; From 19620      FIELD  From 19620      FIELD
 ; ---------------------  ---------------------
 ; RequestIEN        .01  DateReceived    10.06
 ; Requestor         .11  Reason          10.02
 ; RequestorType   10.04  Status          10.08
 ; Comment           .31
 ;
 ; From 19620.1    FIELD  From 19620      FIELD
 ; ---------------------  ---------------------
 ; DocumentCaption   .05  DocumentDate      .07
 ;
 ; Create and initialize variables
 N LOOPCT,LOOPCHK S LOOPCT=1,LOOPCHK=50
 N FLDS,FLDS1,PATREF,IEN,IENLIST,CTR,CTR2,IENS,CTR3,RETVALS,EMSG,TSTR,DOC,QRY,QQ
 S IENLIST="",(IEN,CTR,CTR2,CTR3)=0,FLDS=".01;10.06;.11;10.02;10.04;10.08;.31",FLDS1=".05,.07"
 S FRDT=FRDT\1-.1,TODT=TODT\1+.1
 ;
 ; GET REQUEST NUMBERS
 F  S FRDT=$O(^DSIR(19620,"APTDT",PAT,FRDT)) Q:'FRDT!(FRDT>TODT)  D
 .S IEN=0 F  S IEN=$O(^DSIR(19620,"APTDT",PAT,FRDT,IEN)) Q:'IEN  S CTR=CTR+1,IENLIST(CTR)=IEN
 ;
 I CTR=0 S @AXY@(0)="-1^Patient has requsts but not in the selected date range!" Q
 ; LOOP THROUGH THE REQUESTS
 F CTR2=1:1:CTR D  Q:DONE
 .S LOOPCT=LOOPCT+1 I ('(LOOPCT#LOOPCHK)),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) S DONE=1 Q
 .S IEN=IENLIST(CTR2),IENS=IEN_","
 .K RETVALS D GETS^DIQ(19620,IENS,FLDS,"E","RETVALS","EMSG")
 .S CTR3=CTR3+1,TSTR="$$REQUEST$$^"_IEN_U
 .S TSTR=TSTR_RETVALS(19620,IENS,10.06,"E")_U
 .S TSTR=TSTR_RETVALS(19620,IENS,.11,"E")_U_RETVALS(19620,IENS,10.02,"E")_U
 .S TSTR=TSTR_RETVALS(19620,IENS,10.04,"E")_U_RETVALS(19620,IENS,10.08,"E")
 .S @AXY@(CTR3)=TSTR
 .S CTR3=CTR3+1,TSTR="$$COMMENT1$$^"_$S($D(RETVALS(19620,IENS,.31,1)):RETVALS(19620,IENS,.31,1),1:""),@AXY@(CTR3)=TSTR
 .S CTR3=CTR3+1,TSTR="$$COMMENT2$$^"_$S($D(RETVALS(19620,IENS,.31,2)):RETVALS(19620,IENS,.31,2),1:""),@AXY@(CTR3)=TSTR
 .S CTR3=CTR3+1,TSTR="$$COMMENT3$$^"_$S($D(RETVALS(19620,IENS,.31,3)):RETVALS(19620,IENS,.31,3),1:""),@AXY@(CTR3)=TSTR
 .;
 .; PROCESS DOCUMENTS HERE
 .S DOC=0,QRY=$NA(^DSIR(19620.1,"B",IEN)),QQ=$Q(@QRY)
 .F  Q:(IEN'=$QS(QQ,3))!DONE  D
 ..S LOOPCT=LOOPCT+1 I ('(LOOPCT#LOOPCHK)),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) S DONE=1 Q
 ..S DOC=$QS(QQ,4),CTR3=CTR3+1,TSTR="$$DOCUMENT$$^"
 ..S TSTR=TSTR_$P(^DSIR(19620.1,DOC,0),U,5)_U_$P(^DSIR(19620.1,DOC,0),U,7),@AXY@(CTR3)=TSTR
 ..S QQ=$Q(@QQ)
 .S CTR3=CTR3+1,TSTR="$$ENDOFDOCS$$",@AXY@(CTR3)=TSTR
 I 'DONE,AXY="TASK" D
 .N DATA,DTMP,CT S CT=0,DTMP=$NA(TASK) F  S DTMP=$Q(@DTMP) Q:DTMP']""  S CT=CT+1,DATA(CT)=@DTMP
 .D WP^DIE(19620.35,SIEN_",",2,,"DATA","EMSG") K @AXY
 Q
BAILOUT2 ;
 Q
