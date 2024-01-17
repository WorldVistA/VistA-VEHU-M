TIUASCU ; NA/AJB - ADDITIONAL SIGNER CLEANUP 2.0;11/08/23  10:30
 ;;1.0;TEXT INTEGRATION UTILITIES;**254,357**;Jun 20, 1997;Build 5
 ;
 ; Reference to $$GET1^DID supported by ICR #2052
 ; Reference to $$GET1^DIQ supported by ICR #2056
 ; Reference to $$DIV^XUSER supported by ICR #2533
 ; Reference to HOME^%ZIS supported by ICR #10086
 ; Reference to *^XGF supported by ICR #3173
 ; Reference to *^XLFDT supported by ICR #10103
 ; Reference to *^XLFSTR supported by ICR #10104
 ; Reference to ^%ZTLOAD supported by ICR #10063
 ; Reference to ^DIC supported by ICR #10006
 ; Reference to ^DIK supported by ICR #10013
 ; Reference to ^DIR supported by ICR #10026
 ; Reference to ^XMD supported by ICR #10070
 ; Reference to File ^DIC(49 supported by ICR #4330
 ; Reference to File ^DPT supported by ICR #10035
 ; Reference to File ^VA supported by ICR #10060
 ; Reference to EN^XUTMDEVQ supported by ICR #1519
 ; Reference to HASH^XUSHSHP supported by ICR #10045
 ; Reference to ^%ZOSF(*) supported by ICR #10096
 ; Reference to *^XGF supported by ICR #3173
 ;
 Q
EN N C,DATE,EXIT,POP,X,Y S DT=$$DT^XLFDT,U="^"
 D HOME^%ZIS,PREP^XGF G EXIT:$$CHK(.DATE)
 D INTRO^TIUASCU1,IOXY^XGF(IOSL-1,0),ENTER
 F  D  Q:EXIT
 . S EXIT=$$CHK(.DATE) Q:EXIT  D PREP^XGF
 . N CNT,DIERR,DILOCKTM,DIR,DISYS,EXE,ROW,SCR
 . S SCR("User")=$G(DUZ,0)_U_$$GET1^DIQ(200,$G(DUZ)_",",.01)
 . F X=0:1 S Y=$P($T(MENU+X),";;",2) Q:Y=""  D
 . . I X=0 W IOUON_$$CJ^XLFSTR(Y,IOM)_IOUOFF,! Q
 . . I (Y["VIEW"&('+$O(^XTMP("TIUASCU",0))))!(Y'["VIEW"&('DATE("Start"))) Q
 . . S CNT=+$G(CNT)+1,EXE(CNT)=Y,$P(DIR,";",CNT)=CNT_":"_$P(Y,U)
 . . W !,?22,CNT_"  "_$P(Y,U)
 . S CNT=CNT+1,EXE(CNT)="QUIT^S EXIT=1",$P(DIR,";",CNT)=CNT_":"_"QUIT" W !,?22,CNT_"  QUIT"
 . N DEFAULT S DEFAULT=$P($P($P(DIR,";"),"1:",2)," ")
 . S DIR="SAO^"_DIR W !,IOCUON S X=$$DIR^TIUASCU1(.DIR,"What would you like to do? ",DEFAULT) S:'X EXIT=1 Q:EXIT  S SCR("Action")=$P(EXE(X),U)
 . W ! X $TR($P(EXE(X),U,2),":",U) Q:'Y!(EXIT)  D CLS
 . ; check criteria, if none entered quit
 . N I,J S I=0 F J=4,49,200,8925.6,"Start","End","Terminated","DISUSER'd" S I=I+$G(SCR(J)) S:'$G(SCR(J)) SCR(J)=""
 . Q:'I  I SCR("Start")="" S SCR("Start")=DATE("Start")_U_$$FMTE^XLFDT(DATE("Start")),SCR("End")=$$FMADD^XLFDT(DATE("End"),-30)+.24_U_$$FMTE^XLFDT($$FMADD^XLFDT(DATE("End"),-30))
 . S ROW=0 D IOXY^XGF(ROW,0),SAY^XGF(ROW,0,"Preparing a task to "_$S(EXE(X)'["BOTH":$P(EXE(X),U),1:$TR($P($P(EXE(X),U),"[",2),"]",""))_":","U1")
 . S ROW=ROW+1 D SAY^XGF(ROW,2,"Documents from "_$P(SCR("Start"),U,2)_" to "_$P(SCR("End"),U,2)_".")
 . I SCR(8925.6) S ROW=ROW+1 D SAY^XGF(ROW,2,"Document STATUS must be "_$P(SCR(8925.6),U,2)_".")
 . I SCR(200) S ROW=ROW+1 D SAY^XGF(ROW,2,$P(SCR(200),U,2)_" must be the additional signer.")
 . I SCR("Terminated") S ROW=ROW+1 D SAY^XGF(ROW,2,"Additional Signers must be terminated as of "_$$FMTE^XLFDT(DT)_".")
 . I SCR("DISUSER'd") S ROW=ROW+1 D SAY^XGF(ROW,2,"Additional Signers must be DISUSER'd.")
 . N ERR,MSG,TIUFT F X=49,4 D
 . . S MSG="" S:SCR(X) MSG="Additional Signers must be assigned to the "_$P(SCR(X),U,2)_" ["_$S(X=4:"DIVISION",X=49:"SERVICE/SECTION")_"]."
 . . K TIUFT D:MSG'="" WRAP^TIUFLD(MSG,IOM-2) S TIUFT=0 F  S TIUFT=$O(TIUFT(TIUFT)) Q:'TIUFT  S ROW=ROW+1 D SAY^XGF(ROW,$S(TIUFT>1:4,1:2),TIUFT(TIUFT))
 . I +SCR(200) D  Q:$D(ERR)  ; verify search criteria for the additional signer
 . . N DIV,NODE,SRV S DIV=$$DIV4^XUSER(.DIV,+SCR(200)),SRV=$P($G(^VA(200,+SCR(200),5)),U) S:SRV $P(SRV,U,2)=$P($G(^DIC(49,SRV,0)),U)
 . . S NODE=$G(^VA(200,+SCR(200),0))
 . . I +SCR(4),'$D(DIV(+SCR(4))) S ERR(4)="Divison(s):"
 . . I +SCR(49),+SCR(49)'=+SRV S ERR(49)="Service/Section:   "_$P(SRV,U,2)
 . . I +SCR("DISUSER'd"),'$P(NODE,U,7) S ERR("D")="Status:            ACTIVE"
 . . I +SCR("Terminated"),'+$P(NODE,U,11) S ERR("T")="Termination Date:  <none>"
 . . I +SCR("Terminated"),+$P(NODE,U,11)>0,$P(NODE,U,11)>DT S ERR("T")="Termination Date:  "_$$FMTE^XLFDT($P(NODE,U,11),"5Z")
 . . I $D(ERR) D
 . . . N EC,XGRT S EC=3 S ERR="" F  S ERR=$O(ERR(ERR)) Q:ERR=""  S EC=EC+1 I ERR=4 N X S X=0 F  S X=$O(DIV(X)) Q:'X  S:X'=$O(DIV(0)) EC=EC+1
 . . . N DISP D WIN^XGF(ROW+1,10,ROW+EC+4,74,"DISP")
 . . . D SAY^XGF(ROW+2,25,"*** Conflicting SEARCH CRITERIA ***")
 . . . D SAY^XGF(ROW+4,11,"Additional Signer:"),SAY^XGF(ROW+4,30,$E($P(SCR(200),U,2),1,43))
 . . . S ERR="" N TROW S TROW=ROW+4 F  S ERR=$O(ERR(ERR),-1) Q:ERR=""  D
 . . . . S TROW=TROW+1 D SAY^XGF(TROW,11,ERR(ERR))
 . . . . I ERR=4 N X S X=0 F  S X=$O(DIV(X)) Q:'X  D SAY^XGF(TROW,30,$$GET1^DIQ(4,X,.01)) S:$O(DIV(X)) TROW=TROW+1
 . . . S TROW=TROW+2 D SAY^XGF(TROW,11,"No results possible.   "),ENTER,RESTORE^XGF("DISP")
 . I $P(SCR("Action")," ")'="GENERATE" D  Q:X'>0
 . . N DISP,X1 D WIN^XGF(ROW+1,10,ROW+13,70,"DISP")
 . . D SAY^XGF(ROW+2,32," *** WARNING *** ","B1R1")
 . . D SAY^XGF(ROW+4,11,"This action will PERMANENTLY REMOVE all pending additional")
 . . D SAY^XGF(ROW+5,11,"signatures that match the criteria above.")
 . . D SAY^XGF(ROW+7,11,"You must type YES to continue or ^ to Quit:  ")
 . . N NOW,XGRT S NOW=$H F  S X=$$READ^XGF(4) Q:X="YES"!(X="^")!($$HDIFF^XLFDT($H,NOW,2)>$G(DTIME,60))  D SAY^XGF(,56,"    "),IOXY^XGF(,56)
 . . S X=$S(X="YES":1,1:0) D:'X RESTORE^XGF("DISP") Q:'X  D IOXY^XGF(ROW+9,0) S X=$$SIG^TIUASCU1(ROW+9,11)
 . . D IOXY^XGF(ROW+11,11),ENTER,RESTORE^XGF("DISP")
 . D IOXY^XGF(ROW+1,0)
 . S X=$$DIR^TIUASCU1("YA","Start the task now? ","NO") Q:'X
 . N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK S ZTDESC="Additional Signer Cleanup [TIU]",ZTDTH=+$H_","_($P($H,",",2)+3),ZTIO=""
 . S X="" F  S X=$O(SCR(X)) Q:X=""  S ZTSAVE($NA(SCR(X)))=""
 . S ZTRTN="TASK^TIUASCU(.SCR)" D ^%ZTLOAD W:+$G(ZTSK) !!,"Task #",$G(ZTSK) ; load/start the task
 . ; D TASK(.SCR) ; for live testing
 . D IOXY^XGF(IOSL-1,0),ENTER
EXIT D CLEAN^XGF
 Q
CHK(DATE) ; check environment for outstanding signatures or reports to view, remove if needed
 N EXIT,NODE S EXIT=0,NODE=$G(^XTMP("TIUASCU",0)) I +NODE,NODE'["v2" D  Q:'EXIT 1
 . D CLS,WARN S EXIT=$$DIR^TIUASCU1("YA","Remove the old reports now? ","NO") Q:'EXIT  D CLEAN F  Q:$Y+4>IOSL  W !
 . D DIR^TIUASCU1("EA","Press <Enter> to continue. "),CLS
 S DATE("Start")=$P($O(^TIU(8925.7,"AC",0)),"."),DATE("End")=DT,EXIT=0
 I '+DATE("Start"),'+$O(^XTMP("TIUASCU",0)) D
 . S EXIT=1 W !,IOCUON,"No outstanding signatures or reports to view."
 . D IOXY^XGF(IOSL-1,0),ENTER
 Q EXIT
CLEAN ; remove reports generated with previous utility in ^XTMP("TIUASCU")
 W !!,"Removing entries in ^XTMP..." K ^XTMP("TIUASCU") W "done.",!
 Q
CUDON X ^%ZOSF("EON") Q  ; keyboard output on
CUDOFF X ^%ZOSF("EOFF") Q  ; keyboard output off
CUON W IOCUON Q  ; cursor on
CUOFF W IOCUOFF Q  ; cursor off
ENTER D CUDOFF,CUOFF,SAY^XGF(,,"<Press any key to continue.>") N NOW,X,XGRT S NOW=$H F  S X=$$READ^XGF(1) D CUDON,CUON Q:$D(XGRT)!($$HDIFF^XLFDT($H,NOW,2)>$G(DTIME,60))
 Q
TASK(SCR) ; create [remove] the report of outstanding additional signatures
 N CNT,DATA,DATE,DE,DELIM,LOC,REM,QFLDS,X,Y S DATA="",DELIM=U,LOC=$S(SCR("Action")["REMOVE":"REM",1:$NA(^XTMP("TIUASCU")))
 S @LOC@(0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"Additional Signer Report v2"
 S LOC=$NA(@LOC@(($O(@LOC@(""),-1)+1))) K @LOC ; increment location & prep location
 S @LOC@("Start Time")=$H,X=0 F  S X=$O(SCR(X)) Q:X=""  S @LOC@(X)=SCR(X)
 F X=1:1 S Y=$P($T(DE+X),";;",2) Q:Y=""  S $P(DATA,DELIM,X)=$$QM($P(Y,";"),1) D:$P(Y,";",3)
 . S:+$G(QFLDS($P(Y,";",3))) QFLDS($P(Y,";",3))=QFLDS($P(Y,";",3))_U S $P(QFLDS($P(Y,";",3)),U,$L($G(QFLDS($P(Y,";",3))),U))=X ; set quoted field info
 S CNT=0,@LOC@("zData",CNT)=$TR(DATA,U,","),$P(SCR("End"),U)=+SCR("End")_".9999"
 S @LOC@("User")=$P(SCR("User"),U,2)_U_$P($$FMTE^XLFDT($$NOW^XLFDT,"2Z"),":",1,2)
 S @LOC@("Action")=SCR("Action"),@LOC@("Start Date")=$P(SCR("Start"),U,2),@LOC@("Stop Date")=$P(SCR("End"),U,2)
 S DATE("Entry DT")=+SCR("Start") F  S DATE("Entry DT")=$O(^TIU(8925.7,"AC",DATE("Entry DT"))) Q:'DATE("Entry DT")!(DATE("Entry DT")>SCR("End"))  D
 . N TIUDA S TIUDA=0 F  S TIUDA=$O(^TIU(8925.7,"AC",DATE("Entry DT"),TIUDA)) Q:'+TIUDA  D
 . . N IEN S IEN=0 F  S IEN=$O(^TIU(8925.7,"AC",DATE("Entry DT"),TIUDA,IEN)) Q:'IEN  D
 . . . I '$D(^TIU(8925.7,IEN)) K ^TIU(8925.7,"AC",DATE("Entry DT"),TIUDA,IEN) Q
 . . . N DATA,DIV,NODE,PT S DATA="",NODE(8925,0)=$G(^TIU(8925,TIUDA,0))
 . . . S NODE(8925.7,0)=$G(^TIU(8925.7,IEN,0)) I '+$P(NODE(8925.7,0),U,3)!('$P(NODE(8925,0),U,2)) D  Q  ; if document deleted or missing expected signer, delete entry
 . . . . N DA,DIK S DA=IEN,DIK="^TIU(8925.7," D ^DIK K ^TIU(8925.7,"AC",DATE("Entry DT"),TIUDA,IEN) D SEND^TIUALRT(TIUDA)
 . . . Q:'NODE(8925.7,0)!(TIUDA'=+NODE(8925.7,0))
 . . . S NODE(8925,12)=$G(^TIU(8925,TIUDA,12)),NODE(8925,13)=$G(^TIU(8925,TIUDA,13))
 . . . S NODE(200,0)=$G(^VA(200,$P(NODE(8925.7,0),U,3),0)),NODE(200,5)=$G(^VA(200,$P(NODE(8925.7,0),U,3),5))
 . . . S DIV=$$DIV4^XUSER(.DIV,$P(NODE(8925.7,0),U,3)) S DIV=$S(+DIV:$$GET1^DIQ(4,$O(DIV(0)),.01),1:"")
 . . . Q:SCR("Terminated")&'($P(NODE(200,0),U,11)>0&($P(NODE(200,0),U,11)'>DT))  Q:SCR("DISUSER'd")&'($P(NODE(200,0),U,7))
 . . . Q:+SCR(8925.6)&(+SCR(8925.6)'=$P(NODE(8925,0),U,5))  Q:+SCR(200)&(+SCR(200)'=$P(NODE(8925.7,0),U,3))  Q:+SCR(4)&('$D(DIV(+SCR(4))))  Q:+SCR(49)&(+SCR(49)'=$P(NODE(200,5),U))
 . . . S CNT=CNT+1
 . . . I SCR("Action")'["GENERATE" D  I SCR("Action")["REMOVE" Q
 . . . . N DA,DIK S DA=IEN,DIK="^TIU(8925.7," D ^DIK K ^TIU(8925.7,"AC",DATE("Entry DT"),TIUDA,IEN) D SEND^TIUALRT(TIUDA)
 . . . N TIUDIV1 D PATVADPT^TIULV(.PT,$P(NODE(8925,0),U,2))
 . . . F DE=1:1 S Y=$P($P($T(DE+DE),";;",2),";",2) Q:Y=""  X Y
 . . . S @LOC@("zData",CNT)=$TR($$CHKLEN(DATA),U,",")
 S @LOC@("Total")=CNT,@LOC@("Stop Time")=$H,@LOC@("Elapsed")=$$CONVERT($$HDIFF^XLFDT(@LOC@("Stop Time"),@LOC@("Start Time"),2))
 S @LOC@("Start Time")=$$HTE^XLFDT(@LOC@("Start Time")),@LOC@("Stop Time")=$$HTE^XLFDT(@LOC@("Stop Time"))
 D MAIL^TIUASCU1(.LOC) ; mail the completion message
 K SCR S ZTREQ="@"
 Q
CHKLEN(DATA) ; check length of data and truncate fields as needed
 N I,J,LEN,MAX S LEN=$L(DATA),MAX=255
 N FN S FN="" F  S FN=$O(QFLDS(FN),-1) Q:'FN  F I=$L(QFLDS(FN),U):-1:1 I $P(DATA,U,$P(QFLDS(FN),U,I))'="" S MAX=MAX-2
 S FN="" F  S FN=$O(QFLDS(FN),-1) Q:'FN!(LEN'>MAX)  F I=$L(QFLDS(FN),U):-1:1 I $P(DATA,U,$P(QFLDS(FN),U,I))'="" D  Q:LEN'>MAX
 . N TLEN S TLEN=$P($T(@("F"_FN)),";",2) ; truncated field length (after F### tag)
 . I $L($P(DATA,U,$P(QFLDS(FN),U,I)))'<TLEN D
 . . S LEN=$L(DATA),$P(DATA,U,$P(QFLDS(FN),U,I))=$E($P(DATA,U,$P(QFLDS(FN),U,I)),1,TLEN)
 ; add quotes to specific fields, annotated
 S FN="" F  S FN=$O(QFLDS(FN),-1) Q:'FN  F I=$L(QFLDS(FN),U):-1:1 I $P(DATA,U,$P(QFLDS(FN),U,I))'="" S $P(DATA,U,$P(QFLDS(FN),U,I))=$$QM($P(DATA,U,$P(QFLDS(FN),U,I)),1)
 Q DATA
DATE(DATA) ; convert to external format MM/DD/YYYY, length 10
 Q $$FMTE^XLFDT($P(DATA,"."),"5Z")
F2(PT) ;30;<--truncated length if needed
 Q $E(PT("PNM"),1,22)_" ("_$E(PT("PNM"),1)_$P(PT("SSN"),"-",3)_")"
F200(DATA) ;20;<--truncated length if needed
 Q $S(+DATA:$P($G(^VA(200,DATA,0)),U),1:$E(DATA,1,35))
F49(DATA) ;15;<--truncated length if needed
 Q $S(+DATA:$P($G(^DIC(49,DATA,0)),U),1:"")
F4(DATA) ;15;<--truncated length if needed
 I +SCR(4) N X S X=0 F  S X=$O(DATA(X)) Q:'X  S:+SCR(4)=X DATA=$$GET1^DIQ(4,X,.01)
 Q DATA
F8925(DATA) ;30;<--truncated length if needed
 Q $P($G(^TIU(8925.1,+DATA,0)),U)
VIEW ;
 D CLS I '+$O(^XTMP("TIUASCU",0)) W !!,"There are no reports to view.",! D DIR^TIUASCU1("EA","Press <Enter> to continue.") Q
 N DIR,LOC,X,Y F X=1:1 S Y=$P($T(RPT+X),";;",2) Q:Y=""  W $S(X=2:IOUON,1:""),!,Y,$S(X=2:IOUOFF,1:"")
 S LOC=$NA(^XTMP("TIUASCU")),(X,Y)=0 F  S X=$O(@LOC@(X)) Q:'X  D
 . Q:'$D(@LOC@(X,"Stop Time"))  ; in progress, don't display until complete
 . S Y=Y+1,$P(DIR,";",Y)=Y_":Report #"_X,Y=$$SETSTR^TIUASCU1($E($P(@LOC@(X,"User"),U),1,15),Y,4,18)
 . S Y=$$SETSTR^TIUASCU1($P($P(@LOC@(X,"User"),U,2),":",1,2),Y,20,15)
 . S Y=$$SETSTR^TIUASCU1(@LOC@(X,"Total"),Y,(51-$L(@LOC@(X,"Total"))),$L(@LOC@(X,"Total")))
 . S Y=$$SETSTR^TIUASCU1(@LOC@(X,"Start Date")_"-"_@LOC@(X,"Stop Date"),Y,56,25)
 . W !,Y D
 . . N Y F Y="DISUSER'd","Terminated",200,49,4,8925.6 D:+@LOC@(X,Y)
 . . . N DATA S DATA=$P(@LOC@(X,Y),U,2)_$S(Y=200:" [Additional Signer]",Y=49:" [Service/Section]",Y=4:" [Division]",Y=8925.6:" [Status]",1:" ["_Y_"]") ;"Additional Signers must be ["_Y_"]")
 . . . W !,$$SETSTR^TIUASCU1(DATA,"",(IOM-($L(DATA)-1)),$L(DATA))
 . W:$O(@LOC@(X)) !
 I '$G(DIR) D  Q
 . W !!,$$CJ^XLFSTR("No completed report to view.",IOM),!!,$$CJ^XLFSTR("[Report(s) currently in progress.]",IOM),!
 . F  Q:$Y+4>IOSL  W !
 . D DIR^TIUASCU1("EA","Press <Enter> to continue.")
 W ! S X=$$DIR^TIUASCU1("SAO^"_DIR,"Which report would you like to display? ") Q:'X
 S LOC=$NA(^XTMP("TIUASCU",$P($P(DIR,";",X),"#",2))) I @LOC@("Total")=0 D  G VIEW:+$O(^XTMP("TIUASCU",0)) Q
 . W ! K:$$DIR^TIUASCU1("YA","No results in this report.  OK to delete? ","YES") @LOC
 D CLS W "This output is designed for 255 characters per row.",!
 W !,"Example DEVICE setting:  ;255",!
 N ZTSAVE S ZTSAVE("LOC")="" D EN^XUTMDEVQ("DISPLAY^TIUASCU(LOC)","Additional Signer Report",.ZTSAVE) Q:POP
 D DIR^TIUASCU1("EA","[stop logging before you...] Press <Enter> to continue.")
 Q
DISPLAY(LOC) ;
 I IOST["C-VT" D DIR^TIUASCU1("EA","To capture the report output, start logging now and press <Enter> to begin.") W @IOF
 N X S X="" F  S X=$O(@LOC@("zData",X)) Q:X=""  W @LOC@("zData",X) W:$O(@LOC@("zData",X)) !
 Q
CLS N X F X=1:1:(IOSL+1) W ! I X=(IOSL+1) D IOXY^XGF(0,0) ; clear screen
 Q
CONVERT(SEC) ; convert seconds to hours/minutes/seconds
 Q:SEC'>60 $FN(SEC,"",2)_" sec"
 Q:SEC'>3600 (SEC\60)_" min "_$S($L($FN((SEC#60),"",0))'>1:"0"_$FN((SEC#60),"",0),1:$FN((SEC#60),"",0))_" sec"
 Q (SEC\3600)_" hr "_((SEC#3600)\60)_" min "_$S($L($FN(((SEC#3600)#60),"",0))'>1:"0"_$FN(((SEC#3600)#60),"",0),1:$FN(((SEC#3600)#60),"",0))_" sec"
QM(DATA,QM) ; quote me
 I DATA[$C(34) N X S X("""")="""""" S DATA=$$REPLACE^XLFSTR(DATA,.X)
 Q $S(+$G(QM):$C(34)_DATA_$C(34),1:DATA)
 ; data elements by field; m code; file # (optional, indicates field data must be quoted and may be truncated as needed)
DE ; field;data;
 ;;IEN;S $P(DATA,DELIM,DE)=TIUDA
 ;;ADDITIONAL SIGNER;S $P(DATA,DELIM,DE)=$$F200($P(NODE(200,0),U));200
 ;;SERVICE/SECTION;S $P(DATA,DELIM,DE)=$$F49($P(NODE(200,5),U));49
 ;;DIVISION;S $P(DATA,DELIM,DE)=$$F4(.DIV);4
 ;;DISUSER;S $P(DATA,DELIM,DE)=$S($P(NODE(200,0),U,7):"YES",1:"")
 ;;TERMINATED;S $P(DATA,DELIM,DE)="" I $P(NODE(200,0),U,11)>0 S:$P(NODE(200,0),U,11)'>DT $P(DATA,DELIM,DE)=$$DATE($P(NODE(200,0),U,11))
 ;;PATIENT;S $P(DATA,DELIM,DE)=$$F2(.PT);2
 ;;LOCAL TITLE;S $P(DATA,DELIM,DE)=$$F8925(NODE(8925,0));8925
 ;;PARENT TITLE;S:$P(NODE(8925,0),U,6) $P(DATA,DELIM,DE)=$$F8925($P($G(^TIU(8925,$P(NODE(8925,0),U,6),0)),U));8925
 ;;PARENT DATE;S:$P(NODE(8925,0),U,6) $P(DATA,DELIM,DE)=$$DATE($P($G(^TIU(8925,$P(NODE(8925,0),U,6),13)),U))
 ;;STATUS;S $P(DATA,DELIM,DE)=$$GET1^DIQ(8925.6,$P(NODE(8925,0),U,5)_",",.01)
 ;;ENTRY DATE;S $P(DATA,DELIM,DE)=$$DATE($P(NODE(8925,12),U))
 ;;REFERENCE DATE;S $P(DATA,DELIM,DE)=$$DATE($P(NODE(8925,13),U))
 ;;EXPECTED SIGNER;S $P(DATA,DELIM,DE)=$$F200($P(NODE(8925,12),U,4));200
 ;;EXPECTED COSIGNER;S $P(DATA,DELIM,DE)=$$F200($P(NODE(8925,12),U,8));200
 ;;REMOVED;S $P(DATA,DELIM,DE)="" S:SCR("Action")'["GENERATE" $P(DATA,DELIM,DE)=$$FMTE^XLFDT($$DT^XLFDT,"5Z")
 ;;REMOVED BY;S $P(DATA,DELIM,DE)="" S:SCR("Action")'["GENERATE" $P(DATA,DELIM,DE)=$$F200($G(DUZ));200
 ;;
MENU ;;Additional Signer Utility
 ;;GENERATE a Report^S Y=$$SETUP:TIUASCU1(.SCR,.DATE)
 ;;REMOVE Additional Signer(s)^S Y=$$SETUP:TIUASCU1(.SCR,.DATE)
 ;;BOTH [Generate a Report & Remove Additional Signer(s)]^S Y=$$SETUP:TIUASCU1(.SCR,.DATE)
 ;;VIEW Generated Report(s)^D VIEW
 ;;
RPT ;
 ;;   Report          Generated          # Additional                    Date Range
 ;;#  Generated By    Date@Time            Signatures         [Additional Criteria]
 ;;
 ;; 01234567890123456789012345678901234567890123456789012345678901234567890123456789
WARN F X=1:1 S Y=$P($T(WARN+X),";;",2) Q:Y="EOM"  W @Y,!,IOCUON
 ;;$$CJ^XLFSTR("** WARNING **",IOM)
 ;;""
 ;;"Reports generated with v1 are NOT compatible and must be removed before use."
 ;;""
 ;;"Additional Signer data in TIU MULTIPLE SIGNATURE [File #8925.7] will not be"
 ;;"altered."
 ;;""
 ;;"This process may take a few minutes and only needs to be completed once."
 ;;EOM
