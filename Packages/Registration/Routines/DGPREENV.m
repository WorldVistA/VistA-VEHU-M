DGPREENV ;ALB/SCK - Pre-Registration Environment check ; 1/9/97
 ;;5.3;Regisitration;**109**;Aug 13, 1993
 ;
ENVCHK ; Environment check for Patch sequencing
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) W !!,">> DUZ and DUZ(0) must be defined as an active user to initialize." S XPDABORT=1
 ;
 W !!,"Checking pre-KIDS patch sequence for Patch DG*5.3*32"
 S Y=$T(+2^DG10)
 I '$F($P(Y,"**",2),"32")>0 D
 . W !!,"Patch 32 has not been installed"
 . S XPDABORT=1
 Q
