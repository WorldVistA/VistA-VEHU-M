ECXPHAI ;MBS/BAH - Pharmacy DSS Extract IV Holding File Report ;3/5/24  11:53
 ;;3.0;DSS EXTRACTS;**190**;Dec 22, 1997;Build 36
 ;
EN ;entry point from option
 N STOP,REPORT,DIVISION,SDATE,EDATE,X,TMP,ECXPORT,CNT,TXTYPE,ECXPAT,ECRUN,DATE,Y
 S STOP=0
 ; get today's date
 D NOW^%DTC S DATE=X,Y=$E(%,1,12) D DD^%DT S ECRUN=Y K %DT
 ;Select transaction type
 D TXTYPE Q:STOP
 ;Select date range
 D DATES  Q:STOP
 ;Select patient
 D PATIENT Q:STOP
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D  Q
 .K ^TMP($J,"ECXPORT")
 .S ^TMP($J,"ECXPORT",0)="TRANSACTION TYPE^ORDER NUMBER^ORDER DATE^DRUG^DATE/TIME^ADDITIVE STRENGTH^ADDITIVE STRENGTH UNITS^SOLUTION VOLUME^COST^PATIENT",CNT=0
 .D GETDATA
 .D DETAIL
 .D EXPDISP^ECXUTL1
 .K ^TMP($J,"ECXPORT"),^TMP($J,"ECXPHAI")
 ;Queue Report
 N ZTDESC,ZTIO,ZTSAVE
 F X="TXTYPE","SDATE","EDATE","ECRUN","ECXPAT","STOP" S ZTSAVE(X)=""
 S ZTIO=""
 S ZTDESC="DSS Extract IV Holding File Report"
 W !!,"This report requires 132 column format."
 D EN^XUTMDEVQ("EN1^ECXPHAI",ZTDESC,.ZTSAVE)
 Q
 ;
EN1 ;Init variables
 N PAGE,LN
 S PAGE=0
 D HEADER I STOP D EXIT Q
 D GETDATA I STOP D EXIT Q
 I '$O(^TMP($J,"ECXPHAI",0)) D  Q
 .W !
 .W !,"************************************************************"
 .W !,"*  NOTHING TO REPORT FOR IV HOLDING FILE REPORT  *"
 .W !,"************************************************************"
 .D WAIT
 .D EXIT
 D DETAIL I STOP D EXIT Q
EXIT Q
 ;
TXTYPE ;Prompt for transaction type
 ; This code will pull the options from the file #728.113 field #5 DD to ensure compatibility
 ; in case of any future change to that field.
 N DDTYPES,DIR,X,Y
 D FIELD^DID(728.113,5,,"SET OF CODES","DDTYPES")
 S DIR(0)="S"_U_DDTYPES("SET OF CODES")_"A:ALL"
 S DIR("A")="Select Transaction Type"
 S DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 S TXTYPE=+Y
 Q
 ;
DATES ;Prompt for start date
 N DIR,DIRUT,X,Y
 W !!,"Note that the start and end dates for the IV Holding File Report refer to the",!,"DATE/TIME field, not the ORDER DATE field."
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
PATIENT ;Prompt for patient
 N DIC
 S ECXPAT=0
 S DIC=2,DIC(0)="AME",DIC("A")="Select PATIENT (to run for all patients, leave blank):"
 D ^DIC
 S:Y>0 ECXPAT=+Y
 Q
 ;
HEADER ;Print header
 S PAGE=$G(PAGE)+1,$P(LN,"=",132)=""
 W @IOF
 W !,"IV Holding File Report",?121,$$RJ^XLFSTR("PAGE: "_PAGE,10)
 W !,"Start Date: "_$$FMTE^XLFDT(SDATE),?90,"Report Run Date/Time:  "_ECRUN
 W !,"End Date:   "_$$FMTE^XLFDT(EDATE),!
 W !,"Transaction Type  Date/Time              Order Number  Order Date        Patient"
 W !," Drug                                      Additive Strength    Additive Strength Units   Solution Volume     Cost"
 W !,LN
 Q
 ;
