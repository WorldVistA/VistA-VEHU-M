LRZFASTS ;DALISC/FHS - ENHANCED LRFAST ROUTINE  ACCESSION/VERIFY PROCESS [ 02/16/95  1:04 PM ]
 ;;5.2;LAB SERVICE;;Sep 27, 1994
EN ;
 D ^LRPARAM S LRFASTS="" I '$D(LRLABKY) W !!?10,"Not authorized to use this option " Q
 S LRCW=8,LREND=0,LRPANEL=0 K DIC,LRPER,DUOUT
 W !,"Do you want to review the data before and after you edit?" S %=1 D YN G:$D(DUOUT)!($D(DTOUT))!($G(LREND)) QUIT  IF %=2 S LRPER=""
 K LRCDEF0,LRCDEF
 D ^LRORD
QUIT I $D(LRCSQ),'$O(^TMP("LRCAP",LRCSQ,DUZ,0)) K ^TMP("LRCAP",LRCSQ,DUZ),LRCSQ
 I $D(LRCSQ),$P(LRPARAM,U,14) D STD^LRCAPV K LRIDIV
 K I12,LRCDEF,LRCDEF0,LRCDEF0X,LRCSQ,LRCW,LRFASTS,LRNTN,LRNX,LRPANEL,LRSSCX,LRDUF0,LRTEC,LRVF,LRXDP,X9,%,L1,LRAD,LREND,LRSN,QUOUT
 K LRAL,LRALL,LRCAPMS,LRMA,SEX,S2,T1,AGE,N,D0,D1,DOB,I,LRFASTS,LRSLOW,DIR,X3,LRORDXS,LRADXS,LRSNXS,LRWP,LRWPC
 K LRALERT,LRCSQQ,LRT,LRNOW,LRODTSV,LRSNSV,LRSUF0,LRTSNV,NOW,ORVP,ORIFN
 K LRI,LRTNSV
 D SLOWK,^%ZISC
 Q
LRWU4 ;
 Q:'$G(LRORD)  S LRORDXS=LRORD
 F LRADXS=0:0 S LRADXS=$O(^LRO(69,"C",LRORDXS,LRADXS)) Q:LRADXS<1  D
 .F LRSNXS=0:0 S LRSNXS=$O(^LRO(69,"C",LRORDXS,LRADXS,LRSNXS)) Q:LRSNXS<1  K LRSLOW D
 . . S LRSN=+LRSNXS,LRAD=+LRADXS,LRORD=+LRORDXS
 . . Q:'LRSN!('LRAD)!('$O(^LRO(69,LRAD,1,LRSN,2,0)))
 . . S I=0 F  S I=$O(^LRO(69,LRAD,1,LRSN,2,I)) Q:I<1  S L=$G(^LRO(69,LRAD,1,LRSN,2,I,0)) I $L(L),$P(L,U,3) S LRSLOW(+$P(L,U,4),+$P(L,U,5))=""
 . . S I1=0 F  S I1=$O(LRSLOW(I1)) Q:I1=""  S I12=0 F  S I12=$O(LRSLOW(I1,I12)) Q:I12<1  I $L($P($G(^LRO(68,I1,0)),U,11)) S X=$P(^(0),U,11)_" "_LRAD_" "_I12 D GO
 D SLOWK
 Q
GO D SLOW^LRWU4 I '$D(QUOUT),LRAA>1 D:$P(LRPARAM,U,14)&($P($G(^LRO(68,LRAA,0)),U,16)) ^LRCAPV D SLOW^LRVER
 Q
YN S:'$D(%) %=1 D YN^DICN S:%<0 LREND=1 W:%=0 !,"Answer with a YES or NO or '^' to exit" Q:%  G YN
SLOWK ;
 K I5,LRCSN,LRORIFN,LRWPC,X4
 K K,LRACN,LRACN0,LRDAX,LRDOC,LRCDEF,LRCDEF0
 K LRLBL,LRLBLBP,LRLL,LRLWC,LRMACH,LROD0,LROD1,LROD3,LROOS,LROSD,LRYR,S5
 K LRAA,LRACD,LRAN,LRAOD,LRCAPLOC,LRAOD,LRCDT,LRCFL,LRCODEN,LRCS,LRDAT,LRDEL,LRDFN,LRDPF,LRDV,LRDVF,LREAL,LREDO,LRFFLG,LRFP,LRIDIV,LRIDT,LRIX,LRJ,LRK,LRBLBP,LRLCT,LRLDT,LRLLOC,LRM,LRMAX1
 K LRMAX2,LRMAXX,LRMETH,LRMX,LRNAME,LRNOCODE,LROLLOC,LROT,LRPR,LRPRAC,LRRB,LRSAMP,LRSAVE,LRSPN,LRSS,LRSSX,LRST,LRSUB,LRSUM,LRSX,LRSXN,LRTEST,LRTN,LRTREA,LRTS,LRTX,LRTY,LRVRM,LRWL0,LRWLC,LRWRD,LRX,LRXD,LRWRD,SSN
 K DR,GLB,H8,L,T,TT
 Q
