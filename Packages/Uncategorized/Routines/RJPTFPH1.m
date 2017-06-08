RJPTFPH1 ;RJ WILM DE -BY MOVEVMENT BY PHYSICIAN OUTPUT; 3-12-87
 ;;4.0
 S %DT="APE",%DT("A")="From Discharge Date: " D ^%DT G:Y=-1 X S Z1=Y,%DT("A")="To Discharge Date: " D ^%DT G:Y=-1 X S Z2=Y
 W !!,"This report can be queued by typing a ""Q"" at the DEVICE: prompt." S %IS="QM",%IS("B")="" K IOP D ^%ZIS G:POP X
 I $D(IO("Q")) S PGM="QQ^RJPTFPH1" D ^RJPTFQ S ^%ZTSK(ZTSK,"Z1")=Z1,^%ZTSK("Z2")=Z2 G X
 W !,"This may take a while..."
S K ^UTILITY($J,"RJPTF") S U="^",PTF=0 F P=1:1 S PTF=$O(^DGPT(PTF)) Q:PTF'?.N  D:$D(^DGPT(PTF,70)) 1
X Q
1 Q:$P(^DGPT(PTF,70),U,1)=""  S X1=Z1,(X2,D)=$P(^DGPT(PTF,70),U,1) D ^%DTC Q:X>0  S X1=Z2,X2=D D ^%DTC Q:X<0
 I '$D(^DGPT(PTF,"RJ",0)) S:$D(^DGP(45.84,PTF,0)) ^UTILITY($J,"RJPTF","D",PTF)="" Q
 I ^DGPT(PTF,"RJ",0)="" S:$D(^DGP(45.84,PTF,0)) ^UTILITY($J,"RJPTF","D",PTF)="" Q
 I '$D(^DGP(45.84,PTF,0)) S ^UTILITY($J,"RJPTF","D",PTF)="" Q
 I $P(^DGP(45.84,PTF,0),U,2)="" S ^UTILITY($J,"RJPTF","D",PTF)="" Q
 S RJDATE=$P($P(^DGPT(PTF,0),"^",2),".",1),RJCO1=0 F K=1:1 S RJCO1=$O(^DGPT(PTF,"M",RJCO1)) Q:RJCO1'?.N  I $D(^DGPT(PTF,"M",RJCO1,0)) D 2
 Q
QQ S Z1=^%ZTSK(ZTSK,"Z1"),Z2=^%ZTSK(ZTSK,"Z2") G S
