RCDMCR5A ;HAF/ASF - First Party Charge IB Cancellation Reconciliation Report - Input/output; Apr 9, 2019@21:06
 ;;4.5;Accounts Receivable;**347,361**;Mar 20, 1995;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine is being implemented for the AR Cross-Referencing Project
 ;
 ;This report will assist users in reviewing first party charges receiving
 ;Integrated Billing (IB) cancellation for potential refund activities or charge
 ;cancellation accuracy, and to identify and monitor cancellation activity
 ;productivity so veteran customers can receive refunds due to them for
 ;retroactive eligibility exemptions.  The report provides data for first party
 ;charges receiving IB cancellation for a user defined bill cancellation 
 ;date range.
MAIN ; Initial Interactive Processing
 N STOPIT,EXCEL,CANDATE,CANBEGDT,CANENDDT,BILLPAYS,RCSCR
 W !!,"*** Print the First Party Charge IB Cancellation Reconciliation Report ***",!
 S STOPIT=0 ; quit flag
 ;Prompt user for Date Range for Bill Cancellation date range
 S CANDATE=$$DATE2^RCDMCUT2("    Enter the Bill Cancellation Date Range: ")
 ;Quit is user up arrowed or timed out
 Q:CANDATE'>0
 S CANBEGDT=$P(CANDATE,U,2),CANENDDT=$P(CANDATE,U,3)
 ; Prompt user for Bills with Payments
 S BILLPAYS=$$BILLPAYS^RCDMCUT2
 Q:BILLPAYS="^"
 ; Prompt user if report will be Excel Delimited format:
 S EXCEL=$$EXCEL
 ;Quit if user up arrowed or timed out
 Q:EXCEL="^"
 D:EXCEL>0 EXMSG
 D:EXCEL'>0
 . W !!,"This report is designed to be uploaded to an Excel spreadsheet format"
 . W !,"but you have chosen non-Excel format.  Therefore, it is recommended that you"
 . W !,"adjust your screen display size and terminal settings to at least 150 characters"
  .W !,"wide to accommodate the screen output."
 ; Logic from DEVICE^RCDMCUT2 copied here
 N %ZIS,ZTRTN,ZTIO,ZTSAVE,ZTDESK,ZTSK,POP,ZTDESC
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP Q
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 I $D(IO("Q")) D  S STOPIT=1
 . S ZTRTN="RUN^RCDMCR5A"
 . S ZTIO=ION
 . S ZTSAVE("RCSCR")=""
 . S ZTSAVE("CANBEGDT")=""
 . S ZTSAVE("CANENDDT")=""
 . S ZTSAVE("BILLPAYS")=""
 . S ZTSAVE("EXCEL")=""
 . S ZTDESC="DMC 0-40 Percent SC Change Reconciliation Report Process"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request Queued.  TASK = "_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 ;
 Q:STOPIT>0!($D(ZTQUEUED))
 D RUN^RCDMCR5A
 I 'STOPIT D PAUSE2^RCDMCUT2
 Q
 ; Currently, Taskman schedulable option is not being planned for this report
 ; If this is going to change later on, QUERPT^RCDMCR3A would be a good example
 ; of how to do such an option
QUERPT ; Initial Taskman Scheduled Queued processing
 Q
 ;
RUN ;Get data and Print it out
 ;If queued ensure you delete it from the TASKS file
 I $D(ZTQUEUED) S ZTREQ="@"
 N RCPAGE
 S STOPIT=0
 K ^TMP($J,"RCDMCR5B")
 S RCPAGE=0
 ; Collect the data in ^TMP
 D COLLECT^RCDMCR5B(.STOPIT,CANBEGDT,CANENDDT,BILLPAYS)
 Q:$G(STOPIT)>0
 U IO
 ; Print Report using data in ^TMP
 D REPORT
 I 'RCSCR W !,@IOF
 D ^%ZISC
 K ^TMP($J,"RCDMCR5B")
 K EXCEL,RCSCR
 Q
 ;
