DSIROIR ;DSS/AMC/EWL - Document Storage Systems; ROI Report RPC'S ;04/14/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2056  GETS^DIQ
 ;10003 DD^%DT
 ;10060 $$GET1^DIQ
 Q
PRL(AXY,PAT,STDT,ENDT) ;RPC - DSIRRPT2 PRL PAT REQUEST LIST
 S AXY=$NA(^TMP("DSIRCAS",$J)),PAT=+$G(PAT),STDT=+$G(STDT),ENDT=+$G(ENDT) S:'ENDT ENDT=DT K @AXY
 I 'PAT S ^TMP("DSIRCAS",$J,0)="-1^Must have patient pointer!" Q
 I '$D(^DSIR(19620,"APTDT",PAT_";DPT(")) S ^TMP("DSIRCAS",$J,0)="-2^No records found for patient!"
 N ROI,II,LDT,PTRF S II=0,LDT=STDT\1,ENDT=ENDT+.3,PTRF=PAT_";DPT("
 F  S LDT=$O(^DSIR(19620,"APTDT",PTRF,LDT)) Q:'LDT!(LDT>ENDT)  D
 .S ROI=0 F  S ROI=$O(^DSIR(19620,"APTDT",PTRF,LDT,ROI)) Q:'ROI  S ^TMP("DSIRCAS",$J,II)=ROI,II=II+1
 Q
GETCLRKS(AXY) ;RPC - DSIR CLERKS LIST
 N CLRK,YY,XX S (CLRK,YY)=0,AXY=$NA(^TMP("DSIROICLERKS",$J)) K ^TMP("DSIROICLERKS",$J)
 F  S CLRK=$O(^DSIR(19620,"AE",CLRK)) Q:'CLRK  D
 .S XX=$$GET1^DIQ(200,+CLRK,.01)_U_CLRK,YY=YY+1,^TMP("DSIROICLERKS",$J,YY)=XX
 Q
