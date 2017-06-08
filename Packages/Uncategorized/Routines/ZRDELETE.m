%RDELETE ;GFT/SF ;
 ;4.3
 ;FOR VAXDSM2.2pke/albany
 W !,"ROUTINE DELETE",!
 K %UTILITY D ^%RSEL S X=0,X=$N(%UTILITY(X)) Q:X<0
 S Y=X F I=1:1 S Y=$N(%UTILITY(Y)) I Y<0 W !,I," ROUTINES" Q
 R !,"OK TO DELETE? NO// ",I Q:"yY"'[$E(I_1,1)
 W ! X "F I=1:1 ZR  ZS @X W ""  "",X S X=$N(%UTILITY(X)) Q:X<0"
