ZISLAUT1 ;WILM/RJ - Load a Configuration for a 6600; 4-13-89
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 I $D(^%ZIS("Z",105,DA,2,0)),$P(^(0),"^",3) W !,"ENTER ALL WELCOME MESSAGES IN THE 'Fixed Class or Message Number' Field."
 S DA(1)=0 F I=1:1 S DA(1)=$O(^%ZIS("Z",105,DA,3,DA(1))) Q:+DA(1)=0  S ZISL=0 F J=0:0 S ZISL=$O(^%ZIS("Z",105,DA,3,DA(1),1,ZISL)) Q:+ZISL=0  D MSG
 U IO(0) W !!,"*** END OF AUTO LOAD FOR INSTANET 6600 ***"
E S X=0 D CP^%ZISLDIS G E^ZISLAUTO
MSG ;load message
 I ZISL=1 D SETMSG Q:X=S
 S R="",C=^%ZIS("Z",105,DA,3,DA(1),1,ZISL,0) D T^ZISLAUTO,R^ZISLAUTO
 I +$O(^%ZIS("Z",105,DA,3,DA(1),1,ZISL))=0 F K=1:1:2 S C="" S:K=2 R="* " D T^ZISLAUTO,R^ZISLAUTO
 Q
SETMSG S C="SET MSG "_$P(^%ZIS("Z",105,DA,3,DA(1),0),"^",1),R="* " D T^ZISLAUTO,R^ZISLAUTO Q:X=S
 S C="D 1:99" D T^ZISLAUTO,R^ZISLAUTO Q:X=S
 S C="I 0",R="" D T^ZISLAUTO,R^ZISLAUTO U IO(0) W !,"--- Entering Message Text ---" Q
