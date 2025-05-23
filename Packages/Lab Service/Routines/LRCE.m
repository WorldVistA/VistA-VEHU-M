LRCE ;DALOI/JMC - LOOK-UP ON CENTRAL ENTRY # ; 12/20/17 8:51am
 ;;5.2;LAB SERVICE;**28,76,103,121,153,210,202,263,350,416,486,498**;Sep 27, 1994;Build 7
 ;
EN ;
 N CAN,ORD
 S (LRSTOP,LRFLAG1,LRFLG,LRSN1,LRNOP)=0
 K DIRUT,SSN,LRORD
 W !!
 S DIR("A")="Order Number or UID: ",DIR(0)="FOA"
 S DIR("?",1)="Enter a whole number for the order number, enter the universal identifier"
 S DIR("?",2)="(UID), or press Return to find the order number by Patient.",DIR("?")="Enter '^' to Exit."
 D ^DIR
 I $G(SSN)&(Y="") G END
 I Y="" D ^LROS G:'$G(SSN) END G EN
NEXT I $D(DIRUT) G END
 D UNIV
 S LRORD=+Y
 I LRORD?.AP!(LRORD<1) D  G EN
 . W !,"Enter a whole number for the order number."
 S LRORD=+LRORD
 K DIR,X,Y,DIRUT
 IF $O(^LRO(69,"C",LRORD,0))<1 W "  NUMBER NOT FOUND" G LRCE
 I $D(LRADDTST),$$CAN(LRORD) D  G EN
 . W !!,?5,"This order has been canceled."
 . W !,?5,"Tests WILL NOT be added.  A new order must be placed."
DIS ;
 W @IOF
 I $D(LRADDTST) D
 . W !!?15,"LISTING OF DATES "
 . S (CNT,LRODT)=0
 . F A=0:0 S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT=""  D
 .. D CHKPAGE Q:$G(LRSTOP)
 .. S CNT=CNT+1
 .. W !?5,CNT,?10,$$FMTE^XLFDT(LRODT,"5FM")
 Q:$G(LRSTOP)  K CNT,A
 S LRODT=0
 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1!($G(LRSTOP))  D  I $D(LRADDTST),+LRADDTST Q
 . D LR2
 I $D(LRADDTST) G LRCE:LRADDTST="" G END
 I '$D(LRADDTST) G EN
 Q
 ;
CAN(ORD) ;See if all tests have been canceled
 N I,SN,ODT,LRSTR
 S (CAN,ODT,SN)=1
 F  S ODT=$O(^LRO(69,"C",ORD,ODT)) Q:ODT<1  D
 . S SN=0 F  S SN=$O(^LRO(69,"C",ORD,ODT,SN)) Q:SN<1!('CAN)  D
 . . Q:'$D(^LRO(69,ODT,1,SN,0))
 . . S I=0 F  S I=$O(^LRO(69,ODT,1,SN,2,I)) Q:I<1  Q:'CAN  D
 . . . S LRSTR=$G(^LRO(69,ODT,1,SN,2,I,0)) Q:LRSTR=""
 . . . ;check for "canceled by" and "canceled" status
 . . . I '$P(LRSTR,"^",11),$P(LRSTR,U,9)'="CA" S CAN=0
 Q CAN
 ;
ADDTST ;
 N LRADDTST
 S LRADDTST="" D EN
 S LRRSTAT=160
 I LRADDTST  D ^LRORD
 D END,ADDEND
 Q
 ;
 ;
ADDEND ;
 K LRCLCTR,LRCLST,LRDFN,LRDPF,LRDRWTM,LRFLAG1,LRFLG
 K LRLLOC,LRLOC,LRODT,LROLLOC,LRORDRR,LRPRAC,LRRB
 K LRRSITE,LRSD,LRDN,LRSTOP,LRTREA,LRSN,LRTSN,LRTSP,PNM,SSN,DOB,SEX
 K TYPE,LRRSTAT,LRNOP,LRSN1
 K X,Y,I
 Q
 ;
 ;
LR2 ;
 Q:$G(LRSTOP)
 D CHKPAGE
 Q:$G(LRSTOP)
 S LRSN=0
 F  S LRSN=+$O(^LRO(69,"C",+$G(LRORD),+$G(LRODT),LRSN)) Q:LRSN<1!($G(LRSTOP))  D PT I $D(LRADDTST),+LRADDTST Q
 Q
 ;
 ;
UNIV ; see if entry is UID
 N LRAA,LRAD,LRAN I $D(^LRO(68,"C",X)) S LRAA=$O(^LRO(68,"C",X,0)) I LRAA S LRAD=$O(^LRO(68,"C",X,LRAA,0)) I LRAD S LRAN=$O(^LRO(68,"C",X,LRAA,LRAD,0)) I LRAN S Y=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.1)),"^")
 Q
 ;
 ;
