DVBA184P ;ALB/GAK - PATCH DVBA*2.7*184 POST-INSTALL ;11/26/2012
 ;;2.7;AMIE;**184**;Apr 10, 1995;Build 10
 ;
 Q  ;NO DIRECT ENTRY
 ;
ENV ;Main entry point for Environment check point.
 ;
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 ;
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 ;
 D POST1  ;Convert to IDES codes (#396.3, #9) and X-Ref
 ;
 Q
 ;
 ;
POST1 ;Set up TaskMan to convert Priority Of Exam codes DCS and DFD to IDES in the background
 N ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="SETIDES^DVBA184P"
 S ZTDESC="Convert Priority Of Exam codes DCS and DFD to IDES for DVBA*2.7*184"
 ;Queue Task to start in 60 seconds
 S ZTDTH=$$SCH^XLFDT("60S",$$NOW^XLFDT)
 S ZTIO=""
 D ^%ZTLOAD
 D BMES^XPDUTL("*****")
 D
 . I $D(ZTSK)[0 D  Q
 . .D MES^XPDUTL("TaskMan run to convert Priority Of Exam codes DCS and DFD to IDES was not started.")
 . .D MES^XPDUTL("Re-run Post Install routine POST1^DVBA179P.")
 . D MES^XPDUTL("Task "_ZTSK_" started to populate new Date field.")
 . I $D(ZTSK("D")) D
 . . D MES^XPDUTL("Task will start at "_$$HTE^XLFDT(ZTSK("D")))
 D MES^XPDUTL("*****")
 ;
 Q
 ;
 ;
SETIDES ;Convert Priority Of Exam codes DCS and DFD to IDES
 ;
 D MES^XPDUTL("Converting file 396.3 field 9 priority of exam codes DCS and DFD to IDES.")
 D MES^XPDUTL("Updating cross-reference 'ADP2' of file 396.3 to reflect conversion to IDES priority of exam code.")
 N DVBAFDA,DVBSTART,DVBMESS,DVBQUIT
 N POE,XIEN,XERR,DVBCTR,DVBECTR
 S DVBSTART=$$NOW^XLFDT()
 S DVBCTR=0,DVBECTR=0,DVBQUIT=0
 S XIEN=0
 F  S XIEN=$O(^DVB(396.3,XIEN)) Q:XIEN=""!('XIEN)!(DVBQUIT=1)  D
 . Q:'$D(^DVB(396.3,XIEN,0))
 . S POE=$$GET1^DIQ(396.3,XIEN_",",9,"I","","XERR")
 . I POE="DCS"!(POE="DFD") D
 .. K DVBAFDA,XERR
 .. S DVBAFDA(396.3,XIEN_",",9)="IDES"
 .. D FILE^DIE("","DVBAFDA","XERR")
 .. I $G(XERR)'="" D MES^XPDUTL("POST INSTALL ERROR: FILE 396.3 IEN: "_XIEN_" HAS ISSUE: "_XERR) S DVBECTR=DVBECTR+1 Q
 .. D MES^XPDUTL("Converted FILE 396.3 IEN: "_XIEN_" POE: "_POE_" to IDES")
 .. S DVBCTR=DVBCTR+1
 . ;
 . I $$S^%ZTLOAD D  Q  ;check for task stop request
 .. S DVBMESS=2
 .. S DVBMESS(1)="Patch DVBA*2.7*184 Converting Priority Of Exam Task Stopped by User"
 .. S DVBMESS(2)="Re-run Post Install routine POST2^DVBA179P."
 .. S (ZTSTOP,DVBQUIT)=1
 ;
 I DVBCTR=0 D MES^XPDUTL("I DID NOT FIND ANY PRIORITY OF EXAM CODES OF DCS OR DFD TO CONVERT")
 D MES^XPDUTL("FILE 396.3 conversion to IDES count: "_DVBCTR)
 D MES^XPDUTL("FILE 396.3 conversion to IDES error count: "_DVBECTR)
 ;
 D NOTIFY(DVBSTART,DVBCTR,DVBECTR,.DVBMESS)
 ;
 Q
 ;
 ;
NOTIFY(DVBSTIME,DVBCTR,DVBECTR,DVBMESS) ;send job msg
 ;
 ;  Input
 ;
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 N DVBSITE,DVBETIME,DVBTEXT,DVBI,SUBCTR
 S DVBSITE=$$SITE^VASITE
 S DVBETIME=$$NOW^XLFDT
 S XMDUZ="Convert Priority Of Exam codes DCS and DFD to IDES"
 S XMSUB="Patch DVBA*2.7*184"
 S XMTEXT="DVBTEXT("
 S XMY(DUZ)=""
 S DVBTEXT(1)=""
 S DVBTEXT(2)="          Facility Name:  "_$P(DVBSITE,U,2)
 S DVBTEXT(3)="         Station Number:  "_$P(DVBSITE,U,3)
 S DVBTEXT(4)=""
 S DVBTEXT(5)="  Date/Time job started:  "_$$FMTE^XLFDT(DVBSTIME)
 S DVBTEXT(6)="  Date/Time job stopped:  "_$$FMTE^XLFDT(DVBETIME)
 S DVBTEXT(7)=""
 I $G(DVBMESS) D
 . F DVBI=1:1:DVBMESS D
 .. S SUBCTR=7_"."_DVBI
 .. S DVBTEXT(SUBCTR)="*** "_$E($G(DVBMESS(DVBI)),1,70)
 I '$G(DVBMESS) D
 . S DVBTEXT(8)="PRIORITY OF EXAM (#9) Field Conversion Complete"
 . S DVBTEXT(9)="Total 2507 REQUEST (#396.3) Records Updated: "_DVBCTR
 D ^XMD
 ;
 Q
