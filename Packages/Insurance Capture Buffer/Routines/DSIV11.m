DSIV11 ;DSS/CAJ - POST INSTALL P11 ;7/24/2014 9:55
 ;;2.2;INSURANCE CAPTURE BUFFER;**11**;May 19, 2009;Build 16
 ;Copyright 1995-2014, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;   ICR#  Description
 ;  -----  --------------------------------------
 ;  10013  IXALL2^DIK, IXALL^DIK
 ;   5322  ADD^DSICXPR
 Q
POST ;Post install routine
 N DIK,DSIVIEN
 S DIK(1)=.01,DSIVIEN=0
 F  S DSIVIEN=$O(^DIC(36,DSIVIEN)) Q:'+DSIVIEN  D
 .S DA(1)=+DSIVIEN
 .S DIK="^DIC(36,"_DSIVIEN_",10,"
 .D ENALL2^DIK,ENALL^DIK
 D ADD^DSICXPR(.RET,"SYS~DSIV NON-ICB INDEX~1~0")
 Q
