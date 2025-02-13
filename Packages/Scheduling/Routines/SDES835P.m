SDES835P ;ALB/MGD - SD*5.3*835 Post Init Routine ; Jan 06, 2023
 ;;5.3;SCHEDULING;**835**;AUG 13, 1993;Build 4
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 D FIND,ADDXREF
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.37
 S DA=SDECDA,DIE=409.98,DR="2///1.7.37;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.37;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
 ;
ADDXREF  ;ADD NEW CROSS REFERENCE
 D MES^XPDUTL("Creation of the REQPTR x-ref in SDEC CONTACT (#409.86) started.")
 D MES^XPDUTL("")
 N DIK
 S DIK="^SDEC(409.86,"
 S DIK(1)="2.3^REQPTR"
 D ENALL^DIK
 D MES^XPDUTL("Creation of the REQPTR x-ref in SDEC CONTACT (#409.86) completed.")
 Q
