ZISLCOM0 ;WILM/RJ - Compile 6600 configuration; 4-13-89
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S DIC("A")="Select Configuration to Store 6600 Commands: ",DIC="^%ZIS(""Z"",105,",DIC(0)="AELNQZ" W ! D ^DIC G:Y<1 E S DA=+Y G:$P(Y,"^",3)=1 TOP
ASK W !,"Do you want to DELETE all previously entered commands and messages first" S %=2 D YN^DICN
 G:%<0 E I %=0 W !,"Enter YES to DELETE all commands and messages stored for this configuration,",!,"      NO to add them to the configuration, or '^' to exit." G ASK
 I %=1 W !,"DELETING Configuration." F %=1:1:3 K ^%ZIS("Z",105,DA,%)
 I  W "  Done!"
TOP S T=DTIME,DTIME=20,U="^",DX=0,DY=0 D 1^%ZISLVR I X=U U IO(0) W "No connection made.",! G E
 U IO(0) I ZISLTYPE'=6600 W !,"This option only works with a Micom 6600." G E
 W !!,"Connected to Micom ",ZISLTYPE,"...GO"
 K ^UTILITY("ZISL",$J) S ZISLCOUN=1,ZISLTRY=0
 K ZISLR F J=1:1 W !,"Enter shelf/channel to show:  SHO CH " R R:DTIME S:'$T R=U W:'$T "  ...Timeout." W ! Q:R[U!(R="")  D:R["?" H I R'["?" S ZISLR("SHO CH "_R)=""
 S R="" F ZISLR=1:1 S R=$O(ZISLR(R)) Q:R=""  D T
 I ZISLR=1 K ZISLCOUN G E
 U IO(0) W !,"Computing Protocol Groups, Access Groups, and Destination Groups..."
 U IO(0) W !!,"<<< COMPUTING PROTOCOL GROUPS, ACCESS GROUPS, AND DESTINATION GROUPS >>>" K ^UTILITY("ZISL",$J,"DG"),^UTILITY("ZISL",$J,"PG"),^UTILITY("ZISL",$J,"AG")
 S ZISLAUTO=1,ZISL=0 F I=0:0 S ZISL=$O(^UTILITY("ZISL",$J,ZISL)) Q:+ZISL=0  S C=^(ZISL) I C'="A> ",C'="B> ",C'="",C'["SHO CH" D GET
 S ZISLCOUN("PG")=ZISLCOUN,ZISL=0 F I=0:0 S ZISL=$O(^UTILITY("ZISL",$J,"PG",ZISL)) Q:ZISL=""  S R="SHO PG "_ZISL D T
 S ZISLCOUN("DG")=ZISLCOUN,ZISL=0 F I=0:0 S ZISL=$O(^UTILITY("ZISL",$J,"DG",ZISL)) Q:ZISL=""  S R="SHO DG "_ZISL D T
 S ZISLCOUN("AG")=ZISLCOUN,ZISL=0 F I=0:0 S ZISL=$O(^UTILITY("ZISL",$J,"AG",ZISL)) Q:ZISL=""  S R="SHO AG "_ZISL D T
 U IO(0) W !!,"<<< COMPUTING RESOURCE CLASSES AND WELCOME MESSAGES >>>" K ^UTILITY("ZISL",$J,"RC"),^UTILITY("ZISL",$J,"MSG")
 S ZISL=ZISLCOUN("AG") F I=0:0 S ZISL=$O(^UTILITY("ZISL",$J,ZISL)) Q:+ZISL=0  S C=^(ZISL) D GETWMSG:C["WMSG=",GETRCL:C["RCL="
 S ZISLCOUN("RC")=ZISLCOUN,ZISL=0 F I=0:0 S ZISL=$O(^UTILITY("ZISL",$J,"RC",ZISL)) Q:ZISL=""  S R="SHO RC "_ZISL D T
 S ZISLCOUN("MSG")=ZISLCOUN,ZISL=0 F I=0:0 S ZISL=$O(^UTILITY("ZISL",$J,"MSG",ZISL)) Q:ZISL=""  S R="SHO MSG "_ZISL D T
 S ZISLCOUN("E")=ZISLCOUN
E U IO(0) W !,"<<< HANGING UP ADMINISTRATIVE PORT >>>" X ^%ZOSF("EON") D CP^%ZISLDIS X ^%ZIS("C") S DTIME=T G:'$D(ZISLCOUN) Q D ^ZISLCOM1
Q K %,DIC,DA,D,G,I,J,X,Y,Z,ZISL,ZISLAUTO,ZISLCMD,ZISLCOUN,ZISLCPU,ZISLINE,ZISLR,ZISLRC,ZISLSITE,ZISLTRY,ZISLTYPE,C,R,T,^UTILITY("ZISL",$J) Q
T U IO X ^%ZOSF("XY") U IO(0) S Y="" F J=1:1 D P S X=$E(R,J) Q:X=""  U IO W X
 W *13 U IO(0) W !
 F J=0:0 U IO R *X:1 Q:X=-1  U IO(0) W *X S Y=Y_$C(X) I X=13 S ^UTILITY("ZISL",$J,ZISLCOUN)=$E(Y,1,($L(Y)-2)),ZISLCOUN=ZISLCOUN+1,Y=""
 I $D(ZISLAUTO),^UTILITY("ZISL",$J,ZISLCOUN-1)["?" I ZISLTRY<2 S ZISLTRY=ZISLTRY+1,ZISLCOUN=ZISLCOUN-2,R=^UTILITY("ZISL",$J,ZISLCOUN) G T
 S ^UTILITY("ZISL",$J,ZISLCOUN)=Y,ZISLCOUN=ZISLCOUN+1,ZISLTRY=0
 Q
P F P=1:1:100
 Q
GET ;find out which PG, AG, DG are in use
 S G=+$E(C,14,16),^UTILITY("ZISL",$J,"PG",G)="",G=+$E(C,21,23),^UTILITY("ZISL",$J,"AG",G)="",G=+$E(C,29,31),^UTILITY("ZISL",$J,"DG",G)="" Q
GETWMSG ;find out welcome messages
 S D=$P(C,"WMSG=",2),N="" F I=1:1 Q:$E(D,I)=" "  S N=N_$E(D,I)
 S ^UTILITY("ZISL",$J,"MSG",+N)="" Q
GETRCL ;find out resource classes
 S Y=$P(C,"RCL=",2) F R=1:1 S C=$E(Y,R) Q:C=""  I C?.N S ^UTILITY("ZISL",$J,"RC",+$E(Y,R,255))="" F R=R:1 S C=$E(Y,R) Q:C=""  I C=" " S R=R-1 Q
 Q
H W !,"Type in the shelf/channel numbers in the form sh/ch:ch that is to be sent",!,"to the administrative port for generating the configuration file.  To exit",!,"press the up-arrow ""^"" followed by <RETURN>.",! Q
