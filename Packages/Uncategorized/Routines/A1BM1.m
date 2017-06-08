A1BM1 ;ALB/QAD - BACK BILLING STORAGE, CONTINUED ; 22 AUG 90
 ;;BACK BILLING 1.0;
 ;;BACK BILLING 1.0;
ADD ;search through add/edits for date range
 F I=A1BMSD:0 S I=$O(^SDV(I)) Q:'I!(I>A1BMED)  I $D(^SDV(I,0)) S DFN=$P(^(0),"^",2) D IF
APPT ;search through appointments for date range
 F C=0:0 S C=$O(^SC("AC","C",C)) Q:'C  I $D(^SC(C,0)) F I=A1BMSD:0 S I=$O(^SC(C,"S",I)) Q:'I!(I>A1BMED)  F J=0:0 S J=$O(^SC(C,"S",I,J)) Q:'J  D APPT2
DISP ;search through dispositions for date range
 F I=A1BMSD:0 S I=$O(^DPT("ADI",I)) Q:'I!(I>A1BMED)  F J=0:0 S J=$O(^DPT("ADI",I,J)) Q:'J  F K=0:0 S K=$O(^DPT("ADI",I,J,K)) Q:'K  D IF
INPT S A1BMST="i"
 F C=A1BMSD:0 S C=$O(^DGPM("AMV3",C)) Q:'C  F DFN=0:0 S DFN=$O(^DGPM("AMV3",C,DFN)) Q:'DFN  F J=0:0 S J=$O(^DGPM("AMV3",C,DFN,J)) Q:'J  I $D(^DGPM(+J,0)),(+^(0)<A1BMED) S I=+^(0),A1BMIFN=$P(^(0),"^",14),A1BMDC=$S(C>(DT+.9999):"",1:C) D INPT2
 S C="" F C1=0:0 S C=$O(^DPT("CN",C)) Q:C=""  F DFN=0:0 S DFN=$O(^DPT("CN",C,DFN)) Q:'DFN  S J=^(DFN) I $D(^DGPM(+J,0)),(+^(0)<A1BMED) S I=+^(0),A1BMIFN=J,A1BMDC="" D INPT2
 S A1BMEN=$S($D(^A1BM(0)):$P(^(0),"^",4),1:0),A1BMLN=A1BMEN-A1BMBN_" potential billables were stored in your file" K A1BMBN,A1BMEN
 D NOW^%DTC S A1BMEND=% D BULL^A1BMUTL
 Q
APPT2 I $D(^SC(C,"S",I,1,J,0)) S X=^(0),DFN=+X I $P(X,"^",9)'="C",$D(^DPT(DFN,"S",I,0)),($P(^(0),"^",2)="") D IF
 Q
