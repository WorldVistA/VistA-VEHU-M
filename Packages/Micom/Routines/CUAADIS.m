CUAADIS ;RJ WILMINGTON DE-DISCONNECT DEVICE FROM MICOM PORT; 6-9-85
 ;Version 3.6
 Q:'$D(^%ZIS("Z","CUAA","DEV"))  S:'$D(IO(0)) IO(0)=$I S IOP=^("DEV"),I=$N(^%ZIS(1,"B",IO(0),0)),I=$N(^%ZIS("Z",106,"B",I,0)),U="^",C=0,W=0 Q:I=-1  Q:$P(^%ZIS("Z",106,I,0),U,3)'=1!($P(^%ZIS("Z",106,I,0),U,2)="")
 S R="DIS P"_$P(^%ZIS("Z",106,I,0),U,2) F A=1:1 D ^%ZIS Q:IO'=""!(A>10)  H $R(7)
 Q:IO=""  F A=1:1 D C^CUAAVR Q:X'=U!(A>10)  H $R(7)
 Q:X=U  D H^CUAAVR I X=U X ^%ZIS("C") Q
 D T S X="" D CP X ^%ZIS("C") Q
T U IO R X:1 S Y="" F I=1:1 D P S X=$E(R,I) Q:X=""  U IO W X
 W *13 F I=1:1 U IO R X:1 S:'$T X=U Q:X=U  S Y=Y_X D P
 Q:Y["TASK COMPLETE"!(Y["NOT CONNECTED")  S C=C+1 Q:C=2  G T
CP Q:X=U  U IO R X:1 U IO(0) S I=$N(^%ZIS(1,"B",IO,0)),I=$N(^%ZIS("Z",106,"B",I,0)) Q:I=-1  Q:$P(^%ZIS("Z",106,I,0),U,2)=""  S R="DIS P"_$P(^%ZIS("Z",106,I,0),U,2) F I=1:1 D P S X=$E(R,I) Q:X=""  U IO W X
 W *13 U IO(0) K IOP,P,R,W,Y Q
P F P=1:1:50
 Q
