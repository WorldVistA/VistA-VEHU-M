CUAAVR ;RJ WILMIGTON DE & LM COLUMBIA SC-VERIFY,RESET MICOM CMD PORT CONNECTION; 6-9-85
 ;Version 3.6
A S:'$D(DTIME) DTIME=100 S U="^",W=1,%ZIS("A")="Micom Command Port DZ Device: " S:$D(^%ZIS("Z","CUAA","DEV")) %ZIS("B")=^("DEV") K IOP D ^%ZIS G:IO="" E I IO=IO(0) W "Micom Device cannot be YOUR Device!",! G A
 S ^%ZIS("Z","CUAA","DEV")=IO D C G:X=U E W !,"Connection made with command port..." D H,E K IO Q
C S Y="",^DISV(IO(0),"^%ZIS(1,")=IO(0) U IO X ^%ZOSF("EOFF"),^%ZOSF("TYPE-AHEAD") X:$D(^%ZOSF("ZMAXBUF")) ^("ZMAXBUF") W *13 F I=1:1 R X:1 S:'$T X=U Q:X=U  S Y=Y_X D P
 U IO(0) I Y["UNASSIGNED" W:W !,"No port set up for class.  See Manual." Q
 I Y'["GO"&(Y'["?") W:W !,"No Connection.  See Manual." Q
 S X="" Q
H U IO W *13 F I=1:1:4 R X:1 D P Q:X["?"
 U IO(0) I X["?" W:W !,"Micom connected.",!! U IO R X:1 Q
 E  W:W !,"Micom not responding." S X=U
 Q
1 I '$D(^%ZIS("Z","CUAA","DEV")) S X=U Q
 S DX=0,DY=0,(IOP,IO)=^("DEV"),W=0,U="^" D ^%ZIS D C I X=U X ^%ZIS("C") Q
 D H X:X=U ^%ZIS("C") Q
E D:IO'="" CP^CUAADIS X:IO'="" ^%ZIS("C") K %ZIS,I,IOP,P,W,X,Y Q
P F P=1:1:250
 Q
