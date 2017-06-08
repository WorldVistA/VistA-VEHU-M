LA57 ;DALOI/JMC - LA*5.2*57 PATCH ENVIRONMENT CHECK ROUTINE ;5/5/2000
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**57**;Sep 27, 1994
EN ; Does not prevent loading of the transport global.
 ; Environment check is done only during the install.
 ;
 N XQA,XQAMSG
 ;
 I '$G(XPDENV) D  Q
 . S XQAMSG="Transport global for patch "_$G(XPDNM,"Unknown patch")_" loaded on "_$$HTE^XLFDT($H)
 . S XQA("G.LMI")=""
 . D SETUP^XQALERT
 . S XQAMSG="Lab LIM - Review patch LA*5.2*57 post-installation instructions"
 . S XQA("G.LMI")=""
 . D SETUP^XQALERT
 . D BMES^XPDUTL($$CJ^XLFSTR("Sending transport global loaded alert to mail group G.LMI",80))
 ;
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" started on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 D CHECK
 D EXIT
 Q
 ;
CHECK ; Perform environment check
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device is not defined",80))
 . S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Please log in to set local DUZ... variables",80))
 . S XPDQUIT=2
 I $P($$ACTIVE^XUSER(DUZ),"^")'=1 D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("You are not a valid user on this system",80))
 . S XPDQUIT=2
 S XPDIQ("XPZ1","B")="NO"
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Install Environment Check FAILED ---",80))
 I '$G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",80))
 Q
 ;
 ;
PRE ; KIDS Pre install for LA*5.2*57
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("Sending install started alert to mail group G.LMI",80))
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install started ***",80))
 ;
 ; Check and save auto download process status
 S LA7ADLST=$G(^LA("ADL","STOP"))
 I $P(LA7ADLST,"^")=0 D
 . D SETSTOP^LA7ADL1(2,DUZ)
 . D BMES^XPDUTL($$CJ^XLFSTR("Shutting down Lab Universal Interface Auto Download Job",80))
 ;
 I $P(LA7ADLST,"^")'=0 D BMES^XPDUTL($$CJ^XLFSTR("--- No action required ---",80))
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install completed ***",80))
 ;
 Q
 ;
 ;
POST ; KIDS Post install for LA*5.2*57
 N XQA,XQAMSG
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install started ***",80))
 ;
 I $P(LA7ADLST,"^")=0 D
 . D ZTSK^LA7ADL
 . D SETSTOP^LA7ADL1(1,DUZ)
 . D BMES^XPDUTL($$CJ^XLFSTR("Restarting Lab Universal Interface Auto Download Job",80))
 ;
 I $L($G(XPDNM)) D
 . D PRD^DILFD(62.4,XPDNM)
 . D BMES^XPDUTL($$CJ^XLFSTR("Updating package revision data for file #62.4",80))
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install completed ***",80))
 D BMES^XPDUTL($$CJ^XLFSTR("Sending install completion alert to mail group G.LMI",80))
 ;
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 S XQAMSG="Lab LIM - perform patch LA*5.2*57 post-installation instructions"
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
CLEANUP ;
 K LA7ADLST
 ;
 Q
