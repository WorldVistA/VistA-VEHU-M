AXAPCH ;WPB/JLTP ; PATCHMAN LIST MANAGER USER INTERFACE ; 10-SEP-1998
 ;;2.0;WPB Patch Tracking;10-SEP-1998;;Build 2
EN ; -- main entry point for AXAPCHL
 D EN^VALM("AXAPCHL")
 Q
 ;
HDR ; -- header code
 N I,S,X,X1
 S VALMHDR(1)="Patch List For "_$P($G(^VA(200,PERSON,0),"ALL PACKAGES"),U)
 S X=""
 F I=1:1:$L(STATUS,",") D
 .S S=$P(STATUS,",",I) Q:'S  S X1=$P($G(^AXA(548260.1,S,0)),U) D
 ..I X1]"" S:X]"" X=X_", " S X=X_X1
 S X="Patches in Status: "_X
 S VALMHDR(2)=X
 Q
 ;
INIT ; -- init variables and list array
 S PERSON=DUZ,STATUS=2,SWITCH=0,ADD=0,CAPACITY=$S($$PROG(PERSON):1,1:3)
 S ACCT=$$ACCT^AXAPCHU,PACKAGE="",ORD=1
 I $$PROG(PERSON) S STATUS=1
 S PREF=$G(^AXA(548270,DUZ,260)) S:$P(PREF,U) STATUS=$P(PREF,U)
 S:$P(PREF,U,2) ORD=$P(PREF,U,2)
 D REFRESH
 Q
 ;
REFRESH ;------ Refresh Selections ------
 N I,LINE,X
 D HDR
 K ^TMP($J,"PCH")
 S PP=$S(SWITCH:PACKAGE,1:PERSON)
 I '$$PCHST^AXAPCHU(PP,STATUS,.LIST,SWITCH,CAPACITY,ADD) D  Q
 .S VALMCNT=0
 D SORT K ^TMP("AXAPCH",$J)
 S LINE=0
 F I=0:0 S I=$O(^TMP($J,"PCH",I)) Q:'I  S LINE=I,X=^(I,0) D
 .S NSP=$P(X,U,2) S:NSP="" NSP=" " S PKG0=+$O(^AXA(548260,"C",NSP,0))
 .S PKG0=$G(^AXA(548260,PKG0,0)),PPROG=$P(PKG0,U,3)
 .I PPROG]"" D
 ..S PPGLR=$P(PPROG,";",2),PPROG=@(U_PPGLR_+PPROG_",0)")
 ..S PPROG=$P(PPROG,U) S:PPGLR["XMB" PPROG="G."_PPROG
 .S PPROG=$$EX($P(PPROG,","),6)
 .S DESIG=$$EX($P(X,U),15)
 .S SV=$S($P(X,U,18):$P(X,U,18),$P(X,U,4):"v"_$P(X,U,4),1:"")
 .S SV=$$EX(SV,3,1)
 .S SUBJ=$$EX($P(X,U,17),16)
 .S MSG=$P(X,U,$S(ACCT="TEST":19,1:20)),MSG=$$EX(MSG,8,1)
 .S STAT=$$EX($P($G(^AXA(548260.1,+$P(X,U,14),0)),U),5)
 .S RCV=$P(X,U,7),DLN=$P(X,U,8),INL=$P(X,U,15)
 .S:DLN="" DLN=$$FMADD^XLFDT(RCV,30) S:INL="" INL=DT
 .S DAG=$$FMDIFF^XLFDT(DLN,RCV),DTI=$$FMDIFF^XLFDT(INL,RCV)
 .S DAYS=DAG_"/"_DTI,DAYS=$$EX(DAYS,7)
 .S ^TMP("AXAPCH",$J,LINE,0)=$$EX(LINE,3)_DESIG_SV_DAYS_SUBJ_PPROG_MSG_STAT
 S VALMCNT=LINE
 Q
EX(X,S,L) ;------ Expand Length ------
 N SPC S $P(SPC," ",S)=" ",L=+$G(L)
 I L S X=$E(X,1,S),X=$E(SPC,$L(X)+1,S)_X_"  "
 E  S X=$E(X,1,S),X=X_$E(SPC,$L(X)+1,S)_"  "
 Q X
SS ;------ Select Status ------
 N DIR,DIRUT,DTOUT,DUOUT,OLD,X,Y
 S OLD=STATUS,STATUS="" D FULL^VALM1 S VALMBCK="R"
 S DIR(0)="PO^548260.1:AEMQ",DIR("A")="Select Status to View"
 F  D ^DIR D  Q:$D(DIRUT)
 .S DIR("A")="Select Another or Return"
 .S:STATUS]"" STATUS=STATUS_"," S:Y>0 STATUS=STATUS_+Y
 I $D(DUOUT)+$D(DTOUT) S STATUS=OLD
 E  D REFRESH
 Q
