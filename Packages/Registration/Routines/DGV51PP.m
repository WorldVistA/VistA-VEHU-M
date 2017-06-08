DGV51PP ;ALB/MJK - DG PRE-PRE INIT FOR VERSION 5.1 ; 4/12/91  14:07
 ;;MAS VERSION 5.1;
 ;
 D CHK,PRO:$D(DIFQ)
 Q
CHK ;-- check if v5.0 clean-up routine has been run
 W !!,">>> Checking if v5.0 clean-up routine has been run..."
 I $D(^DD(2.95)) W *7,*7,!,"You must run the v5.0 clean-up routine (^DGPM5CLN) before installing MAS v5.1." K DIFQ
 Q
 ;
PRO ; -- make sure 0th node of PROTOCOL file exists
 G PROQ:$D(^ORD(101,0))
 W !!,*7,">>> The zeroth node of the PROTOCOL file is missing."
 W !,"    Installation cannot continue until ^ORD(101,0) is set."
 K DIFQ
PROQ Q
