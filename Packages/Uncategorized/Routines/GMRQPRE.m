GMRQPRE ;ISC-SLC/MJC;ENVIROMENT CHECK-TITLE INACTIVATION;06/02/94  5:30 PM
V ;;2.5;Progress Notes;**23**;;Jan 08, 1993
 I '$D(^GMR(121,0)) W $C(7),$C(7),!,"I think you're in the wrong UCI!",!?16,"-or-",!,"You don't have Progress Notes v2.5 installed yet!",!! K DIFQ Q
 S U="^" I $S('($D(DUZ)#2):1,'$D(^VA(200,DUZ,0)):1,1:0) D  K DIFQ Q
 .W !!,"Your DUZ is "_$S($D(DUZ):"incorrectly set",1:"not set")_", the INIT will not run!!" Q
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) D  K DIFQ Q
 .W !!,"DUZ(0) needs to be set to ""@"", the INIT will not run!!" Q
EXIT Q
