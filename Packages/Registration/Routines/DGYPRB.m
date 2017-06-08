DGYPRB ;ALB/MIR - ROOM-BED PRINT PRE VERSION 5 ;8 AUG 90
 ;;MAS VERSION 4.7;;**25**;
EN ;output room-bed list
 ;
 I $S('$D(^DG5(1,"P")):1,$P(^("P"),"^",5)']"":1,1:0) W !!?5,*7,"You must use the 'Edit Conversion Parameters' option and answer",!?5,"the 'DO WARDS SHARE BEDS?' prompt first!" G Q
 ;
 S DGYPRB=$P(^("P"),"^",5) ;dgyprb=1 if bed is shared...0 otherwise
 D TEXT
 I DGYPRB W !!,"THIS OUTPUT REQUIRES 132 COLUMN OUTPUT"
 K I,X S DGPGM="P^DGYPRB:1",DGVARS="DGYPRB" D ZIS^DGUTQ K DGPGM,DGVARS I POP G Q
P W @IOF
 F I=0:0 S I=$O(^DIC(42,I)) Q:'I  I $D(^(I,0)) S WN=$P(^(0),"^",1) F J=0:0 S J=$O(^DIC(42,I,2,J)) Q:'J  I $D(^(J,0)) S RN=$P(^(0),"^",1) F K=0:0 S K=$O(^DIC(42,I,2,J,1,K)) Q:'K  I $D(^(K,0)) S ^UTILITY("DGPMRB",$J,RN_"-"_$P(^(0),"^",1),WN)=I
 S DG1=1,I="",(DGFL,DGP)=0 D HEAD S DG1=0 I 'DGYPRB G UNIQUE
 F J=0:0 D:I]"" PT S I=$O(^UTILITY("DGPMRB",$J,I)) Q:I=""!DGFL  D:($Y>(IOSL-10)) HEAD I 'DGFL W !!,I,":" S WN="",C=0,N=1 F K=0:0 S WN=$O(^UTILITY("DGPMRB",$J,I,WN)) Q:WN=""  S C=C+1 W:C=1&'N ! W ?(C-1*32+22),WN S N=0 I C=3 S C=0
 G Q
UNIQUE F J=0:0 S I=$O(^UTILITY("DGPMRB",$J,I)) Q:I=""!DGFL  D:($Y>(IOSL-4)) HEAD I 'DGFL S WN="" F K=0:0 S WN=$O(^UTILITY("DGPMRB",$J,I,WN)) Q:WN=""  W !!,I,":",?22,WN D UNPT I $Y>(IOSL-4) D HEAD Q:DGFL
Q W ! K ^UTILITY("DGPMRB",$J),C,C1,DFN,DG1,DGI,DGFL,DGP,DGYPRB,DIR,I,J,K,N,POP,TAB,W,WN,RN,X,Y D CLOSE^DGUTQ Q
PT ;check to see if patient resides in bed, print
 S C1=1 F DFN=0:0 S DFN=$O(^DPT("RM",I,DFN)) Q:'DFN  I $D(^DPT(DFN,0)) S X=^(0) I $D(^(.1)) W:C1 ! W !?22,$P(X,"^",1)," [",$P(X,"^",9),"] occupies bed ",I," from ward ",^(.1) S C1=0
 Q
UNPT ;check to see if patient resides in bed (unique pt only)
 F DFN=0:0 S DFN=$O(^DPT("RM",I,DFN)) Q:'DFN  I $D(^DPT(DFN,0)),$D(^(.1)),(^(.1)=WN) S X=^(0) I $D(^(.1)) W !?22,$P(X,"^",1)," [",$P(X,"^",9),"] occupies this bed"
 Q
 ;
HEAD ;header for report
 N I,J,K,W,WN
 I $E(IOST)="C",'DG1 S DIR(0)="E" D ^DIR S DGFL='Y I DGFL Q
 S DGP=DGP+1
 W @IOF,"ROOM-BED OUTPUT FOR ",$S(DGYPRB:"BEDS THAT ARE SHARED",1:"BEDS THAT ARE NOT SHARED (UNIQUE)") S TAB=$S('DGYPRB:70,1:122) W ?TAB,"PAGE:  ",$J(DGP,3)
 K X S $P(X,"-",TAB+11)="" W !,X
 Q
TEXT ;print instructions
 W !,"This routine can be run prior to initialization of version 5.0 of MAS.  It"
 W !,"will list all of your room-beds and what wards use them.  It will also display"
 W !,"any current inpatients that may be occupying the bed.  We are providing this"
 W !,"output in advance of version 5.0 to help you prepare for the conversion of the"
 W !,"room-beds into a file of their own and help the conversion process go faster."
 W !,""
 W !,"Version 5 will remove all data from the ROOM multiple of the WARD LOCATION"
 W !,"file (and its associated BED multiple) into a new file called the ROOM-BED"
 W !,"file where the .01 field will be ROOM_""-""_BED."
 W !
 W !,"The following output is based on your choice to ",$S('DGYPRB:"not ",1:""),"share beds"
 W !,"If you would like to review what would happen if you did ",$S(DGYPRB:"not ",1:""),"share beds"
 W !,"among wards, change the 'DO WARDS SHARE BEDS?' parameter via the 'Edit"
 W !,"Conversion Parameters' option and rerun this output."
 Q