CHKPAGE ;
 Q:$G(LRSTOP)
 Q:$Y<(IOSL-2)
 K DIR
 S DIR(0)="E"
 D ^DIR
 I $D(DUOUT)!($D(DIRUT)) S LRSTOP=1 Q
 W @IOF
 W !
 Q
 ;
 ;
PT ;
 D CHKPAGE
 Q:$G(LRSTOP)!($G(LRFLG))
 S LROR=$S($D(^LRO(69,LRODT,1,LRSN,0)):^(0),1:-1)
 S LRDFN=+LROR
 I LRDFN<1 W "  NO PATIENT" Q
 S LRWHOE=+$P(LROR,U,2)
 S LRWHOE=$S($D(^VA(200,LRWHOE,0)):$P(^(0),U),1:"")
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX
 H 1
HEAD ;
 D CHKPAGE
 Q:$G(LRSTOP)
 W !!,"ORDER #: ",LRORD,?20,"PAT: ",PNM,"    SSN: ",SSN,!
 D CHKPAGE
 Q:$G(LRSTOP)
 D LRGLIN^LRX
 W !
 S LRCTYP=$P(LROR,U,4)
 I (LRWHOE'="")!(LRCTYP'="") D
 . I LRWHOE'="" W "WHO ENTERED: ",$E(LRWHOE,1,25) K LRWHOE
 . W:LRCTYP'="" ?40,"TYPE OF COLLECTION: ",LRCTYP
 I $D(^LRO(69,LRODT,1,LRSN,1)) D
 . S LRCLCTR=$P(^LRO(69,LRODT,1,LRSN,1),U,3),LRCLST=$P(^(1),U,4)
 . S:LRCLCTR'="" LRCLCTR=$P($G(^VA(200,+LRCLCTR,0)),U)
 . W ! D CHKPAGE Q:$G(LRSTOP)
 . W:LRCLCTR'="" "  COLLECTOR : ",$E(LRCLCTR,1,25)
 . W:LRCLST'="" ?40,"COLLECTION STATUS: ",LRCLST
 Q:$G(LRSTOP)
 ;
 S LRDRWTM=$S($D(^LRO(69,LRODT,1,LRSN,1)):+^(1),1:"")
 S:LRDRWTM LRDRWTM=$$FMTE^XLFDT(LRDRWTM,"ZM")
 S LRLOC=+$P(LROR,U,9),LRLOC=$P($G(^SC(LRLOC,0)),U)
 I (LRDRWTM'="")!(LRLOC'="") D
 . W ! D CHKPAGE Q:$G(LRSTOP)
 . W:LRDRWTM'="" "  DRAW TIME:   ",LRDRWTM
 . I LRDRWTM="",$P(LROR,"^",8) W "TO BE DRAWN:   ",$$FMTE^XLFDT($P(LROR,U,8),"ZM")
 . W:LRLOC'="" ?40,"ORDERING LOCATION: ",$E(LRLOC,1,20)
 Q:$G(LRSTOP)
 ;
 W ! D CHKPAGE Q:$G(LRSTOP)
 I $G(^LRO(69,LRODT,1,LRSN,3)) W "  LAB ARRIVAL: ",$$FMTE^XLFDT(+$G(^(3)),"ZM")
 I LRDPF=2 W:LRWRD'="" ?40,"WARD: ",LRWRD
 W:$P(LROR,U,3) !,"  SPECIMEN: " D CHKPAGE Q:$G(LRSTOP)
 W:$P(LROR,U,3) $S($D(^LAB(62,$P(LROR,U,3),0)):$P(^(0),U),1:"??")
 S L=+$P(^LRO(69,LRODT,1,LRSN,0),U,6) I L D
 . S LRMD=$S($D(^VA(200,L,0)):$P(^(0),U),1:L)
 . W ?40,"PROVIDER: ",$E(LRMD,1,30)
 W:$G(^LRO(69,LRODT,1,LRSN,"PCE")) !,?5,"Visit Number(s): ",$G(^("PCE"))
 ;
 S I=0
