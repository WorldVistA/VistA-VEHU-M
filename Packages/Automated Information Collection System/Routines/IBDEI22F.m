IBDEI22F ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.4,1591,0)
 ;;=FAMILY HX OF MALIGNANCY^11^147
 ;;^UTILITY(U,$J,358.4,1592,0)
 ;;=FAMILY HX OF CHR DISABILITY^10^147
 ;;^UTILITY(U,$J,358.4,1593,0)
 ;;=PERSONAL HX OF HAZARDS TO HEALTH^21^147
 ;;^UTILITY(U,$J,358.4,1594,0)
 ;;=FAMILY HX OF SPECIFIC CONDITION^13^147
 ;;^UTILITY(U,$J,358.4,1595,0)
 ;;=FAMILY HX OF OTHER CONDITION^12^147
 ;;^UTILITY(U,$J,358.4,1596,0)
 ;;=MENTAL AND BEHAVIORAL PROBLEMS^15^147
 ;;^UTILITY(U,$J,358.4,1597,0)
 ;;=ORGAN OR TISSUE REPLACED^16^147
 ;;^UTILITY(U,$J,358.4,1598,0)
 ;;=PERSONAL HX OF CERTAIN DX^20^147
 ;;^UTILITY(U,$J,358.4,1599,0)
 ;;=ARTIFICIAL OPENING STATUS^3^147
 ;;^UTILITY(U,$J,358.4,1600,0)
 ;;=OTHER POSTSURGICAL STATES^17^147
 ;;^UTILITY(U,$J,358.4,1601,0)
 ;;=PALLATIVE CARE^19^147
 ;;^UTILITY(U,$J,358.4,1602,0)
 ;;=DEPENDENCE ON MACHINES^8^147
 ;;^UTILITY(U,$J,358.4,1603,0)
 ;;=PROBLEMS RELATED TO LIFESTYLE^24^147
 ;;^UTILITY(U,$J,358.4,1604,0)
 ;;=ADMINISTRATIVE PURPOSES^1^147
 ;;^UTILITY(U,$J,358.4,1605,0)
 ;;=CONTACT W/ COMMUNICABLE DISEASES^7^147
 ;;^UTILITY(U,$J,358.4,1606,0)
 ;;=CARRIER OF INFECTIOUS DX^5^147
 ;;^UTILITY(U,$J,358.4,1607,0)
 ;;=ASYMPTOMATIC HIV INFECTION^4^147
 ;;^UTILITY(U,$J,358.4,1608,0)
 ;;=CONDITIONS INFLUENCING HEALTH^6^147
 ;;^UTILITY(U,$J,358.4,1609,0)
 ;;=HOUSING & ECONOMIC CIRCUMSTANCES^14^147
 ;;^UTILITY(U,$J,358.4,1610,0)
 ;;=OTHER PSYCHOSOCIAL CIRCUMSTANCES^18^147
 ;;^UTILITY(U,$J,358.4,1611,0)
 ;;=PRESCRIBER CODES^2^148
 ;;^UTILITY(U,$J,358.4,1612,0)
 ;;=PSYCHOTHERAPY (INPT OR OUTPT)^3^148
 ;;^UTILITY(U,$J,358.4,1613,0)
 ;;=OTHER CODES^6^148
 ;;^UTILITY(U,$J,358.4,1614,0)
 ;;=BEHAVIOR ASSESSMENT/INTERVENTION^4^148
 ;;^UTILITY(U,$J,358.4,1615,0)
 ;;=TEAM CONFERENCE^12^148
 ;;^UTILITY(U,$J,358.4,1616,0)
 ;;=INTERACTIVE COMPLEXITY^5^148
 ;;^UTILITY(U,$J,358.4,1617,0)
 ;;=PSYCHIATRIC DIAGNOSTIC EVALUATION^1^148
 ;;^UTILITY(U,$J,358.4,1618,0)
 ;;=PSYCHOTHERAPY FOR CRISIS^9^148
 ;;^UTILITY(U,$J,358.4,1619,0)
 ;;=PROLONGED SERVICES ADD-ON^8^148
 ;;^UTILITY(U,$J,358.4,1620,0)
 ;;=SUBSTANCE ABUSE^11^148
 ;;^UTILITY(U,$J,358.4,1621,0)
 ;;=PREVENTIVE MED COUNSELING^7^148
 ;;^UTILITY(U,$J,358.4,1622,0)
 ;;=ESTABLISHED PATIENT^1^149
 ;;^UTILITY(U,$J,358.4,1623,0)
 ;;=CONSULTATIONS-OPT^3^149
 ;;^UTILITY(U,$J,358.4,1624,0)
 ;;=NEW PATIENT^2^149
 ;;^UTILITY(U,$J,358.4,1625,0)
 ;;=INPATIENT CONSULTATIONS^6^149
 ;;^UTILITY(U,$J,358.4,1626,0)
 ;;=INITIAL HOSPITAL CARE^7^149
 ;;^UTILITY(U,$J,358.4,1627,0)
 ;;=HOSPITAL CARE DISCHARGE SERVICES^9^149
 ;;^UTILITY(U,$J,358.4,1628,0)
 ;;=INITIAL OBSERVATION CARE^10^149
 ;;^UTILITY(U,$J,358.4,1629,0)
 ;;=OBSERVATION CARE DISCHARGE SERVICES^12^149
 ;;^UTILITY(U,$J,358.4,1630,0)
 ;;=INPT/OBS ADMIT/DISCHARGE SAME DATE^13^149
 ;;^UTILITY(U,$J,358.4,1631,0)
 ;;=SUBSEQUENT HOSPITAL CARE^8^149
 ;;^UTILITY(U,$J,358.4,1632,0)
 ;;=OBSERVATION SUBSEQUESNT CARE^11^149
 ;;^UTILITY(U,$J,358.4,1633,0)
 ;;=DOM ESTABLISHED VISITS^4^149
 ;;^UTILITY(U,$J,358.4,1634,0)
 ;;=DOM NEW VISITS^5^149
 ;;^UTILITY(U,$J,358.4,1635,0)
 ;;=ADJUSTMENT DISORDERS^2^150
 ;;^UTILITY(U,$J,358.4,1636,0)
 ;;=ANXIETY DISORDERS^4^150
 ;;^UTILITY(U,$J,358.4,1637,0)
 ;;=AMNESTICS^3^150
 ;;^UTILITY(U,$J,358.4,1638,0)
 ;;=ORGANIC DISORDERS^13^150
 ;;^UTILITY(U,$J,358.4,1639,0)
 ;;=DEMENTIA^8^150
 ;;^UTILITY(U,$J,358.4,1640,0)
 ;;=DELIRIUM^7^150
 ;;^UTILITY(U,$J,358.4,1641,0)
 ;;=BIPOLAR DISORDERS^5^150
 ;;^UTILITY(U,$J,358.4,1642,0)
 ;;=PSYCHOSIS/OTHER^17^150
 ;;^UTILITY(U,$J,358.4,1643,0)
 ;;=PERSONALITY DISORDERS^15^150
 ;;^UTILITY(U,$J,358.4,1644,0)
 ;;=SEXUAL DISORDERS^19^150
 ;;^UTILITY(U,$J,358.4,1645,0)
 ;;=SLEEP DISORDERS^20^150
 ;;
 ;;$END ROU IBDEI22F
