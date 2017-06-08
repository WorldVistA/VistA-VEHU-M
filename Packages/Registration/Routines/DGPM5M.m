DGPM5M ;ALB/MRL/MIR - MOVE PATIENT DATA; 20 DEC 1988
 ;;MAS VERSION 5.0;
MV L ^DPT(DFN):1 I '$T L  G MV
 S X=$S($D(^DPT(DFN,"C405")):^("C405"),1:"")
 I +X L  W:$S('$D(DGPME):1,'DGPME:1,1:0) !!,*7,*7,*7,"This patient is presently being converted.  Please wait and try again",!,"You can not proceed until the conversion is complete.",! S DGPM5X=1 Q
 S ^DPT(DFN,"C405")=1_"^"_DGPMP("N"),^DPT("C405",DFN)="" L  I $D(^DGPM("C",DFN)) D DEL^DGPM5M0
 I $D(^DGPM("C",DFN)) D DEL^DGPM5M0
 D KG^DGPM5M0 S (PTC,CT,AD,PART)=0 F J=0:0 S AD=$O(^DPT(DFN,"DA",AD)) Q:AD'>0  D MV1
 S ^UTILITY("DGPMPTC",$J,DFN)=PTC I DGPMCT>100 D ^DGPM5M1 S DGPMCT=0 D DON2^DGPM5M0
 Q
 ;
MV1 ;Create Movement Nodes
 F N=0,1,4,"ODS" S NOD(N)=$S($D(^DPT(DFN,"DA",+AD,N)):^(N),1:"")
 S CT=CT+1,^UTILITY("DGPMV",$J,DFN,CT)=AD,^UTILITY("DGPMA",$J,DFN,AD)=CT,CT1=0,NODE="",$P(NODE,"^",2)=1,NOD="ADN" D SV ;Admit
 I DGPMP("A"),+NODE<DGPMP("D") S DD=+NOD(1) I DD,DD<DGPMP("D") D PART Q
 S XF=0 F J1=0:0 S XF=$O(^DPT(DFN,"DA",AD,2,XF)) Q:XF'>0  I $D(^(XF,0)) S NOD(0)=^(0),NOD="XFR",NODE="",$P(NODE,"^",2)=2 D SV ;xfer
 S TS=0 F J1=0:0 S TS=$O(^DPT(DFN,"DA",AD,"T",TS)) Q:TS'>0  I $D(^(TS,0)) S NOD(0)=^(0),NOD="TSC",NODE="",$P(NODE,"^",2)=6 D SV
 I +NOD(1) S NODE="",$P(NODE,"^",2)=3,NOD="DIS" D SV ;Disch
 Q
 ;
PART S PART=1,Z=NODE,TS=$O(^DPT(DFN,"DA",AD,"T",0)) I TS,$D(^(TS,0)) S NOD(0)=^(0),NOD="TSC",NODE="",$P(NODE,"^",2)=6 D SV
 S NODE=Z,(TS,TSP)=0,NOD="DIS" D ^DGPM5M0,SV I TSP S TS=TSP D DX
 S PART=0 K DD Q
 ;
SV S X1=@NOD,$P(NODE,"^",3)=DFN F N=1:1:16,22 I $P(X1,"^",N)]"" S X=$P(X1,"^",N),$P(NODE,"^",N)=$P(NOD($P(X,";",1)),"^",+$P(X,";",2))
SVP ;Entry point for parital movement
 S (DGPMOMD,DGPMMD,DGPMMD(1))=+NODE ;DGPMOMD = original movement date...for compares only
