ZZFILE ;
 S DIC="^DIZ(500007,",DIC(0)="AEQMZ" D ^DIC
 S (NEXT,DA(2))=+Y
 S DIC="^DIZ(500007,NEXT,1," D ^DIC
 S (NEXT1,DA(1))=+Y
 S DR=.01 S DIE="^DIZ(500007,NEXT,1,NEXT1,1,"
 D EDKYW
 Q
EDKYW ;
 S DA=0 F ZZIX=1:1:3 S ZZDAS=DA S DA=$O(^DIZ(500007,NEXT,1,NEXT1,1,DA)) D:DA'?.N CHKS D ^DIE
 Q
CHKS ;
 I ZZIX<4 S DA=ZZDAS+1 S ZZDAS=ZZDAS+1
 
 Q
