DGYPWS ;ALB/MIR - WORKSHEET FOR MOVEMENT TYPE CREATION ; 4 FEB 91
 ;;MAS VERSION 4.7;;**25**;
 ;
 S DGPGM="WS^DGYPWS",DGVAR=""
 D ZIS^DGUTQ G Q:POP U IO
 ;
WS ;Print File Contents
 S (DGFL,DGP)=0
 F DGI=42.1,42.2,42.3 S DG1=1 Q:DGFL  D H S DGJ=0 F DGJ1=0:0 S DGJ=$O(^DIC(DGI,"B",DGJ)) Q:DGJ=""!DGFL  S K=$O(^(DGJ,0)) I $D(^DIC(DGI,K,0)) S DGX=^(0),DG1=0 D S
 W !!
Q K DG1,DGFL,DGI,DGJ,DGP,DGPGM,DGVAR,DGX,DIR,DGJ1,I,K,POP,X,Y
 D CLOSE^DGUTQ
 Q
 ;
S I $Y>(IOSL-9) D H I DGFL Q
 W !!,$P(DGX,"^",1),!?15,"Movement Type: ",?38,": ",$S($D(^DG(405.2,+$P(DGX,"^",7),0)):$P(^(0),"^",1),1:"UNABLE TO DETERMINE")
 W !?15,"Print Name",?38,": ",$P(DGX,"^",8)
 W !?14,">Change MOVEMENT TYPE to",?38,": _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
 W !?14,">Change PRINT NAME to",?38,": _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _",!
 Q
 ;
H I 'DG1,($E(IOST)="C") S DIR(0)="E" D ^DIR I 'Y S DGFL=1 Q
 S DGP=DGP+1 W @IOF,!,"Worksheet for Movement Types",?70,"Page:  ",DGP
 W !!?23,"Contents of '",$P("ADMISSION^DISCHARGE^TRANSFER","^",$P(DGI,".",2))," TYPE' File",! F I=1:1:79 W "="
 Q