INPT2 S DGPMIFN=A1BMIFN K A1BMIFN D ^DGPMLOS S LOS=+$P(X,"^",5) I LOS<1 S LOS=1
IF ;check for NSC, and if A or B, then Yes or Unknown/Null to INS
 Q:'$D(^DPT(+DFN,0))
 I A1BMST="o",$D(^A1BM("ADT",A1BMST,DFN,$P(I,".",1))) Q  ;already stored
 I A1BMST="i" S DA=$O(^A1BM("ADT","i",DFN,I,0)) I DA S DIK="^A1BM(" D ^DIK K DIK,DA ;purge if already inpt entry
 I $S('$D(^DPT(+DFN,0)):1,'$D(^("VET")):1,^("VET")'="Y":1,'$D(^(.3)):1,$P(^(.3),"^",1)'="N":1,1:0) Q
 S FL=0 F M=0:0 S M=$O(^DPT(DFN,.312,M)) Q:'M  I $D(^(M,0)) S X=^(0) I $S('$P(X,"^",4):1,$P(X,"^",4)'<$P(I,".",1):1,1:0),$D(^DIC(36,+X,0)) S FL=1 Q
 S A1BMIS=$S(FL:"Y",'$D(^DPT(DFN,.31)):"B",$P(^(.31),"^",11)="Y":"N",$P(^(.31),"^",11)]"":$P(^(.31),"^",11),1:"B")
 I A1BMST="o" S DGT=I D ^DGINPW I +DG1 Q
 S X=9999998.9-$P(I,".",1),X=$O(^DG(41.3,DFN,2,X)),A1BMMT=$S('$D(^(+X,0)):"N",1:$P(^(0),"^",2)) I $S(A1BMMT="A":1,A1BMMT="B":1,A1BMMT="N":1,1:0),(A1BMIS="N") Q
 I A1BMIS="B"!(A1BMIS="U")&'A1BMUN Q
 I A1BMIS="Y",'A1BMINS Q
 ;check to see if billed
 S (A1BMOK,A1BMCOK)=0
 I A1BMST="i" G INP
 S I1=$P(I,".") F A=0:0 S A=$O(^DGCR(399,"AOPV",DFN,I1,A)) Q:'A  I $D(^DGCR(399,+A,0)) S X=^(0) I ($P(X,"^",13)'=7) S Y=$S($D(^DGCR(399.3,+$P(X,"^",7),0)):^(0),1:"") I $P(Y,"^",6)'=18 S A1BMOK=1 Q
 I A1BMMT="C" F A=0:0 S A=$O(^DGCR(399,"AOPV",DFN,I1,A)) Q:'A  I $D(^DGCR(399,+A,0)) S X=^(0) I ($P(X,"^",13)'=7) S Y=$S($D(^DGCR(399.3,+$P(X,"^",7),0)):^(0),1:"") I $P(Y,"^",6)=18 S A1BMCOK=1 Q
 I A1BMBL!$S('A1BMOK:1,A1BMMT'="C":0,'A1BMCOK:1,1:0) D BILL
 Q
INP ;inpatient episodes...check for from and end date inclusion
 S (B,E)=0,I1=I ;B=beginning date E=end date  1 if covered 0 if not
 F K=0:0 S K=$O(^DGCR(399,"D",I,K)) Q:'K  I $D(^DGCR(399,+K,0)) S X=^(0),Y=$S($D(^("U")):^("U"),1:"") I $P(X,"^",2)=DFN,($P(X,"^",5)<3),($P(X,"^",13)'=7),($S($D(^DGCR(399.3,+$P(X,"^",7),0)):$P(^(0),"^",6),1:"")'=18) D COVERS
 S A1BMOK=B&E,(B,E)=0
 F K=0:0 S K=$O(^DGCR(399,"D",I,K)) Q:'K  I $D(^DGCR(399,+K,0)) S X=^(0),Y=$S($D(^("U")):^("U"),1:"") I $P(X,"^",2)=DFN,($P(X,"^",5)<3),($P(X,"^",13)'=7),($S($D(^DGCR(399.3,+$P(X,"^",7),0)):$P(^(0),"^",6),1:"")=18) D COVERS
 I A1BMMT="C" S A1BMCOK=B&E
 I A1BMBL!$S('A1BMOK:1,A1BMMT'="C":0,'A1BMCOK:1,1:0) D BILL
 Q
BILL ;store entry
 I A1BMST="o" S (A1BMDC,LOS)=""
 S DIC(0)="L",DIC="^A1BM(",DIC("DR")=".02////"_DFN_";.03////"_A1BMST_";.04////"_A1BMMT_";.05////"_A1BMIS_";.06////"_A1BMOK_";.07////"_A1BMCOK_";.08////"_A1BMDC_";.09////"_LOS_";.1////"_DT
 S X=I1 N A,C,C1,I,J,K D FILE^DICN Q
COVERS ;check beginning and end dates for admission, discharge.  if no discharge, use DT
 I $P(I,".")=+Y S B=1
 I $S(A1BMDC:$P(A1BMDC,"."),1:DT)=$P(Y,"^",2) S E=1
 Q
