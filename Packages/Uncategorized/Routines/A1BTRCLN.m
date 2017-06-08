A1BTRCLN ;AISC/CMR - CLEAN UP DUPLICATE CNH RATES ;20APR94
 ;;1.0;;;APR 20, 1994
CLNUP ;cleanup code to remove duplicate contracts and rates
 ;find all contracts with same contract #
 L +^FBAA(161.21) L +^FBAA(161.22)
 S FBI=""
 F  S FBI=$O(^FBAA(161.21,"B",FBI)) Q:FBI']""  D
 .S (FBCNT,FBJ)=0 F  S FBJ=$O(^FBAA(161.21,"B",FBI,FBJ)) Q:'FBJ  I $D(^FBAA(161.21,FBJ,0)) S FBCNT=FBCNT+1,FB(FBI,FBJ)=^FBAA(161.21,FBJ,0)
 .I FBCNT'>1 K FB(FBI) Q
 I '$D(FB) W !!,*7,"No duplicate contracts found." G PTRATE
 S FBI="" F  S FBI=$O(FB(FBI)) Q:FBI']""  D LOOP
 D FIX L
PTRATE ;find all duplicate rates in 161.23
 L +^FBAA(161.23) S FBI=0
 F  S FBI=$O(^FBAA(161.23,"B",FBI)) Q:'FBI  D
 .S (FBCNT,FBJ)=0 F  S FBJ=$O(^FBAA(161.23,"B",FBI,FBJ)) Q:'FBJ  I $D(^FBAA(161.23,FBJ,0)) S FBCNT=FBCNT+1,FB(FBI,FBJ)=^FBAA(161.23,FBJ,0)
 .I FBCNT'>1 K FB(FBI) Q
 I '$D(FB) W !!,*7,"No duplicate patient rates found." G END
 S FBI=0 F  S FBI=$O(FB(FBI)) Q:'FBI  D RLOOP
END K FBI,FBJ,FBK,FBCNT,FB,FBT,Y,X
 L  Q
LOOP ;loop through and remove duplicate contracts
 S FBJ=0 F  S FBJ=$O(FB(FBI,FBJ)) Q:'FBJ  S FBK=FBJ F  S FBK=$O(FB(FBI,FBK)) Q:'FBK  D
 .I FB(FBI,FBJ)=FB(FBI,FBK) D RATE S DIK="^FBAA(161.21,",DA=FBK D ^DIK K DIK,DA,FB(FBI,FBK)
 Q
FIX ;list contracts with same # that are not duplicates
 W !!!,"The following contract numbers exist more than once in your Fee Basis",!,"CNH Contract file.  Although the contract numbers are the same, the",!,"contract data is different.  These contracts must be addressed manually."
 S FBI="" F  S FBI=$O(FB(FBI)) Q:'FBI  S FBJ=$O(FB(FBI,"")) I $O(FB(FBI,FBJ)) W !?5,FBI
 Q
RATE ;get rates for each contract and consolidate
 F FBT=FBJ,FBK S FBR=0 F  S FBR=$O(^FBAA(161.22,"AC",FBT,FBR)) Q:'FBR  S FBX=$P($G(^FBAA(161.22,FBR,0)),"^",2) I FBX S FBRATE(FBT,FBR)=$S(FBX[".00":+FBX,1:FBX) K FBX
 S FBR=0 F  S FBR=$O(FBRATE(FBK,FBR)) Q:'FBR  D
 .S FBR1=0 F  S FBR1=$O(FBRATE(FBJ,FBR1)) Q:'FBR1  D  Q:$G(FBFND)
 ..I FBRATE(FBJ,FBR1)=FBRATE(FBK,FBR) S FBFND=1,DIK="^FBAA(161.22,",DA=FBR D ^DIK K DIK,DA
 .I '$G(FBFND) S DIE="^FBAA(161.22,",DA=FBR,DR=".03////^S X=FBJ" D ^DIE K DIE,DA,DR
 .K FBFND
 K FBR,FBR1,FBRATE,FBFND
 Q
RLOOP ;loop through and remove duplicate patient raties
 S FBJ=0 F  S FBJ=$O(FB(FBI,FBJ)) Q:'FBJ  S FBK=FBJ F  S FBK=$O(FB(FBI,FBK)) Q:'FBK  D
 .I FB(FBI,FBJ)=FB(FBI,FBK) S DIK="^FBAA(161.23,",DA=FBK D ^DIK K DIK,DA,FB(FBI,FBK)
 Q
