DENTVTPC ;DSS/SGM - FILE TP TRANSACTIONS ;11/23/2003 22:29
 ;;1.2;DENTAL;**39,42,43,45,47,53,57**;Aug 10, 2001;Build 8
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ----------------------------------
 ;  2053      x      FILE^DIE
 ; 10103      x      $$NOW^XLFDT
 ; 10104      x      $$UP^XLFSTR
 ; 3744       x      $$TESTPAT^VADPT
 ;
 ; DENRET(SUB) = iens^flag
 ;     where iens is file 228.2 ien, or null, or 0
 ;     where flag = A (added), D (deleted)
 ;                  U (updated)
 ;                 -1 if problems encountered
 ; TRANID = .01 field value
 ;
FILE(DENA) ;  called from ^DENTVTPA
 ;  DENA - return 1^<#> filed^ien;ien;...
 ;  if problems, -1^error msg
 N I,X,Y,Z,DEN,DENERR,DENX,FLG,IENS,STUB,SUB,TRANID,NSUB
 D STUB
 K ^TMP("DENTV",$J,"TC") ;P57 timecounter xref
 ;  now set up transactions
 ;put in numerical order for processing (not ascii collated) P57T6
 F I=1:1:9 I $D(DATA("T"_I)) S DENX=DATA("T"_I),DATA("T0"_I)=DENX K DATA("T"_I)
 S SUB="T"
 F  S SUB=$O(DATA(SUB)) Q:SUB'?1"T"1N.N  S DENX=DATA(SUB) D  Q:$D(DENA)
 .S FLG=$E($P(DENX,U)),TRANID=$P(DENX,U,2)
 .I FLG="",TRANID<1 S FLG="A"
 .I "AaUuDd"'[FLG D ERR(1) Q
 .I FLG?1L S FLG=$$UP^XLFSTR(FLG)
 .I TRANID>0,FLG="A" D ERR(2) Q
 .I TRANID<1,"UD"[FLG D ERR(3) Q
 .S IENS="" I TRANID>0 D  Q:IENS=-1
 ..S IENS=$O(^DENT(228.2,"B",TRANID,0))
 ..I IENS>0 S IENS=IENS_","
 ..E  S IENS=-1 ;P53 don't error if txn not in db
 ..Q
 .D @FLG
 .Q
 ;  check to see if problems filing any txns
 S SUB=0 I $G(DENERR)!$D(DENA) D
 .F  S SUB=$O(DEN(SUB)) Q:SUB=""  D
 ..S IENS=$P(DEN(SUB),U) I $P(DEN(SUB),U,2)="A",IENS>0 D D
 ..Q
 .I '$D(DENA) D ERR("")
 .Q
 E  D
 .S Y=0 K Z S Z(0)="" F  S SUB=$O(DEN(SUB)) Q:SUB=""  D
 ..S Y=Y+1,X=$P(DEN(SUB),U,2) Q:X=-1
 ..S Z(X)=$S(X="A":"added",X="U":"updated",1:"deleted")
 ..I X="A" S Z(0)=Z(0)_(+DEN(SUB))_";"
 ..Q
 .S Z="",X=0 F  S X=$O(Z(X)) Q:X=""  S Z=Z_Z(X)_"/"
 .I Z'="" S Z=$E(Z,1,$L(Z)-1)
 .S X="1^"_Y_" DES transactions successfully filed"_U_Z(0)
 .S DENA=X
 .Q
 K ^TMP("DENTV",$J,"TC")
 Q
 ;
 ;-------------------------  NEW subroutines  -------------------------
ERR(X) ;
 N A S A=1+$O(DENA("A"),-1)
 I A=1 S DENA="-1^No transaction records created"
 I X=1 S X="No filing flag received for a transaction"
 I X=2 S X="Inconsistency, received add flag with a transaction ID"
 I X=3 S X="Inconsistency, received update event with no transaction ID"
 I X=4 S X="Unable to lock record for filing transaction, try again"
 I X=5 S X="TranID "_TRANID_" was not found in file 228.2"
 I X=6 S X="TranID does match TranID in the file"
 I X=7 S X="Editing of the CPT code is not allowed at this time"
 I X=8 S X="Editing of the number of canals is not allowed at this time"
 I X=9 S X="Editing of ICD9 codes is not allowed at this time"
 I X=10 S X="Unable to create new record in file 228.2"
 I X=11 S X="Invalid value received for field "_F_" in file 228.2: "_V
 S:X'[U X=U_X S DENA(A)=X,DEN(SUB)=+$G(IENS)_"^-1",DENERR=1
 Q
 ;
A ;  add a new transaction
 N A,I,X,Y,CODE,DENER,DENF,DIERR,Z
 S IENS=$$TRANID^DENTVRF0(228.2) I IENS<1 D ERR(10) Q
 S IENS=IENS_","
 M DENF(228.2,IENS)=STUB
 I $E($P(DENX,U,3),3) D A0(1.19,1) ;file to PCE, indiv txn level flag
 E  D A0(1.19,0)
 ;  ada code
 S CODE=$P(DENX,U,5) I CODE D
 .D A0(.04,CODE) S Y=$G(^DENT(228,CODE,0)) Q:Y=""
 .S X=$P(Y,U,3) D:X A0(1.11,X) ;  ctv
 .S X=$P(Y,U,18) D:X]"" A0(1.12,X) D:X="" A0(1.12,+$P(DENX,U,31)) ; rvu
 .S X=$P(Y,U,4) D:X A0(1.13,X) ; das field
 .S X=$P(Y,U,5) I X]"" D A0(1.201,X) ; das data
 .S X=$P(Y,U,16) I X S X=$P($G(^DENT(228.42,X,0)),U) D:X'="" A0(1.16,X) ; VA-DSS group
 .S X=$P(Y,U,10) I X="y" D A0(1.202,"10000000") ; tooth related
 .Q
 S X=$P(DENX,U,6) S:X=""&CODE X=$P(DENCPT(CODE),U,2) D:X'="" A0(.05,X)
 ;set chart# manually - sometimes reset TO 60 by the gui! P43
 I $P(DENX,U,19)>59 D
 .S X=$P(DENX,U,13),X=$$DT(X)
 .S Z=$$CHART^DENTVRF0(DFN,$P(X,"."),1) I Z>0 S $P(DENX,U,19)=$P(Z,U) ;  chartnum
 .Q
 ;
 D A1(7,2,.07) ;  aspect
 D A1(8,3,.08) ;  chart type
 D A1(9,4,.09) ;  condition
 D A1(10,5,.1) ;  material
 D A1(11,1,.11) ; area
 D A1(12,7,.12) ; status
 S X=$P(DENX,U,13),X=$$DT(X) D:X A0(.13,X) ; date
 ;VAL time counter! This value must be unique for a txn or ranged txn 'set' for the day
 S Y=$P(DENX,U,14) I $O(^DENT(228.2,"AE",DFN,+X,+Y,0)) D RESET(X) ;P57
 D A2(14,.14) ;  time counter
 D A2(15,.15) ;  tooth number
 D A2(16,.16) ;  surface/roots
 D A2(17,.17) ;  phase
 D A3(18,.18) ;  isjuvenile
 D A2(19,.19) ;  chart num
 D A3(20,.2) ;   visible
 D A3(21,.21) ;  next appt
 D A2(22,.22) ;  group
 D A2(23,.23) ;  deleted
 D A2(24,.24) ;  cost
 D A2(25,.25) ;  category
 D A2(26,.26) ;  sequence index
 D A2(27,.27) ;  plaque index
 D A3(28,.28) ;  read only
 D A2(30,1.17) ; #canals
 ;  get icd9 codes
 S X=$TR($P(DENX,U,29),";",U),A=1.05
 F I=1:1:5 S Y=$P(X,U,I) I Y S A=A+.01 D A0(A,Y)
 ;  determine if record should be marked as read only
 ;  only examine findings and completed txns
 S X=$G(DENF(228.2,IENS,.12))
 I X=102!(X=104) D:'$G(DENF(228.2,IENS,.28)) A0(.28,1)
 I X=104 D
 .I $G(DENF(228.2,IENS,.09))=23,$G(DENF(228.2,IENS,.22))>1 Q  ;only send one txn for a partial P45
 .I $G(DENF(228.2,IENS,.04))="" Q  ;no ada code (placeholder for bridge/conn bar) P45
 .I $$TESTPAT^VADPT(DFN) Q  ;don't send test pt data
 .D:$G(DENF(228.2,IENS,.09))'=66 A0(1.18,"P") ;set pending HL7 flag if not 'observe'
 .Q
 ;  we are now ready to file this txn
 L +^DENT(228.2,+IENS):2 E  S DEN(SUB)=+IENS_"^-1" Q
 D FILE^DIE(,"DENF","DENER") L -^DENT(228.2,+IENS)
 I '$D(DIERR) S DEN(SUB)=+IENS_"^A"
 E  S X=$$MSG^DSICFM01("VE",,,,"DENER") D ERR(X)
 Q
 ;