TST D CHKPAGE
 Q:$G(LRSTOP)
 F  S I=$O(^LRO(69,LRODT,1,LRSN,2,I)) Q:I<1  D
 . D CHKPAGE Q:$G(LRSTOP)
 . S LRNOPMSG=0
 . D TEST D CHKPAGE Q:$G(LRSTOP)
 D CHKPAGE
 Q:$G(LRSTOP)
 I $D(^LRO(69,LRODT,1,LRSN,1)),$L($P(^(1),U,6)) D
 . W !,"COMMENT: ",$P(^LRO(69,LRODT,1,LRSN,1),U,6) D CHKPAGE Q:$G(LRSTOP)
 S I=0
 F  S I=$O(^LRO(69,LRODT,1,LRSN,6,I)) Q:I<1  W !,?3,^(I,0) D CHKPAGE Q:$G(LRSTOP)
 Q:$G(LRSTOP)
NXT S X=$P($G(^LRO(69,LRODT,1,LRSN,1)),U,4)
 I X="C"!($G(LRNOPMSG)) W !,"Order has already been accessioned."
 I LRNOP,'$D(LRLABKY) D  Q
 . I $G(LRNOPMSG) W !,"Tests have been accessioned, call the lab to add tests to the same order."
 I '$D(LRADDTST) Q
 I X="M" W !?5,"This Order was Merged " Q
 I '$G(LRRSTAT) S LRRSTAT=160
