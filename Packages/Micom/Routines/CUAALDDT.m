CUAALDDT ;RJ WILMINGTON DE & LM COLUMBIA SC-LOAD MICOM WITH CPU DATE & TIME; 6-9-85
 ;Version 3.6
 D 1^CUAAVR I X=U W !,"No connection made." K IO,IOP,P,W,X,Y Q
 U IO(0) W !,"Loading Micom with CPU Date and Time..." S %DT="P",X="JAN 1" D ^%DT S X=Y D DW^%DTC,D S R="DAT "_R D T^CUAADIAL
 U IO(0) S X=$P($H,",",2),R=X\3600 S:R<10 R="0"_R S X=X#3600,R=R_(X\60) S:$L(R)=3 R=$E(R,1,2)_"0"_$E(R,3) S X=X#60 S:X<10 X="0"_X S R="TIM "_R_X D T^CUAADIAL
 D CP^CUAADIS X ^%ZIS("C") K %DT,IO,R,X,Y Q
D S R=$H-%H+1 Q:$L(R)=3  S R="0"_R Q:$L(R)=3  S R="0"_R Q
