GMRC167P ;ABV/MKN - Post-install GMRC*3.0*167; 12/16/19 09:23
 ;;3.0;CONSULT/REQUEST TRACKING;**167**;DEC 16, 2019;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
EN ;
 N DA,DIK,IEN38,IEN385,IENTII
 ;Remove GMRC TIER II CRNR IFC ERRORS as a MEMBER GROUP from subscription to IFC PATIENT ERROR MESSAGES mail group
 S IEN38=$O(^XMB(3.8,"B","IFC PATIENT ERROR MESSAGES","")) Q:'IEN38
 S IENTII=$O(^XMB(3.8,"B","GMRC TIER II CRNR IFC ERRORS","")) Q:'IENTII
 S IEN385=$O(^XMB(3.8,IEN38,5,"B",IENTII,"")) Q:'IEN385
 D MES^XPDUTL("Deleting mail group GMRC TIER II CRNR IFC ERRORS subscription from mail group IFC PATIENT ERROR MESSAGES")
 S DIK="^XMB(3.8,"_IEN38_",5,",DA=IEN385,DA(1)=IEN38 D ^DIK
 D MES^XPDUTL("GMRC TIER II CRNR IFC ERRORS subscription deleted from mail group IFC PATIENT ERROR MESSAGES")
 Q
 ;
