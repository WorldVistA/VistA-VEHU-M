ZZHFEUSR ; SEB - Set up HMP UI CONTEXT for HFE users
 ;;1.0;VistA Data Support;;JUNE 4, 2016;Build 23
USERS S IEN=0 F  S IEN=$O(^ZZHFEUSR(IEN)) Q:IEN=""  D HMPUSR(IEN)
 Q
 ;
HMPUSR(IEN)
 I $G(^VA(200,IEN,0))="" W !,"User #",IEN," not found!" Q
 S DA(1)=IEN,DIC="^VA(200,"_IEN_",203,",DIC(0)="NX",X="HMP UI CONTEXT"
 D ^DIC
 I Y'=-1 W !,"User #",IEN,": Menu option already on file!" Q
 S DA(1)=IEN,DIC="^VA(200,"_IEN_",203,",DIC(0)="LNX",X="HMP UI CONTEXT"
 D ^DIC
 I Y=-1 W !,"User #",IEN,": Update unsuccessful!"
 E  W !,"User #",IEN,": Update successful!"
 Q
 ;
