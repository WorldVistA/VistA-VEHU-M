SDES959P ;ALB/LAB - SD*5.3*959 Post Init Routine ; Jul 16, 2026
 ;;5.3;SCHEDULING;**959**;AUG 13, 1993;Build 1
 ;;Per VHA Directive 6402, this routine should not be modified
 ;;
 Q
 ;
EN ;
 D TASK
 Q
 ;
TASK ;
 D MES^XPDUTL("")
 D MES^XPDUTL(" SD*5.3*959 Post-Install to identify clinics with pattern defined after limit")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE,%,%H,%I
 S ZTDESC="SD*5.3*959 Post Install Routine Task 1"
 D NOW^%DTC
 S ZTDTH=$P($H,",",1)_","_86399,ZTIO="",ZTRTN="REPORT^SDES959P",ZTSAVE("*")=""
 D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL(" >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL(" UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL(" Please contact the National Help Desk to report this issue.")
 Q
 ;
REPORT ;
 N CLINICNAME,CLINICIEN,CLINICST,COUNT,ISSUECOUNT,COUNT,DATE,NEXTAPPT
 S CLINICNAME="",ISSUECOUNT=0
 K ^XTMP("SDES959P")
 S ^XTMP("SDES959P",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^SD*5.3*959"
 S ^XTMP("SDES959P",1)="***********************Beyond Limit Availability Report****************************"
 S COUNT=4
 S ^XTMP("SDES959P",COUNT)="Clinic IEN^Clinic Name^ST defined after limit^Appt after limit"
 S COUNT=COUNT+1
 ;Loop over all Clinics in 44
 S DATE=$$FMADD^XLFDT(DT,999)
 F  S CLINICNAME=$O(^SC("AG","C",CLINICNAME)) Q:CLINICNAME=""  D
 . S CLINICIEN=""
 . F  S CLINICIEN=$O(^SC("AG","C",CLINICNAME,CLINICIEN)) Q:CLINICIEN=""  D
 . . S CLINICST=$O(^SC(CLINICIEN,"ST",DATE))
 . . I CLINICST'="" D
 . . . S NEXTAPPT=$O(^SC(CLINICIEN,"S",CLINICST))
 . . . S ^XTMP("SDES959P",COUNT)=CLINICIEN_"^"_$$GET1^DIQ(44,CLINICIEN,.01,"E")_"^"_CLINICST_"^"_NEXTAPPT
 . . . S COUNT=COUNT+1
 S ^XTMP("SDES959P",3)="Total Number of Issues Found     : "_COUNT
 ;
 D MAIL
 Q
 ;
MAIL ;
 N SITENUMBER,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM,%,D,D0,D1,D2,DG,DIC,DICR,DIW,XMDUN,XMZ,PROD
 S SITENUMBER=+$$STA^XUAF4($$KSP^XUPARAM("INST"))
 S PROD=$$PROD^XUPROD
 S MESS1="Station: "_SITENUMBER_" ("_$S(PROD:"PROD",1:"TEST")_") - "
 S XMDUZ=DUZ
 S XMTEXT="^XTMP(""SDES959P"","
 S XMSUB=MESS1_"SD*5.3*959 - Post Install Data Report"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 I 'PROD D
 . S XMY("BARBER.LORI@FORUM.DOMAIN.EXT")=""
 I PROD D
 . S XMY("BARBER.LORI@FORUM.DOMAIN.EXT")=""
 . S XMY("DUNNAM.DAVID@FORUM.DOMAIN.EXT")=""
 . S XMY("CRUZ.ORLANDO@FORUM.DOMAIN.EXT")=""
 D ^XMD
 Q
 ;
