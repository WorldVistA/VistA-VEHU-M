GMP1PRE ;ISC-SLC/MJC;ENVIROMENT CHECK FOR GMP*2*3 ;;11-29-95 3:15pm
 ;;2.0;Problem List;**3**;Aug 25, 1994
 I '$D(^GMPL(125,0)) W $C(7),$C(7),!,"I think you're in the wrong UCI!",!?16,"-or-",!,"You don't have Problem List v2.0 installed yet!",!! K DIFQ Q
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
GMP1I001 ;;4908207
GMP1I002 ;;2761731
GMP1INI1 ;;4834696
GMP1INI2 ;;5232492
GMP1INI3 ;;16805488
GMP1INI4 ;;3357664
GMP1INI5 ;;524405
GMP1INIS ;;2205315
GMP1INIT ;;10518438
GMP1L ;;5248968
GMP1O001 ;;10098511
GMP1ONI1 ;;1694610
GMP1ONI2 ;;82718
GMP1ONI3 ;;10576480
GMP1ONIT ;;950844
GMP1POST ;;681031
GMPL ;;10704366
GMPL1 ;;7123050
GMPLBLD ;;11222614
GMPLBLD1 ;;12288092
GMPLBLD2 ;;8690160
GMPLBLDC ;;11018269
GMPLENFM ;;5246257
GMPLPREF ;;10212637
GMPLPRF0 ;;10274861
GMPLPRF1 ;;14352559
GMPLUTL ;;9761312
GMPLUTL1 ;;5776027
GMPLX1 ;;6961925