GETDATA ;Get data from IV Holding File
 N DATE,FILE,DFN,ERROR,ENDATE,ECDATA,DTEI,DA,ON
 S DATE=SDATE-.1,ENDATE=EDATE+.999,FILE=728.113
 K ^TMP($J,"ECXPHAI")
 S DTEI=$S(ECXPORT:"I",1:"E")
 F  S DATE=$O(^ECX(FILE,"A",DATE)) Q:'DATE!(DATE>ENDATE)  D  Q:STOP
 .S DFN=0 F  S DFN=$O(^ECX(FILE,"A",DATE,DFN)) Q:'DFN  D  Q:STOP
 ..;If user selected a patient to filter for, ensure only those records go through
 ..Q:+$G(ECXPAT)&(DFN'=$G(ECXPAT))
 ..;Filter out test patients or bad records
 ..N ECXPAT ;Have to new here b/c it's being killed in the below call for some reason
 ..S ERROR=$$PAT^ECXNUT(DFN) Q:ERROR
 ..S ON=0 F  S ON=$O(^ECX(FILE,"A",DATE,DFN,ON)) Q:'ON  D  Q:STOP
 ...S DA=0 F  S DA=$O(^ECX(FILE,"A",DATE,DFN,ON,DA)) Q:'DA  D  Q:STOP
 ....N ECPAT,X,ECPNAM
 ....Q:TXTYPE'="0"&($$GET1^DIQ(FILE,DA_",",5,"I")'=TXTYPE)
 ....K ECDATA D GETS^DIQ(FILE,DA_",","*","EI","ECDATA") Q:'$D(ECDATA)
 ....S ECDATA="ECDATA("_FILE_","""_DA_","")"
 ....S X=$$PAT^ECXUTL3(DFN,"","1",.ECPAT)
 ....S ECPNAM=$E($G(ECPAT("NAME")))_$E($G(ECPAT("SSN")),6,9)
 ....;Trans. Type^Order Number^Order Date^Drug^Date/Time^Add. Str^Add. Str. Units^Sol Vol^Cost^Patient
 ....;S ^TMP($J,"ECXPHAI",DATE,DA)=@ECDATA@(5,"E")_U_ON_U_@ECDATA@(14,DTEI)_U_@ECDATA@(3,"E")_U_@ECDATA@(4,DTEI)_U_@ECDATA@(6,"E")_U_@ECDATA@(7,"E")_U_@ECDATA@(8,"E")_U_@ECDATA@(12,"E")_U_ECPNAM
 ....S ^TMP($J,"ECXPHAI",DATE,DA)=@ECDATA@(5,"E")_U_ON_U_$$FMTE^XLFDT(@ECDATA@(14,"I"),"2Z")_U_@ECDATA@(3,"E")_U_$$FMTE^XLFDT(@ECDATA@(4,"I"),"2Z")_U_@ECDATA@(6,"E")_U_@ECDATA@(7,"E")_U_@ECDATA@(8,"E")_U_@ECDATA@(12,"E")_U_ECPNAM
 Q
 ;
DETAIL ;Print report
 N CUR
 S CUR=$NA(^TMP($J,"ECXPHAI"))
 F  S CUR=$Q(@CUR) Q:$QS(CUR,2)'="ECXPHAI"  D  Q:STOP
 .I $G(ECXPORT) D  Q
 ..S CNT=$G(CNT)+1,^TMP($J,"ECXPORT",CNT)=@CUR
 ..;S $P(^TMP($J,"ECXPORT",CNT),U,3)=$$FMTE^XLFDT($P(^TMP($J,"ECXPORT",CNT),U,3),2)
 ..;S $P(^TMP($J,"ECXPORT",CNT),U,5)=$$FMTE^XLFDT($P(^TMP($J,"ECXPORT",CNT),U,5),2)
 .W !,$P(@CUR,U),?18,$P(@CUR,U,5),?41,$P(@CUR,U,2),?55,$P(@CUR,U,3),?73,$P(@CUR,U,10)
 .W !,?1,$P(@CUR,U,4),?43,$P(@CUR,U,6),?64,$P(@CUR,U,7),?90,$P(@CUR,U,8),?110,$P(@CUR,U,9),!
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
