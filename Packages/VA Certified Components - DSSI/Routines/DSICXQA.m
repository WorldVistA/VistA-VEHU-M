DSICXQA ;DSS/SGM - DSS KERNEL ALERT RPCS ;01/26/2004 16:40
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;  this routine contains RPCs for DSS packages to do Alert processing
 ;
 ; DBIA#   SUPPORTED
 ; -----   ---------------------------------------------
 ; 10035   Direct global read of ^DPT(DFN,0)
 ; 10060   Fileman read of all fields in NEW PERSON file
 ; 10081   SETUP^XQALERT
 ;
SEND(DSIC,DATA,FUN) ;  RPC: DSIC XQA SEND ALERT
 ;  DSIC - return 1 if alert successfully sent, else return -1^msg
 ;   FUN - optional - IF $G(FUN) then extrinsic function, else RPC
 ;
 ; As of 8/20/2003, all calls should set up the DATA() in the new
 ; format of DATA(string)=data versus DATA(number)=data
 ;
 ;  DATA is a list which is expecting data in the following format:
 ;    DATA(0) = XQAMSG - message to be displayed to user
 ;        (1) = XQAROU - tag^routine or <null>
 ;        (2) = XQADATA - data to pass to XQAROU - optional
 ;        (3) = XQAKILL - optional - default is 1
 ;                1: delete alert for current user
 ;                0: delete alert for all recipients
 ;                routine in XQAROU can KILL XQAKILL to indicate that
 ;                  alert should not be deleted for user
 ;        (4) = XQA(recipient)="" - at least one recipient required
 ;        (5) = XQA(recipient)="" - optional - additional recipient
 ;        (6,...) = XQA(additional recipients)
 ;
 ;  NEWDATA(sub) = value
 ;    subscript  required  value
 ;    ---------  --------  ---------------------------------------
 ;    XQAMSG        Y      message displayed to the user (80 char)
 ;
 ;    XQAROU        N      tag^routine to be invoked
 ;                           if from RPC this must be silent
 ;
 ;    XQAID         N      package identifier for alert
 ;
 ;    XQADATA       N      an application specific data string
 ;      [the alert processor will set XQADATA equal to this and will
 ;       be available to M routine specified in XQAROU]
 ;
 ;    XQAARCH       N      # days to keep in alert tracking file
 ;
 ;    XQASURO       N      # days to wait before forwarding alert
 ;      [forwarded to recipient's Mailman's surrogates if unprocessed
 ;       by recipient]
 ;
 ;    XQASUPV       N      supervisor forwarding
 ;      [# days to wait before forwarding to recipient's supervisor if
 ;       unprocessed by recipient.  SUPERVIOR = CHIEF field from file
 ;       49 corresponding to recipient's SERVICE/SECTION]
 ;
 ;    DFN           N      pointer to PATIENT file
 ;      [used to construct XQAID so that it works properly in CPRS]
 ;
 ;    PKG           N      namespace of calling app - default=VEJD
 ;
 ;    Rn            Y      at least one must be defined - recipients of
 ;     R1,R2,R3,...          alert - can be pointer to NEW PERSON file
 ;                           or G.<name of mail group>
 ;
 ;  Example of setup in the GUI:
 ;    Param.List['"XQAMSG"'] := text
 ;    Param.list['"R1"']     := duz of recipient
 ;    Param.List['"DFN"']    := pointer to PATIENT file
 ;
 N X,Y,Z,XQA,XQAARCH,XQADATA,XQAID,XQAKILL,XQAMSG,XQAROU,XQASURO,XQASUPV
 D PARSE I '$D(XQAMSG)!'$D(XQA) D
 .S DSIC="-1^" S:'$D(XQAMSG) DSIC=DSIC_"No display message received; "
 .S:'$D(XQA) DSIC=DSIC_"No recipients received"
 .Q
 E  D SETUP^XQALERT S DSIC=1
 Q:'$G(FUN)  Q DSIC
 ;
PARSE ;  parse input array
 ;  ignore DATA(3) - it should never been allowed
 N I,J,X,Y,Z,CNT,DFN,PKG,VAR
 S VAR="",CNT=-1 F  S VAR=$O(DATA(VAR)) Q:VAR=""  D
 .S CNT=CNT+1,X=DATA(VAR) Q:X=""
 .I VAR=+VAR D
 ..I CNT=0 S XQAMSG=X
 ..I CNT=1 S XQAROU=X
 ..I CNT=2 S XQADATA=X
 ..I CNT>3 S XQA(X)=""
 .E  D
 ..I "^XQAMSG^XQAROU^XQADATA^PKG^DFN^"[(U_VAR_U) S @VAR=X Q
 ..I VAR="XQAID",X'[";"&(X'[U) S XQAID=X Q
 ..I X>0,"^XQAARCH^XQASURO^XQASUPV^"[(U_VAR_U) S @VAR=X Q
 ..S XQA(X)=""
 ..Q
 .Q
 ;  validate recipients
 S X="" F  S X=$O(XQA(X)) Q:X=""  D
 .I X=+X,'$D(^VA(200,X,0)) K XQA(X)
 .I X'=+X,X'?1"G.".E K XQA(X)
 .Q
 ;  build XQAID
 Q:$D(XQAID)
 S XQAID=$S($G(PKG)'="":PKG,1:"VEJD")
 I $D(DFN),$D(^DPT(DFN,0)) S $P(XQAID,",",2)=DFN
 Q
