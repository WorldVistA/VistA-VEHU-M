LRLABEL4 ;SLC/RAF - INTERMEC 4100 2x1 LABEL  ;10/20/93  10:16 [ 07/02/96  4:19 PM ]
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;This routine is used in conjunction with the Intermec program routine
 ;LRZBAR4 to print a 2x1 inch single label using an Intermec 4100.
 ;This code includes the doctor as well as the bar coded universal ID.
 ;A traditional accession number will also print. 
 ;The code S X=0 X ^%ZOSF("RM") is needed to replace the U IO:0 which
 ;works with MSM but not DSM
 ;
EN S:$D(ZTQUEUED) ZTREQ="@"
 N I1,J
 S X=0 X ^%ZOSF("RM")
 ;S:'$L($G(LRRB)) LRRB=""
 S J=0,LRTXT="",FLAG=0 F I1=1:1 S J=$O(LRTS(J)) Q:J<1  I ($L(LRTXT)+$L(LRTS(J))'>33) S LRTXT=LRTXT_LRTS(J) S:$O(LRTS(J))>0 FLAG=1,LRTXT=LRTXT_";"
FLAG S:FLAG=0 LRDTXT=LRTXT S:FLAG=1 LRDTXT=".............."
 S LRLPNM=$P(PNM,",",1),LRLPNM=LRLPNM_$S($L(LRLPNM)<18:","_$E($P(PNM,",",2),1),1:"")
BAR ;barcode label..accession number barcoded
 W *2,"R",*3
 W *2,*27,"E3",*24,*3
 W *2,!,LRUID,*3
 W *2,!,$E(PNM,1,27),!,SSN,!,"Loc: ",LRLLOC,!,LRACC,!,LRDAT,*3
 W *2,!,"Order #: ",LRCE,!,LRTOP,*3
 S LRDOC=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),U,8),LRDOC=$P(^VA(200,LRDOC,0),U)
 W *2,!,"Dr. ",LRDOC,*3
 W *2,! W:$D(LRURG) "STAT" W *3
 W *2,!,$E(LRTXT,1,23) W:$L(LRTXT)>23 "..." W *3 
 W *2,*23,*15,"S30",*12,*3
 Q
