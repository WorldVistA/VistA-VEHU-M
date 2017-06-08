DGV52PP ;ALB/MTC - DG PRE-PRE INIT FOR VERSION 5.2 ; 12/10/91  14:07
 ;;5.2;REGISTRATION;;JUL 29,1992
 ;
 D DGPR,DGMT
 Q
DGPR ; -- check if new global is set up
 G DGPRQ:$D(^DGPR)
 W !,"The new ^DGPR global must be defined using %GLOMAN before the install can start!",!,"Please refer to the Install Guide for details.",*7
 K DIFQ
DGPRQ Q
DGMT ; -- check if new global is set up
 G DGMTQ:$D(^DGMT)
 W !,"The new ^DGMT global must be defined using %GLOMAN before the install can start!",!,"Please refer to the Install Guide for details.",*7
 K DIFQ
DGMTQ Q
