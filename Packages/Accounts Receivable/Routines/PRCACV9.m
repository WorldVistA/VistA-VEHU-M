PRCACV9 ;WASH-ISC@ALTOONA,PA/RGY-Install IB patch ;10/26/93  1:58 PM
V ;;4.0;ACCOUNTS RECEIVABLE;;11/22/93
 NEW X,DIF,XCNP,DIE,XCN,XCM
 K ^TMP("PRCACV9",$J)
 S X="IBRFN1" X ^%ZOSF("TEST") I '$T D LOAD G Q
 S X="IBRFN1",DIF="^TMP(""PRCACV9"",$J,",XCNP=0 X ^%ZOSF("LOAD") I $P($G(^TMP("PRCACV9",$J,2,0)),";",3)[1.5 D LOAD
Q Q
LOAD ;Load IB routine
 K ^TMP("PRCACV9",$J)
 F X=1:1 S Y=$T(RTN+X) Q:$P(Y,";;",2)=""  S ^TMP("PRCACV9",$J,X,0)=$P(Y,";;",2,999)
 S DIE="^TMP(""PRCACV9"",$J,",XCN=0,X="IBRFN1" X ^%ZOSF("SAVE") W !,"Routine '",$P($T(RTN),";;",2),"' loaded..."
 K ^TMP("PRCACV9",$J)
 Q
RTN ;;IBRFN1
 ;;IBRFN1 ;ALB/CPM - PASS PATIENT STATEMENT DATA TO A/R ; 24-FEB-93
 ;; ;;Version 1.5 ; INTEGRATED BILLING ;**16**; 29-JUL-92
 ;; ;
 ;;STMT(TRAN) ; Pass clinical data to AR for the patient statement.
 ;; ;         Input:    TRAN -- AR Transaction number (ptr to #433)
 ;; ;         Returns:  ^TMP("IBRFN1",$J,n)=1^2^3^4^5^6^7^8 , where
 ;; ;
 ;; ;        -----------------------------------------------------------
 ;; ;       |          |                Transaction Type                |
 ;; ;       |----------|------------------------------------------------|
 ;; ;       |  Piece   |    Pharmacy    |  Outpatient  |   Inpatient    |
 ;; ;       |----------|----------------|--------------|----------------|
 ;; ;       |    1     |     IB Ref#    |    IB Ref#   |    IB Ref#     |
 ;; ;       |    2     |       Rx#      |  Visit Date  |    Adm Date    |
 ;; ;       |    3     |      Drug      |      --      | Bill From Date |
 ;; ;       |    4     |   Days Supply  |      --      |  Bill To Date  |
 ;; ;       |    5     |    Physician   |      --      |    Disc Date   |
 ;; ;       |    6     |    Quantity    |      --      |       --       |
 ;; ;       |    7     |Fill/Refill Date|      --      |       --       |
 ;; ;       |    8     |   Charge Amt   |  Charge Amt  |   Charge Amt   |
 ;; ;        -----------------------------------------------------------
 ;; ;
 ;; Q:'$G(TRAN)  K ^TMP("IBRFN1",$J)
 ;; N IBN,IBJ,IBND,IBBG,IBSL,IBPE
 ;; S IBN=0 F IBJ=1:1 S IBN=$O(^IB("AT",TRAN,IBN)) Q:'IBN  D
 ;; . S IBND=$G(^IB(IBN,0)),IBSL=$P(IBND,"^",4),IBCHG=$P(IBND,"^",7) Q:'IBND
 ;; . I +IBSL=52 D RX Q
 ;; . S IBBG=$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",11)
 ;; . I IBBG=4 S ^TMP("IBRFN1",$J,IBJ)=+IBND_"^"_$P(IBND,"^",14)_"^^^^^^"_IBCHG Q
 ;; . S IBPE=$G(^IB(+$P(IBND,"^",16),0)) S:+IBSL'=405 IBSL=$P(IBPE,"^",4)
 ;; . I +IBSL=405 D INP Q
 ;; . S ^TMP("IBRFN1",$J,IBJ)=+IBND_"^^"_$P(IBND,"^",14)_"^"_$P(IBND,"^",15)_"^^^^"_IBCHG
 ;; Q
 ;; ;
 ;;RX ; Build array element for Pharmacy Co-pay charges.
 ;; N %DT,I,IBRX,IBFILL,PSOFILL,PSONTALK,PSORX0,PSORX1,PSORXN,PSOTMP,VA,VAERR,X,Y,Z
 ;; S IBRX=$P($P(IBSL,";"),":",2),IBFILL=+$P($P(IBSL,";",2),":",2)
 ;; S X=IBRX_"^"_IBFILL,PSONTALK="" D EN^PSOCPVW
 ;; S Z=+IBND F I=.01,6,8,4,7,22 S Z=Z_"^"_$G(PSOTMP(52,IBRX,I,"E"))
 ;; S:IBFILL $P(Z,"^",7)=$G(PSOTMP(52.1,IBFILL,.01,"E"))
 ;; S X=$P(Z,"^",7),%DT="" D ^%DT S $P(Z,"^",7)=$S(Y>0:Y,1:"")
 ;; S ^TMP("IBRFN1",$J,IBJ)=Z_"^"_IBCHG
 ;; Q
 ;; ;
 ;;INP ; Build array element for inpatient charges.
 ;; N IBADM,IBDIS,IBFR,IBTO,PM,PM0,X,X1,X2
 ;; S PM=+$P(IBSL,":",2),PM0=$G(^DGPM(PM,0))
 ;; S IBADM=$S(PM0:+PM0\1,1:$P(IBPE,"^",17))
 ;; S IBDIS=$S(PM0:$S($D(^DGPM(+$P(PM0,"^",17),0)):+^(0)\1,1:""),1:"")
 ;; S IBFR=$P(IBND,"^",14),IBTO=$P(IBND,"^",15)
 ;; ; - check for per diems added through C/E/A which are off by one day
 ;; I IBBG=3 S X1=IBTO,X2=IBFR D ^%DTC I X+1'=$P(IBND,"^",6) S X1=IBTO,X2=-1 D C^%DTC S IBTO=X
 ;; S ^TMP("IBRFN1",$J,IBJ)=+IBND_"^"_IBADM_"^"_IBFR_"^"_IBTO_"^"_IBDIS_"^^^"_IBCHG
 ;; Q
END ;;
