IBDEI229 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.4,1236,0)
 ;;=INJURY/TRAUMA^13^105
 ;;^UTILITY(U,$J,358.4,1237,0)
 ;;=SIGNS, SYMPTOMS, CONDITIONS^24^105
 ;;^UTILITY(U,$J,358.4,1238,0)
 ;;=SEXUAL TRAUMA^23^105
 ;;^UTILITY(U,$J,358.4,1239,0)
 ;;=PAIN^20^105
 ;;^UTILITY(U,$J,358.4,1240,0)
 ;;=OTHER REASONS^19^105
 ;;^UTILITY(U,$J,358.4,1241,0)
 ;;=COMMON DIAGNOSES^2^105
 ;;^UTILITY(U,$J,358.4,1242,0)
 ;;=PREVENTIVE MEDICINE CODES^21^105
 ;;^UTILITY(U,$J,358.4,1243,0)
 ;;=CONTACT W/ HAZARDOUS SUBSTANCES^1^105
 ;;^UTILITY(U,$J,358.4,1244,0)
 ;;=CAUSES OF INJURY (SECONDARY ONLY)^4^105
 ;;^UTILITY(U,$J,358.4,1245,0)
 ;;=LEGAL BLINDNESS^14^105
 ;;^UTILITY(U,$J,358.4,1246,0)
 ;;=CEREBROVASCULAR ARTERIAL STUDIES^1^106
 ;;^UTILITY(U,$J,358.4,1247,0)
 ;;=EXTREMITY ARTERIAL-VENOUS STUDIES^3^106
 ;;^UTILITY(U,$J,358.4,1248,0)
 ;;=EXTREMITY VENOUS STUDIES^4^106
 ;;^UTILITY(U,$J,358.4,1249,0)
 ;;=VISCERAL/PENILE VASCULAR STUDIES^6^106
 ;;^UTILITY(U,$J,358.4,1250,0)
 ;;=EXTREMITY ARTERIAL STUDIES^2^106
 ;;^UTILITY(U,$J,358.4,1251,0)
 ;;=ULTRASOUNDS^5^106
 ;;^UTILITY(U,$J,358.4,1252,0)
 ;;=CARDIOVASCULAR^5^107
 ;;^UTILITY(U,$J,358.4,1253,0)
 ;;=ABDOMINAL PAIN^2^107
 ;;^UTILITY(U,$J,358.4,1254,0)
 ;;=AFTERCARE POST SURGERY^3^107
 ;;^UTILITY(U,$J,358.4,1255,0)
 ;;=COMMON VASCULAR DX^1^107
 ;;^UTILITY(U,$J,358.4,1256,0)
 ;;=POST-OP COMPLICATIONS^8^107
 ;;^UTILITY(U,$J,358.4,1257,0)
 ;;=GENERAL/SIGNS & SYMPTOMS^6^107
 ;;^UTILITY(U,$J,358.4,1258,0)
 ;;=AMPUTATION^4^107
 ;;^UTILITY(U,$J,358.4,1259,0)
 ;;=INJURY^7^107
 ;;^UTILITY(U,$J,358.4,1260,0)
 ;;=OTHER^9^107
 ;;^UTILITY(U,$J,358.4,1261,0)
 ;;=NEW PATIENT^2^108
 ;;^UTILITY(U,$J,358.4,1262,0)
 ;;=ESTABLISHED PATIENT^1^108
 ;;^UTILITY(U,$J,358.4,1263,0)
 ;;=CONSULTATIONS^3^108
 ;;^UTILITY(U,$J,358.4,1264,0)
 ;;=CARDIOVASCULAR^5^109
 ;;^UTILITY(U,$J,358.4,1265,0)
 ;;=ABDOMINAL PAIN^2^109
 ;;^UTILITY(U,$J,358.4,1266,0)
 ;;=AFTERCARE POST SURGERY^3^109
 ;;^UTILITY(U,$J,358.4,1267,0)
 ;;=COMMON VASCULAR DX^1^109
 ;;^UTILITY(U,$J,358.4,1268,0)
 ;;=POST-OP COMPLICATIONS^8^109
 ;;^UTILITY(U,$J,358.4,1269,0)
 ;;=GENERAL/SIGNS & SYMPTOMS^6^109
 ;;^UTILITY(U,$J,358.4,1270,0)
 ;;=AMPUTATION^4^109
 ;;^UTILITY(U,$J,358.4,1271,0)
 ;;=INJURY^7^109
 ;;^UTILITY(U,$J,358.4,1272,0)
 ;;=OTHER^9^109
 ;;^UTILITY(U,$J,358.4,1273,0)
 ;;=DEBRIDEMENT^2^110
 ;;^UTILITY(U,$J,358.4,1274,0)
 ;;=I&D/ASPIRATION^3^110
 ;;^UTILITY(U,$J,358.4,1275,0)
 ;;=UNNA BOOT^4^110
 ;;^UTILITY(U,$J,358.4,1276,0)
 ;;=PEG TUBE^5^110
 ;;^UTILITY(U,$J,358.4,1277,0)
 ;;=WOUND VAC DRESSING^6^110
 ;;^UTILITY(U,$J,358.4,1278,0)
 ;;=VASCULAR PROCEDURES^1^110
 ;;^UTILITY(U,$J,358.4,1279,0)
 ;;=NEW PATIENT^2^111
 ;;^UTILITY(U,$J,358.4,1280,0)
 ;;=ESTABLISHED PATIENT^1^111
 ;;^UTILITY(U,$J,358.4,1281,0)
 ;;=CONSULTATIONS^3^111
 ;;^UTILITY(U,$J,358.4,1282,0)
 ;;=POST-OP F/U VISIT^5^111
 ;;^UTILITY(U,$J,358.4,1283,0)
 ;;=CARDIO/VASCULAR^2^112
 ;;^UTILITY(U,$J,358.4,1284,0)
 ;;=ENDOCRINE, METABOLIC, NUTRITIONAL^3^112
 ;;^UTILITY(U,$J,358.4,1285,0)
 ;;=EYES, EARS, & NOSE^4^112
 ;;^UTILITY(U,$J,358.4,1286,0)
 ;;=GASTROINTESTINAL^5^112
 ;;^UTILITY(U,$J,358.4,1287,0)
 ;;=GENITOURINARY & RENAL^6^112
 ;;^UTILITY(U,$J,358.4,1288,0)
 ;;=MUSCULOSKETAL^9^112
 ;;^UTILITY(U,$J,358.4,1289,0)
 ;;=NEUROLOGY^10^112
 ;;^UTILITY(U,$J,358.4,1290,0)
 ;;=PULMONARY/RESPIRATORY^14^112
 ;;^UTILITY(U,$J,358.4,1291,0)
 ;;=PSYCHIATRIC^13^112
 ;;^UTILITY(U,$J,358.4,1292,0)
 ;;=SKIN^15^112
 ;;^UTILITY(U,$J,358.4,1293,0)
 ;;=GYNECOLOGICAL/BREAST^7^112
 ;;^UTILITY(U,$J,358.4,1294,0)
 ;;=CONTACT W/ HAZARDOUS SUBSTANCES^1^112
 ;;^UTILITY(U,$J,358.4,1295,0)
 ;;=IMMUNIZATIONS^8^112
 ;;^UTILITY(U,$J,358.4,1296,0)
 ;;=PREVENTIVE HEALTH SCREENING^11^112
 ;;
 ;;$END ROU IBDEI229
