DGPM5M1 ;ALB/MRL/MIR - MOVE PATIENT DATA, CONT.; 02 JAN 1989
 ;;MAS VERSION 5.0;
405 ;
 I $S('$D(DGPME):1,DGPME=3:1,1:0) W "." ;write dot if test or inpt conversion
 S PT=0 F JJ=0:0 S PT=$O(^UTILITY("DGPMV",$J,PT)),MN=0 Q:PT'>0  S ^UTILITY("DGPMDFN",$J,PT)="" F JJ1=0:0 S MN=$O(^UTILITY("DGPMV",$J,PT,MN)),MN1=0 Q:MN'>0  F JJ2=0:0 S MN1=$O(^UTILITY("DGPMV",$J,PT,MN,MN1)) Q:MN1'>0  S NODE=^(MN1) D M405
 S DGPM=0 F DGPM1=0:0 S DGPM=$O(^UTILITY("DGPMNN",$J,DGPM)) Q:DGPM'>0  S NODE=^DGPM(+DGPM,0),NODE("ODS")=$S($D(^("ODS")):^("ODS"),1:"") D XRF
 D NOW^%DTC S PT=0 F PT=0:0 S PT=$O(^UTILITY("DGPMDFN",$J,PT)) Q:PT'>0  S DGPMPC=DGPMPC+1,^DPT(PT,"C405")="0^"_% K ^DPT(PT,"DA"),^DPT("C405",PT)
 D KG^DGPM5MV Q:'DGPME  S $P(^DG5(1,"LST"),"^",3)=DFN S:DGPME=3 $P(^("LST"),"^",4)=DGPM5W Q
 ;
M405 D NN I MN1=1 S PAD=+NN,DGDFN=PT_"^"_^UTILITY("DGPMV",$J,PT,MN)_"^"_NN S X="YSMAS5" X ^%ZOSF("TEST") D:$T ^YSMAS5 S X="FHXCON" X ^%ZOSF("TEST") I $T D ^FHXCON
 S $P(NODE,"^",14)=+PAD I $P(NODE,"^",2)=3 S $P(^DGPM(+PAD,0),"^",17)=+NN
 I $S($P(NODE,"^",2)'=2:1,$P(NODE,"^",15)="":1,'$D(^UTILITY("DGPMA",$J,PT,+$P(NODE,"^",15))):1,1:0) G M405D
 S X=+$P(NODE,"^",15),X1=^UTILITY("DGPMA",$J,PT,X) I '$D(^UTILITY("DGPMMV",$J,PT,X1,1)) S ^UTILITY("DGPMPT",$J,PT,X1,1,NN)="" I $S('$D(^UTILITY("DGPMV",$J,PT,X1,1)):1,'$P(^(1),"^",21):1,1:0) S $P(^(1),"^",21)=+NN,$P(^(1),"^",1)=+NODE
 ;E  S X=^UTILITY("DGPMMV",$J,PT,X1,1),$P(NODE,"^",15)=X,$P(^DGPM(+X,0),"^",15)=+NN
M405D I $D(^UTILITY("DGPMPT",$J,PT,MN,MN1)) F DGX=0:0 S DGX=$O(^UTILITY("DGPMPT",$J,PT,MN,1,DGX)) Q:'DGX  S $P(^DGPM(DGX,0),"^",15)=+NN
 I $P(NODE,"^",24) S $P(NODE,"^",24)=$S($D(^UTILITY("DGPMMV",$J,PT,MN,+$P(NODE,"^",24))):^($P(NODE,"^",24)),1:"")
 S ^DGPM(+NN,0)=NODE D ZERO I $D(^UTILITY("DGPMV",$J,PT,MN,MN1,"PTF")) S ^DGPM(+NN,"PTF")=^("PTF")
 I $D(^UTILITY("DGPMV",$J,PT,MN,MN1,"ODS")) S ^DGPM(+NN,"ODS")=^("ODS")
 Q:$O(^UTILITY("DGPMV",$J,PT,MN,MN1,"D",0))'>0
 S ^DGPM(NN,"DX",0)=^UTILITY("DGPMV",$J,PT,MN,MN1,"D"),$P(^(0),"^",2)=405.099,I=0 F I1=0:0 S I=$O(^UTILITY("DGPMV",$J,PT,MN,MN1,"D",I)) Q:I'>0  S X=^(I),^DGPM(NN,"DX",I,0)=X
 L  Q
 ;
NN S NN=$P(^DGPM(0),"^",3)
LOCK S NN=NN+1 L ^DGPM(NN):1 I $D(^DGPM(NN))!'$T L  G LOCK
 Q
 ;
ZERO S X=^DGPM(0),$P(X,"^",3)=NN,$P(X,"^",4)=$P(X,"^",4)+1,^DGPM(0)=X,^UTILITY("DGPMNN",$J,+NN)="",^UTILITY("DGPMMV",$J,PT,MN,MN1)=NN K X Q
 ;
XRF F DGPMFN=1:1:24 S DGPMF=$P(NODE,"^",DGPMFN) I DGPMF]"" S DGPMFX=0 F DGPMFX1=0:0 S DGPMFX=$O(^UTILITY("DGPMXF",$J,DGPMFN,DGPMFX)) Q:DGPMFX'>0  S DGPMFI=^(DGPMFX),X=DGPMF,DA=DGPM X DGPMFI
 I NODE("ODS")']"" Q
 F DGPMFN=25:1:31 S DGPMF=$P(NODE("ODS"),"^",DGPMFN-24) I DGPMF]"" S DGPMFX=0 F DGPMFX1=0:0 S DGPMFX=$O(^UTILITY("DGPMXF",$J,DGPMFN,DGPMFX)) Q:DGPMFX'>0  S DGPMFI=^(DGPMFX),X=DGPMF,DA=DGPM X DGPMFI
 K DGPMFN,DGPMF,DGPMFX,DGPMFX1,DGPMFI,X,DA Q
 ;
INP ;set up cross-refs...kill for clean-up first
 K ^DPT("CN")
 D NOW^%DTC S VATD=9999999.9999999-(%+.0000001),(VAPRT,DFN)=0,(VAPRC,VACN)=1
 F DGPM=0:0 S DFN=$O(^DGPM("C",DFN)) Q:DFN'>0  I $D(^DPT(+DFN,0)) D VAR^VADPT30 I +VAWD,$P(VAWD,"^",2)]"" D SETALL^DGPMDDCN
 K DGPM D KVAR^VADPT30 Q
 ;
