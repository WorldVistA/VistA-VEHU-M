GCHECK ;BFH;LOOK FOR BAD BLOCKS AT THE END OF GLOBALS [ 05/20/94  4:39 PM ]
 ;Copyright Micronetics Design Corp. @1994
 I $V(2,$J,2)'=1 W !,"Must be run from ",$ZU(1,0) Q
 NEW %ZT,COUNT,G,GNAM,GREF,I,UI,VG,VGI
 S %ZT="ERR^GCHECK",$ZT="%MGR^%LOGON"
 S COUNT=0,G=""
 W !!,"Checking for errors at end of globals",!
 D GETVG^%VGUTIL
 S VGI="" F  S VGI=$O(VG(VGI)) Q:VGI'?1.N  DO
 .F UI=1:1:30 I $ZU(UI,VGI)'="" DO CHECK
 V 2:$J:1:2
DONE ;
 W !,$S(COUNT=0:"No",1:COUNT)," error",$S(COUNT=1:"",1:"s")," found"
 Q
ERR ;
 I $F($ZE,"<INRPT>") U 0 W !!,"...Aborted." V 0:$J:$ZB($V(0,$J,2),#0400,7):2
 ZQ
CHECK ;
 W !,"Checking UCI ",$ZU(UI,VGI),!
 V 2:$J:VGI*32+UI:2
 F  S G=$O(@("^"_G)) Q:G=""  DO
 .S GREF="^"_G_"("""")"
 .W "^",G F I=1:1:8-$L(G) W " "
 .W *13
 .S GNAM="^"_G
 .S GREF=$Q(@GREF,-1) Q:GREF=""
 .F  S GREF=$Q(@GREF) Q:GREF=""  I $P(GREF,"(")'=GNAM W *13,*7,"ERROR FOUND IN ^",G,! S COUNT=COUNT+1 Q
 W $J("",9)
 Q
