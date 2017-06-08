ZISLSTAT ;WILM/RJ - Capture Statistics from Statistics Port; 9-10-86
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S Y=$S($D(^%ZISL(107,"PURGE")):^("PURGE"),1:"") K ^%ZISL(107,"RUN"),^%ZISL(107) S ^%ZISL(107,0)="MICOM STATISTICS^107^",^%ZISL(107,"PURGE")=Y D NOW^%DTC S Y=% X ^DD("DD") S ^%ZISL(107,"START")=Y
1 S ^%ZISL(107,"RUN",$J)=1 D ^%ZISLSIT G:$P(ZISLSITE,"^",3)="" X
 D DT X ^%ZIS("C") G:ZISLTYPE=6600 X S IOP=$P(ZISLSITE,"^",3) D ^%ZIS G:POP X U IO X ^%ZOSF("EOFF"),^%ZOSF("TYPE-AHEAD") X:$D(^%ZOSF("ZMAXBUF")) ^("ZMAXBUF")
 F I=1:1 U IO R D:30 D:$T D Q:'$D(^%ZISL(107,"RUN",$J))
X K ^%ZISL(107,"RUN",$J) Q
D I ZISLTYPE=6600 G D6600
 S E=$P(D," ",1),E=$E(E,$L(E)-3,$L(E)) Q:E=""!(E'?.N)  S T=$P(D," ",2),D=$P(D," ",2,99),D=$E(D,4,50),J=$P(D," ",1),K=$P(D," ",2),C=$P(D," ",3),D=$E(D,18,50),Y=$P(D," ",1),Z=$P(D," ",2)
 S G=^%ZISL(107,0),G1=+$P(G,"^",3)+1,G=$P(G,"^",1,2)_"^"_G1_"^"_($P(G,"^",4)+1),^%ZISL(107,0)=G,^%ZISL(107,G1,0)=E_"^"_T_"^"_J_"^"_K_"^"_C_"^"_Y_"^"_Z
 Q
D6600 ;
 Q
DT F Z1=1:1:5 D 1^%ZISLVR Q:X'=U  H $R(7)
 Q:X=U  S ZISLTYPE=$S(X[">":6600,1:"") I ZISLTYPE=6600 G 6600
 S %DT="P",X="JAN 1" D ^%DT S X=Y D DW^%DTC,D1 S R="DAT "_R D T
 S X=$P($H,",",2),R=X\3600 S:R<10 R="0"_R S X=X#3600,R=R_(X\60) S:$L(R)=3 R=$E(R,1,2)_"0"_$E(R,3) S X=X#60 S:X<10 X="0"_X S R="TIM "_R_X D T
 S R="SOF" D T S R="SON" D T D CP^%ZISLDIS K %DT,R Q
6600 D NOW^%DTC S:$L(%I(1))=1 %I(1)=0_%I(1) S:$L(%I(2))=1 %I(2)=0_%I(2) S D=%I(1)_"/"_%I(2),%=$P(%,".",2),H=$E(%,1,2) S:$L(H)=1 H=H_0 S M=$E(%,3,4) S:$L(M)=1 M=M_0 S R="SET TD" D T S R=H_":"_M_":00" D T S R=D D T
 Q
T U IO X ^%ZOSF("XY") S Y="" F J=1:1 D P S X=$E(R,J) Q:X=""  U IO W X
 W *13 F J=0:0 U IO R *X:1 Q:X=-1
 Q
D1 S R=$H-%H+1 Q:$L(R)=3  S R="0"_R Q:$L(R)=3  S R="0"_R Q
P F P=1:1:100
 Q
