PRC4INST ;WISC/RFJ-version 4 IFCAP installation main program ;30 Jun 92
 ;;4.0;IFCAP;;9/23/93
 ;
 N %,%H,%I,DA,DIE,DIK,DR,PRC4INS1,PRC4INS2,PRC4INST,PRC4PRC,PRC4SITE,PRC4PRCP,PRC4STRT,PRCEND,PRCINSTL,PRCNAME,PRCNOSIG,PRCPFLAG,PRCSTART,PRCTEXT,PRCVERS,X,XH,XP,Y
 ;
 D NOW^%DTC S PRC4STRT=%
 ;  prcvers used to check version number
 ;  prc4inst used in environmental check
 S PRCVERS=$P($T(PRC4INST+1),";",3),PRC4INST=1
 ;
 ;  display introduction
 W !!,"=================== *** IFCAP INSTALLATION INTRODUCTION *** ==================="
 W !,"|      *** Welcome to the installation program for IFCAP Version ",PRCVERS,". ***",?78,"|"
 W !,"|",?78,"|"
 W !,"|  This is the main program for installing IFCAP Version ",PRCVERS,".",?78,"|"
 W !,"|  If you experience any problems, you may re-run this program (PRC4INST).",?78,"|"
 W !,"|",?78,"|"
 W !,"|  Before running this program, please make sure you do not have users",?78,"|"
 W !,"|  on the system.  Also, please make sure you have a working backup of",?78,"|"
 W !,"|  your system disks.",?78,"|"
 S %="",$P(%,"-",80)="" W !,%
 ;
 I '$G(DUZ)!($G(DUZ(0))'["@") W !!,"PLEASE FOLLOW INSTALLATION INSTRUCTIONS EXACTLY.  USER 'DUZ' VARIABLES **NOT**",!,"CORRECTLY DEFINED." Q
 ;
 ;  check called routines and last ifcap routine
 S PRCPFLAG=0 I $D(^%ZOSF("TEST")) F X="PRC4INS1","PRC4INS2","PRC4OFF2","PRC4ICST","PRCUCV1","PRCPU4","PRCPINIT","PRCINIT","PRCUX99" X ^%ZOSF("TEST") I '$T S PRCPFLAG=1 Q
 I PRCPFLAG W !!,"It does not look like all of the IFCAP Version ",PRCVERS," routines",!,"have been successfully loaded.  Please re-load the routines and",!,"run this program again." Q
 ;
 ;  clean up package file
 W !!,"======================= *** CLEANING UP PACKAGE FILE *** ======================"
 S (DA,X)=0 F  S DA=$O(^DIC(9.4,"C","PRC",DA)) Q:'DA  S %=$G(^DIC(9.4,DA,"VERSION")) I %>X S PRC4PRC=DA_"^"_%,X=%
 I X,X'>3.4999 W !!,"YOU MUST BE RUNNING IFCAP VERSION 3.5 OR GREATER BEFORE INSTALLING VERSION ",PRCVERS,"." Q
 S (DA,X)=0 F  S DA=$O(^DIC(9.4,"C","PRCP",DA)) Q:'DA  S %=$G(^DIC(9.4,DA,"VERSION")) I %>X S PRC4PRCP=DA_"^"_%,X=%
 ;  clean out old prc entries
 S PRCNAME="PR" F  S PRCNAME=$O(^DIC(9.4,"C",PRCNAME)) Q:PRCNAME=""!($E(PRCNAME,1,2)'="PR")  I ($E(PRCNAME,1,3)="PRC"&(PRCNAME'="PRCA"))!($E(PRCNAME,1,3)="PRX")  D
 .   S DA=0 F  S DA=$O(^DIC(9.4,"C",PRCNAME,DA)) Q:'DA  I DA'=+$G(PRC4PRC),DA'=+$G(PRC4PRCP) W !?5,PRCNAME," (internal entry #",DA,") ..." S DIK="^DIC(9.4," D ^DIK W "  deleted."
 ;  reset name if wrong
 I $G(PRC4PRC),$D(^DIC(9.4,+PRC4PRC,0)),$P(^(0),"^")'="IFCAP" S DIE="^DIC(9.4,",DA=+PRC4PRC,DR=".01///IFCAP" D ^DIE
 ;
 ;  check esig conversion run
 W !!,"=============== *** CHECKING ELECTRONIC SIGNATURE CONVERSION *** =============="
 S PRC4SITE=+$O(^PRC(411,0))
 I +$P($G(PRC4PRC),"^",2)=4,+$P($G(PRC4PRCP),"^",2)=4,PRC4SITE,+$P($G(^PRC(411,PRC4SITE,7)),"^",2)=1 S PRCNOSIG=1 D
 .   W !?2,"|  It looks like the Electronic Signature Conversion has been already",?76,"|"
 .   W !?2,"|  completed.  Please refer to the installation guide to re-run the",?76,"|"
 .   W !?2,"|  conversion.",?76,"|"
 .   W !?2,"==========================================================================="
 I 'PRC4SITE W !,"This is a VIRGIN installation.  NO Electronic Signature Conversion required."
 I PRC4SITE,'$G(PRCNOSIG) W !,"Electroinc Signature Conversion will automatically start after the PRC inits",!,"have successfully run."
 ;
 W !!,"================== *** IFCAP INSTALLATION INITIALIZATION *** =================="
 W !,"The installation of IFCAP Version ",PRCVERS," has two parts to it as follows:"
 S PRC4INS1=$G(^DIC(9.4,+$G(PRC4PRCP),22,+$O(^DIC(9.4,+$G(PRC4PRCP),22,"B",PRCVERS,0)),0)),Y=$P(PRC4INS1,"^",3) I Y X ^DD("DD") S $P(PRC4INS1,"^",3)=Y
 S PRC4INS2=$G(^DIC(9.4,+$G(PRC4PRC),22,+$O(^DIC(9.4,+$G(PRC4PRC),22,"B",PRCVERS,0)),0)),Y=$P(PRC4INS2,"^",3) I Y X ^DD("DD") S $P(PRC4INS2,"^",3)=Y
 S PRCTEXT(10,0)="PART 1: Generic Inventory Package     "_$S($P(PRC4INS1,"^",3)'="":"previously installed "_$P(PRC4INS1,"^",3),1:"NOT INSTALLED") W !,"     ",PRCTEXT(10,0)
 S PRCTEXT(11,0)="PART 2: IFCAP Main System             "_$S($P(PRC4INS2,"^",3)'="":"previously installed "_$P(PRC4INS2,"^",3),1:"NOT INSTALLED") W !,"     ",PRCTEXT(11,0)
 F %=1:1 S X=$P($T(TEXT1+%),";",3,999) Q:X=""  W !,X
 ;
 W ! S %=2,XP="ARE YOU SURE YOU WANT TO START/CONTINUE THE INSTALLATION OF IFCAP",XH="Enter 'YES' to install IFCAP, 'NO' or '^' to exit." D YN^PRCPU4 I %'=1 Q
 D CONTINUE^PRC4INS1
 Q
 ;
 ;
TEXT1 ;;second part of info text
 ;; 
 ;;The PRC4INST will verify these parts are installed in sequential order by
 ;;checking the PACKAGE File (9.4).  If a part has been successfully installed, a
 ;;prompt will ask you if you would like to re-install that part.  If a part has
 ;;not been successfully installed, the PRC4INST program will start the
 ;;installation of that part without asking.
