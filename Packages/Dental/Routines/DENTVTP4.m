DENTVTP4 ;DSS/KC - RPCS TO FILE TREATMENT PLAN DATA;11/04/2003 15:27
 ;;1.2;DENTAL;**39,43,45,47,59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;  this routine RPCs for filing transaction data type in the Dental
 ;  treatment plan software, Perio, PSR and H&N
 ; DBIA#  SUPPORTED
 ; -----  ---------  ----------------------------------
 ; 10013      x      ^DIK
 ;  2053      x      FILE^DIE, WP^DIE
 ; 10103      x      $$NOW^XLFDT
 ; 
PSR(RET,DATA) ; RPC: DENTV TP FILE PSR
 ;  rpc to file (add/update) PSR data
 ;  RET = -1^error message  or  ien^message
 ;  DATA - required - format of input DATA
 ;  DATA("ENC") = DentalEncounterIFN (required if Add, optional if Update)
 ;  DATA("PSR") = txn id^exam date^prov id^psr score string^STATUS (A/U)
 N X,Y,Z,IENS,DE0,EDT,PROV,DATE,ENC
 ;validate the PSR fields
 S X=$G(DATA("PSR")) I X="" S RET=$$ERR(3) Q
 I +X=0 S RET=$$ERR(4,"Transaction ID") Q
 I +X<0,$P(X,U,5)'="A" S RET=$$ERR(7) Q
 I +X>0,$P(X,U,5)="A" S RET=$$ERR(7) Q
 I +X>0 S IENS=$$GET(+X) I IENS="" S RET=$$ERR(4,"Transaction ID") Q
 D CNVT^DSICDT(.EDT,$P(X,U,2),"E","F") I $P(EDT,U)="ERR"!(EDT="") S RET=$$ERR(4,"Exam date") Q
 S Z(.13)=EDT
 S PROV=""
 S ENC=$G(DATA("ENC")) I ENC S PROV=$$GET1^DIQ(228.1,ENC,.07,"I")
 I PROV="" S PROV=$P(X,U,3) S:'PROV PROV=DUZ
 D PROV^DENTVRP1(.Y,PROV) I +Y<0 S RET=$$ERR(4,$P(Y,U,2)) Q
 S Z(.03)=PROV
 I $P(X,U,4)'?1.17E S RET=$$ERR(4,"PSR Score") Q
 S Z(3.01)=$P(X,U,4)
 I $P(X,U,5)="A" S Z(.28)=1 D ADD($G(DATA("ENC")),3) I +$G(RET)<0 Q
 ;update the PSR record
 S RET=$$FILE($P(X,U,5))
 Q
 ;
PER(RET,DATA) ; RPC: DENTV TP FILE PERIO
 ;  rpc to file (add/update) PSR data
 ;  RET = -1^error message  or  ien^message
 ;  DATA - required - format of input DATA
 ;  DATA("ENC") = DentalEncounterIFN
 ;  DATA("PER") = txn id^exam num^exam date^prov id^STATUS (A/U)
 ;  DATA(n)     = 200 chars of Perio data to be applied to word processing field
 ;       n   = number 1-7
 N X,Y,Z,IENS,DE0,EDT,PROV,DATE,FILE,I,DENT,WPRET,ENC
 ;validate the PERIO fields
 S X=$G(DATA("PER")) I X="" S RET=$$ERR(9) Q
 I +X=0 S RET=$$ERR(4,"Transaction ID") Q
 I +X<0,$P(X,U,5)'="A" S RET=$$ERR(7) Q
 I +X>0,$P(X,U,5)="A" S RET=$$ERR(7) Q
 I +X>0 S IENS=$$GET(+X) I IENS="" S RET=$$ERR(4,"Transaction ID") Q
 I $P(X,U,2)'=+$P(X,U,2) S RET=$$ERR(4,"Exam number") Q
 D CNVT^DSICDT(.EDT,$P(X,U,3),"E","F") I $P(EDT,U)="ERR"!(EDT="") S RET=$$ERR(4,"Exam date") Q
 S Z(2.01)=$P(X,U,2),Z(.13)=EDT
 S PROV=""
 S ENC=$G(DATA("ENC")) I ENC S PROV=$$GET1^DIQ(228.1,ENC,.07,"I")
 I PROV="" S PROV=$P(X,U,4) S:'PROV PROV=DUZ
 D PROV^DENTVRP1(.Y,PROV) I +Y<0 S RET=$$ERR(4,$P(Y,U,2)) Q
 S Z(.03)=PROV
 I $P(X,U,5)="A" S Z(.28)=1 D ADD($G(DATA("ENC")),2) I +$G(RET)<0 Q
 ;update the PERIO record
 S RET=$$FILE($P(X,U,5))
 I +RET<0 Q
 S IENS=+RET
 ;DATA(8) would be from P45 gui (has perio nulls)
 I $D(DATA(8)) D
 .K DENT S DENT(1)=$G(DATA(1)),WPRET=$$FILEWP(2.3) ;4.13.05 file perionullshex P45
 .I +WPRET<0 S RET=WPRET Q
 .K DENT F I=2:1:8 S:$G(DATA(I))]"" DENT(I-1)=$G(DATA(I))
 .S WPRET=$$FILEWP(2.1)
 .Q
 ;no DATA(8) is from P43 gui (no perio nulls passed in)
 I '$D(DATA(8)) D
 .K DENT F I=1:1:8 S:$G(DATA(I))]"" DENT(I)=$G(DATA(I))
 .S WPRET=$$FILEWP(2.1)
 .Q
 I +WPRET<0 S RET=WPRET
 Q
 ; 
