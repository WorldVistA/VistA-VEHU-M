FIXCPST ;WASH-ISC-PEH/FIX COPAY STATUS CREATED BY CLASS III SOFTWARE ;1-16-92/23:42
 ;;
0 D ^PRCFSITE Q:'$D(PRC("SITE"))!('$D(PRC("FY")))
 W !!,"Killing 'AC', 'ADB' and 'AO' cross references, please hold on..." F I="AC","ADB","AO" K ^PRCA(430,I) H 1 W !,I," Deleted"
 W !!,"You have ",$P(^PRCA(430,0),"^",4)," records to validate.",!,"A dot will be written for every 100 records processed.",!
 S X=+$G(^TMP("ZZFIX"))
 F DA=X:0 S DA=$O(^PRCA(430,DA)) Q:'DA  W:'(DA#100) "." S PRCA0=$G(^PRCA(430,DA,0)) S PREDA=DA D:PRCA0'="" XREF S DA=PREDA,^TMP("ZZFIX")=DA
 K ^TMP("ZZFIX") Q  ;end of routine
XREF ;Set up 'AO', 'AC' and 'ADB' X-REF
 I $P(PRCA0,"^",8) S ^PRCA(430,"AC",$P(PRCA0,"^",8),DA)=""
 I $P(PRCA0,"^",8)=$O(^PRCA(430.3,"AC",112,0)),$P(PRCA0,"^",9) S ^PRCA(430,"AO",$E($P(PRCA0,"^",9),1,30),DA)=""
 Q:$P(PRCA0,"^",9)'>0  S PRCA("DEBTOR")=$P(PRCA0,"^",9)
 ;We need this X-ref for printing follow-up letters.
 S Z0=$S(+$P(PRCA0,U,2)>0:$P(PRCA0,U,2),1:9) Q:"NT"[$P(^PRCA(430.2,Z0,0),U,6)  Q:+$P(PRCA0,U,8)'>0  K Z0
 I $P(^PRCA(430.3,+$P(PRCA0,U,8),0),U,3)'=102 K ^PRCA(430,"ADB",PRCA("DEBTOR"),DA) Q
 I '$D(^PRCA(430,DA,6)) S ^PRCA(430,"ADB",PRCA("DEBTOR"),DA)="" D CHK Q
 I +$P(^PRCA(430,DA,6),U,4)>0 K ^PRCA(430,"ADB",PRCA("DEBTOR"),DA) Q
 S ^PRCA(430,"ADB",PRCA("DEBTOR"),DA)="" D CHK
 Q  ;end of XREF
CHK ;CHECK RX COPAYS THAT ARE ACTIVE W/NO PAT REF #
 I ",22,23,"[(","_$P(PRCA0,"^",2)_","),$P(PRCA0,"^",8)=16,'$D(^PRCA(430,DA,2,"C")) D SET
 Q  ;end of CHK
SET ;SET PAT REF # AND MARK ALL TRANSACTIONS AS CALM CODE DONE
 S PRCABN=DA,PEDERR=0 D PRN Q:PEDERR=1
 F TR=0:0 S TR=$O(^PRCA(433,"C",PREDA,TR)) Q:'TR  S $P(^PRCA(433,TR,0),"^",3)=0 K ^PRCA(433,"AE",1,TR)
 Q  ;end of SET
PRN ;THIS WILL CREATE THE PAT REF NO IN FILE 442
 L ^PRCA(430,DA):1 E  D PED K DIC G END
 D PH^PRCACLM
 I '$D(^PRCA(430,PRCABN,2,0)) D PED G END
 I +$P(^PRCA(430,PRCABN,2,0),U,3)'>0 D PED G END
 S PRCAT=$P(PRCA0,U,2)
 D EN1
END L  K PRCAREF,PRCAT,PRCHPO,DR,DIE,PRCABN,DIC,PRCALM,PRCA2,PRCAGL,PRCA,PRCAPAT,PRCHP
 Q  ;end of PRN
EN1 S PRCA2=$P(^PRCA(430,PRCABN,2,0),U,3),PRCAGL=^PRCA(430,PRCABN,2,PRCA2,0)
 I $P(PRCAGL,U,6)=2 S PEDERR=1 Q
 K PRCHPO I $P(PRCAGL,U,3)]"" D PED Q
 S X=$P(PRCA0,"^"),DIC(0)="L",PRCAREF=1,PRCHP("A")="",PRCHP("T")=24,PRCHP("S")=5 D PAT Q:'$D(PRCHPO)
 S PRCAPAT=$P(^PRC(442,PRCHPO,0),U,1) D UP442^PRCAPAT1
 S DIE="^PRCA(430,"_PRCABN_",2,",DA(1)=PRCABN,DA=PRCA2,DR="2///"_PRCAPAT_$S($P(^PRCA(430,PRCABN,2,DA,0),"^",5):"",1:";4") D ^DIE Q:$D(Y)
 S $P(^PRCA(430,PRCABN,2,PRCA2,0),U,6)=2,PRCALM=2
 S PRCA("STATUS")=$O(^PRCA(430.3,"AC",102,"")) D UPSTATS^PRCAUT2 K PRCA("STATUS")
 Q  ;end of EN1
PAT ;CREATE NEW PAT IN FILE 442
 K DIC("S") S PRCHP("NEW")="",DIC="^PRC(442,",DLAYGO=442 D ^DIC G PED:Y<0,PED:'+$P(Y,"^",3) S (DA,PRCHPO)=+Y,%DT="T",X="NOW" D ^%DT
 S $P(^PRC(442,PRCHPO,0),"^",2)=PRCHP("T"),$P(^(12),"^",4,5)=DUZ_"^"_Y,^PRC(442,"F",PRCHP("T"),DA)="" D DOCID^PRCHUTL K DIC,DLAYGO,%DT,PRCHP
 Q  ;end of PAT
PED ;ERROR IN ASSIGNING PAT NO./CHANGE STATUS TO PENDING CALM CODE
 S PEDERR=1,DA=PREDA,DIE="^PRCA(430,",DR="8///^S X=21" D ^DIE K ^PRCA(430,"ADB",PRCA("DEBTOR"),DA)
 Q  ;end of PED
