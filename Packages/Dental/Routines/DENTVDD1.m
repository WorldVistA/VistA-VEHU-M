DENTVDD1 ;DSS/SGM - CALLED FROM DD INDEXES ;11/07/2003 09:33
 ;;1.2;DENTAL;**31,38,39,43**;Aug 10, 2001
 ;Copyright 1995-2005, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;the various entry points here are called from data dictionary elements
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  -----------------------------------------------
 ;  3512  Cont Sub   Direct global read of .01 field on file 9000010
 ;  2053      x      FILE^DIE
 ; 10063      x      ^%ZTLOAD
 ;
 ;  ---------------  FILE 228.1  ---------------
S1 ;  set logic on DATE DELETED field 1.01
 ;  record marked as deleted thus remove other lookup xrefs
 N A,DATE,DFN,PROV,RDATE,TYPE,VST,VSTDATE,X0
 S X0=$G(^DENT(228.1,DA,0))
 S DFN=$P(X0,U,2),VST=$P(X0,U,5),PROV=$P(X0,U,7)
 S (DATE,VSTDATE)="",RDATE=+$P(X0,U,3)
 I VST S VSTDATE=+$G(^AUPNVSIT(VST,0)) I VSTDATE S DATE=VSTDATE
 E  S DATE=RDATE
 K:RDATE ^DENT(228.1,"AF",DATE,DA)
 I DFN D
 .S ^DENT(228.1,"ADEL",DFN,X,DA)=""
 .K ^DENT(228.1,"C",DFN,DA)
 .I VSTDATE,$D(^DENT(228.1,"AE",DFN,VSTDATE,DA)) K ^(DA)
 .I DATE'=VSTDATE,$D(^DENT(228.1,"AE",DFN,DATE,DA)) K ^(DA)
 .Q
 I PROV D
 .I VSTDATE,$D(^DENT(228.1,"AP",PROV,VSTDATE,DA)) K ^(DA)
 .I DATE,VSTDATE'=DATE,$D(^DENT(228.1,"AP",PROV,DATE,DA)) K ^(DA)
 .Q
 D TASK("S")
 Q
 ;
K1 ;  kill logic on DATE DELETED field 1.01
 ;  record date deleted removed thus reestablish other xrefs
 N A,DATE,DFN,PROV,TYPE,VST,VSTDATE,X0
 S X0=$G(^DENT(228.1,DA,0))
 S DFN=$P(X0,U,2),VST=$P(X0,U,5),PROV=$P(X0,U,7)
 S (DATE,VSTDATE,TYPE)="",RDATE=$P(X0,U,3)
 I VST S VSTDATE=+$G(^AUPNVSIT(VST,0)) I VSTDATE S DATE=+VSTDATE,TYPE="V"
 E  S DATE=+$P(X0,U,3),TYPE="C"
 I RDATE S ^DENT(228.1,"AF",RDATE,DA)=$P(X0,U,16)
 I DFN D
 .K ^DENT(228.1,"ADEL",DFN,X,DA)
 .K ^DENT(228.1,"ADEL",DFN,X,DA)
 .S ^DENT(228.1,"C",DFN,DA)=""
 .I DATE S ^DENT(228.1,"AD",DFN,DATE,DA)=TYPE
 .I VST S ^DENT(228.1,"V",DFN,VST,DA)=""
 .Q
 I PROV,DATE S ^DENT(228.1,"AP",PROV,DATE,DA)=DATE
 D TASK("K")
 Q
 ;
S10(IDX) ;  set logic called from several new style xrefs
 ;  IDX = index name [AS]
 ;  X(1) = date created   X(2) = visit
 N DATE,TYPE,VST
 I X(2) S VST=+$G(^AUPNVSIT(X(2),0)),TYPE="V"
 S DATE=+$S($G(VST):VST,1:X(1))
 S:DATE ^DENT(228.1,IDX,+DATE,DA)=$G(TYPE,"C")
 Q
 ;
