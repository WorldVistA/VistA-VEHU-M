PSAREC2 ;B'ham ISC/LTL - DA/PV receiving (cont.) ; 7 May 92
 ;;2.0; DRUG ACCOUNTABILITY ;;3 Dec 93
CON S DIC="^PRCS(410,",DIC(0)="AEMQZ",DIC("A")="Select Pharmacy Transaction number: ",DIC("B")=$S($D(PSACON):$P($G(^PRCS(410,+PSACON,0)),U),1:""),DIC("S")="I $P($G(^(0)),U,2)=""O"",$P($G(^(3)),U,3)[822400"
 D ^DIC K DIC G:Y<1 QUIT S PSACON=$S(Y>0:+Y,1:"")
 S DIR(0)="58.81,71O",DIR("A")="Please enter the Prime Vendor Invoice number",DIR("?")="The invoice will be stored, allowing look-ups for receipts against this invoice." W ! D ^DIR K DIR G:Y'=""&($D(DIRUT)) QUIT S PSAPV=Y
 I $G(PSAPV)]"",$O(^PSD(58.81,"PV",Y,"")) S PSA(2)=Y W !!,"Previous receipts have been processed for this invoice.",!! S DIR(0)="Y",DIR("A")="Would you like to review",DIR("B")="Yes" D ^DIR K DIR G:$D(DIRUT) QUIT G:Y=1 DEV^PSAREPV
DRUG F  S DIC="^PSD(58.8,PSALOC,1,",DIC(0)="AEMQL",DIC("A")="Select "_$G(PSALOCN)_" drug: ",DIC("S")="I $S($P($G(^(0)),U,14):$P($G(^(0)),U,14)>DT,1:1)",DA(1)=PSALOC D  Q:$G(PSAOUT)
 .D ^DIC I Y<0 S PSAOUT=1 Q
 .K DIC S PSADRUG=+Y,PSADRUGN=$P($G(^PSDRUG(+Y,0)),U),PSAB=$P($G(^PSD(58.8,+PSALOC,1,+PSADRUG,0)),U,4)
PRIC .W ! S DIE="^PSDRUG(",DA=PSADRUG,DR="15Dispense units per order unit: ;13Price per order unit: " D ^DIE K DIE I $D(Y) S PSAOUT=1 Q
QTY .W ! S DIR(0)="N^0:9999999:0",DIR("A")="Enter quantity to receive",DIR("?")="The quantity entered will be multiplied by the dispense units per order unit" D ^DIR K DIR S (PSAREC,PSAREC(1))=Y I $D(DIRUT) S PSAOUT=1 Q
DISP .W ?50,"Converted quantity: ",PSAREC*$P($G(^PSDRUG(+PSADRUG,660)),U,5) S PSAREC=$P($G(^(660)),U,5)*PSAREC
PQ .S DIR(0)="Y",DIR("A")="OK to post",DIR("B")="Yes",DIR("?")="If yes, the balance will be updated and a transaction stored." D ^DIR K DIR D:Y=1  I $D(DIRUT) S PSAOUT=1 Q
 ..W !!,"There were ",$S($P($G(^PSD(58.8,+PSALOC,1,+PSADRUG,0)),U,4):$P($G(^(0)),U,4),1:0)," on hand.",?40,"There are now ",$P($G(^(0)),U,4)+PSAREC," on hand.",!
 ..F  L +^PSD(58.8,+PSALOC,1,+PSADRUG,0):0 I  Q
 ..D NOW^%DTC S PSADT=+$E(%,1,12)
 ..S PSAB=$P($G(^PSD(58.8,+PSALOC,1,+PSADRUG,0)),U,4)
 ..S $P(^PSD(58.8,+PSALOC,1,+PSADRUG,0),U,4)=PSAREC+PSAB
 ..L -^PSD(58.8,+PSALOC,1,+PSADRUG,0)
 ..S:'$D(^PSD(58.8,+PSALOC,1,+PSADRUG,5,0)) ^(0)="^58.801A^^"
 ..I '$D(^PSD(58.8,+PSALOC,1,+PSADRUG,5,$E(DT,1,5)*100,0)) S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DIC(0)="L",DIC("DR")="1////^S X=$G(PSAB)",(X,DINUM)=$E(DT,1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG D ^DIC K DIC D
 ...S X="T-1M" D ^%DT S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DIC(0)="L",(X,DINUM)=$E(Y,1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG D ^DIC K DIC S DA=+Y
 ...S DIE="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DA(2)=PSALOC,DA(1)=PSADRUG
 ...S DR="3////^S X=$G(PSAB)" D ^DIE K DIE
 ..S DIE="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DA(2)=PSALOC,DA(1)=PSADRUG,DA=$E(DT,1,5)*100,DR="5////^S X=$P($G(^(0)),U,3)+PSAREC" D ^DIE
 ..W !,"Updating monthly receipts and transaction history.",!
TR ..F  L +^PSD(58.81,0):0 I  Q
FIND ..S PSAT=$P(^PSD(58.81,0),U,3)+1 I $D(^PSD(58.81,PSAT)) S $P(^PSD(58.81,0),U,3)=$P(^PSD(58.81,0),U,3)+1 G FIND
 ..S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSAT D ^DIC K DIC,DLAYGO L -^PSD(58.81,0)
 ..S DIE="^PSD(58.81,",DA=PSAT,DR="1////1;2////^S X=PSALOC;3////^S X=PSADT;4////^S X=PSADRUG;5////^S X=PSAREC;6////^S X=DUZ;7////^S X=PSACON;8////^S X=PSAPO;9////^S X=PSAB;71////^S X=$G(PSAPV)" D ^DIE
 ..S:'$D(^PSD(58.8,+PSALOC,1,+PSADRUG,4,0)) ^(0)="^58.800119PA^^"
 ..S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,4,",DIC(0)="L",(X,DINUM)=PSAT
 ..S DA(2)=PSALOC,DA(1)=PSADRUG D ^DIC K DIC,DA,PSADRUG
QUIT Q
