SDES864P ;ALB/MGD,ANU - SD*5.3*864 Post Init Routine ; Nov 02, 2023
 ;;5.3;SCHEDULING;**864**;AUG 13, 1993;Build 15
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
EN ; Update the VS GUI version in #409.98
 D FIND
 D TASK ;Update #409.85
 Q
 ;
 ; Update CURRENT STATUS (#23) in SDEC APPT REQUEST (#409.85) File to "O" if "OPEN" value found
 ; Update CURRENT STATUS (#23) in SDEC APPT REQUEST (#409.85) File to "C" if "CLOSED" value found
TASK ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*864 Post-Install (Update of #409.85) is being queued ")
 D MES^XPDUTL("   to run in the background.  This Post-install will update ")
 D MES^XPDUTL("   CURRENT STATUS (#23) in SDEC APPT REQUEST (#409.85) File")
 D MES^XPDUTL("   to O if OPEN value found and update CURRENT STATUS (#23) ")
 D MES^XPDUTL("   in SDEC APPT REQUEST (#409.85) File to C if CLOSED value found.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*864 Post Install Routine (Update of #409.85)"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="UPD85^SDES864P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("")
 D MES^XPDUTL("   Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.51
 S DA=SDECDA,DIE=409.98,DR="2///1.7.51;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.51;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("   VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
UPD85 ; entry point
 ;
 ; Update CURRENT STATUS (#23) in SDEC APPT REQUEST (#409.85) File to "O" if "OPEN" value found
 ; Update CURRENT STATUS (#23) in SDEC APPT REQUEST (#409.85) File to "C" if "CLOSED" value found
 ;
 N SDDFN85,REQUESTIEN,SDCOUNT
 S SDCOUNT=0
 S ^XTMP("SDES864P",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Update CURRENT STATUS (#23) in SDEC APPT REQUEST (#409.85) File."
 ;
 ;Loop through entries in file #409.85
 S SDDFN85=0 F  S SDDFN85=$O(^SDEC(409.85,"B",SDDFN85)) Q:SDDFN85'>0  D
 .S REQUESTIEN="" F  S REQUESTIEN=$O(^SDEC(409.85,"B",SDDFN85,REQUESTIEN)) Q:REQUESTIEN=""  D
 ..N SDR85,FDA,ERR
 ..S SDR85=$G(^SDEC(409.85,REQUESTIEN,0)) Q:SDR85=""
 ..I $P($G(SDR85),"^",17)="OPEN" D
 ...S FDA(409.85,REQUESTIEN_",",23)="O"
 ...D FILE^DIE(,"FDA","ERR")
 ...;S $P(^SDEC(409.85,REQUESTIEN,0),"^",17)="O" ;Current status (#23)
 ...S SDCOUNT=SDCOUNT+1
 ..I $P($G(SDR85),"^",17)="CLOSED" D
 ...S FDA(409.85,REQUESTIEN_",",23)="C"
 ...D FILE^DIE(,"FDA","ERR")
 ...;S $P(^SDEC(409.85,REQUESTIEN,0),"^",17)="C"
 ...S SDCOUNT=SDCOUNT+1
 S ^XTMP("SDES864P","STATUS","CNT")=SDCOUNT
 D MAIL
 Q
 ;
MAIL ;
 ; Get Station Number
 ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM,TEXT
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 ;
 ; Send MailMan message
 S XMDUZ=DUZ
 S XMTEXT="TEXT("
 S TEXT(1)="The SD*5.3*864 post install has run to completion."
 S TEXT(2)="The data was reviewed and updated without any issues."
 S XMSUB=MESS1_"SD*5.3*864 - Post Install Update"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 D ^XMD
 Q
 ;
