NURCCGDK ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11702,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11702,1,1,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11702,1,2,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11702,1,3,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11702,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11706,0)
 ;;=Defining Characteristics^2^NURSC^12^136^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11706,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11706,1,1,0)
 ;;=4225^destruction of skin layers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11706,1,2,0)
 ;;=4226^disruption of skin surface^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11706,1,3,0)
 ;;=4235^invasion of body structures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11706,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11710,0)
 ;;=Pain, Chronic^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11710,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11710,1,1,0)
 ;;=11711^Etiology/Related and/or Risk Factors^2^NURSC^158
 ;;^UTILITY("^GMRD(124.2,",$J,11710,1,2,0)
 ;;=11728^Goals/Expected Outcomes^2^NURSC^156
 ;;^UTILITY("^GMRD(124.2,",$J,11710,1,3,0)
 ;;=11733^Nursing Intervention/Orders^2^NURSC^130
 ;;^UTILITY("^GMRD(124.2,",$J,11710,1,4,0)
 ;;=11743^Related Problems^2^NURSC^137
 ;;^UTILITY("^GMRD(124.2,",$J,11710,1,5,0)
 ;;=11849^Defining Characteristics^2^NURSC^138
 ;;^UTILITY("^GMRD(124.2,",$J,11710,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11710,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11710,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11710,"TD",0)
 ;;=^^1^1^2890802^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,11710,"TD",1,0)
 ;;=A state of discomfort that continues for more than 6 months in duration.
 ;;^UTILITY("^GMRD(124.2,",$J,11711,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^158^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11711,1,0)
 ;;=^124.21PI^6^1
 ;;^UTILITY("^GMRD(124.2,",$J,11711,1,6,0)
 ;;=140^alteration in comfort related to pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11711,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11728,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^156^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11728,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,11728,1,1,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11728,1,3,0)
 ;;=1062^has a relaxed facial expression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11728,1,4,0)
 ;;=11925^[Extra Goal]^3^NURSC^190
 ;;^UTILITY("^GMRD(124.2,",$J,11728,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11732,0)
 ;;=[Extra Goal]^3^NURSC^9^188^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11732,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11732,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11733,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^130^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11733,1,0)
 ;;=^124.21PI^12^3
 ;;^UTILITY("^GMRD(124.2,",$J,11733,1,7,0)
 ;;=12208^[Extra Order]^3^NURSC^196
 ;;^UTILITY("^GMRD(124.2,",$J,11733,1,11,0)
 ;;=2858^teach distraction techniques to minimize pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11733,1,12,0)
 ;;=15391^medicate prior to planned activities/exercises and prn^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11733,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11733,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11742,0)
 ;;=[Extra Order]^3^NURSC^11^191^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11742,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11742,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11743,0)
 ;;=Related Problems^2^NURSC^7^137^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11743,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,11743,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