OP ;------ One Patch ------
 N P
 D FULL^VALM1 S VALMBCK="R"
 Q:'$$DIR^AXAFM("P^548261:AEMQ",.P,"Select Patch")
 S STATUS="ONE^"_+P D REFRESH
 Q
AS ;------ Any Status ------
 N I S STATUS="",I=0
 F  S I=$O(^AXA(548260.1,I)) Q:'I  D
 .S:STATUS]"" STATUS=STATUS_","
 .S STATUS=STATUS_I
 S VALMBCK="R" D REFRESH
 Q
SP ;------ Select Package ------
 N DIR,DIRUT,DTOUT,DUOUT,OLD,X,Y
 S OLD=PACKAGE,PACKAGE="" D FULL^VALM1 S VALMBCK="R"
 S DIR(0)="PO^548260:AEMQ",DIR("A")="Select Package to View"
 F  D ^DIR D  Q:$D(DIRUT)
 .S DIR("A")="Select Another or Return"
 .S:PACKAGE]"" PACKAGE=PACKAGE_"," S:Y>0 PACKAGE=PACKAGE_+Y
 I $D(DUOUT)+$D(DTOUT) S PACKAGE=OLD
 E  S SWITCH=1 D REFRESH
 Q
AL ;------ All Persons/Packages ------
 S SWITCH=0,PERSON=0,VALMBCK="R" D REFRESH
 Q
PR ;------ All Persons/Packages ------
 D DIE^AXAFM(548270,DUZ,"261;262") S VALMBCK="R" D REFRESH
 Q
RV ;------ Reverse Order ------
 S ORD=-ORD,VALMBCK="R" D REFRESH
 Q
PP ;------ Edit Patch Package ------
 I '$$PROG(DUZ) W !,"Sorry, Programmers Only..." Q
 D FULL^VALM1 S VALMBCK="R"
 D PKGEDT^AXAPCHS1
 Q
AP ;------ Another Person ------
 N DIR,DIRUT,DTOUT,DUOUT,OLD,X,Y
 D FULL^VALM1 S VALMBCK="R"
 S DIR(0)="P^200:AEMQ",DIR("A")="Select Programmer or ADPAC"
 D ^DIR Q:$D(DIRUT)
 S SWITCH=0,PERSON=+Y,CAPACITY=$S($$PROG(PERSON):1,1:3)
 D REFRESH
 Q
MN ;------ Make a Note ------
 N DIC,I,ITEMS,LMSG,PATCH,TMSG,X,X1
 D FULL^VALM1 S VALMBCK="R"
 I '$$DIR^AXAFM("L^1:"_VALMCNT_":0",.ITEMS,"Select Item") G MNQ
 K ^TMP("TEXT",$J) S ^TMP("TEXT",$J,0)=0
 S DIC="^TMP(""TEXT"",$J," D EN^DIWE G:'$P($G(^TMP("TEXT",$J,0)),U,3) MNQ
 F I=1:1:$L(ITEMS,",")-1 S PATCH=^TMP("AXAPCHIDX",$J,$P(ITEMS,",",I)) D
 .S X=$G(^AXA(548261,+PATCH,0)),TMSG=$P(X,U,19),LMSG=$P(X,U,20)
 .D MN^AXAPCHS1(TMSG,LMSG)
MNQ Q
DI ;------ Document Installation ------
 N DIC,I,ITEMS,PATCH,X,X1
 D FULL^VALM1 S VALMBCK="R"
 I '$$DIR^AXAFM("L^1:"_VALMCNT_":0",.ITEMS,"Select Item") G DIQ
 F I=1:1:$L(ITEMS,",")-1 S PATCH=^TMP("AXAPCHIDX",$J,$P(ITEMS,",",I)) D
 .W !,$G(^TMP("AXAPCH",$J,+$P(ITEMS,",",+I),0))
 .D DIE^AXAFM(548261,PATCH,"2.01;2.03")
DIQ Q
BD ;------ Browse Patch Description ------
 N I,ITEM,L,MSG,PATCH,TITLE,X
 D FULL^VALM1
 I '$$DIR^AXAFM("N^1:"_VALMCNT_":0",.ITEM,"Select Item") Q
 W !,^TMP("AXAPCH",$J,ITEM,0) S PATCH=^TMP("AXAPCHIDX",$J,ITEM)
 S MSG=19+($$ACCT^AXAPCHU="LIVE"),X=$G(^AXA(548261,PATCH,0))
 S MSG=$P(X,U,MSG),TITLE="Reviewing Patch "_$P(X,U)_" "
 S TITLE=TITLE_$S($P(X,U,18):"SEQ# "_$P(X,U,18),1:"Ver "_$P(X,U,4))
 I MSG D
 .S I=.9,L=0 F  S I=$O(^XMB(3.9,MSG,2,I)) Q:'I  S X=^(I,0) Q:X="$END TXT"  D
 ..S L=L+1,^TMP("BROWSE",$J,L,0)=X
 .S ^TMP("BROWSE",$J,0)=L
 D EN^AXAPCH1
 S VALMBCK="R" K ^TMP("BROWSE",$J)
 Q
