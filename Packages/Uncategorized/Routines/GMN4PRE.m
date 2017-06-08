GMN4PRE ;ISC-SLC/MJC;ENVIROMENT CHECK TITLE/LOCATION PARAMS;6-21-95 11:17am
 ;;2.5;Progress Notes;**37**;Jan 08, 1993
 I '$D(^GMR(121,0)) W $C(7),$C(7),!,"I think you're in the wrong UCI!"
 I  W !?16,"-or-",!,"You don't have Progress Notes v2.5 installed yet!"
 I  W !! K DIFQ Q
 S U="^" I $S('($D(DUZ)#2):1,'$D(^VA(200,DUZ,0)):1,1:0) D  K DIFQ Q
 .W !!,"Your DUZ is "_$S($D(DUZ):"incorrectly set",1:"not set")
 .W ", the INIT will not run!!"
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) D  K DIFQ Q
 .W !!,"DUZ(0) needs to be set to ""@"", the INIT will not run!!"
 H 1
CHECK N X,Y S XT4="I 1"
 W !!,"I will check your checksums for you...." H 2 K FLAG
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  D
 .S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,Y,?19,$S('XT3:"Routine not in UCI",XT3'=Y:"OFF BY "_(Y-XT3),1:"ok")
 .I 'XT3!(XT3'=Y) S FLAG=1
 I $D(FLAG) D
 .W !!,$C(7),$C(7),"All of the routines that were exported with this"
 .W " patch do not",!,"have the correct checksum values!!",!
 .K DIR S DIR("A")="Do you want to continue? "
 .S DIR("B")="NO",DIR(0)="YA"
 .S DIR("?")="  'YES' and I will continue- 'NO' and I will stop the init"
 .D ^DIR K DIR
 .I '+$G(Y) K DIFQ W !!,"Init stopped- re-run it when you're ready."
 I $D(DIFQ)&('$D(FLAG)) W !!,"Checksums are all correct......",! H 2
 ;
EXIT K XT1,XT2,XT3,XT4,FLAG Q
ROU ;;
GMN4I001 ;;9248597
GMN4I002 ;;1203218
GMN4I003 ;;8738070
GMN4I004 ;;4104164
GMN4I005 ;;7678791
GMN4I006 ;;4717009
GMN4INI1 ;;4877714
GMN4INI2 ;;5232498
GMN4INI3 ;;16805554
GMN4INI4 ;;3357670
GMN4INI5 ;;625477
GMN4INIS ;;2205602
GMN4INIT ;;10530184
GMN4POST ;;856094
GMRPN ;;9724163
GMRPN1 ;;7961614
GMRPN2 ;;7050997
GMRPN3 ;;8965823
GMRPN4 ;;9239041
GMRPN4A ;;9252946
GMRPN5 ;;7984130
GMRPNA ;;8312533
GMRPNTT1 ;;3500248
GMRPXQA ;;3358412
