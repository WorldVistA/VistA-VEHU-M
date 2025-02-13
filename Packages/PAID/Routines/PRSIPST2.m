PRSIPST2 ;HISC/GWB PAID 4.0 POST-INIT (CONTINUED);5/15/95  15:37
 ;;4.0;PAID;;Sep 21, 1995
UPC ;Update PAID codes
LAA ;LEGAL AUTHORITY
 S X="BFS",DES="OPM DELEGATION AGR#, CERT NO#" D ALA
 S X="BNP",DES="CS RULE 6.7 - CTG/NAF AGR" D ALA
 S X="LTM",DES="REG 315.704(C) - CONDUCT" D ALA
 S X="MLK",DES="REG 316.302(C)(7)" D ALA
 S X="PTL",DES="REG 351.608(C)" D ALA
 S X="PTM",DES="REG 351.608(B)" D ALA
 S X="PTP",DES="REG 351.608(D)(2)" D ALA
 S X="PTR",DES="REG 351.608(D)(1)" D ALA
 S X="PTS",DES="REG 351.608(D)(2)H" D ALA
 S X="PTT",DES="REG 351.608(D)(2)R" D ALA
 S X="UXM",DES="*" D ALA
 S X="UYM",DES="*" D ALA
 S X="V9A",DES="5 U.S.C. 75 REAS" D ALA
 S X="V9B",DES="5 U.S.C. 75 REAS-EQ" D ALA
 S X="V3P",DES="5 U.S.C. 8336(D)(2)" D ALA
 S X="W9N",DES="SCH A, 213.3102(I)(1)" D ALA
 S X="W9P",DES="SCH A, 213.3102(I)(2)" D ALA
 S X="W9R",DES="SCH A, 213.3102(I)(3)" D ALA
 S X="Y1K",DES="SCH B, 213.3202(A)-HS" D ALA
 S X="Y2K",DES="SCH B, 213.3202(A)-VOC/TECH" D ALA
 S X="Y3K",DES="SCH B, 213.3202(A)-ASSOC" D ALA
 S X="Y4K",DES="SCH B, 213.3202(A)-BA/BS" D ALA
 S X="Y5K",DES="SCH B, 213.3202(A)-GRAD/PROF" D ALA
 ;
 S X="BWA",DES="OPM DELEGATION AGR#, CERT NO#" D MLA
 S X="CTM",DES="REG 316.401(B)" D MLA
 S X="DKM",DES="REG 715.202" D MLA
 S X="HDM",DES="REG 230.402(C)" D MLA
 S X="HGM",DES="REG 230.402D(1)" D MLA
 S X="HJM",DES="REG 230.402D(2)" D MLA
 S X="HLM",DES="REG 230.402D(3)" D MLA
 S X="KTM",DES="REG 315.501" D MLA
 S X="MBM",DES="REG 316.201(B)" D MLA
 S X="QAK",DES="REG 353.202" D MLA
 S X="QBK",DES="REG 353.301" D MLA
 S X="QCK",DES="REG 353.301(D)" D MLA
 S X="QDK",DES="REG 353.111" D MLA
 S X="SQM",DES="5 U.S.C. 8336" D MLA
 S X="SRM",DES="REG 831.501" D MLA
 S X="SUM",DES="5 U.S.C. 8337" D MLA
 S X="SWM",DES="5 U.S.C. 8335" D MLA
 S X="V4M",DES="5 U.S.C. 3394(A) LIMITED TERM" D MLA
 S X="V4P",DES="5 U.S.C. 3394(A) LIMITED EMERGENCY" D MLA
 S X="W9M",DES="SCH A, 213.3102(I)" D MLA
 S X="YBM",DES="SCH B, 213.3202(B)-HS" D MLA
 S X="YGM",DES="SCH B, 213.3202(B)-VOC/TECH" D MLA
 S X="Y3M",DES="SCH B, 213.3202(B)-ASSOC" D MLA
 S X="Y1M",DES="SCH B, 213.3202(B)-BA/BS" D MLA
 S X="Y2M",DES="SCH B, 213.3202(B)-GRAD/PROF" D MLA
 ;
ACA ;ASSIGNMENT CODE
 I '$D(^PRSP(454,1,"ASS","B","H9")) D
 .K DD,DO
 .S DIC="^PRSP(454,1,""ASS"",",DA(1)=1,DIC(0)="L",X="H9"
 .S DIC("DR")="1///HEALTH ISSUES OF WOMEN VETERANS FELLOW"
 .D FILE^DICN
 K DIC,DA,X
 ;
 S X="37",DES="SPINAL CORD MEDICINE FELLOW"
 S DIC="^PRSP(454,1,""ASS"",",DIC(0)=0 D ^DIC I Y'=-1 S DIE="^PRSP(454,1,""ASS"",",DA(1)=1,DA=+Y,DR="1///"_DES D ^DIE
 K DIC,Y,DIE,DA,DR,X,DES
 ;
