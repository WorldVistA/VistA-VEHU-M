IBDEI22H ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.4,1704,0)
 ;;=CHEMODENERVATION^6^154
 ;;^UTILITY(U,$J,358.4,1705,0)
 ;;=OTHER^10^154
 ;;^UTILITY(U,$J,358.4,1706,0)
 ;;=BACLOFEN PUMP^3^154
 ;;^UTILITY(U,$J,358.4,1707,0)
 ;;=BOTOX^4^154
 ;;^UTILITY(U,$J,358.4,1708,0)
 ;;=CARPAL TUNNEL INJECTION^5^154
 ;;^UTILITY(U,$J,358.4,1709,0)
 ;;=JNT BURSA INJ W/ US^8^154
 ;;^UTILITY(U,$J,358.4,1710,0)
 ;;=TRIGGER POINT INJECTION^12^154
 ;;^UTILITY(U,$J,358.4,1711,0)
 ;;=ULTRASOUND^13^154
 ;;^UTILITY(U,$J,358.4,1712,0)
 ;;=INITIAL EVAL FOR TBI^1^155
 ;;^UTILITY(U,$J,358.4,1713,0)
 ;;=V CODES ^21^156
 ;;^UTILITY(U,$J,358.4,1714,0)
 ;;=AMPUTATION STATUS^1^156
 ;;^UTILITY(U,$J,358.4,1715,0)
 ;;=BRAIN DISORDERS^5^156
 ;;^UTILITY(U,$J,358.4,1716,0)
 ;;=CARDIOPULMONARY^6^156
 ;;^UTILITY(U,$J,358.4,1717,0)
 ;;=COMPLICATION DUE TO^8^156
 ;;^UTILITY(U,$J,358.4,1718,0)
 ;;=FRACTURES-LATE EFFECTS^10^156
 ;;^UTILITY(U,$J,358.4,1719,0)
 ;;=MENTAL DISORDERS^13^156
 ;;^UTILITY(U,$J,358.4,1720,0)
 ;;=MUSCULOSKELETAL/CONNECTIVE TISSUE^14^156
 ;;^UTILITY(U,$J,358.4,1721,0)
 ;;=LATE EFFECTS OF INJURY^12^156
 ;;^UTILITY(U,$J,358.4,1722,0)
 ;;=LATE EFFECTS OF CVA^11^156
 ;;^UTILITY(U,$J,358.4,1723,0)
 ;;=PHYSICAL CHANGES^16^156
 ;;^UTILITY(U,$J,358.4,1724,0)
 ;;=SPEECH AND LANGUAGE^19^156
 ;;^UTILITY(U,$J,358.4,1725,0)
 ;;=AUDITORY^2^156
 ;;^UTILITY(U,$J,358.4,1726,0)
 ;;=COGNITION^7^156
 ;;^UTILITY(U,$J,358.4,1727,0)
 ;;=PSYCHIATRIC-PSYCHOSOC-EMOTIONAL^18^156
 ;;^UTILITY(U,$J,358.4,1728,0)
 ;;=BACK DIAGNOSIS^3^156
 ;;^UTILITY(U,$J,358.4,1729,0)
 ;;=EXTREMITY DIAGNOSIS^9^156
 ;;^UTILITY(U,$J,358.4,1730,0)
 ;;=POST JOINT REPLACEMENT^17^156
 ;;^UTILITY(U,$J,358.4,1731,0)
 ;;=OTHER^15^156
 ;;^UTILITY(U,$J,358.4,1732,0)
 ;;=BLINDNESS^4^156
 ;;^UTILITY(U,$J,358.4,1733,0)
 ;;=SPINAL CORD INJURY^20^156
 ;;^UTILITY(U,$J,358.4,1734,0)
 ;;=EST PATIENT^1^157
 ;;^UTILITY(U,$J,358.4,1735,0)
 ;;=NEW PATIENT^2^157
 ;;^UTILITY(U,$J,358.4,1736,0)
 ;;=CONSULTATION^3^157
 ;;^UTILITY(U,$J,358.4,1737,0)
 ;;=INITIAL EVAL FOR TBI^1^158
 ;;^UTILITY(U,$J,358.4,1738,0)
 ;;=INJECTIONS/DRUGS^7^159
 ;;^UTILITY(U,$J,358.4,1739,0)
 ;;=WOUND CARE^15^159
 ;;^UTILITY(U,$J,358.4,1740,0)
 ;;=MD PROCEDURES^1^159
 ;;^UTILITY(U,$J,358.4,1741,0)
 ;;=MUSCLE NERVE TESTS^9^159
 ;;^UTILITY(U,$J,358.4,1742,0)
 ;;=TEAM CONFERENCE^12^159
 ;;^UTILITY(U,$J,358.4,1743,0)
 ;;=ACUPUNCTURE^2^159
 ;;^UTILITY(U,$J,358.4,1744,0)
 ;;=CHEMODENERVATION^6^159
 ;;^UTILITY(U,$J,358.4,1745,0)
 ;;=OSTEOPATHIC MANIPULATION (OMT)^10^159
 ;;^UTILITY(U,$J,358.4,1746,0)
 ;;=OTHER^11^159
 ;;^UTILITY(U,$J,358.4,1747,0)
 ;;=BACLOFEN PUMP^3^159
 ;;^UTILITY(U,$J,358.4,1748,0)
 ;;=BOTOX^4^159
 ;;^UTILITY(U,$J,358.4,1749,0)
 ;;=CARPAL TUNNEL INJECTION^5^159
 ;;^UTILITY(U,$J,358.4,1750,0)
 ;;=JNT BURSA INJ W/ US^8^159
 ;;^UTILITY(U,$J,358.4,1751,0)
 ;;=TRIGGER POINT INJECTION^13^159
 ;;^UTILITY(U,$J,358.4,1752,0)
 ;;=ULTRASOUND^14^159
 ;;^UTILITY(U,$J,358.4,1753,0)
 ;;=V CODES ^21^160
 ;;^UTILITY(U,$J,358.4,1754,0)
 ;;=AMPUTATION STATUS^1^160
 ;;^UTILITY(U,$J,358.4,1755,0)
 ;;=BRAIN DISORDERS^5^160
 ;;^UTILITY(U,$J,358.4,1756,0)
 ;;=CARDIOPULMONARY^6^160
 ;;^UTILITY(U,$J,358.4,1757,0)
 ;;=COMPLICATION DUE TO^8^160
 ;;^UTILITY(U,$J,358.4,1758,0)
 ;;=FRACTURES-LATE EFFECTS^10^160
 ;;^UTILITY(U,$J,358.4,1759,0)
 ;;=MENTAL DISORDERS^13^160
 ;;^UTILITY(U,$J,358.4,1760,0)
 ;;=MUSCULOSKELETAL/CONNECTIVE TISSUE^14^160
 ;;^UTILITY(U,$J,358.4,1761,0)
 ;;=LATE EFFECTS OF INJURY^12^160
 ;;^UTILITY(U,$J,358.4,1762,0)
 ;;=LATE EFFECTS OF CVA^11^160
 ;;^UTILITY(U,$J,358.4,1763,0)
 ;;=PHYSICAL CHANGES^16^160
 ;;^UTILITY(U,$J,358.4,1764,0)
 ;;=SPEECH AND LANGUAGE^19^160
 ;;
 ;;$END ROU IBDEI22H
