ZZFBAPCC ;AISC/DSD-PRINT CURRENTLY ISSUED CARDS (MODIFIED ROUTINE FBAAPCC);15APR86 [ 10/31/94  11:04 AM ]
 ;;CLASS III FEE BASIS;;OCT 30, 1994
 S VAR="",PGM="START^FBAAPCC" D ZIS^FBAAUTL G:FBPOP Q
START U IO S UL="",FBAAOUT=0 W:$E(IOST,1,2)["C-" @IOF F A=1:1:80 S UL=UL_"="
 D HED S J=0 F JJ=0:0 S J=$O(^FBAAA("AE",J)) Q:J'>0!(FBAAOUT)  F DFN=0:0 S DFN=$O(^FBAAA("AE",J,DFN)) Q:DFN'>0!(FBAAOUT)  I $D(^FBAAA(DFN,4)) S Y(0)=^(4) D GOT
Q W ! K A,J,DFN,UL,I,JJ,X,Y,FBAAOUT,FBDT,FBNM,FBSSN D CLOSE^FBAAUTL
 Q
GOT S FBDT=$P(Y(0),"^",2),FBNM=$P($G(^DPT(+DFN,0)),"^"),FBSSN=$$SSN^FBAAUTL(DFN),FBADD1=$P($G(^DPT(+DFN,.11)),U,1),FBADD2=$P($G(^DPT(+DFN,.11)),U,2)
 S FBADD3=$P($G(^DPT(+DFN,.11)),U,3),FBCITY=$P($G(^DPT(+DFN,.11)),U,4),FBSTIEN=$P($G(^DPT(+DFN,.11)),U,5),FBSTATE=$P(^DIC(5,FBSTIEN,0),U,2),FBZIP=$P($G(^DPT(+DFN,.11)),U,6)
 S FBCNIEN=$P($G(^DPT(+DFN,.11)),U,7),FBCNTY=$P($G(^DIC(5,FBSTIEN,1,FBCNIEN,0)),U,1),FBPHONE=$P($G(^DPT(+DFN,.13)),U,1)
 I $Y+4>IOSL D HANG Q:FBAAOUT  W @IOF D HED
 W !!,J,?10,FBNM,?36,FBSSN,?61,$$DATX^FBAAUTL(FBDT)
 W !,?10,FBADD1,?36,FBCITY,?50,FBSTATE,?60,FBZIP,!,?10,FBADD2,?36,FBPHONE,?60,FBCNTY W:FBADD3 !,?10 Q
HED W ?1,"Card No.",?11,"Patient Name",?36,"Patient SSN",?61,"Issue Date",!,?10,"Address",?36,"City",?50,"State",?60,"ZIP",!,?36,"Residence Phone",?60,"County",!,UL Q
HANG I $E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1
 Q
