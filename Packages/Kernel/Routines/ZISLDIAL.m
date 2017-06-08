ZISLDIAL ;WILM/RJ - Micom Dialogue Mode; 6-9-85
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S T=DTIME,DTIME=20,U="^",DX=0,DY=0 D 1^%ZISLVR I X=U W "No connection made.",! G E
 U IO(0) W !!,"Connected to Micom ",ZISLTYPE,"...GO"
 F J=1:1 W !,"Enter Micom ",ZISLTYPE," Command >" R R:DTIME S:'$T R=U W:'$T "  ...Timeout." W ! G:R[U E D S:R["STA",H:R["?",T:R'["?"&(R'["STA")&(R'["DIS*"),D:R["DIS*" U IO(0)
E W "Good-bye." X ^%ZOSF("EON") D CP^%ZISLDIS X ^%ZIS("C") S DTIME=T K ZISL,I,J,L,P,S,T,V,W,X,Y,ZISLSITE,ZISLCPU,ZISLTYPE Q
S S ZISL(1)=$S($E(R,6)="":1,1:$E($P(R," ",2),2,4)),S=$P(R," ",3),ZISL(2)=$S($E(S,1)="L"!($E(S,1)="P"):$E(S,2,4),$E(R,6)="":1000,1:$E($P(R," ",2),2,4)),S=R
 F I=ZISL(1):4:ZISL(2) S R=$E(R,1,5)_I,L=$S(ZISL(2)-I'<4:I+3,ZISL(2)-I<4:ZISL(2),1:I) S:ZISL(1)'=ZISL(2) R=R_" "_$E(S,5)_L D T U IO(0) I (ZISL(2)-I'<4&($L(S)<9)) R !,"Continue (Y/N): Y// ",X:DTIME W ! I '$T!((X'["Y")&(X'["y")&(X'="")) Q
 Q
T U IO X ^%ZOSF("XY") U IO(0) S Y="" F J=1:1 D P S X=$E(R,J) Q:X=""  U IO W X
 W *13 U IO(0) W !
 F J=0:0 U IO R *X:1 Q:X=-1  U IO(0) W *X S Y=Y_$C(X) S:$L(Y)>200 Y=""
 Q
P F P=1:1:100
 Q
H W !,"Type in the command to be sent to the Micom command port followed by a <RETURN>",!,"or type ""^"" followed by <RETURN> to exit.",! Q
H1 W !!,"You would NOT WANT TO DISCONNECT the PORT that connects to the Command Port,",!,"Or the LINE that connects to the CPU accessing the Command Port,",!,"Or the terminal you are now using,",!,"Or someone else is using.",!! Q
D I ZISLTYPE=6600 W !,"Module not developed for use with the 6600." Q
 R !,"Enter in LINE/PORT numbers that should NOT be disconnected (ex: 1,5,6): ",L:DTIME Q:'$T  S L=","_L_",",V="L" I L=",," W !!,"You should NOT disconnect your command port or terminal you are using!  See manual.",!! Q
 I L["?" D H1 G D
 I L'?1",".N1",".E W !,"Enter it like this: 1,5,6,10,20" G D
 W !!,"To interrupt DIS command type an ""^"" (no RETURN)." F I=1:1 I '$F(L,","_I_",") S R="DIS "_V_I D T S:Y["SPECIFICATION ERROR"&(I<15) V="P",I=0,Y="" D I Q:Y["SPECIFICATION ERROR"
 Q
I U IO(0) R *X:0 S:X=94 Y="SPECIFICATION ERROR" Q