K10(IDX) ;  kill logic called from several new style xrefs
 ;  IDX = index name [AS]
 ;  X(1) = date created   X(2) = visit
 N VST
 I X(2) S VST=+$G(^AUPNVSIT(X(2),0))
 I $G(VST) K ^DENT(228.1,IDX,VST,DA) Q
 I X(1) K ^DENT(228.1,IDX,+X(1),DA)
 Q
S11(IDX) ;  set logic called from several new style xrefs
 ;  IDX = index name [AE, AP]
 ;  X(1) = patient, provider
 ;  X(2) = date created   X(3) = visit
 N DATE,TYPE,VST
 Q:'X(1)
 I X(3) S VST=+$G(^AUPNVSIT(X(3),0)),TYPE="V"
 S DATE=+$S($G(VST):VST,1:X(2))
 S:DATE ^DENT(228.1,IDX,X(1),+DATE,DA)=$G(TYPE,"C")
 Q
 ;
K11(IDX) ;  kill logic called from several new style xrefs
 ;  IDX = index name [AE, AP]
 ;  X(1) = patient, provider
 ;  X(2) = date created   X(3) = visit
 N DATE,TYPE,VST
 Q:'X(1)
 I X(3) S VST=+$G(^AUPNVSIT(X(3),0))
 I $G(VST) K ^DENT(228.1,IDX,X(1),VST,DA) Q
 I X(2) K ^DENT(228.1,IDX,X(1),+X(2),DA)
 Q
 ;
S12 ;  update fields 70.01 and 70.02 in file 220
 ;  X(1)=DFN   X(2)=DATE   X(3)=CATEGORY  X(4)=DISPOSITION
 ;  invoked from the new style AD xref
 Q:'X(1)!'X(2)!'X(3)!(X(4)<1)
 Q:$$DFN^DENTVRF0(X(1),1)<1  L +^DENT(220,X(1),10):2 Q:'$T
 N X10 S X10=$G(^DENT(220,X(1),10))
 I X(2)>$P(X10,U,2) S $P(^DENT(220,X(1),10),U,1,2)=X(3)_U_X(2)
 L -^DENT(220,X(1),10)
 Q
 ;
 ;  --------------  FILE 228.2  --------------
 ;  A(.02)=DFN               A(.19)=CHART NUM
 ;  A(.03)=PROVIDER          A(.29)=TYPE
 ;  A(.13)=DATE             A(1.01)=DATE CREATED
 ;  A(.14)=TIME COUNTER     A(1.15)=DENTAL ENCOUNTER
 ;  A(.15)=TOOTH            A(1.18)=HL7 STATUS
S2 ;  set logic from DATE DELETED field 1.03
 ;  record marked as deleted thus remove other lookup xrefs
 N A,FLD,HL,X0,X1
 S X0=$G(^DENT(228.2,DA,0)),X1=$G(^(1))
 F FLD=1.01,1.15,1.18 S A(FLD)=$P(X1,U,$P(FLD,".",2))
 F FLD=.02,.03,.13,.14,.15,.19,.29 S A(FLD)=$P(X0,U,FLD*100)
 I A(1.15) S ^DENT(228.2,"AG",A(1.15),DA)=1
 I "C"'[A(1.18),A(1.01) D
 .K ^DENT(228.2,"AXMIT",A(1.18),A(1.01),DA)
 .S HL=$S(A(1.18)="P":"C",1:"P")
 .S $P(^DENT(228.2,DA,1),U,18)=HL
 .S ^DENT(228.2,"AXMIT",HL,A(1.01),DA)=A(1.18)
 .Q
 I A(.03),A(1.18) K ^DENT(228.2,"ATMP",A(.03),A(1.18),DA)
 Q:'A(.02)
 S ^DENT(228.2,"ADEL",A(.02),X,DA)=""
 K ^DENT(228.2,"C",A(.02),DA)
 I A(.29) K ^DENT(228.2,"AD",A(.02),A(.29),DA)
 Q:'A(.13)
 I A(.14) K ^DENT(228.2,"AE",A(.02),A(.13),A(.14),DA)
 I A(.15) K ^DENT(228.2,"AT",A(.02),A(.15),A(.13),DA)
 Q
 ;
