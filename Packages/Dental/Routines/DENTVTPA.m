DENTVTPA ;DSS/SGM - FILE TP TRANSACTION DATA ;11/26/2003 16:25
 ;;1.2;DENTAL;**39,42,43,45,47,53,57,59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this routine will be used to file transaction data types for
 ;  treatment planning as well as DRM
 ;
 ;  DBIA#  Supported  Description
 ;  -----  ---------  ----------------------------
 ;   1625      x      $$GET^XUA4A72
 ;   2054      x      $$IENS^DILF
 ;   2055      x      $$ROOT^DILFD
 ;  10013      x      ^DIK
 ;  10096      x      ^%ZOSF()
 ;  10103      x      $$FMTE^XLFDT
 ;   2053      x      FILE^DIE
 ;  routine documentation for FILE entry point found by VAH>D ^DENTVTPA
 N X S X="DSICDDBR" X ^%ZOSF("TEST") Q:'$T
 D BROWSE^DSICDDBR("9.2;2;DENTVTPA")
 Q
 ;
FILE(DENT,DATA) ;  RPC: DENTV TP FILE TRANSACTIONS
 ;  This will file transaction data types, PCE, and DAS data
 ;  If successful, return:
 ;      1^<#> DES transactions created
 ;      1^PCE message^visit ien                    
 ;  If unsuccessful, return -1^message
 ;
 N A,I,X,Y,Z,DATE,DEN0,DEN1,DEN2,DEN3,DENCPT,DENICD,DES,DFN,FLAG
 N PROV,STR,SUB,DENADD,DENTXN,DENTPCE,DENTADMN,DENDEL
 S DES=$G(DATA("DES")),FLAG="010",DENADD=0,DENTXN=-1,DENDEL=0
 S SUB="T" F  S SUB=$O(DATA(SUB)) Q:SUB'?1"T"1N.N  D  ;see if there are any "A"dds
 .S X=DATA(SUB),Y=$P(X,U),DENTXN=$P(X,U,2) I Y="A" S DENADD=1,SUB="T999"
 .I Y="D" S DENDEL=1
 .Q
 I 'DES,DENADD D ERR(1) Q
 I DENADD S DES(0)=$G(^DENT(228.1,DES,0)) I DES(0)="" D ERR(2) Q
 S DFN=$S(DENADD:$P(DES(0),U,2),DENTXN>0:$P($G(^DENT(228.2,DENTXN,0)),U,2),1:"")
 I DENADD!DENDEL D RRUN^DENTVM1($G(DFN),$G(DES)) ;P57 fluoride monitor
 S DENTADMN=$G(DATA("ADMIN")) ;P47 "file as deleted" findings if admin and previous date
 I $G(DATA("PCE-DIAG"))'="" D
 .S X=$$ICD(DATA("PCE-DIAG"))
 .K:X<1 DATA("PCE-DIAG") S:X>0 DATA("PCE-DIAG")=X
 .Q
 S X=$O(DATA("T")) I X'?1"T"1N.N D ERR(3) Q
 D PROV
 ;
 ;  validate CPT and ICD9 codes
 ;  reset cpt and icd9s to iens instead of code names
 S SUB="T" F  S SUB=$O(DATA(SUB)) Q:SUB'?1"T"1N.N  D
 .S X=DATA(SUB),Y=$P(X,U,3)
 .;  modify filing flags if needed
 .I Y="" S Y=111
 .;  only file to DES if status is not completed nor has a cpt
 .I $P(X,U,12)'=2!($P(X,U,5)="") S Y="010"
 .S $P(DATA(SUB),U,3)=Y
 .F I=1:1:3 I $E(Y,I) S $E(FLAG,I)=1
 .Q:$P(X,U)="D"  ;don't check CPT/ICD for Deletes
 .S Z=$$CPT($P(X,U,5)) S:Z>0 $P(DATA(SUB),U,5)=Z
 .S Y=$P(X,U,29),STR=""
 .F I=1:1:5 S A=$P(Y,";",I) I A'="" S Z=$$ICD(A) S:Z>0 $P(STR,";",I)=Z
 .S $P(DATA(SUB),U,29)=STR
 .Q
 Q:$D(DENT)  S DEN0=1
 ;  file DES data
 I $E(FLAG,2) D  Q:'DEN0
 .D FILE^DENTVTPC(.DEN2)
 .I '$O(DEN2(0)) D SET(DEN2) Q
 .K DENT
 .D SET($P(DEN2,U,1,2)) S DEN0=0
 .F Y=0:0 S Y=$O(DEN2(Y)) Q:'Y  D SET(DEN2(Y))
 .Q
 ;  file PCE data
 I $E(FLAG,3) D
 .D FILE^DENTVTPD(.DEN3)
 .I +DEN3=1 D
 ..D SET(DEN3)
 ..I $O(DEN3(0)) F Y=0:0 S Y=$O(DEN3(Y)) Q:'Y  D SET(DEN3(Y))
 ..Q
 .E  D  ;  PCE failed
 ..K DENT
 ..D SET("-1^No transaction records added")
 ..D SET(DEN3) F Y=0:0 S Y=$O(DEN3(Y)) Q:'Y  D SET(DEN3(Y))
 ..S X=$P(DEN2,U,3)
 ..F Y=1:1:$L(X,";") S Z=$P(X,";",Y),I=$$DIK(Z,228.2)
 ..Q
 .Q
 I $G(DENTPCE) D PCEMSG
 I '$D(DENT) D SET("-1^Unexpected problems encountered")
 Q
