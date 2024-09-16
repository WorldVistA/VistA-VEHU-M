SDES885P ;ALB/MGD,BWF - SD*5.3*885 Post Init Routine ; July 07, 2024
 ;;5.3;SCHEDULING;**885**;AUG 13, 1993;Build 5
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
EN ; Update the VS GUI version in #409.98
 D FIND
 D TASK
 D TASK2
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("")
 D MES^XPDUTL("   Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.59
 S DA=SDECDA,DIE=409.98,DR="2///1.7.59;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.59;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("   VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
TASK ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*885 Post-Install to create new indexes")
 D MES^XPDUTL("   in the SDEC APPT REQUEST file (#409.85) is being")
 D MES^XPDUTL("   queued to run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*885 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="INDEX^SDES885P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
INDEX ;
 N DIK
 S DIK="^SDEC(409.85,"
 S DIK(1)="23^EC^ECC^ESC^ESP^ES"
 D ENALL^DIK
 Q
TASK2 ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*885 Post-Install to update the SD Audit Statistics file #409.97")
 D MES^XPDUTL("   for option SDEC COMPILE AUDIT REPORT is being")
 D MES^XPDUTL("   queued to run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*885 Post Install Routine for file #409.97"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="RUN^SDES885P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
RUN ;
 N AUDITDT,AIEN,FDA,DATEARRY,COMPILEDT
 S AUDITDT=3240528
 F  S AUDITDT=$O(^SDAUDIT("C",AUDITDT)) Q:'AUDITDT  D
 .S DATEARRY(AUDITDT)=AUDITDT
 .S AIEN=0 F  S AIEN=$O(^SDAUDIT("C",AUDITDT,AIEN)) Q:'AIEN  D
 ..S FDA(409.97,AIEN_",",.01)="@" D FILE^DIE(,"FDA") K FDA
 S COMPILEDT=0 F  S COMPILEDT=$O(DATEARRY(COMPILEDT)) Q:'COMPILEDT  D
 .D COMPILE^SDECAUD(COMPILEDT)
 Q
