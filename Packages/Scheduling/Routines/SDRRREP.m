SDRRREP ;ALB/SAT - RECALL REMINDERS REPORTS ;JUL 26, 2017
 ;;5.3;Scheduling;**643,672,727**;Aug 13, 1993;Build 2
 ;
LETTER ;REPORT - RECALL REMINDERS where associated Clinic does not have a Recall Letter defined
 N SDRRDESC,SDRRRTN,SDTMP
 N %ZIS,IO,IOP,IOSL,IOST,POP,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSK,ZTSAVE
 D INIT
 ;
 K %ZIS,IOP S %ZIS="MQ" W ! D ^%ZIS I POP D EXIT Q
 ;
 I $D(IO("Q")) D  Q 
 . S ZTDESC=SDRRDESC
 . S ZTRTN="PROCESS^SDRRREP"
 . S ZTSAVE("*")=""  ;*727
 . D TASK
 ;
 D PROCESS
 Q
 ;
INIT ;
 S SDRRRTN="SDRRREP"
 S SDRRDESC="Recall Letter Report"
 S SDTMP=$NA(^TMP(SDRRRTN,$J))
 K @SDTMP
 Q
 ;
PROCESS ;
 N SDDTIM,SDQUIT,SDRPAGE,SDTIME,SDTODAY,SDUNDL
 D SETUP,SORT,RPT
 I '$D(@SDTMP) W !!?26,"* * * NO DATA TO PRINT * * *",!!
 D EXIT
 Q
 ;
SETUP ;
 S (SDQUIT,SDRPAGE)=0
 S SDDTIM=$$HTE^XLFDT($H,1)
 S SDTIME=$P(SDDTIM,"@",2)
 S SDTODAY=$P(SDDTIM,"@")_"  "_$E(SDTIME,1,5)
 S $P(SDUNDL,"-",78)="-"
 Q
 ;
SORT ; get recall entries associated to clinics with no recall letter
 N DFN,SDC,SDCL,SDATE,SDCLN,SDI,SDNAM,SSN
 S SDC=0
 S SDCL=0 F  S SDCL=$O(^SD(403.5,"E",SDCL)) Q:SDCL=""  D
 .Q:$O(^SD(403.52,"B",SDCL,0))
 .S SDCLN=$$GET1^DIQ(44,SDCL_",",.01)
 .Q:SDCLN=""   ;alb/sat 672 - skip if clinic name not defined
 .S SDI=0 F  S SDI=$O(^SD(403.5,"E",SDCL,SDI)) Q:SDI=""  D
 ..S DFN=$$GET1^DIQ(403.5,SDI_",",.01,"I")
 ..Q:(DFN="")!('$D(^DPT(+DFN,0)))   ;alb/sat 672 - skip if patient not defined
 ..S SDNAM=$$GET1^DIQ(2,DFN_",",.01) S:SDNAM="" SDNAM="No Name"  ;alb/sat 672 - make sure a value is in SDNAM
 ..S SDATE=$$GET1^DIQ(403.5,SDI_",",5)
 ..S:SDATE="" SDATE=0   ;alb/sat 672 - make sure a value is in SDATE
 ..S SSN=$E($P(^DPT(DFN,0),"^",9),6,9) S:SSN="" SSN=0
 ..S SDC=SDC+1 S @SDTMP@(SDCLN,SDATE,SDNAM,SSN,SDC)=""   ;alb/sat 672 - use SDNAM
 Q
 ;
RPT ; Print the report
 N SDATE,SDC,SDCLN,SDNAME,SDSSN
 U IO
 ;
 D HEADER
 ; Loop through the Sorted data.
 S SDCLN="" F  S SDCLN=$O(@SDTMP@(SDCLN)) Q:SDCLN=""  D  Q:SDQUIT
 .S SDATE="" F  S SDATE=$O(@SDTMP@(SDCLN,SDATE)) Q:SDATE=""  D  Q:SDQUIT
 ..S SDNAME="" F  S SDNAME=$O(@SDTMP@(SDCLN,SDATE,SDNAME)) Q:SDNAME=""  D  Q:SDQUIT
 ...S SDSSN="" F  S SDSSN=$O(@SDTMP@(SDCLN,SDATE,SDNAME,SDSSN)) Q:SDSSN=""  D  Q:SDQUIT
 ....S SDC="" F  S SDC=$O(@SDTMP@(SDCLN,SDATE,SDNAME,SDSSN,SDC)) Q:SDC=""  D  Q:SDQUIT
 .....I $Y>(IOSL-6) D HEADER Q:SDQUIT
 .....W !,SDCLN,?30,SDATE,?43,SDNAME,?74,$S(SDSSN=0:"",1:SDSSN)
 Q
 ;
HEADER ;
 N DIR,Y
 S SDRPAGE=SDRPAGE+1
 I SDRPAGE>1 D  Q:SDQUIT
 . W $C(7)
 . I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S SDQUIT=$S(Y'>0:1,1:0)
 ;
 W:$E(IOST)="C"!(SDRPAGE>1) @IOF
 W !,SDRRDESC,?48,SDTODAY,?70,"PAGE ",SDRPAGE
 W !,"Clinic",?30,"Recall Date",?43,"Patient Name",?75,"SSN"
 W !,SDUNDL
 ;
 Q
 ;
EXIT ;
 W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K @SDTMP
 Q
 ;
TASK ;set variables for call to ^%ZTLOAD
 D ^%ZTLOAD
 I $G(ZTSK) W !,"Task Number: ",ZTSK
 Q
