IB2P167C ;LL/ELZ - CHARGEMASTER POST INIT ROUTINE FOR IB*2*167 ;29-NOV-01
 ;;2.0;INTEGRATED BILLING;**167**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
CM ; this is the post init part that will update charge master with the
 ; new rate structure for tiered copayments
 ;
 N IBCS,IBCI,DINUM,DO,DIC,X,Y,DIE,DA,DR,IBCOUNT,IBITEM,IBLINE,IBDATA
 ;
 D M("   Now Updating Charge Master ...")
 S IBCS=$$CSN^IBCRU3("TL-MT OPT COPAY")
 I 'IBCS D M("**** ERROR FINDING THE CARGE SET ***") Q
 ;
 D M("   -- Deleting all charge items in Charge Set TL-MT OPT COPAY")
 S IBCI=$$DELETE^IBCRED(IBCS,"ALL")
 D M("   -- "_IBCI_" items deleted")
 ;
 D M("   -- Adding New Billable Rate")
 I '$D(^IBE(363.3,"B","TORTIOUSLY LIABLE MISC")) F DINUM=13:1  I '$D(^IBE(363.3,DINUM)) K DO S DIC="^IBE(363.3,",DIC(0)="",X="TORTIOUSLY LIABLE MISC",DIC("DR")=".02///TORT MIS;.03///1;.04///9;.05///1" D FILE^DICN Q
 ;
 D M("   -- Updating Charge Set to new type")
 S DIE="^IBE(363.1,",DA=IBCS,DR=".02///TORTIOUSLY LIABLE MISC;.03///UNASSOCIATED" D ^DIE
 ;
 D M("   -- Adding Rates in New Format")
 S IBCOUNT=0
 F IBLINE=1:1 S IBDATA=$P($T(RATES+IBLINE),";",3) Q:IBDATA=""  D
 . S IBITEM=+$$ADDBI^IBCREF("MISCELLANEOUS",$P(IBDATA,"^",2))
 . I IBITEM,$$ADDCI^IBCREF(IBCS,IBITEM,$P(IBDATA,"^"),$P(IBDATA,"^",3)) S IBCOUNT=IBCOUNT+1
 ;
 D M("   -- "_IBCOUNT_" Rates added to Charge Master")
 ;
 D M("  Charge Master Update Complete ...")
 ;
 Q
 ;
M(Y) ; send messages to KIDS to print
 D MES^XPDUTL(Y)
 Q
 ;
RATES ; copay rates to add
 ;;2921001^PRIMARY CARE^33
 ;;2921001^SPECIALTY CARE^33
 ;;2931001^PRIMARY CARE^36
 ;;2931001^SPECIALTY CARE^36
 ;;2941001^PRIMARY CARE^39
 ;;2941001^SPECIALTY CARE^39
 ;;2951001^PRIMARY CARE^41
 ;;2951001^SPECIALTY CARE^41
 ;;2961001^PRIMARY CARE^38.8
 ;;2961001^SPECIALTY CARE^38.8
 ;;2971001^PRIMARY CARE^45.8
 ;;2971001^SPECIALTY CARE^45.8
 ;;2991001^PRIMARY CARE^50.8
 ;;2991001^SPECIALTY CARE^50.8
 ;;3011206^PRIMARY CARE^15
 ;;3011206^SPECIALTY CARE^50
 ;;
