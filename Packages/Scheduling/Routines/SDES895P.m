SDES895P ;ALB/TJB,MGD - SD*5.3*895 Post Init Routine ; OCT 31, 2024
 ;;5.3;SCHEDULING;**895**;AUG 13, 1993;Build 11
 ;;Per VHA Directive 6402, this routine should not be modified
 ;;
 Q
 ;
EN ; Update the VS GUI version in #409.98
 D FIND
 D TASK
 D TASK2
 D TASK3
 Q
 ;
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("")
 D MES^XPDUTL("   Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.62
 S DA=SDECDA,DIE=409.98,DR="2///1.7.62;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.62;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("   VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
 ;
 ;
TASK ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*895 Post-Install to remove INACTIVE PREFRENCE field (#1)")
 D MES^XPDUTL("   in the SDEC PREFERENCES AND SPECIAL NEEDS file (#409.845)")
 D MES^XPDUTL("   is being queued to run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*895 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="CLEAN409845^SDES895P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
CLEAN409845 ;
 ;Post install to remove any SNAPs in 409.8451 that are inactive
 N CIEN,SUB,SDMSG,SDFDA
 S CIEN=0
 F  S CIEN=$O(^SDEC(409.845,CIEN)) Q:'+CIEN  D
 . S SUB=0
 . F  S SUB=$O(^SDEC(409.845,CIEN,1,SUB)) Q:'+SUB  D
 .. N INACT
 .. S INACT=$$GET1^DIQ(409.8451,SUB_","_CIEN_",",4,"I")
 .. ; Delete the inactive record
 .. I INACT'="" S SDFDA=$NA(SDFDA(409.8451,SUB_","_CIEN_",")),@SDFDA@(.01)="@" D UPDATE^DIE("","SDFDA","","SDMSG")
 Q
 ;
TASK2 ;
 K ^XTMP("SDES895P")
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*895 Post-Install to correct the spelling of CANCELLED on days with")
 D MES^XPDUTL("   full day cancellations (#44.005) in the HOSPITAL LOCATION file (#44) is")
 D MES^XPDUTL("   being queued to run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*895 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="CANCELCLEANUP^SDES895P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
CANCELCLEANUP ;
 N CLINICIEN,DATE,FDA,PATTERN,CANCELMESSAGE,COUNT
 ;
 S CLINICIEN=0,COUNT=0
 F  S CLINICIEN=$O(^SC(CLINICIEN)) Q:'CLINICIEN  D
 .S DATE=$$GETSUB^SDES2UTIL(DT)
 .F  S DATE=$O(^SC(CLINICIEN,"ST",DATE)) Q:'DATE  D
 ..I '$D(^SC(CLINICIEN,"ST",DATE,"CAN")) Q
 ..;
 ..S CANCELMESSAGE="   "_$E($P(DATE,"."),6,7)_"    **CANCELLED**"
 ..S PATTERN=$$GET1^DIQ(44.005,DATE_","_CLINICIEN_",",1)
 ..;
 ..I PATTERN["[" Q
 ..I PATTERN=CANCELMESSAGE Q
 ..;
 ..S FDA(44.005,DATE_","_CLINICIEN_",",1)=CANCELMESSAGE
 ..D FILE^DIE(,"FDA") K FDA
 ..S COUNT=COUNT+1
 ;
 S ^XTMP("SDES895P",1)=""
 S ^XTMP("SDES895P",2)="A total of "_COUNT_" records were corrected"
 S ^XTMP("SDES895P",3)=""
 S ^XTMP("SDES895P",4)="SDES895P post install has run to completion."
 D MAIL
 Q
 ;
MAIL ;
 ; Get Station Number
 ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 ;
 ; Send MailMan message
 S XMDUZ=DUZ
 S XMY(XMDUZ)=""
 S XMTEXT="^XTMP(""SDES895P"","
 S XMSUB=MESS1_"SD*5.3*895 post install for Cancellation Data Cleanup"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 D ^XMD
 Q
 ;
TASK3 ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*895 Post-Install to populate new comment auditing multiples in the")
 D MES^XPDUTL("   RECALL REMINDERS file (#403.5) and the RECALL REMINDERS REMOVED file (#403.56)")
 D MES^XPDUTL("   is being queued to run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*895 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="COMMCONV^SDES895P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
COMMCONV  ; Save existing Comment data into the new Comment Audit mults
 ;
 N RRREMIEN,RECREQIEN,COMMENTS,FDA
 S RECREQIEN=0
 F  S RECREQIEN=$O(^SD(403.5,RECREQIEN)) Q:'RECREQIEN  I $D(^SD(403.5,RECREQIEN,0)) D
 . S COMMENTS=$$GET1^DIQ(403.5,RECREQIEN,2.5,"E") I $L(COMMENTS) D
 . . Q:$D(^SD(403.5,RECREQIEN,2))
 . . S FDA(403.57,"+1,"_RECREQIEN_",",.01)=$$GET1^DIQ(403.5,RECREQIEN,7.5,"I")
 . . S FDA(403.57,"+1,"_RECREQIEN_",",1)=$$GET1^DIQ(403.5,RECREQIEN,7,"I")
 . . S FDA(403.57,"+1,"_RECREQIEN_",",2)=COMMENTS
 . . D UPDATE^DIE("","FDA") K FDA
 ;
 S RRREMIEN=0
 F  S RRREMIEN=$O(^SD(403.56,RRREMIEN)) Q:'RRREMIEN  I $D(^SD(403.56,RRREMIEN,0)) D
 . S COMMENTS=$$GET1^DIQ(403.56,RRREMIEN,2.5,"E") I $L(COMMENTS) D
 . . Q:$D(^SD(403.56,RRREMIEN,4))
 . . S FDA(403.58,"+1,"_RRREMIEN_",",.01)=$$GET1^DIQ(403.56,RRREMIEN,7.5,"I")
 . . S FDA(403.58,"+1,"_RRREMIEN_",",1)=$$GET1^DIQ(403.56,RRREMIEN,7,"I")
 . . S FDA(403.58,"+1,"_RRREMIEN_",",2)=COMMENTS
 . . D UPDATE^DIE("","FDA") K FDA
 Q 
