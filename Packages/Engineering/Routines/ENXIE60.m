ENXIE60 ;;WCIOFO/DH- Environmental Check Routine ;2.17.99
 ;;7.0;ENGINEERING;**60**;Aug 17, 1993
EN ;  find deleted cmrs that are still pointed to by equipment records
 ;  uses ^tmp($j,"fap0",equipment) for expensed
 ;  ^tmp($j,"fap1",oldcmr,equipment) for capitalized
 K ^TMP($J)
 N DA,DIC,DIE,DR,COUNT,ESCAPE,ERROR,CMR,OLDCMR
 F I="FAP0","FAP1" S COUNT(I)=0
 S DA=0 F  S DA=$O(^ENG(6914,"AD",DA)) Q:'DA  I '$D(^ENG(6914.1,DA,0)) S DA(1)=0 D
 . F  S DA(1)=$O(^ENG(6914,"AD",DA,DA(1))) Q:'DA(1)  D
 .. I $$CHKFA^ENFAUTL(DA(1)) S COUNT("FAP1")=COUNT("FAP1")+1,^TMP($J,"FAP1",DA,DA(1))=""
 .. E  S COUNT("FAP0")=COUNT("FAP0")+1,^TMP($J,"FAP0",DA(1))=""
 G:'$D(^TMP($J)) EXIT
 I COUNT("FAP0") D
 . W !!,"There "_$S(COUNT("FAP0")=1:"is ",1:"are ")_COUNT("FAP0")_" equipment record" W:COUNT("FAP0")>1 "s"
 . W " that "_$S(COUNT("FAP0")=1:"is",1:"are") W " not capitalized and ha"_$S(COUNT("FAP0")=1:"s a pointer to",1:"ve pointers to") W !,$S(COUNT("FAP0")=1:"a CMR that has",1:"CMRs that have")
 . W " been deleted. Please hold on while we delete "_$S(COUNT("FAP0")=1:"this",1:"these")_" dangling",!,"pointer" W:COUNT("FAP0")>1 "s"
 . S DIE="^ENG(6914,",DR="19///@"
 . S DA=0 F  S DA=$O(^TMP($J,"FAP0",DA)) Q:'DA  W "." D ^DIE
 G:'COUNT("FAP1") EXIT
 W !!,$S(COUNT("FAP1")=1:"There is ",1:"There are ")_COUNT("FAP1")_" equipment record"
 I COUNT("FAP1")=1 W " that is capitalized and has a pointer to a"
 E  W "s that are capitalized and have pointers to"
 W !,"CMR" W:COUNT("FAP1")>1 "s" W $S(COUNT("FAP1")=1:" that has been deleted. This problem",1:" that have been deleted. These problems")_" must be corrected."
 S (DA,COUNT)=0 F  S DA=$O(^TMP($J,"FAP1",DA)) Q:'DA  S COUNT=COUNT+1 S DA(1)=$O(^TMP($J,"FAP1",DA,0)) I DA(1) D
 . S ENDA("FA")=$P($$CHKFA^ENFAUTL(DA(1)),U,4),OLDCMR("EIL",DA)=$$EIL(DA(1)),COUNT(DA)=1 F  S DA(1)=$O(^TMP($J,"FAP1",DA,DA(1))) Q:'DA(1)  S COUNT(DA)=COUNT(DA)+1
 I COUNT=1 W !!,"Only one old CMR is involved."
 E  W !!,COUNT_" old CMRs are involved."
 W " Would you like a list of the affected equipment?"
 K DIR S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) G ABORT
 I Y D  I POP G ABORT
 . K IO("Q") S %ZIS="Q" D ^%ZIS Q:POP
 . I $D(IO("Q")) D  Q
 .. S ZTRTN="PRNT^ENXIE60",ZTDESC="DELETED CMR REPORT",ZTIO=ION
 .. S ZTSAVE("OLDCMR(""EIL"",")=""
 .. S ZTSAVE("^TMP($J,")=""
 .. D ^%ZTLOAD,HOME^%ZIS K ZTSK
 . D PRNT
 W !!,"You may either correct these problematic equipment records now, or '^' out",!,"and re-install EN*7*60 at some future time."
 W !,"It will not be possible to complete the installation until the necessary",!,"corrections have been made."
 W !!,"Would you like to make the corrections now?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) G ABORT
 I 'Y G ABORT
