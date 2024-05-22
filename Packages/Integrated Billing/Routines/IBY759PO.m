IBY759PO ;EDE/WCJ - POST-INSTALL FOR IB*2.0*759 ;13-JUL-2018
 ;;2.0;INTEGRATED BILLING;**759**;21-MAR-94;Build 24
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IA# 10141 - MES^XPDUTL
 ;
EN ;Entry Point
 N IBA
 S IBA(2)="IB*2*759 Post-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 D UPDERR
 ;;JWS;7/11/22;reset PCR query date to enable all sites to catchup with PCR data collection
 S $P(^IBE(350.9,1,8),"^",22)=""
 S IBA(2)="IB*2*759 Post-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
UPDERR ; Update existing error code message for 350.8
 N IBCODE,IBMESN,IBIEN,DIE,DIC,DA,DR,X,Y
 S IBCODE="IB400",IBMESN="The destination payer is not authorized to receive Medicare"
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB401",IBMESN="excluded services electronically."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 Q
 ;
CREATE ;Create entry for IB error file in D350.8 if not there
 S DIC="^IBE(350.8,",DIC(0)="",X=IBCODE D FILE^DICN K DIC,X
 I Y=-1 D MES^XPDUTL(">> IB ERROR - Entry '"_IBCODE_"' was unable to be created <<") Q
 S IBIEN=+Y
 S DIE="^IBE(350.8,",DA=IBIEN,DR=".02////"_IBMESN_";.03////"_IBCODE_";.04////1;.05////1" D ^DIE K DIE,DIC,DA,DR
 Q
 ;
