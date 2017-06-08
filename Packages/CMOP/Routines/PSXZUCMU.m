PSXZUCMUP ;CLEAN UP ROUTINE AT CMOP  ; Compiled 1999-09-23 10:25AM for M/WNT
 ;
 R !,"Enter internal entry number of transmission you wish to mark as cancelled and processed in file 552.4: ",TRA
 Q:$G(TRA)["^"!($G(TRA)="")  
 Q:'$G(^PSX(552.4,TRA,0))
 F ZZ=0:0 S ZZ=$O(^PSX(552.4,TRA,1,ZZ)) Q:'ZZ  S DA(1)=TRA,DA=ZZ,DIE="^PSX(552.4,"_DA(1)_",1,",DR="1////2;9////3" D ^DIE K DA,DIE,DR W !,ZZ
 Q
5522 R !,"Enter the transmission name, for example 500-1234: ",NA
 Q:$G(NA)["^"!($G(NA)="")  
 S ZZ=""  F  S ZZ=$O(^PSX(552.2,"AQ",NA,ZZ)) Q:'ZZ  S DA=ZZ,DIE="^PSX(552.2,",DR="1////3;3////"_$H D ^DIE W !,ZZ K DIE,DR,ZZ
 Q  
