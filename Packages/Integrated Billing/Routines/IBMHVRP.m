IBMHVRP ;EDE/YMG - Mental Health Visit Summary/Detail Report; 09/13/2023
 ;;2.0;INTEGRATED BILLING;**760**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 N IBBDT,IBSD,IBEDT,IBEXCEL,IBCA
 N POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 ;
 W !
 D DATE I IBBDT<0 Q
 W !!
 ; Ask the user if they want a detailed or summary version of the report
 S IBSD=$$GETPRMPT("SD") I IBSD=-1 Q
 ; Ask the user if they want to report on visits at their site only or all sites
 S IBCA=$$GETPRMPT("CA") I IBCA=-1 Q
 S IBEXCEL=$$GETEXCEL() I IBEXCEL=-1 Q
 I IBEXCEL D PRTEXCEL
 I 'IBEXCEL W !!,"This report requires 132 column display.",!
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued report
 .S ZTDESC="Mental Health Visit Summary/Detail Report",ZTRTN="COMPILE^IBMHVRP"
 .S (ZTSAVE("IBCA"),ZTSAVE("IBBDT"),ZTSAVE("IBEDT"),ZTSAVE("IBEXCEL"),ZTSAVE("IBSD"))=""
 .S ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! D PAUSE(0)
 .Q
 D COMPILE
 D ^%ZISC
 Q
 ;
