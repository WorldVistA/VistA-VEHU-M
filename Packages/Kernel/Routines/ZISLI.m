ZISLI ;WILM/RJ - Initialization routine.  Needs to be run on each CPU at package installation; 5-17-87
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 W !!,"Running Post Initialization.",! K ^DOPT("ZISL"),^DOPT("ZISL1"),^DOPT("ZISL2"),^DOPT("CUAA")
 I '$D(DT) D NOW^%DTC S DT=$P(%,".",1)
 W !,"Moving 'Class Message text' free-text subfield to a word-processing subfield",!,"named 'Message' (for use with an Instanet 6600)"
 S DA=0 F I=0:0 S DA=$O(^%ZIS("Z",105,DA)) Q:+DA=0  S DA(1)=0 F I=0:0 S DA(1)=$O(^%ZIS("Z",105,DA,3,DA(1))) Q:+DA(1)=0  D MOVE
 W !,"Deleting the 'Class Message text' sub-field" I $D(^DD(105.03,1)) S $P(^(0),"^",4)=2 K ^DD(105.03,1),^DD(105.03,"B","Class Message text",1),^DD(105.03,"GL",0,2,1) W "  Done."
 I '$D(^%ZOSF("VOL")) W !,"First, you need to set %ZOSF(""VOL"") to the 1-10 character volume set of this cpu." Q
1 S ZISLCPU=^%ZOSF("VOL") D:'$O(^%ZIS("Z",108,"B",ZISLCPU,0)) SN^ZISLMSP S Y=$O(^%ZIS("Z",108,"B",ZISLCPU,0)) G:Y<1!('$D(^%ZIS("Z",108,Y,0))) 1
 W !,"Site Name: ",ZISLCPU S (DIE,DIC)="^%ZIS(""Z"",108,",DR="1:2",DA=Y D ^DIE
 S ZISLOS=$S($D(^DD("OS")):^("OS"),1:"") G:ZISLOS="" Q S ZISLOS=$S($D(^DD("OS",ZISLOS,0)):$P(^(0),"^",1),1:"") G:ZISLOS="" Q
 I ZISLOS["DSM" S X="D ^%ZISLDIS" G SET
 I ZISLOS["M/11"!(ZISLOS["M/VX") S X="S %DV=$I D ^%RESTERM" G SET
Q K ZISLOS W !!,"OK, the Micom Package (Version 4.51) has been initialized." K DA,DIC,DIE,DR,Z,ZISLCPU Q
SET I '$D(^%ZIS("H")) S ^("H")="Q"
 G:^%ZIS("H")=X Q
 W !!,"I am going to set up the global ^%ZIS(""H"") which is called when a user logs",!,"out through the kernel.  You currently have the node set to ",^%ZIS("H")
SET1 W !,"Do you want me to replace it with ",X," for micom disconnects" S U="^",%=1 D YN^DICN I %=1 S ^%ZIS("H")=X W !,"ok, I replaced it." G Q
 I %=2 W !,"ok, I will leave it as is." G Q
 I %=0 W !,"Enter Yes to replace your value [",^%ZIS("H"),"] with my value [",X,"]." G SET1
 G Q
MOVE ;move from class freetext subfield to word processing subfield
 S Y=^%ZIS("Z",105,DA,3,DA(1),0),X=$P(Y,"^",2),^%ZIS("Z",105,DA,3,DA(1),0)=$P(Y,"^",1) Q:X=""
 S ^%ZIS("Z",105,DA,3,DA(1),1,0)="^^1^1^"_DT_"^^",^%ZIS("Z",105,DA,3,DA(1),1,1,0)=X W "." Q
