ECXDTASK ;ALB/TJL - Option, ECX KILL TASK ;3/19/24  14:35
 ;;3.0;DSS EXTRACTS;**190**;Dec 22, 1997;Build 36
 ;
 ; Reference to $$PRDEA^XUSER supported by DBIA #2343.
 ; Reference to ^%ZTLOAD:ASKSTOP,KILL,S, supported by ICR # 10063
 ;
ENV ;Establish Routine Environment
 N DIR,XUTMT,ZTSK
 K DIRUT,DTOUT,DUOUT ;Clean-up for so we can use them too.
 N U,LN,DTOUT,DUOUT,X,Y,ZT,ZTOUT,ZTS
 S U="^" S $P(LN,"-",80)=""
START ;
 K ^TMP($J)
 N ABBR,STAT,FOUND,QCOUNT,TASKNO,LISTNO,QREC,DA7271,VERB,PRINTNM,JOBNO
 N STARTDT,ENDDT,SCHED,DTCREATE,HSEC,SECNODE
 W @IOF   ;,"Please wait while I find the DSS Extract tasks...searching..."
 S (FOUND,QCOUNT,ZTOUT)=0 S $P(LN,"-",80)=""
 S ABBR="" F  S ABBR=$O(^XTMP("ECX EXTRACT",ABBR)) Q:ABBR=""  D
 . S QREC=^XTMP("ECX EXTRACT",ABBR) Q:QREC=""
 . S ZTSK=$P(QREC,U,1) D STAT^%ZTLOAD
 . I ZTSK(0) D
 . . S JOBNO=$P(QREC,U,6)
 . . I ZTSK(1)=1,ZTSK(2)="Active: Pending" S STAT="P" D VALID Q
 . . I ZTSK(1)=2,ZTSK(2)="Active: Running" S STAT="R" D VALID
 . . Q
 . Q
 W !  ;"finished!!",!
 I 'FOUND W !,"There are no extract-related tasks queued.",! Q
 E  S SECNODE=0,LISTNO=0 F  S SECNODE=$O(^TMP($J,SECNODE)) Q:SECNODE'>0  D  I ZTOUT Q
 . S TASKNO=0 F  S TASKNO=$O(^TMP($J,SECNODE,TASKNO)) Q:TASKNO=""  D  I ZTOUT Q
 . . S LISTNO=LISTNO+1
 . . S ^TMP($J,0,LISTNO)=TASKNO
 . . S QREC=^TMP($J,SECNODE,TASKNO,0)
 . . S DA7271=$O(^ECX(727.1,"C",$P(QREC,U,1),0))
 . . S PRINTNM=$P(^ECX(727.1,DA7271,0),U,7)
 . . S Y=$P(QREC,U,5) D DD^%DT S STARTDT=Y
 . . S Y=$P(QREC,U,6) D DD^%DT S ENDDT=Y
 . . S SCHED=$P(QREC,U,4)
 . . S JOBNO=$P(QREC,U,7)
 . . S DTCREATE=$P(QREC,U,9)
 . . S DTCREATE=$$HTE^XLFDT(DTCREATE,"M")
 . . S VERB="Queued to start" S:$P(QREC,U,8)="R" VERB="Running since"
 . . S SCHED=$$HTE^XLFDT(SCHED,"M")
 . . W !,LISTNO_": (Task #"_TASKNO_")"
 . . W:$L($G(JOBNO))>0 ?32,"DSS Extract Log Record Number: "_JOBNO
 . . W !?3,PRINTNM_" Extract from "_STARTDT_" to "_ENDDT_"."
 . . W !?5,"Task created at "_$P(DTCREATE,"@",2)_" on "_$P(DTCREATE,"@",1)_" by "_$$NAME^XUSER($P(QREC,U,3),"F")
 . . W !?5,"Scheduled to start at "_$P(SCHED,"@",2)_" on "_$P(SCHED,"@",1)
 . . W !,LN
 . . I $Y>18 D EOP S ZTOUT=$D(DTOUT)!$D(DUOUT) Q:ZTOUT  W @IOF
 I 'ZTOUT D EOL W !
 D PROMPT
 I $L(XUTMT)=0 W !?7,"No task selected. Returning to the DSS Extracts Transmission",!?7,"Management menu." Q
 D STOPTASK
 Q
