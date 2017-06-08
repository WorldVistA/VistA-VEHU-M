DENTVRHD ;TPA/SGM - DELETE DENTAL DATA ;11/24/2003 12:40
 ;;1.2;DENTAL;**31,39,57,59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ; this routine has various entry points to delete dental data
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  --------------------------------------
 ;  2053      x      FILE^DIE
 ; 10013      x      ^DIK
 ; 10103      x      $$FMTE^XLFDT, $$NOW^XLFDT
 ;
DELH(DENT,IEN,REASON) ;  RPC: DENTV DELETE HISTORY ENTRY
 ;  delete a record from file 228.1 and all associated 228.2 entries
 ;  IEN - required - pointer to file 228.1
 ;  Return: 1^message if deleted
 ;          0^message if record already deleted
 ;         -1^message if problems
 ;
 ;  The ADEL xref on DATE DELETED field on file 228.1 will invoke
 ;  a taskman job to mark associated records in file 228.2 as deleted.
 ;
 N X,Y,Z,DENTER,DENTX,DIERR,TP,PAT
 S IEN=+$G(IEN),TP=0
 I 'IEN!'$D(^DENT(228.1,IEN)) S DENT="-1^No record number received" Q
 I $D(^DENT(228.1,IEN,1)) S X=+^(1) I X D  Q
 .S DENT="0^Record already deleted on "_$$FMTE^XLFDT(X)
 .Q
 ;F  S TP=$O(^DENT(228.2,"AG",IEN,TP)) Q:'TP!($P($G(^DENT(228.2,+TP,0)),U,6)&'$P($G(^(1)),U,3))
 ;I TP>0 S DENT="-1^Treatment Plan transactions exist" Q
 S X=IEN_","
 S DENT(228.1,X,1.01)=$$FMTE^XLFDT($E($$NOW^XLFDT,1,12))
 S:$G(REASON)'="" DENT(228.1,X,1.03)=$E(REASON,1,80)
 L +^DENT(228,IEN):2 E  S DENT="-1^Unable to lock record, try again" Q
 D FILE^DIE("ET","DENT","DENTER")
 I '$D(DIERR) S DENT="1^Record "_IEN_" has been deleted" D
 .S PAT=$$GET1^DIQ(228.1,IEN,.02,"I") I PAT D RRUN^DENTVM1(PAT,IEN) ;P57 fluoride monitor
 .Q
 E  S DENT="-1^"_$$MSG^DSICFM01("VE",,,,"DENTER")
 Q
 ;
DELT(DENT,IEN) ; RPC: DENTV DELETE TRANSACTIONS
 ;  If the transaction record type fails to file in 228.2, then delete
 ;  the other types (PSR, HNC, Perio) that might have been loaded
 ;  along with the encounter record in 228.1
 ;  IEN - required - pointer to 228.1
 ;  Return 1^message if successfully deleted, else return -1^message
 ;
 N TP,DA,DD,DO,DIK S TP=0,IEN=+$G(IEN)
 I 'IEN!'$D(^DENT(228.1,IEN)) S DENT="-1^Missing or invalid record number" Q
 F  S TP=$O(^DENT(228.2,"AG",IEN,TP)) Q:'TP  D
 .S DA=TP,DIK="^DENT(228.2," I $D(^DENT(228.2,DA)) D ^DIK
 .Q
 S DA=IEN,DIK="^DENT(228.1," D ^DIK
 S DENT="1^Records deleted"
 Q
DELU(DENT,DATA) ; RPC: DENTV DELETE UNFILED DATA - Added Patch 59
 ;  Delete records in 228.7 for unfiled data no longer needed
 ;  DATA - Array of IENS of records in 228.7 to be deleted
 ;   i.e. DATA(IEN) - where IEN is 50
 ;  Return DENT(IEN)=0^Filed record deleted
 ;         
 N IEN,DA,DD,DO,DIK
 S DIK="^DENT(228.7,"
 S IEN=0 F  S IEN=$O(DATA(IEN)) Q:'IEN  D
 .S DA=IEN I $D(^DENT(228.7,IEN)) D ^DIK S DENT(IEN)="0^File record deleted"
 Q
