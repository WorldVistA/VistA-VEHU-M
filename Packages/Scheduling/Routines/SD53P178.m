SD53P178 ;BP-CIOFO/KEITH - Clean up duplicate encounter records  ; 17 Feb 99  1:07 PM
 ;;5.3;Scheduling;**178**;AUG 13, 1993
 ;
NOQ ;Suppress option question in KIDS
 S:$G(XPDENV)=1 XPDDIQ("XPZ1")=0 Q
 ;
RUN ;Check outpatient encounters for duplicates.
 N %DT,DIR
 W !,"SD*5.3*178 Duplicate Encounter Record Report & Cleanup"
 W !!,"**** Date Range Selection ****"
 W ! S %DT="AEPXT",%DT("A")="Beginning date: " D ^%DT G:Y<1 EXIT S SDBDT=Y X ^DD("DD") S SDPBDT=Y
EDT S %DT("A")="   Ending date: " W ! D ^%DT G:Y<1 EXIT
 I Y<SDBDT W !!,$C(7),"End date cannot be before begin date!",! G EDT
 S SDEDT=Y S:SDEDT#1=0 SDEDT=SDEDT_.999999 X ^DD("DD") S SDPEDT=Y
 S DIR(0)="S^R:REPORT ONLY;C:CLEAN UP & REPORT",DIR("A")="Select utility format"
 S DIR("?",1)="'REPORT ONLY' will produce a mail message that lists duplicate encounter"
 S DIR("?",2)="records found within the date range specified.  'CLEAN UP & REPORT' will"
 S DIR("?",3)="delete duplicate encounter records that are found and produce a mail"
 S DIR("?")="message that lists those records."
 W ! D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT S SDFMT=Y
 N ZTSAVE,I F I="SDBDT","SDEDT","SDPBDT","SDPEDT","SDFMT" S ZTSAVE(I)=""
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 S ZTRTN="OECK^SD53P178",ZTDESC="Check for duplicate encounters",ZTIO=""
 K %DT S %DT="AEFRX",%DT("A")="Date/time to run report"_$S(SDFMT="R":"",1:" & cleanup")_": ",%DT("B")="NOW" W ! D ^%DT G:Y<1 EXIT
 S ZTDTH=Y D ^%ZTLOAD
 I ZTSK W !!,"Task ",ZTSK," queued."
 E  W !!,"Unable to queue."
 G EXIT
 ;
OECK ;Search database and cleanup if indicated
 S (SDCI,SDCT)=0,SDDT=SDBDT K ^TMP("SD178",$J)
 F  S SDDT=$O(^SCE("B",SDDT)) Q:'SDDT!(SDDT>SDEDT)  D
 .S SDOE=0 F  S SDOE=$O(^SCE("B",SDDT,SDOE)) Q:'SDOE  D
 ..S SDCI=$$EVAL(SDOE) Q:'SDCI
 ..S SDCT=SDCT+1,^TMP("SD178",$J,1,SDPNAM,DFN,SDDT,SDOE)=SDSSN_U_SDCLN
 ..I SDFMT="C" D CLEAN(SDOE,SDCI)
 ..Q
 .Q
 ;
 ;Report findings
 S SDL=0 D XML("For date range: "_SDPBDT_" to "_SDPEDT),XML(" ")
 I 'SDCT D XML("No duplicate encounter records found in this time frame!") G XM
 D XML(SDCT_" duplicate encounter record"_$S(SDCT=1:"",1:"s")_$S(SDFMT="R":" identified.",1:" deleted.")),XML(" ")
 S (SDLINE,SDX)="",$P(SDLINE,"-",31)="" D XMX(1,"Patient"),XMX(20,"SSN"),XMX(31,"Encounter"),XMX(42,"Date/time"),XMX(59,"Location"),XML(SDX)
 S SDX="" D XMX(1,$E(SDLINE,1,17)),XMX(20,$E(SDLINE,1,9)),XMX(31,$E(SDLINE,1,9)),XMX(42,$E(SDLINE,1,15)),XMX(59,$E(SDLINE,1,20)),XML(SDX)
 S SDPNAM="" F  S SDPNAM=$O(^TMP("SD178",$J,1,SDPNAM)) Q:SDPNAM=""  D
 .S DFN=0 F  S DFN=$O(^TMP("SD178",$J,1,SDPNAM,DFN)) Q:'DFN  D
 ..S SDDT=0 F  S SDDT=$O(^TMP("SD178",$J,1,SDPNAM,DFN,SDDT)) Q:'SDDT  D
 ...S SDOE=0 F  S SDOE=$O(^TMP("SD178",$J,1,SDPNAM,DFN,SDDT,SDOE)) Q:'SDOE  D
 ....S SDX="",SDSSN=^TMP("SD178",$J,1,SDPNAM,DFN,SDDT,SDOE)
 ....S SDCLN=$P(SDSSN,U,2),SDSSN=$P(SDSSN,U)
 ....D XMX(1,$E(SDPNAM,1,17)),XMX(20,SDSSN),XMX(31,SDOE)
 ....D XMX(42,$$DT(SDDT)),XMX(59,$E(SDCLN,1,20)),XML(SDX)
 ....Q
 ...Q
 ..Q
 .Q
 ;
