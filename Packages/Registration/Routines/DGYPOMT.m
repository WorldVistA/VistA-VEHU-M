DGYPOMT ;ALB/MIR - DESCRIPTIONS OF MAS MOVEMENT TYPES ; 6 FEB 91
 ;;MAS VERSION 4.7;;**25**;
 ;
 ;
 S DGPGM="OUT^DGYPOMT",DGVAR="" D ZIS^DGUTQ I POP G Q
 ;
OUT S (DGP,DGFL)=0 D HEAD
 F DGI=1:1:47 I $D(^DG(405.2,DGI,0)) S DGX=^(0) D PRINT Q:DGFL
Q K DGI,DGFL,DGP,DGPGM,DGX,DGX1,DGVAR,DIR,POP,X,Y
 W ! D CLOSE^DGUTQ
 Q
 ;
PRINT I $Y>(IOSL-9) D HEAD I DGFL Q
 W !,"Number: ",DGI,?15,"MAS Movement Type",?38,": ",$P(DGX,"^",1),!?15,"Transaction Type",?38,": " S DGX1="ADMISSION^TRANSFER^DISCHARGE^CHECK-IN LODGER^CHECK-OUT LODGER^SPECIALTY TRANSFER" W $P(DGX1,"^",+$P(DGX,"^",2))
 S X=$S($D(^DG(405.2,DGI,"D")):^("D"),1:""),DIWL=41,DIWF="WC38" K ^UTILITY($J,"W"),^(1) W !?15,"Movement Description",?38,":" D ^DIWP,^DIWW
 K X,DIWL,DIWF W ! Q
 ;
 ;
HEAD ;header for report (80 column display)
 I DGP,($E(IOST)="C") S DIR(0)="E" D ^DIR S DGFL='Y I DGFL Q
 S DGP=DGP+1
 W @IOF,"List of distributed MAS Movement Types",?70,"Page:  ",$J(DGP,2)
 K X S $P(X,"-",80)="" W !,X
 Q
