DGYGNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;MAY 19, 1993@15:07
 ;;5.2;REGISTRATION;**22**;JUL 29,1992
 ;;0.0;
 ;;7.0;MAY 19, 1993@15:07
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
DG1010P ;;14271906
DGA4004 ;;11609708
DGBTE1 ;;19353265
DGBTEF ;;17560116
DGMTA ;;7693570
DGMTAUD ;;9429788
DGMTAUD1 ;;85791
DGMTCOM ;;1409819
DGMTCOR ;;5850820
DGMTCOST ;;987768
DGMTCOU ;;2047183
DGMTCOU1 ;;3441600
DGMTDD ;;5296793
DGMTDEL ;;9632454
DGMTE ;;2638664
DGMTEO ;;3308362
DGMTM ;;1268897
DGMTOREQ ;;8011776
DGMTP ;;5237602
DGMTP2 ;;13975368
DGMTP4 ;;12233970
DGMTR ;;4651515
DGMTSC ;;2692004
DGMTSC4 ;;4989763
DGMTSCC ;;11109594
DGMTSCU ;;2716592
DGMTSCU2 ;;3506131
DGMTU ;;7404973
DGMTU11 ;;5025341
DGMTUB ;;3480486
DGMTV ;;6491590
DGPMGLG2 ;;15170971
DGPTFVC1 ;;15576437
DGPTUTL1 ;;7521194
DGREG0 ;;9204974
DGRP ;;1060986
DGRP8 ;;9786787
DGRP9 ;;8611620
DGRPD ;;18482430
DGRPDB ;;9173899
DGRPU ;;4463240
DGYGPOST ;;1915848
DGYGPRE ;;3070638
DGYGPT ;;11097602
SDPP ;;13947939