ADD I NOD'="TSC",'$P(NODE,"^",22),(+NODE<2871001),$D(^UTILITY("DGPMAS",$J,DFN,DGPMMD(1))) S DGPMMD(1)=DGPMMD(1)+.000001 G ADD
 S DGPMMD=DGPMMD(1),$P(NODE,"^",1)=DGPMMD
 S:(NOD="TSC") DGPMMD(1)=DGPMMD+.0000009 S $P(NODE,"^",4)=$S(NOD="TSC":TSCN,$P(NODE,"^",4):$P(DGPMT(NOD),"^",$P(NODE,"^",4)),1:""),$P(NODE,"^",18)=$S($D(^DG(405.1,+$P(NODE,"^",4),0)):$P(^(0),"^",3),1:"")
 I $P(NODE,"^",7)]"" S $P(NODE,"^",7)=$S($D(^DG5(1,"RE","R",+$P(NODE,"^",6),$P(NODE,"^",7))):$O(^($P(NODE,"^",7),0)),1:"") I '$D(^DG(405.4,+$P(NODE,"^",7),0)) S $P(NODE,"^",7)=""
 I NOD="XFR",($P(NODE,"^",5)]"") S $P(NODE,"^",5)=$S($O(^DIC(4,"B",$P(NODE,"^",5),0)):$O(^(0)),1:"")
 S X=$P(NODE,"^",18) I "^13^14^40^41^42^44^45^46^"[("^"_X_"^") S (X,DGX)=$S(X=13:1,X=14:3,X=40:2,X=41:1,X=44:1,X=46:1,X=45:4,1:""),$P(NODE,"^",22)=X D WHILE^DGPM5M0:'DGX,FROM^DGPM5M0:(DGX=3),CHANGE^DGPM5M0:(DGX=4)
 I NOD'="TSC" S ^UTILITY("DGPMAS",$J,DFN,DGPMMD)=CT_"^"_CT1
 S CT1=CT1+1 I '$D(^UTILITY("DGPMD",$J,DFN,AD,+DGPMOMD,CT)) S ^(CT)=CT1
 I NOD="TSC" S F=$O(^UTILITY("DGPMD",$J,DFN,AD,+DGPMMD,0)) S $P(NODE,"^",24)=$S(+F:^(F),1:"")
 I $P(NODE,"^",15),("^13^44^"'[("^"_$P(NODE,"^",18)_"^")) S $P(NODE,"^",15)=""
 S ^UTILITY("DGPMV",$J,DFN,CT,CT1)=NODE,DGPMCT=DGPMCT+1,DGPMTC=DGPMTC+1,PTC=PTC+1
 I NOD("ODS")]"" D ODS
 Q:NOD'="TSC"
TSC ;I $D(^UTILITY("DGPMV",$J,DFN,CT,+$P(NODE,"^",24))) S F=^(+$P(NODE,"^",24)) I $P(F,"^",2)=1,$D(^DGPT(+$P(F,"^",16),101)) S $P(^UTILITY("DGPMV",$J,DFN,CT,CT1,"PTF"),"^",1)=+^(101)
TS F I=12,13 I $P(NOD(0),"^",I)]"" S $P(^UTILITY("DGPMV",$J,DFN,CT,CT1,"PTF"),"^",$S(I=12:2,1:3))=$P(NOD(0),"^",I)
DX G TSQ:$O(^DPT(DFN,"DA",AD,"T",TS,"D",0))'>0
 S ^UTILITY("DGPMV",$J,DFN,CT,CT1,"D")=^DPT(DFN,"DA",AD,"T",TS,"D",0),D=0 F J2=0:0 S D=$O(^DPT(DFN,"DA",AD,"T",TS,"D",D)) Q:D'>0  S X=^(D,0),^UTILITY("DGPMV",$J,DFN,CT,CT1,"D",D)=X
TSQ K D,J2,Z1 Q
 ;
ODS ;convert ODS data
 S ODS=""
 I NOD="ADN",+NOD("ODS") S ODS=$P(NOD("ODS"),"^",1)_"^^^"_$P(NOD("ODS"),"^",4)
 I NOD="DIS",($P(NOD("ODS"),"^",2)]"") S ODS="^"_$P(NOD("ODS"),"^",2)_"^"_$P(NOD("ODS"),"^",3)_"^^"_$P(NOD("ODS"),"^",5)_"^"_$P(NOD("ODS"),"^",6)_"^"_$P(NOD("ODS"),"^",7)
 I ODS]"" S ^UTILITY("DGPMV",$J,DFN,CT,CT1,"ODS")=ODS
 K ODS
 Q
