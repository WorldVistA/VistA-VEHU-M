%utt7 ;JLI/JIVEY@JIVEYSOFT.COM - Unit tests for MUnit !TEST functionality ;04/26/17  21:41
 ;;1.6;M-UNIT;;Aug 28, 2019;Build 17
 ; Submitted to OSEHRA Jul 8, 2017 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Joel L. Ivey 04/2017
 ;
 ; This routine is a copy of %utt1 modified by changing tag T1 to !TEST instead of @Test and adding !TEST to tag T5 to test
 ; the handling of !TEST functionality, so that only only those tags are run while tags marked @TEST or under XTENT are ignored
 ;
 W !,"Running tests in VERBOSE mode"
 N X R !,"ENTER RETURN TO CONTINUE: ",X:3
 D EN^%ut($T(+0),3) ; Run tests here.
 I $G(^TMP("%ut",$J,"UTVALS"))'="7^2^5^2^0" W !!,"The test of !TEST failed, since expected results were:",!,"Ran 7 Routines, 2 Entry Tags",!,"Checked 5 tests, with 2 failures and encountered 0 errors."
 Q
 ;
VERBOSE(VERBSITY) ;
 I (+$G(VERBSITY)<1)!($G(VERBSITY)>3) N VERBSITY S VERBSITY=3
 W !!,"Running tests in VERBOSE mode with "_$S(VERBSITY=1:"no timing",VERBSITY=2:"whole millisecond timing",3:"fractional millisecond timing"),!
 D EN^%ut($T(+0),VERBSITY) ; Run tests here, be verbose.
 QUIT
 ;
STARTUP ; M-Unit Start-Up - This runs before anything else.
 ; ZEXCEPT: KBANCOUNT - created here, removed in SHUTDOWN
 S ^TMP($J,"%ut","STARTUP")=""
 S KBANCOUNT=1
 QUIT
 ;
SHUTDOWN ; M-Unit Shutdown - This runs after everything else is done.
 ; ZEXCEPT: KBANCOUNT - created in STARTUP, removed here
 K ^TMP($J,"%ut","STARTUP")
 K KBANCOUNT
 QUIT
 ;
 ;
 ;
SETUP ; This runs before every test.
 ; ZEXCEPT: KBANCOUNT - created in STARTUP, removed in SHUTDOWN
 S KBANCOUNT=KBANCOUNT+1
 QUIT
 ;
TEARDOWN ; This runs after every test
 ; ZEXCEPT: KBANCOUNT - created in STARTUP, removed in SHUTDOWN
 S KBANCOUNT=KBANCOUNT-1
 QUIT
 ;
 ;
 ;
T1 ; !TEST - Make sure Start-up Ran
 D CHKTF($D(^TMP($J,"%ut","STARTUP")),"Start-up node on ^TMP must exist")
 QUIT
 ;
T2 ; @TEST - Make sure Set-up runs
 ; ZEXCEPT: KBANCOUNT - created in STARTUP, removed in SHUTDOWN
 D CHKEQ(KBANCOUNT,2,"KBANCount not incremented properly at SETUP")
 QUIT
 ;
T3 ; @TEST - Make sure Teardown runs
 ; ZEXCEPT: KBANCOUNT - created in STARTUP, removed in SHUTDOWN
 D CHKEQ(KBANCOUNT,2,"KBANCount not decremented properly at TEARDOWN")
 QUIT
 ;
T4 ; Specified in XTMTAG
 ; 140731 JLI - note that this will fail when run from the GUI runner, since it calls each tag separately
 ; ZEXCEPT: %utETRY - newed and created in EN1^%ut
 ; ZEXCEPT: %utGUI      -- CONDITIONALLY DEFINED BY GUINEXT^%ut
 I $G(%utGUI) D CHKEQ(%utETRY,"T4","T4 should be the value for %utETRY in the GUI Runner")
 I '$G(%utGUI) D CHKEQ(%utETRY(4),"T4","T4 should be the collected as the fourth entry in %utETRY")
 QUIT
 ;
T5 ; !test  - ditto
 ; ZEXCEPT: %ut - NEWed and created in EN1^%ut
 D CHKTF(0,"This is an intentional failure")
 D CHKEQ(%ut("FAIL"),1,"By this point, we should have failed one test")
 D FAIL^%ut("Intentionally throwing a failure")
 D CHKEQ(%ut("FAIL"),2,"By this point, we should have failed two tests")
 ; S %ut("FAIL")=0 ; Okay... Boy's and Girls... as the developer I can do that.
 QUIT
 ;
T6 ; ditto
 ; ZEXCEPT: %ut - NEWed and created in EN1^%ut
 N TESTCOUNT S TESTCOUNT=%ut("CHK")
 D SUCCEED^%ut
 D SUCCEED^%ut
 D CHKEQ(%ut("CHK"),TESTCOUNT+2,"Succeed should increment the number of tests")
 QUIT
 ;