HNC(RET,DATA) ; RPC: DENTV TP FILE HNC
 ;  rpc to file (add/update/delete) Head & Neck data
 ;  RET(n) = -1^error message or ien^message
 ;  DATA - required - formay of input DATA
 ;  DATA("ENC") = DentalEncounterIFN (reqd if Add, optnl if Upd/Del)
 ;  DATA(n) = txn id^provider^Xcoord^Ycoord^LesionDt^Color^Shape^size^
 ;                        deleted^master^link^result^readonly^STATUS (A/U/D)^History
 ;  DATA(n) = WP^text
 ;       n = integer value
 N INUM,X,Y,Z,IENS,DE,DE0,EDT,PROV,DATE,SAVE,T,DENT,WP,CNT,I
 ;loop through the DATA array and validate the HNC fields
 S INUM=0,CNT=0,DE=$G(DATA("ENC")) K DATA("ENC")
 F  S INUM=$O(DATA(INUM)) Q:INUM=""  S X=$G(DATA(INUM)) K Z D
 .I X="" S RET(INUM)=$$ERR(8) Q
 .I $P(DATA(INUM),U)="WP" S CNT=CNT+1,WP(CNT)=$P(DATA(INUM),U,2) Q
 .I $D(WP)=10 D WP S CNT=0 K WP
 .I +X=0 S RET(INUM)=$$ERR(4,"Transaction ID") Q
 .I +X<0,$P(X,U,14)'="A" S RET(INUM)=$$ERR(7) Q
 .I +X>0,$P(X,U,14)="A" S RET(INUM)=$$ERR(7) Q
 .I +X>0 S IENS=$$GET(+X) I IENS="" S RET(INUM)=$$ERR(4,"Transaction ID") Q
 .;check for delete status, if set, then go ahead and file without validating other fields
 .I $P(X,U,14)="D" S Z(.23)=1,RET(INUM)=$$FILE($P(X,U,14)) Q
 .S PROV=""
 .I $P(X,U,15)=-1 S Z(4.2)=1 ;Patch 59 History Only addition
 .I DE S PROV=$$GET1^DIQ(228.1,DE,.07,"I")
 .I PROV="" S PROV=$P(X,U,2) S:'PROV PROV=DUZ
 .D PROV^DENTVRP1(.Y,PROV) I +Y<0 S RET(INUM)=$$ERR(4,$P(Y,U,2)) Q
 .S Z(.03)=PROV
 .I $P(X,U,3)'=+$P(X,U,3)!($P(X,U,4)'=+$P(X,U,4)) S RET(INUM)=$$ERR(4,"X and/or Y coord") Q
 .S Z(4.01)=$P(X,U,3),Z(4.02)=$P(X,U,4)
 .K EDT D CNVT^DSICDT(.EDT,$P(X,U,5),"E","F")
 .I $P(EDT,U)="ERR"!(EDT="") S RET(INUM)=$$ERR(4,"Lesion date") Q
 .S Z(.13)=EDT
 .I $P(X,U,6)'=+$P(X,U,6)!($P(X,U,7)'=+$P(X,U,7)) S RET(INUM)=$$ERR(4,"Color and/or Shape") Q
 .S Z(4.03)=$P(X,U,6),Z(4.04)=$P(X,U,7)
 .S Y=$P(X,U,8) I +Y=Y S Y=$O(^DENT(228.3,"E",6,Y,0)) I Y="" S RET(INUM)=$$ERR(4,"Marker size") Q
 .S Z(4.05)=Y,Z(4.07)=-$P(X,U,10),Z(4.09)=-$P(X,U,12)
 .S:Z(4.09)="" Z(4.09)=0
 .S Z(4.08)=""
 .;validate the link id (link to master txn)
 .I $P(X,U,11)'="",$P(X,U,11)'=0 D  I +$G(RET(INUM))<0 Q
 ..I $P(X,U,11)>0 S Z(4.08)=$O(^DENT(228.2,"B",+$P(X,U,11),0))
 ..I $P(X,U,11)<0 S Z(4.08)=$G(T($P(X,U,11)))
 ..I Z(4.08)="" S RET(INUM)=$$ERR(4,"Link to Master record")
 ..Q
 .I $P(X,U,14)="A" S Z(.28)=1 K SAVE M SAVE=RET D ADD(DE,4) I +$G(RET)<0 D  Q
 ..;get rid of the unsubscripted RET variable when there's an Add error
 ..S SAVE(INUM)=RET K RET M RET=SAVE
 ..Q
 .;update the HNC record
 .S RET(INUM)=$$FILE($P(X,U,14)) I +RET(INUM)>0 S T(+X)=+RET(INUM)
 .Q
 I $D(WP)=10 D WP ; catch the last description field
 ;combine the good filing messages into one message
 S CNT=0 F I=0:0 S I=$O(RET(I)) Q:'I  I +$G(RET(I))>0 S CNT=CNT+1 K RET(I)
 I CNT S RET(0)="1^"_CNT_" transaction"_$S(CNT>1:"s",1:"")_" successfully filed"
 Q