FRMTRPT(AXY,RL,HDC,FTC,INL,RPT) ; RPC REFORMAT REPORTS
 S AXY=$NA(^TMP("DSIRRPT",$J)) K @AXY
 I '$G(RL)!'$G(INL) S ^TMP("DSIRRPT",$J,0)="-1^Invalid Input!" Q
 S HDC=+$G(HDC),FTC=+$G(FTC)
 N LINE,PP,LDIF,PGS,TXT,HDR,FTR,LN,LNC,TOTLN,TLPP,LIN,BDY S LDIF=INL-RL,TLPP=RL-HDC-FTC,(BDY,TOTLN)=0,LN="" F  S LN=$O(RPT(LN)) Q:LN=""  S TOTLN=TOTLN+1
 F LNC=1:1 S LN=$O(RPT(LN)) Q:LN=""  S TXT(LNC)=RPT(LN)
 S LNC=0 F  S LNC=$O(TXT(LNC)) Q:'LNC  S LIN=LNC#(INL+1) D
 .I HDC,LIN,LIN'>HDC S:'$D(HDR(LIN)) HDR(LIN)=TXT(LNC) K TXT(LNC) Q
 .I LIN,LIN<(INL-FTC+1) S BDY=BDY+1,BDY(BDY)=TXT(LNC) K TXT(LNC) Q
 .I FTC S:'$D(FTR(LIN-LDIF)) FTR(LIN-LDIF)=TXT(LNC)
 .Q
 S LN="A" F  S LN=$O(BDY(LN),-1) Q:'LN!(BDY(LN)]"")  K BDY(LN) S BDY=BDY-1
 S PGS=BDY\TLPP+(''(BDY#TLPP)),LINE=0
 F PP=1:1:PGS D
 .F HDR=1:1:HDC S LINE=LINE+1,^TMP("DSIRRPT",$J,LINE)=HDR(HDR)
 .F LNC=1:1:TLPP S LINE=LINE+1,LIN=+$O(BDY(0)),^TMP("DSIRRPT",$J,LINE)=$G(BDY(LIN)) K BDY(LIN)
 .S FTR=0 F  S FTR=$O(FTR(FTR)) Q:'FTR  S LINE=LINE+1,^TMP("DSIRRPT",$J,LINE)=FTR(FTR)
 .Q
 Q
DISHISTR(AXY,PAT,FRDT,TODT) ; RPC - DSIR GET PATIENT DISC HIST
 ;Input Parameters
 ;               1 - Patient IEN
 ;               2 - Start Date (FM Date Required)
 ;               3 - End Date (FM Date Optional - Defaults to current date)
 ;               
 ;Return Array
 ;               -1^Missing From or To date!
 ;               -2^Must have patient pointer!
 ;               -3^No records found for patient!
 ;               -4^Patient has requsts but not in the selected date range!
 ;      The return array will contain strings formatted in groups (one per request) as follows:
 ;               $$REQUEST$$^IEN^Date Recieved^Requestor^Reason^RequestorType^Status
 ;               $$COMMENT1$$^Comment line 1 text
 ;               $$COMMENT2$$^Comment line 2 text
 ;               $$COMMENT3$$^Comment line 3 text
 ;               $$DOCUMENT$$^Document Caption^Document Date (one line like this for each document)
 ;               $$ENDOFDOCS$$
 ;
 ; Required fields for this report: 
 ;
 ; From 19620      FIELD 
 ; ---------------------
 ; RequestIEN        .01
 ; DateReceived    10.06
 ; Requestor         .11 
 ; Reason          10.02
 ; RequestorType   10.04
 ; Status          10.08
 ; Comment           .31
 ;
 ; From 19620.1    FIELD 
 ; ---------------------
 ; DocumentCaption   .05
 ; DocumentDate      .07 
 ;
 ; Setup return global
 S AXY=$NA(^TMP("DSIRPATDISCHIST",$J)) K ^TMP("DSIRPATDISCHIST",$J)
 ;
 ; Check input parameters 
 S PAT=$G(PAT),FRDT=+$G(FRDT),TODT=+$G(TODT) S:'TODT TODT=DT
 I 'FRDT S ^TMP("DSIRPATDISCHIST",$J,0)="-1^Missing From or To date!" Q
 I '""[PAT S ^TMP("DSIRPATDISCHIST",$J,0)="-2^Must have patient pointer!" Q
 I '$D(^DSIR(19620,"APTDT",PAT)) S ^TMP("DSIRPATDISCHIST",$J,0)="-3^No records found for patient!" Q
 ;
 ; Create and initialize variables
 N FLDS,FLDS1,PATREF,IEN,IENLIST,CTR,CTR2,IENS,CTR3,RETVALS,EMSG,TSTR,DOC,QRY,QQ
 S IENLIST="",(IEN,CTR,CTR2,CTR3)=0,FLDS=".01;10.06;.11;10.02;10.04;10.08;.31",FLDS1=".05,.07"
 S FRDT=FRDT\1-.1,TODT=TODT\1+.1
 ;
 ; GET REQUEST NUMBERS
 F  S FRDT=$O(^DSIR(19620,"APTDT",PAT,FRDT)) Q:'FRDT!(FRDT>TODT)  D
 .S IEN=0 F  S IEN=$O(^DSIR(19620,"APTDT",PAT,FRDT,IEN)) Q:'IEN  S CTR=CTR+1,IENLIST(CTR)=IEN
 ;
 I CTR=0 S ^TMP("DSIRPATDISCHIST",$J,0)="-4^Patient has requsts but not in the selected date range!" Q
 ; LOOP THROUGH THE REQUESTS
 F CTR2=1:1:CTR D
 .S IEN=IENLIST(CTR2),IENS=IEN_","
 .D GETS^DIQ(19620,IENS,FLDS,"E","RETVALS","EMSG")
 .S CTR3=CTR3+1,TSTR="$$REQUEST$$^"_IEN_U
 .S TSTR=TSTR_RETVALS(19620,IENS,10.06,"E")_U
 .S TSTR=TSTR_RETVALS(19620,IENS,.11,"E")_U_RETVALS(19620,IENS,10.02,"E")_U
 .S TSTR=TSTR_RETVALS(19620,IENS,10.04,"E")_U_RETVALS(19620,IENS,10.08,"E")
 .S ^TMP("DSIRPATDISCHIST",$J,CTR3)=TSTR
 .S CTR3=CTR3+1,TSTR="$$COMMENT1$$^"_$S($D(RETVALS(19620,IENS,.31,1)):RETVALS(19620,IENS,.31,1),1:"")
 .S ^TMP("DSIRPATDISCHIST",$J,CTR3)=TSTR
 .S CTR3=CTR3+1,TSTR="$$COMMENT2$$^"_$S($D(RETVALS(19620,IENS,.31,2)):RETVALS(19620,IENS,.31,2),1:"")
 .S ^TMP("DSIRPATDISCHIST",$J,CTR3)=TSTR
 .S CTR3=CTR3+1,TSTR="$$COMMENT3$$^"_$S($D(RETVALS(19620,IENS,.31,3)):RETVALS(19620,IENS,.31,3),1:"")
 .S ^TMP("DSIRPATDISCHIST",$J,CTR3)=TSTR
 .;
 .; PROCESS DOCUMENTS HERE
 .S DOC=0,QRY=$NA(^DSIR(19620.1,"B",IEN)),QQ=$Q(@QRY)
 .F  Q:IEN'=$QS(QQ,3)  D
 ..S DOC=$QS(QQ,4),CTR3=CTR3+1,TSTR="$$DOCUMENT$$^"
 ..S TSTR=TSTR_$P(^DSIR(19620.1,DOC,0),U,5)_U_$P(^DSIR(19620.1,DOC,0),U,7)
 ..S ^TMP("DSIRPATDISCHIST",$J,CTR3)=TSTR
 ..S QQ=$Q(@QQ)
 .S CTR3=CTR3+1,TSTR="$$ENDOFDOCS$$"
 .S ^TMP("DSIRPATDISCHIST",$J,CTR3)=TSTR
 Q
ACCOFDIS(AXY,AODIEN) ; RPC - DSIR GET AOD
 ;Input Parameters
 ;               1 - Request IEN
 ;               
 ;Return Array
 ;               -1^Missing Request IEN!
 ;               -2^Request not found for this IEN: ###.
 ;      The return array will contain strings formatted in groups (one per request) as follows:
 ;               $$AOD$$^IEN^Date Recieved^Requestor^Reason^RequestorType^Status
 ;               $$COMMENT1$$^Comment line 1 text
 ;               $$COMMENT2$$^Comment line 2 text
 ;               $$COMMENT3$$^Comment line 3 text
 ;               $$DOCUMENT$$^Document Caption^Document Date^Document Type^if paper "P" else "" 
 ;                            (one line like this for each document)
 ;               $$PAPER$$^one or more optional records for paper documents.
 ;
 ; Required fields for this report:
 ;
 ; From 19620      FIELD
 ; ---------------------
 ; Requestor Address .81
 ; Patient Address   .82
 ; Current Status  10.05 
 ; Date Received   10.06
 ; Date Closed     10.07
 ; Clerk Assigned    .03
 ; Comment           .31
 ;
 ; From 19620.1    FIELD
 ; ---------------------
 ; DocumentCaption   .05
 ; DocumentDate      .07
 ;
 ; Setup return global
 S AXY=$NA(^TMP("DSIRACCOFDIS",$J)) K ^TMP("DSIRACCOFDIS",$J)
 ;
 ; Check input parameters 
 I 'AODIEN S ^TMP("DSIRACCOFDIS",$J,0)="-1^Missing Request IEN!" Q
 I '$D(^DSIR(19620,AODIEN)) S ^TMP("DSIRACCOFDIS",$J,0)="-2^Request not found for this IEN: "_AODIEN_"." Q
 ;
 ; Create and initialize variables
 N FLDS,FLDS1,FLDS2,IEN,IENS,CTR,RETVALS,EMSG,PIENS,PRETVALS,PEMSG,DOCDAT0
 N RIENS,RRETVALS,REMSG,TSTR,DOC,QRY,QQ,RADPTR,DOCS,WPIEN,RET
 S CTR=0,FLDS=".81;.82;10.05;10.06;10.07;.03;.31",FLDS1=".05,.07"
 S FLDS2=".02;.03;.11;.04;.05;.06"
 ;
 ; GET THE REQUEST DATA
 S IEN=AODIEN,IENS=IEN_","
 D GETS^DIQ(19620,IENS,FLDS,"IE","RETVALS","EMSG")
 S CTR=CTR+1,TSTR="$$AOD$$^"
 S TSTR=TSTR_RETVALS(19620,IENS,10.05,"E")_U_RETVALS(19620,IENS,10.06,"E")_U
 S TSTR=TSTR_RETVALS(19620,IENS,10.07,"E")_U_RETVALS(19620,IENS,.03,"E")
 S ^TMP("DSIRACCOFDIS",$J,CTR)=TSTR,CTR=CTR+1
 S RIENS=RETVALS(19620,IENS,.81,"I"),PIENS=RETVALS(19620,IENS,.82,"I")
 I $G(PIENS)'="" D
 .S PIENS=PIENS_","
 .D GETS^DIQ(19620.92,PIENS,FLDS2,"IE","PRETVALS","PEMSG")
 .S TSTR="$$PAD$$^"_$G(PRETVALS(19620.92,PIENS,.02,"I"))_U_$G(PRETVALS(19620.92,PIENS,.03,"I"))_U
 .S TSTR=TSTR_$G(PRETVALS(19620.92,PIENS,.11,"I"))_U_$G(PRETVALS(19620.92,PIENS,.04,"I"))_U
 .S TSTR=TSTR_$G(PRETVALS(19620.92,PIENS,.05,"E"))_U_$G(PRETVALS(19620.92,PIENS,.06,"I"))
 .S ^TMP("DSIRACCOFDIS",$J,CTR)=TSTR,CTR=CTR+1
 I $G(RIENS)'="" D
 .S RIENS=RIENS_","
 .D GETS^DIQ(19620.92,RIENS_",",FLDS2,"IE","RRETVALS","REMSG")
 .S TSTR="$$RAD$$^"_$G(RRETVALS(19620.92,RIENS,.02,"I"))_U_$G(RRETVALS(19620.92,RIENS,.03,"I"))_U
 .S TSTR=TSTR_$G(RRETVALS(19620.92,RIENS,.11,"I"))_U_$G(RRETVALS(19620.92,RIENS,.04,"I"))_U
 .S TSTR=TSTR_$G(RRETVALS(19620.92,RIENS,.05,"E"))_U_$G(RRETVALS(19620.92,RIENS,.06,"I"))
 .S ^TMP("DSIRACCOFDIS",$J,CTR)=TSTR,CTR=CTR+1
 S CTR=CTR+1,TSTR="$$COMMENT1$$^"_$S($D(RETVALS(19620,IENS,.31,1)):RETVALS(19620,IENS,.31,1),1:"")
 S ^TMP("DSIRACCOFDIS",$J,CTR)=TSTR
 S CTR=CTR+1,TSTR="$$COMMENT2$$^"_$S($D(RETVALS(19620,IENS,.31,2)):RETVALS(19620,IENS,.31,2),1:"")
 S ^TMP("DSIRACCOFDIS",$J,CTR)=TSTR
 S CTR=CTR+1,TSTR="$$COMMENT3$$^"_$S($D(RETVALS(19620,IENS,.31,3)):RETVALS(19620,IENS,.31,3),1:"")
 S ^TMP("DSIRACCOFDIS",$J,CTR)=TSTR
 ;
 ; PROCESS DOCUMENTS HERE
 S DOC=0,QRY=$NA(^DSIR(19620.1,"B",IEN)),QQ=$Q(@QRY)
 F  Q:IEN'=$QS(QQ,3)  D
 .S DOC=$QS(QQ,4),CTR=CTR+1,TSTR="$$DOCUMENT$$^"
 .S DOCDAT0=^DSIR(19620.1,DOC,0)
 .S TSTR=TSTR_IEN_U_$P(DOCDAT0,U,5)_U_$P(DOCDAT0,U,7)_U_$P(DOCDAT0,U,2),^TMP("DSIRACCOFDIS",$J,CTR)=TSTR
 .I $P(DOCDAT0,":",2)=" Paper Doc." D
 ..S Y=$P(DOCDAT0,U,7) D DD^%DT S TSTR="$$PAPER$$^Paper Document Date: "_Y
 ..S CTR=CTR+1,^TMP("DSIRACCOFDIS",$J,CTR)=TSTR
 ..;PROCESS PAPER DOCUMENT WP FIELD
 ..S WPIEN=0,DOCS=DOC_"," K RET D GETS^DIQ(19620.1,DOCS,1,,"RET","ERMSG")
 ..F  S WPIEN=$O(RET(19620.1,DOCS,1,WPIEN)) Q:'WPIEN  D
 ...S TSTR="$$PAPER$$"_U_RET(19620.1,DOCS,1,WPIEN)
 ...S CTR=CTR+1,^TMP("DSIRACCOFDIS",$J,CTR)=TSTR
 .S QQ=$Q(@QQ)
 S ^TMP("DSIRACCOFDIS",$J,CTR)=TSTR
 Q
