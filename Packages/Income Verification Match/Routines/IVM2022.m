IVM2022 ;ALB/GN - IVM TRANS LOG (#301.6) FILE CLEANUP; 11-AUG-99
 ;;2.0;INCOME VERIFICATION MATCH;**22**; 21-OCT-94
 ;
 ; Drive thru the Transmission Log file (#301.6) via the Date/Time 
 ; cross reference ("ADT") beginning with the earliest known date that
 ; the corruptions could have occured, i.e. Oct 29, 1996.  Look for 
 ; corrupted message control ID's caused by patch HL*1.6*19. Purge all
 ; bad messages from the log file via IVM API call.  These bad records
 ; can be identified by a message control id that begins with a "-"
 ; rather than by a Batch #_"-"_rec #.  Recreate Full Data Transmission
 ; (Z07) messages for all patients that did not have a good transmission
 ; since the bad messages found in the transmission log file.
 ;
 ; setup background job & prompt user
EN N ZTDESC,ZTIO,ZTRTN,ZTSK
 I '$G(DUZ) D  Q
 .W !!,"Your DUZ code must be defined in order to run this job.",!
 W !,"Job to cleanup IVM TRANSMISSION LOG (#301.6) file",!
 S ZTDESC="IVM Transmission Log Cleanup"
 S ZTRTN="BEGIN^IVM2022",ZTIO=""
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!,*7,?5,"C A N C E L L E D !",!
 E  W !!?5,"TASK QUEUED....TASK # ",ZTSK,!
 Q
 ;
BEGIN ; Begin process
 N BDATE,BEGTIM,COUNT,ENDTIM,ERRORS,IIEN,NOTSENT,PKG,PRGCNT,RECCNT
 N TEXT,TLOG,Z07CNT
 S PKG="IVM"
 K ^TMP(PKG,$J)
 ;
 S COUNT=10
 ;
 S BDATE=2961029,BEGTIM=$H
 S (RECCNT,Z07CNT,PRGCNT,ERRORS)=0
 ;
 ; drive thru Trans log by date (#301.6) and get patient IEN # from 
 ; patient file (#301.5) for all bad message control id's
 F  S BDATE=$O(^IVM(301.6,"ADT",BDATE)) Q:BDATE=""  D
 .S IIEN=""
 .F  S IIEN=$O(^IVM(301.6,"ADT",BDATE,IIEN)) Q:IIEN=""  D
 ..S RECCNT=RECCNT+1
 ..I '$$GET^IVMTLOG(IIEN,.TLOG) D PATERR(.COUNT,.ERRORS) Q
 ..;
 ..; if a BAD transmission, mark to purge 301.6 file and assume will
 ..; need to resend a Z07 data trans for this patient for now
 ..I $E(TLOG("MSGID"))="-" D
 ...S ^TMP(PKG,$J,"PURGE",IIEN)=""
 ...S ^TMP(PKG,$J,"Z07",TLOG("PAT"))=""
 ..;
 ..; if a GOOD transmission is found, since a bad one, for a given
 ..; patient, then kill the resending of the Z07 for that patient
 ..I $E(TLOG("MSGID"))'="-",$D(^TMP(PKG,$J,"Z07",TLOG("PAT"))) D
 ...K ^TMP(PKG,$J,"Z07",TLOG("PAT"))
 ;
 ; build Z07 stuff and cleanup transmission log file now
 D BLDZ07(.ERRORS,.Z07CNT),PURGE(.ERRORS,.PRGCNT)
 S ENDTIM=$H
 ;
 ; mail stats
 S TEXT="The IVM TRANSMISSION LOG file (#301.6) cleanup has "
 I $G(ERRORS) S TEXT=TEXT_"completed with ERRORS"
 E  S TEXT=TEXT_"successfully completed"
 ;
 S ^TMP(PKG,$J,"MSG",1)=TEXT
 S ^TMP(PKG,$J,"MSG",2)=""
 S ^TMP(PKG,$J,"MSG",3)="   Job began at: "_$$HTE^XLFDT(BEGTIM)
 S ^TMP(PKG,$J,"MSG",4)="   Job ended at: "_$$HTE^XLFDT(ENDTIM)
 S ^TMP(PKG,$J,"MSG",5)=""
 S ^TMP(PKG,$J,"MSG",6)=RECCNT_" records read for a total time of: "_$$HDIFF^XLFDT(ENDTIM,BEGTIM,3)
 S ^TMP(PKG,$J,"MSG",7)=""
 S TEXT=PRGCNT_" records were purged from the IVM TRANSMISSION LOG file (#301.6)"
 S ^TMP(PKG,$J,"MSG",8)=TEXT
 S TEXT=Z07CNT_" records will be included in the next HL7 transmission to HEC"
 S ^TMP(PKG,$J,"MSG",9)=TEXT
 S ^TMP(PKG,$J,"MSG",10)=""
 D MAIL
 ;
 ; housekeeping
 K ^TMP(PKG,$J)
 Q
 ;
 ;@@@@@@@@@@@@@@@@@@@@@@@@ SUBROUTINES @@@@@@@@@@@@@@@@@@@@@@@@@@
BLDZ07(ERROR,ZCNT) ; Drive thru TMP and flag patients for Z07 data transmissions
 N XIEN,EVENTS,ERR,NOTSENT,SUCCESS
 S (ERR,XIEN)="",(SUCCESS,NOTSENT)=0
 F  S XIEN=$O(^TMP(PKG,$J,"Z07",XIEN)) Q:XIEN=""  D
 .S NOTSENT=$$STATUS^IVMPLOG(XIEN,.EVENTS)
 .S:NOTSENT SUCCESS=$$SETSTAT^IVMPLOG(XIEN,.EVENTS,.ERR)
 .I NOTSENT,'SUCCESS D Z07ERR(ERR,.COUNT,.ERROR) Q
 .S ZCNT=ZCNT+1
 Q
 ;
PURGE(ERROR,PCNT) ; Purge Transmission log (#301.6) of bad records via ^TMP
 N IIEN,SUCCESS,I
 S IIEN=""
 F  S IIEN=$O(^TMP(PKG,$J,"PURGE",IIEN)) Q:IIEN=""  D
 .; try 5 times to get a lock on rec before indicating an error
 .F I=1:1:5 S SUCCESS=$$DELETE^IVMTLOG(IIEN) Q:SUCCESS
 .I 'SUCCESS D PURGERR(.COUNT,.ERROR) Q
 .S PCNT=PCNT+1
 Q
 ;
PATERR(CNT,ERROR) ; error occured so save error text for mailing
 N TEXT
 S CNT=CNT+1,ERROR=1
 S TEXT="Could not get IVM patient record >"_IIEN_"<"
 S ^TMP(PKG,$J,"MSG",CNT)=TEXT
 Q
 ;
Z07ERR(ERR,CNT,ERROR) ; error occured so save error text for mailing
 N TEXT
 S CNT=CNT+1,ERROR=1
 S TEXT="Could not flag record >"_XIEN_"< for a Z07 transmission for "
 S TEXT=TEXT_"reasons:"_ERR
 S ^TMP(PKG,$J,"MSG",CNT)=TEXT
 Q
 ;
PURGERR(CNT,ERROR) ; error occured so save error text for mailing
 N TEXT
 S CNT=CNT+1,ERROR=1
 S TEXT="Could not delete record >"_IIEN
 S TEXT=TEXT_"< from IVM transmission log file"
 S ^TMP(PKG,$J,"MSG",CNT)=TEXT
 Q
 ;
MAIL ; send a mail message with stats, to whoever ran this routine
 N XMY,XMDUZ,XMSUB,XMTEXT
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="IVM TRANSMISSION LOG file (#301.6) CLEANUP RESULTS (IVM2022)"
 S XMTEXT="^TMP(PKG,$J,""MSG"","
 D ^XMD
 Q