K2 ;  kill logic from DATE DELETED field 1.03
 ;  record previous marked as deleted reactivated, reset other xrefs
 N A,FLD,X0,X1
 S X0=$G(^DENT(228.2,DA,0)),X1=$G(^(1))
 F FLD=1.15,1.18 S A(FLD)=$P(X1,U,$P(FLD,".",2))
 F FLD=.02,.03,.13,.14,.15,.19,.29 S A(FLD)=$P(X0,U,FLD*100)
 I A(1.15) S ^DENT(228.2,"AG",A(1.15),DA)=""
 Q:'A(.02)
 K ^DENT(228.2,"ADEL",A(.02),X,DA)
 S ^DENT(228.2,"C",A(.02),DA)=""
 I A(.29) S ^DENT(228.2,"AD",A(.02),A(.29),DA)=""
 Q:'A(.13)
 I A(.14) S ^DENT(228.2,"AE",A(.02),A(.13),A(.14),DA)=(A(.19)>59)
 I A(.15),A(.19)>59 S ^DENT(228.2,"AT",A(.02),A(.15),A(.13),DA)=""
 Q
 ;
 ; ---------- xref logic invoked by taskman ----------
 ; did not want to call ^DIE directly when xref logic invoked
 ; so xref queued up these calls to update data
 ;
TASK(T) ; called from traditional ADEL xref on file 228.1
 ; as such DA = ien to 228.1    X = date deleted
 ; we only need DA.    T - required - K (do kill) or S (do set)
 N X,X1,X2,Y,Z,DD,DO,DENIEN,DIC,DIE,DIK
 N ZTSK,ZTIO,ZTQUEUED,ZTREQ,ZTDTH,ZTDESC,ZTSAVE,ZTRTN
 Q:$G(T)=""  Q:"KS"'[$E(T)
 S DENIEN=DA N DA
 S ZTIO="",ZTSAVE("DENIEN")="",ZTDTH=$H
 S ZTDESC="DENT XREF UPDATE AS DATE DELETED CHANGED"
 S ZTRTN=$S($E(T)="S":"TS1",1:"TK1")_"^DENTVDD1"
 D ^%ZTLOAD
 Q
 ;
TS1 ;  called from ADEL xref on file 228.1 via Taskman
 ;  record DENIEN in 228.1 had the DATE DELETED field set
 ;  mark all records in file 228.2 as deleted
 S ZTREQ="@"
 N X,Y,Z,DENT,DENTER,DENZ,DIERR,IEN
 ;  check to see if record is still marked as deleted
 Q:'$G(DENIEN)  Q:'$D(^DENT(228.1,DENIEN))  Q:'$G(^(DENIEN,1))
 S DENZ=$G(^DENT(228.1,DENIEN,1))
 F IEN=0:0 S IEN=$O(^DENT(228.2,"AG",DENIEN,IEN)) Q:'IEN  D:'^(IEN)
 .K DENT,DENTER,DIERR
 .S X=IEN_","
 .S DENT(228.2,X,1.03)=$P(DENZ,U)
 .S Y=$P(DENZ,U,3) S:Y'="" DENT(228.2,X,1.05)=Y
 .S DENT(228.2,X,1.18)=$S($P($G(^DENT(228.2,IEN,1)),U,18)="P":"C",1:"P") ;hl7 status
 .D FILE^DIE(,"DENT","DENTER")
 .Q
 Q
 ;
TK1 ;  called from ADEL xref on file 228.1 via Taskman
 ;  record DENIEN in 228.1 had the DATE DELETED field deleted
 ;  unmark all records in file 228.2 previously marked as deleted
 S ZTREQ="@"
 N X,Y,Z,DENT,DENTER,DENZ,DIERR,IEN
 ;  check to see if record is still marked as not deleted
 Q:'$G(DENIEN)  Q:'$D(^DENT(228.1,DENIEN))  Q:$G(^(DENIEN,1))
 F IEN=0:0 S IEN=$O(^DENT(228.2,"AG",DENIEN,IEN)) Q:'IEN  D:^(IEN)
 .K DENT,DENTER,DIERR
 .S X=IEN_","
 .S DENT(228.2,X,1.03)=""
 .D FILE^DIE(,"DENT","DENTER")
 .Q
 Q
