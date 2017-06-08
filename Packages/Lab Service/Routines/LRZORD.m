LRZORD ;DALOI/CJS,NTEO/JFR - LAZY ACCESSION LOGGING ;12/6/06 13:14; [12/27/09 5:21pm]
 ;;5.2;LAB SERVICE;**100,121,153,286**;Sep 27, 1994
 ;;
VEHU ; Entry point for jamming in labs
 ; get test (one only for now)
 ; show test range
 ; ask for result range
 ; get collection date/time
 ; get patient list
 ; rock & roll
 K ^TMP("LRZSTIK",$J),^TMP("LRVEHU",$J)
 N LRZPT,LRVEHU,LRZONE,DIR,Y,DUOUT,DTOUT,DIRUT
 N LRBLOOD,LRDT0,LRLABKY,LRPARAM,LRPLASMA,LRSERUM,LRODT0,LRSND
 N LRUNKNOW,LRURINE,LRVIDO,LRVIDOF,LRAL,LRALL,LRCMTDSP,LRFLG,LRNGS
 D ^LRPARAM I $G(LREND) D KILL Q
 D GET I '$D(^TMP("LRZSTIK",$J)) W !,"No test selected, you lose!" Q
 S ^TMP("LRVEHU",$J,"RNG")=$$RNG
 I '$L(^TMP("LRVEHU",$J,"RNG")) W !,"No result entered, can't continue" D KILL Q
 S ^TMP("LRVEHU",$J,"I")=$P(^VA(200,+DUZ,0),U,2)
 S ^TMP("LRVEHU",$J,"COLL")=$$COLLDT
 I '$L(^TMP("LRVEHU",$J,"COLL")) W !,"No collection date/time entered, gotta go!" D KILL Q
 S LRVEHU=1
 D PT
 I '$D(^TMP("LRVEHU",$J,"PT")) W !,"No patients selected!",!,"Outta Here!" D KILL Q
 W !
 S DIR(0)="YA",DIR("A")="Are you ready to proceed? "
 D ^DIR
 I $D(DTOUT)!($D(DUOUT))!('$G(Y)) W !!,"OK! No data entered." H 1 D KILL Q
 S LRZPT=0
 ;Q  ; JFR QUIT TO TEST ALL DATA COLLECTION
 F  S LRZPT=$O(^TMP("LRVEHU",$J,"PT",LRZPT)) Q:'LRZPT  D
 . S LRWP=1
 . M ^TMP("LRSTIK",$J)=^TMP("LRZSTIK",$J)
 . D ^LRPARAM
 . D EN
 . S ^TMP("LRVEHU",$J,"R")=$$RAND($P(^TMP("LRVEHU",$J,"RNG"),U,1),$P(^TMP("LRVEHU",$J,"RNG"),U,2))
 . D STAT^LRZOE
 . K ^TMP("LRVEHU",$J,LRZORD),LRZORD,LRZONE
 . D ^LRORDK
 . W !,$$CJ^XLFSTR("************************************************",80),!
 . Q
 D KILL
 K LRVEHU
 Q
 ;
EN ;;from LROR4
 K DIC,LRURG,LRSAME,LRCOM,LRNATURE,LRTCOM
 S LRORDR="WC"
 S LRORDTIM=""
 I $D(LRADDTST) Q:LRADDTST=""
 S LRFIRST=1,LRODT=DT,U="^",LRECT=0,LROUTINE=$P(^LAB(69.9,1,3),U,2)
 S:$G(LRORDRR)="R" LRECT=1,LRFIRST=0
 I LRORDR="SP" S LRLWC="SP"
 I LRORDR="WC" S LRLWC="WC"
L5 S Y=$$NOW^XLFDT S LRORDTIM=$P(Y,".",2),LRODT=$P(Y,".",1),X1=Y,X2=DT D ^%DTC ;;  JFR  def order time
 G KILL:LRWP<1
 S:'$D(^LRO(69,LRODT,0)) ^(0)=$P(^LRO(69,0),U,1,2)_U_LRODT_U_(1+$P(^(0),U,4)),^LRO(69,LRODT,0)=LRODT,^LRO(69,"B",LRODT,LRODT)=""
 S LRURG="",LRAD=DT,LRWPD=LRWP\2+(LRWP#2) D ^LRZORD1
 Q
G0 ;
G1 ;
GET ;
 N DIC,X,Y,DUOUT,DTOUT
 S LRORDR="WC"
 S DIC("S")="I $P(^(0),U,4)=""CH"""_$S('$D(LRLABKY):",""NO""'[$P(^(0),U,3)",'$P(LRLABKY,U,3):",""N""'[$P(^(0),U,3)",1:"")
 S DIC="^LAB(60,",DIC(0)="AEMOQZ"
 D ^DIC I Y<1 Q
 S LRWP=1,LRY=Y
 S ^TMP("LRZSTIK",$J,LRWP)=$P(LRY,U,1,2)
 ; "B" Used to lookup by number user enters.
 S ^TMP("LRZSTIK",$J,"B",LRWP)=LRWP
 ; "C" Used by LEDI (LRORDB)
 S ^TMP("LRZSTIK",$J,"C",+LRY,LRWP)=""
 S LRTSTS=+^TMP("LRZSTIK",$J,LRWP) D SAMP
 S:+LRSAMP=-1&(LRSPEC=-1) LRWP=LRWP-1
 G GET:+LRSAMP=-1&(LRSPEC=-1)
 S ^TMP("LRZSTIK",$J,LRWP)=^TMP("LRZSTIK",$J,LRWP)_U_LRSAMP_U_U_LRSPEC
 W !!
 W !,"Reference Ranges for this test and Specimen:",!
 N LRZSP S LRZSP=$O(^LAB(60,+LRY,1,"B",LRSPEC,0)),LRZSP=$G(^LAB(60,+LRY,1,LRZSP,0))
 W !,"Reference Low: ",$P(LRZSP,U,2)
 W !,"Reference High: ",$P(LRZSP,U,3)
 W !,"Critical Low: ",$P(LRZSP,U,4)
 W !,"Critical High: ",$P(LRZSP,U,5),!!
 Q
 ;
RNG() ;
 N LRZRES
 N DIR,X,Y,DUOUT,DTOUT
 W !,"If you want the same value for all patients, enter it for both high and low",!
 S DIR(0)="N^::2",DIR("A")="Enter the low result to enter for this test"
 D ^DIR I $D(DTOUT)!($D(DUOUT)) K ^TMP("LRSTIK",$J) Q ""
 S LRZRES=Y
 S DIR(0)="NA^"_LRZRES_"::2"
 S DIR("A")="Enter the high result for this test: " D ^DIR
 I $D(DTOUT)!($D(DUOUT)) K ^TMP("LRSTIK",$J) Q ""
 S LRZRES=LRZRES_U_Y
 Q LRZRES
 ;
KILL D ^LRORDK,LROEND^LRORDK K ^TMP("LRVEHU",$J),^TMP("LRSTIK",$J) D HOME^%ZIS Q
% R %:DTIME Q:%=""!(%["N")!(%["Y")!($E(%)="^")  W !,"Answer 'Y' or 'N': " G %
 Q
 ;
RAND(LOW,HIGH) ; GET RANGE
 N DIFF,NEWVAL,LOWDEC,HIGHDEC,NEWDEC,LDEC
 S DIFF=HIGH-LOW
 I DIFF=0 Q LOW
 I DIFF<1 S DIFF=1
 S NEWVAL=LOW+$R(DIFF)
 S LOWDEC=$P(LOW,".",2)
 S HIGHDEC=$P(HIGH,".",2)
 I 'HIGHDEC,'LOWDEC Q NEWVAL
 S LDEC=$S($L(LOWDEC)=2:2,$L(HIGHDEC)=2:2,1:1)
 I LDEC=2 S NEWDEC=$R(100)
 I LDEC=1 S NEWDEC=$R(10)
 S NEWVAL=NEWVAL+("."_NEWDEC)
 S $P(NEWVAL,".",2)=$E(+$P(NEWVAL,".",2),1,LDEC)
 I NEWVAL>HIGH S NEWVAL=HIGH
 Q NEWVAL
 ;
PT N PTARR
 W !!,"Select patients to enter the selected lab result for. Select numbers between"
 W !,"0 and 950 with the number corresponding to the VeHU patient that you want to"
 W !,"update.  For example, choosing number 12 will update VeHU patient twelve",!!
 S DIR("A")="Select patient(s) to be updated"
 S DIR(0)="LO^0:950" D ^DIR K DIR Q:Y=""!($D(DUOUT))!($D(DTOUT))
 D PARSE(Y,.PTARR) S J=0 F  S J=$O(Y(J)) Q:'+J  D PARSE(Y(J),.PTARR)
 M ^TMP("LRVEHU",$J,"PT")=PTARR
 Q
 ;
PARSE(ARRAY,LIST) ;
 N NUM,R,LNUM,L4,SSN
 S NUM=$L(ARRAY,",")-1
 F R=1:1:NUM S LNUM=$P(ARRAY,",",R) S L4=$S(LNUM=0:"0000",1:$E("000",1,(4-$L(LNUM)))_LNUM) D
 .S SSN="66600"_L4
 .I $D(^DPT("SSN",SSN)) S LIST($O(^DPT("SSN",SSN,0)))=""
 Q
 ;
COLLDT() ; get d/t to stuff in for collection date@time
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT
 W !
 S DIR(0)="D^:NOW:ETR",DIR("A")="Enter the date/time of collection for all results"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q ""
 Q Y(0)
 ;
SAMP ; copy of GS^LRORD3
 N X,Y,DIC,DTOUT,DUOUT,J
 S LRSAMP=-1,LRSPEC=-1 S:$D(LRSAME) LRSAMP=$P(LRSAME,U),LRSPEC=$P(LRSAME,U,2)
 K %
 S J=$O(^LAB(60,LRTSTS,3,0)) G GSNO:J<1 S LRCSN=1,LRUNQ=+$P(^LAB(60,LRTSTS,0),U,8),LRCS(1)=+^(3,J,0) S X=$P(^LAB(62,LRCS(1),0),U) W:'$D(LRSAME) !,$S(LRUNQ:"The Sample ",1:""),"Is ",X,"   ",$P(^(0),U,3)
 G G2S:LRUNQ Q:$D(LRSAME)  W " the correct sample to collect? Y//" D % G G2S:%'["N"
 F  S J=$O(^LAB(60,LRTSTS,3,J)) Q:J<1  S LRCSN=LRCSN+1,LRCS(LRCSN)=+^(J,0)
 G GSNO:LRCSN<2
 W ! F I=1:1:LRCSN W !,I," ",$P(^LAB(62,LRCS(I),0),U),"  ",$P(^(0),U,3)
 R !,"Choose one: ",X:DTIME IF X>0&(X<(LRCSN+1)) S LRCSN=+X G G2S
GSNO ;
 Q:$D(LRSAME)  S LRCSN=1,LRCS(1)=-1,DIC="^LAB(62,",DIC(0)="AEMOQ" D ^DIC K DIC S LRCS(1)=+Y
G2S S LRSAMP=LRCS(LRCSN) I LRSAMP<1 S Y=-1,LROT="" G G3S
 I $P(^LAB(62,LRSAMP,0),U,2)'="" S LRSPEC=+$P(^(0),U,2) G G4S
W18A S DIC="^LAB(61,",DIC(0)="EMOQ",D="E" R !,"Select SITE/SPECIMEN: ",X:DTIME
 D IX^DIC:X="?" G W18A:X="?" D ^DIC K DIC G W18A:'($D(DUOUT)!$D(DTOUT))&(Y<0) I $D(DTOUT)!$D(DUOUT) S LREND=1 Q
 I LRUNKNOW=+Y W !,"Unknown is not allowed." G W18A
G3S S LRSPEC=+Y
 I +LRSAMP=-1&(LRSPEC=-1),$D(LROT) W !,"Sample and source incompletely defined, test skipped." Q
G4S Q:+LRSAMP=-1&(LRSPEC=-1)!$D(LRSAME)!$D(LRBLEND)
 Q
