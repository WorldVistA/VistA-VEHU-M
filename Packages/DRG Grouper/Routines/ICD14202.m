ICD14202 ;ALB/EG/ABR - ADD NEW ICD DX/OPS/UPDATES ;DEC 15, 1993
 ;;14.0;DRG Grouper;**2**;Apr 03, 1997
ADDP ;add new diagnostic codes
 N ACTION,DA,I,STR,STR1
 F I=1:1 S ACTION=$P($T(NEWOPS+I),";;",2) Q:ACTION="$END"  I ACTION'="" S ^TMP("ICDUPD",$J,$P(ACTION,","))="" D:ICDDEBUG DEBUG1 S ACTION="S ^ICD9("_ACTION X:ICDTEST=0 ACTION
 Q
DEBUG1 I ACTION[",0)="&($P($P(ACTION,"^",3),$C(34),1)'?.N) D
 . S STR1=$P($P(ACTION,$C(34),2),"^",1),STR=" "_STR1_$E("     ",1,(10-$L(STR1)))_$P(ACTION,"^",3)
 . D MES^XPDUTL(STR)
 Q
NEWOPS ;;diagnosis codes to add according to fed register
 ;;13351,0)="V02.60^^VIRAL HEPATITIS CARRIER, UNSPE^^7"
 ;;13351,1)="VIRAL HEPATITIS CARRIER, UNSPECIFIED"
 ;;13351,"DRG")="205^206"
 ;;13352,0)="V02.61^^HEPATITIS B CARRIER^^7"
 ;;13352,1)="HEPATITIS B CARRIER"
 ;;13352,"DRG")="205^206"
 ;;13353,0)="V02.62^^HEPATITIS C CARRIER^^7"
 ;;13353,1)="HEPATITIS C CARRIER"
 ;;13353,"DRG")="205^206"
 ;;13354,0)="V02.69^^OTHER VIRAL HEPATITIS CARRIER^^7"
 ;;13354,1)="OTHER VIRAL HEPATITIS CARRIER"
 ;;13354,"DRG")="205^206"
 ;;13355,0)="V12.40^^HIST OF UNSP DISORD NERV SYST^^23"
 ;;13355,1)="PERSONAL HISTORY OF UNSPECIFIED DISORDER OF NERVOUS SYSTEM AND SENSE ORGANS"
 ;;13355,"DRG")="467"
 ;;13356,0)="V12.41^^PERS HX BENIGN NEOPL OF BRAIN^^23"
 ;;13356,1)="PERSONAL HISTORY OF BENIGN NEOPLASM OF THE BRAIN"
 ;;13356,"DRG")="467"
 ;;13357,0)="V12.49^^PERS HX, OTH DISORD NERV SYS^^23"
 ;;13357,1)="PERSONAL HISTORY OF OTHER DISORDER OF NERVOUS SYSTEM AND SENSE ORGANS"
 ;;13357,"DRG")="467"
 ;;13358,0)="V16.40^^FAM HX MALIG NEOPL,GENITAL^^23"
 ;;13358,1)="FAMILY HISTORY OF MALIGNANT NEOPLASM OF GENITAL ORGAN, UNSPECIFIED"
 ;;13358,"DRG")="467"
 ;;13359,0)="V16.41^^FAM HX, MALIG NEOPL OF OVARY^^23"
 ;;13359,1)="FAMILY HISTORY OF MALIGNANT NEOPLASM OF OVARY"
 ;;13359,"DRG")="467"
 ;;13360,0)="V16.42^^FAM HX, MALIG NEOPL OF PROST^^23"
 ;;13360,1)="FAMILY HISTORY OF MALIGNANT NEOPLASM OF PROSTATE"
 ;;13360,"DRG")="467"
 ;;13361,0)="V16.43^^FAM HX, MALIG NEOPL OF TESTIS^^23"
 ;;13361,1)="FAMILY HISTORY OF MALIGNANT NEOPLASM OF TESTIS"
 ;;13361,"DRG")="467"
 ;;13362,0)="V16.49^^FAM HX, OF OTH MALIG NEOPL^^23"
 ;;13362,1)="FAMILY HISTORY OF OTHER MALIGNANT NEOPLASM"
 ;;13362,"DRG")="467"
 ;;13363,0)="V28.6^^ANTENATAL SCREEN FOR STREP B^^23^^^^^F"
 ;;13363,1)="ANTENATAL SCREENING FOR STREPTOCOCCUS B"
 ;;13363,"DRG")="467"
 ;;13364,0)="V42.81^^ORGAN/TISSUE TRANS, BONE MARR^^16^^1"
 ;;13364,1)="ORGAN OR TISSUE REPLACED BY TRANSPLANT, BONE MARROW"
 ;;13364,"DRG")="398^399"
 ;;13365,0)="V42.82^^ORGAN/TISSUE TRANS,PERIPH STEM^^16^^1"
 ;;13365,1)="ORGAN OR TISSUE REPLACED BY TRANSPLANT, PERIPHERAL STEM CELLS"
 ;;13365,"DRG")="398^399"
 ;;13366,0)="V42.83^^ORGAN/TISSUE TRANS, PANCREAS^^7^^1"
 ;;13366,1)="ORGAN OR TISSUE REPLACED BY TRANSPLANT, PANCREAS"
 ;;13366,"DRG")="204"
 ;;13367,0)="V42.89^^OTHER ORGAN/TISSUE TRANSPLANT^^23^^1"
 ;;13367,1)="OTHER ORGAN OR TISSUE REPLACED BY TRANSPLANT"
 ;;13367,"DRG")="467"
 ;;13368,0)="V45.61^^CATARACT EXTRACTION STATUS^^23"
 ;;13368,1)="CATARACT EXTRACTION STATUS"
 ;;13368,"DRG")="467"
 ;;13369,0)="V45.69^^OTH STATES FOLLOW SURG OF EYE^^23"
 ;;13369,1)="OTHER STATES FOLLOWING SURGERY OF EYE AND ADNEXA"
 ;;13369,"DRG")="467"
 ;;13370,0)="V45.71^^ACQUIRED ABSENCE OF BREAST^^23"
 ;;13370,1)="ACQUIRED ABSENCE OF BREAST"
 ;;13370,"DRG")="467"
 ;;13371,0)="V45.72^^ACQ. ABS. OF INTESTINE (LG,SM)^^23"
 ;;13371,1)="ACQUIRED ABSENCE OF INTESTINE (LARGE) (SMALL)"
 ;;13371,"DRG")="467"
 ;;13372,0)="V45.73^^ACQUIRED ABSENCE OF KIDNEY^^23"
 ;;13372,1)="ACQUIRED ABSENCE OF KIDNEY"
 ;;13372,"DRG")="467"
 ;;13373,0)="V53.01^^FIT/ADJUST CEREBR VENT SHUNT^^23"
 ;;13373,1)="FITTING AND ADJUSTMENT OF CEREBRAL VENTRICULAR (COMMUNICATING) SHUNT"
 ;;13373,"DRG")="467"
 ;;13374,0)="V53.02^^FIT/ADJUST NEUROPACEMAKER^^23"
 ;;13374,1)="FITTING AND ADJUSTMENT OF NEUROPACEMAKER (BRAIN) (PERIPHERAL NERVE) (SPINAL CORD)"
 ;;13374,"DRG")="467"
 ;;13375,0)="V53.09^^FIT/ADJUST OTH DEV-NERV SYS^^23"
 ;;13375,1)="FITTING AND ADJUSTMENT OF OTHER DEVICES RELATED TO NERVOUS SYSTEM AND SPECIAL SENSES"
 ;;13375,"DRG")="467"
 ;;13376,0)="V64.4^^LAPAR SURG PROC CONV OPEN^^23"
 ;;13376,1)="LAPAROSCOPIC SURGICAL PROCEDURE CONVERTED TO OPEN PROCEDURE"
 ;;13376,"DRG")="467"
 ;;13377,0)="V76.10^^SCREEN MAL NEOPL, BREAST,UNSP^^23"
 ;;13377,1)="SCREENING FOR MALIGNANT NEOPLASM, BREAST SCREENING, UNSPECIFIED"
 ;;13377,"DRG")="467"
 ;;13378,0)="V76.11^^SCREEN MAMMO HIGH-RISK PT^^23"
 ;;13378,1)="SCREENING MAMMOGRAM FOR HIGH-RISK PATIENT, MALIGNANT NEOPLASM OF BREAST"
 ;;13378,"DRG")="467"
 ;;13379,0)="V76.12^^OTHER SCREEN MAMMO FOR MAL NEO^^23"
 ;;13379,1)="OTHER SCREENING MAMMOGRAM FOR MALIGNANT NEOPLASM OF BREAST"
 ;;13379,"DRG")="467"
 ;;13380,0)="V76.19^^OTHER SCREEN BREAST EXAM^^23"
 ;;13380,1)="OTHER SCREENING BREAST EXAMINATION FOR MALIGNANT NEOPLASM"
 ;;13380,"DRG")="467"
 ;;12686,0)="041.04^^STREP UNSP, GROUP D (ENTERO)^^18"
 ;;12686,1)="STREPTOCOCCUS INFECTION IN CONDITIONS CLASSIFIED ELSEWHERE AND OF UNSPECIFIED SITE, GROUP D (ENTEROCOCCUS)"
 ;;12686,"DRG")="423"
 ;;$END
