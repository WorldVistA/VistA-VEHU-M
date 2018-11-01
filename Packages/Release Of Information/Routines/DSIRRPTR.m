DSIRRPTR ;EWL - Document Storage Systems; ROI Report RPC'S ;07/01/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;**1**;Nov 08, 2011;Build 3
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2053  FILE^DIE
 ;2053  UPDATE^DIE
 ;2053  WP^DIE
 ;2056  GET1^DIQ
 ;2056  GETS^DIQ
 ;2263  GET^XPAR
 ;2263  CHG^XPAR
 ;2340  ^DIK
 ;10000 NOW^%DTC
 ;10000 C^%DTC
 ;10003 DD^%DT
 ;10103 $$FMTH^XLFDT
 ;10063 ^%ZTLOAD
 ;10063 $$ASKSTOP^%ZTLOAD 
 ;10063 $$S^%ZTLOAD
 ;10063 KILL^%ZTLOAD 
 Q
 ;*********************************************************************
 ; This routine contains all of the common calls for control of the 
 ; report scheduling system. 
 ;*********************************************************************
 ;
 ;**********************************************************************
 ; Common Report sub-routines
 ;**********************************************************************
UDSCHED(RPT,ST) ;
 ;-----------------------------------------------------------
 ; CALLED WHEN A SCHEDULED REPORT IS DONE: 
 ;-----------------------------------------------------------
 N NOW,X1,X2,IEN,II,SFDA,IROOT,MROOT S II=-1
 ; Calculate the date to kill the report
 D NOW^%DTC S NOW=% I +$G(ST)<NOW S ST=NOW
 S X1=ST,X2=$$KEEPDAYS D C^%DTC S KDATE=X
 ; Initialize report record
 S SFDA(19620.35,"+1,",.01)=DUZ
 S SFDA(19620.35,"+1,",.02)=RPT
 S SFDA(19620.35,"+1,",.03)="Q"
 S SFDA(19620.35,"+1,",.04)=ST
 S SFDA(19620.35,"+1,",.07)=KDATE
 D UPDATE^DIE(,"SFDA","IROOT","MROOT")
 S II=$O(IROOT(II)),IEN=IROOT(II)
 Q IEN
 ;**********************************************************************