T7 ; Make sure we write to principal even though we are on another device
 ; This is a rather difficult test to carry out for GT.M and Cache...
 ; ZEXCEPT: GetEnviron,Util,delete,newversion,readonly - not really variables
 N D
 I $$GETSYS^%ut()=47 S D="/tmp/test.txt" ; All GT.M ; VMS not supported.
 I $$GETSYS^%ut()=0 D  ; All Cache
 . I $ZVERSION(1)=2 S D=$SYSTEM.Util.GetEnviron("temp")_"\test.txt" I 1 ; Windows
 . E  S D="/tmp/test.txt" ; not windows; VMS not supported.
 I $$GETSYS^%ut()=0 O D:"NWS" ; Cache new file
 I $$GETSYS^%ut()=47 O D:(newversion) ; GT.M new file
 U D
 WRITE "HELLO",!
 WRITE "HELLO",!
 C D
 ;
 ; Now open back the file, and read the hello, but open in read only so
 ; M-Unit will error out if it will write something out there.
 ;
 I $$GETSYS^%ut()=0 O D:"R"
 I $$GETSYS^%ut()=47 O D:(readonly)
 U D
 N X READ X:1
 D CHKTF(X="HELLO")  ; This should write to the screen the dot not to the file.
 D CHKTF(($$LO($IO)=$$LO(D)),"IO device didn't get reset back")       ; $$LO is b/c of a bug in Cache/Windows. $IO is not the same cas D.
 I $$GETSYS^%ut()=0 C D:"D"
 I $$GETSYS^%ut()=47 C D:(delete)
 U $P
 S IO=$IO
 QUIT
 ;
 ; At the moment T8^%utt1 throws a fail, with no message
 ; in the GUI runner.  For some reason, both X and Y
 ; variables are returned as null strings, while in the
 ; command line runner, Y has a value containing the
 ; word being sought
 ;
T8 ; If IO starts with another device, write to that device as if it's the pricipal device
 ; ZEXCEPT: GetEnviron,Util,delete,newversion,readonly - not really variables
 ; ZEXCEPT: %utGUI - if present, defined and killed elsewhere
 I $D(%utGUI) Q  ; GUI doesn't run verbose
 N D
 I $$GETSYS^%ut()=47 S D="/tmp/test.txt" ; All GT.M ; VMS not supported.
 I $$GETSYS^%ut()=0 D  ; All Cache
 . I $ZVERSION(1)=2 S D=$SYSTEM.Util.GetEnviron("temp")_"\test.txt" I 1 ; Windows
 . E  S D="/tmp/test.txt" ; not windows; VMS not supported.
 I $$GETSYS^%ut()=0 O D:"NWS" ; Cache new file
 I $$GETSYS^%ut()=47 O D:(newversion) ; GT.M new file
 S IO=D
 U D
 D ^%utt4 ; Run some Unit Tests
 C D
 I $$GETSYS^%ut()=0 O D:"R" ; Cache read only
 I $$GETSYS^%ut()=47 O D:(readonly) ; GT.M read only
 U D
 N X,Y,Z,Z1,Z2,Z3,Z4 R X:1,Y:1,Z:1,Z1:1,Z2:1,Z3:1,Z4:1
 I $$GETSYS^%ut()=0 C D:"D"
 I $$GETSYS^%ut()=47 C D:(delete)
 D CHKTF(Z1["MAIN","Write to system during test didn't work")
 S IO=$P,IO(0)=IO
 QUIT
 ;
COVRPTGL ;
 N GL1,GL2,GL3,GL4
 S GL1=$NA(^TMP("%utCOVCOHORTSAVx",$J)) K @GL1
 S GL2=$NA(^TMP("%utCOVCOHORTx",$J)) K @GL2
 S GL3=$NA(^TMP("%utCOVRESULTx",$J)) K @GL3
 S GL4=$NA(^TMP("%utCOVREPORTx",$J)) K @GL4
 D SETGLOBS^%uttcovr(GL1,GL2)
 D COVRPTGL^%utcover(GL1,GL2,GL3,GL4)
 D CHKEQ($G(@GL4@("%ut1","ACTLINES")),"0/9","Wrong number of lines covered f>>or ACTLINES")
 D CHKEQ($G(@GL4@("%ut1","ACTLINES",9))," QUIT CNT","Wrong result for last l>>ine not covered for ACTLINES")
 D CHKEQ($G(@GL4@("%ut1","CHEKTEST")),"8/10","Wrong number of lines covered >>for CHEKTEST")
 D CHKEQ($G(@GL4@("%ut1","CHEKTEST",39))," . Q","Wrong result for last line >>not covered for CHEKTEST")
 K @GL1,@GL2,@GL3,@GL4
 Q
 ;
LO(X) Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 ; Shortcut methods for M-Unit
CHKTF(X,Y) ;
 D CHKTF^%ut(X,$G(Y))
 QUIT
 ;
CHKEQ(A,B,M) ;
 D CHKEQ^%ut(A,B,$G(M))
 QUIT
 ;
XTENT ; Entry points
 ;;T4;Entry point using XTMENT
 ;;T5;Error count check
 ;;T6;Succeed Entry Point
 ;;T7;Make sure we write to principal even though we are on another device
 ;;T8;If IO starts with another device, write to that device as if it's the pricipal device
 ;;COVRPTGL;coverage report returning global
 ;
XTROU ; Routines containing additional tests
 ;;%utt1;
 ;;%utt2; old %utNITU
 ;;%utt4; old %utNITW
 ;;%utt5;
 ;;%utt6;
 ;;%uttcovr;coverage related tests
