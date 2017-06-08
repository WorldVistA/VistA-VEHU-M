IBYLPOST ;WAS/RFJ - post init for patch ib*2*58 ; 15 Mar 96
 ;;Version 2.0 ; INTEGRATED BILLING ;**58**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$G(DUZ)!($G(DUZ(0))'="@") W !!,"DUZ OR DUZ(0) NOT DEFINED." Q
 ;
 N %,DA,DATA,DIC,DIK,DR,I,IBMENU,LINE,OLDDATA,X,Y
 ;
 ;  remove "special unit si/is" (ibtrvd spec unit) from the
 ;  "expanded review menu" (ibtrvd  menu)
 S DIC(0)="X",DIC="^ORD(101,",X="IBTRVD  MENU"
 D ^DIC
 I Y>0 S IBMENU=+Y D
 .   S DIC(0)="X",DIC="^ORD(101,"_IBMENU_",10,",X="IBTRVD SPEC UNIT"
 .   D ^DIC
 .   I Y>0 S DA=+Y,DA(1)=IBMENU,DIK="^ORD(101,"_DA(1)_",10," D ^DIK
 ;
 ;  install file 356.3 entries
 L +^IBE(356.3)
 K ^TMP($J,"IBYLPOST")
 ;  build entry array for entries in 356.3
 S DA=0 F  S DA=$O(^IBE(356.3,DA)) Q:'DA  S DATA=$P($G(^(DA,0)),"^") I DATA'="" S ^TMP($J,"IBYLPOST",$P(DATA,"^"))=DA
 ;
 ;  edit existing entries
 F LINE=1:1 S DATA=$P($T(DATA+LINE),";",3,99) Q:DATA=""  D
 .   S DA=$G(^TMP($J,"IBYLPOST",$P(DATA,"^"))) I 'DA Q
 .   S OLDDATA=$G(^IBE(356.3,DA,0)) I OLDDATA="" Q
 .   S DR=""
 .   I $P(DATA,"^",2)'="" S DR=".01///"_$P(DATA,"^",2)_";"
 .   I $P(DATA,"^",3),$P(DATA,"^",3)'=$P(OLDDATA,"^",4) S DR=DR_".04///"_$P(DATA,"^",3)_";"
 .   I DR="" Q
 .   D EDIT(DA,DR)
 ;
 ;  add new entries
 F LINE=1:1 S DATA=$P($T(NEWDATA+LINE),";",3,99) Q:DATA=""  D
 .   S DA=$G(^TMP($J,"IBYLPOST",$P(DATA,"^"))) I DA Q
 .   S DR=".03///"_$P(DATA,"^",2)_";.04///"_$P(DATA,"^",3)_";"
 .   D ADD($P(DATA,"^"),DR)
 ;
 L -^IBE(356.3)
 K ^TMP($J,"IBYLPOST")
 Q
 ;
 ;
EDIT(DA,DR) ;  change the data in file 356.3
 N %,D,D0,DDER,DI,DIC,DIE,DIG,DIH,DIU,DIV,DQ,X
 S DIE="^IBE(356.3,"
 D ^DIE
 Q
 ;
 ;
ADD(NAME,DR)       ;  add name to file 356.3
 N %,D0,DD,DDER,DI,DIC,DIE,DIK,DLAYGO,DO,DQ,X,Y
 S X=NAME
 S DIC="^IBE(356.3,",DIC(0)="L",DLAYGO=356.3,DIC("DR")=DR
 D FILE^DICN
 Q
 ;
 ;
 ;  existing name ^ new name ^ level of care
DATA ;  data for file 356.3
 ;;BLOOD AND LYMPHATICS^BLOOD/LYMPH/IMMUNE^2
 ;;CARDIOVASCULAR^^2
 ;;CENTRAL NERVOUS SYSTEM/HEAD^^2
 ;;CORONARY CARE^CRITICAL CARE (CARDIAC)^1
 ;;ENDOCRINE/METABOLIC^^2
 ;;EYE, EAR, NOSE, AND THROAT^^2
 ;;FEMALE REPRODUCTIVE^^2
 ;;GASTROINTESTINAL TRACT AND ABDOMEN^^2
 ;;GENERIC^zGENERIC (1995 OBSOLETE)
 ;;INTENSIVE CARE (MED AND SURG)^CRITICAL CARE (NON CARDIAC)^1
 ;;MUSCULOSKELETAL/SPINE^^2
 ;;OBSERVATION^^3
 ;;PERIPHERAL VASCULAR^^2
 ;;PSYCHIATRIC^^3
 ;;REHABILITATION^zREHABILITATION (1995 OBSOLETE)
 ;;RESPIRATORY/CHEST^^2
 ;;SKIN/CONNECTIVE TISSUE^^2
 ;;SUBSTANCE ABUSE^zSUBSTANCE ABUSE (1995 OBSOLETE)
 ;;SUBSTANCE ABUSE (MEDICAL DETOXIFICATION)^MEDICAL DETOXIFICATION^3
 ;;TELEMETRY^^1
 ;;URINARY TRACT^GENITOURINARY^2
 ;
 ;
 ;  name ^ code ^ level of care
NEWDATA ;  new entries for file 356.3
 ;;FEMALE REPRODUCTIVE (PREGNANCY-PRETERM)^16^2
 ;;FEMALE REPRODUCTIVE (PREGNANCY-TERM)^17^2
