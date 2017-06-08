DGPTF3 ;ALB/MRL - DETERMINE & STORE PTF MEANS TEST INDICATOR ; 10 FEB 87
 ;;MAS VERSION 5.1;
EN ;
 S DGZEC=$S($D(^DPT(DFN,.36)):$P(^(.36),U,1),1:""),DGZEC=$S($D(^DIC(8,+DGZEC,0)):^(0),1:"") I $P(DGZEC,U,5)="N" S DGX="N" G DIE
 I AD<2860701 S DGX="X" G DIE
 I $D(^DGPT(PTF,101)),$D(^DIC(45.1,+^(101),0)),$P(^(0),"^",4) S DGX="X" G DIE
 I $P(^DG(43,1,0),U,21),AD]"" S DGT=AD D ^DGINPW I DG1,$S('$D(^DIC(42,+DG1,0)):0,$P(^(0),U,3)="D":1,1:0) S DGX="X" G DIE
 S DGT=$S($D(^DGPT(PTF,70)):$P(^(70),U,1),1:""),DGT=9999999-$S(DGT]"":DGT,1:DT_.9) G AS:'$O(^DG(41.3,DFN,2,0)) F DGZ=0:0 S DGZ=$O(^DG(41.3,DFN,2,DGZ)) Q:DGZ'>0!($D(DGZ1))  I DGZ>DGT S DGZ1=^(DGZ,0)
 S DGX=$S('$D(DGZ1):"U",1:$P(DGZ1,U,2)),DGX=$S(DGX="A":"AN","BN"[DGX:DGX,"CP"[DGX:"C",1:"U") G DIE:DGX'="N"
AS S DGZ=$S($D(^DPT(DFN,.321)):^(.321),1:0) I $P(DGZ,U,2)="Y"!($P(DGZ,U,3)="Y") S DGX="AS" G DIE
 I $P(DGZEC,U,5)="Y",$P(DGZEC,U,4)<4,"^2^15^"'[(U_$P(DGZEC,U,9)_U) S DGX="AS" G DIE
 I DGZEC]"" S DGX="AN" G DIE
 S DGX="U" I '$D(DGLN) W !,"===> this patient has a blank Eligibility Code"
DIE W ! S DA=PTF,DR="10///"_DGX_$S('$P(^DGPT(PTF,0),U,3):";3///`"_^DD("SITE",1),1:""),DIE="^DGPT(" D ^DIE K DGZEC,DGZ,DGZ1,DG1,DR,DGT Q
