GMPLIL ; List Template Exporter ; 21-OCT-1994
 ;;2.0;Problem List;;Aug 25, 1994
 ;; ;
 W !,"'GMPL CODE LIST' List Template..."
 S DA=$O(^SD(409.61,"B","GMPL CODE LIST",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="GMPL CODE LIST" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="GMPL CODE LIST^1^^^5^14^1^1^Problem^GMPL CODE LIST^PROBLEM LIST^1^^1"
 .S ^SD(409.61,VALM,1)="GMPL PRINT LIST^GMPL HIDDEN MENU"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""GMPL"",$J)"
 .S ^SD(409.61,VALM,"COL",0)="^409.621^7^7"
 .S ^SD(409.61,VALM,"COL",1,0)="NUMBER^1^3"
 .S ^SD(409.61,VALM,"COL",2,0)="STATUS^4^2"
 .S ^SD(409.61,VALM,"COL",3,0)="PROBLEM^6^40^Problem"
 .S ^SD(409.61,VALM,"COL",4,0)="SERV CONNECTED^55^3^SC"
 .S ^SD(409.61,VALM,"COL",5,0)="RESOLVED^72^8^Resolved"
 .S ^SD(409.61,VALM,"COL",6,0)="ICD^47^7^ICD"
 .S ^SD(409.61,VALM,"COL",7,0)="EXPOSURE^59^12^Exposure"
 .S ^SD(409.61,VALM,"FNL")="D EXIT^GMPLMGR2"
 .S ^SD(409.61,VALM,"HDR")="D HDR^GMPLMGR"
 .S ^SD(409.61,VALM,"HLP")="D HELP^GMPLCODE"
 .S ^SD(409.61,VALM,"INIT")="D INIT^GMPLCODE"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 W !,"'GMPL DATA ENTRY' List Template..."
 S DA=$O(^SD(409.61,"B","GMPL DATA ENTRY",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="GMPL DATA ENTRY" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="GMPL DATA ENTRY^1^^80^5^14^1^1^Problem^GMPL DATA ENTRY^PROBLEM LIST^1"
 .S ^SD(409.61,VALM,1)="GMPL PRINT^GMPL HIDDEN MENU"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""GMPL"",$J)"
 .S ^SD(409.61,VALM,"COL",0)="^409.621^7^7"
 .S ^SD(409.61,VALM,"COL",1,0)="NUMBER^1^3"
 .S ^SD(409.61,VALM,"COL",2,0)="STATUS^4^2^"
 .S ^SD(409.61,VALM,"COL",3,0)="PROBLEM^6^40^Problem"
 .S ^SD(409.61,VALM,"COL",4,0)="SERV CONNECTED^55^3^SC"
 .S ^SD(409.61,VALM,"COL",5,0)="RESOLVED^72^8^Resolved"
 .S ^SD(409.61,VALM,"COL",6,0)="ICD^47^7^ICD"
 .S ^SD(409.61,VALM,"COL",7,0)="EXPOSURE^59^12^Exposure"
 .S ^SD(409.61,VALM,"FNL")="D EXIT^GMPLMGR2"
 .S ^SD(409.61,VALM,"HDR")="D HDR^GMPLMGR"
 .S ^SD(409.61,VALM,"HLP")="D HELP^GMPLMGR2"
 .S ^SD(409.61,VALM,"INIT")="D INIT^GMPLMGR"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 W !,"'GMPL DETAILED DISPLAY' List Template..."
 S DA=$O(^SD(409.61,"B","GMPL DETAILED DISPLAY",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="GMPL DETAILED DISPLAY" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="GMPL DETAILED DISPLAY^1^^^4^15^1^1^Attribute^GMPL DT MENU^PROBLEM LIST^1"
 .S ^SD(409.61,VALM,1)="^GMPL HIDDEN MENU"
 .S ^SD(409.61,VALM,"ARRAY")=" GMPDT"
 .S ^SD(409.61,VALM,"COL",0)="^409.621^1^1"
 .S ^SD(409.61,VALM,"COL",1,0)="LINE^1^79"
 .S ^SD(409.61,VALM,"FNL")="D EXIT^GMPLDISP"
 .S ^SD(409.61,VALM,"HDR")="D HDR^GMPLDISP"
 .S ^SD(409.61,VALM,"HLP")="D HELP^GMPLDISP"
 .S ^SD(409.61,VALM,"INIT")="D EN^GMPLDISP"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 W !,"'GMPL EDIT PROBLEM' List Template..."
 S DA=$O(^SD(409.61,"B","GMPL EDIT PROBLEM",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="GMPL EDIT PROBLEM" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="GMPL EDIT PROBLEM^1^^^4^14^1^1^Attribute^GMPL EDIT MENU^PROBLEM LIST^4"
 .S ^SD(409.61,VALM,1)="^GMPL HIDDEN MENU"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""GMPLEDIT"",$J)"
 .S ^SD(409.61,VALM,"COL",0)="^409.621^2^1"
 .S ^SD(409.61,VALM,"COL",2,0)="LINE^1^79^"
 .S ^SD(409.61,VALM,"FNL")="D EXIT^GMPLEDIT"
 .S ^SD(409.61,VALM,"HDR")="D HDR^GMPLEDIT"
 .S ^SD(409.61,VALM,"HLP")="D HELP^GMPLEDIT"
 .S ^SD(409.61,VALM,"INIT")="D EN^GMPLEDIT"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 G ^GMPLIL1
