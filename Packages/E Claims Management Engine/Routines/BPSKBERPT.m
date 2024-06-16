BPSKBERPT ; AITC/PED - K Bill Error Report;07/2023
 ;;1.0;E CLAIMS MGMT ENGINE;**36**;JUN 2004;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to file 366.14 in ICR #4299
 ;
 Q
 ;
EN ; Entry Point for Report
 ;
 N BPSEXCEL,BPSTMP,DATERNG
 ;
 W @IOF,!,"ECME Bills Created with Errors Report",!!
 ;
 S BPSTMP=$NA(^TMP($J,"BPSKBE"))
 K @BPSTMP
 ;
 ; Get date range
 S DATERNG=$$DATES
 I DATERNG="^" Q
 ;
 ; Capture data in Excel format?
 S BPSEXCEL=$$EXCEL I BPSEXCEL="^" Q
 ;
 ; Prompt user for device
 D DEVICE
 ;
 Q
 ;
DATES() ; Date range prompts
 ;
 ; Date range will be stored in variable DATERNG
 ; DATERNG = START WITH DATE ^ GO TO DATE
 ;
 N DATERNG,DIR,DTOUT,DUOUT,X,Y
 ;
 S DATERNG=""
 S DIR(0)="DA^:DT:EX"
 S DIR("A")="START WITH CLAIM ENTERED DATE: "
 S DIR("B")="T-14"
 D ^DIR
 ;
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S DATERNG="^" Q DATERNG
 ;
 S $P(DATERNG,"^")=Y
 ;
 S DIR(0)="DA^"_DATERNG_":DT:EX"
 S DIR("A")="     GO TO CLAIM ENTERED DATE: "
 S DIR("B")="T"
 D ^DIR
 ;
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S DATERNG="^" Q DATERNG
 ;
 S $P(DATERNG,"^",2)=Y
 ;
 Q DATERNG
 ;
EXCEL() ; Capture data in Excel format prompt
 ;
 N BPSEXCEL,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S BPSEXCEL=0
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D EXHELP^BPSKBERPT"
 ;
 D ^DIR
 K DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q "^"
 I Y S BPSEXCEL=1
 ;
 ;Display Excel device info
 I BPSEXCEL=1 D
 . W !!?5,"Before continuing, please set up your terminal to capture the"
 . W !?5,"detail report data and save the detail report data in a text file"
 . W !?5,"to a local drive. This report may take a while to run."
 . W !!?5,"Note: To avoid undesired wrapping of the data saved to the file,"
 . W !?5,"      please enter '0;256;99999' at the 'DEVICE:' prompt.",!
 ;
 Q BPSEXCEL
 ; 
EXHELP ; - 'Do you want to capture data...' prompt
 W !!,"      Enter:  'Y'    -  To capture detail report data to transfer"
 W !,"                        to an Excel document"
 W !,"              '<CR>' -  To skip this option"
 W !,"              '^'    -  To quit this option"
 Q
 ;
DEVICE ; Device selection prompt
 ;
 N ZTRTN,ZTDESC,ZTSAVE,ZTSK,DIR,X,Y
 ;
 I 'BPSEXCEL D
 . W !!,"WARNING - THIS REPORT REQUIRES THAT A DEVICE WITH 132 COLUMN WIDTH BE USED."
 . W !,"IT WILL NOT DISPLAY CORRECTLY USING 80 COLUMN WIDTH DEVICES",!
 ;
 S ZTRTN="COMPILE^BPSKBERPT"
 S ZTDESC="ECME Bills Created with Errors"
 S ZTSAVE("BPSTMP")=""
 S ZTSAVE("DATERNG")=""
 S ZTSAVE("BPSEXCEL")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR
 Q
 ;
