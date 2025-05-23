A4AADP5 ;HINES-CIOFO/JJM - PROGRAM TO AUDIT DEBTOR 7/30/99 02:00
 ;;1.0;**** CLASS III ****;;JUN 30, 1998
START ;;
BYCXREF ;;
 N ERRCNT,OK,I,ICS,BN,TN,RCNT,DCNT,BCNT,TCNT,TERRCNT
 S DEBTOR=0,BN=0,TN=0,RCNT=0,DCNT=0,BCNT=0,TCNT=0,TERRCNT=0
 D INIT,SETUP^A4AARPT1
 W "CHECKING C CROSS-REFERENCE OF FILE 430"
 S DEBTOR=0,DCNT=0,RCNT=0,ERRCNT=0
 F I=1:1 S DEBTOR=$O(^PRCA(430,"C",DEBTOR)) W:(I#10)=0 "." Q:'DEBTOR  D LOOPBN^A4AADP1
 W !,$J(ERRCNT,10)," ERRORS FOUND"
 W !,$J(RCNT,10)," BILLS CHECKED (",+$P(^PRCA(430,0),U,3),")"
 D:ERRCNT>0 ERRLIST^A4AADP2
 W !,"EOJ"
 QUIT
BYASXR ;;
 N ERRCNT,OK,I,ICS,BN,TN,RCNT,DCNT,BCNT,TCNT,TERRCNT
 S DEBTOR=0,BN=0,TN=0,RCNT=0,DCNT=0,BCNT=0,TCNT=0,TERRCNT=0
 D INIT
 W "CHECKING AS CROSS-REFERENCE OF FILE 430"
 S DEBTOR=0,DCNT=0,RCNT=0
 F I=1:1 S DEBTOR=$O(^PRCA(430,"AS",DEBTOR)) W:(I#10)=0 "." Q:'DEBTOR  D
   . S ICS=0
   . F  S ICS=$O(^PRCA(430,"AS",DEBTOR,ICS)) Q:'ICS  D
      .. S BN=0
      .. F  S BN=$O(^PRCA(430,"AS",DEBTOR,ICS,BN)) Q:'BN  D CHK430^A4AADP1,LOOPBTN^A4AADP1
 W !,$J(ERRCNT,10)," ERRORS FOUND"
 W !,$J(RCNT,10)," BILLS CHECKED (",+$P(^PRCA(430,0),U,3),")"
 D:ERRCNT>0 ERRLIST^A4AADP2
 W !,"EOJ"
 QUIT
BY430 ;;
 N ERRCNT,OK,I,ICS,BN,TN,RCNT,DCNT,BCNT,TCNT,TERRCNT
 S DEBTOR=0,BN=0,TN=0,RCNT=0,DCNT=0,BCNT=0,TCNT=0,TERRCNT=0
 D INIT
 W "CHECKING FILE 430"
 S BN=0,DCNT=0,RCNT=0
 F I=1:1 S BN=$O(^PRCA(430,BN)) W:(I#10)=0 "." Q:'BN  D
   . S DCNT=DCNT+1,TERRCNT=ERRCNT
   . D GET430D^A4AADP3
   . S DEBTOR=+$G(FAN0P9)
   . D CHK430^A4AADP1,LOOPBTN^A4AADP1
   . I ERRCNT'=TERRCNT D
       .. W !,$J(BN,6)," HAS ",$J((ERRCNT-TERRCNT),5)," ERRORS"
 W !,$J(ERRCNT,10)," ERRORS FOUND"
 W !,$J(RCNT,10)," BILLS CHECKED (",+$P(^PRCA(430,0),U,3),")"
 D:ERRCNT>0 ERRLIST^A4AADP2
 D EXIT
 W !,"EOJ"
 QUIT
BY433 ;;
 N ERRCNT,OK,I,ICS,BN,TN,RCNT,DCNT,BCNT,TCNT,TERRCNT
 S BN=0,TN=0,RCNT=0,DCNT=0,BCNT=0,TCNT=0,TERRCNT=0
 D INIT
 W "CHECKING FILE 433"
 S TN=0,DCNT=0,RCNT=0
 F I=1:1 S TN=$O(^PRCA(433,TN)) W:(I#10)=0 "." Q:'TN  D
   . S DCNT=DCNT+1,TERRCNT=ERRCNT
   . D GET433D^A4AADP3 Q:(FBN0P4=1)&(FBN0P10=1)
   . S BN=+$G(BN433)
   . D GET430D^A4AADP3
   . S DEBTOR=+$G(FAN0P9)
   . D CHK433^A4AADP1
   . D C430XR^A4AADP3
   . I ERRCNT'=TERRCNT D
       .. W !,$J(TN,6)," HAS ",$J((ERRCNT-TERRCNT),5)," ERRORS"
 W !,$J(ERRCNT,10)," ERRORS FOUND"
 W !,$J(RCNT,10)," TRANSACTIONS  CHECKED (",+$P(^PRCA(433,0),U,3),")"
 D:ERRCNT>0 ERRLIST^A4AADP2
 D EXIT
 W !,"EOJ"
 QUIT
AT433 ;;
 N ERRCNT,OK,I,ICS,BN,TN,RCNT,DCNT,BCNT,TCNT,TERRCNT
 S DEBTOR=0,BN=0,TN=0,RCNT=0,DCNT=0,BCNT=0,TCNT=0,TERRCNT=0
 D INIT
 W "CHECKING ""AT"" CROSS-REFERENCE FOR FILE 433"
 S AT2=0,DCNT=0,RCNT=0
 F I=1:1 S AT2=$O(^PRCA(433,"AT",AT2)) W:(I#10)=0 "." Q:'AT2  D
    . S DCNT=DCNT+1,TERRCNT=ERRCNT
    . D LOOPAT2^A4AADP1
 W !,$J(ERRCNT,10)," ERRORS FOUND"
 W !,$J(RCNT,10)," RECORDS CHECKED (",+$P(^PRCA(433,0),U,3),")"
 D:ERRCNT>0 ERRLIST^A4AADP2
 D EXIT
 W !,"EOJ"
 QUIT
ATD433 ;;
 N ERRCNT,OK,I,ICS,BN,TN,RCNT,DCNT,BCNT,TCNT,TERRCNT
 S DEBTOR=0,BN=0,TN=0,RCNT=0,DCNT=0,BCNT=0,TCNT=0,TERRCNT=0
 D INIT
 W "CHECKING ""ATD"" CROSS-REFERENCE FOR FILE 433"
 S DEBTOR=0,DCNT=0,RCNT=0
 F I=1:1 S DEBTOR=$O(^PRCA(433,"ATD",DEBTOR)) W:(I#10)=0 "." Q:'DEBTOR  D
    . S DCNT=DCNT+1,TERRCNT=ERRCNT
    . D LOOPDAT^A4AADP1
    . I ERRCNT'=TERRCNT D
      .. W !,$J(DEBTOR,6)," HAS ",$J((ERRCNT-TERRCNT),5)," ERRORS"
 W !!,$J(DCNT,10)," DEBTORS CHECKED"
 W !,$J(ERRCNT,10)," ERRORS FOUND"
 W !,$J(RCNT,10)," RECORDS CHECKED (",+$P(^PRCA(433,0),U,3),")"
 D:ERRCNT>0 ERRLIST^A4AADP2
 D EXIT
 W !,"EOJ"
 QUIT
CHK430C ; CHECK THE C CROSS-REFERENCE FOR BAD DEBTORS:
 N ERRCNT,OK,I,ICS,BN,TN,RCNT,DCNT,BCNT,TCNT,TERRCNT
 S DEBTOR=0,BN=0,TN=0,RCNT=0,DCNT=0,BCNT=0,TCNT=0,TERRCNT=0
 D INIT,SETUP^A4AARPT1
 W "CHECKING C CROSS-REFERENCE OF FILE 430"
 S DEBTOR=0,DCNT=0,RCNT=0,ERRCNT=0
 F I=1:1 S DEBTOR=$O(^PRCA(430,"C",DEBTOR)) W:(I#10)=0 "." Q:'DEBTOR  D
   . S BN=0
   . F  S BN=$O(^PRCA(430,"C",DEBTOR,BN)) Q:'BN  D
     .. D CHK2^A4AADP3,PERROR1^A4AADP1
     .. D CHK20^A4AADP3,PERROR1^A4AADP1
     .. D CHK22^A4AADP3,PERROR1^A4AADP1
     .. D CHK23^A4AADP3,PERROR1^A4AADP1
     .. D CHK32^A4AADP3,PERROR1^A4AADP1
 W !,$J(ERRCNT,10)," ERRORS FOUND"
 W !,$J(RCNT,10)," BILLS CHECKED (",+$P(^PRCA(430,0),U,3),")"
 D:ERRCNT>0 ERRLIST^A4AADP2
 W !,"EOJ"
 QUIT
EXIT ;;
 QUIT
 D EOR^A4AARPT
CLEANUP ;;
 K ERRCNT,OK,RCNT,DCNT,TERRCNT,AT2,BCNT,BN,BN433,DAT,DCNT,DPT,ERRCNT
 K ERRCODE,NATD,RBAL,TAO,BAL,CAT,BILL,CS,DIC,FAN0P2,FLAG1,TEAMT
 K FAN0,FAN0P1,FAN0P8,FAN0P9,FAN6,FAN6P21
 K FBN0,FBN0P1,FBN0P10,FBN0P2,FBN0P4,FBN1,FBN1P2,FBN1P9
 K NAC,NACTDT,NAS,NAT,NAW,NB,NC,ND,OK,RCNT,TCNT,TDT,TERRCNT,TN,XTN
 K DAT,I,TN
 K X,Y
 QUIT
INIT ;; 
 S ERRCNT=0,OK=0,RCNT=0,DCNT=0,BCNT=0,TCNT=0,TERRCNT=0
 QUIT
