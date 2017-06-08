A1BGPOST ;ALB/MLI - POST-INIT TO CREATE MAILGROUP FOR PAC ; 24 NOV 92
 ;; Version 2.0 ; PATIENT ADDRESS COLLECTION ;; 24-NOV-92
 ;
 ; post-init to create A1BG PAC NOTIFICATION mailgroup
 ;
MG ;Add mailgroup for PAC notification
 W !!,">>> Checking for 'A1BG PAC NOTIFICATION' mailgroup..."
 S Y=$O(^XMB(3.8,"B","A1BG PAC NOTIFICATION",0)) I $D(^XMB(3.8,+Y,0)) W "Mailgroup already exists...",$S($O(^XMB(3.8,+Y,1,0))]"":"Members already",1:"No members")," defined..." G INITC
 ;create mail group
 S DIC="^XMB(3.8,",DIC(0)="L",(A1BGX,X)="A1BG PAC NOTIFICATION"
 K DD,DO D FILE^DICN I Y<0 W "Mailgroup not created!" G INITC
 S DA=+Y,^XMB(3.8,DA,0)=A1BGX_"^PU^^^^0"
 S ^XMB(3.8,DA,1,0)="^3.81P^^",^(1,0)=DUZ ;stuff as member of mailgroup
 S ^XMB(3.8,DA,2,0)="^3.801^^",^(1,0)="Used to notify members of the status of PAC transmissions",^XMB(3.8,DA,3)=DUZ
 S DIK=DIC D IX1^DIK
 W !?4,"Mailgroup ADDED...",$P($G(^VA(200,+DUZ,0)),"^",1)," added as a member..."
 W !?4,"This mailgroup will receive notification of all stages in the Patient",!?4,"Address Collection process.  You have been added as a member and you may",!?4,"add other members as appropriate."
INITC ; Send Mail man message that init is complete
 N DIFROM,XMDUZ,XMTEXT,XMY,SITE
 W !!,">>> Sending a message to the Albany ISC indicating your init is complete"
 S XMSUB="PATIENT ADDRESS COLLECTION REQUEST"
 S SITE=$$PRIM^VASITE(DT),SITE=$P($G(^DG(40.8,+SITE,0)),U)
 S XMN=0,XMTEXT="A1BGM("
 S Y=DT D DD^%DT
 S A1BGM(1)=SITE_" has completed the init at "_Y_"."
 S XMDUZ=.5
 S XMY("G.A1BG PAC NOTIFICATION@ISC-ALBANY.VA.GOV")=""
 S XMY(DUZ)=""
 D ^XMD
 K XMDUZ,XMN,XMSUB,XMTEXT,XMY
MGQ K %,A1BGX,DA,DIC,DIK,X,Y,SITE
 Q