COMPILE ; Compile data using file 366.14
 ;
 N BPSQUIT,DATE1,DATE2,IEN36614,IEN366141,IEN399,X
 ;
 S DATE1=$P(DATERNG,"^")-.5
 S DATE2=$P(DATERNG,"^",2)
 ;
 F  S DATE1=$O(^IBCNR(366.14,"B",DATE1)) Q:DATE1=""!(DATE1>DATE2)  D
 . S IEN36614=""
 . F  S IEN36614=$O(^IBCNR(366.14,"B",DATE1,IEN36614)) Q:IEN36614=""  D
 . . S IEN366141=0
 . . F  S IEN366141=$O(^IBCNR(366.14,IEN36614,1,"B",3,IEN366141)) Q:'IEN366141  D
 . . . S IEN399=$$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.301,"I")
 . . . ; Don't include if bill has been cancelled
 . . . I $$GET1^DIQ(399,IEN399,16,"I")=1 Q
 . . . ; AR Status must be "BILL INCOMPLETE"
 . . . I $P($$ARSTATA^IBJTU4(IEN399),"^")'="BILL INCOMPLETE" Q
 . . . S @BPSTMP@(IEN36614,IEN366141)=DATE1
 ;
 D PRINT
 ;
 ; Close the device
 D ^%ZISC
 ;
 ;Purge the task
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 ; Kill scratch global
 K @BPSTMP
 ;
 I $G(BPSQUIT) Q
 ;
 ; Pause screen so report can be viewed
 U IO(0) W !!,"Press RETURN to continue:"
 R X:300
 U IO
 ;
 Q
 ;
PRINT ; Print data
 ;
 N BPSPG,BPSPTDT,DATE,DIR,DIRUT,DUOUT,IEN36614,IEN366141,IEN50,X
 ;
 S BPSPG=1
 S BPSQUIT=0
 S BPSPTDT=$$HTE^XLFDT($H)
 D HDR(BPSPG)
 ;
 S IEN36614=""
 F  S IEN36614=$O(@BPSTMP@(IEN36614)) Q:IEN36614=""!(BPSQUIT)  D
 . S IEN366141=""
 . F  S IEN366141=$O(@BPSTMP@(IEN36614,IEN366141)) Q:IEN366141=""!(BPSQUIT)  D
 . . S X=@BPSTMP@(IEN36614,IEN366141)
 . . S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 . . ;
 . . ; Display data in readable format
 . . I 'BPSEXCEL D
 . . . W !,$$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.301)
 . . . W ?12,$E($$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.03),1,30)
 . . . W ?45,$$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.201)
 . . . W ?57,$$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.203)_"/"
 . . . W $$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.13)
 . . . W ?73,DATE
 . . . S IEN50=$$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.204)
 . . . W ?86,$E($$GET1^DIQ(50,IEN50,.01),1,40)
 . . . W ?130,$E($$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",7.01),1)
 . . . ;
 . . . I $Y>(IOSL-3) D
 . . . . I $E(IOST,1,2)="C-" D
 . . . . . W !
 . . . . . S DIR(0)="E"
 . . . . . D ^DIR
 . . . . . K DIR
 . . . . . I $D(DIRUT)!($D(DUOUT)) S BPSQUIT=1 K DIRUT,DTOUT,DUOUT
 . . . . Q:BPSQUIT
 . . . . S BPSPG=BPSPG+1
 . . . . D HDR(BPSPG)
 . . ;
 . . ; Display data in Excel format
 . . I BPSEXCEL D
 . . . W !,$$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.301)_"^"
 . . . W $E($$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.03),1,30)_"^"
 . . . W $$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.201)_"^"
 . . . W $$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.203)_"/"
 . . . W $$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.13)_"^"
 . . . W DATE_"^"
 . . . S IEN50=$$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.204)
 . . . W $E($$GET1^DIQ(50,IEN50,.01),1,40)_"^"
 . . . W $E($$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",7.01),1)_"^"
 . . . W $$GET1^DIQ(366.141,IEN366141_","_IEN36614_",",.08)
 ;
 I 'BPSEXCEL W !!,?5,"*** End of Report ***",!
 ;
 Q
 ;
HDR(BPSPG) ; Print header
 ;
 N BPSI
 ;
 ; Excel header
 I BPSEXCEL D  Q
 . W !,"BILL#^PATIENT^RX#^REF/ECME#^DATE^DRUG^COB^ERROR"
 ;
 W @IOF
 ;
 ; Report header
 W !,"ECME BILLS CREATED WITH ERRORS"
 W ?88,"Print Date: "_BPSPTDT
 W ?123,"Page: ",$J(BPSPG,3)
 W !,"CLAIM DATE: Start "_$$FMTE^XLFDT($P(DATERNG,"^"),2)
 W " Go to "_$$FMTE^XLFDT($P(DATERNG,"^",2),2)
 W ! F BPSI=1:1:132 W "="
 W !,"BILL#"
 W ?12,"PATIENT NAME"
 W ?45,"RX#"
 W ?57,"REF/ECME #"
 W ?73,"FILL DATE"
 W ?86,"DRUG"
 W ?129,"COB"
 W ! F BPSI=1:1:132 W "="
 ;
 Q
