DENANTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;SEP 09, 1993@15:40:18
 ;;0.0;;**15**;
 ;;7.0;SEP 09, 1993@15:40:18
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
DENAI001 ;;10249159
DENAI002 ;;8367938
DENAI003 ;;4768939
DENAI004 ;;7488153
DENAI005 ;;8006833
DENAI006 ;;7821383
DENAI007 ;;8278665
DENAI008 ;;8347953
DENAI009 ;;8315250
DENAI010 ;;8224939
DENAI011 ;;8163292
DENAI012 ;;8300535
DENAI013 ;;8273755
DENAI014 ;;8134868
DENAI015 ;;8406340
DENAI016 ;;3768888
DENAI017 ;;1332203
DENAINI0 ;;258213
DENAINI1 ;;5268772
DENAINI2 ;;5215741
DENAINI3 ;;15730315
DENAINI4 ;;3357689
DENAINIT ;;10902666
DENAIPRE ;;236958
DENTD ;;6135344
DENTD1 ;;9153351
DENTDBL ;;1720711
DENTDC ;;8321672
DENTDC1 ;;10224935
DENTDCM ;;7376822
DENTDCM1 ;;8153109
DENTDCM2 ;;14443416
DENTDCM3 ;;4311973
DENTDCN ;;5909185
DENTDCN1 ;;12221098
DENTDCQ ;;8319427
DENTDCQ1 ;;10616418
DENTDML ;;8337833
DENTDNJ ;;12975627
DENTDNJ1 ;;11752108
DENTDNJ2 ;;8570663
DENTDNK ;;4344731
DENTDNQ ;;9982353
DENTDNQ2 ;;2437624
DENTDPAR ;;1040123
DENTDPL ;;8237323
DENTDSE ;;2175730