PREPSUB(AXY,ESTART,RPT,RTN,IEN,PRMS) ;
 N SFDA,MROOT,X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC,EMSG
 D WP^DIE(19620.35,IEN_",",1,"","PRMS","EMSG")
 S ZTIO="",ZTDTH=$$FMTH^XLFDT(ESTART)
 S ZTRTN=RTN_"("_IEN_")",ZTDESC="DSIR "_RPT
 D ^%ZTLOAD S TSKNBR=$G(ZTSK)
 K SFDA S SFDA(19620.35,IEN_",",.08)=TSKNBR
 D FILE^DIE(,"SFDA","MROOT")
 ;RETURN REPORT SCHEDULE INFORMATION
 S Y=$S('ESTART:NOW,1:ESTART) D DD^%DT
 S @AXY@(1)=ZTSK_U_"REPORT AFTER "_Y
 Q
 ;*********************************************************************
INIT(SIEN) ;
 ;-----------------------------------------------------------
 ; CALLED WHEN A SCHEDULED REPORT IS STARTED: 
 ;-----------------------------------------------------------
 I $$STOPCHK^DSIRRPTR(SIEN) Q 0
 ;-----------------------------------------------------------
 N SFDA,SIENS,EMSG S SIENS=SIEN_","
 D GETS^DIQ(19620.35,SIENS,1,,"PRMS","MSG")
 S XX=0 F  S XX=$O(PRMS(19620.35,SIENS,1,XX)) Q:'XX  X PRMS(19620.35,SIENS,1,XX)
 S SFDA(19620.35,SIENS,.03)="R"
 D NOW^%DTC S NOW=%,X1=%,X2=$$KEEPDAYS D C^%DTC
 S SFDA(19620.35,SIENS,.05)=NOW
 S SFDA(19620.35,SIENS,.07)=X
 D FILE^DIE(,"SFDA","EMSG")
 Q 1
 ;**********************************************************************
RPTDONE(SIEN) ; 
 ;-----------------------------------------------------------
 ; CALLED WHEN A SCHEDULED REPORT IS DONE: 
 ;-----------------------------------------------------------
 I '$D(^DSIR(19620.35,+$G(SIEN),0)) Q
 N SFDA,SIENS K SFDA,STOPRPT
 S SIENS=SIEN_",",SFDA(19620.35,SIENS,.03)="C"
 D NOW^%DTC S NOW=% S SFDA(19620.35,SIENS,.06)=NOW
 D FILE^DIE(,"SFDA")
 Q
 ;**********************************************************************
KEEPDAYS() ;
 ;**** DSIR REPORT RETENTION PERIOD IS A PACKAGE PARAMETER
 N DAYS S DAYS=$$GET^XPAR("PKG","DSIR REPORT RETENTION PERIOD",1)
 Q DAYS
 ;*********************************************************************
STOPCHK(SIEN) ;
 ;-----------------------------------------------------------
 ; CALLED PERIODICALLY WHEN A SCHEDULED REPORT IS RUNNING 
 ;-----------------------------------------------------------
 Q:'$D(^DSIR(19620.35,+$G(SIEN),0)) "-1^Report Record "_+$G(SIEN)_"Missing!"
 I '$$S^%ZTLOAD Q 0
 S DIK="^DSIR(19620.35,",DA=SIEN D ^DIK
 Q 1
 ;**********************************************************************
 ;**********************************************************************
 ; Report Support API Calls
 ;**********************************************************************
 ;**********************************************************************
 ;
CRPT(RET) ; RPC - DSIRRPTR CRPT CHECK REPORTS
 ; NO INPUT PARAMETERS
 ;
 ;RETURNS in external format:
 ; IEN^CLERK^REPORT NAME^REPORT STATUS^SCHEDULE TIME,RUN TIME^COMPLETION TIME^KILL TIME\^TASK #
 ; NOTE ALL TIMES ARE IN DATE TIME FORMAT
 ; OR
 ; 0^NO RECORDS FOUND
 ; OR
 ; -1^error message
 ;
 N IX,FI,IEN,GET,EMSG S RET=$NA(^TMP("DSIR",$J)),IX="B",FI=19620.35,IEN=0 K @RET
 I 'DUZ S @RET@(1)="-1^YOU MUST BE SIGNED IN TO MAKE THIS CALL" Q
 N CHKDT S CHKDT=$$GET^XPAR("PKG","DSIR REPORT KILL CHECK DATE",1)
 F  S IEN=$O(^DSIR(FI,IX,DUZ,IEN)) Q:'IEN  S IENS=IEN_"," D
 .D GETS^DIQ(FI,IENS,".01;.02;.03;.04;.05;.06;.07;.08","IE","GET","EMSG")
 .Q:GET(FI,IENS,.07,"I")'>(CHKDT-1)
 .S @RET@(IEN)=IEN_U_GET(FI,IENS,.01,"E")_U_GET(FI,IENS,.02,"E")_U_GET(FI,IENS,.03,"E")_U
 .S @RET@(IEN)=@RET@(IEN)_GET(FI,IENS,.04,"E")_U_GET(FI,IENS,.05,"E")_U_GET(FI,IENS,.06,"E")
 .S @RET@(IEN)=@RET@(IEN)_U_GET(FI,IENS,.07,"E")_U_GET(FI,IENS,.08,"E")
 I '$D(@RET) S @RET@(1)="0^NO RECORDS FOUND"
 Q
 ;**********************************************************************
STOP(RET,IEN,WEP) ; RPC - DSIRRPTR STOP CANCEL REPORT
 ;**********************************************************************
 ; INPUT
 ; IEN - internal entry number of the report to delete in file 19620.35
 ; WEP - flag to delete the report with extreme prejudice
 ;
 ; RETURNS
 ;  IEN^A REPORT CANCELLATION HAS BEEN SUBMITTED.
 ;  or 
 ;  IEN^REPORT HAS BEEN CANCELLED.
 ;  or
 ;  REPORT CANNOT BE CANCELLED AT THIS TIME
 ;  or 
 ;  -1^error message 
 ;  
 N ZTSK,TSTAT,ROOT,GET,IENS,FI,RPT,DTIM S IENS=IEN_",",FI=19620.35,WEP=+$G(WEP)
 I '$D(^DSIR(FI,IEN)) S RET="-1^Invalid report IEN requested." Q
 D GETS^DIQ(FI,IENS,".01:.09","I","GET")
 S ZTSK=GET(FI,IENS,.08,"I"),RPT=GET(FI,IENS,.02,"I"),DTIM=GET(FI,IENS,.04,"I")
 S ROOT=$NA(^XTMP("DSIR",DUZ,RPT,DTIM))
 ; REQUEST THE REPORT TO BE STOPPED/CANCELLED/DELETED AND CHECK STATUS
 S TSTAT=$$ASKSTOP^%ZTLOAD(ZTSK),ZTSK=GET(FI,IENS,.08,"I")
 ;-----------------------------------------------------------
 I TSTAT="0^Busy" S RET="1^REPORT CANNOT BE CANCELLED AT THIS TIME" Q:'WEP
 ;-----------------------------------------------------------
 I TSTAT="2^Asked to stop" S RET="1^A REPORT CANCELLATION HAS BEEN SUBMITTED" Q:'WEP
 ;-----------------------------------------------------------
 I TSTAT="1^Finished running"!(TSTAT="2^Unscheduled") D
 .I ZTSK>0 D KILL^%ZTLOAD
 ;-----------------------------------------------------------
 K @ROOT S DIK="^DSIR(19620.35,",DA=IEN D ^DIK
 S RET="1^REPORT HAS BEEN CANCELLED"
 Q
 ;**********************************************************************
CLEAN ; Task to clean up report data
 ;**********************************************************************
 N NOW,KDATE,IEN,FI D NOW^%DTC S NOW=% S FI=19620.35
 ;-----------------------------------------------------------
 ;CLEAN UP THE OLD REPORT ENTRIES IN 19620.35
 S KDATE=0,ZTREQ="@" F  S KDATE=$O(^DSIR(FI,"KILLDT",KDATE)) Q:(KDATE\1>NOW)!('KDATE)  D
 .S IEN=0 F  S IEN=$O(^DSIR(FI,"KILLDT",KDATE,IEN)) Q:'IEN  D
 ..S DIK="^DSIR(FI,",DA=IEN D ^DIK
 Q
KCHK(RET) ; RPC DSIRRPTR KCHK REPORT KILL CHK
 ; NO INPUT PARAMETERS
 ; OUTPUT IS EITHER 
 ;  0 (ZERO) WHICH INDICATES NO ACTION NEEDED
 ;  1 WHICH INDICATES THE REPORT CLEANUP TASK WAS SCHEDULED
 N CHKDT S RET=0,CHKDT=$$GET^XPAR("PKG","DSIR REPORT KILL CHECK DATE",1)
 I CHKDT'<DT Q RET
 D CHG^XPAR("PKG","DSIR REPORT KILL CHECK DATE",1,DT)
 ;-----------------------------------------------------------
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC ; THESE ARE USED BY ^%ZTLOAD
 ;-----------------------------------------------------------
 D NOW^%DTC S ZTIO="",ZTDTH=$$FMTH^XLFDT(%)
 S RET=1,ZTREQ="@",ZTRTN="CLEAN^DSIRRPTR",ZTDESC="DSIR REPORT CLEANUP"
 D ^%ZTLOAD
 Q
 ;**********************************************************************
GETRPT(RET,IEN,STFM,RECS) ; RPC - DSIRRPTR GETRPT GET RPT DATA
 ; INPUT 
 ; IEN - internal entry number of the report
 ; STRM - last record number returned from previous call to this RPC for a given report
 ; RECS - number of records to return
 ; RETURNS ^ delimited array with varied results depending on the report.
 ;  If calling passing in the RECS parameter the last record returned will be:
 ;    '***^' followed by the last record number if there are more or 'EOF' if there are no more records
 ;  or
 ;  -1^error message
 ;
 S STFM=+$G(STFM),RECS=$G(RECS)
 S RET=$NA(^TMP("DSIR",$J)) K @RET
 I '$D(^DSIR(19620.35,IEN)) S @RET@(1)="-1^Invalid report IEN requested" Q
 N FI,IENS,GET,EMSG,CLERK,RPT,SCHDTIME,LREC S LREC=0,FI=19620.35,IENS=IEN_","
 S STATUS=$$GET1^DIQ(FI,IENS,".03","I")
 I STATUS'="C" S @RET@(1)="-1^The selected report is not completed." Q
 I '$O(^DSIR(FI,IEN,2,0)) S @RET@(1)="-1^Nothing was returned for the selected report." Q
 I RECS D  Q  ;
 .N II S DIEN=STFM
 .F II=1:1:RECS S DIEN=$O(^DSIR(FI,IEN,2,DIEN)) Q:'DIEN  S @RET@(DIEN)=$G(^(DIEN,0)),LREC=DIEN
 .S @RET@(LREC+1)="***^"_$S(DIEN:LREC,1:"EOF")
 S DIEN=0 F  S DIEN=$O(^DSIR(FI,IEN,2,DIEN)) Q:'DIEN  S @RET@(DIEN)=$G(^(DIEN,0))
 Q
PRMS(RET,IEN) ; RPC - DSIRRPTR PRMS GET RPT PARAMETERS
 ; INPUT 
 ; IEN - internal entry number of the report
 ; RETURNS ^ delimited array with varied results based on report definitions.
 S RET=$NA(^TMP("DSIR",$J)) K @RET
 I '$D(^DSIR(19620.35,IEN)) S @RET@(1)="-1^Invalid report IEN requested" Q
 N FI,IENS,I,EMSG S FI=19620.35,IENS=IEN_","
 D GETS^DIQ(FI,IENS,"1",,"GET","EMSG")
 I $D(GET) D  Q
 .S I=0 F  S I=$O(GET(FI,IENS,1,I)) Q:'I  D
 ..S @RET@(I)=$P(GET(FI,IENS,1,I),"=",2)
 ..I $L(@RET@(I),"""")>1 S @RET@(I)=$P(@RET@(I),"""",2)
 I '$D(GET) S @RET@(I)="-1^No parameters were returned for the selected report."
 Q 
 ;
MEDCALC(GBL,CT,SS) ; FUNCTION TO RETURN MEDIAN VALUE
 ; note this is called by the FOIA report so be careful if modifying
 N MED,ODD,S1,S2,MIDDLE,CTR
 I CT=0 Q 0
 S CTR=0,MED=0,ODD=CT#2,MIDDLE=CT\2,S1=0,S2=0 S:ODD MIDDLE=MIDDLE+1
 I CT=1 S S1=$O(@GBL@(S1)),MED=S1 Q MED
 F  Q:(CTR=(MIDDLE+1))  S S1=$O(@GBL@(S1)) Q:'S1  S S2=0 D
 .F  S S2=$O(@GBL@(S1,S2)) Q:'S2  D
 ..S CTR=CTR+1
 ..I CTR=MIDDLE S MED=$QS($NA(@GBL@(S1,S2)),SS)
 ..I CTR=(MIDDLE+1) S:'ODD MED=MED+$QS($NA(@GBL@(S1,S2)),SS),MED=(MED/2)\1
 Q MED
