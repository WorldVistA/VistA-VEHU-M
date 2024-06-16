PRC229 ;HDSO/JAB - TRANSACTION UTILITY PROGRAM ; 27 FEB 2024
 ;;5.1;IFCAP;**229**;;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^DIC in ICR #10006
 ; Reference to $$FIND1^DIC in ICR #2051
 ; Reference to UPDATE^DIE in ICR #2053
 ; Reference to $$SITE^VASITE in ICR #10112
 ; Reference to $$DT^XLFDT in ICR #10103
 ; Reference to $$FMADD^XLFDT in ICR #10103
 ; Reference to SENDMSG^XMXAPI in ICR #2729
 ; Reference to MES^XPDUTL in ICR #10141
 ; Reference to $$PROD^XUPROD in ICR #4440
 Q
EN ;Entry point to kill 0 site and 0 FCP entries from FUND CONTROL POINT file 420
 ;PRCPRVST - previous site
 ;PRCSITE - current site
 ;PRCFCP - FCP
 ;PRCCNT - Count of 0 nodes deleted
 ;PRCBKUP - Backup location of 0 nodes deleted
 N PRCPRVST,PRCSITE,PRCFCP,PRCCNT,PRCBKUP
 S U="^"
 S DT=$$DT^XLFDT
 I '$D(^XTMP("PRC229")) S ^XTMP("PRC229",0)=$$FMADD^XLFDT(DT,90)_U_DT
 S PRCSITE="" F  S PRCSITE=$O(^PRC(420,PRCSITE)) Q:PRCSITE=""  D
 . ;PRCMSG - Email message
 . ;PRCMESS - PRC message
 . ;PRCXTMP - ^XTMP message
 . ;PRCBDND - PRC bad node
 . ;PRCBDMSG - Bad node message
 . ;PRCMSGLN - Email message line number
 . ;This email info is not static and skips over static portions (PRCMSGLN=5) of email
 . N PRCMSG,PRCMESS,PRCXTMP,PRCBDND,PRCBDMSG,PRCMSGLN
 . S PRCMSGLN=5,PRCCNT=0,(PRCPRVST,PRCXTMP)=""
 . S PRCFCP="" F  S PRCFCP=$O(^PRC(420,PRCSITE,1,PRCFCP)) Q:PRCFCP=""  D
 . . I PRCPRVST'=PRCSITE  S PRCCNT=0,PRCPRVST=PRCSITE
 . . I PRCSITE=0 D
 . . . M ^XTMP("PRC229",DT,PRCSITE,1,PRCFCP)=^PRC(420,PRCSITE,1,PRCFCP)
 . . . K ^PRC(420,PRCSITE,1,PRCFCP)
 . . . S PRCMSG(PRCMSGLN)="     A SITE that was 0 that had an FCP of "_PRCFCP_"."
 . . . S PRCXTMP="backup in ^XTMP(PRC229,"_DT_","_PRCSITE_",1,"_PRCFCP_")."
 . . . S PRCBDND="     Deleted ^PRC(420,"_PRCSITE_",1,"_PRCFCP_")"
 . . . S PRCMSGLN=PRCMSGLN+1
 . . . S PRCCNT=PRCCNT+1
 . . . S PRCBDMSG(PRCCNT)=PRCBDND_"  "_PRCXTMP
 . . I (PRCSITE'=0),(PRCFCP=0),$D(^PRC(420,PRCSITE,1,PRCFCP,4))'=0  D
 . . . M ^XTMP("PRC229",DT,PRCSITE,1,PRCFCP,4)=^PRC(420,PRCSITE,1,PRCFCP,4)
 . . . K ^PRC(420,PRCSITE,1,PRCFCP,4)
 . . . S PRCMSG(PRCMSGLN)="     A FCP that was 0 for SITE "_PRCSITE_"."
 . . . S PRCXTMP="backup in ^XTMP(PRC229,"_DT_","_PRCSITE_",1,"_PRCFCP_",4)."
 . . . S PRCBDND="     Deleted ^PRC(420,"_PRCSITE_",1,"_PRCFCP_",4)"
 . . . S PRCMSGLN=PRCMSGLN+1
 . . . S PRCCNT=PRCCNT+1
 . . . S PRCBDMSG(PRCCNT)=PRCBDND_"  "_PRCXTMP
 . . . Q
 . . Q
 . I (PRCCNT>0) D EMAIL
 Q
EMAIL ;
 N PRCSUBJ,PRCSTA,PRCENVTP,XMTO,PRCBDCNT
 S PRCSUBJ="0 Site and/or FCP Deleted by Nightly Job in "_PRCSITE_"."  ;Must < 65 chars
 S PRCSUBJ=$TR($E(PRCSUBJ,1,65),U," ")
 S PRCSTA=$$SITE^VASITE
 S PRCENVTP=$S($$PROD^XUPROD(1):"PRODUCTION",1:"TEST")
 S PRCMSG(1)="Good morning,"
 S PRCMSG(2)=" "
 S PRCMSG(3)="When you receive this email, it indicates inaccessible data with a 0 site and/or 0 FCP was created in past 24 hours."
 S PRCMSG(3)=PRCMSG(3)_"  The nightly Delete Site/FCP=0 [PRC DELETE SITE/FCP=0] job that runs at 3:00 am found "
 S PRCMSG(4)="this data, made a backup of it, and deleted these entries:"
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)=" "
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)="Please contact your Budget Analyst team to ask what options they were using involving FCPs in the past 24 hours such"
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)="as Carry Forward Quarterly or Release Transaction, or any other activity related to FCP's and if they encountered any"
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)="FCP issues."
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)=" "
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)="Please submit a Service Now ticket after finding out details from the Budget Analyst team and include these findings"
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)="which the IT support team will require to research."
 F PRCBDCNT=1:1:PRCCNT S PRCMSGLN=PRCMSGLN+1,PRCMSG(PRCMSGLN)=PRCBDMSG(PRCBDCNT)
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)=" "
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)="We are attempting to identify and improve the IFCAP software functionality that causes these 0's to be created."
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)=" "
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)="Thank you."
 S PRCMSGLN=PRCMSGLN+1
 S PRCMSG(PRCMSGLN)=" "
 S PRCMSGLN=PRCMSGLN+1
 M PRCMSG=PRCMESS
 S XMTO("VHATUCPRC229Distribution@domain.ext")=""  ;wrapper email group   
 D SENDMSG^XMXAPI(DUZ,PRCSUBJ,"PRCMSG",.XMTO)
 Q
