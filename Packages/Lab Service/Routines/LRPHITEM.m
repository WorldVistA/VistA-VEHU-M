LRPHITEM ;SLC/CJS/RWF-ITEMIZED LOGIN ;JUNE 06, 1991@1049
 ;;5.2;LAB SERVICE;**121,198,208,202,221,262,528**;Sep 27, 1994;Build 3
 ;
 S LRODT=DT,LRNT=$$NOW^XLFDT
 ;
V1 D FNDLOC^LRDRAW G END^LRPHITE1:LRLLOC["^"
 I LRLLOC="" W !,"All locations" S %=2 D YN^DICN G V1:%=2!(%=0),END^LRPHITE1:%=-1
 I $L(LRLLOC) I '$D(^LRO(69.1,"LRPH",1,LRLLOC)) W !,"Location ",LRLLOC," not found on collection list.",$C(7) G V1
 ;
V2 ;
 K LRSN,LROR,LRCOM,LRTCOM,LRNOCOM
 W !!,$C(7),"Enter Order Numbers NOT collected: " S LROR=0,LRFIRST=1 D LP1 G:X="^" END^LRPHITE1
 ; -->Fix for 208
 I $O(LROR(0))>0 W !,"Exceptions first." S LROR=0 D
 . N LRLLOC,LRODT
 . F  S LROR=$O(LROR(LROR)) Q:LROR<1  D EXCEPT^LRPHITE3
 ;
 K LRSN,LROR,LRCOM,LRTCOM
 W !!,"Enter Order Numbers COLLECTED: " S LRNOCOM=1,LROR="" D LP1 G:X="^" END^LRPHITE1
 G:LRLLOC'="" E1 S LRLLOC="" F  S LRLLOC=$O(^LRO(69,LRODT,1,"AC",LRLLOC)) Q:LRLLOC=""  D E2
 D LEFT G END^LRPHITE1
 ;
E1 ;
 D E2,LEFT G END^LRPHITE1
 ;
LEFT Q:$O(LROR(0))=""  W !!,"DID NOT FIND THESE ORDERS:" S I=0 F  S I=$O(LROR(I)) Q:I=""  W $J(LROR(I),10) W:$X>69 !
 Q
 ;
E2 ;
 N LRSTORE
 S LROR=0
 F  S LROR=$O(LROR(LROR)) Q:LROR<1  D
 . S LRSTORE(1)=LROR(LROR)
 . S LRSN=0
 . F  S LRSN=$O(^LRO(69,"C",LRSTORE(1),LRODT,LRSN)) Q:LRSN=""  D
 . . I $G(^LRO(69,LRODT,1,"AC",LRLLOC,LRSN))'=1 Q
 . . S LRSTORE=0
 . . D P15
 . . W !,LRLLOC,"  ",LRSTORE(1)
 . . W:'$G(LRSTORE) "  Not Accepted !! ",$C(7)
 . . K LROR(LROR)
 Q
 ;
 ;
P15 ;from LROE1, LRPHEXPT
 N LRORIFN,LRX712,LRUIDA
 ;
 Q:'$D(^LRO(69,LRODT,1,LRSN,1))  Q:$L($P(^(1),U,4))  S J1=^(1),LRX712=^(0)
 S LRDFN=+LRX712 K LRDPF
 D
 . N LRRB
 . D PT^LRX
 S LROLLOC=$P(LRX712,U,9)
 S LRTREA=+$G(VAIN(3))
 S LRORIFN=$P(LRX712,U,11)
 S LRNT=$$NOW^XLFDT
 ;
 ;S ^LRO(69,LRODT,1,LRSN,1)=$P(J1,U,1,2)_"^"_DUZ_"^"_$P(J1,U,4)_"^^"_$P(J1,U,6)_"^"_$P(J1,U,7)
 S $P(^LRO(69,LRODT,1,LRSN,1),U,3)=DUZ
 ;
 S $P(^LRO(69,LRODT,1,LRSN,3),U)=LRNT,^LRO(69,LRODT,1,"AC",LRLLOC,LRSN)=""
 S (LRAA,LRAD,LRAN,LRTN)=0
 F  S LRTN=$O(^LRO(69,LRODT,1,LRSN,2,LRTN)) Q:LRTN<1  D
 . I '$D(^LRO(69,LRODT,1,LRSN,2,LRTN,0)) Q
 . S X=^LRO(69,LRODT,1,LRSN,2,LRTN,0),LRAA=+$P(X,U,4),LRAD=+$P(X,U,3),LRAN=+$P(X,U,5),LRORIFN=$P(X,U,7)
 . D P15A
 . I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,3)) D
 . . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,3)=LRNT
 . . S ^LRO(68,LRAA,1,LRAD,1,"E",LRNT,LRAN)=""
 ;
 I +$G(LRDPF)=2 D
 . N CONTROL
 . S CONTROL=$S($L(LRORIFN):"SC",1:"SN")
 . D NEW^LR7OB1(LRODT,LRSN,CONTROL,,,6)
 ;
 N LRX
 S LRX=""
 F  S LRX=$O(LRUIDA(LRX)) Q:LRX=""  D EN^LA7ADL(LRX)
 ;
 Q
 ;
 ;
