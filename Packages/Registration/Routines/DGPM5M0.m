DGPM5M0 ;ALB/MRL/MIR - MOVE PARTIAL DATA/REMOVE NEW ENTRIES; 22 JAN 89
 ;;MAS VERSION 5.0;
 ;Move Partial Data
 F I=4,6,7,9,10 S D(I)=$P(NODE,"^",$S(I=4:6,I=6:10,I=7:8,I=10:7,1:9)),DD(I)=+NODE
 S (T,Z)=0 F T1=0:0 S T=$O(^DPT(DFN,"DA",AD,2,T)) Q:T'>0  S X=^(T,0) I +X>Z S Z=+X F I=4,6,7,9,10 I $P(X,"^",I)]"" S D(I)=$P(X,"^",I),DD(I)=+X
 S (T,TSP,Z)=0 F T1=0:0 S T=$O(^DPT(DFN,"DA",AD,"T",T)) Q:T'>0  S X=^(T,0) I +X>Z S Z=+X D TS
 S NODE=+NOD(1)_"^3^"_DFN_"^"_$P(NOD(1),"^",2)_"^"_$P(NOD(1),"^",3)_"^"_D(4)_"^"_D(10)_"^"_D(7)_"^"_D(9)_"^"_D(6) K D,DD,I,X,T,T1,Z Q
 ;
TS F I=2,3 I $P(X,"^",I)]"" S X1=$S(I=2:9,1:7) I +X'>DD(X1) S D(X1)=$P(X,"^",I)
 I $O(^DPT(DFN,"DA",AD,"T",T,"D",0)) S TS=T
 S TSP=+T Q
 ;
DEL S DGPMR=0 F DGPMR1=0:0 S DGPMR=$O(^DGPM("C",DFN,DGPMR)) Q:DGPMR'>0  S DA=DGPMR,DIK="^DGPM(" D ^DIK
 K DA,DIK,DGPMR,DGPMR1 Q
KG F I="DGPMA","DGPMAS","DGPMD","DGPMV","DGPMMV","DGPMNN","DGPMPT","DGPMPTC","DGPMDFN" K ^UTILITY(I,$J,DFN)
 K I Q
 ;
DON1 F I="ADN","DIS","XFR","TSC" K @I,DGPMT(I)
 K ^UTILITY("DGPMXF",$J),J,AD,C,DGPMCT,NOD
DON2 K ADD,C1,CT,CT1,D,DA,DGPM,DGPM1,DGPMF,DGPMFI,DGPMFN,DGPMFX,DGPMFX1,DGPMI,DGPMI1,DGPMMD,DGPMOMD,DIK,I,I1,J1,J2,JJ,JJ1,JJ2,MN,MN1,N,NN,NOD,NODE,PAD,PT,TS,X,X1,X2,X3,XF Q
 ;
 ;The following is ASIH code called from DGPM5M
WHILE S X=$O(^DPT(DFN,"DA",AD,2,"ATT",0)),X=$O(^(+X,0)) I '$D(^DPT(DFN,"DA",AD,2,+X,0)) S $P(NODE,"^",22)=0 Q
 S X=$P(^DPT(DFN,"DA",AD,2,+X,0),"^",12) I $S('$D(^DPT(DFN,"DA",+X,1)):1,+^(1)'=DGPMOMD:1,1:0) S $P(NODE,"^",22)=0 Q
 S $P(NODE,"^",22)=2 I X>AD S $P(^DPT(DFN,"DA",+X,1),"^",6)=1,$P(^(1),"^",1)=+NODE Q
 S X=^UTILITY("DGPMAS",$J,DFN,DGPMOMD),$P(^UTILITY("DGPMV",$J,DFN,$P(X,"^"),$P(X,"^",2)),"^",22)=1,$P(NODE,"^",1)=$P(^($P(X,"^",2)),"^",1) Q
FROM S X1=$O(^DPT(DFN,"DA",AD,2,"ATT",10000000.000005-NODE)),X1=$O(^(+X1,0))
 I $D(^DPT(DFN,"DA",AD,2,+X1,0)) S X=$P(DGPMT(NOD),"^",+$P(^(0),"^",2)),X=$S($D(^DG(405.1,+X,0)):$P(^(0),"^",3),1:0),$P(NODE,"^",22)=$S(X=13:2,X=44:2,1:"") D:$P(NODE,"^",22) FRCONT Q
 S $P(NODE,"^",22)=0 Q
CHANGE I '$D(^DPT(DFN,"DA",AD,2,XF,0)) S $P(NODE,"^",22)=0 Q
 S X=$P(^DPT(DFN,"DA",AD,2,XF,0),"^",12) I $S('$D(^DPT(DFN,"DA",+X,1)):1,+^(1)'=DGPMOMD:1,1:0) S $P(NODE,"^",22)=0 Q
 S $P(NODE,"^",22)=2 I X>AD S $P(^DPT(DFN,"DA",+X,1),"^",6)=1,$P(^(1),"^",1)=+NODE Q
 S X=^UTILITY("DGPMAS",$J,DFN,DGPMOMD),$P(^UTILITY("DGPMV",$J,DFN,$P(X,"^"),$P(X,"^",2)),"^",22)=1,$P(NODE,"^",1)=$P(^($P(X,"^",2)),"^",1) Q
 ;
FRCONT ;set date/asih sequence for the hospital discharge
 S X=$P(^DPT(DFN,"DA",AD,2,+X1,0),"^",12) I $S('$D(^DPT(DFN,"DA",+X,1)):1,+^(1)'=DGPMOMD:1,1:0) S $P(NODE,"^",22)=0 Q
 S $P(NODE,"^",22)=2 I X>AD S $P(^DPT(DFN,"DA",+X,1),"^",6)=1,$P(^(1),"^",1)=+NODE Q
 S X=^UTILITY("DGPMAS",$J,DFN,DGPMOMD),$P(^UTILITY("DGPMV",$J,DFN,$P(X,"^"),$P(X,"^",2)),"^",22)=1,$P(NODE,"^",1)=$P(^($P(X,"^",2)),"^",1) Q
