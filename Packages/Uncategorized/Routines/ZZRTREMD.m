ZZRTREMD ;JF/ISC1 - Remove duplicate entries in RT MOVEMENT HISTORY File
 ;;Class 3 software
 ;
 S DIK="^RTV(190.3,"
 S REC=0
RESTART F  S REC=$O(^RTV(190.3,"B",REC)) Q:REC=""  D CHKRECD
 K REC,TEMP,CLDATA,ASSOC,MOVE,MHDATA,DIK,DA
 Q
CHKRECD S TEMP=$G(^RT(REC,"CL"))
 I TEMP="" W !,"No CL node for record #",REC Q
 S CLDATA=$P(TEMP,"^",5,8),ASSOC=$P(TEMP,"^",2)
 I ASSOC="" W !,"No associated movement in CL node of record #",REC Q
 D ALLNODES
 Q
ALLNODES F MOVE=0:0 S MOVE=$O(^RTV(190.3,"B",REC,MOVE)) Q:MOVE=""  D CHKMOVE
 Q
CHKMOVE S MHDATA=$G(^RTV(190.3,MOVE,0))
 I MHDATA="" W !,"Missing movement #",MOVE Q
 I $P(MHDATA,"^",2)]"" Q
 I CLDATA=$P(MHDATA,"^",5,8)&(ASSOC'=MOVE) D MOVEDEL
 Q
MOVEDEL S DA=MOVE
 ;D ^DIK
 W !,"Movement History entry #",MOVE," has been removed"
 Q
