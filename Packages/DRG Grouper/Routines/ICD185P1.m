ICD185P1 ;ALB/MRY - ADD NEW DRG/DIAG/PROC ; 10/28/02 2:21pm
 ;;18.0;DRG Grouper;**5**;Oct 13,2000
 ;
 Q
 ;
ADDDRG  ;-- Add any new DRGs
 N DIC,X,Y,LINE,ICDDRG,DA,DRGX,DRGY,MDC,DINUM
 D BMES^XPDUTL(">>> Adding New DRGs - Please verify that 4 added")
 I '$D(^ICM(98)) D  Q:Y=-1
 .S DIC="^ICM(",DIC(0)=""
 .S X="PRE",DINUM=98
 .K DO D FILE^DICN
 F LINE=1:1 S X=$T(ADD+LINE) S ICDDRG=$P(X,";;",2) Q:ICDDRG="EXIT"  D
 .S DIC="^ICD(",DIC(0)=""
 .S MDC=$P(ICDDRG,U,2) I MDC="PRE" S MDC=98
 .; check whether #900 field needs an entry of a routine name
 .S DIC("DR")="5///"_MDC_";.06///"_$P(ICDDRG,U,3)_";900///"_$P(ICDDRG,U,5)
 .S X="DRG",X=X_$P(ICDDRG,U)
 .; check for duplicates in case install is being rerun
 .I +$O(^ICD("B",X,0)) Q
 .K DO D FILE^DICN
 .I Y=-1 Q
 .K DIC("DR")
 .S DA(1)=+Y
 .S DIC=DIC_DA(1)_",1,"
 .S DIC(0)="L"
 .S X=$P(ICDDRG,U,4)
 .K DO D FILE^DICN
 .I Y=-1 Q
 . ; displays listing
 .S DRGX=$P(ICDDRG,U),DRGY=$P(ICDDRG,U,4)
 .D MES^XPDUTL("  DRG"_DRGX_"     "_DRGY_" added.")
 Q
 ;
ADD ;New DRGs - descriptions should not exceed 80 char.
 ;;524^1^^TRANSIENT ISCHEMIA
 ;;525^5^1^HEART ASSIST SYSTEM IMPLANT
 ;;526^5^1^PERCUTANEOUS CARDIOVASCULAR PROCEDURE WITH DRUG-ELUTING STENT WITH AMI^ICDTLB6
 ;;527^5^1^PERCUTANEOUS CARDIOVASCULAR PROCEDURE WITH DRUG-ELUTING STENT WITHOUT AMI^ICDTLB6
 ;;EXIT
 Q
