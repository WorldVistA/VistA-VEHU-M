ECX218EN ;ALB/JAP - ECX*2.0*18 Environment Checker ; 18 JUN 1997
 ;;2.0T11;DSS EXTRACTS;**18**;DEC 18,1996
 ;
EN ;entry point
 W !,"ECX*2.0*18 Installation Requirements:",!
 D ENV ; check environment
 D PATCH ; check patches
 W:$D(XPDABORT) !!,">>> Environment check failed.  Installation will not be allowed."
 W:'$D(XPDABORT) !!,">>> Environment is Ok"
 Q
 ;
 ;
ENV ; check enviroment for KIDS/programmer variables
 W !,">>> Checking Environment:"
 I $G(XPDABORT) W !,"    Cannot proceed -- XPDABORT is inappropriately defined."
 I $G(XPDQUIT) W !,"    Cannot proceed -- XPDQUIT is inappropriately defined."
 I +$G(DUZ)'>0!($G(DUZ(0))'="@")!($G(U)'="^")!('$D(DT)) D
 . S XPDABORT=1
 . W !,"You must first initialize Programmer Environment by running ^XUP",!
 I '$G(XPDABORT) W !,"    Environment checks OK"
 Q
 ;
 ;
PATCH ;check for required patches
 N LINE,OK,PATCH
 W !!,">>> Checking PACKAGE File Entries:"
 F LINE=1:1 S PATCH=$P($T(LIST+LINE),";;",2) Q:(PATCH="QUIT")  D
 . W !,"    Checking for required patch ",PATCH,"..."
 . S OK=$$PATCH^XPDUTL(PATCH)
 . I 'OK S XPDABORT=1 W "not found!!"
 . I OK W "OK"
 Q
 ;
LIST ;
 ;;LR*5.2*143
 ;;QUIT