REPORT ;Print report
 N RUNDATE,NAME,SSN,BILLNO,IBIEN,SKIP
 ;
 S RUNDATE=$$FMTE^XLFDT($$NOW^XLFDT,"9MP")
 D HDR
 I +$D(^TMP($J,"RCDMCR5B"))'>0 W !,"No data meets the criteria." Q
 K SKIP
 S NAME=""
 F  S NAME=$O(^TMP($J,"RCDMCR5B","DETAIL",NAME)) Q:NAME']""  D  Q:STOPIT
 . S SSN=""
 . F  S SSN=$O(^TMP($J,"RCDMCR5B","DETAIL",NAME,SSN)) Q:SSN']""  D  Q:STOPIT
 . . S BILLNO=""
 . . F  S BILLNO=$O(^TMP($J,"RCDMCR5B","DETAIL",NAME,SSN,BILLNO)) Q:BILLNO']""  D  Q:STOPIT
 . . . S IBIEN=""
 . . . F  S IBIEN=$O(^TMP($J,"RCDMCR5B","DETAIL",NAME,SSN,BILLNO,IBIEN)) Q:IBIEN']""  D  Q:STOPIT
 . . . . N NODE,CHGAMT,SERVDT,RXDT,RXNUM,RXNAM,CANCDT,CANCREAS,CANCUSER,APPR,RSC
 . . . . ; S ^TMP($J,"RCDMCR5B","DETAIL",NAME,SSN,BILLNO,IBIEN)=SERVDT_U_RXDT_U_CHGAMT_U_RXNUM_U_RXNAM_U_CANCDT_U_CANCREAS_U_CANCUSER
 . . . . S NODE=$G(^TMP($J,"RCDMCR5B","DETAIL",NAME,SSN,BILLNO,IBIEN))
 . . . . S SERVDT=$P(NODE,U,1)
 . . . . S RXDT=$P(NODE,U,2)
 . . . . S CHGAMT=$P(NODE,U,3)
 . . . . S RXNUM=$P(NODE,U,4)
 . . . . S RXNAM=$P(NODE,U,5)
 . . . . S CANCDT=$P(NODE,U,6)
 . . . . S CANCREAS=$P(NODE,U,7)
 . . . . S CANCUSER=$P(NODE,U,8)
 . . . . S APPR=$P(NODE,U,9)
 . . . . S RSC=$P(NODE,U,10) ;S ZZ=$G(ZZ)_", "_RSC
 . . . . I EXCEL'>0 D WRLINE Q
 . . . . I EXCEL>0 D WRLINE2 Q
 Q
 ;
WRLINE ; Write the data formated report line
 ;If Multiple Bills for Vet only print Name & SSN for 1st record on page
 ;
 ; Columns are - position, width, spacing (offset header by)
 ; Veteran Name - 0, 13, 1 (offset 1)
 ; SSN - 14, 10, 1 (offset 3)
 ; Bill Number - 25, 11, 1 (offset 1)
 ; Charge/Amount - 37, 11, 1 (offset 3,3)
 ; Appropriation Fund Number - 49, 6, 1 (offset 1)
 ; Revenue Source Code - 56, 5, 1 (offset 1) 
 ; Medical/Care Date - 62, 8, 1 (offset 1, 0)
 ; RXFillDT - 72, 9, 1 (offset 0)
 ; RX # - 82, 9, 1 (offset 3)
 ; RX Name - 92, 14, 1 (offset 3)
 ; IBCXLDT - 107, 7, 1 (offset 0)
 ; IB Cancellation/Reason - 115, 16, 1 (Offset 0, 6)
 ; Cancelled By - 132, 14 (offset 1)
 D CHKP() Q:STOPIT
 ; Disable Skips for now per direction of customer with :0
 W !
 I (NAME_SSN)'=$G(SKIP(1)) D
 . W $E(NAME,1,13) ; Veteran Name
 . W ?14,SSN ; SSN
 . S:0 SKIP(1)=NAME_SSN
 W ?25,BILLNO ; Bill Number
 W ?37,$J("$"_$FN(CHGAMT,",",2),11)
 W ?49,APPR
 W ?56,RSC
 W:SERVDT>0 ?62,$$STRIP^XLFSTR($$FMTE^XLFDT(SERVDT,"8D")," ")
 W:RXDT>0 ?72,$$STRIP^XLFSTR($$FMTE^XLFDT(RXDT,"8D")," ") ; Med Fill Date
 W ?82,RXNUM ; RX # 
 W ?92,$E(RXNAM,1,14) ; RX Name
 W ?107,$$STRIP^XLFSTR($$FMTE^XLFDT(CANCDT,"8D")," ")
 W ?115,$E(CANCREAS,1,16)
 W ?132,$E(CANCUSER,1,14)
 Q
 ;
