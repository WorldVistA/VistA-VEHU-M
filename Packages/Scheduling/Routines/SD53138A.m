SD53138A ;ALB/SEK - CLEAN-UP OF FILE 409.75;12-JAN-1998
 ;;5.3;Scheduling;**138**;Aug 13, 1993
 ;
SCAN ;Entry point to scan only (prints what would have been deleted)
 N ZTRTN,ZTDESC
 D INTRO
 W !
 W !,"You are running this routine in scan mode, which will only identify"
 W !,"the problems corrected.  Please select a device (queueing allowed) so"
 W !,"that a listing of what would have been done can be obtained."
 W !!
 S ZTRTN="EN^SD53138A(1)"
 S ZTDESC="ACRP records to be set for retransmit by FIX"
 D EN^XUTMDEVQ(ZTRTN,ZTDESC)
 Q
 ;
FIX ;Entry point to schedule clean-up
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 D INTRO
 W !
 ;
 ;Generate late activity bulletin (only applicable for fix mode)
 S SDLATE=$$LATEBULL^SD53138B() Q:(SDLATE<0)
 ;
 W !
 W !,"Please enter the date/time that you would like this clean up queued to"
 W !,"be run.  A summary of what was done will be sent to you and the"
 W !,"recipients of the SCDX AMBCARE TO NPCDB SUMMARY bulletin."
 W !!
 W !,"For a detailed list of those records that will be marked for"
 W !,"re-transmission by this fix, please run SCAN^SD53138A prior"
 W !,"to running FIX^SD53138A."
 W !!
 ;
 ;OK ? prompt
 Q:('$$OK^SD53138B())
 ;
 S ZTRTN="EN^SD53138A(0)"
 S ZTDESC="ACRP clean-up of file 409.75"
 S ZTDTH=""
 S ZTIO=""
 S ZTSAVE("SDLATE")=""
 D ^%ZTLOAD
 W:(+$G(ZTSK)) !,"Scheduled as task number ",ZTSK
 W:('$G(ZTSK)) !,"** Unable to schedule correction **"
 Q
 ;
INTRO ;Print intro text
 W !!,"This routine will mark for re-transmission entries in the"
 W !,"Transmitted Outpatient Encounter file (#409.73) that have"
 W !,"been rejected by the Austin Automation Center and do not have an"
 W !,"entry in the Transmitted Outpatient Encounter Error file (#409.75)."
 Q
 ;
EN(SCANMODE) ;Main entry point
 ; Routine marks entries in the Transmitted Outpatient Encounter file
 ; (#409.73) that have been rejected by the Austin Automation Center
 ; and do not have an entry in the Transmitted Outpatient Encounter
 ; Error file (#409.75) for re-transmission.
 ;
 ;Input  : SCANMODE - Flag denoting if routine should only scan
 ;                    for errors and not fix them
 ;                    0 = No - scan and fix (default)
 ;                    1 = Yes - scan but don't fix
 ;Output : None
 ;Notes  : A completion/summary bulletin will be sent to the current
 ;         user and the recipients of the SCDX AMBCARE TO NPCDB SUMMARY
 ;         bulletin.  This bulletin will not be sent if in scan mode.
 ;
 ;Declare variables
 N XMITPTR,XMITTOT,XMITXMIT,TMP
 S SCANMODE=+$G(SCANMODE)
 ;Initialize counters
 S (XMITTOT,XMITXMIT)=0
 ;Initialize summary location
 K ^TMP($J,"SD53138A")
 S ^TMP($J,"SD53138A","XMIT")="^"
 S ^TMP($J,"SD53138A","STOP")=0
 ;Remember starting time
 S ^TMP($J,"SD53138A","TIME")=$$NOW^XLFDT()
 ;
 ;User didn't want late activity bulletins
 I ($G(SDLATE)) D
 .;Pointer to late activity mail group
 .S ^TMP($J,"SD53138A","LAMG")=+$$GETLAMG^SD53138B()
 .;Delete value from file (this prevents bulletin generation)
 .D SETLAMG^SD53138B("",1)
 ;
 I (SCANMODE) D
 .W !
 .W !,"Scanning of the Transmitted Outpatient Encounter file (#409.73)"
 .W !,"for entries that have been rejected by the Austin Automation"
 .W !,"Center and do not have an entry in the Transmitted Outpatient"
 .W !,"Encounter Error file (#409.75).  Started on "_$$FMTE^XLFDT($$NOW^XLFDT())
 .W !
 ;Loop through Transmitted Outpatient Encounter file (#409.73)
 I (SCANMODE) D
 .W !!
 .W !,"The following entries in the Transmitted Outpatient Encounter"
 .W !,"file (#409.73) will be set for re-transmission when run in fix mode"
 .W !,$$REPEAT^SCDXUTL1("=",70)
 S XMITPTR=0
 F  S XMITPTR=+$O(^SD(409.73,XMITPTR)) Q:('XMITPTR)  D  Q:($G(ZTSTOP))
 .;Increment total entries checked
 .S XMITTOT=XMITTOT+1
 .;Check for rejection without entry in Transmitted Outpatient Encounter
 .; Error file (#409.75)
 .S TMP=$G(^SD(409.73,XMITPTR,1))
 .I ($P(TMP,"^",5)="R") D:('$D(^SD(409.75,"B",XMITPTR)))
 ..Q:'$$XMIT4DBC^SCDXFU04(XMITPTR)
 ..;Mark for retransmission
 ..D:('SCANMODE) STREEVNT^SCDXFU01(XMITPTR)
 ..D:('SCANMODE) XMITFLAG^SCDXFU01(XMITPTR)
 ..W:(SCANMODE) !,"^SD(409.73,",XMITPTR,",0) rejected with no reason on file (entry in 409.75)"
 ..;Increment retransmission counter
 ..S XMITXMIT=XMITXMIT+1
 .;Check for request to stop
 .S:($$S^%ZTLOAD("Last entry in Transmitted Outpatient Encounter file checked >> "_XMITPTR)) ZTSTOP=1
 ;Remember totals
 S ^TMP($J,"SD53138A","XMIT")=XMITTOT_"^"_XMITXMIT
 I (SCANMODE) D
 .W !
 .W !,XMITTOT," entries were checked"
 .W !,?2,XMITXMIT," would have been marked for retransmission"
 ;
EN1 ;Restore late activity bulletins
 I ($G(SDLATE)) D
 .;Get pointer to original late activity mail group
 .S SDLATE=+$G(^TMP($J,"SD53138A","LAMG"))
 .;Store (this restores bulletin generation
 .D SETLAMG^SD53138B(SDLATE)
 ;
 ;Remember ending time
 S $P(^TMP($J,"SD53138A","TIME"),"^",2)=$$NOW^XLFDT()
 I (SCANMODE) D
 .W !!!,"Scan ended on ",$$FMTE^XLFDT($$NOW^XLFDT())
 .W !!!,"Use the entry point FIX^SD53138A to run in fix mode"
 .W !,"Use the entry point SCAN^SD53138A to re-run in scan mode"
 ;Remember if requested to stop
 S ^TMP($J,"SD53138A","STOP")=+$G(ZTSTOP)
 ;Send completion/summary bulletin
 D:('SCANMODE) BULL1^SD53138B
 ;Done - clean-up and quit
 K ^TMP($J,"SD53138A"),SDLATE
 S:($D(ZTQUEUED)) ZTREQ="@"
 Q
