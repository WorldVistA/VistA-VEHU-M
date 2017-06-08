DENTV062 ;DSS/AJ - Post init DENTAL Patch 62;9/27/2011 14:43
 ;;1.2;DENTAL;**62**;Aug 10, 2001;Build 1
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  ICR#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 5323       x       MES^DSICXPDU 
 ; 10070      x       ^XMD
 Q
POST ;Completes changes to necessary ICD codes
 N X,Y,D,CPT,DX1730,DX17300,DX1731,DX17310,DX1732,DX17320,DX1733,DX17330,DX1734,DX17340,LIST
 S DX1730=+$$ICD9^DSICDRG(,"173.0",,3110930,,1) I DX1730<0 S X="173.0" G ERR
 S DX1731=+$$ICD9^DSICDRG(,"173.1",,3110930,,1) I DX1731<0 S X="173.1" G ERR
 S DX1732=+$$ICD9^DSICDRG(,"173.2",,3110930,,1) I DX1732<0 S X="173.2" G ERR
 S DX1733=+$$ICD9^DSICDRG(,"173.3",,3110930,,1) I DX1733<0 S X="173.3" G ERR
 S DX1734=+$$ICD9^DSICDRG(,"173.4",,3110930,,1) I DX1734<0 S X="173.4" G ERR
 S DX17300=+$$ICD9^DSICDRG(,"173.00",,3111001,,1) I DX17300<0 S X="173.00" G ERR
 S DX17310=+$$ICD9^DSICDRG(,"173.10",,3111001,,1) I DX17310<0 S X="173.10" G ERR
 S DX17320=+$$ICD9^DSICDRG(,"173.20",,3111001,,1) I DX17320<0 S X="173.20" G ERR
 S DX17330=+$$ICD9^DSICDRG(,"173.30",,3111001,,1) I DX17330<0 S X="173.30" G ERR
 S DX17340=+$$ICD9^DSICDRG(,"173.40",,3111001,,1) I DX17340<0 S X="173.40" G ERR
 S I=0
 S (X,LIST(I))=""
 F  S X=$O(^DENT(228,X)) Q:X]]"A"  S Y=0 I $D(^DENT(228,X,5,Y))#2 D
 .F  S Y=$O(^DENT(228,X,5,Y)) Q:(Y]]"A")!(Y="")  D
 ..S D="^DENT(228,X,5,Y,0)",CPT="^ICPT(X,0)"
 ..I @D=DX1730 D
 ...S @D=DX17300 K ^DENT(228,X,5,"B",DX1730,Y) S ^DENT(228,X,5,"B",DX17300,Y)=""
 ...S:$P(@CPT,"^",1)'=LIST(I) I=I+1,LIST(I)=$P(@CPT,"^",1)
 ..I @D=DX1731 D
 ...S @D=DX17310 K ^DENT(228,X,5,"B",DX1731,Y) S ^DENT(228,X,5,"B",DX17310,Y)=""
 ...S:$P(@CPT,"^",1)'=LIST(I) I=I+1,LIST(I)=$P(@CPT,"^",1)
 ..I @D=DX1732 D
 ...S @D=DX17320 K ^DENT(228,X,5,"B",DX1732,Y) S ^DENT(228,X,5,"B",DX17320,Y)=""
 ...S:$P(@CPT,"^",1)'=LIST(I) I=I+1,LIST(I)=$P(@CPT,"^",1)
 ..I @D=DX1733 D
 ...S @D=DX17330 K ^DENT(228,X,5,"B",DX1733,Y) S ^DENT(228,X,5,"B",DX17330,Y)=""
 ...S:$P(@CPT,"^",1)'=LIST(I) I=I+1,LIST(I)=$P(@CPT,"^",1)
 ..I @D=DX1734 D
 ...S @D=DX17340 K ^DENT(228,X,5,"B",DX1734,Y) S ^DENT(228,X,5,"B",DX17340,Y)=""
 ...S:$P(@CPT,"^",1)'=LIST(I) I=I+1,LIST(I)=$P(@CPT,"^",1)
 D:$D(LIST)\10 MM
 Q
ERR ;STOP WITH ERROR MESSAGE
 D MES^DSICXPDU("No IEN for code "_$G(X)_". Unable to complete installation!")
 Q
MM ;send message
 Q:'DUZ  N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,DIFROM,CNT,I,IEN
 S XMDUZ=DUZ,XMSUB="Dental Patch 62 Q1 FY2012 CPT Code Updates",I=1,CNT=0
 S (%,IEN)=0,R="DENTVTXT",XMY(XMDUZ)="",XMY("G.DENTV ADA CODE MAPPING")=""
 S %=%+1,@R@(%,0)="The following ICD-9 codes used by DRM Plus will be replaced "
 S %=%+1,@R@(%,0)="with newly activated ICD-9 codes as follows:"
 S %=%+1,@R@(%,0)="  173.0 to be replaced with 173.00"
 S %=%+1,@R@(%,0)="  173.1 to be replaced with 173.10"
 S %=%+1,@R@(%,0)="  173.2 to be replaced with 173.20"
 S %=%+1,@R@(%,0)="  173.3 to be replaced with 173.30"
 S %=%+1,@R@(%,0)="  173.4 to be replaced with 173.40"
 S %=%+1,@R@(%,0)="Dental procedure codes affected by this change are:"
 S %=%+1,@R@(%,0)=""
 F  Q:$G(LIST(I))=""  D
 .S @R@(%,0)=@R@(%,0)_LIST(I)_",",I=I+1,CNT=CNT+1
 .I (CNT#8)=0 S %=%+1,@R@(%,0)="",CNT=0
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
