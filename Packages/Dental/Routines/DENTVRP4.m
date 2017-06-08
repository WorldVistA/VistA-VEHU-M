DENTVRP4 ;DSS/SGM - RPC CALLS FOR DSS DENTAL ;07/26/2003 07:50
 ;;1.2;DENTAL;**30,32,31,42,43**;Aug 10, 2001
 ;Copyright 1995-2005, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  --------------------------------
 ;  2053      x      UPDATE^DIE
 ; 10103      x      ^XLFDT: $$FMADD, $$NOW
 ;
NON(RET,DATA) ;  RPC: DENTV FILE ADMIN TIME
 ;  DATA - required - p1^p2^p3^p4
 ;    p1 = duz (pointer to file 200 - must also be in 220.5)
 ;    p2 = single character (A)dmin, (F)ee, (E)duc/train, (R)esearch
 ;    p3 = hour.min
 ;    p4 = division name from file 225
 ;  RETURN: 1^message or -1^message
 ;
 N X,Y,Z,DENT,DENT0,DENTER,DIERR,IEN,MIN,PROV,TIME
 S PROV=$$DPRV^DENTVUTL(+DATA),DENT0=$G(^DENT(220.5,+PROV,0))
 I 'PROV D ERR(1) Q
 I $P(DENT0,U,3) D ERR(2) Q
 S Z(.06)=+PROV ;new Provider Id field KC/p42
 S Z(.3)=$P(DATA,U,4)
 S Z(.6)=$P(DATA,U,2)
 S Z(.9)=$P(DATA,U,3)
 I Z(.6)'?1U!("ARFE"'[Z(.6)) D ERR(3) Q
 S TIME=Z(.9),MIN=$P(TIME,".",2)
 I TIME<.25!(TIME>49.75)!("^^25^5^75^"'[(U_MIN_U)) D ERR(4) Q
 S PTYP=+$E($P(DENT0,U,4),1,2)
 I PTYP S Y=$$GET1^DIQ(220.51,PTYP_",",.04) I Y="","AF"[Z(.6) D ERR(5) Q
 S Z(.4)=$P(DENT0,U,2),Y=+$E(Z(.4)) I 'PTYP,Y,12'[Y,"AF"[Z(.6) D ERR(5) Q
 I $S(Z(.3)="":1,1:'$O(^DENT(225,"B",Z(.3),0))) D ERR(6) Q
 L +^DENT(226,0):2 E  D ERR(7) Q
 M DENT(226,"+1,")=Z
 S X=$$NOW^XLFDT F  Q:'$D(^DENT(226,"B",X))  S X=$$FMADD^XLFDT(X,,,,1)
 S IEN(1)=9999999-X,DENT(226,"+1,",.01)=X
 D UPDATE^DIE(,"DENT","IEN","DENTER") L -^DENT(226,0)
 I '$D(DIERR) S RET="1^Record successfully added"
 E  S RET="-1^"_$$MSG^DSICFM01("VE",,,,"DENTER")
 Q
 ;
ERR(X,Y,Z) ;  error meesages from this routine - expects X=1,2,3,4,5,6....
 ;;Provider not found in Dental Provider file (225)
 ;;Provider not marked as active in Dental Provider file (225)
 ;;Non clinical time category (R,A,E,F) is not correct
 ;;Non clinical time (hr.min) is incorrect
 ;;Only dentists may enter non clin time spent in admin or fee categories
 ;;Invalid station.division name
 ;;Unable to lock file 226 - try again later
 S X=$P($T(ERR+X),";",3) S:$G(Y)'="" X=X_Y
 I $G(Z) S RET(1)="-1^"_X
 E  S RET="-1^"_X
 Q
 ;
 ;  --------------------  OLD CODE PRE PATCH 31  --------------------
 ;  The code below is not invoked since patch 31.  It was kept here
 ;  in anticipation that a future patch may resue some of this code.
 ;  -----------------------------------------------------------------
 ;
DEL(RET,IEN) ;  RPC to delete all data in history file, das, and pce
 ;  this is dead code at this time - may be reused later
 ;  associated with history record number IEN
 ;  RET - return RET(1)=1^message if successfully deleted all
 ;        else return RET(n)=-1^error messages for n=1,2,3,...
 ;
 N I,J,X,X0,Y,Z,CPT,DA,DD,DO,DAS,DATA,DENT,DIERR,DIK,ERR,ICD,MSG,PCE
 N PKG,SOURCE,VISIT,ERRFLG
 S IEN=+$G(IEN)
 I '$D(^DENT(228.1,IEN,0))!'IEN D ERR(9) Q
 M DATA(228.1)=^DENT(228.1,IEN)
 I $S($$KEY:0,1:$P(DATA(228.1,0),U,7)'=DUZ) D ERR(18,IEN) Q
 S DAS=+$P(DATA(228.1,0),U,6),VISIT=+$P(DATA(228.1,0),U,5)
 I DAS,$D(^DENT(221,DAS,0)) M DATA(221)=^DENT(221,DAS)
 I VISIT D  Q:$D(RET)
 .S PKG=$$PKG^DENTVUTL
 .I 'PKG D ERR(15) S X=RET K RET S RET(1)=X Q
 .S SOURCE="DENTV DSS GUI"
 .S DENT("ENCOUNTER",1,"ENC D/T")=$P(^AUPNVSIT(VISIT,0),U)
 .S DENT("ENCOUNTER",1,"PATIENT")=$P(DATA(228.1,0),U,2)
 .S DENT("ENCOUNTER",1,"HOS LOC")=$P(DATA(228.1,0),U,11)
 .S DENT("ENCOUNTER",1,"SERVICE CATEGORY")="A"
 .S DENT("ENCOUNTER",1,"ENCOUNTER TYPE")="P"
 .S DENT("ENCOUNTER",1,"DELETE")=1
 .S DENT("PROVIDER",1,"NAME")=$P(DATA(228.1,0),U,7)
 .S DENT("PROVIDER",1,"DELETE")=1
 .F I=0:0 S I=$O(DATA(228.1,1,I)) Q:'I  S X0=DATA(228.1,1,I,0) D
 ..Q:$P(X0,U,13)'="y"  ;  did not file to PCE
 ..F J=7:1:11 S X=$P(DATA(228.1,0),U,J) I X,'$D(ICD(X)) S ICD(X)=""
 ..S X=$P(DATA(228.1,0),U,3) S:X CPT(X)=1+$G(CPT(X))
 ..Q
 .S (I,X)=0 F  S X=$O(ICD(X)) Q:'X  S I=I+1 D
 ..S DENT("DX/PL",I,"DIAGNOSIS")=X
 ..S DENT("DX/PL",I,"DELETE")=1
 ..Q
 .S (I,X)=0 F  S X=$O(CPT(X)) Q:'X  S I=I+1 D
 ..S DENT("PROCEDURE",I,"PROCEDURE")=X
 ..S DENT("PROCEDURE",I,"QTY")=CPT(X)
 ..S DENT("PROCEDURE",I,"DELETE")=1
 ..Q
 .S X=VISIT K VISIT S VISIT(1)=X
 .S PCE=$$DATA2PCE^PXAPI("DENT",PKG,SOURCE,.VISIT,DUZ)
 .I PCE<1 S Z=0 D
 ..F I=0:0 S I=$O(DENT("DIERR",I)) Q:'I  S J=0 D
 ...F  S J=$O(DENT("DIERR",I,"TEXT",J)) Q:'J  D
 ....S X=DENT("DIERR",I,"TEXT",J)
 ....Q:$E(X,1,4)="TO: "  Q:X?." "
 ....I X?1"Calling Package".E S J="A" Q
 ....S Z=Z+1,RET(Z)="-1^"_X
 ....Q
 ...S Z=Z+1,RET(Z)="-1^"
 ...Q
 ..Q
 .Q
 I DAS S DA=DAS,DIK="^DENT(221," D ^DIK
 K DA,DIK S DA=IEN,DIK="^DENT(228.1," D ^DIK
 S X=1_U
 I DAS S X=X_"DAS entry "_$$FMTE^XLFDT(9999999-DATA(221,0))_"; "
 S X=X_"Dental History record "_IEN_"; "
 I $G(PCE)>0 S X=X_" associated PCE data "
 S RET(1)=X_"deleted"
 Q
 ;
KEY() Q $D(^XUSEC("DENTV DELETE ENTRY",DUZ))
 ;
TIU(RET,IEN,NOTE) ;  RPC to file TIU note pointer to file 228.1
 ;  this code is dead, it is not invoked at this time
 ;  IEN - required - pointer to file 228.1
 ; NOTE - required - pointer to file 8925 (tiu document)
 ;  RET - return value = 1 if successful, else return -1^error message
 ;
 N X,X0,Y,Z,DENT,DIERR,ERR
 S IEN=+$G(IEN),NOTE=+$G(NOTE)_","
 I NOTE D GETS^DIQ(8925,NOTE,".02;.03","I","DENT","ERR")
 I $D(DIERR)!'NOTE S X=11 G ERR
 S X0=$G(^DENT(228.1,IEN,0)) I X0=""!'IEN S X=9 G ERR
 I DENT(8925,NOTE,.02,"I")'=$P(X0,U,2) S X=12 G ERR
 I $P(X0,U,3),DENT(8925,NOTE,.03,"I")'=$P(X0,U,3) S X=13 G ERR
 K DENT S DENT(228.1,IEN_",",7)=+NOTE
 L +^DENT(228.1,IEN) D FILE^DIE(,"DENT","ERR") L -^DENT(228.1,IEN)
 I $D(DIERR) S X=14 G ERR
 S RET=1
 Q
 ;
OLDERR ;  error meesages from this routine - expects X=1,2,3,4,5,6....
 ;  ERRFLG - optional - I $G(ERRFLG) then set RET(1), else set RET
 I X=1 S X="Provider not found in Dental Provider file (225)"
 I X=2 S X="Provider not marked as active in Dental Provider file (225)"
 I X=3 S X="Non clinical time category (R,A,E,F) is not correct"
 I X=4 S X="Non clinical time (hr.min) is incorrect"
 I X=5 S X="Only dentists may enter non clin time spent in admin or fee categories"
 I X=6 S X="Invalid station.division name"
 I X=7 S X="Unable to lock file 226 - try again later"
 I X=8 S X="Unable to create a new record for administative time"
 I X=9 S X="Invalid Dental History record number received"
 I X=10 S X="Dental History record not deleted - problems encountered"
 I X=11 S X="Invalid TIU record number received"
 I X=12 S X="The patient for the dental history record does not match the patient associated with the TIU note"
 I X=13 S X="The VISIT associated with the dental history record and TIU note do not match"
 I X=14 S X="Error encountered while filing note to history file"
 I X=15 S X="No Dental PACKAGE file entry found to use in PCE"
 I X=16 S X="No VISIT record number received"
 I X=17 S X="No Dental History records found with VISIT="_VISIT
 I X=18 S X="You are not authorized to delete record# "_IEN
 I $G(ERRFLG) S RET(1)="-1^"_X
 E  S RET="-1^"_X
 Q
