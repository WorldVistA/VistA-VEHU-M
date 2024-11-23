ECXTSR ;MBS/BAH - Pharmacy DSS Extract Treating Specialty Report ;4/5/24  11:53
 ;;3.0;DSS EXTRACTS;**190**;Dec 22, 1997;Build 36
 ;
EN ;entry point from option
 N STOP,REPORT,DIVISION,SDATE,EDATE,X,TMP,ECXPORT,CNT,TXTYPE,ECXPAT,ECRUN,DATE,Y
 S STOP=0
 ; get today's date
 D NOW^%DTC S DATE=X,Y=$E(%,1,12) D DD^%DT S ECRUN=Y K %DT
 ;Select date range
 D DATES  Q:STOP
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D  Q
 .K ^TMP($J,"ECXPORT")
 .S ^TMP($J,"ECXPORT",0)="PTF CODE^NAME^STATUS^EFFECTIVE DATE^STATUS CHANGED",CNT=0
 .D GETDATA
 .D DETAIL
 .D EXPDISP^ECXUTL1
 .K ^TMP($J,"ECXPORT"),^TMP($J,"ECXTSR")
 ;Queue Report
 N ZTDESC,ZTIO,ZTSAVE
 F X="SDATE","EDATE","ECRUN","STOP" S ZTSAVE(X)=""
 S ZTIO=""
 S ZTDESC="DSS Extract Treating Specialty Report"
 W !!,"This report requires 132 column format."
 D EN^XUTMDEVQ("EN1^ECXTSR",ZTDESC,.ZTSAVE)
 Q
 ;
EN1 ;Init variables
 N PAGE,LN
 S PAGE=0
 D HEADER I STOP D EXIT Q
 D GETDATA I STOP D EXIT Q
 I '$O(^TMP($J,"ECXTSR",0)) D  Q
 .W !
 .W !,"************************************************************"
 .W !,"*  NOTHING TO REPORT FOR TREATING SPECIALTY REPORT  *"
 .W !,"************************************************************"
 .D WAIT
 .D EXIT
 D DETAIL I STOP D EXIT Q
EXIT Q
 ;
DATES ;Prompt for start date
 N DIR,DIRUT,X,Y
 S DIR(0)="D^:NOW:EX"
 S DIR("A")="Enter Report Start Date"
 S DIR("B")=$$FMTE^XLFDT($$NOW^XLFDT,"1D")
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 S SDATE=Y
 ;Prompt for end date
 K DIR,DIRUT,X,Y
 S DIR(0)="D^:NOW:EX"
 S DIR("A")="Enter Report End Date"
 S DIR("B")=$$FMTE^XLFDT($$NOW^XLFDT,"1D")
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 S EDATE=Y
 Q
 ;
HEADER ;Print header
 S PAGE=$G(PAGE)+1,$P(LN,"=",91)=""
 W @IOF
 W !,"Treating Specialty Report",?80,$$RJ^XLFSTR("PAGE: "_PAGE,10)
 W !,"Start Date: "_$$FMTE^XLFDT(SDATE),?49,"Report Run Date/Time:  "_ECRUN
 W !,"End Date:   "_$$FMTE^XLFDT(EDATE),!
 W !,"Note: '*' beside the status indicates status was changed during report period."
 W !,"PTF Code         Name                            Status           Effective Date"
 W !,LN
 Q
 ;
GETDATA ;Get data from Specialty File
 N ACTIVE,DATE,EFDT,EFDTI,ECXTSRD,ENDATE,ERROR,IEN,NAME,PTFC,STATCH,STATUS
 S DATE=SDATE-.1,ENDATE=EDATE+.999
 K ^TMP($J,"ECXTSR")
 S IEN=0 F  S IEN=$O(^DIC(42.4,IEN)) Q:'IEN  D
 .K ^TMP($J,"ECXTSRD")
 .S STATUS="DOES NOT EXIST",STATCH=0 ; Default to Specialty not existing at the time
 .D GETS^DIQ(42.4,IEN_",","*","EI",$NA(^TMP($J,"ECXTSRD")))
 .S ECXTSRD=$NA(^TMP($J,"ECXTSRD",42.4,IEN_","))
 .S NAME=$G(@ECXTSRD@(.01,"E")),PTFC=$G(@ECXTSRD@(7,"E"))
 .S EFDT=$O(^DIC(42.4,IEN,"E","B",ENDATE),-1)
 .I EFDT]"" D
 ..S EFDTI=$O(^DIC(42.4,IEN,"E","B",EFDT,0))
 ..S ACTIVE=$$GET1^DIQ(42.41,EFDTI_","_IEN_",",.02,"I"),STATUS=$S(+ACTIVE:"ACTIVE",1:"INACTIVE")
 ..S STATCH=$$STATCH(IEN,EFDT,SDATE,EDATE)
 .S:EFDT="" EFDT="N/A"
 .S ^TMP($J,"ECXTSR",IEN)=PTFC_U_NAME_U_STATUS_$S(STATCH:"*",1:"")_U_$$FMTE^XLFDT(EFDT,"2Z")
 Q
 ;
STATCH(IEN,EFDT,SDATE,EDATE) ;Check if status changed during report period
 Q EFDT'<SDATE&(EFDT'>EDATE)
 ;
DETAIL ;Print report
 N I
 S I=0 F  S I=$O(^TMP($J,"ECXTSR",I)) Q:'+I  D  Q:STOP
 .S X=$G(^TMP($J,"ECXTSR",I))
 .I $G(ECXPORT) D  Q
 ..I $P(X,U,3)["*" S $P(X,U,3)=$P($P(X,U,3),"*"),$P(X,U,5)="*"
 ..S CNT=$G(CNT)+1,^TMP($J,"ECXPORT",CNT)=X
 .W !,$P(X,U),?17,$P(X,U,2),?49,$P(X,U,3),?66,$P(X,U,4)
 .I $Y>(IOSL-5) D WAIT Q:STOP  D HEADER
 Q
 ;
WAIT ;End of page logic
 ;Input   ; None
 ;Output  ; STOP - Flag indicating if printing should continue
 ;                 1 = Stop     0 = Continue
 ;
 S STOP=0
 ;CRT - Prompt for continue
 I $E(IOST,1,2)="C-" D  Q
 .F  Q:$Y>(IOSL-3)  W !
 .N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 .S DIR(0)="E"
 .D ^DIR
 .S STOP=$S(Y'=1:1,1:0)
 ;Background task - check taskman
 S STOP=$$S^%ZTLOAD()
 I STOP D
 .W !,"*********************************************"
 .W !,"*  PRINTING OF REPORT STOPPED AS REQUESTED  *"
 .W !,"*********************************************"
 Q
