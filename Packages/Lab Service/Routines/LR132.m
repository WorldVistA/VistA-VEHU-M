LR132 ;DALISC/SED - LR*5.2*132 PATCH ENVIRNMENT CHECK ROUTINE
 ;;5.2;LAB SERVICE;**132**;Oct 20, 1996
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
lab S VER=$$VERSION^XPDUTL("LR")
 I VER'>5.1 W !,$$CJ^XLFSTR("You must have LAB V5.2 Installed",80),! S XPDQUIT=2 Q
hl7 S VER=$$VERSION^XPDUTL("HL")
 I VER'=1.6 W !,$$CJ^XLFSTR("You must have Health Level 7 V1.6 Installed",80),! S XPDQUIT=2 Q
 S RN="XPDIA"
 X "ZL @RN S LN2=$T(+2)" I LN2'[",44" W !,$$CJ^XLFSTR("It appears that Patch 'XU*8*44' has not been installed",80),! S XPDQUIT=2 Q
 Q
