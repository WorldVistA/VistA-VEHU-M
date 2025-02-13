A4AMINN ;HINES-CIOFO/JJM - UTILITY TO CORRECT DISCREPANCIES  7/30/98 15:15
V ;;1.0;**** CLASS III ****;;JUN 30, 1998
 ; VARIABLE LIST
 ;
 ; PWDCNT - NUMBER OF PATIENTS FOUND WITH DISCREPANCIES
 ; TAOCNT - NUMBER OF DISCREPANCIES WITH A TOTAL OF 0 FOR ACTIVE & OPEN BILLS
 ; CNT    - NUMBER OF RECORDS IN FILE 341 THAT WERE CHANGED
 ; CNT1   - NUMBER OF RECORDS IN FILE 341 THAT WERE PROCESSED
 ;
QUERPT ;
 D OPENDEV
EXIT ;;
 W:$D(ZTSK) !,"TASK NUMBER: ",ZTSK
 K ZTSK
 QUIT
OPENDEV ;check for regular run or TaskMan
 N A4ADEV,POP,%ZIS,ZTRTN,ZTSAVE,A4AIOSV K IOP
 I $D(ZTSK) S A4ADEV=ION_";"_IOST_";"_IOM_";"_IOSL D EN Q
 ;
OPENQ ;check device for queueing or local
 S ZTRTN="EN^A4AMINN",%ZIS="QM",%ZIS("B")="" D ^%ZIS G:POP CLOSEDV S (IOP,A4ADEV)=ION_";"_IOST_";"_IOM_";"_IOSL,A4AIOSV=IO(0)
 I IO=IO(0) D @ZTRTN G CLOSEDV
 I $D(IO("Q")) S ZTDESC="DISCREPANCY REPORT" D ^%ZTLOAD G CLOSEDV
 U IO D @ZTRTN
 ;
CLOSEDV ;close device and exit routine
 W:IO'=IO(0) @IOF D ^%ZISC Q:$D(ZTSK)  S:$D(A4AIOSV) IO(0)=A4AIOSV U IO(0)
 QUIT
EN ;
 N PWDCNT,DEBTOR,ERRFLAG,TAOC,TAOAS,TAOCNT,DEBB,TOOB,CNT,CNT1
 D INIT
 D NOW^%DTC W !,"STARTED ",%
 S DEBB=0 F  S DEBB=$O(^RCD(340,"B",DEBB)) Q:('DEBB)  D:DEBB["DPT" PROG1
 W !!,"NUMBER OF INCORRRECT BILLS FOUND: ",?40,$J(ECNT1,10)
 W !,"NUMBER OF REFUND REVIEW BILLS FOUND: ",?40,$J(ECNT2,10)
 W !,"NUMBER OF SUSPENDED BILLS FOUND: ",?40,$J(ECNT3,10)
 W !,"NUMBER OF DISCREPANCIES: ",?50,$J(PWDCNT,10)
 W !,"NUMBER OF RECORDS CHECKED: ",?60,$J(CNT1,10)
 D NOW^%DTC W !!,"COMPLETED ",%
KA4AV   ;
 K A4ADEB,A4A,DEB,A4ADEV,A4AFRB,A4AIOSV,A4ANAME,A4ANAT,A4APAT,A4A,PSB,A4APSB2,A4APSB6
 K A4ARDT,A4ASDAY,A4ASSN
 K A4ATL1,A4ATL2,A4ATL3,A4ATL4,A4ATL5,A4ATL6,A4ATL7,A4ATL8,A4ATL9,A4ATL10
 K A4ATNA,A4ATNA3,A4ATOA,A4ATOA1,A4AU1N4,A4APSB
 K BN,DAT,Y,BILL,CAT,DEBTOR,END,ERRFLAG,TAO
 K BBAL,CA,CC,CS,DATE1,DATE3,DFLAG,EP,F433N0,F433N1,F433N8,FAN0P1
 K FAN0P9,FAN6,FAN6P21,FLAG1,IB,IFT,LINE,LST1,LST2,LST3,LST4,LST5,LSTB1,LSTB2
 K LSTB3,LSTB4,LSTB5,LSTB6,MF,NAF,NAME,NATOTAL,OV1,OV2,PAT,PB,PBAL,PFLAG,PG
 K PRCA4307,PRCA433X,RBAL,RFLAG,SDAY,SDT,SFLAG,SRBAL,SSN,T1,T2,T3,T4,T5,T6,T7,T8
 K TAMT,TBAL,TIME1,U1N4,X,XDATE
 K RECNO,TYPE,F430N0,POP,ECNT1,ECNT2,ECNT3
 K AB,BAL,FAN0,FAN0P2,FAN0P8,ITF,LST6,LSTBT
 QUIT
PROG1 ;
 S DEBTOR=$O(^RCD(340,"B",DEBB,0))
 Q:'DEBTOR
 D CHKA
 Q:Y=0  ; NO DISCREPANCY
 S PWDCNT=PWDCNT+1
 D CHKB
 D CHKC
 D CHKD
 D CHKE
 QUIT
INIT ; INIT VARIABLES
 S (PWDCNT,TAOC,TAOAS,TAOCNT,CNT,CNT1,ECNT1,ECNT2,ECNT3)=0
 QUIT
CHKA ; CHECK FOR DISCREPANCIES
 Q:'DEBTOR
 S A4ADEB=DEBTOR
 S CNT1=CNT1+1
 S Y=$$EN^A4AARPT5(DEBTOR)
 QUIT
CHKB ; GET STATEMENT BALANCES FROM FILE 341 AND CHECK DATE RANGE
 ; DATE1 - 2980701
 S RECNO=""
 D ^A4AMIN3
 QUIT
CHKC ;
 S FLAG1=1,ERRFLAG=0
 D BYCXREF^A4AMIN2
 S A4ATL6=TAOC
 QUIT
 D BYASXR
 S DEBTOR=A4ADEB
 QUIT
CHKD ;
 D FBD^A4AARPT5
 QUIT
CHKE ;
 S FLAG1=0
 D CRT^A4AARPT6
 W !,$J(PWDCNT,8),?10,$J(DEBTOR,8),?20,$J(A4ATL1,10,2),$J(A4ATL2,10,2),$J(A4ATL3,10,2),$J((A4ATL2+A4ATL3),10,2),$J(A4ATL4,10,2)
 W !,?10,+DEBB,?20,$J(A4ATL6,10,2),$J(A4ATL7,10,2),$J(A4ATL8,10,2),$J(A4ATL9,10,2),$J(A4ATL10,10,2)
 ; Q:(TAOC'=0)!(TAOAS'=0)
 I ((A4ATL2+A4ATL4)=0),A4ATL7=0,A4ATL9=A4ATL6,A4ATL6=A4ATL10 S ERRFLAG=0
 ELSE  SET ERRFLAG=1
 S TAOCNT=TAOCNT+1
 D GETNAME
 W !,NAME,?35,$J(LSTBT,8),"  STATEMENT BALANCE DISCREPANCY "
 Q:(ERRFLAG=1)!('RECNO)
 S CNT=CNT+1
 D FIXIT^A4AMIN3
 QUIT
GETNAME ; GET PATIENT'S NAME
 S PAT=+DEBB
 S NAME=$P($G(^DPT(PAT,0)),U,1)
 QUIT
EOR8 ;
 QUIT
