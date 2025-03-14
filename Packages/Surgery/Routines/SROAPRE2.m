SROAPRE2 ;BIR/MAM - EDIT PAGE 2 PREOP ;07/18/2011
 ;;3.0;Surgery;**38,47,125,153,166,176,182,184,193**;24 Jun 93;Build 2
 D @EMILY Q
1 ; edit renal information
 W ! K DIR S X=$P(SRAO(1),"^") I X'="" S DIR("B")=X
 S DIR(0)="130,243",DIR("A")="RENAL" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S SRCAT="Renal" D SURE Q:SRSOUT  G:'SRYN 1 S $P(^SRF(SRTN,200),"^",37)="" S (SRAX,X)="" D NOREN Q
 S SRAX=Y,$P(^SRF(SRTN,200),"^",37)=SRAX I Y["N" D NOREN Q
 I Y["Y" D REN
 Q
2 ; edit CNS information
 W ! K DIR S X=$P(SRAO(2),"^") I X'="" S DIR("B")=X
 S DIR(0)="130,210",DIR("A")="CENTRAL NERVOUS SYSTEM" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S SRCAT="Central Nervous System" D SURE Q:SRSOUT  G:'SRYN 2 S $P(^SRF(SRTN,200),"^",18)="",(SRAX,X)="" D NOCNS Q
 S SRAX=Y,$P(^SRF(SRTN,200),"^",18)=SRAX I Y["N" D NOCNS Q
 I Y["Y" D CNS
 Q
3 ; edit nutritional/immune/other info
 W ! K DIR S X=$P(SRAO(3),"^") I X'="" S DIR("B")=X
 S DIR(0)="130,245",DIR("A")="NUTRITIONAL/IMMUNE/OTHER" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S SRCAT="Nutritional/Immune/Other" D SURE Q:SRSOUT  G:'SRYN 3 S $P(^SRF(SRTN,200),"^",44)="" S (SRAX,X)="" D NONUT Q
 S SRAX=Y,$P(^SRF(SRTN,200),"^",44)=SRAX I Y["N" D NONUT Q
 I Y["Y" D NUT
 Q
REN ; renal
 W ! K DR,DIE S DA=SRTN,DIE=130,DR="328T;211T" D ^DIE K DR
 S SRACLR=0
 Q
NOREN ; no renal problems
 F I=38,39 S $P(^SRF(SRTN,200),"^",I)=SRAX
 Q
CNS ; cns
 W ! K DR,DIE S DIE=130,DA=SRTN,DR="332T;333T;400T;521T;522T;401T;662T;" D ^DIE K DR,DIE
 S SRACLR=0
 Q
NOCNS ; no CNS problems
 F I=19,21,24,29 S $P(^SRF(SRTN,200),"^",I)=SRAX
 F I=13,14 S $P(^SRF(SRTN,200.1),"^",I)=$S(SRAX="N":0,SRAX="NS":0,1:SRAX) ;p193 added condition SRAX="NS" to $SELECT statement.
 S $P(^SRF(SRTN,210),"^")=0
 Q
NUT ; nutritional/immune/other
 W ! K DR,DIE S DIE=130,DA=SRTN,DR="338T;218T;339T;215T;216T;642T;217T;338.3T;338.2T;218.1T;269T;673T;674T;677T" D ^DIE K DA,DIE,DR
 S SRACLR=0
 Q
NONUT ; no nutritional/immune/other
 F I=45:1:50 S $P(^SRF(SRTN,200),"^",I)=SRAX
 F I=3,4,8 S $P(^SRF(SRTN,206),"^",I)=SRAX
 I SRAX="N" S $P(^SRF(SRTN,200.1),"^",3)=$S($P($G(VADM(5)),"^")="M":"NA",1:"NO"),$P(^SRF(SRTN,200),"^",58)="N"
 S:SRAX="" $P(^SRF(SRTN,200.1),"^",3)=""
 F I=8,9 S $P(^SRF(SRTN,210),"^",I)="N"
 S $P(^SRF(SRTN,210),"^",12)=0,$P(^SRF(SRTN,204),"^",17)=1
 Q
RET W !! K DIR S DIR(0)="E" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
SURE W ! K DIR S DIR("A")="   Sure you want to delete all "_SRCAT_" information ? ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR S SRYN=Y I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
DEL W !!,?10,"Deleting all "_SRCAT_" information...  "
 Q
NO2ALL ; set all fields to NO
 S SRAX="N",$P(^SRF(SRTN,200),"^",37)=SRAX D NOREN
 S $P(^SRF(SRTN,200),"^",18)=SRAX D NOCNS
 S $P(^SRF(SRTN,200),"^",44)=SRAX D NONUT
 Q