SINGLE I COUNT=1 D  G:$G(ERROR) ERR G:$G(ESCAPE) ABORT G EXIT
 . S OLDCMR=$O(^TMP($J,"FAP1",0)) I 'OLDCMR S ERROR=1 Q
 . S DA=$O(^TMP($J,"FAP1",OLDCMR,0)) I 'DA S ERROR=1 Q
 . S ENDA("FA")=$P($$CHKFA^ENFAUTL(DA),U,4) I 'ENDA("FA") S ERROR=1 Q
 . S OLDCMR(0)=$$EIL(DA)
 . I COUNT("FAP1")=1,OLDCMR(0)]"" W !!,"The affected equipment record was assigned to a CMR that began with '"_OLDCMR(0)_"'."
 . E  W !!,"All of the affected equipment records were assigned to the same CMR, the first",!,"two characters of which" D
 .. I OLDCMR(0)]"" W " were '"_OLDCMR(0)_"'."
 .. E  W " are unknown."
 . I COUNT("FAP1")>1 W !,"Shall all of the "_COUNT("FAP1")_" equipment records be assigned to the same CMR",!,"at this time?" D  Q:$G(ESCAPE)
 .. S DIR(0)="Y",DIR("B")="YES"
 .. D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 .. I Y W !,"We can do that."
 . S:COUNT("FAP1")=1 Y=1
 . I Y D  Q
 .. S DIC="^ENG(6914.1,",DIC(0)="AEQM"
 .. D ^DIC I Y'>0 S ESCAPE=1 Q
 .. S CMR=+Y,CMR("PRNT")=$P(Y,U,2)_"  "_$$GET1^DIQ(6914.1,CMR,.5)
 .. W !!,"We're about to assign "_COUNT("FAP1")_" equipment record(s) to CMR: ",!?5,CMR("PRNT")
 .. S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you sure"
 .. D ^DIR K DIR I $D(DIRUT)!('Y) S ESCAPE=1 Q
 .. S $P(^ENG(6914,DA,2),U,9)=CMR,^ENG(6914,"AD",CMR,DA)="" D SRVC ;  must do hard set because input x-form would trap
 .. F  S DA=$O(^TMP($J,"FAP1",OLDCMR,DA)) Q:'DA  W:'(DA#5) "." S $P(^ENG(6914,DA,2),U,9)=CMR,^ENG(6914,"AD",CMR,DA)="" D SRVC
 .. K ^ENG(6914,"AD",OLDCMR),^TMP($J,"FAP1",OLDCMR)
 . W !!,"Then we'll have to edit the equipment records individually."
 . S DIC="^ENG(6914.1,",DIC(0)="AEQM"
 . F  Q:'DA  W !!,"Equip ID: "_DA_"  "_$E($P(^ENG(6914,DA,0),U,2),1,30) D ^DIC S:$E(X)="^" ESCAPE=1 Q:$G(ESCAPE)  D:Y>0  S DA=$O(^TMP($J,"FAP1",OLDCMR,DA))
 .. S CMR=+Y,$P(^ENG(6914,DA,2),U,9)=CMR,^ENG(6914,"AD",CMR,DA)="" D SRVC
 .. K ^ENG(6914,"AD",OLDCMR,DA),^TMP($J,"FAP1",OLDCMR,DA)
 . S:$D(^TMP($J,"FAP1")) ESCAPE=1
MULT ; more than one old cmr
 S OLDCMR=0 F  S OLDCMR=$O(^TMP($J,"FAP1",OLDCMR)) Q:'OLDCMR  D  Q:$G(ESCAPE)!($G(ERROR))
 . S DA=$O(^TMP($J,"FAP1",OLDCMR,0)) I 'DA S ERROR=1 Q
 . S ENDA("FA")=$P($$CHKFA^ENFAUTL(DA),U,4) I 'ENDA("FA") S ERROR=1 Q
 . S OLDCMR(0)=$$EIL(DA)
 . W !!,COUNT(OLDCMR)_" of the affected equipment records were assigned to a CMR whose INTERNAL",!,"ENTRY NUMBER was "_OLDCMR_". The first two characters "
 . I OLDCMR(0)]"" W "were '"_OLDCMR(0)_"'."
 . E  W "are unknown."
 . I COUNT(OLDCMR)>1 W !!,"Shall all of these "_COUNT(OLDCMR)_" equipment records be assigned to the same CMR",!,"at this time?" D  Q:$G(ESCAPE)
 .. S DIR(0)="Y",DIR("B")="YES"
 .. D ^DIR K DIR I $D(DIRUT) S ESCAPE=1
 . S:COUNT(OLDCMR)=1 Y=1
 . I Y D  Q
 .. S DIC="^ENG(6914.1,",DIC(0)="AEQM"
 .. D ^DIC I Y'>0 S ESCAPE=1 Q
 .. S CMR=+Y,CMR("PRNT")=$P(Y,U,2)_"  "_$$GET1^DIQ(6914.1,CMR,.5)
 .. W !!,"We're about to assign "_COUNT(OLDCMR)_" equipment record(s) to CMR: ",!?5,CMR("PRNT")
 .. S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you sure"
 .. D ^DIR K DIR I $D(DIRUT)!('Y) S ESCAPE=1 Q
 .. S $P(^ENG(6914,DA,2),U,9)=CMR,^ENG(6914,"AD",CMR,DA)="" D SRVC ;  must do hard set because input x-form would trap
 .. F  S DA=$O(^TMP($J,"FAP1",OLDCMR,DA)) Q:'DA  W:'(DA#5) "." S $P(^ENG(6914,DA,2),U,9)=CMR,^ENG(6914,"AD",CMR,DA)="" D SRVC
 .. K ^ENG(6914,"AD",OLDCMR),^TMP($J,"FAP1",OLDCMR)
 . W !!,"Then we'll have to edit the equipment records individually."
 . S DIC="^ENG(6914.1,",DIC(0)="AEQM"
 . F  Q:'DA  W !!,"Equip ID: "_DA_"  "_$E($P(^ENG(6914,DA,0),U,2),1,30) D ^DIC S:$E(X)="^" ESCAPE=1 Q:$G(ESCAPE)  D:Y>0  S DA=$O(^TMP($J,"FAP1",OLDCMR,DA))
 .. S CMR=+Y,$P(^ENG(6914,DA,2),U,9)=CMR,^ENG(6914,"AD",CMR,DA)="" D SRVC
 .. K ^ENG(6914,"AD",OLDCMR,DA),^TMP($J,"FAP1",OLDCMR,DA)
 G:$G(ERROR) ERR G:$G(ESCAPE)!($D(^TMP($J,"FAP1"))) ABORT G EXIT
 ;
PRNT ; produce report
 N DA,PAGE,DATE,EQPT
 D NOW^%DTC S Y=% X ^DD("DD") S DATE=$P(Y,":",1,2),(PAGE,CMR,EQPT)=0
 U IO W:$E(IOST,1,2)="C-" @IOF
 F  S CMR=$O(^TMP($J,"FAP1",CMR)) Q:'CMR!($G(ESCAPE))  D HEADR D  Q:$G(ESCAPE)  D HOLD Q:$G(ESCAPE)
 . F  S EQPT=$O(^TMP($J,"FAP1",CMR,EQPT)) Q:'EQPT  D  Q:$G(ESCAPE)
 .. W !,?5,EQPT,?20,$E($P($G(^ENG(6914,EQPT,0)),U,2),1,50)
 .. I (IOSL-$Y)'>2 D HOLD Q:$G(ESCAPE)  D HEADR
 D ^%ZISC
 Q
 ;
HEADR ; report header
 W:PAGE>0 @IOF S PAGE=PAGE+1
 W "Equipment with Deleted CMR     Printed: "_DATE,?70,"Page "_PAGE
 W !,"Old EIL: "_$G(OLDCMR("EIL",CMR))
 K X S $P(X,"-",79)="-" W !,X,!
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
 ;
SRVC ; populate service pointer where appropriate
 ; DA => equipment file
 ; CMR => cmr
 N SRVC
 Q:$P($G(^ENG(6914,DA,3)),U,2)]""
 S SRVC=$P(^ENG(6914.1,CMR,0),U,5) Q:SRVC=""  Q:'$D(^DIC(49,SRVC,0))
 S $P(^ENG(6914,DA,3),U,2)=SRVC,^ENG(6914,"AC",SRVC,DA)=""
 Q
 ;
EIL(DA) ; make best guess as to original eil
 ; expects enda("fa")
 I '$D(^ENG(6915.6,"B",DA)) Q $P($G(^ENG(6915.2,ENDA("FA"),3)),U,8)
 S ENDA("FR")=$O(^ENG(6915.6,"B",DA,9999999),-1)
 I ENDA("FR"),$P(^ENG(6915.6,ENDA("FR"),0),U,2)>$P(^ENG(6915.2,ENDA("FA"),0),U,2) Q $P($G(^ENG(6915.6,ENDA("FR"),3)),U,14)
 Q $P($G(^ENG(6915.2,ENDA("FA"),3)),U,8)
 ;
ERR W !,"Your data base appears to be corrupted."
ABORT I $G(XPDENV)=0 W !,"Patch EN*7*60 has been loaded, but is uninstallable."
 E  W !,"Patch EN*7*60 remains uninstallable."
 S XPDQUIT=2
EXIT K ENDA
 K ^TMP($J)
 ;ENXIE60
