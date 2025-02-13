PXRMP21I ;SLC/PKR,AJB - Inits for PXRM*2.0*21;12/14/2011
 ;;2.0;CLINICAL REMINDERS;**21**;Feb 04, 2005;Build 152
 Q
 ;
CFINC(Y) ;List of computed findings to include in the build.
 N CFLIST,CFNAME
 S CFLIST("VA-OEF/OIF SERVICE (LIST)")=""
 S CFLIST("VA-SERVICE BRANCH")=""
 S CFLIST("VA-SERVICE SEPARATION DATES")=""
 S CFNAME=$P($G(^PXRMD(811.4,Y,0)),U)
 Q $S($D(CFLIST(CFNAME)):1,1:0)
 ;
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 I $D(^PXRMD(811.4,"B","VA-LAST SERVICE SEPARATION DATE")) D
 . N PXRMINST
 . S PXRMINST=1
 . D BMES^XPDUTL("Renaming CF VA-LAST SERVICE SEPARATION DATE to VA-SERVICE SEPARATION DATES")
 . D RENAME^PXRMUTIL(811.4,"VA-LAST SERVICE SEPARATION DATE","VA-SERVICE SEPARATION DATES")
 Q
 ;
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P21")
 D SENDIM
 Q
 ;
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*21"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*21 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@FORUM.VA.GOV")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*21"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*21 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
