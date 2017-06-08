DENTV060  ;DSS/BD - Post init DENTAL Patch 60 ;7/30/2010 10:51
 ;;1.2;DENTAL;**60**;Aug 10, 2001;Build 3
 ;Copyright 1995-2010, Document Storage Systems, Inc., All Rights Reserved
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
 N DIU S DIU=220.2,DIU(0)="" D EN^DIU2
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
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTV060",ZTDESC="DENTV PATCH 60 POST-INSTALL"
 D ^%ZTLOAD S X="Patch 60 post-install successfully queued, task# "_$G(ZTSK)
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
 S XMDUZ=DUZ,XMSUB="New CPT Code Updates for Dental"
 S (%,IEN)=0,R="DENTVTXT",XMY(XMDUZ)="",XMY("G.DENTV ADA CODE MAPPING")=""
 S %=%+1,@R@(%,0)="The Dental Coding Committee has updated RVU and default"
 S %=%+1,@R@(%,0)="Diagnosis (ICD-9) codes to procedures.  Also, many codes"
 S %=%+1,@R@(%,0)="have updated coding guidelines."
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="The following codes have updated RVU values:"
 S %=%+1,@R@(%,0)="D2390,D2610,D2620,D2630,D2643,D2644,D2712,D2780,D2781,"
 S %=%+1,@R@(%,0)="D2782,D2960,D2961,D2975,D3110,D3120,D4210,D4211,D4231,"
 S %=%+1,@R@(%,0)="D4240,D4241,D4245,D4249,D4273,D4274,D4341,D4342,D5861,"
 S %=%+1,@R@(%,0)="D6053,D6054,D7311,D7321,D7450,D7451,D7460,D7461,D7830,"
 S %=%+1,@R@(%,0)="D7953,D7960,D7981"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="The following codes have updated coding guidelines:"
 S %=%+1,@R@(%,0)="D0120,D0140,D0145,D0150,D0160,D0170,D0180,D2971,D2975,"
 S %=%+1,@R@(%,0)="D4245,D4249,D4260,D4261,D4270,D5110,D5120,D5130,D5140,"
 S %=%+1,@R@(%,0)="D5211,D5212,D5213,D5214,D5225,D5226,D5730,D5731,D5740,"
 S %=%+1,@R@(%,0)="D5741,D5750,D5751,D5760,D5761,D5860,D5861,D5875,D6975,"
 S %=%+1,@R@(%,0)="D7111,D7140,D7285,D7286,D7471,D7473,D7981,D7997,D9120,"
 S %=%+1,@R@(%,0)="D9920,D9950,D9951,D9952,D9970,D9971,D9972,D9973"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="The following codes have updated defaut diagnosis:"
 S %=%+1,@R@(%,0)="D0120,D0140,D0150,D0160,D0170,D0180,D0210,D0220,D0230,"
 S %=%+1,@R@(%,0)="D0240,D0250,D0260,D0270,D0272,D0273,D0274,D0277,D0290,"
 S %=%+1,@R@(%,0)="D0330,D0340,D0350,D0460,D1204,D1206,D2910,D2915,D2920,"
 S %=%+1,@R@(%,0)="D5937,D6930"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)=""
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
