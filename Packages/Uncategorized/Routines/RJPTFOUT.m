RJPTFOUT ;RJ WILM DE OUTPUT DRG STATISTICS; 12-12-85
 ;;4.0
 D DT^DICRW S DT=+Y,U="^",Z(1)="Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec" S:'$D(DTIME) DTIME=300
R1 R !,"Do you want a BATCH process: N// ",X:DTIME S:'$T X=U G:X["^" Q G:X["?" H1 G:X["Y"!(X["y") T
R2 R !,"Do you want to run the patients that have been checked but",!,?10,"not released: Y// ",X:DTIME S:'$T X=U G:X["^" Q G:X["?" H2 G:X'["N"&(X'["n") LL
 D S Q:X=U  D IO G:POP Q F RJPTFA=1:1 S I=$P(A,",",RJPTFA) G:I="" Q D ^RJPTFOU1
LL D IO G:POP Q S I=0 F I=0:0 S I=$O(^DGP(45.84,I)) G:I=""!(I'?.N) Q I $P(^DGP(45.84,I,0),"^",4)="",$D(^DGPT(I,0)) D ^RJPTFOU1
S S A="",DIC="^DGPT(" F I=1:1 W ! S DIC(0)="QEALM" D ^DIC Q:Y=-1  S DA=+Y W !,?18,"*** Patient Number = ",DA,?47,"***" S A=$S(A="":DA,1:A_","_DA)
 Q
T R !,"Run DRG beggining with PATIENT number: ",ZZ:DTIME Q:ZZ[U!(ZZ="")  I ZZ>$P(^DGPT(0),U,4)!(ZZ<1) W !,"There are ",$P(^DGPT(0),U,4)," PATIENTS to choose from. Enter PATIENT number!" G L
 R !,?11,"ending with PATIENT number: ",R:DTIME Q:R[U!(R="")  I R>$P(^DGPT(0),U,4)!(R<X) W !,"There are ",$P(^DGPT(0),U,4)," PATIENTS to choose from. Enter PATIENT number!" G L
 D IO G:POP Q F I=ZZ:1:R I $D(^DGPT(I,0)) D ^RJPTFOU1
Q K G,G1,%Y,R,K,L,Z,ZZ,RJDRG,RJPAT,RJPTF,RJPTFA,RJPTFUN X ^%ZIS("C") Q
L R !,"Do you need a PATIENT number LIST (Y/N): N// ",X:DTIME S:'$T X=U Q:X=U  D:X="Y" ^RJPTFLIS G T
H1 W !!,"A BATCH Process will allow you to produce an output of the DRG funding for a",!,"series of patients.  You will be prompted to enter the starting and ending PTF",!,"number.",!! G R1
H2 W !!,"This option will take all patients that have been coded bt not transmitted,",!,"and produce an output of the funding.",!! G R2
IO S %ZIS("A")="DRG Funding Output Device: " D ^%ZIS K %ZIS I POP W !,"Try Later." Q
IO1 S:'$D(^DIZ(45.00046,1,0)) ^DIZ(45.00046,1,0)="" I $P(^DIZ(45.00046,1,0),"^",6)="" W !,"I need to have the FUNDING PER WWU entered before I can continue." D ^RJPTFVAR G IO1
 S RJPTFUN=$P(^DIZ(45.00046,1,0),"^",6) D H^RJPTFOU1 Q
