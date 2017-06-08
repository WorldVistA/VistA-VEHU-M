LRP72ENV ;DALISC/CYM - CHECK FOR LR*5.2*72-- ENVIRONMENT CHECK ROUTINE ;9/20/96
 ;;5.2;LAB SERVICE;**173**;Sep 27, 1994
EN ; Does not prevent loading of the transport global.
 ;Environment check is done only during the install.
 ;
 Q:'$G(XPDENV)
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) W !,$$CJ^XLFSTR("Terminal Device in not defined",80),!!
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) W !!,$$CJ^XLFSTR("Please Log in to set local DUZ... variables",80),! S XPDQUIT=2
 I '$D(^VA(200,$G(DUZ),0))#2 W !,$$CJ^XLFSTR("You are not a valid user on this system",80),! S XPDQUIT=2
 I '$D(^LRO(68,"VR")) D BMES^XPDUTL("You need to install patch LR*5.2*72 BEFORE you can install this patch") S XPDQUIT=2
 I $G(XPDQUIT) W !!,$$CJ^XLFSTR("Install environment check FAILED",80)
 I '$G(XPDQUIT) W !!,$$CJ^XLFSTR("Environment Check is Ok ---",80)
 K DIC Q
