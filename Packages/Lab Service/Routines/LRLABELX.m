LRLABELX ;DUR/KT/AT - PRINTS ON VAF 10-1392 LABELS ;2/6/91  08:05 ; [ 06/25/96  8:28 AM ]
 ;;5.2;LAB SERVICE;;Sep 27, 1994
A U IO
A1 W LRACC W:$D(LRURG) ?16,"Stat" W:$L(LRINFW) ?21,LRINFW W ?33,LRACC,?56,LRACC
 W !,$E(PNM,1,20),?21,$E(LRDAT,1,2)_$E(LRDAT,4,5)_$E(LRDAT,7,8),?33,$E(PNM,1,20),?56,$E(PNM,1,20),!,SSN,"  W:",LRLLOC,?20,$S(LRRB=0:"",1:" B:"_LRRB),?33,SSN,?56,SSN
 W ! I LRXL G SKIP:N-I<LRXL
 W LRPREF
SKIP W LRTOP,?15," Order:",LRCE,?33,"Order:",LRCE,?56,"Order:",LRCE,!
 S J=0,LRTXT="" F LRIJ=1:1 S J=$O(LRTS(J)) Q:J<.5  Q:($L(LRTXT)+$L(LRTS(J))>39)  S LRTXT=LRTXT_LRTS(J) S:$O(LRTS(J)) LRTXT=LRTXT_", "
 K LRIJ W $E(LRTXT,1,IOM-1),!! Q:'$D(LRAA)  Q:'$D(LRBAR(LRAA))
BAR ;Print bar code label
B1 W LRACC W:$D(LRURG) ?16,"Stat" W:$L(LRINFW) ?21,LRINFW
 W !,$E(PNM,1,20),?21,$E(LRDAT,1,2)_$E(LRDAT,4,5)_$E(LRDAT,7,8),!,SSN,"  W:",LRLLOC,?20,$S(LRRB=0:"",1:" B:"_LRRB)
 W !,$E(LRTXT,1,IOM-1),!
 W @LRBAR1,$E("00000",$L(LRAN),5)_LRAN,@LRBAR0 W ! Q
