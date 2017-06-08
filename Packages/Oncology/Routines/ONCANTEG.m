ONCANTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;FEB 14, 1994@08:53:36
 ;;2.1;Oncology;**3**;Oct 29, 1993
 ;;7.1;FEB 14, 1994@08:53:36
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
ONCAENV ;;638107
ONCAI001 ;;3782567
ONCAI002 ;;2698644
ONCAINI1 ;;5677057
ONCAINI2 ;;5232527
ONCAINI3 ;;16092669
ONCAINI4 ;;3357699
ONCAINI5 ;;472339
ONCAINIS ;;2208315
ONCAINIT ;;11174698
ONCAPOS ;;1769208
ONCAPRE ;;97343
