ENXIIPS ;(WIRMFO)/DH-POST INIT ;5/2/96
 ;;7.0;ENGINEERING;**29**;August 17,1993
MAIN N STANUM,ENTXT,ENXMY,ENSCR,ENSCRDA,ENFLDDA,DIE,DR,DA
 Q:'$D(DIFROM)
 W !!,"Performing Post-Init..."
 S STANUM=$P(^DIC(6910,1,0),U,2)
 I '$D(^ENG(6915.1,1)) S ^ENG(6915.1,1,0)=STANUM_"^0^0^0^0^0",DIK="^ENG(6915.1," D IXALL^DIK K DIK
 ; add mail group
 S ENI=$$FIND1^DIC(3.8,"","X","FAM","B")
 I 'ENI D
 . W !,"  Creating Mail Group FAM..."
 . S ENXMY(DUZ)=""
 . S ENTXT(1)="Receives confirmation messages from Austin Postmaster for"
 . S ENTXT(2)="messages sent by the Engineering package (via Generic"
 . S ENTXT(3)="Code Sheet) to Domain Q-FAM.VA.GOV (Fixed Assets)."
 . S X=$$MG^XMBGRP("FAM",0,DUZ,0,.ENXMY,.ENTXT,1)
 . W "done."
 . W !,"  Mail group FAM will receive confirmation messages from Austin."
 . W !,"  You have been entered as the sole member of mail group FAM."
 . W !,"  Please enter other members as appropriate."
 ; correct some DJ screen pre-actions
 F ENSCR="ENEQ1","ENEQ1E","ENEQ1S","ENEQNX1" D
 . S ENSCRDA=$O(^ENG(6910.9,"B",ENSCR,0))
 . Q:'ENSCRDA
 . S ENFLDDA=$O(^ENG(6910.9,ENSCRDA,1,"B","SOURCE",0)) I ENFLDDA D
 . . S DIE="^ENG(6910.9,"_ENSCRDA_",1,",DA(1)=ENSCRDA,DA=ENFLDDA
 . . S DR="2///S V(18)=$$GET1^DIQ(6914,DA,13.5)" D ^DIE
 . S ENFLDDA=$O(^ENG(6910.9,ENSCRDA,1,"B","VENDOR",0)) I ENFLDDA D
 . . S DIE="^ENG(6910.9,"_ENSCRDA_",1,",DA(1)=ENSCRDA,DA=ENFLDDA
 . . S DR="2///S V(12)=$$GET1^DIQ(6914,DA,10)" D ^DIE
 W !,"Completed Post-Init"
 Q
 ;ENXIIPS