XM ;Send mail message
 N XMSUB,XMDUZ,XMDUN,XMTEXT,XMY,XMZ
 S XMSUB="Duplicate encounter report"_$S(SDFMT="R":"",1:" & cleanup")
 S (XMDUZ,XMDUN)="SD*5.3*178",XMY(DUZ)="",XMTEXT="^TMP(""SD178"",$J,2,"
 D ^XMD
 ;
EXIT ;Clean up and quit
 K %DT,DA,DFN,DIK,DIR,DTOUT,DUOUT,I,SDACT,SDAPST,SDBDT,SDCI,SDCLN,SDCT,SDDT,SDEDT,SDFMT,SDI,SDL,SDOE,SDOE0
 K SDLINE,SDOECH,SDOPT,SDPBDT,SDPEDT,SDPNAM,SDPTAP0,SDSSN,SDVSIT,SDX,SDXOE,SDXOE0,X,Y,^TMP("SD178",$J) Q
 ;
XMX(X,Y) ;Set message text value
 S $E(SDX,X)=Y Q
 ;
XML(SDX) ;Set message text line
 S SDL=SDL+1
 S ^TMP("SD178",$J,2,SDL)=SDX Q
 ;
DT(SDDT) ;Format slashed date
 Q $E(SDDT,4,5)_"/"_$E(SDDT,6,7)_"/"_(17+$E(SDDT))_$E(SDDT,2,3)_"@"_$E($P(SDDT,".",2)_"0000",1,4)
 ;
EVAL(SDOE) ;Evaluate encounter
 N SDACT
 S SDOE0=$$GETOE^SDOE(SDOE) Q:'SDOE0 0  Q:$P(SDOE0,U,6) 0
 Q:$P(SDOE0,U,12)'=14 0  S DFN=$P(SDOE0,U,2) Q:'DFN 0
 S SDACT=$$ACT($P(SDOE0,U,8)) Q:'SDACT 0
 S SDPNAM=$G(^DPT(DFN,0)),SDSSN=$P(SDPNAM,U,9),SDPNAM=$P(SDPNAM,U) Q:'$L(SDPNAM) 0
 S SDCLN=$P($G(^SC(+$P(SDOE0,U,4),0)),U) Q:'$L(SDCLN) 0
 Q SDACT
 ;
ACT(SDOPT) ;Evaluate action indicated
 ;Input: SDOPT=encounter originating process type
 ;Output: action indicated - '1' = encounter/visit cleanup
 ;                           '2' = complete checkout cleanup
 ;                           '0' = no action indicated
 N SDAPST,SDI,SDXOE,SDXOE0
 Q:'SDOPT 0  Q:"12"'[SDOPT 0
 S SDPTAP0=$G(^DPT(DFN,"S",+SDOE0,0))
 I SDOPT=1 S SDPTAP0=$G(^DPT(DFN,"S",+SDOE0,0)),SDAPST=$P(SDPTAP0,U,2) Q:$P(SDPTAP0,U,20)=SDOE 0  Q:+SDPTAP0'=$P(SDOE0,U,4) 2  Q:SDAPST="" 1  Q:"NAPCA"[SDAPST 2  Q 1
 S SDVSIT=$P(SDOE0,U,5),(SDI,SDXOE)=0
 I SDVSIT F  S SDXOE=$O(^SCE("AVSIT",SDVSIT,SDXOE)) Q:'SDXOE!SDI  D
 .Q:SDXOE=SDOE  S SDXOE0=$$GETOE^SDOE(SDXOE)
 .I '$P(SDXOE0,U,6),$P(SDXOE0,U,8)=2,$P(SDXOE0,U,12)=2 S SDI=1
 .Q
 Q SDI
 ;
CLEAN(SDOE,SDCI) ;Clean up records for a specified duplicate "parent" encounter
 ;Input: SDOE=encounter ifn
 ;Input: SDCI=cleanup indicator: '1' = encounter/visit cleanup
 ;                               '2' = complete checkout cleanup
 I SDCI=2 D EN^SDCODEL(SDOE,0) Q
 S SDOECH=0 F  S SDOECH=$O(^SCE("APAR",SDOE,SDOECH)) Q:'SDOECH  D CLOE(SDOECH)
 D CLOE(SDOE) Q
 ;
CLOE(DA) ;Delete OUTPATIENT ENCOUNTER record
 S SDVSIT=$P($$GETOE^SDOE(DA),U,5)
 N DIK S DIK="^SCE(" D ^DIK
 I SDVSIT N SDX S SDX=$$KILL^VSITKIL(SDVSIT)
 Q
