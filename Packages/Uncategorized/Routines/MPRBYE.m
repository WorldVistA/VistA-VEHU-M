MPRBYE ;OIOFO BAY PINES/ELR - REMOVE MPR APPLICATION ;7/20/2003
 ;;1.0;Missing Patient Register;**6**;July 30, 2003
 Q
START ;DELETE DICTIONARIES AND DATA FILES
 I $D(^XTMP("MPRDEL","RUNNING")) D  Q
 . S ^XTMP("MPRELR")="MPR DELETE PROGRAM ALREADY RUNNING" D MAIL
 S DIU="^MPR(850,",DIU(0)="DT" D EN^DIU2
 S DIU="^MPR(850.1,",DIU(0)="DT" D EN^DIU2
 S DIU="^MPR(850.9,",DIU(0)="DT" D EN^DIU2
 K DIU
 D ZTQUE
 S ^XTMP("MPRELR")="Background Utility for MPR removal, Task #"_$G(ZTSK)_", has been tasked to start at "_MPRELR1
 D MAIL
 Q
 ;CALLED BY TASKMAN AFTER ALL OTHER DATA HAS BEEN REMOVED
LAST ;DELETE THE BUILDS
 NEW ZZNMSP,ZNODE,ZI
 S ZZNMSP="MPR"
 S DIK="^XPD(9.6," F ZI=0:0 S ZI=$O(^XPD(9.6,ZI)) Q:ZI'?.N  S ZNODE=$G(^XPD(9.6,ZI,0)) I $E(($P(ZNODE,U,1)),1,$L(ZZNMSP))[ZZNMSP!($P($G(^DIC(9.4,+$P(ZNODE,U,2),0)),U,2)=ZZNMSP) S DA=ZI D ^DIK
 ;DELETE INSTALLS
 S DIK="^XPD(9.7," F ZI=0:0 S ZI=$O(^XPD(9.7,ZI)) Q:ZI'?.N  S ZNODE=$G(^XPD(9.7,ZI,0)) I $E(($P(ZNODE,U,1)),1,$L(ZZNMSP))[ZZNMSP!($P($G(^DIC(9.4,+$P(ZNODE,U,2),0)),U,2)=ZZNMSP) S DA=ZI D ^DIK
 ;DELETE PACKAGES
 S DIK="^DIC(9.4," F ZI=0:0 S ZI=$O(^DIC(9.4,ZI)) Q:ZI'?.N  S ZNODE=$G(^DIC(9.4,ZI,0)) I $E(($P(ZNODE,U,2)),1,$L(ZZNMSP))[ZZNMSP S DA=ZI D ^DIK
 ;DELETE VISTA APPLICATIONS
 S DIK="^DIC(1200036," F ZI=0:0 S ZI=$O(^DIC(1200036,ZI)) Q:ZI'?.N  S ZNODE=$G(^DIC(1200036,ZI,0)) I $P(ZNODE,U,3)=ZZNMSP S DA=ZI D ^DIK
 S MPRELR="Background Utility for MPR removal, Task #"_$G(ZTSK)_" has completed"
 D DONE
 K DIK,MPRELR,MPRELR1,%H,DA,Y,ZTSK
 K ^XTMP("MPRDEL","RUNNING")
 K ^XTMP("MPRELR")
 Q
ZTQUE ;
 N ZTIO,ZTDTH,ZTDESC,ZTRTN,ZTSAVE
 S ZTIO="",ZTDTH=$H,$P(ZTDTH,",",2)=$P(ZTDTH,",",2)+300,ZTDESC="MPR DELETION UTILITY"
 S ZTRTN="LAST^MPRBYE"
 S %H=ZTDTH D YX^%DTC S MPRELR1=Y
 D ^%ZTLOAD
 S ^XTMP("MPRDEL","RUNNING")=$G(ZTSK)
 Q
DONE N MPRX,XMSUB,XMY,XMTEXT,XMDUZ
 S XMY($S(DUZ:DUZ,1:.5))=""
 S XMSUB="BACKGROUND FOR DELETING MPR PACKAGE"
 S XMTEXT="MPRX("
 S XMDUZ="POSTMASTER"
 I $D(MPRELR) S MPRX(1)=MPRELR
 E  S MPRX(1)=$G(^XTMP("MPRELR"))
 D ^XMD
 Q
MAIL ;
 N ZTIO,ZTDTH,ZTDESC,ZTRTN,ZTSAVE
 S ZTIO="",ZTDTH=$H,$P(ZTDTH,",",2)=$P(ZTDTH,",",2)+60,ZTDESC="MPR DELETE MAIL"
 S ZTRTN="DONE^MPRBYE"
 D ^%ZTLOAD
 Q
