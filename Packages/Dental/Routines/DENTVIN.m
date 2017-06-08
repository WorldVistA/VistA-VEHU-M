DENTVIN ;DSS/KC - INACTIVATE DENTAL PATIENTS ;03/21/2007 15:37
 ;;1.2;DENTAL;**53,59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ;  2053      x       FILE^DIE
 ; 10103      x       FMADD^XLFDT
 ; 10063      x       ^%ZTLOAD
 ;  3744      x       $$TESTPAT^VADPT 
 ; 
INACT ;Inactivate patients in DRM Plus
 ;default date is T-180
 S NODT=$$FMADD^XLFDT(DT,-365) ;cannot be within 365 days!
 S DIR("A",1)=" Patients not seen in dental within the selected time frame"
 S DIR("A",2)=" (defaulted to 2 years) will be inactivated!"
 S DIR("A")="Select inactivation date"
 S DIR("B")="T-730"
 S DIR(0)="D"
 D ^DIR Q:Y<0!$D(DIRUT)
 S INDT=Y I INDT>NODT W !,"Date cannot be within 365 days!",! G INACT
 D TASK
 Q
TASK ;task off the code to set encounters inactive
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTVIN",ZTDESC="DENTV INACTIVATE PATIENTS option queued"
 S ZTSAVE("INDT")="" D ^%ZTLOAD
 I $G(ZTSK) W !,"Successfully queued, task# "_$G(ZTSK)
 I '$G(ZTSK) W !,"Could not queue the job!"
 Q
 ;
PS ;loop through DENTAL PATIENT (#220), find last encounter in DENTAL HISTORY (#228.1)
 ;if last encounter is 'In Progress' and date is older than select date then inactivate it
 N DFN,LV,IEN,STAT
 I '$G(INDT) S INDT=$$FMADD^XLFDT(DT,-720)
 S DFN=0  F  S DFN=$O(^DENT(220,DFN)) Q:'DFN  D
 .S LV=$O(^DENT(228.1,"AE",DFN,""),-1) Q:'LV  ;no entries
 .I LV>INDT Q  ;has data within time frame
 .S LV="",STAT=0
 .F  S LV=$O(^DENT(228.1,"AE",DFN,LV),-1) Q:'LV!STAT  D
 ..S STAT=0,IEN="" F  S IEN=$O(^DENT(228.1,"AE",DFN,LV,IEN),-1) Q:'IEN!STAT  D
 ...I +$G(^DENT(228.1,IEN,1)) Q  ;deleted
 ...S STAT=$P($G(^DENT(228.1,IEN,0)),U,16) I STAT>1 Q  ;already inactive
 ...S STAT=$S($D(^DENT(228.2,"AP",DFN)):3,1:2) ;terminated if planned care, else completed
 ...K DENT S DENT(228.1,IEN_",",.16)=STAT D FILE^DIE(,"DENT")
 ...I $$TESTPAT^VADPT(DFN) Q  ;test pt, don't resend
 ...D RS(IEN)
 ...Q
 ..Q
 .Q
 Q
RS(IEN) ;resend txns for the inactivated dental hx entry
 N TXN,DENST,DENT0
 S TXN=0 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN  D
 .S DENST="P" ;default status to Pending
 .S DENT0=$G(^DENT(228.2,TXN,0)) I DENT0="" S DENST="" ;no data, don't resend
 .I $P(DENT0,U,9)=23,$P(DENT0,U,22)>1 S DENST="" ;only resend 1st tooth in partial
 .I $P(DENT0,U,9)=66 S DENST="" ;don't resend Observe txns
 .I $P(DENT0,U,4)="" S DENST="" ;no ADA code (placeholder txn) don't resend
 .K DENT S DENT(228.2,TXN_",",1.18)=DENST D FILE^DIE(,"DENT")
 .Q
 Q 
