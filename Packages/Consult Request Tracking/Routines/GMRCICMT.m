GMRCICMT ;SLC/JFR - IFC Possible Erroneous Comments Report; Jan 19,2024@14:05
 ;;3.0;CONSULT/REQUEST TRACKING;**193,199,196**;DEC 27, 1997;Build 3
 ;
 ;
 Q
EN ; Main
 N DASHES,TAB
 N GEXIT,GMRCO,GMRCISIT,GMRCRO,GMRCACT,GMRCSITE,GMRCX,GMRCX2,GMRCX3,GMBEG,GIDX
 N GMRCDA,GMRCDA0,GMRCDA2,GMRCDA3,GMRCTYPE,GMRCCMT,GMRCLINE,REMNUM,ANS,GMRCPG
 N ACTCNT,TOTCNT,ACTTYPE,PTNM,PTSSN,REMSIT,ZTQUEUED,ZTREQ,GIDX,GMRCODT
 N %ZIS,POP,IO,GEXIT,NMIDX,GMRCNM
 D BEGDT
 S %ZIS="QM" D ^%ZIS
 I POP D HOME^%ZIS Q
 I $D(IO("Q")) D  D ^%ZISC,HOME^%ZIS Q
 . N ZTRTN,ZTSK,ZTIO,ZTDTH,ZTDESC
 . S ZTRTN="MAKERPT^GMRCICMT"_"("_GMBEG_")",ZTDESC="IFC Possible Erroneous Comments Report"
 . S ZTIO=ION,ZTDTH=$H
 . D ^%ZTLOAD
 . I $G(ZTSK) W !,"Queued to Print, Task # ",ZTSK
 . E  W !,"Sorry, Try again Later"
 I '$D(IO("Q")) D
 . D MAKERPT(GMBEG)
 . D ^%ZISC,HOME^%ZIS
 Q
BEGDT ;
 N %DT,X,Y
 S GEXIT=0,GMBEG=""
 W @IOF
 W !!,"Enter beginning date for the IFC selection:",!
 K %DT
 S %DT="AEX"
 S %DT("B")="07/01/2020"
 S %DT("A")="Beginning Date: "
 D ^%DT S GMBEG=+$G(Y)
 I Y<1 S GEXIT=1 Q
 I GMBEG'>0 D
 . S %DT("B")=$$FMTE^XLFDT(GMBEG,"5Z")
 W @IOF
 Q
