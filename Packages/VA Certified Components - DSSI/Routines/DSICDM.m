DSICDM ;DSS/SGM - DOCMANAGER TO VISTA IMAGING RPCS ;9/5/03  15:08
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;  this routine contains all the RPC tags and the callback routine
 ;  required for the interface to Vista Imaging to import images to
 ;  VistA Imaging
 ;  VIBK = VistA Imaging Background Processor
 ;  6/6/2003/sgm - updated to allow any DSS application to call
 ;  this and not just DocManager.
 ;
 ; DBIA#   SUPPORTED
 ; -----   --------------------------------------
 ;  2052   $$GET1^DID
 ;  2053   ^DIE: FILE,UPDATE
 ; 10013   ^DIK, IX1^DIK
 ; 10014   EN^DIU2
 ; 10103   $$NOW^XLFDT
 ; 10104   $$UP^XLFSTR
 ;
CALLBK(DSIC) ;  callback routine expected by the VistA Imaging
 ;   background processor
 ;  DSIC(0) = status code^message
 ;            where status code=1 if success, else 0
 ;      (1) = tracking id
 ;      (2) = queue number
 ;  (3...n) = warning messages
 N I,J,X,Y,Z,APP,DIERR,DSIA,DSIERR,DSIW,IEN,IENS
 I $G(DSIC(1))="" Q
 ; if 'ien then record does not exist, add it, set iens
 S IEN=+$O(^DSI(19621,"B",DSIC(1),0)) S:IEN IENS=IEN_","
 I 'IEN D  Q:'$G(IENS)
 .S X=DSIC(1),IENS(1)="",DSIA(19621,"+1,",.01)=X
 .;  get app code from tranid
 .S X=$P(X,";",2),APP=""
 .F I=1:1:$L(X) S Z=$E(X,I) Q:Z'?1U  S APP=APP_Z
 .S:Z="" Z="DM" S DSIA(19621,"+1,",.06)=Z
 .I '$$LOCK(0) Q
 .D UPDATE^DIE(,"DSIA","IENS","DSIERR") D UNLK(0)
 .S X=$G(IENS(1)) K IENS I '$D(DIERR),X S IENS=X_","
 .Q
 S X=$G(DSIC(0)) K DSIA
 I X'="" S DSIA(19621,IENS,.03)=$P(X,U),DSIA(19621,IENS,2)=$P(X,U,2)
 I $G(DSIC(2))]"" S DSIA(19621,IENS,.02)=DSIC(2)
 S X=$$NOW
 I 'IEN S DSIA(19621,IENS,.05)=X,DSIA(19621,IENS,.04)=.5
 S I=2,J=0
 F  S I=$O(DSIC(I)) Q:'I  S J=J+1,DSIW(J,0)=DSIC(I)
 I $D(DSIW) S DSIA(19621,IENS,1)="DSIW"
 I $$LOCK(+IENS) D FILE^DIE(,"DSIA","DSIERR"),UNLK(+IENS)
 Q
 ;
NOW(S) S S=$G(S,0) S:S S=2 Q $E($$NOW^XLFDT,1,12+S)
 ;
