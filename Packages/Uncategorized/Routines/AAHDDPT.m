%AAHDDPT ;402,DJB,11/2/91,EDD**Pointers In, Pointers Out
 ;;GEM III;;
 ;; David Bolduc - Togus, ME
PTI ;Pointers In
 I '$D(^DD(ZNUM,0,"PT")) W ?30,"No files point to this file." S FLAGG=1 Q
 NEW GL,HD,Z1,ZCNT,ZFILE,ZFILEN,ZFILETP,ZFLD
 D INIT^%AAHDDPR G:FLAGQ EX D HD S ZFILE="",ZCNT=1,HD="HD"
 F  S ZFILE=$O(^DD(ZNUM,0,"PT",ZFILE)) Q:ZFILE=""!FLAGQ  S FLAGPT=0 D @$S($D(^DIC(ZFILE,0)):"PTIYES",1:"PTINO") I 'FLAGPT S ZFLD="" F  S ZFLD=$O(^DD(ZNUM,0,"PT",ZFILE,ZFLD)) Q:ZFLD=""  D PTIPRT Q:FLAGQ
EX ;
 K FLAGPT Q
PTINO ;
 I '$D(^DD(ZFILE,0,"UP")) S FLAGPT=1 Q
 S ZFILETP=ZFILE F  S ZFILETP=^DD(ZFILETP,0,"UP") Q:$D(^DIC(ZFILETP,0))  I '$D(^DD(ZFILETP,0,"UP")) Q
 I '$D(^DIC(ZFILETP,0)) S FLAGPT=1 Q
 S GL=^DIC(ZFILETP,0,"GL"),ZFILEN=$P(^DIC(ZFILETP,0),U)
 Q
PTIYES ;
 S GL=^DIC(ZFILE,0,"GL"),ZFILEN=$P(^DIC(ZFILE,0),U) Q
PTIPRT ;
 W !,$J(ZCNT,4),".",?6,GL,?21,$E(ZFILEN,1,25)
 W ?48 I $D(^DD(ZFILE,ZFLD,0)),$P(^(0),U)]"" W $E($P(^(0),U),1,22)," (",ZFLD,")"
 E  W "--> Field ",ZFLD," does not exist."
 S ZCNT=ZCNT+1 I $Y>GEMSIZE D PAGE Q:FLAGQ
 Q
PTO ;Pointers Out
 NEW CNT,FILE,HD,NAME,NODE0,NUMBER,Z1,ZDD
 D INIT^%AAHDDPR S HD="HD1" D @HD,PTOGET
 Q
PTOGET ;
 S ZDD="",CNT=1
 F  S ZDD=$O(^UTILITY($J,"TMP",ZDD)) Q:ZDD=""!(FLAGQ)  S NAME="" F  S NAME=$O(^DD(ZDD,"B",NAME)) Q:NAME=""  S NUMBER="",NUMBER=$O(^DD(ZDD,"B",NAME,"")) D PTOLIST Q:FLAGQ
 I CNT=1 W !!!!!?20,"This file has no fields that",!?20,"point to other files."
 Q
PTOLIST ;
 Q:^DD(ZDD,"B",NAME,NUMBER)=1  ;If this node equals 1 it is TITLE not NAME
 S NODE0=^DD(ZDD,NUMBER,0) Q:$P(NODE0,U,2)'["P"  Q:$P(NODE0,U,3)']""
 W !?1,$S(ZDD'=ZNUM:"MULT",1:""),?6,$J(NUMBER,8),?16,NAME S FILE="^"_$P(NODE0,U,3)_"0)" W ?48,$S($D(@FILE):$E($P(@FILE,U),1,30),1:"-->No such file")
 S CNT=CNT+1 I $Y>GEMSIZE D PAGE Q:FLAGQ=1
 Q
HD ;Pointers to this file
 W !?3,"Pointers TO this file..",!?9,"GLOBAL",?22,"FILE  (Truncated to 25)",?50,"FIELD   (Truncated to 22)",!?6,"-------------",?21,"-------------------------",?48,"------------------------------"
 Q
HD1 ;Pointers from this file
 W !?3,"Pointers FROM this file..",!?6,"FLD NUM",?26,"FIELD NAME",?52,"FILE (Truncated to 30)",!?6,"--------",?16,"------------------------------",?48,"------------------------------"
 Q
PAGE ;
 I FLAGP,$E(GEMIOST,1,2)="P-" W @GEMIOF,!!! D @HD Q
 R !!?2,"<RETURN> to continue, '^' to quit, '^^' to exit: ",Z1:GEMTIME S:'$T Z1="^" I Z1["^" S FLAGQ=1 S:Z1="^^" FLAGE=1 Q
 W @GEMIOF D @HD
 Q
