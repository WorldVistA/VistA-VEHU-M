ZISLVR ;WILM/RJ - Verify, Reset Micom Command Port Connection; SAVE AS %ZISLVR IN MGR UCI; 6-9-85
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 X ^%ZOSF("UCI") I Y["MGR" W !,"You cannot run this program from the MGR UCI." Q
 I '$D(^%ZOSF("VOL")) W !,"First, you need to set %ZOSF(""VOL"") to the 3-char volume set of this cpu." Q
 S ZISLCPU=^("VOL") W !! I '$O(^%ZIS("Z",108,"B",ZISLCPU,0)) W !,"You have not set up your MICOM SITE PARAMETERS file #108 correctly.",!,"Please see section under Micom Site Parameters in the manual." Q
 D ^%ZISLSIT W !,"Site Name: ",$P(ZISLSITE,"^",1) S ZISLCPU=$O(^%ZIS("Z",108,"B",ZISLCPU,0))
 S (DIC,DIE)="^%ZIS(""Z"",108,",DA=ZISLCPU,DR=1 D ^DIE,^%ZISLSIT K DIC,DIE,DR,DA I $P(ZISLSITE,"^",2)="" W !,"You must enter a device into this field before I can continue." Q
 S IOP=$P(ZISLSITE,"^",2) D ^%ZIS I POP W !,"Device ",$P(ZISLSITE,"^",2)," is busy.  Try later." K IOP Q
 W !!,"Wait, Trying to connect->" S W=1 D C U IO(0) G:X=U E W !?6,"Connection made with command port..." D H,E K ZISLSITE,ZISLTYPE Q
C S Y="" U IO X ^%ZOSF("EOFF"),^%ZOSF("TYPE-AHEAD") X:$D(^%ZOSF("ZMAXBUF")) ^("ZMAXBUF") W *13,*13 F I=1:1 R *X:1 S:'$T X=U Q:X=U  S Y=Y_$C(X) S:$L(Y)>240 Y="" D P
 U:W IO(0) I Y["UNASSIGNED" W:W !?6,"No port set up for class.  See Manual." Q
 I Y'["GO"&(Y'["?")&(Y'["B>")&(Y'["A>")&(Y'["CONNECTED") W:W !?6,"No Connection Made.  See Manual." Q
 S X="" Q
H U IO W *13 F I=1:1:4 R X:1 D P Q:X["?"!(X["B>")!(X["A>")
 U:W IO(0) I X["?"!(X["B>")!(X["A>") S ZISLTYPE=$S(X["?":600,1:6600) W:W !?6,"Micom ",ZISLTYPE," connected.",!! U IO R I:1 Q
 E  W:W !?6,"Micom not responding." S X=U
 Q
1 D ^%ZISLSIT I $P(ZISLSITE,"^",2)="" S X=U Q
 S DX=0,DY=0,(IOP,IO)=$P(ZISLSITE,"^",2),W=0,U="^" D ^%ZIS K IOP S:POP X=U D:X'=U C I X=U X ^%ZIS("C") Q
 D H X:X=U ^%ZIS("C") Q
E D:IO'="" CP^%ZISLDIS X:IO'="" ^%ZIS("C") K %ZIS,I,IOP,P,W,X,Y,ZISLSITE,ZISLCPU Q
P F P=1:1:50
 Q
