EC725U07 ;ALB/GTS/JAP/JAM - EC National Procedure Update;10/27/00
 ;;2.0; EVENT CAPTURE ;**26**;8 May 96
 ;
 ;this routine is used as a post-init in a KIDS build 
 ;to modify the EC National Procedure file #725
 ;
NAMECHG ;* change national procedure names
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^NEW NAME
 ;
 N ECX,ECXX,ECDA,DA,DR,DIC,DIE,X,Y,STR
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Changing names in EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(CHNG+ECX),";;",2) Q:ECXX="QUIT"  D
 .I $D(^EC(725,"D",$P(ECXX,U,1))) D
 ..S ECDA=+$O(^EC(725,"D",$P(ECXX,U,1),0))
 ..I $D(^EC(725,ECDA,0)) D
 ...S DA=ECDA,DR=".01////^S X=$P(ECXX,U,2)",DIE="^EC(725," D ^DIE
 ...D MES^XPDUTL(" ")
 ...D MES^XPDUTL("   Entry #"_ECDA_" for "_$P(ECXX,U,1))
 ...D BMES^XPDUTL("      ... field (#.01) updated to  "_$P(ECXX,U,2)_".")
 .I '$D(^EC(725,"D",$P(ECXX,U,1))) D
 ..D MES^XPDUTL(" ")
 ..S STR="Can't find entry for "_$P(ECXX,U,1)
 ..D BMES^XPDUTL(STR_" ...field (#.01) not updated.")
 Q
 ;
