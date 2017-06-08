RJPTFDSP ;RJ WILM DE; Show DRG for selected patient; 4 14 87
 ;;Version 4.0
 D DT^DICRW D ^%ZIS Q:POP  S RJNEURO=10,RJMED="12^15",RJINT="40^80",RJSURG="50^53^54^55^59^60^63"
S U IO(0) S DIC(0)="QEAM",DIC="^DGPT(" W !! D ^DIC G:Y<1 X S PTF=+Y D 1 I RJCO1'="ZZZZ" G S
X X ^%ZIS("C") K RJNEURO,RJMED,RJINT,RJSURG,DIC,DRG,DRGCAL,PTF,RG,RJCO1,RJCO2,RJDAT1,RJDAT2,RJDATE,RJDESC,RJDXLS,RJDXLS1,RJICD,RJICD1,RJLBS,RJLBS1,RJLOS,RJICDN,D,DFN,A,I,K,L,X,Y,Z Q
1 D HEAD S RJDATE=$P($P(^DGPT(PTF,0),"^",2),".",1),RJCO1=0 F K=1:1 S RJCO1=$O(^DGPT(PTF,"M",RJCO1)) Q:RJCO1'?.N!(RJCO1="")  I $D(^DGPT(PTF,"M",RJCO1,0)) D 2 Q:RJCO1="ZZZZ"
 Q
2 W !!,"Movement #",RJCO1 S RJLBS=$P(^(0),"^",2),RJLBS1=$S(RJLBS="":"",$D(^DIC(42.4,RJLBS,0)):$P(^(0),"^",1),1:"") W ?15,"Losing Bedsection: ",RJLBS1
 S RJLOS=$P(^DGPT(PTF,"M",RJCO1,0),"^",10) I RJLOS'="" S RJLOS=RJLOS-RJDATE\1,RJDATE=$P(^DGPT(PTF,"M",RJCO1,0),"^",10) W ?60,"LOS: ",RJLOS," days"
 E  S RJLOS=DT-RJDATE\1,RJDATE=DT W !,"Patient has not been discharged from bedsection.",?50,"Up to date LOS: ",RJLOS," days"
 S Z=$O(^DGPT(PTF,"M",RJCO1)) I Z<1 G SET
 S Z=$P(^(Z,0),"^",2) I RJNEURO[RJLBS,RJNEURO'[Z G SET
 I RJMED[RJLBS,RJMED'[Z G SET
 I RJINT[RJLBS,RJINT'[Z G SET
 I RJSURG[RJLBS,RJSURG'[Z G SET
 D SHOW Q
SET I '$D(^DGPT(PTF,70)) W !,"Not enough information available to calculate DRG's." Q
 S B(70)=^DGPT(PTF,70),$P(B(70),"^",2)=RJLBS,$P(B(70),"^",10)=$P(^DGPT(PTF,"M",RJCO1,0),"^",5),DFN=$P(^DGPT(PTF,0),"^",1)
 S DAM=$S($P(B(70),U,3)=4:1,1:0),TAC=$P(B(70),U,13),TAC=$S($L(TAC):1,1:0),SEX=$P(^DPT(DFN,0),U,2),TRS=$S($P(B(70),U,3)=5:1,1:0),EXP=$S($P(B(70),U,3)>5:1,1:0)
 S AGE="",DOB=$P(^(0),"^",3) I DOB S AGE=$S(+B(70):+B(70),1:DT)-DOB\10000
 D CD^RJPTFD D O
 I IO=IO(0),$Y'<(IOSL-6) S DX=0,DY=0 X ^%ZOSF("XY") W !,"Press RETURN to continue, ""^"" to exit: " R A:DTIME S:'$T A="^" S:A["^" RJCO1="ZZZZ" I RJCO1'="ZZZZ",Z>1 D HEAD
 Q
HEAD U IO W @IOF,"Patient Name: ",$E($P(^DPT($P(^DGPT(PTF,0),"^",1),0),"^",1),1,30)," (",PTF,")"
 I $D(^DGPT(PTF,70)) S Z=$P(^(70),"^",1) I Z'="" W ?50,"Discharge Date: ",$E(Z,4,5),"-",$E(Z,6,7),"-",$E(Z,2,3)
 S RJDXLS1=$S($D(^DGPT(PTF,70)):$P(^(70),"^",10),1:""),RJDXLS=$S(RJDXLS1="":"",$D(^ICD9(RJDXLS1,0)):$P(^(0),"^",1),1:""),RJDESC=$S(RJDXLS="":"",$D(^ICD9(RJDXLS1,0)):$P(^(0),"^",2),1:"") W !,"DXLS: ",RJDXLS,?15,"Description: ",RJDESC
 Q
O D SHOW S:'$D(DRGCAL) DRGCAL="" I DRGCAL="" W !!,"Not enough information available to calculate DRG's." Q
 W !!,"DRG: ",$P(DRGCAL,"^",1),?15,$S($D(^ICD($P($P(DRGCAL,"^",1),"G",2),2)):^(2),1:"")
 W !?5,"WWU: ",$P(DRGCAL,"^",2),?20,"Average LOS: ",$P(DRGCAL,"^",8)," days"
 W !?5,"Low Trim: ",$P(DRGCAL,"^",3),?25,"High Trim: ",$P(DRGCAL,"^",4)
 W !?5,"Weight-Int: ",$P(DRGCAL,"^",11)
 Q
NM S RJICDN=$S($D(^ICD9(RJICD1,1)):^(1),1:"") W ?20,$E(RJICDN,1,59) Q
SHOW S D=^DGPT(PTF,"M",RJCO1,0) F I=1:1:5 S RJICD1=$P(D,"^",I+4),RJICD=$S(RJICD1="":"",$D(^ICD9(RJICD1,0)):$P(^(0),"^",1),1:"") W !?5,"ICD ",I,": ",RJICD Q:RJICD=""  D NM
 I I=5 F I=6:1:10 S RJICD1=$P(D,"^",I+5),RJICD=$S(RJICD1="":"",$D(^ICD9(RJICD1,0)):$P(^(0),"^",1),1:"") W !?5,"ICD ",I,": ",RJICD Q:RJICD=""  D NM
