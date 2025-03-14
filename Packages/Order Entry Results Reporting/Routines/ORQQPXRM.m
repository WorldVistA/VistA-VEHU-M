ORQQPXRM ;SLC/PJH - Functions for reminder data ;08/17/2018
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,116,173,187,190,215,243,306,389,377,405**;Dec 17, 1997;Build 212
 ;
 ;ORQQPXRM DIALOG ACTIVE
ACTIVE(ORY,ORLIST) D ACTIVE^PXRMRPCC(.ORY,.ORLIST) Q  ; DBIA 3080
 ;
 ;ORQQPXRM REMINDER EVALUATION
ALIST(ORY,ORPT,ORLIST) D ALIST^PXRMRPCA(.ORY,.ORPT,.ORLIST) Q  ; DBIA 3078
 ;
 ;ORQQPXRM REMINDERS APPLICABLE
APPL(ORY,ORPT,ORLOC) D EVALCOVR^ORQQPX(.ORY,ORPT,ORLOC) Q
 ;
 ;ORQQPXRM REMINDER CATEGORIES
CATEGORY(ORY,ORPT,ORLOC) ;
 D CATEGORY^PXRMRPCA(.ORY,ORPT,ORLOC) Q  ; DBIA 3078
 ;
 ;ORQQPXRM REMINDER DIALOG
DIALOG(ORY,ORREM,DFN,VISITID) D DIALOG^PXRMRPCC(.ORY,ORREM,DFN,VISITID) Q  ; DBIA 3080
 ;
 ;ORQQPXRM EDUCATION SUBTOPICS
EDS(ORY,OREDU) D EDS^PXRMRPCB(.ORY,OREDU) Q  ; DBIA 3079
 ;
 ;ORQQPXRM EDUCATION SUMMARY
EDL(ORY,OREM) D EDL^PXRMRPCB(.ORY,OREM) Q  ; DBIA 3079
 ;
 ;ORQQPXRM EDUCATION TOPIC
EDU(ORY,OREDU) D EDU^PXRMRPCB(.ORY,OREDU) Q  ; DBIA 3079
 ;
 ;ORQQPXRM PROGRESS NOTE HEADER
HDR(ORY,ORLOC) D HDR^PXRMRPCC(.ORY,ORLOC) Q  ; DBIA 3080
 ;
 ;ORQQPXRM REMINDERS UNEVALUATED
LIST(ORY,ORPT,ORLOC) D GETLIST^ORQQPX(.ORY,ORLOC) Q
 ;
 ;ORQQPXRM MENTAL HEALTH
MH(ORY,OTEST) ;
 D MH^PXRMRPCC(.ORY,OTEST)  ; DBIA 3080
 S ORY(0)=0
 I $$PATCH^XPDUTL("YS*5.01*85") S ORY(0)=1
 Q
 ;
MHDLL(ORY,DFN,INPUTS,DIEN) ;
 N CNT,CNT1,ORRESULT,ORSCORES,TEXT
 F TEXT="RESULTS","SCORES" D
 .S CNT=0,CNT1=0
 .F  S CNT=$O(INPUTS(TEXT,CNT)) Q:CNT=""  D
 ..S CNT1=CNT1+1
 ..I TEXT="RESULTS" S ORRESULT(CNT1)=$G(INPUTS(TEXT,CNT))
 ..I TEXT="SCORES" S ORSCORES(CNT1)=$G(INPUTS(TEXT,CNT))
 D MHDLL^PXRMDRSG(.ORY,.ORRESULT,.ORSCORES,DFN,DIEN)
 Q
 ;
 ;ORQQPXRM MENTAL HEALTH RESULTS
MHR(ORY,RESULT,ORES) ;
 ; DBIA 3080
 D MHR^PXRMRPCC(.ORY,RESULT,.ORES)
 Q
 ;
 ;ORQQPXRM MENTAL HEALTH SAVE
MHS(ORY,ORES) D MHS^PXRMRPCC(.ORY,.ORES) Q  ; DBIA 3080
 ;
