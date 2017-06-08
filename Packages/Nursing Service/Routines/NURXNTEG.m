NURXNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;DEC 20, 1994@13:44:32
 ;;2.5;NURSING FIXES;**20,21,22,29**;DEC 20, 1994
 ;;7.1;DEC 20, 1994@13:44:32
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
NURXI001 ;;5120572
NURXI002 ;;2163427
NURXINI1 ;;5627017
NURXINI2 ;;5232677
NURXINI3 ;;16095345
NURXINI4 ;;3357849
NURXINI5 ;;474434
NURXINIS ;;2219575
NURXINIT ;;10792848
NURXPOS1 ;;290330