COMPILE ; compile report
 N IBNEW,IBLP,IBIEN,IBDATA,IBDFN,IBFAC,IBSITE,IBSTAT,IBYR,IBMN,IBCSITE,IBCTX
 K ^TMP($J,"IBMHVRP"),^TMP($J,"IBMHVRPNM")
 ;
 ; Get the current site's ID, and then re-initializing IBSITE for future use.
 D SITE^IBAUTL S IBCSITE=IBSITE,IBSITE=""
 ; Initialize loop to start date
 S IBLP=0   ;initial starting value
 S:+$G(IBBDT)>0 IBLP=+$G(IBBDT)-1   ; use beginning date if defined
 ; Loop through the "VD" index to gather
 F  S IBLP=$O(^IBMH(351.83,"VD",IBLP)) Q:'IBLP  Q:IBLP>IBEDT  D
 .S IBIEN=0 F  S IBIEN=$O(^IBMH(351.83,"VD",IBLP,IBIEN)) Q:'IBIEN  D
 ..S IBNEW=0
 ..S IBDATA=$G(^IBMH(351.83,IBIEN,0)),IBYR=$E(IBLP,1,3)+1700,IBMN=$E(IBLP,1,5)
 ..I (IBCA="C"),($P(IBDATA,U,2)'=IBCSITE) Q
 ..S IBDFN=$P(IBDATA,U),IBSITE=$P(IBDATA,U,2),IBSTAT=$P(IBDATA,U,4),IBCTX=IBSTAT+1
 ..S IBNM=$$GET1^DIQ(2,IBDFN_",",.01,"E") Q:IBNM=""
 ..; # visits by a patient in a given month (for the total and the code)
 ..S:'$D(^TMP($J,"IBMHVRP",IBYR,IBMN,IBNM,IBDFN)) IBNEW=1
 ..S $P(^TMP($J,"IBMHVRP",IBYR,IBMN,IBNM,IBDFN),U)=+$P($G(^TMP($J,"IBMHVRP",IBYR,IBMN,IBNM,IBDFN)),U)+1
 ..S $P(^TMP($J,"IBMHVRP",IBYR,IBMN,IBNM,IBDFN),U,IBCTX)=+$P($G(^TMP($J,"IBMHVRP",IBYR,IBMN,IBNM,IBDFN)),U,IBCTX)+1
 ..; # visits in a given month
 ..S $P(^TMP($J,"IBMHVRP",IBYR,IBMN),U)=+$P($G(^TMP($J,"IBMHVRP",IBYR,IBMN)),U)+1
 ..S $P(^TMP($J,"IBMHVRP",IBYR,IBMN),U,IBCTX)=+$P($G(^TMP($J,"IBMHVRP",IBYR,IBMN)),U,IBCTX)+1
 ..S:IBNEW $P(^TMP($J,"IBMHVRP",IBYR,IBMN),U,6)=+$P($G(^TMP($J,"IBMHVRP",IBYR,IBMN)),U,6)+1
 ..; # visits in a given year
 ..S $P(^TMP($J,"IBMHVRP",IBYR),U)=+$P($G(^TMP($J,"IBMHVRP",IBYR)),U)+1
 ..S $P(^TMP($J,"IBMHVRP",IBYR),U,IBCTX)=+$P($G(^TMP($J,"IBMHVRP",IBYR)),U,IBCTX)+1
 ..I '$D(^TMP($J,"IBMHVRPNM",IBDFN)) D
 ...S ^TMP($J,"IBMHVRPNM",IBDFN)=""
 ...S ^TMP($J,"IBMHVRPNM")=$G(^TMP($J,"IBMHVRPNM"))+1
 D PRINT
 K ^TMP($J,"IBMHVRP"),^TMP($J,"IBMHVRPNM")
 Q
 ;
PRINT ; print report
 N IBLINE,IBPAG,IBTOT,IBY,IBCHG,IBMON,IBYR
 N IBDTH,IBTOT,IBTOTF,IBTOTC,IBTOTN,IBTOTV,IBQUIT
 U IO
 S IBDTH=$$FMTE^XLFDT($E($$NOW^XLFDT(),1,12))
 S IBLINE="",$P(IBLINE,"=",IOM+1)="",(IBPAG,IBTOT,IBTOTC,IBTOTF,IBTOTN,IBTOTV,IBQUIT,IBCHG)=0
 D:'IBEXCEL HDR
 D:IBEXCEL EXHDR
 I '$D(^TMP($J,"IBMHVRP")) W !!,"No Mental Health Visits found within the specified period" D:'$D(ZTQUEUED)&'IBEXCEL PAUSE(1) Q
 ; - first, print detail lines
 F IBMON=$E(IBBDT,1,5):1:$E(IBEDT,1,5)  D  Q:IBQUIT
 .D:'$D(ZTQUEUED)&'IBEXCEL CHKSTOP Q:IBQUIT
 .S IBYR=$E(IBMON,1,3)+1700
 .S IBY=$G(^TMP($J,"IBMHVRP",IBYR,IBMON)) Q:$G(IBY)=""
 .;If EXCEL Output, display with ^ delim
 .I IBEXCEL W !,$$MON($E(IBMON,4,5))_" "_(1700+$E(IBMON,1,3)),U,+$P(IBY,U,1),U,+$P(IBY,U,2),U,+$P(IBY,U,3),U,+$P(IBY,U,4),U,+$P(IBY,U,5),U,+$P(IBY,U,6)
 .; Otherwise print in screen format
 .I 'IBEXCEL D
 ..W !,$$MON($E(IBMON,4,5)),?10,1700+$E(IBMON,1,3)
 ..W ?34,$J(+$P(IBY,U,1),5)     ;# visits
 ..W ?43,$J(+$P(IBY,U,2),5)     ;# free visits
 ..W ?52,$J(+$P(IBY,U,3),5)     ;# charged Visits
 ..W ?62,$J(+$P(IBY,U,4),5)     ;# not counted Visits
 ..W ?72,$J(+$P(IBY,U,5),5)     ;# visit only Visits
 ..W ?83,$J(+$P(IBY,U,6),5)     ;# # Unique Patients
 ..Q
 .S IBTOT=IBTOT+$P(IBY,U,1),IBTOTF=IBTOTF+$P(IBY,U,2),IBTOTC=IBTOTC+$P(IBY,U,3),IBTOTN=IBTOTN+$P(IBY,U,4),IBTOTV=IBTOTV+$P(IBY,U,5)
 .I IBSD="D" D PRDET(IBYR,IBMON)
 .Q
 Q:IBQUIT
 D TOTALS
 ;Write Unique Patient Definition
 W !!,"*The total unique patient number only counts a patient once for the period",!,"of the report."
 I '$D(ZTQUEUED)&'IBEXCEL D PAUSE(1)
 Q
 ;
PRDET(IBYR,IBMON) ; Print the details of the summary
 ;
 N IBDFN,IBNM
 S IBNM="" F  S IBNM=$O(^TMP($J,"IBMHVRP",IBYR,IBMON,IBNM)) Q:IBNM=""  D
 .S IBDFN=0 F  S IBDFN=$O(^TMP($J,"IBMHVRP",IBYR,IBMON,IBNM,IBDFN)) Q:'IBDFN  D
 ..I '$D(ZTQUEUED)&'IBEXCEL D CHKSTOP Q:IBQUIT
 ..S IBDATA=$G(^TMP($J,"IBMHVRP",IBYR,IBMON,IBNM,IBDFN))
 ..; Excel Format
 ..I IBEXCEL D  Q
 ...W !,$$GET1^DIQ(2,IBDFN_",",.01,"E"),U,+$P(IBDATA,U,1),U,+$P(IBDATA,U,2),U,+$P(IBDATA,U,3),U,+$P(IBDATA,U,4),U,+$P(IBDATA,U,5)
 ...Q
 ..;Screen format
 ..W !?3,$$GET1^DIQ(2,IBDFN_",",.01,"E")
 ..W ?34,$J(+$P(IBDATA,U,1),5)
 ..W ?43,$J(+$P(IBDATA,U,2),5)     ;# free visits
 ..W ?52,$J(+$P(IBDATA,U,3),5)     ;# charged Visits
 ..W ?62,$J(+$P(IBDATA,U,4),5)     ;# Removed Visits
 ..W ?72,$J(+$P(IBDATA,U,5),5)     ;# Visit On Visits
 ..Q
 .Q
 Q
 ;
TOTALS ; Print the totals.
 N IBI,X
 ; Excel format
 I IBEXCEL W !,"REPORT TOTALS",U,IBTOT,U,IBTOTF,U,IBTOTC,U,IBTOTN,U,IBTOTV,U,$G(^TMP($J,"IBMHVRPNM")) Q
 ; screen format
 W ! F IBI=1:1:88 W "-"
 W !,"REPORT TOTALS",?34,$J(IBTOT,5),?43,$J(IBTOTF,5),?52,$J(IBTOTC,5),?62,$J(IBTOTN,5),?72,$J(IBTOTV,5),?82,$J($G(^TMP($J,"IBMHVRPNM")),6)
 Q
 ;
HDR ; Print header.
 N IBI,IBHDR,IBH,IBH1,IBFACNM,IBH2
 I $E(IOST,1,2)["C-"!(IBPAG) W @IOF,*13
 S IBHDR=$S(IBSD="S":"SUMMARY",1:"DETAIL")
 S IBH="MENTAL HEALTH VISIT TRACKING "_IBHDR_" REPORT"
 S IBPAG=IBPAG+1 W ?(122-$L(IBH)\2),IBH
 S IBH1="FOR ALL SITES"
 I IBCA="C" D
 .S IBFACNM=$$GET1^DIQ(4,IBFAC_",",.01,"E")
 .S IBH1="FOR "_IBFACNM
 W !,?(122-$L(IBH1)\2),IBH1
 S IBH2="From "_$$FMTE^XLFDT(IBBDT,"2MZ")_" through "_$$FMTE^XLFDT(IBEDT,"2MZ")
 W !,?(122-$L(IBH2)\2),IBH2
 W ?IOM-36,IBDTH,?IOM-9,"Page: ",IBPAG
 W !!,?33,"TOTAL",?60,"REMOVED",?71,"VISITS",?80,"UNIQUE"
 W !," MONTH",?10,"YEAR",?33,"VISITS",?44,"FREE",?51,"BILLED",?60,"VISITS",?71,"ONLY",?80,"PATIENTS"
 W ! F IBI=1:1:88 W "-"
 Q
 ;
EXHDR ; Print Excel version of the header.
 W !,"MONTH/YEAR",U,"TOTAL VISITS",U,"FREE",U,"BILLED",U,"REMOVED VISITS",U,"VISITS ONLY",U,"UNIQUE PATIENTS"
 Q
 ;
MON(IBMON) I (IBMON<1)!(IBMON>12) Q ""
 Q $P("JANUARY FEBRUARY MARCH APRIL MAY JUNE JULY AUGUST SEPTEMBER OCTOBER NOVEMBER DECEMBER"," ",IBMON)
 ;
CHKSTOP I $Y>(IOSL-5) D PAUSE(0) Q:IBQUIT  D HDR
 Q
 ; Ask begin/end dates, with default values
 ; Input:  none
 ; Output: IBBDT,IBEDT - begin/end dates
DATE N IBNOW
 S IBNOW=$$NOW^XLFDT()
DATAGN ;Loop entry point
 S (IBBDT,IBEDT)=-1
 ; Get beginning date
 S IBBDT=$$ASKDT("Start with DATE: ",$$FIRST(IBNOW))
 I IBBDT<1 Q
 ; Get ending date
 S IBEDT=$$ASKDT("Go to DATE: ",$$LAST(IBNOW))
 I IBEDT<1 S IBBDT=-1 Q  ;User cancelled
 I IBEDT<IBBDT W !,"Ending date must follow start date!",! G DATAGN
 Q
 ;
 ;Define the first day of the given month
FIRST(IBDT) S $E(IBDT,6,7)="01"
 Q IBDT
 ;
 ;Define the last day of the given month
LAST(IBDT) N IBM,IBY
 S IBY=$E(IBDT,1,3),IBM=+$E(IBDT,4,5)
 S IBM=IBM+1 I IBM>12 S IBM=1,IBY=IBY+1
 I $L(IBM)<2 S IBM="0"_IBM
 Q $$FMADD^XLFDT(IBY_IBM_"01",-1)
 ;
 ; Input: prompt, default value (FM format)
 ; Output: date (FM) or -1, if cancelled
ASKDT(IBPRMT,IBDFLT) ;Date input
 N DIR,Y,X,DIROUT,DIRUT
 I $G(IBPRMT)'="" S DIR("A")=IBPRMT
 I $G(IBDFLT)'="" S DIR("B")=$$FMTE^XLFDT(IBDFLT,"1D")
 S DIR(0)="DA"
 D ^DIR I $D(DIRUT) Q -1
 W " (",$$FMTE^XLFDT(Y),")"
 Q Y
 ;
 ;Ask the user some questions about what to report
GETPRMPT(IBPRMPT) ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 ;
 ; Prompt Summary or Detail version
 I $G(IBPRMPT)="SD" D
 .S DIR("A")="(S)ummary or (D)etailed Report: "
 .S DIR("B")="S"
 .S DIR(0)="SA^S:SUMMARY;D:DETAILED"
 .S DIR("?")="Select the type of report to Generate."
 .Q
 ;
 ; Prompt Current or All Sites
 I $G(IBPRMPT)="CA" D
 .S DIR("A")="(C)urrent or (A)ll Sites: "
 .S DIR(0)="SA^C:CURRENT;A:ALL SITES"
 .S DIR("B")="A"
 .S DIR("?")="Select C to run for your site only, otherwise, select A to report on all sites with Mental Health visits Tracked at this site."
 .Q
 ;
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!($G(Y)="")  Q -1
 Q Y
 ;
 ;
GETEXCEL() ; Export the report to MS Excel?
 ; Function return values:
 ;   0 - User selected "No" at prompt.
 ;   1 - User selected "Yes" at prompt.
 ;   ^ - User aborted.
 ; This function allows the user to indicate whether the report should be
 ; printed in a format that could easily be imported into an Excel
 ; spreadsheet.  If the user wants to print in EXCEL format, the variable 
 ; IBEXCEL will be set to '1', otherwise IBEXCEL will be set to '0' for "No" 
 ; or "^" to abort.
 ;
 N DIR,DIRUT,Y
 S DIR(0)="Y"
 S DIR("A")="Export the report to Microsoft Excel (Y/N)"
 I $G(IBEXCEL)=1 S DIR("B")="YES"
 E  S DIR("B")="NO"
 S DIR("?",1)="If you want to capture the output from this report in a format that"
 S DIR("?",2)="could easily be imported into an Excel spreadsheet, then answer YES here."
 S DIR("?")="If you want a normal report output, then answer NO here."
 W !
 D ^DIR
 K DIR
 I $D(DIRUT) Q -1 ; Abort
 Q +Y
 ;
PRTEXCEL() ;Print the MS Excel instructions.
 W !!?5,"Before continuing, please set up your terminal to capture the"
 W !?5,"detail report data and save the detail report data in a text file"
 W !?5,"to a local drive. This report may take a while to run."
 W !!?5,"Note: To avoid undesired wrapping of the data saved to the file,"
 W !?11,"please enter '0;256;99999' at the 'DEVICE:' prompt.",!
 Q
 ;
PAUSE(IBEND) ;
 ;
 ; sets IBQUIT variable
 ;
 Q:$E(IOST,1,2)'["C-"
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT,Y
 W !!
 S DIR(0)="E"
 I $G(IBEND) S DIR("A")="End of the report. Enter RETURN to continue or '^' to exit"
 D ^DIR K DIR I $G(DUOUT) S IBQUIT=1 W @IOF Q
 I $G(IBEND) W @IOF
 Q
