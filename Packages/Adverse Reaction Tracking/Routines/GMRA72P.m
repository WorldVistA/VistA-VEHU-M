GMRA72P ;HDSO/RJH - GMRA*4.0*72 Post-install routine; Feb 5, 2024@16:00
 ;;4.0;ADVERSE REACTION TRACKING;**72**; 30 Oct 98;Build 5
 ;
 ;
 ; Note: The routine is not deleted after install since it is tasked and the
 ;       BACKOUT functionality needs to remain available. A future patch can
 ;       be used to delete the routine, if needed.
 ;
 Q  ; Must be run from a specific tag
 ;
 ; ============================================================================
 ;
EN ; Main entry point
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("  The GMRA*4.0*72 Post-Install Routine will scan the PATIENT ALLERGIES file")
 D MES^XPDUTL("  file (#120.8) for pointers to inactive drug records in the GMR ALLERGY")
 D MES^XPDUTL("  file (#120.82). If found, this patch will attempt to correct those records.")
 ;
 N GMRADUZ,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ,ZTSK
 S ZTRTN="START^GMRA72P"
 S ZTDESC="GMRA*4.0*72 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S GMRADUZ=DUZ
 S ZTSAVE("GMRADUZ")=""
 D ^%ZTLOAD
 ;
 D BMES^XPDUTL("  The GMRA*4.0*72 Post-Install Routine has been tasked.")
 D MES^XPDUTL("  Task Number: "_$G(ZTSK))
 D MES^XPDUTL("  You will receive MailMan messages when it completes.")
 D BMES^XPDUTL("  ")
 Q
 ;
