DGYPP ;ALB/MIR - PRE-5 PARAMETER ENTER/EDIT ; 4 FEB 91
 ;;MAS VERSION 4.7;;**25**;
 ;
PAR ;enter/edit parameters
 D DISPLAY
ASK S %=$S(DGER:1,1:2) W !!,"Do you want to edit these parameters" D YN^DICN
 I '% W !!?3,"Enter yes to edit parameters, no otherwise" G ASK
 I %=1 S DR="10.01;10.05",DIE="^DG5(",DA=1 D ^DIE
 D CHECK I DGER W !,"These parameters must be complete before you can run the conversion"
PARQ K DA,DR,DIE,I,X,Y,DGER
 Q
 ;
 ;
DISPLAY ;display current conversion parameters
 W !!!?12,"Conversion Parameters" K X S $P(X,"-",22)="" W !?12,X
 S X=$S($D(^DG5(1,"P")):^("P"),1:"")
 W !,"Date to re-initialize G&L.........." S Y=$P(X,"^",1) X ^DD("DD") W $S(Y]"":Y,1:"UNSPECIFIED")
 W !,"Do wards share beds?...............",$S($P(X,"^",5)=1:"YES",$P(X,"^",5)=0:"NO",1:"UNSPECIFIED")
 ;
CHECK ;check that parameters are complete
 S X=$S($D(^DG5(1,"P")):^("P"),1:"")
 S DGER=0 F I=1,5 I $P(X,"^",I)']"" S DGER=1 Q
 Q
