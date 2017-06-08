GMD1PRE ;ISC-SLC/MJC;Environment check rtn for GMRD*1*2;12-7-94 5:28pm
 ;;1.0;Discharge Summary;**2**;Nov 02, 1993
 I '$D(^GMR(128,0)) W $C(7),$C(7),!,"I think you're in the wrong UCI!",!?16,"-or-",!,"You don't have Discharge Summary v1.0 installed yet!",!! K DIFQ Q
 S U="^" I $S('($D(DUZ)#2):1,'$D(^VA(200,DUZ,0)):1,1:0) D  K DIFQ Q
 .W !!,"Your DUZ is "_$S($D(DUZ):"incorrectly set",1:"not set")_", the INIT will not run!!"
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) D  K DIFQ Q
 .W !!,"DUZ(0) needs to be set to ""@"", the INIT will not run!!"
 H 1
CHECK N X,Y S XT4="I 1"
 W !,"I will check your checksums for you...." H 2 K FLAG W !
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
EXIT K X,Y,XT1,XT2,XT3,XT4,FLAG Q
ROU ;;
GMD1I001 ;;7011631
GMD1I002 ;;11986098
GMD1I003 ;;6244709
GMD1I004 ;;2296792
GMD1INI1 ;;5626079
GMD1INI2 ;;5232456
GMD1INI3 ;;16091231
GMD1INI4 ;;3357628
GMD1INI5 ;;455291
GMD1INIS ;;2202303
GMD1INIT ;;11263246
GMRDCHLP ;;3367576
GMRDEDIT ;;9317167
GMRDFLRC ;;8545994
GMRDFLRT ;;7158276
GMRDFLRU ;;2814639
GMRDLIBA ;;11744980
GMRDLIBC ;;7668231
GMRDLIBD ;;6117649
GMRDLIBF ;;2103761
GMRDUPAR ;;2494543