BN ;------ Browse Notes ------
 N ITEM,MSG,PATCH,TITLE,X
 D FULL^VALM1 S VALMBCK="R"
 I '$$DIR^AXAFM("N^1:"_VALMCNT_":0",.ITEM,"Select Item") Q
 W !,^TMP("AXAPCH",$J,ITEM,0) S PATCH=^TMP("AXAPCHIDX",$J,ITEM)
 S MSG=19+($$ACCT^AXAPCHU="LIVE"),X=$G(^AXA(548261,PATCH,0))
 S MSG=$P(X,U,MSG),TITLE(1)="Reviewing Patch Notes"
 S TITLE(2)=$P(X,U)_" "_$S($P(X,U,18):"SEQ# "_$P(X,U,18),1:"Ver "_$P(X,U,4))
 D EN^AXAPCH2
 Q
SORT ;------  Sort List -----
 N I,LINE,X,X0,X1,X2,X3
 S I=0 F  S I=$O(^TMP($J,"PCH",I)) Q:'I  S X=^(I,0),X0=^(1),X02=^(2) D
 .S $P(X,U,14)=$P(X02,U,7),$P(X,U,15)=$P(X02,U,3)
 .S X1=$P(X,U,2),X2='$P(X,U,18),X3=$S(X2:$P(X,U,4),1:$P(X,U,18))
 .S ^TMP("AXAPCHSORT",$J,X1,X2,+X3,+X0)=X
 S LINE=0 K ^TMP($J,"PCH"),^TMP("AXAPCHIDX",$J)
 S X1="" F  S X1=$O(^TMP("AXAPCHSORT",$J,X1)) Q:X1=""  D
 .S X2="" F  S X2=$O(^TMP("AXAPCHSORT",$J,X1,X2)) Q:X2=""  D
 ..S X3="" F  S X3=$O(^TMP("AXAPCHSORT",$J,X1,X2,X3),ORD) Q:X3=""  D
 ...S X0=0 F  S X0=$O(^TMP("AXAPCHSORT",$J,X1,X2,X3,X0)) Q:'X0  S X=^(X0) D
 ....S LINE=LINE+1,^TMP($J,"PCH",LINE,0)=X,^TMP("AXAPCHIDX",$J,LINE)=X0
 K ^TMP("AXAPCHSORT",$J)
 Q
OK ;------ OK for Live -------
 N I,ITEM,PATCH,X,X1
 D FULL^VALM1
 I '$$DIR^AXAFM("L^1:"_VALMCNT_":0",.ITEMS,"Select Item") G OKQ
 D SIG^XUSESIG I X1="" W !,"NO ACTION TAKEN!",!! G OKQ
 F I=1:1:$L(ITEMS,",")-1 S PATCH=^TMP("AXAPCHIDX",$J,$P(ITEMS,",",I)) D
 .W !,$G(^TMP("AXAPCH",$J,+$P(ITEMS,",",+I),0))
 .I '$$PRSN^AXAPCHU(PATCH,DUZ,"1,2,3,4") D  Q
 ..W !,"This patch is not yours!",!!
 .I "2 7"'[$P(^AXA(548261,PATCH,0),U,14) D  Q
 ..W !,"Only patches IN TEST or ON HOLD may be OK'd for live..."
 .D DIE^AXAFM(548261,PATCH,"2.05///^S X=""TODAY""") W !,"  -- Approved"
OKQ S X=$$DIR^AXAFM("E",.X) D REFRESH S VALMBCK="R"
 Q
CS ;------ Change Status -------
 N I,ITEMS,NS,PATCH,SCREEN,X D FULL^VALM1
 I '$$PROG(DUZ) D  G CSQ
 .W !,"This option is only for programmers!"
 I '$$DIR^AXAFM("L^1:"_VALMCNT_":0",.ITEMS,"Select Item") G CSQ
 S SCREEN="I +Y>5"
 I '$$DIR^AXAFM("P^548260.1:AEQ",.NS,"Select New Status","",SCREEN) G CSQ
 F I=1:1:$L(ITEMS,",")-1 S PATCH=^TMP("AXAPCHIDX",$J,$P(ITEMS,",",I)) D
 .W !,$G(^TMP("AXAPCH",$J,+$P(ITEMS,",",+I),0))
 .D DIE^AXAFM(548261,PATCH,"2.07///^S X=$P(NS,U,2)") W !,"  -- Changed"
CSQ S X=$$DIR^AXAFM("E",.X) D REFRESH S VALMBCK="R"
 Q
PROG(X) ;------ Is X A Programmer ------
 Q:'$G(X) 0
 Q ''$D(^XUSEC("AXA PATCH",X))
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
