LR162 ;DALISC/CKA - LR*5.2*162 PATCH ENVIRONMENT CHECK ROUTINE;9/1/97
 ;;5.2;LAB SERVICE;**162**;Sep 27, 1994
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
 S X="LRARU" X ^%ZOSF("TEST")
 I '$T W !,$$CJ^XLFSTR("It appears that you do not have the routine LRARU which means that Patch 'LR*5.2*59' has not been installed",80),! S XPDQUIT=2 Q
 S RN="LRARU"
 X "ZL @RN S LN2=$T(+2)" D
 . I LN2'["150" W !,$$CJ^XLFSTR("It appears that Patch 'LR*5.2*150' has not been installed",80),! S XPDQUIT=2
 Q
