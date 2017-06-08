HBHWNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;MAY 10, 1994@11:14:06
 ;;0.0;;**3**;
 ;;7.1;MAY 10, 1994@11:14:06
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
HBHCXMT ;;8388350
HBHWI001 ;;5351456
HBHWI002 ;;1049327
HBHWI003 ;;842338
HBHWI004 ;;2206723
HBHWINI1 ;;5626621
HBHWINI2 ;;5232599
HBHWINI3 ;;16093245
HBHWINI4 ;;3357771
HBHWINI5 ;;531935
HBHWINIS ;;2210899
HBHWINIT ;;10930737
