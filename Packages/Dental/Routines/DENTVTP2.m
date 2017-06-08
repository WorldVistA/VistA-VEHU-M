DENTVTP2 ;DSS/SGM - FILE DES RECORD FOR TREATMENT PLAN ;11/04/2003 15:23
 ;;1.2;DENTAL;**38,39,45,47,50,55**;Aug 10, 2001;Build 5
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  -----------------------------------
 ;  2056      x      $$GET1^DIQ
 ;  2051      x      $$FIND1^DIC
 ;  2438      x      Fileman lookup on file 40.8
 ;  3512   Cont Sub  direct global read of ^AUPNVSIT(D0)
 ; 10013      x      IX1^DIK
 ;                   FM read of file 44, field 3.5
 ;
ADD(DENTP,DATA) ;  RPC: DENTV TP ADD ENCOUNTER
 ;  This RPC will create a new encounter record to file 228.1, and will
 ;  create new transaction type records in file 228.2
 ;  DATA(sub) = value  where
 ;      sub     Req  Description
 ;   ---------  ---  -------------------------------------------------
 ;   "PAT"       x   DFN - pointer to patient file
 ;   "VISIT"         pointer to visit file (#9000010)
 ;   "APPT"          scheduled appointment Fileman date.time
 ;   "NEWAPPT"       create visit, no scheduled appt or existing visit
 ;                   NOTE: VISIT supercedes APPT which supercedes NEWAPPT
 ;
 ;   "LOC"       x   pointer to HOSPITAL LOCATION file (#44)
 ;   "PROV"          primary provider - pointer to NEW PERSON file
 ;                   if not passed then use DUZ of existing user
 ;   "DISTPROV"      If PROV (or DUZ) = resident then distributed provider
 ;                   is required.
 ;   "PATTYPE"       I:inpatient; O:outpatient (NOT USED AFTER P54,get from MAS)
 ;   "DAS CAT"   x   POINTER TO DENTAL CLASSIFICATION FILE (#220.2)
 ;   "DAS BED"       POINTER TO DENTAL BED SECTION FILE (#220.4)
 ;                      required if patient an inpatient
 ;   "DAS DIV"   x   station number
 ;   "DAS DIS"   x   1:In progress; 2:Completed; 3:Terminated;
 ;   "FLAGS"         3 bytes - each byte 0 or 1 - <das><des><pce>
 ;
 ;  If successfully add a new record, return ien to file 228.1^message
 ;  Else return -1^message
 ;
 ;  Internal variables of note:
 ;  DATA("T") = V for visit, A for scheduled appt, N for adhoc visit
 ;
 N X,Y,Z,DA,DATE,DEN,DENER,DENMSG,DENPCE,DENT,DIERR,DIK,FLG,INP,DFN
 ;  validate patient
 S FLG=$G(DATA("FLAGS")) S:FLG="" FLG=111
 I $G(DATA("PAT"))<1 D MSET("No patient received")
 E  D
 .S X=$$DFN^DENTVRF0(DATA("PAT"),1)
 .I X<1 D MSET($P(X,U,2)) Q
 .S (DFN,DENT(.02))=+DATA("PAT")
 .Q
 ;validate location
 S DEN="No valid location received: "_$G(DATA("LOC"))
 I '$D(DATA("LOC")) D MSET(DEN)
 E  S X=$$LOC^DSICVST("`"_DATA("LOC")) D
 .I X>0 S DENT(.11)=+X
 .E  D MSET(DEN)
 .Q
 ; if visit, validate 
 S X=$G(DATA("VISIT")) I X D
 .I +$G(^AUPNVSIT(X,0)) S DENT(.05)=X
 .E  D MSET("Visit entry does not exist: "_X) Q
 .S VAIP("D")=$P($P(^AUPNVSIT(X,0),"."),U)  ;must be date field, without time
 .D IN5^VADPT I 'VAIP(13) S INP=0,DENT(.1)="O" D KVA Q
 .S INP=1,DENT(.1)="I",DENT(.17)=+VAIP(13,6) D KVA
 .Q
 ;use the old code to get the inpt/outpt flag if not found above (it means no Visit)
 I '$D(INP) D
 .S INP=$$INQ^DSICDPT2(,DENT(.02),"MSs",,1)
 .I $P(INP,U,3)>0 S DENT(.17)=$P(INP,U,3)
 .S X=$G(DATA("PATTYPE"))
 .I X="" S X=$S(+INP:"I",1:"O")
 .E  I X'="I",X'="O" D MSET("Invalid patient type received: "_X) S X=-1
 .S:"IO"[X DENT(.1)=X
 .Q
 ;  validate that the provider has an active person class
 ;  if a resident, then "DISTPROV" is required, else error  P47
 S X=$G(DATA("PROV")) S:X<1 X=DUZ S DENT(.07)=X
 D PROV^DENTVRP1(.Y,X) I +Y<0 D MSET($P(Y,U,2)) ;validate provider P45
 I $G(DATA("DISTPROV"))=X S DATA("DISTPROV")="" ;the same user can't be in both fields
 N PC S PC=$$VCODE^DENTVHLU(X,DT)
 I PC]"","V030300,V115500,V115600"[PC D
 .;before setting error, make sure we're filing to PCE
 .I $G(DATA("DISTPROV"))="",+$E(FLG,3) D MSET("Residents require a Distributed Provider for PCE workload.") Q
 .S DENT(.08)=$G(DATA("DISTPROV"))
 .Q
 ;  get das specific data
 S X=$G(DATA("DAS CAT")) I X S DENT(.13)=X
 I 'X D MSET("Missing Dental Category - cannot file encounter") ;10.20.06 P50 some sites get HL7 error for this?
 S X=$G(DATA("DAS BED")) I X S DENT(.14)=X
 S X=$G(DATA("DAS DIS")) I X S DENT(.16)=X
 S X=$G(DATA("DAS DIV")),Y=""
 I X'="" S Y=$O(^DENT(225,"B",X,0)) I Y S DENT(.15)=Y D
 .; 1/30/2004 KC P38 always get the Division pointer here
 .K DENER,DIERR S Z=$$FIND1^DIC(4,,"MX",X,,,"DENER")
 .S:Z>0 DENT(.18)=Z
 .Q
 I $D(DENMSG) S DENTP="-1^"_DENMSG Q
 I +$E(FLG,3) S DENT(.19)=1 ;filed to pce
 ;  file data
 ;  create file 228.1 record stub
 S DA=$$TRANID^DENTVRF0(228.1)
 S X="Problems encountered trying to create a new record in file 228.1"
 I DA<1 S DENTP="-1^"_X Q
 ;  gather rest of record 228.1 data, file it, reindex it
 I $$LOCK^DENTVUTL(228.1,DA)<1 D  Q
 .S DENTP="-1^Unable to file 228.1 record "_DA_", try again"
 .Q
 S X=^DENT(228.1,DA,0),$P(X,U,3)=+$P(X,U,3) ;temp fix for patch 39 create date=string
 F Z=0:0 S Z=$O(DENT(Z)) Q:'Z  S Y=Z*100,$P(X,U,Y)=DENT(Z)
 S ^DENT(228.1,DA,0)=X
 N DD,DO S DIK="^DENT(228.1," D IX1^DIK
 L -^DENT(228.1,DA)
 S DENTP=DA_"^Dental encounter record successfully created"
 Q
 ;
UPD(DENTP,DATA) ;  RPC: DENTV TP UPDATE TRANSACTION
 ;  update an existing transaction data type
 ;  DATA(n) = p1^p2^
 Q
 ;
 ;------------------------  subroutines  ------------------------
MSET(X) S DENMSG=$G(DENMSG)_X_"; " Q
KVA D KVA^VADPT Q
