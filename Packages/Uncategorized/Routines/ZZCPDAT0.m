ZZCPDAT0 ; SEB - Copy clinical data from one IEN to another - prompts for ZZCPDATA
 ;;1.0;VistA Data Support;;JUL 15 2016;Build 1
 Q
 ;
GETDFN() S DIC="^DPT(",DIC(0)="QEAMZ",DIC("A")="Select a patient to clone: " D ^DIC
 Q +Y
 ;
GETNAME() S NAME=""
NAME R !,"Enter the name of the new patient: ",NAME
 I NAME="" Q ""
 I $E(NAME)="?" W !,"Select the name of the new patient. It should be in the format LAST,FIRST MIDDLE." G NAME
 S X=NAME X $P(^DD(2,.01,0),"^",5,99) I '$D(X) W !,"Invalid name format! Please try again." G NAME
 Q NAME
 ;
GETDEBUG() S DEBUG=""
DEBUG R !,"Show debug messages? ",DEBUG
 I DEBUG="" Q ""
 I $E(DEBUG)="?" W !,"Answer YES or NO. If YES is selected, then information about each entry cloned will be displayed." G DEBUG
 I "YN01"'[$E(DEBUG) W !,"Please answer YES or NO." G DEBUG
 S DEBUG=$E(DEBUG),DEBUG=$S("N0"[DEBUG:0,1:1)
 Q DEBUG
 ;
