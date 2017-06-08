LRSORA1 ;SLC/KCM - CREATE SEARCH LOGIC ; 8/5/87  11:40 ;
 ;;5.1;LAB;;04/11/91 11:06
EN W ! F J=1:1:LRTST W !,"-",$C(64+J),"-","   ",$P(LRTST(J,2),U,1) W:$P(LRTST(J,2),U,2)]"" " (",$P(LRTST(J,2),U,2),")" W " ",$P(LRTST(J,2),U,3)
 S LRA="A" F I=1:1:LRTST-1 S LRA=LRA_" OR "_$C(65+I)
 S Y=-1 F I=0:0 W !!,"Enter SEARCH LOGIC: ",LRA,"// " R X:DTIME S:'$T X="^" S:X["^" LREND=1 D:X["?" HLP0 S:'$L(X) X=LRA D:(X'["?")&(X'["^") PLOG Q:Y'<0!LREND
 S LRTST(0)=Y Q
PLOG F %=1:1 S T=$T(SWAP+%) Q:$P(T,";",3)="ZZZZ"  S LROLD=$P(T,";",3),LRNEW=$P(T,";",4) D PARSE
 S Y="" F %=1:1:$L(X) S:$E(X,%)'=" " Y=Y_$E(X,%)
 F %=1:1:$L(Y) S T=$A(Y,%) S LROK=0 D TSTLIM I 'LROK S Y=-1 Q
 I Y'=-1 S X="I "_Y D ^DIM S:'$D(X) Y=-1
STOP W:Y<0 " ??" K LRPNT,LROLD,LRNEW,LROK,LRI,LRJ,X,T,% Q
TSTLIM F LRJ=33,38,39,40,41,65:1:64+LRTST S:T=LRJ LROK=1
 Q
PARSE F LRI=1:1:$L(LROLD)-$L(LRNEW) S LRNEW=LRNEW_" "
 S LRPNT(0)=0 F LRI=1:1 S LRPNT(LRI)=$F(X,LROLD,LRPNT(LRI-1)) Q:LRPNT(LRI)=0
 F LRJ=1:1:LRI-1 S X=$E(X,1,LRPNT(LRJ)-$L(LROLD)-1)_LRNEW_$E(X,LRPNT(LRJ),99)
 Q
SWAP ;;LROLD;LRNEW; NOTE:  $L(LROLD) MUST BE >= $L(LRNEW)
 ;;AND;&
 ;;OR;!
 ;;NOT;'
 ;;,;&
 ;;ZZZZ
HLP0 W !!,"Enter a logical expression (i.e., A AND B OR C or A&B!C)."
 W !,"  NOTE:  AND will compare only values from the -same- accession."
 W !,"         To print all results that fall within the search criteria,"
 W !,"         accept the default search logic (OR)."
