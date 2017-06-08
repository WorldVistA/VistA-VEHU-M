PRC4INS1 ;WISC/RFJ-version 4 IFCAP installation continued ; 06/03/93  1:31 PM
 ;;4.0;IFCAP;;9/23/93
 ;  environmental check for variable prc4inst
 I '$G(PRC4INST) K DIFQ Q
 Q
 ;
 ;
CONTINUE ;  continue with installation of version 4
 W !!,"==================== *** STARTING  IFCAP  INSTALLATION *** ===================="
 ;  install part 1, inventory
 W !,"|",?78,"|",!,"|",?30,"----- PART 1 -----",?78,"|"
 W !,"PART 1: INSTALLING Generic Inventory Package ..."
 S (PRCPFLAG,PRCINSTL)=0
 I $P(PRC4INS1,"^",3)'="" D  I PRCPFLAG Q
 .   S %=2,XP="  THIS PART HAS ALREADY BEEN INSTALLED.  DO YOU WANT TO RE-INSTALL IT",XH="  ENTER 'YES' TO RE-INSTALL THE PART, 'NO' TO GO TO THE NEXT PART, '^' TO EXIT." D YN^PRCPU4 I %=2 S PRCINSTL=1 Q
 .   I %'=1 S PRCPFLAG=1 Q
 I 'PRCINSTL D
 .   D NOW^%DTC S Y=% X ^DD("DD") S PRCSTART=$J(Y,20) W ! D ^PRCPINIT
 .   D NOW^%DTC S Y=% X ^DD("DD") S PRCEND=$J(Y,20)
 .   S PRCTEXT(10,0)="PART 1: Generic Inventory Package "_PRCSTART_"  "_PRCEND
 ;  verify it was installed
 S DA=+$O(^DIC(9.4,"C","PRCP",0)),PRC4PRCP=DA_"^"_$G(^DIC(9.4,DA,"VERSION"))
 I +$P(PRC4PRCP,"^",2)=4,$P($G(^DIC(9.4,DA,22,+$O(^DIC(9.4,DA,22,"B",PRCVERS,0)),0)),"^",3) S Y=$P(^(0),"^",3) X ^DD("DD") S $P(PRC4INS1,"^",3)=Y
 I $P(PRC4INS1,"^",3)="" D  D NO("RE-RUN 'PRC4INST'") Q
 .   W ! F %=1:1 S X=$P($T(TEXT+%),";",3,999) Q:X=""  W !,X
 ;
 ;  install part 2, ifcap
 W !!,"|",?78,"|",!,"|",?30,"----- PART 2 -----",?78,"|"
 W !,"PART 2: INSTALLING IFCAP Main System ..."
 S (PRCPFLAG,PRCINSTL)=0
 I $P(PRC4INS2,"^",3)'="" D  I PRCPFLAG Q
 .   S %=2,XP="  THIS PART HAS ALREADY BEEN INSTALLED.  DO YOU WANT TO RE-INSTALL IT",XH="  ENTER 'YES' TO RE-INSTALL THE PART, 'NO' TO GO TO THE NEXT PART, '^' TO EXIT." D YN^PRCPU4 I %=2 S PRCINSTL=1 Q
 .   I %'=1 S PRCPFLAG=1 Q
 I 'PRCINSTL D
 .   D NOW^%DTC S Y=% X ^DD("DD") S PRCSTART=$J(Y,20) W ! D ^PRCINIT
 .   D NOW^%DTC S Y=% X ^DD("DD") S PRCEND=$J(Y,20)
 .   S PRCTEXT(11,0)="PART 2: IFCAP Main System         "_PRCSTART_"  "_PRCEND
 ;  verify it was installed
 S DA=+$O(^DIC(9.4,"C","PRC",0)),PRC4PRC=DA_"^"_$G(^DIC(9.4,DA,"VERSION"))
 I +$P(PRC4PRC,"^",2)=4,$P($G(^DIC(9.4,DA,22,+$O(^DIC(9.4,DA,22,"B",PRCVERS,0)),0)),"^",3) S Y=$P(^(0),"^",3) X ^DD("DD") S $P(PRC4INS2,"^",3)=Y
 I $P(PRC4INS2,"^",3)="" D  D NO("RE-RUN 'PRC4INST'") Q
 .   W ! F %=1:1 S X=$P($T(TEXT+%),";",3,999) Q:X=""  W !,X
 ;
 ;  install AR patch 17 routine prc4off2 to prcaoff2
 D PATCH^PRC4INS2
 ;
 ;  start esig conversion if not previously run and version 4 installed
 I PRC4SITE,'$G(PRCNOSIG) D
 .   W !!,"=================== *** ELECTRONIC SIGNATURE CONVERSION *** ==================="
 .   D ^PRCUCV1 S:$G(ZTSK) PRCNOSIG=1
 .   I +$P($G(^PRC(411,+$O(^PRC(411,0)),7)),"^",2)=1 S PRCNOSIG=1
 S PRCTEXT(12,0)="",PRCTEXT(13,0)="Electronic Signature Conversion has "_$S($G(PRCNOSIG):"",1:"NOT ")_"been "_$S($G(ZTSK):"queued.",1:"completed.")
 I 'PRC4SITE S PRCNOSIG=1,PRCTEXT(13,0)="VIRGIN installation.  NO Electronic Signature Conversion required."
 ;
 ;  update forum site tracking if version 4 installed
 I $G(PRCNOSIG),$P(PRC4PRC,"^",2)="4.0",$P(PRC4PRCP,"^",2)="4.0" D
 .   W !!,"================ *** UPDATING FORUM SITE ACTIVITY TRACKING *** ================"
 .   K Y S Y="4.0",Y("START")=PRC4STRT D PAC^PRC4ICST(";;IFCAP^PRC",.Y)
 ;
 ;  fire off mailman message
 D MAILMSG^PRCPU4("IFCAP "_PRCVERS_" INSTALL","version "_PRCVERS,.PRCTEXT)
 I '$G(PRCNOSIG) D NO("SEE INSTALLATION NOTES ON RE-RUNNING ELECTRONIC SIGNATURE CONVERSION") Q
 W !!,"======================== *** INSTALLATION COMPLETED *** ======================="
 W !,"CONGRATULATIONS !  IFCAP Version ",PRCVERS," has been successfully installed."
 S %="",$P(%,"=",80)="" W !,%
 Q
 ;
 ;
NO(V1) ;  not installed
 W !!,"********************* === UNSUCCESSFUL INSTALLATION !! === ********************"
 W !,"PLEASE ",V1 W:$L(V1)>50 ! W "TO COMPLETE THE INSTALLATION !!"
 W !,"*******************************************************************************"
 Q
 ;
 ;
TEXT ;;text for install unsuccessful
 ;;You will not be able to continue with the installation of IFCAP
 ;;until this part has been successfully installed.
