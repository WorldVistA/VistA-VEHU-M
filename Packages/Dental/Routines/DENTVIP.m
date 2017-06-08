DENTVIP ;DSS/SGM - PRE/POST INIT ROUTINE ;04/21/2003 21:16
 ;;1.2;DENTAL;**30,32,34,35,36**;Aug 10, 2001
 ;  this contains the pre and post init entry points for the DSS DRM
 ;  KIDS package
 ;
 ;  DBIA#  SUPPORTED
 ;  -----  ---------  -------------------------------------------
 ;  10141      x      XPDUTL: $$VER
 ;
 ;  environment check - during install phase only
ENV ;;To install this KIDS, you must have a valid DUZ and DUZ(0)="@"
 Q:$G(XPDENV)'=1
 I $G(DUZ)>0,$G(DUZ(0))="@" Q
 S XPDQUIT=2 W !!?3,$P($T(ENV),";",3)
 Q
 ;
 ;  XPDNM is the .01 field, BUILD file during KIDS install
 ;  XPDNM is available for enviromental check, pre and post install
INIT S PATCH=$P($G(XPDNM),"*",3)
 S VER=$$VER^XPDUTL($G(XPDNM)) ; ver may be null
 Q
 ; 
PRE ;  pre-init
 N X,Y,VER,PATCH D INIT
 I "^35^36"[(U_PATCH) D SAVE^DENTVIP1
 Q
 ;
POST ;  post init
 N I,X,Y,CK,CPT,DATA,ICD,PATCH,RTN,VCPT,VER
 D INIT,^DENTVIP2,RESTORE^DENTVIP1
 I PATCH=35 D QUICK^DENTVIP1
 I $D(^VEJD(19600.1)) D
 .S X="   >>>>>  Deleting ^VEJD(19600.1)  <<<<<"
 .D MES^DENTVIP1(X) K ^VEJD(19600.1)
 .Q
 Q