NOAA ;NATURE OF ACTION
 S X="390",DES="SEPARATION - APPT IN (NAME OF ENTITY)" D ANOA
 S X="805",DES="ELECTED FULL LIVING BENEFITS" D ANOA
 S X="810A",DES="SUPERVISORY DIFFERENTIAL" D ANOA
 S X="810B",DES="STAFFING DIFFERENTIAL" D ANOA
 S X="810C",DES="RETENTION ALLOWANCE" D ANOA
 ;
PUCA ;FOLLOWUP CODEs
 S X="CR",DES="EXPIRATION OF CR BOARD CERT",DEF="COLON AND RECTAL SURGERY" D APUC
 S X="IM",DES="EXPIRATION OF IM BOARD CERT",DEF="INTERNAL MEDICINE" D APUC
 S X="MG",DES="EXPIRATION OF MG BOARD CERT",DEF="MEDICAL GENETICS" D APUC
 S X="PN",DES="EXPIRATION OF PN BOARD CERT",DEF="PSYCHIATRY AND NEUROLOGY" D APUC
 S X="53",DES="EXPIRATION OF RETENTION ALLOW",DEF="" D APUC
 K X,DES,DEF
 ;
NOAM ;NATURE OF ACTION
 S X="353A",DES="SEPARATION-MIL" D MNOA
 S X="356",DES="SEPARATION-RIF" D MNOA
 S X="385B",DES="TERMINATION DURING PROBATION/TRIAL PERIOD" D MNOA
 S X="806",DES="ELECTED PARTIAL LIVING BENEFITS" D MNOA
 ;
PPA ;PAY PLAN
 I '$D(^PRSP(454,1,"PP","B","C")) D
 .K DD,DO
 .S DIC="^PRSP(454,1,""PP"",",DA(1)=1,DIC(0)="L",X="C"
 .S DIC("DR")="1///AL"
 .D FILE^DICN
 I '$D(^PRSP(454,1,"PP","B","F")) D
 .K DD,DO
 .S DIC="^PRSP(454,1,""PP"",",DA(1)=1,DIC(0)="L",X="F"
 .S DIC("DR")="1///FEE BASIS"
 .D FILE^DICN
 K DIC,DA,X
 ;
KLAC ;Kill LEGAL AUTHORITY "C" x-ref
 K ^PRSP(454,1,"CSA","C")
 ;
CCORGM ;COST CENTER/ORGANIZATION
 S X="REHABILITATION MEDICINE",DES="PHYSICAL MED & REHAB"
 S DIC="^PRSP(454.1,",DIC(0)=0 D ^DIC I Y'=-1 S DIE="^PRSP(454.1,",DA=+Y,DR=".01///"_DES D ^DIE
 K DIC,Y,DIE,DA,DR,X,DES
 Q
 ;Sub-routines
ALA ;LEGAL AUTHORITY
 I '$D(^PRSP(454,1,"CSA","B",X)) D
 .K DD,DO
 .S DIC="^PRSP(454,1,""CSA"",",DA(1)=1,DIC(0)="L",DIC("DR")="1///"_DES
 .D FILE^DICN
 Q
MLA ;LEGAL AUTHORITY
 S DIC="^PRSP(454,1,""CSA"",",DIC(0)=0 D ^DIC
 I Y'=-1 S DIE="^PRSP(454,1,""CSA"",",DA(1)=1,DA=+Y,DR="1///"_DES D ^DIE
 Q
ANOA ;NATURE OF ACTION
 I '$D(^PRSP(454,1,"NOA","B",X)) D
 .K DD,DO
 .S DIC="^PRSP(454,1,""NOA"",",DA(1)=1,DIC(0)="L",DIC("DR")="1///"_DES
 .D FILE^DICN
 Q
MNOA ;NATURE OF ACTION
 S DIC="^PRSP(454,1,""NOA"",",DIC(0)=0 D ^DIC
 I Y'=-1 S DIE="^PRSP(454,1,""NOA"",",DA(1)=1,DA=+Y,DR="1///"_DES D ^DIE
 Q
APUC ;FOLLOWUP CODE
 I '$D(^PRSP(454,1,"PUC","B",X)) D
 .K DD,DO
 .S DIC="^PRSP(454,1,""PUC"",",DA(1)=1,DIC(0)="L",DIC("DR")="1///"_DES_";2///"_DEF
 .D FILE^DICN
 Q
