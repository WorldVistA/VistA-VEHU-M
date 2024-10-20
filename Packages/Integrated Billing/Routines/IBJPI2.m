IBJPI2 ;DAOU/BHS - eIV SITE PARAMETERS SCREEN ACTIONS ;26-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,316,416,438,713,737,763**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - electronic Insurance Verification Interface
 ;
 ; Only call from tag
 Q
 ;
IIVEDIT ; -- IBJP IIV EDIT ACTIONS (GP,PW):  Edit eIV Site Parameters
 N DA,DR,DIE,DIC,X,Y
 ;
 ;IB*737/TAZ - Removed parameter and clean up the code
 ;
 D FULL^VALM1
 W @IOF,!,"General Parameters",!
 S DR="[IBCNE GENERAL PARAMETER EDIT]"
 S DIE="^IBE(350.9,",DA=1 D ^DIE K DA,DR,DIE,DIC,X,Y
 ;
 D INIT^IBJPI S VALMBCK="R"
 Q
 ;
LTENT ; entry from list template protocol 'IBJP IIV FIX CORRUPT BUFFERS' from 'IBJP INS VER MENU' menu
 N IBA,IBERR,IBFL,IBFR,IBMSG,IBOK,IBXTMPNM,IBGHDESC,ZTDESC,IBOKM  ;IB*763/CKB - added IBFL,IBFR
 ;
 S IBXTMPNM="IBJPI2_FIX_BUFFER_RECS",IBGHDESC="IB file 355.33 Corrupt Buffer Clean up"
 S ZTDESC="IB eInsurance FIX CORRUPTED BUFFERS IN #355.33"
 S (IBOK,IBOKM)=1
 I $G(DT)="" S DT=$$DT^XLFDT
