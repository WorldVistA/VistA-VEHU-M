RJPTFMGR ;RJ WILM DE -MGR STATS; 12-12-85
 ;;4.0
 S:'$D(DTIME) DTIME=300
IO1 S:'$D(^DIZ(45.00046,1,0)) ^DIZ(45.00046,1,0)="" I $P(^DIZ(45.00046,1,0),"^",6)="" W !,"I need to have the FUNDING PER WWU entered before I can continue." D ^RJPTFVAR G IO1
 S %DT="APE",%DT("A")="From Discharge Date: " D ^%DT G:Y=-1 X S Z1=Y,%DT("A")="To Discharge Date: " D ^%DT G:Y=-1 X S Z2=Y
 K %DT S RJVAR=$P(^DIZ(45.00046,1,0),"^",6),RJ="",RJ1=0,X="T" D ^%DT S DT=+Y,U="^"
 W !,"This will take a while." S (PTF,RJC)=0 F I=1:1 S PTF=$O(^DGPT(PTF)) Q:PTF=""!(PTF'?.N)  D 1
 W !,"PTF Patients discharged between ",$E(Z1,4,5),"-",$E(Z1,6,7),"-",$E(Z1,2,3)," and ",$E(Z2,4,5),"-",$E(Z2,6,7),"-",$E(Z2,2,3),"."
 W !,"There was a total of ",$J(RJ1,7),?30,"patients with their DXLS changed out of ",!?21,$J(RJC,7),?30,"patients checked (",$J(RJ1/RJC,0,4)*100," percent)."
 S:RJ1=0 RJ1=1 W !,"DRG Calculator increased funds by ",$J(RJ,0,2)," dollars.",!,"AVERAGE= ",($J(RJ/RJ1,0,4))," per patient changed." Q:'$D(^DGPT("PU"))  W !,"There was a total of ",^DGPT("PU")," cards punched since using this package."
 R !,"Press RETURN to continue:",X:DTIME
X K B,DA,DFN,DOB,I,L2,ORG,PTF,R,RJ,TAC,TRS,%DT,RJ1,RJVAR,RJC,Z1,Z2,Z3 Q
1 Q:'$D(^DGPT(PTF,70))  S Z3=$P(^(70),"^",1) Q:Z3=""  I Z3<Z1!(Z3>Z2) Q
 I $D(^DGPT(PTF,"RJ","DIF")) S RJ=RJ+^DGPT(PTF,"RJ","DIF"),RJ1=RJ1+1,RJC=RJC+1 Q
 Q:'$D(^DGPT(PTF,"RJ","DXLS"))  Q:'$D(^DGPT(PTF,70))
 S RJC=RJC+1 I ^DGPT(PTF,"RJ","DXLS")'=$P(^DGPT(PTF,70),"^",10),$P(^(70),"^",10)'="" W !,"Comparing PTF Record ",PTF D F S:'$D(^DGPT(PTF,"MO")) ^("MO")=0 I R'=0 S RJ1=RJ1+1,RJ=RJ-^("MO")+R,^("RJ","DIF")=$J(R-^("MO"),0,2)
 Q
F S DFN=$P(^DGPT(PTF,0),"^",1) D ^DGPTFD S R=0 S:$D(DRGCAL) R=$P(DRGCAL,"^",2)*RJVAR
 K AGE,SEX,DRG,DRGCAL,MDC,NOR,NDR,NSD,EXP,DXLS,OR,PD,RG,SD,SD1,DAM,L,L1,NO
 Q
