DSIFPAY4 ;DSS/RED - RPC FOR FEE BASIS PAYMENTS ;12/31/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   2053  FILE^DIE,UPDATE^DIE,WP^DIE
 ;   2056  $$GET1^DIQ,GETS^DIQ
 ;
 Q    ;no direct calls to the routine
 ;
FILEADJ(FBIENS,FBADJ) ; File Adjustments  (called from DSIFPAY3 & DSIFPAU1)
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.03
 ;             in standard format as specified for FileMan DBS calls
 ;   FBADJ   - required, array passed by reference
 ;             array of adjustments to file
 ;             array does not have to contain any data or be defined
 ;             format
 ;               FBADJ(#)=FBADJR^FBADJG^FBADJA
 ;             where
 ;               # = sequentially assigned number starting with 1
 ;               FBADJR = adjustment reason (internal value file 162.91)
 ;               FBADJG = adjustment group (internal value file 162.92)
 ;               FBADJA = adjustment amount (dollar value)
 ; Output
 ;   Data in File 162.03 will be modified
 N FB,FBFDA,FBHIGH,FBI,FBMSR,FBSC,FBSIENS,FBTAS
 ; delete adjustment reasons currently on file
 D GETS^DIQ(162.03,FBIENS,"52*","","FB")
 K FBFDA
 S FBSIENS="" F  S FBSIENS=$O(FB(162.07,FBSIENS)) Q:FBSIENS=""  D
 . S FBFDA(162.07,FBSIENS,.01)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ; delete suspend data currently on file
 K FBFDA
 S FBFDA(162.03,FBIENS,3)="@"
 S FBFDA(162.03,FBIENS,3.5)="@"
 S FBFDA(162.03,FBIENS,4)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ; delete description of suspension currently on file
 D WP^DIE(162.03,FBIENS,22,,"@")
 ; compute total amount suspended and determine most significant reason
 ; loop thru reasons
 S (FBTAS,FBI,FBHIGH)=0,FBMSR=""
 F  S FBI=$O(FBADJ(FBI)) Q:'FBI  D
 . N FBADJA
 . ; get adjustment amount for reason
 . S FBADJA=$P(FBADJ(FBI),U,3)
 . ; add amount to total
 . S FBTAS=FBTAS+FBADJA
 . ; check if reason has largest absolute $ impact
 . I $FN(FBADJA,"-")>$G(FBHIGH) S FBMSR=FBI,FBHIGH=$FN(FBADJA,"-")
 I +FBTAS=0 Q  ; quit since total amount suspended is 0
 ; file adjustments from input array
 K FBFDA
 S FBI=0 F  S FBI=$O(FBADJ(FBI)) Q:'FBI  D
 . S FBFDA(162.07,"+"_FBI_","_FBIENS,.01)=$P(FBADJ(FBI),U)
 . S FBFDA(162.07,"+"_FBI_","_FBIENS,1)=$P(FBADJ(FBI),U,2)
 . S FBFDA(162.07,"+"_FBI_","_FBIENS,2)=+$P(FBADJ(FBI),U,3)
 I $D(FBFDA) D UPDATE^DIE("","FBFDA")
 ; file derived suspend data
 K FBFDA
 S FBFDA(162.03,FBIENS,3)=FBTAS
 S FBFDA(162.03,FBIENS,3.5)=DT
 I FBMSR,$P(FBADJ(FBMSR),U) S FBSC=$$GET1^DIQ(161.91,$P(FBADJ(FBMSR),U),3)
 I '$G(FBSC) S FBSC=4
 S FBFDA(162.03,FBIENS,4)=FBSC
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ; if suspend code = 4 (other) then file description of suspension
 I FBSC=4,FBMSR,$P(FBADJ(FBMSR),U) D WP^DIE(162.03,FBIENS,22,,"^FB(161.91,"_$P(FBADJ(FBMSR),U)_",4)")
 Q
  ;
CHKINV ; Verify invoice is valid (called from DSIFPAY3)
 K FBAACK1,X I $D(^FBAAC("C",$P(FBSERV,U,8))) S FBJ=0 F  S FBJ=$O(FBAR(FBJ)) Q:'FBJ  D  K X(1) I $G(FBAACK1) S FBV=FBJ Q
 .I '$G(FBCNP) I $D(^FBAAC("C",$P(FBSERV,U,8),DFN,FBJ)) S FBAACK1=1
 .I $G(FBCNP) S X(1)=$O(^FBAAC("C",$P(FBSERV,U,8),0)) I $D(^FBAAC("C",$P(FBSERV,U,8),X(1),FBJ)) S FBAACK1=1
 I '$G(FBAACK1) S FBOUT="-1^That number not valid for this vendor!",MFLAG=1
 Q