A0(F,X) S DENF(228.2,IENS,F)=X Q
 ;
A1(P,T,F) ;  lookup ien for constants value
 ;  P = piece of variable DENX   T=type    F = 228.2 field#
 S X=$P(DENX,U,P) I X'="" S Y=$$PTR^DENTVTP0(T,X) I Y>0 D A0(F,Y)
 Q
 ;
A2(P,F) S X=$P(DENX,U,P) D:X'="" A0(F,X) Q
 ;
A3(P,F) ;  boolean
 S X=$P(DENX,U,P) S:X<0 X=1 I X?1N,10[X D A0(F,X)
 Q
 ;
RESET(CDAT) ;reset the timecounter
 ;txns may file in any order - grouped txns need the same timecounter, even if reset
 N LAST
 S LAST=$G(^TMP("DENTV",$J,"TC",+$P(DENX,U,14))) I LAST S $P(DENX,U,14)=LAST Q
 S LAST=$O(^DENT(228.2,"AE",DFN,CDAT,9999),-1)
 I '$P(DENX,U,22) S LAST=LAST+10 ;get last tc and add 10 (if not a grp txn)
 ;save in case of grouped txns and update the timecounter field with new tc
 S ^TMP("DENTV",$J,"TC",+$P(DENX,U,14))=LAST,$P(DENX,U,14)=LAST
 Q
D ;  delete a txn
 N X,Y,Z,DA,DENF S DA=+IENS
 I DA<1!'$D(^DENT(228.2,DA,0)) S DEN(SUB)=+IENS_"^-1" Q  ;not valid txn
 I $P(DENX,U,12)=0 D  Q  ;if "findings", set Deleted field (.23) = 1 OR delete
 .I $E(+$G(^DENT(228.2,DA,1)),1,7)'=DT D  D DELF Q
 ..I $G(DENTADMN) S DENF(228.2,DA_",",1.03)=$$NOW^XLFDT Q  ;file as deleted if admin P47
 ..S DENF(228.2,DA_",",.23)=1 ;set strikethrough 'deleted' field if not admin
 ..Q
 .S X=$$DIK^DENTVTPA(.DA,228.2),DEN(SUB)=+IENS_U_$S(+X=-1:-1,1:"D") ;really delete if same day
 .D DH^DENTVTPA
 .Q
 I $P(DENX,U,12)=2 D  Q  ;if "completed", set Date Deleted (1.03)
 .S DENF(228.2,DA_",",1.03)=$$NOW^XLFDT D DELF
 .I $$GET1^DIQ(228.2,DA_",",1.19)="YES" S DENTPCE=1,DELD(DA)="" ;update PCE message to user (see DENTVTPA) DELD=P47
 .Q
 ;if "planned", delete the transaction entirely
 S X=$$DIK^DENTVTPA(.DA,228.2),DEN(SUB)=+IENS_U_$S(+X=-1:-1,1:"D")
 D DH^DENTVTPA
 Q
 ;
DELF ;file the delete updates
 N DENER,DIERR
 L +^DENT(228.2,+IENS):2 E  S DEN(SUB)=+IENS_"^-1" Q
 D FILE^DIE(,"DENF","DENER") L -^DENT(228.2,+IENS)
 I '$D(DIERR) S DEN(SUB)=+IENS_"^A" D DH^DENTVTPA
 E  S X=$$MSG^DSICFM01("VE",,,,"DENER") D ERR(X)
 Q
DT(X,DEN) ;
 N Y,Z,%DT S %DT="" D ^%DT Q $S($G(DEN):$G(Y),$G(Y)>0:Y,1:DT)
 ;
STUB ;  define STUB(field#)=value for common elements in each transaction
 N VISDT I DFN S STUB(.02)=DFN
 I PROV S STUB(.03)=PROV
 I DES S STUB(1.15)=DES,VISDT=$$VISDT(DES) S:VISDT STUB(1.05)=VISDT
 I $G(DES("DAS")) S STUB(1.01)=DES("DAS")
 S STUB(.29)=1
 S STUB(.06)=1
 Q
 ;
VISDT(EIEN) ;get the visit date, or create date of 228.1 P53
 ;this may not return the correct date until AFTER PCE files for a sched appt
 ;DENTVTPD will reset this data.  If existing visit picked, it'll be set here
 N VIEN,VDT S VIEN=0,VDT=$P($G(^DENT(228.1,EIEN,0)),U,3) ;default to create date
 S VIEN=$P($G(^DENT(228.1,EIEN,0)),U,5)
 I VIEN S VDT=$$GET1^DIQ(9000010,VIEN,.01,"I") ;use visit date if exists
 Q VDT
U ;  update an existing transaction
 N A,I,J,X,Y,DENER,DENF,DENR,DIERR
 D GETS^DIQ(228.2,IENS,"*","I","DENR","DENER")
 K X M X=DENR K DENR
 I $D(DIERR) S X=$$MSG^DSICFM01("VE",,,,"DENER") D ERR(X) Q
 F I=0:0 S I=$O(X(228.2,IENS,I)) Q:'I  S DENR(I)=X(228.2,IENS,I,"I")
 K X
 ;
 ;  find any fields that are different
 D U4(2,.01)
 ;I $E($P(DENX,U,3),3) D A0(1.19,1) ;file to PCE, indiv txn level flag
 ;E  D A0(1.19,0) ;11.18.04 KC don't update this flag!!
 S X=$P(DENX,U,5) I X'=DENR(.04) D ERR(7) ; cpt code
 ;  ada description
 I X,$P(DENX,U,6)="" S $P(DENX,U,6)=$P(DENCPT(X),U,2)
 D U1(6,.05) ;    ada description
 D U2(7,2,.07) ;  aspect
 D U2(8,3,.08) ;  chart type
 D U2(9,4,.09) ;  condition
 D U2(10,5,.1) ;  material
 D U2(11,1,.11) ; area
 D U2(12,7,.12) ; status
 S X=$P(DENX,U,13) S:X'="" X=$$DT(X,1) ; date
 I X="",DENR(.13) D A0(.13,X)
 I X,X'=DENR(.13) D A0(.13,X)
 D U1(14,.14) ;  time counter
 D U1(15,.15) ;  tooth number
 D U1(16,.16) ;  surface/roots
 D U1(17,.17) ;  phase
 D U3(18,.18) ;  isjuvenile
 D U1(19,.19) ;  chart num
 D U3(20,.2) ;   visible
 D U3(21,.21) ;  next appt
 D U1(22,.22) ;  group
 D U1(23,.23) ;  deleted
 D U1(24,.24) ;  cost
 D U1(25,.25) ;  category
 D U1(26,.26) ;  sequence index
 D U1(27,.27) ;  plaque index
 D U3(28,.28) ;  read only
 ;D U4(30,1.17) ;  #canals ;don't update canals! patch 42 KC
 ;  get icd9 codes
 S X=$TR($P(DENX,U,29),";",U),Z=1.05,J=0
 F I=1:1:5 S Y=$P(X,U,I),Z=Z+.01 I Y'=$G(DENR(Z)) S J=1 Q
 D:J ERR(9)
 Q:$P($G(DEN(SUB)),U,2)=-1  Q:$D(DENA)
 I '$D(DENF) S DEN(SUB)=+IENS_"^U0" Q
 D FILE^DIE(,"DENF","DENER")
 I '$D(DIERR) S DEN(SUB)=+IENS_"^U"
 E  S X=$$MSG^DSICFM01("VE",,,,"DENER")
 Q
 ;
U1(P,F) S X=$P(DENX,U,P) I X'=DENR(F) D A0(F,X)
 Q
 ;
U2(P,T,F) ;  edit constants
 N V,X,Y S V=$P(DENX,U,P)
 I V'="" S Y=$O(^DENT(228.3,"E",T,V,0)) I Y="" D ERR(11) Q
 I V="" Q:DENR(F)=""  D A0(F,V) Q
 I Y'=DENR(F) D A0(F,Y)
 Q
 ;
U3(P,F) ;  boolean
 S X=$P(DENX,U,P) S:X<0 X=1 I 10[X,X'=DENR(F) D A0(F,X)
 Q
 ;
U4(P,F) ;  check those fields which are not allowed to be edited
 S X=$P(DENX,U,P) Q:X=DENR(F)  S Y=$S(F=.01:6,1:8) D ERR(Y)
 Q