SEL W !,"Is this the one"
 S %=1,LRNOP=0 K LRORDRR,LRRSITE,LRSD,LRTSP
 D YN^DICN
 I %'=1 S (LRFLG1,LRNOP)=0 Q
 S LRADDTST=$S(%=1:LRORD,1:"")
 Q:$G(LRSTOP)!('$G(LRADDTST))
 I %=1 D
 . N X,X0,I,DIC,DA
 . S X0=^LRO(69,LRODT,1,LRSN,0),LRLWC=$P(X0,"^",4)
 . S LRFLG=1
 . S LRPRAC=$P(X0,"^",6),LRLLOC=$P(X0,"^",7),LROLLOC=$P(X0,U,9)
 . Q:LRLWC'="R"  S LRRSITE("SDT")=$P(X0,U,5)
 . S DIC("A")="*Select Original Ordered Test "
 . S DA=LRSN,DA(1)=LRODT,DIC("S")="I $G(^(.3))"
 . S DIC="^LRO(69,"_LRODT_",1,"_LRSN_",2,",DIC(0)="AQEZNM"
 . D ^DIC I Y<1  S LRADDTST="" Q
 . S LRTSP=$P(Y,U,2),X=$G(^LRO(69,LRODT,1,LRSN,2,+Y,.3))
 . Q:'$P(X,U,2)  S (LRSD("RPSITE"),LRRSITE("RSITE"))=$P(X,U,2)_U_$P(^LRO(69,LRODT,1,LRSN,0),U,7)
 . S LRRSITE("RPSITE")=$P(X,U,3)
 . S LRSD("RUID")=$P(X,U,5)
 . ;LRRSITE("IDTYPE") needs to be set so that
 . ;all UID fields are set correctly in file 69
 . ;see SET3^LRX (line below added in LR*5.2*498)
 . S LRRSITE("IDTYPE")=1
 . S LRORDRR="R"
 Q
 ;
 ;
LUPT ;
 K DFN,DIC S DIC(0)="EMQ"
 D ^LRDPA
 Q:DFN<1!$D(DUOUT)
 ;
LU1 ;
 W !,"Order date to start from: T//" R X:DTIME
 I '$T!(X["^") QUIT
 S %DT="E",X=$S(X="":"T",1:X)
 D ^%DT
 G:Y<1 LU1 S Y=Y-1
 S LRODT=Y F  S LRODT=$O(^LRO(69,LRODT)) Q:LRODT<1  D FSN
 Q
 ;
 ;
FSN ;
 S LRSN=0
 F  S LRSN=$O(^LRO(69,LRODT,1,"AA",LRDFN,LRSN)) Q:LRSN<1  D
 . Q:'$D(^LRO(69,LRODT,1,LRSN,.1))  S LRORD=+^(.1) D PT
 Q
 ;
 ;
TEST ;
 D CHKPAGE Q:$G(LRSTOP)
 S X=^LRO(69,LRODT,1,LRSN,2,I,0) S:$P(^(0),U,3) (LRNOP,LRNOPMSG)=1
 W !,"  TEST: ",$S($D(^LAB(60,+X,0)):$P(^(0),"^"),1:"UNKNOWN"),?28,"  "
 S LRURG=+$P(X,U,2)
 W $E($S($D(^LAB(62.05,LRURG,0)):$P(^(0),U),1:"ROUTINE"),1,15)
 W ?38,"  ",$S($D(^LRO(68,+$P(X,"^",4),0)):$P(^(0),"^"),1:""),?50,"  ",$P(X,"^",5),?55
 ;
 D REF
 I $P(X,"^",11) D
 . W !?3,"Canceled by: "_$P(^VA(200,$P(X,"^",11),0),"^") S I(2)=0
 . F  S I(2)=$O(^LRO(69,LRODT,1,LRSN,2,I,1.1,I(2))) Q:I(2)<1  I $D(^(I(2),0)) W !?5,^(0) D CHKPAGE Q:$G(LRSTOP)
 D CHKPAGE Q:$G(LRSTOP)
 ;
 S I(2)=0
 F  S I(2)=$O(^LRO(69,LRODT,1,LRSN,2,I,1,I(2))) Q:I(2)<1  I $D(^(I(2),0)) W !?5,^(0) D CHKPAGE Q:$G(LRSTOP)
 Q
 ;
 ;
REF ; If referred test, display status and manifest
 N LREVNT,LRSCFG,LRUID
 ;
 S LRUID=$P($G(^LRO(69,LRODT,1,LRSN,2,I,.3)),"^")
 I LRUID="" Q
 ;
 W "  <"_LRUID_">"
 ;
 S LREVNT=$$STATUS^LREVENT(LRUID,+X,""),LRSCFG=""
 I LREVNT="" Q
 I $P(LREVNT,"^",3)'="" D
 . N LR628
 . S LR628=$O(^LAHM(62.8,"B",$P(LREVNT,"^",3),0))
 . S LRSCFG=$P($G(^LAHM(62.8,LR628,0)),"^",2)
 . I LRSCFG S LRSCFG(0)=$P($G(^LAHM(62.9,LRSCFG,0),"Unknown/deleted"),"^")
 W !,?4,"REFERRAL STATUS: "_$P(LREVNT,"^")_" ("_$P(LREVNT,"^",2)_")"
 W !,?4,"SHIPPING MANIFEST: "_$P(LREVNT,"^",3)
 I LRSCFG W " using shipping config "_LRSCFG(0)
 ;
 Q
 ;
 ;
END ;
 K %,%DT,A,DFN,DIC,DIR,DIRUT,DTOUT,DUOUT,I,II,K,L,LRARIV,LRCLCTR,LRCLST
 K LRCTYP,LRDRWTM,LRFLAG1,LRFLG,LRLOC,LRMD,LRODT,LROR,LRORD
 K LRPRAC,LRSN,LRSN1,LRSTOP,LRURG,LRW,LRWHOE,LRWRD,VA("BID"),VA("PID")
 K VAIN,VADM,VAERR,X,X1,X2,Y,Z
 Q:$G(LR2ORD)
 K LRNOP,LRNOPMSG
 Q
