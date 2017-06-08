SDV52PP ;ALB/MTC - SD PRE-PRE INIT FOR VERSION 5.2 ; 4/3/92  14:07
 ;;5.2;SCHEDULING;;JUL 29,1992
 ;
 D SDD
 Q
 ;
SDD ; -- check if new global is set up
 G SDDQ:$D(^SDD)
 W !,"The new ^SDD global must be defined using %GLOMAN before the install can start!",!,"Please refer to the Install Guide for details.",*7
 K DIFQ
SDDQ Q
 ;
 ;
