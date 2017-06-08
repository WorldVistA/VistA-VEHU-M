LR138 ;DALISC/FHS - LR*5.2*138 PATCH ENVIRONMENT CHECK ROUTINE
 ;;5.2;LAB SERVICE;**138**;Sep 27, 1994
EN ; Does not prevent loading if SD*5.3*63 not loaded.
 ;Environment check is done only during the install.
 S X="SCDXUAPI"
 X ^%ZOSF("TEST") I '$T D  Q
 . W !!,$$CJ^XLFSTR("You must FIRST Load the SD*5.3*63 Patch",80),!,$$CJ^XLFSTR(" to be able to create OOS clinic locations",80)
 . W !,$$CJ^XLFSTR("BEFORE YOU CAN INSTALL THIS PATCH",80),!! S XPDQUIT=2 Q
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) W !,$$CJ^XLFSTR("Terminal Device in not defined",80),!!
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) W !!,$$CJ^XLFSTR("Please Log in to set local DUZ... variables",80),! S XPDQUIT=2
 I '$D(^VA(200,$G(DUZ),0))#2 W !,$$CJ^XLFSTR("You are not a valid user on this system",80),! S XPDQUIT=2
 I +$G(^LAM("VR"))'>5.1 W !,$$CJ^XLFSTR("You must have LAB V5.2 or greater Installed",80),! S XPDQUIT=2
 I $O(^LAB(64.81,0)) W !?5," You still have old data in file 64.81 requiring database install. ",$C(7)
 I $G(XPDQUIT) W !!,$$CJ^XLFSTR("Install environment check FAILED",80)
 I '$G(XPDQUIT) W !!,$$CJ^XLFSTR("Envirnoment Check is Ok ---",80)
 Q
