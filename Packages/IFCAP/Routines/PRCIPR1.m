PRCIPR1 ;WISC/CLH/LEM-PRE INIT TO DELETE OLD FILES AND FIELDS ;8/26/93  9:14 AM
V ;;5.0;IFCAP;;4/21/95
 N DIK,PRCFSITE,DA,L,I,X
 D DT^DICRW
 ;
 ;  remove ifcap dd field descriptions
 D DESCRIP^PRC5INS1(410,443.99)
TAKEOUT Q
 ;
 S (PRCFD,PRCFSITE)=0 F  S PRCFSITE=$O(^PRC(420,"B",PRCFSITE)) Q:'PRCFSITE  I $D(^PRC(420,PRCFSITE,0)) D
   . S DA=0 F  S DA=$O(^PRC(420,PRCFSITE,1,DA)) Q:'DA  I $D(^PRC(420,PRCFSITE,1,DA,0)) S $P(^(0),"^",4,5)="^",PRCFD=1
   . Q
 ;
 W:PRCFD !!,"I'm going to delete old data and obsolete fields from",!,"file #420 (FUND CONTROL POINT)."
 F L=5,5.5 S DA(1)=420,DA=L,DIK="^DD(420.01," D ^DIK
 F L=0,1,2 K ^DD(420.01,20,1,1,L)
 K ^DD(420.01,0,"IX","AD",420.01,20)
 ;
 I $D(^DD(420.3,0,"ID",2))!$D(^DD(420.3,0,"ID","WR"))!$D(^DD(420.01,.6))!$D(^DD(420.4,0,"IX","C",420.4,6))!$D(^DD(420.4,0,"ID",6))!$D(^DD(420.02,0,"NM","COST CENTER")) D
 . W !!,"Cleaning up obsolete identifier in file #420.3 (ALD CODE) . . ."
 . K ^DD(420.3,0,"ID",2),^DD(420.3,0,"ID","WR"),^DD(420.01,.6),^DD(420.4,0,"IX","C",420.4,6),^DD(420.4,0,"ID",6),^DD(420.02,0,"NM","COST CENTER")
 . Q
 ;
 I $D(^DD(422.2,2)) D
 . W !!,"Deleting duplicate COUNTER field in CALM/LOG TRANSMISSION/BATCH COUNTER file . . ."
 . S DA=2,DIK="^DD(422.2," D ^DIK
 . K X,DIK,DA
 . Q
 ;
 S PRCFD=0 F L=512:.1:514.9,578,580 S:$D(^DD(423,L)) PRCFD=1
 D:PRCFD
 . W !!,"Deleting unused fields from file 423 - CALM/LOG CODE SHEET file. . ."
 . F L=512:.1:514.9,578,580 S DA(1)=423,DA=L,DIK="^DD(423," D ^DIK
 . Q
 ;
 I $D(^DD(423,999,12))!$D(^DD(423,999,12.1)) D
 . W !!,"Removing screen  from file 423 - CALM/LOG CODE SHEET file. . ."
 . F L=12,12.1 K ^DD(423,999,L)
 . Q
 ;
 I $D(^DIC(424)) D
 . W !!,"Deleting old data dictionary for file 424 - 1358 DAILY RECORD file . . ."
 . S DIU="^PRC(424,",DIU(0)="EST" D EN^DIU2
 . K DIU W !
 . Q
 ;
 I $D(^DD(440,12))!$D(^DD(440,12.2)) D
 . W !!,"Deleting duplicate fields in file 440 - VENDOR file . . ."
 . F DA=12,12.2 S DIK="^DD(440," D ^DIK
 . K X,DIK,DA
 . Q
 ;
 S PRCFD=0 F I="Z2","Z3","Z4","Z5","Z6" I $D(^DD(440,0,"ID",I)) S PRCFD=1
 D:PRCFD
 . W !!,"Deleting old identifiers in file 440 - VENDOR file . . ."
 . F I="Z2","Z3","Z4","Z5","Z6" K ^DD(440,0,"ID",I)
 . Q
 ;
 I $D(^DD(442.1,3,12))!$D(^DD(442.1,3,12.1)) D
 . W !!,"Removing screen from file 442.1 - PROCUREMENT & ACCOUNTING TRANSACTIONS file . . ."
 . F I=12,12.1 K ^DD(442.1,3,I)
 . Q
 ;
 I $D(^DD(442.6,0,"ID","WR")) D
 . W !!,"Deleting identifier from file 442.6 - PAT NUMBER file . . ."
 . K ^DD(442.6,0,"ID","WR")
 . Q
 ;
 I $D(^DD(442.8,0,"ID",1)) D
 . W !!,"Deleting identifier from file 442.8 - DELIVERY SCHEDULE (ORDER) file . . ."
 . K ^DD(442.8,0,"ID",1)
 . Q
 ;
 I $D(^DD(443,.01,5,1,0)) D
 . W !!,"Deleting obsolete fields from file 443 - REQUEST WORKSHEET file . . ."
 . K ^DD(443,.01,5,1,0)
 . Q
 ;
 I $D(^DD(443.61,15,5,4,0)) D
 . W !!,"Deleting obsolete fields from file 443.6 - AMENDMENTS file . . ."
 . K ^DD(443.61,15,5,4,0)
 . Q
 ;
 I $D(^DIC(444.2))!$D(^PRC(444.2)) D
 . W !!,"Deleting old data and data dictionary for file 444.2 - LOG TRANSACTION CODE LIST file . . ."
 . S DIU="^PRC(444.2,",DIU(0)="DEST" D EN^DIU2
 . K DIU W !
 . Q
 ;
 D ^PRCIPR1A Q
