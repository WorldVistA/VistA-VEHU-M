DGV52PT ;ALB/MTC - DG POST-INIT FOR VERSION 5.2 DRIVER ;12/10/91  09:55
 ;;5.2;REGISTRATION;;JUL 29,1992
EN I DGVCUR<5.11 D DEL^DGV52PT1
 I DGVCUR<5.11 D MG,MVTYP^DGV52PT2,INDOM
 D ^VASITE1
 D ^DGV52PT2
 D ^DGV52PT3
 Q
 ;
MG ;Add mailgroup for building managment
 W !!,">>> Checking for 'DGPM UR ADMISSION' mailgroup..." S Y=$O(^XMB(3.8,"B","DGPM UR ADMISSION",0)) I $D(^XMB(3.8,+Y,0)) W "Mailgroup already exists...",$S($O(^XMB(3.8,+Y,1,0))]"":"Members already",1:"No members")," defined..."
 I '$D(^XMB(3.8,+Y,0)) S DIC("DR")="4///public;5////"_DUZ_";",DIC="^XMB(3.8,",DIC(0)="L",X="DGPM UR ADMISSION" D FILE^DICN W !?3,"Mailgroup ADDED...No members defined..."
 K DIC,X,Y
 Q
 ;
INDOM ;Inactivating DOM. PATIENT eligibility code in file 8
 W !!,">>> Inactivating DOM. PATIENT eligibility code in file 8 ..."
 F DGX=0:0 S DGX=$O(^DIC(8,"D",11,DGX)) Q:'DGX  S DA=DGX,DIE="^DIC(8,",DR="6////1" D ^DIE
 K DA,DIE,DR,DGX
 Q
 ;
