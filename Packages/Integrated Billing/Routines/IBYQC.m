IBYQC ;ALB/ARH - POST INIT FOR COB PATCH ; 5/1/97
 ;;2.0;INTEGRATED BILLING;**80**;21-MAR-94
 ;
POST ;
 D MES^XPDUTL("  "),MES^XPDUTL("    Post-Install ....")
 D ERRCD ;             modify error code
 D OF ;                update Date Element Fields for Output Formater
 ;
 D OC^IBYQCFO ;        add Occurrence Codes
 D CC^IBYQCFC ;        add Condition Codes
 ;
 D CV^IBYQCCV ;        update 399 - convert Condition Codes and add Bill Payer
 D MES^XPDUTL("    Post-Install Completed"),MES^XPDUTL("  ")
 Q
 ;
ERRCD ; modify error code IB054 description, used if no valid Bill Payer
 N DIE,DIC,DA,DR,X,Y,IBDESC
 S IBDESC="Bill Payer is not an Insurance that will reimburse, check Payer Sequence."
 S DA=$O(^IBE(350.8,"C","IB054",0)) Q:'DA
 S DIE="^IBE(350.8,",DR=".02////"_IBDESC D ^DIE
 D MES^XPDUTL("      *  Error Code Updated (#350.8)")
 Q
 ;
OF ; Output Formater:  reset Data Elements (364.7,.03) for 2 HCFA 1500 Form Fields
 N OLD,NEW,DA,DIC,DIE,DR,X,Y
 ;
 ; change TOTAL CHARGE (BX-28) (315) from N-TOTAL CHARGES LESS OFFSET (152) to N-TOTAL CHARGES (95)
 ;
 S DA=315
 S OLD=$O(^IBA(364.5,"B","N-TOTAL CHARGES LESS OFFSET",0))
 S NEW=$O(^IBA(364.5,"B","N-TOTAL CHARGES",0))
 I +OLD,+NEW,$P($G(^IBA(364.7,DA,0)),U,3)=OLD S DIE="^IBA(364.7,",DR=".03////"_NEW D ^DIE
 ;
 ; change TOTAL PRIOR PAYMENTS (BX-29) (346) from N-PRIOR PAYMENTS (156) to N-OFFSET AMOUNT (217)
 ;
 S DA=346
 S OLD=$O(^IBA(364.5,"B","N-PRIOR PAYMENTS",0))
 S NEW=$O(^IBA(364.5,"B","N-OFFSET AMOUNT",0))
 I +OLD,+NEW,$P($G(^IBA(364.7,DA,0)),U,3)=OLD S DIE="^IBA(364.7,",DR=".03////"_NEW D ^DIE
 ;
 D MES^XPDUTL("      *  Output Formatter Fields Updated (#364.7)")
 Q
