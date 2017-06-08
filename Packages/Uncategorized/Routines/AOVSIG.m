AOVSIG ; SLC/JER/AFE - OP Rx Summary Component (V6) ;JUN 09, 1998@17:00;
 ;;2.7;Health Summary;**15**;Oct 20, 1995
 ;;;PALO ALTO LOCAL MODS;2980609
 ;********** LOCAL VAPA MODIFICATION BEGIN ************
 ; This subroutine is to be used to changed the Outpatient Medicine 
 ; Instructions (file 52, field 10) to the detailed description.
 ; Done on 24-Jun-97 by Steve Winterton
SIG(X) ;Modifies SIG to detail description
 N SIG,PSI,Z9,Y
 S SIG=""
 F PSI=1:1 Q:$P(X," ",PSI,99)=""  S Z9=$P(X," ",PSI),Y="" Q:$L(Z9)>32  D SIG1:Z9]"" S SIG=SIG_Z9_" "
 S X=SIG
 Q
SIG1 I $D(^PS(51,"A",Z9)) S %=^(Z9),Z9=$P(%,"^") Q:$P(%,"^",2)=""  S Y=$P(X," ",PSI-1),Y=$E(Y,$L(Y)) S:Y>1 Z9=$P(%,"^",2) Q
 Q
 ;********** LOCAL VAPA MODIFICATION END ************
