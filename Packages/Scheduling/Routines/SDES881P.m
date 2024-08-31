SDES881P ;ALB/MGD,BWF - SD*5.3*881 Post Init Routine ; June 07, 2024
 ;;5.3;SCHEDULING;**881**;AUG 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
EN ; Update the VS GUI version in #409.98
 D FIND
 D ADDWWII
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("")
 D MES^XPDUTL("   Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.58
 S DA=SDECDA,DIE=409.98,DR="2///1.7.58;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.58;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("   VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
ADDWWII ;
 N FDA,DESC,FDAIEN,ERR,FILEERR,NEWIEN
 Q:$D(^SD(409.1,"B","WORLD WAR II"))
 D MES^XPDUTL("")
 D MES^XPDUTL("   Adding World War II to the Appointment Type file (#409.1)")
 S FDA(409.1,"+1,",.01)="WORLD WAR II"
 S FDA(409.1,"+1,",2)=1
 S FDA(409.1,"+1,",4)="WWII"
 S FDA(409.1,"+1,",5)=1
 S FDA(409.1,"+1,",6)=$O(^DIC(8,"B","WORLD WAR II",0))
 D UPDATE^DIE(,"FDA","NEWIEN","FILEERR")
 I $D(FILEERR) D  Q
 .D MES^XPDUTL("")
 .D MES^XPDUTL("Error adding World War II to the Appointment Type file.")
 .D MES^XPDUTL("Please create a SNOW ticket and route to the Vista Scheduling")
 .D MES^XPDUTL("team.")
 S FDAIEN=$G(NEWIEN(1))
 S DESC(1)="Used for veterans who have served in World War II."
 D WP^DIE(409.1,FDAIEN_",",10,"","DESC","ERR")
 Q
