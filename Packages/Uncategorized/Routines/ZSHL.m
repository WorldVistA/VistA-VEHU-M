ZSHL ;HL7 Link utility
 
 
Start ;
 s U="^",DUZ(0)="@"
 d STRTSTOP
 H 10
 d STRTSTOP1
 d STALL
 d QUE
 q
 
 
STRTSTOP ;Stolen from HLCSLM
 ;ENTRY POINT TO START/STOP TCP LINK MANAGER
 ; MOD
 L +^HLCS("HLCSLM"):3 E  D  Q
 .D STOPLM
 L -^HLCS("HLCSLM")
 Q
 
STRTSTOP1 ;Stolen from HLCSLM
 ;ENTRY POINT TO START/STOP TCP LINK MANAGER
 N DIR,DIRUT,Y
 L +^HLCS("HLCSLM"):3
 D TASKLM
 L -^HLCS("HLCSLM")
 Q
 
STOPLM  ; Stolen from HLCSLM
 ;ENTRY POINT TO STOP LINK MANAGER
 N DIC,X,Y,DTOUT,DUOUT,DLAYGO,DIE,DA,DR
 S DIC="^HLCS(869.3,"
 S X=1
 D ^DIC
 S DA=+Y,DIE=DIC
 S DR="53////1"
 D ^DIE
 ;W !,"Link Manager has been asked to stop"
 Q
 
TASKLM ; Stolen from HLCSLM
 ;Task Link Manager
 ;Declare variables
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK,TMP
 S ZTIO=""
 S ZTDTH=$H
 ;Task Link Manager
 S ZTRTN="EN^HLCSLM"
 S ZTDESC="HL7 Link Manager"
 ;Call TaskMan
 D ^%ZTLOAD
 I $G(ZTSK) ; W !,"Link Manager queued as task number ",ZTSK
 E  ;W $C(7),!!,"Unable to start/restart Link Manager"
 Q
 
STALL  ; Stolen from HLCS2
 ;STOP ALL LINKS AND FILERS
 N DIR,Y
 ; W ! S DIR(0)="Y",DIR("A")="Okay to shut down all Links and Filers"
 ; D ^DIR
 ; I 'Y!($D(DIRUT))!($D(DUOUT)) W !!,"Shutdown Aborted!" Q
 ;  W !,"Shutting down all Links and Filers..."
 D CLEAR
 D LLP(1)
 Q
 
QUE ;Restart Filers and AUTOSTART Logical Links after system re-boot
 N DIR,Y
 ;I '$D(ZTQUEUED) D  Q:'Y!($D(DIRUT))!($D(DUOUT))
 .; W ! S DIR(0)="Y",DIR("A")="Shutdown and restart ALL AUTOSTART links and filers. Okay"
 .; D ^DIR
 .; I 'Y!($D(DIRUT))!($D(DUOUT)) W !!,"RESTART Aborted!" Q
 .;W !,"Restarting all Autostart-Enabled Links and Filers..."
 D CLEAR
 D STARTF
 D LLP(0)
 D STRT
 Q
 
CLEAR ;Reset state of 869.3
 S DA(1)=1,DA=0,DIK="^HLCS(869.3,1,2,"
 F  S DA=$O(^HLCS(869.3,DA(1),2,DA)) Q:DA<1  D ^DIK
 S DA=0,DIK="^HLCS(869.3,1,3,"
 F  S DA=$O(^HLCS(869.3,DA(1),3,DA)) Q:DA<1  D ^DIK
 Q
 
STARTF ;Start filers
 ;Get Defaults
 N TMP,PTR,DEFCNT,DA,HLCNT,HLNODE1
 S PTR=+$O(^HLCS(869.3,0)) Q:'PTR
 ;default # of incoming filers
 S HLNODE1=$G(^HLCS(869.3,PTR,1)),DEFCNT=+$P(HLNODE1,U) S:'DEFCNT DEFCNT=1
 F HLCNT=1:1:DEFCNT S TMP=$$TASKFLR^HLCS1("IN")
 ;default # of outgoing filers
 S DEFCNT=+$P(HLNODE1,U,2) S:'DEFCNT DEFCNT=1
 F HLCNT=1:1:DEFCNT S TMP=$$TASKFLR^HLCS1("OUT")
 Q
 
