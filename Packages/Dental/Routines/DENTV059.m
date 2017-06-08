DENTV059  ;DSS/BD - Post init DENTAL Patch 59 ;12/04/2009 9:41
 ;;1.2;DENTAL;**59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  -----------
 ; 10070      x       ^XMD
 ;                    FILE^DIE
 ;                    EN^DIU2
 ;                    WP^DIE
 ;                    HOME^%ZIS
 ;                    DT^DICRW
 ;                    GETWP^DSICXPR
 ;                    GET1^DIQ
 ;                    UPDATE^DIE
 ;                    CPT^DSICCPT
 ;                    MES^DSICXDPU
 ;                    CHGWP^DSICXPR
 ;                    MULT^DSICXPR
 Q
PRE ; Deletes DDs for 228.2, 228.7, and 227
 ;delete 228.2 DD
 I $$VFILE^DSICFM06(,228.2,1)>0 D MSG("Deleting DD for file 228.2") D
 .N DIU S DIU=228.2,DIU(0)="" D EN^DIU2
 .Q
 ;delete 228.7 DD
 I $$VFILE^DSICFM06(,228.7,1)>0 D MSG("Deleting DD for file 228.7") D
 .N DIU S DIU=228.7,DIU(0)="" D EN^DIU2
 .Q
 Q
POST ;
 ;
 ;Queue off visit date fix
 N M S M(1)=" This part of the post-install will be queued, but may "
 S M(2)=" take some time to run. It loops through 228.2 looking for "
 S M(3)=" records that were undeleted in P57 and corrects the visit "
 S M(4)=" date if the record is missing one."
 D MES^DSICXPDU(.M,1)
 D TASK ; Task off repairing Visit dates
 ;
 D PARAM ;Make changes to parameters for P59
 D MSG("Updated DENTV TP NOTE OBJECTS and DENTV TP NOTE SEQUENCE")
 Q
RESET ;loop through #228.2, find encounter in DENTAL HISTORY (#228.1)
 ;find VISIT (field .05), if defined, use .01 from 9000010, else use Create Date
 N IEN,EIEN,VIEN,VISDT
 S IEN=0 F  S IEN=$O(^DENT(228.2,IEN)) Q:'IEN  D
 .I $P($G(^DENT(228.2,IEN,1)),U,5) Q  ;visit date exists
 .S EIEN=0,VIEN=0,VISDT=+$G(^DENT(228.2,IEN,1)) ;default to create date
 .S EIEN=$P($G(^DENT(228.2,IEN,1)),U,15)
 .I EIEN S VIEN=$P($G(^DENT(228.1,EIEN,0)),U,5)
 .I VIEN S VISDT=$$GET1^DIQ(9000010,VIEN,.01,"I") ;use visit date if exists
 .K DENT S DENT(228.2,IEN_",",1.05)=VISDT D FILE^DIE(,"DENT")
 .Q
 Q
MSG(X) ;
 S X="   >> "_X_" <<"
 D MES^DSICXPDU(X,1)
 Q
TASK ; Create a queued task to perform visit date fix caused
 ; in P57 when undeleting transactions
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 I '$D(XPDNM) D  Q:'X
 .I $G(DUZ)<.5 W !!,"Please sign on properly through the Kernel" S X=0
 .E  D HOME^%ZIS,DT^DICRW S X=1
 .Q
 S ZTIO="",ZTDTH=$H,ZTRTN="RESET^DENTV059",ZTDESC="DENTV PATCH 59 POST-INSTALL"
 D ^%ZTLOAD S X="Patch 59 post-install successfully queued, task# "_$G(ZTSK)
 I $G(ZTSK) D MSG(X)
 I '$G(ZTSK) D MSG("Could not queue the Post-Install!"),MSG("Enter a Dental Remedy ticket.")
 Q
