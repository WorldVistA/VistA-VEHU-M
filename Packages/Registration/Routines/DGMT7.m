DGMT7 ;ALB/MRL - PATIENTS WITH REQUIRED/PENDING MEANS TEST ; 18 FEB 87
 ;;MAS VERSION 5.1;
1 ;List MT Patients
 S Z="^REQUIRED^PENDING" W !!,"List (R)equired from Registration or (P)ending Adjudication?  " R X:DTIME G Q:(X="")!('$T) D IN^DGHELP G Q:X["^" S DGHOW=$E(X)
 I %=-1 W !!,"Generate a listing of means test patients whose current status is:",!!?4,"R - Required from registration (means test not applied)",!?4,"P - Pending Adjudication (not categorized yet)" G 1
 W ! S %DT="EAX",%DT(0)="-NOW",%DT("A")="Start with TEST DATE: " D ^%DT G Q:Y'>0 S DGS=Y
2 S %DT="EAX",%DT(0)="-NOW",%DT("A")="     Go to TEST DATE: " D ^%DT G Q:Y'>0 S DGT=+Y I DGT<DGS W !?4,*7,"Cannot precede the START DATE!" G 2
 S DGPGM="S^DGMT7",DGVAR="DGHOW^DGS^DGT^DUZ^U" D ZIS^DGUTQ G Q:POP U IO
 I $D(IOST)#2,$E(IOST,1,2)["C-" D WAIT^DICD
S D SET F DFN=0:0 S DFN=$N(^DG(41.3,DFN)) Q:DFN'>0  S DGD=DGT1 F I=0:0 S DGD=$N(^DG(41.3,DFN,2,"AC",DGHOW,DGD)) Q:DGD=-1!(DGD>DGS1)  D S1
 I '$D(^UTILITY($J,"DGMTO")) D H W !!,"NO PATIENTS '",$S(DGHOW="R":"REQUIRING' A",1:"PENDING ADJUDICATION' OF")," MEANS TEST FOUND FOR REQUESTED DATE RANGE!" G Q
 D H F I1=0:0 S I=$N(^UTILITY($J,"DGMTO",I)) Q:I=-1  F I2=0:0 S I2=$N(^UTILITY($J,"DGMTO",I,I2)) Q:I2'>0  S X=^(I2) D:$Y>$S($D(IOSL):(IOSL-4),1:62) H W !?5,I,?40,$P(X,"^",1),?60,$P(X,"^",2)
Q W ! K ^UTILITY($J,"DGMTO"),%DT,I,I1,I2,Y,X,DGNM,DGD,DGS,DGS1,DGT,DGT1,DFN,DGH,DGP,Z,DGHOW,DGPGM,DGVAR,DGN,POP D CLOSE^DGUTQ Q
S1 I $D(^DPT(DFN,0)) S DGNM=$P(^DPT(DFN,0),"^",1),DGN=$P(^(0),"^",9)_"^" S Y=9999999-DGD X ^DD("DD") S DGN=DGN_Y,^UTILITY($J,"DGMTO",DGNM,DGD)=DGN
 Q
H S DGP=DGP+1 W @IOF,!,DGH,DGP,!!?5,"Patient Name",?40,"Social Sec #",?60,"Date of Test",!?5,"------------",?40,"------------",?60,"------------" Q
SET K ^UTILITY($J) S DGH="Patients "_$S(DGHOW="R":"REQUIRING",1:"PENDING ADJUDICATION of")_" a means test, " S Y=DGS X ^DD("DD") S DGH=DGH_Y I DGS'=DGT S Y=DGT X ^DD("DD") S DGH=DGH_" - "_Y
 S DGH=DGH_", Page ",(DGP,I)=0,DGT1=9999999-(DGT_.2359),DGS1=9999999-DGS Q
