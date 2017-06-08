VEJDWPZ ;TPA/SGM - ENVIRONMENT CHECK FOR KIDS ;07/18/2000 21:44
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;  This routine is invoked by the environment check phase of the KIDS
 ;  process for the DSS CORE RPCS package.
 G L1
 ;
L1 ;  clean up package file for any previous VEJD entries
 ;  There must be only one entry in the PACKAGE file for KIDS to work 
 ;  properly
 Q:XPDENV'=1
 N I,II,J,X,Y,Z,VEJD,DA,DIK,DD,DO,NAME,ERR,DIERR,VER
 S X=$P($T(VEJDWPZ+1),";",3,4),NAME=$P(X,";",2),VER=$P(X,";"),DA=0
 Q:VER>1.32  S DIK="^DIC(9.4,"
 ;  delete any duplicate package file entries
 F  S DA=$O(^DIC(9.4,"C","VEJD",DA)),X=$O(^(DA)) Q:'DA!'X  D
 .I '$D(^DIC(9.4,DA,0)) K ^DIC(9.4,"C","VEJD",DA)
 .E  D ^DIK
 .Q
 Q:'DA
 ;  rename package file entry to dba approved name
 S VEJD(9.4,DA_",",.01)=NAME
 L +^DIC(9.4,DA) D FILE^DIE(,"VEJD","ERR") L -^DIC(9.4,DA)
 Q
 ;
 ;  This post install will verify the current version field in the
 ;  Package file for the VEJD entry is set to the version number of
 ;  this routine.
POST ;;13;CURRENT VERSION field number
 N IEN,FDA,VER,DIERR,ERR,FLD,I,J,K,X,Y,Z
 S FLD=$P($T(POST),";",3),VER=$P($T(VEJDWPZ+1),";",3)
 S IEN=$$FIND1^DIC(9.4,,"X","VEJD","C",,"ERR") Q:'IEN  S IEN=IEN_","
 Q:$$GET1^DIQ(9.4,IEN,FLD,"I",,"ERR")'<VER
 S FDA(9.4,IEN,FLD)=VER
 L +^DIC(9.4,+IEN) D FILE^DIE(,"FDA","ERR") L -^DIC(9.4,+IEN)
 Q