WRLINE2 ; Write the Excel report line
 W !
 W $$EXOUT^RCDMCR4A(NAME),U
 W $$EXOUT^RCDMCR4A(SSN),U
 W BILLNO,U
 W "$",$FN(CHGAMT,",",2),U
 W APPR,U
 W RSC,U
 W $$FMTE^XLFDT(SERVDT,"9D")
 W U
 I RXDT W $$FMTE^XLFDT(RXDT,"9D")
 W U
 W RXNUM,U
 W RXNAM,U
 W $$FMTE^XLFDT(CANCDT,"9D"),U
 W CANCREAS,U
 W $$EXOUT^RCDMCR4A(CANCUSER)
 Q
 ;
CHKP(FOOTER) ;Check for End of Page
 ;INPUT:
 ;  FOOTER - Footer value. Optional. Default to 4 if nothing passed
 I $G(FOOTER)'>0 S FOOTER=4
 I $Y>(IOSL-FOOTER) D:RCSCR PAUSE^RCDMCUT2 Q:STOPIT  D HDR
 Q
 ;
HDR ;Print Report Header
 ;RUNDATE - Current Date in human readable format
 I EXCEL>0 D  Q
 . ;ASF 8/10/19
 . W !,"Veteran Name",U,"SSN",U,"Bill Number",U,"Charge Amount",U,"APPR",U,"RSC",U,"Medical Care Date",U,"RXFillDT",U
 . W "RX #",U,"RX Name",U,"IBCXLDT",U,"IB Cancellation Reason",U,"Cancelled By"
 S RCPAGE=RCPAGE+1 K SKIP
 W @IOF,"First Party Charge IB Cancellation Reconciliation Report  -- Run Date: ",RUNDATE," --"
 W ?140,"Page "_RCPAGE
 W !?6,"Cancellation Dates from ",$$FMTE^XLFDT(CANBEGDT,"9D")," to ",$$FMTE^XLFDT(CANENDDT,"9D")
 W !
 ;Print to screen or printer
 W !,?42,"Charge",?63,"Medical",?115,"IB Cancellation"
 W !," Veteran Name",?17,"SSN",?25,"Bill Number",?42,"Amount",?50,"APPR",?56,"RSC",?62,"Care Date",?72,"RXFillDT",?84,"RX #",?95,"RX Name",?107,"IBCXLDT",?120,"Reason",?132,"Cancelled By"
 D ULINE^RCDMCUT2("=",$G(IOM))
 Q
EXCEL() ; - Returns whether to capture data for Excel report.
 ;INPUT:
 ;  None
 ; Output:
 ;   Returns 1 - YES (capture data) / 0 - NO (DO NOT capture data) /
 ;           "^" - Exit report
 ;
 N EXCEL,X,Y,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S EXCEL=0
 S DIR(0)="Y",DIR("B")="YES",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D HEXC^RCDMCUT2"
 D ^DIR
 S:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) EXCEL="^"
 S:$G(Y)>0 EXCEL=1
 ;
 Q EXCEL
EXMSG ;message if sending to excel
 W !!,"This report may take a while to run. It is recommended that you Queue it."
 W !,"To capture as an Excel format, it is recommended that you queue this"
 W !,"report to a spool device with margins of 256 and page length of 99999"
 W !,"(e.g. spoolname;256;99999). This should help avoid wrapping problems."
 W !
 W !,"Another method would be to set up your terminal to capture the detail"
 W !,"report data. On some terminals, this can be done by clicking on the"
 W !,"'Tools' menu above, then click on 'Capture Incoming Data' to save to"
 W !,"Desktop.  To avoid undesired wrapping of the data saved to the file,"
 W !,"please enter '0;256;99999' at the 'DEVICE:' prompt."
