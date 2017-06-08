ICD1820B ;ALB/ESD/JAT - ICD/DRG; 6/22/01 2:43pm ; 6/29/05 3:30pm
 ;;18.0;DRG Grouper;**20**;Oct 13,2000
 ; continue updating DRGs
 ; - Weights & ALOS for FY 2006
 ; - update 80.272 multiple with new table routines for FY 2006
 ; - inactivate DRGs (from DRG Reclassification section in Fed Reg)        
 Q
 ;
UPDTDRG ;
 N DRG,FYR,ICDLOW,ICDHIGH,ICDLOS,ICDWWU,ICDCNT,WT,I,J
 N ICDREF,ICDDRG,ICDFDA
 D UPD01
 D UPD02
 Q
 ;
 ;
UPD01 ;- Load FY 2006 weights & ALOS into DRG file (#80.2)
 S FYR=3060000
 D BMES^XPDUTL(">>>  Adding FY 2006 Weights & ALOS...")
 ; check if already done in case patch being re-installed
 Q:$D(^ICD(559,"FY",3060000,0))
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD1820X),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD1820Y),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD1820Z),";;",2,99) Q:$E(WT,1,4)="EXIT"  D SETVAR,FY,MORE
 S ^ICD("AFY",3060000)=""
 D MES^XPDUTL(">>>  ...completed.")
 D MES^XPDUTL("")
 Q
 ;
 ;
FY ;- Set FY multiple with FYR stats
 ; check if already done in case patch being re-installed
 I $D(^ICD(DRG,"FY",FYR,0)) Q
 S $P(^ICD(DRG,"FY",FYR,0),"^",1,4)=FYR_"^"_ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",9)=ICDLOS
 I '$D(^ICD(DRG,"FY",0)) S ^ICD(DRG,"FY",0)="^80.22^"_FYR_"^1" Q
 S ICDCNT="" F J=0:1 S ICDCNT=$O(^ICD(DRG,"FY",ICDCNT)) Q:ICDCNT=""
 S $P(^ICD(DRG,"FY",0),"^",3,4)=FYR_"^"_J
 Q
 ;
 ;
SETVAR ;- Set variables
 S DRG=$P(WT,U),ICDLOW=1,ICDHIGH=99,ICDWWU=$P(WT,U,2),ICDLOS=$P(WT,U,3)
DRG I DRG<544 S ICDLOW=$P(^ICD(DRG,"FY",3050000,0),U,3),ICDHIGH=$P(^ICD(DRG,"FY",3050000,0),U,4)
 Q
 ;
 ;
MORE ;- Set zero node with FY 2006 stats
 S $P(^ICD(DRG,0),"^",2,4)=ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",8)=ICDLOS
 Q
 ;
UPD02 ; create new entries for FY 2006 versioning
 S DRG=0
 F  S DRG=$O(^ICD(DRG)) Q:'DRG  D
 .; check if already done in case patch being re-installed
 .Q:$D(^ICD(DRG,2,3,0))
 .; it's also already done if DRG new this year 
 .Q:DRG>543&($D(^ICD(DRG,2)))
 .S (ICDDRG,ICDREF)=""
 .S ICDDRG=$P($G(^ICD(DRG,0)),U,1)
 .;"A"= FY 2005 "B"=FY 2006 "C"=FY 2007, etc.
 .I $D(^ICD(DRG,2,2,0)) S ICDREF=$P(^ICD(DRG,2,2,0),U,3),ICDREF=$E(ICDREF,1,7)_"B"
 .;Create FY 2006 reference table entries used for FY 2006
 .I ICDDRG'="",ICDREF'="" D
 ..S ICDFDA(80.2,"?1,",.01)=ICDDRG
 ..S ICDFDA(80.271,"+2,?1,",.01)=3051001
 ..S ICDFDA(80.271,"+2,?1,",1)=ICDREF
 ..D UPDATE^DIE("","ICDFDA")
 Q
 ;
INACTDRG ;
 N LINE,X,ICDDRG,DESC,DA,DIE,DR,MDC,SURG,ICDFDA
 D BMES^XPDUTL(">>> Inactivating 10 DRGs...")
 F LINE=1:1 S X=$T(INAC+LINE) S ICDDRG=$P(X,";;",2) Q:ICDDRG="EXIT"  D
 .S DESC="NO LONGER VALID"
 .S DA(1)=$P(ICDDRG,U)
 .S DA=1
 .S DIE="^ICD("_DA(1)_",1,"
 .S DR=".01///^S X=DESC"
 .D ^DIE
 .; check if already done in case patch being re-installed
 .Q:$D(^ICD($P(ICDDRG,U),66,"B",3051001))
 .; add entry to 80.266
 .S MDC=$P(ICDDRG,U,2)
 .S SURG=$P(ICDDRG,U,3)
 .S ICDDRG=$P(ICDDRG,U)
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.266,"+2,?1,",.01)=3051001
 .S ICDFDA(80.266,"+2,?1,",.03)=0
 .S ICDFDA(80.266,"+2,?1,",.05)=MDC
 .S ICDFDA(80.266,"+2,?1,",.06)=SURG
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .; add entry to 80.268 and 80.2681 
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.268,"+2,?1,",.01)=3051001
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.268,"?2,?1,",.01)=3051001
 .S ICDFDA(80.2681,"+3,?2,?1,",.01)=DESC
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 Q
 ;
INAC ;
 ;;107^5^1
 ;;109^5^1
 ;;115^5^1
 ;;116^5^1
 ;;209^8^1
 ;;478^5^1
 ;;516^5^1
 ;;517^5^1
 ;;526^5^1
 ;;527^5^1
 ;;EXIT
