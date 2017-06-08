DENTV067 ;DSS/AJ - Post init DENTAL Patch 67; 11/25/2014
 ;;1.2;DENTAL;**67**;Aug 10, 2001;Build 11
 ;Copyright 1995-2015, Document Storage Systems, Inc., All Rights Reserved
 ;
 Q
POST ; DENT*1.2*67 Post-Install
 ; Task off restoration of user data as well as the sending of MailMan message
 D EN^DENTVI67,TASK
 Q
TASK ;task off the code to set VISIT DATE in 228.2
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 I '$D(XPDNM) D  Q:'X
 .I $G(DUZ)<.5 W !!,"Please sign on properly through the Kernel" S X=0
 .E  D HOME^%ZIS,DT^DICRW S X=1
 .Q
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTV067",ZTDESC="DENTV PATCH 67 POST-INSTALL"
 D ^%ZTLOAD S X="Patch 67 post-install successfully queued, task# "_$G(ZTSK)
 I $G(ZTSK) D MSG(X)
 I '$G(ZTSK) D MSG("Could not queue the Post-Install!"),MSG("Enter a Dental Remedy ticket.")
 Q
 ;
PS ;post-install
 ; Remove accidental data from 11001 CPT code
 N DENTV
 S DENTV(228,"11001,",3)="@"
 S DENTV(228.05,"2,11001,",.01)="@"
 S DENTV(228.05,"3,11001,",.01)="@"
 D FILE^DIE("K","DENTV","DENTVERR")
 D MM
 Q
MM ;send message
 Q:'DUZ  N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,IEN,X,Y,J,ICD,DATA,DIFROM
 S XMDUZ=DUZ,XMSUB="New ADA Codes for Dental"
 S (%,IEN)=0,R="DENTVTXT",XMY(XMDUZ)="",XMY("G.DENTV ADA CODE MAPPING")=""
 S %=%+1,@R@(%,0)="The following NEW CPT Codes were added:"
 S %=%+1,@R@(%,0)="1. The following NEW CDT Codes were added:"
 S %=%+1,@R@(%,0)="  12053, 15829, 40820"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="2. The following NEW ADA Codes were added:"
 S %=%+1,@R@(%,0)="  D0171, D0351, D1353, D6110, D6111, D6112, D6113, D6114"
 S %=%+1,@R@(%,0)="  D6115, D6116, D6117, D6549, D9219, D9931, D9986, D9987"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="3. The following codes were inactivated:"
 S %=%+1,@R@(%,0)="  D6053, D6054, D6078, D6079, D6975"
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
MSG(X) ;
 S X="   >>>>> "_X_" <<<<<"
 D MES^DSICXPDU(X,1)
 Q
 ;
