RMPR214P ;HDSO/RJH - RMPR*3.0*214 Post-install routine; Aug 9, 2023@16:00
 ;;3.0;PROSTHETICS;**214**; 30 Oct 98;Build 3
 ;
 ;;Reference to $$ICDDX^ICDEX supported by ICR #5747
 ;;Reference to ^GMR(123,30.1) supported by ICR# 3067
 ;
 Q  ; Must be run from a specific tag
 ;
 ; ----------------------------------------------------------------------------
 ; This post-install routine, loosely based on RMPR213P, does the following:
 ; 
 ; 1. Scan the RECORD OF PROS APPLIANCE/REPAIR file (#660) to look for any
 ;    records with "-1" in the SUSPENSE ICD field (#8.8)
 ; 2. When found, the corresponding PROVISIONAL DIAGNOSIS field (#8.7), ICD10
 ;    code and CONSULT (#8.9) pointer are retrieved
 ; 3. Using the CONSULT pointer, the PROVISIONAL DIAGNOSIS CODE (#30.1) is
 ;    from the REQUEST/CONSULTATION file (#123).
 ; 4. That diagnosis code is then used to call $$ICDDX^ICDEX to return the 
 ;    correct ICD10 pointer (IEN) for the code.
 ; 5. The original record is stored in ^XTMP for potential recovery by
 ;    executing the BACKOUT^RMPR214P logic in programmer mode.
 ; 6. The corrected ICD10 code is then inserted back into the SUSPENSE ICD
 ;    field in file 660.
 ;
 ; Note: The routine is not deleted after install since it is tasked and the
 ;       BACKOUT functionality needs to remain available. A future patch can
 ;       be used to delete the routine, if needed.
 ;
 ; ============================================================================
 ; 
EN ; Main entry point
 D BMES^XPDUTL("")
 D BMES^XPDUTL($$LJ^XLFSTR("The RMPR*3.0*214 Post-Install Routine will scan the RECORD OF PROS ",80))
 D MES^XPDUTL($$LJ^XLFSTR("APPLIANCE/REPAIR file (#660) for erroneous ICD fields and if found,",80))
 D MES^XPDUTL($$LJ^XLFSTR("attempt to correct them. ",80))
 ;
 N RMPRDUZ,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ,ZTSK
 S ZTRTN="START^RMPR214P"
 S ZTDESC="RMPR*3.0*214 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S RMPRDUZ=DUZ
 S ZTSAVE("RMPRDUZ")=""
 D ^%ZTLOAD
 ;
 D BMES^XPDUTL($$LJ^XLFSTR("The RMPR*3.0*214 Post-Install Routine has been tasked.",80))
 D MES^XPDUTL($$LJ^XLFSTR("Task Number: "_$G(ZTSK),80))
 D MES^XPDUTL($$LJ^XLFSTR("You will receive a MailMan message when it completes.",80))
 D BMES^XPDUTL("")
 Q
 ;
START ; Start the correction process
 N RMPRSUB,RMPRFROM,RMPRTEXT
 ;
 S ^XTMP("RMPR*3.0*214 POST INSTALL",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^RMPR*3.0*214 POST INSTALL"
 D RMPR,MAIL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
RMPR ; Fix records in the RECORD OF PROS APPLIANCE/REPAIR file (#660)
 N RMPR,RMPR10,RMSUSICD,RMFND,RMFIXED,RMRXDT,RMCNSLT,RMICD,RMICDIEN,RMNODE
 S RMNODE="RMPR*3.0*214 POST INSTALL"
 S (RMPR,RMFND,RMFIXED)=0
 ;
 F  S RMPR=$O(^RMPR(660,RMPR)) Q:'RMPR  D
 . Q:'$D(^RMPR(660,RMPR,10))
 . S RMPR10=$G(^RMPR(660,RMPR,10))
 . S RMSUSICD=$P(RMPR10,"^",8)
 . Q:RMSUSICD'="-1"
 . ; If we're here, a bad record has been found
 . S RMFND=RMFND+1
 . S RMCNSLT=$P(RMPR10,"^",9) Q:RMCNSLT=""
 . S RMRXDT=$P(RMPR10,"^",2) S:RMRXDT'>0 RMRXDT=DT
 . Q:'$$FIND1^DIC(123,,"A",RMCNSLT)
 . S RMICD=$$GET1^DIQ(123,RMCNSLT,30.1),RMICD=$P(RMICD,U,1)
 . Q:RMICD=""
 . S RMICDIEN=$P($$ICDDX^ICDEX(RMICD,RMRXDT),"^")
 . Q:RMICDIEN<0
 . ; Now save the original and then fix the bad record
 . S ^XTMP(RMNODE,0,660,RMPR,10)=RMPR10
 . S $P(^RMPR(660,RMPR,10),"^",8)=RMICDIEN
 . S RMFIXED=RMFIXED+1
 . Q
 ;
 S ^XTMP(RMNODE,1)=" "
 S ^XTMP(RMNODE,2)="********** RMPR*3.0*214 Post-Install Routine Summary Report **********"
 S ^XTMP(RMNODE,3)=" "
 S ^XTMP(RMNODE,4)=" Records in the RECORD OF PROS APPLIANCE/REPAIR file (#660) file"
 S ^XTMP(RMNODE,5)=" have been searched for an -1 error code in the SUSPENSE ICD field."
 S ^XTMP(RMNODE,6)=" "
 S ^XTMP(RMNODE,7)=" Number of erroneous records found: "_RMFND
 S ^XTMP(RMNODE,8)="       Number of records corrected: "_RMFIXED
 S ^XTMP(RMNODE,9)=" "
 S ^XTMP(RMNODE,10)=" The original version of corrected records, if any, are stored for"
 S ^XTMP(RMNODE,11)=" 90 days at ^XTMP(""RMPR*3.0*214 POST INSTALL"",0,660,recordID)."
 S ^XTMP(RMNODE,12)=" "
 S ^XTMP(RMNODE,13)="*************************** End of Report ****************************"
 ;
 Q
 ;
MAIL ; Send MailMan message to installer and users with the RMPRMANAGER key
 S RMPRSUB="RMPR*3.0*214 Post-Install Summary Information"
 S RMPRFROM="RMPR*3.0*214 Post-Install"
 S RMPRTEXT="^XTMP(""RMPR*3.0*214 POST INSTALL"")"
 D MAILMSG(RMPRSUB,RMPRFROM,RMPRTEXT)
 Q
 ;
 ; ============================================================================
BACKOUT ; Run this from the programmer's prompt if patch backout is required
 W #
 N DIR,Y
 S DIR("A",1)="This action will back out the file modifications that were performed"
 S DIR("A",2)="after the install of RMPR*3.0*214."
 S DIR("A")="Are you sure you wish to proceed",DIR("B")="NO",DIR(0)="Y"
 D ^DIR
 Q:Y<1
 ;
 N RMBKNODE,RMPRDUZ,RMPRNF,RMPRNC,RMPRZ,RMPRREC,RMPRTEXT,RMPRMY,RMPRSUB,RMPRMIN
 N RMPRMZ,RMPRFROM
 ;
 S RMBKNODE="RMPR*3.0*214 BACKOUT"
 S RMPRDUZ=DUZ
 S ^XTMP(RMBKNODE,0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^RMPR*3.0*214 BACKOUT"
 ;
 W !!,"Please wait until the backout completes."
 W !,"Working..."
 D ICDBACK,MAILBACK
 ;
 K DIR
 N DIR
 S DIR("A",1)="MailMan message #"_RMPRMZ_" has been sent to you as well as"
 S DIR("A",2)="holders of the RMPRMANAGER security key."
 S DIR("A")="Press any key to continue"
 S DIR(0)="E" D ^DIR
 Q
 ;
ICDBACK ; Restore the previous (erroneous) records back to #660, node 10
 S (RMPRZ,RMPRNF,RMPRNC)=0
 ;
 F  S RMPRZ=$O(^XTMP("RMPR*3.0*214 POST INSTALL",0,660,RMPRZ)) Q:RMPRZ=""  D
 . S ^XTMP(RMBKNODE,0,660,RMPRZ,10)=^RMPR(660,RMPRZ,10)
 . S ^RMPR(660,RMPRZ,10)=^XTMP("RMPR*3.0*214 POST INSTALL",0,660,RMPRZ,10)
 . S RMPRNF=RMPRNF+1,RMPRNC=RMPRNC+1
 . Q
 ;
 S ^XTMP(RMBKNODE,1)=" "
 S ^XTMP(RMBKNODE,2)="**************** RMPR*3.0*214 Rollback Summary Report ****************"
 S ^XTMP(RMBKNODE,3)=" "
 S ^XTMP(RMBKNODE,4)=" Backout was run by "_$$GET1^DIQ(200,DUZ,.01)_" on "_$$FMTE^XLFDT(DT)
 S ^XTMP(RMBKNODE,5)=" "
 S ^XTMP(RMBKNODE,6)=" Number of records found to rollback: "_RMPRNF
 S ^XTMP(RMBKNODE,7)="        Number of records backed out: "_RMPRNC
 S ^XTMP(RMBKNODE,8)=" "
 S ^XTMP(RMBKNODE,9)=" The previously corrected records will be saved for 90 days at"
 S ^XTMP(RMBKNODE,10)="  ^XTMP(""RMPR*3.0*214 BACKOUT"",0,660,recordID)."
 S ^XTMP(RMBKNODE,11)=" "
 S ^XTMP(RMBKNODE,12)=" The text of this message will also be stored for 90 days at"
 S ^XTMP(RMBKNODE,13)="  ^XTMP(""RMPR*3.0*214 BACKOUT""."
 S ^XTMP(RMBKNODE,14)=" "
 S ^XTMP(RMBKNODE,15)="*************************** End of Report ****************************"
 Q
 ;
MAILBACK ; Send MailMan message with backout info to appropriate group
 S RMPRSUB="RMPR*3.0*214 Backout Information"
 S RMPRFROM="RMPR*3.0*214 BACKOUT"
 S RMPRTEXT="^XTMP(""RMPR*3.0*214 BACKOUT"")"
 D MAILMSG(RMPRSUB,RMPRFROM,RMPRTEXT)
 Q
 ;
 ; ----------------------------------------------------------------------------
MAILMSG(MSGSUBJ,MSGFROM,MSGTEXT) ; Build and send a MailMan message
 N RMPRREC,RMPRMY,RMPRMIN
 I '$D(RMPRDUZ) S RMPRDUZ=DUZ
 S RMPRMIN("FROM")=MSGFROM
 S RMPRREC=""
 F  S RMPRREC=$O(^XUSEC("RMPRMANAGER",RMPRREC)) Q:RMPRREC=""  S RMPRMY(RMPRREC)=""
 S RMPRMY(RMPRDUZ)=""
 D SENDMSG^XMXAPI(RMPRDUZ,MSGSUBJ,MSGTEXT,.RMPRMY,.RMPRMIN,.RMPRMZ,"")
 Q
