LBRVCONE ;SSI/ALA-Consolidate library files env check ;[ 03/13/98  10:17 AM ]
 ;;2.5;Library;**3**;Mar 11, 1996
 ;
EN ; Checking for patch load requirements
 N QUIT
 I '$G(DUZ)!($G(DUZ(0))'["@") W !,"USER 'DUZ' VARIABLES **NOT** CORRECTLY DEFINED.  CONFIRM THAT DUZ(0)='@'.  THEN D ^XUP." S XPDQUIT=1 Q
 ;
 ;
 S LBRPT2=$$PATCH^XPDUTL("LBR*2.5*2")
 I LBRPT2'=1 D  S XPDQUIT=1 Q
 . W !!,"*** Patch LBR*2.5*2 must be installed prior to loading"
 . W !,"this patch.  This install will now abort.",!
 ;
RX ; re-index file 680.6 for checks
 F LBRXREF="B","C" K ^LBRY(680.6,LBRXREF)
 S DIK="^LBRY(680.6," D IXALL^DIK
LEG ;Check for Legacy Station
 S LBRPRT=$P($G(^XTMP("LBRV",0)),"^",3),LBRSYS=$P(LBRPRT,";",2)
 I LBRSYS="LEG" K LBRSYS,LBRPRT,LBRPT2,LBRXREF Q
 ;
CHK ; check to see if ^XTMP already integrated
 I '$D(^XTMP("LBRY",0)) G WRN
 S LBRCODE=0
ORD S LBRCODE=$O(^XTMP("LBRY",LBRCODE)) G WRN:LBRCODE=""
 S LBRPTR=$O(^LBRY(680.6,"C",LBRCODE,""))
 I LBRPTR="" G WRN
 S LBRDA=0
L680 S LBRDA=$O(^XTMP("LBRY",LBRCODE,680,LBRDA)) G ORD:LBRDA=""
 I $P($G(^XTMP("LBRY",LBRCODE,680,LBRDA,0)),U,4)=LBRPTR G MESS
 G L680
WRN ;  Warning on existence of XTMP global
 I $O(^XTMP("LBRY",0))'="" S QUIT=0 D  I QUIT S XPDQUIT=1,DIRUT=1 Q
 . D MES^XPDUTL("*** WARNING - XTMP global exists! ***")
 . D MES^XPDUTL("This data file will be merged with your data file!")
 . D BMES^XPDUTL("If you are a PRIMARY STATION and need to have this global present,")
 . D MES^XPDUTL(" Enter 'Y'es to install or 'N'o to stop the install.")
 . D MES^XPDUTL("  ")
 . S DIR(0)="Y",DIR("A")="Enter 'N' to quit, or 'Y' to continue: "
 . S DIR("B")="NO" D ^DIR
 . I Y=0!$D(DIRUT) K DIR,X,Y S QUIT=1 Q
CNF I $O(^XTMP("LBRY",0))="" S QUIT=0 D  Q:QUIT
 . D MES^XPDUTL("No LEGACY'S TEMPORARY GLOBAL present.")
 . D BMES^XPDUTL("If you are a PRIMARY STATION and need to have these globals present,")
 . D MES^XPDUTL(" Enter 'Y' to quit install and then load the LEGACY'S TEMPORARY GLOBAL.")
 . D MES^XPDUTL("If you want to continue with this install, Press ENTER.")
 . D MES^XPDUTL("  ")
 . S DIR(0)="Y",DIR("A")="Enter 'Y' to quit, or Press ENTER to continue: "
 . S DIR("B")="NO" D ^DIR
 . I Y'=0!($G(DIRUT)) K DIR,X,Y S XPDQUIT=1,DIRUT=1 Q
STA ;
 S LBRVSTA=0,CT=0
 F  S LBRVSTA=$O(^XTMP("LBRY",LBRVSTA)) Q:LBRVSTA=""  S CT=CT+1
 I CT>0 S $P(^XTMP("LBRY",0),"^",3)=CT
 I CT>1 D
 . D MES^XPDUTL("**WARNING** Temporary global contains multiple stations.")
 . D MES^XPDUTL("The integration may take a couple of hours.")
 K CT,LBRPT2,LBRVSTA
 Q
QUES ;  Check to see if 5-letter code has been set and finds a match
 S QUIT=0,LBRVSTA=0
LP S LBRVSTA=$O(^XTMP("LBRY",LBRVSTA))
 I LBRVSTA="" G EXIT
LP2 S LBRVNM=$O(^LBRY(680.6,"C",LBRVSTA,""))
 I LBRVNM="" D PROC G EXIT:QUIT
 K DIC,DIE,D,DA,D0,DR,X,Y
 G LP
PROC ; get new site name for integrating site if not already setup
 D MES^XPDUTL("No Division Site Name defined in Library Parameter file")
 D MES^XPDUTL("for integrating site:  ***  "_LBRVSTA_"   ***")
 D BMES^XPDUTL("Enter the corresponding SITE NAME to match the above 5 letter code.")
 D MES^XPDUTL("  ")
Q2 S DIC="^LBRY(680.6,",DIC("A")="Select the LIBRARY PARAMETERS SITE NAME for '"_LBRVSTA_"': "
 S DIC(0)="AELQ" D ^DIC
 I $G(DTOUT)!($G(DUOUT)) S QUIT=1 Q
 I Y<0 W !,"You must select a site name." G Q2
 S (DA,LBRVNM)=+Y
 I $P($G(^LBRY(680.6,DA,0)),U,7)'="" W !,"Already matched with another 5 letter code.  Select a NEW site name.." G Q2
 S DR=".07///^S X=LBRVSTA",DIE=DIC D ^DIE
 Q
MESS ; display exit message that data must be removed
 D BMES^XPDUTL(LBRCODE_"'s integrating data is present!")
 D MES^XPDUTL("You will need to remove this data, in order to continue with this install.")
 D BMES^XPDUTL("At the command line:  K ^XMTP(""LBRY"","""_LBRCODE_""")")
 D BMES^XPDUTL("Then re-load this patch to continue.")
 D MES^XPDUTL("  ")
 S XPDQUIT=1
 K LBRVCODE,LBRVPTR,LBRYDA,LBRXREF Q
EXIT ;Kill local variables
 K LBRVSTA,LBRVNM,DIR,DIC,DIE,D,DA,D0,DR,X,Y
 I QUIT S DIRUT=1
 Q