VALID ; Task is either running or scheduled - add to list
 N TASKDA S QCOUNT=QCOUNT+1,FOUND=1
 S TASKDA=$P(QREC,U,1)
 S HSEC=$$H3^%ZTM($P(QREC,U,3))
 S ^TMP($J,HSEC,TASKDA)=QCOUNT
 S ^TMP($J,HSEC,TASKDA,0)=ABBR_U_QREC
 S $P(^TMP($J,HSEC,TASKDA,0),U,8,9)=STAT_U_$P(^%ZTSK(ZTSK,0),U,5)
 Q
 ;
EOP ;Simulate DIR(0)="E" Call To DIR (For Use Within DIR calls)
 S Y="" F ZT=0:0 R !,"Press RETURN to continue or '^' to exit: ",Y:$S($D(DTIME)#2:DTIME,1:60) S:'$T DTOUT="" S:Y="^" DUOUT="" Q:Y=""!(Y="^")  W !!,"Enter either RETURN or '^'",! W:Y'["?" $C(7)
 Q
 ;
EOL ;Simulate DIR(0)="E" call to DIR for end of listings
 S Y="" F ZT=0:0 R !,"End of listing.  Press RETURN to continue: ",Y:$S($D(DTIME)#2:DTIME,1:60) S:'$T DTOUT="" S:Y="^" DUOUT="" Q:Y=""!(Y="^")  W !!,"Enter either RETURN or '^'",! W:Y'["?" $C(7)
 Q
 ;
PROMPT ; Prompt the user for a task number
 N DIRUT,X,Y,ZT
 F  D SETPARAM,^DIR Q:+Y=Y!$D(DIRUT)
 S ZTSK=$S($D(DIRUT):"",'$D(^%ZTSK(Y,0))&$D(^TMP($J,0,Y)):$G(^TMP($J,0,Y)),1:Y)
 S XUTMT=ZTSK
 Q
 ;
SETPARAM ;
 S DIR(0)="NAO^1:9999999999:0^D XFORM^ECXDTASK"
 S DIR("A")="Select Extract Task to Stop: "
 S DIR("?")="^D HELP1^ECXDTASK"
 S DIR("??")="^D HELP2^ECXDTASK" I DIR("??")="@" K DIR("??")
 ;I $D(XUTMT("B"))#2 S DIR("B")=XUTMT("B")
 I $D(DTIME)[0 S DIR("T")=60
 Q
 ;
XFORM ; XFORM--Does task have an intact ^%ZTSK(#,0)
 I '$D(^%ZTSK(X)),$D(^TMP($J,0,X)) S X=$G(^TMP($J,0,X)) ;Use index to get task number.
 Q
 ;
HELP1 ;SELECT--Default Help For '?'
 W !?5,"Select an extract task by its Task # (an integer between 1 and 999999999)"
 I $D(^TMP($J,0)) W ",",!?5,"or by its index number from the list."
 Q
 ;
HELP2 ;SELECT--Default Help For '??'
 N DIR,DIRUT,X,Y D START
 Q
 ;
STOPTASK ;Lookup Task File Data And Set Stop Flag
 N DA,RET
 S (DA,FOUND)=0
 F  S DA=$O(^TMP($J,DA)) Q:FOUND!(DA="")  D
 . I $G(^TMP($J,DA,XUTMT)) S FOUND=1
 I 'FOUND W !!,"Only tasks for DSS Extracts that are running or queued can be stopped." Q
 S RET=$$ASKSTOP^%ZTLOAD(XUTMT)
 D REPORT
 Q
REPORT ;Report Results Of Lookup And Stop
 I $O(ZTSK(.3))]"" W !!?5,"Task unscheduled and stopped." K XUTMT Q
 I "1356ABCDEFGIL"[$P(ZTSK(.1),U) W !,"This task was already stopped." K XUTMT Q
 W !!?5,"Task stopped!" K XUTMT Q
 ;
