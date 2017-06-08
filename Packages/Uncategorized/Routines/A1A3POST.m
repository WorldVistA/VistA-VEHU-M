A1A3POST ;ALB/RMO - POST-INIT FOR TEST SITES ; 31 JUL 89
 ;
 I $S('($D(DUZ)#2):1,'$D(^DIC(3,+DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must equal '@' to initialize." G Q
 ;
SET S DGBDT=$S('$D(^DG(43,1,"SCLR")):2890701,$P(^("SCLR"),"^",9):$P(^("SCLR"),"^",9),1:2890701)-.0001,X="NOW",%DT="T" D ^%DT K %DT S DGEDT=Y
 S DGSCD=+$O(^DIC(40.7,"B","SPECIAL SERVICES",0)) I '$D(^DIC(40.7,DGSCD,0)) W !,"Stop Code 900, SPECIAL SERVICES is not defined!" Q
 W !,"Patient Name",?25,"Visit Date",?50,"Inactive Amb Proc",!,"------------",?25,"----------",?50,"-----------------"
 F DGDT=DGBDT:0:DGEDT S DGDT=$O(^SDV(DGDT)) Q:'DGDT  F DGI=0:0 S DGI=$O(^SDV(DGDT,"CS",DGI)) Q:'DGI  I $D(^(DGI,0)),$P(^(0),"^",1)=DGSCD,$D(^("PR")) D CHKCPT
 ;
Q K DGBDT,DGCPT,DGDT,DGEDT,DGI,DGJ,DGNM,DGSCD,X,Y
 Q
 ;
CHKCPT S DGNM=$S('$D(^SDV(DGDT,0)):"UNKNOWN",$D(^DPT(+$P(^(0),"^",2),0)):$P(^(0),"^",1),1:"UNKNOWN")
 F DGJ=1:1:5 S DGCPT=$P(^SDV(DGDT,"CS",DGI,"PR"),"^",DGJ) I DGCPT I $S('$D(^ICPT(DGCPT,"SD")):1,^("SD"):0,1:1) W !,DGNM,?25 S Y=DGDT X ^DD("DD") W Y,?50,$S($D(^ICPT(DGCPT,0)):$P(^(0),"^",1),1:"UNKNOWN")
 Q
