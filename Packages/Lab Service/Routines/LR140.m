LR140 ;DALISC/MJD - LR*5.2*140 PATCH ENVIRNMENT CHECK ROUTINE
 ;;5.2;LAB SERVICE;**140**;Feb 14, 1996
EN ; Does not prevent loading of the transport global.
 ;Environment check is done only during the install.
 Q:'$G(XPDENV)
 D CHECK
EXIT I $G(XPDQUIT) W !!,$$CJ^XLFSTR("Install Environment Check FAILED",80)
 I '$G(XPDQUIT) W !!,$$CJ^XLFSTR("Environment Check is Ok ---",80)
 K VER,RN,LN2
 Q
CHECK I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) W !,$$CJ^XLFSTR("Terminal Device is not defined",80),!! S XPDQUIT=2 Q
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) W !!,$$CJ^XLFSTR("Please Log in to set local DUZ... variables",80),! S XPDQUIT=2 Q
 I '$D(^VA(200,$G(DUZ),0))#2 W !,$$CJ^XLFSTR("You are not a valid user on this system",80),! S XPDQUIT=2 Q
 S VER=$$VERSION^XPDUTL("LR")
 I VER'>5.1 W !,$$CJ^XLFSTR("You must have LAB V5.2 Installed",80),! S XPDQUIT=2 Q
 S RN="LRVER3"
 X "ZL @RN S LN2=$T(+2)" I LN2'["100" W !,$$CJ^XLFSTR("It appears that Patch 'LR*5.2*100' has not been installed",80),! S XPDQUIT=2 Q
 S RN="LRVER4"
 X "ZL @RN S LN2=$T(+2)" I LN2'["112" W !,$$CJ^XLFSTR("It appears that Patch 'LR*5.2*112' has not been installed",80),! S XPDQUIT=2 Q
 Q
