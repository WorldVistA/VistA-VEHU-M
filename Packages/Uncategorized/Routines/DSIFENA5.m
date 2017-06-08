DSIFENA5 ;DSS/RED - RPC FOR FEE BASIS ;08/09/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; Routine for API used in Fee Basis to print a generic report
 ;  
 ; Integration Agreements
 ; 10000  NOW^%DTC
 ; 10089  ^%ZISC
 ; 10063  ^%ZTLOAD
 ;  3771  DEVICE^XUDHGUI
 ;
 Q  ;; no direct calls to routine
 ;
PRINTGEN(OUT,DEVICE,INPUT) ;  RPC: DSIF PRINT GENERIC REPORT
 ;   This is a generic letter generator, whatever is passed as input (array)
 ;   will be printed to the selected VistA printer.  Taskman will handle page generation,
 ;   it will not at this time generate page numbers.
 ;   
 ; Input:  Device - VistA device to use for report
 ;      Input array - Array containing text to send to printer
 ;    
 ;    to add runtime queing add the RUNTIME input variable and then
 ;    S ZTDTH=$$FMTH^XLFDT(RUNTIME)  This will queue the report to a FM date and time
 N ZTIO,ZTRTN,ZTDESC,ZTDTH,ZTSAVE,%,DSIFPRNT,NOW,ZTQUEUED,ZTREQ
 D NOW^%DTC S NOW=% S:'$D(DT) DT=%
 I $G(DEVICE)=""!('$D(INPUT(1))) S OUT="-1^Invalid input parameter" Q
 I '$D(^%ZIS(1,"B",$P(DEVICE,";"))) S OUT="-1^Not a valid VistA print device" Q
 ; setup taskman parameters
 I $P(DEVICE,";",2)'="",$P(DEVICE,";")="HFS" S ZTIO("H")=$P(DEVICE,";",2),ZTSAVE("%ZIS(""HFSFILE"")")=$P(DEVICE,";",2),ZTSAVE("%ZIS(""HFSMODE"")")="WNS",DEVICE=$P(DEVICE,";")
 S ZTDTH=$H
 S ZTRTN="GENPRINT^DSIFENA5",ZTSAVE("INPUT*")=""
 S ZTIO=DEVICE,ZTDTH=$H,ZTDESC="DSIFENA4 - Print generic report"
 D ^%ZTLOAD I $D(ZTSK) S OUT="1^Request queued to device: "_$P(DEVICE,";")_", Task #: "_$G(ZTSK)
 S:'$D(ZTSK) OUT="-1^Error creating task."
 I '$D(ZTQUEUED) D ^%ZISC
 K IOP,ZTIO,ZTRTN,ZTDESC,ZTDTH,ZTSAVE,ZTSK
 Q
 ;
GENPRINT ;  Taskman uses the above code to generate a generic report
 ;  The output is not formatted in any way, this allows more control for the report
 N I  U IO W !!
 I $D(INPUT)<9 S OUT="=1^No data array to print, quitting" QUIT
 F I=0:0 S I=$O(INPUT(I)) Q:I<1  D
 . W !,INPUT(I)
 K INPUT D QUIT
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
QUIT ; 
 S ZTREQ="@" D ^%ZISC  ; kill taskman entry, close the device
 Q
GETPRINT(DSIFOUT) ; RPC: DSIF GET PRINTERS
 ;Gets a list of printers No input
 ; Returns an array of printers, format: 
 ;          IEN^Printer Name^DisplayName^Location^RMar^PLen
 K DSIFOUT,^TMP("DSIFENA5",$J) N ZX,D
 S (D,ZX)="",DSIFOUT=$NA(^TMP("DSIFENA5",$J))
 F  D DEVICE^XUDHGUI(.ZX,.D,1) Q:D=""  D
 . F J=1:1:20 I $D(ZX(J)) S @DSIFOUT@(+ZX(J))=$P(ZX(J),U,1,9)
 . S:$L(D) D=D_"*"
 Q
