IBDEI21Q ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.4,63,0)
 ;;=EMPLOYEE HEALTH COMMON DX^1^4
 ;;^UTILITY(U,$J,358.4,64,0)
 ;;=EXAMINATIONS^2^4
 ;;^UTILITY(U,$J,358.4,65,0)
 ;;=EXPOSURES^3^4
 ;;^UTILITY(U,$J,358.4,66,0)
 ;;=IMMUNIZATIONS^4^4
 ;;^UTILITY(U,$J,358.4,67,0)
 ;;=ALIMENTARY TRACT^1^5
 ;;^UTILITY(U,$J,358.4,68,0)
 ;;=FRACTURES^2^5
 ;;^UTILITY(U,$J,358.4,69,0)
 ;;=NEOPLASMS^4^5
 ;;^UTILITY(U,$J,358.4,70,0)
 ;;=RESPIRATORY TRACT^6^5
 ;;^UTILITY(U,$J,358.4,71,0)
 ;;=OTOLOGY^5^5
 ;;^UTILITY(U,$J,358.4,72,0)
 ;;=OTHER HEAD AND NECK^7^5
 ;;^UTILITY(U,$J,358.4,73,0)
 ;;=METASTATIC SITES^3^5
 ;;^UTILITY(U,$J,358.4,74,0)
 ;;=ESOPHAGUS^1^6
 ;;^UTILITY(U,$J,358.4,75,0)
 ;;=COLON^2^6
 ;;^UTILITY(U,$J,358.4,76,0)
 ;;=LIVER^3^6
 ;;^UTILITY(U,$J,358.4,77,0)
 ;;=PANCREAS^4^6
 ;;^UTILITY(U,$J,358.4,78,0)
 ;;=SMALL INTESTINE^5^6
 ;;^UTILITY(U,$J,358.4,79,0)
 ;;=STOMACH^6^6
 ;;^UTILITY(U,$J,358.4,80,0)
 ;;=POST SURGERY STATES^7^6
 ;;^UTILITY(U,$J,358.4,81,0)
 ;;=SYMPTOMS^8^6
 ;;^UTILITY(U,$J,358.4,82,0)
 ;;=SCREENING^9^6
 ;;^UTILITY(U,$J,358.4,83,0)
 ;;=ID-GENERAL^1^7
 ;;^UTILITY(U,$J,358.4,84,0)
 ;;=ID-HIV^2^7
 ;;^UTILITY(U,$J,358.4,85,0)
 ;;=ABUSE AND NEGLECT^1^8
 ;;^UTILITY(U,$J,358.4,86,0)
 ;;=ANXIETY DISORDERS^3^8
 ;;^UTILITY(U,$J,358.4,87,0)
 ;;=BIPOLAR DISORDERS^4^8
 ;;^UTILITY(U,$J,358.4,88,0)
 ;;=DELIRIUM^7^8
 ;;^UTILITY(U,$J,358.4,89,0)
 ;;=DEMENTIA/NEUROCOGNITIVE DISORDERS^8^8
 ;;^UTILITY(U,$J,358.4,90,0)
 ;;=DEPRESSIVE DISORDERS^9^8
 ;;^UTILITY(U,$J,358.4,91,0)
 ;;=DISSOCIATIVE DISORDERS ^10^8
 ;;^UTILITY(U,$J,358.4,92,0)
 ;;=EATING DISORDERS^11^8
 ;;^UTILITY(U,$J,358.4,93,0)
 ;;=EDUCATIONAL/OCCUPATIONAL PROBLEMS^12^8
 ;;^UTILITY(U,$J,358.4,94,0)
 ;;=GENDER DYSPHORIA^13^8
 ;;^UTILITY(U,$J,358.4,95,0)
 ;;=HOUSING/ECONOMIC PROBLEMS^14^8
 ;;^UTILITY(U,$J,358.4,96,0)
 ;;=MEDICATION-INDUCED MOVEMENT DISORDERS^15^8
 ;;^UTILITY(U,$J,358.4,97,0)
 ;;=OBSESSIVE-COMPULSIVE & RELATED DISORDERS^16^8
 ;;^UTILITY(U,$J,358.4,98,0)
 ;;=ORGANIC DISORDERS^17^8
 ;;^UTILITY(U,$J,358.4,99,0)
 ;;=PERSONAL HISTORY CIRCUMSTANCES^19^8
 ;;^UTILITY(U,$J,358.4,100,0)
 ;;=ADHD^2^8
 ;;^UTILITY(U,$J,358.4,101,0)
 ;;=COUNSELING/MED ADVICE^5^8
 ;;^UTILITY(U,$J,358.4,102,0)
 ;;=SOCIAL ENVIRONMENT PROBLEMS^27^8
 ;;^UTILITY(U,$J,358.4,103,0)
 ;;=PARAPHILIC DISORDERS^18^8
 ;;^UTILITY(U,$J,358.4,104,0)
 ;;=PERSONALITY DISORDERS^20^8
 ;;^UTILITY(U,$J,358.4,105,0)
 ;;=CRIME/LEGAL SYSTEM PROBLEMS^6^8
 ;;^UTILITY(U,$J,358.4,106,0)
 ;;=PSYCHIC FACT W/ OTH DIS^21^8
 ;;^UTILITY(U,$J,358.4,107,0)
 ;;=PSYCHOSOCIAL/PERSONAL/EVIRONMENTAL^22^8
 ;;^UTILITY(U,$J,358.4,108,0)
 ;;=RELATIONAL PROBLEMS^23^8
 ;;^UTILITY(U,$J,358.4,109,0)
 ;;=SCHIZOPHRENIA/OTH PSYCHOTIC DISORDERS^24^8
 ;;^UTILITY(U,$J,358.4,110,0)
 ;;=SEXUAL DYSFUNCTION^25^8
 ;;^UTILITY(U,$J,358.4,111,0)
 ;;=SLEEP DISORDERS^26^8
 ;;^UTILITY(U,$J,358.4,112,0)
 ;;=SUBSTANCE ABUSE-ALCOHOL^28^8
 ;;^UTILITY(U,$J,358.4,113,0)
 ;;=SUBSTANCE ABUSE-AMPHETAMINE^29^8
 ;;^UTILITY(U,$J,358.4,114,0)
 ;;=SUBSTANCE ABUSE-CANNABIS^30^8
 ;;^UTILITY(U,$J,358.4,115,0)
 ;;=SUBSTANCE ABUSE-HALLUCINOGEN^32^8
 ;;^UTILITY(U,$J,358.4,116,0)
 ;;=SUBSTANCE ABUSE-OPIOID^34^8
 ;;^UTILITY(U,$J,358.4,117,0)
 ;;=SUBSTANCE ABUSE-PSYCHOACTIVE DRUGS^35^8
 ;;^UTILITY(U,$J,358.4,118,0)
 ;;=SUBSTANCE ABUSE-SEDATIVE/HYPNOTIC^36^8
 ;;^UTILITY(U,$J,358.4,119,0)
 ;;=SUBSTANCE ABUSE-TOBACCO^37^8
 ;;^UTILITY(U,$J,358.4,120,0)
 ;;=SUBSTANCE ABUSE-COCAINE^31^8
 ;;^UTILITY(U,$J,358.4,121,0)
 ;;=TRAUMA/STRESSOR-RELATED DISORDERS^38^8
 ;;^UTILITY(U,$J,358.4,122,0)
 ;;=SUBSTANCE ABUSE-INHALANT^33^8
 ;;^UTILITY(U,$J,358.4,123,0)
 ;;=SUBSTANCE ABUSE^5^9
 ;;^UTILITY(U,$J,358.4,124,0)
 ;;=DIAGNOSTIC EVALUATION^1^9
 ;;
 ;;$END ROU IBDEI21Q