START ; Start the correction process
 N GMRASUB,GMRAFROM,GMRATEXT
 S GMRANODE="GMRA*4.0*72 POST INSTALL"
 ;
 ; Next line in case the patch is installed and backed out multiple times
 I $D(^XTMP("GMRA*4.0*72 BACKOUT")) D CHKDUPES
 ;
 S ^XTMP(GMRANODE,0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^GMRA*4.0*72 POST INSTALL"
 D GMRA
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
CHKDUPES ; Look for record IDs found in both the FIXED and BACKOUT nodes caused
 ;         by an early version of this functionality
 ; ^XTMP("GMRA*4.0*72 BACKOUT",0)="3240904^3240606^GMRA*4.0*72 BACKOUT"
 ; ^XTMP("GMRA*4.0*72 POST INSTALL",0)="3240903^3240605^GMRA*4.0*72 POST INSTALL"
 N BKDT,FXDT,RECIEN
 S BKDT=$P($G(^XTMP("GMRA*4.0*72 BACKOUT",0)),"^",2)
 S FXDT=$P($G(^XTMP("GMRA*4.0*72 POST INSTALL",0)),"^",2)
 I BKDT'<FXDT D
 . S RECIEN=0
 . F  S RECIEN=$O(^XTMP("GMRA*4.0*72 BACKOUT",0,RECIEN)) Q:'RECIEN  D
 .. I $D(^XTMP("GMRA*4.0*72 POST INSTALL",0,"FIXED",RECIEN)) K ^XTMP("GMRA*4.0*72 POST INSTALL",0,"FIXED",RECIEN)
 .. Q
 . Q
 ;
 Q
 ;
GMRA ; Fix records in the PATIENT ALLERGY file (120.8)
 ; INC30029401 - find inactive GMRA allergies in the Patient Allergy file.
 ; Search the 120.8 Patient Allergy file to find allergies that are marked as
 ; inactive in the GMR Allergy file (#120.82)
 N ALGIEN,NODE0,PT,GMRALGY,GMRIEN,ALGYNAME,STATUS,ERRMSG,ACTVDT,DTIEN,DTDATA
 N DTCNT,PREVSTS,STOP,ERRCNT,RECCNT,GMRCNT,ALGYTYPE,LASTDT,FIXCNT,PT,DEADCNT
 N TESTCNT,GMRANODE
 ;
 S GMRANODE="GMRA*4.0*72 POST INSTALL"
 S (ALGIEN,RECCNT,ERRCNT,FIXCNT,DEADCNT,TESTCNT)=0
 F  S ALGIEN=$O(^GMR(120.8,ALGIEN)) Q:'ALGIEN  D
 . S RECCNT=RECCNT+1
 . Q:$D(^GMR(120.8,ALGIEN,"ER"))                        ; Entered in Error
 . ;
 . S NODE0=$G(^GMR(120.8,ALGIEN,0)) Q:NODE0=""
 . S PT=$P(NODE0,"^",1) Q:PT=""
 . I +$P($G(^DPT(PT,.35)),"^",1) S DEADCNT=DEADCNT+1 Q  ; Deceased Patient
 . I $$TESTPAT^VADPT(PT) S TESTCNT=TESTCNT+1 Q          ; Test patient
 . ;
 . S GMRALGY=$P(NODE0,"^",3) Q:GMRALGY=""
 . I GMRALGY'["GMRD(120.82" Q                           ; GMR Allergies only
 . I $$GET1^DIQ(120.8,ALGIEN,3.1)'["DRUG" Q             ; Drug allergies only
 . ;
 . S GMRIEN=$P(GMRALGY,";",1) Q:GMRIEN=""
 . I '$D(^GMRD(120.82,GMRIEN)) Q
 . I '$D(^GMRD(120.82,GMRIEN,"VUID")) D FIXIT Q
 . S STATUS=$$CHKACTV("^GMRD(120.82",GMRIEN)
 . I 'STATUS D FIXIT                                    ; Inactive/bad record
 . Q
 ;
 D SUMMARY
 D REPORT("FIXED",0),REPORT("NOTFIXED",0)
 Q
 ;
FIXIT ; Try to find a matching drug in #50.6 and fix the record
 N FIXED,PIEN,FDA,FILEERR,COMMENT
 S FIXED=0
 S ERRCNT=ERRCNT+1
 ; Next line - ALGYNAME = REACTANT (File 120.8, field# .02)
 S ALGYNAME=$P(NODE0,"^",2) Q:ALGYNAME=""
 S PIEN=$O(^PSNDF(50.6,"B",ALGYNAME,"")) I PIEN="" D  Q
 . S ^XTMP("GMRA*4.0*72 POST INSTALL",0,"NOTFIXED",ALGIEN)=NODE0
 . Q
 ;
 S STATUS=$$CHKACTV("^PSNDF(50.6",PIEN)
 I STATUS D REBUILD
 ;
 I 'FIXED S ^XTMP("GMRA*4.0*72 POST INSTALL",0,"NOTFIXED",ALGIEN)=NODE0
 ; Next line in case a site ran a previous version of the patch
 I FIXED,$D(^XTMP("GMRA*4.0*72 POST INSTALL",0,"NOTFIXED",ALGIEN)) D
 . K ^XTMP("GMRA*4.0*72 POST INSTALL",0,"NOTFIXED",ALGIEN)
 . Q
 ;
 K FDA,FILEERR
 Q
 ;
REBUILD ; Rebuild piece 3 of ^GMR(120.8,ien,0) here and add a comment
 S FDA(120.8,ALGIEN_",",1)=PIEN_";PSNDF(50.6"_","
 D FILE^DIE("","FDA","FILEERR")
 I $D(FILEERR) Q
 D FNDVADC I 'FIXED S ^GMR(120.8,ALGIEN,0)=NODE0 Q
 ;
 S FIXED=1,FIXCNT=FIXCNT+1
 S ^XTMP("GMRA*4.0*72 POST INSTALL",0,"FIXED",ALGIEN)=NODE0
 ;
 ; Add a comment for this update
 S COMMENT="Updated using GMRA*4.0*72 Post-Install routine. Changed inactive "
 S COMMENT=COMMENT_"GMRA reactant from file 120.82 to matching active "
 S COMMENT=COMMENT_"reactant #"_PIEN_" from file 50.6."
 D ADCOM^GMRAFX(ALGIEN,"O",COMMENT) ;Add a comment for this update
 Q
 ;
FNDVADC ; Find the VA Drug Class(es) associated with this drug
 N VADC,VADCPTR,VFDA,VFILEERR,VADCFND
 S VADCFND=+$P($G(^GMR(120.8,ALGIEN,3,0)),"^",4) ; VA Drug Class counter
 S FIXED=$S(VADCFND:1,1:0)
 ;
 I '$D(^PSNDF(50.6,"APRO")) Q
 I '$D(^PSNDF(50.6,"APRO",PIEN)) Q
 ;
 S VADC=""
 F  S VADC=$O(^PSNDF(50.6,"APRO",PIEN,VADC)) Q:'VADC  D
 . S VADCPTR=$$GET1^DIQ(50.68,VADC,15,"I")               ;Pointer to #50.605
 . Q:VADCPTR=""
 . Q:$D(^GMR(120.8,ALGIEN,3,"B",VADCPTR))                ;Already present
 . S STATUS=$$CHKACTV("^PS(50.605",VADCPTR)
 . I 'STATUS Q
 . S VFDA(120.803,"+1,"_ALGIEN_",",.01)=VADCPTR
 . D UPDATE^DIE("","VFDA","","VFILEERR")
 . I $D(VFILEERR) K VFDA,VFILEERR Q
 . S FIXED=1
 . S ^XTMP(GMRANODE,0,"FIXED",ALGIEN,3,VADCPTR)=""
 . K VFDA,VFILEERR
 . Q
 ;
 Q
 ;
 ; ----------------------------------------------------------------------------
CHKACTV(CHKGBL,AIEN) ; Check to see if an item is active
 N STRING
 S STATUS=0
 S STRING="""TERMSTATUS"""_")"
 S CHKGBL=CHKGBL_","_AIEN_","_STRING
 S LASTDT=$O(@CHKGBL@("B","9999999"),-1) I LASTDT="" Q STATUS
 S DTIEN=$O(@CHKGBL@("B",LASTDT,""),-1) I DTIEN="" Q STATUS
 S DTDATA=$G(@CHKGBL@(DTIEN,0)) I DTDATA="" Q STATUS
 S STATUS=$P(DTDATA,"^",2)
 Q STATUS
 ;
SUMMARY ; Summary of results
 S ^XTMP(GMRANODE,0,"SUMMARY",1)=" "
 S ^XTMP(GMRANODE,0,"SUMMARY",2)="********** GMRA*4.0*72 Post-Install Routine Summary Report **********"
 S ^XTMP(GMRANODE,0,"SUMMARY",3)=" "
 S ^XTMP(GMRANODE,0,"SUMMARY",4)=" Process was run by "_$$GET1^DIQ(200,DUZ,.01)_" on "_$$FMTE^XLFDT(DT)
 S ^XTMP(GMRANODE,0,"SUMMARY",5)=" "
 S ^XTMP(GMRANODE,0,"SUMMARY",6)="Total Patient Allergy records examined = "_$J(RECCNT,7)
 S ^XTMP(GMRANODE,0,"SUMMARY",7)="    Deceased patient bad records found = "_$J(DEADCNT,7)
 S ^XTMP(GMRANODE,0,"SUMMARY",8)="        Test patient bad records found = "_$J(TESTCNT,7)
 S ^XTMP(GMRANODE,0,"SUMMARY",9)=" "
 S ^XTMP(GMRANODE,0,"SUMMARY",10)="        Total active bad records found = "_$J(ERRCNT,7)
 S ^XTMP(GMRANODE,0,"SUMMARY",11)="Bad records that could not be repaired = "_$J(ERRCNT-FIXCNT,7)
 S ^XTMP(GMRANODE,0,"SUMMARY",12)="                                         _______"
 S ^XTMP(GMRANODE,0,"SUMMARY",13)="                     Bad records fixed = "_$J(FIXCNT,7)
 S ^XTMP(GMRANODE,0,"SUMMARY",14)=" "
 S ^XTMP(GMRANODE,0,"SUMMARY",15)=" The original version of the corrected records, if any, are stored for"
 S ^XTMP(GMRANODE,0,"SUMMARY",16)=" 90 days at ^XTMP(""GMRA*4.0*72 POST INSTALL"",0,""FIXED"",recordID)."
 S ^XTMP(GMRANODE,0,"SUMMARY",17)=" "
 S ^XTMP(GMRANODE,0,"SUMMARY",18)="*************************** End of Report ****************************"
 ;
 ; Send MailMan message to installer and users with GMRA SUPERVISOR or PSNMGR key
 S GMRASUB="GMRA*4.0*72 Post-Install Summary Information"
 S GMRAFROM="GMRA*4.0*72 Post-Install"
 S GMRATEXT="^XTMP(""GMRA*4.0*72 POST INSTALL"",0,""SUMMARY"")"
 D MAILMSG(GMRASUB,GMRAFROM,GMRATEXT)
 Q
 ;
 ; ============================================================================
BACKOUT ; Run this from the programmer's prompt if patch backout is required
 W #
 N DIR,Y
 S DIR("A",1)="This action will back out the file modifications that were performed"
 S DIR("A",2)="after the install of GMRA*4.0*72."
 S DIR("A",3)=""
 S DIR("A")="Are you sure you wish to proceed",DIR("B")="NO",DIR(0)="Y"
 D ^DIR
 Q:Y<1
 ;
 I '$D(^XTMP("GMRA*4.0*72 POST INSTALL",0,"FIXED")) D  Q
 . W !!,"No converted records were found that can be backed out. Quitting...",!!
 . Q
 ;
 N GMBKNODE,GMRADUZ,GMRBKOK,GMRNOBK,GMRIEN,GMRAREC,GMRATEXT,GMRAMY,GMRASUB,GMRAMIN
 N GMRAMZ,GMRAFROM,GMRCNT,GMRCMTDT,GMRCMT,GMRCMTERR
 ;
 S GMBKNODE="GMRA*4.0*72 BACKOUT"
 S GMRADUZ=DUZ
 S ^XTMP(GMBKNODE,0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^GMRA*4.0*72 BACKOUT"
 ;
 W !!,"Please wait until the backout completes."
 W !,"Working...",!
 D BKRECS
 ;
 K DIR
 N DIR
 S DIR("A",1)="A MailMan message has been sent to you as well as holders"
 S DIR("A",2)="of the GMRA-SUPERVISOR or PSNMGR security keys."
 S DIR("A",3)=""
 S DIR("A")="Press any key to continue"
 S DIR(0)="E" D ^DIR
 Q
 ;
BKRECS ; Restore the previous (erroneous) records back to ^GMR(120.8,ien,0)
 N FDA,FILEERR,VADCPTR,VADCNODE,VFDA,VFILEERR,VADCERR
 S (GMRIEN,GMRBKOK,GMRNOBK,GMRCMTERR,VADCERR)=0
 ;
 ; ^XTMP("GMRA*4.0*72 POST INSTALL",0,"FIXED",ALGIEN)=NODE0
 F  S GMRIEN=$O(^XTMP("GMRA*4.0*72 POST INSTALL",0,"FIXED",GMRIEN)) Q:GMRIEN=""  D
 . I '$D(^GMR(120.8,GMRIEN)) S GMRNOBK=GMRNOBK+1 Q   ; This should never happen
 . S ^XTMP(GMBKNODE,0,"BACKOUT",GMRIEN)=^GMR(120.8,GMRIEN,0)
 . S ^GMR(120.8,GMRIEN,0)=^XTMP("GMRA*4.0*72 POST INSTALL",0,"FIXED",GMRIEN)
 . ;
 . ; Back out VA Drug Class(es) added during repair
 . I $D(^XTMP("GMRA*4.0*72 POST INSTALL",0,"FIXED",GMRIEN,3)) D BKVADC
 . ;
 . ; Back out the comment added during repair
 . S GMRCMTDT=9999999
 . K FDA,FILEERR
 . F  S GMRCMTDT=$O(^GMR(120.8,GMRIEN,26,"B",GMRCMTDT),-1) Q:GMRCMTDT=""  D
 .. S GMRCNT=$O(^GMR(120.8,GMRIEN,26,"B",GMRCMTDT,"")) Q:GMRCNT=""
 .. S GMRCMT=$G(^GMR(120.8,GMRIEN,26,GMRCNT,2,1,0)) Q:GMRCMT=""
 .. I GMRCMT["Updated using GMRA*4.0*72" D
 ... S FDA(120.826,GMRCNT_","_GMRIEN_",",.01)="@"
 ... D FILE^DIE("","FDA","FILEERR")
 ... I $D(FILEERR) S ^XTMP(GMBKNODE,0,"BACKOUT",GMRIEN,"CMTERR")="",GMRCMTERR=GMRCMTERR+1
 ... Q
 .. Q
 . S GMRBKOK=GMRBKOK+1
 . K ^XTMP("GMRA*4.0*72 POST INSTALL",0,"FIXED",GMRIEN)
 . Q
 ;
 D BKSMRY
 Q
 ;
BKVADC ; Back out the VA Drug Class updates
 S VADCPTR=0
 F  S VADCPTR=$O(^XTMP("GMRA*4.0*72 POST INSTALL",0,"FIXED",GMRIEN,3,VADCPTR)) Q:'VADCPTR  D
 . S VADCNODE=$O(^GMR(120.8,GMRIEN,3,"B",VADCPTR,"")) Q:VADCNODE=""
 . S VFDA(120.803,VADCNODE_","_GMRIEN_",",.01)="@"
 . D FILE^DIE("","VFDA","VFILEERR")
 . I $D(VFILEERR) S ^XTMP(GMBKNODE,0,"BACKOUT",GMRIEN,"VADCERR",VADCPTR)="",VADCERR=VADCERR+1
 . K VFDA,VFILEERR
 . Q
 ;
 Q
 ;
BKSMRY ; Summary of the backout results
 S ^XTMP(GMBKNODE,0,"SUMMARY",1)=" "
 S ^XTMP(GMBKNODE,0,"SUMMARY",2)="**************** GMRA*4.0*72 Rollback Summary Report ****************"
 S ^XTMP(GMBKNODE,0,"SUMMARY",3)=" "
 S ^XTMP(GMBKNODE,0,"SUMMARY",4)=" Backout was run by "_$$GET1^DIQ(200,DUZ,.01)_" on "_$$FMTE^XLFDT(DT)
 S ^XTMP(GMBKNODE,0,"SUMMARY",5)=" "
 S ^XTMP(GMBKNODE,0,"SUMMARY",6)="       Number of records not rolled back: "_GMRNOBK
 S ^XTMP(GMBKNODE,0,"SUMMARY",7)="           Number of records rolled back: "_GMRBKOK
 S ^XTMP(GMBKNODE,0,"SUMMARY",8)="        Number of comment backout errors: "_GMRCMTERR
 S ^XTMP(GMBKNODE,0,"SUMMARY",9)="  Number of VA Drug Class backout errors: "_VADCERR
 S ^XTMP(GMBKNODE,0,"SUMMARY",10)=" "
 S ^XTMP(GMBKNODE,0,"SUMMARY",11)=" The previously corrected records will be saved for 90 days at"
 S ^XTMP(GMBKNODE,0,"SUMMARY",12)="  ^XTMP(""GMRA*4.0*72 BACKOUT"",0,""BACKOUT"",recordID)."
 S ^XTMP(GMBKNODE,0,"SUMMARY",13)=" with errors encountered during comment backout, if any, at"
 S ^XTMP(GMBKNODE,0,"SUMMARY",14)="  ^XTMP(""GMRA*4.0*72 BACKOUT"",0,""BACKOUT"",recordID,""CMTERR"")"
 S ^XTMP(GMBKNODE,0,"SUMMARY",15)=" and errors encountered during VA Drug Class backout, if any, at"
 S ^XTMP(GMBKNODE,0,"SUMMARY",16)="  ^XTMP(""GMRA*4.0*72 BACKOUT"",0,""BACKOUT"",recordID,""VADCERR"")"
 S ^XTMP(GMBKNODE,0,"SUMMARY",17)=" "
 S ^XTMP(GMBKNODE,0,"SUMMARY",18)=" The text of this message will also be stored for 90 days at"
 S ^XTMP(GMBKNODE,0,"SUMMARY",19)="  ^XTMP(""GMRA*4.0*72 BACKOUT"",0,""SUMMARY""."
 S ^XTMP(GMBKNODE,0,"SUMMARY",20)=" "
 S ^XTMP(GMBKNODE,0,"SUMMARY",21)="*************************** End of Report ****************************"
 ;
 ; Send MailMan message with backout info to appropriate group
 S GMRASUB="GMRA*4.0*72 Backout Information"
 S GMRAFROM="GMRA*4.0*72 BACKOUT"
 S GMRATEXT="^XTMP(""GMRA*4.0*72 BACKOUT"",0,""SUMMARY"")"
 D MAILMSG(GMRASUB,GMRAFROM,GMRATEXT)
 Q
 ;
 ; ============================================================================
REPORT(TYPE,LOCAL) ; Common report data
 ; Local = report run from prompt = 1, otherwise 0
 N RPTIEN,RPTDATA,RPTNAME,RPTFILE,RPTFLIEN,RPTPT,RPTPTNM,RPTNODE,RPTSS,RPTLN
 N RPTFTR,RPTRECS,RPTCERR,RPTSUB,RPTFROM,RPTTEXT,RPTSTOP,NORECS,DLM
 S:$G(TYPE)="" TYPE=""
 S:$G(LOCAL)="" LOCAL=1
 S RPTSS=$S(TYPE["FIX":"GMRA*4.0*72 POST INSTALL",1:"GMRA*4.0*72 BACKOUT")
 S RPTNODE="GMRA*4.0*72 POST INSTALL"
 S RPTRECS=$S(TYPE="FIXED":"Fixed",TYPE="NOTFIXED":"Unfixed",1:"Backed Out")_" Records "
 S RPTFTR="*************************** End of Report ***************************"
 S RPTSUB="GMRA*4.0*72 "_TYPE_" Record Report Information"
 S RPTFROM="GMRA*4.0*72 REPORT"
 S RPTTEXT="^XTMP(""GMRA*4.0*72 POST INSTALL"",0,""REPORT"")"
 S (RPTSTOP,NORECS)=0,DLM="^"
 ;
 I LOCAL D  Q:RPTSTOP
 . W #
 . I $G(TYPE)="" W !!,"GMRA*72 Report Type not specified. Quitting...",!! S RPTSTOP=1 Q
 . I (TYPE'="FIXED"),(TYPE'="NOTFIXED"),(TYPE'="BACKOUT") D  Q
 .. W !!,"GMRA*72 Report type of "_TYPE_" not valid. Quitting...",!!
 .. S RPTSTOP=1
 .. Q
 . ;
 . W !!,"GMRA*4.0*72 "_RPTRECS_"Report Results will be sent to you and users"
 . W !,"with the GMRA-SUPERVISOR or PSNMGR security key via a MailMan message",!!
 . Q
 ;
 K ^XTMP(RPTNODE,0,"REPORT")
 D RPTHDR
 I '$D(^XTMP(RPTSS,0,TYPE)) D  Q
 . S NORECS=1,^XTMP(RPTNODE,0,"REPORT",8)=" No "_RPTRECS_"found"
 . D RPTFTR(9)
 . D MAILMSG(RPTSUB,RPTFROM,RPTTEXT)
 . Q
 ;
 S ^XTMP(RPTNODE,0,"REPORT",8)="#120.8 ID"_DLM_"PATIENT NAME"_DLM_"DRUG ALLERGY NAME"
 ;
 S RPTIEN="",RPTLN=9
 F  S RPTIEN=$O(^XTMP(RPTSS,0,TYPE,RPTIEN)) Q:'RPTIEN  D
 . S RPTCERR=""
 . S RPTDATA=$G(^XTMP(RPTSS,0,TYPE,RPTIEN))
 . S RPTPT=$P(RPTDATA,"^",1),RPTPTNM=$$GET1^DIQ(2,RPTPT,.01)
 . S RPTNAME=$P(RPTDATA,"^",2),RPTFLIEN=$P($P(RPTDATA,"^",3),";",1)
 . I TYPE="BACKOUT" D RPTBKERR
 . S ^XTMP(RPTNODE,0,"REPORT",RPTLN)=RPTIEN_RPTCERR_DLM_RPTPTNM_DLM_RPTNAME
 . S RPTLN=RPTLN+1
 . Q
 ;
 S RPTLN=RPTLN+1 D RPTFTR(RPTLN)
 D MAILMSG(RPTSUB,RPTFROM,RPTTEXT)
 Q
 ;
RPTBKERR ; Look for errors during the backout process
 N CERR,VERR
 S (CERR,VERR)=0
 S CERR=$D(^XTMP(RPTSS,0,"BACKOUT",RPTIEN,"CMTERR"))
 S VERR=$D(^XTMP(RPTSS,0,"BACKOUT",RPTIEN,"VADCERR"))
 S RPTCERR=$S((CERR&VERR):"B",CERR:"C",VERR:"V",1:"")
 Q
 ;
RPTHDR ; Write the report header
 S ^XTMP(RPTNODE,0,"REPORT",1)=" "
 S ^XTMP(RPTNODE,0,"REPORT",2)="************************* GMRA*4.0*72 Report ************************"
 S ^XTMP(RPTNODE,0,"REPORT",3)=" "
 S ^XTMP(RPTNODE,0,"REPORT",4)=" "_TYPE_" Report was requested by "_$$GET1^DIQ(200,DUZ,.01)_" on "_$$FMTE^XLFDT(DT)
 S ^XTMP(RPTNODE,0,"REPORT",5)=" "
 S ^XTMP(RPTNODE,0,"REPORT",6)=" You are receiving this report as a holder of the GMRA-SUPERVISOR or PSNMGR key"
 S ^XTMP(RPTNODE,0,"REPORT",7)=" "
 Q
 ;
RPTFTR(LINE) ; Write the report footer
 S ^XTMP(RPTNODE,0,"REPORT",LINE)=" "
 S LINE=LINE+1
 I TYPE="BACKOUT" D
 . I 'NORECS D
 .. S ^XTMP(RPTNODE,0,"REPORT",LINE)=" Record IDs with a C, V, or B suffix, if any, had backout issues"
 .. S LINE=LINE+1
 .. Q
 . S ^XTMP(RPTNODE,0,"REPORT",LINE)=" "
 . S LINE=LINE+1
 . Q
 ;
 S ^XTMP(RPTNODE,0,"REPORT",LINE)=RPTFTR
 Q
 ;
 ; ============================================================================
MAILMSG(MSGSUBJ,MSGFROM,MSGTEXT) ; Build and send a MailMan message
 N GMRAREC,GMRAMY,GMRAMIN,GMRAMZ,GMRAKEY
 I '$D(GMRADUZ) S GMRADUZ=DUZ
 S GMRAMIN("FROM")=MSGFROM
 ;
 ; Next line - send to users with specified GMRAKEY. Add more here if needed
 F GMRAKEY="GMRA-SUPERVISOR","PSNMGR" D
 . S GMRAREC=""
 . F  S GMRAREC=$O(^XUSEC(GMRAKEY,GMRAREC)) Q:GMRAREC=""  S GMRAMY(GMRAREC)=""
 . Q
 ;
 S GMRAMY(GMRADUZ)=""
 D SENDMSG^XMXAPI(GMRADUZ,MSGSUBJ,MSGTEXT,.GMRAMY,.GMRAMIN,.GMRAMZ,"")
 Q