SCHED229 ;
 D MES^XPDUTL("Setting up TASKMAN scheduling.")
 N DA,DIC,DIE,DR,DT,FDA,DIIEN,DIMSGA,X,Y,PRCOPIEN,PRCSCIEN,PRCTOM
 S DT=$$DT^XLFDT()  ;Current Date in FM
 S X="PRC DELETE SITE/FCP=0"  ;OPTION NAME
 S DIC=19
 D ^DIC
 S FDA(19.2,"?+1,",.01)=+Y  ;IEN from DIC 19
 S FDA(19.2,"?+1,",2)=DT_".03"  ;Install date & daily run time
 S FDA(19.2,"?+1,",6)="1D"  ;Frequency every 1 day
 S FDA(19.2,"?+1,",11)=".5" ; Run as POSTMASTER
 D UPDATE^DIE(,"FDA","DIEN","DIMSGA")
 S PRCTOM=$$FMADD^XLFDT(DT,1) ;Add 1 day to FM date
 S PRCOPIEN=$$FIND1^DIC(19,"","OX","PRC DELETE SITE/FCP=0","B")
 S PRCSCIEN=$$FIND1^DIC(19.2,"","B","PRC DELETE SITE/FCP=0","B")
 I $P(^DIC(19,PRCOPIEN,0),U,1)="PRC DELETE SITE/FCP=0",PRCSCIEN'="" D 
 . D MES^XPDUTL("Option 'PRC DELETE SITE/FCP=0' is scheduled to start running on "_PRCTOM_" at 3 am.")
 . D MES^XPDUTL("It is "_PRCOPIEN_" in OPTION (#19) file and "_PRCSCIEN_" in OPTION SCHEDULING (#19.2) file.")
 Q 
