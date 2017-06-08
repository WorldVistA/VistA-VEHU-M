IBYQCPRE ;ALB/ARH - PRE-INSTALL FOR COB PATCH ; 5/1/97
 ;;2.0;INTEGRATED BILLING;**80**;21-MAR-94
 ;
 ;
XREF399 ; in 399, delete all xrefs for certain fields, these fields are all exported with this patch
 ; they must be deleted before the build inserts the updated fields because the xrefs have changed
 N IBX,X,Y,DIK,DA,IBFLD,IBXREF
 ;
 D BMES^XPDUTL("Pre-Installation Updates (Cross references will be updated during install)")
 ;
 F IBFLD=.11,.21,101 D
 . ;
 . S IBXREF=0 F  S IBXREF=$O(^DD(399,IBFLD,1,IBXREF)) Q:'IBXREF  D
 .. ;
 .. S DIK="^DD(399,"_IBFLD_",1,",DA(2)=399,DA(1)=IBFLD,DA=IBXREF
 .. ;
 .. D ^DIK K DIK,DA
 . ;
 . S IBX="   * ^DGCR(399,"_IBFLD_") cross references deleted." D MES^XPDUTL(IBX)
 ;
 ;
OF ; Output Formater:  reset Data Elements (364.7,.03) for 2 HCFA 1500 Form Fields
 ; this is the reverse of what happens in the post-init and is included here so the patch can be
 ; installed multiple times without problems.  These entries in 364.7 are exported with the patch then the 
 ; Data Element is changed in the post-init.  If the patch is installed a second time without this it will
 ; try to match the entries in 364.7 with the old Data Elements, since these are changed by the first install
 ; post-init it will not find them and therefore create new entries, which is incorrect
 ; 
 N OLD,NEW,DA,DIC,DIE,DR,X,Y
 ;
 ; change TOTAL CHARGE (BX-28) (315) to N-TOTAL CHARGES LESS OFFSET (152) from N-TOTAL CHARGES (95)
 ;
 S DA=315
 S OLD=$O(^IBA(364.5,"B","N-TOTAL CHARGES LESS OFFSET",0))
 S NEW=$O(^IBA(364.5,"B","N-TOTAL CHARGES",0))
 I +OLD,+NEW,$P($G(^IBA(364.7,DA,0)),U,3)=NEW S DIE="^IBA(364.7,",DR=".03////"_OLD D ^DIE
 ;
 ; change TOTAL PRIOR PAYMENTS (BX-29) (346) to N-PRIOR PAYMENTS (156) from N-OFFSET AMOUNT (217)
 ;
 S DA=346
 S OLD=$O(^IBA(364.5,"B","N-PRIOR PAYMENTS",0))
 S NEW=$O(^IBA(364.5,"B","N-OFFSET AMOUNT",0))
 I +OLD,+NEW,$P($G(^IBA(364.7,DA,0)),U,3)=NEW S DIE="^IBA(364.7,",DR=".03////"_OLD D ^DIE
 ;
 ;
 D BMES^XPDUTL("Pre-Installation Updates Completed")
 Q
