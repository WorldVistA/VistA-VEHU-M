PRCACV6 ;WASH-ISC@ALTOONA,PA/RGY-Remove obsolete AR V3.7 files ;6/24/93  12:26 PM
V ;;4.0;ACCOUNTS RECEIVABLE;;11/22/93
 W !!,"Oops, you're trying to enter at the wrong entry point!!",! G Q
KILL ;
 NEW DIU,X,Y,PRCAY
 I '$$SYS() W !,"Post-installation process aborted!",! G Q
 F X=1:1 S Y=$P($T(NEW+X),";;",2) Q:Y=""  I '$D(@(Y_",0)")) W !,"Hmmm, no data in file ",Y,!?5,"seems you didn't run your conversion!!... process aborted",! G Q
 W !,"I am about to delete the following AR V3.7 obsolete files: "
 F X=1:1 S Y=$P($T(FILES+X),";;",2) Q:Y=""  W !,Y,?25,$P($G(@(Y_",0)")),"^")
 W !!,"Are you sure AR V4.0 is installed and running correctly ..." I '$$ASK("... OK? ^NO") W *7,"  <NO ACTION TAKEN>",! G Q
 W ! F PRCAY=1:1 S DIU=$P($T(FILES+PRCAY),";;",2)_"," Q:DIU=","  S DIU(0)="DT" W !,"Deleting file ",DIU D EN^DIU2 W "... done!"
Q Q
SYS() ;Check system vairables
 I '$D(DT)!'$D(IOM)!'$D(IOF)!'$D(ION)!'$D(IOST)!'$D(IOSL)!'$D(DUZ)!'$D(IO)!'$D(DTIME) W !,"Some of your system variables are not defined!!",! Q 0
 Q 1
ASK(Y) ;ASK TO CONTINUE
 NEW DIR,DIROUT,DIRUT,DUOUT,X
 S DIR(0)="YA",DIR("B")=$S($P(Y,"^",2)]"":$P(Y,"^",2),1:"YES"),DIR("A")=$S($G(Y)]"":$P(Y,"^"),1:"...OK? ") D ^DIR
 Q Y
FILES ;;
 ;;^PRC(412
 ;;^PRCA(430.5
 ;;^PRCA(430.7
 ;;^PRCA(430.9
 ;;^PRCA(431
 ;;^PRCA(434
 ;;^PRCA(435
 ;;
NEW ;;
 ;;^RCD(340
 ;;^RC(341
 ;;^RC(341.1
 ;;^RC(342
 ;;^RC(342.1
 ;;^RC(343
 ;;^RCY(344
 ;;