FXLST ;IB*763/CKB - Prompt user to run 'Fix or List Corrupt Buffers'
 D FULL^VALM1
 K DIR,DIRUT,DUOUT,X,Y
 S DIR(0)="SA^F:Fix;L:List"
 S DIR("A")="Fix or List Corrupt Buffers? "
 S DIR("?")="^D FLHELP^IBJPI2"
 S DIR("??")="^D FLHELP^IBJPI2"
 S DIR("B")="List"
 D ^DIR K DIR
 S IBFR=$$UP^XLFSTR($E(Y,1))
 I IBFR="^"!$D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) D PAUSE^VALM1 G LTOUT
 I (IBFR'="F")&(IBFR'="L") W !," Select 'F'ix or 'L'ist",! G FXLST
 ;
 ;IB*763/CKB - if user selects LIST, change ZTDESC, IBXTMPNM and IBGHDESC
 ; set IBFR=("F" or "L") / IBFL=("Fix Corrupt Buffer" or "List of Corrupt Buffers")
 I IBFR="L" D
 . S ZTDESC="IB eInsurance LIST OF CORRUPTED BUFFERS IN #355.33"
 . S IBXTMPNM="IBJPI2_LIST_BUFFER_RECS",IBGHDESC="IB file 355.33 List of Corrupt Buffers"
 S IBFL=$S(IBFR="F":"Fix Corrupt Buffer",1:"List of Corrupt Buffers")
 ;
 D LTCHKRN I 'IBOK D  D PAUSE^VALM1 G LTOUT
 .;IB*763/CKB - Allow to Fix or List, using variables IBFR and IBFL
 . I IBOKM D
 .. I IBFR="F" W !,"Not submitting Fix Corrupt Buffers to run"
 .. I IBFR="L" W !,"Not creating List of Corrupt Buffers."
 D FULL^VALM1 W !!
 S IBMSG(0)=0
 S IBERR=$$TASKIN($S(IBFR="L":IBFL,1:"Corrupt Buffers Fixed"),$G(DUZ),"IBMSG")
 I +IBERR!('$G(IBMSG(0))) D  D PAUSE^VALM1 G LTOUT
 . W !!,"Error in submitting '"_IBFL_"'."
 . W !,"Please Contact eInsurance Team"
 I $G(IBMSG(0)) W !! S IBA=0 F  S IBA=$O(IBMSG(IBA)) D:'IBA PAUSE^VALM1 Q:'IBA  W IBMSG(IBA),!
 ;
LTOUT ; list template protocol quit
 D INIT^IBJPI S VALMBCK="R"
 Q
 ;
LTCHKRN ; has the CBF been run in the last 15 days
 N DIR,DIRUT,DUOUT,IBA,IBA1,IBB,IBB1,IBC,IBCHK,IBLCNT,IBLCTOP,IBLDT,IBMSF,IBMSG
 N IBRDT,IBSTR,IBT,MSG,MSGD,X,Y
 ;
 S IBCHK="",IBSTR="",$P(IBSTR,"*",80)=""
 S IBLCNT=$G(^XTMP(IBXTMPNM,"C")) I IBLCNT S IBCHK=$G(^XTMP(IBXTMPNM,0))
 S IBLDT=$P($P(IBCHK,U,2),".",1),IBRDT=$$FMTE^XLFDT(IBLDT)
 S IBMSF="Last run was "_($S(IBLDT:"on "_IBRDT,1:"over 2 weeks ago"))
 S MSGD="",MSG=$$CHKTSK
 D FULL^VALM1 W !!
 W IBMSF,!
 ;IB*763/CKB - Set MSGD using IBFL for Fix or List wording
 ;     IBFL = "Fix Corrupt Buffer" or "List of Corrupt Buffers"
 I +MSG D
 . S MSGD="*** '"_IBFL_"' "
 . S MSGD=MSGD_$P($P(MSG,U,2),"y",1)_"y ***^*** "_$P($P(MSG,U,2),"y",2,999)
 I IBLDT D  I 'IBOK Q
 . K DIR,DIRUT,DUOUT
 . S DIR("?")="Enter 'Y' to view the details of the last run, Enter 'N' to skip or '^' to quit."
 . S DIR("A")="Do you want the details",DIR(0)="Y",DIR("B")="No" D ^DIR
 . I 'Y S:$E(Y)=U!($D(DIRUT))!($D(DUOUT)) IBOK=0 Q
 . S IBLCTOP=^XTMP(IBXTMPNM,IBLCNT,0),IBT=$G(^XTMP(IBXTMPNM,IBLCNT,"T"))
 . M IBMSG=^XTMP(IBXTMPNM,IBLCNT,"M")
 . W !!,"Run For: ",$P(IBLCTOP,U,2),!
 . W "Started: " S IBC=$P(IBT,U,1) S:IBC'="" IBC=$$FMTE^XLFDT(IBC),IBC=$P(IBC,":",1,2) W IBC
 . W ?35,"Completed: " S IBC=$P(IBT,U,2) S:IBC'="" IBC=$$FMTE^XLFDT(IBC),IBC=$P(IBC,":",1,2) W IBC,!
 . S IBA=0 F  S IBA=$O(IBMSG(IBA)) Q:IBA=""  S IBB=IBMSG(IBA) I IBB'=""&(IBB'=" ") W !,IBB
 . W !
 ; don't ask submit question if already scheduled just quit out
 I MSGD'="" D  S (IBOK,IBOKM)=0 Q
 . S IBA1=$P(MSGD,U,1),IBB1=$P(MSGD,U,2,99)
 . W !!,$E(IBSTR,1,$L(IBA1)),!,IBA1,!,IBB1,($E("          ",1,($L(IBA1)-3-$L(IBB1)))),"***",!
 . W $E(IBSTR,1,$L(IBA1))
 ;
 ;IB*763/CKB - Include X,Y in kill and use IBFL for Fix or List Help Text wording
 K DIR,DIRUT,DUOUT,X,Y
 S DIR("A")="Do you want to run "_IBFL
 S DIR("?")="Enter 'Y' to run "_$S(IBFR="L":"the "_IBFL,1:"Corrupt Buffers Fix")
 S DIR("?")=DIR("?")_", Enter 'N' or '^' to quit."
 S DIR(0)="Y",DIR("B")="No"
 D ^DIR K DIR
 I $E(Y)=U!('Y)!($D(DIRUT))!($D(DUOUT)) S IBOK=0
 Q
 ;
TASKIN(IBSB,IBUS,IBRET,IBFLIN) ; Clean-up corrupted records in the Insurance Verification Processor file #355.33
 ;INPUT: 
 ; IBSB - message subject
 ; IBUS - user DUZ to use
 ; IBRET - message return array to calling entity passed in as "VARIBLE"
 ; IBFLIN - first line of e-mail message (if one) [opt]
 ;
 N IBA,IBB,IBNAME,IBUDUZ,MSG,RMSG,WMSG,ZTDTH,ZTIO,ZTQUEUED,ZTRTN,ZTSAVE
 ;
 S IBUDUZ=$G(DUZ)
 S IBUS=$G(IBUS) S:IBUS="" IBUS=$G(DUZ) I IBUS="" S IBUS=.5
 S IBSB=$G(IBSB)
 S IBRET=$G(IBRET) I IBRET="" Q "1^Need return array"
 S IBFLIN=$G(IBFLIN)
 K @IBRET
 ;
 ;IB*763/CKB - ZTDESC is already set, don't want to reset. Overwrites if user is running List 
 ;S ZTDESC="IB eInsurance FIX CORRUPTED BUFFERS IN #355.33"
 ;
 ; ZTDTH = TODAY AT 8:00 PM
 S ZTDTH=$P($$NOW^XLFDT(),"."),ZTDTH=$$FMADD^XLFDT(ZTDTH,,20)
 S ZTIO=""
 S ZTQUEUED=1
 S ZTRTN="BADRECS^IBJPI2"
 I $E(IBSB,1)="L" S ZTRTN="LIST^IBJPI2"  ;IB*763/CKB
 S ZTSAVE("IBUS")="",ZTSAVE("IBSB")="",ZTSAVE("IBFLIN")=""
 S ZTSAVE("IBXTMPNM")="",ZTSAVE("IBGHDESC")=""
 ;
 S @IBRET@(0)=1
 S RMSG(0)="",MSG=$$TASK(ZTDTH,ZTDESC,ZTRTN,ZTIO,.RMSG)
 S @IBRET@(1)=MSG
 I RMSG(0) D  ;< multi line message to avoid wrap
 . S IBA=0 F  S IBA=$O(RMSG(IBA)) Q:'IBA  S IBB=$G(RMSG(IBA)) I IBB'="" S @IBRET@(IBA+1)=IBB,@IBRET@(0)=@IBRET@(0)+1
 ;
TSKCLNQ ;
 Q ""
 ;
CHKTSK() ;Check if task already scheduled for date/time
 N GTASKS,MSGA,TSK,ZTSK
 ;
 K GTASKS
 D DESC^%ZTLOAD(ZTDESC,"GTASKS")
 S TSK="",MSGA=0
 S TSK=$O(GTASKS(TSK))
 I TSK'=""  D  Q MSGA
 . S ZTSK=TSK D ISQED^%ZTLOAD
 . S MSGA="1^Task #"_+ZTSK_" is already scheduled to run on "_$$HTE^XLFDT(ZTSK("D"),1)_" "
 Q MSGA
 ;
TASK(ZTDTH,ZTDESC,ZTRTN,ZTIO,RMSG) ;bypass for queued task
 N %DT,GTASKS,IBAA,IDT,MSG,MSG1,NOW,TIME,TSK,XDT,Y,ZTSK
 ;
 S (IDT,Y)=ZTDTH D DD^%DT S XDT=Y    ; XDT is TODAY@2000 reformatted to a readable date.
 ;
 ;Check if task already scheduled for date/time
 S RMSG(0)=0
 S MSG=$$CHKTSK
 I +MSG S MSG=$P(MSG,U,2,999) Q MSG
 ;Schedule the task
 S TSK=$$SCHED(IDT,ZTIO)
 ;
 ;Check for scheduling problem
 I $G(TSK)="" S MSG=" Task Could Not Be Scheduled" Q MSG
 ;
 ;Send successful schedule message
 S NOW=$$NOW^XLFDT,TIME=""
 I '$P(TSK,U,3) S TIME=NOW
 I $P(TSK,U,3) S TIME=$P(TSK,U,2)
 S TIME=$$FMTE^XLFDT(TIME)
 ;IB*763/CKB - allow for Fix or List message
 S MSG="Task: "_$P($G(TSK),U)_" Clean-up of corrupted records in file #355.33"
 I IBFR="L" S MSG="Task: "_$P($G(TSK),U)_" List of Corrupt Buffers in file #355.33       "
 S RMSG(1)="      scheduled for "_TIME
 S RMSG(0)=1
 Q MSG
 ;
SCHED(ZTDTH,ZTIO) ;
 N ZTSK,IBDT
 D ^%ZTLOAD
 I $G(ZTSK)="" Q ""
 S IBDT=$$HTFM^XLFDT(ZTSK("D"))
 ; 72000 represents 8pm in $harlog seconds
 Q ZTSK_U_IBDT_U_$S($P(ZTSK("D"),",",2)=72000:1,1:0)
 ;
BADRECS ; Clean-up corrupted records in File #355.33.
 N CNT,DA,DIC,DIE,DR,I,IBART,IBUNAME,IBBUFDA,IBNODE0,IBOK,IBP01,IBPATNM
 N IBRETA,IBSTAT,IBSTART,IBSTOP,IBTYP,IBWRKARY,IBXMY,MSG,SITESYS,SITENAME
 N TOTAL,X,Y
 ;
 K IBART S IBART=""
 ; recalculate SITESYS here as this tag is called from TaskMan
 S SITESYS=$$SITE^VASITE ; Get the site name & #
 S SITENAME=$P(SITESYS,U,2),SITESYS=$P(SITESYS,U,3) ; piece 3 is the site #
 S IBSTART=$$NOW^XLFDT()
 F I="AR","B","E" S CNT(I)=0
 ;
 ;Search for corrupted entries
 S IBBUFDA=0
 F  S IBBUFDA=$O(^IBA(355.33,IBBUFDA)) Q:('+IBBUFDA)  D
 . ; get node 0
 . S IBNODE0=$G(^IBA(355.33,IBBUFDA,0))
 . ; get (#.01) date entered, (#.04) status, (#60.01) patient name
 . K IBRETA D GETS^DIQ(355.33,IBBUFDA_",",".01;.04;60.01","I","IBRETA")
 . K IBWRKARY M IBWRKARY=IBRETA(355.33,IBBUFDA_",")
 . S IBSTAT=$G(IBWRKARY(.04,"I")),IBP01=$G(IBWRKARY(.01,"I")),IBPATNM=$G(IBWRKARY(60.01,"I"))
 . ;
 . ; If missing .01 then delete (DATE ENTERED is not populated)
 . I IBP01="" D DELREC(".01",IBPATNM) S IBTYP="B",CNT(IBTYP)=$G(CNT(IBTYP))+1 Q
 . ;
 . ; Corrupted buffer entry (STATUS is not E,A,R)
 . I IBSTAT="" D DELREC(".04",IBPATNM) S IBTYP="B",CNT(IBTYP)=$G(CNT(IBTYP))+1 Q
 . ;
 . I IBSTAT="E" D  Q
 . . ; Patient Name is missing for Entered Status
 . . I IBPATNM="" D DELREC("60.01",IBPATNM) S IBTYP="B",CNT(IBTYP)=$G(CNT(IBTYP))+1
 . ;
 . ; Accepted/Rejected buffer entries, clean up all but the Zero node
 . I (("^A^R^")[("^"_IBSTAT_"^")) D
 . . ; Corrupted buffer entry (PATIENT NAME is populated - EVIL GHOST)
 . . I IBPATNM'="" D DELDATA S IBTYP="E",CNT(IBTYP)=$G(CNT(IBTYP))+1 Q
 . . ;
 . . ; Corrupted buffer entry (PATIENT NAME is not populated & has a node other than Zero)
 . . I IBPATNM="",$O(^IBA(355.33,IBBUFDA,0)) D
 . . . D XREFC(0) D DELDATA S IBTYP="AR",CNT(IBTYP)=$G(CNT(IBTYP))+1
 ;
 ;Send mailman message at completion.
 S IBUNAME=$$NAME^XUSER($G(IBUS))
 I $G(IBFLIN)="" S IBFLIN=IBUNAME_", ran 'Fix Corrupt Buffer' on "_$$FMTE^XLFDT($P($$NOW^XLFDT,".",1),1)
 ;
 S MSG(1)=IBFLIN
 S MSG(2)="  - Clean-up of corrupted #355.33 records has completed."
 S MSG(3)="------------------------------------------------------------------------"
 S MSG(4)=" # of corrupt buffer entries corrected (stopped ins. verification): "_CNT("E")
 S MSG(5)=" "
 S MSG(6)=" # of corrupt Accepted/Rejected buffer entries corrected: "_CNT("AR")
 S MSG(7)=" "
 S MSG(8)=" # of corrupt buffer entries removed (bad zero node): "_CNT("B")
 S TOTAL=CNT("E")+CNT("AR")
 S MSG(9)=" "
 S MSG(10)=" Total entries removed: "_CNT("B")
 S MSG(11)=" "
 S MSG(12)=" Total entries corrected: "_TOTAL
 ;
 D IBXSAV
 ; Only send to eInsurance Rapid Response if in Production
 ;  1=Production Environment, 0=Test Environment
 I $G(IBSB)="" S IBSB="Corrupt Buffers Fixed"
 I $$PROD^XUPROD(1) D
 . S IBXMY("VHAeInsuranceRapidResponse@domain.ext")=""
 . D MSG^IBCNEUT5(,IBSB_" ("_SITESYS_"-"_SITENAME_")","MSG(",,.IBXMY)
 ;
 ; Tell TaskManager to delete the task's record
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
BADRECQ ; Exit from Cleaning up Buffers.
 Q
 ;
IBXSAV ; save message into ^XTMP for 15 days
 N IBNOK,IBCNT,IBHNG
 ;
 S (IBNOK,IBCNT,IBHNG)=0,IBSTOP=$$NOW^XLFDT()
 F  L +^XTMP(IBXTMPNM):30 Q:$T  H 10 S IBHNG=IBHNG+1 I IBHNG>10 S IBNOK=1 Q
 I IBNOK Q  ; not able to get the lock
 S ^XTMP(IBXTMPNM,0)=$$FMADD^XLFDT(DT,15)_U_$$NOW^XLFDT()_U_IBGHDESC
 S IBCNT=$G(^XTMP(IBXTMPNM,"C"))+1,^XTMP(IBXTMPNM,"C")=IBCNT
 L -^XTMP(IBXTMPNM)
 ; place message info in ^XTMP
 S ^XTMP(IBXTMPNM,IBCNT,0)=$G(IBUNAME)_U_SITESYS_"-"_SITENAME
 M ^XTMP(IBXTMPNM,IBCNT,"M")=MSG
 ; place start-stop time
 S ^XTMP(IBXTMPNM,IBCNT,"T")=IBSTART_U_IBSTOP
 ;
 ; place tmp array kill items in ^XTMP
 ; M ^XTMP(IBXTMPNM,IBCNT,"K")=IBART  ;(* use for debugging by programmer only)
 Q
 ;
DELDATA ; Delete data from corrupted records
 D DELDATA^IBCNBED(IBBUFDA)
 Q
 ;
DELREC(FIELD,IBPATNM) ;Delete entire record as it is unrecoverable
 ;; Kills all nodes, including the zero node, and all cross references
 ; FIELD - missing field so we have to kill a few cross-references first
 ; IBPATNM - Patient name (#355.33,60.01)
 ;
 N DA,DIK,IBAR1,IBAR2,IBAR3,IBL1,IBL2,IBL3,IBLIEN,IBLP,IBSP,IBSN,IBOST
 ;
 I FIELD="" Q
 ;
 ; ** Before killing the buffer record using IBBUFDA, search and kill specific
 ;    cross-references that would be left behind due to missing
 ;    data as it is a corrupted record.
 ;
 I FIELD=".01" D  ; (#355.33,.01)
 . K IBAR1,IBAR2,IBAR3
 . S IBL1=0 F  S IBL1=$O(^IBA(355.33,"B",IBL1)) Q:'IBL1  D
 . . S IBLIEN=0 F  S IBLIEN=$O(^IBA(355.33,"B",IBL1,IBLIEN)) Q:'IBLIEN  D
 . . . I IBLIEN=IBBUFDA S IBAR1(IBL1)="" K ^IBA(355.33,"B",IBL1,IBBUFDA)
 ;
 I FIELD=".01"!(FIELD=".04") D  ; (#355.33,.01) & (#355.33,.04)
 . S IBL1="" F  S IBL1=$O(^IBA(355.33,"AEST",IBL1)) Q:IBL1=""  D
 . . S IBL2=0 F  S IBL2=$O(^IBA(355.33,"AEST",IBL1,IBL2)) Q:'IBL2  D
 . . . S IBLIEN=0 F  S IBLIEN=$O(^IBA(355.33,"AEST",IBL1,IBL2,IBLIEN)) Q:'IBLIEN  D
 . . . . I IBLIEN=IBBUFDA S IBAR2(IBL1,IBL2)="" K ^IBA(355.33,"AEST",IBL1,IBL2,IBBUFDA)
 . ;
 . S IBL1="" F  S IBL1=$O(^IBA(355.33,"AFST",IBL1)) Q:IBL1=""  D
 . . S IBL2=0 F  S IBL2=$O(^IBA(355.33,"AFST",IBL1,IBL2)) Q:'IBL2  D
 . . . S IBLIEN=0 F  S IBLIEN=$O(^IBA(355.33,"AFST",IBL1,IBL2,IBLIEN)) Q:'IBLIEN  D
 . . . . I IBLIEN=IBBUFDA S IBAR3(IBL1,IBL2)="" K ^IBA(355.33,"AFST",IBL1,IBL2,IBBUFDA)
 . ;
 . I 'IBPATNM D XREFC(1)
 . ;
 . ; save into total  ;(* IBART - use for debugging by programmer only)
 . ;M IBART(IBBUFDA,"B")=IBAR1,IBART(IBBUFDA,"AEST")=IBAR2,IBART(IBBUFDA,"AFST")=IBAR3
 ;
 I FIELD="60.01" D XREFC(1)
 ;
 ; Kills all nodes, including the zero node, and all cross references where the 
 ;   data was present on the record
 S DIK="^IBA(355.33,",DA=IBBUFDA
 D ^DIK K DA,DIK
 Q
 ;
XREFC(DELREC) ; Clean up possible bad "C" cross-reference related to (#355.33,60.01)
 ;
 ; DELREC - 1 if the entire record in #355.33 will be killed, track the killing of the "C" x-ref
 ;          0 the record will not be killed, do not track the killing of the "C" x-ref 
 ;
 N IBAR4,IBL1,IBLIEN
 K IBAR4
 S IBL1=0 F  S IBL1=$O(^IBA(355.33,"C",IBL1)) Q:'IBL1  D
 . S IBLIEN=0 F  S IBLIEN=$O(^IBA(355.33,"C",IBL1,IBLIEN)) Q:'IBLIEN  D
 . . I IBLIEN=IBBUFDA S IBAR4(IBL1)="" K ^IBA(355.33,"C",IBL1,IBBUFDA)
 ;
 ; save into total   ;(* IBART - use for debugging by programmer only)
 ;I DELREC M IBART(IBBUFDA,"C")=IBAR4
 Q
 ;
LIST ;IB*763/CKB - List of Corrupted Buffers in File #355.33 
 N IBARR,IBBUFDA,IBCNT,IBHNG,IBNODE0,IBNOK,IBP01,IBPATNM,IBREC,IBSTART,IBSTAT,IBSTOP
 N IBUNAME,LN,MSG,SITENAME,SITESYS,TOTAL
 ;
 ; recalculate SITESYS here as this tag is called from TaskMan
 S SITESYS=$$SITE^VASITE ; Get the site name & #
 S SITENAME=$P(SITESYS,U,2),SITESYS=$P(SITESYS,U,3) ; piece 3 is the site #
 S IBSTART=$$NOW^XLFDT()
 S IBUNAME=$$NAME^XUSER($G(IBUS))
 ;
 ;List Header
 S LN=1,TOTAL=0
 S MSG(LN)="Last run by "_IBUNAME,LN=LN+1
 S MSG(LN)="   ",LN=LN+1
 S MSG(LN)="Date Created^Buffer IEN^Patient",LN=LN+1
 ;
 ;Search for corrupted entries
 S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,IBBUFDA)) Q:('+IBBUFDA)  D
 . ; get node 0
 . S IBNODE0=$G(^IBA(355.33,IBBUFDA,0))
 . ; get (#.01) date entered, (#.04) status, (#60.01) patient name
 . K IBARR,IBREC
 . D GETS^DIQ(355.33,IBBUFDA_",",".01;.04;60.01","IE","IBREC")
 . M IBARR=IBREC(355.33,IBBUFDA_",")
 . S IBSTAT=$G(IBARR(.04,"I")),IBP01=$G(IBARR(.01,"I")),IBPATNM=$G(IBARR(60.01,"E"))
 . ;
 . ; If missing .01(DATE ENTERED is not populated)
 . I IBP01="" D SAVLIST Q
 . ; Corrupted buffer entry (STATUS is not E,A,R)
 . I IBSTAT="" D SAVLIST Q 
 . ; Patient Name is missing for Entered Status
 . I IBSTAT="E",IBPATNM="" D SAVLIST Q
 . ;
 . ; Accepted/Rejected buffer entries
 . I (("^A^R^")[("^"_IBSTAT_"^")) D
 . . ; Corrupted buffer entry (PATIENT NAME is populated - EVIL GHOST)
 . . I IBPATNM'="" D SAVLIST Q
 . . ; Corrupted buffer entry (PATIENT NAME is not populated & has a node other than Zero)
 . . I IBPATNM="",$O(^IBA(355.33,IBBUFDA,0)) D SAVLIST
 ;
 S MSG(LN)="**End of Report**"
 ;
 ; save message into ^XTMP for 15 days
 S (IBNOK,IBCNT,IBHNG)=0,IBSTOP=$$NOW^XLFDT()
 ;
 ; IBXTMPNM = "IB eInsurance LIST OF CORRUPTED BUFFERS IN #355.33"
 F  L +^XTMP(IBXTMPNM):30 Q:$T  H 10 S IBHNG=IBHNG+1 I IBHNG>10 S IBNOK=1 Q
 I IBNOK Q  ; not able to get the lock
 S ^XTMP(IBXTMPNM,0)=$$FMADD^XLFDT(DT,15)_U_$$NOW^XLFDT()_U_"IB file 355.33 List of Corrupt Buffers"
 S IBCNT=$G(^XTMP(IBXTMPNM,"C"))+1,^XTMP(IBXTMPNM,"C")=IBCNT
 L -^XTMP(IBXTMPNM)
 ;
 ; place message info in ^XTMP
 S ^XTMP(IBXTMPNM,IBCNT,0)=$G(IBUNAME)_U_SITESYS_"-"_SITENAME
 M ^XTMP(IBXTMPNM,IBCNT,"M")=MSG
 ; place start-stop time
 S ^XTMP(IBXTMPNM,IBCNT,"T")=IBSTART_U_IBSTOP
 ;
LISTQ ; Exit from List
 ; Tell TaskManager to delete the task's record
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
SAVLIST ;IB*763/CKB - Save List output to MSG array
 S MSG(LN)=$$DAT3^IBOUTL(IBARR(.01,"I"))_"^"_IBBUFDA_"^"_IBARR(60.01,"E")
 S LN=LN+1,TOTAL=TOTAL+1
 Q
 ;
FLHELP ;IB*763/CKB - Help Text for the 'Fix or List Corrupt Buffers' prompt.
 W !!," Select Fix to fix corrupted entries in the INSURANCE VERIFICATION PROCESSOR"
 W !," file (#355.33) aka 'the buffer file'. Select List to display corrupted entries"
 W !," in the INSURANCE VERIFICATION PROCESSOR file (#355.33) aka 'the buffer file'."
 Q
