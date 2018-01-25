A4AMIN2 ;HINES-CIOFO/JJM - UTILITY TO CORRECT DISCREPANCIES  7/30/98 09:15
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
 S ZTRTN="EN^A4AMIN2",%ZIS="QM",%ZIS("B")="" D ^%ZIS G:POP CLOSEDV S (IOP,A4ADEV)=ION_";"_IOST_";"_IOM_";"_IOSL,A4AIOSV=IO(0)
 I IO=IO(0) D @ZTRTN G CLOSEDV
 I $D(IO("Q")) S ZTDESC="DISCREPANCY REPORT" D ^%ZTLOAD G CLOSEDV
 U IO D @ZTRTN
 ;
CLOSEDV ;close device and exit routine
 W:IO'=IO(0) @IOF D ^%ZISC Q:$D(ZTSK)  S:$D(A4AIOSV) IO(0)=A4AIOSV U IO(0)
 D KA4AV
 QUIT
EN ;
 N PWDCNT,DEBTOR,ERRFLAG,TAOC,TAOAS,TAOCNT,DEBB,TOOB,CNT,CNT1
 S ECNT1=0
 S ECNT2=0
 D INIT
 D NOW^%DTC W !,"STARTED ",%
 S DEBB=0 F ICNT=1:1 S DEBB=$O(^RCD(340,"B",DEBB)) Q:('DEBB)  W:(ICNT#500)=0 "." D:DEBB["DPT" PROG2
 W !,"NUMBER OF RECORDS CHECKED: ",$J(CNT1,10)
 W !,"NUMBER OF DISCREPANCIES: ",$J(PWDCNT,10)
 W !,"NUMBER OF INCORRRECT BILLS FOUND: ",$J(ECNT1,10)
 W !,"NUMBER OF REFUND REVIEW BILLS FOUND: ",$J(ECNT2,10)
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
 K RECNO,TYPE,F430N0,POP
 K AB,BAL,FAN0,FAN0P2,FAN0P8,ITF,LST6,LSTBT
 K BS,DATE2,TIME2,TRANS,ECNT1,ECNT2
 QUIT
PROG1 ;
 S DEBTOR=$O(^RCD(340,"B",DEBB,0))
 Q:'DEBTOR
 D CHKA
 Q:Y=0  ; NO DISCREPANCY
 S PWDCNT=PWDCNT+1
 D CHKB
 D CHKD
 D CHKE
 QUIT
INIT ; INIT VARIABLES
 S (PWDCNT,TAOC,TAOAS,TAOCNT,CNT,CNT1)=0
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
 QUIT
 S FLAG1=1,ERRFLAG=0
 D BYCXREF
 S A4ATL6=TAOC
 D BYASXR
 S DEBTOR=A4ADEB
 QUIT
CHKD ;
 D FBD^A4AARPT5
 QUIT
CHKE ;
 S FLAG1=0
 D CRT^A4AARPT6
 W !,$J(DEBTOR,8),$J(PWDCNT,8),?20,$J(A4ATL1,10,2),$J(A4ATL2,10,2),$J(A4ATL3,10,2),$J((A4ATL2+A4ATL3),10,2),$J(A4ATL4,10,2)
 W !,?10,+DEBB,?20,$J(A4ATL6,10,2),$J(A4ATL7,10,2),$J(A4ATL8,10,2),$J(A4ATL9,10,2),$J(A4ATL10,10,2)
 ; Q:(TAOC'=0)!(TAOAS'=0)
 I ((A4ATL2+A4ATL4)=0),A4ATL7=0,A4ATL9=A4ATL6,A4ATL6=A4ATL10 S ERRFLAG=0
 ELSE  SET ERRFLAG=1
 S TAOCNT=TAOCNT+1
 D GETNAME
 W !,?5,NAME,?40,$J(LSTBT,8),"  STATEMENT BALANCE DISCREPANCY FOUND"
 Q:(ERRFLAG=1)!('RECNO)
 S CNT=CNT+1
 ;D FIXIT^A4AMIN3
 QUIT
PROG2 ; 
 S DEBTOR=$O(^RCD(340,"B",DEBB,0))
 Q:'DEBTOR
 D CHKA
 Q:Y=0  ; NO DISCREPANCY
 S PWDCNT=PWDCNT+1
BYCXREF ;;
 Q:'$D(DEBTOR)
 N ERRCNT,OK,I
 N AB,BAL,BCNT,BILL,BN,CC,CS,DCNT,IB,MF,PB,PRCA4307,RCNT
 N DAT,DATE1,SDT,TCNT,TERRCNT,TIME1,Y
 D INIT^A4AADP1
 ; W #,"COMPUTING TOTAL BALANCE FOR ACTIVE & OPEN BILLS",!,"USING THE C CROSS-REFERENCE OF FILE 430"
 S DCNT=0,RCNT=0,TAOC=0
 S BN=0
 F  S BN=$O(^PRCA(430,"C",DEBTOR,BN)) Q:('BN)  D
 . S BILL=BN
    . D CHKBILL^A4AMIN1
    . Q:(+($P(^PRCA(430,BN,0),U,8)'=16))&(+($P(^PRCA(430,BN,0),U,8))'=42)&(+($P(^PRCA(430,BN,0),U,8))'=44)
    . S BILL=BN,RCNT=RCNT+1
    . D CALCCBAL^A4AARPT
    . S TAOC=TAOC+BAL
 ; W !,$J(DEBTOR,10),$J(RCNT,10)," BILLS CHECKED (",+$P(^PRCA(430,0),U,3),")"
 ; W !,"TOTAL OF ACTIVE & OPEN BILLS COMPUTED BY USING THE C XREF: ",$J(TAOC,12,2)
 ; W !
EOT1 ;
 QUIT
BYASXR ;;
 Q:'$D(DEBTOR)
 N ERRCNT,OK,I,BN
 N AB,BAL,BCNT,BILL,BN,CC,CS,DCNT,IB,MF,PB,PRCA4307,RCNT
 N DAT,DATE1,SDT,TCNT,TERRCNT,TIME1,Y
 D INIT^A4AADP1
 ; W #,"COMPUTING TOTAL BALANCE FOR ACTIVE & OPEN BILLS",!,"USING THE AS CROSS-REFERENCE OF FILE 430"
 S DCNT=0,RCNT=0,TAOAS=0
 F CS=16,42 S BN=0 F  S BN=$O(^PRCA(430,"AS",DEBTOR,CS,BN)) Q:'BN  D 
   . S BILL=BN,RCNT=RCNT+1
   . D CALCCBAL^A4AARPT
   . S TAOAS=TAOAS+BAL
 ; W !,$J(RCNT,10)," BILLS CHECKED (",+$P(^PRCA(430,0),U,3),")"
 ; W !,"TOTAL OF ACTIVE & OPEN BILLS COMPUTED BY USING THE AS XREF: ",$J(TAOAS,12,2)
 ; W !
EOT2 ;
 QUIT
GETNAME ; GET PATIENT'S NAME
 S PAT=+DEBB
 S NAME=$P($G(^DPT(PAT,0)),U,1)
 QUIT
EOR8 ;
 QUIT