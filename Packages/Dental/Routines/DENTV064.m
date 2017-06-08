DENTV064 ;DSS/AJ - Post init DENTAL Patch 64;1/16/2013 12:39
 ;;1.2;DENTAL;**64**;Aug 10, 2001;Build 3
 ;Copyright 1995-2013, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ;  2053      x       FILE^DIE
 ; 10070      x       ^XMD
 ; 10013      x       IX1^DIK
 ;
 Q
PRE ;  pre-install
 D SAVE^DENTVIP1 ;save off 228 data so that we can restore their ICD-9s and $Values
 Q
POST ;queue off the restore of file 228 data
 D TASK
 Q
MSG(X) ;
 S X="   >>>>> "_X_" <<<<<"
 D MES^DSICXPDU(X,1)
 Q
 ;
TASK ;task off the code to set VISIT DATE in 228.2
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 I '$D(XPDNM) D  Q:'X
 .I $G(DUZ)<.5 W !!,"Please sign on properly through the Kernel" S X=0
 .E  D HOME^%ZIS,DT^DICRW S X=1
 .Q
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTV064",ZTDESC="DENTV PATCH 64 POST-INSTALL"
 D ^%ZTLOAD S X="Patch 64 post-install successfully queued, task# "_$G(ZTSK)
 I $G(ZTSK) D MSG(X)
 I '$G(ZTSK) D MSG("Could not queue the Post-Install!"),MSG("Enter a Dental Remedy ticket.")
 Q
 ;
PS ;post-install
 D RESTORE^DENTVIP1 ;restore the ICD-9s and $Values saved in the pre-install
 D MM
 Q
MM ;send message
 Q:'DUZ  N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,IEN,X,Y,J,ICD,DATA,DIFROM
 S XMDUZ=DUZ,XMSUB="New ADA Codes for Dental"
 S (%,IEN)=0,R="DENTVTXT",XMY(XMDUZ)="",XMY("G.DENTV ADA CODE MAPPING")=""
 S %=%+1,@R@(%,0)="The following NEW CPT Codes were added:"
 S %=%+1,@R@(%,0)="E0485, 21240, 40812, 82962, 90655, 90658, 97035"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="The following NEW ADA Codes were added:"
 S %=%+1,@R@(%,0)="D0190, D0191, D0364, D0365, D0366, D0367, D0368, D0369, "
 S %=%+1,@R@(%,0)="D0370, D0371, D0380, D0381, D0382, D0383, D0384, D0385, "
 S %=%+1,@R@(%,0)="D0386, D0391, D1208, D2929, D2981, D2982, D2983, D2990, "
 S %=%+1,@R@(%,0)="D4212, D4277, D4278, D6051, D6101, D6102, D6103, D6104, "
 S %=%+1,@R@(%,0)="D7921, D7952, D9975"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="The following procedure codes were inactivated:"
 S %=%+1,@R@(%,0)="D0360, D0362, D1203, D1204, D4271, D6254, D6795, D6970, "
 S %=%+1,@R@(%,0)="D6972, D6973, D6976, D6977, 95015"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="The Dental Coding Committee also made changes to coding "
 S %=%+1,@R@(%,0)="guidelines for many existing dental codes."
 S %=%+1,@R@(%,0)=""
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
