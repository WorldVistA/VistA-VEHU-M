IB20P16B ;ALB/RFJ - Add new reason code in patch 167 post init ;11 Dec 01
 ;;2.0;INTEGRATED BILLING;**167**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
POSTINIT ;  continue post init
 ; Add new cancellation reasons into file #350.3
 ;
 D MES^XPDUTL("     -> Adding new cancellation reasons into file #350.3...")
 ;
 N D,D0,DA,DI,DIC,DIE,DQ,DR,IBCR,IBI,X,Y
 ;
 F IBI=1:1 S IBCR=$P($T(CRES+IBI),";;",2) Q:IBCR="QUIT"  D
 .   S X=$P(IBCR,"^")
 .   I $O(^IBE(350.3,"B",X,0)) D MES^XPDUTL("          * "_X_" is already on file") Q
 .   ;
 .   K DD,DO S DIC="^IBE(350.3,",DIC(0)="" D FILE^DICN Q:Y<0
 .   S DIE=DIC,DA=+Y,DR=".02////"_$P(IBCR,"^",2)_";.03////"_$P(IBCR,"^",3) D ^DIE
 .   D MES^XPDUTL("           * "_$P(IBCR,"^")_" has been filed")
 ;
 D MES^XPDUTL("        OK, I'm done!")
 Q
 ;
 ;
CRES ; Cancellation Reasons to add into file #350.3
 ;;BILLED AT HIGHER TIER RATE^HTR^2
 ;;QUIT
