ONCCNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;MAR 31, 1994@11:08:37
 ;;2.1;MINI-INITS FOR ONC*2.1*7;;Mar 31, 1994
 ;;7.1;MAR 31, 1994@11:08:37
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
ONCCENV ;;151390
ONCCI001 ;;5004228
ONCCI002 ;;5335366
ONCCI003 ;;7057983
ONCCI004 ;;8456119
ONCCI005 ;;8277521
ONCCI006 ;;8638616
ONCCI007 ;;8536283
ONCCI008 ;;7595521
ONCCI009 ;;1413854
ONCCI00A ;;9796909
ONCCI00B ;;9647191
ONCCI00C ;;1175015
ONCCINI1 ;;5649157
ONCCINI2 ;;5232535
ONCCINI3 ;;16092793
ONCCINI4 ;;3357707
ONCCINI5 ;;565804
ONCCINIS ;;2208841
ONCCINIT ;;11175279
ONCCPOS ;;1469704
ONCOCOS ;;9194348
