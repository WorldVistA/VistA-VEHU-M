GMN5PRE ;ISC-SLC/MJC;ENVIROMENT CHECK COSIG REQ;;4-14-96 13:23pm
 ;;2.5;Progress Notes;**43**;Jan 08, 1993
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
GMN5I001 ;;5571442
GMN5INI1 ;;4855222
GMN5INI2 ;;5232502
GMN5INI3 ;;16805616
GMN5INI4 ;;3357674
GMN5INI5 ;;380467
GMN5INIS ;;2205865
GMN5INIT ;;10625780
GMRPART ;;2365265
GMRPN ;;9815109
GMRPN3 ;;9789782
GMRPN5 ;;8025402
GMRPNP2 ;;7487080
