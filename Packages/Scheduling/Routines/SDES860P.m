SDES860P ;ALB/MGD,ANU - SD*5.3*860 Post Init Routine ; Aug 04, 2023
 ;;5.3;SCHEDULING;**860**;AUG 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Update E-Checkin Allowed (#20) in Hospital Location (#44) file to "No" if null value or blank found
 ; Update Pre-Checkin Allowed (#21) in Hospial Location (#44) file to "No" if null value or blank found
 ;
 Q
 ;
EN ; Update the VS GUI version in #409.98
 D FIND
 D UPD44 ; Update #20 and #21 fields of #44 file
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("")
 D MES^XPDUTL("   Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.48
 S DA=SDECDA,DIE=409.98,DR="2///1.7.48;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.48;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("   VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
 ;
UPD44 ; entry point for updating #44 file
 N SDIEN,SDNAME,SDFDA,SDERR,SDCOUNT
 S SDCOUNT=0
 D MES^XPDUTL("")
 D MES^XPDUTL("Updating of Fields #20 and #21 in HOSPITAL LOCATION (#44) FILE...")
 D MES^XPDUTL("")
 S SDNAME=""
 F  S SDNAME=$O(^SC("B",SDNAME)) Q:SDNAME=""  F SDIEN=0:0 S SDIEN=$O(^SC("B",SDNAME,SDIEN)) Q:'SDIEN  D
 . K SDERR,SDFDA
 . I $P($G(^SC(SDIEN,0)),U,26)="" S SDFDA(44,SDIEN_",",20)=0 ; E-Checkin Allowed
 . I $P($G(^SC(SDIEN,0)),U,27)="" S SDFDA(44,SDIEN_",",21)=0 ; Pre-Checkin Allowed
 . I $D(SDFDA) D FILE^DIE(,"SDFDA","SDERR") S SDCOUNT=SDCOUNT+1
 . I $D(SDERR) D MES^XPDUTL(SDNAME_" with IEN "_SDIEN_" failed to update #20 and #21 fields in HOSPITAL LOCATION file.")
 D MES^XPDUTL("")
 D MES^XPDUTL("Update of Fields #20 and #21 in HOSPITAL LOCATION (#44) File is completed.")
 D MES^XPDUTL(SDCOUNT_" number of records in HOSPITAL LOCATION (#44) File updated.")
 D MES^XPDUTL("")
 Q
 ;
