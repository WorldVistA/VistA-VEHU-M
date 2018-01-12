DENTV066 ;DSS/AJ - DENTAL Install Patch 66;10/1/2013 9:12
 ;;1.2;DENTAL;**66**;Aug 10, 2001;Build 36
 ;Copyright 1995-2013, Document Storage Systems, Inc., All Rights Reserved
 ;
 Q
PRE ;Pre-install Routine
 D SAVE^DENTVIP1
 I $$VFILE^DSICFM06(,228,1)>0 D MSG("Deleting DD for file 220.2") D
 .N DIU S DIU=220.2,DIU(0)="" D EN^DIU2
 Q
POST ;Post-install Routine
 D PARAM,TASK
 Q
PARAM ; Sets up new parameters and converts old ancillary parameter to new word processing parameter
 N ANC,RET,NUM,PROD,X,XML1,XML2 S (ANC,RET,NUM,PROD,X)=""
 D MSG("Setting Defaults For New Parameters")
 S XML1(1)="http://vaww.va.gov/dental/docs/CDWDentalReports.xml"
 S XML2(1)="http://vaww.infoshare.va.gov/sites/dental/HiddenContent/CDWDentalReports.xml"
 ; Setting default value for Data Warehouse XML address 1 if no value is set
 K RET
 D GETWP^DENTVX2(.RET,"SYS","DENTV DATAWAREHOUSE XML1",1)
 D:+$G(RET(1))=-1 FILEWP^DENTVX2(,"SYS","DENTV DATAWAREHOUSE XML1",1,.XML1)
 ; Setting default value for Data Warehouse XML address 2 if no value is set
 K RET
 D GETWP^DENTVX2(.RET,"SYS","DENTV DATAWAREHOUSE XML2",1)
 D:+$G(RET(1))=-1 FILEWP^DENTVX2(,"SYS","DENTV DATAWAREHOUSE XML2",1,.XML2)
 ; Setting default value for Data Warehouse timeout if no value is set
 D:+$$GET1^DSICXPR(,"SYS~DENTV DATAWAREHOUSE TIMEOUT~~~",1)=-1 ADD^DSICXPR(,"SYS~DENTV DATAWAREHOUSE TIMEOUT~1~5~~",1)
 ; Converting Ancillary Products to new DENTV ANCILLARY MULTI WP parameter
 D MSG("Transferring Ancillary Products to New Parameter")
 K RET
 D GET^DSICXPR(.RET,"PKG~DENTV DRM ANCILLARY~~~") Q:+RET(1)=-1
 F  S X=$O(RET(X)) Q:X=""  K ANC D
 .S NUM=+RET(X),PROD(1)=$P(RET(X),U,4)
 .I NUM>0 D
 ..D GETWP^DENTVX2(.ANC,"SYS","DENTV ANCILLARY MULTI WP","DENTV ANCILLARY"_NUM)
 ..D:$P(ANC(1),"=",2)="" FILEWP^DENTVX2(,"SYS","DENTV ANCILLARY MULTI WP","DENTV ANCILLARY"_NUM,.PROD)
 .I NUM=0 D
 ..S PROD(1)="MiPACS="_PROD(1)
 ..D GETWP^DENTVX2(.ANC,"SYS","DENTV ANCILLARY MULTI WP","DENTV ANCILLARY MIPACS")
 ..D:$P(ANC(1),"=",2)="" FILEWP^DENTVX2(,"SYS","DENTV ANCILLARY MULTI WP","DENTV ANCILLARY MIPACS",.PROD)
 Q
TASK ; Task of Post-Install
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 I '$D(XPDNM) D  Q:'X
 .I $G(DUZ)<.5 W !!,"Please sign on properly through the Kernel" S X=0
 .E  D HOME^%ZIS,DT^DICRW S X=1
 .Q
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTV066",ZTDESC="DENTV PATCH 66 POST-INSTALL"
 D ^%ZTLOAD S X="Patch 66 post-install successfully queued, task# "_$G(ZTSK)
 I $G(ZTSK) D MSG(X)
 I '$G(ZTSK) D MSG("Could not queue the Post-Install!"),MSG("Enter a Dental Remedy ticket.")
 Q
PS ; Taskman Post-Install
 D RESTORE^DENTVIP1,NULL
 Q
NULL ;Converts TMJ and Social History nulls to zero
 N DENT,DIEN S DIEN=0
 F  S DIEN=$O(^DENT(228.2,DIEN)) Q:DIEN'?1.N  D  I $D(DENTERR) D MSG(DENTERR("DIERR",1,"TEXT",1)) Q
 .K DENT,DENTERR
 .I $D(^DENT(228.2,DIEN,"TMJ")),'+^DENT(228.2,DIEN,"TMJ") S DENT(228.2,DIEN_",",5.5)=0
 .I $D(^DENT(228.2,DIEN,"SOCH")),'+^DENT(228.2,DIEN,"SOCH") S DENT(228.2,DIEN_",",10.01)=0
 .I $D(DENT) D FILE^DIE("K","DENT","DENTERR")
 Q
MSG(X) ;
 S X="   >>>>> "_X_" <<<<<"
 D MES^DSICXPDU(X,1)
 Q
