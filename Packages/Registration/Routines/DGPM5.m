DGPM5 ;ALB/MIR - CONVERSION PROCESS DRIVER ; 30 JAN 91
 ;;MAS VERSION 5.0;
 ;find the last step successfully completed and restart
 ;DGER = 1 if no start time (start from this step)
 ;       2 if step completed (check next step)
 ;       0 if no end time (step did not complete properly)
 ;
 D Q
 S E=0 F I=42.1,42.2,42.3 F J=0:0 S J=$O(^DIC(I,J)) Q:'J  I $D(^(J,0)) S X=^(0) I ('$P(X,"^",7))!($P(X,"^",8)']"") W !,$P(X,"^",1) S E=1 Q
 I E W !,"You must first use the 'Update New Movement Type Fields' option on the",!,"'Pre-5 Set-up Menu' to update you movement types." G Q
 F I=1:1:6 S DGER=$S('$D(^DG5(1,"T",I,0)):1,'$P(^(0),"^",2):1,$P(^(0),"^",3):2,1:0) Q:DGER'=2
 S DGPME=I
 I DGER=1 G QUEUE^DGPM50:(DGPME>3),@DGPME
 I DGER=2 W !,"You have already completed the conversion process!" G Q
 I DGPME'=5 W !,"The conversion of ",$S(DGPME=1:"room-beds",DGPME=2:"movement types",DGPME=3:"inpatients",DGPME=4:"patients in-house since init date",1:"remaining inpatients")
 I DGPME=5 W !,"The recalculation process"
 W " did not complete."
ASK W !!,"Are you sure it is not still running" S %=2 D YN^DICN G Q:%<0!(%=2)
 I '% W !!?5,"Enter NO if this step may still be running, otherwise YES" G ASK
ASK2 W !!,"Are you sure you want to restart this step" S %=2 D YN^DICN G Q:%<0!(%=2)
 I '% W !!?5,"Enter NO if you don't want to restart, otherwise YES" G ASK2
 I "^3^4^6^"[("^"_DGPME_"^") D RESET^DGPM50
 I DGPME>3 D QUEUE^DGPM50 G Q
 G @DGPME
 ;
1 ;step 1...edit parameters, convert room-beds, mvt types, inpt data
 D DIS^DGPM50
 D DISPLAY
EDIT S %=$S(DGER:1,1:2) W !!,"Do you want to edit these parameters" D YN^DICN
 I %<0 G Q
 I '% W !!?3,"Enter yes to edit parameters, no otherwise" G EDIT
 I %=1 S DR="10.01;10.05",DIE="^DG5(",DA=1 D ^DIE
 S $P(^DG5(1,"P"),"^",2)=0 ;don't allow choice of partial data...stuff no
 D CHECK I DGER W !,"These parameters must be complete before continuing" G Q
 S DIE="^DG(43,",DR="10////"_+X_";1000.01////"_+X_";1000.07////"_+X,DA=1 D ^DIE K DA,DIE,DR ; move init date to MAS parameters file
 S DGPMRB='$P(^DG5(1,"P"),"^",5),DGPME=1 D TIME,^DGPM5RB,TIME ; move room-beds into new file
 ;note:  DGPMRB='$p(...) do to last minute change to field name (from CREATE A UNIQUE ROOM-BED? to DO WARDS SHARE BEDS?) - this caused the field definition to be the opposite.
2 S DGPME=2 D TIME,^DGPM5C,TIME ; convert movement types
3 W !!,"Moving all movement data for current inpatients (this will take a while)"
 I '$D(^DG5(1,"T",3)) K ^DPT("ACN"),^DPT("ATR"),^DPT("APR"),^DPT("RM")
 S DGPME=3 D TIME,INP^DGPM5MV,TIME ; convert movements for all inpatients
 W !!,*7,*7,"You have completed part 1 of the conversion.  You may now bring your systems",!,"on line and type 'D ^DGPM5' to start part 2."
Q K %,%Y,DA,DGER,DGPM5BEG,DGPM5END,DGPME,DGPME,DIE,DTOUT,DR,E,I,J,X,X1,X2,Y Q
 ;
DISPLAY ;display current conversion parameters
 W !!!?12,"Conversion Parameters" K X S $P(X,"-",22)="" W !?12,X
 S X=$S($D(^DG5(1,"P")):^("P"),1:"")
 W !,"Date to re-initialize G&L.........." S Y=$P(X,"^",1) X ^DD("DD") W $S(Y]"":Y,1:"UNSPECIFIED")
 W !,"Do wards share beds?...............",$S($P(X,"^",5)=1:"YES",$P(X,"^",5)=0:"NO",1:"UNSPECIFIED")
 ;
CHECK ;check that parameters are complete
 S X=$S($D(^DG5(1,"P")):^("P"),1:"")
 S DGER=0 F I=1,2,5 I $P(X,"^",I)']"" S DGER=1 Q
 I $P(X,"^",2),($P(X,"^",3)']"") S DGER=1
 Q
 ;
 ;
4 ;step 2...convert pts since recalc, recalc, convert remaining
 D DIS^DGPM50 ;disable the G&L options
 S DGPME=4 D TIME,REC^DGPM5MV,TIME
5 S DGPME=5 D TIME,RECALC^DGPM50,TIME
6 S DGPME=6 D TIME,REST^DGPM5MV,TIME
 K DGPME,DGPM5BEG,DGPM5END
 Q
 ;
TIME ;record start and end times for steps
 I $D(DGPM5BEG) G END^DGPM50
 D NOW^%DTC S DGPM5BEG=% K %
 S $P(^DG5(1,"T",0),"^",3,4)=DGPME_"^"_DGPME,^DG5(1,"T",DGPME,0)=DGPME_"^"_DGPM5BEG
 Q