P15A ;
 I $G(LRDPF)=2,$$VER^LR7OU1<3 D:LRAA OR^LRWLST S $P(^LRO(69,LRODT,1,LRSN,2,LRTN,0),U,7)=LRORIFN
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))
 S $P(^LRO(69,LRODT,1,LRSN,1),U,4)="C",$P(^(1),U,8)=DUZ(2),LRRB="",$P(^LRO(69,LRODT,1,LRSN,1),U)=LRNT,^LRO(69,"AA",+$G(^(.1)),LRODT_"|"_LRSN)=""
 S LRSTORE=1
 ;
 ; Save list of uid's on this order, used above to download to Lab UI.
 N X
 S X=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),U)
 I $L(X) S LRUIDA(X)=""
 Q
 ;
P16 ;from LRPHITE1
 N X
 Q:'$D(^LRO(69,LRODT,1,LRSN,1))#2
 S LRSS=$P(^LRO(68,LRAA,0),"^",2)
 Q:'$G(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  S LRDFN=+^(0),LRDPF=$P(^(0),U,2)
 S LRDTM=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U),LRIDT=+$P(^(3),U,5)
 I $S('LRIDT:1,'$D(^LR(LRDFN,LRSS,LRIDT,0))#2:1,1:0) S LRNOP=1 W !?5,"Accession Information Corrupt for this Order",!! Q
 I $P(^LR(LRDFN,LRSS,LRIDT,0),U,3) W !,$C(7),"CAN'T DO IT.  The data has been verified for accession  ",$P(^(0),U,6) S LRNOP=1 Q
SKP S $P(^LRO(69,LRODT,1,LRSN,1),U,3)=DUZ,$P(^(1),U,4)="U" G P17:'LRBATCH
 S X=$O(LRCOM(999-LROR)),LRRND=$S($L(LRRND):LRRND,X>0:LRCOM(X,1,1),1:"")
P17 G P18:$L(LRRND) W !,"REASON FOR NON-DRAW ON ORDER ",LROR(LROR)
 W " ",$G(LRCCOM)
 I $G(LREPISOD) K LREPISOD
 S LRSAMP=1,LRSPEC=1,LREND=0 I '$L(LRRND) F  D  Q:$L(LRRND)!($G(LREND))  W !?5,"You must enter a reason.",!
 . N LRCCOM,LRCCOM1,LRCCOMX D FX2^LRTSTOUT S LRRND=LRCCOM
 Q:$G(LREND)
P18 S $P(^LRO(69,LRODT,1,LRSN,1),U,6)=LRRND
 D:$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) OUT^LRPHITE2
 Q
