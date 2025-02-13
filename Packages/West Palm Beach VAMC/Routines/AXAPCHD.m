AXAPCHD ;WPB/GBH - GET PATCHES, BY PROGRAMMER/STATUS/NAMESPACE/VERSION
 ;;2.0;WPB Patch Tracking;10-SEP-1998;;Build 2
MAIN ;
 K ^TMP($J)
 D GETPRG G:$D(DIRUT) EXIT ;.........ask for primary programmer
 D GETSTAT G:$D(DIRUT) EXIT ;........ask for patch status
 D GETPKGS ;.......make array of package namespaces for this programmer
 D GETRECS ;.......find patches matching selections, write to TMP($J)
 D ^AXAPCHE ;........do the print routine that fits these selections
EXIT ;
 K DES,DIRUT,INLIVE,INTEST,MSGLIVE,MSGTEST,NSP,OKFOR,PPROG,PSTAT
 K RECNR,RECORD,SEQ,SPA,SUBJ,VER,X,XPROG,XSPAC,XSTAT,Y,ZZ
 Q
GETPRG ;
 N X,Y,DIR,DIRUT
 S DIR(0)="P^548270:AEMQZ"
 S DIR("B")=$P($G(^VA(200,DUZ,0)),U)
 S DIR("A")="ENTER PROGRAMMER"
 D ^DIR Q:$D(DIRUT)  S XPROG=+Y,PPROG=Y(0,0)
 Q
GETSTAT ;
 N X,Y,DIR,DIRUT
 S DIR(0)="P^548260.1:AEMQZ"
 S DIR("A")="ENTER STATUS"
 S DIR("B")="IN TEST"
 D ^DIR Q:$D(DIRUT)  S XSTAT=+Y,PSTAT=Y(0,0)
 Q
GETPKGS ;
 S RECNR=0
 F  D  Q:+RECNR'>0
 .S RECNR=$O(^AXA(548260,"D",XPROG,RECNR)) Q:+RECNR'>0
 .S RECORD=$G(^AXA(548260,RECNR,0))
 .S NSP=$P($G(RECORD),U,2)
 .S SPA(NSP)=""
 Q
GETRECS ;
 S RECNR=0
 F  D  Q:+RECNR'>0
 .S RECNR=$O(^AXA(548261,"ASTAT",XSTAT,RECNR)) Q:+RECNR'>0
 .S RECORD=$G(^AXA(548261,RECNR,0))
 .S NSP=$P($G(RECORD),U,2)
 .S DES=$P($G(RECORD),U,1)
 .S VER=$P($G(DES),"*",2)
 .S SEQ=$P($G(RECORD),U,18)
 .I SEQ']"" S SEQ="T"_$P($G(RECORD),U,4)
 .S XSPAC=+$P(RECORD,U,14)
 .I $D(SPA(NSP)) D
 ..S (INTEST,OKFOR,INLIVE,MSGTEST,MSGLIVE,SUBJ)=""
 ..S INTEST=$P($G(RECORD),U,8)
 ..S INLIVE=$P($G(RECORD),U,10)
 ..S OKFOR=$P($G(RECORD),U,12)
 ..S SUBJ=$P($G(RECORD),U,17)
 ..S MSGTEST=$P($G(RECORD),U,19)
 ..S MSGLIVE=$P($G(RECORD),U,20)
 ..D WRITEIT
 Q
WRITEIT ;
 S ZZ=SUBJ_U_MSGTEST_U_MSGLIVE_U_INTEST_U_OKFOR_U_INLIVE_U_DES_U_XPROG
 S ^TMP($J,NSP,VER,SEQ)=ZZ
 Q
