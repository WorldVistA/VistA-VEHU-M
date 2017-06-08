DGYGPRE ;ALB/AAS/REW - MAS PATCH PRE-INITIALIZATION ROUTINE ; 1-JAN-92
 ;;5.2;REGISTRATION;**22**;JUL 29,1992
 ;
% D NOW^%DTC S DGBDT=$H,DT=X,Y=% W !!,"Initialization Started: " D DT^DIQ W !!
USER I $S('($D(DUZ)#2):1,'$D(^DIC(3,+DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must equal '@' to initialize.",! K DIFQ G NO
 ;
MAS I $D(DIFQ),+$G(^DD(43,0,"VR"))'>5.1 K DIFQ W !!,?3,"MAS Version 5.2 must be installed first!" G NO
 ;
IB I $D(DIFQ),+$G(^DD(350,0,"VR"))<1.5 K DIFQ W !!?3,"IB Version 1.5 must be installed first!" G NO
 ;
PRC I $D(DIFQ),+$G(^DD(43,0,"VR"))'>3.5 K DIFQ  W !,"AR v3.7 must be installed first" G NO
 ;
 ;
NO I '$D(DIFQ) W !,"INITIALIZATION ABORTED"
 Q
