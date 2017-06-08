LR198 ;DAL/HOAK-LR PATCH ENVIRNMENT CHECK ROUTINE ; 01/05/98  09:01
 ;;5.2;LAB SERVICE;**198**;Sep 27, 1994
 ;
INIT ;-->Does not prevent loading of the transport global.
 ;-->Environment check is done only during the install.
 ;
 Q:'$G(XPDENV)
 ;
 D CHECK
EXIT ;
 I $G(XPDQUIT) W !!,$$CJ^XLFSTR("Install Environment Check FAILED",80)
 I '$G(XPDQUIT) W !!,$$CJ^XLFSTR("Environment Check is Ok ---",80)
 K VER,RN,LN2
 Q
CHECK ;
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D TERM QUIT
 ;
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D DUZ QUIT
 ;
 I '$D(^VA(200,$G(DUZ),0))#2 D USER QUIT
 ;
 S VER=$$VERSION^XPDUTL("LR") I VER'>5.1 D VERSION QUIT
 ;
 ;
CHECK1 W !!,"Checking for 121..."
 F RN="LRPHITEM","LRPHITE1" X "ZL @RN S LN2=$T(+2)" I LN2'["121" D
 .  W !,$$CJ^XLFSTR(RN_"--Patch 'LR*5.2*121' has not been installed.",80)
 .  W ! S XPDQUIT=2 Q
 ;
 QUIT
 ;
TERM ;
 W !,$$CJ^XLFSTR("Terminal Device is not defined",80),!!
 D XP
 Q
DUZ ;
 W !!,$$CJ^XLFSTR("Please Log in to set local DUZ... variables",80),!
 D XP
 Q
USER ;
 W !,$$CJ^XLFSTR("You are not a valid user on this system.",80),!
 D XP
 Q
VERSION ;
 W !,$$CJ^XLFSTR("You must have LAB V5.2 Installed",80),!
 D XP
 Q
XP ;
 S XPDQUIT=2
 Q
 ;
 Q