CHNG ;name changes
 ;;SP001^CERUMEN MANAGEMENT, LEVEL 1
 ;;SP004^ALD EVAL/SELECTION, LEVEL 1
 ;;SP006^REHAB STATUS/OUTCOME EXAM
 ;;SP010^SPEECH SCREENING
 ;;SP013^FOCUSED ARTIC/PHONOLOGY EVAL, LEVEL 1
 ;;SP015^FOCUSED DYSARTH/MOTOR SPEECH EVAL, LEVEL 1
 ;;SP018^FOCUSED RECEPT/EXPRESS LANG EVAL, LEVEL 1
 ;;SP019^FOCUSED COGNITIVE EVALUATION, LEVEL 1
 ;;SP021^FOCUSED FLUENCY EVALUATION, LEVEL 1
 ;;SP022^FOCUSED VOICE EVALUATION, LEVEL 1
 ;;SP023^AUDITORY PROCESSING ASSESSMENT, LEVEL 1
 ;;SP024^OTHER NONINVASIVE INSTRUM EXAM, LEVEL 1
 ;;SP026^AURAL REHABILITATION TREATMENT, LEVEL 1
 ;;SP027^VESTIBULAR REHAB TREATMENT, LEVEL 1
 ;;SP028^NONSPOKEN LANGUAGE TREATMENT, LEVEL 1
 ;;SP029^RECEPT/EXPRESS LANG TREATMENT, LEVEL 1
 ;;SP030^VOICE TREATMENT, LEVEL 1
 ;;SP031^ARTIC/PHONOL TREATMENT, LEVEL 1
 ;;SP032^MOTOR SPEECH TREATMENT, LEVEL 1
 ;;SP033^APHASIA TREATMENT, LEVEL 1
 ;;SP034^FLUENCY TREATMENT, LEVEL 1
 ;;SP036^AUDITORY PROCESSING TREATMENT, LEVEL 1
 ;;SP039^GROUP EVAL/TREAT/ACTIVITY
 ;;SP051^COCHLEAR IMPLANT REHAB, LEVEL 1
 ;;SP055^LARYNGEAL FUNCTION STUDY, LEVEL 1
 ;;SP056^NON-INSTRUMENT SWALLOWING EVAL, LEVEL 1
 ;;SP057^SWALLOWING TREATMENT, LEVEL 1
 ;;SP069^VERTICAL ELECTRODE RECORDING, EACH
 ;;SP097^AUDITORY EVOKED POTENTIALS, LEVEL 1
 ;;SP100^CENTRAL AUD FUNCTION EVAL, LEVEL 1
 ;;SP103^HEARING AID ASSESSMENT, MON, LEVEL 1
 ;;SP104^HEARING AID ASSESSMENT, BIN, LEVEL 1
 ;;SP105^HEARING AID CHECK/REPAIR/ADJUST, MON, LEVEL 1
 ;;SP106^HEARING AID CHECK/REPAIR/ADJUST, BIN, LEVEL 1
 ;;SP112^AUG/ALTERN/PROSTH DEVICE EVAL, LEVEL 1
 ;;SP114^MODIY AUGM/ALTERN/PROSTH DEVICE, LEVEL 1
 ;;SP131^GROUP PATIENT EDUCATION
 ;;SP228^SPEECH/LANGUAGE/HEARING EVAL, LEVEL 1
 ;;SP229^SPEECH/LANGUAGE/HEARING TREATMENT, LEVEL 1
 ;;SP230^INSTRUMENT SWALLOWING EVAL, LEVEL 1
 ;;SP245^FOCUSED NASALITY EVAL, LEVEL 1
 ;;SP246^FOCUSED ALARYNGEAL SPEECH EVAL, LEVEL 1
 ;;SP247^FOCUSED PROSODY EVAL, LEVEL 1
 ;;SP248^ALARYNGEAL SPEECH TREATMENT, LEVEL 1
 ;;SP249^NASALITY TREATMENT, LEVEL 1
 ;;SW001^CASE MANAGEMENT - V 15N
 ;;SW002^CONSULTATION INPT - V 15N
 ;;SW003^DISCH PLANNING/COORDINATION < 30 MIN
 ;;SW004^FAM PSYCHOTHERAPY W/O PAT - V 15N
 ;;SW006^PREVENTIVE COUNSEL-ED-REFER INDIV 15MIN
 ;;SW007^DISCH PLANNING/COORDINATION > 30 MIN
 ;;SW012^PHONE-D/C  NON-MENTAL HEALTH FOLW-UP, 15 MIN
 ;;SW015^PSYCHSOC TX/PSYCHOTHERAPY OPT 75-80 MIN
 ;;SW019^PREVENCOUNSEL-ED-REF - GROUP (1-5) @30 MIN
 ;;SW020^PSYCHSOC TX/PSYCHOTHERAPY - GROUP (1-5), 90 MIN
 ;;SW025^PREVENCOUNSEL-ED-REF - GROUP (6-8) @30 MIN
 ;;SW026^PREVENCOUNSEL-ED-REF - GROUP (9+) @30 MIN
 ;;SW027^PSYCHSOC TX/PSYCHOTHERAPY - GROUP (6-8), 90 MIN
 ;;SW028^PSYCHSOC TX/PSYCHOTHERAPY - GROUP (9+), 90 MIN
 ;;SW031^INELIG VET REFERRAL - V 15N
 ;;SW032^INELIG NONVET REFERRAL - V 15N
 ;;SW033^CONSULTATION INPT, 30 MIN
 ;;SW034^CONSULTATION INPT, 45 MIN
 ;;SW035^FAM PSYCHOTHERAPY W/PAT - V 15N
 ;;SW036^MULTI FAM PSYCHOTHERAPY W/PAT - V 15N
 ;;SW037^PREVENTIVE COUNSEL-ED-REFER INDIV 30MIN
 ;;SW038^PREVENTIVE COUNSEL-ED-REFER INDIV 45MIN
 ;;SW039^PREVENTIVE COUNSEL-ED-REFER INDIV 60MIN
 ;;SW048^COMMUNITY RESIDENTIAL CARE FOLLOW-UP - V 15N
 ;;SW054^PHONE-D/C NON-MENTAL HEALTH FOLW-UP, 30 MIN
 ;;SW055^PHONE-D/C NON-MENTAL HEALTHFOLW-UP, 45 MIN
 ;;SW056^OFFICE VISIT OPT 10 MIN - FOCUSED
 ;;SW057^OFFICE VISIT OPT 15 MIN - EXPANDED
 ;;SW058^OFFICE VISIT OPT 25 MIN - DETAILED
 ;;SW059^OFFICE VISIT OPT 40 MIN - COMPREHENSIVE
 ;;SW060^COMP & PEN EXAM - V 15N 
 ;;SW061^PSYCHSOC TX/PSYCHOTHERAPY OPT 20-30 MIN
 ;;SW062^PSYCHSOC TX/PSYCHOTHERAPY OPT 45-50 MIN
 ;;SW063^UNLISTED PSYCH SVCS - V 15N
 ;;SW072^INDIV FUNCTIONAL IMPVMT - V 15N
 ;;SW073^SELF CARE/HOME MGMT- V 15N
 ;;SW074^COMM/WORK REINTEGRATION - V 15N
 ;;SW075^HIGH RISK ASSESSMENT - V 15N
 ;;SW076^HOME VISIT - DIRECT CARE 60 MIN
 ;;SW080^PSYCHSOC TX/PSYCHOTHERAPY INPT 75-80 MIN
 ;;SW081^PSYCHSOC TX/PSYCHOTHERAPY INPT 20-30 MIN
 ;;SW082^PSYCHSOC TX/PSYCHOTHERAPY INPT 45-50 MIN
 ;;SW083^PREVENCOUNSEL-ED-REF - GROUP (1-5) @60 MIN
 ;;SW084^PREVENCOUNSEL-ED-REF - GROUP (6-8) @60 MIN
 ;;SW085^PREVENCOUNSEL-ED-REF - GROUP (9+) @60 MIN
 ;;QUIT
