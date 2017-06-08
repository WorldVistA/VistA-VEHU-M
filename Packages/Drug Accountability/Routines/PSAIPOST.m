PSAIPOST ; B'ham ISC/LTL - Post Init for Drug Accountability ; 25 Feb 93
 ;;2.0; DRUG ACCOUNTABILITY ;;3 Dec 93
CHECK ;check pharmacy system file for conversion completion date
 N PSASYS S PSASYS=$O(^PS(59.7,0)),XQABT4=$H
 G:$P($G(^PS(59.7,+PSASYS,70)),U,4) QUIT
INF W !!,"I need to convert and clean up data in the DRUG ACCOUNTABILITY STATS file."
 W !!,"I'll attempt to add your existing Primary Inventory Point pointers",!!,"to a new multiple.",!!
 N DA,DIC,DIE,DIK,DINUM,PSAPRI,PSALOC,X,Y,DTOUT,DUOUT S PSAPRI=0
 F  S PSAPRI=$O(^PSD(58.8,"E",PSAPRI)) Q:'PSAPRI  D
 .S PSALOC=$O(^PSD(58.8,"E",+PSAPRI,0))
 .Q:'$D(^PSD(58.8,+PSALOC,0))
 .I $P($G(^PRCP(445,+PSAPRI,0)),U,20)'="D" W "Before linking ",$P($G(^PSD(58.8,+PSALOC,0)),U),",",!!,"the special inventory type must = ""D"" for Drug Accountability",!!,"in the ",$$INVNAME^PRCPUX1(PSAPRI)," Inventory Point." Q
 .S:'$D(^PSD(58.8,+PSALOC,4,0)) ^(0)="^58.8445P^^"
 .S DIC="^PSD(58.8,+PSALOC,4,",DIC(0)="L",X="`"_PSAPRI,DA=PSAPRI,DA(1)=PSALOC
 .D ^DIC K DIC
CONV ;convert monthly activity entries to be FM compatible
 W !!,"Now, I need to add 00 to the monthly activity multiple so it's FM compatible.",!!
 S PSALOC=0 N PSADRUG,PSAMON
 F  S PSALOC=$O(^PSD(58.8,PSALOC)) Q:'PSALOC  D
 .S PSADRUG=0 W !!,"Working on ",$P($G(^PSD(58.8,+PSALOC,0)),U)
 .F  S PSADRUG=$O(^PSD(58.8,+PSALOC,1,PSADRUG)) Q:'PSADRUG  D
 ..S PSAMON=0 W "*"
 ..F  S PSAMON=$O(^PSD(58.8,+PSALOC,1,+PSADRUG,5,PSAMON)) Q:'PSAMON!($L(PSAMON)>5)  D
 ...;create the new node with data
 ...S PSAMON(1)=PSAMON*100,^PSD(58.8,+PSALOC,1,+PSADRUG,5,PSAMON(1),0)=$G(^PSD(58.8,+PSALOC,1,+PSADRUG,5,PSAMON,0)),$P(^PSD(58.8,+PSALOC,1,+PSADRUG,5,PSAMON(1),0),U)=PSAMON(1)
 ...;kill the old one
 ...S DIK="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DA=PSAMON,DA(2)=PSALOC
 ...S DA(1)=PSADRUG D ^DIK K DIK,DA
 ..;reindex the new multiple for this drug
 ..S DIK="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DA(2)=PSALOC,DA(1)=PSADRUG
 ..S DIK(1)=".01" D ENALL^DIK K DIK,DA
COMP ;enter conversion completion date in pharmacy system file
 W !!,"I'm done with the conversion.",!!,"I'll now store a completion date in your PHARMACY SYSTEM (#59.7) file."
 D DT^DICRW
 S DIE="^PS(59.7,",DA=PSASYS,DR="71///^S X=DT" D ^DIE
QUIT S XQABT5=$H,X="PSAINITY" X ^%ZOSF("TEST") I $T D @("^"_X) Q
