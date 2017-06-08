ICD1877L ;ALB/JDG - UPDATE DX & PX CODES ; 10/5/11 3:23pm
 ;;18.0;DRG Grouper;**77**;Oct 20,2000;Build 2
 ;
 Q
 ;
 ; Update Dx code(s)
ICDUPDDX ; update the UNACCEPTABLE AS PRINCIPAL DX (#1.3) field
 N LINE,LINEXX,ICDDXDA,DA,DIE,IDENT,DR,ICDTXTFP,ICDTXTSP
 F LINE=1:1 S LINEXX=$T(DIAGUP1+LINE) S ICDDXDA=$P(LINEXX,";;",2),ICDTXTFP=$P(ICDDXDA,"^"),ICDTXTSP=$P(ICDDXDA,"^",2) Q:ICDDXDA="EXIT"  D
 .I '$D(^ICD9(ICDTXTFP,0)) D  Q
 ..D BMES^XPDUTL(">>>>> Missing Diagnosis code "_ICDTXTSP_"<<<<<")
 .D BMES^XPDUTL(">>> Updating Diagnosis code "_ICDTXTSP_"...")
 .S DA=ICDTXTFP
 .S DIE="^ICD9("
 .S DR="1.3///^S X=1"
 .D ^DIE
 Q
 ;
 ; 
UPDTADRG ; update existing operation/procedure codes 
 D BMES^XPDUTL(">>>Modify existing procedure codes - file 80.1")
 N LINE,ICDX,ICDPROC,ENTRY,SUBLINE,DATA,ICDFDA
 F LINE=1:1 S ICDX=$T(PROCUP3+LINE) S ICDPROC=$P(ICDX,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",""_ICDPROC_" "_"",0))
 .I ENTRY D
 ..; check if already created in case patch being re-installed
 ..Q:$D(^ICD0(ENTRY,2,"B",3141001))
 ..;add 80.171, 80.1711 and 80.17111 records
 ..F SUBLINE=1:1 S ICDX=$T(PROCUP4+SUBLINE) S DATA=$P(ICDX,";;",2) Q:DATA'["+"  D
 ...I SUBLINE=1 D
 ....S ICDFDA(80.1,"?1,",.01)="`"_ENTRY
 ....S ICDFDA(80.171,"+2,?1,",.01)=3141001
 ....D UPDATE^DIE("","ICDFDA") K ICDFDA
 ...S DATA=$E(DATA,2,99)
 ...S ICDFDA(80.1,"?1,",.01)="`"_ENTRY
 ...S ICDFDA(80.171,"?2,?1,",.01)=3141001
 ...S ICDFDA(80.1711,"+3,?2,?1,",.01)=$P(DATA,U)
 ...D UPDATE^DIE("","ICDFDA") K ICDFDA
 ...S ICDFDA(80.1,"?1,",.01)="`"_ENTRY
 ...S ICDFDA(80.171,"?2,?1,",.01)=3141001
 ...S ICDFDA(80.1711,"?3,?2,?1,",.01)=$P(DATA,U)
 ...S ICDFDA(80.17111,"+4,?3,?2,?1,",.01)=$P(DATA,U,2)
 ...S ICDFDA(80.17111,"+5,?3,?2,?1,",.01)=$P(DATA,U,3)
 ...S ICDFDA(80.17111,"+6,?3,?2,?1,",.01)=$P(DATA,U,4)
 ...D UPDATE^DIE("","ICDFDA") K ICDFDA
 Q
 ;
 ;
DIAGUP1 ; updating the UNACCEPTABLE AS PRINCIPAL DX (#1.3) field for the following Diagnosis codes
 ;;11387^V17.0 (FAM HX-PSYCHIATRIC COND)
 ;;11389^V17.2 (FAM HX-NEUROLOG DIS NEC)
 ;;14572^V17.49 (FAM HX-CARDIOVAS DIS NEC)
 ;;11396^V18.0 (FAM HX-DIABETES MELLITUS)
 ;;14574^V18.19 (FM HX ENDO/METAB DIS NEC)
 ;;11404^V18.8 (FM HX-INFECT/PARASIT DIS)
 ;;11584^V50.3 (EAR PIERCING)
 ;;EXIT
 ;
 ;
PROCUP3 ; update the following ICD OPERARTION/PROCEDURE codes with related DRGs
 ;;03.02
 ;;03.09
 ;;03.1
 ;;03.32
 ;;03.39
 ;;03.4
 ;;03.53
 ;;03.59
 ;;03.6
 ;;03.93
 ;;03.94
 ;;03.97
 ;;03.98
 ;;03.99
 ;;80.50
 ;;80.51
 ;;80.53
 ;;80.54
 ;;80.59
 ;;84.59
 ;;84.60
 ;;84.61
 ;;84.62
 ;;84.63
 ;;84.64
 ;;84.65
 ;;84.66
 ;;84.67
 ;;84.68
 ;;84.69
 ;;84.80
 ;;84.82
 ;;84.84
 ;;EXIT
 ;
 ;
PROCUP4 ;
 ;;+8^518^519^520
 ;;EXIT
