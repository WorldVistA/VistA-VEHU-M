DENGNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;DEC 20, 1993@16:08:46
 ;;0.0;;**18**;
 ;;7.1;DEC 20, 1993@16:08:46
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
DENGI001 ;;3664308
DENGI002 ;;3626957
DENGI003 ;;3661835
DENGI004 ;;2502833
DENGINI1 ;;5632354
DENGINI2 ;;5232555
DENGINI3 ;;16092563
DENGINI4 ;;3357727
DENGINI5 ;;693324
DENGINIT ;;10517469
