PX1P88A ;PRH Utility Routine - correct dangling pointers;3/16/00
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**88**;Aug 12, 1996
 ;
START ;Entry point
 N EXIT
 S EXIT=0
 ;
 I '$D(DUZ) W !,*7,"You do not have a DUZ." Q
 K ^XTMP("PX1P88A")
 D FIND
 I '$D(^XTMP("PX1P88A","IEN")) D  G EXIT
 .W !,"NO PROBLEM VISITS FOUND"
 I '$$ASK() G EXIT
 ;
 K ZTSYNC,ZTSK,ZTSAVE,ZTIO,ZTRTN,ZTDESC,ZTQUEUED
 S ZTRTN="CREATE^PX1P88A"
 S ZTDESC="Correct duplications in V CPT - Create Error File"
 S ZTIO="",ZTSAVE("*")=""
 D ^%ZTLOAD
 I $D(ZTSK)[0 D
 . W !!,"Run Cancelled",!!
 . S EXIT=1
 I EXIT G EXIT
 W !!,"Task ",ZTSK," queued",!
 I $D(ZTSK("D")) W !,"Correct duplications Task to commence at ",$$HTE^XLFDT(ZTSK("D"))
 ;
 Q
EXIT ;
 K ^XTMP("PX1P88A")
 Q
 ;
 ;
CREATE ;Entry point from TaskMan
 N TMP,VISIT,PXSTART,PXEND,PXDUZ,EXIT
 S ZTREQ="@" ;Delete task on completion
 S TMP="^XTMP(""PX1P88A"""_","_"""IEN"""_")"
 S PXSTART=$$NOW^XLFDT
 S PXDUZ=^XTMP("PX1P88A","DUZ")
 S EXIT=0
 I $D(@TMP) D
 .S VISIT=""
 .F  S VISIT=$O(@TMP@(VISIT)) Q:'VISIT  D  Q:EXIT
 ..D LOOP Q:EXIT
 ..D REXMIT
 D:'EXIT MAIL
 K ^XTMP("PX1P88A")
 Q
 ;
LOOP ; Loop AUPNVCPT
 N IENNN,CNT
 S IENNN=""
 F CNT=1:1 S IENNN=$O(^AUPNVCPT("AD",VISIT,IENNN)) Q:IENNN=""  D  Q:EXIT
 . D LOOP1
 . I '$$S^%ZTLOAD H:'(CNT#5000) 5 Q
 . ;request made to stop run
 . S EXIT=1
 Q
 ;
LOOP1 ; Process
 N DIK,DA
 I '$D(^AUPNVCPT(IENNN)) Q  ;Being handled by PX*1*86
 S DIK="^AUPNVCPT(",DA=IENNN
 D ^DIK ; Delete Item
 ;
 Q
FIND ;Find VISIT IEN with duplicate entries
 N DAT,IEN,GLB
 S GLB="^AUPNVSIT(""B"")"
 S DAT=$$DATE()
 Q:DAT<0
 S ^XTMP("PX1P88A",0)=$$HTFM^XLFDT(+$H+7)_"^"_$$DT^XLFDT()
 S ^XTMP("PX1P88A","DUZ")=DUZ
 W !,"SEARCHING",!
 F I=1:1 S DAT=$O(@GLB@(DAT)) Q:'DAT  D
 .W:'(I#5000) "."
 .S IEN=""
 .F  S IEN=$O(@GLB@(DAT,IEN)) Q:'IEN  D
 ..I $P($G(^AUPNVSIT(IEN,0)),"^",9)>500 D:$$VER()
 ...W !,"PATIENT NAME: ",$$GET1^DIQ(9000010,IEN,.05)
 ...W !,"VISIT IEN: ",IEN
 ...W ?23,"VISIT DATE: ",$$FMTE^XLFDT($P(^AUPNVSIT(IEN,0),"^"))
 ...W !,"# of V file entries: ",$P(^AUPNVSIT(IEN,0),"^",9),!
 ...S ^XTMP("PX1P88A","IEN",IEN)=""
 Q
VER() ;VERIFY HIGH NUMBER OF V CPT FILE ENTRIES
 N CT,CPT
 S (CT,CPT)=0
 F CT=1:1 S CPT=$O(^AUPNVCPT("AD",IEN,CPT)) Q:'CPT!(CT>500)
 I CT<500 Q 0
 Q 1
 ;
REXMIT ;Flag OUTPATIENT ENCOUNTER for retransmission
 N OENC,XMIT
 S OENC=$O(^SCE("AVSIT",VISIT,0)) Q:'OENC
 S XMIT=$$CRTXMIT^SCDXFU01(OENC)
 D STREEVNT^SCDXFU01(XMIT,0)
 D XMITFLAG^SCDXFU01(XMIT,0)
 Q
ASK() ;Prompt user to run cleanup
 N DIR,DA,X,Y
 S DIR(0)="Y"
 S DIR("A")="Do you wish to TASK cleanup routine"
 D ^DIR
 Q Y
DATE() ;Ask date on which to start search
 N DIR,X,Y
 D NOW^%DTC S DT=X
 S DIR(0)="DA^"
 S DIR("A")="Enter date to begin search: "
 D ^DIR
 I Y<0!(Y["^") Q -1
 Q Y
MAIL ;Send mail notification about job completion
 N XMAIL,XMSUB,XMDUZ,XMDUN,XMTEXT,XMY,XMZ,TEXT
 S TEXT(1)="Cleanup routine PX1P88A has completed"
 S TEXT(2)="Start time: "_$$FMTE^XLFDT(PXSTART)
 S TEXT(2)=TEXT(2)_"  End time: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S XMSUB="Cleanup routine PX1P88A"
 S XMTEXT="TEXT("
 S (XMDUN,XMDUZ)="PX*88 Cleanup"
 S XMY(PXDUZ)=""
 D ^XMD
 Q
