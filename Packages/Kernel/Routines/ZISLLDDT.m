ZISLLDDT ;WILM/RJ - Load Micom with CPU Date and Time; 6-9-85
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 D 1^%ZISLVR I X=U W !,"No connection made." K IOP,P,W,X,Y,ZISLSITE Q
 S ZISLTYPE=$S(X["?":600,1:6600) U IO(0) W !,"Loading Micom ",ZISLTYPE," with CPU Date and Time..." G:ZISLTYPE=6600 6600 S %DT="P",X="JAN 1" D ^%DT S X=Y D DW^%DTC,D S R="DAT "_R D T^ZISLDIAL
 U IO(0) S X=$P($H,",",2),R=X\3600 S:R<10 R="0"_R S X=X#3600,R=R_(X\60) S:$L(R)=3 R=$E(R,1,2)_"0"_$E(R,3) S X=X#60 S:X<10 X="0"_X S R="TIM "_R_X D T^ZISLDIAL
Q D CP^%ZISLDIS X ^%ZIS("C") K %DT,R,X,Y,ZISLSITE,ZISLTYPE,ZISLCPU Q
D S R=$H-%H+1 Q:$L(R)=3  S R="0"_R Q:$L(R)=3  S R="0"_R Q
6600 S R="SET TD" D T^ZISLDIAL
 D NOW^%DTC S R=$E($P(%,".",2),1,2)_":"_$E($P(%,".",2),3,4)_":00" D T^ZISLDIAL S R=$E(%,4,5)_"/"_$E(%,6,7) D T^ZISLDIAL
 G Q
