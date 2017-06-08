ANQCLO1 ;MUSKOGEE VAMC/GLD, B'ham ISC/DMA - CLOZARIL RX LOCKOUT ROUTINE ; 15 Sep 92 / 11:07 AM
 ;;1.01;;**18,34,41,54**
 ; Changes added 1 July 91 to get data for transmission to Sandoz data base
 ;
 I '$D(^DIC(59,PSOSITE,"SAND")) W !!,"This site is not registered for clozapine dispensing.",!! R X:10 K X S ANQX=1 Q
 I '$D(^PS(55,DFN,"SAND")) W !!,"This patient has not been registered in the clozapine program.",!! R X:10 S ANQX=1 Q
 I $P(^PS(55,DFN,"SAND"),"^")="" W !!,"This patient has no clozapine registration number.",!! R X:10 S ANQX=1 Q
 I $P(^PS(55,DFN,"SAND"),"^",2)="D" W !!,"This patient has been discontinued from the clozapine treatment program.",!,"   and must have a new registration number assigned",!! R X:10 K X S ANQX=1 Q
PTCHK I '$D(^DPT(DFN,"LR")) W !,"*** NO WBC VALUE ON FILE CANNOT FILL***" S ANQX=1,ANQRE=1 G CLEAN
SETUP K ANQNO S ANQTST=$P(^PSDRUG(P(5),623002),"^",1),ANQDAYS=7 ; changed to 7 days because of new Sandoz requirements
 S LRDFN=$P(^DPT(DFN,"LR"),"^",1),ANQTSTN=$P(^LAB(60,ANQTST,0),"^",1),ANQLDN=^LAB(60,ANQTST,.2),ANQTSTSP=$P(^PSDRUG(P(5),623002),"^",3)
EDATE S %DT="",X="T-"_ANQDAYS D ^%DT S ANQEDATE=Y X ^DD("DD") S ANQEDTR=Y S X="T-"_21 D ^%DT S ANQ21=9999999-Y
 S ANQEDL=9999999-ANQEDATE,ANQINDIC=0,ANQB=0,ANQV="",ANQRE=1
LOOP1 F ANQJ1=0:0 S ANQB=$O(^LR(LRDFN,"CH",ANQB)) Q:ANQB=""  Q:ANQB>ANQEDL  D CHECK Q:ANQINDIC  Q:$D(ANQNO)
 I $D(ANQNO) G CLEAN
 I ANQINDIC=0 W !,"*** NO ",ANQV,"RESULTS FOR ",ANQTSTN," IN PAST ",ANQDAYS," DAYS CANNOT FILL ***",! S ANQX=1 G CLEAN
 G CLEAN:ANQINDIC>1
SERIES ;Check for three in a row
 F ANQJ=2:0 S ANQB=$O(^LR(LRDFN,"CH",ANQB)) Q:'ANQB  Q:ANQB>ANQ21  Q:'$D(^(ANQB,ANQLDN))  S X=$P(^(ANQLDN),"^") I +X,$P(^(0),"^",5)=ANQTSTSP,$P(^(0),"^",3) S ANQ(ANQJ)=X,ANQD(ANQJ)=ANQB Q:ANQ(ANQJ-1)'<ANQ(ANQJ)  S ANQJ=ANQJ+1 Q:ANQJ>3
 I $D(ANQ(3)),ANQ(3)>ANQ(2),ANQ(2)>ANQ(1) S ANQX=1 G THREENO
 G CLEAN
CHECK S ANQV="" I '$D(^LR(LRDFN,"CH",ANQB,ANQLDN)) S ANQRE=1 Q
 I $P(^LR(LRDFN,"CH",ANQB,0),"^",5)'=ANQTSTSP S ANQRE=1 Q
 I '$P(^LR(LRDFN,"CH",ANQB,0),"^",3) S ANQV="VERIFIED ",ANQRE=2 Q
 I '$P(^LR(LRDFN,"CH",ANQB,ANQLDN),"^") Q
 W !,"*** MOST RECENT ",ANQTSTN," PERFORMED ON "
 S Y=$P(^LR(LRDFN,"CH",ANQB,0),"^",1) X ^DD("DD") W $P(Y,"@")
 W !,?5,"RESULTS: ",$P(^LR(LRDFN,"CH",ANQB,ANQLDN),"^")*1000
VALCK S ANQ(1)=$P(^LR(LRDFN,"CH",ANQB,ANQLDN),"^",1),ANQD(1)=ANQB,PSOLR=ANQ(1),PSOLDT=$P(9999999-ANQB,".")
 I ANQ(1)<2 W !,"*** WBC COUNT LESS THAN 2000 RX CANNOT BE FILLED ***",!,"NO OVERRIDE PERMITTED",! S ANQX=1,ANQNO=1 Q
 I ANQ(1)<3.5 W !,"*** WBC COUNT LESS THAN 3500 RX CANNOT BE FILLED ***",! S ANQX=1,ANQRE=3
 S ANQINDIC=ANQ(1)'<5+1
 Q
CLEAN K ANQINDIC,ANQTST,ANQDAYS,ANQTSTN,ANQLDN,ANQEDL,ANQB,ANQEDATE,ANQEDTR,ANQTSTSP,ANQJ1,LRDFN,ANQV,ANQ,ANQD,ANQJ,ANQDT,ANQ21
 I 'ANQX G DOSAGE
 I '$D(^XUSEC("PSOLOCKCLOZ",DUZ))!($D(ANQNO)) G EXIT
OVRD R !!,"Do you wish to override and issue this prescription ? N// ",X:DTIME S:'$T X="^" S:X="" X="N" G EXIT:"^Nn"[X I "Yy"'[X W !,"Please answer yes or no " G OVRD
DOC S DIC=3,DIC(0)="AEQM",DIC("A")="Approving member of the Clozapine team : ",DIC("S")="I $D(^XUSEC(""PSOLOCKCLOZ"",+Y)),+Y'=DUZ" D ^DIC K DIC S ANQD=+Y I Y<0,$P(PSOPAR,"^",9) W !,"No prescription entered" G EXIT
COM S DIR(0)="52.52,5",DIR("A")="Remarks " D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) I $P(PSOPAR,"^",9) W !,"No prescription entered" G EXIT
 S ANQX=0,ANQDATA=DUZ_"^"_ANQD_"^"_ANQRE_"^"_X
 ;
DOSAGE ; set variable to ask daily dose in PSONEW1
 S PSOCLOZ=""
EXIT K X,Y,%,%DT,ANQD,ANQRE,ANQNO,ANQT,DTOUT,DUOUT Q
THREENO ;Fails 3 in a row decreasing
 W !,"*** LAST THREE WBC TESTS WERE:",! F ANQJ=3,2,1 S ANQDT=9999999-ANQD(ANQJ)_"0000" W ?5,$E(ANQDT,4,5),"/",$E(ANQDT,6,7),"/",$E(ANQDT,2,3) W:ANQDT["." "@",$E(ANQDT,9,10),":",$E(ANQDT,11,12) W ?29,"RESULTS : ",ANQ(ANQJ)*1000,!
 W "PRESCRIPTION CANNOT BE FILLED",! S ANQRE=4 G CLEAN