LP1 ;from LRPHEXPT
 N Y1
 S LRFORD=LROR K LRCCOM,LRCOM0
 W !,"Enter Order #(s) :",! R X:DTIME Q:(X="^"!(X="")!('$T))  W ! I (X="?"!($L(X)>80)) W !,"Enter a string of numbers separated with A ',' UP TO 80 CHARACTERS LONG ",! G LP1
 W ! F I=1:1 S LRSN=+$P(X,",",I) Q:LRSN=0  D
 .  S Y1=$O(^LRO(69,"C",+LRSN,LRODT,0))
 .  S Y=Y1 D:Y1<1 TEXT S LRSN0=Y1 ;----->LR*5.2*182
 .  I Y1'="",$$ALLCA(LRODT,+LRSN) S Y=0 D TEXT Q
 .  I Y1'="" S LRWD=$P(^LRO(69,LRODT,1,Y1,0),U,7) S:LRLLOC'="" Y=$S(LRWD=LRLLOC:$D(^LRO(69,LRODT,1,Y,1)),1:"") S:Y LROR=LROR+1,LROR(LROR)=+LRSN D TEXT
198 ;
 S LRSAMP=999-LRFORD,LRSPEC=1,LRCOM(LRSAMP,1,1)="",LRCOM(LRSAMP,1)=0
 G LP1
ALLCA(LRSD,LRON) ;Are all tests cancelled?
 N LRI,LRC,LRSN,LRX
 S LRC=1,LRSN=0
 F  S LRSN=$O(^LRO(69,"C",LRON,LRSD,LRSN)) Q:+LRSN'>0  S LRI=0 D  Q:LRC=0
 .  F  S LRI=$O(^LRO(69,LRSD,1,LRSN,2,LRI)) Q:+LRI'>0  D  I LRX'="CA" S LRC=0 Q
 .  .  S LRX=^LRO(69,LRSD,1,LRSN,2,LRI,0),LRX=$P(LRX,U,9)
 Q LRC
TEXT S:Y<1 Y="" W:$X>70 ! W +LRSN,$S(Y:" OK, ",1:" NOT ON LIST, ")
 QUIT
 ;--> LR*5.2*182
SINGLE ;
 N X
 Q:$G(LREPISOD)=1
 S LREPISOD=1
 I '$G(LRSN) S LRSN=$G(LRSN0)
 S LRITN=$G(LRITN,LRIX)
 S LRRND=LRCCOM
 Q:'$G(LRSN)
 S $P(^LRO(69,LRODT,1,LRSN,1),U,6)=LRRND
 S X=1+$O(^LRO(69,LRODT,1,LRSN,2,LRITN,1.1,"A"),-1),X(1)=$P($G(^(0)),U,4)
 S ^LRO(69,LRODT,1,LRSN,2,LRITN,1.1,X,0)="*"_$G(LRCCOM1)_":"_LRCCOM,X=X+1,X(1)=X(1)+1
 S ^LRO(69,LRODT,1,LRSN,2,LRITN,1.1,0)="^^"_X_U_X(1)_U_DT
 K LRSAMP,LRSPEC,LRCOM,LRCCOM
 QUIT
POLY ;
 N LRTIC
 S LRTIC=0
 F  S LRTIC=$O(^LRO(69,LRODT,1,LRSN,2,LRTIC)) Q:+LRTIC'>0  S LRITN=LRTIC D
 .  S X=1+$O(^LRO(69,LRODT,1,LRSN,2,LRITN,1.1,"A"),-1),X(1)=$P($G(^(0)),U,4)
 .  S ^LRO(69,LRODT,1,LRSN,2,LRITN,1.1,X,0)="*"_$G(LRCCOM1)_":"_LRCCOM,X=X+1,X(1)=X(1)+1
 .  S ^LRO(69,LRODT,1,LRSN,2,LRITN,1.1,0)="^^"_X_U_X(1)_U_DT
 K DIE,LREPISOD
 S LRCOM0=LRCCOM
 K LRSAMP,LRSPEC,LRCOM
 QUIT
 ;
MULT ;
 S LRSN0=0 ;-->  specimen number
 F  S LRSN0=$O(^LRO(69,"C",LRSN,LRODT,LRSN0)) Q:+LRSN0'>0  D LRSN
 QUIT
LRSN ;
 ;--> From LRPHITE1 when multiple tests have been cancelled
 ;    LRCCOM is still valid since only one comment per order
 ;
 N LRTT3
 S LRTT3=0
 F  S LRTT3=$O(^LRO(69,LRODT,1,LRSN0,2,LRTT3)) Q:+LRTT3'>0  D
 .  Q:$P(^LRO(69,LRODT,1,LRSN0,2,LRTT3,0),U,9)'="CA"
 .  S LRTIC=0
 .  F  S LRTIC=$O(^LRO(69,LRODT,1,LRSN0,2,LRTT3,1,LRTIC)) Q:+LRTIC'>0  D
 ..  Q:$D(^LRO(69,LRODT,1,LRSN0,2,LRTT3,1,LRTIC,0))
 ..  N LRITN S LRITN=LRTT3
 ..  D SINGLE
 QUIT
