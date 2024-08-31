ORQQCN ; SLC/CLA/REV - Functions which return patient consult requests and results ; APR 30, 2024@15:56
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,620**;Dec 17, 1997;Build 2
LIST(ORY,ORPT,ORSDT,OREDT,ORSERV,ORSTATUS) ; return patient's consult requests between start date and stop date for the service and status indicated:
 N I,J,SITE,SEQ,DIFF,ORSRV,ORLOC,GMRCOER
 S J=1,SEQ="",GMRCOER=2
 S:'$L($G(ORSDT)) ORSDT=""
 S:'$L($G(OREDT)) OREDT=""
 S:'$L($G(ORSERV))!(+$G(ORSERV)=0) ORSERV=""
 S:'$L($G(ORSTATUS)) ORSTATUS="" ;ALL STATI
 K ^TMP("GMRCR",$J)
 S ORY=$NA(^TMP("ORQQCN",$J,"CS"))
 I '$L($G(ORPT)) S ^TMP("ORQQCN",$J,"CS",1,0)="< ERROR DFN IS MISSING >" Q
 D OER^GMRCSLM1(ORPT,ORSERV,ORSDT,OREDT,ORSTATUS,GMRCOER)
 M @ORY=^TMP("GMRCR",$J,"CS")
 K @ORY@("AD")
 K @ORY@(0)
 K ^TMP("GMRCR",$J)
 Q
DETAIL(ORQY,CONSULT) ; return formatted consult request details (plus result note if available):
 N GMRCOER
 S GMRCOER=2
 S ORQY=$NA(^TMP("GMRCR",$J,"DT"))
 D DT^GMRCSLM2(CONSULT)
 Q
 ;
