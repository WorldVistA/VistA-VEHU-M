GMN2PRE ;ISC-SLC/MJC;ENVIROMENT CHECK FOR SECURITY KEY;1-18-95 5:16pm
 ;;2.5;Progress Notes;**29**;Jan 08, 1993
 I '$D(^GMR(121,0)) W $C(7),$C(7),!,"I think you're in the wrong UCI!",!?16,"-or-",!,"You don't have Progress Notes v2.5 installed yet!",!! K DIFQ Q
 S U="^" I $S('($D(DUZ)#2):1,'$D(^VA(200,DUZ,0)):1,1:0) D  K DIFQ Q
 .W !!,"Your DUZ is "_$S($D(DUZ):"incorrectly set",1:"not set")_", the INIT will not run!!" Q
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) D  K DIFQ Q
 .W !!,"DUZ(0) needs to be set to ""@"", the INIT will not run!!" Q
 H 1
CHECK N X,Y S XT4="I 1"
 W !!,"I will check your checksums for you...." H 2 K FLAG W !
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  D
 .S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,Y,?19,$S('XT3:"Routine not in UCI",XT3'=Y:"OFF BY "_(Y-XT3),1:"ok")
 .I 'XT3!(XT3'=Y) S FLAG=1
 I $D(FLAG) D
 .W !!,$C(7),$C(7),"All of the routines that were exported with this"
 .W " patch do not",!,"have the correct checksum values!!",!
 .K DIR S DIR("A")="Do you want to continue? "
 .S DIR("B")="NO",DIR(0)="YA"
 .S DIR("?")="  'YES' and I will continue- 'NO' and I will stop the init"
 .D ^DIR K DIR I '+$G(Y) K DIFQ W !!,"Init stopped- re-run it when you're ready."
 I $D(DIFQ)&('$D(FLAG)) W !!,"Checksums are all correct......",!
 ;
EXIT K XT1,XT2,XT3,XT4,FLAG Q
ROU ;;
GMN2I001 ;;9405275
GMN2I002 ;;1215921
GMN2I003 ;;6842077
GMN2INI1 ;;5646556
GMN2INI2 ;;5232490
GMN2INI3 ;;16091893
GMN2INI4 ;;3357662
GMN2INI5 ;;515899
GMN2INIS ;;2205076
GMN2INIT ;;11262185
GMRPN ;;9000206
GMRPN5 ;;4862422
GMRPNP1 ;;5963483
GMRPNP2 ;;6775252
GMRPNTTL ;;11286371
