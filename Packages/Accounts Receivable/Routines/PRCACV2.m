PRCACV2 ;WASH-ISC@ALTOONA,PA/RGY-Display file Warning messages ;9/27/93  10:30 AM
V ;;4.0;ACCOUNTS RECEIVABLE;;11/22/93
 F X=1:1 S Y=$P($T(MESS+X),";;",2) Q:Y=""  W !,$S(Y=".":" ",1:Y) I '(X#(IOSL-5)) W !!,"<< MORE >>",! I '$$ASK("Continue reading? ") W !!,"...Aborting installation",! S ERROR=1 G Q
 W ! I $D(DIFQ),'$$ASK("Continue with installation? ^NO") S ERROR=1
 W:'$D(DIFQ) !,"OK, Pre-installation complete!",!
Q Q
ASK(Y) ;ASK TO CONTINUE
 NEW DIR,DIROUT,DIRUT,DUOUT,X
 S DIR(0)="YA",DIR("B")=$S($P(Y,"^",2)]"":$P(Y,"^",2),1:"YES"),DIR("A")=$S($G(Y)]"":$P(Y,"^"),1:"...OK? ") D ^DIR
 Q Y
MESS ;;
 ;;READ READ READ READ !!!
 ;;The AR package (V4.0) introduces some new globals.  These globals
 ;;are in the namespace RC*.  You NEED to make sure that your site
 ;;does the following:
 ;;.
 ;;1) Make sure that any local routines or data being stored in RC*
 ;;namespace are moved prior to installing this package.
 ;;.
 ;;2) Make sure that the global namespace RC* is translated on
 ;;all CPUs.  The following is a list of new globals introduced
 ;;in this release:
 ;;.
 ;;  ^RCD   - New global containing AR Debtor information
 ;;  ^RC    - New global containing AR Event and other information
 ;;  ^RCY   - New global containing AR Payment Receipt information
 ;;  ^PRCAK - New global containing AR Archival information
 ;;.
 ;;3) The following AR files will become obsolete in this version:
 ;;.
 ;;  ^PRC(412,    - Old AR Debtor file
 ;;  ^PRCA(430.5, - Old AR Site Parameter file
 ;;  ^PRCA(430.7, - Old AR Billing Error Handling file
 ;;  ^PRCA(430.9, - Old AR Conversion file (V3.5 to V3.7 conversion)
 ;;  ^PRCA(431,   - Old AR Interest Rate file
 ;;  ^PRCA(434,   - Old AR Form Letter file
 ;;  ^PRCA(435,   - Old AR Batch Payment file
 ;;.
 ;;These files will not be deleted during installation, but you
 ;;will have the option to delete these files at a later time by
 ;;running the KILL^PRCACV6 routine.
 ;;.
 ;;You need to know this to make sure your site has not made any
 ;;local modification to these files.  If your site has made local
 ;;modifications, you will need to review the changes and take
 ;;appropriate action prior to installing or deleting these files.
 ;;