PARAM ;
 ;DENTV DRM NOTE WIDTH
 N RET,N
 ;D CHG^DSICXPR(.RET,"SYS~DENTV DRM NOTE WIDTH~~70")
 ;I 'RET D MSG("Error updating DENTV DRM NOTE WIDTH"),MSG("Enter a Dental Remedy ticket.")
 K RET
 ;DENTV TP NOTE OBJECTS/NOTE SEQUENCE
 N PARM,II,TYP,RET,III,FLG,DNT,PROV,CHK
 S PARM="DENTV TP NOTE SEQUENCE",II="0",FLG=1,CHK=0
 F TYP="SYS","PKG" K DNT,RET S FLG=1 D
 .D GETWP^DSICXPR(.RET,TYP_"~"_PARM_"~")
 .I $D(RET)=10 D
 ..S III="0" F  S III=$O(RET(III)) Q:'III  D
 ...I RET(III)'="TEXT MARKER" S DNT(FLG)=RET(III),FLG=FLG+1
 ..I $D(DNT(FLG)) S FLG=FLG+1
 ..S CHK=$$PARCHK("OHA FINDINGS") I 'CHK D
 ...S DNT(FLG)="OHA FINDINGS",FLG=FLG+1
 ..S CHK=$$PARCHK("OCCLUSAL FINDINGS") I 'CHK D
 ...S DNT(FLG)="OCCLUSAL FINDINGS",FLG=FLG+1
 ..S CHK=$$PARCHK("PARAFUNCTIONAL HABITS") I 'CHK D
 ...S DNT(FLG)="PARAFUNCTIONAL HABITS",FLG=FLG+1
 ..S CHK=$$PARCHK("TMJ FINDINGS") I 'CHK D
 ...S DNT(FLG)="TMJ FINDINGS",FLG=FLG+1
 ..S CHK=$$PARCHK("SOCIAL HISTORY") I 'CHK D
 ...S DNT(FLG)="SOCIAL HISTORY",FLG=FLG+1
 ..I $D(DNT) D CHGWP^DSICXPR(.RET,TYP_"~"_PARM_"~",.DNT)
 ;
 K DNT,RET S FLG=1,III=1,II=0,PROV=0
 F  S II=$O(^DENT(220.5,"B",II)) Q:'II  D
 .S PROV(III)=II,III=III+1
 S III=0,II=0 F  S III=$O(PROV(III)) Q:'III  D
 .S TYP="USR.`"_PROV(III)
 .I $D(RET) K RET
 .D GETWP^DSICXPR(.RET,TYP_"~"_PARM_"~")
 .I $D(RET)=10 S RET=1
 .I +RET=1 D
 ..K DNT S FLG=1
 ..S II=0 F  S II=$O(RET(II)) Q:'II  D
 ...I RET(II)'="TEXT MARKER" S DNT(FLG)=RET(II),FLG=FLG+1
 ..I $D(DNT(FLG)) S FLG=FLG+1
 ..S CHK=$$PARCHK("OHA FINDINGS",.RET) I 'CHK D
 ...S DNT(FLG)="OHA FINDINGS",FLG=FLG+1
 ..S CHK=$$PARCHK("OCCLUSAL FINDINGS") I 'CHK D
 ...S DNT(FLG)="OCCLUSAL FINDINGS",FLG=FLG+1
 ..S CHK=$$PARCHK("PARAFUNCTIONAL HABITS") I 'CHK D
 ...S DNT(FLG)="PARAFUNCTIONAL HABITS",FLG=FLG+1
 ..S CHK=$$PARCHK("TMJ FINDINGS") I 'CHK D
 ...S DNT(FLG)="TMJ FINDINGS",FLG=FLG+1
 ..S CHK=$$PARCHK("SOCIAL HISTORY") I 'CHK D
 ...S DNT(FLG)="SOCIAL HISTORY",FLG=FLG+1
 ..I $D(DNT) D CHGWP^DSICXPR(.RET,TYP_"~"_PARM_"~",.DNT)
 ;
 ;Setup Note Objects for new modals
 ;
 K DNT,RET,III,II,TYP N DNT,RET,AYZ
 F TYP="SYS","PKG" K AYZ D
 .D GET^DSICXPR(.AYZ,TYP_"~DENTV TP NOTE OBJECTS~")
 .I $P(AYZ(1),U)'=-1 D
 ..S DNT(1)=TYP_"~DENTV TP NOTE OBJECTS~OHA FINDINGS~1;0;1;0~~~"
 ..S DNT(2)=TYP_"~DENTV TP NOTE OBJECTS~OCCLUSAL FINDINGS~1;0;1;0~~~"
 ..S DNT(3)=TYP_"~DENTV TP NOTE OBJECTS~PARAFUNCTIONAL HABITS~1;0;1;0~~~"
 ..S DNT(4)=TYP_"~DENTV TP NOTE OBJECTS~TMJ FINDINGS~1;0;1;0~~~"
 ..S DNT(5)=TYP_"~DENTV TP NOTE OBJECTS~SOCIAL HISTORY~1;0;1;0~~~"
 ..S DNT(6)=TYP_"~DENTV TP NOTE OBJECTS~TEXT MARKER~~~~DEL"
 ..D MULT^DSICXPR(.RET,.DNT)
 S II=0 F  S II=$O(PROV(II)) K DNT Q:'II  D
 .K AYZ D GET^DSICXPR(.AYZ,"USR.`"_PROV(II)_"~DENTV TP NOTE OBJECTS~")
 .I $P(AYZ(1),U)'=-1 D
 ..S DNT(1)="USR.`"_PROV(II)_"~DENTV TP NOTE OBJECTS~OHA FINDINGS~1;0;1;0~~~"
 ..S DNT(2)="USR.`"_PROV(II)_"~DENTV TP NOTE OBJECTS~OCCLUSAL FINDINGS~1;0;1;0~~~"
 ..S DNT(3)="USR.`"_PROV(II)_"~DENTV TP NOTE OBJECTS~PARAFUNCTIONAL HABITS~1;0;1;0~~~"
 ..S DNT(4)="USR.`"_PROV(II)_"~DENTV TP NOTE OBJECTS~TMJ FINDINGS~1;0;1;0~~~"
 ..S DNT(5)="USR.`"_PROV(II)_"~DENTV TP NOTE OBJECTS~SOCIAL HISTORY~1;0;1;0~~~"
 ..S DNT(6)="USR.`"_PROV(II)_"~DENTV TP NOTE OBJECTS~TEXT MARKER~~~~DEL"
 ..D MULT^DSICXPR(.RET,.DNT)
 ;F N=1:1:5 D
 ;.I $P($G(RET(N)),U,8)=-1 D MSG($P($G(RET(N)),U,9))
 ;.I $P($G(RET(N)),U,8)=1 D MSG($P($G(RET(N)),U,2)_"~"_$P($G(RET(N)),U,3)_"~"_$P($G(RET(N)),U,4)_" UPDATED")
 ;Default new DENTV EXAM REQUIREMENT DISPLAY system parameter to 1 (on)
 N RET1,PARM S PARM="SYS~DENTV EXAM REQUIREMENT DISPLAY~1~1" D ADD^DSICXPR(.RET1,PARM)
 Q
PARCHK(TEXT,DATA) ;
 ;
 N NUM,XYZ S XYZ=0
 S NUM=0 F  S NUM=$O(RET(NUM)) Q:'NUM!XYZ  D
 .I $P(RET(NUM),U)=TEXT S XYZ=1
 I XYZ Q 1
 Q 0
