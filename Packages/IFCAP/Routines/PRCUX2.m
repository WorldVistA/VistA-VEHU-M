PRCUX2 ;WISC@ALTOONA/CTB-SIGNATURE CONVERSION ROUTINE FOR FILE 421.2 ; 05/18/93  10:43 AM
V ;;4.0;IFCAP;;9/23/93
CVT(X) ;CONVERT RANGE OF RECORDS - X?.N1"-".N
 N BEGIN,END,DA
 S BEGIN=$P(X,"-"),END=$P(X,"-",2)
 S DA=BEGIN-1 L +^PRCF(421.2)
 F  S DA=$O(^PRCF(421.2,DA)) Q:'DA  Q:DA>END  I $D(^(DA,0)) D ONE(DA) W:DA#1000=0 "."
 L -^PRCF(421.2) QUIT
ONE(DA) ;ENTRY POINT TO CONVERT ONE RECORD
 D CVT1^PRCFAES1(DA)
 D CVT1^PRCFAES2(DA)
 QUIT
BUILD ;BUILD ENTRIES IN 443.1 FOR FILE 421.2 CONVERSION
 NEW X,FIRST,LAST,IX,VAR,MSG
 S FIRST=$O(^PRCF(421.2,0)) Q:FIRST=""
 S LAST=$P($G(^PRCF(421.2,0)),"^",3)
 W !,"Finding Last Entry in 421.2"
 F  S X=$O(^PRCF(421.2,LAST)) Q:'X  S LAST=X
 W "   Last Entry = ",LAST
 W !,"Building conversion list for 421.2"
 F IX=FIRST:100:LAST DO
 . S VAR=IX_"-"_(IX+99)
 . D ADD^PRCUPM1("CVT^PRCUX2",VAR,.MSG)
 . W "." K MSG
 . QUIT
 W !,"Conversion list for 421.2 completed.",!
 QUIT
