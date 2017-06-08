VEJDTP01 ;TPA/SGM - PATIENT SECURITY CHECK ;10/7/99  14:10
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
DGSEC ;ALB/RMO - MAS Patient Look-up Security Check ;7/24/99  23:37
 ;;;5.3;Registration;**32,46,197,214**;Aug 13, 1993
SEN(RET,DFN) ;  rpc to return string of sensitivity flag
 ;  dfn - required - must be pointer to patient file
 ;  RET = number where
 ;  RET = 0 if not sensitive
 ;  RET = 1 if sensitive & user has DG SENSITIVITY key
 ;  RET = 2 if sensitive & user does not have DG SENSITIVITY key
 ;  RET = 3 if user does not have SSN in file 200
 ;  RET = 4 if user trying to access own record & does not have DG RECORD
 ;          ACCESS key
 ;  RET = -1 ^ error message
 N VEJD,KEY,XX S RET=0,DFN=$G(DFN,0),KEY=$D(^XUSEC("DG SENSITIVITY",DUZ))
 I '$D(^DPT(DFN,0))!'DFN S RET=$$E3 Q
 I $G(DUZ)<1 S RET=$$E1 Q
 I '$D(^VA(200,DUZ,0)) S RET=$$E2 Q
 S RET=$$OWN I RET Q
 I $S('$D(^DGSL(38.1,DFN,0)):1,'$P(^(0),U,2):1,1:0) Q
 S VEJD=$$INP(DFN)>0,RET=$S(VEJD:1,KEY:1,1:2)
 I RET=1 D SECLOG(.XX,DFN,VEJD,0) S RET=1
 Q
OWN() ;  check for access to own medical record
 ;  return 0 if okay, 3 if user has no SSN,
 ;         4 if own record & do not own DG RECORD ACCESS key
 N DIC,DGSEC,SSN,VEJERR S DGSEC=0
 I '+$G(^DG(43,1,"REC")) G OWNOUT ; patch *214 flag not active
 I $D(^XUSEC("DG RECORD ACCESS",DUZ)) G OWNOUT
 S SSN=$$GET1^DIQ(200,DUZ_",",9,"I","","VEJERR")
 ; blj/dss 14/6/2000  The linetag REC in DGSEC doesn't exist.  We'll make a rash
 ;   assumption that we're really trying to call SETLOG^DGSEC. 
 ;I 'SSN S DIC(0)="" D REC^DGSEC S DGSEC=3 G OWNOUT ; send bulletin
 I 'SSN S DIC(0)="" D SETLOG^DGSEC S DGSEC=3 G OWNOUT ; send bulletin
 I SSN=$P(^DPT(DFN,0),U,9) S DGSEC=4
OWNOUT Q DGSEC
 ;
SECLOG(RET,DFN,IPT,BULL) ;  rpc to record sensitive patient access
 ;  DFN - required pointer to patient file
 ;  IPT - optional inpatient flag ('IPT if outpatient, else inpatient)
 ;  BULL - optional - if BULL=0 no bulletin sent, otherwise send
 ;  RET returned, may be -1, 0, 1
 ;  RET=-1 (unsuccessful logging)  RET=0 (logging not required)
 ;  RET=1  (successfully logged)
 N X,Y,DIERR,ERR,VEJD,VIEN,VIENS S IPT=$G(IPT)
 I '$P($G(^DGSL(38.1,+$G(DFN),0)),U,2) S RET=0 Q
 I IPT'?1N!(10'[IPT) S IPT=$$INP(DFN)>0
 L +^DGSL(38.1,DFN) S VIENS="+1,"_DFN_","
 F  S X=9999999.9999-$E($$NOW^XLFDT,1,12) Q:'$D(^DGSL(38.1,DFN,"D",X))
 S VIEN(1)=X,VEJD(38.11,VIENS,.01)=9999999.9999-X
 S VEJD(38.11,VIENS,2)=DUZ,VEJD(38.11,VIENS,3)=$$OPT
 S VEJD(38.11,VIENS,4)=$E("yn",2-IPT)
 D UPDATE^DIE(,"VEJD","VIEN","ERR")
 L -^DGSL(38.1,DFN) S RET=$S('$D(DIERR):1,1:-1) D:$G(BULL)'=0 BULL(DFN)
 Q
TS(TXT,SEN) ;  text of security message - SEN is flag from above SEN module
 ;;                           *** WARNING ***
 ;;                      *** RESTRICTED RECORD ***
 ;;This record is protected by the Privacy Act of 1974. If you elect
 ;;to proceed, you will be required to prove you have a need to know.
 ;;Accessing this patient is tracked, and your station Security Officer
 ;;will contact you for your justification.
 ;;  Do you want to continue processing this patient record?
 ;;
 ;;Your NEW PERSON file record does not have your SSN.  Contact your
 ;;ADP Coordinator.  Access to the PATIENT file is not allowed.
 ;;
 ;;Security regulations prhibit computer access to your own medical record.
 N A,B,I,J,L,X S $P(L,"* ",38)="",SEN=+$G(SEN),(A,J)=0
 I SEN=1 S A=1,B=2
 I SEN=2 S A=1,B=7
 I SEN=3 S A=9,B=10
 I SEN=4 S A=12,B=12
 I A F I=A:1:B S X=$P($T(TS+I),";",3),J=J+1 D
 .I 3456[I S X="* "_X,$E(X,73)="*"
 .S TXT(J)=X I SEN=2,26[I S J=J+1,TXT(J)=L
 .Q
 Q
OPT() N XQOPT D OP^XQCHK Q $P(XQOPT,U,2)
INP(DFN) ;  check for inpatient status
 N DGT,DG1,DGA1,DGXFR0,%,%T,%I,X,Y,Z
 S DGT=$E($$NOW^XLFDT,1,12) D ^DGPMSTAT
 Q +DG1
BULL(DFN) ;  sensitive patient record bulletin
 ;;RESTRICTED PATIENT RECORD ACCESSED
 ;;The following sensitive patient record has been accessed:
 ;;
 ;;  Patient Name: 
 ;;  Soc Sec Num : 
 ;;  Option Used : 
 N VEJD,VEJSUB,VEJXMY,VEJXMZ,I,J,X,Y,Z
 S VEJSUB=$P($T(BULL+1),";",3),X=+$P($G(^DG(43,1,"NOT")),U,10)
 S X=$P($G(^XMB(3.8,X,0)),U) Q:X=""  S VEJXMY("G."_X)=""
 Q:'$D(^DPT(+$G(DFN),0))
 F I=2:1:6 S VEJD(I-1,0)=$P($T(BULL+I),";",3)
 S VEJD(5,0)=VEJD(5,0)_$$OPT
 S VEJD(3,0)=VEJD(3,0)_$P(^DPT(DFN,0),U),VEJD(4,0)=VEJD(4,0)_$P(^(0),U,9)
 I $$PATCH^XPDUTL("XM*7.1*50")
 I  D SENDMSG^XMXAPI(DUZ,VEJSUB,"VEJD",.VEJXMY,,.VEJXMZ) Q
 N XMSUB,XMZ,XMY,XMDUZ,XMTEXT,ZTQUEUED S ZTQUEUED=1
 S XMSUB=VEJSUB,XMDUZ=DUZ,XMTEXT="VEJD(" M XMY=VEJXMY D ^XMD
 Q
E1() Q "-1^Access denied, no user ID received"
E2() Q "-1^Access denied, invalid user ID received"
E3() Q "-1^Invalid patient ID received"
