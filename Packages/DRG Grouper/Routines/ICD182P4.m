ICD182P4  ;BAY/JAT - DRG RECLASSIFICATION ; 7/2/01 10:24am
 ;;18.0;DRG Grouper;**2**;Oct 13,2000
 ;
 Q
 ;
EN ;
 D BMES^XPDUTL(">>> Beginning DRG Reclassification changes...")
MDC5 ;
 N DIAG,PROC,ENTRY,DA,DR,DIE
 F DIAG=410.01,410.11,410.21,410.31,410.41,410.51,410.61,410.71,410.81,410.91 S ENTRY=+$O(^ICD9("BA",DIAG_" ",0)) I ENTRY D
 .S DA=ENTRY,DR="60///516",DIE="^ICD9(" D ^DIE
 F PROC=37.94 S ENTRY=+$O(^ICD0("BA",PROC_" ",0)) I ENTRY D
 .S DA(1)=ENTRY,DA=5,DR="1///514;2///515",DIE="^ICD0("_DA(1)_","_"""MDC"""_"," D ^DIE
 F PROC=37.96,37.97,37.98 S ENTRY=+$O(^ICD0("BA",PROC_" ",0)) I ENTRY D
 .S DA(1)=ENTRY,DA=5,DR="1///514",DIE="^ICD0("_DA(1)_","_"""MDC"""_"," D ^DIE
 F PROC=37.26,37.27 S ENTRY=+$O(^ICD0("BA",PROC_" ",0)) I ENTRY D
 .S DA(1)=ENTRY,DA=5,DR="1///518",DIE="^ICD0("_DA(1)_","_"""MDC"""_"," D ^DIE
 F PROC=35.96,36.01,36.02,36.05,36.09,37.34 S ENTRY=+$O(^ICD0("BA",PROC_" ",0)) I ENTRY D
 .S DA(1)=ENTRY,DA=5,DR="1///516",DIE="^ICD0("_DA(1)_","_"""MDC"""_"," D ^DIE
MDC8 ;
 F PROC=81.02,81.03 S ENTRY=+$O(^ICD0("BA",PROC_" ",0)) I ENTRY D
 .S DA(1)=ENTRY,DA=8,DR="2///519;3///520",DIE="^ICD0("_DA(1)_","_"""MDC"""_"," D ^DIE
 S PROC=81.07 S ENTRY=+$O(^ICD0("BA",PROC_" ",0)) I ENTRY D
 .S DA(1)=ENTRY,DA=8,DR="1///496;2///497;3///498",DIE="^ICD0("_DA(1)_","_"""MDC"""_"," D ^DIE
MDC15 ;
 F DIAG=770.7 S ENTRY=+$O(^ICD9("BA",DIAG_" ",0)) I ENTRY D
 .S DA=ENTRY,DR="5///4;60///92;61///93",DIE="^ICD9(" D ^DIE
