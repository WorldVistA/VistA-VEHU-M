DENTV061  ;DSS/BD - Post init DENTAL Patch 61 ;7/30/2010 10:51
 ;;1.2;DENTAL;**61**;Aug 10, 2001;Build 3
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 10005      x      DT^DICRW
 ; 10070      x       ^XMD
 ; 10063      x      ^%ZTLOAD
 ; 10086      x      HOME^%ZIS
 ; 10013      x      ^DIK
 ; 2053       x      FILE^DIE
 Q
PRE ;  pre-install
 D SAVE^DENTVIP1 ;save off 228 data so that we can restore their $Values and admin notes
 ;
 ;I $$VFIELD^DSICFM06(,228,1.02,1)<0 Q  ;has been run (installed) before
 ;
 Q
POST ;queue off the restore of file 228 data
 N M S M(1)=" The post-install will be queued, but may take some time to run."
 S M(2)=" It restores DENTAL CPT CODE MAPPING file (#228) values from the"
 S M(3)="pre-install routine. It restores site specific values, like $values,"
 S M(4)="admin guidelines, and local codes."
 D MES^DSICXPDU(.M,1)
 D TASK
 Q
MSG(X) ;
 S X=" >> "_X_" <<"
 D MES^DSICXPDU(X,1)
 Q
 ;
TASK ;task off the code to restore 228 site values
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 I '$D(XPDNM) D  Q:'X
 .I $G(DUZ)<.5 W !!,"Please sign on properly through the Kernel" S X=0
 .E  D HOME^%ZIS,DT^DICRW S X=1
 .Q
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTV061",ZTDESC="DENTV PATCH 61 POST-INSTALL"
 D ^%ZTLOAD S X="Patch 61 post-install successfully queued, task# "_$G(ZTSK)
 I $G(ZTSK) D MSG(X)
 I '$G(ZTSK) D MSG("Could not queue the Post-Install!"),MSG("Enter a Dental Remedy ticket.")
 Q
 ;
PS ;post-install
 D RESTORE^DENTVIP1 ;restore $Values and admin guidelines saved in the pre-install
 D MM ;send MM about file 228
 Q
MM ;send message
 Q:'DUZ  N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,DIFROM
 S XMDUZ=DUZ,XMSUB="Dental Patch 61 FY2011 CPT Code Updates"
 S (%,IEN)=0,R="DENTVTXT",XMY(XMDUZ)="",XMY("G.DENTV ADA CODE MAPPING")=""
 S %=%+1,@R@(%,0)="The Dental Coding Committee has released RVU, diagnosis"
 S %=%+1,@R@(%,0)="(ICD-9) codes and coding guidelines for 8 new Dental codes."
 S %=%+1,@R@(%,0)="The Dental Coding Committee also updated various codes' RVU,"
 S %=%+1,@R@(%,0)="diagnosis codes, and coding guidelines."
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="The following codes are NEW:"
 S %=%+1,@R@(%,0)="1352,D3354,D5992,D5993,D6254,D6795,D7251,D7295"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="The following codes have revised diagnosis codes:"
 S %=%+1,@R@(%,0)="D0486,D9215,D9420,99499"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="The following codes have updated coding guidelines:"
 S %=%+1,@R@(%,0)="D0486,D1110,D2940,D4910,D6055,D6950,D7210,D7953,"
 S %=%+1,@R@(%,0)="D7960,D9215,D9230,D9420"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="The following codes revisions to their GUI display properties:"
 S %=%+1,@R@(%,0)="D4211,D6980,D6985,D9970"
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
