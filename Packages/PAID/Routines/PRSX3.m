PRSX3 ; HISC/REL/FPT-Match Names ;10/19/93  10:40
 ;;3.1;PAID;;Feb 25, 1994
 ;
 ; BN       = LOOP VALUE FOR B X-REF (#450)
 ; C0       = EMPLOYEE COUNT (#450)
 ; C1       = FILE 200 &450 MATCH COUNT
 ; DFN200   = INTERNAL NUMBER (#200)
 ; DFN450   = INTERNAL NUMBER (#450)
 ; ID       = ARRAY OF FILE 200 MATCHES CONTAINING DFN VALUES
 ; L        = NUMBER OF FILE 200 MATCHES TO CHOOSE FROM
 ; NAME     = NAME VALUE FOR B X-REF (#200)
 ; NAME450  = PAID EMPLOYEE NAME (#450)
 ; NODE     = ZERO NODE OF FILE 450 ENTRY
 ; NX       = NAME TO SEARCH FOR IN B-XREF OF FILE 200
 ; SSN      = SOCIAL SECURITY NUMBER
 ; YN       = YES/NO FLAG
 ;
 D WAIT^DICD S (C0,C1)=0,(BN,YN)="" W !!
 F  S BN=$O(^PRSPC("B",BN)) Q:BN=""!(YN["^")  S DFN450=0 F  S DFN450=$O(^PRSPC("B",BN,DFN450)) Q:DFN450<1!(YN["^")  S NODE=$G(^PRSPC(DFN450,0)),SSN=$P(NODE,"^",9),NAME450=$P(NODE,"^",1),C0=C0+1 I '$D(^PRSPC("A200",DFN450)) D TRY
KILL K BN,C0,C1,DA,DIC,DIE,DFN200,DFN450,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DR,ID,L,NAME,NAME200,NAME450,NODE,NX,SSN,SSN200,SSN450,X,Y,YN
 Q
TRY ; Try to match
 D DIC Q:'L
T1 R !!,"Select Employee # (or RETURN): ",DFN200:DTIME W:DFN200="" ! Q:DFN200=""  I '$T!("^"[DFN200) S L=0,YN="^" Q
 I DFN200'?1.3N!(DFN200<1)!(DFN200>L) W " ??" G T1
 S DFN200=$G(ID(DFN200)) Q:'DFN200
F1 S C1=C1+1,^PRSPC("A200",DFN450)=DFN200,^PRSPC("A450",DFN200)=DFN450,DA=DFN200,DR="9////"_SSN,DIE="^VA(200," D ^DIE W "  ok"
 W ! Q
DIC S L=0,NAME=$P(NAME450,",",1)_","_$E($P(NAME450,",",2),1),NX=NAME K ID
 F  S NX=$O(^VA(200,"B",NX)) Q:NX=""!($P(NX,NAME,1)'="")  F DFN200=0:0 S DFN200=$O(^VA(200,"B",NX,DFN200)) Q:DFN200<1  I '$D(^PRSPC("A450",DFN200)) W:'L !!,$P(NODE,"^",1),! S L=L+1,ID(L)=DFN200 W !,L," ",NX D
 .S AC=$P($G(^VA(200,DFN200,0)),"^",3)
 .W ?35,$S(AC'="":"has an ACCESS CODE",1:"does NOT have an ACCESS CODE")
 K AC Q
PE ; PAID EMPLOYEE file lookup
 W ! K DIC S DIC="^PRSPC(",DIC(0)="AEMQZ" D ^DIC I Y<1 D KILL Q
 I $D(^PRSPC("A200",+Y)) S DFN200=^PRSPC("A200",+Y) W !!,"This employee has already been matched to ",$P($G(^VA(200,DFN200,0)),"^"),!,"in the NEW PERSON file.",! K DFN200 G PE
 S DFN450=+Y,NODE=$G(^PRSPC(+Y,0)),NAME450=$P(NODE,"^"),SSN450=$P(NODE,"^",9)
NP ; NEW PERSON file lookup
 W ! K DIC S DIC="^VA(200,",DIC(0)="AEMQZ" D ^DIC I Y<1 D KILL G PE
 I $D(^PRSPC("A450",+Y)) S DFN450=^PRSPC("A450",+Y) W !!,"This NEW PERSON entry has already been matched to ",$P(^PRSPC(DFN450,0),"^"),!,"in the PAID EMPLOYEE file.",! K DFN200 G PE
 S DFN200=+Y,NAME200=$P(^VA(200,+Y,0),"^"),SSN200=$P($G(^VA(200,+Y,1)),"^",9)
 W !!,"Employee: ",?15,NAME450,?47,$E(SSN450,1,3)_"-"_$E(SSN450,4,5)_"-"_$E(SSN450,6,9)
 W !,"  VA 200: ",?15,NAME200 W:$L(SSN200)>0 ?47,$E(SSN200,1,3)_"-"_$E(SSN200,4,5)_"-"_$E(SSN200,6,9),!
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y",DIR("A")="Are these the same person" D ^DIR
 I $D(DIRUT) D KILL Q
 I Y=0 D KILL G PE
 K DIC,DIE,DIR
 S DIE="^VA(200,",DA=DFN200,DR="9////"_SSN450 D ^DIE
 S ^PRSPC("A200",DFN450)=DFN200,^PRSPC("A450",DFN200)=DFN450
 G PE
DM ; delete a match
 K DIC S DIC="^PRSPC(",DIC(0)="AEMQZ" D ^DIC I Y<1 D KILL Q
 I '$D(^PRSPC("A200",+Y)) W !,"This employee has not been matched to a NEW PERSON file entry!",! G DM
 S DFN450=+Y,DFN200=$G(^PRSPC("A200",+Y))
 S NODE=$G(^PRSPC(DFN450,0)),NAME450=$P(NODE,"^"),SSN450=$P(NODE,"^",9)
 S NAME200=$P($G(^VA(200,DFN200,0)),"^"),SSN200=$P($G(^VA(200,DFN200,1)),"^",9)
 W !!,"Employee: ",?15,NAME450,?47,$E(SSN450,1,3)_"-"_$E(SSN450,4,5)_"-"_$E(SSN450,6,9)
 W !,"  VA 200: ",?15,NAME200 W:$L(SSN200)>0 ?47,$E(SSN200,1,3)_"-"_$E(SSN200,4,5)_"-"_$E(SSN200,6,9),!
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 W !,"If these two entries are not the same person, I will erase the SSN",!,"field of the NEW PERSON file entry and not consider this a match.",!
 S DIR(0)="Y",DIR("A")="Delete this match" D ^DIR I $D(DIRUT) D KILL Q
 I Y=0 D KILL G DM
 K DIC,DIE,DIR
 S DIE="^VA(200,",DA=DFN200,DR="9///@" D ^DIE
 K ^PRSPC("A200",DFN450),^PRSPC("A450",DFN200)
 D KILL G DM
CU ; clean up match cross references
 W !!,"This step should not be done until you are satisfied that every",!,"File 450 entry has been matched to a File 200 entry.",!
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y",DIR("A")="Continue with Clean Up" D ^DIR
 I $D(DIRUT)!(Y=0) D KILL Q
 K ^PRSPC("A200"),^PRSPC("A450")
 Q