MAKERPT(GMBEG) ;
 K ^TMP("GMRCICMT",$J)
 D GETIFCS
 S TOTCNT=^TMP("GMRCICMT",$J,"TOTCNT")
 I $D(ZTQUEUED) S ZTREQ="@"
 U IO
 S TAB=$$REPEAT^XLFSTR(" ",79)
 S REMNUM=0,ANS="",GMRCPG=0,ACTCNT=0
 ; Loop the ^TMP global of selected IFCs and write records
 ; GMRCO = consult internal entry number
 ; GMRCDA = activity internal entry number
 I '$D(^TMP("GMRCICMT",$J)) S GMBEG="" S TOTCNT=0 D HDR(.GMRCPG),NOREC Q
 S GMRCSITE=0
 F  S GMRCSITE=$O(^TMP("GMRCICMT",$J,GMRCSITE)) Q:('GMRCSITE)  D
 . S GMRCO=0
 . F  S GMRCO=$O(^TMP("GMRCICMT",$J,GMRCSITE,+GMRCO)) Q:('GMRCO)  D
 .. S GMRCDA=0
 .. F  S GMRCDA=$O(^TMP("GMRCICMT",$J,GMRCSITE,+GMRCO,+GMRCDA)) Q:('GMRCDA)  D
 ... D RPTACT
 ... Q
 .. Q
 . Q
 W !,$$CJ^XLFSTR("End of Report",80),!!
 K ^TMP("GMRCICMT",$J)
 Q
GETIFCS ; Get IFCs
 S GMRCO="",GMRCISIT="",GMRCRO="",TOTCNT=0,ACTCNT=0,GIDX=0
 S GMRCISIT=0
 F  S GMRCISIT=$O(^GMR(123,"AIFC",GMRCISIT)) Q:'GMRCISIT  D
 . S GMRCRO=0
 . F  S GMRCRO=$O(^GMR(123,"AIFC",GMRCISIT,GMRCRO)) Q:'GMRCRO  D
 .. S GMRCO=$O(^GMR(123,"AIFC",GMRCISIT,GMRCRO,0))
 .. I $P($G(^GMR(123,GMRCO,12)),U,5)="P" D ACTS
 . Q
 Q
ACTS ; Get IFC activities
 N ERRCMT,CMTIDX,I
 S (GMRCACT,CMTIDX,I)=0,ERRCMT=""
 F  S GMRCACT=$O(^GMR(123,GMRCO,40,GMRCACT)) Q:'GMRCACT  D
 . S GIDX=GIDX+1 H:'(GIDX#10000) 1
 . ; Get only COMPLETE/UPDATE activities
 . S ACTTYPE=$P(^GMR(123,GMRCO,40,GMRCACT,0),U,2)
 . Q:ACTTYPE'=10
 . ; Do not include any IFCs before the begin date
 . S GMRCX=$P(^GMR(123,GMRCO,40,GMRCACT,0),U,1)
 . Q:(GMRCX<GMBEG)
 . ; Look for associated results or remote associated results to screen out admin completes
 . I ($D(^GMR(123,GMRCO,50,"AR")))!($D(^GMR(123,GMRCO,51,"AR"))) D
 .. S CMTIDX=0 S CMTIDX=$P($G(^GMR(123,GMRCO,40,GMRCACT,1,0)),U,4) ;p196
 .. F I=1:1:CMTIDX S ERRCMT=$S(I=1:$G(^GMR(123,GMRCO,40,GMRCACT,1,I,0)),1:ERRCMT_" "_$G(^GMR(123,GMRCO,40,GMRCACT,1,I,0))) ;p196
 .. I CMTIDX>0 D
 ... I $TR(ERRCMT,"")'="" D
 .... S ^TMP("GMRCICMT",$J,GMRCISIT,GMRCO,GMRCACT,0)="" S TOTCNT=TOTCNT+1
 ... Q
 .. Q
 . Q
 S ^TMP("GMRCICMT",$J,"TOTCNT")=TOTCNT
 Q
RPTACT ; 
 S GMRCACT="",GMRCLINE="",GMRCX="",GMRCX2="",GMRCISIT=0
 S TAB=$$REPEAT^XLFSTR(" ",22)
 S GMRCODT=$P(^GMR(123,+GMRCO,0),"^",1)
 S X=GMRCODT D REGDTM^GMRCU
 S GMRCODT=X
 S NMIDX=$P(^GMR(123,+GMRCO,0),U,5)
 S GMRCNM=$P($G(^GMR(123.5,NMIDX,0)),U,1)
 S GMRCDA0=$G(^GMR(123,+GMRCO,40,+GMRCDA,0))
 S GMRCTYPE=$P(GMRCDA0,"^",2)
 I GMRCTYPE'=10 Q
 S GMRCDA2=$G(^GMR(123,+GMRCO,40,+GMRCDA,2))
 S GMRCDA3=$G(^GMR(123,+GMRCO,40,+GMRCDA,3))
 I $D(^GMR(123,+GMRCO,40,+GMRCDA,2)) D
 . S GMRCISIT=$P(^GMR(123,+GMRCO,0),U,23) Q:'GMRCISIT
 . S GMRCISIT=$$GET1^DIQ(4,GMRCISIT,.01)
 ; Only reporting if comments exist
 D RPTCSLT
 D RPTCMTS
 Q
RPTCSLT ;
 I (ACTCNT#3)=0 D HDR(.GMRCPG)
 S ACTCNT=ACTCNT+1
 W !,"Possible Erroneous Comment: "_$TR($J(ACTCNT,10)," ")_"/"_$TR($J(TOTCNT,10)," ")
 S PTNM="Patient Name: "_$$GET1^DIQ(123,+GMRCO,.02,"E")
 S PTSSN="SSN: "_$$GET1^DIQ(2,$P(^GMR(123,+GMRCO,0),U,2),.09)
 S REMSIT="Receiving Site: "_$$GET1^DIQ(4,$P(^GMR(123,+GMRCO,0),U,23),.01)
 S REMNUM="Remote Consult #: "_$P(^GMR(123,+GMRCO,0),U,22)
 W !," "
 W !,"Consult #: ",GMRCO
 W !,PTNM,$$REPEAT^XLFSTR(" ",51-$L(PTNM)),PTSSN
 W !,REMSIT,$$REPEAT^XLFSTR(" ",51-$L(REMSIT)),REMNUM
 ; GMRCX/GMRCX2 are scratch pad variables
 S GMRCX="Action: "_$P($G(^GMR(123.1,+GMRCTYPE,0)),"^",1)
 S:'$L(GMRCX) GMRCX="Action: "_GMRCTYPE
 S GMRCX2="Activity #:"_+GMRCDA
 W !,GMRCX2,$$REPEAT^XLFSTR(" ",51-$L(GMRCX2)),GMRCX
 S GMRCX="" S GMRCX=$P($O(^GMR(123,+GMRCO,50,"AR",GMRCX)),";",1)
 I GMRCX="" S GMRCX=$P($O(^GMR(123,+GMRCO,51,"AR",GMRCX)),";",1)
 W !,"TIU Document #: ",GMRCX
 W !," "
 W !,"Activity Date/Time   File Entry Date/Time  Service Name"
 W !,$$REPEAT^XLFSTR("-",79)
 S DASHES=$$REPEAT^XLFSTR("-",79)
 ;Add on Date/time of Actual Activity, File Entry Date/Time, and Service Name
 S X=$P(GMRCDA0,"^",3) D REGDTM^GMRCU
 S GMRCX2=X_" "_$S($P(GMRCDA2,"^",3)]"":$P(GMRCDA2,"^",3),1:$E(TAB,1,3))
 W !,GMRCX2_$E(TAB,1,21-$L(GMRCX2))_GMRCODT_$E(TAB,1,22-$L(GMRCODT))_GMRCNM
 W !," "
 Q
RPTCMTS ;
 S GMRCCMT=0,GMRCLINE=""
 F  S GMRCCMT=$O(^GMR(123,+GMRCO,40,+GMRCDA,1,GMRCCMT)) Q:'+GMRCCMT  D
 . I $D(^GMR(123,+GMRCO,40,+GMRCDA,1,GMRCCMT,0)) D
 .. S GMRCLINE=$G(^GMR(123,+GMRCO,40,+GMRCDA,1,GMRCCMT,0))
 .. W !,GMRCLINE
 W !," "
 W !,$$REPEAT^XLFSTR("=",79)
 Q
NOREC ; Print the no records found message
 W !!,$$CJ^XLFSTR("No IFC possible erroneous comments to report",80),!
 Q
HDR(PAGE) ; Print the page hdr and increment page number
 ;
 S PAGE=PAGE+1
 I PAGE>1 W $C(12)
 W !,"IFC Possible Erroneous Comments Report"
 W ?44,$$FMTE^XLFDT($$NOW^XLFDT),?69,"Page: ",PAGE
 W !,$$REPEAT^XLFSTR("-",78)
 I PAGE=1 D
 . S GMRCX="Total IFC Activities to Review: "_TOTCNT
 . W !,$$CJ^XLFSTR(GMRCX,80),!
 . W !,$$REPEAT^XLFSTR("*",79)
 . W !,"No automated modification will be made to inter-facility consults that are "
 . W !,"identified with possible erroneous comments at this time."
 . W !,$$REPEAT^XLFSTR("*",79),!
 . W !,$$REPEAT^XLFSTR("=",79)
 Q