PCEMSG ;set additional informational message, PATCH 43
 N DENTXPR,DENX,I
 S DENTXPR="SYS~DENTV DRM NO PCE DELETE~1",DENX=$$GET1^DSICXPR(,DENTXPR,1)
 I +DENX=1 D  Q
 .D SET("")
 .D SET("You have deleted COMPLETED transactions that were filed to PCE")
 .D SET("Please remember to update the affected encounter in PCE")
 .Q
 ;P53 Send back deleted txns to file to PCE separately via rpc
 Q:'$D(DELD)
 S I=0 F  S I=$O(DELD(I)) Q:'I  D SET("DELETED^"_I)
 Q
 ;
FILEX(DENT,DATA) ; RPC - DENTV TP FILE EXAM TRANSACTION
 ; Files the new exam template modal data (OHA,PAR,OCC,TMJ) into a record in 228.2 of type 5:EXAM
 ;
 N I,IENS,VISDT,DENTV,FIL,FLD,TMP,DENTER,III,DENTWP,TMP,II,FLG,DA,DIK
 S FIL="228.2",FLG=0
 I DATA("FLAG")="" S DATA("FLAG")="A"
 I DATA("FLAG")="A" S IENS=$$TRANID^DENTVRF0(FIL) I IENS<0 D ERR(6) Q
 I DATA("DPAT")="" S DENT(1)="-1^Patient IEN not sent" Q
 I DATA("PROV")="" S DENT(1)="-1^A provider is required for this transaction." Q
 I DATA("FLAG")="M" D
 .I DATA("IEN")="" S DENT(1)="-1^A record IEN must be passed to modify a record." Q
 .S II=DATA("IEN")
 .D GETS^DIQ(FIL,II_",",".03;.13;1.05","I","TMP","DENTER")
 .I TMP(FIL,II_",",.03,"I")=DATA("PROV") S FLG=1 E  S FLG=0
 .I TMP(FIL,II_",",.13,"I")=DATA("DATE") S FLG=1 E  S FLG=0
 .I TMP(FIL,II_",",1.05,"I")=$$VISDT^DENTVTPC(DATA("DES")) S FLG=1 E  S FLG=0
 .I FLG S IENS=II
 I 'IENS S DENT(1)="-1^IEN data does not match" Q
 ;S DA=IENS,DIK="^DENT(228.2," D ^DIK
 I '$D(DATA("DES")) D ERR(1) Q
 S IENS=IENS_",",VISDT=$$VISDT^DENTVTPC(DATA("DES"))
 S DENTV(FIL,IENS,.02)=DATA("DPAT")
 ;Add check for valid dental provider?? Using PROV
 I '$D(DATA("PROV")) D ERR(4) Q 
 S DENTV(FIL,IENS,.03)=DATA("PROV")
 S DENTV(FIL,IENS,.06)=1
 S DENTV(FIL,IENS,.13)=DATA("DATE")
 S DENTV(FIL,IENS,1.05)=$P(VISDT,".")
 S DENTV(FIL,IENS,1.15)=DATA("DES")
 S DENTV(FIL,IENS,.29)=5
 F I="OHA","OCC","PAR","PARC","TMJ","TMJC","SOCH","SHDA" D  ;Loop thru DATA
 .S Z=$S(I="OHA":5,I="OCC":9,I="PAR":4,I="PARC":7,I="TMJ":8,I="TMJC":7,I="SOCH":17,I="SHDA":2) ;Controls # of ^'s per node for loop
 .S FLD=$S(I="OHA":5.01,I="OCC":5.1,I="PAR":5.3,I="PARC":5.4,I="TMJ":5.5,I="TMJC":5.7,I="SOCH":10.01,I="SHDA":10.3)
 .I $D(DATA(I)) S III=1 F III=III:1:Z S TMP=$P(DATA(I),U,III) D  ;Grab the piece to save to DENT
 ..S DENTV(FIL,IENS,FLD)=TMP S FLD=FLD+.01
 D FILE^DIE(,"DENTV","DENTER")
  I '$D(DENTER) S DENT="1^Save complete"
 E  D
 .S X=$$MSG^DSICFM01("VE",,,,"DENTER")
 .I $G(DENIEN(1))<1 S DENT="-1^"_X
 .E  S DENT="1^"_X
 F I="PARWP","PARCWP","TMJWP","TMJCWP","SHWP" D  ;Loop through WP fields in DATA
 .I $D(DATA(I)) D
 ..S FLD=$S(I="PARWP":6,I="PARCWP":7,I="TMJWP":8,I="TMJCWP":9,I="SHWP":10.4)
 ..M DENTWP=DATA(I)
 ..D WP^DIE(FIL,IENS,FLD,"K","DENTWP","DENTER") K DENTWP
 .I '$D(DATA(I)) D
 ..N DNTWP
 ..S FLD=$S(I="PARWP":6,I="PARCWP":7,I="TMJWP":8,I="TMJCWP":9,I="SHWP":10.4)
 ..S DNTWP(228.2,IENS,FLD)="@" D FILE^DIE(,"DNTWP") K DNTWP
 I '$D(DENTER) S DENT="1^Save complete"
 E  D
 .S X=$$MSG^DSICFM01("VE",,,,"DENTER")
 .I $G(DENIEN(1))<1 S DENT="-1^"_X
 .E  S DENT="1^"_X
 Q
 ;
 ;-----------------------  subroutines  -------------------------
