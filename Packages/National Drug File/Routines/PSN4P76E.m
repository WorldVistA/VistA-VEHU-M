PSN4P76E ;BIR/DMA-environment check for PMI data updates ; 10/28/03 12:17
 ;;4.0; NATIONAL DRUG FILE;**76**; 30 Oct 98
 I $D(DUZ)#2 N DIC,X,Y S DIC=200,DIC(0)="N",X="`"_DUZ D ^DIC I Y>0
 E  W !!,"You must be a valid user." S XPDQUIT=2
 I $G(^PS(50.621,.5,0))'=3030811 W !!,"It appears the wrong data global is on your system.",!,"Please check and reload, if necessary, the correct global NDF4P76.GBL." S XPDQUIT=2
 Q
