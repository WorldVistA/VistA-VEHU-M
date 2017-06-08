PRSIPRE ;HISC/GWB PAID 4.0 PRE-INIT ;5/15/95  15:37
 ;;4.0;PAID;;Sep 21, 1995
CLN ; Remove files which have changed and which have fixed contents
 S DIU="^PRST(457.3,",DIU(0)="D" D EN^DIU2
 S DIU="^PRST(457.4,",DIU(0)="D" D EN^DIU2
 S DIU="^PRST(457.5,",DIU(0)="D" D EN^DIU2
 S DIU="^PRST(455.1,",DIU(0)="D" D EN^DIU2
 K DIU
 K ^XTMP("PRS","PCT")
O450I ;Delete OLD 450 IEN (#700) data and field from PAID EMPLOYEE (#450) file
 S OLDIEN=0 F  S OLDIEN=$O(^PRSPC("OLDIEN",OLDIEN)) Q:OLDIEN'>0  S IEN=0 F  S IEN=$O(^PRSPC("OLDIEN",OLDIEN,IEN)) Q:IEN'>0  K ^PRSPC(IEN,"OLDIEN")
 K ^PRSPC("OLDIEN")
 S DIK="^DD(450,",DA=700,DA(1)=450 D ^DIK
 ; Remove unused fields and options
 K DIK,DA S DIK="^DD(455.5,",DA(1)=455.5,DA=3 D ^DIK
 S X="PRSA PAY T&A",DA=$O(^DIC(19,"B",X,"")) I DA S DIK="^DIC(19," D ^DIK
 K OLDIEN,IEN,DIK,DA,X
 Q
