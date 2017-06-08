DGMT ;ALB/JDS - MEANS TEST ; 21 APR 86
 ;;MAS VERSION 5.1;
EN K B,DIC S DIC="^DG(41.3,",DIC(0)="QEAMZ" D ^DIC G Q1:Y'>0 S DFN=+Y,DGJUMP=1
E S:'$D(^DG(41.3,DFN,2,0)) ^(0)="^41.33DI^^" S DIC="^DG(41.3,"_DFN_",2,",DA(1)=DFN,DIC("B")=$S($O(^DG(41.3,DFN,2,0)):$O(^(0)),1:"") D ^DIC G Q1:Y'>0 S DGCD=+Y(0) I $P(Y(0),U,2)="N" W !,"Cannot edit No Longer Required",! G E
 S DR="0;1",DA=+Y K ^UTILITY($J) D EN^DIQ
EN1 K B,DIC I '$D(^DG(41.3,DFN,1,0)) S ^(0)="^41.31DA^^"
 S IOP="" D ^%ZIS K IOP
 S DGLY=$E(DGCD,1,3)-1_"0000",DIC="^DG(41.3,"_DFN_",1,",DA(1)=DFN,X=DGLY,DIC(0)="LM" D ^DIC I '$D(^DG(41.3,DFN,1,DGLY,1,0)) D MOV^DGMT2 G Q:%=-1 S ^DG(41.3,DFN,1,DGLY,1,0)="^41.32ISA^^"
 S DGMS=$P(^DPT(DFN,0),U,5) S DIE="^DG(41.3,"_DFN_",1,",DA(1)=DFN,DR="2"_$S($D(^DIC(11,+DGMS,0)):$S("N"[$E(^(0),1):"///0","DW"[$E(^(0),U,1):"//SINGLE",1:""),1:"")_";3",DA=DGLY D ^DIE G Q:$D(Y)
 S DGN=1,B(1)="",DG0=^DG(41.3,DFN,1,DGLY,0),DGNC=+$P(DG0,U,3) S:$P(DG0,U,2)=1 B(2)="",DGN=2 S:DGNC B(3)="",DGN=DGN+1 S:DGNC>1 B(4)="" S:DGNC>2 B(5)=""
 S DIC(0)="LM",DIC="^DG(41.3,"_DFN_",1,"_DGLY_",1,",DA(2)=DFN,DA(1)=DGLY F DA=1:1:5 D SET
EN2 F X=0:0 S X=$N(B(X)) Q:X'>0  S X(X)=$S($D(^DG(41.3,DFN,1,DGLY,1,X,0)):^(0),1:0)
 I $P(^DG(41.3,DFN,2,9999999-DGCD,0),U,14) G REF^DGMT2
 I DGNC>1 F I=4,5 F J=2:1:15 I I=4!(DGNC>2) S $P(X(3),U,J)=$P(X(3),U,J)+$P(X(I),U,J)
 S Y=DGLY X ^DD("DD") W @IOF,!,"Means Test Income for ",$P(^DPT(DFN,0),U,1),"  ",$P(^(0),U,9)," for ",Y
 S A=9999999-DGCD I $P(^DG(41.3,DFN,2,A,0),U,14) S DIE="^DG(41.3,"_DFN_",2,",DA=A,DA(1)=DFN,DR=14 D ^DIE I $P(^DG(41.3,DFN,2,A,0),U,14) G REF^DGMT2
 W !,$P($P($P(^DD(41.31,2,0),U,3),+$P(DG0,U,2)_":",2),";",1)
 S DGNC=+$P(DG0,U,3) W ?40,"Number of dependent children ",DGNC
 S DGMT=$S($D(^DG(43,1,"MT",DGLY+10000,0)):^(0),1:""),DGA=$P(DGMT,U,2)+$S(DGN-1:$P(DGMT,U,3),1:0)+($P(DGMT,U,4)*$S($D(B(2))&DGNC:(DGNC),DGNC:DGNC-1,1:0))
 S DGB=$P(DGMT,U,5)+$S(DGN-1:$P(DGMT,U,6),1:0)+($P(DGMT,U,7)*$S($D(B(2))&(DGNC):(DGNC),DGNC:DGNC-1,1:0))
 W !,"Income thresholds:   Category A: " S X=DGA D FOR W "  Category B: " S X=DGB D FOR W !
 W ! S J=0,B(6)="" F K=1:1:4 S J=$N(B(J)) Q:J'>0  S:J>3 J=6 W ?(K*12+18),$J($P("VETERAN^SPOUSE^CHILDREN^^^TOTAL",U,J),9) Q:J=6
 W ! S X(4)="" F I=1:1:14 D TOT:I=11 W !,$J(I,2),?3,$P(^DD(41.32,I,0),U,1) S J=0 F K=1:1:4 S J=$N(B(J)) Q:J'>0  S:J>3 J=4 S:J'=4 $P(X(4),U,I+1)=$P(X(4),U,I+1)+$P(X(J),U,I+1) W ?(12*K+15) S X=$P(X(J),U,I+1) D FOR Q:J=4
 S DGC=$S(DGT'>DGA:"A",DGT'>DGB:"B",1:"C"),DGW=-$P(X(4),U,15) F I=12:1:14 S DGW=DGW+$P(X(4),U,I)
 W !,"Income of" S X=DGT D FOR W " Category ",DGC I (DGW+DGT)>$P(DGMT,U,8)&(DGC'="C") W " Property of " S X=DGW D FOR W "  would make Category C"
ASK S DGV=0 R !!,"Enter # to edit or 'ALL' for all fields: ",X:DTIME G Q:'$T!(X[U),COM^DGMT1:X']"",H:X["?" S Z="^ALL"_$S('(DGT+DGW):"^REFUSES",1:"") D IN^DGHELP G REF^DGMT2:X="R"&(%'=-1) I X="A" S DR="1:14" G ALL
 I "VSC"[$E(X,1) S DGV=$F("VSC",$E(X,1))-1,X=$E(X,2,999)
 I '+X W *7,"??" G ASK
 F I=1:1:$L(X) S Y=$E(X,I) S:Y="-" X=$E(X,1,I-1)_":"_$E(X,I+1,$L(X)) S:Y="," X=$E(X,1,I-1)_";"_$E(X,I+1,$L(X)) I ";-:,"'[Y&(Y'?1N) S X=$E(X,1,I-1)_$E(X,I+1,$L(X)),I=I-1
 I +X=X&(X'<1)&(X'>15) S DR=X G ALL
 ;
 I +X<1!(+X>15)!('$E(X,1)) G ASK
 S DR=X G ALL
ALL F A=0:0 S (A,DA)=$N(B(A)) Q:A'>0!(A>5)  I 'DGV!(DGV=A)!((DGV=3)&(A>2)) S DIE="^DG(41.3,"_DFN_",1,"_DGLY_",1,",DA(2)=DFN,DA(1)=DGLY W !!,"For ",$P("Veteran^Spouse^Child 1^Child 2^Other Children",U,DA),! D ^DIE
 G EN2
SET I $D(B(DA)),'$D(@(DIC_DA_",0)")) S X=DA D ^DIC Q
 I '$D(B(DA)),$D(@(DIC_DA_",0)")) S DIK=DIC D ^DIK
 Q
TOT S DGT=0 F K=2:1:11 S DGT=DGT+$P(X(4),U,K)
 W !,?(DGN+1*12),"Total 1-10 --> " S X=DGT D FOR
 Q
FOR G FOR^DGMT2
H G H^DGMT2
Q K %,%X,%DT,A,B,D,DA,D0,D1,DG0,DG1,DGA,DGADJ,DGB,DGC,DGCD,DGFR,DIV,DGK,DGL,DGLY,DGMS,DGN,DGMT,DGNC,DGP,DGS,DGT,DGTO,DGV,DGW,DGX,DGY,DIC,DIE,DIK,DR,I,J,K,L,POP,S,XY I $D(DGJUMP) G @($P("EN;ADD^DGMT2;MT^DGMT1",";",DGJUMP))
 Q
Q1 K DGIO,DGJUMP G Q
