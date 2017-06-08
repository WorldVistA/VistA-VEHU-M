SD5371EN ;ALB/SEK - SD*5.3*71 Environment Checker ; 22 OCT 1996
 ;;5.3;Scheduling;**71**;AUG 13, 1993
 ;
EN ;entry point
 W !,"SD*5.3*71 Installation Requirements:",!
 D ENV ; check environment
 D PATCH ; check patches
 W:$D(XPDABORT) !!,">>> Environment check failed.  Installation will not be allowed."
 W:'$D(XPDABORT) !!,">>> Environment is Ok"
 Q
 ;
 ;
ENV ; check enviroment for KIDS/programmer variables
 W !,">>> Checking Environment:"
 I $G(XPDABORT) W !,"    Can not proceed.  XPDABORT is inappropriately defined."
 I +$G(DUZ)'>0!($G(DUZ(0))'="@")!($G(U)'="^")!('$D(DT)) D
 . S XPDABORT=2
 . W !,"You must first initialize Programmer Environment by running ^XUP",!
 I '$G(XPDABORT) W !,"    Environment checks OK"
 Q
 ;
 ;
PATCH ;check for required patches
 N LINE,OK,PATCH
 W !,"    Checking for required patch SD*5.3*28..."
 S OK=$F($T(+2^SDROUT2),28)
 I 'OK S XPDABORT=2 W "not found!!"
 I OK W "OK"
 W !!,">>> Checking PACKAGE File Entries:"
 F LINE=1:1 S PATCH=$P($T(LIST+LINE),";;",2) Q:(PATCH="QUIT")  D
 . W !,"    Checking for required patch ",PATCH,"..."
 . S OK=$$PATCH^XPDUTL(PATCH)
 . I 'OK S XPDABORT=2 W "not found!!"
 . I OK W "OK"
 Q
 ;
LIST ;
 ;;SD*5.3*27
 ;;SD*5.3*44
 ;;SD*5.3*45
 ;;XU*8.0*27
 ;;QUIT
