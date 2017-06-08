PRC4INS2 ;WISC/RFJ-version 4 IFCAP installation  AR patch 17 ;30 Jun 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
PATCH ;  install AR patch
 W !!,"======================= *** INSTALLING  AR  PATCH 17 *** ======================"
 W !,"Installing Accounts Receivable Patch 17, routine PRCAOFF2 ..."
 NEW %,%N,X,DIF,XCNP,DIE,XCN,XCM
 K ^TMP($J,"PRC4INS2")
 S X="PRC4OFF2" X ^%ZOSF("TEST") I '$T W !,"Cannot install Accounts Receivable patch PRCA*3.7*17",!,"routine PRC4OFF2 not found!",! G Q
 S X="PRCAOFF2" X ^%ZOSF("TEST") I '$T D INST G Q
 S DIF="^TMP($J,""PRC4INS2"",",XCNP=0,X="PRCAOFF2" X ^%ZOSF("LOAD") I $P($G(^TMP($J,"PRC4INS2",2,0)),";",3)'="4.0" D INST
Q Q
INST ;Install update PRCAOFF2 routine
 K ^TMP($J,"PRC4INS2")
 S DIF="^TMP($J,""PRC4INS2"",",XCNP=0,X="PRC4OFF2" X ^%ZOSF("LOAD")
 S DIE="^TMP($J,""PRC4INS2"",",XCN=2,X="PRCAOFF2" X ^%ZOSF("SAVE")
 K ^TMP($J,"PRC4INS2")
 W " OK, DONE."
 Q
