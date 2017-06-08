ZISLCOM1 ;WILM/RJ - Part 2 of Compiling 6600 status into configuration; 4-13-89
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 D NOW^%DTC S DT=$P(%,".",1)
 S:'$D(^%ZIS("Z",105,DA,1,0)) ^(0)="^^0^0^"_DT_"^^^" S ZISLCOUN=$P(^%ZIS("Z",105,DA,1,0),"^",3) S:ZISLCOUN<1 ZISLCOUN=1 I ZISLCOUN("PG")<ZISLCOUN("DG") S ZISLCMD=";==================  P R O T O C O L   G R O U P S  ==================" D SET
 F ZISL=ZISLCOUN("PG"):1:(ZISLCOUN("DG")-1) S Y=^UTILITY("ZISL",$J,ZISL) D 1
 I ZISLCOUN("RC")<ZISLCOUN("MSG") S ZISLCMD=";=================  R E S O U R C E   C L A S S E S  =================" D SET
 F ZISL=ZISLCOUN("RC"):1:(ZISLCOUN("MSG")-1) S Y=^UTILITY("ZISL",$J,ZISL) D 1
 I ZISLCOUN("AG")<ZISLCOUN("RC") S ZISLCMD=";====================  A C C E S S   G R O U P S  ====================" D SET
 F ZISL=ZISLCOUN("AG"):1:(ZISLCOUN("RC")-1) S Y=^UTILITY("ZISL",$J,ZISL) D 1
 I ZISLCOUN("DG")<ZISLCOUN("AG") S ZISLCMD=";===============  D E S T I N A T I O N   G R O U P S  ===============" D SET
 F ZISL=ZISLCOUN("DG"):1:(ZISLCOUN("AG")-1) S Y=^UTILITY("ZISL",$J,ZISL) D 1
 S ZISLCMD=";=========================  C H A N N E L S  =========================" D SET
 F ZISL=1:1:(ZISLCOUN("PG")-1) S Y=^UTILITY("ZISL",$J,ZISL) D 1
 S ^%ZIS("Z",105,DA,1,0)="^^"_ZISLCOUN_"^"_ZISLCOUN_"^"_DT
 F ZISL=ZISLCOUN("MSG"):1:(ZISLCOUN("E")-1) S Y=^UTILITY("ZISL",$J,ZISL) D 1
 Q
1 I Y["SHO PG" S ZISLTYPE="SET PG "_$E(Y,8,255) Q
 I Y["SHO AG" S ZISLTYPE="SET AG "_$E(Y,8,255) Q
 I Y["SHO RC" S ZISLTYPE="SET RC "_$E(Y,8,255) Q
 I Y["SHO MSG" S ZISLTYPE="SET MSG "_$E(Y,9,255) Q
 I Y["SHO CH" S ZISLTYPE="SET CH " Q
 I Y["SHO DG" S ZISLTYPE="SET DG "_$E(Y,8,255) Q
PG ;
 Q:Y=""!(Y["?")!(Y["A>")!(Y["B>")
 I ZISLTYPE["SET AG",Y["RCL=" D AGRCL Q
 I ZISLTYPE["SET RC" Q:$E(Y,1,5)'="  RC "  D RC Q
 I ZISLTYPE["SET MSG" D MSG Q
 I ZISLTYPE["SET CH" S ZISLCMD=ZISLTYPE_$E(Y,3,8)_" "_$E(Y,11,32) G SET
 I ZISLTYPE["SET DG" D DG Q
 S X=$E(Y,11,255),ZISLCMD=ZISLTYPE_" "_X
SET W !,ZISLCMD
 S ^%ZIS("Z",105,DA,1,ZISLCOUN,0)=ZISLCMD,ZISLCOUN=ZISLCOUN+1
 Q
AGRCL ;access group resource class message
 S ZISLCMD=ZISLTYPE_" RCL" D SET
 S ZISLCMD="K" D SET
 S Y=$P(Y,"RCL=",2) F R=1:1 S C=$E(Y,R) Q:C=""  I C?.N S ZISLCMD="A "_(+$E(Y,R,255)) D SET F R=R:1 S C=$E(Y,R) Q:C=""  I C=" " S R=R-1 Q
 S Y=$S($D(^UTILITY("ZISL",$J,ZISL+1)):^(ZISL+1),1:"") I $E(Y,16)?1N D AGNL
 S ZISLCMD="Q" G SET
AGNL ;check to see if following line is resource classes also
 F R=1:1:13 S C=$E(Y,R) Q:C=""!(C'=" ")
 I C'=" " Q
 S Y=$E(Y,14,255) F R=1:1 S C=$E(Y,R) Q:C=""  I C?.N S ZISLCMD="A "_(+$E(Y,R,255)) D SET F R=R:1 S C=$E(Y,R) Q:C=""  I C=" " S R=R-1 Q
 S ZISL=ZISL+1 Q
RC ;resource classes
 S Y=$E(Y,11,255),Y=$P(Y," RC=INS"),ZISLCMD=ZISLTYPE_" "_Y D SET Q
MSG ;set messages
 I $E(Y,1,3)=" 1)" S ZISLCMD=ZISLTYPE D MSGADD
 S ZISLCMD=$E(Y,5,255) S ^%ZIS("Z",105,DA,3,ZISLRC,1,ZISLINE,0)=ZISLCMD,ZISLINE=ZISLINE+1
 W !?3,ZISLCMD S X=$O(^UTILITY("ZISL",$J,ZISL)) I +X=0!($L(^UTILITY("ZISL",$J,X))=0) S ^%ZIS("Z",105,DA,3,ZISLRC,1,0)="^^"_(ZISLINE-1)_"^"_(ZISLINE-1)_"^"_DT_"^^"
 Q
MSGADD ;add a new message number
 I '$D(^%ZIS("Z",105,DA,3,0)) S ^(0)="^105.03A^^"
 S X=+$E(ZISLCMD,9,255),ZISLINE=1,ZISLRC=$P(^(0),"^",4)+1,$P(^(0),"^",3,4)=ZISLRC_"^"_ZISLRC,^(ZISLRC,0)=X W !,ZISLCMD Q
DG ;destination groups
 S X=$E(Y,12,255),I=+$P(X,"RC=",2),J=+$P(X,"IIT=",2),K=$E($P(Y,"RDIR=",2),1,3),ZISLCMD=ZISLTYPE_" RC="_I_" IIT="_$S(J=0:"NONE",1:J)_" RDIR="_K D SET
 Q