WP ;HNC WP field
 Q:'$G(IENS)  N Z,DENT,I
 S I=$O(RET(999),-1) ;get last return node
 Q:+RET(I)<0  ;don't file WP if main node didn't file
 M DENT=WP S Z=$$FILEWP(4.1)
 I +Z<1 S RET($O(RET(INUM),-1))=Z_" Description field error"
 Q
 ;
ADD(ENC,TYPE) ; validate and retrieve extra fields to be updated
 ; common data to be added to new PSR, Perio and HNC records
 ; validate the encounter id
 S Z(1.15)=ENC I Z(1.15)="" S RET=$$ERR(1) Q
 S DE0=$G(^DENT(228.1,Z(1.15),0)) I DE0="" S RET=$$ERR(2) Q
 S Z(.02)=$P(DE0,U,2)
 ; create a new stub record in file 228.2
 S DATE=$E($$NOW^XLFDT,1,12)
 S IENS=$$TRANID^DENTVRF0(228.2) I IENS<1 S RET=$$ERR(5) Q
 S Z(.29)=TYPE
 Q
 ;
ERR(X,MESS) ;  error messages from this routine - expects X=1,2,3 etc
 ;;Dental Encounter not sent
 ;;Dental Encounter record not found (file 228.1)
 ;;PSR data not sent
 ;;Invalid input data:
 ;;Unable to create Transaction record (file 228.2)
 ;;Unable to find internal status (file 228.3)
 ;;Status and Transaction ID do not match
 ;;Not enough HNC data sent to process request
 ;;Not enough Perio data sent to process request
 S X="-1^"_$P($T(ERR+X),";",3)
 S:$G(MESS)]"" X=X_" "_MESS
 Q X
 ;
DIK N DA,DD,DO,DIK
 S DA=I,DIK="^DENT(228.2," I $D(^DENT(228.2,DA)) D ^DIK
 Q
FILE(STATUS) ;  file data - return ien or -1
 ;  we're always filing data (rather than using UPDATE^DIE to create) 
 ;  because the call to TRANID^DENTVRF0 adds the new txn stub record
 ;  expects Z(field#)=value, IENS=internal entry#
 N DENT,DENTERR,I
 L +^DENT(228.2,+IENS):2 E  S I=IENS D DIK Q "-1^Unable to lock file 228.2"
 S IENS=IENS_","
 M DENT(228.2,IENS)=Z
 D FILE^DIE(,"DENT","DENTERR") L -^DENT(228.2,+IENS)
 I $D(DENTERR) S I=+IENS D DIK Q "-1^"_$$MSG^DSICFM01("VE",,,,"DENTERR")
 Q +IENS_"^Record "_$S(STATUS="A":"added",STATUS="D":"marked as deleted",1:"updated")
 ;
FILEWP(SUBFLD) ;  file word processing data - return ien or -1
 ;  expects DENT(1-5)=wp data array, IENS=internal entry#
 N DENTERR,I,X
 L +^DENT(228.2,+IENS):2 E  S I=IENS D DIK Q "-1^Unable to lock file 228.2 to add Word Processing data"
 S:'(IENS[",") IENS=IENS_","
 D WP^DIE(228.2,IENS,SUBFLD,,"DENT","DENTERR") L -^DENT(228.2,+IENS)
 I $D(DENTERR) S I=+IENS D DIK Q "-1^"_$$MSG^DSICFM01("VE",,,,"DENTERR")
 Q +IENS_"^Word processing filed"
 ;
GET(ID) ;  return ien for transaction ID or return <null> if not found
 Q $S($G(ID)="":"",1:$O(^DENT(228.2,"B",ID,0)))
 ;