MDC20 ;
 F PROC=94.61,94.63,94.64,94.66,94.67,94.69 S ENTRY=+$O(^ICD0("BA",PROC_" ",0)) I ENTRY D
 .S DA(1)=ENTRY,DA=20,DR="1///522",DIE="^ICD0("_DA(1)_","_"""MDC"""_"," D ^DIE
 F PROC=94.25 S ENTRY=+$O(^ICD0("BA",PROC_" ",0)) I ENTRY D
 .S DA(1)=ENTRY,DA=20,DIK="^ICD0("_DA(1)_","_"""MDC"""_"," D ^DIK
 ; this will be update all the diagnoses in MDC 20 en masse
 N ICDIEN,ICDCODE
 S ICDIEN=0
 F  S ICDIEN=$O(^ICD9(ICDIEN)) Q:'ICDIEN  D
 .Q:$P($G(^ICD9(ICDIEN,0)),U,9)
 .Q:$P($G(^ICD9(ICDIEN,0)),U,5)'=20
 .S ICDCODE=$P($G(^ICD9(ICDIEN,0)),U)
 .Q:ICDCODE="305.1"
 .I ICDCODE["291."!(ICDCODE["292.")!(ICDCODE["303.")!(ICDCODE["304.")!(ICDCODE["305.") D
 ..S DA=ICDIEN,DR="60///521;61///522;62///523;63////@"
 ..S DIE="^ICD9(" D ^DIE
 S ICDCODE="790.3" S ICDIEN=+$O(^ICD9("BA",ICDCODE_" ",0)) I ICDIEN D
 .S DA=ICDIEN,DR="60///521;61///522;62///523;63////@"
 .S DIE="^ICD9(" D ^DIE
MDC25 ;
 F DIAG=783.21,783.22,783.40,783.41,783.42,783.43 S ENTRY=+$O(^ICD9("BA",DIAG_" ",0)) I ENTRY D
 .S DA=ENTRY,DR="5.9///3",DIE="^ICD9(" D ^DIE
DRG468 ;
 N ICDLINE,X,PROC,ICDPROC,ENTRY,ICDSUB,DATA,DIC,DRG,DRG1,DRG2
 F ICDLINE=1:1 S X=$T(PROC+ICDLINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .Q:ICDPROC["+"
 .S ENTRY=+$O(^ICD0("BA",ICDPROC_" ",0)) I ENTRY D
 ..F ICDSUB=1:1 S DATA=$T(PROC+ICDLINE+ICDSUB) Q:DATA'[";;+"  D
 ...K DIC("DR")
 ...S DIC="^ICD0("
 ...S DIC=DIC_ENTRY_","_"""MDC"""_","
 ...S DIC(0)="L"
 ...S DATA=$P(DATA,";;+",2)
 ...S DRG=$P(DATA,U,2)
 ...S (DRG1,DRG2)=""
 ...S DRG1=$P(DRG,"~",1) I $P(DRG,"~",2) S DRG2=$P(DRG,"~",2)
 ...S DIC("DR")="1///"_DRG1_";2///"_DRG2
 ...S X=$P(DATA,U)
 ...S DINUM=X
 ...K DO D FILE^DICN
MISC ;
 ; this is part III of the patch for miscellaneous NOISes, etc.
 ;
 F DIAG=198 S ENTRY=+$O(^ICD9("BA",DIAG,0)) I ENTRY D
 .S DA=ENTRY,DR="60///318;61///319;62////@",DIE="^ICD9(" D ^DIE
 F DIAG=474.01,474.02 S ENTRY=+$O(^ICD9("BA",DIAG_" ",0)) I ENTRY D
 .S DA=ENTRY,DR="2///Y;5///3;60///68;61///69;62///70;63////@"
 .S DIE="^ICD9(" D ^DIE
 F DIAG=474 S ENTRY=+$O(^ICD9("BA",474,9104)) I ENTRY D
 .S DA=ENTRY,DR="2///Y;5///3;60///68;61///69;62///70;63////@"
 .S DIE="^ICD9(" D ^DIE
PUG ;
 N ICDLINE,X,ICDDIAG,ICIDENT
 F ICDLINE=1:1 S X=$T(DIAG+ICDLINE),ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  S ENTRY=+$O(^ICD9("BA",ICDDIAG_" ",0)) I ENTRY D
 .S ICIDENT=$P($G(^ICD9(ENTRY,0)),U,2)
 .Q:ICIDENT["V"
 .S ICIDENT=ICIDENT_"V"
 .S DA=ENTRY,DR="2///^S X=ICIDENT",DIE="^ICD9(" D ^DIE
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> DRG Reclassification complete.")
 Q
 ;
PROC ; procedures for which +MDC^DRGs combinations are being added
 ;;54.95
 ;;+1^7~8
 ;;38.21
 ;;+3^63
 ;;+4^76~77
 ;;39.29
 ;;+4^76~77
 ;;39.31
 ;;+4^76~77
 ;;54.11
 ;;+4^76~77
 ;;77.49
 ;;+4^76~77
 ;;86.69
 ;;+4^76~77
 ;;34.02
 ;;+5^120
 ;;34.03
 ;;+5^120
 ;;34.21
 ;;+5^120
 ;;34.22
 ;;+5^120
 ;;34.26
 ;;+5^120
 ;;43.6
 ;;+5^120
 ;;43.7
 ;;+5^120
 ;;43.89
 ;;+5^120
 ;;43.99
 ;;+5^120
 ;;45.61
 ;;+5^120
 ;;45.62
 ;;+5^120
 ;;45.72
 ;;+5^120
 ;;45.73
 ;;+5^120
 ;;45.74
 ;;+5^120
 ;;45.75
 ;;+5^120
 ;;45.79
 ;;+5^120
 ;;45.8
 ;;+5^120
 ;;45.93
 ;;+5^120
 ;;46.03
 ;;+5^120
 ;;46.13
 ;;+5^120
 ;;47.09
 ;;+5^120
 ;;48.62
 ;;+5^120
 ;;48.63
 ;;+5^120
 ;;48.69
 ;;+5^120
 ;;50.12
 ;;+5^120
 ;;54.0
 ;;+5^120
 ;;51.22
 ;;+6^170~171
 ;;51.23
 ;;+6^170
 ;;51.32
 ;;+6^170
 ;;51.36
 ;;+6^170~171
 ;;51.37
 ;;+6^170~171
 ;;51.59
 ;;+6^170~171
 ;;54.0
 ;;+7^201
 ;;+11^315
 ;;34.79
 ;;+8^233~234
 ;;54.51
 ;;+11^315
 ;;54.59
 ;;+11^315
 ;;EXIT
 Q
DIAG ;;
 ;;398.91
 ;;415.11
 ;;415.19
 ;;416.0
 ;;430.
 ;;431.
 ;;432.0
 ;;432.1
 ;;432.9
 ;;433.01
 ;;433.11
 ;;433.21
 ;;433.31
 ;;433.81
 ;;433.91
 ;;434.00
 ;;434.01
 ;;434.10
 ;;434.11
 ;;434.90
 ;;434.91
 ;;436.
 ;;458.8
 ;;481.
 ;;482.0
 ;;482.1
 ;;482.2
 ;;482.30
 ;;482.31
 ;;482.32
 ;;482.39
 ;;482.40
 ;;482.41
 ;;482.49
 ;;482.81
 ;;482.82
 ;;482.83
 ;;482.89
 ;;482.9
 ;;483.0
 ;;483.1
 ;;483.8
 ;;484.1
 ;;484.3
 ;;484.5
 ;;484.6
 ;;484.7
 ;;484.8
 ;;485.
 ;;486.
 ;;487.0
 ;;507.0
 ;;507.1
 ;;507.8
 ;;518.0
 ;;518.5
 ;;518.81
 ;;518.83
 ;;518.84
 ;;707.0
 ;;996.62
 ;;996.72
 ;;EXIT
 Q