MHV(ORY,DFN,NAME,ANS) ;
 N ORDATA,ORES,X
 S ORY(0)=0
 I '$$PATCH^XPDUTL("YS*5.01*85") S ORY(0)=2 Q
 I '$L(ANS) Q
 S ORES("DFN")=DFN,ORES("CODE")=NAME
 F X=1:1:$L(ANS) I $E(ANS,X)'="X" D
 .;I $E(ANS,X)="T" S $E(ANS,X)=1
 .;I $E(ANS,X)="F" S $E(ANS,X)=2
 .S ORES(X)=X_U_$E(ANS,X)
 D CHECKCR^YTQPXRM4(.ORDATA,.ORES)
 I $G(ORDATA(2))="OK" S ORY(0)=1 Q
 S ORY(1)=$P($G(ORDATA(2)),U,2)
 Q
 ;
 ;ORQQPXRM MST UPDATE
MST(ORY,ORPT,ORDATE,ORSTAT,ORPROV,ORFTYP,ORFIEN,ORRES) ;
 D MST^PXRMRPCC(.ORY,ORPT,ORDATE,ORSTAT,ORPROV,ORFTYP,ORFIEN,ORRES) Q
 ;
 ;ORQQPXRM WOMEN HEALTH RESULT
WH(ORY,ORRESULT) ;
 D WH^PXRMRPCC(.ORY,.ORRESULT) Q
 ;
WHLETTER(ORY,ORIEN) ;
 D LETTER^WVRPCNO1(.ORY,ORIEN) Q
 ;
WHREPORT(ORY,ORIEN) ;
 D RESULTS^WVALERTF(.ORY,ORIEN) Q
 ;
 ;ORQQPXRM DIALOG PROMPTS
PROMPT(ORY,ORDLG,ORDCUR,ORFTYP,ORIEN,NDATA) ;
 D PROMPT^PXRMRPCC(.ORY,ORDLG,ORDCUR,ORFTYP,ORIEN,.NDATA) Q  ; DBIA 3080
 ;
 ;ORQQPXRM REMINDER DETAIL
REMDET(ORY,ORPT,ORIEN) D REMDET^PXRMRPCA(.ORY,ORPT,ORIEN) Q  ; DBIA 3078
 ;
 ;ORQQPXRM REMINDER INQUIRY
RES(ORY,ORREM) D RES^PXRMRPCC(.ORY,ORREM) Q  ; DBIA 3080
 ;
 ;ORQQPXRM REMINDER WEB
WEB(ORY,ORREM) D WEB^PXRMRPCA(.ORY,ORREM) Q  ; DBIA 3078
 ;
 ;PXRM REMINDER DIALOG (TIU)
TDIALOG(ORY,ORDLG,DFN,VISITID) D DIALOG^PXRMRPCD(.ORY,ORDLG,DFN,VISITID) Q
 ;
ACT(REM) ;ORQQPX SEARCH ITEMS - XPAR value screen for active reminders
 ;Treat a null value as inactive
 I 'REM Q 0
 ;Check IF inactive flag is set
 I ($T(INACTIVE^PXRM)'=""),$$INACTIVE^PXRM(REM) Q 0 ; DBIA 2182
 ;Otherwise active
 Q 1
 ;
REMVER(ORLIST) ;
 S ORLIST=$$VERSION^XPDUTL("PXRM")
 Q
 ;
GEC(ORRESULT,IEN,DFN,VISIT,NOTEIEN) ;
 D API^PXRMGECU(.ORRESULT,IEN,DFN,VISIT,1,NOTEIEN)
 Q
 ;
GECF(RESULT,DFN,FIN) ;
 D FINISHED^PXRMGECU(DFN,FIN)
 Q
 ;
GECP(RESULT,DFN) ;
 S RESULT=$$STATUS^PXRMGECU(DFN)
 Q
 ;
 ;ORQQPXRM REMINDER LINK SEQ
AFFSEQ(RESULT,LINK) D GETLSEQ^PXRMDLLB(.RESULT,+$G(LINK)) Q
 ;
