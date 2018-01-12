DENTV068 ;DSS/AJ - Post init DENTAL Patch 68; 9/23/2015
 ;;1.2;DENTAL;**68**;Aug 10, 2001;Build 1
 ;Copyright 1995-2015, Document Storage Systems, Inc., All Rights Reserved
 ;
 Q
PRE ;  pre-install
 D SAVE^DENTVIP1 ;save off 228 data so that we can restore their ICD-9s and $Values
 Q
POST ;queue off the restore of file 228 data
 D TASK
 Q
TASK ;task off the code to set VISIT DATE in 228.2
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 I '$D(XPDNM) D  Q:'X
 .I $G(DUZ)<.5 W !!,"Please sign on properly through the Kernel" S X=0
 .E  D HOME^%ZIS,DT^DICRW S X=1
 .Q
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTV068",ZTDESC="DENTV PATCH 68 POST-INSTALL"
 D ^%ZTLOAD S X="Patch 68 post-install successfully queued, task# "_$G(ZTSK)
 I $G(ZTSK) D MSG(X)
 I '$G(ZTSK) D MSG("Could not queue the Post-Install!"),MSG("Enter a Dental Remedy ticket.")
 Q
PS ;post-install
 D RESTORE^DENTVIP1 ;restore the ICDs and $Values saved in the pre-install
 D MM
 Q
MM ; DENT*1.2*68 Post-Install
 ;send MailMan message
 Q:'DUZ  N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,IEN,X,Y,J,ICD,DATA,DIFROM
 S XMDUZ=DUZ,XMSUB="New ADA Codes for Dental"
 S (%,IEN)=0,R="DENTVTXT",XMY(XMDUZ)="",XMY("G.DENTV ADA CODE MAPPING")=""
 S %=%+1,@R@(%,0)="1. The following NEW CPT Codes were added:"
 S %=%+1,@R@(%,0)="   99444, 98969"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="2. The following NEW ADA Codes were added:"
 S %=%+1,@R@(%,0)="   D0251, D0422, D0423, D1354, D4283, D4285, D5221, D5222,"
 S %=%+1,@R@(%,0)="   D5223, D5224, D7881, D8681, D9223, D9243, D9932, D9933,"
 S %=%+1,@R@(%,0)="   D9934, D9935, D9943"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="3. The following ADA Codes were inactivated:"
 S %=%+1,@R@(%,0)="   D0260, D0421, D2970, D9220, D9221, D9241, D9242, D9931"
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
 ;
MSG(X) ;
 S X="   >>>>> "_X_" <<<<<"
 D MES^DSICXPDU(X,1)
 Q
 ;