LLP(ALL) ;Stop Logical Links
 ;ALL=1 OR 0 IF zero, only AUTOSTART LINKS get stopped
 N HLDP,HLDP0,HLPARM0,HLPARM4,HLJ,X,Y S HLDP=0
 F  S HLDP=$O(^HLCS(870,HLDP)) Q:'HLDP  S HLDP0=$G(^(HLDP,0)),X=+$P(HLDP0,U,3) D:X
 .;skip this link if not stopping all and Autostart not enabled
 . I 'ALL&('$P(HLDP0,U,6)) Q
 . S HLPARM4=$G(^HLCS(870,HLDP,400))
 . ;TCP Multi listener for non-Cache uses UCX
 . I $P(HLPARM4,U,3)="M" Q:^%ZOSF("OS")'["OpenM"  Q:$$OS^%ZOSV["VMS"
 . ;4=status,10=Time Stopped,9=Time Started,11=Task Number,3=Device Type,14=shutdown?
 . S X="HLJ(870,"""_HLDP_","")",@X@(4)="Halting",@X@(10)=$$NOW^XLFDT,(@X@(11),@X@(9))="@",@X@(14)=1
 . I $P(HLPARM4,U,3)="C"&("N"[$P(HLPARM4,U,4)),'$P(HLDP0,U,12) S @X@(4)="Shutdown"
 . D FILE^HLDIE("","HLJ","","LLP","HLCS2") ;HL*1.6*109
 . ;Cache system, need to open TCP port to release job
 . I ^%ZOSF("OS")["OpenM",($P(HLPARM4,U,3)="M"!($P(HLPARM4,U,3)="S")) D
 .. ;pass task number to stop listener
 .. S:$P(HLDP0,U,12) X=$$ASKSTOP^%ZTLOAD(+$P(HLDP0,U,12))
 .. D CALL^%ZISTCP($P(HLPARM4,U),$P(HLPARM4,U,2),10)
 .. I POP D HOME^%ZIS Q
 .. D CLOSE^%ZISTCP
 Q
 
STRT ;Start Links
 N HLDP,HLDP0,HLDAPP,HLTYPTR,HLBGR,HLENV,HLPARAM0,HLPARM4,HLQUIT,ZTRTN,ZTDESC,ZTSK,ZTCPU
 S HLDP=0
 F  S HLDP=$O(^HLCS(870,HLDP)) Q:HLDP<1  S HLDP0=$G(^(HLDP,0)) D
 . S HLPARM4=$G(^HLCS(870,HLDP,400))
 . ;quit if no parameters or AUTOSTART is disabled
 . Q:'$P(HLDP0,U,6)
 . ;HLDAPP=LL name, HLTYPTR=LL type, HLBGR=routine, HLENV=environment check
 . S HLDAPP=$P(HLDP0,U),HLTYPTR=+$P(HLDP0,U,3),HLBGR=$G(^HLCS(869.1,HLTYPTR,100)),HLENV=$G(^(200))
 . ;quit if no LL type or no routine
 . Q:'HLTYPTR!(HLBGR="")
 . I HLENV'="" K HLQUIT X HLENV Q:$D(HLQUIT)
 . ;TCP Multi listener for non-Cache uses UCX
 . I $P(HLPARM4,U,3)="M" Q:^%ZOSF("OS")'["OpenM"  Q:$$OS^%ZOSV["VMS"
 . I $P(HLPARM4,U,3)="C"&("N"[$P(HLPARM4,U,4)) D  Q
 .. ;4=status 9=Time Started, 10=Time Stopped, 11=Task Number 
 .. ;14=Shutdown LLP, 3=Device Type, 18=Gross Errors
 .. N HLJ,X
 .. I $P(HLDP0,U,15)=0 Q
 .. L +^HLCS(870,HLDP,0):2
 .. E  Q
 .. S X="HLJ(870,"""_HLDP_","")"
 .. S @X@(4)="Enabled",@X@(9)=$$NOW^XLFDT,@X@(14)=0
 .. D FILE^HLDIE("","HLJ","","STRT","HLCS2") ; HL*1.6*109
 .. L -^HLCS(870,HLDP,0)
 .. Q
 . S ZTRTN=$P(HLBGR," ",2),ZTIO="",ZTDTH=$H,HLTRACE=""
 . S ZTDESC=HLDAPP_" Low Level Protocol",ZTSAVE("HLDP")=""
 . ;get startup node
 . I $P(HLPARM4,U,6),$D(^%ZIS(14.7,+$P(HLPARM4,U,6),0)) S ZTCPU=$P(^(0),U)
 . D ^%ZTLOAD
 Q
 
 
