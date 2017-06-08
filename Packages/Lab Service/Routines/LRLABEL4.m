LRLABELA ;SLC/RAF - INTERMEC 4100 2 LABEL PRINT BARCODE/PLAIN ; 16 Dec 99  3:00 PM
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;;V5.1;LAB;;04/11/91 11:06
 ;This routine is used in conjunction with the Intermec program routine
 ;LRBARA to print a two label accession label for accession areas which
 ;have their BAR CODE PRINT field set to YES
 ;LRLABELA may have to be renamed LRLABEL6
 ;The code S X=0 X ^%ZOSF("RM") is needed to replace the U IO:0 which
 ;works with MSM but not DSM
 ;
 S LRZLBTYP=$G(^%ZIS(1,IOS,"F")) I LRZLBTYP="LRZLABLS" D ^LRZLABLS K LRZLBTYP Q  
EN S:$D(ZTQUEUED) ZTREQ="@"
 N I1,J
 I $G(LRSN) D COM S X=^LRO(69,LRODT,1,LRSN,0),LRCSS=$S($D(^(4,1)):^(1,0),1:0)
 Q:LRAA=0!'$D(LRAA)!('$D(LRAD)!('$D(LRAN)))  S ZZRDX=^LRO(68,LRAA,1,LRAD,1,LRAN,0)
 S LRPR=+$P(ZZRDX,"^",8)
 S ZZURG=$S($D(LRTV):+$P(LRTV,U,2),1:0),ZZURG=$S($D(^LAB(62.05,ZZURG,0)):$E($P(^(0),U),1,12),1:"")
 D AGE
 ;
 H 2
 S X=0 X ^%ZOSF("RM")
 S:'$L($G(LRRB)) LRRB=""
 S J=0,LRTXT="",FLAG=0 F I1=1:1 S J=$O(LRTS(J)) Q:J<1  S LRTXT=LRTXT_LRTS(J) S:$O(LRTS(J))>0 FLAG=1,LRTXT=LRTXT_","
FLAG S:FLAG=0 LRDTXT=LRTXT S:FLAG=1 LRDTXT=".............."
 S LRLPNM=$P(PNM,",",1),LRLPNM=LRLPNM_$S($L(LRLPNM)<18:","_$E($P(PNM,",",2),1),1:"")
 ;D PRT
 I IOST'["INTERMEC" D REG Q
 I '$D(LRBAR) D PRT
 Q:'$D(LRBAR)!('$D(LRBAR($G(LRAA))))
BAR ;barcode label..accession number barcoded
 W *2,"R",*3
 W *2,*27,"E3",*24,!,$E(LRTXT,1,31) W:$L(LRTXT)>31 "..." W *3
 W *2,!,LRTOP,!,"Ord#: ",LRCE,!,"PROV:",$S($D(^VA(200,LRPR,0)):$P(^(0),"^"),1:"UNKNOWN"),!,"VA-CAVHCS",!,LRACC,!,LRDAT,!,SSN,!,$S($L(LRRB):"B:"_LRRB,1:"W:"_$E(LRLLOC,1,9)),*3
 W *2,!,$E(PNM,1,27),!,"AGE: ",VADM(4),*3
 ;W *2,! W:$D(LRURG) LRURG W *3
 ;W *2,! W:$D(ZZURG) ZZURG W *3
 W *2,!,*3 ;W *2,! W $S($D(LRURG0):$E(^LAB(62.05,+LRURG0,0),1,4),1:"????") W *3
 W *2,!,LRBARID,*3
 ;W *2,!,LRAA_$E("00",$L(LRAN),2)_LRAN,*3
 W *2,!,"OC: ",ZCOM,*3
 W *2,*23,*15,"S30",*12,*3
 Q
PRT ;plain label..no barcode
 W *2,"R",*3
 W *2,*27,"E2",*24,!,$E(LRTXT,1,31) W:$L(LRTXT)>31 "..." W *3
 W *2,!,LRTOP,!,"Ord#: ",LRCE,!,"PROV:",$S($D(^VA(200,LRPR,0)):$P(^(0),"^"),1:"UNKNOWN"),!,"VA-CAVHCS",!,LRACC,!,LRDAT,!,SSN,!,$S($L(LRRB):"B:"_LRRB,1:"W:"_$E(LRLLOC,1,9)),*3
 W *2,!,$E(PNM,1,27),!,"AGE: ",VADM(4),*3
 ;W *2,! W:$D(ZZURG) ZZURG W *3
 W *2,! W $S($D(LRURG0):$E(^LAB(62.05,+LRURG0,0),1,4),1:"????") W *3
 ;W *2,! W:$D(LRURG) LRURG W *3
 ;W *2,!,$E("0000",$L(LRAN),4)_LRAN,*3
 W *2,!,"OC: ",ZCOM,*3
 W *2,*23,*15,"S30",*12,*3
 Q
REG ;REGULAR ASCII LABELS
 ;W LRACC,?15,$E(ZZURG,1,7),?30,"VA-MONTG."
 W LRACC,?15,$S($D(LRURG0):$E(^LAB(62.05,+LRURG0,0),1,4),1:"????"),?30,"VA-CAVHCS"
 W !,$E(PNM,1,22),?25,"AGE: ",VADM(4),?35,LRDAT,!,SSN,"    W:",LRLLOC,?32,"PROV: "
 W $S($D(^VA(200,LRPR,0)):$P(^(0),"^"),$D(^VA(200,LRPR,0)):$P(^(0),"^"),1:"UNKNOWN")
 W ! ;I LRXL G SKIP:N-I<LRXL
 W LRPREF
 W LRTOP,?31," Order:",LRCE,?42," OC: ",ZCOM,!
 S J=0,LRTXT="" F LRIJ=1:1 S J=$N(LRTS(J)) Q:J<1  Q:($X+$L(LRTS(J))>39)  S LRTXT=LRTXT_LRTS(J)  S:$N(LRTS(J))>0 LRTXT=LRTXT_", "
 K LRIJ W $E(LRTXT,1,IOM-1)
 W # Q
 Q
COM I '$D(^LRO(69,LRODT,1,LRSN,6,2,0)) S ZCOM="" Q
 I ^LRO(69,LRODT,1,LRSN,6,2,0)["MID" S ZCOM="MID"
 E  I ^(0)["TROUGH" S ZCOM="TROUGH"
 E  I ^(0)["PEAK" S ZCOM="PEAK"
 E  I ^(0)["UNK" S ZCOM="UNK"
 E  I $D(^(0)) S ZCOM=^(0)
 E  I ^(0)["" S ZCOM=""
 Q
AGE N X,I D ^VADPT
 Q
