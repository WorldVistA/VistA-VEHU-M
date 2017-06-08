QIENTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;APR 24, 1992@07:12:47
 ;;1.0; EPRP ;;28 Apr 92
 ;;6.5;APR 24, 1992@07:12:47
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
DGYEPRN ;;7172124
DGYEPRP ;;7228617
DGYESCAN ;;3626755
DGYETBL ;;1473731
DGYEUTL ;;3663404
DGYEUTL1 ;;705984
QIEQA ;;1500151
