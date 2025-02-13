ICD1822P   ; ALB/JAT - NEW DIAGNOSIS CODES; 7/27/05 14:50;
 ;;18.0;DRG Grouper;**22**;Oct 13,2000
 ;
REMEDY ;
 N FDA,DA,DIE,IDENT,DR,ICMED
 ;
 ; HD135282
 ; 
 ; next line in case patch being re-installed
 I $P(^ICD9(14197,3,1,1,0),U,4)=5 G NEXT
 S FDA(1820,80,"?1,",.01)="`14197"
 S FDA(1820,80.071,"?2,?1,",.01)=3051001
 S FDA(1820,80.711,"+3,?2,?1,",.01)=406
 S FDA(1820,80.711,"+4,?2,?1,",.01)=407
 S FDA(1820,80.711,"+5,?2,?1,",.01)=408
 D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 S FDA(1820,80,"?1,",.01)="`14198"
 S FDA(1820,80.071,"?2,?1,",.01)=3051001
 S FDA(1820,80.711,"+3,?2,?1,",.01)=406
 S FDA(1820,80.711,"+4,?2,?1,",.01)=407
 S FDA(1820,80.711,"+5,?2,?1,",.01)=408
 D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ;
NEXT ;
 ; HD143411
 ; 
 S DA=4210
 S DIE="^ICD0("
 S IDENT="Og"
 S DR="2///^S X=IDENT"
 D ^DIE
 ;
 ; HD135520
 ;
 S DA=541
 S DIE="^ICD("
 S ICMED=98
 S DR="5///^S X=ICMED"
 D ^DIE
 S DA=542
 S DIE="^ICD("
 S ICMED=98
 S DR="5///^S X=ICMED"
 D ^DIE
 S DA(1)=541
 S DA=1
 S DIE="^ICD(541,66,"
 S DR=".05///^S X=ICMED"
 D ^DIE
 S DA(1)=542
 S DA=1
 S DIE="^ICD(542,66,"
 S DR=".05///^S X=ICMED"
 D ^DIE
 ;
 ; HD141351
 ; 
 D DIAG^ICD1822C
 Q
