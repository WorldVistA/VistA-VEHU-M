RGEDPST ;B'HAM/PTD-RGED*2.6*1 PATCH ROUTINE ;08/30/01
 ;;2.6;EXTENSIBLE EDITOR;**1**;Mar 22, 1999
 ;
 ;Delete Extensible Editor files, DDs and data.
 ;SACC Exemption granted 9/6/01 to kill unsubscripted global.
 ;Delete Extensible Editor DIALOG file entries.
 ;Reference to ^DI(.84 supported by IA #3434
 ;
ASK ;Are you ready?
 W !!
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A",1)="Before running this routine, you must set protection to"
 S DIR("A",2)="allow deletion of the unsubscripted globals as directed."
 S DIR("A",3)=""
 S DIR("A")="Are you sure you want to continue"
 D ^DIR
 I +Y'=1 W !,"No Extensible Editor files have been deleted!" G END
 ;
DIU2 ;VA FileMan delete files, DDs and data for 996 and 996.2.
 K DIU W !
 F RGEDFN=996,996.2 D
 .W !," Deleting file "_RGEDFN_"."
 .S DIU=RGEDFN,DIU(0)="D"
 .D EN^DIU2
 .K DIU
 ;Delete file and data for: 996.1.
 ;File is NOT VA FileMan compatible, therefore M Kill command used.
 W !," Deleting file 996.1."
 K ^RGED
 W !," Extensible Editor files have been deleted."
 ;
DLG ;Delete DIALOG file entries 9960001 through 9960070.
 N RGEDLOG
 W !!," Deleting Extensible Editor dialog entries.",!," "
 S DIK="^DI(.84,"
 F RGEDLOG=9960001:1:9960070 S DA=RGEDLOG D ^DIK W "."
 W !!," DIALOG entries 9960001 through 9960070 have been deleted."
 ;
END K DA,DIK,DIR,DIU,RGEDFN,RGEDLOG,X,Y
 Q
