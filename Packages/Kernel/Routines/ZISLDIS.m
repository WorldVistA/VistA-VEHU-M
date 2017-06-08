ZISLDIS ;WILM/RJ - Disconnect Device from Micom Port; SAVE AS %ZISLDIS IN MGR UCI; 6-9-85 ;1/20/93  15:51
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.41
 D ^%ZISLSIT Q:$P(ZISLSITE,"^",2)=""  S (IO,IOP)=$P(ZISLSITE,"^",2),I=0 S:'$D(IO(0)) IO(0)=$I
 I $O(^%ZIS(1,"CPU",0))'="" G MDF
SDF S I=$O(^%ZIS(1,"C",IO(0),I)) Q:I=""  S N=$O(^%ZIS("Z",106,"B",I,0)) G:N="" SDF
 G DISC
MDF S I=$O(^%ZIS(1,"CPU",ZISLCPU_"."_IO(0),I)) Q:I=""  S N=$O(^%ZIS("Z",106,"B",I,0)) G:N="" MDF
DISC S I=N,U="^",C=0,N=^%ZIS("Z",106,I,0) Q:$P(N,U,3)'=1!($P(N,U,2)="")
 U IO(0) W !,"Disconnecting -> " S R="DIS P"_$P(N,U,2) X "O IOP:10" I '$T H $R(7) X "O IOP:10" I '$T Q
 S W=0 F A=1:1 D C^%ZISLVR Q:X'=U!(A>10)  H $R(7)
 I X=U X ^%ZIS("C") Q
 D H^%ZISLVR I X=U X ^%ZIS("C") Q
 U IO(0) W "Bye!" D T S X="" D CP X ^%ZIS("C") Q
T U IO R X:1 S Y="" F I=1:1 D P S X=$E(R,I) Q:X=""  U IO W X
 W *13 F I=1:1 U IO R X:1 S:'$T X=U Q:X=U  S Y=Y_X D P
 Q:Y["TASK COMPLETE"!(Y["NOT CONNECTED")  S C=C+1 Q:C=2  G T
CP ;Disconnect Command Port
 Q:X="^"  S ZISLCPU=$S($D(^%ZOSF("VOL")):^("VOL"),1:"") Q:ZISLCPU=""
 R X:1 S I=0,X="" I $O(^%ZIS(1,"CPU",0))'="" G MDFCP
SDFCP F R=1:1 S I=$O(^%ZIS(1,"C",IO,I)) Q:I=""  S X=$O(^%ZIS("Z",106,"B",I,0)) I X'="" S X=$P(^%ZIS("Z",106,X,0),"^",2) Q:X'=""
 G CPDISC
MDFCP F R=1:1 S I=$O(^%ZIS(1,"CPU",ZISLCPU_"."_IO,I)) Q:I=""  S X=$O(^%ZIS("Z",106,"B",I,0)) I X'="" S X=$P(^%ZIS("Z",106,X,0),"^",2) Q:X'=""
CPDISC Q:X=""!(X<0)  S R=$S('$D(ZISLTYPE):"DIS P",ZISLTYPE=6600:"DISC CH ",1:"DIS P")_X F I=1:1 D P S X=$E(R,I) Q:X=""  U IO W X
 W *13 K IOP,P,R,W,Y,N Q
P F P=1:1:50
 Q
