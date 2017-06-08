DGYPADT ;ALB/MIR - PRE-5 ROUTINE TO ENTER/EDIT NEW MVT TYPES,PRINT NAMES ; AUG 3 1990
 ;;MAS VERSION 4.7;;**25**;
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  W !,X
ALL R !!,"Do you want to edit all movement types" S %=1 D YN^DICN I %<0 G QUIT
 I '% W !!?5,"Enter yes to edit all local movement types, or",!?5,"no to edit specific entries only" G ALL
 I %=2 D SOME G QUIT
EN S DGER=0,DR="S DGER=1;.07;.08;S DGER=0"
 F DGI=42.1,42.2,42.3 Q:DGER  W !!?5,"***EDIT ",$S(DGI=42.1:"ADMISSION",DGI=42.2:"DISCHARGE",1:"TRANSFER")," TYPES***" S DIE="^DIC("_DGI_"," D CONT
QUIT K DA,DIC,DIE,DGI,DGER,DR,X,Y Q
CONT F DA=0:0 S DA=$O(^DIC(DGI,DA)) Q:'DA  I $D(^(DA,0)) W !!,$P(^(0),"^",1),":" D ^DIE Q:DGER
 Q
OUTPUT ;OUTPUT OF MOVEMENT LISTS
 W !!,*7,"This output requires 132 columns!",!
 S DGVARS="",DGPGM="PRINT^DGYPADT" D ZIS^DGUTQ G Q:POP
PRINT ;print list of movements and master list
 S (DGFL,DGPG)=0 D HEAD F I=42.1,42.3,42.2 Q:DGFL  W !!?69,$S(I=42.1:"ADMISSION",I=42.3:"TRANSFER",1:"DISCHARGE")," TYPES",!?69 K X S $P(X,"-",15)="" W X W:I'=42.3 "-" D LIST
 I 'DGFL D 4052
Q W ! K DGVARS,DGPGM,DGP,DGFL,DIR,I,J,POP,X D CLOSE^DGUTQ Q
LIST F J=0:0 S J=$O(^DIC(I,J)) Q:'J!DGFL  I $D(^(J,0)) S X=^(0) W !,$E($P(X,"^",1),1,35),?38,$S($D(^DIC(43.9,+$P(X,"^",6),0)):$P(^(0),"^",1),1:""),?71,$S($D(^DG(405.2,+$P(X,"^",7),0)):$P(^(0),"^",1),1:""),?112,$P(X,"^",8) I $Y>(IOSL-8) D HEAD
 Q
 ;
HEAD ;header
 I $E(IOST)="C",DGPG S DIR(0)="E" D ^DIR S DGFL='Y I DGFL Q
 S DGPG=DGPG+1 W @IOF,!,"LOCAL MOVEMENT TYPE LIST",?123,"PAGE:  ",DGPG
 W !,"LOCAL NAME",?38,"CURRENT MOVEMENT TYPE",?71,"NEW MOVEMENT TYPE FOR V5",?112,"PRINT NAME",! K X S $P(X,"-",132)="" W X
 Q
TEXT ;Text to be printed as help
 ;;This option should be used to enter the new movement type you would like to
 ;;associate with each of your ADMISSION TYPE, TRANSFER TYPE, and DISCHARGE TYPE
 ;;file entries.  If you have a movement type presently defined, it will be used
 ;;as the default, but you may change it.  Version 5.0 of MAS requires that all
 ;;of your locally defined movement types point to a nationally activated MAS
 ;;MOVEMENT TYPE to insure a clean conversion.  All of your local movement types
 ;;must point to an MAS distributed movement type before you will be allowed to
 ;;install MAS version 5.0.
 ;;
 ;;Also prompted is the PRINT NAME.  Several outputs will print an abbreviated
 ;;form of the movement type name.  The default will be the first 20 characters
 ;;of the movement type name, but this may not be unique enough.  You can make
 ;;changes to this field as well.
 ;;
 ;;You may use the 'Movement Type Worksheet' option as a worksheet prior to using
 ;;this option if you like.
 ;;
 ;;QUIT
 ;
 ;
4052 ;print outputs for 405.2
 D HEAD2 F I=0:0 S I=$O(^DG(405.2,I)) Q:'I  I $D(^(I,0)) S X=^(0) W !?3,$J(I,2),?9,$P(X,"^",1),?51 D CONT2
 Q
 ;
CONT2 S J=$P(X,"^",2) W $S(J=1:"ADMISSION",J=2:"TRANSFER",J=3:"DISCHARGE",J=4:"CHECK-IN LODGER",J=5:"CHECK-OUT LODGER",1:"SPECIALTY TRANSFER") W:I<47 ?83,$S($D(^DIC(43.9,+I,0)):$P(^(0),"^",1),1:"") I $Y>(IOSL-8) D HEAD2
 Q
 ;
HEAD2 S DGPG=DGPG+1 W @IOF,!,"NEW MOVEMENT TYPE LIST",?123,"PAGE:  ",DGPG
 W !,"NUMBER",?9,"NAME",?51,"TRANSACTION TYPE",?83,"PREVIOUSLY NAMED",! K X S $P(X,"-",132)="" W X
 Q
SOME ;choose which admission types, transfer types, and discharge types to edit
 S DR=".07;.08"
ADM S DIC(0)="AEQMZ",DIC="^DIC(42.1," D ^DIC I Y>0 S DIE=DIC,DA=+Y D ^DIE G ADM
XFR S DIC(0)="AEQMZ",DIC="^DIC(42.3," D ^DIC I Y>0 S DIE=DIC,DA=+Y D ^DIE G XFR
DIS S DIC(0)="AEQMZ",DIC="^DIC(42.2," D ^DIC I Y>0 S DIE=DIC,DA=+Y D ^DIE G DIS
 Q