CPT(X) ;  validate CPT codes in Tn
 ;  If valid code, return p1;p2;p3  where
 ;     p1 = cpt ien    p2 = cpt code    p3 = cpt short description
 ;  If invalid code, set error message
 ;  RETURN: cpt ien or -1
 N Y,Z,ACT,CODE
 I X="" Q -1
 I $D(DENCPT("B",X)) Q DENCPT("B",X)
 S Z=$$CPT^DSICCPT("",X,DT,"","",1),ACT=$P(Z,U,7),CODE=$P(Z,U,2)
 I Z>0,ACT S DENCPT(+Z)=$P(Z,U,2,3) Q +Z
 I Z<1 S Y=Z
 E  S Y=CODE_" inactive as of "_$$FMTE^XLFDT($P(Z,U,6))
 D ERR(Y)
 Q -1
 ;
DIK(DA,F) ;  delete a record
 ;  return 1 if successfully deleted, else return -1
 ;  DA - required as defined by ^DIK
 ;   F - required - file number if it a top level file or global root
 N X,Y,DIC,DIK,DD,DO
 I $G(F)=""!'$G(DA) Q -1
 I F'=+F S DIK=F
 E  D  I DIK=-1 Q -1
 .I $$VFILE^DSICFM06(,F,1)=-1 S DIK=-1 Q
 .N IENS,DENER,DIERR S IENS=$$IENS^DILF(.DA)
 .S DIK=$$ROOT^DILFD(F,IENS,,"DENER")
 .I $D(DIERR)!$D(DENER) S DIK=-1
 .Q
 D ^DIK
 Q 1
 ;
ERR(X) ;
 ;;No DES Encounter received
 ;;No record exists in file 228.1 for encounter
 ;;No transaction records received
 ;;No valid provider DUZ or no PERSON CLASS
 ;;Provider does not have an active PERSON CLASS
 ;;Unable to create new record in file 228.2
 S:X=+X X=$P($T(ERR+X),";",3) S:+X'=-1 X="-1^"_X D SET(X)
 Q
 ;
ICD(X) ;  validate ICD9 codes in Tn
 ;  If valid code, return p1;p2;p3  where
 ;     p1 = icd9 ien    p2 = icd9 code    p3 = icd9 short description
 ;  If invalid code, set error message
 ;  Return -1 or file 80 ien
 N I,Y,Z,ACT,CODE
 I X="" Q -1
 I $D(DENICD("B",X)) Q DENICD("B",X)
 S Z=$$ICD9^DSICDRG("",X,"",DT,"",1),ACT=$P(Z,U,10),CODE=$P(Z,U,2)
 I Z>0,ACT S DENICD(+Z)=CODE_U_$P(Z,U,4) Q +Z
 I Z<1 S Y=Z
 E  S Y=CODE_" inactive as of "_$P($P(Z,U,12),";",2)
 D ERR(Y)
 Q -1
 ;
PROV ;  determine valid provider
 ;  return duz of provider^boolean flag if has active person class
 N X,Y,DENX
 S DENX=$G(DATA("PCE-DUZ")) S:'DENX DENX=DUZ
 S X=$$GET^XUA4A72(DENX) I X=-1 D ERR(4) Q
 I X=-2 D ERR(5) Q
 S PROV=+DENX
 Q
 ;
SET(X) N I S:X'[U X=U_X S I=1+$O(DENT("A"),-1),DENT(I)=X Q
 ;
DH ;If there are no more active transactions, then delete history file entry also
 ;called by DENTVTPC when deleting txns
 N DH,Y,QT S DH=$P($G(^DENT(228.2,DA,1)),U,15) Q:'DH  ;no encounter pointer
 S Y=0,QT=0 F  S Y=$O(^DENT(228.2,"AG",DH,Y)) Q:'Y!QT  I +$G(^(Y))=0 S QT=1
 Q:QT  ;still active txns left for this encounter
 K DENF S DENF(228.1,DH_",",1.01)=$$NOW^XLFDT
 L +^DENT(228.1,DH):2 E  Q  ;can't lock record
 D FILE^DIE(,"DENF","DENER") L -^DENT(228.1,DH)
 Q