STATUS(RETX,TRANID,WHICH,DEL,APP) ;  RPC: DSIC DM GET STATUS
 ;  TRANID - optional
 ;    a. If TRANID is passed, then ignore parameter WHICH
 ;    b. If TRANID not passed, then WHICH determines the statuses
 ;       to be returned
 ;
 ;   WHICH - required if not retrieving status of a single Tranid
 ;     if WHICH = "A" - get all transaction statuses
 ;        WHICH [ "E" - transactions which had errored
 ;        WHICH [ "S" - transactions which were successfully imported
 ;        WHICH [ "P" - transactions which have not yet been
 ;                      processed by the VI background processor
 ;
 ;     DEL - optional - default 0
 ;      if DEL=1 then delete transactions record which were successfully
 ;      imported and whose status was returned by this RPC
 ;
 ;     APP - required for all DSS applications other than DocManager
 ;           this is the code assigned to the app
 ;           only statuses for this app will be returned
 ;  RETURN:
 ;    if error(s) return -1^error message
 ;    else for each tranID return a multiline data of the form
 ;     array[n] = tranID^status
 ;     array[n+j] = message from VistA Imaging where j = 1,2,3,...
 ;     array[n+m] = $END where m is 1 more than the last j
 ;     sorted by status and within status by tranID
 ;
 N I,X,Y,Z,DSIC,STAT,STATUS,TMP,TXT
 S TRANID=$G(TRANID),WHICH=$G(WHICH),DEL=$G(DEL),APP=$G(APP,"DM")
 S:APP="" APP="DM"
 F X="TRANID","WHICH","DEL","APP" S:@X?.E1L.E @X=$$UP^XLFSTR(@X)
 ;I APP="" S @RETX@(1)="-1^No application code received" Q
 S RETX=$NA(^TMP("DSICDM",$J)) K @RETX
 S STATUS(0)="Error",STATUS(1)="Successfully Imported"
 S STATUS(2)="Pending"
 I TRANID="" S X="" D  I X'="" S @RETX@(1)="-1"_U_X Q
 .I WHICH="" S X="No TranID nor status type received" Q
 .I WHICH["A" S WHICH="012" Q
 .S Y="",Z="ESP" F I=1:1:3 I WHICH[$E(Z,I) S Y=Y_(I-1)
 .I Y'="" S WHICH=Y
 .E  S X="Invalid WHICH parameter received: "_WHICH
 .Q
 ;  get single transaction status
 I TRANID]"" D  Q
 .S X=$O(^DSI(19621,"B",TRANID,0))
 .I 'X S @RETX@(1)="-1^TranID "_TRANID_" not found in file" Q
 .S STATUS=$P($G(^DSI(19621,X,0)),U,3)
 .S Z="-1^Record for TranID "_TRANID_" does not have a STATUS code"
 .I "012"[STATUS S Z=TRANID_U_STATUS(STATUS)
 .I STATUS=1,DEL D
 ..D UPD(.TMP,"D",TRANID,,APP)
 ..S:+TMP=1 Z=Z_", record deleted"
 ..Q
 .S @RETX@(1)=Z
 .Q
 ;  get all transactions for statuses
 F I=1:1:$L(WHICH) S STAT=$E(WHICH,I) D
 .F Y=0:0 S Y=$O(^DSI(19621,"AC",STAT,APP,Y)) Q:Y=""  D
 ..S X=$G(^DSI(19621,Y,0)),TRANID=$P(X,U) Q:TRANID=""
 ..S Z=TRANID_U_STATUS(+$P(X,U,3)) K TMP,TXT
 ..F X=0:0 S X=$O(^DSI(19621,Y,1,X)) Q:'X  S TXT(X)=^(X,0)
 ..I STAT=1,DEL D UPD(.TMP,"D",TRANID,,APP)
 ..S:+$G(TMP)=1 Z=Z_", record deleted"
 ..S @RETX@(STAT,TRANID)=Z I $D(TXT) M @RETX@(STAT,TRANID)=TXT
 ..S @RETX@(STAT,TRANID,"A")="$END"
 ..Q
 .Q
 Q
 ;
LOCK(N) N I F I=1,2,3 L +^DSI(19621,N):5 Q:$T
 Q $T
 ;
UNLK(N) L -^DSI(19621,N) Q
 ;
IMPCK(RET) ; RPC: DSIC DM CHECK
 ;  This rpc will check to see if VistA Imaging Import is supported
 ;  As of 7/1/2003 - VI did not support import if the site had
 ;  multiple VistA Imaging servers
 S RET=$$IMP Q
 ;
IMP() ;  check to see if VistA Imaging supports import API
 N X,Y,VER,PATCH
 D VERSION^DSICXPDU(.VER,"MAG")
 ;S VER=$$VERSION^DSICXPDU(.X,"MAG")
 ;S PATCH=$$PATCH^DSICXPDU("MAG*3.0*7")
 D PATCH^DSICXPDU(.PATCH,"MAG*3.0*7")
 I VER>3!PATCH Q 1
 Q "-1^Your VistA Imaging system does not support the import API"
 ;
UPD(RET,ACT,TRANID,QUEUE,APP) ;  RPC: DSIC DM ADD/DELETE QUEUE
 ;  add or delete a record
 ;  updates to existing records done by CALLBK
 ;  REQUIRED parameters for actions:
 ;  For Delete - ACT, TRANID are required
 ;  For Add    - for DocManager - TRANID is required
 ;               for all other DSS apps - APP is required
 ;
 ;   ACT - A for ADD a record, D for delete a record - default = A
 ;
 ;TRANID - transaction id sent to VistA Imaging Import queue
 ;         this must be a unique ID
 ;         For DocManager, required for both Add and Delete
 ;         For other DSS apps, optional will be returned as 3rd piece
 ;
 ; QUEUE - queue number return from VistA Imaging Import API
 ;         optional - mainly required for CYA in case of problems
 ;
 ;   APP - code assigned by Jay for a specific DSS application
 ;         optional for DocManager, required for all other apps
 ;                     
 ; Return - If successful, 1^message^transaction ID
 ;          Else -1^error message
 ;
 N I,X,Y,Z,DA,DIERR,DIK,DSIERR,IEN,DSIC
 S ACT=$G(ACT),TRANID=$G(TRANID),QUEUE=$G(QUEUE),APP=$G(APP,"DM")
 S:APP="" APP="DM"
 ;F Z="ACT","TRANID","QUEUE","APP" S @Z=$G(@Z)
 S X=$$IMP I X<1 S RET=X Q
 ;  QA input values
 S X="" S:ACT="" ACT="A"
 I "AD"'[ACT!(ACT'?1U) S X="Invalid type ["_ACT_"]; "
 I TRANID'="",$E(TRANID,1,4)'="DSS;" S X=X_"Invalid TranID ["_TRANID_"]; "
 I TRANID="" D
 .I ACT="D" S X=X_"No TranID received; "
 .I ACT="A",APP="" S X=X_"No application code received; "
 .Q
 I X'="" S RET="-1^"_X Q
 I ACT="A" D  Q:$D(RET)
 .I '$$LOCK(0) S RET="-1^Unable to lock the file, try again"
 .Q
 ;  check to see if need to create tranID
 I TRANID="" D
 .F  S X="DSS;"_APP_$$NOW(1) Q:'$D(^DSI(19621,"B",X))
 .S TRANID=X
 .Q
 S DA=$O(^DSI(19621,"B",TRANID,0))
 I ACT="D" D  Q
 .I 'DA S RET="-1^No record found for tranID "_TRANID Q
 .I '$$LOCK(DA) S RET="-1^Unable to lock record, try again" Q
 .S DIK="^DSI(19621," D ^DIK,UNLK(DA)
 .S RET="1^Record successfully deleted"
 .Q
 I DA S RET="-1^Record not added as "_TRANID_" already exists" G OUT
 S DSIC(19621,"+1,",.01)=TRANID
 S:QUEUE DSIC(19621,"+1,",.02)=QUEUE
 S DSIC(19621,"+1,",.03)=2
 S DSIC(19621,"+1,",.04)=DUZ
 S DSIC(19621,"+1,",.05)=$$NOW
 S DSIC(19621,"+1,",.06)=APP
 S IEN(1)=""
 D UPDATE^DIE(,"DSIC","IEN","DSIERR") K X,DSIC
 I $G(IEN(1))>0 D
 .I '$D(DIERR) S RET="1^Record successfully added"
 .E  S RET="1^Record added, but problems encountered"
 .S:APP'="DM" $P(RET,U,3)=TRANID
 .Q
 E  S RET="-1^Record not added"
 S:$G(RET)="" RET="-1^Unknown problem encountered"
 I $D(DIERR),$D(DSIERR) S RET=RET_" - "_$$MSG^DSICFM01("VE",,,,"DSIERR")
OUT D UNLK(0)
 Q
 ;
POST ;  post-install from DSIC 1.1
 N X,Y,Z,DA,DD,DO,DIERR,DIK,DIU,DSI,DSIEN,DSIERR,LOOP,OLD,X0
 S X=$$GET1^DID(19606,,,"NAME",,"DSIERR")
 Q:X'="VEJD-VISTA IMAGING QUEUE TRACKING"
 S X=">>> Moving file 19606 to the new file 19621 <<<"
 I '$G(LOOP) D MES^DSICXPDU(X,1)
 F  S DA=$O(^VEJD(19606,0)) Q:'DA  K OLD M OLD=^VEJD(19606,DA) D
 .I $G(OLD(0))="" Q
 .K X,Y,Z,DD,DO,DIERR,DIK,DSI,DIERR
 .S DSIEN=DA
 .S Y(0)=$P(OLD(0),U,1,5)_U_"DM"
 .S:$G(OLD(2))'="" Y(2)=OLD(2)
 .I $D(OLD(1)) M Y(1)=OLD(1) S $P(Y(1,0),U,2)=""
 .F Z=1,2,3 L +^DSI(19621,0):5 Q:$T
 .Q:'$T
 .;  add entry to file 19621
 .S X=1+$O(^DSI(19621,"A"),-1)
 .S $P(^DSI(19621,0),U,3)=X,$P(^(0),U,4)=1+$P(^(0),U,4)
 .M ^DSI(19621,X)=Y
 .L -^DSI(19621,0)
 .;  reindex new entry
 .K DA S DA=X,DIK="^DSI(19621," D IX1^DIK
 .;  delete entry from old file
 .K DA,DIK S DA=DSIEN,DIK="^VEJD(19606," D ^DIK
 .Q
 ;  try to convert record not converted for whatever reason
 I +$O(^VEJD(19606,0)) D  Q:LOOP>5
 .S LOOP=1+$G(LOOP) D POST
 .Q
 D MES^DSICXPDU(">>> Deleting file 19606... <<<",1)
 K DA,DD,DO,DIU S DIU="^VEJD(19606,",DIU(0)="DM" D EN^DIU2
 Q
